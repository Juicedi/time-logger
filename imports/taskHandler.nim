import ./inputHandler

const currentProjectBeginning = "Current project -- "
const currentTaskBeginning = "Current task -- "

var project*: string
var task*: string
var comment: string

proc commentTimeLog(): void =
  stdout.write("\nWrite a comment for the time -- ")
  comment = stdin.readline()

proc saveCurrentTask*(time: string): void =
  commentTimeLog()
  echo "\n"
  echo "saving task"
  echo project
  echo task
  echo comment

proc changeNames*(): void =
  stdout.write("\n" & currentProjectBeginning)
  project = inputString(currentProjectBeginning.len)
  stdout.write("\n" & currentTaskBeginning)
  task = inputString(currentTaskBeginning.len)
  stdout.write("\n")
