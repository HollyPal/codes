library(dplyr)

tuesdata <- tidytuesdayR::tt_load('2022-02-01')

breedinfo <- tuesdata$breed_traits |> 
  janitor::clean_names()

friendly_dogs <- breedinfo |> 
  filter (affectionate_with_family %in% c(4,5) 
         & good_with_young_children %in% c(4,5) 
         & good_with_other_dogs %in% c(4,5)
         & openness_to_strangers %in% c(4,5)
         & playfulness_level %in% c(4,5))
  
target_dogs <- friendly_dogs |> 
  mutate (trainability_level_category = case_when(
    trainability_level %in% c(1,2) ~ "Not very trainable",
    trainability_level == 3 ~ "Somewhat trainable",
    trainability_level %in% c(4,5) ~ "Very trainable")) |> 
  select(breed,trainability_level_category) |> 
  arrange(breed)

target_dogs |> 
  group_by(trainability_level_category) |> 
  summarise(trainability_category_count =n())