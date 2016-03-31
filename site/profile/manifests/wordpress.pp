class profile::wordpress {
  ## Mysql Server needs to be running
  service {'mysql':
    ensure => running,
    enable => true,
  }
  ## Pull down Wordpress TAR ball and expand it
  class { '::wordpress':
    install_dir => '/var/www/wordpress',
    install_url => 'http://internal.example.com/software',
  }
  ## Need Apache VHost config
  apache::vhost { 'vhost.example.com':
    port    => '31013',
    docroot => '/var/www/vhost',
  }
  ## Setup Wordpress
  class { '::wordpress':
    wp_owner    => 'wordpress',
    wp_group    => 'wordpress',
  }
  ## Local user for wordpress
  user { 'wordpress':
    ensure => present,
  }
  ## local group for wordpress
  group { 'wordpress':
    ensure => present,
  }
}
