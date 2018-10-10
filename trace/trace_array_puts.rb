tp = TracePoint.new { |tp| p tp, tp.self }

tp.enable
puts ["1", "2", "3"]
tp.disable

#<TracePoint:c_return `enable'@trace/trace_array_puts.rb:3>
#<TracePoint:c_return `enable'@trace/trace_array_puts.rb:3>


#<TracePoint:line@trace/trace_array_puts.rb:4>
#self is main

#<TracePoint:c_call `puts'@trace/trace_array_puts.rb:4>
#self is main

#---------------------------------------------------------------

#<TracePoint:c_call `puts'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>

#<TracePoint:c_call `write'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>
#output is 1

#<TracePoint:c_return `write'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>

#<TracePoint:c_call `write'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>
#output is a newline

#<TracePoint:c_return `write'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>

#<TracePoint:c_call `write'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>
#output is 2

#<TracePoint:c_return `write'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>

#<TracePoint:c_call `write'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>
#output is a newline

#<TracePoint:c_return `write'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>

#<TracePoint:c_call `write'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>
#output is 3

#<TracePoint:c_return `write'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>

#<TracePoint:c_call `write'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>
#output is a newline

#<TracePoint:c_return `write'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>

#<TracePoint:c_return `puts'@trace/trace_array_puts.rb:4>
#self is #<IO:<STDOUT>>

#---------------------------------------------------------------

#<TracePoint:c_return `puts'@trace/trace_array_puts.rb:4>
#self is main

#<TracePoint:line@trace/trace_array_puts.rb:5>
#self is main


#<TracePoint:c_call `disable'@trace/trace_array_puts.rb:5>
#<TracePoint:c_call `disable'@trace/trace_array_puts.rb:5>
