#Test reading from stdin as a file of input.

puts "Enter some data"

result = ""

while (line = gets)
  result << line
end

puts "The following was read in"

puts result.inspect

# Test with
#
# $ cat test.txt | ruby stdin_read.rb
#
