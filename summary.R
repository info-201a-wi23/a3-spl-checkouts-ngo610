library(dplyr)
library(tidyverse)
library(readr)
library(ggplot2)
library("lubridate")
library("viridis")

library_df <- read.csv("./2017-2023-10-Checkouts-SPL-Data.csv")

leigh_bardugo_all_df <- library_df %>% 
  filter(Creator %in% c("Leigh Bardugo", "Bardugo, Leigh")) %>% 
  filter(!CheckoutYear == 2023)

leigh_bardugo_all_df$Creator <- tolower(leigh_bardugo_all_df$Creator)
leigh_bardugo_all_df$Title <- tolower(leigh_bardugo_all_df$Title)

leigh_bardugo_all_df$Title[str_detect(leigh_bardugo_all_df$Title, "shadow and bone")] <- "Shadow and Bone"

leigh_bardugo_all_df$Title[str_detect(leigh_bardugo_all_df$Title, "siege and storm")] <- "Siege and Storm"

leigh_bardugo_all_df$Title[str_detect(leigh_bardugo_all_df$Title, "ruin and rising")] <- "Ruin and Rising"

leigh_bardugo_all_df$Title[str_detect(leigh_bardugo_all_df$Title, "six of crows")] <- "Six of Crows"

leigh_bardugo_all_df$Title[str_detect(leigh_bardugo_all_df$Title, "crooked kingdom")] <- "Crooked Kingdom"

leigh_bardugo_all_df$Title[str_detect(leigh_bardugo_all_df$Title, "king of scars")] <- "King of Scars"

leigh_bardugo_all_df$Title[str_detect(leigh_bardugo_all_df$Title, "rule of wolves")] <- "Rule of Wolves"

grishaverse_df <- leigh_bardugo_all_df %>% 
  filter(Title %in% c("Shadow and Bone", "Siege and Storm", "Ruin and Rising",
                      "Six of Crows", "Crooked Kingdom", "King of Scars", "Rule of Wolves"))

# Find total checkouts per Grishaverse book over the years 2017-2022
grishaverse_checkouts_per_year <- grishaverse_df %>% 
  select(Title, CheckoutYear, Checkouts, Creator) %>% 
  group_by(Title, CheckoutYear) %>% 
  summarize(total_checkouts_per_year = sum(Checkouts, na.rm = TRUE))

# MOVE THIS?

summary_info <- list()

all_checkouts <- grishaverse_checkouts_per_year %>% 
  summarize(total = sum(total_checkouts_per_year))

summary_info$sab_checkouts <- all_checkouts %>% 
  filter(Title == "Shadow and Bone") %>% 
  pull(total)

summary_info$sas_checkouts <- all_checkouts %>% 
  filter(Title == "Siege and Storm") %>% 
  pull(total)

summary_info$rar_checkouts <- all_checkouts %>% 
  filter(Title == "Ruin and Rising") %>% 
  pull(total)

summary_info$soc_checkouts <- all_checkouts %>% 
  filter(Title == "Six of Crows") %>% 
  pull(total)

summary_info$ck_checkouts <- all_checkouts %>% 
  filter(Title == "Crooked Kingdom") %>% 
  pull(total)

summary_info$kos_checkouts <- all_checkouts %>% 
  filter(Title == "King of Scars") %>% 
  pull(total)

summary_info$row_checkouts <- all_checkouts %>% 
  filter(Title == "Rule of Wolves") %>% 
  pull(total)

summary_info$total_may_checkouts <- grishaverse_df %>% 
  filter(CheckoutMonth == "5") %>% 
  filter(CheckoutYear == "2021") %>% 
  group_by(CheckoutMonth) %>% 
  summarize(may_checkouts = sum(Checkouts, na.rm = TRUE)) %>% 
  pull(may_checkouts)

summary_info$total_april_checkouts <- grishaverse_df %>% 
  filter(CheckoutMonth == "4") %>% 
  filter(CheckoutYear == "2021") %>% 
  group_by(CheckoutMonth) %>% 
  summarize(april_checkouts = sum(Checkouts, na.rm = TRUE)) %>% 
  pull(april_checkouts)

summary_info$total_oct_checkouts <- grishaverse_df %>% 
  filter(CheckoutMonth == "10") %>% 
  filter(CheckoutYear == "2021") %>% 
  group_by(CheckoutMonth) %>% 
  summarize(oct_checkouts = sum(Checkouts, na.rm = TRUE)) %>% 
  pull(oct_checkouts)

summary_info$may_april_difference <- summary_info$total_may_checkouts - summary_info$total_april_checkouts
