#Can we use splat with hashes?

require 'pp'

class Mine

  def test(args={})
    pp args
  end

end

zzz = Mine.new

yyy = {c: 999, d: "apple"}

puts
zzz.test(a: 10, b:42)
puts
zzz.test(yyy)
puts
zzz.test(yyy.merge(a: 10, b:42))

puts
pp yyy

puts

