
require 'erb'

x = 42
src = <<-EOF
  So now we can begin
  <% 10.times { |i| %>
  The value of x is: <%= x+i %>
  <% } %>
  <%= "Hello" %>
EOF

template = ERB.new(src)

puts template.result(binding)

#puts template.src

# _erbout = ''
# _erbout.concat "  So now we can begin\n  "
#
# 10.times { |i|
#   _erbout.concat "\n  The value of x is: "
#   _erbout.concat(( x+i ).to_s)
#   _erbout.concat "\n  "
# }
#
# _erbout.concat "\n  "
# _erbout.concat(( "Hello" ).to_s)
# _erbout.concat "\n"
# _erbout.force_encoding(__ENCODING__)

a = 4
b = 5

src = "<% if a == b; %> They were equal indeed.  <% else %> Ha! You LIE! <% end %>"

template = ERB.new(src)

puts template.result(binding)
