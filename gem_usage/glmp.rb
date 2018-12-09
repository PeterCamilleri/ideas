# The latest_spec_for(name) monkey patch.

module Gem

  # Originally in  File rubygems.rb at line 816
  def self.latest_spec_for(name)
    dependency   = Gem::Dependency.new(name)
    fetcher      = Gem::SpecFetcher.fetcher
    fetcher.spec_for_dependency(dependency)[0][-1][0]
  end

end
