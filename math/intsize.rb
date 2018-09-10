#Find the largest Fixnum.

old = tip = 1

loop do

  if tip.is_a?(Fixnum)

    break if (tip+1).is_a?(Bignum)

    old  = tip
    tip *= 2
  else
    tip = (tip + old)/2
  end

  puts "#{tip}, #{old}"
end

puts
puts "The tipping point is #{tip}"
puts
puts "#{tip} is a #{tip.class}"
puts "#{tip+1} is a #{(tip+1).class}"
puts
