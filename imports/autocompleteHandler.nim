import strutils

const learnedWords = [
  "hello",
  "helsinki",
  "wow",
  "world"
]

var tabPressCount* = -1

proc autocomplete*(input: string): string =
  var index = 0
  var found = false

  for word in learnedWords:
    if word.contains(input) and tabPressCount < index:
      found = true
      tabPressCount = index
      result = word
      break
    index += 1

  if found == false:
    tabPressCount = -1
    result = input

