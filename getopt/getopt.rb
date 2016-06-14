require 'getoptlong'

opts = GetoptLong.new(
  [ "--input",  "-i", GetoptLong::REQUIRED_ARGUMENT ],
  [ "--output", "-o", GetoptLong::REQUIRED_ARGUMENT ],
  [ "--key",    "-k", GetoptLong::REQUIRED_ARGUMENT ])

puts "Option List Study"
puts

option_found = false

opts.each do |opt, arg|

  puts "opt = #{opt}, arg = #{arg.inspect}"
  option_found = true

end

puts "No options found" unless option_found
