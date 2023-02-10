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
  geom_point(mapping=aes(x=time_s/3600, y=HPV, color='hpv'))

ggplotly(p)


#--------------- interactive graph quick view---------------------
fig_0 <- plot_ly(data=dataset, x=~time_s/3600) %>% 
  layout(xaxis = list(title='time (hr)'),
         yaxis = list(title='water uptake/ humidity'))
fig_0 <- fig_0 %>% add_trace(y=~HPV, name='humidity')
fig_0 <- fig_0 %>% add_trace(y=~uptake*100, name='uptake')
fig_0



#------------------data clean---------------

df_excel <- read_excel("dataset.xlsx")
write.csv(df_excel, "dataset.csv")
df_csv <- read.csv("dataset.csv")
colnames(df_csv)


# data clean
df_clean <- df_csv %>% filter(time_s/3600>=3) %>% 
  filter(!((time_s/3600 >= 7.132 & time_s/3600 <= 7.226) & (HPV >= 14.24 & HPV <= 19.24)))



ggplot(data=df_clean)+
  geom_point(mapping=aes(x=time_s/3600, y=uptake*100, color='uptake'))+
  geom_point(mapping=aes(x=time_s/3600, y=HPV, color='hpv'))+
  ylim(0, 100)+
  labs(x="time (min)", y="uptake/ humidity")+
  theme_bw()


#---------------- Interactive graph ------------------
fig <- plot_ly(data=df_clean, x=~time_s/60)
fig <- fig %>% add_trace(y=~HPV, name='humidity')
fig <- fig %>% add_trace(y=~uptake*100, name='uptake')
fig


fig_1 <- plot_ly(data=df_clean, x=~HPV, y=~uptake*100)
fig_1



# data clean group_by and summarise by max of uptake
df_group_max <- df_clean %>% 
  mutate(hpv_1 = round(HPV,1)) %>% 
  group_by(hpv_1) %>% 
  summarise(uptake_max = max(uptake))

fig_2 <- plot_ly(data=df_group_max, x=~hpv_1, y=~uptake_max*100)
fig_2


# data clean group_by and summarise by mean of uptake
df_group_mean <- df_clean %>% 
  mutate(hpv_1 = round(HPV,1)) %>% 
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
p1 <- ggplot(data=df_all)+
  geom_point(mapping=aes(x=hpv_1, y=uptake_mean*100, color='Al2O3_Filtech'))+
  geom_smooth(mapping=aes(x=hpv_1, y=uptake_mean*100, color='smooth'))+
  ylab('water uptake (wt.%)')+
  xlab('humidity (%RH)')+
  xlim(0,100)+
  theme_test()

ggplotly(p1)
  