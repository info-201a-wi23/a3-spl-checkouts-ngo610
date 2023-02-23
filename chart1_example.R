library(dplyr)
library(tidyverse)
library(readr)
library(ggplot2)
library("lubridate")

library_df <- read_csv("~/info 201/a3-spl-checkouts-ngo610/2017-2023-10-Checkouts-SPL-Data.csv/2017-2023-10-Checkouts-SPL-Data.csv")

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
  # group_by(Title, CheckoutMonth, CheckoutYear) %>%
  # summarize(total_checkout_month = sum(Checkouts))


ggplot() +
  geom_line(aes(x=x_values, y = y_values))

ggplot(data = bardugo_checkouts_per_year) +
  geom_line(mapping = aes(x = CheckoutYear, y = total_checkouts_per_year, color = Title)) +
  scale_color_brewer(palette = "Set3") + 
  labs(title = "Total Checkouts for Leigh Bardugo's Grishaverse novels from 2017-2022", x = "Year", y = "Number of Checkouts", color = "Book Title")

