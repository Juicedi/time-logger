import terminal
import ./imports/taskHandler
import ./imports/timeHandler

# TODO: load previus proj and task
# TODO: show today, this week, cummulated times
# TODO: option to save time recording

const taskMenuHelperText =
  "r = refresh status, " &
  "p = pause, " &
  "e = end recording, " &
  "esc = exit, " &
  "n = rename" &
  "\n"
const mainMenuHelperText =
  "# = continue previous task, " &
  "esc = exit, " &
  "n = start new task" &
  "\n"

var input: char

proc eraseStatus(): void =
  cursorUp()
  eraseLine()

proc writeStatus(): void =
  echo project & " - " & task & ": " & getAccummulatedTime()

# TODO: better name for this procedure
proc startTask(): void =
  echo "\n"
  changeNames()
  echo taskmenuHelperText
  writeStatus()

proc saveTaskData(): void =
  echo "task ended"

  if isTimePaused == false:
    echo accummulateTime()

  saveCurrentTask(getAccummulatedTime())

proc taskInputLoop(): void =
  while true:
    input = getch()

    if input.ord == 27:
      break

    if input == 'p':
      togglePause()

    if isTimePaused == true:
      continue

    if input == 'n':
      startTask()

    if input == 'e':
      saveTaskData()
      break

    if input == 'r':
      eraseStatus()
      writeStatus()

  # if paused, the accummulator has already been updated
  if isTimePaused == false: echo accummulateTime()


proc mainMenuLoop(startTask: bool): void =
  var running = true

  if startTask:
    taskInputLoop()

  echo "\n\n" & mainMenuHelperText

  while running:
    input = getch()

    if input.ord == 27:
      running = false

    if input == 'n':
      startTask()
      taskInputLoop()
      echo "\n\n" & mainMenuHelperText

    # if number ... start previously run task

startTask()
mainMenuLoop(startTask = true)
