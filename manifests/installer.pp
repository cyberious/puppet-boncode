define boncode::installer($installDir = hiera("boncode::installDir","D:/software/")) {
  include 'boncode::params'

  file {"BonCodeUnzip":
    path    => "${installDir}/Unzip.ps1",
    source  => "puppet:///modules/boncode/Unzip.ps1"
  }->
  file {"${installDir}/BonCodeAjp13_${boncode::params::version}.zip":
    source  => "puppet:///modules/boncode/AJP13_${boncode::params::version}.zip",
    notify  => Exec['ExpandAjpZip']
  }->
  exec {'ExpandAjpZip':
    provider    => powershell,
    command     => "${installDir}\\Unzip.ps1 -InstallDir ${installDir} -Version ${boncode::params::version}",
    refreshonly => true,
    require     => File['BonCodeUnzip']
  }->
  file {'BonCodeInstallSettings':
    path    => "${installDir}/BonCode/${boncode::params::version}/installer.settings",
    ensure  => file,
    content => template("boncode/installer.settings.erb"),
    before => Package['BonCode AJP 1.3 Connector']
  }->
  package {'BonCode AJP 1.3 Connector':
    provider  =>  windows,
    ensure    =>  installed,
    source    =>  "D:/Software/Boncode/${boncode::params::version}/Connector_Setup.exe",
    install_options => ['/VERYSILENT','/SUPPRESSMSGBOXES','/LOG','/SP-','/NOCANCEL','/NORESTART'],
    require   => File['BonCodeInstallSettings']
  }

  file{"BonCodeServerSettings":
    path    => 'C:\windows\BonCodeAJP13.settings',
    content => template('boncode/BonCodeRoot.settings.erb'),
    require => Package['BonCode AJP 1.3 Connector']
  }

}