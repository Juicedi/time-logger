import times
import terminal

# var x: seq[int]          # a reference to a sequence of integers
# x = @[1, 2, 3, 4, 5, 6]  # the @ turns the array into a sequence allocated on the heap

# type taskTime = start: int64, end: int64, what: string

type Intlist = array[0..3, int64]
type TimeArray = array[0..1, Intlist]

var timelist: TimeArray
var newTime: Time
var storedTime = getTime()

for i in low(timelist)..high(timelist):
  for j in low(timelist[i])..high(timelist[i]):
    echo "ready to store"

    # maybe add some logic to this part, ie. change list
    # pos by number input
    discard getch() 

    newTime = getTime()
    timelist[i][j] = inSeconds(newTime - storedTime)
    storedTime = newTime

echo timelist
