
********************************************************************************
* Homework 1 Solutions
* Course: PBHS 32700/STAT 22700, Spring 2024
* Name: Alexandra Chang
********************************************************************************

* Problem 2: Cigarette Smoke Experiment on Mice
* (a) Estimate the probability of two-month survival for each group.
* (b) Calculate the standard error for each estimate using a binomial model.
* (c) Give the estimated difference in survival probability, its standard error, and CI.
* (d) Test if cigarette smoke harms two-month survival.
* (e) Test the hypothesis H0: p1 = p2 vs. H1: p1 != p2.
* (f) Conclusions about the effects of smoke exposure on survival.

* Part (b) - Stata code for standard errors
cii proportions 36 23
cii proportions 36 32

* Part (e) - Stata code for chi-squared test
tabi 23 32 \ 13 4, chi2 exact

* Problem 3: Continuing with the same mouse smoking experiment
* (a) Calculate the estimated odds ratio for two-month survival.
* (b) Give the estimated log odds ratio and its approximate standard error.
* (c) Give a confidence interval for the log odds ratio.
* (d) Give a confidence interval for the odds ratio, and interpret.

* Part (d) - Stata code for odds ratio CI using Woolf's method
csi 23 32 \ 13 4, or woolf

* Problem 4: Nasal carrier rate for Streptococcus pyogenes and tonsil size
* Test whether tonsil size affects the probability of carrying S. pyogenes bacteria.

* Stata code for chi-squared test
tabi 19 29 24 \ 497 560 269, chi2 col

* Problem 5: Personalized medicine and drug simvastatin
* (b) ii. Give a 95% confidence interval for the odds ratio of drug use.
* This part involves manual calculation based on the 2x2 table, no direct Stata command for the CI calculation as shown in the solution.
* The 2x2 table is:
* Group             | drug use (a,b) | no drug use (c,d)
* ------------------|----------------|------------------
* with pharma. info | a=60           | c=1140
* w/o pharma. info  | b=96           | d=1104
* OR = (60*1104)/(96*1140) = 0.605
* log(OR) = log(0.605) = -0.5025
* se(log(OR)) = sqrt(1/a + 1/b + 1/c + 1/d) = sqrt(1/60 + 1/96 + 1/1140 + 1/1104) = 0.170
* 95% CI for log(OR) = -0.5025 +/- 1.96*0.170 = (-0.8357, -0.1693)
* 95% CI for OR = (exp(-0.8357), exp(-0.1693)) = (0.433, 0.844)
