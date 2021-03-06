require "benchmark/ips"

def use_shift
  256.times do |i|
    j = i >> 1 | (i&0x01) << 27
  end
end

def use_condition
  256.times do |i|
    j = i >> 1 | (i.odd? ? 0x10000000 : 0)
  end
end

Benchmark.ips do |x|
  x.report("Rotate with shift restore")        { use_shift }
  x.report("Rotate with conditional restore")  { use_condition }
  x.compare!
end

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# Warming up --------------------------------------
# Rotate with shift restore
#                          1.731k i/100ms
# Rotate with conditional restore
#                          2.252k i/100ms
# Calculating -------------------------------------
# Rotate with shift restore
#                          17.990k (± 1.3%) i/s -     90.012k
# Rotate with conditional restore
#                          23.113k (± 1.1%) i/s -    117.104k
#
# Comparison:
# Rotate with conditional restore:    23112.9 i/s
# Rotate with shift restore:    17990.0 i/s - 1.28x slower

# Tested under: ruby 2.3.3p222 (2016-11-21 revision 56859) [i386-mingw32]
#
# Warming up --------------------------------------
# Rotate with shift restore
#                          1.797k i/100ms
# Rotate with conditional restore
#                          2.053k i/100ms
# Calculating -------------------------------------
# Rotate with shift restore
#                          18.899k (± 0.3%) i/s -     95.241k in   5.039391s
# Rotate with conditional restore
#                          22.367k (± 1.0%) i/s -    112.915k in   5.048839s
#
# Comparison:
# Rotate with conditional restore:    22367.0 i/s
# Rotate with shift restore:    18899.4 i/s - 1.18x  slower
