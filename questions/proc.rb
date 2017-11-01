def partial (proc1, val1)
  lambda {|val2| proc1.call(val1,val2)}
end

adder = Proc.new {|a,b| a + b}

sum_five = partial(adder,5)

puts sum_five.call(10) # -- expecting 15

