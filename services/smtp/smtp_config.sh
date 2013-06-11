#!/bin/bash

#Add hosts to hostfile
cat /vagrant/common_config/hosts >> /etc/hosts

Postfix was not set up.  Start with
  cp /usr/share/postfix/main.cf.debian /etc/postfix/main.cf
  .  If you need to make changes, edit
  /etc/postfix/main.cf (and others) as needed.  To view Postfix configuration
  values, see postconf(1).

  After modifying main.cf, be sure to run '/etc/init.d/postfix reload'.

#Start HAProxy
service haproxy start
