*************************************
* Final Project
* Longitudinal Data Analysis Projects
*************************************

use "/Users/wuyufei/Desktop/Longitudinal/Final Project/finalproj_2023.dta", clear

***********************
**** Data Cleaning ****
***********************

* Use the first 5 waves since alcohol information is only contained in first 5 waves

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

keep PID TAS05 TAS07 TAS09 TAS11 TAS13 TA050938 TA070919 TA090983 TA111125 TA131217 TA050766 TA070737 TA090796 TA130945 TA150967 TA050884 TA050762 TA070733 TA090792 TA110908 TA130941 TA050944 TA070925 TA090989 TA111131 TA131223 ER33804

replace TAS05 = 0 if TAS05 == .
replace TAS07 = 0 if TAS07 == .
replace TAS09 = 0 if TAS09 == .
replace TAS11 = 0 if TAS11 == .
replace TAS13 = 0 if TAS13 == .
gen TAS = 0
replace TAS = TAS05 + TAS07 + TAS09 + TAS11 + TAS13

* prefer at least 3 observations
keep if TAS > 2

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
rename ER33804 age

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

keep PID distress* alc* smoke* bmi* race age

lab def alcohol 0 "No" 1 "Yes"
lab val alc* alcohol

lab def smk 0 "current smoker" 1 "former smoker" 2 "non-smoker"
lab val smoke* smk

*** Total N = 1,452
describe

*** Outcome: Non-specific distress

sum distress*
/*

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
   distress1 |        672    5.433036    3.566483          0         24
   distress2 |      1,040    5.164423     3.74948          0         23
   distress3 |      1,399    5.142244    3.655076          0         24
   distress4 |      1,376     4.77907    3.703054          0         24
   distress5 |        992    4.865927    3.762523          0         24
*/



*** Main predictor: Alcohol use
tab alc1
/*
tab alc1

       alc1 |      Freq.     Percent        Cum.
------------+-----------------------------------
         No |        251       37.30       37.30
        Yes |        422       62.70      100.00
------------+-----------------------------------
      Total |        673      100.00
*/

tab alc5
/*
       alc5 |      Freq.     Percent        Cum.
------------+-----------------------------------
         No |        149       26.75       26.75
        Yes |        408       73.25      100.00
------------+-----------------------------------
      Total |        557      100.00
*/

*** Baseline age
sum age
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
         age |      1,452    16.97521     2.62248          0         21
*/

*** Race
tab race
/*
                 L7 RACE MENTION #1 |      Freq.     Percent        Cum.
------------------------------------+-----------------------------------
                              White |        343       50.89       50.89
  Black, African-American, or Negro |        282       41.84       92.73
   American Indian or Alaska Native |          5        0.74       93.47
                              Asian |          7        1.04       94.51
Native Hawaiian or Pacific Islander |          3        0.45       94.96
                    Some other race |          7        1.04       95.99
                                 DK |          2        0.30       96.29
                        NA; refused |         25        3.71      100.00
------------------------------------+-----------------------------------
                              Total |        674      100.00
*/

*** Smoking status (baseline & end)
tab smoke1
/*
        smoke1 |      Freq.     Percent        Cum.
---------------+-----------------------------------
current smoker |        159       23.63       23.63
 former smoker |         86       12.78       36.40
    non-smoker |        428       63.60      100.00
---------------+-----------------------------------
         Total |        673      100.00
*/

tab smoke5
/*
       smoke5 |      Freq.     Percent        Cum.
---------------+-----------------------------------
current smoker |        203       20.46       20.46
 former smoker |        162       16.33       36.79
    non-smoker |        627       63.21      100.00
---------------+-----------------------------------
         Total |        992      100.00
*/

*** Body mass index
sum bmi*
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
        bmi1 |        667    24.67976    5.056179       16.2       53.9
        bmi2 |      1,031    25.34791    5.456751       16.3       53.9
        bmi3 |      1,385    25.66693    5.620094       15.3       51.4
        bmi4 |      1,363    26.26823     5.88721       16.3       58.4
        bmi5 |        978    26.48139    5.943688       15.4       51.5
