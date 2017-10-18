# Set up periodic yum updates
class yumupdate (
  Integer $hour = $::yum_hour,
  Integer $minute = $::yum_minute,
  Array $exclude = [],
) {
  if $::osfamily == 'RedHat' {

    # basic yum.conf
    file { 'yum.conf':
      ensure => file,
      name   => '/etc/yum.conf',
      mode   => '0644',
      owner  => 'root',
      group  => 'root',
      source => 'puppet:///modules/yumupdate/yum.conf',
    }

    # boot-time updates cause problems when the network is down, so we remove it
    package { 'yum-updateonboot':
      ensure => absent,
    }

    # Install the yum-security plugin to enable monitoring of updates
    # Only needed on EL6 and is included by default on EL7
    if versioncmp($::operatingsystemmajrelease, '6') == 0 {
      package { 'yum-plugin-security':
        ensure => installed,
      }
    }

    # Run yum updates every weekday
    cron { 'yum-update':
      hour    => $hour,
      minute  => $minute,
      weekday => ['1-5'],
      command => '/usr/bin/yum-update.bash',
      require => File['yum-update.bash'],
    }

    # Install yum update script
    file { 'yum-update.bash':
      name    => '/usr/bin/yum-update.bash',
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
      content => template('yumupdate/yum-update.bash.erb'),
    }

    # Override OS default rotation which is yearly
    logrotate::rule { 'yum':
      path         => '/var/log/yum.log',
      missingok    => true,
      ifempty      => false,
      rotate_every => 'month',
      rotate       => 6,
      create       => true,
      create_mode  => '0600',
      create_owner => 'root',
      create_group => 'root',
    }
  }
}
