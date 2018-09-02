
def test(*test, keyparm: nil)
  puts test.inspect
  puts keyparm.inspect
end

test(1, 2, 3)

test(1, 2, 3, keyparm: 42)

test([1, 2, 3])

test([1, 2, 3], keyparm: 42)
