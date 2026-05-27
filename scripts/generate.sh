#!/usr/bin/env bash
set -e
cd "$(dirname "$(dirname "$(readlink -f "$0")")")"

ksc -- -t lua -d lua/pvz/kaitai assets/ksy/*
perl -pi -e's/require\("kaitaistruct"\)/local KaitaiStruct = require "kaitaistruct"[1]/' lua/pvz/kaitai/*.lua
perl -pi -e's/^([^. ]+) = /local \1 = /' lua/pvz/kaitai/*.lua
echo 'return Users' >>lua/pvz/kaitai/users.lua
echo 'return User' >>lua/pvz/kaitai/user.lua
