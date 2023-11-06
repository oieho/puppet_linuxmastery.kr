class fortunecow {
	include fortunecow::install
	include fortunecow::motd

    Class['fortunecow::install'] -> Class['fortunecow::motd']
}
