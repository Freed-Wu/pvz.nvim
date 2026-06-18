-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
local KaitaiStruct = require "kaitaistruct"[1]
local str_decode = require("string_decode")

-- 
-- Before parse, use 0xF7 to xor decrypt.
-- After file_entry, the following is file contents without any gap.
-- 
-- https://github.com/Freed-Wu/pvz.nvim provides tools to (de)serialize it.
-- See also: Source (https://plantsvszombies.fandom.com/wiki/Modify_Plants_vs._Zombies)
local PvzMainPak = class.class(KaitaiStruct)

function PvzMainPak:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function PvzMainPak:_read()
  self.magic = self._io:read_u8le()
  if not(self.magic == 3133164224) then
    error("not equal, expected " .. 3133164224 .. ", but got " .. self.magic)
  end
  self.files = {}
  local i = 0
  while true do
    local _ = PvzMainPak.FileEntry(self._io, self, self._root)
    self.files[i + 1] = _
    if _.mark ~= 0 then
      break
    end
    i = i + 1
  end
end


PvzMainPak.FileEntry = class.class(KaitaiStruct)

function PvzMainPak.FileEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function PvzMainPak.FileEntry:_read()
  self.mark = self._io:read_u1()
  if self.mark == 0 then
    self.len_name = self._io:read_u1()
  end
  if self.mark == 0 then
    self.name = str_decode.decode(self._io:read_bytes(self.len_name), "ASCII")
  end
  if self.mark == 0 then
    self.size = self._io:read_u4le()
  end
  if self.mark == 0 then
    self.timestamp = self._io:read_u8le()
  end
end


