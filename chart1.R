library(dplyr)
library(tidyverse)
library(readr)
library(ggplot2)
library("lubridate")
library("viridis")

<<<<<<< HEAD
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
=======
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
>>>>>>> 68ba237644ac09c0b877cdd324a017a9fb0aa239
  group_by(Title, CheckoutYear) %>% 
  summarize(total_checkouts_per_year = sum(Checkouts, na.rm = TRUE))

# MOVE THIS?
<<<<<<< HEAD
all_checkouts <- grishaverse_checkouts_per_year %>% 
  summarize(total = sum(total_checkouts_per_year))

dregs_checkouts_per_year <- grishaverse_checkouts_per_year %>% 
  filter(Title %in% c("Six of Crows", "Crooked Kingdom")) %>% 
=======
all_checkouts <- bardugo_checkouts_per_year %>% 
  summarize(total = sum(total_checkouts_per_year))

dregs_checkouts_per_year <- bardugo_checkouts_per_year %>% 
  filter(Title %in% c("Six of Crows: Dregs Series, Book 1", "Crooked Kingdom: Dregs Series, Book 2")) %>% 
>>>>>>> 68ba237644ac09c0b877cdd324a017a9fb0aa239
  group_by(CheckoutYear) %>% 
  summarize(total = sum(total_checkouts_per_year))

dregs <- "Dregs Series"
dregs_checkouts_per_year$Title <- dregs

<<<<<<< HEAD
grisha_checkouts_per_year <- grishaverse_checkouts_per_year %>% 
  filter(Title %in% c("Shadow and Bone", "Siege and Storm", "Ruin and Rising")) %>% 
=======
grisha_checkouts_per_year <- bardugo_checkouts_per_year %>% 
  filter(Title %in% c("Shadow and Bone: The Grisha Trilogy, Book 1", "Siege and Storm: The Grisha Trilogy, Book 2", 
                      "Ruin and Rising: The Grisha Trilogy, Book 3")) %>% 
>>>>>>> 68ba237644ac09c0b877cdd324a017a9fb0aa239
  group_by(CheckoutYear) %>% 
  summarize(total = sum(total_checkouts_per_year))

grisha <- "Grisha Trilogy"
grisha_checkouts_per_year$Title <- grisha

<<<<<<< HEAD
king_of_scars_checkouts_per_year <- grishaverse_checkouts_per_year %>% 
  filter(Title %in% c("King of Scars", "Rule of Wolves")) %>% 
=======
king_of_scars_checkouts_per_year <- bardugo_checkouts_per_year %>% 
  filter(Title %in% c("King of Scars: King of Scars Series, Book 1", "Rule of Wolves: King of Scars Duology, Book 2")) %>% 
>>>>>>> 68ba237644ac09c0b877cdd324a017a9fb0aa239
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
<<<<<<< HEAD
  labs(title = "Total Checkouts for each Grishaverse Series", x = "Year",
       y = "Number of Checkouts", color = "Series Title") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
=======
  labs(title = "Total eBook Checkouts for each Grishaverse Series", x = "Year",
       y = "Number of Checkouts", color = "Series Title") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

  

>>>>>>> 68ba237644ac09c0b877cdd324a017a9fb0aa239
