#A little tool to survey the Ruby environment.

#What are the core, shared CONFIG keys?
core = ["DLEXT",
        "EXEEXT",
        "LIBRUBY",
        "LIBRUBY_ALIASES",
        "LIBRUBY_SO",
        "MAJOR",
        "MINOR",
        "RUBYW_INSTALL_NAME",
        "RUBY_INSTALL_NAME",
        "SHELL",
        "TEENY",
        "arch",
        "archdir",
        "bindir",
        "build",
        "datadir",
        "exec_prefix",
        "host",
        "host_alias",
        "host_cpu",
        "host_os",
        "host_vendor",
        "includedir",
        "libdir",
        "localstatedir",
        "mandir",
        "prefix",
        "ridir",
        "ruby_install_name",
        "ruby_version",
        "rubyhdrdir",
        "rubylibdir",
        "rubylibprefix",
        "rubyw_install_name",
        "sitearch",
        "sitearchdir",
        "sitedir",
        "sitelibdir",
        "sysconfdir",
        "target",
        "target_cpu",
        "target_os",
        "topdir"]

puts
puts "RbConfig Settings:"
puts "======================================="

RbConfig::CONFIG.keys
                .sort
                .select{|k| core.include?(k)}
                .each{|k| puts "#{k.ljust(18)} => #{RbConfig::CONFIG[k].inspect}"}

puts
puts "Useful Environment Variables:"
puts "======================================="
puts "USER         => #{ENV['USER']}"         #Supported!
puts "HOSTNAME     => #{ENV['HOSTNAME']}"     #Cygwin only
puts "COMPUTERNAME => #{ENV['COMPUTERNAME']}" #Windows and JRuby
puts "OS           => #{ENV['OS']}"           #Supported?
puts "CDPATH       => #{ENV['CDPATH']}"       #None
puts "HOME         => #{ENV['HOME']}"         #Supported!
puts "SHELL        => #{ENV['SHELL']}"        #Not windows.
puts "ComSpec      => #{ENV['ComSpec']}"      #Windows only.
puts "TERM         => #{ENV['TERM']}"         #Cygwin only
puts "DISPLAY      => #{ENV['DISPLAY']}"      #None. (Maybe only true Linux?)
puts "EDITOR       => #{ENV['EDITOR']}"       #None. (Maybe only true Linux?)

