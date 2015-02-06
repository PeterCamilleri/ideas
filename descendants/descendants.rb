# A class descendants explorer.

class Class
  def all_descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def direct_descendants
    ObjectSpace.each_object(Class).select { |klass| klass.superclass == self }
  end
end

def create_ordered_class_list(classes)
  classes.sort {|a,b| a.to_s <=> b.to_s}
end

def display_class_tree(klass, depth=0)
  puts "#{' '* depth}#{klass.to_s}"

  create_ordered_class_list(klass.direct_descendants).each do |subklass|
    display_class_tree(subklass, depth+2)
  end
end

def show_full_class_tree
  display_class_tree(BasicObject)
end

show_full_class_tree