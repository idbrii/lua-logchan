# LogChan

*print channeled logs*

LogChan is a simple tool to print to named channels and disable channels at
will. Create the logger instance `local log = LogChan()` and then either pass
channel names as an argument `log:print("Audio", "Loud")` or index the `ch`
table directly `log.ch.Audio:print("Noises")`.


# Examples

## Multiple Channels and Format Print

	local log = LogChan()
	log:print("Audio", "Can you hear this?")
	log:printf("Camera", "Look %s", "left")

### Output

    [Audio]	Can you hear this?
    [Camera]	Look left


## Disable All

	local log = LogChan()
	-- new channels are enabled by default
	log:print("Audio", "Audible")
	log:disable_all()
	log:print("Audio", "Inaudible")
	-- after disable all, new channels default to disabled
	log:print("NewChan", "Invisible")

### Output

    [Audio]	Audible


## Disable All and Enable One

	local log = LogChan()
	log:print("Audio", "Audible")
	log:print("Rendering", "Visible")
	log:disable_all()
	log:enable_channel("Audio")
	log:print("Audio", "Loud noises")
	log:print("Rendering", "Invisible")

### Output

    [Audio]	Audible
    [Rendering]	Visible
    [Audio]	Loud noises


## Dot Syntax

	local log = LogChan()
	log.ch.Audio:print("Audible")
	log.ch.Rendering:print("Visible")
	log:disable_channel("Rendering")
	log.ch.Audio:print("Loud noises")
	log.ch.Rendering:print("Invisible")

### Output

    [Audio]	Audible
    [Rendering]	Visible
    [Audio]	Loud noises


# License

Redistribute/modify under the terms of the MIT license. See LICENSE for
details.

