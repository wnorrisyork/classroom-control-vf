class nginx {
  case $::osfamily {
    'redhat','debian' : {
    $package = 'nginx'
    $owner = 'root'
    $group = 'root'
    $docroot = '/var/www'
    $confdir = '/etc/nginx'
    $serverblockdir = '/etc/nginx/conf.d'
    $logdir = '/var/log/nginx'
  }
  'windows' : {
    $package = 'nginx-service'
    $owner = 'Administrator'
    $group = 'Administrators'
    $docroot = 'C:/ProgramData/nginx/html'
    $confdir = 'C:/ProgramData/nginx'
    $serverblockdir = 'C:/ProgramData/nginx/conf.d',
    $logdir = 'C:/ProgramData/nginx/logs'
  }
  default : {
    fail("Module ${module_name} is not supported on ${::osfamily}")
  }
}

  # user the service will run as. Used in the nginx.conf.erb template
  $user = $::osfamily ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    'windows' => 'nobody',
  }
  File {
    owner => $owner,
    group => $group,
    mode => '0664',
  }
  package { $package:
    ensure => present,
  }
  file { [ $docroot, "$serverblockdir ]:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${confdir}/nginx.conf":
    ensure => file,
    content => template('nginx/nginx.conf.erb'),
    notify => Service['nginx'],
  }
  file { "${serverblockdir}/default.conf":
    ensure => file,
    content => template('nginx/default.conf.erb'),
    notify => Service['nginx'],
  }
