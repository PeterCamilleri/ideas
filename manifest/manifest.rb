
# Get a Version Manifest.

require 'fOOrth'

mods = ObjectSpace.each_object(Module).select {|c| c.const_defined?("VERSION") }

width = (mods.max_by{|m| m.to_s.length}).to_s.length

list = mods.map do |m|
  "#{m.to_s.ljust(width)} #{m.const_get(:VERSION)}"
end

puts list.sort
