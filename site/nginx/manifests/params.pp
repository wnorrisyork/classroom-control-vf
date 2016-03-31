class nginx::params {
  case $::osfamily {
    'redhat','debian' : {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir = '/var/log/nginx'
      $root = '/var/www'
    }
    'windows' : {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $logdir = 'C:/ProgramData/nginx/logs'
      $root = '/var/www'
    }
    default : {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
  }
  $user = $::osfamily ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    'windows' => 'nobody',
  }
}
