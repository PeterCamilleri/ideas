#Experiment with putting array (or hash) data into bullet points.

class BulletPoints
  #Prepare a blank slate.
  def initialize(page_width)
    @page_width, @bullet_data = page_width, []
  end

  #Add an item to this page.
  #<br>Returns
  #* The number if items that did not fit in the page.
  def add(raw_bullet = "*", raw_item)
    bullet = raw_bullet.to_s
    item = raw_item.to_s
    @bullet_data << [bullet, item]
  end

  #Render the page as an array of strings.
  def render
    @key_length, results = get_key_length, []

    @bullet_data.each do |key, item|
      results.concat(render_bullet(key, item))
    end

    @bullet_data = []
    results
  end

  private

  #How large is the largest bullet?
  def get_key_length
    (@bullet_data.max_by {|line| line[0].length})[0].length
  end

  #Render one bullet point.
  def render_bullet(key, item)
    result = []
    input  = item.split(' ').each
    temp   = key.ljust(len = @key_length)

    loop do
      word = ' ' + input.next

      if (len += word.length) >= @page_width
        result << temp
        temp = (' ' * @key_length) + word
        len  = temp.length
      else
        temp << word
      end
    end

    result << temp
  end
end

class Array
  #Print out the array as bullet points.
  def puts_bullets(page_width = 80)
    puts self.bulletize(page_width)
  end

  #Convert the array to strings with bullet points.
  #<br>
  #* An array of arrays of strings
  def bulletize(page_width)
    builder = BulletPoints.new(page_width)

    self.each do |pair|
      builder.add(*pair)
    end

    builder.render
  end
end

class Hash
  #Print out the hash as bullet points.
  def puts_bullets(page_width = 80)
    puts self.bulletize(page_width)
  end

  #Convert the hash to strings with bullet points.
  #<br>
  #* An array of arrays of strings
  def bulletize(page_width)
    builder = BulletPoints.new(page_width)

    self.each do |key, value|
      builder.add(key, value)
    end

    builder.render
  end
end

#Build a sample array.
gen = Random.new
count = 10 + gen.rand(10) + gen.rand(10)
scale = 20 + gen.rand(20) + gen.rand(20) * gen.rand(20)

test_array = Array.new(count) do |i|
  [i*scale, (0...gen.rand(1..40)).map{|i| "*" * gen.rand(1..12)}.join(" ")]
end

#Display test_array in neat columns
puts "Array"
test_array.puts_bullets

puts
puts
puts

#Build a sample hash.
test_hash = {}

count.times do |i|
  test_hash[i*scale] = (0...gen.rand(1..40)).map{|i| "*" * gen.rand(1..12)}.join(" ")
end

puts "Hash"
test_hash.puts_bullets
