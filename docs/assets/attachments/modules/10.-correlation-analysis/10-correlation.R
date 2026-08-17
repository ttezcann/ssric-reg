### Correlation ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/r-scripts/0-packages-data.R"))



# Bivariate correlation ---------------------------------------------------
## Correlation table (Significant and negative correlation) ---------------
tab_corr (gss[c("educ", "tvhours")],
p.numeric = T, triangle="lower")


## Scatterplot graph (Significant and negative correlation) ----------------
scatterplot(gss, "educ", "tvhours")


## Correlation table (Significant and positive correlation) ---------------
tab_corr (gss[c("masei10", "pasei10")],
p.numeric = T, triangle="lower")


## Scatterplot graph (Significant and positive correlation) ----------------
scatterplot(gss, "masei10", "pasei10")


## Correlation table (Nonsignificant correlation) --------------------------
tab_corr (gss[c("hrs1", "sibs")], 
p.numeric = T, triangle="lower")


## Scatterplot graph (Nonsignificant correlation) --------------------------
scatterplot(gss, "hrs1", "sibs")



# Multivariate correlation ------------------------------------------------
## Correlation table matrix -----------------------------------------------
tab_corr (gss[, c("educ", "tvhours", "masei10", "pasei10", "hrs1", "sibs")], 
p.numeric = T, triangle="lower", na.deletion = "pairwise")


## Scatterplot graph matrix -----------------------------------------------
scatterplot_matrix <- gss[, c("educ", "tvhours", "masei10", "pasei10", "hrs1", "sibs")]
pairs_panels_pval(scatterplot_matrix, color = "#15616d")



# WORKING SPACE -----------------------------------------------------------
## Assignment -------------------------------------------------------------
### 1) --------------------------------------------------------------------





### 2) --------------------------------------------------------------------





### 3) ---------------------------------------------------------------------





### 4) ---------------------------------------------------------------------





### 5) ---------------------------------------------------------------------





### 6) ---------------------------------------------------------------------





## Sample assignment ------------------------------------------------------
### 1) --------------------------------------------------------------------
tab_corr (gss[c("variable1_here", "variable2_here")],
p.numeric = T, triangle="lower")

tab_corr (gss[c("conrinc", "tvhours")],
p.numeric = T, triangle="lower")




### 2) --------------------------------------------------------------------
tab_corr (gss[c("variable1_here", "variable2_here")],
p.numeric = T, triangle="lower")

tab_corr (gss[c("maeduc", "paeduc")],
p.numeric = T, triangle="lower")



### 3) ---------------------------------------------------------------------
scatterplot(gss, "variable1_here", "variable2_here")

scatterplot(gss, "conrinc", "tvhours")




### 4) ---------------------------------------------------------------------
scatterplot(gss, "variable1_here", "variable2_here")

scatterplot(gss, "maeduc", "paeduc")




### 5) ---------------------------------------------------------------------
tab_corr (gss[, c("variable1_here", "variable2_here", "variable3_here", "variable4_here", "variable5_here", "variable6_here")],  
p.numeric = T, triangle="lower", na.deletion = "pairwise")

tab_corr (gss[, c("conrinc", "tvhours", "maeduc", "paeduc", "age", "sei10")],  
p.numeric = T, triangle="lower", na.deletion = "pairwise")




### 6) ---------------------------------------------------------------------
scatterplot_matrix <- gss[, c("variable1_here", "variable2_here", "variable3_here", "variable4_here", "variable5_here", "variable6_here")]
pairs_panels_pval(scatterplot_matrix, color = "#15616d")

scatterplot_matrix <- gss[, c("conrinc", "tvhours", "maeduc", "paeduc", "age", "sei10")]
pairs_panels_pval(scatterplot_matrix, color = "#15616d")



