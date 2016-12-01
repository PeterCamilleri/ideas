# coding: utf-8

require_relative 'win_32_api'

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

  def show_screen_info
    raw_buffer = 0.chr * 22
    @_get_screen_info.call(@_out_handle, raw_buffer)

    x_size     = (raw_buffer[ 0,2].unpack('S'))[0]
    y_size     = (raw_buffer[ 2,2].unpack('S'))[0]
    x_posn     = (raw_buffer[ 4,2].unpack('S'))[0]
    y_posn     = (raw_buffer[ 6,2].unpack('S'))[0]

    attrib     = (raw_buffer[ 8,2].unpack('S'))[0]

    left       = (raw_buffer[10,2].unpack('S'))[0]
    top        = (raw_buffer[12,2].unpack('S'))[0]
    right      = (raw_buffer[14,2].unpack('S'))[0]
    bottom     = (raw_buffer[16,2].unpack('S'))[0]

    max_width  = (raw_buffer[18,2].unpack('S'))[0]
    max_height = (raw_buffer[20,2].unpack('S'))[0]

    puts
    puts "buffer   (width = #{x_size.to_s.rjust(2)   }, height = #{y_size})"
    puts "position (x     = #{x_posn.to_s.rjust(2)   }, y      = #{y_posn})"
    puts "window   (left  = #{left.to_s.rjust(2)     }, right  = #{right}, " +
    "top = #{top}, bottom = #{bottom})"
    puts "max      (width = #{max_width.to_s.rjust(2)}, height = #{max_height})"
    puts "character attributes = 0x#{attrib.to_s(16) }"
    puts

  end

end

RawTerm.new.show_screen_info
