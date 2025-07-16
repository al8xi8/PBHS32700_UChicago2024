********************************************************************************
* Homework 6 Solutions
* Course: PBHS 32700/STAT 22700, Spring 2024
* Name: Alexandra Chang
********************************************************************************

* Problem 1: Kidney Stones (Poisson Regression)

* (a) Build a model to assess whether the rate of kidney-stone formation differs by sex, adjusting for age.
* Make sure you have the 'stones8.dta' file in your Stata working directory or provide the full path.
use "stones8.dta", clear
poisson stones sex age, exposure(yrfu) nolog

* (b) Interpret the parameters. - No code needed.

* (c) Do men and women form stones at significantly different rates? - No code needed.

* (d) Would it be appropriate to assess the difference using "poisson stones sex age"? - No code needed.

* (e) Build another model to assess whether individuals with only one functional kidney have different rates.
poisson stones nx1 sex age, exposure(yrfu) nolog

* (f) Construct a likelihood ratio test to compare the model in (a) versus (e).
* Log likelihood from (a) = -2342.0248
* Log likelihood from (e) = -2330.8625
* LR = -2 * (LogLikelihood_a - LogLikelihood_e)
* LR = -2 * (-2342.0248 - (-2330.8625)) = -2 * (-11.1623) = 22.3246
* Degrees of freedom = 1 (for nx1)
* p-value = chi2tail(1, 22.3246) = 0.0000
display chi2tail(1, -2*(-2342.0248 - (-2330.8625)))

* Problem 2: Hypothetical Problem Descriptions (Model Suggestions)
* (a) Fatal car accident rates. - No code needed.
* (b) Clinical trial for hepatitis and survival. - No code needed.
* (c) Coffee shop preference. - No code needed.
* (d) Ice cream shop preference (multinomial still works). - No code needed.
* (e) Ice cream shop preference (women vs men). - No code needed.
* (f) Placenta abnormalities and low birth weight (ordered categorical response). - No code needed.
* (g) Placenta abnormalities and low birth weight (binary response). - No code needed.

* Problem 3: Summarize Regression Models
* This problem is purely descriptive and requires no Stata code.
