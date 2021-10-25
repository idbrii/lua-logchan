package.path = package.path .. ';./?.lua'

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
	self.channels = {}
	self.auto_enable = true
end

function LogChan:_get_or_create_channel(chan_name)
	local ch = self.channels[chan_name]
	if not ch then
		if self.auto_enable then
			ch = Channel(chan_name)
		else
			ch = void_channel
		end
		self.channels[chan_name] = ch
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
	self.channels[chan_name] = Channel(chan_name)
end

function LogChan:disable_channel(chan_name)
	self.channels[chan_name] = void_channel
end

function LogChan:enable_all()
	for chan_name,ch in pairs(self.channels) do
		self:enable_channel(chan_name)
	end
	self.auto_enable = true
end

function LogChan:disable_all()
	for chan_name,ch in pairs(self.channels) do
		self:disable_channel(chan_name)
	end
	self.auto_enable = false
end


-- Test with testy.lua {{{

local function test_multiple_channels()
	local lc = LogChan()
	print()
	lc:print("Audio", "Can you hear this?")
	lc:printf("Camera", "Look %s", "left")
end

local function test_disable_all()
	local lc = LogChan()
	print()
	lc:print("Audio", "Audible")
	lc:disable_all()
	lc:print("Audio", "Inaudible")
	lc:print("NewChan", "Invisible")
end

local function test_disable_all_enable_one()
	local lc = LogChan()
	print()
	lc:print("Audio", "Audible")
	lc:print("Rendering", "Visible")
	lc:disable_all()
	lc:enable_channel("Audio")
	lc:print("Audio", "Loud noises")
	lc:print("Rendering", "Invisible")
end

-- }}}

return LogChan
