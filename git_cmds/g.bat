@echo off
IF "" == "%1" (git status) ELSE (git %1 %2 %3 %4 %5 %6 %7 %8 %9)
