# LogChan

*print channeled logs*

LogChan is a simple tool to print to named channels and disable channels at
will. Create the logger instance `local log = LogChan()` and then either pass
channel names as an argument `log:print("Audio", "Loud")` or index the `ch`
table directly `log.ch.Audio:print("Noises")`.

Games often have different systems and you're not always interested in all the
systems at once. Using channels allows you to always have your logging setup,
but only see what's currently interesting.


# Examples

## Multiple Channels and Format Print

    local log = LogChan()
    log:print("Audio", "Can you hear this?")
    log:printf("Camera", "Look %s and %s for %0.2f s", "left", "right", 10.5)

### Output

    [Audio]	Can you hear this?
    [Camera]	Look left and right for 10.50 s


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


## Dot Syntax

    local log = LogChan()
    log.ch.Audio:print("Audible")
    log.ch.Rendering:print("Visible")
    -- dot syntax is only for printing, not toggling.
    log:disable_channel("Rendering")
    log.ch.Audio:print("Loud noises")
    log.ch.Rendering:print("Invisible")

### Output

    [Audio]	Audible
    [Rendering]	Visible
    [Audio]	Loud noises


## Configure and Use

    local log = LogChan()
    log:disable_all()
    log:enable_channel("Audio")
    log:enable_channel("Camera")
    log:print("Audio", "Loud noises")
    log:print("Rendering", "Invisible")
    log:printf("Camera", "Look %s and %s for %0.2f s", "left", "right", 10.5)
    -- Or dot syntax.
    log.ch.Audio:print("Loud noises")
    log.ch.Rendering:print("Invisible")
    log.ch.Camera:printf("Look %s and %s for %0.2f s", "left", "right", 10.5)

### Output

    [Audio]	Loud noises
    [Camera]	Look left and right for 10.50 s
    [Audio]	Loud noises
    [Camera]	Look left and right for 10.50 s


# Requirements

Bundles a basic class implmentation. Replace with your own class library
trivially.


# License

Redistribute/modify under the terms of the MIT license. See LICENSE for
details.

