import terminal, strutils
import ./autocompletion

type
  Keys = enum
    backspace = 8,
    tab = 9,
    enter = 13

proc eraseCurrentInputText(passedResult: string, padding: int): void =
  setCursorXPos(padding)
  for i in 0..passedResult.len:
    stdout.write(" ")

proc inputString*(min: int): string =
  var cursorX = min;
  var pressedOtherKeyThanTab = true
  var originalText: string
  var input: char

  proc removeCharacter(passedResult: string): string =
    var resultText = passedResult
    pressedOtherKeyThanTab = true

    if cursorX > min:
      cursorX -= 1
      cursorBackward()
      stdout.write(" ")
      cursorBackward()
      resultText.delete(resultText.len - 1, resultText.len - 1)

    return resultText

  proc autocompleteInput(passedResult: string): string =
    var autocompleteResult: string

    if passedResult.len == 0: return passedResult
    eraseCurrentInputText(passedResult, min)

    if pressedOtherKeyThanTab:
      tabPressCount = -1
      originalText = passedResult
      autocompleteResult = autocomplete(passedResult)
      pressedOtherKeyThanTab = false
    else:
      autocompleteResult = autocomplete(originalText)

    if autocompleteResult.len > 0:
      setCursorXPos(min)
      cursorX = min + autocompleteResult.len
      stdout.write(autocompleteResult)
      return autocompleteResult
    return passedResult

  while true:
    case getch().ord
    of enter.ord: break
    of backspace.ord: result = removeCharacter(result)
    of tab.ord: result = autocompleteInput(result)
    else:
      pressedOtherKeyThanTab = true
      stdout.write(input)
      result.add(input)
      cursorX += 1
