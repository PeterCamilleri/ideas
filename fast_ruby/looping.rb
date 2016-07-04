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
