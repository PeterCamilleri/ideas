# Get the raw data from rubygems.org
#
# Peter Camilleri, August 11, 2017
#

require 'net/http'
require 'json'

class GemSurvey

  # Get the raw info on each version of the gem.
  def get_raw_gem_info(gem_name)
    url = "https://rubygems.org/api/v1/versions/#{gem_name}.json"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  # Get download counts by version for a gem.
  def get_gem_info(gem_name)
    get_raw_gem_info(gem_name).map {|info| info["downloads_count"].to_i}
  end

  # Get download counts by version for each gem.
  def get_gem_list_info
    @input.map do |gem_name|
      [gem_name] + get_gem_info(gem_name)
    end
  end
end
