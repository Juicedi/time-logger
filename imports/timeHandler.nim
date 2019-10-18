import terminal, times

var accummulator: Duration
var startTime = getTime()
var isTimePaused* = false

proc accummulateTime*(): Duration =
  accummulator += getTime() - startTime
  return accummulator

proc getAccummulatedTime*(): string =
  result = $(accummulator + (getTime() - startTime))

proc restartTimer*(): void =
  startTime = getTime()

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

