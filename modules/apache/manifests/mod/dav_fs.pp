# @summary
#   Installs `mod_dav_fs`.
# 
# @see https://httpd.apache.org/docs/current/mod/mod_dav_fs.html for additional documentation.
#
class apache::mod::dav_fs {
  include apache
  $dav_lock = $facts['os']['family'] ? {
    'Debian'  => "\${APACHE_LOCK_DIR}/DAVLock",
    'FreeBSD' => '/usr/local/var/DavLock',
    default   => '/var/lib/dav/lockdb',
  }

  Class['apache::mod::dav'] -> Class['apache::mod::dav_fs']
  ::apache::mod { 'dav_fs': }

  # Template uses: $dav_lock
  file { 'dav_fs.conf':
    ensure  => file,
    path    => "${apache::mod_dir}/dav_fs.conf",
    mode    => $apache::file_mode,
    content => epp('apache/mod/dav_fs.conf.epp', { 'dav_lock' => $dav_lock }),
    require => Exec["mkdir ${apache::mod_dir}"],
    before  => File[$apache::mod_dir],
    notify  => Class['apache::service'],
  }
}
