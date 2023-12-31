# frozen_string_literal: true

#
# get_module_path.rb
#
module Puppet::Parser::Functions
  newfunction(:get_module_path, type: :rvalue, doc: <<-DOC
    @summary
      Returns the absolute path of the specified module for the current
      environment.

    @return
      Returns the absolute path of the specified module for the current
      environment.

    @example Example Usage:
      $module_path = get_module_path('stdlib')

    > *Note:*
      that since Puppet 5.4.0 the  built-in
      [`module_directory`](https://puppet.com/docs/puppet/latest/function.html#module_directory)
      function in Puppet does the same thing and will return the path to the first found module
      if given multiple values or an array.
  DOC
  ) do |args|
    raise(Puppet::ParseError, 'get_module_path(): Wrong number of arguments, expects one') unless args.size == 1

    module_path = Puppet::Module.find(args[0], compiler.environment.to_s)
    raise(Puppet::ParseError, "Could not find module #{args[0]} in environment #{compiler.environment}") unless module_path

    module_path.path
  end
end
