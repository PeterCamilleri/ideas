require 'scanf'

def run(command)
  IO.popen(command, "r") do |io|
    io.read
  end
end

puts run('stty size').scanf("%d%d")
