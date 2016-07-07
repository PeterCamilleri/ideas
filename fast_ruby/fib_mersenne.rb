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
#                           0.293  (± 0.0%) i/s -      2.000  in   6.823390s
# Generator with mersenne
#                           7.384  (± 0.0%) i/s -     37.000
#
# Comparison:
# Generator with mersenne:        7.4 i/s
# Generator with fibonacci:        0.3 i/s - 25.19x slower

# Version 1.1.2
#
# Warming up --------------------------------------
# Generator with fibonacci
#                          1.000  i/100ms
# Generator with mersenne
#                          1.000  i/100ms
# Calculating -------------------------------------
# Generator with fibonacci
#                           0.329  (± 0.0%) i/s -      2.000  in   6.073346s
# Generator with mersenne
#                           7.455  (± 0.0%) i/s -     38.000
#
# Comparison:
# Generator with mersenne:        7.5 i/s
# Generator with fibonacci:        0.3 i/s - 22.64x slower

# Version 1.1.3
#
# Warming up --------------------------------------
# Generator with fibonacci
#                          1.000  i/100ms
# Generator with mersenne
#                          1.000  i/100ms
# Calculating -------------------------------------
# Generator with fibonacci
#                           0.454  (± 0.0%) i/s -      3.000  in   6.613378s
# Generator with mersenne
#                           7.611  (± 0.0%) i/s -     39.000
#
# Comparison:
# Generator with mersenne:        7.6 i/s
# Generator with fibonacci:        0.5 i/s - 16.78x slower

# Version comparison.
#
# Generator with fibonacci 1.1.1
#                           0.293  (± 0.0%) i/s -      2.000  in   6.823390s
# Generator with fibonacci 1.1.2 (speed_up_one branch)
#                           0.329  (± 0.0%) i/s -      2.000  in   6.073346s
# Generator with fibonacci 1.1.3
#                           0.454  (± 0.0%) i/s -      3.000  in   6.613378s
#
# Version 1.1.1 is the baseline.
# Version 1.1.2 is 1.22 times faster.
# Version 1.1.3 is 1.55 times faster.
#
