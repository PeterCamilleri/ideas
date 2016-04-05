

class Foo < String

  def initialize(text)
    super(text)
  end

end

s = "bar"

puts "s (#{s}) is a #{s.class}."

f = Foo.new("foo")

puts "f (#{f}) is a #{f.class}."

f << "bar"

puts "f (#{f}) is a #{f.class}."

g = f[1...-1]

puts "g (#{g}) is a #{g.class}."

h = f.to_s

puts "h (#{h}) is a #{h.class}."

