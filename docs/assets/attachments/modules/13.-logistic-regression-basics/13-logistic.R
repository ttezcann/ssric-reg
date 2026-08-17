### Logistic regression ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/r-scripts/0-packages-data.R"))



# Dummy variable: Categorical (nominal/ordinal) - class -------------------
gss$lowerclass <- 
ifelse(gss$class == 1, 1, 0 | gss$class == 2, 1, 0,
label = "Perceiving as lower class")

gss$higherclass <- 
ifelse(gss$class == 3, 1, 0 | gss$class == 4, 1, 0,
label = "Perceiving as higher class")


# Dummy variable: Categorical (binary) - sex ------------------------------
gss$male <- 
ifelse(gss$sex == 1, 1, 0,
label = "Being male")

gss$female <- 
ifelse(gss$sex == 2, 1, 0,
label = "Being female")


# Dummy variable: Categorical (nominal/ordinal) - race --------------------
gss$white <- 
ifelse(gss$race == 1, 1, 0,
label = "Being white")

gss$nonwhite <- 
ifelse(gss$race == 2 | gss$race == 3, 1, 0,
label = "Being nonwhite")


# Logistic regression -----------------------------------------------------
model1 <- glm(higherclass ~ educ + female + nonwhite, data = gss, family = binomial(link="logit"))
tab_model(model1, show.std = T, show.ci = F, collapse.se = T)



# WORKING SPACE -----------------------------------------------------------
## Assignment -------------------------------------------------------------
### 1) --------------------------------------------------------------------





### 2) --------------------------------------------------------------------





### 3) ---------------------------------------------------------------------






### 4) ---------------------------------------------------------------------






## Sample assignment ------------------------------------------------------
### 1) --------------------------------------------------------------------
gss$dummyvar2 <- 
ifelse(gss$orig_var == value | gss$orig_var == value | gss$orig_var == value, 1, 0,
label = "Dummy variable's variable label")


gss$religious <- 
ifelse(gss$relpersn == 1 | gss$relpersn == 2, 1, 0,
label = "Being religious")

gss$notreligious <- 
ifelse(gss$relpersn == 3 | gss$relpersn == 4, 1, 0,
label = "Being not religious")


### 2) --------------------------------------------------------------------
gss$dummyvar1 <- 
ifelse(gss$orig_var == value, 1, 0,
label = "Dummy variable's variable label")

gss$dummyvar2 <- 
ifelse(gss$orig_var == value, 1, 0,
label = "Dummy variable's variable label")


gss$male <- 
ifelse(gss$sex == 1, 1, 0,
label = "Being male")

gss$female <- 
ifelse(gss$sex == 2, 1, 0,
label = "Being female")


### 3) ---------------------------------------------------------------------
gss$dummyvar1 <- 
ifelse(gss$orig_var == value, 1, 0,
label = "Dummy variable's variable label")

gss$dummyvar2 <- 
ifelse(gss$orig_var == value | gss$orig_var == value | gss$orig_var == value, 1, 0,
label = "Dummy variable's variable label")


gss$white <- 
ifelse(gss$race == 1, 1, 0,
label = "Being white")

gss$nonwhite <- 
ifelse(gss$race == 2 | gss$race == 3, 1, 0,
label = "Being nonwhite")


### 4) ---------------------------------------------------------------------
model1 <- glm(dummy_outcome_here ~ factor1_here + factor2_here + factor3_here, data = gss, family = binomial(link="logit"))
tab_model(model1, show.std = T, show.ci = F, collapse.se = T)

model1 <- glm(religious ~ female + white + educ + age, data = gss, family = binomial(link="logit"))
tab_model(model1, show.std = T, show.ci = F, collapse.se = T)


