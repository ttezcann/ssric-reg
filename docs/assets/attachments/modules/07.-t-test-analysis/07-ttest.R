### T-Test ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/r-scripts/0-packages-data.R"))



# T-test ------------------------------------------------------------------
## GSS Example 1: Significant p-value (sex and conrinc) --------------------
t.test(conrinc ~ sex, data = gss) |> 
parameters() |> display(format="html")


## GSS Example 2: Insignificant p-value (sex and educ) --------------------
t.test(educ ~ sex, data = gss) |> 
parameters() |> display(format="html")


## GSS example 3: Significant p-value (maritalbinary and tvhours) ---------
gss$maritalbinary <- 
rec(gss$marital, rec = 
"5 = 1 [Single]; 
1, 2, 3, 4 = 2 [Nonsingle]",
var.label = "Recoded respondents' marital status")

t.test(tvhours ~ maritalbinary, data = gss) |> 
parameters() |> display(format="html")




# WORKING SPACE -----------------------------------------------------------
## Assignment --------------------------------------------------------------
### 1) ----------------------------------------------------------------------





### 2) ----------------------------------------------------------------------





### 3) ----------------------------------------------------------------------





### 4) ----------------------------------------------------------------------





### 5) ----------------------------------------------------------------------





## Sample assignment --------------------------------------------------------------
### 1) ----------------------------------------------------------------------
t.test(outcome_here ~ factor_here, data = gss) |>
parameters() |> display(format="html")

t.test(weekswrk ~ wrkslf, data = gss) |>
parameters() |> display(format="html")



### 2) ----------------------------------------------------------------------
t.test(outcome_here ~ factor_here, data = gss) |>
parameters() |> display(format="html")

t.test(hrs2 ~ postlife, data = gss) |>
parameters() |> display(format="html")



### 3) ----------------------------------------------------------------------
gss$new_variable_here <-
rec(gss$original_variable_here, rec =
"number(from) : number(to) = 1 [Label1]; 
number(from) : number(to) = 2 [Label2]",
var.label = "Recoded variable label")


gss$educbinary <- rec(gss$educ, rec = 
"0:14=1 [Low education level]; 
15:20=2 [High education level]",
var.label = "Recoded respondents' education in years")



### 4) ----------------------------------------------------------------------
frq(gss$variable_here, out = "v")

frq(gss$educbinary, out = "v")



### 5) ----------------------------------------------------------------------
t.test(outcome_here ~ factor_here, data = gss) |>
parameters() |> display(format="html")

t.test(tvhours ~ educbinary, data = gss) |>
parameters() |> display(format="html")