*/



********************************
**** Individual Growth Plots ***
********************************

*** Profile plot

preserve
set seed 339487731
sample 10, count
profileplot distress*, by(PID) name(profile_plot, replace)
restore

*** Empirical growth plot

* Reshape the data

reshape long distress@ alc@ smoke@ bmi@, i(PID) j(wave)

lab val distress dis
lab val alc alcohol
lab val smoke smk

replace wave = wave - 1 // center the wave

save "/Users/wuyufei/Desktop/Longitudinal/Final Project/final_long.dta", replace

list in 1/10

/*
	 +--------------------------------------------------------------------+
     |  PID   wave   age    race   distress    bmi   alc            smoke |
     |--------------------------------------------------------------------|
  1. | 4039      0    14       .          .      .     .                . |
  2. | 4039      1    14       .          .      .     .                . |
  3. | 4039      2    14       .          3   28.3    No   current smoker |
  4. | 4039      3    14       .          4   25.6    No    former smoker |
  5. | 4039      4    14       .          4   26.6    No   current smoker |
     |--------------------------------------------------------------------|
  6. | 4180      0    20   White          5   21.3   Yes    former smoker |
  7. | 4180      1    20   White          7   20.5   Yes   current smoker |
  8. | 4180      2    20   White          6   21.1   Yes   current smoker |
  9. | 4180      3    20   White          7   21.1     .   current smoker |
 10. | 4180      4    20   White          .      .     .                . |
     +--------------------------------------------------------------------+
*/

* Empirical growth plots for the first 20 individuals
preserve
keep if _n <= 100
graph twoway scatter distress wave, by(PID) ylabel(0(5)24) xlabel(0(1)4) name(growth_scatter, replace)
graph twoway (lowess distress wave)(scatter distress wave), by(PID) ylabel(0(5)24) xlabel(0(1)4) name(growth_nonpara, replace)
graph twoway (lfit distress wave)(scatter distress wave), by(PID) ylabel(0(5)24) xlabel(0(1)4) name(growth_para, replace)
restore



***********************************
**** Individual OLS Regressions ***
***********************************

use "/Users/wuyufei/Desktop/Longitudinal/Final Project/final_long.dta", clear

egen grp = group(PID)
generate p2=.
forvalues i = 1/1452 {
  quietly regress distress wave if grp ==`i' 
  quietly predict p 
  quietly replace p2=p if grp==`i'
  quietly drop p
}

graph twoway (scatter p2 wave, msym(i) connect(L))(lfit distress wave, ylabel(0(5)24) xlabel(0(1)4) lc(red) lwidth(thick) name(OLS_reg, replace) legend(lab (1 "K-6 Scale"))) 

*** Without covariates
use "/Users/wuyufei/Desktop/Longitudinal/Final Project/final_long.dta", clear

statsby _b[_cons] _se[_cons] _b[wave] _se[wave] (e(rmse)^2) e(r2), by(PID): regress distress wave
list, clean
rename _stat_1 intercept 
rename _stat_3 slope

sum intercept slope
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
   intercept |      1,452    5.586171    4.666319  -14.83333       32.5
       slope |      1,452   -.2373006    1.511675       -7.5        8.5
*/

correlate intercept slope
/*
(obs=1,452)

             | interc~t    slope
-------------+------------------
   intercept |   1.0000
       slope |  -0.7455   1.0000
*/


*** With covariates
use "/Users/wuyufei/Desktop/Longitudinal/Final Project/final_long.dta", clear

statsby _b[_cons] _se[_cons] _b[wave] _se[wave] (e(rmse)^2) e(r2), by(PID): regress distress wave age i.smoke i.race bmi
list, clean
rename _stat_1 intercept 
rename _stat_3 slope

sum intercept slope
/* 
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
   intercept |        674    5.133561    197.8821  -1813.993    2604.99
       slope |        674    .3548072    15.68193  -81.00121   333.0051
*/

correlate intercept slope

