require 'English'
require 'PP'

require_relative 'literal'
require_relative 'variable'


# Format specifier syntax (BNF):
#
# "%" {flag}* {parm {"." parm}?}? {command}
#
# flag = { "~" | "@" | "#" | "&" | "^"  |
#          "&" | "*" | "-" | "+" | "="  |
#          "?" | "_" | "<" | ">" | "\\" |
#          "/" | "." | "," | "|" }
#
# parm = { "0" .. "9" }+
#
# command = { "a" .. "z" | "A" .. "Z"}

class FormatEngine

  @motor_pool = {}

  private_class_method :new

  def self.get_engine(spec)
    @motor_pool[spec] ||= new(spec)
  end

  attr_reader :spec   # Why is this needed? Debug? Maybe?
  attr_reader :engine

  def initialize(spec)
    @spec = spec
    @engine = []
    scan_spec(@spec, @engine)
  end

  def scan_spec(spec_string, engine_array)
    until spec_string == ""
      if spec_string =~ /%[~@#$^&*\-+=?_<>\\\/\.,\|]*(\d+(\.\d+)?)?[a-zA-Z]/
        engine_array << FormatLiteral.new($PREMATCH)
        engine_array << FormatVariable.new($MATCH)
        spec_string  =  $POSTMATCH
      else
        engine_array << FormatLiteral.new(spec)
        spec_string = ""
      end
    end
  end

end


test = FormatEngine.get_engine "Elapsed = %*03.4H:%M:%S"

pp test.engine

