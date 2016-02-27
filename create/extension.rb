#The test extension

module Extension
  puts "Extension top"

  def initialize
    puts "Extension - initialize"
  end

  def self.included(target)
    puts "Extension was included in #{target}"
    puts (/^.+(?=:\d+:in)/.match(caller[0])).to_s
  end

  puts "Extension bottom"
end
