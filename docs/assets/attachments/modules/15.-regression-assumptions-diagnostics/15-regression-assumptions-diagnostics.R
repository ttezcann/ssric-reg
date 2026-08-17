### Regression assumptions and diagnostics ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/r-scripts/0-packages-data.R"))



# Recoding and computing variable -----------------------------------------
## Recode sociallife_index (social life index) variables and compute -------

gss$socrel_reversed <- rec(gss$socrel, rec = 
"1=7 [almost daily];
2=6 [once or twice a week]; 
3=5 [several times a month]; 
4=4 [about once a month]; 
5=3 [several times a year]; 
6=2 [about once a year];
7=1 [never]", append = FALSE)

gss$socommun_reversed <- rec(gss$socommun, rec = 
"1=7 [almost daily];
2=6 [once or twice a week]; 
3=5 [several times a month]; 
4=4 [about once a month]; 
5=3 [several times a year]; 
6=2 [about once a year];
7=1 [never]", append = FALSE)

gss$sociallife_index <- structure(rowMeans(
gss[, c("socrel_reversed", "socommun_reversed")], na.rm = TRUE), 
label = "Social life index score")


## Dummy variable for `life` ---------------------------------------------
gss$exciting <- 
ifelse(gss$life == 1, 1, 0,
label = "Finding life exciting")

gss$routine <- 
ifelse(gss$life == 2, 1, 0,
label = "Finding life routine")

gss$dull <- 
ifelse(gss$life == 3, 1, 0,
label = "Finding life dull")


# Model 1 -----------------------------------------------------------------
## Linear regression (model 1) --------------------------------------------
model1 <- lm(sociallife_index ~ sei10 + educ + conrinc + coninc + prestg10 + childs + exciting + routine, data = gss)
tab_model(model1, show.std = T, show.ci = F, collapse.se = T)

## Performance diagnostic (Model 1) ---------------------------------------
check_model(model1)

## Homoscedasticity (Model 1) ---------------------------------------------
check_heteroscedasticity(model1)


## Multicollinearity (Model 1) --------------------------------------------
check_collinearity(model1)


## Scatterplot graph matrix (Model 1) -------------------------------------
scatterplot_matrix <- gss[, c("sociallife_index", "sei10", "educ", "conrinc", "coninc", "prestg10", "childs")]
pairs_panels_pval(scatterplot_matrix, color = "#15616d")


# Model 2 -----------------------------------------------------------------
## New dummy variable for `life` ---------------------------------------------
gss$exciting_new <- 
ifelse(gss$life == 1, 1, 0,
label = "Finding life exciting")

gss$routine_dull_new <- 
ifelse(gss$life == 2 | gss$life == 3, 1, 0,
label = "Finding life routine or dull")

## Linear regression (Model 2) --------------------------------------------
model2 <- lm(sociallife_index ~ educ + exciting_new, data = gss)
tab_model(model2, show.std = T, show.ci = F, collapse.se = T)


## Performance diagnostic (Model 2) ---------------------------------------
check_model(model2)


## Homoscedasticity (Model 2) --------------------------------------------
check_heteroscedasticity(model2)


## Multicollinearity (Model 2) -------------------------------------------
check_collinearity(model2)


