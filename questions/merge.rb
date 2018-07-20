require 'pp'

hash1 = {"a" => {"b" => {}, "c" => {}}, "d" => {"e" => {}}}
hash2 = {"a" => {"b" => {"x" => "y"}, "z" => 1}}

final_hash = {"a" => {"b" => {"x" => "y"}, "c" => {}}, "d" => {"e" => {}}}

puts
pp hash1
pp hash2

class Hash

  def mittal_merge(source)
    result = {}

    keys.each do |key|
      value = {}

      self[key].keys.each do |sub_key|
        value[sub_key] = (source[key] || {})[sub_key] || {}
      end

      result[key] = value
    end

    result
  end


end

puts
pp final_hash
pp hash1.mittal_merge(hash2)
