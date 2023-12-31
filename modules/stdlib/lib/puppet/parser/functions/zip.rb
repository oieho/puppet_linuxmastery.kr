# frozen_string_literal: true

#
# zip.rb
#
module Puppet::Parser::Functions
  newfunction(:zip, type: :rvalue, doc: <<-DOC
    @summary
      Takes one element from first array and merges corresponding elements from second array.

    @return
      This generates a sequence of n-element arrays, where n is one more than the count of arguments.

    @example
      zip(['1','2','3'],['4','5','6'])
      Would result in: ["1", "4"], ["2", "5"], ["3", "6"]
  DOC
  ) do |arguments|
    # Technically we support three arguments but only first is mandatory ...
    raise(Puppet::ParseError, "zip(): Wrong number of arguments given (#{arguments.size} for 2)") if arguments.size < 2

    a = arguments[0]
    b = arguments[1]

    raise(Puppet::ParseError, 'zip(): Requires array to work with') unless a.is_a?(Array) && b.is_a?(Array)

    flatten = function_str2bool([arguments[2]]) if arguments[2]

    result = a.zip(b)
    result = flatten ? result.flatten : result

    return result
  end
end

# vim: set ts=2 sw=2 et :
