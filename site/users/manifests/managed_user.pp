define users::managed_user (
  $homedir = "/home/${title}",
  $group = $title,
){
  ## user account
  user {$title:
    ensure => present,
  }
  ## group account
  file {$homedir:
    ensure => directory,
    group => $group,
    owner => $title,
  }
## manage ${home}/.ssh directory
}
