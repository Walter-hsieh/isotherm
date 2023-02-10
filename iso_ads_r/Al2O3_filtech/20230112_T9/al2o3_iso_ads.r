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

df_filtered <- filter(dataset, time_s>=10000)

ggplot(data=df_filtered)+
  geom_point(mapping=aes(x=time_s, y=uptake*100,,color='uptake'))+
  geom_point(mapping=aes(x=time_s, y=hpv, color='hpv'))

#--------------- interactive graph quick view---------------------
fig_0 <- plot_ly(data=dataset, x=~time_s/60)
fig_0 <- fig_0 %>% add_trace(y=~hpv, name='humidity')
fig_0 <- fig_0 %>% add_trace(y=~uptake*100, name='uptake')
fig_0



#------------------data clean---------------

df_excel <- read_excel("dataset.xlsx")
write.csv(df_excel, "dataset.csv")
df_csv <- read.csv("dataset.csv")
colnames(df_csv)


ggplot(data=df_csv)+
  geom_point(mapping=aes(x=time_s/60, y=uptake*100, color='uptake'))+
  geom_point(mapping=aes(x=time_s/60, y=hpv, color='hpv'))+
  ylim(0, 100)+
  labs(x="time (min)", y="uptake/ humidity")+
  theme_bw()

# data clean
df_clean <- df_csv %>% filter(time_s/60>=190) %>% 
  filter(!((time_s/60 >= 298.5 & time_s/60 <= 303.5) & (hpv >= 14.22 & hpv <= 19.88)))



ggplot(data=df_clean)+
  geom_point(mapping=aes(x=time_s/60, y=uptake*100, color='uptake'))+
  geom_point(mapping=aes(x=time_s/60, y=hpv, color='hpv'))+
  ylim(0, 100)+
  labs(x="time (min)", y="uptake/ humidity")+
  theme_bw()



#---------------- Interactive graph ------------------
fig <- plot_ly(data=df_clean, x=~time_s/60)
fig <- fig %>% add_trace(y=~hpv, name='humidity')
fig <- fig %>% add_trace(y=~uptake*100, name='uptake')
fig


fig_1 <- plot_ly(data=df_clean, x=~hpv, y=~uptake*100)
fig_1
#---------------- Interactive graph ------------------

# data clean group_by and summarise by max of uptake
df_group_max <- df_csv %>% filter(time_s/60>=190) %>% 
  filter(!((time_s/60 >= 298.5 & time_s/60 <= 303.5) & (hpv >= 14.22 & hpv <= 19.88))) %>% 
  mutate(hpv_1 = round(hpv,1)) %>% 
  group_by(hpv_1) %>% 
  summarise(uptake_max = max(uptake))

fig_2 <- plot_ly(data=df_group_max, x=~hpv_1, y=~uptake_max*100)
fig_2


# data clean group_by and summarise by mean of uptake
df_group_mean <- df_csv %>% filter(time_s/60>=200) %>% 
  filter(!((time_s/60 >= 298.5 & time_s/60 <= 303.5) & (hpv >= 14.22 & hpv <= 19.88))) %>% 
  mutate(hpv_1 = round(hpv,1)) %>% 
  group_by(hpv_1) %>% 
  summarise(uptake_mean = mean(uptake))

df_all <- mutate(df_group_mean, uptake_max = df_group_max$uptake_max)

fig_3 <- plot_ly(data=df_all, x=~hpv_1)
fig_3 <- fig_3 %>% add_trace(y=~uptake_max*100, name = 'uptake_max')
fig_3 <- fig_3 %>% add_trace(y=~uptake_mean*100, name = 'uptake_mean')
fig_3

df_all_dropna <- drop_na(df_all)

write.csv(df_all_dropna, "result_r.csv")

  