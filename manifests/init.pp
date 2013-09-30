# == Class: BonCode
#
# Full description of class BonCode here.
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
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { boncode:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
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
class boncode {
       	$installDir = "D:/software/"
        $sourceDir  = '\\storage1\files\shared\tfields'
        $port = 18009
        $host = "localhost"
        $version = "v1014"
	
	file{"C:\inetpub\wwwroot\BIN\BonCodeAJP13.settings":
                source  => 'puppet:///modules/boncode/BonCode-site.settings',
		require => Package['BonCode AJP 1.3 Connector']
        }
        file{"C:\inetpub\wwwroot\web.config":
                source  => 'puppet:///modules/boncode/web.config',
		require => Package['BonCode AJP 1.3 Connector']
        }
        file{"C:\windows\BonCodeAJP13.settings":
                source  => 'puppet:///modules/boncode/BonCodeRoot.settings',
		require	=> Package['BonCode AJP 1.3 Connector']
        }

        file {"${installDir}/BonCodeAjp13_${version}.zip":
                source  => "puppet:///modules/boncode/AJP13_${version}.zip",
                notify  => Exec['ExpandAjpZip']
        }

        file {"BonCodeUnzip":
                path    => "${installDir}/Unzip.ps1",
                source  => "puppet:///modules/boncode/Unzip.ps1"
        }

        exec {'ExpandAjpZip':
                provider=> powershell,
                command => "${installDir}\Unzip.ps1 -InstallDir ${installDir} -Version ${version}",
                refreshonly     => true,
                require => File['BonCodeUnzip']
        }
        file {'BonCodeInstallSettings':
                path    => "D:/software/BonCode/${version}/installer.settings",
		ensure	=> file,
                content => template("boncode/installer.settings.erb")
        }
        package {'BonCode AJP 1.3 Connector':
                provider  =>  windows,
                ensure    =>  installed,
                source    =>  "D:/Software/Boncode/${version}/Connector_Setup.exe",
                install_options => ['/VERYSILENT','/SUPPRESSMSGBOXES','/LOG','/SP-','/NOCANCEL','/NORESTART']
        }


}
