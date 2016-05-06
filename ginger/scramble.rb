#Test scrambling up some data.

require 'pp'

module Scrambler

  def self.scramble(input_string, window, prng, fill_char=' ')
    prepare_input(input_string)
    @window = window
    @prng   = prng

    @fill   = fill_char.bytes[0]
    @processed = 0

    do_scramble
  end

  def self.prepare_input(input_string)
    input_bytes = input_string.bytes

    len = input_bytes.length
    len_bytes = "#{len};".bytes

    @input = len_bytes + input_bytes
    @length = @input.length
  end

  def self.do_scramble
    result = []

    while @processed < @length
      top_up

      index = @prng.rand(@window)

      #result << (@input.delete_at(index) ^ @prng.rand(256))
      result << (@input.delete_at(index))

      @processed += 1 if (index + @processed) < @length
    end

    result.pack "C*"
  end

  def self.top_up
    while @input.length < @window
      pad_input
    end
  end

  def self.pad_input
    @input << @fill
  end

end

$plain_text = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
puts "Plain text = #{$plain_text.inspect}"
$key = 1234
puts "Key = #{$key}"
$scramble_text = Scrambler.scramble($plain_text, 8, Random.new($key))
puts  "Scramble text = #{$scramble_text.inspect}"
