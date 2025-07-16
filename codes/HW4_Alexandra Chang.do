
********************************************************************************
* Homework 4 Solutions
* Course: PBHS 32700/STAT 22700, Spring 2024
* Name: Alexandra Chang
********************************************************************************

* Problem 1: Serological Testing for Malaria

* (a) Build a logistic model assessing the association between age and seropositive rates.
* Make sure you have the 'malaria.dta' file in your Stata working directory or provide the full path.
use "malaria.dta", clear
glm y midpoint_age, family(binomial n) nolog
display chi2tail (5,13.76141124)

* (b) Plot the deviance residuals against midpoint_age.
quietly glm y midpoint_age, family(binomial n) nolog
predict dres, d
predict dsres, d stan
graph twoway scatter dres midpoint_age, yline(0 -2 2) name(g1) nodraw
graph twoway scatter dsres midpoint_age, yline(0 -2 2) name(g2) nodraw
graph combine g1 g2

* (c) Consider the model with log transformed midpoint_age as the predictor.
gen lage = log(midpoint_age)
glm y lage, family(binomial n) nolog
display chi2tail (5,11.96341612)
predict dlres, d
predict dlsres, d stan
graph twoway scatter dlres lage, yline(0 -2 2) name(g3) nodraw
graph twoway scatter dlsres lage, yline(0 -2 2) name(g4) nodraw
graph combine g3 g4

* (d) Fit the probit model using "glm" function with log midpoint age.
glm y lage, family(binomial n) link(probit) nolog
display chi2tail (5, 12.73223275)

* (e) Fit the cloglog model with log midpoint age.
glm y lage, family(binomial n) link(cloglog) nolog
display chi2tail (5,10.38907448)

* (f) Discuss possible reasons of the apparent violations. - No code needed.

* Problem 2: Alcohol and Esophageal Cancer

* (a) Construct a 2x2 contingency table and estimate the odds ratio.
* This is a manual calculation as per the solution.

* (b) Provide a 95% confidence interval for the odds ratio.
* This is a manual calculation as per the solution.

* (c) Fit a logistic regression model to obtain the odds ratio.
clear
input alcohol case control
1 96 110
0 104 690
end
gen n=case+control
blogit case n alcohol, or

* (d) Input the data for the original and the recent study.
clear
input new_study alcohol case control
0 1 96 110
0 0 104 690
1 1 115 25
1 0 25 275
end

* (e) Is there significant difference in the association effects?
gen n = case + control
gen study_alc = new_study * alcohol
glm case n alcohol new_study study_alc, family(binomial n) nolog

* (f) Select a final model. - No code needed.
* (g) Literature search on prevalence of esophageal cancer. - No code needed.
