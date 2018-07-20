require "benchmark/ips"

module EmptyArray
  def self.include?(_args)
    false
  end
end


def normal_empty
  1000.times { |x| [].include?(x) }
end

def special_empty
  1000.times { |x| EmptyArray.include?(x) }
end

Benchmark.ips do |x|
  x.report("Use [] empty array")  { normal_empty }
  x.report("Use EmptyArray")      { special_empty }
  x.compare!
end

