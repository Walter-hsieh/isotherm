install.packages("tidyverse")
install.packages("readxl")
library(tidyverse)
library(ggplot2)
library(readxl)


df <- read.csv("iso_des_summary.csv")

colnames(df)


ggplot(data=df)+
  geom_point(mapping=aes(x=hpv_4a, y=X4a_filtech*100, color='4A_filtech'))+
  geom_point(mapping=aes(x=hpv_mof.801, y=mof.801*100, color='MOF-801'))+
  geom_point(mapping=aes(x=hpv_alumina, y=alumina_filtech*100, color='alumina_filtech'))+
  geom_point(mapping=aes(x=hpv_mof.303, y=mof.303_1230_ntu*100, color='mof-303_1230_ntu'))+
  geom_point(mapping=aes(x=hpv_a520, y=a520_itri*100, color='a520_itri'))+
  ylim(0, 55)+
  xlim(0, 100)+
  theme_bw()+
  labs(x="Humidity_%RH", y="water uptake_wt.%")


