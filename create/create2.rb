#Investigate how classes are created.

class BassClass
  def initialize
    puts "BassClass - initialize"
  end
end

class CaseStudy < BassClass
  def initialize
    puts "CaseStudy - first initialize"
    super
  end

  old_initialize = instance_method(:initialize)

  define_method(:initialize) do |*args|
    puts "CaseStudy - second initialize"
    puts old_initialize.bind(self).call(*args)
  end


  def party_time
  end

end

CaseStudy.new
