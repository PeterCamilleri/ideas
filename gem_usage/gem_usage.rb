require 'net/https'
require 'json'

target = ARGV[0]

if target
  puts "The gem #{target} is used in:"

  url = "https://rubygems.org/api/v1/gems/#{target}/reverse_dependencies.json"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  puts JSON.parse(response).sort
else
  puts "Usage: gem_usage <gem_name>"
end

