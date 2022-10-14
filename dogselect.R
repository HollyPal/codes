library(dplyr)

breed_traits |> 
  select("Breed", "Affectionate With Family") |> 
  rename("Dog Breed" = "Breed") |> 
  readr::write_csv("dogbasic.csv")
