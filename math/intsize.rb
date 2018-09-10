#Find the largest Fixnum.

old = tip = 1

loop do

  old_class   = old.class
  tip_class   = tip.class
  tipp1_class = (tip+1).class

  if tip_class == Fixnum && tipp1_class == Bignum
    break
  elsif old_class == Fixnum && tip_class == Fixnum
    old = tip
    tip *=2
  elsif old_class == Fixnum && tip_class == Bignum
    tip = (tip + old)/2
  end

  puts "#{tip}, #{old}"
end

puts "The tipping point is #{tip}"
