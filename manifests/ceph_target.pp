# class to define ceph-node specific monitoring

class naginator::ceph_target inherits naginator::common_target {

    include naginator::params

    @@nagios_service { "check_ceph_keyring${hostname}":
        check_command       => "check_nrpe_1arg!check_ceph_keyring",
        use                 => "generic-service",
        host_name           => "$fqdn",
        service_description => "Check Ceph Keyring",
    }
    naginator::nrpe::command { "check_ceph_keyring":
        command => "check_ceph_health --id admin -k /etc/ceph/keyring";
    }
    @@nagios_service { "check_ceph_conf_${hostname}":
        check_command       => "check_nrpe_1arg!check_ceph_conf",
        use                 => "generic-service",
        host_name           => "$fqdn",
        service_description => "Check Ceph Conf",
    }
    naginator::nrpe::command { "check_ceph_conf":
        command => "check_ceph_health --id admin -c /etc/ceph/ceph.conf";
    }
    @@nagios_service { "check_ceph_detail_${hostname}":
        check_command       => "check_nrpe_1arg!check_ceph_detail",
        use                 => "generic-service",
        host_name           => "$fqdn",
        service_description => "Check Ceph Detail",
    }
    naginator::nrpe::command { "check_ceph_detail":
        command => "check_ceph_health --id admin -d";
    }
    @@nagios_service { "check_ceph_executable_${hostname}":
        check_command       => "check_nrpe_1arg!check_ceph_executable",
        use                 => "generic-service",
        host_name           => "$fqdn",
        service_description => "Check Ceph executable",
    }
    naginator::nrpe::command { "check_ceph_executable":
        command => "check_ceph_health --id admin -e /usr/bin/ceph";
    }

    file { "check_ceph_health":
        name    => "${::naginator::params::plugin_dir}/check_ceph_health",
        source  => 'puppet:///modules/naginator/check_ceph_health',
        mode    => 0755,
        owner   => root,
        group   => root,
        require => Package[$::naginator::params::nagios_plugin],
        notify  => Service[$::naginator::params::nrpe_service],
    }

}
