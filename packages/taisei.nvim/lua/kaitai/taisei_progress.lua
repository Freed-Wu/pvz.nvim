-- This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild
--
-- This file is compatible with Lua 5.3

local class = require("class")
local KaitaiStruct = require "kaitaistruct"[1]
local KaitaiStream = require "kaitaistruct"[2]
local enum = require("enum")
local stringstream = require("string_stream")
local str_decode = require("string_decode")

-- 
-- See also: Source (https://github.com/taisei-project/taisei/blob/master/src/progress.c)
local TaiseiProgress = class.class(KaitaiStruct)

TaiseiProgress.ProgfileCommand = enum.Enum {
  unlock_stages = 0,
  unlock_stages_with_difficulty = 1,
  hiscore = 2,
  stage_playinfo = 3,
  endings = 4,
  game_settings = 5,
  game_version = 6,
  unlock_bgms = 7,
  unlock_cutscenes = 8,
  hiscore_64bit = 9,
  stage_playinfo2 = 16,
}

function TaiseiProgress:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root or self
  self:_read()
end

function TaiseiProgress:_read()
  self.magic = self._io:read_u8le()
  if not(self.magic == 0x8483e36f66746700) then
    error("not equal, expected " .. 0x8483e36f66746700 .. ", but got " .. self.magic)
  end
  self.checksum = self._io:read_u4le()
  self.cmds = {}
  local i = 0
  while not self._io:is_eof() do
    self.cmds[i + 1] = TaiseiProgress.Cmd(self._io, self, self._root)
    i = i + 1
  end
end

-- 
-- CRC32 of the commands_raw, seed is 0xB16B00B5.

TaiseiProgress.Cmd = class.class(KaitaiStruct)

function TaiseiProgress.Cmd:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function TaiseiProgress.Cmd:_read()
  self.id = TaiseiProgress.ProgfileCommand(self._io:read_u1())
  self.len_payload = self._io:read_u2le()
  local _on = self.id
  if _on == TaiseiProgress.ProgfileCommand.endings then
    self._raw_payload = self._io:read_bytes(self.len_payload)
    local _io = KaitaiStream(stringstream(self._raw_payload))
    self.payload = TaiseiProgress.Endings(_io, self, self._root)
  elseif _on == TaiseiProgress.ProgfileCommand.game_settings then
    self._raw_payload = self._io:read_bytes(self.len_payload)
    local _io = KaitaiStream(stringstream(self._raw_payload))
    self.payload = TaiseiProgress.Settings(_io, self, self._root)
  elseif _on == TaiseiProgress.ProgfileCommand.game_version then
    self._raw_payload = self._io:read_bytes(self.len_payload)
    local _io = KaitaiStream(stringstream(self._raw_payload))
    self.payload = TaiseiProgress.Version(_io, self, self._root)
  elseif _on == TaiseiProgress.ProgfileCommand.hiscore then
    self.payload = self._io:read_u4le()
  elseif _on == TaiseiProgress.ProgfileCommand.hiscore_64bit then
    self.payload = self._io:read_u8le()
  elseif _on == TaiseiProgress.ProgfileCommand.stage_playinfo then
    self._raw_payload = self._io:read_bytes(self.len_payload)
    local _io = KaitaiStream(stringstream(self._raw_payload))
    self.payload = TaiseiProgress.Playinfos(_io, self, self._root)
  elseif _on == TaiseiProgress.ProgfileCommand.stage_playinfo2 then
    self._raw_payload = self._io:read_bytes(self.len_payload)
    local _io = KaitaiStream(stringstream(self._raw_payload))
    self.payload = TaiseiProgress.Playinfo2s(_io, self, self._root)
  elseif _on == TaiseiProgress.ProgfileCommand.unlock_bgms then
    self.payload = self._io:read_u8le()
  elseif _on == TaiseiProgress.ProgfileCommand.unlock_cutscenes then
    self.payload = self._io:read_u8le()
  elseif _on == TaiseiProgress.ProgfileCommand.unlock_stages then
    self.payload = self._io:read_u2le()
  elseif _on == TaiseiProgress.ProgfileCommand.unlock_stages_with_difficulty then
    self._raw_payload = self._io:read_bytes(self.len_payload)
    local _io = KaitaiStream(stringstream(self._raw_payload))
    self.payload = TaiseiProgress.Header(_io, self, self._root)
  else
    self.payload = str_decode.decode(self._io:read_bytes(self.len_payload), "ASCII")
  end
end


TaiseiProgress.Endings = class.class(KaitaiStruct)

function TaiseiProgress.Endings:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function TaiseiProgress.Endings:_read()
  self.ending = self._io:read_u1()
  self.num_achieved = self._io:read_u4le()
end


TaiseiProgress.Header = class.class(KaitaiStruct)

function TaiseiProgress.Header:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function TaiseiProgress.Header:_read()
  self.stage = self._io:read_u2le()
  self.difficulty = self._io:read_u1()
end


TaiseiProgress.Percharacter = class.class(KaitaiStruct)

function TaiseiProgress.Percharacter:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function TaiseiProgress.Percharacter:_read()
  self.permodes = {}
  for i = 0, 2 - 1 do
    self.permodes[i + 1] = TaiseiProgress.Permode(self._io, self, self._root)
  end
end


TaiseiProgress.Permode = class.class(KaitaiStruct)

function TaiseiProgress.Permode:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function TaiseiProgress.Permode:_read()
  self.num_played = self._io:read_u4le()
  self.num_cleared = self._io:read_u4le()
  self.hiscore = self._io:read_u8le()
end


TaiseiProgress.Playinfo = class.class(KaitaiStruct)

function TaiseiProgress.Playinfo:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function TaiseiProgress.Playinfo:_read()
  self.header = TaiseiProgress.Header(self._io, self, self._root)
  self.num_played = self._io:read_u4le()
  self.num_cleared = self._io:read_u4le()
end


TaiseiProgress.Playinfo2 = class.class(KaitaiStruct)

function TaiseiProgress.Playinfo2:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function TaiseiProgress.Playinfo2:_read()
  self.header = TaiseiProgress.Header(self._io, self, self._root)
  self.hiscore = self._io:read_u8le()
  self.percharacters = {}
  for i = 0, 3 - 1 do
    self.percharacters[i + 1] = TaiseiProgress.Percharacter(self._io, self, self._root)
  end
end


TaiseiProgress.Playinfo2s = class.class(KaitaiStruct)

function TaiseiProgress.Playinfo2s:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function TaiseiProgress.Playinfo2s:_read()
  self.playinfos = {}
  local i = 0
  while not self._io:is_eof() do
    self.playinfos[i + 1] = TaiseiProgress.Playinfo2(self._io, self, self._root)
    i = i + 1
  end
end


TaiseiProgress.Playinfos = class.class(KaitaiStruct)

function TaiseiProgress.Playinfos:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function TaiseiProgress.Playinfos:_read()
  self.playinfos = {}
  local i = 0
  while not self._io:is_eof() do
    self.playinfos[i + 1] = TaiseiProgress.Playinfo(self._io, self, self._root)
    i = i + 1
  end
end


TaiseiProgress.Settings = class.class(KaitaiStruct)

function TaiseiProgress.Settings:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function TaiseiProgress.Settings:_read()
  self.difficulty = self._io:read_u1()
  self.character = self._io:read_u1()
  self.shotmode = self._io:read_u1()
end


TaiseiProgress.Version = class.class(KaitaiStruct)

function TaiseiProgress.Version:_init(io, parent, root)
  KaitaiStruct._init(self, io)
  self._parent = parent
  self._root = root
  self:_read()
end

function TaiseiProgress.Version:_read()
  self.major = self._io:read_u1()
  self.minor = self._io:read_u1()
  self.patch = self._io:read_u1()
  self.tweak = self._io:read_u2le()
end


return TaiseiProgress
