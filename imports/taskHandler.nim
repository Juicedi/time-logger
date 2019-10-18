import ./inputHandler

const currentProjectBeginning = "Current project -- "
const currentTaskBeginning = "Current task -- "

var project*: string
var task*: string

proc saveCurrentTask*(time: string): void =
  echo "saving task"

proc changeNames*(): void =
  stdout.write(currentProjectBeginning)
  project = inputString(currentProjectBeginning.len)
  stdout.write("\n" & currentTaskBeginning)
  task = inputString(currentTaskBeginning.len)
  stdout.write("\n")
