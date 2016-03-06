
# Get a Version Manifest.

require 'mini_readline'


mods =  ObjectSpace.each_object(Module).select {|c| c.const_defined?("VERSION") }

width = (mods.max {|m| m.to_s.length}).to_s.length

puts mods.map {|m| "#{m.to_s.ljust(width)} #{m.const_get(:VERSION)}" }
