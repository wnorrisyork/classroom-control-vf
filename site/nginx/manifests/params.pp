class nginx::params {
  case $::osfamily {
    'redhat','debian' : {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir = '/var/log/nginx'
    }
    'windows' : {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $logdir = 'C:/ProgramData/nginx/logs'
    }
    default : {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
  }
  $user = $::osfamily ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    'windows' => 'nobody',
    Lab 18.2: Proposed Solution
    VirtualFundamentals v1.0.2 31 ©2016 Puppet Labs
  }
}
