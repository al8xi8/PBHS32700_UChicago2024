********************************************************************************
* Homework 8 Solutions
* Course: PBHS 32700/STAT 22700, Spring 2024
* Student Name: [Your Name Here]
* Date: [Current Date]
********************************************************************************

* Problem 1: Breast Cancer (Weibull Proportional Hazards Model)

* (a) i. Write down the Weibull proportional hazards model. - No code needed.

* (a) ii. Fit the Weibull proportional hazards model in Stata.
* Make sure you have the 'bcmod.dta' file in your Stata working directory or provide the full path.
use "bcmod.dta", clear
stset survyears failure(death)
streg i.trt, dist(weibull) nolog

* (a) iii. Estimated baseline hazard function and hazard function for treatment group. - No code needed.

* (a) iv. Obtain the estimate of the hazard ratio of death. - No code needed.

* (a) v. Estimated median survival time for placebo and tamoxifen groups.
* Manual calculation based on the formula: ((1/lambda) * log(2))^(1/gamma)
* lambda = _b[_cons] from streg output
* gamma = _b[/ln_p] from streg output (p in Stata output is gamma)
* For placebo (baseline), lambda = 0.0073966, gamma = 1.570178
display ((1/.0073966)*log(2))^(1/1.570178)
* For tamoxifen (trt=2), hazard ratio = 0.8912763
* So, lambda_tamoxifen = lambda_baseline * HR = 0.0073966 * 0.8912763
display ((1/(.0073966*.8912763))*log(2))^(1/1.570178)

* (b) Expand the model in (a) to control further for tumor size.
* (b) i. Fit the model. Interpretation of coefficient for trt.
streg i.trt i.tumsiz, dist(weibull) nolog

* (b) ii. Compare the fit of the model in (a) versus (b).
* Log likelihood from (a) = -1020.9312
* Log likelihood from (b) = -1015.7465
* LR = -2 * (LogLikelihood_a - LogLikelihood_b)
* DF = 3 - 1 = 2 (tumsiz has 3 categories, so 2 parameters added)
display chi2tail(2, -2*(-1020.9312 - (-1015.7465)))

* (c) Expand the model in (a) to control further for both tumor size and menstat.
* (c) i. Fit the model. Description of subject for baseline hazard.
streg i.trt i.tumsiz menstat, dist(weibull) nolog

* (c) ii. Interpretation of coefficient for trt. - No code needed.

* (c) iii. Estimate the hazard function for a subject whose menopausal status is pre-menopausal with tumor size between 2-4 cm and treated with tamoxifen.
* This involves manual calculation based on the formula and coefficients.

* (d) Expand the model in (c) to further add the interaction between tumor size and trt.
xi: streg i.trt*i.tumsiz menstat, dist(weibull) nolog
* The calculation of the hazard ratio is manual as per the solution.
* HR = exp(beta_tumsiz2 - beta_tumsiz3 + beta_trt_tumsiz2 - beta_trt_tumsiz3)
* From the output:
* _Itumsiz_21: 1.271864 (exp(beta_tumsiz2))
* _Itumsiz_31: 1.335762 (exp(beta_tumsiz3))
* _ItrtXtum_2_2: 1.004005 (exp(beta_trt_tumsiz2))
* _ItrtXtum_2_3: 1.419207 (exp(beta_trt_tumsiz3))
* So, HR = (1.271864 / 1.335762) * (1.004005 / 1.419207) = 0.9521 * 0.7074 = 0.6735
display (1.271864/1.335762)*(1.004005/1.419207)

* Problem 2: Time to Recurrence (Cox Proportional Hazards Model)

* (a) i. Write down the Cox PH model. Fit the model in Stata.
stset recuryears failure(bcrecur)
stcox i.trt, nolog

* (a) ii. Obtain the estimate of the hazard ratio of recurrence. - No code needed.

* (b) Expand the model in (a) to control further for tumor size.
stcox i.trt i.tumsiz, nolog

* (b) i. Fit the model. Interpretation of coefficient for trt. - No code needed.

* (b) ii. Compare the fit of the model in 2(a) versus 2(b).
* Log likelihood from 2(a) = -1920.858
* Log likelihood from 2(b) = -1911.4983
* LR = -2 * (LogLikelihood_2a - LogLikelihood_2b)
* DF = 2 (tumsiz has 3 categories, so 2 parameters added)
display chi2tail(2, -2*(-1920.858 - (-1911.4983)))

* (c) Expand the model in (a) to control further for both tumor size and menstat.
* (c) i. Fit the model. Description of subject for baseline hazard.
stcox i.trt i.tumsiz menstat, nolog

* (c) ii. Interpretation of coefficient for trt. - No code needed.

* (d) Expand the model in (c) to further add the interaction between tumor size and trt.
xi: stcox i.trt*i.tumsiz menstat, nolog
* The calculation of the hazard ratio is manual as per the solution.
* HR = exp(beta_tumsiz2 + beta_trt_tumsiz2) = exp(beta_tumsiz2) * exp(beta_trt_tumsiz2)
* From the output:
* _Itumsiz_21: 1.643488 (exp(beta_tumsiz2))
* _ItrtXtum_2_2: 1.144907 (exp(beta_trt_tumsiz2))
* So, HR = 1.643488 * 1.144907 = 1.8816
display 1.643488 * 1.144907

* Problem 3: Accelerated Failure Time Model

* (a) Write down a Weibull accelerated failure time model. - No code needed.

* (b) Fit the model in Stata. Interpretation of parameter for trt.
streg i.trt, dist(weibull) nolog time

* (c) Write down the estimated survivor function for subjects treated with tamoxifen. - No code needed.
