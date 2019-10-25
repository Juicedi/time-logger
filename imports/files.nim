import os

const logsPath = "logs/"
const outputFile = "temp.txt"

proc saveText*(project: string, task: string, comment: string, time: string): void =
  let projectPath = logsPath & project & "/"
  let inputFilePath = projectPath & task & ".txt"
  var i: File
  var line = ""
  let o = open(outputFile, fmWrite)

  discard logsPath.existsOrCreateDir()
  discard projectPath.existsOrCreateDir()

  if inputFilePath.fileExists():
    i = inputFilePath.open()
    while i.readLine(line): o.writeLine(line)
    i.close()
  else:
    echo "no input file, creating new one"
    i = inputFilePath.open(fmWrite)
    i.close()

  o.write(time & " -- ")
  o.writeLine(comment)
  o.close()

  discard tryRemoveFile(inputFilePath)
  moveFile(outputFile, inputFilePath)

# saveText(project = "hello", task = "test", comment = "this is just a test")
