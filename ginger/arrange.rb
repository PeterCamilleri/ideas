
require_relative 'scramble'

module Arranger

  def self.arrange(input_string, window, prng)
    @window = window
    @prng   = prng
    @processed = 0

    @input = input_string.bytes
    @offsets = (0...@window).to_a
    @offset = @window

    output_string = do_arrange

    extract_output(output_string)
  end

  def self.do_arrange
    result = Array.new(@input.length, 32)
    _pad = @prng.rand @window   #Value not used, but we must stay in sync.

    @input.each do | value |
      index = @prng.rand @window
      result[@offsets[index]] = value

      @offsets.delete_at(index)
      @offsets << @offset
      @offset = @offset.succ
    end

    result.pack "C*"
  end

  def self.extract_output(output_string)
    if /^\d+;/ =~ output_string
      true_len = $&.to_i
      $'[0...true_len]
    else
      output_string
    end
  end

end

puts
puts '-' * 50
puts

puts "Scrambled text = #{$scramble_text.inspect}"
puts "Window = #{$window}"
puts "Key = #{$key}"
$recovered_text = Arranger.arrange($scramble_text, $window, Random.new($key))
puts "Recovered text = #{$recovered_text.inspect}"
