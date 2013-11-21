class workshop::chipseq($module='ChIP-seq', $container='NGSDataChIPSeq') inherits workshop {

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

  workshop_file { 'Oct4.fastq':
    location => $container_url,
    link     => $module_path,
  }

  workshop_file { 'gfp.fastq':
    location => $container_url,
    link     => $module_path,
  }

  remote_file { 'PeakAnalyzer_1.4.tar.gz':
    remote_location => "${container_url}/PeakAnalyzer_1.4.tar.gz",
    mode            => '0644',
    owner           => $trainee_user,
    group           => $trainee_user,
  }

  exec { 'extract_peak_analyzer':
    command => "/bin/tar -xzf ${data_path}/PeakAnalyzer_1.4.tar.gz",
    cwd     => $data_path,
    creates => "${data_path}/PeakAnalyzer_1.4",
    require => Remote_file['PeakAnalyzer_1.4.tar.gz'],
  }

  workshop_dir { "${data_path}/PeakAnalyzer_1.4":
    require => Exec['extract_peak_analyzer'],
  }

  workshop_dir { "${module_path}/bowtie_index":
    require => Workshop_dir[$module_path],
  }

  workshop_file { 'mouse.mm10.genome':
    location => $container_url,
    link     => "${module_path}/bowtie_index",
    require  => Workshop_dir["${module_path}/bowtie_index"],
  }

  workshop_file { 'mm10.fa':
    location => $container_url,
    link     => "${module_path}/bowtie_index",
    require  => Workshop_dir["${module_path}/bowtie_index"],
  }

  workshop_dir { "${module_path}/data":
    require => Workshop_dir[$module_path],
  }
}
