data examp1_8;
input x @@;
cards;
25 45 50 54 55 61 64 68 72 75 75 78 79 81 83 84
84 84 85 86 86 86 87 89 89 89 90 91 91 92 100
;
proc univariate data=examp1_8 normal;
run;

proc capability data=examp1_8 graphics noprint;
histogram x/weibull vscale=proportion;
run;

data delmin;
set examp1_8;
if x=25 then delete;
run;

proc capability data=delmin graphics noprint;
histogram x/weibull vscale=proportion;
cdfplot x/weibull;
run;
