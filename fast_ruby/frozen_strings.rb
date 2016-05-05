require "benchmark/ips"

def use_thawed
  a = "Now is the time for all good voters to throw up in disgust."
  b = a
  c = b
  d = c
end

def use_frozen
  a = "Now is the time for all good voters to throw up in disgust.".freeze
  b = a
  c = b
  d = c
end

Benchmark.ips do |x|
  x.report("Thawed strings") { use_thawed }
  x.report("Frozen strings") { use_frozen }
  x.compare!
end

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# C:\Sites\ideas\fast_ruby>ruby frozen_strings.rb
# Warming up --------------------------------------
#       Thawed strings    99.823k i/100ms
#       Frozen strings   109.052k i/100ms
# Calculating -------------------------------------
#       Thawed strings      3.403M (± 1.9%) i/s -     17.070M
#       Frozen strings      5.065M (± 2.5%) i/s -     25.409M
#
# Comparison:
#       Frozen strings:  5064609.2 i/s
#       Thawed strings:  3402770.7 i/s - 1.49x slower
