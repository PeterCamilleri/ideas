#A study of sub-classing the String class and the propogation
#of the frozen state.

class StringBuffer < String

  def initialize(text)
    super(text.to_s.dup)
  end

end

s = "333".freeze
puts "s is a #{s.class}. Frozen? (#{s.frozen?}) Value: (#{s})"

t = s.dup
puts "t is a #{t.class}. Frozen? (#{t.frozen?}) Value: (#{t})"

u = s.clone
puts "u is a #{u.class}. Frozen? (#{u.frozen?}) Value: (#{u})"

v = s.to_s
puts "v is a #{v.class}. Frozen? (#{v.frozen?}) Value: (#{v})"

x = (s + "4444").freeze
puts "x is a #{x.class}. Frozen? (#{x.frozen?}) Value: (#{x})"

y = x[1...-1]
puts "y[1...-1] is a #{y.class}. Frozen? (#{y.frozen?}) Value: (#{y})"

f = StringBuffer.new(s)
puts "f is a #{f.class}. Frozen? (#{f.frozen?}) Value: (#{s})"

f << s
puts "f is a #{f.class}. Frozen? (#{f.frozen?}) Value: (#{f})"

g = f[1...-1]
puts "g[1...-1] is a #{g.class}. Frozen? (#{g.frozen?}) Value: (#{g})"

h = f.to_s.freeze
puts "h is a #{h.class}. Frozen? (#{h.frozen?}) Value: (#{h})"

# Outputs the following:

# s is a String. Frozen? (true) Value: (333)
# t is a String. Frozen? (false) Value: (333)
# u is a String. Frozen? (true) Value: (333)
# v is a String. Frozen? (true) Value: (333)
# x is a String. Frozen? (true) Value: (3334444)
# y[1...-1] is a String. Frozen? (false) Value: (33444)
# f is a StringBuffer. Frozen? (false) Value: (333)
# f is a StringBuffer. Frozen? (false) Value: (333333)
# g[1...-1] is a StringBuffer. Frozen? (false) Value: (3333)
# h is a String. Frozen? (true) Value: (333333)

