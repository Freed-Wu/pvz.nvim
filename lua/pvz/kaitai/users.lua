-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
local KaitaiStruct = require "kaitaistruct"[1]
local str_decode = require("string_decode")

local Users = class.class(KaitaiStruct)

function Users:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function Users:_read()
  self.version = self._io:read_u4le()
  self.num_users = self._io:read_u2le()
  self.users = {}
  for i = 0, self.num_users - 1 do
    self.users[i + 1] = Users.UserEntry(self._io, self, self._root)
  end
end

-- 
-- 版本号，必须为 0x0E.
-- 
-- 用户数量.

Users.UserEntry = class.class(KaitaiStruct)

function Users.UserEntry:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function Users.UserEntry:_read()
  self.len_name = self._io:read_u2le()
  self.name = str_decode.decode(self._io:read_bytes(self.len_name), "ASCII")
  self.timestamp = self._io:read_u4le()
  self.id = self._io:read_u4le()
end

-- 
-- 用户名长度.
-- 
-- 时间戳.
-- 
-- 文件编号.

return Users
