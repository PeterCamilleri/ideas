require "benchmark/ips"

def assign_many
  a,b,c,d = nil, nil, nil, nil
end

def assign_array
  a,b,c,d = [nil, nil, nil, nil]
end

def assign_chain
  a = b = c = d = nil
end

Benchmark.ips do |x|
  x.report("Assign from many")  { assign_many }
  x.report("Assign from array") { assign_array }
  x.report("Assign from chain") { assign_chain }
  x.compare!
end

# Tested under: ruby 2.1.6p336 (2015-04-13 revision 50298) [i386-mingw32]
#
# Warming up --------------------------------------
#     Assign from many    83.352k i/100ms
#    Assign from array    84.127k i/100ms
#    Assign from chain   109.027k i/100ms
# Calculating -------------------------------------
#     Assign from many      2.102M (± 1.6%) i/s -     10.586M
#    Assign from array      2.096M (± 1.2%) i/s -     10.516M
#    Assign from chain      5.172M (±11.8%) i/s -     25.730M
#
# Comparison:
#    Assign from chain:  5172286.9 i/s
#     Assign from many:  2101560.0 i/s - 2.46x slower
#    Assign from array:  2096226.3 i/s - 2.47x slower

# Tested under: ruby 2.3.3p222 (2016-11-21 revision 56859) [i386-mingw32]
#
# Warming up --------------------------------------
#     Assign from many    37.382k i/100ms
#    Assign from array    37.339k i/100ms
#    Assign from chain    41.627k i/100ms
# Calculating -------------------------------------
#     Assign from many      2.215M (± 0.8%) i/s -     11.102M in   5.013041s
#    Assign from array      2.209M (± 0.7%) i/s -     11.052M in   5.003379s
#    Assign from chain      4.314M (± 0.5%) i/s -     21.604M in   5.007696s
#
# Comparison:
#    Assign from chain:  4314364.6 i/s
#     Assign from many:  2214849.0 i/s - 1.95x  slower
#    Assign from array:  2209068.9 i/s - 1.95x  slower


