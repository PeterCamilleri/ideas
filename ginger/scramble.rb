#Test scrambling up some data.

module Scrambler

  def self.scramble(input_string, window, generator, filler = lambda {32 + rand(95)})
    @window    = window
    @generator = generator
    @filler    = filler
    @processed = 0

    prepare_input(input_string)
    do_scramble
  end

  #Get the data formatted for scrambling.
  def self.prepare_input(input_string)
    body    = input_string.bytes
    @input  = "#{body.length.to_s(36)};".bytes + body
    @length = @input.length
    @data   = @input[0...@window]
    @offset = @data.length

    while @data.length < @window
      @data << @filler.call
    end
  end

  #Put bytes into disorder.
  def self.do_scramble
    result = []

    while @processed < @length
      index = @generator.rand(@window)
      result << (@data.delete_at(index) ^ @generator.rand(256))

      @data << (@input[@offset] || @filler.call)
      @offset += 1

      @processed += 1 if (index + @processed) < @length
    end

    result.pack("C*")
  end
end

puts; puts '-' * 50; puts
puts "Plain text = \n#{($plain_text = IO.read("test.txt"))}"
puts; puts "Window = #{($window = 16)}";
puts "Key = #{($key = 'BB6AFB1C2D1E6F8E32DDAF1331677'.to_i(16))}"
puts; puts '-' * 50; puts
$scramble_text = Scrambler.scramble($plain_text, $window, Random.new($key))
puts "Cypher text = \n#{$scramble_text.inspect}"
