import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors

colors = mcolors.TABLEAU_COLORS
color_list = list(colors.values())

df = pd.read_excel("summary.xlsx")

print(df)
colnames = df.columns


fig, ax = plt.subplots()
ax.set_xlabel("%RH")
ax.set_ylabel("water uptake_wt.%")
# ax.text(30, 0, "measured at 80%RH/ 25°C")

markers = ["o", "v", "s", "p", "x"]
ax.plot(df[colnames[0]], df[colnames[1]], label=colnames[1], color = color_list[0], marker=markers[0], linewidth=1, alpha=0.8)
ax.plot(df[colnames[2]], df[colnames[3]], label=colnames[3], color = color_list[1], marker=markers[1], linewidth=1, alpha=0.8)
ax.plot(df[colnames[4]], df[colnames[5]], label=colnames[5], color = color_list[2], marker=markers[2], linewidth=1, alpha=0.8)
# ax.plot(df[colnames[6]], df[colnames[7]], label=colnames[7], color = color_list[3], marker=markers[3], linewidth=1, alpha=0.8)
# ax.plot(df[colnames[8]], df[colnames[9]]*100, label=colnames[9], color = color_list[4], marker=markers[4], linewidth=1.5, alpha=1)
ax.legend(loc=2, fontsize=10)
ax.set_title("Adsorption Isotherm of water")
plt.xlim([0, 100])
plt.ylim([0, 100])
# plt.savefig('result.png', dpi=1000)
plt.savefig('Adsorption Isotherm_ntu.png', dpi=1000)
plt.show()


