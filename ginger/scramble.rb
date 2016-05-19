#Test scrambling up some data.

module Scrambler

  def self.scramble(input_string, window, generator, filler = lambda {32 + rand(95)})
    @window    = window
    @generator = generator
    @filler    = filler
    @processed = 0

    prepare_input(input_string)

    @data      = @input[0...@window]
    @offset    = @data.length

    while @data.length < @window
      @data << @filler.call
    end

    do_scramble
  end

  #Get the data formatted for scrambling.
  def self.prepare_input(input_string)
    body    = input_string.bytes
    prefix  = "#{body.length.to_s(36)};".bytes

    @input  = prefix + body
    @length = @input.length
  end

  #Put bytes into disorder.
  def self.do_scramble
    result = []

    while @processed < @length
      index = @generator.rand(@window)
      result << @data.delete_at(index)

      @data << (@input[@offset] || @filler.call)
      @offset += 1

      @processed += 1 if (index + @processed) < @length
    end

    result.pack("C*")
  end
end

puts; puts '-' * 50; puts
#puts "Plain text = #{($plain_text = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ').inspect}"
puts "Plain text = \n#{($plain_text = IO.read("test.txt"))}"
puts; puts "Window = #{($window = 16)}"; puts "Key = #{($key = 1234567890)}"
puts; puts '-' * 50; puts
$scramble_text = Scrambler.scramble($plain_text, $window, Random.new($key))
puts "Scramble text = \n#{$scramble_text.inspect}"
