require "benchmark/ips"

module EmptyArray
  def self.include?(_args)
    false
  end
end

class Object

  def full_dup1_exclude
    []
  end

  #The full_dup method for most objects.
  def full_dup1(progress={})
    progress[object_id] = result = dup
    exclude = full_dup1_exclude

    instance_variables.each do |name|
      unless exclude.include?(name)
        value = result.instance_variable_get(name)
        value = progress[value.object_id] || value.full_dup1(progress)
        result.instance_variable_set(name, value)
      end
    end

    result
  end



  def full_dup2_exclude
    []
  end

  #The full_dup method for most objects.
  def full_dup2(progress={})
    progress[object_id] = result = dup
    exclude = full_dup2_exclude

    if exclude.empty?
      instance_variables.each do |name|
        value = result.instance_variable_get(name)
        value = progress[value.object_id] || value.full_dup2(progress)
        result.instance_variable_set(name, value)
      end
    else
      instance_variables.each do |name|
        unless exclude.include?(name)
          value = result.instance_variable_get(name)
          value = progress[value.object_id] || value.full_dup2(progress)
          result.instance_variable_set(name, value)
        end

      end
    end

    result
  end



  def full_dup3_exclude
    EmptyArray
  end

  #The full_dup method for most objects.
  def full_dup3(progress={})
    progress[object_id] = result = dup
    exclude = full_dup3_exclude

    instance_variables.each do |name|
      unless exclude.include?(name)
        value = result.instance_variable_get(name)
        value = progress[value.object_id] || value.full_dup3(progress)
        result.instance_variable_set(name, value)
      end
    end

    result
  end

end


class Array

  #The full_dup method for arrays.
  def full_dup1(progress={})
    progress[object_id] = result = dup
    exclude = full_dup1_exclude

    each_index do |name|
      unless exclude.include?(name)
        value = result[name]
        value = progress[value.object_id] || value.full_dup1(progress)
        result[name] = value
      end
    end

    result
  end

  #The full_dup method for arrays.
  def full_dup2(progress={})
    progress[object_id] = result = dup
    exclude = full_dup2_exclude

    if exclude.empty?
      each_index do |name|
        value = result[name]
        value = progress[value.object_id] || value.full_dup2(progress)
        result[name] = value
      end
    else
      each_index do |name|
        unless exclude.include?(name)
          value = result[name]
          value = progress[value.object_id] || value.full_dup2(progress)
          result[name] = value
        end
      end
    end

    result
  end
  

  #The full_dup method for arrays.
  def full_dup3(progress={})
    progress[object_id] = result = dup
    exclude = full_dup3_exclude

    each_index do |name|

      unless exclude.include?(name)
        value = result[name]
        value = progress[value.object_id] || value.full_dup3(progress)
        result[name] = value
      end

    end

    result
  end



end

$test_subject = Array.new(10) { "abcd" }



def use_full_dup1
  1000.times { temp = $test_subject.full_dup1 }
end

def use_full_dup2
  1000.times { temp = $test_subject.full_dup2 }
end

def use_full_dup3
  1000.times { temp = $test_subject.full_dup3 }
end


Benchmark.ips do |x|
  x.report("use_full_dup1")  { use_full_dup1 }
  x.report("use_full_dup2")  { use_full_dup2 }
  x.report("use_full_dup3")  { use_full_dup3 }
  x.compare!
end

