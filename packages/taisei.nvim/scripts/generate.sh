#!/usr/bin/env bash
set -e
cd "$(dirname "$(dirname "$(readlink -f "$0")")")"

ksc -- -t lua -d lua/kaitai ../../kaitai_struct_formats/game/taisei_*.ksy
perl -pi -e's/require\("kaitaistruct"\)/local KaitaiStruct = require "kaitaistruct"[1]\nlocal KaitaiStream = require "kaitaistruct"[2]/' lua/kaitai/*.lua
perl -pi -e's/^([^. ]+) = /local \1 = /' lua/kaitai/*.lua
echo 'return TaiseiProgress' >>lua/kaitai/taisei_progress.lua
