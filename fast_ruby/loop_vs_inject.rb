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
