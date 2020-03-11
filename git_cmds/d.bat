@echo off
IF "" == "%1" (git --no-pager diff --ignore-cr-at-eol) ELSE (git --no-pager diff --ignore-cr-at-eol --no-index %1 %2 %3 %4 %5 %6 %7 %8 %9)
