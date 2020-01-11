import terminal, threadpool, os
import ./imports/tasks
import ./imports/time

type Keys = enum
  esc = 27,
  n = 110,
  p = 112,
  r = 114,
  s = 115,
  w = 119,
  x = 120

const
  watchHelperText =
    $esc & " = stop watch " &
    "\n"
  mainMenuHelperText =
    "# = continue previous task,\n" &
    $esc & " = exit,\n" &
    $w & " = watch task,\n" &
    $s & " = save and stop task,\n" &
    $r & " = rename task,\n" &
    $x & " = print current status,\n" &
    $p & " = start/stop task,\n" &
    $n & " = start new task,\n" &
    "\n"

proc watchLoop(): void =
  var asyncChar: char
  var asyncInput = spawn getch()

  echo watchHelperText
  hideCursor()

  while true:
    asyncChar = ' '

    if asyncInput.isReady():
      asyncChar = ^asyncInput

    accummulateTime()
    setCursorXPos(0)
    stdout.write(project & " - " & task & ": " & getAccummulatedTime())

    if asyncChar.ord == esc.ord:
      showCursor()
      break

    sleep(100)

proc mainMenuLoop(): void =
  var input: char

  while true:
    case getch().ord
    of esc.ord:
      break
    of p.ord:
      togglePause()

      if isTimePaused:
        echo "Paused"
      else:
        echo "Resumed task"
        echo getAccummulatedTime()
    of s.ord:
      accummulateTime()
      saveCurrentTask(getAccummulatedTime())
      echo "\n\n" & mainMenuHelperText
    of x.ord:
      accummulateTime()
      setCursorXPos(0)
      stdout.write(project & " - " & task & ": " & getAccummulatedTime())
    of w.ord:
      watchLoop()
      echo "\n\n" & mainMenuHelperText
    of r.ord:
      changeNames()
      echo "\n\n" & mainMenuHelperText
    of n.ord:
      restartTimer()
      changeNames()
      echo "\n\n" & mainMenuHelperText
    # if input == number: start previously run task
    else:
      echo "Please press a valid key"

changeNames()
echo "\n\n" & mainMenuHelperText
mainMenuLoop()
