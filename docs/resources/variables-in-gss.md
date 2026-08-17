---
title: "Variables in GSS"
icon: lucide/book-marked
tags:
  - Resources
knotis_content:
  heading_numbering: false
  heading_guides: false
---

# Guideline
- This page lists the variable names, variable labels, variable types, question wording and response categories for each question from the GSS dataset.

## Table A. Guideline of variable types

| Variable type | It means |
|---|---|
| Binary (categorical) | Binary variable: it has two responses |
| Nominal (categorical) | Nominal variable: it has more than two responses |
| Ordinal (categorical) | Ordinal variable: same as nominal variable, but there is a logical order among categories |
| Ordinal ✅ (categorical) | ✅ next to an ordinal variable indicates that these ordinal variables could be treated as continuous |
| Continuous | Continuous variable: numeric variables; real numbers |
| COMPUTE-A, COMPUTE-B, ... | Indicates that it can be computed together with other variables marked with the same COMPUTE letter under the same table. Note that the computed variable will be continuous. |
| RECODE | Indicates that they should be recoded (the direction of the responses should be reversed) before computation or treating them as continuous. After recoding, the new (recoded) variables should be used in analysis. |


# Table 1. Basic demographics

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `age` | Respondents' age | Continuous | What is your age?<br><br>*(Min: 18, Max: 89)*  |
| `sex` | Respondents' sex | Binary | What's your sex?<br><br>*(1: Male; 2: Female)* |
| `sexornt` | Respondents' sexual orientation | Nominal | Which of the following best describes you?<br><br>*(1: Gay, lesbian, or homosexual; 2: Bisexual; 3: Heterosexual or straight)* |
| `race` | Respondents' race | Nominal | What's your race?<br><br>*(1: White; 2: Black; 3: Other)* |
| `marital` | Respondents' marital status | Nominal | Are you currently — married, widowed, divorced, separated, or have you never been married?<br><br>*(1: Married; 2: Widowed; 3: Divorced; 4: Separated; 5: Never married)* |
| `childs` | Number of children respondents have | Continuous | How many children do you have? <br><br>*(Min: 0, Max: 8)*  |
| `hompop` | Number of persons in household | Continuous | How many people do live in your household?<br><br>*(Min: 1, Max: 14)* |
| `divorce` | Respondents' divorce status | Binary | Have you ever been divorced or legally separated?<br><br>*(1: Yes; 2: No)* |
| `sibs` | Number of brothers and sisters respondents have | Continuous | How many brothers and sisters do you have?<br><br>*(Min: 0, Max: 6)*  |
| `born` | Respondents' immigrant status | Binary | Were you born in this country?<br><br>*(1: Yes; 2: No)* |
| `dwelown` | Respondents' home ownership status | Nominal | (Do you/Does your family) own your (home/apartment), pay rent, or what?<br><br>*(1: Own or is buying; 2: Pays rent; 3: Other)* |

