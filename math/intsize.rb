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


  #Uncomment for fun or debug.
  #puts "#{'%10d' % tip}, #{'%10d' % old}"
  #sleep(1.0)
end

puts
puts "The tipping point is #{tip}"
puts
puts "#{tip} is a #{tip.class}"
puts "#{tip+1} is a #{(tip+1).class}"
puts
