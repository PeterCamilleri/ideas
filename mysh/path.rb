# Test out path searching ideas.

path = ENV['PATH'].split(File::PATH_SEPARATOR).uniq

path.each do |folder|
  puts folder, Dir.entries(folder).select {|file| file[".com"] || file[".bat"] || file[".exe"]}


end


