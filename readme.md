# time-logger (Work in Progress)

This is going to be a command-line (CLI) program that will make time logging
faster and easier than going in to your web browser and marking your time-logs
there.

### How to install

For now this has to be compiled using the Nim programming language
compiler. When the Nim compiler has been installed, run the build.bat if you
are on MS windows. You can also just write ```nim c timeLogger.nim``` to the
terminal. This command will compile the program to your current directory.

### Goal of This Project

This projects goal is to create a time logging tool that will be faster and
easier to use than the applications in the web.

### Todos
* Load previus project and task
  * This can be a separate program from the time-logger. The tasks and
    projects don't need to be updated constantly. Just when user wants to
    update them by running the update program.
  * Ensure the times are synchronized only once by saving the log id from server
  * Gather users all project and task data separately

* Handle different time logs
  * Valid Project
    * Project name = valid
    * Task name = valid or empty

  * Default Project
    * Project name = empty
    * Task name = anything or empty

  * Empty fields will result a default project or task name. It can be
    "Default" for now.

* Create option to refresh fetched data or atleast give help how to do it

* Autocomplete should use the fetched Project and task data

* Each time log should have the date and time when the time log started

* Show today, this week, cummulated times
