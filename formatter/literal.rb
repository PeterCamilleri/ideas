# A format engine literal specification.

class FormatLiteral

  attr_reader :literal

  def initialize(literal)
    @literal = literal
  end

  def inspect
    "Literal(#{literal.inspect})"
  end

end
