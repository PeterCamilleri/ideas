require "benchmark/ips"

COUNT  =   1_000
ANSWER = 250_500

def use_odd
  result = 0
  COUNT.times { |i| result += i.odd? ? 2 : i }
  fail "Incorrect #{result}" unless result == ANSWER
end

def use_and
  result = 0
  COUNT.times { |i| result += i&1 == 1 ? 2 : i }
  fail "Incorrect #{result}" unless result == ANSWER
end

def use_and_alt
  result = 0
  COUNT.times { |i| result += (i&1).zero? ? i : 2 }
  fail "Incorrect #{result}" unless result == ANSWER
end

def use_bit
  result = 0
  COUNT.times { |i| result += i[0] == 1 ? 2 : i }
  fail "Incorrect #{result}" unless result == ANSWER
end

def use_bit_alt
  result = 0
  COUNT.times { |i| result += i[0].zero? ? i : 2 }
  fail "Incorrect #{result}" unless result == ANSWER
end

Benchmark.ips do |x|
  x.report("Test with odd?")    { use_odd }
  x.report("Test with and")     { use_and }
  x.report("Test with and alt") { use_and_alt }
  x.report("Test with bit")     { use_bit }
  x.report("Test with bit alt") { use_bit_alt }
  x.compare!
end

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# Warming up --------------------------------------
#       Test with odd?   876.000  i/100ms
#        Test with and   837.000  i/100ms
#    Test with and alt   658.000  i/100ms
#        Test with bit   699.000  i/100ms
#    Test with bit alt   585.000  i/100ms
# Calculating -------------------------------------
#       Test with odd?      9.339k (± 1.3%) i/s -     47.304k
#        Test with and      8.509k (± 1.7%) i/s -     42.687k
#    Test with and alt      6.510k (± 2.0%) i/s -     32.900k
#        Test with bit      6.951k (± 1.1%) i/s -     34.950k
#    Test with bit alt      5.963k (± 1.2%) i/s -     29.835k
#
# Comparison:
#       Test with odd?:     9338.7 i/s
#        Test with and:     8509.0 i/s - 1.10x slower
#        Test with bit:     6951.5 i/s - 1.34x slower
#    Test with and alt:     6509.6 i/s - 1.43x slower
#    Test with bit alt:     5962.8 i/s - 1.57x slower

# Tested under: ruby 2.3.3p222 (2016-11-21 revision 56859) [i386-mingw32]
#
# Warming up --------------------------------------
#       Test with odd?   873.000  i/100ms
#        Test with and   807.000  i/100ms
#    Test with and alt   665.000  i/100ms
#        Test with bit   784.000  i/100ms
#    Test with bit alt   641.000  i/100ms
# Calculating -------------------------------------
#       Test with odd?      9.648k (± 0.4%) i/s -     48.888k in   5.067404s
#        Test with and      8.227k (± 0.3%) i/s -     41.157k in   5.002567s
#    Test with and alt      6.584k (± 0.2%) i/s -     33.250k in   5.050125s
#        Test with bit      7.515k (± 0.3%) i/s -     37.632k in   5.007457s
#    Test with bit alt      6.605k (± 0.2%) i/s -     33.332k in   5.046793s
#
# Comparison:
#       Test with odd?:     9647.7 i/s
#        Test with and:     8227.3 i/s - 1.17x  slower
#        Test with bit:     7515.3 i/s - 1.28x  slower
#    Test with bit alt:     6604.6 i/s - 1.46x  slower
#    Test with and alt:     6584.0 i/s - 1.47x  slower

