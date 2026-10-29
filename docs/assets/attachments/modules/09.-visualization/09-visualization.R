### Visualization ###

# Refresh data and packages -----------------------------------------------
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/attachments/data/0-packages-data.R"))



# Stacked bar graph for multiple variables ---------------------------
graph <- gss |> 
select(conbus, coneduc, confed, conmedic, conarmy, conjudge) |> 
plot_stackfrq(sort.frq = "first.asc",  geom.colors = "Blues", 
show.total = FALSE, title = "Confidence in major US institutions") 
graph + theme(
axis.text.x = element_text(size=11), 
axis.text.y = element_text(size=11), 
plot.title = element_text(size=12), 
legend.text = element_text(size=11))


# Grouped bar graph ---------------------------------------------
graph <- plot_xtab(
gss$health, gss$conmedic, show.n = FALSE, margin = "row",
geom.colors = "Dark2",
show.total = FALSE, title = "Confidence level in medicine by perceived personal health quality")
graph + theme(
axis.text.x = element_text(size = 11),
axis.text.y = element_text(size = 11),
plot.title = element_text(size = 12),
legend.text = element_text(size = 11))


# WORKING SPACE -----------------------------------------------------------
## Assignment -------------------------------------------------------------
### 1) --------------------------------------------------------------------







### 2) ----------------------------------------------------------------------







## Sample assignment --------------------------------------------------------
### 1) ----------------------------------------------------------------------
graph <- gss |> 
select(variable1_here, variable2_here, variable3_here) |> 
plot_stackfrq(sort.frq = "first.asc",  geom.colors = "Blues", 
show.total = FALSE, title = "title_here") 
graph + theme(
axis.text.x = element_text(size=11), 
axis.text.y = element_text(size=11), 
plot.title = element_text(size=12), 
legend.text = element_text(size=11))


graph <- gss |> 
select(natsci, nateduc, natspac) |> 
plot_stackfrq(sort.frq = "first.asc",  geom.colors = "Blues", 
show.total = FALSE, title = "Attitudes on government expenditure for science") 
graph + theme(
axis.text.x = element_text(size=10), 
axis.text.y = element_text(size=10), 
plot.title = element_text(size=12), 
legend.text = element_text(size=10))


### 2) ----------------------------------------------------------------------
graph <- plot_xtab(
gss$factor_here, gss$outcome_here, show.n = FALSE, margin = "row",
geom.colors = "Dark2",
show.total = FALSE, title = "title_here")
graph + theme(
axis.text.x = element_text(size = 11),
axis.text.y = element_text(size = 11),
plot.title = element_text(size = 12),
legend.text = element_text(size = 11))

graph <- plot_xtab(
gss$degree, gss$nateduc, show.n = FALSE, margin = "row",
geom.colors = "Dark2",
show.total = FALSE, title = "Support level for government spending for improving the nation's education system by respondents' education degree")
graph + theme(
axis.text.x = element_text(size = 11),
axis.text.y = element_text(size = 11),
plot.title = element_text(size = 13),
legend.text = element_text(size = 12))



