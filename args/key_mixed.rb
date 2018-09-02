
def test(*test, keyparm: nil)
  puts test.inspect
  puts keyparm.inspect
end

puts "Part 1"

test(1, 2, 3)

test(1, 2, 3, keyparm: 42)

test([1, 2, 3])

test([1, 2, 3], keyparm: 42)

puts "Part 2"

def []=(*test, value)
  puts test.inspect
  puts value.inspect
end

self[1,2,3]="A"
