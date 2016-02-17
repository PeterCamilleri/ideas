puts "\nfiber test #3"

def nest(x)
  puts "Test ran! x = #{x}"
  Fiber.yield true
  puts "After yield!"
end

block_one = lambda do |x|
  3.times do
    nest(x)
  end

  nil
end

test = Fiber.new &block_one
while test.resume(1)
end



puts "\nfiber test #4"

class HighFibre

  def each(x)
    if block_given?
      3.times do
        puts "Test ran! x = #{x}"
        yield true
        puts "After yield!"
      end

      yield false
    else
      self.to_enum(:each, x)
    end
  end
end

my_fibre = HighFibre.new
hook = my_fibre.each(1)
while hook.next
end

