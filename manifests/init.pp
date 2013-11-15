# == Class: workshop
#
# Full description of class workshop here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { workshop:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class workshop($parent_dir='/mnt/NGS_workshop', $data_dir='data', 
               $working_dir='working_dir', $trainee_user='ngstrainee') {

  # NGS Trainee User
  $trainee_uid = 1001

  File {
    owner => $trainee_user,
    group => $trainee_user,
  }

  group { $trainee_user:,
    ensure => present,
  }

  file { "/home/${trainee_user}":
    ensure => directory,
    mode   => '0755',
  }

  file { "/home/${trainee_user}/Desktop":
    ensure  => directory,
    mode    => '0755',
    require => File["/home/${trainee_user}"],
  }

  user { $trainee_user:
    ensure  => present,
    uid     => $trainee_uid,
    gid     => $trainee_user,
    shell   => '/bin/bash',
    home    => "/home/${trainee_user}",
    require => [Group[$trainee_user], File["/home/${trainee_user}"]],
  }

  # Parent Directory
  file { $parent_dir:
    ensure  => directory,
    mode    => '0755',
    require => User[$trainee_user], 
  }

  # Data Directory
  file { "${parent_dir}/${data_dir}":
    ensure  => directory,
    mode    => '0755',
    require => File[$parent_dir],
  }

  # Work Directory
  file { "${parent_dir}/${working_dir}":
    ensure  => directory,
    mode    => '0755',
    require => File[$parent_dir],
  }

  define remote_file($remote_location, $mode=0644, $owner, $group) {
    exec { "get_${title}":
      command => "/usr/bin/wget -q ${remote_location} -O ${workshop::parent_dir}/${workshop::data_dir}/${title}",
      creates => "${workshop::parent_dir}/${workshop::data_dir}/${title}",
    }
   
    file { "${workshop::parent_dir}/${workshop::data_dir}/${title}":
      mode    => $mode,
      owner   => $owner,
      group   => $group,
      require => Exec["get_${title}"],
    }
  }

  define workshop_file($location, $link) {
    remote_file { $title:
      remote_location => "${location}/${title}",
      mode            => '0644',
      owner           => $workshop::trainee_user,
      group           => $workshop::trainee_user,
    }
    
    file { "${link}/${title}":
      ensure => link,
      target => "${workshop::parent_dir}/${workshop::data_dir}/${title}",
      owner  => $workshop::trainee_user,
      group  => $workshop::trainee_user,
    }
  }

}
