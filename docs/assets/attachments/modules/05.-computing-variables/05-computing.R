### Computing ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/r-scripts/0-packages-data.R"))



# Recode variables, if necessary ------------------------------------------
gss$disrspctreversed <- 
rec(gss$disrspct, rec = 
"1 = 6 [Almost every day]; 
2 = 5 [At least once a week];
3 = 4 [A few times a month];
4 = 3 [A few times a year];
5 = 2 [Less than once a year];
6 = 1 [Never]",
var.label = "Recoded frequency of being treated with less courtesy or respect")

gss$poorservreversed <- 
rec(gss$poorserv, rec = 
"1 = 6 [Almost every day]; 
2 = 5 [At least once a week];
3 = 4 [A few times a month];
4 = 3 [A few times a year];
5 = 2 [Less than once a year];
6 = 1 [Never]",
var.label = "Recoded frequency of receiving poorer service at restaurants or stores")

gss$threatenreversed <- 
rec(gss$threaten, rec = 
"1 = 6 [Almost every day]; 
2 = 5 [At least once a week];
3 = 4 [A few times a month];
4 = 3 [A few times a year];
5 = 2 [Less than once a year];
6 = 1 [Never]",
var.label = "Recoded frequency of being threatened or harassed")


# Index variable ----------------------------------------------------------
gss$discrimination_index <- structure(rowMeans(
gss[, c("disrspctreversed", "poorservreversed", "threatenreversed")]),
label = "Perceived everyday discrimination index score")


# Descriptive table -------------------------------------------------------
descr(gss$discrimination_index, out = "v", show = "short")


# WORKING SPACE -----------------------------------------------------------
## Assignment -------------------------------------------------------------
### 2) --------------------------------------------------------------------





### 3) --------------------------------------------------------------------





### 4) --------------------------------------------------------------------





### 5) --------------------------------------------------------------------





### 6) --------------------------------------------------------------------





## Sample assignment ------------------------------------------------------
### 2) --------------------------------------------------------------------
frq(gss$variable_here, out = "v")

frq(gss$relpersn, out = "v")



### 3) --------------------------------------------------------------------
frq(gss$variable_here, out = "v")

frq(gss$sprtprsn, out = "v")



### 4) --------------------------------------------------------------------
gss$new_variable_here <- 
rec(gss$original_variable_here, rec =
"1 = 4 [label1]; 
2 = 3 [label2];
3 = 2 [label3];
4 = 1 [label4]",
var.label = "Recoded variable label")

gss$relpersnreversed <- 
rec(gss$relpersn, rec =
"1 = 4 [Very religious]; 
2 = 3 [Moderately religious];
3 = 2 [Slightly religious];
4 = 1 [Not religious at all]",
var.label = "Recoded subjective religiosity")

gss$sprtprsnreversed <- 
rec(gss$sprtprsn, rec =
"1 = 4 [Very spiritual]; 
2 = 3 [Moderately spiritual];
3 = 2 [Slightly spiritual];
4 = 1 [Not spiritual at all]",
var.label = "Recoded level of spirituality")




### 5) --------------------------------------------------------------------
gss$new_index_variable_here <- structure(rowMeans(
gss[, c("variable1_here", "variable2_here", "variable3_here")]),
label = "Variable label of the index variable")

gss$relspiindex <- structure(rowMeans(
gss[, c("relpersnreversed", "sprtprsnreversed")]),
label = "The religiosity and spirituality index score")




### 6) --------------------------------------------------------------------
descr(gss$new_index_variable_here, out = "v", show = "short")

descr(gss$relspiindex, out = "v", show = "short")







