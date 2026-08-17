### Dummy variables ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/r-scripts/0-packages-data.R"))


# Dummy variable example --------------------------------------------------
gss$male <- 
ifelse(gss$sex == 1, 1, 0,
label = "Being male")

gss$female <- 
ifelse(gss$sex == 2, 1, 0,
label = "Being female")


# Adding dummy variable to a regression model -----------------------------
model5 <- lm(conrinc ~ res16 + age + prestg10 + educ + male + female, data = gss)
tab_model(model5, show.std = T, show.ci = F, collapse.se = T)

## Error -------------------------------------------------------------------
# You will see the following error under RStudio console:
# Model matrix is rank deficient. Parameters `female` were not estimable.
# Model matrix is rank deficient. Parameters `female` were not estimable.
# Because one of the dummy variables were not ommitted.


# Dummy variable: Categorical (binary) ------------------------------------
gss$nonimmigrant <- 
ifelse(gss$born == 1, 1, 0,
label = "Being nonimmigrant")

gss$immigrant <- 
ifelse(gss$born == 2, 1, 0,
label = "Being immigrant")


# Dummy variable: Categorical (nominal/ordinal) ---------------------------
gss$married <- 
ifelse(gss$marital == 1, 1, 0,
label = "Being married")

gss$formerlyunion <- 
ifelse(gss$marital == 2 | gss$marital == 3 | gss$marital == 4, 1, 0,
label = "Being formerly in union")

gss$single <- 
ifelse(gss$marital == 5, 1, 0,
label = "Being single")


# Dummy variable: Continuous ----------------------------------------------
gss$lowses <- 
ifelse(gss$sei10 <= 40, 1, 0,
label = "Having low socio-economic status")

gss$moderateses <- 
ifelse(gss$sei10 >= 40 & gss$sei10 <= 75, 1, 0,
label = "Having moderate socio-economic status")

gss$highses <- 
ifelse(gss$sei10 >=76, 1, 0,
label = "Having high socio-economic status")


# Linear regression with dummy variables ----------------------------------
model5 <- lm(conrinc ~ res16 + age + prestg10 + educ + male + immigrant + married + single + lowses + moderateses, data = gss)
tab_model(model5, show.std = T, show.ci = F, collapse.se = T)



# WORKING SPACE -----------------------------------------------------------
## Assignment -------------------------------------------------------------
### 1) --------------------------------------------------------------------





### 2) --------------------------------------------------------------------
#### 2.1) -----------------------------------------------------------------





#### 2.2) -----------------------------------------------------------------





### 3) --------------------------------------------------------------------
#### 3.1) -----------------------------------------------------------------




#### 3.2) -----------------------------------------------------------------




### 4) --------------------------------------------------------------------
#### 4.1) -----------------------------------------------------------------




#### 4.2) -----------------------------------------------------------------




### 5) --------------------------------------------------------------------






## Sample assignment ------------------------------------------------------
### 1) --------------------------------------------------------------------
model4 <- lm(sei10 ~ age + educ + prestg10 + class, data = gss)
tab_model(model4, show.std = T, show.ci = F, collapse.se = T)




### 2) --------------------------------------------------------------------
#### 2.1) -----------------------------------------------------------------
frq(gss$variable_here, out = "v")

frq(gss$compuse, out = "v")


#### 2.2) -----------------------------------------------------------------
gss$dummyvar1 <- 
ifelse(gss$orig_var == value, 1, 0,
label = "Dummy variable's variable label")

gss$dummyvar2 <- 
ifelse(gss$orig_var == value, 1, 0,
label = "Dummy variable's variable label")


gss$usecomputer <- 
ifelse(gss$compuse == 1, 1, 0,
label = "Using computer")

gss$nousecomputer <- 
ifelse(gss$compuse == 2, 1, 0,
label = "Not using computer")



### 3) --------------------------------------------------------------------
#### 3.1) -----------------------------------------------------------------
frq(gss$variable_here, out = "v")

frq(gss$satjob, out = "v")



#### 3.2) -----------------------------------------------------------------
gss$dummyvar1 <- 
ifelse(gss$orig_var == value, 1, 0,
label = "Dummy variable's variable label")

gss$dummyvar2 <- 
ifelse(gss$orig_var == value | gss$orig_var == value | gss$orig_var == value, 1, 0,
label = "Dummy variable's variable label")

gss$dummyvar3 <- 
ifelse(gss$orig_var == value, 1, 0,
label = "Dummy variable's variable label")


gss$verysatisfied <- 
ifelse(gss$satjob == 1, 1, 0,
label = "Being very satisfied with work")

gss$moderatelysatisfied <- 
ifelse(gss$satjob == 2, 1, 0,
label = "Being moderately satisfied with work")

gss$dissatisfied <- 
ifelse(gss$satjob == 3 | gss$satjob == 4, 1, 0,
label = "Being dissatisfied with work")



### 4) --------------------------------------------------------------------
#### 4.1) -----------------------------------------------------------------
descr(gss$variable_here, out = "v", show = "short")

descr(gss$conrinc, out = "v", show = "short")


#### 4.2) -----------------------------------------------------------------
gss$dummyvar1 <- 
ifelse(gss$orig_var <= value, 1, 0,
label = "Dummy variable's variable label")

gss$dummyvar2 <- 
ifelse(gss$orig_var >= lowest_value & gss$orig_var <= highest_value, 1, 0,
label = "Dummy variable's variable label")

gss$dummyvar3 <- 
ifelse(gss$orig_var => value, 1, 0,
label = "Dummy variable's variable label")


gss$lowfamincome <- 
ifelse(gss$conrinc <= 30000, 1, 0,
label = "Having low family income")

gss$mediumfamincome <- 
ifelse(gss$conrinc >= 30001 & gss$conrinc <= 70000, 1, 0,
label = "Having medium family income")

gss$highfamincome <- 
ifelse(gss$conrinc >=70001, 1, 0,
label = "Having high family income")

### 5) --------------------------------------------------------------------
model5 <- lm(outcome_here ~ factor1_here + factor2_here + factor3_here + factor4_here + factor5_here + factor6_here + factor7_here + factor8_here + factor9_here + factor10_here, data = gss)
tab_model(model5, show.std = T, show.ci = F, collapse.se = T)

model5 <- lm(sei10 ~ age + educ + prestg10 + class + usecomputer + moderatelysatisfied + dissatisfied + lowfamincome + mediumfamincome, data = gss)
tab_model(model5, show.std = T, show.ci = F, collapse.se = T)

