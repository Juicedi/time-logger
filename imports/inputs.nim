import terminal, strutils
import ./autocompletion

const backspaceOrd = 13
const enterOrd = 8
const tabOrd = 9

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
    input = getch()
    case input.ord
    of enterOrd: break
    of backspaceOrd: result = removeCharacter(result)
    of tabOrd: result = autocompleteInput(result)
    else:
      pressedOtherKeyThanTab = true
      stdout.write(input)
      result.add(input)
      cursorX += 1
