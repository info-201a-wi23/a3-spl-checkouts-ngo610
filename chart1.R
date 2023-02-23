library(dplyr)
library(tidyverse)
library(readr)
library(ggplot2)
library("lubridate")
library("viridis")

library_df <- read_csv("2017-2023-10-Checkouts-SPL-Data.csv")

leigh_bardugo_df <- library_df %>% 
  filter(Creator == "Leigh Bardugo") %>% 
  filter(!CheckoutYear == 2023)

titles <- leigh_bardugo_df %>%
  select(Title) %>%
  group_by(Title)
titles <- unique(titles)

# Find total checkouts per Grishaverse book over the years 2017-2022
bardugo_checkouts_per_year <- leigh_bardugo_df %>% 
  select(Title, CheckoutYear, Checkouts, Creator) %>% 
  filter(Title %in% c("Shadow and Bone: The Grisha Trilogy, Book 1", "Siege and Storm: The Grisha Trilogy, Book 2", 
                      "Ruin and Rising: The Grisha Trilogy, Book 3",
                      "Six of Crows: Dregs Series, Book 1", "Crooked Kingdom: Dregs Series, Book 2",
                      "King of Scars: King of Scars Series, Book 1", "Rule of Wolves: King of Scars Duology, Book 2")) %>% 
  group_by(Title, CheckoutYear) %>% 
  summarize(total_checkouts_per_year = sum(Checkouts, na.rm = TRUE))

# MOVE THIS?
all_checkouts <- bardugo_checkouts_per_year %>% 
  summarize(total = sum(total_checkouts_per_year))

dregs_checkouts_per_year <- bardugo_checkouts_per_year %>% 
  filter(Title %in% c("Six of Crows: Dregs Series, Book 1", "Crooked Kingdom: Dregs Series, Book 2")) %>% 
  group_by(CheckoutYear) %>% 
  summarize(total = sum(total_checkouts_per_year))

dregs <- "Dregs Series"
dregs_checkouts_per_year$Title <- dregs

grisha_checkouts_per_year <- bardugo_checkouts_per_year %>% 
  filter(Title %in% c("Shadow and Bone: The Grisha Trilogy, Book 1", "Siege and Storm: The Grisha Trilogy, Book 2", 
                      "Ruin and Rising: The Grisha Trilogy, Book 3")) %>% 
  group_by(CheckoutYear) %>% 
  summarize(total = sum(total_checkouts_per_year))

grisha <- "Grisha Trilogy"
grisha_checkouts_per_year$Title <- grisha

king_of_scars_checkouts_per_year <- bardugo_checkouts_per_year %>% 
  filter(Title %in% c("King of Scars: King of Scars Series, Book 1", "Rule of Wolves: King of Scars Duology, Book 2")) %>% 
  group_by(CheckoutYear) %>% 
  summarize(total = sum(total_checkouts_per_year))

king_of_scars <- "King of Scars Duology"
king_of_scars_checkouts_per_year$Title <- king_of_scars

all_series <- rbind(dregs_checkouts_per_year, grisha_checkouts_per_year)

all_series <- rbind(all_series, king_of_scars_checkouts_per_year)


ggplot(data = all_series) +
  geom_line(mapping = aes(x = CheckoutYear, y = total, color = Title, lwd = 2)) +
  scale_color_manual(values = c("#260b2c", "#aa405b", "#fea775")) +
  guides(lwd = FALSE) +
  labs(title = "Total eBook Checkouts for each Grishaverse Series", x = "Year",
       y = "Number of Checkouts", color = "Series Title") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

  

