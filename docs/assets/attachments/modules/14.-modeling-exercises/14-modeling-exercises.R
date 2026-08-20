### Modeling exercises ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/attachments/data/0-packages-data-trashball.R"))


# Logistic regression -----------------------------------------------------
model1 <- glm(success ~ distance + narrow + physicallycoordinated + regularsports, data = trashball, family = binomial(link="logit"))
tab_model(model1, show.std = T, show.ci = F, collapse.se = T)


# WORKING SPACE -----------------------------------------------------------
## Assignment -------------------------------------------------------------
### 1) --------------------------------------------------------------------





## Sample assignment ------------------------------------------------------
### 1) --------------------------------------------------------------------
model1 <- glm(success ~ distance + narrow + sleep + nervous, data = trashball, family = binomial(link="logit"))
tab_model(model1, show.std = T, show.ci = F, collapse.se = T)

