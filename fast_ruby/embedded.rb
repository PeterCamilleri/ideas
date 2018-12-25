require "benchmark/ips"
require 'erb'
require 'erubi'

x     = 42
$env  = binding
lines = 1000

puts "Lines = #{lines}", ""

$esrc = "The answer to life, the universe and everything is <%= x %>\n" * lines
$usrc = "The answer to life, the universe and everything is 21\n"  * lines

class String

  def erb_direct
    ERB.new(self).result($env)
  end

  def erb_shortcut
    self['<%'] ? ERB.new(self).result($env) : self
  end

  def erubi_direct
    $env.eval(Erubi::Engine.new(self).src)
  end

  def erubi_shortcut
    self['<%'] ?  $env.eval(Erubi::Engine.new(self).src) : self
  end

end

Benchmark.ips do |x|
  x.report("erb directly")   { $esrc.erb_direct;     $usrc.erb_direct     }
  x.report("erb shortcut")   { $esrc.erb_shortcut;   $usrc.erb_shortcut   }
  x.report("erubi directly") { $esrc.erubi_direct;   $usrc.erubi_direct   }
  x.report("erubi shortcut") { $esrc.erubi_shortcut; $usrc.erubi_shortcut }

  x.compare!
end

# Lines = 1
#
# Comparison:
#       erubi shortcut:    18984.6 i/s
#         erb shortcut:    13909.9 i/s - 1.36x  slower
#       erubi directly:    12005.5 i/s - 1.58x  slower
#         erb directly:     8154.1 i/s - 2.33x  slower

# Lines = 10
#
# Comparison:
#       erubi shortcut:     4319.1 i/s
#         erb shortcut:     3838.2 i/s - 1.13x  slower
#       erubi directly:     3591.8 i/s - 1.20x  slower
#         erb directly:     2923.2 i/s - 1.48x  slower

# Lines = 100
#
# Comparison:
#       erubi shortcut:      493.3 i/s
#         erb shortcut:      472.1 i/s - 1.05x  slower
#       erubi directly:      451.6 i/s - 1.09x  slower
#         erb directly:      408.3 i/s - 1.21x  slower

# Lines = 1000
#
# Comparison:
#         erb shortcut:       48.0 i/s
#         erb directly:       42.7 i/s - 1.12x  slower
#       erubi shortcut:       39.3 i/s - 1.22x  slower
#       erubi directly:       38.4 i/s - 1.25x  slower

# Conclusions:
#  - For very long texts, erb is better than erubi.
#  - 1000 lines is only 400 times slower than 1 line.
#  - Simplicity wins. I will stick to plain old erb!
