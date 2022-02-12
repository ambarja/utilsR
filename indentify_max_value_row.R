# Indentify max value and put name of column in row
library(tidyverse)
df <- tibble(
  id = 1:5,
  luz = c(20,10,5,30,12),
  agua = c(14,5,10,14,15),
  internet = c(24,1,4,15,20)
)

# 01. Max value in new column
df %>% 
  mutate(cat = pmax(!!!syms(c("agua","luz","internet"))))

# 02. Name of max value in column  
 df %>% 
  rowwise() %>%
  mutate(row_max = names(.)[which.max(c_across(everything()))]) 
# 03. Columns specific
df %>% 
  rowwise() %>%
  mutate(row_max = names(.)[which.max(c_across(everything(vars = c(agua,luz))))])

