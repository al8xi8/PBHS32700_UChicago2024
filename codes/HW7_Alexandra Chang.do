********************************************************************************
* Homework 7 Solutions
* Course: PBHS 32700/STAT 22700, Spring 2024
* Student Name: [Your Name Here]
* Date: [Current Date]
********************************************************************************

* Problem 1: Breast Cancer (Kaplan-Meier Estimator)

* (a) Sort the data and construct Kaplan-Meier estimates by hand. - No code needed.
* (b) Draw the Kaplan-Meier curve by hand. - No code needed.

* (c) Input the data in Stata and obtain results using Stata.
clear
input time status
5 1
5 1
5 0
6 1
10 1
14 1
14 0
16 0
17 1
17 0
end

stset time, failure(status)
sts list
sts graph

* (d) 30th and 60th percentiles of survival time. Probabilities of surviving 6 and 12 years. - No code needed.

* Problem 2: Interval Life-Table Calculations
* This problem involves manual calculations and table filling. No Stata code is directly provided for these calculations.

* Problem 3: Brain Tumor (Survival Analysis)

* (a) Obtain Kaplan-Meier estimates for each group and plot survival curves.
* Make sure you have the 'brain_tumor.dta' file in your Stata working directory or provide the full path.
use "brain_tumor.dta", clear
stset weeks, failure(event)
sts list, by(Trt)
sts graph, by(Trt) xline(26) xline(52)

* (b) Report the probability of remaining free of brain tumor recurrence to 6 months and 1 year. - No code needed.

* (c) Report the 25th percentile and median survival times.
stsum, by(Trt)

* (d) Is survival different between the two groups? Test using unweighted logrank test.
sts test Trt

* (e) Estimate the average hazard rate ratio. - No code needed.

* (f) Obtain Nelson-Aalen cumulative hazard estimates and plot log cumulative hazards.
sts gen cumhaz = na, by(Trt)
gen logH = log(cumhaz)
gen logH1 = logH if Trt == 1
gen logH2 = logH if Trt == 2
scatter logH1 weeks, connect(l) || scatter logH2 weeks, connect(l)

* Fleming-Harrington test (optional, as per solution)
sts test Trt, fh(1,0)

* (g) What likely happened to censored patients? - No code needed.
