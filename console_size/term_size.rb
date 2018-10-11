# From the tty_ioctl man page in Linux.
#
# TIOCGWINSZ     struct winsize *argp
#        Get window size.
#
# TIOCSWINSZ     const struct winsize *argp
#        Set window size.
#
# The struct used by these ioctls is defined as
#
#     struct winsize {
#         unsigned short ws_row;
#         unsigned short ws_col;
#         unsigned short ws_xpixel;   /* unused */
#         unsigned short ws_ypixel;   /* unused */
#     };
#         rows cols width height
#
# From https://gist.github.com/nixpulvis/6025433
#
# No joy here. 1074295912, it seems, is just a little too magical.
#
window = [0,   0,   0,    0     ].pack('SSSS')

fd = IO.sysopen("/dev/tty", "w")
terminal = IO.new(fd, "w")

# The int in this call is === TIOCGWINSZ. No idea where it is defined.
# I found it using ruby-termios with `Termios::TIOCGWINSZ`
terminal.ioctl(1074295912, window)

rows, cols, width, height = window.unpack('SSSS')
puts "Rows: #{rows}, Cols: #{cols}, Width: #{width}, Height: #{height}"
