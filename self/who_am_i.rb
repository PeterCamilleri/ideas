puts "Who am I?"

puts
puts "In the open spaces between classes and modules."

puts "Instance <#{self.inspect}> of the class <#{self.class}>"

puts
puts "In the FooBar class defn."

class FooBar

puts "Instance <#{self.inspect}> of the class <#{self.class}>"

end

puts
puts "In a simple instance eval."

42.instance_eval {
  puts "Instance <#{self.inspect}> of the class <#{self.class}>"
}

puts
puts "In a simple instance exec."

77.instance_exec {
  puts "Instance <#{self.inspect}> of the class <#{self.class}>"
}

puts
puts "Defining a method in an instance exec."

s = "bow"

s.instance_exec {

  def speak
    self + " wow"
  end

}

puts s.speak

s << "ser"

puts s.speak
