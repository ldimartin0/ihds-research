library(tidyverse)
library(quantreg)
library(rio)
library(janitor)
library(glue)
library(DataExplorer)
library(modelsummary)

d <- import("data/cleanR_indiv_data.csv")

d <- d %>% 
	mutate(
		survey = case_when(
			SURVEY == "IHDS1 1" ~ 0L,
			SURVEY == "IHDS2 2" ~ 1L
		),
		literacy = case_when(
			ED2 == "No 0" ~ 0L,
			ED2 == "Yes 1" ~ 1L
		),
		benefits = as.integer(floor(INCBENEFITS)),
		urban = case_when(
			URBAN == "rural 0" ~ 0L,
			URBAN == "urban 1" ~ 1L
		),
		schooled = case_when(
			ED4 == "No 0" ~ 0L,
			ED4 == "Yes 1" ~ 1L
		)
	) %>% 
	drop_na(lwshourly) %>% 
	select(lwshourly, female, survey, literacy, benefits, urban, schooled, district)

district_quantiles <- quantile(d$district, c(.2, .4, .6, .8))

quantiles <- c(.2, .4, .6, .8)
fits <- vector("list", length = length(quantiles))

for (i in seq_along(quantiles)) {
	fits[[i]] <- rq(lwshourly ~ female + survey + literacy + urban + schooled + factor(district), tau = quantiles[i], data = d, method = "fn")
	print(glue("Model {i} fitted"))
}

options(modelsummary_get = "easystats")

modelsummary(
	fits,
	coef_omit = "district", 
	title = "Quantile Regression Results",
	notes = list("Model includes district fixed effects."),
	stars = TRUE)

methods <- c("bn", "fn", "pfn", "sfn", "pfnb")

