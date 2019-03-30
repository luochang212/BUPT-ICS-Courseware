data examp1_9;
input x y;
cards;
68  971
63  892
70 1125
 6   82
65  931
 9  112
10  162
12  321
20  315
30  375
33  462
27  352
21  305
 5   84
14  229
27  332
17  185
53  703
62  872
65  740
;
run;

proc corr data=examp1_9 pearson spearman cov;
run;
