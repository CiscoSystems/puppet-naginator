# 
# class to define swift-node specific monitoring
#
class naginator::swift_target {

    class { "naginator::common_target":
    }

    @@nagios_service { "check_swift_${hostname}":
        check_command => "check_nrpe_1arg!check_swift",
        use => "generic-service",
        host_name => "$fqdn",
        service_description => "Check_Swift",
    }

    naginator::nrpe::command { "check_swift":
        command => "check_swift";
    }

    file { "check_swift":
        name => "/usr/lib/nagios/plugins/check_swift",
        source => 'puppet:///modules/naginator/check_swift',
        mode => 0755,
        owner => root,
        group => root,
        require => Package["nagios-plugins"],
        notify => Service["nagios-nrpe-server"],
    }

    @@nagios_service { "check_swift_dispersion_${hostname}":
        check_command => "check_nrpe_1arg!check_swift_dispersion",
        use => "generic-service",
        host_name => "$fqdn",
        service_description => "Check_Swift_Dispersion",
    }
    naginator::nrpe::command { "checks swift dispersion":
        command => "check_swift_dispersion";
    }

    file { "check_swift_dispersion":
        name => "/usr/lib/nagios/plugins/check_swift_dispersion",
        source => 'puppet:///modules/naginator/check_swift_dispersion',
        mode => 0755,
        owner => root,
        group => root,
        require => Package["nagios-plugins"],
        notify => Service["nagios-nrpe-server"],
    }

    @@nagios_service { "check_swift_object_servers${hostname}":
        check_command => "check_nrpe_1arg!check_swift_object_servers",
        use => "generic-service",
        host_name => "$fqdn",
        service_description => "Checks Swift Object Server",
    }
    naginator::nrpe::command { "check_swift_object_servers":
        command => "check_swift_object_servers";
    }

    file { "check_swift_object_servers":
        name => "/usr/lib/nagios/plugins/check_swift_object_servers",
        source => 'puppet:///modules/naginator/check_swift_object_servers',
        mode => 0755,
        owner => root,
        group => root,
        require => Package["nagios-plugins"],
        notify => Service["nagios-nrpe-server"],
    }

}
