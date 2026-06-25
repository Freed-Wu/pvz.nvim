-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
local KaitaiStruct = require "kaitaistruct"[1]
local str_decode = require("string_decode")

-- 
-- https://github.com/Freed-Wu/pvz.nvim provides tools to (de)serialize it.
-- See also: Source (https://github.com/chiaracoetzee/plants-vs-zombies-user-file-editor/blob/595523add14b649147218bcd059eeb18fe506e92/Plants%20vs.%20Zombies%20user%20file%20editor/FormSelectUser.cs#L111-L125)
local PvzUsersDat = class.class(KaitaiStruct)

function PvzUsersDat:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function PvzUsersDat:_read()
  self.version = self._io:read_u4le()
  if not(self.version == 14) then
    error("not equal, expected " .. 14 .. ", but got " .. self.version)
  end
  self.num_users = self._io:read_u2le()
  self.users = {}
  for i = 0, self.num_users - 1 do
    self.users[i + 1] = PvzUsersDat.UserEntry(self._io, self, self._root)
  end
end


PvzUsersDat.UserEntry = class.class(KaitaiStruct)

function PvzUsersDat.UserEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function PvzUsersDat.UserEntry:_read()
  self.len_name = self._io:read_u2le()
  self.name = str_decode.decode(self._io:read_bytes(self.len_name), "ASCII")
  self.timestamp = self._io:read_u4le()
  self.id = self._io:read_u4le()
end


return PvzUsersDat
