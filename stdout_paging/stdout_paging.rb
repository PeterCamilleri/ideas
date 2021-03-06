#Test ideas for putting page pauses into Ruby output.

require 'io/console'
require 'mini_term'

MiniTerm.open(quiet: true)

$saved_stdout = $stdout      # Keep a copy of the real $stdout.

class QuitOutput < Exception
end

# A class to manage paged output.
class PagedOutput

  MSG = "Press enter, space or q:"

  # Set up the initial values.
  def initialize
    @lines = 0
    @chars = 0

    # For this test, these are hardwired.
    @lines_per_page = 32
    @chars_per_line = 80
  end

  # Write out a general string with page pauses.
  def write(str)
    while !str.empty?
      pre,mid,str = str.partition("\n")
      write_str(pre) unless pre.empty?
      writeln unless mid.empty?
    end
  end

  # Write out a simple string with no embedded new-lines.
  def write_str(str)
    loop do
      len = str.length

      if @chars + len < @chars_per_line
        $saved_stdout.write(str)
        @chars += len
        return
      else
        tilt = @chars_per_line - @chars
        $saved_stdout.write(str[0, tilt])
        count_lines

        str = (str[tilt..-1])
      end
    end
  end

  # Write out a new-line.
  def writeln
    $saved_stdout.write("\n")
    count_lines
  end

  # A new line is out, count it!
  def count_lines
    @chars = 0
    @lines += 1

    if @lines >= (@lines_per_page - 1)
      case pause.downcase
      when " "
        @lines -= 1
      when "q"
        raise QuitOutput
      else
        @lines = 0
      end
    end
  end

  # Pause waiting for the user.
  def pause
    $saved_stdout.write(MSG)
    MiniTerm.raw do |term|
      result = term.get_raw_char
      term.flush
      result
    end

  ensure
    $saved_stdout.write("\r" + " " * MSG.length + "\r")
  end

end

# Execute a block with page paused output.
def with_pauses
  saved   = $stdout
  $stdout = PagedOutput.new if (outer = $stdout.equal?($saved_stdout))
  yield
rescue QuitOutput
  raise unless outer
  return
ensure
  $stdout = saved
end

# Let us try some test cases.
with_pauses do

  puts "Test one - 40 times Hello World"
  40.times { puts "Hello World" }

  with_pauses do
    puts "Test two - (1..40).to_a"
    puts (1..40).to_a

    puts "Test three - a row of 5000 stars"
    puts "*"*5000
  end

  puts "Test four - 260 streams of 19 letters"
  10.times {("A".."Z").each {|l| print l*19 }}
  puts

  puts "Test five - 20 times Hello\\nWonderful\\nWorld"
  20.times { |i| puts "#{i} Hello\nWonderful\nWorld" }

  puts "Test six - 1000 streams of 10 digits"
  100.times {("0".."9").each {|l| print l*10 }}
  puts

end
