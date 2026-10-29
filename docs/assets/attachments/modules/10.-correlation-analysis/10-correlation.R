### Correlation ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/attachments/data/0-packages-data.R"))


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

### 3.1) --------------------------------------------------------------------





### 3.2) --------------------------------------------------------------------







## Sample assignment ------------------------------------------------------
### 3.1) --------------------------------------------------------------------
tab_corr (gss[c("variable1_here", "variable2_here")],
p.numeric = T, triangle="lower")

tab_corr (gss[c("hompop", "earnrs")],
p.numeric = T, triangle="lower")




### 3.2) ---------------------------------------------------------------------

scatterplot(gss, "variable1_here", "variable2_here")

scatterplot(gss, "hompop", "earnrs")




