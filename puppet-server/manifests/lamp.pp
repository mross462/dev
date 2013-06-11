package {'php5':
  ensure => present,
  before => File['/etc/php.ini'],
}

file {'/etc/php.ini':
  ensure => file,
}

package {'apache2':
  ensure => present,
}

service {'apache2':
    ensure => running,
    enable => true,
    require => Package['apache2'],
    subscribe => File['/etc/php.ini'],
}

package {"libapache2-mod-php5" :
    ensure => installed,
    require => Package["php5"]
}

package {'mysql-server':
  ensure => 'present',
}

service {'mysql':
  ensure => running,
  enable => true,
  require => Package['mysql-server'],
}
