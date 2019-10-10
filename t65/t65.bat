@echo off
echo Run the test program %1

ca65 --target sim65c02 %1 -o test.o
ld65 --target sim65c02 --lib sim65c02.lib test.o -o test.out
sim65 test.out
echo Test status is %ERRORLEVEL%
rm test.out
rm test.o
