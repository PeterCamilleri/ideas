#Find the largest Fixnum.

old = tip = 1

loop do

  if tip.is_a?(Fixnum)

    break if (tip+1).is_a?(Bignum)

    old = tip
    tip *=2
  else
    tip = (tip + old)/2
  end

  puts "#{tip}, #{old}"
end

puts "The tipping point is #{tip}"
