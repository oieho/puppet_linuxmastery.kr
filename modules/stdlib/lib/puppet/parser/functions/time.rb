# frozen_string_literal: true

#
# time.rb
#
module Puppet::Parser::Functions
  newfunction(:time, type: :rvalue, doc: <<-DOC
    @summary
      This function will return the current time since epoch as an integer.

    @return
      the current time since epoch as an integer.

    @example **Usage**

      time()
      Will return something like: 1311972653

    > *Note:* that since Puppet 4.8.0 the Puppet language has the data types Timestamp (a point in time) and
    Timespan (a duration). The following example is equivalent to calling time() without
    any arguments:

    ```Timestamp()```

  DOC
  ) do |arguments|
    # The Time Zone argument is optional ...
    time_zone = arguments[0] if arguments[0]

    raise(Puppet::ParseError, "time(): Wrong number of arguments given #{arguments.size} for 0 or 1") if !arguments.empty? && (arguments.size != 1)

    time = Time.new

    # There is probably a better way to handle Time Zone ...
    if time_zone && !time_zone.empty?
      original_zone = ENV.fetch('TZ', nil)

      local_time = time.clone
      local_time = local_time.utc

      ENV['TZ'] = time_zone

      result = local_time.localtime.strftime('%s')

      ENV['TZ'] = original_zone
    else
      result = time.localtime.strftime('%s')
    end

    # Calling Time#to_i on a receiver changes it.  Trust me I am the Doctor.
    result = result.to_i

    return result
  end
end

# vim: set ts=2 sw=2 et :
