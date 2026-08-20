### Linear regression basics ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/attachments/data/0-packages-data.R"))


# (Model 1) Linear regression with 1 factor -------------------------------
model1 <- lm(conrinc ~ res16, data = gss)
tab_model(model1, show.std = T, show.ci = F, collapse.se = T)


# (Model 2) Linear regression with 2 factors -------------------------------
model2 <- lm(conrinc ~ res16 + age, data = gss)
tab_model(model2, show.std = T, show.ci = F, collapse.se = T)


# (Model 3) Linear regression with 3 factors -------------------------------
model3 <- lm(conrinc ~ res16 + age + prestg10, data = gss)
tab_model(model3, show.std = T, show.ci = F, collapse.se = T)


# (Model 4) Linear regression with 4 factors -------------------------------
model4 <- lm(conrinc ~ res16 + age + prestg10 + educ, data = gss)
tab_model(model4, show.std = T, show.ci = F, collapse.se = T)



# WORKING SPACE -----------------------------------------------------------
## Assignment -------------------------------------------------------------
### 1) --------------------------------------------------------------------






### 2) --------------------------------------------------------------------






### 3) ---------------------------------------------------------------------






### 4) ---------------------------------------------------------------------







## Sample assignment ------------------------------------------------------
### 1) --------------------------------------------------------------------
model1 <- lm(outcome_here ~ factor1_here, data = gss)
tab_model(model1, show.std = T, show.ci = F, collapse.se = T)

model1 <- lm(sei10 ~ age, data = gss)
tab_model(model1, show.std = T, show.ci = F, collapse.se = T)



### 2) --------------------------------------------------------------------
model2 <- lm(outcome_here ~ factor1_here + factor2_here, data = gss)
tab_model(model2, show.std = T, show.ci = F, collapse.se = T)

model2 <- lm(sei10 ~ age + educ, data = gss)
tab_model(model2, show.std = T, show.ci = F, collapse.se = T)



### 3) ---------------------------------------------------------------------
model3 <- lm(outcome_here ~ factor1_here + factor2_here + factor3_here, data = gss)
tab_model(model3, show.std = T, show.ci = F, collapse.se = T)

model3 <- lm(sei10 ~ age + educ + prestg10, data = gss)
tab_model(model3, show.std = T, show.ci = F, collapse.se = T)



### 4) ---------------------------------------------------------------------
model4 <- lm(outcome_here ~ factor1_here + factor2_here + factor3_here + factor4_here, data = gss)
tab_model(model4, show.std = T, show.ci = F, collapse.se = T)

model4 <- lm(sei10 ~ age + educ + prestg10 + class, data = gss)
tab_model(model4, show.std = T, show.ci = F, collapse.se = T)


