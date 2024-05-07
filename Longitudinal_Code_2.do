*************************************
* Final Project
* Longitudinal Data Analysis Projects
*************************************

use "/Users/wuyufei/Desktop/Longitudinal/Final Project/finalproj_2023.dta", clear

***********************
**** Data Cleaning ****
***********************

* Use the first 5 waves since alcohol information is only contained in the first 5 waves
* TAS05 ~ TAS13

/*
  Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
         TAS |      4,776    2.907663     1.55636          1          6
       TAS05 |        745           1           0          1          1
       TAS07 |      1,115           1           0          1          1
       TAS09 |      1,554           1           0          1          1
       TAS11 |      1,907           1           0          1          1
-------------+---------------------------------------------------------
       TAS13 |      1,804           1           0          1          1
       TAS15 |      1,641           1           0          1          1
       TAS17 |      2,526           1           0          1          1
       TAS19 |      2,595           1           0          1          1

*/

*** Variables

* Outcome: mental health
* Predictor: alcohol use
* Time-invariant covariates: race
* Time-variant covariates: smoking, BMI
* Time variable: age

* ER33804, ER33904, ER34004, ER34104, ER34204

keep PID TAS05 TAS07 TAS09 TAS11 TAS13 TA050938 TA070919 TA090983 TA111125 TA131217 TA050766 TA070737 TA090796 TA130945 TA150967 TA050884 TA050762 TA070733 TA090792 TA110908 TA130941 TA050944 TA070925 TA090989 TA111131 TA131223 ER33804 ER33904 ER34004 ER34104 ER34204

replace TAS05 = 0 if TAS05 == .
replace TAS07 = 0 if TAS07 == .
replace TAS09 = 0 if TAS09 == .
replace TAS11 = 0 if TAS11 == .
replace TAS13 = 0 if TAS13 == .
gen TAS = 0
replace TAS = TAS05 + TAS07 + TAS09 + TAS11 + TAS13

* prefer at least 3 observations
keep if TAS > 2

* Time variable: age
rename ER33804 age1
rename ER33904 age2
rename ER34004 age3
rename ER34104 age4
rename ER34204 age5
keep if age1 != 0
keep if age2 != 0
keep if age3 != 0
keep if age4 != 0
keep if age5 != 0
* 1,363 individuals




* Outcome: mental health
rename TA050938 distress1
rename TA070919 distress2
rename TA090983 distress3
rename TA111125 distress4
rename TA131217 distress5
replace distress1 = . if distress1 == 99
replace distress2 = . if distress2 == 99
replace distress3 = . if distress3 == 99
replace distress4 = . if distress4 == 99
replace distress5 = . if distress5 == 99

label drop TA050938L TA070919L TA090983L TA111125L TA131217L

* Predictor: alcohol use
gen alc1 = .
replace alc1 = 1 if TA050766 == 1
replace alc1 = 0 if TA050766 == 5

gen alc2 = .
replace alc2 = 1 if TA070737 == 1
replace alc2 = 0 if TA070737 == 5

gen alc3 = .
replace alc3 = 1 if TA090796 == 1
replace alc3 = 0 if TA090796 == 5

gen alc4 = .
replace alc4 = 1 if TA130945 == 1
replace alc4 = 0 if TA130945 == 5

gen alc5 = .
replace alc5 = 1 if TA150967 == 1
replace alc5 = 0 if TA150967 == 5


* Time-invariant covariate: race, baseline age
rename TA050884 race

* Time-variant covariates: smoking, BMI

gen smoke1 = .
replace smoke1 = 0 if TA050762 == 0
replace smoke1 = 1 if TA050762 == 1
replace smoke1 = 2 if TA050762 == 5

gen smoke2 = .
replace smoke2 = 0 if TA070733 == 0
replace smoke2 = 1 if TA070733 == 1
replace smoke2 = 2 if TA070733 == 5

gen smoke3 = .
replace smoke3 = 0 if TA090792 == 0
replace smoke3 = 1 if TA090792 == 1
replace smoke3 = 2 if TA090792 == 5

