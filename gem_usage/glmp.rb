# The latest_spec_for(name) monkey patch.

module Gem

  # Originally in  File rubygems.rb at line 816
  def self.latest_spec_for(name)
    dependency   = Gem::Dependency.new name
    fetcher      = Gem::SpecFetcher.fetcher
    spec_tuples, = fetcher.spec_for_dependency dependency

    spec_tuples[-1][0]
  end

end
