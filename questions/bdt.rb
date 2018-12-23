require 'bytesize'

t = ByteSize.new(1210000000)  #=> (1.21 GB)

puts t

t = ByteSize.new("1.1269 GiB")  #=> (1.21 GB)

puts t
