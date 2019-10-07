@echo off
echo Test the minimum pass program

ca65 --target sim65c02 %1 -o out.o
ld65 --target sim65c02 --lib sim65c02.lib out.o
sim65 a.out
echo Test status is %ERRORLEVEL%
rm a.out
rm *.o
