require "benchmark/ips"

def one_e_00
  result = 1
  10_000.times { |i| result += i }
  result
end

def one_e_10
  result = 10_000_000_000
  10_000.times { |i| result += i }
  result
end

def one_e_20
  result = 100_000_000_000_000_000_000
  10_000.times { |i| result += i }
  result
end

def one_e_30
  result = 1000_000_000_000_000_000_000_000_000_000
  10_000.times { |i| result += i }
  result
end

Benchmark.ips do |x|
  x.report("Adding with FIXNUM 1e00") { one_e_00 }
  x.report("Adding with BIGNUM 1e10") { one_e_10 }
  x.report("Adding with BIGNUM 1e20") { one_e_20 }
  x.report("Adding with BIGNUM 1e30") { one_e_30 }
  x.compare!
end
