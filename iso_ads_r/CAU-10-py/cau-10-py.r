install.packages("tidyverse")
install.packages("ggplot2")
install.packages("readxl")
install.packages("plotly")

library(tidyverse)
library(ggplot2)
library(readxl)
library(plotly) 

dataset <- read_excel("dataset.xlsx")
colnames(dataset)

p <- ggplot(data=dataset)+
  geom_point(mapping=aes(x=time_s/3600, y=uptake*100,,color='uptake'))+
  geom_point(mapping=aes(x=time_s/3600, y=hpv, color='humidity'))+
  ylab("water uptake/ humidity")+
  xlab('time (hr)')+
  theme_test()

ggplotly(p)


#------------------data clean---------------

df_excel <- read_excel("dataset.xlsx")
write.csv(df_excel, "dataset.csv")
df_csv <- read.csv("dataset.csv")
colnames(df_csv)


# data clean
df_clean <- df_csv %>% filter(time_s/3600>=2.86) %>% 
  filter(!((time_s/3600 >= 4.3666 & time_s/3600 <= 4.725) & (hpv >= 16.68 & hpv <= 35.68))) #%>% 
  #filter(!((time_s/3600 >= 21.433 & time_s/3600 <= 21.7833) & (hpv >= 17.59 & hpv <= 40.48)))




p1 <- ggplot(data=df_clean)+
  geom_point(mapping=aes(x=time_s/3600, y=uptake*100, color='uptake'))+
  geom_point(mapping=aes(x=time_s/3600, y=hpv, color='hpv'))+
  ylim(0, 100)+
  labs(x="time (min)", y="uptake/ humidity")+
  theme_bw()

ggplotly(p1)


p2 <- ggplot(data=df_clean)+
  geom_point(mapping=aes(x=hpv, y=uptake*100, color='uptake'))+
  xlim(0, 100)+
  labs(x="humidity", y="uptake")+
  theme_bw()

ggplotly(p2)


humidity = c(9.50, 19.62, 29.95, 40.18, 50.33,63.30,70.02,80.05,89.91)
water_uptake = c(24.653,30.923, 32.788, 33.576, 34.211,34.865,35.230,35.903,37.615)

point_pick = data.frame(humidity, water_uptake)
write.csv(point_pick, 'point_pick.csv', row.names = FALSE)


p3 <- ggplot(data=point_pick, mapping=aes(x=humidity, y=water_uptake, color='uptake'))+
  geom_point()+
  geom_smooth(se=FALSE)+
  labs(x="humidity (%RH)", y="uptake (wt.%)")+
  xlim(0,100)+
  theme_bw()

ggplotly(p3)



# group data by humidity
df_group <- df_clean %>% 
  mutate(hpv_1 = round(hpv,0)) %>% 
  group_by(hpv_1) %>% 
  select(hpv_1, uptake) %>%
  drop_na() %>% 
  summarise(uptake_max = max(uptake), uptake_mean = mean(uptake), uptake_min = min(uptake))


# smooth plot
p <- ggplot(data=df_group)+
  geom_point(mapping=aes(x=hpv_1, y=uptake_max*100, color='max'))+
  geom_point(mapping=aes(x=hpv_1, y=uptake_mean*100, color='mean'))+
  geom_point(mapping=aes(x=hpv_1, y=uptake_min*100, color='min'))+
  # geom_smooth(mapping=aes(x=hpv_1, y=uptake_max*100, color='max_smooth'))+
  ylab('water uptake (wt.%)')+
  xlab('humidity (%RH)')+
  xlim(0, 100)+
  ylim(0, 50)+
  theme_test()

ggplotly(p)


# save processed data as csv
df_dropna <- drop_na(df_group)

write.csv(df_dropna, "result_r.csv", row.names = FALSE)
  