# Table 2. Socioeconomic status and political views

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `educ` | Respondents' education in years | Continuous | What is the highest year of school you completed?<br><br>*(Min: 0, Max: 20)*  |
| `degree` | Respondents' education degree | Ordinal | Do you have less than high school, high school, associate/junior college, bachelor's, or graduate degree?<br><br>*(0: Less than high school; 1: High school; 2: Associate/junior college; 3: Bachelor's; 4: Graduate)* |
| `coninc` | Respondents' family income | Continuous | What is your family income in dollars?<br><br>*(Min: $281.5, Max: $139,024.4)*  |
| `conrinc` | Respondents' personal income | Continuous | What is your income in dollars? <br><br>*(Min: $281.5; Max, $123,761.9)*  |
| `sei10` | Respondents' socio-economic index score | Continuous | Socio-economic index score of the respondent (calculated) <br><br>*(Min: 9, Max: 92.8)* |
| `spsei10` | Socio-economic index score of the respondents' spouses | Continuous | Socio-economic index score of the respondent's spouse (calculated) <br><br>*(Min: 10.6, Max: 93.7)* |
| `prestg10` | Respondents' occupational prestige score | Continuous | Respondent's occupational prestige score (calculated) <br><br>*(Min: 16, Max: 80)* |
| `sppres10` | Occupational prestige score of the respondents' spouses | Continuous | Respondent's spouse's occupational prestige score (calculated) <br><br>*(Min: 16, Max: 80)* |
| `class` | Respondents' subjective class identification | Ordinal ✅ | If you were asked to use one of four names for your social class, which would you say you belong in?<br><br>*(1: Lower class; 2: Working class; 3: Middle class; 4: Upper class)* |
| `partyid` | Respondents' political party affiliation | Nominal | Generally speaking, do you usually think of yourself as a Republican, Democrat, Independent, or what?<br><br>*(0: Strong Democrat; 1: Not very strong Democrat; 2: Independent, close to Democrat; 3: Independent (neither, no response); 4: Independent, close to Republican; 5: Not very strong Republican; 6: Strong Republican; 7: Other party)* |
| `polviews` | Respondents' conservatism level | Ordinal ✅ | Do you think of yourself as liberal or conservative?<br><br>*(1: Extremely liberal; 2: Liberal; 3: Slightly liberal; 4: Moderate; 5: Slightly conservative; 6: Conservative; 7: Extremely conservative)* |

# Table 3. Respondents' parents and adolescence years

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `mapres10` | Respondents' mothers' occupational prestige score | Continuous | Respondent's mother's prestige score (calculated)<br><br>*(Min: 16, Max: 80)* |
| `papres10` | Respondents' fathers' occupational prestige score | Continuous | Respondent's father's prestige score (calculated)<br><br>*(Min: 16, Max: 80)* |
| `maeduc` | Respondents' mothers' education in years | Continuous | What is the highest year of school your mother completed?<br><br>*(Min: 0, Max: 20)* |
| `paeduc` | Respondents' fathers' education in years | Continuous | What is the highest year of school your father completed?<br><br>*(Min: 0, Max: 20)* |
| `masei10` | Respondents' mothers' socio-economic index score | Continuous | Respondent's mother's socio-economic index score (calculated)<br><br>*(Min: 9, Max: 92.8)* |
| `pasei10` | Respondents' fathers' socio-economic index score | Continuous | Respondent's father's socio-economic index score (calculated)<br>*(Min: 9, Max: 93.7)* |
| `granborn` | Number of grandparents born outside the United States | Ordinal | Were all of your four grandparents born in this country? How many were born outside the United States?<br>*(0: None; 1: One; 2: Two; 3: Three; 4: Four)* |
| `maborn` | Respondents' mothers' immigration status | Binary | Was your mother born in this country?<br>*(1: Yes; 2: No)* |
| `paborn` | Respondents' fathers' immigration status | Binary | Was your father born in this country?<br>*(1: Yes; 2: No)* |
| `res16` | Population density of residence during adolescence years | Ordinal ✅ | Which of the categories on this card comes closest to the type of place you were living in when you were 16 years old?<br><br>*(1: Country, nonfarm; 2: Farm; 3: Town less than 50K; 4: 50K to 250K; 5: Big city, suburb; 6: City greater than 250K)* |
| `reg16` | Region of residence during adolescence years | Nominal | In what state or foreign country were you living when you were 16 years old?<br><br>*(0: Foreign country; 1: New England; 2: Middle Atlantic; 3: East North Central; 4: West North Central; 5: South Atlantic; 6: East South Central; 7: West South Central; 8: Mountain; 9: Pacific)* |
| `family16` | Parental cohabitation status during adolescence years | Nominal | Were you living with both your own mother and father around the time you were 16?<br><br>*(0: Other; 1: Mother and father; 2: Father and stepmother; 3: Mother and stepfather; 4: Father; 5: Mother; 6: Male relative; 7: Female relative; 8: Male and female relatives)* |
| `incom16` | Self-assessment of family wealth relative to societal average during adolescence years | Ordinal ✅ | Thinking about the time when you were 16 years old, compared with American families in general then, would you say your family income was — far below average, below average, average, above average, or far above average?<br><br>*(1: Far below average; 2: Below average; 3: Average; 4: Above average; 5: Far above average)* |

# Table 4. Quality of life

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `goodlife` | Level of optimism about economic opportunity | Ordinal ✅ RECODE | The way things are in America, people like me and my family have a good chance of improving our standard of living — do you agree or disagree?<br><br>*(1: Strongly agree; 2: Agree; 3: Neither agree nor disagree; 4: Disagree; 5: Strongly disagree)* |
| `finrela` | Perceived family income relative to average | Ordinal ✅ | Compared with American families in general, would you say your family income is far below average, below average, average, above average, or far above average?<br><br>*(1: Far below average; 2: Below average; 3: Average; 4: Above average; 5: Far above average)* |
| `finalter` | Perceived change in financial situation | Nominal | During the last few years, has your financial situation been getting better, worse, or has it stayed the same?<br><br>*(1: Better; 2: Worse; 3: Stayed same)* |
| `parsol` | Level of higher living standard compared to parents | Ordinal ✅ RECODE | Compared to your parents when they were the age you are now, do you think your own standard of living now is much better, somewhat better, about the same, somewhat worse, or much worse than theirs was?<br><br>*(1: Much better; 2: Somewhat better; 3: About the same; 4: Somewhat worse; 5: Much worse)* |
| `health` | Perceived personal health quality | Ordinal ✅ RECODE | Would you say that in general your health is Excellent, Very good, Good, Fair, or Poor?<br> <br>*(1: Excellent; 2: Very Good; 3: Good; 4: Fair; 5: Poor)* |

# Table 5. Social life

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `socrel` | Frequency of social evening with relatives | Ordinal ✅ RECODE | How often do you spend a social evening with relatives?<br><br>*(1: Almost daily; 2: Once or twice a week; 3: Several times a month; 4: About once a month; 5: Several times a year; 6: About once a year; 7: Never)* |
| `socommun` | Frequency of social evening with neighbors | Ordinal ✅ RECODE | How often do you spend a social evening with neighbors?<br><br>*(1: Almost daily; 2: Once or twice a week; 3: Several times a month; 4: About once a month; 5: Several times a year; 6: About once a year; 7: Never)* |
| `socfrend` | Frequency of social evening with friends | Ordinal ✅ RECODE | How often do you spend a social evening with friends?<br><br>*(1: Almost daily; 2: Once or twice a week; 3: Several times a month; 4: About once a month; 5: Several times a year; 6: About once a year; 7: Never)* |
| `socbar` | Frequency of going to a bar | Ordinal ✅ RECODE | How often do you go to a bar?<br><br>*(1: Almost daily; 2: Once or twice a week; 3: Several times a month; 4: About once a month; 5: Several times a year; 6: About once a year; 7: Never)* |

# Table 6. Work

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `wrkstat` | Labor force status | Nominal | Last week were you working full time, part time, going to school, keeping house, or what?<br><br>*(1: Working full time; 2: Working part time; 3: With a job, but not at work because of temporary illness, vacation, strike; 4: Unemployed, laid off, looking for work; 5: Retired; 6: In school; 7: Keeping house; 8: Other)* |
| `wrkslf` | Respondents' employment status | Binary | Are you self employed or do you work for someone else?<br><br>*(1: Self employed; 2: Working for someone else)* |
| `weekswrk` | Weeks respondents worked last year | Continuous | In the previous year how many weeks did you work either full-time or part-time not counting work around the house — including paid vacations and sick leave? <br><br>*(Min: 0, Max: 52)* |
| `hrs1` | Number of hours respondents worked last week | Continuous | How many hours did you work last week, at all jobs? <br><br>*(Min: 0, Max: 89)* |
| `hrs2` | Number of hours respondents usually work | Continuous | How many hours a week do you usually work, at all jobs? <br><br>*(Min: 1, Max: 70)* |
| `earnrs` | Number of family members who earned money last year | Continuous | How many persons in the family, including yourself, earned any money last year from any job or employment? <br><br>*(Min: 0, Max: 3)* |

# Table 7. Racial inequality and discrimination

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `racdif1` | Attribution of racial inequality to discrimination | Binary | On the average Black people have worse jobs, income, and housing than white people. Do you think these differences are mainly due to discrimination?<br><br>*(1: Yes; 2: No)* |
| `racdif2` | Attribution of racial inequality to in-born ability | Binary | On the average Black people have worse jobs, income, and housing than white people. Do you think these differences are mainly due to less in-born ability to learn?<br><br>*(1: Yes; 2: No)* |
| `racdif3` | Attribution of racial inequality to lack of education | Binary | On the average Black people have worse jobs, income, and housing than white people. Do you think these differences are because they don't have the chance for education that it takes to rise out of poverty?<br><br>*(1: Yes; 2: No)* |
| `racdif4` | Attribution of racial inequality to lack of motivation | Binary | On the average Black people have worse jobs, income, and housing than white people. Do you think these differences are because they don't have the motivation or will power to pull themselves up out of poverty?<br><br>*(1: Yes; 2: No)* |
| `disrspct` | Frequency of being treated with less courtesy or respect | Ordinal ✅ RECODE, COMPUTE-A | In your day-to-day life how often have any of the following things happened to you? You are treated with less courtesy or respect than other people.<br><br>*(1: Almost every day; 2: At least once a week; 3: A few times a month; 4: A few times a year; 5: Less than once a year; 6: Never)* |
| `poorserv` | Frequency of receiving poorer service at restaurants or stores | Ordinal ✅ RECODE, COMPUTE-A | In your day-to-day life how often have any of the following things happened to you? You receive poorer service than other people at restaurants or stores.<br><br>*(1: Almost every day; 2: At least once a week; 3: A few times a month; 4: A few times a year; 5: Less than once a year; 6: Never)* |
| `notsmart` | Frequency of being treated as if not smart | Ordinal ✅ RECODE, COMPUTE-A | In your day-to-day life how often have any of the following things happened to you? People act as if they think you are not smart.<br><br>*(1: Almost every day; 2: At least once a week; 3: A few times a month; 4: A few times a year; 5: Less than once a year; 6: Never)* |
| `afraidof` | Frequency of people acting afraid of the respondents | Ordinal ✅ RECODE, COMPUTE-A | In your day-to-day life how often have any of the following things happened to you? People act as if they are afraid of you.<br><br>*(1: Almost every day; 2: At least once a week; 3: A few times a month; 4: A few times a year; 5: Less than once a year; 6: Never)* |
| `threaten` | Frequency of being threatened or harassed | Ordinal ✅ RECODE COMPUTE-A | In your day-to-day life how often have any of the following things happened to you? You are threatened or harassed.<br><br>*(1: Almost every day; 2: At least once a week; 3: A few times a month; 4: A few times a year; 5: Less than once a year; 6: Never)* |

# Table 8. Parenting style

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `obey` | Importance level of teaching children to obey | Ordinal ✅ RECODE COMPUTE-A | If you had to choose, which thing on this list would you pick as the most important for a child to learn to prepare him or her for life? To obey.<br><br>*(1: Most important; 2: Second important; 3: Third important; 4: Fourth important; 5: Least important)* |
| `popular` | Importance level of teaching children to be well-liked or popular | Ordinal ✅ RECODE, COMPUTE-A | If you had to choose, which thing on this list would you pick as the most important for a child to learn to prepare him or her for life? To be well-liked or popular.<br><br>*(1: Most important; 2: Second important; 3: Third important; 4: Fourth important; 5: Least important)* |
| `thnkself` | Importance level of teaching children to think for themselves | Ordinal ✅ RECODE, COMPUTE-A | If you had to choose, which thing on this list would you pick as the most important for a child to learn to prepare him or her for life? To think for himself or herself.<br><br>*(1: Most important; 2: Second important; 3: Third important; 4: Fourth important; 5: Least important)* |
| `workhard` | Importance level of teaching children to work hard | Ordinal ✅ RECODE, COMPUTE-A | If you had to choose, which thing on this list would you pick as the most important for a child to learn to prepare him or her for life? To work hard.<br><br>*(1: Most important; 2: Second important; 3: Third important; 4: Fourth important; 5: Least important)* |
| `helpoth` | Importance level of teaching children to help others | Ordinal ✅ RECODE, COMPUTE-A | If you had to choose, which thing on this list would you pick as the most important for a child to learn to prepare him or her for life? To help others when they need help.<br><br>*(1: Most important; 2: Second important; 3: Third important; 4: Fourth important; 5: Least important)* |

# Table 9. Government spending

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `natspac` | Support level for government spending on space exploration | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on the space exploration program?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natenvir` | Support level for government spending on environment | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on improving and protecting the environment?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natheal` | Support level for government spending on the nation's health | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on improving and protecting the nation's health?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natcity` | Support level for government spending for solving problems of big cities | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on solving problems of big cities?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natcrime` | Support level for government spending for halting the rising crime rate | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on halting the rising crime rate?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natdrug` | Support level for government spending for dealing with drug addiction | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on dealing with drug addiction?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `nateduc` | Support level for government spending for improving the nation's education system | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on improving the nation's education system?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natrace` | Support level for government spending for improving the conditions of Black people | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on improving the conditions of Blacks?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natarms` | Support level for government spending for military, armaments, and defense | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on military, armaments, and defense?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `nataid` | Support level for government spending for foreign aid | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on foreign aid?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natfare` | Support level for government spending for welfare | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on welfare?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natroad` | Support level for government spending for highways and bridges | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on highways and bridges?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natsoc` | Support level for government spending for social security | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on social security?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natchld` | Support level for government spending for assistance for childcare | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on assistance for childcare?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natsci` | Support level for government spending for supporting scientific research | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on supporting scientific research?<br><br>*(1: Too little; 2: About right; 3: Too much)* |
| `natenrgy` | Support level for government spending for developing alternative energy sources | Ordinal, COMPUTE-A | Are we spending too much money, too little money, or about the right amount on developing alternative energy sources?<br><br>*(1: Too little; 2: About right; 3: Too much)* |

# Table 10. Civil liberties — Freedom of speech

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `spkath` | Support for allowing an anti-religionist person to make a speech | Binary, RECODE, COMPUTE-A | Consider a person who is against all churches and religion. If such a person wanted to make a speech in your community against churches and religion, should he be allowed to speak, or not?<br><br>*(1: Allowed; 2: Not allowed)* |
| `colath` | Support for allowing an anti-religionist person to teach in a college | Binary, RECODE, COMPUTE-A | Consider a person who is against all churches and religion. Should such a person be allowed to teach in a college or university, or not?<br><br>*(1: Allowed; 2: Not allowed)* |
| `libath` | Support for keeping a book by an anti-religionist person in the public library | Binary, RECODE, COMPUTE-A | If some people in your community suggested that a book he wrote against churches and religion should be taken out of your public library, would you favor removing this book, or not?<br><br>*(1: Allowed; 2: Not allowed)* |
| `spkrac` | Support for allowing a racist person to make a speech | Binary, RECODE, COMPUTE-A | Consider a person who believes that Blacks are genetically inferior. If such a person wanted to make a speech in your community claiming that Blacks are inferior, should he be allowed to speak, or not?<br><br>*(1: Allowed; 2: Not allowed)* |
| `colrac` | Support for allowing a racist person to teach in a college | Binary, RECODE, COMPUTE-A | Consider a person who believes that Blacks are genetically inferior. Should such a person be allowed to teach in a college or university, or not?<br><br>*(1: Allowed; 2: Not allowed)* |
| `librac` | Support for keeping a book by a racist person in the public library | Binary, RECODE, COMPUTE-A | Consider a person who believes that Blacks are genetically inferior. If some people in your community suggested that a book he wrote which said Blacks are inferior should be taken out of your public library, would you favor removing this book, or not?<br><br>*(1: Allowed; 2: Not allowed)* |
| `spkcom` | Support for allowing a communist person to make a speech | Binary, RECODE, COMPUTE-A | Consider a person who admits he is a Communist. Suppose this admitted Communist wanted to make a speech in your community. Should he be allowed to speak, or not?<br><br>*(1: Allowed; 2: Not allowed)* |
| `colcom` | Support for allowing a communist person to teach in a college | Binary, RECODE, COMPUTE-A | Consider a person who admits he is a Communist. Suppose he is teaching in a college. Should he be fired, or not?<br><br>*(1: Allowed; 2: Not allowed)* |
| `libcom` | Support for keeping a book by a communist person in the public library | Binary, RECODE, COMPUTE-A | Consider a person who admits he is a Communist. Suppose he wrote a book which is in your public library. Somebody in your community suggests that the book should be removed from the library. Would you favor removing it, or not?<br><br>*(1: Allowed; 2: Not allowed)* |
| `spkmslm` | Support for allowing a Muslim clergyman preaching hatred of the United States to make a speech | Binary, RECODE, COMPUTE-A | Consider a Muslim clergyman who preaches hatred of the United States. If such a person wanted to make a speech in your community preaching hatred of the United States, should he be allowed to speak, or not?<br><br>*(1: Allowed; 2: Not allowed)* |
| `colmslm` | Support for allowing a Muslim clergyman preaching hatred of the United States to teach in a college | Binary, RECODE, COMPUTE-A | Consider a Muslim clergyman who preaches hatred of the United States. Should such a person be allowed to teach in a college or university, or not?<br><br>*(1: Allowed; 2: Not allowed)* |
| `libmslm` | Support for keeping a book by a Muslim clergyman preaching hatred of the United States in the public library | Binary, RECODE, COMPUTE-A | Consider a Muslim clergyman who preaches hatred of the United States. If some people in your community suggested that a book he wrote which preaches hatred of the United States should be taken out of your public library, would you favor removing this book, or not?<br><br>*(1: Allowed; 2: Not allowed)* |

# Table 11. Abortion and birth control

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `abdefect` | Support for abortion in cases of potential birth defects | Binary, RECODE, COMPUTE-A | Should abortion be legal if there is a strong chance of serious defect in the baby?<br><br>*(1: Yes; 2: No)* |
| `abnomore` | Support for abortion for family planning reasons | Binary, RECODE, COMPUTE-A | Should abortion be legal if she is married and does not want any more children?<br><br>*(1: Yes; 2: No)* |
| `abhlth` | Support for abortion for maternal health reasons | Binary, RECODE, COMPUTE-A | Should abortion be legal if the woman's own health is seriously endangered by the pregnancy?<br><br>*(1: Yes; 2: No)* |
| `abpoor` | Support for abortion for economic reasons | Binary, RECODE, COMPUTE-A | Should abortion be legal if the family has a very low income and cannot afford any more children?<br><br>*(1: Yes; 2: No)* |
| `abrape` | Support for abortion in cases of rape | Binary, RECODE, COMPUTE-A | Should abortion be legal if she became pregnant as a result of rape?<br><br>*(1: Yes; 2: No)* |
| `absingle` | Support for abortion in cases of non-marital pregnancy | Binary, RECODE, COMPUTE-A | Should abortion be legal if she is not married and does not want to marry the man?<br><br>*(1: Yes; 2: No)* |
| `abany` | Support level for unrestricted abortion rights | Binary, RECODE, COMPUTE-A | Should abortion be legal if she wants it for any reason?<br><br>*(1: Yes; 2: No)* |
| `pillok` | Support level for providing birth control to teens (14–16) without parent approval | Ordinal, RECODE | Do you strongly agree, agree, disagree, or strongly disagree that methods of birth control should be available to teenagers between the ages of 14 and 16 if their parents do not approve?<br><br>*(1: Strongly agree; 2: Agree; 3: Disagree; 4: Strongly disagree)* |

# Table 12. Affirmative action

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `affrmact` | Support level for preferential hiring and promotion policies for Black people | Ordinal, RECODE, COMPUTE-A | Some people say that because of past discrimination, blacks should be given preference in hiring and promotion. Others say that such preference is wrong because it discriminates against whites. What about your opinion — are you for or against preferential hiring and promotion of blacks?<br><br>*(1: Strongly favors; 2: Not strongly favors; 3: Not strongly opposes; 4: Strongly opposes)* |
| `fejobaff` | Support level for preferential hiring and promotion policies for women | Ordinal, RECODE, COMPUTE-A | Some people say that because of past discrimination, women should be given preference in hiring and promotion. Others say that such preference is wrong because it discriminates against men. What about your opinion — are you for or against preferential hiring and promotion of women?<br><br>*(1: Strongly favors; 2: Not strongly favors; 3: Not strongly opposes; 4: Strongly opposes)* |
| `discaffm` | Concern level for gender-based employment discrimination against men | Ordinal, RECODE, COMPUTE-B | What do you think the chances are these days that a man won't get a job or promotion while an equally or less qualified woman gets one instead?<br><br>*(1: Very likely; 2: Somewhat likely; 3: Somewhat unlikely; 4: Very unlikely)* |
| `discaffw` | Concern level for gender-based employment discrimination against women | Ordinal, RECODE, COMPUTE-B | What do you think the chances are these days that a woman won't get a job or promotion while an equally or less qualified man gets one instead?<br><br>*(1: Very likely; 2: Somewhat likely; 3: Somewhat unlikely; 4: Very unlikely)* |
| `discaff` | Concern level for reverse discrimination in employment | Ordinal, RECODE, COMPUTE-B | What do you think the chances are these days that a white person won't get a job or promotion while an equally or less qualified black person gets one instead?<br><br>*(1: Very likely; 2: Somewhat likely; 3: Somewhat unlikely; 4: Very unlikely)* |
| `fehire` | Support level for special efforts to hire and promote qualified women | Ordinal, RECODE | Do you agree that because of past discrimination, employers should make special efforts to hire and promote qualified women?<br><br>*(1: Strongly agree; 2: Agree; 3: Neither agree nor disagree; 4: Disagree; 5: Strongly disagree)* |

# Table 13. Religion

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `god` | Confidence in the existence of God | Ordinal ✅ | Respondent's confidence in the existence of God<br><br>*(1: Don't believe; 2: Don't know, no way to find out; 3: Higher power; 4: Believe sometimes; 5: Believe with doubts; 6: No doubts about it)* |
| `attend` | Frequency of attending religious services (institutional religiosity) | Ordinal ✅ | How often do you attend religious services?<br><br>*(0: Never; 1: Less than once a year; 2: About once or twice a year; 3: Several times a year; 4: About once a month; 5: 2–3 times a month; 6: Nearly every week; 7: Every week; 8: Several times a week)* |
| `pray` | Frequency of praying (individual religiosity) | Ordinal ✅ RECODE | How often do you pray?<br><br>*(1: Several times a day; 2: Once a day; 3: Several times a week; 4: Once a week; 5: Less than once a week; 6: Never)* |
| `relpersn` | Subjective religiosity | Ordinal ✅ RECODE | To what extent do you consider yourself a religious person?<br><br>*(1: Very religious; 2: Moderately religious; 3: Slightly religious; 4: Not religious at all)* |
| `sprtprsn` | Level of spirituality | Ordinal ✅ RECODE | To what extent do you consider yourself a spiritual person?<br><br>*(1: Very spiritual; 2: Moderately spiritual; 3: Slightly spiritual; 4: Not spiritual at all)* |
| `postlife` | Belief in life after death | Binary | Do you believe there is a life after death?<br><br>*(1: Yes; 2: No)* |
| `prayer` | Agreement with the prohibition of mandated Bible readings in schools | Binary | The United States Supreme Court has ruled that no state or local government may require the reading of the Lord's Prayer or Bible verses in public schools. What are your views on this — do you approve or disapprove of the court ruling?<br><br>*(1: Approve; 2: Disapprove)* |
| `bible` | Feelings about the Bible | Nominal | Which of these statements comes closest to describing your feelings about the Bible?<br><br>*(1: Word of God; 2: Inspired word; 3: Ancient book; 4: Other)* |

# Table 14. Intermarriage attitudes

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `marblk` | Favoring intermarriage with Black people | Ordinal ✅ RECODE | Would you be very in favor of having a close relative or family member marry a Black person?<br><br>*(1: Strongly favor; 2: Favor; 3: Neither favor nor oppose; 4: Oppose; 5: Strongly oppose)* |
| `marasian` | Favoring intermarriage with Asian people | Ordinal ✅ RECODE | Would you be very in favor of having a close relative or family member marry an Asian person?<br><br>*(1: Strongly favor; 2: Favor; 3: Neither favor nor oppose; 4: Oppose; 5: Strongly oppose)* |
| `marhisp` | Favoring intermarriage with Hispanic people | Ordinal ✅ RECODE | Would you be very in favor of having a close relative or family member marry a Hispanic person?<br><br>*(1: Strongly favor; 2: Favor; 3: Neither favor nor oppose; 4: Oppose; 5: Strongly oppose)* |
| `marwht` | Favoring intermarriage with White people | Ordinal ✅ RECODE | Would you be very in favor of having a close relative or family member marry a White person?<br><br>*(1: Strongly favor; 2: Favor; 3: Neither favor nor oppose; 4: Oppose; 5: Strongly oppose)* |

# Table 15. Immigration related questions

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `immcrime` | Perception that immigrants increase crime rates | Ordinal ✅ RECODE | How much do you agree or disagree that immigrants increase crime rates?<br><br>*(1: Agree strongly; 2: Agree; 3: Neither agree nor disagree; 4: Disagree; 5: Disagree strongly)* |
| `immjobs` | Perception that immigrants take jobs away from natives | Ordinal ✅ RECODE | How much do you agree or disagree that immigrants take jobs away from people who were born in America?<br><br>*(1: Agree strongly; 2: Agree; 3: Neither agree nor disagree; 4: Disagree; 5: Disagree strongly)* |
| `letin1a` | Perception that the number of immigrants should be decreased | Ordinal ✅ | Do you think the number of immigrants to America nowadays should be increased or decreased?<br><br>*(1: Increased a lot; 2: Increased a little; 3: Remain the same as it is; 4: Reduced a little; 5: Reduced a lot)* |

# Table 16. Happiness and satisfaction

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `happy` | Happiness level | Ordinal, RECODE | Would you say that you are very happy, pretty happy, or not too happy?<br><br>*(1: Very happy; 2: Pretty happy; 3: Not too happy)* |
| `hapmar` | Marriage happiness level | Ordinal, RECODE | Would you say that your marriage is very happy, pretty happy, or not too happy?<br><br>*(1: Very happy; 2: Pretty happy; 3: Not too happy)* |
| `hapcohab` | Relationship happiness level | Ordinal, RECODE | Would you say that your relationship with your partner is very happy, pretty happy, or not too happy?<br><br>*(1: Very happy; 2: Pretty happy; 3: Not too happy)* |
| `life` | Level of finding life exciting | Ordinal, RECODE | In general, do you find life exciting, pretty routine, or dull?<br><br>*(1: Exciting; 2: Routine; 3: Dull)* |
| `satjob` | Level of work satisfaction | Ordinal, RECODE | On the whole, how satisfied are you with the work you do?<br><br>*(1: Very satisfied; 2: Moderately satisfied; 3: A little dissatisfied; 4: Very dissatisfied)* |
| `satfin` | Level of financial satisfaction | Ordinal, RECODE | So far as you and your family are concerned, how satisfied are you with your present financial situation?<br><br>*(1: Pretty well satisfied; 2: More or less satisfied; 3: Not satisfied at all)* |

# Table 17. Technology and media use

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `news` | Level of reading newspaper | Ordinal ✅ RECODE | How often do you read the newspaper?<br><br>*(1: Everyday; 2: A few times a week; 3: Once a week; 4: Less than once a week; 5: Never)* |
| `tvhours` | Television screen time in hours | Continuous | On the average day, how many hours do you personally watch television? <br><br>*(Min: 0, Max: 24)* |
| `compuse` | Use of computer | Binary | Do you personally ever use a computer at home, at work, or at some other location?<br>*(1: Yes; 2: No)* |

# Table 18. Confidence in institutions

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `confinan` | Confidence level in banks and financial institutions | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in banks and financial institutions?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |
| `conbus` | Confidence level in major companies | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in major companies?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |
| `conclerg` | Confidence level in organized religion | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in organized religion?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |
| `coneduc` | Confidence level in education | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in education?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |
| `confed` | Confidence level in executive branch of the federal government | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in executive branch of the federal government?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |
| `conlabor` | Confidence level in organized labor | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in organized labor?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |
| `conpress` | Confidence level in press | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in press?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |
| `conmedic` | Confidence level in medicine | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in medicine?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |
| `contv` | Confidence level in television | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in television?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |
| `conjudge` | Confidence level in Supreme Court | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in Supreme Court?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |
| `consci` | Confidence level in scientific community | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in scientific community?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |
| `conlegis` | Confidence level in congress | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in Congress?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |
| `conarmy` | Confidence level in military | Ordinal, RECODE, COMPUTE-A | Would you say you have confidence in military?<br><br>*(1: A great deal; 2: Only some; 3: Hardly any)* |

# Table 19. Family and gender roles

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `meovrwrk` | Level of agreement with the negative impact of men's work commitment on family life | Ordinal, RECODE, COMPUTE-A | Do you agree or disagree?: Family life often suffers because men concentrate too much on their work.<br><br>*(1: Strongly agree; 2: Agree; 3: Neither agree nor disagree; 4: Disagree; 5: Strongly disagree)* |
| `fechld` | Level of agreement with the capability of working mothers to establish a warm and secure relationship with their children | Ordinal, RECODE, COMPUTE-A | Do you agree or disagree?: A working mother can establish just as warm and secure a relationship with her children as a mother who does not work.<br><br>*(1: Strongly agree; 2: Agree; 3: Neither agree nor disagree; 4: Disagree; 5: Strongly disagree)* |
| `fefam` | Level of agreement with the belief that traditional gender roles are best for everyone involved | Ordinal, RECODE, COMPUTE-A | Do you agree or disagree?: It is much better for everyone involved if the man is the achiever outside the home and the woman takes care of the home and family.<br><br>*(1: Strongly agree; 2: Agree; 3: Neither agree nor disagree; 4: Disagree; 5: Strongly disagree)* |

# Table 20. Police abuse

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `polhitok` | Support of police violence for some reason | Binary, RECODE, COMPUTE-A | Are there any situations you can imagine in which you would approve of a policeman striking an adult male citizen?<br><br>*(1: Yes; 2: No)* |
| `polabuse` | Support of police violence if citizen said vulgar or obscene things | Binary, RECODE, COMPUTE-A | If they had said vulgar and obscene things to the policeman, would you approve of a policeman striking an adult male citizen?<br><br>*(1: Yes; 2: No)* |
| `polmurdr` | Support of police violence if citizen questioned as murder suspect | Binary, RECODE, COMPUTE-A | If they were being questioned as a suspect in a murder case, would you approve of a policeman striking an adult male citizen?<br><br>*(1: Yes; 2: No)* |
| `polescap` | Support of police violence if citizen attempting to escape custody | Binary, RECODE, COMPUTE-A | If they were attempting to escape from custody, would you approve of a policeman striking an adult male citizen?<br><br>*(1: Yes; 2: No)* |
| `polattak` | Support of police violence if citizen attacking policeman with fists | Binary, RECODE, COMPUTE-A | If they were attacking the policeman with his fists, would you approve of a policeman striking an adult male citizen?<br><br>*(1: Yes; 2: No)* |

# Table 21. Miscellaneous

| Variable name | Variable label | Variable type | Question wording and response categories |
|---|---|---|---|
| `fear` | Sense of neighborhood security | Binary | Is there any area right around here — that is, within a mile — where you would be afraid to walk alone at night?<br><br>*(1: Yes; 2: No)* |
| `cappun` | Views on death penalty | Binary | Do you favor or oppose the death penalty for persons convicted of murder?<br><br>*(1: Favor; 2: Oppose)* |
| `gunlaw` | Views on gun control measures | Binary | Would you favor or oppose a law which would require a person to obtain a police permit before he or she could buy a gun?<br><br>*(1: Favor; 2: Oppose)* |
| `owngun` | Ownership of gun | Nominal | Do you happen to have any guns or revolvers?<br><br>*(1: Yes; 2: No; 3: Refused)* |
| `courts` | Views on criminal justice adequacy | Nominal | In general, do you think the courts in this area deal too harshly or not harshly enough with criminals?<br><br>*(1: Too harshly; 2: Not harshly enough; 3: About right)* |
| `homosex` | Support level for sexual relations between two adults of the same sex | Ordinal ✅ | What about sexual relations between two adults of the same sex — do you think it is always wrong, almost always wrong, wrong only sometimes, or not wrong at all?<br><br>*(1: Always wrong; 2: Almost always wrong; 3: Wrong only sometimes; 4: Not wrong at all)* |
| `grass` | Views on legality of marijuana | Binary | Do you think the use of marijuana should be made legal or not?<br><br>*(1: Should be legal; 2: Should not be legal)* |
| `sexeduc` | Views on sex education in public schools | Binary | Would you be for or against sex education in the public schools?<br><br>*(1: Favor; 2: Oppose)* |
| `raclive` | Presence of racial diversity in the neighborhood | Binary | Are there any (whites for Black respondents, Blacks for non-Black respondents) living in this neighborhood now?<br><br>*(1: Yes; 2: No)* |
| `spanking` | Favoring spanking children to discipline | Ordinal ✅ RECODE | Do you strongly agree, agree, disagree, or strongly disagree that it is sometimes necessary to discipline a child with a good, hard spanking?<br><br>*(1: Strongly agree; 2: Agree; 3: Disagree; 4: Strongly disagree)* |
