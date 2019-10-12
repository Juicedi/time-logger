from terminal import
  getch,
  cursorDown,
  cursorUp,
  eraseLine
from ./imports/taskHandler import
  changeNames,
  project,
  task
from ./imports/timeHandler import
  isTimePaused,
  accummulateTime,
  getAccummulatedTime,
  togglePause

# TODO: move time management out of the irrelevant procedures
# TODO: load previus proj and task
# TODO: show today, this week, cummulated times
# TODO: option to save time recording

const userInputHelperText =
  "r = refresh status, " &
  "p = pause, " &
  "esc = exit, " &
  "n = rename" &
  "\n"

var input: char

proc eraseStatus(): void =
  cursorUp()
  eraseLine()

proc writeStatus(): void =
  echo project & " - " & task & ": " & $getAccummulatedTime()

# TODO: better name for this procedure
proc startTask(): void =
  echo "\n"
  changeNames()
  echo userInputHelperText
  writeStatus()

startTask()

while true:
  input = getch()

  if input.ord == 27:
    # if paused, the accummulator has already been updated
    if isTimePaused == false: echo accummulateTime()
    break
  if input == 'p': togglePause()
  if isTimePaused == true: continue
  if input == 'n': startTask()
  if input == 'r':
    eraseStatus()
    writeStatus()
