# frozen_string_literal: true

require 'puppet/parser/functions'

Puppet::Parser::Functions.newfunction(:ensure_resources, type: :statement, doc: <<-DOC
  @summary
    Takes a resource type, title (only hash), and a list of attributes that describe a
    resource.

  @return
    created resources with the passed type and attributes

  @example Example usage

        user { 'dan':
          gid => 'mygroup',
          ensure => present,
        }

    An hash of resources should be passed in and each will be created with
    the type and parameters specified if it doesn't already exist.

    ensure_resources('user', {'dan' => { gid => 'mygroup', uid => '600' }, 'alex' => { gid => 'mygroup' }}, {'ensure' => 'present'})

    From Hiera Backend:

    userlist:
      dan:
        gid: 'mygroup'
     uid: '600'
      alex:
     gid: 'mygroup'

    Call:
    ensure_resources('user', hiera_hash('userlist'), {'ensure' => 'present'})
DOC
) do |vals|
  type, title, params = vals
  raise(ArgumentError, 'Must specify a type') unless type
  raise(ArgumentError, 'Must specify a title') unless title

  params ||= {}

  raise(Puppet::ParseError, 'ensure_resources(): Requires second argument to be a Hash') unless title.is_a?(Hash)

  resource_hash = title.dup
  resources = resource_hash.keys

  Puppet::Parser::Functions.function(:ensure_resource)
  resources.each do |resource_name|
    params_merged = if resource_hash[resource_name]
                      params.merge(resource_hash[resource_name])
                    else
                      params
                    end
    function_ensure_resource([type, resource_name, params_merged])
  end
end
