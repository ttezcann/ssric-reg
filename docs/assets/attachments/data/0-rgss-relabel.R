invisible(capture.output(suppressMessages(suppressWarnings({

# Relabel----
## TABLE 1. Basic Demographics — Sociodemographics----

attr(gss$age, "label") <- "Respondents' age"

attr(gss$sex, "label") <- "Respondents' sex"
attr(gss$sex, "labels") <- c("Male" = 1, "Female" = 2)

attr(gss$sexornt, "label") <- "Respondents' sexual orientation"
attr(gss$sexornt, "labels") <- c("Gay, lesbian, or homosexual" = 1, "Bisexual" = 2, "Heterosexual or straight" = 3)

attr(gss$race, "label") <- "Respondents' race"
attr(gss$race, "labels") <- c("White" = 1, "Black" = 2, "Other" = 3)

attr(gss$marital, "label") <- "Respondents' marital status"
attr(gss$marital, "labels") <- c("Married" = 1, "Widowed" = 2, "Divorced" = 3, "Separated" = 4, "Never married" = 5)

attr(gss$childs, "label") <- "Number of children respondents have"

attr(gss$hompop, "label") <- "Number of persons in household"

attr(gss$divorce, "label") <- "Respondents' divorce status"
attr(gss$divorce, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$sibs, "label") <- "Number of brothers and sisters respondents have"

attr(gss$born, "label") <- "Respondents' immigrant status"
attr(gss$born, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$region, "label") <- "Respondents' region of residence"
attr(gss$region, "labels") <- c("New England" = 1, "Middle Atlantic" = 2, "East North Central" = 3,
                                "West North Central" = 4, "South Atlantic" = 5, "East South Central" = 6,
                                "West South Central" = 7, "Mountain" = 8, "Pacific" = 9)

attr(gss$dwelown, "label") <- "Respondents' home ownership status"
attr(gss$dwelown, "labels") <- c("Own or is buying" = 1, "Pays rent" = 2, "Other" = 3)

## TABLE 2. Socioeconomic Status and Political Views----

attr(gss$educ, "label") <- "Respondents' education in years"

attr(gss$degree, "label") <- "Respondents' education degree"
attr(gss$degree, "labels") <- c("Less than high school" = 0, "High school" = 1, "Associate/junior college" = 2,
                                "Bachelor's" = 3, "Graduate" = 4)

attr(gss$coninc, "label") <- "Respondents' family income"

attr(gss$conrinc, "label") <- "Respondents' personal income"

attr(gss$sei10, "label") <- "Respondents' socio-economic index score"

attr(gss$spsei10, "label") <- "Socio-economic index score of the respondents' spouses"

attr(gss$prestg10, "label") <- "Respondents' occupational prestige score"

attr(gss$sppres10, "label") <- "Occupational prestige score of the respondents' spouses"

attr(gss$class, "label") <- "Respondents' subjective class identification"
attr(gss$class, "labels") <- c("Lower class" = 1, "Working class" = 2, "Middle class" = 3,
                                  "Upper class" = 4, "No class" = 5)

attr(gss$partyid, "label") <- "Respondents' political party affiliation"
attr(gss$partyid, "labels") <- c("Strong Democrat" = 0, "Not very strong Democrat" = 1,
                                 "Independent, close to Democrat" = 2, "Independent (neither, no response)" = 3,
                                 "Independent, close to Republican" = 4, "Not very strong Republican" = 5,
                                 "Strong Republican" = 6, "Other party" = 7)

attr(gss$polviews, "label") <- "Respondents' conservatism level"
attr(gss$polviews, "labels") <- c("Extremely liberal" = 1, "Liberal" = 2, "Slightly liberal" = 3,
                                  "Moderate" = 4, "Slightly conservative" = 5, "Conservative" = 6,
                                  "Extremely conservative" = 7)

## TABLE 3. Respondents' Parents and Adolescence Years----

attr(gss$mapres10, "label") <- "Respondents' mothers' occupational prestige score"

attr(gss$papres10, "label") <- "Respondents' fathers' occupational prestige score"

attr(gss$maeduc, "label") <- "Respondents' mothers' education in years"

attr(gss$paeduc, "label") <- "Respondents' fathers' education in years"

attr(gss$masei10, "label") <- "Respondents' mothers' socio-economic index score"

attr(gss$pasei10, "label") <- "Respondents' fathers' socio-economic index score"

attr(gss$granborn, "label") <- "Number of grandparents born outside the United States"
attr(gss$granborn, "labels") <- c("None" = 0, "One" = 1, "Two" = 2, "Three" = 3, "Four" = 4)

attr(gss$maborn, "label") <- "Respondents' mothers' immigration status"
attr(gss$maborn, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$paborn, "label") <- "Respondents' fathers' immigration status"
attr(gss$paborn, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$res16, "label") <- "Population density of residence during adolescence years"
attr(gss$res16, "labels") <- c("Country, nonfarm" = 1, "Farm" = 2, "Town less than 50K" = 3,
                               "50K to 250K" = 4, "Big city, suburb" = 5, "City greater than 250K" = 6)

attr(gss$reg16, "label") <- "Region of residence during adolescence years"
attr(gss$reg16, "labels") <- c("Foreign country" = 0, "New England" = 1, "Middle Atlantic" = 2,
                               "East North Central" = 3, "West North Central" = 4, "South Atlantic" = 5,
                               "East South Central" = 6, "West South Central" = 7, "Mountain" = 8, "Pacific" = 9)

attr(gss$family16, "label") <- "Parental cohabitation status during adolescence years"
attr(gss$family16, "labels") <- c("Other" = 0, "Mother and father" = 1, "Father and stepmother" = 2,
                                  "Mother and stepfather" = 3, "Father" = 4, "Mother" = 5,
                                  "Male relative" = 6, "Female relative" = 7, "Male and female relatives" = 8)

attr(gss$incom16, "label") <- "Self-assessment of family wealth relative to societal average during adolescence years"
attr(gss$incom16, "labels") <- c("Far below average" = 1, "Below average" = 2, "Average" = 3,
                                 "Above average" = 4, "Far above average" = 5)

## TABLE 4. Quality of Life----

attr(gss$goodlife, "label") <- "Level of optimism about economic opportunity"
attr(gss$goodlife, "labels") <- c("Strongly agree" = 1, "Agree" = 2, "Neither agree nor disagree" = 3,
                                  "Disagree" = 4, "Strongly disagree" = 5)

attr(gss$finrela, "label") <- "Perceived family income relative to average"
attr(gss$finrela, "labels") <- c("Far below average" = 1, "Below average" = 2, "Average" = 3,
                                 "Above average" = 4, "Far above average" = 5)

attr(gss$finalter, "label") <- "Perceived change in financial situation"
attr(gss$finalter, "labels") <- c("Better" = 1, "Worse" = 2, "Stayed same" = 3)

attr(gss$parsol, "label") <- "Level of higher living standard compared to parents"
attr(gss$parsol, "labels") <- c("Much better" = 1, "Somewhat better" = 2, "About the same" = 3,
                                "Somewhat worse" = 4, "Much worse" = 5)

attr(gss$health, "label") <- "Perceived personal health quality"
attr(gss$health, "labels") <- c("Excellent" = 1, "Very Good" = 2, "Good" = 3,
                                "Fair" = 4, "Poor" = 5)

## TABLE 5. Social Life----

attr(gss$socrel, "label") <- "Frequency of social evening with relatives"
attr(gss$socrel, "labels") <- c("Almost daily" = 1, "Once or twice a week" = 2, "Several times a month" = 3,
                                "About once a month" = 4, "Several times a year" = 5, "About once a year" = 6,
                                "Never" = 7)

attr(gss$socommun, "label") <- "Frequency of social evening with neighbors"
attr(gss$socommun, "labels") <- c("Almost daily" = 1, "Once or twice a week" = 2, "Several times a month" = 3,
                                  "About once a month" = 4, "Several times a year" = 5, "About once a year" = 6,
                                  "Never" = 7)

attr(gss$socfrend, "label") <- "Frequency of social evening with friends"
attr(gss$socfrend, "labels") <- c("Almost daily" = 1, "Once or twice a week" = 2, "Several times a month" = 3,
                                  "About once a month" = 4, "Several times a year" = 5, "About once a year" = 6,
                                  "Never" = 7)

attr(gss$socbar, "label") <- "Frequency of going to a bar"
attr(gss$socbar, "labels") <- c("Almost daily" = 1, "Once or twice a week" = 2, "Several times a month" = 3,
                                "About once a month" = 4, "Several times a year" = 5, "About once a year" = 6,
                                "Never" = 7)


## TABLE 6. Work----

attr(gss$wrkstat, "label") <- "Labor force status"
attr(gss$wrkstat, "labels") <- c("Working full time" = 1, "Working part time" = 2,
                                 "With a job, but not at work because of temporary illness, vacation, strike" = 3,
                                 "Unemployed, laid off, looking for work" = 4, "Retired" = 5,
                                 "In school" = 6, "Keeping house" = 7, "Other" = 8)

attr(gss$wrkslf, "label") <- "Respondents' employment status"
attr(gss$wrkslf, "labels") <- c("Self employed" = 1, "Working for someone else" = 2)

attr(gss$weekswrk, "label") <- "Weeks respondents worked last year"

attr(gss$hrs1, "label") <- "Number of hours respondents worked last week"

attr(gss$hrs2, "label") <- "Number of hours respondents usually work"

attr(gss$earnrs, "label") <- "Number of family members who earned money last year"

## TABLE 7. Racial Inequality and Discrimination----

attr(gss$racdif1, "label") <- "Attribution of racial inequality to discrimination"
attr(gss$racdif1, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$racdif2, "label") <- "Attribution of racial inequality to in-born ability"
attr(gss$racdif2, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$racdif3, "label") <- "Attribution of racial inequality to lack of education"
attr(gss$racdif3, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$racdif4, "label") <- "Attribution of racial inequality to lack of motivation"
attr(gss$racdif4, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$disrspct, "label") <- "Frequency of being treated with less courtesy or respect"
attr(gss$disrspct, "labels") <- c("Almost every day" = 1, "At least once a week" = 2, "A few times a month" = 3,
                                  "A few times a year" = 4, "Less than once a year" = 5, "Never" = 6)

attr(gss$poorserv, "label") <- "Frequency of receiving poorer service at restaurants or stores"
attr(gss$poorserv, "labels") <- c("Almost every day" = 1, "At least once a week" = 2, "A few times a month" = 3,
                                  "A few times a year" = 4, "Less than once a year" = 5, "Never" = 6)

attr(gss$notsmart, "label") <- "Frequency of being treated as if not smart"
attr(gss$notsmart, "labels") <- c("Almost every day" = 1, "At least once a week" = 2, "A few times a month" = 3,
                                  "A few times a year" = 4, "Less than once a year" = 5, "Never" = 6)

attr(gss$afraidof, "label") <- "Frequency of people acting afraid of the respondents"
attr(gss$afraidof, "labels") <- c("Almost every day" = 1, "At least once a week" = 2, "A few times a month" = 3,
                                  "A few times a year" = 4, "Less than once a year" = 5, "Never" = 6)

attr(gss$threaten, "label") <- "Frequency of being threatened or harassed"
attr(gss$threaten, "labels") <- c("Almost every day" = 1, "At least once a week" = 2, "A few times a month" = 3,
                                  "A few times a year" = 4, "Less than once a year" = 5, "Never" = 6)

## TABLE 8. Parenting Style----

attr(gss$obey, "label") <- "Importance level of teaching children to obey"
attr(gss$obey, "labels") <- c("Most important" = 1, "Second important" = 2, "Third important" = 3,
                              "Fourth important" = 4, "Least important" = 5)

attr(gss$popular, "label") <- "Importance level of teaching children to be well-liked or popular"
attr(gss$popular, "labels") <- c("Most important" = 1, "Second important" = 2, "Third important" = 3,
                                 "Fourth important" = 4, "Least important" = 5)

attr(gss$thnkself, "label") <- "Importance level of teaching children to think for themselves"
attr(gss$thnkself, "labels") <- c("Most important" = 1, "Second important" = 2, "Third important" = 3,
                                  "Fourth important" = 4, "Least important" = 5)

attr(gss$workhard, "label") <- "Importance level of teaching children to work hard"
attr(gss$workhard, "labels") <- c("Most important" = 1, "Second important" = 2, "Third important" = 3,
                                  "Fourth important" = 4, "Least important" = 5)

attr(gss$helpoth, "label") <- "Importance level of teaching children to help others"
attr(gss$helpoth, "labels") <- c("Most important" = 1, "Second important" = 2, "Third important" = 3,
                                 "Fourth important" = 4, "Least important" = 5)

## TABLE 9. Government Spending----

attr(gss$natspac, "label") <- "Support level for government spending on space exploration"
attr(gss$natspac, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natenvir, "label") <- "Support level for government spending on environment"
attr(gss$natenvir, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natheal, "label") <- "Support level for government spending on the nation's health"
attr(gss$natheal, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natcity, "label") <- "Support level for government spending for solving problems of big cities"
attr(gss$natcity, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natcrime, "label") <- "Support level for government spending for halting the rising crime rate"
attr(gss$natcrime, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natdrug, "label") <- "Support level for government spending for dealing with drug addiction"
attr(gss$natdrug, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$nateduc, "label") <- "Support level for government spending for improving the nation's education system"
attr(gss$nateduc, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natrace, "label") <- "Support level for government spending for improving the conditions of Black people"
attr(gss$natrace, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natarms, "label") <- "Support level for government spending for military, armaments, and defense"
attr(gss$natarms, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$nataid, "label") <- "Support level for government spending for foreign aid"
attr(gss$nataid, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natfare, "label") <- "Support level for government spending for welfare"
attr(gss$natfare, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natroad, "label") <- "Support level for government spending for highways and bridges"
attr(gss$natroad, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natsoc, "label") <- "Support level for government spending for social security"
attr(gss$natsoc, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natchld, "label") <- "Support level for government spending for assistance for childcare"
attr(gss$natchld, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natsci, "label") <- "Support level for government spending for supporting scientific research"
attr(gss$natsci, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

attr(gss$natenrgy, "label") <- "Support level for government spending for developing alternative energy sources"
attr(gss$natenrgy, "labels") <- c("Too little" = 1, "About right" = 2, "Too much" = 3)

## TABLE 10. Civil Liberties — Freedom of Speech----

attr(gss$spkath, "label") <- "Support for allowing an anti-religionist person to make a speech"
attr(gss$spkath, "labels") <- c("Allowed" = 1, "Not allowed" = 2)

attr(gss$colath, "label") <- "Support for allowing an anti-religionist person to teach in a college"
attr(gss$colath, "labels") <- c("Allowed" = 1, "Not allowed" = 2)

attr(gss$libath, "label") <- "Support for keeping a book by an anti-religionist person in the public library"
attr(gss$libath, "labels") <- c("Allowed" = 1, "Not allowed" = 2)

attr(gss$spkrac, "label") <- "Support for allowing a racist person to make a speech"
attr(gss$spkrac, "labels") <- c("Allowed" = 1, "Not allowed" = 2)

attr(gss$colrac, "label") <- "Support for allowing a racist person to teach in a college"
attr(gss$colrac, "labels") <- c("Allowed" = 1, "Not allowed" = 2)

attr(gss$librac, "label") <- "Support for keeping a book by a racist person in the public library"
attr(gss$librac, "labels") <- c("Allowed" = 1, "Not allowed" = 2)

attr(gss$spkcom, "label") <- "Support for allowing a communist person to make a speech"
attr(gss$spkcom, "labels") <- c("Allowed" = 1, "Not allowed" = 2)

attr(gss$colcom, "label") <- "Support for allowing a communist person to teach in a college"
attr(gss$colcom, "labels") <- c("Allowed" = 1, "Not allowed" = 2)

attr(gss$libcom, "label") <- "Support for keeping a book by a communist person in the public library"
attr(gss$libcom, "labels") <- c("Allowed" = 1, "Not allowed" = 2)

attr(gss$spkmslm, "label") <- "Support for allowing a Muslim clergyman preaching hatred of the United States to make a speech"
attr(gss$spkmslm, "labels") <- c("Allowed" = 1, "Not allowed" = 2)

attr(gss$colmslm, "label") <- "Support for allowing a Muslim clergyman preaching hatred of the United States to teach in a college"
attr(gss$colmslm, "labels") <- c("Allowed" = 1, "Not allowed" = 2)

attr(gss$libmslm, "label") <- "Support for keeping a book by a Muslim clergyman preaching hatred of the United States in the public library"
attr(gss$libmslm, "labels") <- c("Allowed" = 1, "Not allowed" = 2)

## TABLE 11. Abortion and Birth Control----

attr(gss$abdefect, "label") <- "Support for abortion in cases of potential birth defects"
attr(gss$abdefect, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$abnomore, "label") <- "Support for abortion for family planning reasons"
attr(gss$abnomore, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$abhlth, "label") <- "Support for abortion for maternal health reasons"
attr(gss$abhlth, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$abpoor, "label") <- "Support for abortion for economic reasons"
attr(gss$abpoor, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$abrape, "label") <- "Support for abortion in cases of rape"
attr(gss$abrape, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$absingle, "label") <- "Support for abortion in cases of non-marital pregnancy"
attr(gss$absingle, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$abany, "label") <- "Support level for unrestricted abortion rights"
attr(gss$abany, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$pillok, "label") <- "Support level for providing birth control to teens (14-16) without parent approval"
attr(gss$pillok, "labels") <- c("Strongly agree" = 1, "Agree" = 2, "Disagree" = 3, "Strongly disagree" = 4)

## TABLE 12. Affirmative Action----

attr(gss$affrmact, "label") <- "Support level for preferential hiring and promotion policies for Black people"
attr(gss$affrmact, "labels") <- c("Strongly favors" = 1, "Not strongly favors" = 2,
                                  "Not strongly opposes" = 3, "Strongly opposes" = 4)

attr(gss$fejobaff, "label") <- "Support level for preferential hiring and promotion policies for women"
attr(gss$fejobaff, "labels") <- c("Strongly favors" = 1, "Not strongly favors" = 2,
                                  "Not strongly opposes" = 3, "Strongly opposes" = 4)

attr(gss$discaffm, "label") <- "Concern level for gender-based employment discrimination against men"
attr(gss$discaffm, "labels") <- c("Very likely" = 1, "Somewhat likely" = 2,
                                  "Somewhat unlikely" = 3, "Very unlikely" = 4)

attr(gss$discaffw, "label") <- "Concern level for gender-based employment discrimination against women"
attr(gss$discaffw, "labels") <- c("Very likely" = 1, "Somewhat likely" = 2,
                                  "Somewhat unlikely" = 3, "Very unlikely" = 4)

attr(gss$discaff, "label") <- "Concern level for reverse discrimination in employment"
attr(gss$discaff, "labels") <- c("Very likely" = 1, "Somewhat likely" = 2,
                                 "Somewhat unlikely" = 3, "Very unlikely" = 4)

attr(gss$fehire, "label") <- "Support level for special efforts to hire and promote qualified women"
attr(gss$fehire, "labels") <- c("Strongly agree" = 1, "Agree" = 2, "Neither agree nor disagree" = 3,
                                "Disagree" = 4, "Strongly disagree" = 5)

## TABLE 13. Religion----

attr(gss$god, "label") <- "Confidence in the existence of God"
attr(gss$god, "labels") <- c("Don't believe" = 1, "Don't know, no way to find out" = 2,
                             "Higher power" = 3, "Believe sometimes" = 4,
                             "Believe with doubts" = 5, "No doubts about it" = 6)

attr(gss$attend, "label") <- "Frequency of attending religious services (institutional religiosity)"
attr(gss$attend, "labels") <- c("Never" = 0, "Less than once a year" = 1, "About once or twice a year" = 2,
                                "Several times a year" = 3, "About once a month" = 4, "2-3 times a month" = 5,
                                "Nearly every week" = 6, "Every week" = 7, "Several times a week" = 8)

attr(gss$pray, "label") <- "Frequency of praying (individual religiosity)"
attr(gss$pray, "labels") <- c("Several times a day" = 1, "Once a day" = 2, "Several times a week" = 3,
                              "Once a week" = 4, "Less than once a week" = 5, "Never" = 6)

attr(gss$relpersn, "label") <- "Subjective religiosity"
attr(gss$relpersn, "labels") <- c("Very religious" = 1, "Moderately religious" = 2,
                                  "Slightly religious" = 3, "Not religious at all" = 4)

attr(gss$sprtprsn, "label") <- "Level of spirituality"
attr(gss$sprtprsn, "labels") <- c("Very spiritual" = 1, "Moderately spiritual" = 2,
                                  "Slightly spiritual" = 3, "Not spiritual at all" = 4)

attr(gss$postlife, "label") <- "Belief in life after death"
attr(gss$postlife, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$prayer, "label") <- "Agreement with the prohibition of mandated Bible readings in schools"
attr(gss$prayer, "labels") <- c("Approve" = 1, "Disapprove" = 2)

attr(gss$bible, "label") <- "Feelings about the Bible"
attr(gss$bible, "labels") <- c("Word of God" = 1, "Inspired word" = 2, "Ancient book" = 3, "Other" = 4)

## TABLE 14. Intermarriage Attitudes----

attr(gss$marblk, "label") <- "Favoring intermarriage with Black people"
attr(gss$marblk, "labels") <- c("Strongly favor" = 1, "Favor" = 2, "Neither favor nor oppose" = 3,
                                "Oppose" = 4, "Strongly oppose" = 5)

attr(gss$marasian, "label") <- "Favoring intermarriage with Asian people"
attr(gss$marasian, "labels") <- c("Strongly favor" = 1, "Favor" = 2, "Neither favor nor oppose" = 3,
                                  "Oppose" = 4, "Strongly oppose" = 5)

attr(gss$marhisp, "label") <- "Favoring intermarriage with Hispanic people"
attr(gss$marhisp, "labels") <- c("Strongly favor" = 1, "Favor" = 2, "Neither favor nor oppose" = 3,
                                 "Oppose" = 4, "Strongly oppose" = 5)

attr(gss$marwht, "label") <- "Favoring intermarriage with White people"
attr(gss$marwht, "labels") <- c("Strongly favor" = 1, "Favor" = 2, "Neither favor nor oppose" = 3,
                                "Oppose" = 4, "Strongly oppose" = 5)

## TABLE 15. Immigration Related Questions----

attr(gss$immcrime, "label") <- "Perception that immigrants increase crime rates"
attr(gss$immcrime, "labels") <- c("Agree strongly" = 1, "Agree" = 2, "Neither agree nor disagree" = 3,
                                  "Disagree" = 4, "Disagree strongly" = 5)

attr(gss$immjobs, "label") <- "Perception that immigrants take jobs away from natives"
attr(gss$immjobs, "labels") <- c("Agree strongly" = 1, "Agree" = 2, "Neither agree nor disagree" = 3,
                                 "Disagree" = 4, "Disagree strongly" = 5)

attr(gss$letin1a, "label") <- "Perception that the number of immigrants should be decreased"
attr(gss$letin1a, "labels") <- c("Increased a lot" = 1, "Increased a little" = 2, "Remain the same as it is" = 3,
                                 "Reduced a little" = 4, "Reduced a lot" = 5)

## TABLE 16. Happiness and Satisfaction----

attr(gss$happy, "label") <- "Happiness level"
attr(gss$happy, "labels") <- c("Very happy" = 1, "Pretty happy" = 2, "Not too happy" = 3)

attr(gss$hapmar, "label") <- "Marriage happiness level"
attr(gss$hapmar, "labels") <- c("Very happy" = 1, "Pretty happy" = 2, "Not too happy" = 3)

attr(gss$hapcohab, "label") <- "Relationship happiness level"
attr(gss$hapcohab, "labels") <- c("Very happy" = 1, "Pretty happy" = 2, "Not too happy" = 3)

attr(gss$life, "label") <- "Level of finding life exciting"
attr(gss$life, "labels") <- c("Exciting" = 1, "Routine" = 2, "Dull" = 3)

attr(gss$satjob, "label") <- "Level of work satisfaction"
attr(gss$satjob, "labels") <- c("Very satisfied" = 1, "Moderately satisfied" = 2,
                                "A little dissatisfied" = 3, "Very dissatisfied" = 4)

attr(gss$satfin, "label") <- "Level of financial satisfaction"
attr(gss$satfin, "labels") <- c("Pretty well satisfied" = 1, "More or less satisfied" = 2,
                                "Not satisfied at all" = 3)

## TABLE 17. Technology and Media Use----

attr(gss$news, "label") <- "Level of reading newspaper"
attr(gss$news, "labels") <- c("Everyday" = 1, "A few times a week" = 2, "Once a week" = 3,
                              "Less than once a week" = 4, "Never" = 5)

attr(gss$tvhours, "label") <- "Television screen time in hours"

attr(gss$compuse, "label") <- "Use of computer"
attr(gss$compuse, "labels") <- c("Yes" = 1, "No" = 2)

## TABLE 18. Confidence in Institutions----

attr(gss$confinan, "label") <- "Confidence level in banks and financial institutions"
attr(gss$confinan, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

attr(gss$conbus, "label") <- "Confidence level in major companies"
attr(gss$conbus, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

attr(gss$conclerg, "label") <- "Confidence level in organized religion"
attr(gss$conclerg, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

attr(gss$coneduc, "label") <- "Confidence level in education"
attr(gss$coneduc, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

attr(gss$confed, "label") <- "Confidence level in executive branch of the federal government"
attr(gss$confed, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

attr(gss$conlabor, "label") <- "Confidence level in organized labor"
attr(gss$conlabor, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

attr(gss$conpress, "label") <- "Confidence level in press"
attr(gss$conpress, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

attr(gss$conmedic, "label") <- "Confidence level in medicine"
attr(gss$conmedic, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

attr(gss$contv, "label") <- "Confidence level in television"
attr(gss$contv, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

attr(gss$conjudge, "label") <- "Confidence level in Supreme Court"
attr(gss$conjudge, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

attr(gss$consci, "label") <- "Confidence level in scientific community"
attr(gss$consci, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

attr(gss$conlegis, "label") <- "Confidence level in congress"
attr(gss$conlegis, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

attr(gss$conarmy, "label") <- "Confidence level in military"
attr(gss$conarmy, "labels") <- c("A great deal" = 1, "Only some" = 2, "Hardly any" = 3)

## TABLE 19. Family and Gender Roles----

attr(gss$meovrwrk, "label") <- "Level of agreement with the negative impact of men's work commitment on family life"
attr(gss$meovrwrk, "labels") <- c("Strongly agree" = 1, "Agree" = 2, "Neither agree nor disagree" = 3,
                                  "Disagree" = 4, "Strongly disagree" = 5)

attr(gss$fechld, "label") <- "Level of agreement with the capability of working mothers to establish a warm and secure relationship with their children"
attr(gss$fechld, "labels") <- c("Strongly agree" = 1, "Agree" = 2, "Neither agree nor disagree" = 3,
                                "Disagree" = 4, "Strongly disagree" = 5)

attr(gss$fefam, "label") <- "Level of agreement with the belief that traditional gender roles are best for everyone involved"
attr(gss$fefam, "labels") <- c("Strongly agree" = 1, "Agree" = 2, "Neither agree nor disagree" = 3,
                               "Disagree" = 4, "Strongly disagree" = 5)

## TABLE 20. Police Abuse----

attr(gss$polhitok, "label") <- "Support of police violence for some reason"
attr(gss$polhitok, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$polabuse, "label") <- "Support of police violence if citizen said vulgar or obscene things"
attr(gss$polabuse, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$polmurdr, "label") <- "Support of police violence if citizen questioned as murder suspect"
attr(gss$polmurdr, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$polescap, "label") <- "Support of police violence if citizen attempting to escape custody"
attr(gss$polescap, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$polattak, "label") <- "Support of police violence if citizen attacking policeman with fists"
attr(gss$polattak, "labels") <- c("Yes" = 1, "No" = 2)

## TABLE 21. Miscellaneous

attr(gss$fear, "label") <- "Sense of neighborhood security"
attr(gss$fear, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$cappun, "label") <- "Views on death penalty"
attr(gss$cappun, "labels") <- c("Favor" = 1, "Oppose" = 2)

attr(gss$gunlaw, "label") <- "Views on gun control measures"
attr(gss$gunlaw, "labels") <- c("Favor" = 1, "Oppose" = 2)

attr(gss$owngun, "label") <- "Ownership of gun"
attr(gss$owngun, "labels") <- c("Yes" = 1, "No" = 2, "Refused" = 3)

attr(gss$courts, "label") <- "Views on criminal justice adequacy"
attr(gss$courts, "labels") <- c("Too harshly" = 1, "Not harshly enough" = 2, "About right" = 3)

attr(gss$homosex, "label") <- "Support level for sexual relations between two adults of the same sex"
attr(gss$homosex, "labels") <- c("Always wrong" = 1, "Almost always wrong" = 2,
                                 "Wrong only sometimes" = 3, "Not wrong at all" = 4)

attr(gss$grass, "label") <- "Views on legality of marijuana"
attr(gss$grass, "labels") <- c("Should be legal" = 1, "Should not be legal" = 2)

attr(gss$sexeduc, "label") <- "Views on sex education in public schools"
attr(gss$sexeduc, "labels") <- c("Favor" = 1, "Oppose" = 2)

attr(gss$raclive, "label") <- "Presence of racial diversity in the neighborhood"
attr(gss$raclive, "labels") <- c("Yes" = 1, "No" = 2)

attr(gss$spanking, "label") <- "Favoring spanking children to discipline"
attr(gss$spanking, "labels") <- c("Strongly agree" = 1, "Agree" = 2, "Disagree" = 3, "Strongly disagree" = 4)
}))))