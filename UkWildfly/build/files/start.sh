#!/bin/sh
PATH="$(dirname "$0")":$PATH
config-standalone.sh $@
add-user.sh -r ManagementRealm -u system -p kinjirou 
standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0