require 'irb'

class Object

  def help(*args)
    puts "Help on #{args}"
    puts
  end

  def run(*args)
    puts "Run #{args}"
    puts
  end

  LESSONS = [:lesson_00, :lesson_01, :lesson_02, :lesson_03, :lesson_04]

  def method_missing(symbol, *args, &block)

    if LESSONS.include?(symbol)
      puts caller
      puts "Symbol = #{symbol.inspect}, " +
           "Args = #{args.inspect}"

      symbol.to_s
    else
      super
    end
  end

end

ARGV.clear
IRB.start

