require "benchmark/ips"

module EmptyArray
  def self.include?(_args)
    false
  end

  def self.empty?
    true
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

  def full_dup4_exclude
    EmptyArray
  end

  #The full_dup method for most objects.
  def full_dup4(progress={})
    progress[object_id] = result = dup
    exclude = full_dup4_exclude

    if exclude.empty?
      instance_variables.each do |name|
        value = result.instance_variable_get(name)
        value = progress[value.object_id] || value.full_dup4(progress)
        result.instance_variable_set(name, value)
      end
    else
      instance_variables.each do |name|
        unless exclude.include?(name)
          value = result.instance_variable_get(name)
          value = progress[value.object_id] || value.full_dup4(progress)
          result.instance_variable_set(name, value)
        end

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

  #The full_dup method for arrays.
  def full_dup4(progress={})
    progress[object_id] = result = dup
    exclude = full_dup4_exclude

    if exclude.empty?
      each_index do |name|
        value = result[name]
        value = progress[value.object_id] || value.full_dup4(progress)
        result[name] = value
      end
    else
      each_index do |name|
        unless exclude.include?(name)
          value = result[name]
          value = progress[value.object_id] || value.full_dup4(progress)
          result[name] = value
        end
      end
    end

    result
  end


end

class Numeric

  def full_dup1(progress={})
    self
  end

  def full_dup2(progress={})
    self
  end

  def full_dup3(progress={})
    self
  end

  def full_dup4(progress={})
    self
  end
end

$test_subject = (Array.new(100) { "abcd" }) + Array.new(100, 1)



def use_full_dup1
  1000.times { temp = $test_subject.full_dup1 }
end

def use_full_dup2
  1000.times { temp = $test_subject.full_dup2 }
end

def use_full_dup3
  1000.times { temp = $test_subject.full_dup3 }
end

def use_full_dup4
  1000.times { temp = $test_subject.full_dup4 }
end

Benchmark.ips do |x|
  x.report("use_full_dup1")  { use_full_dup1 }
  x.report("use_full_dup2")  { use_full_dup2 }
  x.report("use_full_dup3")  { use_full_dup3 }
  x.report("use_full_dup4")  { use_full_dup4 }
  x.compare!
end


# mysh>ruby faster_full_dup.rb
# Warming up --------------------------------------
#        use_full_dup1     1.000  i/100ms
#        use_full_dup2     1.000  i/100ms
#        use_full_dup3     1.000  i/100ms
#        use_full_dup4     1.000  i/100ms
# Calculating -------------------------------------
#        use_full_dup1      6.041  (± 0.0%) i/s -     31.000  in   5.131640s
#        use_full_dup2      6.490  (± 0.0%) i/s -     33.000  in   5.084455s
#        use_full_dup3      6.098  (± 0.0%) i/s -     31.000  in   5.083972s
#        use_full_dup4      6.504  (± 0.0%) i/s -     33.000  in   5.073597s
#
# Comparison:
#        use_full_dup4:        6.5 i/s
#        use_full_dup2:        6.5 i/s - 1.00x  slower
#        use_full_dup3:        6.1 i/s - 1.07x  slower
#        use_full_dup1:        6.0 i/s - 1.08x  slower
