# coding: utf-8

require_relative 'win_32_api'
require 'IO/console'

#The class used to manipulate console i/o on a low level.
#<br>Endemic Code Smells
# :reek:TooManyInstanceVariables
class RawTerm

  #The magic number for standard out.
  STD_OUTPUT_HANDLE = -11

  #Set up the Windows Raw Terminal.
  def initialize
    @_getch = Win32API.new("msvcrt", "_getch", [], 'I')
    @_kbhit = Win32API.new("msvcrt", "_kbhit", [], 'I')
    @_beep  = Win32API.new("user32", "MessageBeep", ['L'])
    @_set_cursor_posn = Win32API.new("kernel32", "SetConsoleCursorPosition",
                                     ['L','L'], 'L')
    @_get_screen_info = Win32API.new("kernel32", "GetConsoleScreenBufferInfo",
                                     ['L','P'], 'L')
    @_get_handle = Win32API.new("kernel32", "GetStdHandle", ['L'], 'L')

    @_out_handle = @_get_handle.call(STD_OUTPUT_HANDLE)
  end

  def update_size
    raw_buffer = 0.chr * 24
    @_get_screen_info.call(@_out_handle, raw_buffer)

    x_size = (raw_buffer[0,2].unpack('S'))[0]
    y_size = (raw_buffer[2,2].unpack('S'))[0]
    x_posn = (raw_buffer[4,2].unpack('S'))[0]
    y_posn = (raw_buffer[6,2].unpack('S'))[0]

    size = IO.console.winsize

    print "size = #{x_size},#{y_size}  #{x_posn},#{y_posn} / #{size[1]},#{size[0]}\x0D"

  end

end

rt = RawTerm.new

100.times do
  rt.update_size
  sleep(0.1)
end

