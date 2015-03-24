class sauceconnect::daemon($username, $apikey, $sharedtunnel = false ) {
  $logdir = '/var/log/sauce'

  $switches = $sharedtunnel ? {
    true    => '--shared-tunnel',
    default => '',
  }

  file {
    $logdir :
      ensure => directory;

    '/etc/default/sauce-connect' :
      ensure  => present,
      content => "
SAUCE_CONNECT=/usr/share/sauce/sc
SWITCHES=${switches}
API_USER=${username}
API_KEY=${apikey}
USERNAME=
GROUP=
LOG_DIR=${logdir}
LOG_FILE=${logdir}/sc.log
";

    '/etc/init.d/sauce-connect' :
      ensure => 'present',
      mode   => 0755,
      notify => Service['sauce-connect'],
      source => 'puppet:///modules/sauceconnect/init.d_sauce-connect';
  }

  service {
    'sauce-connect' :
      ensure     => running,
      hasrestart => true,
      hasstatus  => true;
  }
}
