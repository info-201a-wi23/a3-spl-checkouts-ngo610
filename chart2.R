library(dplyr)
library(tidyverse)
library(readr)
library(ggplot2)
library("lubridate")
library("viridis")
library("plotly")

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
  group_by(Title, CheckoutMonth) %>% 
  summarize(total_checkouts_per_month = sum(Checkouts, na.rm = TRUE)) %>% 
  arrange(desc(total_checkouts_per_month))


chart2_plot <- ggplot(data = new_df, mapping = aes(x = reorder(CheckoutMonth, +CheckoutMonth), 
                                                   y = total_checkouts_per_month,
                                                   fill = Title)) +
  scale_fill_manual(values = c("#240925", "#3E1138", "#56194f", "#802b5b", "#aa405b", "#d46059", "#fea775"), 
                    labels=c("Crooked Kingdom", "King of Scars", "Ruin and Rising", "Rule of Wolves",
                             "Shadow and Bone", "Siege and Storm", "Six of Crows")) +
  labs(title = "eBook Checkouts for Leigh Bardugo's Grishaverse Novels in 2022", 
       x = "Month",
       y = "Number of Checkouts", 
       color = "Title") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  
  geom_col()

ggplotly(chart2_plot, toltip = "text")





