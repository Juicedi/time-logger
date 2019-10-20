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
* Show today, this week, cummulated times
* Time log folder structure:
    * Project folder
    * Task files
    * Timelogs with comments
* Fix input issue when leaving taskloop to mainloop (first input not responsive)
