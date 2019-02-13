module X
  module ClassMethods
    def x()
      puts "In class"
    end
  end

  def y()
    puts "In instance"
  end

  def self.included(host_class)
    host_class.extend(ClassMethods)
  end
end

class Object
  include X
end

# Test the instance method
Object.new.y

# Test the class method
Object.x

