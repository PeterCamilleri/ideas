# Get command line args for the gem survey.
#
# Peter Camilleri, August 11, 2017
#

require 'getoptlong'

class GemSurvey
  # Process the survey command line options.
  def process_args
    set_default_args

    opts = GetoptLong.new(
        [ "--help",  "-h", "-?", GetoptLong::NO_ARGUMENT ],
        [ "--quiet", "-q",       GetoptLong::NO_ARGUMENT ],
        [ "--out",   "-o",       GetoptLong::REQUIRED_ARGUMENT ],
        [ "--gem",   "-g",       GetoptLong::REQUIRED_ARGUMENT ],
        [ "--list",  "-l",       GetoptLong::REQUIRED_ARGUMENT ])

    opts.each do |opt, arg|
      case opt
      when "--help"
        fail "Help!"
      when "--quiet"
        @quiet = true
      when "--out"
        @output = arg
      when "--gem"
        @input << arg
      when "--list"
        @input += IO.read(arg).split
      end
    end

    rescue => err
      puts
      puts err.to_s

      exit
  end


  # Set the default survey options.
  def set_default_args
    @quiet = false
    @input = []
    @output = 'a.csv'
  end

end
