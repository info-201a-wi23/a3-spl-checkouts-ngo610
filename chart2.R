library(dplyr)
library(tidyverse)
library(readr)
library(ggplot2)
library("lubridate")
library("viridis")
library("plotly")

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

# Find total checkouts per Grishaverse book from January to December of 2022
checkouts_per_months <- grishaverse_df %>% 
  select(Title, CheckoutYear, CheckoutMonth, Checkouts) %>% 
  filter(CheckoutYear == "2021") %>% 
=======
library_df <- read_csv("2017-2023-10-Checkouts-SPL-Data.csv")

leigh_bardugo_df <- library_df %>% 
  filter(Creator == "Leigh Bardugo") %>% 
  filter(!CheckoutYear == 2023)

# Find total checkouts per Grishaverse book over the years 2017-2022
new_df <- leigh_bardugo_df %>% 
  select(Title, CheckoutYear, CheckoutMonth, Checkouts) %>% 
  filter(CheckoutYear == "2022") %>% 
  filter(Title %in% c("Shadow and Bone: The Grisha Trilogy, Book 1", "Siege and Storm: The Grisha Trilogy, Book 2", 
                      "Ruin and Rising: The Grisha Trilogy, Book 3",
                      "Six of Crows: Dregs Series, Book 1", "Crooked Kingdom: Dregs Series, Book 2",
                      "King of Scars: King of Scars Series, Book 1", "Rule of Wolves: King of Scars Duology, Book 2")) %>% 
>>>>>>> 68ba237644ac09c0b877cdd324a017a9fb0aa239
  group_by(Title, CheckoutMonth) %>% 
  summarize(total_checkouts_per_month = sum(Checkouts, na.rm = TRUE)) %>% 
  arrange(desc(total_checkouts_per_month))

<<<<<<< HEAD
total_may_checkouts <- grishaverse_df %>% 
  filter(CheckoutMonth == "5") %>% 
  group_by(CheckoutMonth) %>% 
  summarize(may_checkouts = sum(Checkouts, na.rm = TRUE))


chart2_plot <- ggplot(data = checkouts_per_months, mapping = aes(x = reorder(CheckoutMonth, +CheckoutMonth), 
=======

chart2_plot <- ggplot(data = new_df, mapping = aes(x = reorder(CheckoutMonth, +CheckoutMonth), 
>>>>>>> 68ba237644ac09c0b877cdd324a017a9fb0aa239
                                                   y = total_checkouts_per_month,
                                                   fill = Title)) +
  scale_fill_manual(values = c("#240925", "#3E1138", "#56194f", "#802b5b", "#aa405b", "#d46059", "#fea775"), 
                    labels=c("Crooked Kingdom", "King of Scars", "Ruin and Rising", "Rule of Wolves",
                             "Shadow and Bone", "Siege and Storm", "Six of Crows")) +
<<<<<<< HEAD
  labs(title = "Monthly Checkouts for Leigh Bardugo's Grishaverse Novels in 2021", 
=======
  labs(title = "eBook Checkouts for Leigh Bardugo's Grishaverse Novels in 2022", 
>>>>>>> 68ba237644ac09c0b877cdd324a017a9fb0aa239
       x = "Month",
       y = "Number of Checkouts", 
       color = "Title") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  
  geom_col()

<<<<<<< HEAD
ggplotly(chart2_plot, toltip = "text")
=======
ggplotly(chart2_plot, toltip = "text")





>>>>>>> 68ba237644ac09c0b877cdd324a017a9fb0aa239
