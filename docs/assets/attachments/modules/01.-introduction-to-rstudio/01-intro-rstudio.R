### Introduction to RStudio ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/attachments/data/0-packages-data.R"))


# you can take notes on this script file wherever you put a hashtag (#) first.


# WORKING SPACE -----------------------------------------------------------
## Assignment --------------------------------------------------------------
### Frequency table ---------------------------------------------------------
frq(gss$marital, out = "v")



## Sample assignment ---------------------------------------------------------
### Frequency table -----------------------------------------------------------
frq(gss$degree, out = "v")

# The code above generates a frequency table of degree variable.” 
