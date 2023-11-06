class webapp::wp {
   $servername = lookup('servername')
   $dbname = lookup('wp_db_name')

   file { '/tmp/latest.tar.gz':
      ensure => present,
      source => 'puppet:///modules/webapp/latest.tar.gz',
      }

   exec { 'extract':
      cwd => '/tmp',
      command => 'tar -zxvf latest.tar.gz',
      require => File['/tmp/latest.tar.gz'],
      path => ['/bin'],
      }

   file { "/var/www/${servername}":
      ensure  => directory,
      }

   file { "/var/www/${servername}/${dbname}":
      ensure => directory,
      }

   exec { 'copy':
      command => "cp -r /tmp/wordpress/* /var/www/${servername}/${dbname}",
      require => Exec['extract'],
      path => ['/bin'],
      }

   file { "/var/www/${servername}/${dbname}/wp-config.php":
      ensure  => present,
      require => Exec['copy'],
      # source  => 'puppet:///modules/webapp/wp-config.php',
      content => template('webapp/wp-config.php.erb'),
      }

}
