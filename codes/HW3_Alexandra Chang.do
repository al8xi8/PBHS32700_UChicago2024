********************************************************************************
* Homework 3 Solutions
* Course: PBHS 32700/STAT 22700, Spring 2024
* Name: Alexandra Chang
********************************************************************************

* Problem 1: Toxicity of Rotenone on Chrysanthemum Aphids

* (a) Input the data in Stata.
clear
input dose y_affected n_exposed
10.2 44 50
7.7 42 49
5.1 24 46
3.8 16 48
2.6 6 50
end

* (b) Fit the full model for this data.
tabulate dose, generate(g)
blogit y_affected n_exposed g2-g5

* (c) Fit the model with dose as the predictor and calculate the deviance statistic.
blogit y_affected n_exposed dose
display chi2tail(3, 5.826)

* (d) Does the linear model have a good fit? Test it.
display chi2tail(3, 5.826)

* (e) Fit the model with log dose as the predictor. Assess the fit.
gen ldose = log(dose)
glm y_affected ldose, family(binomial n_exposed)
display chi2tail(3,1.424)

* (g) Fit the five models with polynomial terms of dose.
gen dose2 = dose^2
gen dose3 = dose^3
gen dose4 = dose^4
gen dose5 = dose^5

glm y_affected dose, family(binomial n_exposed)
glm y_affected dose dose2, family(binomial n_exposed)
glm y_affected dose dose2 dose3, family(binomial n_exposed)
glm y_affected dose dose2 dose3 dose4, family(binomial n_exposed)
glm y_affected dose dose2 dose3 dose4 dose5, family(binomial n_exposed)

* (l) Find the dose that lead to 50% of survival based on the log dose model.
blogit y_affected n_exposed ldose, nolog
predict phat, pr
list

* Alternative calculation for exact dose:
display log(20)

* Problem 2: High Blood Pressure (NHANES)

* (a) Download and open the dataset. Use descriptive statistics commands.
use "nhaneshw.dta", clear
describe
notes
summarize age
table male

* (b) Use logistic regression to build a model for the relationship between age and hypertension. Assess goodness of fit.
logit htn age, nolog
estat gof, group(10)

* (c) Model parameters interpretation.
display exp(15*.0623793)

* (d) Add sex (male) to the logistic model. Interpret the coefficient on male.
glm htn age male, nolog family(binomial)

* (e) Fit logistic regression models using age as the only predictor separately for men and for women.
glm htn age if male == 1, nolog family(binomial)
glm htn age if male == 0, nolog family(binomial)

* (f) Fit logistic regression model using age, sex and the interaction between age and sex.
gen maleage = male*age
glm htn age male maleage, nolog family(binomial)

* (g) Does adding the interaction between age and sex significantly improve the fit?
display chi2tail(1,3025.540053-2996.57506)

* (h) Predicted probability of hypertension for a 63-year old man.
lincom _cons+63*age + male + maleage*63

display as text "probability = " as result invlogit(-.6708589)
display as text "lower bound = " as result invlogit(-.8351339)
display as text "upper bound = " as result invlogit(-.5065839)
