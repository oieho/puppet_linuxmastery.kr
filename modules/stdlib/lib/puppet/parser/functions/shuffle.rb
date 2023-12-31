# frozen_string_literal: true

#
# shuffle.rb
#
module Puppet::Parser::Functions
  newfunction(:shuffle, type: :rvalue, doc: <<-DOC
  @summary
    Randomizes the order of a string or array elements.

   @return
     randomized string or array
  DOC
  ) do |arguments|
    raise(Puppet::ParseError, "shuffle(): Wrong number of arguments given (#{arguments.size} for 1)") if arguments.empty?

    value = arguments[0]

    raise(Puppet::ParseError, 'shuffle(): Requires either array or string to work with') unless value.is_a?(Array) || value.is_a?(String)

    result = value.clone

    string = value.is_a?(String)

    # Check whether it makes sense to shuffle ...
    return result if result.size <= 1

    # We turn any string value into an array to be able to shuffle ...
    result = string ? result.chars : result

    elements = result.size

    # Simple implementation of Fisher–Yates in-place shuffle ...
    elements.times do |i|
      j = rand(elements - i) + i
      result[j], result[i] = result[i], result[j]
    end

    result = string ? result.join : result

    return result
  end
end

# vim: set ts=2 sw=2 et :
