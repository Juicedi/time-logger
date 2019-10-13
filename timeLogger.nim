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
  restartTimer,
  togglePause

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

proc mainMenuLoop(): void =
  while true:
    input = getch()

    if input.ord == 27: break
    if input == 'n':
      startTask()
      taskInputLoop()
    # if number ... start previously run task

proc endTask(): void =
  echo "task ended"
  if isTimePaused == false: echo accummulateTime()
  saveCurrentTask(getAccummulatedTime())
  restartTimer()
  mainMenuLoop()

proc taskInputLoop(): bool =
  while true:
    input = getch()

    if input.ord == 27:
      # if paused, the accummulator has already been updated
      if isTimePaused == false: echo accummulateTime()
      result = false
      break
    if input == 'p': togglePause()
    if isTimePaused == true: continue
    if input == 'n': startTask()
    if input == 'e': endTask()
    if input == 'r':
      eraseStatus()
      writeStatus()

startTask()
taskInputLoop()
