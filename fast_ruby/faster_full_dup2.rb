require "benchmark/ips"

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

end

class Numeric

  def full_dup1(progress={})
    self
  end

  def full_dup2(progress=nil)
    self
  end

end

class String
  def full_dup2(progress=nil)
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

Benchmark.ips do |x|
  x.report("use_full_dup1")  { use_full_dup1 }
  x.report("use_full_dup2")  { use_full_dup2 }
  x.compare!
end


# Warming up --------------------------------------
#        use_full_dup1     1.000  i/100ms
#        use_full_dup2     1.000  i/100ms
# Calculating -------------------------------------
#        use_full_dup1      5.056  (± 0.0%) i/s -     26.000  in   5.144658s
#        use_full_dup2      9.286  (± 0.0%) i/s -     47.000  in   5.068812s
#
# Comparison:
#        use_full_dup2:        9.3 i/s
#        use_full_dup1:        5.1 i/s - 1.84x  slower
#