/*
(obs=674)

             | interc~t    slope
-------------+------------------
   intercept |   1.0000
       slope |   0.5784   1.0000
*/



***********************************
**** Unconditional Mean Model *****
***********************************

use "/Users/wuyufei/Desktop/Longitudinal/Final Project/final_long.dta", clear

mixed distress || PID:, mle
est sto model1

/*
Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood = -14260.945  
Iteration 1:   log likelihood = -14260.945  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =      5,479
Group variable: PID                             Number of groups  =      1,452
                                                Obs per group:
                                                              min =          2
                                                              avg =        3.8
                                                              max =          5
                                                Wald chi2(0)      =          .
Log likelihood = -14260.945                     Prob > chi2       =          .

------------------------------------------------------------------------------
    distress | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
       _cons |    5.05396    .076721    65.87   0.000     4.903589     5.20433
------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
PID: Identity                |
                  var(_cons) |   6.584551   .3215517      5.983542    7.245928
-----------------------------+------------------------------------------------
               var(Residual) |   7.207276    .160832      6.898845    7.529496
------------------------------------------------------------------------------
LR test vs. linear model: chibar2(01) = 1360.14       Prob >= chibar2 = 0.0000

*/

* AIC/BIC
estat ic
/*

Akaike's information criterion and Bayesian information criterion

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
      model1 |      5,479          .  -14260.94       3   28527.89   28547.72
-----------------------------------------------------------------------------
*/

* ICC
estat icc
/*
Intraclass correlation

------------------------------------------------------------------------------
                       Level |        ICC   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
                         PID |   .4774241   .0140891      .4499068    .5050792
------------------------------------------------------------------------------
*/



************************************
**** Unconditional Growth Model ****
************************************

mixed distress wave || PID: wave, cov(un) mle
est sto model2

/*
Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood = -14210.823  
Iteration 1:   log likelihood = -14209.624  
Iteration 2:   log likelihood =  -14209.62  
Iteration 3:   log likelihood =  -14209.62  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =      5,479
Group variable: PID                             Number of groups  =      1,452
                                                Obs per group:
                                                              min =          2
                                                              avg =        3.8
                                                              max =          5
                                                Wald chi2(1)      =      38.85
Log likelihood =  -14209.62                     Prob > chi2       =     0.0000

---------------------------------------------------------------------------------
       distress | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
----------------+----------------------------------------------------------------
           wave |  -.2135079   .0342546    -6.23   0.000    -.2806456   -.1463702
          _cons |   5.522278   .1049583    52.61   0.000     5.316564    5.727992
---------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
PID: Unstructured            |
                   var(wave) |   .4045396   .0664558       .293177    .5582031
                  var(_cons) |   7.645997   .6010962      6.554148    8.919736
             cov(wave,_cons) |  -.6506264   .1688018      -.981472   -.3197809
-----------------------------+------------------------------------------------
               var(Residual) |   6.382025   .1704241       6.05659    6.724946
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 1447.51               Prob > chi2 = 0.0000
*/



****************************
**** Conditional Models ****
****************************

*** Without covariates
mixed distress c.wave##i.alc || PID: wave, cov(un) var mle
est sto model3

/*
Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood =  -12002.64  
Iteration 1:   log likelihood = -11999.166  
Iteration 2:   log likelihood = -11999.146  
Iteration 3:   log likelihood = -11999.146  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =      4,599
Group variable: PID                             Number of groups  =      1,452
                                                Obs per group:
                                                              min =          1
                                                              avg =        3.2
                                                              max =          4
                                                Wald chi2(3)      =      25.33
Log likelihood = -11999.146                     Prob > chi2       =     0.0000

---------------------------------------------------------------------------------
       distress | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
----------------+----------------------------------------------------------------
           wave |  -.1603977   .0714371    -2.25   0.025    -.3004118   -.0203836
                |
            alc |
           Yes  |   .2589895   .1872865     1.38   0.167    -.1080853    .6260643
                |
     alc#c.wave |
           Yes  |  -.0693297   .0850234    -0.82   0.415    -.2359724     .097313
                |
          _cons |   5.349012   .1572073    34.03   0.000     5.040891    5.657133
---------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
PID: Unstructured            |
                   var(wave) |   .3907075    .096746      .2404802    .6347814
                  var(_cons) |   7.072217   .6322623      5.935501    8.426626
             cov(wave,_cons) |  -.4653093   .2140363     -.8848127    -.045806
-----------------------------+------------------------------------------------
               var(Residual) |   6.494062    .199704      6.114211    6.897511
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 1072.09               Prob > chi2 = 0.0000
*/


