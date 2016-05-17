#Test scrambling up some data.

module Scrambler

  def self.scramble(input_string, window, generator, filler=Random.new)
    @window = window
    @generator = generator
    @filler    = filler
    @processed = 0
    prepare_input(input_string)
    do_scramble
  end

  #Get the data formatted for scrambling.
  def self.prepare_input(input_string)
    body    = input_string.bytes
    prefix  = "#{body.length.to_s(36)};".bytes
    suffix  = Array.new(@generator.rand(@window)) { generate_padding }

    @input  = prefix + body + suffix
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

    result.pack("C*")
  end

  def self.top_up
    while @input.length < @window
      @input << generate_padding
    end
  end

  def self.generate_padding
    32 + @filler.rand(95)
  end
end

puts; puts '-' * 50; puts
#puts "Plain text = #{($plain_text = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ').inspect}"
puts "Plain text = \n#{($plain_text = IO.read("test.txt"))}"
puts; puts "Window = #{($window = 16)}"; puts "Key = #{($key = 1234567890)}"
puts; puts '-' * 50; puts
$scramble_text = Scrambler.scramble($plain_text, $window, Random.new($key))
puts "Scramble text = \n#{$scramble_text}"
