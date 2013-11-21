class workshop::denovo($module='de_novo', $container='NGSDataDeNovo') inherits workshop {

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

  workshop_dir { "${module_path}/data":
    require => Workshop_dir[$module_path],
  }

  workshop_file { 'velvet_1.2.07.tgz':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { 'SRR022825.fastq.gz':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { 'SRR022823.fastq.gz':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { 's_aureus_mrsa252.EB1_s_aureus_mrsa252.dna.chromosome.Chromosome.fa.gz':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { 'SRR022852_1.fastq.gz':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { 'SRR022852_2.fastq.gz':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { 'SRR023408_1.fastq.gz':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { 'SRR023408_2.fastq.gz':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { 'SRR000892.fastq.gz':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { 'SRR000893.fastq.gz':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { 'SRR022863_1.fastq.gz':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { 'SRR022863_2.fastq.gz':
    location => $container_url,
    link     => "${module_path}/data",
  }
}
