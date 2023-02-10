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
  geom_point(mapping=aes(x=time_s/3600, y=hpv, color='hpv'))

ggplotly(p)


#------------------data clean---------------

df_excel <- read_excel("dataset.xlsx")
write.csv(df_excel, "dataset.csv")
df_csv <- read.csv("dataset.csv")
colnames(df_csv)


# data clean
df_clean <- df_csv %>% filter(time_s/3600>=0.5) #%>% 
  # filter(!((time_s/3600 >= 31.625 & time_s/3600 <= 31.933) & (hpv >= 78.94 & hpv <= 99.66))) %>% 
  # filter(!((time_s/3600 >= 10.308 & time_s/3600 <= 10.3834) & (hpv >= 13.46 & hpv <= 19.45)))



p1 <- ggplot(data=df_clean)+
  geom_point(mapping=aes(x=time_s/3600, y=uptake*100, color='uptake'))+
  geom_point(mapping=aes(x=time_s/3600, y=hpv, color='hpv'))+
  ylim(0, 100)+
  labs(x="time (min)", y="uptake/ humidity")+
  theme_bw()

ggplotly(p1)


p2 <- ggplot(data=df_clean)+
  geom_point(mapping=aes(x=hpv, y=uptake*100, color='uptake'))+
  labs(x="humidity", y="uptake")+
  theme_bw()

ggplotly(p2)

humidity = c(9.95, 29.79,50.02, 69.88, 89.84)
water_uptake = c(10.426, 11.096, 11.54, 12.12, 12.603)

point_pick <- data.frame(humidity, water_uptake)

write.csv(point_pick, 'point_pick.csv', row.names = FALSE)

p3 <- ggplot(mapping=aes(x=humidity, y=water_uptake, color='uptake'))+
  geom_point()+
  geom_smooth(se=FALSE)+
  labs(x="humidity", y="uptake")+
  xlim(0,100)+
  theme_bw()

ggplotly(p3)



# data clean group_by and summarise by max of uptake
df_group_max <- df_clean %>% 
  mutate(hpv_1 = round(hpv,1)) %>% 
  group_by(hpv_1) %>% 
  summarise(uptake_max = max(uptake))

fig_2 <- plot_ly(data=df_group_max, x=~hpv_1, y=~uptake_max*100)
fig_2


# data clean group_by and summarise by mean of uptake
df_group_mean <- df_clean %>% 
  mutate(hpv_1 = round(hpv,1)) %>% 
  group_by(hpv_1) %>% 
  summarise(uptake_mean = mean(uptake))

df_all <- mutate(df_group_mean, uptake_max = df_group_max$uptake_max)

fig_3 <- plot_ly(data=df_all, x=~hpv_1) %>% 
  layout(xaxis = list(title='humidity (%RH)'),
         yaxis = list(title='water uptake (wt.%)'))
fig_3 <- fig_3 %>% add_trace(y=~uptake_max*100, name = 'uptake_max')
fig_3 <- fig_3 %>% add_trace(y=~uptake_mean*100, name = 'uptake_mean')
fig_3

df_all_dropna <- drop_na(df_all)

write.csv(df_all_dropna, "result_r.csv")


# smoothing
p4 <- ggplot()+
  geom_point(data=df_all, mapping=aes(x=hpv_1, y=uptake_max*100, color='Al2O3_Filtech_max'))+
  geom_smooth(data=df_all, mapping=aes(x=hpv_1, y=uptake_max*100, color='Al2O3_Filtech_max'),se=FALSE)+
  geom_point(mapping=aes(x=humidity, y=water_uptake, color='Al2O3_Filtech_point'))+
  geom_smooth(mapping=aes(x=humidity, y=water_uptake, color='Al2O3_Filtech_point'),se=FALSE)+
  ylab('water uptake (wt.%)')+
  xlab('humidity (%RH)')+
  xlim(0,100)+
  ylim(0, 20)+
  theme_test()


ggplotly(p4)



  