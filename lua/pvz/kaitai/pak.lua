-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
local KaitaiStruct = require "kaitaistruct"[1]
local str_decode = require("string_decode")

local Pak = class.class(KaitaiStruct)

function Pak:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Pak:_read()
  self.magic = self._io:read_u8le()
  self.files = {}
  local i = 0
  while true do
    local _ = Pak.FileEntry(self._io, self, self._root)
    self.files[i + 1] = _
    if _.mark ~= 0 then
      break
    end
    i = i + 1
  end
end

-- 
-- Magic number (8 bytes).
-- 
-- File entries, stop when mark is not 0x00.

Pak.FileEntry = class.class(KaitaiStruct)

function Pak.FileEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Pak.FileEntry:_read()
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

-- 
-- 0x00 = has file, others = end.
-- 
-- 8-byte timestamp, ignored.

return Pak
