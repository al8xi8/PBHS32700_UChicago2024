
********************************************************************************
* Homework 2 Solutions
* Course: PBHS 32700/STAT 22700, Spring 2024
* Name: Alexandra Chang
********************************************************************************

* Problem 1: Cigarette Smoke Experiment on Mice (Logistic Regression)

* (a) Fit a logistic regression model for two-month survival.
clear
input y x count
0 0 6
1 0 34
0 1 16
1 1 24
end

logit y x [fweight=count], nolog

* (b) Fit the same logistic regression model using the blogit command.
clear
input y n x
34 40 0
24 40 1
end

blogit y n x

* (c) Estimated odds ratio for survival (exposed vs unexposed).
blogit, or

* (d) 95% CI for the odds ratio. (Interpretation is in the solution, no new code needed)

* (e) Summarize the evidence about the effects of smoke exposure on survival. (No new code needed)

* Problem 2: Genetic Toxicity of 9-Aminoacridine in E. coli

* (a) Fit a logistic regression model for response in terms of the dose.
clear
input dose response n
0.25 7 96
0.8 28 96
2.5 64 96
8 54 96
24 81 96
80 96 96
end

blogit response n dose

* (b) Repeat the analysis using log dose.
gen ldose = log(dose)
blogit response n ldose

* (c) Plot the empirical logit of the observed proportions against the corresponding explanatory variable.
gen elogit = log((response+.5)/(n-response+.5))
graph twoway scatter elogit dose || lfit elogit dose, name(g1) nodraw
graph twoway scatter elogit ldose || lfit elogit ldose, name(g2) nodraw
graph combine g1 g2

* (d) Which model do you prefer? (Why?) - No code needed.

* (e) Prediction of mutagenic response when dose is 20 using the preferred model.
* This involves manual calculation and `lincom`.
* For log-dose model, when dose = 20, ldose = log(20) = 2.9957323
lincom _cons + ldose*2.9957323

* (f) Summarize the evidence about the effects of 9-AA on mutagenic response. - No code needed.

* Problem 3: Low Birth Weight Data (NHANES)

* (a) Fit a logistic regression to evaluate predictors (age, race, smoke) for low birth weight.
* Make sure you have the 'lowbwt.dta' file in your Stata working directory or provide the full path.
use "lowbwt.dta", clear

* Treat race as a categorical variable using i.race
logistic lbw age i.race smoke, coef

* (b) Interpret the parameter estimate for age. - No code needed.

* (c) Is the statement "younger moms (16 yrs old or younger) tend to have newborns with low birth weight" supported by your data?
gen lowage = 0
replace lowage = 1 if age <= 16

logistic lbw lowage i.race smoke, coef

* (d) Predict the chance of having a low birth weight baby for a 30-year old Asian mom who smokes.
* This involves manual calculation and `lincom`.
* Based on model (a), for age=30, race=3 (other), smoke=1
quietly logit lbw age i.race smoke
lincom _cons + age*30 + 3.race + smoke*1
