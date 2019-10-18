import terminal
import ./imports/taskHandler
import ./imports/timeHandler

# TODO: load previus proj and task
# TODO: show today, this week, cummulated times
# TODO: option to save time recording

const taskMenuHelperText =
  "r = refresh status, " &
  "p = pause, " &
  "s = save and exit, " &
  "esc = exit without saving, " &
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

proc startNewTask(): void =
  changeNames()
  echo taskmenuHelperText
  writeStatus()

proc taskInputLoop(): void =
  while true:
    input = getch()

    if input.ord == 27:
      break

    if input == 'p':
      togglePause()

    if isTimePaused == true:
      continue

    discard accummulateTime()

    if input == 'n':
      startNewTask()

    if input == 's':
      commentTimeLog()
      saveCurrentTask(getAccummulatedTime())
      break

    if input == 'r':
      eraseStatus()
      writeStatus()

proc mainMenuLoop(): void =
  while true:
    input = getch()

    if input.ord == 27:
      break

    if input == 'n':
      restartTimer()
      startNewTask()
      taskInputLoop()
      echo "\n\n" & mainMenuHelperText

    # if number ... start previously run task

startNewTask()
taskInputLoop()
echo "\n\n" & mainMenuHelperText
mainMenuLoop()
