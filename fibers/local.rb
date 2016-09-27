#Test idea: Can a fiber maintain local state across calls?

$f = Fiber.new do |cmd|

  ____binding = binding

  while true
    cmd = Fiber.yield ____binding.eval(cmd)
  end

end


def x(str)
  @step ||= 1
  puts "Step #{@step}, Code #{str.inspect.ljust(22)} ==> #{$f.resume(str).inspect}"
  @step += 1
end

x "a = 4"
x "a"
x "a *= 2"
x "a"

x "def foo; 'bar'; end"
x "foo"

x "self.class"

# YES, with a little help from my friends!!!

# C:\Sites\ideas\fibers>ruby local.rb
# Step 1, Code "a = 4"                ==> 4
# Step 2, Code "a"                    ==> 4
# Step 3, Code "a *= 2"               ==> 8
# Step 4, Code "a"                    ==> 8
# Step 5, Code "def foo; 'bar'; end"  ==> :foo
# Step 6, Code "foo"                  ==> "bar"
# Step 7, Code "self.class"           ==> Object

# Ruby  1.9.3 - OK
# Ruby  2.1.6 - OK
# Ruby  2.2.4 - OK
# JRuby 9.1.5 - OK



