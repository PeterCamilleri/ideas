require "benchmark/ips"

COUNT = 1_000
ANSWER = 250500

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

def use_bit
  result = 0
  COUNT.times { |i| result += i[0] == 1 ? 2 : i }
  fail "Incorrect #{result}" unless result == ANSWER
end

Benchmark.ips do |x|
  x.report("Test with odd?") { use_odd }
  x.report("Test with and")  { use_and }
  x.report("Test with bit")  { use_bit }
  x.compare!
end

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# Warming up --------------------------------------
#       Test with odd?   930.000  i/100ms
#        Test with and   827.000  i/100ms
#        Test with bit   692.000  i/100ms
# Calculating -------------------------------------
#       Test with odd?      9.270k (± 1.6%) i/s -     46.500k
#        Test with and      8.107k (± 1.2%) i/s -     41.350k
#        Test with bit      7.152k (± 1.1%) i/s -     35.984k
#
# Comparison:
#       Test with odd?:     9270.4 i/s
#        Test with and:     8107.0 i/s - 1.14x slower
#        Test with bit:     7151.5 i/s - 1.30x slower
