### Chi-square ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/attachments/data/0-packages-data.R"))



# Chi-square (significant p-value)----
sjt.xtab(gss$degree, gss$health, show.row.prc = TRUE)


# Chi-square (insignificant p-value)----
sjt.xtab(gss$sex, gss$happy, show.row.prc = TRUE)


# WORKING SPACE -----------------------------------------------------------
## Assignment --------------------------------------------------------------
### 3) ----------------------------------------------------------------------





### 6) ----------------------------------------------------------------------





## Sample assignment --------------------------------------------------------------
### 3) ----------------------------------------------------------------------
sjt.xtab(gss$factor_here, gss$outcome_here, show.row.prc = TRUE)

sjt.xtab(gss$race, gss$satfin, show.row.prc = TRUE)




### 6) ----------------------------------------------------------------------
sjt.xtab(gss$factor_here, gss$outcome_here, show.row.prc = TRUE)

sjt.xtab(gss$sex, gss$parsol, show.row.prc = TRUE)



