#Test ideas for tapping into puts.

$saved_stdout = $stdout

class TracedOut
  def write(str)
    $saved_stdout.write(str.inspect + "\n")
  end
end

def with_trace
  $stdout = TracedOut.new
  yield
ensure
  $stdout = $saved_stdout
end

puts "Test one - Hello World"
with_trace { puts "Hello World" }

puts "Test two - [1, 2, 3]"
with_trace { puts [1, 2, 3] }

puts "Test three - a row of 100 stars"
with_trace { puts "*"*100 }
