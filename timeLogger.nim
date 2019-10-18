import terminal, threadpool, os
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
  var asyncInput = spawn getch()
  var asyncChar: char

  while true:
    if asyncInput.isReady():
      asyncChar = ^asyncInput
      echo asyncChar
      if asyncChar.ord == 27:
        break

      if asyncChar == 'p':
        togglePause()

      if isTimePaused == false:
        discard accummulateTime()

        if asyncChar == 'n':
          startNewTask()

        if asyncChar == 's':
          commentTimeLog()
          saveCurrentTask(getAccummulatedTime())
          break
      asyncInput = spawn getch()
    if isTimePaused == false:
      eraseStatus()
      writeStatus()
    sleep(100)

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
