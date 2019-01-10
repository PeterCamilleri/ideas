require "benchmark/ips"
require 'erb'
require 'erubi'
require 'pp'

x     = 42
$env  = binding

class String

  def erb_d
    ERB.new(self).result($env).escape_text
  end

  def erb_s
    (self['<%'] ? ERB.new(self).result($env) : self).escape_text
  end

  def erubi_d
    $env.eval(Erubi::Engine.new(self).src).escape_text
  end

  def erubi_s
    (self['<%'] ? $env.eval(Erubi::Engine.new(self).src) : self).escape_text
  end

  def handlebar
    string, text, buffer = self, "", []

    until string.empty?
      text, code, string = string.partition(/{{.*?}}/m)

      if not text.empty?
        text = text.escape_text
        buffer << "_m_<<#{text.inspect};"
      elsif buffer.empty?
        buffer << ""
      end

      unless code.empty?
        if code[-3] == "#"
          buffer << "#{code[2...-3]};"
        else
          buffer << "_m_<<(#{code[2...-2]}).to_s;"
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
    gsub(/\\\S/) {|found| found[1]}
  end
end

work_list = [1, 10, 100, 1000, 10000]

Item = Struct.new(:data, :work)

items = { "erb directly"   =>
            Item.new([], Proc.new { $esrc.erb_d;     $usrc.erb_d     }),
          "erb shortcut"   =>
            Item.new([], Proc.new { $esrc.erb_s;     $usrc.erb_s     }),
          "erubi directly" =>
            Item.new([], Proc.new { $esrc.erubi_d;   $usrc.erubi_d   }),
          "erubi shortcut" =>
            Item.new([], Proc.new { $esrc.erubi_s;   $usrc.erubi_s   }),
          "handlebar"      =>
            Item.new([], Proc.new { $hsrc.handlebar; $usrc.handlebar })
         }


work_list.each do |lines|

  puts "Lines = #{lines}",""

  $esrc = "The answer to life, the \\<\\%universe\\%\\> and everything is <%= x %>\n" * lines
  $hsrc = "The answer to life, the \\{\\{universe\\}\\} and everything is {{ x }}\n" * lines
  $usrc = "The answer to life, the \\<\\%universe\\%\\> and everything is 21\n"  * lines

  # Use an arg of 't' to test for correct output.
  if ARGV[0] == 't'
    puts $usrc.erb_d
    puts $esrc.erb_d

    puts $usrc.erb_s
    puts $esrc.erb_s

    puts $usrc.erubi_d
    puts $esrc.erubi_d

    puts $usrc.erubi_s
    puts $esrc.erubi_s

    puts $usrc.handlebar
    puts $hsrc.handlebar
    exit
  end

  report = Benchmark.ips do |x|

    items.each do |name, item|
      x.report(name, &item.work)
    end

    x.compare!

  end

  fastest = -1.0

  report.data.each do |test_result|
    fastest = test_result[:ips] if test_result[:ips] > fastest
  end

  report.data.each do |test_result|
    name = test_result[:name]
    ips  = test_result[:ips]
    items[name].data << fastest/ips
  end

end

items.each do |name, item|
  puts name, item.data, ""
end

