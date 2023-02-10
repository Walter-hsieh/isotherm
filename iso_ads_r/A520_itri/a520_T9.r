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
  geom_point(mapping=aes(x=time_s/3600, y=uptake*100,color='uptake'))+
  geom_point(mapping=aes(x=time_s/3600, y=uptake1*100,,color='uptake1'))+
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
df_clean <- df_csv %>% filter(time_s/3600>=3) %>% 
  filter(!((time_s/3600 >= 4.982 & time_s/3600 <= 5.017) & (hpv >= 16.61 & hpv <= 19.72)))



p1 <- ggplot(data=df_clean)+
    geom_point(mapping=aes(x=time_s/3600, y=uptake*100, color='uptake'))+
    geom_point(mapping=aes(x=time_s/3600, y=hpv, color='hpv'))+
    ylim(0, 100)+
    labs(x="time (min)", y="uptake/ humidity")+
    theme_bw()

ggplotly(p1)


p2 <- ggplot(data=df_clean)+
  geom_point(mapping=aes(x=hpv, y=uptake*100, color='uptake'))+
  labs(x="humidity (%RH)", y="uptake (wt.%)")+
  xlim(0,100)+
  theme_bw()

ggplotly(p2)

humidity = c(9.52, 29.91, 40.08, 49.89, 70.05, 80.13, 90.03)
water_uptake = c(1.613, 13.195, 28.175, 33.32, 36.51, 40.896, 48.718)

point_pick = data.frame(humidity, water_uptake)

write.csv(point_pick, 'point_pick.csv', row.names = FALSE)


p3 <- ggplot(data=point_pick, mapping=aes(x=humidity, y=water_uptake, color='uptake'))+
  geom_point()+
  geom_smooth(se=FALSE)+
  labs(x="humidity (%RH)", y="uptake (wt.%)")+
  xlim(0,100)+
  theme_bw()

ggplotly(p3)


# data clean group_by and summarise by max of uptake
df_group_max <- df_clean %>% 
  mutate(hpv_1 = round(hpv,0)) %>% 
  group_by(hpv_1) %>% 
  summarise(uptake_max = max(uptake))

fig_2 <- plot_ly(data=df_group_max, x=~hpv_1, y=~uptake_max*100)
fig_2


# data clean group_by and summarise by mean of uptake
df_group_mean <- df_clean %>% 
  mutate(hpv_1 = round(hpv,0)) %>% 
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

write.csv(df_all_dropna, "result_r.csv", row.names = FALSE)


# smoothing
p2 <- ggplot(data=df_all)+
  geom_point(mapping=aes(x=hpv_1, y=uptake_mean*100,color='a520'))+
  geom_smooth(mapping=aes(x=hpv_1, y=uptake_mean*100, color='smooth'),se=FALSE)+
  ylab('water uptake (wt.%)')+
  xlab('humidity (%RH)')+
  xlim(0,100)+
  theme_test()

ggplotly(p2)
  