#Test scrambling up some data.

require 'pp'

module Scrambler

  def self.scramble(input_string, window, prng, fill_char=' ')
    @input  = input_string.bytes
    @window = window
    @prng   = prng

    @fill   = fill_char.bytes[0]

    @length = @input.length
    @processed = 0

    do_scramble
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
      @input << @fill
    end
  end


end

$plain_text = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
puts "Plain text = #{$plain_text.inspect}"
puts "Key = #{$key = 1234}"
$scramble_text = Scrambler.scramble($plain_text, 8, Random.new($key))
puts  "Scramble text = #{$scramble_text.inspect}"
