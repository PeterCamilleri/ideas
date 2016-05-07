#Test put data back into order.

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
    result = Array.new(@input.length, 32)

    @generator.rand @window   #We must stay in sync.

    @input.each do | value |
      index = @generator.rand @window
      result[@offsets[index]] = value

      @offsets.delete_at(index)
      @offsets << @offset
      @offset = @offset.succ
    end

    result.pack "C*"
  end

  #Extract the data from the formatted record.
  def self.extract_output(output_string)
    if /^\d+;/ =~ output_string
      $POSTMATCH[0...($MATCH.to_i)]
    else
      fail "Unable to unscramble data."
    end
  end

end

puts; puts '-' * 50; puts
$recovered_text = Arranger.arrange($scramble_text, $window, Random.new($key))
puts "Recovered text = #{$recovered_text.inspect}"
