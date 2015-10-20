require 'English'
require 'PP'

require_relative 'literal'
require_relative 'variable'

# Format Specification Syntax (BNF):
#
# spec = { text | item }+
#
# item = "%" {flag}* {parm {"." parm}?}? {command}
#
# flag = { "~" | "@" | "#" | "&" | "^"  |
#          "&" | "*" | "-" | "+" | "="  |
#          "?" | "_" | "<" | ">" | "\\" |
#          "/" | "." | "," | "|" }
#
# parm = { "0" .. "9" }+
#
# command = { "a" .. "z" | "A" .. "Z"}

class FormatSpec

  @spec_pool = {}

  # Don't use new, use get_spec instead.
  private_class_method :new

  def self.get_spec(fmt_string)
    @spec_pool[fmt_string] ||= new(fmt_string)
  end

  attr_reader :spec

  def initialize(fmt_string)
    @spec = []
    scan_spec(fmt_string, @spec)
  end

  def scan_spec(fmt_string, spec_array)
    until fmt_string == ""
      if fmt_string =~ /%[~@#$^&*\-+=?_<>\\\/\.,\|]*(\d+(\.\d+)?)?[a-zA-Z]/
        spec_array << FormatLiteral.new($PREMATCH)
        spec_array << FormatVariable.new($MATCH)
        fmt_string  =  $POSTMATCH
      else
        spec_array << FormatLiteral.new(fmt_string)
        fmt_string = ""
      end
    end
  end

end

spec = "Elapsed = %*03.1H:%M:%S!"
test = FormatSpec.get_spec spec

puts "Specification for #{spec.inspect} is"
pp test.spec

