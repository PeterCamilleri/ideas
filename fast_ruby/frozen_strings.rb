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
