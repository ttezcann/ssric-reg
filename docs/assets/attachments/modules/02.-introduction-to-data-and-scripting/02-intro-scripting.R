### Introduction to scripting ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/attachments/data/0-packages-data.R"))


# The codes examples ------------------------------------------------------

## Frequency table of sex variable -----------------------------------------
frq(gss$sex, out="v")


## Bar graph of sex variable -----------------------------------------------
plot_frq(gss$sex,
type = "bar",
geom.colors = "#336699")


## Descriptive table of age variable ---------------------------------------
descr(gss$age, out = "v", show = "short")


## Histogram of age variable -----------------------------------------------
plot_frq(gss$age, 
type = "hist", normal.curve = T, show.mean = T, show.sd = T,
geom.colors = "#336699", normal.curve.color = "#9b2226")


# WORKING SPACE -----------------------------------------------------------
## Assignment --------------------------------------------------------------
### 5) Frequency table of race variable -------------------------------------



### 6) Bar graph of race variable -------------------------------------------




### 7) Descriptive table of childs variable ---------------------------------




### 8) Histogram of childs variable ----------------------------------------




## Sample assignment --------------------------------------------------------------
### 5) Frequency table of marital variable -------------------------------------
frq(gss$variable_here, out = "v") # model code

frq(gss$marital, out = "v") # working code


### 6) Bar graph of marital variable -------------------------------------------
plot_frq(gss$variable_here,
type = "bar",
geom.colors = "#336699") # model code

plot_frq(gss$marital,
type = "bar",
geom.colors = "#336699") # working code



### 7) Descriptive table of sei10 variable ---------------------------------
descr(gss$variable_here, out = "v", show = "short") # model code

descr(gss$sei10, out = "v", show = "short") # working code



### 8) Histogram of sei10 variable ----------------------------------------
plot_frq(gss$variable_here, 
type = "hist", normal.curve = T, show.mean = T, show.sd = T,
geom.colors = "#336699", normal.curve.color = "#9b2226") # model code

plot_frq(gss$sei10, 
type = "hist", normal.curve = T, show.mean = T, show.sd = T,
geom.colors = "#336699", normal.curve.color = "#9b2226") # working code










