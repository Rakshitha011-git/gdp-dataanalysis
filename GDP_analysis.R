library(tidyverse)
library(janitor)
library(stringr)
dir()
dir(path = "GDP Data")



"GDP Data/NAD-Andhra_Pradesh-GSVA_cur_2016-17.csv" %>% 
  read_csv()-> ap_df

"NAD-Andhra_Pradesh-GSVA_cur_2016-17.csv" %>% 
  str_split("-") %>% 
  unlist() ->state_name_vector
state_name_vector[2] ->st_name
st_name


ap_df %>% 
  slice(-c(7,11,27:33)) %>% 
  pivot_longer(-c(1,2),names_to = "year",values_to = "gsdp") %>% 
  clean_names() %>% 
  select(-1) %>% 
  mutate(state = st_name)


##step 1
#create for loop and iterate over all files names
dir(path="GDP Data",
    pattern = "NAD") ->state_files
tibble() -> tempdf    
for(i in state_files){
  print(paste0("GDP Data",i))

i %>% 
  str_split("-") %>% 
  unlist()->state_name_vector
state_name_vector[2] ->str_name
print(paste0("state name:",str_name))

##step3
#read.csv file
paste0("GDP Data/",i) %>% 
  read.csv() ->st_df1

st_df1 %>% 
  slice(-c(7,11,27:33)) %>% 
  pivot_longer(-c(1,2),names_to = "year",values_to = "gsdp") %>% 
  clean_names() %>% 
  select(-1) %>% 
  mutate(state = str_name) ->state_df
print(state_df)

bind_rows(tempdf,state_df)->tempdf
tempdf
}
tempdf-> final_statewise_gsdp

