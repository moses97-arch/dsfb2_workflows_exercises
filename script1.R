library(tidyverse)


md5_sum_toxrefdb <- tools::md5sum(
  here::here(
    "data",
    "toxrefdb_nel_lel_noael_loael_summary_AUG2014_FOR_PUBLIC_RELEASE.csv"
  )
) %>% enframe()


md5_sum_toxrefdb %>% 
  readr::write_csv(
    here::here(
      "data",
      "toxrefdb_nel_lel_noael_loael_summary_AUG2014_FOR_PUBLIC_RELEASE.md5"
    )
  )

local_md5_sum <- read_csv(
  here::here(
    "data",
    "toxrefdb_nel_lel_noael_loael_summary_AUG2014_FOR_PUBLIC_RELEASE.md5"
    
  )
)

# Server doesn't exist but with will be the same code as the local
# local_md5_sum$value == server_md5_sum$value -> if the same it returns True

