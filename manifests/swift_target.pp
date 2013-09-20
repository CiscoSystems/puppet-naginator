#
# class to define swift-node specific monitoring
#
class naginator::swift_target {

    class { 'naginator::common_target':
    }

    @@nagios_service { "check_swift_${hostname}":
      check_command       => 'check_nrpe_1arg!check_swift',
      use                 => 'generic-service',
      host_name           => $fqdn,
      service_description => 'Check_Swift',
    }

    naginator::nrpe::command { 'check_swift':
      command => "check_swift -A http://$::controller_node_address:5000/v2.0/ \
      -U admin -K $admin_password  -V 1.1 -T admin";
    }

    file { 'check_swift':
      name    => '/usr/lib/nagios/plugins/check_swift',
      source  => 'puppet:///modules/naginator/check_swift',
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
      require => Package['nagios-plugins'],
      notify  => Service['nagios-nrpe-server'],
    }
}