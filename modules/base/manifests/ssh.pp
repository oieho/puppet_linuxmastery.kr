class base::ssh {
   package { 'openssh-server':
      ensure => latest,
   }

   service { 'ssh':
      ensure => running,
      require => Package['openssh-server'],
   }

   file { '.ssh':
      ensure => 'directory',
      name => '/home/administrator/.ssh',
      owner => 'administrator',
      group => 'administrator',
      mode => '700',
   }

   file { 'authorized_keys':
      name => '/home/administrator/.ssh/authorized_keys',
      owner => 'administrator',
      group => 'administrator',
      mode => '600',
      source => 'puppet:///modules/base/authorized_keys',
      require => File['.ssh'],
   }

   notify { "===== base::ssh =====\n": }
}
