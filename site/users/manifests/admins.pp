class users::admins {
  users::managed_user {'joe':}
  users::managed_user {'alice':
    groupname => 'staff',
  }
}