# Lines = 1
#
# Warming up --------------------------------------
#         erb directly   690.000  i/100ms
#         erb shortcut     1.101k i/100ms
#       erubi directly   863.000  i/100ms
#       erubi shortcut     1.147k i/100ms
#            handlebar     1.801k i/100ms
# Calculating -------------------------------------
#         erb directly      7.100k (± 0.5%) i/s -     35.880k in   5.053619s
#         erb shortcut     11.477k (± 0.5%) i/s -     58.353k in   5.084651s
#       erubi directly      8.905k (± 0.8%) i/s -     44.876k in   5.039727s
#       erubi shortcut     11.966k (± 0.4%) i/s -     60.791k in   5.080203s
#            handlebar     19.494k (± 0.6%) i/s -     99.055k in   5.081482s
#
# Comparison:
#            handlebar:    19493.9 i/s
#       erubi shortcut:    11966.4 i/s - 1.63x  slower
#         erb shortcut:    11476.6 i/s - 1.70x  slower
#       erubi directly:     8905.0 i/s - 2.19x  slower
#         erb directly:     7100.0 i/s - 2.75x  slower
#
# Lines = 10
#
# Warming up --------------------------------------
#         erb directly   229.000  i/100ms
#         erb shortcut   288.000  i/100ms
#       erubi directly   211.000  i/100ms
#       erubi shortcut   254.000  i/100ms
#            handlebar   384.000  i/100ms
# Calculating -------------------------------------
#         erb directly      2.317k (± 1.1%) i/s -     11.679k in   5.040522s
#         erb shortcut      2.918k (± 0.5%) i/s -     14.688k in   5.034285s
#       erubi directly      2.140k (± 0.5%) i/s -     10.761k in   5.027787s
#       erubi shortcut      2.581k (± 1.5%) i/s -     12.954k in   5.020915s
#            handlebar      3.914k (± 0.4%) i/s -     19.584k in   5.004007s
#
# Comparison:
#            handlebar:     3913.7 i/s
#         erb shortcut:     2917.7 i/s - 1.34x  slower
#       erubi shortcut:     2580.6 i/s - 1.52x  slower
#         erb directly:     2317.3 i/s - 1.69x  slower
#       erubi directly:     2140.4 i/s - 1.83x  slower
#
# Lines = 100
#
# Warming up --------------------------------------
#         erb directly    30.000  i/100ms
#         erb shortcut    35.000  i/100ms
#       erubi directly    25.000  i/100ms
#       erubi shortcut    29.000  i/100ms
#            handlebar    44.000  i/100ms
# Calculating -------------------------------------
#         erb directly    308.580  (± 0.3%) i/s -      1.560k in   5.055489s
#         erb shortcut    352.060  (± 0.3%) i/s -      1.785k in   5.070227s
#       erubi directly    251.071  (± 1.2%) i/s -      1.275k in   5.079178s
#       erubi shortcut    294.968  (± 0.3%) i/s -      1.479k in   5.014167s
#            handlebar    444.143  (± 0.9%) i/s -      2.244k in   5.052878s
#
# Comparison:
#            handlebar:      444.1 i/s
#         erb shortcut:      352.1 i/s - 1.26x  slower
#         erb directly:      308.6 i/s - 1.44x  slower
#       erubi shortcut:      295.0 i/s - 1.51x  slower
#       erubi directly:      251.1 i/s - 1.77x  slower
#
# Lines = 1000
#
# Warming up --------------------------------------
#         erb directly     3.000  i/100ms
#         erb shortcut     3.000  i/100ms
#       erubi directly     2.000  i/100ms
#       erubi shortcut     2.000  i/100ms
#            handlebar     4.000  i/100ms
# Calculating -------------------------------------
#         erb directly     31.919  (± 0.0%) i/s -    162.000  in   5.075621s
#         erb shortcut     36.572  (± 0.0%) i/s -    183.000  in   5.004100s
#       erubi directly     22.338  (± 0.0%) i/s -    112.000  in   5.014021s
#       erubi shortcut     25.767  (± 0.0%) i/s -    130.000  in   5.045465s
#            handlebar     45.613  (± 0.0%) i/s -    232.000  in   5.086382s
#
# Comparison:
#            handlebar:       45.6 i/s
#         erb shortcut:       36.6 i/s - 1.25x  slower
#         erb directly:       31.9 i/s - 1.43x  slower
#       erubi shortcut:       25.8 i/s - 1.77x  slower
#       erubi directly:       22.3 i/s - 2.04x  slower
#
# Lines = 10000
#
# Warming up --------------------------------------
#         erb directly     1.000  i/100ms
#         erb shortcut     1.000  i/100ms
#       erubi directly     1.000  i/100ms
#       erubi shortcut     1.000  i/100ms
#            handlebar     1.000  i/100ms
# Calculating -------------------------------------
#         erb directly      3.043  (± 0.0%) i/s -     16.000  in   5.260217s
#         erb shortcut      3.448  (± 0.0%) i/s -     18.000  in   5.222336s
#       erubi directly      1.008  (± 0.0%) i/s -      6.000  in   5.954983s
#       erubi shortcut      1.077  (± 0.0%) i/s -      6.000  in   5.570273s
#            handlebar      4.231  (± 0.0%) i/s -     22.000  in   5.203304s
#
# Comparison:
#            handlebar:        4.2 i/s
#         erb shortcut:        3.4 i/s - 1.23x  slower
#         erb directly:        3.0 i/s - 1.39x  slower
#       erubi shortcut:        1.1 i/s - 3.93x  slower
#       erubi directly:        1.0 i/s - 4.20x  slower
#
#
# erb directly
# 2.745613340009359
# 1.688893482365301
# 1.4393117822373045
# 1.4290463153595876
# 1.3906075389850132
#
# erb shortcut
# 1.6985798157495433
# 1.341391493684265
# 1.2615530902083862
# 1.2472336062845757
# 1.2270883987242502
#
# erubi directly
# 2.1890981416651965
# 1.828539335947944
# 1.7689938884940712
# 2.0419505142662895
# 4.198278084820397
#
# erubi shortcut
# 1.62905113668478
# 1.5165788642045268
# 1.5057325906199721
# 1.7702400360958612
# 3.92772624981774
#
# handlebar
# 1.0
# 1.0
# 1.0
# 1.0
# 1.0

#=======================================================
# Conclusion: The handlebar code looks pretty good!
#             Not only is it fastest, it is consistent.
#=======================================================