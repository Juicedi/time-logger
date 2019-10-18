import terminal, times

var accummulator: Duration
var startTime = getTime()
var isTimePaused* = false

proc accummulateTime*(): Duration =
  accummulator += getTime() - startTime
  startTime = getTime()
  return accummulator

proc getAccummulatedTime*(): string =
  result = $(inSeconds(accummulator + (getTime() - startTime)))

proc restartTimer*(): void =
  startTime = getTime()
  accummulator = DurationZero

proc togglePause*() =
  isTimePaused = not isTimePaused
  cursorUp()
  eraseLine()

  if isTimePaused == true:
    echo "paused"
    discard accummulateTime()
  else:
    cursorDown()
    startTime = getTime()

