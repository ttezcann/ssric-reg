# Load TRASHBALL data----
temp <- tempfile(fileext = ".dta")
download.file("https://github.com/ttezcann/ssric-reg/raw/refs/heads/main/docs/assets/attachments/data/trashball.dta", temp, mode = "wb")
trashball <- haven::read_dta(temp)


# Install and load packages----
while (dev.cur() > 1) dev.off()
packages <- c("haven", "corrplot", "patchwork", "Hmisc",
"parameters", "performance", "psych", 
"see", "sjlabelled", "sjmisc", 
"sjPlot", "ggpubr", "tidyverse", "gt")
for (pkg in packages) {if (!requireNamespace(pkg, quietly = TRUE)) {
message("Installing package: ", pkg)
install.packages(pkg, dependencies = c("Depends", "Imports"))} else {
message("Package already installed: ", pkg)}
(library(pkg, character.only = TRUE))}


# Load helpers ------------------------------------------------------------
invisible(capture.output(suppressMessages(suppressWarnings({
set_course_editor_prefs <- TRUE
if (set_course_editor_prefs &&
    requireNamespace("rstudioapi", quietly = TRUE) &&
    rstudioapi::isAvailable()) {
  try(rstudioapi::writeRStudioPreference("reindent_on_paste", FALSE), silent = TRUE)
}
source(url("https://raw.githubusercontent.com/ttezcann/ssric-reg/refs/heads/main/docs/assets/attachments/data/0-rhelpers.R"))
}))))
