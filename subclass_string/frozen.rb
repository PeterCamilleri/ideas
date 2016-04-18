# Just what is frozen?

class Object

  def inspect_frozen
    puts "#{self.inspect} is #{self.frozen? ? "frozen" : "thawed"}."
  end

end

puts "----------------------"
puts "Ruby version = #{RUBY_VERSION}"
puts "----------------------"

puts
puts "----------------------"
puts "Test before freeze"
puts "----------------------"
"abc".inspect_frozen
:abc.inspect_frozen
(42).inspect_frozen
Rational(1,2).inspect_frozen
(3.1416).inspect_frozen
Complex(1,2).inspect_frozen
true.inspect_frozen
false.inspect_frozen
nil.inspect_frozen

puts
puts "----------------------"
puts "Test with freeze"
puts "----------------------"
"abc".freeze.inspect_frozen
:abc.freeze.inspect_frozen
(42).freeze.inspect_frozen
Rational(1,2).freeze.inspect_frozen
(3.1416).freeze.inspect_frozen
Complex(1,2).freeze.inspect_frozen
true.freeze.inspect_frozen
false.freeze.inspect_frozen
nil.freeze.inspect_frozen

puts
puts "----------------------"
puts "Test after freeze"
puts "----------------------"
"abc".inspect_frozen
:abc.inspect_frozen
(42).inspect_frozen
Rational(1,2).inspect_frozen
(3.1416).inspect_frozen
Complex(1,2).inspect_frozen
true.inspect_frozen
false.inspect_frozen
nil.inspect_frozen
