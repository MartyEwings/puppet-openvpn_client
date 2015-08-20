# Defined Type: openvpn_client::client
# ===========================
#
# Create and manage a client configuration for OpenVPN.
#
# Parameters
# ----------
#
# * `custom_options`
# An array containing strings to be appended to the end of the client
# configuration. Defaults to an empty array.
#
# All of the following parameters are taken directly from the OpenVPN man page
# where their descriptions can be found. Only default values and quirks will be
# noted here.
#
# * `auth`
# String; defaults to `SHA256`.
#
# * `auth_user_pass`
# Absolute path; defaults to `undef`.
#
# * `ca`
# Absolute path; defaults to `undef`.
#
# * `cipher`
# String; defaults to `AES-256-CBC`.
#
# * `client`
# Bool; defaults to `true`.
#
# * `comp_lzo`
# String; defaults to `adaptive`.
#
# * `dev`
# String; defaults to `tun`.
#
# * `nobind`
# Bool; defaults to `true`.
#
# * `persist_key`
# Bool; defaults to `true`.
#
# * `persist_remote_ip`
# Bool; defaults to `true`.
#
# * `persist_tun`
# Bool; defaults to `true`.
#
# * `port`
# Integer; defaults to `1194`.
#
# * `proto`
# String; defaults to `udp`.
#
# * `remote_cert_tls`
# String; defaults to `server`.
#
# * `resolv_retry`
# String; defaults to `infinite`.
#
# * `server`
# String; defaults to `$name`.
#
# * `tls_client`
# Bool; defaults to `true`.
#
# * `verb`
# Integer; defaults to `3`.
#
define openvpn_client::client(
  $auth              = 'SHA256',
  $auth_user_pass    = undef,
  $ca                = undef,
  $cipher            = 'AES-256-CBC',
  $client            = true,
  $comp_lzo          = 'adaptive',
  $custom_options    = [],
  $dev               = 'tun',
  $nobind            = true,
  $persist_key       = true,
  $persist_remote_ip = true,
  $persist_tun       = true,
  $port              = 1194,
  $proto             = 'udp',
  $remote_cert_tls   = 'server',
  $resolv_retry      = 'infinite',
  $server            = $name,
  $tls_client        = true,
  $verb              = 3,
  ) {

  include openvpn_client

  validate_array($custom_options)
  unless $auth == undef { validate_string($auth) }
  unless $auth_user_pass == undef { validate_absolute_path($auth_user_pass) }
  unless $ca == undef { validate_absolute_path($ca) }
  unless $cipher == undef { validate_string($cipher) }
  unless $client == undef { validate_bool($client) }
  unless $comp_lzo == undef { validate_string($comp_lzo) }
  unless $dev == undef { validate_string($dev) }
  unless $nobind == undef { validate_bool($nobind) }
  unless $persist_key == undef { validate_bool($persist_key) }
  unless $persist_remote_ip == undef { validate_bool($persist_remote_ip) }
  unless $persist_tun == undef { validate_bool($persist_tun) }
  unless $port == undef { validate_integer($port) }
  unless $proto == undef { validate_string($proto) }
  unless $remote_cert_tls == undef { validate_string($remote_cert_tls) }
  unless $resolv_retry == undef { validate_string($resolv_retry) }
  unless $server == undef { validate_string($server) }
  unless $tls_client == undef { validate_bool($tls_client) }
  unless $verb == undef { validate_integer($verb) }

  file { "${::openvpn_client::openvpn_dir}/${server}.conf":
    mode    => '0640',
    content => template('openvpn_client/client.conf.erb')
  }

  File["${::openvpn_client::openvpn_dir}/${server}.conf"] ~>
  Service[$::openvpn_client::service_name]
}
