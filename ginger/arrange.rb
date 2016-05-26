#Test putting data back into order.

require 'English'
require_relative 'scramble'

module Arranger

  def self.arrange(input_string, window, generator)
    @window    = window
    @generator = generator
    @processed = 0
    @input     = input_string.bytes
    @offsets   = (0...@window).to_a
    @offset    = @window

    output_string = do_arrange
    extract_output(output_string)
  end

  #Put bytes back into order.
  def self.do_arrange
    result = Array.new(@input.length + @window, 32)

    @input.each do | value |
      index = @generator.rand(@window)
      result[@offsets[index]] = value ^ @generator.rand(256)

      @offsets.delete_at(index)
      @offsets << @offset
      @offset += 1
    end

    result.pack "C*"
  end

  #Extract the data from the formatted record.
  def self.extract_output(output_string)
    if /^[0-9a-z]+;/ =~ output_string
      $POSTMATCH[0...($MATCH.to_i(36))]
    else
      fail "Unable to unscramble data."
    end
  end

end

puts; puts '-' * 50; puts
$recovered_text = Arranger.arrange($scramble_text, $window, Random.new($key))
puts "Recovered text = \n#{$recovered_text}"
