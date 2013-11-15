class workshop::chipseq inherits workshop {

  $module = 'ChIP-seq'
  $swift_url = 'https://swift.rc.nectar.org.au:8888/v1/AUTH_809'
  $swift_container = 'NGSDataChIPSeq'

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

  workshop_file { 'Oct4.fastq':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}",
    require  => File["${parent_dir}/${working_dir}/${module}"],
  }

  workshop_file { 'gfp.fastq':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}",
    require  => File["${parent_dir}/${working_dir}/${module}"],
  }

  remote_file { 'PeakAnalyzer_1.4.tar.gz':
    remote_location => "${swift_url}/${swift_container}/PeakAnalyzer_1.4.tar.gz",
    mode            => '0644',
    owner           => $workshop::trainee_user,
    group           => $workshop::trainee_user,
  }

  exec { 'extract_peak_analyzer':
    command => "/bin/tar -xzf ${parent_dir}/${data_dir}/PeakAnalyzer_1.4.tar.gz",
    cwd     => "${parent_dir}/${data_dir}",
    creates => "${parent_dir}/${data_dir}/PeakAnalyzer_1.4",
    require => Remote_file['PeakAnalyzer_1.4.tar.gz'],
  }

  file { "${parent_dir}/${data_dir}/PeakAnalyzer_1.4":
    ensure  => directory,
    recurse => true,
    require => Exec['extract_peak_analyzer'],
  }

  file { "${parent_dir}/${working_dir}/${module}/bowtie_index":
    ensure  => directory,
    mode    => '0755',
    require => File["${parent_dir}/${working_dir}/${module}"],
  }

  workshop_file { 'mouse.mm10.genome':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/bowtie_index",
    require  => [File["${parent_dir}/${working_dir}/${module}"],
                File["${parent_dir}/${working_dir}/${module}/bowtie_index"]],
  }

  workshop_file { 'mm10.fa':
    location => "${swift_url}/${swift_container}",
    link     => "${workshop::parent_dir}/${workshop::working_dir}/${module}/bowtie_index",
    require  => [File["${parent_dir}/${working_dir}/${module}"],
                File["${parent_dir}/${working_dir}/${module}/bowtie_index"]],
  }

  file { "${parent_dir}/${working_dir}/${module}/data":
    ensure  => directory,
    mode    => '0755',
    require => File["${parent_dir}/${working_dir}/${module}"],
  }
}
