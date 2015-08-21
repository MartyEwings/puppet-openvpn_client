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
# String; defaults to `undef`.
#
# * `auth_user_pass`
# Absolute path; defaults to `undef`.
#
# * `ca`
# Absolute path; defaults to `undef`.
#
# * `cert`
# Absolute path; defaults to `undef`.
#
# * `cipher`
# String; defaults to `undef`.
#
# * `client`
# Bool; defaults to `true`.
#
# * `comp_lzo`
# String; defaults to `undef`.
#
# * `dev`
# String; defaults to `undef`.
#
# * `group`
# String; defaults to `undef`.
#
# * `key`
# Absolute path; defaults to `undef`.
#
# * `nobind`
# Bool; defaults to `true`.
#
# * `ns_cert_type`
# String; defaults to `undef`.
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
# Integer; defaults to `undef`.
#
# * `proto`
# String; defaults to `undef`.
#
# * `remote_cert_tls`
# String; defaults to `undef`.
#
# * `resolv_retry`
# String; defaults to `undef`.
#
# * `server`
# String; defaults to `$name`.
#
# * `tls_client`
# Bool; defaults to `true`.
#
# * `user`
# String; defaults to `undef`.
#
# * `verb`
# Integer; defaults to `undef`.
#
define openvpn_client::client(
  $auth              = undef,
  $auth_user_pass    = undef,
  $ca                = undef,
  $cert              = undef,
  $cipher            = undef,
  $client            = true,
  $comp_lzo          = undef,
  $custom_options    = [],
  $dev               = undef,
  $group             = undef,
  $key               = undef,
  $nobind            = true,
  $ns_cert_type      = undef,
  $persist_key       = true,
  $persist_remote_ip = true,
  $persist_tun       = true,
  $port              = undef,
  $proto             = undef,
  $remote_cert_tls   = undef,
  $resolv_retry      = undef,
  $server            = $name,
  $tls_client        = true,
  $user              = undef,
  $verb              = undef,
  ) {

  include openvpn_client

  validate_array($custom_options)
  validate_bool($client, $nobind, $persist_key, $persist_remote_ip,
  $persist_tun, $tls_client)
  unless $auth == undef { validate_string($auth) }
  unless $auth_user_pass == undef { validate_absolute_path($auth_user_pass) }
  unless $ca == undef { validate_absolute_path($ca) }
  unless $cert == undef { validate_absolute_path($cert) }
  unless $cipher == undef { validate_string($cipher) }
  unless $comp_lzo == undef { validate_string($comp_lzo) }
  unless $dev == undef { validate_string($dev) }
  unless $group == undef { validate_string($group) }
  unless $key == undef { validate_absolute_path($key) }
  unless $ns_cert_type == undef { validate_string($ns_cert_type) }
  unless $port == undef { validate_integer($port) }
  unless $proto == undef { validate_string($proto) }
  unless $remote_cert_tls == undef { validate_string($remote_cert_tls) }
  unless $resolv_retry == undef { validate_string($resolv_retry) }
  unless $server == undef { validate_string($server) }
  unless $user == undef { validate_string($user) }
  unless $verb == undef { validate_integer($verb) }

  file { "${::openvpn_client::openvpn_dir}/${server}.conf":
    mode    => '0640',
    content => template('openvpn_client/client.conf.erb')
  }

  File["${::openvpn_client::openvpn_dir}/${server}.conf"] ~>
  Service[$::openvpn_client::service_name]
}
