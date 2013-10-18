
class boncode::params {
  $port                     = hiera("boncode::tomcatAjpPort",18009)
  $host                     = hiera("boncode::hostname","localhost")
  $customErrors             = hiera("boncode::customErros","Off")
  $execTimeout              = hiera("boncode::execTimeout",7200)
  $version                  = hiera("boncode::version","v1014")
  $packetSize               = hiera("boncode::packetSize",65536)
  $enableHTTPStatusCodes    = hiera("boncode::enableHttpStatusCodes","False")
  $enableHeaderDataSupport  = hiera("boncode::enableHeaderDataSupport","True")
  $enableRemoteAdmin        = hiera("boncode::enableRemoteAdmin","False")
  $allowEmptyHeaders        = hiera("boncode::allowEmptyHeaders","True")
  $maxConnections           = hiera("boncode::maxConnections",500)
  $flushThreshold           = hiera("boncode::fulshThreshold",0)
  $writeTimeOut             = hiera("boncode::writeTimeOut",30000)
  $logDir                   = hiera("boncode::logDir",'d:\log')
  $logLevel                 = hiera("boncode::logLevel",2)

}