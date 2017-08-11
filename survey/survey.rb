# Get gem downloads by version and create a CSV file for study and graphing.
#
# Peter Camilleri, August 11, 2017
#

require_relative 'version'
require_relative 'survey_args'
require_relative 'gem_info'

class GemSurvey
  # Display the start-up messages for the survey.
  def announcements
    unless @quiet
      puts "Gem Survey Version #{VERSION}"
    end
  end

  # Run the gem survey.
  def run
    process_args
    announcements
    results = get_gem_list_info.map {|gem| gem.join(",")}.join("\n")
    IO.write(@output, results)
  end

end

GemSurvey.new.run
