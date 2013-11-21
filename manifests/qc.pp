class workshop::qc($module='QC', $container='NGSDataQC') inherits workshop {

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

  workshop_file { 'bad_example.fastq':
    location => $container_url,
    link     => $module_path,
  }

  workshop_file { 'good_example.fastq':
    location => $container_url,
    link     => $module_path,
  }
}
