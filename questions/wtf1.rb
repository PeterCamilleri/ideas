ruby_block "immutable_resolv" do
       block do
               r = Chef::Resource::Execute.new("attr settings")
               r.command "/usr/bin/chattr +i /etc/resolv.conf"
               r.run_action(:create)
       end
       only_if { ::File.exist?('/etc/resolv.conf') }
end