*** With all covariates
mixed distress c.wave##i.alc age i.race i.smoke c.wave#i.smoke bmi c.wave#c.bmi || PID: wave, cov(un) var mle
est sto model4

/*
Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood = -5654.9402  
Iteration 1:   log likelihood = -5653.7796  
Iteration 2:   log likelihood = -5653.7759  
Iteration 3:   log likelihood = -5653.7759  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =      2,195
Group variable: PID                             Number of groups  =        674
                                                Obs per group:
                                                              min =          1
                                                              avg =        3.3
                                                              max =          4
                                                Wald chi2(17)     =      42.69
Log likelihood = -5653.7759                     Prob > chi2       =     0.0005

------------------------------------------------------------------------------------------
                distress | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------------------+----------------------------------------------------------------
                    wave |  -.1564747   .3544468    -0.44   0.659    -.8511777    .5382284
                         |
                     alc |
                    Yes  |  -.0404531   .2306885    -0.18   0.861    -.4925942     .411688
                         |
              alc#c.wave |
                    Yes  |   .0226345   .1466332     0.15   0.877    -.2647613    .3100304
                         |
                     age |  -.0837836   .1003439    -0.83   0.404    -.2804539    .1128868
                         |
                    race |
Black, African-Americ..  |  -.0285351   .2354185    -0.12   0.904    -.4899468    .4328767
American Indian or Al..  |  -.5858198   1.278574    -0.46   0.647     -3.09178     1.92014
                  Asian  |   .8719649   1.067239     0.82   0.414    -1.219785    2.963715
Native Hawaiian or Pa..  |  -1.042566   1.603399    -0.65   0.516    -4.185169    2.100038
        Some other race  |   1.699349   1.056587     1.61   0.108     -.371524    3.770222
                     DK  |   1.210677    1.95848     0.62   0.536    -2.627873    5.049227
            NA; refused  |  -.2040278   .5794947    -0.35   0.725    -1.339817    .9317611
                         |
                   smoke |
          former smoker  |    -.18572   .3604521    -0.52   0.606    -.8921931    .5207531
             non-smoker  |  -.9905717   .2789664    -3.55   0.000    -1.537336   -.4438076
                         |
            smoke#c.wave |
          former smoker  |  -.2570019   .2156948    -1.19   0.233     -.679756    .1657522
             non-smoker  |   .1029419   .1562637     0.66   0.510    -.2033293    .4092132
                         |
                     bmi |   .0104612   .0235326     0.44   0.657    -.0356618    .0565843
                         |
            c.wave#c.bmi |  -.0056166   .0116285    -0.48   0.629     -.028408    .0171749
                         |
                   _cons |   7.350643   1.960387     3.75   0.000     3.508354    11.19293
------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
PID: Unstructured            |
                   var(wave) |   .5909184   .1544315       .354057    .9862383
                  var(_cons) |   6.279473   .6394271       5.14336    7.666541
             cov(wave,_cons) |  -.5570092   .2572218     -1.061155   -.0528637
-----------------------------+------------------------------------------------
               var(Residual) |   6.071107   .2790112      5.548161    6.643344
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 438.43                Prob > chi2 = 0.0000
*/

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
      model1 |      5,479          .  -14260.94       3   28527.89   28547.72
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
      model2 |      5,479          .  -14209.62       6   28431.24   28470.89
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
      model3 |      4,599          .  -11999.15       8   24014.29   24065.76
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
      model4 |      2,195          .  -5653.776      22   11351.55   11476.82
-----------------------------------------------------------------------------
*/
