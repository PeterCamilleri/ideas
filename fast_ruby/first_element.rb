require "benchmark/ips"

# Plucking the first element of an array and discarding the rest.

def with_assignment
  1000.times { |x| y, = [x]  }
end

def with_index
  1000.times { |x| y = [x][0] }
end

def with_fetch
  1000.times { |x| y = [x].fetch(0) }
end

def with_shift
  1000.times { |x| y = [x].shift }
end

Benchmark.ips do |x|
  x.report("Use assignment")  { with_assignment }
  x.report("Use index")       { with_index }
  x.report("Use fetch")       { with_fetch }
  x.report("Use shift")       { with_shift }
  x.compare!
end

# Tested under: ruby 2.3.3p222 (2016-11-21 revision 56859) [i386-mingw32]
#
# Warming up --------------------------------------
#       Use assignment   843.000  i/100ms
#            Use index   885.000  i/100ms
#            Use fetch   558.000  i/100ms
#            Use shift   650.000  i/100ms
# Calculating -------------------------------------
#       Use assignment      8.813k (± 0.5%) i/s -     44.679k in   5.069794s
#            Use index      9.054k (± 0.2%) i/s -     46.020k in   5.082852s
#            Use fetch      5.682k (± 0.7%) i/s -     28.458k in   5.009075s
#            Use shift      6.780k (± 0.4%) i/s -     34.450k in   5.081379s
#
# Comparison:
#            Use index:     9054.0 i/s
#       Use assignment:     8813.0 i/s - 1.03x  slower
#            Use shift:     6779.8 i/s - 1.34x  slower
#            Use fetch:     5681.6 i/s - 1.59x  slower
