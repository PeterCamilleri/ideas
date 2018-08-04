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

  def full_dup5_exclude
    nil
  end

  #The full_dup method for most objects.
  def full_dup5(progress={})
    progress[object_id] = result = dup
    exclude = full_dup5_exclude

    instance_variables.each do |name|
      unless exclude && exclude.include?(name)
        value = result.instance_variable_get(name)
        value = progress[value.object_id] || value.full_dup5(progress)
        result.instance_variable_set(name, value)
      end
    end

    result
  end

  def full_dup6_exclude
    nil
  end

  #The full_dup method for most objects.
  def full_dup6(progress={})
    progress[object_id] = result = dup
    exclude = full_dup6_exclude

    if exclude
      instance_variables.each do |name|
        unless exclude.include?(name)
          value = result.instance_variable_get(name)
          value = progress[value.object_id] || value.full_dup5(progress)
          result.instance_variable_set(name, value)
        end
      end
    else
      instance_variables.each do |name|
        value = result.instance_variable_get(name)
        value = progress[value.object_id] || value.full_dup5(progress)
        result.instance_variable_set(name, value)
      end
    end

    result
  end

  def full_dup7_exclude
    nil
  end

  #The full_dup method for most objects.
  def full_dup7(progress={})
    progress[object_id] = result = dup
    exclude = full_dup7_exclude

    instance_variables.each do |name|
      unless exclude&.include?(name)
        value = result.instance_variable_get(name)
        value = progress[value.object_id] || value.full_dup7(progress)
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

  #The full_dup method for most objects.
  def full_dup5(progress={})
    progress[object_id] = result = dup
    exclude = full_dup5_exclude

    each_index do |name|
      unless exclude && exclude.include?(name)
        value = result[name]
        value = progress[value.object_id] || value.full_dup5(progress)
        result[name] = value
      end
    end

    result
  end

  #The full_dup method for most objects.
  def full_dup6(progress={})
    progress[object_id] = result = dup
    exclude = full_dup7_exclude

    if exclude
      each_index do |name|
        unless exclude.include?(name)
          value = result[name]
          value = progress[value.object_id] || value.full_dup7(progress)
          result[name] = value
        end
      end
    else
      each_index do |name|
        value = result[name]
        value = progress[value.object_id] || value.full_dup7(progress)
        result[name] = value
      end
    end

    result
  end


  #The full_dup method for most objects.
  def full_dup7(progress={})
    progress[object_id] = result = dup
    exclude = full_dup7_exclude

    each_index do |name|
      unless exclude&.include?(name)
        value = result[name]
        value = progress[value.object_id] || value.full_dup7(progress)
        result[name] = value
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

  def full_dup5(progress={})
    self
  end

  def full_dup6(progress={})
    self
  end

  def full_dup7(progress={})
    self
  end

end

class String
  def full_dup2(progress={})
    dup
  end

  def full_dup3(progress={})
    dup
  end

  def full_dup4(progress={})
    dup
  end

  def full_dup5(progress={})
    dup
  end

  def full_dup6(progress={})
    dup
  end

  def full_dup7(progress={})
    dup
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

def use_full_dup5
  1000.times { temp = $test_subject.full_dup5 }
end

def use_full_dup6
  1000.times { temp = $test_subject.full_dup6 }
end

def use_full_dup7
  1000.times { temp = $test_subject.full_dup7 }
end

Benchmark.ips do |x|
  x.report("use_full_dup1")  { use_full_dup1 }
  x.report("use_full_dup2")  { use_full_dup2 }
  x.report("use_full_dup3")  { use_full_dup3 }
  x.report("use_full_dup4")  { use_full_dup4 }
  x.report("use_full_dup5")  { use_full_dup5 }
  x.report("use_full_dup6")  { use_full_dup6 }
  x.report("use_full_dup7")  { use_full_dup7 }
  x.compare!
end

# mysh>ruby faster_full_dup.rb
# Warming up --------------------------------------
#        use_full_dup1     1.000  i/100ms
#        use_full_dup2     1.000  i/100ms
#        use_full_dup3     1.000  i/100ms
#        use_full_dup4     1.000  i/100ms
#        use_full_dup5     1.000  i/100ms
#        use_full_dup6     1.000  i/100ms
#        use_full_dup7     1.000  i/100ms
# Calculating -------------------------------------
#        use_full_dup1      6.077  (± 0.0%) i/s -     31.000  in   5.101499s
#        use_full_dup2     10.775  (± 0.0%) i/s -     54.000  in   5.011740s
#        use_full_dup3      9.842  (± 0.0%) i/s -     50.000  in   5.080405s
#        use_full_dup4     10.764  (± 0.0%) i/s -     54.000  in   5.016970s
#        use_full_dup5     10.603  (± 0.0%) i/s -     54.000  in   5.093140s
#        use_full_dup6     10.724  (± 0.0%) i/s -     54.000  in   5.035648s
#        use_full_dup7     10.532  (± 0.0%) i/s -     53.000  in   5.032138s
#
# Comparison:
#        use_full_dup2:       10.8 i/s
#        use_full_dup4:       10.8 i/s - 1.00x  slower
#        use_full_dup6:       10.7 i/s - 1.00x  slower
#        use_full_dup5:       10.6 i/s - 1.02x  slower
#        use_full_dup7:       10.5 i/s - 1.02x  slower
#        use_full_dup3:        9.8 i/s - 1.09x  slower
#        use_full_dup1:        6.1 i/s - 1.77x  slower