gen smoke4 = .
replace smoke4 = 0 if TA110908 == 0
replace smoke4 = 1 if TA110908 == 1
replace smoke4 = 2 if TA110908 == 5

gen smoke5 = .
replace smoke5 = 0 if TA130941 == 0
replace smoke5 = 1 if TA130941 == 1
replace smoke5 = 2 if TA130941 == 5

rename TA050944 bmi1
replace bmi1 = . if bmi1 == 99

rename TA070925 bmi2
replace bmi2 = . if bmi2 == 99

rename TA090989 bmi3
replace bmi3 = . if bmi3 == 99

rename TA111131 bmi4
replace bmi4 = . if bmi4 == 99

rename TA131223 bmi5
replace bmi5 = . if bmi5 == 99



********************************
**** Descriptive Statistics ****
********************************

keep PID distress* alc* smoke* bmi* race age*

lab def alcohol 0 "No" 1 "Yes"
lab val alc* alcohol

lab def smk 0 "current smoker" 1 "former smoker" 2 "non-smoker"
lab val smoke* smk

*** Total N = 1,363
describe

*** Outcome: Non-specific distress

sum distress*
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
   distress1 |        625      5.3664    3.509395          0         24
   distress2 |        969    5.117647    3.712914          0         23
   distress3 |      1,319    5.129644    3.624318          0         24
   distress4 |      1,321    4.764572    3.692722          0         24
   distress5 |        956    4.846234    3.698365          0         20
*/

*** Main predictor: Alcohol use
tab alc1
/*
       alc1 |      Freq.     Percent        Cum.
------------+-----------------------------------
         No |        238       38.02       38.02
        Yes |        388       61.98      100.00
------------+-----------------------------------
      Total |        626      100.00
*/

tab alc5
/*
       alc5 |      Freq.     Percent        Cum.
------------+-----------------------------------
         No |        144       26.82       26.82
        Yes |        393       73.18      100.00
------------+-----------------------------------
      Total |        537      100.00
*/

*** Race
tab race
/*
                 L7 RACE MENTION #1 |      Freq.     Percent        Cum.
------------------------------------+-----------------------------------
                              White |        314       50.08       50.08
  Black, African-American, or Negro |        266       42.42       92.50
   American Indian or Alaska Native |          3        0.48       92.98
                              Asian |          7        1.12       94.10
Native Hawaiian or Pacific Islander |          3        0.48       94.58
                    Some other race |          7        1.12       95.69
                                 DK |          2        0.32       96.01
                        NA; refused |         25        3.99      100.00
------------------------------------+-----------------------------------
                              Total |        627      100.00
*/

*** Smoking status (baseline & end)
tab smoke1
/*
        smoke1 |      Freq.     Percent        Cum.
---------------+-----------------------------------
current smoker |        140       22.36       22.36
 former smoker |         82       13.10       35.46
    non-smoker |        404       64.54      100.00
---------------+-----------------------------------
         Total |        626      100.00
*/

tab smoke5
/*
        smoke5 |      Freq.     Percent        Cum.
---------------+-----------------------------------
current smoker |        196       20.50       20.50
 former smoker |        154       16.11       36.61
    non-smoker |        606       63.39      100.00
---------------+-----------------------------------
         Total |        956      100.00
*/

*** Body mass index
sum bmi*
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
        bmi1 |        620    24.73129     5.11227       16.2       53.9
        bmi2 |        960    25.37229    5.487628       16.3       53.9
        bmi3 |      1,308    25.71246    5.665129       15.3       51.4
        bmi4 |      1,309    26.30069    5.919301       16.3       58.4
        bmi5 |        944    26.52807    5.989346       15.4       51.5
*/


********************************
**** Individual Growth Plots ***
********************************

*** Profile plot

preserve
keep if _n <= 15
profileplot distress*, by(PID) name(profile_plot, replace)
restore

*** Empirical growth plot

* Reshape the data

reshape long age@ distress@ alc@ smoke@ bmi@, i(PID) j(wave)

lab val distress dis
lab val alc alcohol
lab val smoke smk

list in 1/10

