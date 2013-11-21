class workshop::filesys($module='file_system', $container='SoftwareCarpentry') inherits workshop {

  $container_url = "${swift_url}/${container}"
  $module_path = "${parent_path}/${working_dir}/${module}"

  $trainee_home = "/home/${trainee_user}"

  File {
    owner => $workshop::trainee_user,
    group => $workshop::trainee_user,
  }

  workshop_dir { $module_path:
    require => Workshop_dir[$working_path],
  }

  workshop_link { "${trainee_home}/${module}":
    source => $module_path,
  }

  workshop_link { "${trainee_home}/Desktop/${module}":
    source  => $module_path,
    require => Workshop_dir["${trainee_home}/Desktop"],
  }

  remote_file { 'file_system.tar.gz':
    remote_location => "${container_url}/file_system.tar.gz",
    mode            => '0644',
    owner           => $trainee_user,
    group           => $trainee_user,
  }

  exec { 'extract_file_system':
    command => "/bin/tar -xzf ${data_path}/file_system.tar.gz",
    cwd     => $data_path,
    creates => "${data_path}/file_system",
    require => Remote_file['file_system.tar.gz'],
  }

  workshop_dir { "${data_path}/file_system":
    require => Exec['extract_file_system'],
  }
}
