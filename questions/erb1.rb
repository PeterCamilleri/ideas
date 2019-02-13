class MyTest
  def location=((filename, lineno))
    @filename = filename
    @lineno = lineno if lineno
  end

  def locatia=(filename, lineno)
    @filename = filename
    @lineno = lineno if lineno
  end
end

a = MyTest.new
a.location = "foo", 34
puts a.inspect

b = MyTest.new
b.location = "foo"
puts b.inspect

c = MyTest.new
c.locatia = "foo", 34
puts c.inspect

d = MyTest.new
d.locatia = "foo"
puts d.inspect

