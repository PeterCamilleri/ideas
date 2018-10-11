#Test ideas for tapping into puts.

$saved_stdout = $stdout

class TracedOut

  def initialize
    @line = 0
    @line_per_page = 5
    @chrs = 0
    @chrs_per_line = 80
  end

  def write(str)
    len = str.length

    if len > @chrs_per_line
      copy = str.dup
      write(copy.slice!(0, @chrs_per_line))
      write(copy)
    else
      if @line >= @line_per_page
        $saved_stdout.write("PAUSE")
        sleep(2) # Sleep because this test has no raw input.
        $saved_stdout.write("\r     \r")
        @line = 0
      end

      $saved_stdout.write(str)

      if len == @chrs_per_line || str["\n"]
        @line += 1
      end
    end
  end
end

def with_trace
  $stdout = TracedOut.new
  yield
ensure
  $stdout = $saved_stdout
end

with_trace {
  puts "Test one - Hello World"
  12.times { puts "Hello World" }

  puts "Test two - (1..20).to_a"
  puts (1..20).to_a

  puts "Test three - a row of 1000 stars"
  puts "*"*1000
}
