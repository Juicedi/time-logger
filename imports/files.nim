import os

const inputFile = "output.txt"
const outputFile = "temp.txt"

proc saveText*(project: string, task: string, comment: string, time: string): void =
  var i: File
  var line = ""
  var o = open(outputFile, fmWrite)

  if fileExists(inputFile):
    i = open(inputFile)
    while i.readLine(line): o.writeLine(line)
    i.close()
  else:
    echo "no input file, creating new one"
    i = open(inputFile, fmWrite)
    i.close()

  o.writeLine(project)
  o.writeLine(task)
  o.writeLine(comment)
  o.writeLine(time)
  o.close()

  discard tryRemoveFile(inputFile)
  moveFile(outputFile, inputFile)

# saveText(project = "hello", task = "test", comment = "this is just a test")
