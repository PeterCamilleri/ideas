# In computer arithmetic, addition is NOT associative!
a = 1.0e20
b = -1.0e20
c = 1.0

puts
puts "Float 64 Math"
puts "-------------"
puts "a = #{a}"
puts "b = #{b}"
puts "c = #{c}"

puts "a+b+c   = #{a+b+c}"
puts "(a+b)+c = #{(a+b)+c}"
puts "a+(b+c) = #{a+(b+c)}"

a = Rational(1.0e20, 1)
b = Rational(-1.0e20, 1)
c = Rational(1.0, 1)

puts
puts "Rational Math"
puts "-------------"
puts "a = #{a.to_f}"
puts "b = #{b.to_f}"
puts "c = #{c.to_f}"

puts "a+b+c   = #{(a+b+c).to_f}"
puts "(a+b)+c = #{((a+b)+c).to_f}"
puts "a+(b+c) = #{(a+(b+c)).to_f}"

#   Results

#   Float 64 Math
#   -------------
#   a = 1.0e+20
#   b = -1.0e+20
#   c = 1.0
#   a+b+c   = 1.0
#   (a+b)+c = 1.0
#   a+(b+c) = 0.0
#
#   Rational Math
#   -------------
#   a = 1.0e+20
#   b = -1.0e+20
#   c = 1.0
#   a+b+c   = 1.0
#   (a+b)+c = 1.0
#   a+(b+c) = 1.0
