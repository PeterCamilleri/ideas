require "benchmark/ips"

# Plucking the first element of an array and discarding the rest.

def with_assignment
  1000.times { |x| y, = [x]  }
end

def with_index
  1000.times { |x| y = [x][0] }
end

def with_fetch
  1000.times { |x| y = [x].fetch(0) }
end

def with_shift
  1000.times { |x| y = [x].shift }
end

Benchmark.ips do |x|
  x.report("Use assignment")  { with_assignment }
  x.report("Use index")       { with_index }
  x.report("Use fetch")       { with_fetch }
  x.report("Use shift")       { with_shift }
  x.compare!
end
