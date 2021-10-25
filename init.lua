--
-- logchan -- print channeled logs
--
-- Copyright (c) 2021, David Briscoe
--
-- This module is free software; you can redistribute it and/or modify it under
-- the terms of the MIT license. See LICENSE for details.
--

-- Required when using testy.
--~ package.path = package.path .. ';./?.lua'

local Class = require "classic"


local Channel = Class:extend()

function Channel:new(name)
	self.label = ("[%s]"):format(name)
end
function Channel:print(...)
	print(self.label, ...)
end

function Channel:printf(fmt, ...)
	print(self.label, fmt:format(...))
end

local function noop() end

local void_channel = Channel("Void")
void_channel.print = noop
void_channel.printf = noop



local LogChan = Class:extend()

function LogChan:new()
	self.auto_enable = true

	local autoget_mt = {
		__index = function(t, key)
			assert(type(key) == 'string', key)
			return self:_get_or_create_channel(key)
		end,
	}
	self.ch = {}
	setmetatable(self.ch, autoget_mt)
end

function LogChan:_get_or_create_channel(chan_name)
	local ch = rawget(self.ch, chan_name)
	if not ch then
		if self.auto_enable then
			ch = Channel(chan_name)
		else
			ch = void_channel
		end
		self.ch[chan_name] = ch
	end
	return ch
end

function LogChan:print(chan_name, ...)
	local ch = self:_get_or_create_channel(chan_name)
	ch:print(...)
end

function LogChan:printf(chan_name, ...)
	local ch = self:_get_or_create_channel(chan_name)
	ch:printf(...)
end

function LogChan:enable_channel(chan_name)
	self.ch[chan_name] = Channel(chan_name)
end

function LogChan:disable_channel(chan_name)
	self.ch[chan_name] = void_channel
end

function LogChan:enable_all()
	for chan_name,ch in pairs(self.ch) do
		self:enable_channel(chan_name)
	end
	self.auto_enable = true
end

function LogChan:disable_all()
	for chan_name,ch in pairs(self.ch) do
		self:disable_channel(chan_name)
	end
	self.auto_enable = false
end


-- Test with testy.lua {{{

local function test_multiple_channels()
	local log = LogChan()
	print()
	log:print("Audio", "Can you hear this?")
	log:printf("Camera", "Look %s", "left")
end

local function test_disable_all()
	local log = LogChan()
	print()
	log:print("Audio", "Audible")
	log:disable_all()
	log:print("Audio", "Inaudible")
	log:print("NewChan", "Invisible")
end

local function test_disable_all_enable_one()
	local log = LogChan()
	print()
	log:print("Audio", "Audible")
	log:print("Rendering", "Visible")
	log:disable_all()
	log:enable_channel("Audio")
	log:print("Audio", "Loud noises")
	log:print("Rendering", "Invisible")
end

local function test_preconfigure()
	local log = LogChan()
	print()
	log:disable_all()
	log:enable_channel("Audio")
	log:enable_channel("Camera")
	log:print("Audio", "Loud noises")
	log:print("Rendering", "Invisible")
	log:printf("Camera", "Look %s", "left")
	log.ch.Audio:print("Loud noises")
	log.ch.Rendering:print("Invisible")
	log.ch.Camera:printf("Look %s", "left")
end


local function test_dot_syntax()
	local log = LogChan()
	print()
	log.ch.Audio:print("Audible")
	log.ch.Rendering:print("Visible")
	log:disable_channel("Rendering")
	log.ch.Audio:print("Loud noises")
	log.ch.Rendering:print("Invisible")
end

-- }}}

return LogChan
