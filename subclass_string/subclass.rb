#A study of sub-classing the String class and the propogation
#of the frozen state.

class StringBuffer < String

  def initialize(text)
    super(text.to_s.dup)
  end

end

s = "333".freeze
puts "s is a #{s.class}. Frozen? (#{s.frozen?}) Value: (#{s})"
# s is a String. Frozen? (true) Value: (333)

t = s.dup
puts "t is a #{t.class}. Frozen? (#{t.frozen?}) Value: (#{t})"
# t is a String. Frozen? (false) Value: (333)

u = s.clone
puts "u is a #{u.class}. Frozen? (#{u.frozen?}) Value: (#{u})"
# u is a String. Frozen? (true) Value: (333)

v = s.to_s
puts "v is a #{v.class}. Frozen? (#{v.frozen?}) Value: (#{v})"
# v is a String. Frozen? (true) Value: (333)

w = (s + "4444")
puts "w is a #{w.class}. Frozen? (#{w.frozen?}) Value: (#{w})"
# w is a String. Frozen? (false) Value: (3334444)

r = (s + "4444".freeze)
puts "r is a #{r.class}. Frozen? (#{r.frozen?}) Value: (#{r})"
# w is a String. Frozen? (false) Value: (3334444)

x = (s + "4444").freeze
puts "x is a #{x.class}. Frozen? (#{x.frozen?}) Value: (#{x})"
# x is a String. Frozen? (true) Value: (3334444)

y = x[1...-1]
puts "y[1...-1] is a #{y.class}. Frozen? (#{y.frozen?}) Value: (#{y})"
# y[1...-1] is a String. Frozen? (false) Value: (33444)

f = StringBuffer.new(s)
puts "f is a #{f.class}. Frozen? (#{f.frozen?}) Value: (#{s})"
# f is a StringBuffer. Frozen? (false) Value: (333)

f << s
puts "f is a #{f.class}. Frozen? (#{f.frozen?}) Value: (#{f})"
# f is a StringBuffer. Frozen? (false) Value: (333333)

g = f[1...-1]
puts "g[1...-1] is a #{g.class}. Frozen? (#{g.frozen?}) Value: (#{g})"
# g[1...-1] is a StringBuffer. Frozen? (false) Value: (3333)

h = f.to_s.freeze
puts "h is a #{h.class}. Frozen? (#{h.frozen?}) Value: (#{h})"
# h is a String. Frozen? (true) Value: (333333)

i = f.to_s.freeze
puts "i is a #{i.class}. Frozen? (#{i.frozen?}) Value: (#{i})"
#i is a String. Frozen? (true) Value: (333333)
