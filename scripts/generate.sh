#!/usr/bin/env bash
set -e
cd "$(dirname "$(dirname "$(readlink -f "$0")")")"

ksc -- -t lua -d lua/pvz/kaitai kaitai_struct_formats/game/pvz_*.ksy
perl -pi -e's/require\("kaitaistruct"\)/local KaitaiStruct = require "kaitaistruct"[1]/' lua/pvz/kaitai/*.lua
perl -pi -e's/^([^. ]+) = /local \1 = /' lua/pvz/kaitai/*.lua
echo 'return PvzUsersDat' >>lua/pvz/kaitai/pvz_users_dat.lua
echo 'return PvzUserDat' >>lua/pvz/kaitai/pvz_user_dat.lua
echo 'return PvzMainPak' >>lua/pvz/kaitai/pvz_main_pak.lua
