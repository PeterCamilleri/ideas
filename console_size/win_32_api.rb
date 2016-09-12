# coding: utf-8

require 'dl'

#The classic \Win32API gem is deprecated, so we emulate it with DL.
class Win32API

  #A hash of DLL files used for one or more API entry points.
  DLL = {}

  #Type mappings
  TYPEMAP = {"0" => DL::TYPE_VOID, "S" => DL::TYPE_VOIDP, "I" => DL::TYPE_LONG}

  #Set up an API entry point.
  def initialize(dllname, func, import, export = "0", calltype = :stdcall)
    @proto = [import].join.tr("VPpNnLlIi", "0SSI").sub(/^(.)0*$/, '\1')
    handle = DLL[dllname] ||= DL.dlopen(dllname)
    @func  = DL::CFunc.new(handle[func], TYPEMAP[export.tr("VPpNnLlIi", "0SSI")], func, calltype)
  end

  #Call the Win 32 API entry point with appropriate arguments.
  #<br>Endemic Code Smells
  #* :reek:FeatureEnvy
  def call(*args)
    args.each_with_index do |arg, index|
      case @proto[index]
        when "S"
          args[index], = [arg == 0 ? nil : arg].pack("p").unpack("l!*")
        when "I"
          args[index], = [arg].pack("I").unpack("i")
      end
    end

    @func.call(args).to_i || 0
  end

end

