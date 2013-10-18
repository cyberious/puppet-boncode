
define boncode::site_settings($site_root = hiera("boncode::site_settings::root",'c:\inetpub\wwwroot')) {
  include 'boncode::params'

  file{"BonCodeSiteBin":
    path    => "${site_root}\\BIN",
    ensure  => directory,
    recurse => true
  }->
  file{'BonCodeSiteSettings':
    path    => "${site_root}\\BIN\\BonCodeAJP13.settings",
    content => template('boncode/BonCodeSite.settings.erb'),
    require => Package['BonCode AJP 1.3 Connector']
  }->
  file{"BonCodeWebConfig":
    path    => "${site_root}\\web.config",
    content => template('boncode/web.config.erb'),
    require => Package['BonCode AJP 1.3 Connector']
  }
}