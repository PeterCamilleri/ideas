#Some experiments with method arguments.

def meth(a=nil, b=nil)
  if a.is_a?(Hash)
    arg_a = a[:a]
    arg_b = a[:b]
  else
    arg_a = a
    arg_b = b
  end

  arg_a ||= "default_a"
  arg_b ||= "default_b"

  puts
  puts "arg_a = #{arg_a}, arg_b = #{arg_b}"
end

meth

meth(19)

meth(a: 20, b: 44)

meth(b: 44)


