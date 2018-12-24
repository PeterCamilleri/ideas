require "benchmark/ips"
require 'erb'

x     = 42
$env  = binding
lines = 100
$esrc = ("The answer to life, the universe and everything is <%= x %>\n" * lines).freeze
$usrc = ("The answer to life, the universe and everything is 21\n" * lines).freeze

class String

  def first_embedder
    ERB.new(self).result($env)
  end

  def second_embedder
    self['<%'] ? ERB.new(self).result($env) : self
  end

  def third_embedder
    /<%/ =~ self ? ERB.new(self).result($env) : self
  end

end

def use_direct
  $esrc.first_embedder
  $usrc.first_embedder
end

def use_shortcut1
  $esrc.second_embedder
  $usrc.second_embedder
end

def use_shortcut2
  $esrc.third_embedder
  $usrc.third_embedder
end

Benchmark.ips do |x|
  x.report("Embed directly")     { use_direct }
  x.report("Embed shortcut 1")   { use_shortcut1 }
  x.report("Embed shortcut 2")   { use_shortcut2 }

  x.compare!
end

# RESULTS
#
# Warming up --------------------------------------
#       Embed directly    40.000  i/100ms
#     Embed shortcut 1    47.000  i/100ms
#     Embed shortcut 2    47.000  i/100ms
# Calculating -------------------------------------
#       Embed directly    411.914  (± 0.2%) i/s -      2.080k in   5.049628s
#     Embed shortcut 1    475.345  (± 0.2%) i/s -      2.397k in   5.042675s
#     Embed shortcut 2    476.339  (± 0.4%) i/s -      2.397k in   5.032201s
#
# Comparison:
#     Embed shortcut 2:      476.3 i/s
#     Embed shortcut 1:      475.3 i/s - same-ish: difference falls within error
#       Embed directly:      411.9 i/s - 1.16x  slower

# Conclusion: Not worth implementing.
