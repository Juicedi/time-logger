import terminal, threadpool, os
import ./imports/taskHandler
import ./imports/timeHandler

# TODO: load previus proj and task
# TODO: show today, this week, cummulated times
# TODO: record time to file

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

proc writeStatus(): void =
  stdout.write(project & " - " & task & ": " & getAccummulatedTime())

proc startNewTask(): void =
  changeNames()
  echo taskmenuHelperText
  writeStatus()

proc taskInputLoop(): void =
  var asyncInput = spawn getch()
  var asyncChar: char

  hideCursor()

  while true:
    asyncChar = ' '
    if asyncInput.isReady():
      asyncChar = ^asyncInput
      asyncInput = spawn getch()
    if asyncChar.ord == 27:
      showCursor()
      break
    if asyncChar == 'p':
      togglePause()
    if asyncChar == 's':
      showCursor()
      saveCurrentTask(getAccummulatedTime())
      break
    if isTimePaused == false:
      if asyncChar == 'n':
        showCursor()
        startNewTask()
        hideCursor()
      accummulateTime()
      eraseLine()
      writeStatus()
    sleep(100)

proc mainMenuLoop(): void =
  while true:
    input = getch()
    if input.ord == 27: break
  # if input == number ... start previously run task
    if input == 'n':
      restartTimer()
      startNewTask()
      taskInputLoop()
      echo "\n\n" & mainMenuHelperText

startNewTask()
taskInputLoop()
echo "\n\n" & mainMenuHelperText
mainMenuLoop()
