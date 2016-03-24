require "benchmark/ips"

def use_new
  Array.new(10) {|i| i*i}
end

def use_times
  10.times.map {|i| i*i}
end

Benchmark.ips do |x|
  x.report("Build with Array.new") { use_new }
  x.report("Build with times")     { use_times }
  x.compare!
end
