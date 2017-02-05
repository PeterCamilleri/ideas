module AutoAddMethods

  def singleton_method_added(symbol)
    define_method(symbol, method(symbol).to_proc)
  end

end

class Foo

  extend AutoAddMethods

  @bar = 39

  def initialize
    @bar = 42
  end

  def test_one # Only added as an instance method.
    puts "One #{@bar.inspect}"
  end

  def self.test_two # Added as both an instance and class method.
    puts "Two #{@bar.inspect}"
  end

end

i = Foo.new
i.test_one
i.test_two

Foo.test_two
