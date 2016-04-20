puts "An examination of singleton classes and more."
puts

test1 = "Hello World"

puts "(test1) Class = #{test1.class}, Singleton class = #{test1.singleton_class}."
puts "(test1) Singleton methods =  #{test1.singleton_methods}"
puts

def test1.shout
  self.upcase
end

puts "(test1) Class = #{test1.class}, Singleton class = #{test1.singleton_class}."
puts "(test1) Singleton methods =  #{test1.singleton_methods}"
puts

test2 = test1.clone

puts "(test2) Class = #{test2.class}, Singleton class = #{test2.singleton_class}."
puts "(test2) Singleton methods =  #{test2.singleton_methods}"
puts

puts test1.shout
puts test2.shout
