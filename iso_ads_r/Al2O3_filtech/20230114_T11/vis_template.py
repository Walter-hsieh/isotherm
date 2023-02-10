import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors

colors = mcolors.TABLEAU_COLORS
color_list = list(colors.values())

markers = ['o','v','s','p','x']

class Graph:
	def __init__(self, data,x,y,z):
		self.data= data
		self.x = data[x]
		self.y = data[y]
		self.z = data[z]

	def plot(self, title='defalut', labels=['A', 'B'], axes=['%RH', 'water uptake_wt.%']):
		fig, ax = plt.subplots()
		ax.scatter(x=self.x, y=self.y, label=labels[0], color=color_list[0], marker=markers[0], alpha=0.8)
		ax.scatter(x=self.x, y=self.z, label=labels[1], color=color_list[1], marker=markers[1], alpha=0.8)
		ax.legend(loc=2, fontsize=10)
		ax.set_title(title)
		ax.set_xlabel(axes[0])
		ax.set_ylabel(axes[1])
		plt.show()


df = pd.read_csv("result_r.csv")
df1 = pd.read_csv("dataset.csv")


# Make graph Objects
graph_1 = Graph(df, 'hpv_1','uptake_mean', 'uptake_max')
graph_2 = Graph(df1, 'time_s', 'uptake', 'HPV')

# Call plot
# graph_1.plot('Al2O3 Isotherm', ['uptake_man', 'uptake_max'])
# graph_2.plot('Al2O3 Test Condition', ['uptake', 'hpv'], ['time', 'humidity/uptake'])




# Creating plot with dataset_1
fig, ax1 = plt.subplots()
 
color = 'k'
ax1.set_xlabel('time (hr)')
ax1.set_ylabel('Water uptake (wt.%)', color = color)
ax1.scatter(graph_2.x/3600, graph_2.y*100, color = color, s=5)
ax1.tick_params(axis ='y', labelcolor = color)
 
# Adding Twin Axes to plot using dataset_2
ax2 = ax1.twinx()
 
color = 'tab:blue'
ax2.set_ylabel('Humidity_%RH', color = color)
ax2.scatter(graph_2.x/3600, graph_2.z, color = color, s=5)
ax2.tick_params(axis ='y', labelcolor = color)
 
# Adding title
plt.title('Al2O3_Filtech TEST11 2023-01-14') #fontweight ="bold"
 
# Show plot
plt.show()




url = 'https://www.geeksforgeeks.org/use-different-y-axes-on-the-left-and-right-of-a-matplotlib-plot/'