library(DBI)
library(RPostgres)

con <- dbConnect(RPostgres::Postgres(),
                 dbname="pagila",
                 host="localhost",
                 port=5432,
                 user="postgres",
                 password = "Teeren11")

