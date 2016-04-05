#A study of sub-classing the String class and the propogation
#of the frozen state.

class BahBar < String

  def initialize(text)
    super(text.to_s.dup)
  end

end

s = "bar".freeze
puts "s is a #{s.class}. Frozen? (#{s.frozen?}) Value: (#{s})"

t = s.dup
puts "t is a #{t.class}. Frozen? (#{t.frozen?}) Value: (#{t})"

u = s.clone
puts "u is a #{u.class}. Frozen? (#{u.frozen?}) Value: (#{u})"

v = s.to_s
puts "v is a #{v.class}. Frozen? (#{v.frozen?}) Value: (#{v})"

x = (s + "abas").freeze
puts "x is a #{x.class}. Frozen? (#{x.frozen?}) Value: (#{x})"

y = x[1...-1]
puts "y[1...-1] is a #{y.class}. Frozen? (#{y.frozen?}) Value: (#{y})"

f = BahBar.new(s)
puts "f is a #{f.class}. Frozen? (#{f.frozen?}) Value: (#{s})"

f << s
puts "f is a #{f.class}. Frozen? (#{f.frozen?}) Value: (#{f})"

g = f[1...-1]
puts "g[1...-1] is a #{g.class}. Frozen? (#{g.frozen?}) Value: (#{g})"

h = f.to_s.freeze
puts "h is a #{h.class}. Frozen? (#{h.frozen?}) Value: (#{h})"

# Outputs the following:

# s is a String. Frozen? (true) Value: (bar)
# t is a String. Frozen? (false) Value: (bar)
# u is a String. Frozen? (true) Value: (bar)
# v is a String. Frozen? (true) Value: (bar)
# x is a String. Frozen? (true) Value: (barabas)
# y[1...-1] is a String. Frozen? (false) Value: (araba)
# f is a BahBar. Frozen? (false) Value: (bar)
# f is a BahBar. Frozen? (false) Value: (barbar)
# g[1...-1] is a BahBar. Frozen? (false) Value: (arba)
# h is a String. Frozen? (true) Value: (barbar)
