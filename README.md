Broker: TimeToExecute
=====================

Uses linear regression and a log of hitpoint values to estimate how long
a boss has left to die and reach execute range.

**Requires a LibDataBroker [Display Addon][].**

Mathematics are based on the [TimeToExecute Addon][] developed by
[Tifordin][] in 2009.

Features
--------

- Two estimates: one to execute time and one to kill time.
- Flexible timer uses the configured amount of historic data to
  determine how quickly the target unit is currently dropping. Because
  only recent data is considered, the estimate will automatically adjust
  to factor in heroism/bloodlust, DPS deaths, execute range, DPS
  stoppage phases, etc. Because only historic data is used, there is no
  prediction made for **future** heroism/bloodlust, etc.
- Ability to track focus (enabled by default). If there is an enemy unit
  that is alive and focussed, the timers will track the focus instead of
  the current target. If the focus dies (or there is no focus set),
  tracking reverts back to the target.
- Configurable execute percentage.
- Configurable history time (increasing means slower adjusting to recent
  events, but more resilience against temporary bursts or drops).
- Configurable refresh time (default 0.2 sec).

Configuration
-------------

- `/timetoexecute` slash command
- Alt+click the displayed addon for a configuration interface
- Blizzard Interface options dialog
- Configuration can be changed during fights, to adjust as quick as
  possible.

Localisation
------------

You can [help localise][] this addon. Fortunately there is not a lot to
translate, other than configuration.

[help localise]: http://www.wowace.com/addons/broker_timetoexecute/localization/
[Display Addon]: https://github.com/tekkub/libdatabroker-1-1/wiki/addons-using-ldb
[TimeToExecute Addon]: http://www.wowace.com/addons/timetoexecute/
[Tifordin]: http://www.wowace.com/profiles/Tifordin/
