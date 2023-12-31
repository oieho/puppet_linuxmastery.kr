# frozen_string_literal: true

#
#  swapcase.rb
#  Please note: This function is an implementation of a Ruby class and as such may not be entirely UTF8 compatible. To ensure compatibility please use this function with Ruby 2.4.0 or greater - https://bugs.ruby-lang.org/issues/10085.
#
module Puppet::Parser::Functions
  newfunction(:swapcase, type: :rvalue, doc: <<-DOC
    @summary
      This function will swap the existing case of a string.

    @return
      string with uppercase alphabetic characters converted to lowercase and lowercase characters converted to uppercase

    @example **Usage**

      swapcase("aBcD")
      Would result in: "AbCd"
  DOC
  ) do |arguments|
    raise(Puppet::ParseError, "swapcase(): Wrong number of arguments given (#{arguments.size} for 1)") if arguments.empty?

    value = arguments[0]

    raise(Puppet::ParseError, 'swapcase(): Requires either array or string to work with') unless value.is_a?(Array) || value.is_a?(String)

    result = if value.is_a?(Array)
               # Numbers in Puppet are often string-encoded which is troublesome ...
               value.map { |i| i.is_a?(String) ? i.swapcase : i }
             else
               value.swapcase
             end

    return result
  end
end

# vim: set ts=2 sw=2 et :
