from ./inputHandler import inputString

const currentProjectBeginning = "Current project -- "
const currentTaskBeginning = "Current task -- "

var project*: string
var task*: string

proc changeNames*(): void =
  stdout.write(currentProjectBeginning)
  project = inputString(currentProjectBeginning.len)
  stdout.write("\n" & currentTaskBeginning)
  task = inputString(currentTaskBeginning.len)
  stdout.write("\n")
