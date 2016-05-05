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

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# Warming up --------------------------------------
# Adding with FIXNUM 1e00
#                        133.000  i/100ms
# Adding with BIGNUM 1e10
#                         55.000  i/100ms
# Adding with BIGNUM 1e20
#                         25.000  i/100ms
# Adding with BIGNUM 1e30
#                         17.000  i/100ms
# Calculating -------------------------------------
# Adding with FIXNUM 1e00
#                           1.387k (± 5.6%) i/s -      6.916k
# Adding with BIGNUM 1e10
#                         578.593  (± 5.2%) i/s -      2.915k
# Adding with BIGNUM 1e20
#                         259.329  (± 6.2%) i/s -      1.300k
# Adding with BIGNUM 1e30
#                         174.743  (± 6.9%) i/s -    884.000
#
# Comparison:
# Adding with FIXNUM 1e00:     1387.4 i/s
# Adding with BIGNUM 1e10:      578.6 i/s - 2.40x slower
# Adding with BIGNUM 1e20:      259.3 i/s - 5.35x slower
# Adding with BIGNUM 1e30:      174.7 i/s - 7.94x slower
