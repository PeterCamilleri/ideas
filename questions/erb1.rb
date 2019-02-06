
class MyTest

  def location=((filename, lineno))
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


