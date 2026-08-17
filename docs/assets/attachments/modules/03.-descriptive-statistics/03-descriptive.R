### Descriptive statistics ###


# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/r-scripts/0-packages-data.R"))

# Frequency table (for categorical variables ------------------------------
frq(gss$finalter, out = "v")


# Bar graph (for categorical variables) -----------------------------------
plot_frq(gss$satjob,
type = "bar", 
geom.colors = "#336699")


# Descriptive table (for continuous variables) ----------------------------
descr(gss$educ, out = "v", show = "short")


# Histogram (for continuous variables) ------------------------------------
plot_frq(gss$age, 
type = "hist", normal.curve = T, show.mean = T, show.sd = T,
geom.colors = "#336699", normal.curve.color = "#9b2226")



# WORKING SPACE -----------------------------------------------------------
## Assignment --------------------------------------------------------------
### 1) ---------------------------------------------------------------------



### 2) ----------------------------------------------------------------------



### 3) ----------------------------------------------------------------------



### 4) ----------------------------------------------------------------------





## Sample assignment -------------------------------------------------------
### 1) ----------------------------------------------------------------------
frq(gss$variable_here, out = "v")

frq(gss$fear, out = "v")

### 2) ----------------------------------------------------------------------
plot_frq(gss$variable_here,
type = "bar",
geom.colors = "#336699")

plot_frq(gss$contv,
type = "bar",
geom.colors = "#336699")




### 3) ----------------------------------------------------------------------
descr(gss$variable_here, out = "v", show = "short")

descr(gss$weekswrk, out = "v", show = "short")




### 4) ----------------------------------------------------------------------
plot_frq(gss$variable_here, 
type = "hist", normal.curve = T, show.mean = T, show.sd = T,
geom.colors = "#336699", normal.curve.color = "#9b2226")

plot_frq(gss$maeduc, 
type = "hist", normal.curve = T, show.mean = T, show.sd = T,
geom.colors = "#336699", normal.curve.color = "#9b2226")

