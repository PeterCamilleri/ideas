require 'pp'

def actuall_latest_version_for(name, matching_platform=true)
  spec = actuall_latest_spec_for(name, matching_platform)
  spec and spec.version
end

def actuall_latest_spec_for(name, matching_platform=true)
  actuall_specs_for(name, matching_platform)[-1]
end

def actuall_specs_for(name, matching_platform=true)
  dependency    = Gem::Dependency.new(name)
  fetcher       = Gem::SpecFetcher.fetcher
  specs, errors = fetcher.spec_for_dependency(dependency)

  specs.map { |s| s[0] }
end

def show_specs(name)
  puts
  puts name

  pp actuall_specs_for(name).map {|s| [s.version.to_s, s.platform.to_s] }
  pp actuall_latest_version_for(name)
end

show_specs('rails')
show_specs('mysh')
show_specs('gosu')
show_specs('goasdfsu')


# # File rubygems.rb, line 837
# def self.latest_version_for name
#   spec = latest_spec_for name
#   spec and spec.version
# end
#
# # File rubygems.rb, line 816
# def self.latest_spec_for name
#   dependency   = Gem::Dependency.new name
#   fetcher      = Gem::SpecFetcher.fetcher
#   spec_tuples, = fetcher.spec_for_dependency dependency
#
#   spec, = spec_tuples.first
#
#   spec
# end
#
#
# # File rubygems/spec_fetcher.rb, line 165
# def spec_for_dependency(dependency, matching_platform=true)
#   tuples, errors = search_for_dependency(dependency, matching_platform)
#
#   specs = []
#   tuples.each do |tup, source|
#     begin
#       spec = source.fetch_spec(tup)
#     rescue Gem::RemoteFetcher::FetchError => e
#       errors << Gem::SourceFetchProblem.new(source, e)
#     else
#       specs << [spec, source]
#     end
#   end
#
#   return [specs, errors]
# end
#
#
# # File rubygems/spec_fetcher.rb, line 85
# def search_for_dependency(dependency, matching_platform=true)
#   found = {}
#
#   rejected_specs = {}
#
#   if dependency.prerelease?
#     if dependency.specific?
#       type = :complete
#     else
#       type = :abs_latest
#     end
#   elsif dependency.latest_version?
#     type = :latest
#   else
#     type = :released
#   end
#
#   list, errors = available_specs(type)
#   list.each do |source, specs|
#     if dependency.name.is_a?(String) && specs.respond_to?(:bsearch)
#       start_index = (0 ... specs.length).bsearch{ |i| specs[i].name >= dependency.name }
#       end_index   = (0 ... specs.length).bsearch{ |i| specs[i].name > dependency.name }
#       specs = specs[start_index ... end_index] if start_index && end_index
#     end
#
#     found[source] = specs.select do |tup|
#       if dependency.match?(tup)
#         if matching_platform and !Gem::Platform.match(tup.platform)
#           pm = (
#             rejected_specs[dependency] ||= \
#               Gem::PlatformMismatch.new(tup.name, tup.version))
#           pm.add_platform tup.platform
#           false
#         else
#           true
#         end
#       end
#     end
#   end
#
#   errors += rejected_specs.values
#
#   tuples = []
#
#   found.each do |source, specs|
#     specs.each do |s|
#       tuples << [s, source]
#     end
#   end
#
#   tuples = tuples.sort_by { |x| x[0] }
#
#   return [tuples, errors]
# end



# 31: =dependency = Gem::Dependency.new('gosu')
# 33: =fetcher = Gem::SpecFetcher.fetcher
# 35: =specs = fetcher.spec_for_dependency(dependency)[0]
# 48: =specs.map {|s| [s[0].version.to_s, s[0].platform.to_s]}
# [
#  ["0.7.38", "x86-mingw32"],
#  ["0.14.4", "ruby"],
#  ["0.14.4", "x86-mingw32"]
# ]

# [["0.7.38", "x86-mingw32"], ["0.14.4", "ruby"], ["0.14.4", "x86-mingw32"]]

# RubyGems platforms are composed of three parts, a CPU, an OS, and a
# version.  These values are taken from values in rbconfig.rb.  You can view
# your current platform by running `gem environment`.
#
# RubyGems matches platforms as follows:
#
#   * The CPU must match exactly unless one of the platforms has
#     "universal" as the CPU or the local CPU starts with "arm" and the gem's
#     CPU is exactly "arm" (for gems that support generic ARM architecture).
#   * The OS must match exactly.
#   * The versions must match exactly unless one of the versions is nil.
#
# For commands that install, uninstall and list gems, you can override what
# RubyGems thinks your platform is with the --platform option.  The platform
# you pass must match "#{cpu}-#{os}" or "#{cpu}-#{os}-#{version}".  On mswin
# platforms, the version is the compiler version, not the OS version.  (Ruby
# compiled with VC6 uses "60" as the compiler version, VC8 uses "80".)
#
# For the ARM architecture, gems with a platform of "arm-linux" should run on a
# reasonable set of ARM CPUs and not depend on instructions present on a limited
# subset of the architecture.  For example, the binary should run on platforms
# armv5, armv6hf, armv6l, armv7, etc.  If you use the "arm-linux" platform
# please test your gem on a variety of ARM hardware before release to ensure it
# functions correctly.
#
# Example platforms:
#
#   x86-freebsd        # Any FreeBSD version on an x86 CPU
#   universal-darwin-8 # Darwin 8 only gems that run on any CPU
#   x86-mswin32-80     # Windows gems compiled with VC8
#   armv7-linux        # Gem complied for an ARMv7 CPU running linux
#   arm-linux          # Gem compiled for any ARM CPU running linux
#
# When building platform gems, set the platform in the gem specification to
# Gem::Platform::CURRENT.  This will correctly mark the gem with your ruby's
# platform.

# 21 mysh>=spec_tuples[0][0]
# Gem::Specification.new do |s|
#   s.name = "gosu"
#   s.version = Gem::Version.new("0.7.38")
#   s.installed_by_version = Gem::Version.new("0")
#   s.authors = ["Julian Raschke"]
#   s.date = Time.utc(2011, 10, 28)
#   s.description = "  2D game development library. Etc, etc, etc"
#   s.email = "julian@raschke.de"
#   s.homepage = "http://libgosu.org/"
#   s.metadata = nil
#   s.platform = #<Gem::Platform:0x1a176e0 @cpu="x86", @os="mingw32", @version=nil>
#   s.require_paths = ["lib"]
#   s.required_ruby_version = Gem::Requirement.new([">= 1.8.2"])
#   s.rubygems_version = "1.8.9"
#   s.specification_version = 3
#   s.summary = "2D game development library."
#   end

