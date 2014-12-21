require 'readline'

puts
puts "Fractions converter."
puts

value = Readline.readline('Enter a number: ', true).to_r
puts "Value = #{value}, #{value.to_f}"

step_size = Rational(1,1)
result = Rational(value.to_i,1)
den = value.denominator
len = den.to_s.length
num = value.numerator % value.denominator
bin = value.to_i.to_s(2) + '.'

while result.to_f != value.to_f
  num *= 2
  step_size = step_size / 2

  if num >= den
    result += step_size
    num = num - den
    bin << '1'
  else
    bin << '0'
  end

  puts "#{result.to_f.to_s.ljust(20)} #{num.to_s.ljust(len)} #{den}"

  sleep 0.5
end

puts
puts "****** RESULTS ******"
puts "#{bin}"
