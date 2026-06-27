#!/usr/bin/env bash
set -e
cd "$(dirname "$(dirname "$(readlink -f "$0")")")"

ksc -- -t lua -d lua/kaitai kaitai_struct_formats/game/pvz_*.ksy
perl -pi -e's/require\("kaitaistruct"\)/local KaitaiStruct = require "kaitaistruct"[1]\nlocal KaitaiStream = require "kaitaistruct"[2]/' lua/kaitai/*.lua
perl -pi -e's/^([^. ]+) = /local \1 = /' lua/kaitai/*.lua
echo 'return PvzUsersDat' >>lua/kaitai/pvz_users_dat.lua
echo 'return PvzUserDat' >>lua/kaitai/pvz_user_dat.lua
echo 'return PvzMainPak' >>lua/kaitai/pvz_main_pak.lua
