#Test idea: What happens when we run out of fiber?

class Worker

  def initialize
    @count = 1
  end

  def step
    Fiber.yield @count
    @count += 1
  end

end

f = Fiber.new do
  w = Worker.new

  8.times do
    w.step
  end

  nil
end

12.times { puts f.resume.inspect }

#
#  1
#  2
#  3
#  4
#  5
#  6
#  7
#  8
#  nil
#  overrun.rb:25:in `resume': dead fiber called (FiberError)
#          from overrun.rb:25:in `block in <main>'
#          from overrun.rb:25:in `times'
#          from overrun.rb:25:in `<main>'
#