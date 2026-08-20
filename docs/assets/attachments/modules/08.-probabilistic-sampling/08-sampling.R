### Sampling ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/attachments/data/0-packages-data.R"))



# Descriptive table of family income for ALL GSS respondents --------------
descr(gss$coninc, out = "v", show = "short")


# 40% Non-random sampling -------------------------------------------------
## Data creation for 40% non-random sampling -------------------------------
gssfirst40per <- head(gss, round(0.40 * nrow(gss)))


# Descriptive table of family income for 40% non-random sampling ----------
descr(gssfirst40per$coninc, out = "v", show = "short")


# 30% simple random sampling ------------------------------------------------
## Data creation for 30% simple random sampling ----------------------------
gssrandom30per <- gss[sample(nrow(gss), round(0.30 * nrow(gss))), ]


## Descriptive table of 30% simple random sampling -------------------------
descr(gssrandom30per$coninc, out = "v", show = "short")


# 20% systematic random sampling -------------------------------------------
## Data creation for 20% systematic random sampling ------------------------
gss20persystematic <- gss[seq(4, nrow(gss), 5), ]


# Descriptive table of 20% systematic random sampling ---------------------
descr(gss20persystematic$coninc, out = "v", show = "short")





# WORKING SPACE -----------------------------------------------------------
## Assignment -------------------------------------------------------------
### 1) --------------------------------------------------------------------





### 2) ----------------------------------------------------------------------
#### 2.1.1) Data creation code ----------------------------------------------


#### 2.1.2) Descriptive table code ------------------------------------------



### 3) ----------------------------------------------------------------------
#### 3.1.1) Data creation code ----------------------------------------------


#### 3.1.2) Descriptive table code ------------------------------------------




### 4) ----------------------------------------------------------------------
#### 4.1.1) Data creation code ----------------------------------------------


#### 4.1.2) Descriptive table code ------------------------------------------





## Sample assignment --------------------------------------------------------
### 1) ----------------------------------------------------------------------
descr(gss$sei10, out = "v", show = "short")


### 2) ----------------------------------------------------------------------
# 2.1.1) Data creation code -------------------------------------------------
gssfirst40per <- head(gss, round(0.40 * nrow(gss)))

# 2.1.2) Descriptive table code ---------------------------------------------
descr(gssfirst40per$sei10, out = "v", show = "short")



### 3) ----------------------------------------------------------------------
# 3.1.1) Data creation code -------------------------------------------------
gssrandom30per <- gss[sample(nrow(gss), round(0.30 * nrow(gss))), ]

# 3.1.2) Descriptive table code ---------------------------------------------
descr(gssrandom30per$sei10, out = "v", show = "short")



### 4) ----------------------------------------------------------------------
# 4.1.1) Data creation code -------------------------------------------------
gss20persystematic <- gss[seq(4, nrow(gss), 5), ]

# 4.1.2) Descriptive table code ---------------------------------------------
descr(gss20persystematic$sei10, out = "v", show = "short")



