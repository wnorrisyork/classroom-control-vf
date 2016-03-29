class skeleton {
  ## Manage /etc/skel directory
  file {'/etc/skel':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0755',
  }
  ## Manage /etc/skel/.bashrc file
  file {'/etc/skel/,bashrc':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/skeleton/bashrc',
  }

## Note: Source the file from the module
## Note: Copy from /etc/skel/.bashrc in your container

}
