#Test scrambling up some data.

require 'pp'

module Scrambler

  def self.scramble(input_string, window, prng)
    @window = window
    @prng   = prng
    @processed = 0

    prepare_input(input_string)

    do_scramble
  end

  def self.prepare_input(input_string)
    input_bytes = input_string.bytes

    len = input_bytes.length
    len_bytes = "#{len};".bytes

    pad = @prng.rand @window

    pad.times { input_bytes << generate_padding }

    @input = len_bytes + input_bytes
    @length = @input.length
  end

  def self.do_scramble
    result = []

    while @processed < @length
      top_up

      $indexes << index = @prng.rand(@window)
      result << (@input.delete_at(index))

      @processed += 1 if (index + @processed) < @length
    end

    result.pack "C*"
  end

  def self.top_up
    while @input.length < @window
      @input << generate_padding
    end
  end

  def self.generate_padding
    @fill ||= '*'.bytes[0]
  end

end

$indexes = []
$plain_text = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
puts "Plain text = #{$plain_text.inspect}"
$window = 8
puts "Window = #{$window}"
$key = 1234
puts "Key = #{$key}"
$scramble_text = Scrambler.scramble($plain_text, $window, Random.new($key))
puts "Scramble text = #{$scramble_text.inspect}"
puts "Indexes = #{$indexes.inspect}"
