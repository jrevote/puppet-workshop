class workshop::rnaseq inherits workshop {

  $module = 'RNA-seq'
  $swift_url = 'https://swift.rc.nectar.org.au:8888/v1/AUTH_809'
  $swift_container = 'NGSDataRNASeq'

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

  file { "${parent_dir}/${working_dir}/${module}/data":
    ensure  => directory,
    mode    => '0755',
    require => File["${parent_dir}/${working_dir}/${module}"],
  }

  workshop_file { '2cells_1.fastq':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/data",
    require  => File["${parent_dir}/${working_dir}/${module}/data"],
  }

  workshop_file { '2cells_2.fastq':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/data",
    require  => File["${parent_dir}/${working_dir}/${module}/data"],
  }

  workshop_file { '6h_1.fastq':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/data",
    require  => File["${parent_dir}/${working_dir}/${module}/data"],
  }

  workshop_file { '6h_2.fastq':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/data",
    require  => File["${parent_dir}/${working_dir}/${module}/data"],
  }

  file { "${parent_dir}/${working_dir}/${module}/annotation":
    ensure  => directory,
    mode    => '0755',
    require => File["${parent_dir}/${working_dir}/${module}"],
  }

  workshop_file { 'Danio_rerio.Zv9.66.spliceSites':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/annotation",
    require  => File["${parent_dir}/${working_dir}/${module}/annotation"],
  }

  workshop_file { 'Danio_rerio.Zv9.66.gtf':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/annotation",
    require  => File["${parent_dir}/${working_dir}/${module}/annotation"],
  }

  file { "${parent_dir}/${working_dir}/${module}/genome":
    ensure  => directory,
    mode    => '0755',
    require => File["${parent_dir}/${working_dir}/${module}"],
  }

  workshop_file { 'ZV9.1.ebwt':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/genome",
    require  => File["${parent_dir}/${working_dir}/${module}/genome"],
  }

  workshop_file { 'ZV9.2.ebwt':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/genome",
    require  => File["${parent_dir}/${working_dir}/${module}/genome"],
  }

  workshop_file { 'ZV9.3.ebwt':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/genome",
    require  => File["${parent_dir}/${working_dir}/${module}/genome"],
  }

  workshop_file { 'ZV9.4.ebwt':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/genome",
    require  => File["${parent_dir}/${working_dir}/${module}/genome"],
  }

  workshop_file { 'ZV9.rev.1.ebwt':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/genome",
    require  => File["${parent_dir}/${working_dir}/${module}/genome"],
  }

  workshop_file { 'ZV9.rev.2.ebwt':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/genome",
    require  => File["${parent_dir}/${working_dir}/${module}/genome"],
  }

  workshop_file { 'Danio_rerio.Zv9.66.dna.fa':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/genome",
    require  => File["${parent_dir}/${working_dir}/${module}/genome"],
  }

  workshop_file { 'Danio_rerio.Zv9.66.dna.fa.fai':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/genome",
    require  => File["${parent_dir}/${working_dir}/${module}/genome"],
  }

}
