import terminal, threadpool, os
import ./imports/tasks
import ./imports/time

type Keys = enum
  esc = 27,
  n = 110,
  p = 112,
  s = 115

const
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

    # FIXME: Causes issues when user has already exited this loop
    if asyncInput.isReady():
      asyncChar = ^asyncInput
      asyncInput = spawn getch()

    case asyncChar.ord:
    of esc.ord:
      showCursor()
      break
    of p.ord:
      togglePause()
    of n.ord:
      showCursor()
      startNewTask()
      hideCursor()
    of s.ord:
      showCursor()
      saveCurrentTask(getAccummulatedTime())
      break
    else:
      if timerCurrentState == running:
        accummulateTime()
        setCursorXPos(0)
        stdout.write(project & " - " & task & ": " & getAccummulatedTime())
      else:
        # FIXME: "paused" text will be written each loop
        stdout.write("paused")

    sleep(100)

proc mainMenuLoop(): void =
  var input: char

  while true:
    case getch().ord
    of esc.ord: break
    of n.ord:
      restartTimer()
      startNewTask()
      taskInputLoop()
      echo "\n\n" & mainMenuHelperText
    # if input == number: start previously run task
    else:
      echo "Please press a valid key"

startNewTask()
taskInputLoop()
echo "\n\n" & mainMenuHelperText
mainMenuLoop()
