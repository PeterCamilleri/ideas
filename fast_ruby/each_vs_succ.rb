require "benchmark/ips"

def use_each
  result = (1..1000).each
  1000.times {result.next}
end

def use_succ
  result = 1
  1000.times {result = result.succ}
end

def use_addition
  result = 1
  1000.times {result += 1}
end

Benchmark.ips do |x|
  x.report("Count with each") { use_each }
  x.report("Count with succ") { use_succ }
  x.report("Count with += 1") { use_addition }
  x.compare!
end

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# Warming up --------------------------------------
#      Count with each   207.000  i/100ms
#      Count with succ     1.369k i/100ms
#      Count with += 1     1.319k i/100ms
# Calculating -------------------------------------
#      Count with each      2.091k (± 3.4%) i/s -     10.557k
#      Count with succ     14.457k (± 5.4%) i/s -     72.557k
#      Count with += 1     13.307k (± 3.7%) i/s -     67.269k
#
# Comparison:
#      Count with succ:    14456.8 i/s
#      Count with += 1:    13306.5 i/s - 1.09x slower
#      Count with each:     2091.1 i/s - 6.91x slower
