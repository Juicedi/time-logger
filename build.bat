@echo off
pushd src
nim c -r --threads -o:..\dist\timeLogger.exe .\timeLogger.nim
popd