/*
     +--------------------------------------------------------------------+
     |  PID   wave    race   age   distress    bmi   alc            smoke |
     |--------------------------------------------------------------------|
  1. | 4039      1       .    14          .      .     .                . |
  2. | 4039      2       .    16          .      .     .                . |
  3. | 4039      3       .    18          3   28.3    No   current smoker |
  4. | 4039      4       .    20          4   25.6    No    former smoker |
  5. | 4039      5       .    23          4   26.6    No   current smoker |
     |--------------------------------------------------------------------|
  6. | 4180      1   White    20          5   21.3   Yes    former smoker |
  7. | 4180      2   White    22          7   20.5   Yes   current smoker |
  8. | 4180      3   White    24          6   21.1   Yes   current smoker |
  9. | 4180      4   White    26          7   21.1     .   current smoker |
 10. | 4180      5   White    28          .      .     .                . |
     +--------------------------------------------------------------------+
*/

* Empirical growth plots for the first 20 individuals
tab age
* center age at 13
gen age_13 = .
replace age_13 = age - 13 

save "/Users/wuyufei/Desktop/Longitudinal/Final Project/final_long2.dta", replace
use "/Users/wuyufei/Desktop/Longitudinal/Final Project/final_long2.dta", clear

preserve
keep if _n <= 100
graph twoway scatter distress age_13, by(PID) ylabel(0(5)24) name(growth_scatter, replace)
graph twoway (lowess distress age_13)(scatter distress age_13), by(PID) ylabel(0(5)24) name(growth_nonpara, replace)
graph twoway (lfit distress age_13)(scatter distress age_13), by(PID) ylabel(0(5)24) name(growth_para, replace)
restore

***********************************
**** Individual OLS Regressions ***
***********************************

use "/Users/wuyufei/Desktop/Longitudinal/Final Project/final_long2.dta", clear

egen grp = group(PID)
generate p2=.
forvalues i = 1/1452 {
  quietly regress distress age_13 if grp ==`i' 
  quietly predict p 
  quietly replace p2=p if grp==`i'
  quietly drop p
}

graph twoway (scatter p2 age_13, msym(i) connect(L))(lfit distress age_13, ylabel(0(5)25) lc(red) lwidth(thick) name(OLS_reg, replace) legend(lab (1 "K-6 Scale")))

*** Without covariates
use "/Users/wuyufei/Desktop/Longitudinal/Final Project/final_long2.dta", clear

statsby _b[_cons] _se[_cons] _b[age_13] _se[age_13] (e(rmse)^2) e(r2), by(PID): regress distress age_13
list, clean
rename _stat_1 intercept 
rename _stat_3 slope

sum intercept slope
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
   intercept |      1,363    6.037181    6.732105  -31.83333   36.42308
       slope |      1,363   -.1155283    .7428197       -3.5       4.25
*/

correlate intercept slope
/*
(obs=1,363)

             | interc~t    slope
-------------+------------------
   intercept |   1.0000
       slope |  -0.8915   1.0000
*/


***********************************
**** Unconditional Mean Model *****
***********************************

use "/Users/wuyufei/Desktop/Longitudinal/Final Project/final_long2.dta", clear

mixed distress || PID:, mle
est sto model1

/*
Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood =  -13460.92  
Iteration 1:   log likelihood =  -13460.92  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =      5,190
Group variable: PID                             Number of groups  =      1,363
                                                Obs per group:
                                                              min =          2
                                                              avg =        3.8
                                                              max =          5
                                                Wald chi2(0)      =          .
Log likelihood =  -13460.92                     Prob > chi2       =          .

------------------------------------------------------------------------------
    distress | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
       _cons |   5.020615   .0780829    64.30   0.000     4.867575    5.173654
------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
PID: Identity                |
                  var(_cons) |   6.392136   .3223714      5.790523    7.056255
-----------------------------+------------------------------------------------
               var(Residual) |   7.110904   .1627217      6.799022    7.437093
------------------------------------------------------------------------------
LR test vs. linear model: chibar2(01) = 1281.59       Prob >= chibar2 = 0.0000
*/

