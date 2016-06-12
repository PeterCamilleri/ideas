require "benchmark/ips"
require "fibonacci_rng"

def use_fibonacci
  gen = FibonacciRng.new
  result = 0
  1_000_000.times { result += gen.byte}
end

def use_mersenne
  gen = Random.new
  result = 0
  1_000_000.times { result += gen.rand(256)}
end

Benchmark.ips do |x|
  x.report("Generator with fibonacci") { use_fibonacci }
  x.report("Generator with mersenne")  { use_mersenne }
  x.compare!
end

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# Warming up --------------------------------------
# Generator with fibonacci
#                          1.000  i/100ms
# Generator with mersenne
#                          1.000  i/100ms
# Calculating -------------------------------------
# Generator with fibonacci
#                           0.293  (� 0.0%) i/s -      2.000  in   6.823390s
# Generator with mersenne
#                           7.384  (� 0.0%) i/s -     37.000
#
# Comparison:
# Generator with mersenne:        7.4 i/s
# Generator with fibonacci:        0.3 i/s - 25.19x slower