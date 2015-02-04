# coding: utf-8

require 'io/console'

puts
puts "With IO.console"
puts IO.console.inspect
puts "IO.console.winsize #does not work!"
puts

puts "With STDOUT"
puts STDOUT.inspect

#This actually works and is quite useful!
puts "winsize = #{STDOUT.winsize.inspect}"

puts
puts "q to quit."

char = nil

# No special characters, messed up enter keys...
# Raw input??? Hardly!!! This is most unacceptable!

while char != 'q'
  STDIN.raw do |inp|
    print (char = inp.getch).bytes.to_a
  end
end
