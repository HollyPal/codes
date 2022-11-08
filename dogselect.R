library(dplyr)

tuesdata <- tidytuesdayR::tt_load('2022-02-01')

breed_traits <- tuesdata$breed_traits |> 
  janitor::clean_names()

breed_traits |> 
  select(breed,affectionate_with_family) |> 
  rename(dog_breed = breed) |> 
  readr::write_csv("dogbasic.csv")

breed_traits |> 
  filter(coat_grooming_frequency==1)

breed_traits |> 
  filter(
    (good_with_young_children==5 & drooling_level==1)|
      (good_with_young_children==5 & drooling_level==2)
    )

breed_traits |> 
  filter(
    good_with_young_children==5 & drooling_level %in% c(1,2)
  )
# this is a comment
stuff <- breed_traits |> 
  mutate(
    bark_energy = barking_level*energy_level,
    coat = paste(coat_type , coat_length, sep = " " ),
    affectionate_with_family_category = case_when(
      affectionate_with_family %in% c(4,5) ~ "very affectionate",
      affectionate_with_family == 3 ~ "moderately affectionate",
      affectionate_with_family %in% c(1,2) ~ "stone cold fish"
    )) |> 
    select(breed, barking_level, bark_energy, coat, coat_type, coat_length, 
           affectionate_with_family,affectionate_with_family_category ) |> 
  arrange(desc(barking_level), breed)

stuff |> 
  group_by(coat_length) |> 
  summarise(coat_length_frequency = n())

stuff |> 
  count(coat_length) 