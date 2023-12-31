# @summary
#   Installs and configures `mod_fcgid`.
# 
# @param options
#   A hash used to parameterize the availible options:
#   expires_active
#     Enables generation of Expires headers.
#   expires_default
#     Default algorithm for calculating expiration time.
#   expires_by_type
#     Value of the Expires header configured by MIME type.
#
# @example The class does not individually parameterize all available options. Instead, configure mod_fcgid using the options hash. 
#   class { 'apache::mod::fcgid':
#     options => {
#       'FcgidIPCDir'  => '/var/run/fcgidsock',
#       'SharememPath' => '/var/run/fcgid_shm',
#       'AddHandler'   => 'fcgid-script .fcgi',
#     },
#   }
#
# @example If you include apache::mod::fcgid, you can set the [FcgidWrapper][] per directory, per virtual host. The module must be 
# loaded first; Puppet will not automatically enable it if you set the fcgiwrapper parameter in apache::vhost.
#   include apache::mod::fcgid
#   
#   apache::vhost { 'example.org':
#     docroot     => '/var/www/html',
#     directories => {
#       path        => '/var/www/html',
#       fcgiwrapper => {
#         command => '/usr/local/bin/fcgiwrapper',
#       }
#     },
#   }
#
# @see https://httpd.apache.org/docs/current/mod/mod_fcgid.html for additional documentation.
#
class apache::mod::fcgid (
  Hash $options = {},
) {
  include apache
  if ($facts['os']['family'] == 'RedHat' and versioncmp($facts['os']['release']['major'], '7') >= 0) or $facts['os']['family'] == 'FreeBSD' {
    $loadfile_name = 'unixd_fcgid.load'
    $conf_name = 'unixd_fcgid.conf'
  } else {
    $loadfile_name = undef
    $conf_name = 'fcgid.conf'
  }

  ::apache::mod { 'fcgid':
    loadfile_name => $loadfile_name,
  }

  # Template uses:
  # - $options
  file { $conf_name:
    ensure  => file,
    path    => "${apache::mod_dir}/${conf_name}",
    mode    => $apache::file_mode,
    content => epp('apache/mod/fcgid.conf.epp', { 'options'  => $options, }),
    require => Exec["mkdir ${apache::mod_dir}"],
    before  => File[$apache::mod_dir],
    notify  => Class['apache::service'],
  }
}
