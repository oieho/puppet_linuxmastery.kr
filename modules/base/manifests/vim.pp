class base::vim {
   package { 'vim':
      ensure => latest,
   }

   file { '.vimrc':
      name => '/home/administrator/.vimrc',
      owner => 'administrator',
      group => 'administrator',
      mode => '666',
      source => 'puppet:///modules/base/.vimrc',
      require => Package['vim'],
      }

   notify { "===== base:vim =====\n": }
}
