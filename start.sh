#!/bin/bash

[[ -d /dev/net ]] || mkdir -p /dev/net
[[ -c /dev/net/tun ]] || mknod /dev/net/tun c 10 200

if [ ! -f /tmp/pass_set ]; then
  if [ ! -z ${OPENVPN_PASS} ]; then
    echo "${OPENVPN_PASS}" | passwd --stdin openvpn
    pass=${OPENVPN_PASS}
  else
    pass=$(openssl rand -base64 32)
    echo "${pass}" | passwd --stdin openvpn
  fi

  echo "To login to OpenVPN, use the following credentials:"
  echo "username: openvpn"
  echo "password: ${pass}"
fi

touch /tmp/pass_set

if [ -f /vpn.pid ]; then
  echo "Not shutdown properly, removing stale pid"
  rm /vpn.pid
fi

exec /usr/local/openvpn_as/scripts/openvpnas -n --pidfile /vpn.pid -l -
