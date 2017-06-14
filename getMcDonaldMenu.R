library(dplyr)
CateCode = read.csv("categoryCode.txt", header = FALSE, sep = ",",col.names = c("name", "code"), colClasses = c("character", "character"))

menu = read.csv("menu.csv",header = TRUE, colClasses = c("character", "character", "numeric", "character"))

# menu$Size[menu$Size == ""] = "Uni-Size"

menu  = menu %>% inner_join(CateCode, by = c( "Category" = "code"))
names(menu)
