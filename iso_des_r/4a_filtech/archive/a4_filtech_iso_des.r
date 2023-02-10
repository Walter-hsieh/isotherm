install.packages("tidyverse")
library(tidyverse)
library(ggplot2)

df <- read.csv("4a_filtech_iso_des_p.csv")
view(df)

# quick view of data
ggplot(data=df)+
  geom_point(mapping=aes(x=hpv, y=uptake))


# data clean: filter unwanted data
df_f <- filter(df, !((hpv >= 73.17 & hpv <= 83.60) & (uptake >= 0.120886 & uptake <= 0.12344)))


# quick view of filtered data
ggplot(data=df_f)+
  geom_point(mapping=aes(x=hpv, y=uptake))


# remove decimal of HPV and grouped
df_m <- mutate(df_f, hpv1=round(hpv,1))
df_g <- group_by(df_m, hpv1)
df_s <- summarize(df_g, uptake = mean(uptake))


ggplot(data=df_s, mapping=aes(x=hpv1, y=uptake*100))+
  geom_point()+
  geom_smooth()
  ylim(0,44)

# write.csv(df_s, "4a_filtech_iso_des_r.csv")


