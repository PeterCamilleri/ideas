require "benchmark/ips"
require 'erb'
require 'erubi'

x     = 42
$env  = binding

if ARGV[0] == 't'
  lines = 1
else
  lines = 1000
end

puts "Lines = #{lines}", ""

$esrc = "The answer to life, the \\<\\%universe\\%\\> and everything is <%= x %>\n" * lines
$hsrc = "The answer to life, the \\{\\{universe\\}\\} and everything is {{ x }}\n" * lines
$usrc = "The answer to life, the \\<\\%universe\\%\\> and everything is 21\n"  * lines

class String

  def erb_direct
    ERB.new(self).result($env).escape_text
  end

  def erb_shortcut
    (self['<%'] ? ERB.new(self).result($env) : self).escape_text
  end

  def erubi_direct
    ($env.eval(Erubi::Engine.new(self).src).escape_text).escape_text
  end

  def erubi_shortcut
    (self['<%'] ? $env.eval(Erubi::Engine.new(self).src) : self).escape_text
  end

  def handlebar
    string, text, buffer = self, "", []

    until string.empty?
      text, code, string = string.partition(/{{.*?}}/m)

      unless text.empty?
        text = text.escape_text
        buffer << "_m_<<#{text.inspect};"
      end

      unless code.empty?
        if code[-3] == "#"
          buffer << "#{code[2...-3]};"
        else
          buffer << "_m_<<#{code[2...-2]}.to_s;"
        end
      end
    end

    if buffer.length > 1
      $env.eval("_m_ = '';" + buffer.join + "_m_")
    else
      text
    end
  end

  def escape_text
    gsub(/\\./) {|found| found[1] || "\\"}
  end
end

# Use an arg of 't' to test for correct output.
if ARGV[0] == 't'
  puts $usrc.erb_direct
  puts $esrc.erb_direct

  puts $usrc.erb_shortcut
  puts $esrc.erb_shortcut

  puts $usrc.erubi_direct
  puts $esrc.erubi_direct

  puts $usrc.erubi_shortcut
  puts $esrc.erubi_shortcut

  puts $usrc.handlebar
  puts $hsrc.handlebar
  exit
end

Benchmark.ips do |x|
  x.report("erb directly")   { $esrc.erb_direct;     $usrc.erb_direct     }
  x.report("erb shortcut")   { $esrc.erb_shortcut;   $usrc.erb_shortcut   }
  x.report("erubi directly") { $esrc.erubi_direct;   $usrc.erubi_direct   }
  x.report("erubi shortcut") { $esrc.erubi_shortcut; $usrc.erubi_shortcut }
  x.report("handlebar")      { $hsrc.handlebar;      $usrc.handlebar }

  x.compare!
end

# Lines = 1
#
# Comparison:
#            handlebar:    19682.6 i/s
#       erubi shortcut:    12561.3 i/s - 1.57x  slower
#         erb shortcut:    11494.7 i/s - 1.71x  slower
#       erubi directly:     8638.1 i/s - 2.28x  slower
#         erb directly:     7098.5 i/s - 2.77x  slower

# Lines = 10
#
# Comparison:
#            handlebar:     3984.4 i/s
#         erb shortcut:     2935.9 i/s - 1.36x  slower
#       erubi shortcut:     2629.4 i/s - 1.52x  slower
#         erb directly:     2346.4 i/s - 1.70x  slower
#       erubi directly:     2109.8 i/s - 1.89x  slower

# Lines = 100
#
# Comparison:
#            handlebar:      452.3 i/s
#         erb shortcut:      355.5 i/s - 1.27x  slower
#         erb directly:      311.3 i/s - 1.45x  slower
#       erubi shortcut:      295.8 i/s - 1.53x  slower
#       erubi directly:      253.4 i/s - 1.78x  slower

# Lines = 1000
#
# Comparison:
#            handlebar:       46.5 i/s
#         erb shortcut:       36.9 i/s - 1.26x  slower
#         erb directly:       32.5 i/s - 1.43x  slower
#       erubi shortcut:       26.0 i/s - 1.79x  slower
#       erubi directly:       22.6 i/s - 2.06x  slower

#=======================================================
# Conclusion: The handlebar code looks pretty good!
#             Not only is it fastest, it is consistent.
#=======================================================