import ./inputHandler

const currentProjectBeginning = "Current project -- "
const currentTaskBeginning = "Current task -- "

var project*: string
var task*: string
var comment: string

proc saveCurrentTask*(time: string): void =
  echo "\n"
  echo "saving task"
  echo project
  echo task
  echo comment

proc commentTimeLog*(): void =
  stdout.write("\nWrite a comment for the time -- ")
  comment = stdin.readline()

proc changeNames*(): void =
  stdout.write("\n" & currentProjectBeginning)
  project = inputString(currentProjectBeginning.len)
  stdout.write("\n" & currentTaskBeginning)
  task = inputString(currentTaskBeginning.len)
  stdout.write("\n")
