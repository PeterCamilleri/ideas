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

  alias_method(:old_init, :initialize)

  def initialize
    puts "CaseStudy - second initialize"
    old_init
  end


  def party_time
  end

end

CaseStudy.new
