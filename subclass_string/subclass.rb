

class Foo < String

  def initialize(text)
    super(text)
  end

end

s = "bar"

puts "s is a #{s.class}."

f = Foo.new("foo")

puts "f is a #{f.class}."

f << "bar"

puts "f is a #{f.class}."
