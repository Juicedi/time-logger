import ./inputs
import ./files

const currentProjectBeginning = "Current project -- "
const currentTaskBeginning = "Current task -- "
const commentText = "Write a comment for the time -- "

var project*: string
var task*: string
var comment: string

proc commentTimeLog(): void =
  stdout.write("\n" & commentText)
  comment = stdin.readline()

proc saveCurrentTask*(time: string): void =
  commentTimeLog()
  echo "\n"
  echo "saving task"
  saveText(project = project, task = task, comment = comment, time = time)

proc changeNames*(): void =
  stdout.write("\n" & currentProjectBeginning)
  project = inputString(currentProjectBeginning.len)
  stdout.write("\n" & currentTaskBeginning)
  task = inputString(currentTaskBeginning.len)
  stdout.write("\n")
