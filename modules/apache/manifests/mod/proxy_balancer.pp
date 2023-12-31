# @summary
#   Installs and configures `mod_proxy_balancer`.
# 
# @param manager
#   Toggle whether to enable balancer manager support.
#
# @param manager_path
#   Server relative path to balancer manager.
#
# @param allow_from
#   List of IPs from which the balancer manager can be accessed.
#
# @see https://httpd.apache.org/docs/current/mod/mod_proxy_balancer.html for additional documentation.
#
class apache::mod::proxy_balancer (
  Boolean $manager                       = false,
  Stdlib::Unixpath $manager_path         = '/balancer-manager',
  Array[Stdlib::IP::Address] $allow_from = ['127.0.0.1', '::1'],
) {
  require apache::mod::proxy
  require apache::mod::proxy_http
  ::apache::mod { 'slotmem_shm': }
  ::apache::mod { 'proxy_balancer': }
  if $manager {
    include apache::mod::status
    file { 'proxy_balancer.conf':
      ensure  => file,
      path    => "${apache::mod_dir}/proxy_balancer.conf",
      mode    => $apache::file_mode,
      content => epp('apache/mod/proxy_balancer.conf.epp', { 'manager_path' => $manager_path, 'allow_from'  => $allow_from, }),
      require => Exec["mkdir ${apache::mod_dir}"],
      before  => File[$apache::mod_dir],
      notify  => Class['apache::service'],
    }
  }
}
