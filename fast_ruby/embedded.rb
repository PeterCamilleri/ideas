require "benchmark/ips"
require 'erb'
require 'erubi'

x     = 42
$env  = binding
lines = 100

puts "Lines = #{lines}", ""

$esrc = "The answer to life, the universe and everything is <%= x %>\n" * lines
$usrc = "The answer to life, the universe and everything is 21\n"  * lines

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

  def with_erubi
    $env.eval(Erubi::Engine.new(self).src)
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

def use_erubi
  $esrc.with_erubi
  $usrc.with_erubi
end


Benchmark.ips do |x|
  x.report("Embed directly")     { use_direct }
  x.report("Embed shortcut 1")   { use_shortcut1 }
  x.report("Embed shortcut 2")   { use_shortcut2 }
  x.report("Embed eRubi")        { use_erubi }

  x.compare!
end

# Comparison:
#     Embed shortcut 2:      474.1 i/s
#     Embed shortcut 1:      472.2 i/s - same-ish: difference falls within error
#          Embed eRubi:      453.1 i/s - 1.05x  slower
#       Embed directly:      408.2 i/s - 1.16x  slower

# Conclusion: Well I guess I will stick to plain old erb!