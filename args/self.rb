#A study of what happens to self in a lambda block.

$test = lambda { puts self.inspect }

puts "What is default self?"
puts self.inspect
puts

puts "$test.call"
$test.call
puts

puts "43.instance_exec(&$test)"
43.instance_exec(&$test)
puts

class MoreTests

  def test1
    puts "What is default self in a MoreTest object?"
    puts self.inspect
    puts

    puts "MoreTests -- $test.call"
    $test.call
    puts

    puts "MoreTests -- self.instance_exec(&$test)"
    self.instance_exec(&$test)
    puts
  end

end

MoreTests.new.test1

# What is default self?
# main
#
# $test.call
# main
#
# 43.instance_exec(&$test)
# 43
#
# What is default self in a MoreTest object?
# #<MoreTests:0x1ef2da8>
#
# MoreTests -- $test.call
# main
#
# MoreTests -- self.instance_exec(&$test)
# #<MoreTests:0x1ef2da8>


