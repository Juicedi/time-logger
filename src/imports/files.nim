import os

var logsPath = getAppDir() & "/logs/"
var outputFile = getAppDir() & "/temp.txt"

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

  #[
  # TODO: Figure out, how the log files should be formatted.
  #
  # 1. Format should be easy to parse
  #   * Projects should be files?
  #   * tasks, comments, time, date should be listed in the file
  # 2. Date should be saved, so the recent logs could be parsed
  ]#
  o.writeLine(time)
  o.writeLine(comment)
  o.close()

  discard tryRemoveFile(inputFilePath)
  moveFile(outputFile, inputFilePath)
