require "benchmark/ips"

def use_each
  result = (1..1000).each
  1000.times {result.next}
end

def use_succ
  result = 1
  1000.times {result = result.succ}
end

Benchmark.ips do |x|
  x.report("Count with each") { use_each }
  x.report("Count with succ") { use_succ }
  x.compare!
end

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# Warming up --------------------------------------
#      Count with each   197.000  i/100ms
#      Count with succ     1.375k i/100ms
# Calculating -------------------------------------
#      Count with each      2.040k (± 5.3%) i/s -     10.244k
#      Count with succ     14.485k (± 5.4%) i/s -     72.875k
#
# Comparison:
#      Count with succ:    14484.8 i/s
#      Count with each:     2040.2 i/s - 7.10x slower
