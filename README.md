# LogChan

*print channeled logs*

LogChan is a simple tool to print to named channels and disable channels at
will. Create the logger instance `local log = LogChan()` and then either pass
channel names as an argument `log:print("Audio", "Loud")` or index the `ch`
table directly `log.ch.Audio:print("Noises")`.


# Examples

    -- write logs
	local log = LogChan()
	log:print("Audio", "Can you hear this?")   [Audio]	Can you hear this?
	log:printf("Camera", "Look %s", "left")    [Camera]	Look left

    -- disable_all
	local log = LogChan()
	log:print("Audio", "Audible")              [Audio]	Audible
	log:disable_all()
	log:print("Audio", "Inaudible")
	log:print("NewChan", "Invisible")

    -- disable_all and enable one
	local log = LogChan()
	log:print("Audio", "Audible")              [Audio]	Audible
	log:print("Rendering", "Visible")          [Rendering]	Visible
	log:disable_all()
	log:enable_channel("Audio")
	log:print("Audio", "Loud noises")          [Audio]	Loud noises
	log:print("Rendering", "Invisible")

    -- dot syntax
	local log = LogChan()
	log.ch.Audio:print("Audible")              [Audio]	Audible
	log.ch.Rendering:print("Visible")          [Rendering]	Visible
	log:disable_channel("Rendering")
	log.ch.Audio:print("Loud noises")          [Audio]	Loud noises
	log.ch.Rendering:print("Invisible")


# License

Redistribute/modify under the terms of the MIT license. See LICENSE for
details.

