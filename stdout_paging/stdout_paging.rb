#Test ideas for putting page pauses into Ruby output.

require 'io/console'

$saved_stdout = $stdout      # Keep a copy of the real $stdout.

# A class to manage paged output.
class PagedOutput

  MSG = "Press Space"

  # Set up the initial values.
  def initialize
    @line = 0
    @line_per_page = 32
    @chrs = 0
    @chrs_per_line = 80
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

      if @chrs + len < @chrs_per_line
        $saved_stdout.write(str)
        @chrs += len
        return
      else
        tilt = @chrs_per_line - @chrs
        $saved_stdout.write(str[0, tilt])
        count_line

        str = (str[tilt..-1])
      end
    end
  end

  # Write out a new-line.
  def writeln
    $saved_stdout.write("\n")
    count_line
  end

  # A new line is out, count it!
  def count_line
    @chrs = 0
    @line += 1

    if @line >= (@line_per_page - 1)
      pause
      @line = 0
    end
  end

  # Pause waiting for the user.
  def pause
    $saved_stdout.write(MSG)
    STDIN.raw { |i| i.getch }
    $saved_stdout.write("\r" + " " * MSG.length + "\r")
  end

end

# Execute a block with page paused output.
def with_pauses
  saved   = $stdout
  $stdout = PagedOutput.new if $stdout.equal?($saved_stdout)
  yield
ensure
  $stdout = saved
end

# Let us try some test cases.
with_pauses do

  puts "Test one - 40 times Hello World"
  40.times { puts "Hello World" }

  puts "Test two - (1..40).to_a"
  puts (1..40).to_a

  puts "Test three - a row of 5000 stars"
  puts "*"*5000

  puts "Test four - 260 streams of 19 letters"
  10.times {("A".."Z").each {|l| print l*19 }}
  puts

  puts "Test five - 20 times Hello\\nWonderful\\nWorld"
  20.times { |i| puts "#{i} Hello\nWonderful\nWorld" }

end