* AIC/BIC
estat ic
/*
Akaike's information criterion and Bayesian information criterion

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
      model1 |      5,190          .  -13460.92       3   26927.84    26947.5
-----------------------------------------------------------------------------
*/

* ICC
estat icc
/*
Intraclass correlation

------------------------------------------------------------------------------
                       Level |        ICC   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
                         PID |    .473385   .0145125      .4450577    .5018846
------------------------------------------------------------------------------
*/



************************************
**** Unconditional Growth Model ****
************************************

mixed distress age_13 || PID: age_13, cov(un) mle
est sto model2

/*
Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood = -13413.253  
Iteration 1:   log likelihood = -13413.212  
Iteration 2:   log likelihood = -13413.212  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =      5,190
Group variable: PID                             Number of groups  =      1,363
                                                Obs per group:
                                                              min =          2
                                                              avg =        3.8
                                                              max =          5
                                                Wald chi2(1)      =      40.35
Log likelihood = -13413.212                     Prob > chi2       =     0.0000

-----------------------------------------------------------------------------------
         distress | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
------------------+----------------------------------------------------------------
           age_13 |  -.1097474   .0172767    -6.35   0.000    -.1436092   -.0758856
            _cons |    5.96589   .1634458    36.50   0.000     5.645542    6.286238
-----------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
PID: Unstructured            |
                 var(age_13) |   .0908293    .016257      .0639549    .1289965
                  var(_cons) |    11.6646   1.477048       9.10092    14.95046
           cov(age_13,_cons) |  -.6900289   .1463871     -.9769424   -.4031154
-----------------------------+------------------------------------------------
               var(Residual) |   6.353073   .1736705      6.021643    6.702745
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 1352.21               Prob > chi2 = 0.0000
*/
margins, at(age_13=(0(4)16)) vsquish
marginsplot, ytitle("Predicted Distress Scores") xtitle ("Age centered at 13") title("Unconditional Growth Model") name(graph_uncondgrowth, replace) x(age_13)


****************************
**** Conditional Models ****
****************************

*** Without covariates
mixed distress c.age_13##i.alc || PID: age_13, cov(un) var mle
est sto model3

/*
Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood = -11350.384  
Iteration 1:   log likelihood = -11350.076  
Iteration 2:   log likelihood = -11350.076  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =      4,364
Group variable: PID                             Number of groups  =      1,363
                                                Obs per group:
                                                              min =          1
                                                              avg =        3.2
                                                              max =          4
                                                Wald chi2(3)      =      26.54
Log likelihood = -11350.076                     Prob > chi2       =     0.0000

-----------------------------------------------------------------------------------
         distress | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
------------------+----------------------------------------------------------------
           age_13 |  -.0795195   .0373075    -2.13   0.033    -.1526408   -.0063982
              alc |   .5075868   .3677397     1.38   0.167    -.2131698    1.228343
                  |
   c.age_13#c.alc |   -.049575   .0465955    -1.06   0.287    -.1409006    .0417506
                  |
            _cons |   5.663238     .28549    19.84   0.000     5.103688    6.222788
-----------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
PID: Unstructured            |
                 var(age_13) |   .0880531    .025589      .0498171    .1556363
                  var(_cons) |   9.934907   1.904348       6.82344    14.46519
           cov(age_13,_cons) |  -.5628218   .2109251     -.9762274   -.1494162
-----------------------------+------------------------------------------------
               var(Residual) |   6.488307   .2078742      6.093409    6.908797
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 988.55                Prob > chi2 = 0.0000
*/

margins i.alc, at(age_13=(0(4)16)) vsquish
marginsplot, ytitle("Predicted K-6 Scores") xtitle ("Age centered at 13") title("Predictions By Alcohol Use") name(alcohol_pred, replace) x(age_13)

*** With all covariates

mixed distress c.age_13##i.alc i.race i.smoke bmi || PID: age_13, cov(un) var mle
est sto model4

