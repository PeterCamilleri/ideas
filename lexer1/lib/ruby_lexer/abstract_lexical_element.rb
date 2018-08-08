# coding: utf-8

module RubyLexer

  class AbstractLexicalElement

    puts "#{File.basename(__FILE__)} > #{self.inspect}"

    def initialize
      # WIP
    end

    #Get the sequential sub-elements of this element.
    def sequential
      [self]
    end

    #Get the alternative sub-elements of this element
    def alternatives
      [self]
    end

  end

end
