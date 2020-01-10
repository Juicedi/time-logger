import terminal, times

type TimerState* = enum
  paused, running

var accummulator: Duration
var startTime = getTime()
var timerCurrentState* = paused

proc accummulateTime*(): void =
  accummulator += getTime() - startTime
  startTime = getTime()

proc getAccummulatedTime*(): string =
  result = $(inSeconds(accummulator + (getTime() - startTime)))

proc restartTimer*(): void =
  startTime = getTime()
  accummulator = DurationZero

proc togglePause*() =
  timerCurrentState = if timerCurrentState == paused: running else: paused
  eraseLine()

  if timerCurrentState == paused:
    accummulateTime()
  else:
    startTime = getTime()
