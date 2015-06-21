# A format engine literal specification.

class FormatVariable

  attr_reader :format
  attr_reader :parms

  def initialize(format)
    if format =~ /(\d+(\.\d+)?)/
      @format = $PREMATCH + $POSTMATCH

      if (digits = $MATCH) =~ /\./
        @parms = [$PREMATCH, $POSTMATCH]
      else
        @parms = [digits]
      end

    else
      @parms  = nil
      @format = format
    end
  end

  def inspect
    "Variable(#{format.inspect}, #{parms.inspect})"
  end

end
