class fortunecow::motd {
	file { '/etc/profile.d/motd.sh':
		ensure => file,
		owner => 'root',
		content => "/usr/games/fortune | /usr/games/cowsay -n"
	}
}
