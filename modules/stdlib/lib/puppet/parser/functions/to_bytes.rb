# frozen_string_literal: true

#
# to_bytes.rb
#
module Puppet::Parser::Functions
  newfunction(:to_bytes, type: :rvalue, doc: <<-DOC
    @summary
        Converts the argument into bytes, for example 4 kB becomes 4096.

    @return
      converted value into bytes

    Takes a single string value as an argument.
    These conversions reflect a layperson's understanding of
    1 MB = 1024 KB, when in fact 1 MB = 1000 KB, and 1 MiB = 1024 KiB.
  DOC
  ) do |arguments|
    raise(Puppet::ParseError, "to_bytes(): Wrong number of arguments given (#{arguments.size} for 1)") if arguments.size != 1

    arg = arguments[0]

    return arg if arg.is_a? Numeric

    value, prefix = *%r{([0-9.e+-]*)\s*([^bB]?)}.match(arg)[1, 2]

    value = value.to_f
    case prefix
    when '' then return value.to_i
    when 'k' then return (value * (1 << 10)).to_i
    when 'M' then return (value * (1 << 20)).to_i
    when 'G' then return (value * (1 << 30)).to_i
    when 'T' then return (value * (1 << 40)).to_i
    when 'P' then return (value * (1 << 50)).to_i
    when 'E' then return (value * (1 << 60)).to_i
    else raise Puppet::ParseError, "to_bytes(): Unknown prefix #{prefix}"
    end
  end
end
