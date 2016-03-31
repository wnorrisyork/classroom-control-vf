class nginx (
  $package = $nginx::params::package,
  $owner = $nginx::params::owner,
  $group = $nginx::params::group,
  $docroot = $nginx::params::docroot,
  $confdir = $nginx::params::confdir,
  $logdir = $nginx::params::logdir,
  $user = $nginx::params::user,
  $root = $nginx::params::root,
  $serverblockdir = $nginx::params::serverblockdir,
) inherits nginx::params {
  File {
    owner => $owner,
    group => $group,
    mode => '0664',
  }
  package { 'nginx':
    ensure => installed,
    name => $package,
  }
  file { [ $docroot, $serverblockdir ]:
    ensure => directory,
  }
  
  # manage the default docroot, index, and conf--replaces several resources
  nginx::vhost { 'default':
    docroot => $docroot,
    servername => $::fqdn,
  }

#  file { "${docroot}/index.html":
#    ensure => file,
#    source => 'puppet:///modules/nginx/index.html',
#  }
  file { "${confdir}/nginx.conf":
    ensure => file,
    content => template('nginx/nginx.conf.erb'),
    notify => Service['nginx'],
  }
#  file { "${serverblockdir}/default.conf":
#    ensure => file,
#    content => template('nginx/default.conf.erb'),
#    notify => Service['nginx'],
#  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
