class motd {
   file { '/etc/motd':
      ensure  => file,
      owner   => 'root',
      content => "\n
         Hostname : ${::fqdn}\n
         IP Address : ${::ipaddress}\n",
   }
}
