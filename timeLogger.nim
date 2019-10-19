import terminal, threadpool, os
import ./imports/tasks
import ./imports/time

const
  escOrd = 27
  pOrd   = 112
  sOrd   = 115
  nOrd   = 110
  taskMenuHelperText =
    "p = pause, " &
    "s = save and exit, " &
    "esc = exit without saving, " &
    "n = rename" &
    "\n"
  mainMenuHelperText =
    "# = continue previous task, " &
    "esc = exit, " &
    "n = start new task" &
    "\n"

proc startNewTask(): void =
  changeNames()
  echo taskmenuHelperText

proc taskInputLoop(): void =
  var asyncChar: char
  var asyncInput = spawn getch()

  hideCursor()

  while true:
    asyncChar = ' '

    if asyncInput.isReady():
      asyncChar = ^asyncInput
      asyncInput = spawn getch()

    case asyncChar.ord:
    of escOrd:
      showCursor()
      break
    of pOrd:
      togglePause()
    of nOrd:
      showCursor()
      startNewTask()
      hideCursor()
    of sOrd:
      showCursor()
      saveCurrentTask(getAccummulatedTime())
      break
    else:
      if isTimePaused == false:
        accummulateTime()
        setCursorXPos(0)
        stdout.write(project & " - " & task & ": " & getAccummulatedTime())
      else:
        stdout.write("paused")

    sleep(100)

proc mainMenuLoop(): void =
  var input: char

  while true:
    input = getch()
    if input.ord == escOrd: break
    # if input == number: start previously run task

    if input == 'n':
      restartTimer()
      startNewTask()
      taskInputLoop()
      echo "\n\n" & mainMenuHelperText

startNewTask()
taskInputLoop()
echo "\n\n" & mainMenuHelperText
mainMenuLoop()
