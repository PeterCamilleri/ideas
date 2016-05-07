#Test scrambling up some data.

module Scrambler

  def self.scramble(input_string, window, generator)
    @window = window
    @generator = generator
    @processed = 0
    prepare_input(input_string)
    do_scramble
  end

  #Get the data formatted for scrambling.
  def self.prepare_input(input_string)
    input_bytes = input_string.bytes
    len = input_bytes.length
    len_bytes = "#{len};".bytes
    pad = @generator.rand @window

    pad.times { input_bytes << generate_padding }

    @input = len_bytes + input_bytes
    @length = @input.length
  end

  #Put bytes into disorder.
  def self.do_scramble
    result = []

    while @processed < @length
      top_up

      index = @generator.rand(@window)
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

$plain_text = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
puts "Plain text = #{$plain_text.inspect}"
$window = 8
puts "Window = #{$window}"
$key = 1234
puts "Key = #{$key}"
$scramble_text = Scrambler.scramble($plain_text, $window, Random.new($key))
puts "Scramble text = #{$scramble_text.inspect}"
