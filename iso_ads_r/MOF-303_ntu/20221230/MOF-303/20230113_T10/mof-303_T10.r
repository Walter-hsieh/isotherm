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
df_clean <- df_csv %>% filter(time_s/3600>=3.4)  %>% 
  filter(!((time_s/3600 >= 5.282 & time_s/3600 <= 5.326) & (hpv >= 16.26 & hpv <= 19.55))) %>% 
  filter(!((time_s/3600 >= 3.8832 & time_s/3600 <= 4.184) & (hpv >= 18.94 & hpv <= 21.51))) %>%  
  filter(!((time_s/3600 >= 5.3832 & time_s/3600 <= 5.517) & (hpv >= 29.62 & hpv <= 32.04)))




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


humidity = c(9.55,19.35,30.78,41.23,51.21,56.45,60.11,63.66,71.13,80.89,85.89,89.34,95.06)
water_uptake = c(10.375,20.492,36.572,40.117,40.774,40.751,41.43,41.05,41.737,41.784,41.361,42.065,42.558)

point_pick = data.frame(humidity, water_uptake)
write.csv(point_pick, 'point_pick.csv', row.names = FALSE)




p3 <- ggplot(data=point_pick, mapping=aes(x=humidity, y=water_uptake, color='MOF-303_ntu_1230'))+
  geom_point()+
  #geom_line()+
  geom_smooth(se=FALSE)+
  labs(x="humidity (%RH)", y="uptake (wt.%)")+
  xlim(0,100)+
  theme_bw()

ggplotly(p3)


tiff("test_5x2_smooth.tiff", units="in", width=5, height=2.5, res=1000)
p3
dev.off()



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

write.csv(df_all_dropna, "result_r.csv", row.names = FALSE)


# smoothing
p <- ggplot(data=df_all)+
  geom_point(mapping=aes(x=hpv_1, y=uptake_max*100))+
  geom_smooth(mapping=aes(x=hpv_1, y=uptake_max*100))+
  ylab('water uptake (wt.%)')+
  xlab('humidity (%RH)')+
  xlim(0,100)+
  theme_test()

ggplotly(p)
  