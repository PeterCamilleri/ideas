#Some tests with curried lambdas. Yummy!

puts "\nOriginal proc."
test_proc = lambda { |a,b,c| puts "a=#{a} b=#{b} c=#{c}" }
puts "test_proc = #{test_proc.inspect}"
test_proc.call(1,2,3)

puts "\nWith one curried arg."
curry_one = test_proc.curry[11]
puts "curry_one = #{curry_one.inspect}"
curry_one.call(22, 33)

puts "\nWith two curried args."
curry_two = test_proc.curry[12][24]
puts "curry_two = #{curry_two.inspect}"
curry_two.call(36)

puts "\nWith three curried args."
curry_three = test_proc.curry[13][26][39]
puts "curry_three = #{curry_three.inspect}"

# Original proc.
# test_proc = #<Proc:0x1f02a80@curried.rb:4 (lambda)>
# a=1 b=2 c=3
#
# With one curried arg.
# curry_one = #<Proc:0x1f028b8 (lambda)>
# a=11 b=22 c=33
#
# With two curried args.
# curry_two = #<Proc:0x1f025d0 (lambda)>
# a=12 b=24 c=36
#
# With three curried args.
# a=13 b=26 c=39
# curry_three = nil
