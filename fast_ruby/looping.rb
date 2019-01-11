require "benchmark/ips"

COUNT = 10_000
INDEXES = Array.new(COUNT) { |i| i }

def use_times
  result = 0
  COUNT.times { |i| result += i}
end

def use_each
  result = 0
  (0...COUNT).each { |i| result += i}
end

def use_indexes
  result = 0
  INDEXES.each { |i| result += i}
end

def use_for
  result = 0
  for i in 0...COUNT
    result += i
  end
end

def use_loop
  result, i = 0, 0

  loop do
    result += i
    i += 1
    break if i == COUNT
  end
end

Benchmark.ips do |x|
  x.report("Looping with times")   { use_times   }
  x.report("Looping with each")    { use_each    }
  x.report("Looping with indexes") { use_indexes }
  x.report("Looping with for")     { use_for     }
  x.report("Looping with loop")    { use_loop    }

  x.compare!
end

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# Warming up --------------------------------------
#   Looping with times   136.000  i/100ms
#    Looping with each   138.000  i/100ms
# Looping with indexes   127.000  i/100ms
#     Looping with for   128.000  i/100ms
#    Looping with loop   103.000  i/100ms
# Calculating -------------------------------------
#   Looping with times      1.368k (± 7.6%) i/s -      6.936k
#    Looping with each      1.388k (± 7.6%) i/s -      6.900k
# Looping with indexes      1.297k (± 6.6%) i/s -      6.477k
#     Looping with for      1.291k (± 7.4%) i/s -      6.528k
#    Looping with loop      1.046k (± 6.9%) i/s -      5.253k
#
# Comparison:
#    Looping with each:     1387.6 i/s
#   Looping with times:     1367.7 i/s - 1.01x slower
# Looping with indexes:     1297.2 i/s - 1.07x slower
#     Looping with for:     1291.0 i/s - 1.07x slower
#    Looping with loop:     1046.1 i/s - 1.33x slower

# Tested under: ruby 2.3.3p222 (2016-11-21 revision 56859) [i386-mingw32]
#
# Warming up --------------------------------------
#   Looping with times   140.000  i/100ms
#    Looping with each   128.000  i/100ms
# Looping with indexes   139.000  i/100ms
#     Looping with for   123.000  i/100ms
#    Looping with loop   101.000  i/100ms
# Calculating -------------------------------------
#   Looping with times      1.418k (± 1.1%) i/s -      7.140k in   5.034850s
#    Looping with each      1.338k (± 1.3%) i/s -      6.784k in   5.070333s
# Looping with indexes      1.369k (± 1.0%) i/s -      6.950k in   5.078328s
#     Looping with for      1.241k (± 0.8%) i/s -      6.273k in   5.054186s
#    Looping with loop      1.033k (± 0.8%) i/s -      5.252k in   5.085271s
#
# Comparison:
#   Looping with times:     1418.3 i/s
# Looping with indexes:     1368.7 i/s - 1.04x  slower
#    Looping with each:     1338.2 i/s - 1.06x  slower
#     Looping with for:     1241.2 i/s - 1.14x  slower
#    Looping with loop:     1032.9 i/s - 1.37x  slower
