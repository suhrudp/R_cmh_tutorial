# COCHRAN-MANTEL-HAENSZEL TEST

## IMPORT DATA

```{r}
library(readxl)
df <- read_excel(file.choose())
attach(df)
View(df)
```

## LOAD LIBRARIES

```{r}
library(tidyverse)
library(ggthemes)
library(DescTools)
library(vcd)
```

## CREATE AN ARRAY

```{r}
niacin <- array(c(2, 11, 46, 41,
                  4, 12, 67, 60,
                  1, 4, 86, 76,
                  1, 6, 37, 32,
                  2, 1, 92, 93),
           dim = c(2, 2, 5),
           dimnames = list(
               Treat = c("Niacin", "Placebo"),
               Vascularization = c("Revascularization", "No revascularization"),
                 Study = c("FATS", "AFREGS", "ARBITER 2", "HATS", "CLAS 1")))
niacin
```

## ASSUMPTIONS

Homogeneity of odds ratios: In this test, we get an estimate of the common odds ratio - a way of summarizing how big the effect is when pooled across different repeats of the study. We assume that the odds ratio is the same in all the different levels. We can test this assumption using the Breslow-Day test. If it is significant, the CMH test may not be appropriate.

```{r}
BreslowDayTest(niacin)
```

## CMH TEST

```{r}
mantelhaen.test(niacin, exact=T, alternative="two.sided")
```

## VISUALIZE RESULTS

```{r}
ggplot(df, aes(x=study, y=percrevasc, fill=treat)) + geom_bar(stat="identity", position=position_dodge()) + theme_bw() + scale_fill_wsj()
```

## 
