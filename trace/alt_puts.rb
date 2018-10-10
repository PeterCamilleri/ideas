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

with_trace { puts "Hello World" }

