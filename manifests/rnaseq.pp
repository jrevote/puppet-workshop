class workshop::rnaseq($module='RNA-seq', $container='NGSDataRNASeq') inherits workshop {

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

  workshop_file { '2cells_1.fastq':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { '2cells_2.fastq':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { '6h_1.fastq':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_file { '6h_2.fastq':
    location => $container_url,
    link     => "${module_path}/data",
  }

  workshop_dir { "${module_path}/annotation":
    require => Workshop_dir[$module_path],
  }

  workshop_file { 'Danio_rerio.Zv9.66.spliceSites':
    location => $container_url,
    link     => "${module_path}/annotation",
  }

  workshop_file { 'Danio_rerio.Zv9.66.gtf':
    location => $container_url,
    link     => "${module_path}/annotation",
  }

  workshop_dir { "${module_path}/genome":
    require => Workshop_dir[$module_path],
  }

  workshop_file { 'ZV9.1.ebwt':
    location => $container_url,
    link     => "${module_path}/genome",
  }

  workshop_file { 'ZV9.2.ebwt':
    location => $container_url,
    link     => "${module_path}/genome",
  }

  workshop_file { 'ZV9.3.ebwt':
    location => $container_url,
    link     => "${module_path}/genome",
  }

  workshop_file { 'ZV9.4.ebwt':
    location => $container_url,
    link     => "${module_path}/genome",
  }

  workshop_file { 'ZV9.rev.1.ebwt':
    location => $container_url,
    link     => "${module_path}/genome",
  }

  workshop_file { 'ZV9.rev.2.ebwt':
    location => $container_url,
    link     => "${module_path}/genome",
  }

  workshop_file { 'Danio_rerio.Zv9.66.dna.fa':
    location => $container_url,
    link     => "${module_path}/genome",
  }

  workshop_file { 'Danio_rerio.Zv9.66.dna.fa.fai':
    location => $container_url,
    link     => "${module_path}/genome",
  }

  # Tophat
  workshop_dir { "${module_path}/tophat":
    require => Workshop_dir[$module_path],
  }

  # Cufflinks
  workshop_dir { "${module_path}/cufflinks":
    require => Workshop_dir[$module_path],
  }

  # Cuffdiff
  workshop_dir { "${module_path}/cuffdiffs":
    require => Workshop_dir[$module_path],
  }

  workshop_file { 'globalDiffExprs_Genes_qval.01_top100.tab':
    location => $container_url,
    link     => "${module_path}/cufflinks",
  }

  workshop_dir { "${module_path}/cufflinks/ZV9_2cells_gtf_guided":
    require => Workshop_dir["${module_path}/cufflinks"],
  }

  workshop_dir { "${module_path}/cufflinks/ZV9_6h_gtf_guided":
    require => Workshop_dir["${module_path}/cufflinks"],
  }

  workshop_dir { "${module_path}/tophat/ZV9_2cells":
    require => Workshop_dir["${module_path}/cufflinks"],
  }

  workshop_file { 'accepted_hits.bam':
    location => $container_url,
    link     => "${module_path}/tophat/ZV9_2cells",
  }

  workshop_file { 'accepted_hits.sorted.bam':
    location => $container_url,
    link     => "${module_path}/tophat/ZV9_2cells",
  }

  workshop_file { 'accepted_hits.sorted.bam.bai':
    location => $container_url,
    link     => "${module_path}/tophat/ZV9_2cells",
  }

  workshop_file { 'junctions.bed':
    location => $container_url,
    link     => "${module_path}/tophat/ZV9_2cells",
  }

  workshop_file { 'deletions.bed':
    location => $container_url,
    link     => "${module_path}/tophat/ZV9_2cells",
  }

  workshop_file { 'insertions.bed':
    location => $container_url,
    link     => "${module_path}/tophat/ZV9_2cells",
  }
}
