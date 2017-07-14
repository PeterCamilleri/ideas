class Object
  def reverse_rek
    self
  end
end

class Array
  def reverse_rek
    reverse.map{|element| element.reverse_rek }
  end
end
