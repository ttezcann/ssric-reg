### Recoding ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/r-scripts/0-packages-data.R"))



# (1) Recode (Merging values) ---------------------------------------------
## Frequency table for the original variable, marital ---------------------
frq(gss$marital, out = "v")


## Recoding code marital > maritalgroups ----------------------------------
gss$maritalgroups <- 
rec(gss$marital, rec = 
"1 = 1 [Married]; 
2, 3, 4 = 2 [Formerly in union];
5 = 3 [Never married]",
var.label = "Recoded respondents' marital status")


# Frequency table for the recoded variable, maritalgroups -----------------
frq(gss$maritalgroups, out = "v")



# (2) Recode (Reversing values) -------------------------------------------
## Frequency table for the original variable, satjob ----------------------
frq(gss$satjob, out = "v")


## Recoding code satjob > satjobreversed ----------------------------------
gss$satjobreversed <- 
rec(gss$satjob, rec = 
"1 = 4 [Very satisfied]; 
2 = 3 [Moderately satisfied];
3 = 2 [A little dissatisfied];
4 = 1 [Very dissatisfied]",
var.label = "Recoded level of work satisfaction")


## Frequency table for the recoded variable, satjobreversed ---------------
frq(gss$satjobreversed, out = "v")



# (3) Recode (Transforming continuous variables into groups)----
## Descriptive table for the original variable, educ----
descr(gss$educ, out = "v", show = "short")

## Recoding code educ > educgroups----
gss$educgroups <- 
rec(gss$educ, rec =
"0 : 11 = 1 [Low level of education]; 
12 : 15 = 2 [Moderate level of education];
16 : 20 = 3 [High level of education]",
var.label = "Recoded respondents' education in years")

## Frequency table for the recoded variable, educgroups----
frq(gss$educgroups, out = "v")




# WORKING SPACE -----------------------------------------------------------
## Assignment --------------------------------------------------------------
### 2) ----------------------------------------------------------------------






### 3) ----------------------------------------------------------------------






### 4) ----------------------------------------------------------------------







## Sample assignment --------------------------------------------------------
### 2) ----------------------------------------------------------------------
gss$new_variable_here <-
rec(gss$original_variable_here, rec =
"number1, number2 = 1 [label1]; 
number3 = 2 [label2]",
var.label = "Recoded variable label")

gss$spankingrecoded <-
rec(gss$spanking, rec =
"1, 2 = 1 [Agree]; 
3, 4 = 2 [Disagree]",
var.label = "Recoded favoring spanking children to discipline")

frq(gss$variable_here, out = "v")

frq(gss$spankingrecoded, out = "v")



### 3) ----------------------------------------------------------------------
gss$new_variable_here <- 
rec(gss$original_variable_here, rec =
"1 = 3 [label1];
2 = 2 [label2]; 
3 = 1 [label3]",
var.label = "Recoded variable label")

gss$natenrgyreversed <- 
rec(gss$natenrgy, rec =
"1 = 3 [Too much];
2 = 2 [About right]; 
3 = 1 [Too little]",
var.label = "Recoded support level for government spending for developing alternative energy sources")


frq(gss$variable_here, out = "v")

frq(gss$natenrgyreversed, out = "v")



### 4) ----------------------------------------------------------------------
gss$new_variable_here <-
rec(gss$original_variable_here, rec =
"number(from) : number(to) = 1 [Label1]; 
number(from) : number(to) = 2 [Label2];
number(from) : number(to) = 3 [Label3]",
var.label = "Recoded variable label")

gss$weekswrkgroups <-
rec(gss$weekswrk, rec =
"0 : 10 = 1 [Worked less than 10 weeks]; 
11 : 40 = 2 [Worked between 10 and 40 weeks];
41 : 52 = 3 [Worked more than 40 weeks]",
var.label = "Recoded weeks respondents worked last year")

frq(gss$variable_here, out = "v")

frq(gss$weekswrkgroups, out = "v")


