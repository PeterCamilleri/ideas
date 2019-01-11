require "benchmark/ips"

def use_times_loop
  result = ''
  10.times {result << 'a' }
  result
end

def use_range_inject
  (0...10).inject('') {|s| s << 'a'}
end

def use_times_inject
  10.times.inject('') {|s| s << 'a'}
end

Benchmark.ips do |x|
  x.report("Build string with times loop")   { use_times_loop }
  x.report("Build string with range inject") { use_range_inject }
  x.report("Build string with times inject") { use_times_inject }
  x.compare!
end

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# Warming up --------------------------------------
# Build string with times loop
#                         28.014k i/100ms
# Build string with range inject
#                         23.216k i/100ms
# Build string with times inject
#                         20.347k i/100ms
# Calculating -------------------------------------
# Build string with times loop
#                         375.149k (± 6.6%) i/s -      1.877M
# Build string with range inject
#                         301.915k (± 6.1%) i/s -      1.509M
# Build string with times inject
#                         255.246k (± 2.6%) i/s -      1.282M
#
# Comparison:
# Build string with times loop:   375148.6 i/s
# Build string with range inject:   301914.9 i/s - 1.24x slower
# Build string with times inject:   255245.9 i/s - 1.47x slower

# Tested under: ruby 2.3.3p222 (2016-11-21 revision 56859) [i386-mingw32]
#
# Warming up --------------------------------------
# Build string with times loop
#                         23.594k i/100ms
# Build string with range inject
#                         19.958k i/100ms
# Build string with times inject
#                         17.796k i/100ms
# Calculating -------------------------------------
# Build string with times loop
#                         475.812k (± 0.3%) i/s -      2.383M in   5.008311s
# Build string with range inject
#                         357.351k (± 1.1%) i/s -      1.796M in   5.027118s
# Build string with times inject
#                         295.560k (± 0.3%) i/s -      1.495M in   5.057786s
#
# Comparison:
# Build string with times loop:   475812.1 i/s
# Build string with range inject:   357351.0 i/s - 1.33x  slower
# Build string with times inject:   295559.7 i/s - 1.61x  slower
