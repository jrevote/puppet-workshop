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
class workshop {

  $parent_path = hiera('workshop::parent_path')
  $data_dir = hiera('workshop::data_dir')
  $working_dir = hiera('workshop::working_dir')
  $trainee_user = hiera('workshop::trainee_user')
  $trainee_uid = hiera('workshop::trainee_uid')
  $swift_url = hiera('workshop::swift_url')

  $data_path = "${parent_path}/${data_dir}"
  $working_path = "${parent_path}/${working_dir}"

  # Defaults
  File {
    owner => $trainee_user,
    group => $trainee_user,
  }

  # Helper resource for the directories
  define workshop_dir {
    file { "${title}":
      ensure  => directory,
      recurse => true,
      mode    => '0755',
      owner   => $workshop::trainee_user,
      group   => $workshop::trainee_user,
    }
  }

  # Helper resource for symbolic links
  define workshop_link($source) {
    file { "${title}":
      ensure  => link,
      target  => $source,
      require => Workshop_dir[$source],
    }
  }

  # Trainee group
  group { $trainee_user:
    ensure => present,
  }

  # Trainee user's home directory
  workshop_dir { "/home/${trainee_user}": }

  # Trainee user's desktop directory
  workshop_dir { "/home/${trainee_user}/Desktop":
    require => Workshop_dir["/home/${trainee_user}"],
  }

  # Trainee user
  user { $trainee_user:
    ensure  => present,
    uid     => $trainee_uid,
    gid     => $trainee_user,
    shell   => '/bin/bash',
    home    => "/home/${trainee_user}",
    require => Group[$trainee_user],
  }

  # Helper resource for downloading a remote file
  define remote_file($remote_location, $mode=0644, $owner, $group) {
    exec { "get_${title}":
      command => "/usr/bin/wget -q ${remote_location} -O ${workshop::data_path}/${title}",
      creates => "${workshop::data_path}/${title}",
      require => Workshop_dir[$workshop::data_path],
    }
   
    file { "${workshop::data_path}/${title}":
      mode    => $mode,
      owner   => $owner,
      group   => $group,
      require => Exec["get_${title}"],
    }
  }

  # Helper resource for the workshop files
  define workshop_file($location, $link) {
    remote_file { $title:
      remote_location => "${location}/${title}",
      mode            => '0644',
      owner           => $workshop::trainee_user,
      group           => $workshop::trainee_user,
    }
    
    file { "${link}/${title}":
      ensure  => link,
      target  => "${workshop::data_path}/${title}",
      owner   => $workshop::trainee_user,
      group   => $workshop::trainee_user,
      require => [Workshop_dir[$link], Remote_file[$title]],
    }
  }

  # Parent path
  workshop_dir { $parent_path:
    require => User[$trainee_user],
  }

  # Data directory
  workshop_dir { $data_path:
    require => Workshop_dir[$parent_path],
  }

  # Working directory
  workshop_dir { $working_path:
    require => Workshop_dir[$parent_path],
  }

}
