import terminal, times

var accummulator: Duration
var startTime = getTime()
var isTimePaused* = false

proc accummulateTime*(): void =
  accummulator += getTime() - startTime
  startTime = getTime()

proc getAccummulatedTime*(): string =
  result = $(inSeconds(accummulator + (getTime() - startTime)))

proc restartTimer*(): void =
  startTime = getTime()
  accummulator = DurationZero

proc togglePause*() =
  isTimePaused = not isTimePaused
  eraseLine()

  if isTimePaused == true:
    stdout.write("paused")
    accummulateTime()
  else:
    startTime = getTime()

