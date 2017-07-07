class sauceconnect($username="", $apikey="", $sharedtunnel = true ) {
  $dir = '/usr/share/sauce'

  file {
    $dir :
      ensure => directory;

    "$dir/sc" :
      ensure  => present,
      require => File[$dir],
      source  => 'puppet:///modules/sauceconnect/sc';
  }
  
  $lower_osfamily = downcase(${osfamily})

  class {
    "sauceconnect::${lower_osfamily}" : ;
    'sauceconnect::daemon' :
      username     => $username,
      apikey       => $apikey,
      sharedtunnel => $sharedtunnel,
  }
}
