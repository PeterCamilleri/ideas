#Find the largest Fixnum.

old = tip = 1

loop do

  tip_class   = tip.class
  tipp1_class = (tip+1).class

  if tip_class == Fixnum && tipp1_class == Bignum
    break
  elsif tip_class == Fixnum
    old = tip
    tip *=2
  else
    tip = (tip + old)/2
  end

  puts "#{tip}, #{old}"
end

puts "The tipping point is #{tip}"
