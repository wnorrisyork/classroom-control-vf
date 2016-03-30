class nginx {
File {
  owner => 'root',
  group => 'root',
  mode => '0664',
}

$modules = 'puppet:///modules/nginx/'

  package { 'nginx':
    ensure => present,
  }
  file { ['/var/www','/etc/nginx/conf.d']:
    ensure => directory,
  }
  file { '/var/www/index.html':
    ensure => file,
    source => "${modules}index.html",
  }
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => "${modules}nginx.conf",
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    source => "${modules}default.conf",
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
