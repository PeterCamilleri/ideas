tp = TracePoint.new { |tp| p tp, tp.self }

tp.enable
puts "Hello"
tp.disable

#<TracePoint:c_return `enable'@trace/trace_puts.rb:3>
#<TracePoint:c_return `enable'@trace/trace_puts.rb:3>

#<TracePoint:line@trace/trace_puts.rb:4>
# self is main

#<TracePoint:c_call `puts'@trace/trace_puts.rb:4>
# self is main

#<TracePoint:c_call `puts'@trace/trace_puts.rb:4>
# self is #<IO:<STDOUT>>

#<TracePoint:c_call `write'@trace/trace_puts.rb:4>
# self is #<IO:<STDOUT>>
#Prints => Hello

#<TracePoint:c_return `write'@trace/trace_puts.rb:4>
# self is #<IO:<STDOUT>>

#<TracePoint:c_call `write'@trace/trace_puts.rb:4>
# self is #<IO:<STDOUT>>

#<TracePoint:c_return `write'@trace/trace_puts.rb:4>
# self is #<IO:<STDOUT>>
#Prints newline.

#<TracePoint:c_return `puts'@trace/trace_puts.rb:4>
# self is #<IO:<STDOUT>>

#<TracePoint:c_return `puts'@trace/trace_puts.rb:4>
# self is main

#<TracePoint:line@trace/trace_puts.rb:5>
# self is main

#<TracePoint:c_call `disable'@trace/trace_puts.rb:5>
#<TracePoint:c_call `disable'@trace/trace_puts.rb:5>
