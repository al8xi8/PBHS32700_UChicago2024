
**********************************************************
* HW1_Alexandra Chang
* PBHS 32700 - Biostatistical Methods
* Homework 1 – Spring 2024 – Alexandra Chang
**********************************************************

* Question 1(a): Load the dataset and replicate syntax from Lecture 3 Slide 13
use "smoke_survey.dta", clear

* (Assuming Lecture 3 Slide 13 includes summaries, tabulations, etc.)
summarize
tabulate sex
tabulate smoke

* Question 1(b): Calculate DOB + month
* Example if DOB is March 30
display 03 + 30

* Question 2(a): Estimate survival probability for each group
display "Exposed Survival Proportion:" 23/36
display "Unexposed Survival Proportion:" 32/36

* Question 2(b): Standard error under binomial model
display "SE (Exposed): " sqrt((23/36)*(1 - 23/36)/36)
display "SE (Unexposed): " sqrt((32/36)*(1 - 32/36)/36)

* Question 2(c): Difference in survival, SE of difference, and CI
local p1 = 23/36
local p2 = 32/36
local diff = `p1' - `p2'
local se_diff = sqrt((`p1'*(1 - `p1')/36) + (`p2'*(1 - `p2')/36))
display "Difference: " `diff'
display "SE of Difference: " `se_diff'
display "95% CI Lower: " `diff' - 1.96*`se_diff'
display "95% CI Upper: " `diff' + 1.96*`se_diff'

* Question 2(d): Z test for harm from cigarette smoke
display "Z-statistic: " `diff'/`se_diff'

* Question 2(e): Test H0: p1 = p2
prtesti 36 23 36 32

* Question 2(f): Interpretation of results
* (Write-up to be done in assignment document)

* Question 3(a): Odds ratio
local odds_exposed = 23 / (36 - 23)
local odds_unexposed = 32 / (36 - 32)
display "Odds Ratio: " `odds_exposed' / `odds_unexposed'

* Question 3(b): Log odds ratio and SE
local or = `odds_exposed' / `odds_unexposed'
local log_or = log(`or')
local se_log_or = sqrt(1/23 + 1/13 + 1/32 + 1/4)
display "Log(OR): " `log_or'
display "SE of Log(OR): " `se_log_or'

* Question 3(c): CI for log(OR)
display "95% CI Lower (log scale): " `log_or' - 1.96*`se_log_or'
display "95% CI Upper (log scale): " `log_or' + 1.96*`se_log_or'

* Question 3(d): Chi-squared test for independence
matrix input A = (23, 13 \ 32, 4)
tabi 23 13 \ 32 4, chi2
