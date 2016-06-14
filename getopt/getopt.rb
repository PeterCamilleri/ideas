require 'getoptlong'

def help
  puts
  puts "getopt usage summary:"
  puts
  puts "--input,  -i <input data>   # Specify the input data"
  puts "--output, -o <output data>  # Specify the input data"
  puts "--key,    -k <key data>     # Specify the key data"
  puts
end


opts = GetoptLong.new(
  [ "--input",  "-i", GetoptLong::REQUIRED_ARGUMENT ],
  [ "--output", "-o", GetoptLong::REQUIRED_ARGUMENT ],
  [ "--key",    "-k", GetoptLong::REQUIRED_ARGUMENT ])

puts "Option List Study version 231.15.6 build: 278,331"
puts

option_found = false

begin
  opts.each do |opt, arg|
    puts "opt = #{opt}, arg = #{arg.inspect}"
    option_found = true
  end
rescue => err
  puts "Error: #{err.message}"
  help
  exit
end

help unless option_found
