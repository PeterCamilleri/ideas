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

# Tested under: ruby 2.3.3p222 (2016-11-21 revision 56859) [i386-mingw32]
#
# Warming up --------------------------------------
# Build with Array.new    27.901k i/100ms
#     Build with times    21.706k i/100ms
# Calculating -------------------------------------
# Build with Array.new    681.959k (± 1.8%) i/s -      3.432M in   5.034243s
#     Build with times    417.166k (± 0.7%) i/s -      2.105M in   5.047357s
#
# Comparison:
# Build with Array.new:   681958.5 i/s
#     Build with times:   417165.7 i/s - 1.63x  slower