/*
Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood = -5310.1679  
Iteration 1:   log likelihood = -5310.1561  
Iteration 2:   log likelihood = -5310.1561  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =      2,064
Group variable: PID                             Number of groups  =        627
                                                Obs per group:
                                                              min =          1
                                                              avg =        3.3
                                                              max =          4
                                                Wald chi2(13)     =      29.09
Log likelihood = -5310.1561                     Prob > chi2       =     0.0064

--------------------------------------------------------------------------------------------
                  distress | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
---------------------------+----------------------------------------------------------------
                    age_13 |  -.1017042   .0586569    -1.73   0.083    -.2166697    .0132613
                           |
                       alc |
                      Yes  |    .024336   .5776249     0.04   0.966    -1.107788     1.15646
                           |
              alc#c.age_13 |
                      Yes  |   -.009485   .0701239    -0.14   0.892    -.1469253    .1279554
                           |
                      race |
Black, African-American..  |   -.013436   .2413846    -0.06   0.956    -.4865411    .4596691
American Indian or Alas..  |  -1.953918   1.630282    -1.20   0.231    -5.149212    1.241377
                    Asian  |   .8200931   1.056507     0.78   0.438    -1.250622    2.890808
Native Hawaiian or Paci..  |  -1.054994   1.566647    -0.67   0.501    -4.125566    2.015578
          Some other race  |   1.726667   1.042806     1.66   0.098    -.3171955     3.77053
                       DK  |   1.169961    1.92287     0.61   0.543    -2.598795    4.938717
              NA; refused  |  -.1425652   .5729235    -0.25   0.803    -1.265475    .9803443
                           |
                     smoke |
            former smoker  |  -.4335278   .2414716    -1.80   0.073    -.9068034    .0397478
               non-smoker  |  -.7286778   .2167669    -3.36   0.001    -1.153533   -.3038226
                           |
                       bmi |   .0006164   .0182809     0.03   0.973    -.0352135    .0364463
                     _cons |   6.394118   .6369874    10.04   0.000     5.145646    7.642591
--------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
PID: Unstructured            |
                 var(age_13) |   .1154157   .0363554      .0622501     .213988
                  var(_cons) |   10.83367   2.768934      6.564788    17.87849
           cov(age_13,_cons) |  -.7929476   .3031181     -1.387048   -.1988471
-----------------------------+------------------------------------------------
               var(Residual) |   6.217284   .2902942      5.673576    6.813097
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 405.18                Prob > chi2 = 0.0000
*/

margins i.alc, at(age_13=(0(4)16)) vsquish
marginsplot, ytitle("Predicted K-6 Scores") xtitle ("Age centered at 13") title("Predictions By Alcohol Use Adjusted for Covariates") name(alcohol_pred_adjusted, replace) x(age_13)

margins i.smoke, at(age_13=(0(4)16)) vsquish
marginsplot, ytitle("Predicted K-6 Scores") xtitle ("Age centered at 13") title("Predictions By Smoking Status Adjusted for Covariates") name(alcohol_pred_adjusted, replace) x(age_13)

estimates restore model1
estat ic
estimates restore model2
estat ic
estimates restore model3
estat ic
estimates restore model4
estat ic

/*
-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
      model1 |      5,190          .  -13460.92       3   26927.84    26947.5
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
      model2 |      5,190          .  -13413.21       6   26838.42   26877.75
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
      model3 |      4,364          .  -11350.08       8   22716.15    22767.2
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
      model4 |      2,064          .  -5310.156      18   10656.31    10757.7
-----------------------------------------------------------------------------
*/

*****************************
**** Logistic Regression ****
*****************************

use "/Users/wuyufei/Desktop/Longitudinal/Final Project/final_long2.dta", clear
gen distress_bi = .
replace distress_bi = 1 if distress >= 13
replace distress_bi = 0 if distress < 13
replace distress_bi = . if distress == .

xtset PID age_13
xtlogit distress_bi i.alc##c.age_13 bmi i.race i.smoke, or

margins i.alc, at(age_13 = (0(4)16)) level(95)
marginsplot, xtitle("Age centered at 13") ytitle("Probability of Non-Specific Distress") title("Probability of Non-Specific Distress By Alcohol Use") name(logit_graph, replace)

