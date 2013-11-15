class workshop::qc inherits workshop {

  $module = 'QC'
  $swift_url = 'https://swift.rc.nectar.org.au:8888/v1/AUTH_809'
  $swift_container = 'NGSDataQC'

  File {
    owner => $workshop::trainee_user,
    group => $workshop::trainee_user,
  }

  file { "${parent_dir}/${working_dir}/${module}":
    ensure  => directory,
    mode    => '0755',
    require => File["${parent_dir}/${working_dir}"],
  }

  file { "/home/${trainee_user}/${module}":
    ensure  => link,
    target  => "${parent_dir}/${working_dir}/${module}",
    require => File["${parent_dir}/${working_dir}/${module}"],
  }
 
  file { "/home/${trainee_user}/Desktop/${module}":
    ensure  => link,
    target  => "${parent_dir}/${working_dir}/${module}",
    require => [File["${parent_dir}/${working_dir}/${module}"],
               File["/home/${trainee_user}/Desktop"]],
  } 

  workshop_file { 'bad_example.fastq':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}",   
    require  => File["${parent_dir}/${working_dir}/${module}"],
  }

  workshop_file { 'good_example.fastq':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}",
    require  => File["${parent_dir}/${working_dir}/${module}"],
  }
}
