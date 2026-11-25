library(DBI)
library(RPostgres)
library(tidyverse)
library(palmerpenguins)

con <- dbConnect(RPostgres::Postgres(),
                 dbname="pagila",
                 host="localhost",
                 port=5432,
                 user="postgres",
                 password = "Teeren11")

dbListTables(con) # Shows all tables in the pagila database
dbListFields(con, "actor") # Shows all colums in the actor table
actor <- dbReadTable(con, "actor") # read the table as a data.frame
dbGetQuery(con, 'Select * from actor')

actortbl <- tbl(con, "actor")
actortbl %>% 
  select(actor_id, first_name, last_name) %>%
  filter(actor_id > 5 & actor_id < 12)

myquery <- dbSendQuery(con, "select * from actor where actor_id = $1")
dbBind(myquery, list(4))
dbFetch(myquery)
dbClearResult(myquery)
dbDisconnect(con)

con <- dbConnect(RPostgres::Postgres(),
                 dbname = "myfirstdb",
                 host = "localhost",
                 port = 5432,
                 user = "postgres",
                 password = "")


dbWriteTable(con, "penguinswide", penguins)
dbRemoveTable(con, "penguinswide")

penguins %>% pivot_longer(contains("_"),
                          names_to = c("part", "measure", "unit"),
                          names_sep = "_") -> penguins_tidy

dbWriteTable(con, "penguins_long", penguins_tidy)
dbDisconnect(con)
