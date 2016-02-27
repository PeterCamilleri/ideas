#Test idea: Can a fiber yield be outside the fiber block?

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
  loop do
    w.step
  end
end

10.times { puts f.resume }

# YES IT CAN !!!!
