# frozen_string_literal: true

#
# squeeze.rb
#
module Puppet::Parser::Functions
  newfunction(:squeeze, type: :rvalue, doc: <<-DOC
    @summary
      Returns a new string where runs of the same character that occur in this set are replaced by a single character.

    @return
      a new string where runs of the same character that occur in this set are replaced by a single character.
  DOC
  ) do |arguments|
    raise(Puppet::ParseError, "squeeze(): Wrong number of arguments given #{arguments.size} for 2 or 1") if (arguments.size != 2) && (arguments.size != 1)

    item = arguments[0]
    squeezeval = arguments[1]

    if item.is_a?(Array)
      if squeezeval
        item.map { |i| i.squeeze(squeezeval) }
      else
        item.map(&:squeeze)
      end
    elsif squeezeval
      item.squeeze(squeezeval)
    else
      item.squeeze
    end
  end
end

# vim: set ts=2 sw=2 et :
