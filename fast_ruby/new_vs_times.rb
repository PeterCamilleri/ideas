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

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# Warming up --------------------------------------
# Build with Array.new    43.624k i/100ms
#     Build with times    31.227k i/100ms
# Calculating -------------------------------------
# Build with Array.new    658.764k (± 1.0%) i/s -      3.315M
#     Build with times    415.884k (± 1.0%) i/s -      2.092M
#
# Comparison:
# Build with Array.new:   658763.5 i/s
#     Build with times:   415884.3 i/s - 1.58x slower
