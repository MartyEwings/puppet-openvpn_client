[![Build Status](https://travis-ci.org/thejandroman/puppet-openvpn_client.svg)](https://travis-ci.org/thejandroman/puppet-openvpn_client)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with openvpn_client](#setup)
    * [What openvpn_client affects](#what-openvpn_client-affects)
    * [Beginning with openvpn_client](#beginning-with-openvpn_client)
4. [Usage Examples - Configuration options and additional functionality](#usage-examples)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module attempts to manage client OpenVPN connections. It does not manage
server configurations and it attempts to make no assumptions about client
configurations. The goal for the module is simplicity and versatility.

## Module Description

This module installs the OpenVPN package and manages the OpenVPN service via its
default class. It also includes a defined type to create and manage OpenVPN
client configurations. The template file for creating the client configuration
attempts to make no assumptions about options. All options can be turned off by
declaring them `undef` and custom options can be defined via a parameter.

## Setup

### What openvpn_client affects

* The OpenVPN default package manager package and its service impact, or execute
on the system it's installed on.

### Beginning with openvpn_client

All that is needed is to get started is to create an `openvpn_client::client`
defined type with the required parameters. Everything else should be handled
automatically with sane defaults.

## Usage Examples

```puppet
openvpn_client::client { 'openvpn.server':
  port => 1194,
  ca   => '/path/to/ca',
}
```

## Reference

### Classes

#### openvpn_client

Install the openvpn package and manage its service.

##### Parameters
 * `openvpn_dir`
 The directory created by the package to store the openvpn configs. Should be
 an absolute path. Defaults differ according to OS. See `params.pp`.

 * `package_name`
 The name of the OpenVPN package. Should be a string. Defaults differ according
 to OS. See `params.pp`.

 * `service_name`
 The name of the OpenVPN service. Should be a string. Defaults differ according
 to OS. See `params.pp`.

### Defined Types

#### openvpn_client::client

Configure a client connection and restart the OpenVPN service. Not all OpenVPN
services are represented as parameters; however, the parameter array
`custom_options` has been provided to provide extensibility.

 * `custom_options`
 An array containing strings to be appended to the end of the client
 configuration. Defaults to an empty array.

All of the following parameters are taken directly from the OpenVPN man page
where their descriptions can be found. Only default values and quirks will be
noted here.

 * `auth`
 String; defaults to `SHA256`.

 * `auth_user_pass`
 Absolute path; defaults to `undef`.

 * `ca`
 Absolute path; defaults to `undef`.

 * `cert`
 Absolute path; defaults to `undef`.

 * `cipher`
 String; defaults to `AES-256-CBC`.

 * `client`
 Bool; defaults to `true`.

 * `comp_lzo`
 String; defaults to `adaptive`.

 * `dev`
 String; defaults to `tun`.

 * `group`
 String; defaults to `nogroup`.

 * `key`
 Absolute path; defaults to `undef`.

 * `nobind`
 Bool; defaults to `true`.

 * `ns_cert_type`
 String; defaults to `server`.

 * `persist_key`
 Bool; defaults to `true`.

 * `persist_remote_ip`
 Bool; defaults to `true`.

 * `persist_tun`
 Bool; defaults to `true`.

 * `port`
 Integer; defaults to `1194`.

 * `proto`
 String; defaults to `udp`.

 * `remote_cert_tls`
 String; defaults to `server`.

 * `resolv_retry`
 String; defaults to `infinite`.

 * `server`
 String; defaults to `$name`.

 * `tls_client`
 Bool; defaults to `true`.

 * `user`
 String; defaults to `nobody`.

 * `verb`
 Integer; defaults to `3`.


## Limitations

This module has really only been tested on Ubuntu 12.04 and 14.04. Compatability
with EL6 and 7 has been attempted. Please send PRs for additional OSs or to fine
tune existing support; which brings us to...

## Development

PRs are welcome. Keep in mind the stated goals of the module are simplicity and
versatility while making no client configuration assumptions. Standard ground
rules for contributing apply; namely test and document everything.

Most development information can be found in CONTRIBUTING.md.
