import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_excel("dataset.xlsx")

# print(df.head(10))

fig, ax = plt.subplots()

# ax.plot(df['time_s'], df['HPV'])
# ax.plot(df['time_s'], df['uptake']*100)
ax.scatter(df['HPV'], df['uptake']*100)



x = [3, 20, 40, 60, 75, 85, 95]
y = [3, 8, 13, 17, 25, 30, 37]

ax.scatter(x, y)


plt.show()

