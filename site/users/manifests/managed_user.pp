define users::managed_user (
  $homedir = "/home/${title}",
  $username = $title,
  $uid = undef,
  $groupname = undef,
){
  File {
    owner => $username,
    group => $groupname,
    mode => '0644',
  }
  ## user account
  user {$title:
    ensure => present,
    uid => $uid,
    gid => $groupname,
    home => $homedir,
    name => $username,
  }
  ## group account
  group {$title:
    ensure => present,
    name => $groupname,
  }
  ## manage ${home}/.ssh directory
  file {[$homedir, "${homedir}/.ssh"]:
    ensure => directory,
  }
}
