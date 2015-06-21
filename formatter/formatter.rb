require 'English'
require 'PP'

# Format specifier syntax:
#
# "%" {flag}* {parm {"." parm}?}? {command}
#
# flag = { "~" | "@" | "#" | "&" | "^"  |
#          "&" | "*" | "-" | "+" | "="  |
#          "?" | "_" | "<" | ">" | "\\" |
#          "/" | "." | "," | "|"}
#
# parm = { "0" .. "9" }+
#
# command = { "a" .. "z" | "A" .. "Z"}

class FormatEngine

  attr_reader :spec_string # why? is this needed?
  attr_reader :specs

  def initialize(spec_string)
    @spec_string = spec_string
    @specs = []
    scan_spec(@spec_string, @specs)
  end

  def scan_spec(spec, specs)
    until spec == ""
      if spec =~ /%[~@#$^&*\-+=?_<>\\\/\.,\|]*(\d+(\.\d+)?)?[a-zA-Z]/
        specs << $PREMATCH
        specs << $MATCH
        spec  =  $POSTMATCH
      else
        specs << spec
        spec = ""
      end
    end
  end


end


test = FormatEngine.new "Elapsed = %*3.4H:%M:%S"

pp test.specs
