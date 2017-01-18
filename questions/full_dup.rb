require 'full_dup'

hash_of_array = { a: [] }
b = hash_of_array.full_dup
c = hash_of_array.full_dup

b[:a] << 1

puts b # => { a: [1] }
puts c # => { a: [] }

