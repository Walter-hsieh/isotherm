install.packages("tidyverse")
library(tidyverse)
library(ggplot2)

install.packages("readxl")
library(readxl)

df <- read_excel("result.xlsx")
view(df)

colnames(df)

# quick view of the data
ggplot(data=df)+
  geom_point(mapping=aes(x=hpv, y=uptake))


# data clean: filter unwanted data
df_f <- filter(df, !((hpv >= 59.45 & hpv <= 91.32) & (uptake >= 0.107961565 & uptake <= 0.118531)))
df_f <- filter(df_f, !((hpv >= 51.05 & hpv <= 54.8) & (uptake >= 0.091901166 & uptake <= 0.108030199)))
df_f <- filter(df_f, hpv<=88.5)


# quick view of filtered data
ggplot(data=df_f)+
  geom_point(mapping=aes(x=hpv, y=uptake))


# remove decimal of HPV and grouped
df_m <- mutate(df_f, hpv1=round(hpv))
df_g <- group_by(df_m, hpv1)
df_s <- summarize(df_g, uptake = mean(uptake))


ggplot(data=df_s, mapping=aes(x=hpv1, y=uptake*100))+
  geom_point()+
  ylim(0,44)

write.csv(df_s, "alumina_filtech_r.csv")


