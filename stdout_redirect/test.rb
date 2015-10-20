require 'stringio'
require 'pp'

def with_captured_stdout
  begin
    old_stdout = $stdout
    $stdout = StringIO.new('','w')
    yield
    result = $stdout.string
  ensure
    $stdout = old_stdout
  end

  result
end

def run(command)
  IO.popen(command, "r+") do |io|
    io.close_write
    return io.read
  end
end

foo = run("dir")

puts "Here is the result:"
puts
pp foo.lines
puts
puts "Done!"
