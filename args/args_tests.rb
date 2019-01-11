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

meth               # arg_a = default_a, arg_b = default_b

meth(19)           # arg_a = 19, arg_b = default_b

meth(a: 20, b: 44) # arg_a = 20, arg_b = 44

meth(b: 44)        # arg_a = default_a, arg_b = 44

