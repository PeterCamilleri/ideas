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




#=======================================================
# Conclusion: The handlebar code looks pretty good!
#             Not only is it fastest, it is consistent.
#=======================================================