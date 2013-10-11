#
# class for configuration needed on all nodes
# (both Nagios server and all monitored clients)
#

class naginator::base_target (
  $public_address = $::service_address,
){

    include naginator::params

    @@nagios_host { $::fqdn:
        ensure  => present,
        alias   => $::hostname,
        address => $public_address,
        use     => 'generic-host',
        notify  => Service[$naginator::params::service_name],
    }

    @@nagios_hostextinfo { $::fqdn:
        ensure => present,
    }

    @@nagios_service { "check_ping_${hostname}":
        check_command       => 'check_ping!100.0,20%!500.0,60%',
        use                 => 'generic-service',
        host_name           => $::fqdn,
        notification_period => '24x7',
        service_description => "check_ping_${hostname}",
    }

}
