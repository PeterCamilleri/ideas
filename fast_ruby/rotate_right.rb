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
