require "benchmark/ips"
require "fibonacci_rng"

COUNT = 1_000_000

def baseline
  result = 0
  COUNT.times { result += 1 }
end


def use_fibonacci
  gen = FibonacciRng.new
  result = 0
  COUNT.times { result += gen.byte}
end

def use_mersenne
  gen = Random.new
  result = 0
  COUNT.times { result += gen.rand(256)}
end

Benchmark.ips do |x|
  x.report("Baseline overheads")       { baseline }
  x.report("Generator with fibonacci") { use_fibonacci }
  x.report("Generator with mersenne")  { use_mersenne }

  x.compare!
end

# GATHERED DATA

#   Baseline overheads     12.876  (± 7.8%) i/s -     65.000
#   Baseline overheads     13.242  (± 7.6%) i/s -     66.000
#   Baseline overheads     13.180  (± 7.6%) i/s -     66.000
#   Average of 3 runs



# RAW TEST RESULTS
# See the finbonacci_rng project for an analysis of this data.

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# fibonacci_rng version 1.1.1
#
# Warming up --------------------------------------
#   Baseline overheads     1.000  i/100ms
# Generator with fibonacci
#                          1.000  i/100ms
# Generator with mersenne
#                          1.000  i/100ms
# Calculating -------------------------------------
#   Baseline overheads     12.876  (± 7.8%) i/s -     65.000
# Generator with fibonacci
#                           0.294  (± 0.0%) i/s -      2.000  in   6.810018s
# Generator with mersenne
#                           7.317  (± 0.0%) i/s -     37.000
#
# Comparison:
#   Baseline overheads:       12.9 i/s
# Generator with mersenne:        7.3 i/s - 1.76x slower
# Generator with fibonacci:        0.3 i/s - 43.84x slower

# fibonacci_rng version 1.1.2
#
# Warming up --------------------------------------
#   Baseline overheads     1.000  i/100ms
# Generator with fibonacci
#                          1.000  i/100ms
# Generator with mersenne
#                          1.000  i/100ms
# Calculating -------------------------------------
#   Baseline overheads     13.242  (± 7.6%) i/s -     66.000
# Generator with fibonacci
#                           0.327  (± 0.0%) i/s -      2.000  in   6.109018s
# Generator with mersenne
#                           7.559  (± 0.0%) i/s -     38.000
#
# Comparison:
#   Baseline overheads:       13.2 i/s
# Generator with mersenne:        7.6 i/s - 1.75x slower
# Generator with fibonacci:        0.3 i/s - 40.45x slower

# fibonacci_rng version 1.1.3
#
# Warming up --------------------------------------
#   Baseline overheads     1.000  i/100ms
# Generator with fibonacci
#                          1.000  i/100ms
# Generator with mersenne
#                          1.000  i/100ms
# Calculating -------------------------------------
#   Baseline overheads     13.180  (± 7.6%) i/s -     66.000
# Generator with fibonacci
#                           0.439  (± 0.0%) i/s -      3.000  in   6.837015s
# Generator with mersenne
#                           7.487  (± 0.0%) i/s -     38.000
#
# Comparison:
#   Baseline overheads:       13.2 i/s
# Generator with mersenne:        7.5 i/s - 1.76x slower
# Generator with fibonacci:        0.4 i/s - 30.04x slower

# fibonacci_rng version 9.9.9 - Nonfunctional - no spinner
#
# Warming up --------------------------------------
#   Baseline overheads     1.000  i/100ms
# Generator with fibonacci
#                          1.000  i/100ms
# Generator with mersenne
#                          1.000  i/100ms
# Calculating -------------------------------------
#   Baseline overheads     12.565  (± 8.0%) i/s -     63.000
# Generator with fibonacci
#                           4.346  (± 0.0%) i/s -     22.000
# Generator with mersenne
#                           7.213  (± 0.0%) i/s -     36.000
#
# Comparison:
#   Baseline overheads:       12.6 i/s
# Generator with mersenne:        7.2 i/s - 1.74x slower
# Generator with fibonacci:        4.3 i/s - 2.89x slower
