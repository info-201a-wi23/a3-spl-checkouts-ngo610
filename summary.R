library(dplyr)
library(tidyverse)
library(readr)

library_df <- read_csv("~/info 201/a3-spl-checkouts-ngo610/2017-2023-10-Checkouts-SPL-Data.csv/2017-2023-10-Checkouts-SPL-Data.csv")

leigh_bardugo_df <- library_df %>% 
  filter(Creator == "Leigh Bardugo")
