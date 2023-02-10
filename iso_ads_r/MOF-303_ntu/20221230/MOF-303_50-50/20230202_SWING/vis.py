import pandas as pd
import matplotlib.pyplot as plt
import plotly.express as px

df = pd.read_excel("dataset.xlsx")


def quick_look(df):
	time = df['time_s']/3600
	hpv = df['hpv']
	uptake = df['uptake']*100

	fig, ax1 = plt.subplots()
	color='tab:red'
	ax1.scatter(x=time, y=hpv, color=color, s=5)
	ax1.set_xlabel('time (hr)')
	ax1.set_ylabel('humidity (%RH)', color=color)

	color='tab:blue'
	ax2 = ax1.twinx()
	ax2.scatter(x=time, y=uptake, color=color, s=5)
	ax2.set_ylabel('water uptake (wt.%)', color=color)

	# plt.ylim(0,40)

	plt.savefig('result.png', dpi=1000)

	plt.show()


# df_filtered = df[df['time_s']/3600 >= 3]

def make_plot(df_filtered):
	time = df_filtered['time_s']/3600
	hpv = df_filtered['hpv']
	uptake = df_filtered['uptake']*100

	fig,ax = plt.subplots()
	ax.scatter(x=hpv, y=uptake, s=5)
	ax.set_xlabel('humidity (%RH)')
	ax.set_ylabel('water uptake (wt.%)')
	# plt.ylim(0, 40)
	plt.savefig("humidity_vs_uptake.png", dpi=500)
	plt.show()

	#interactive plot by plotly
	fig = px.scatter(x=hpv, y=uptake)
	fig.show()

quick_look(df)
# make_plot(df)

# hpv_p = [9.59, 14.81, 18.12, 30.05, 40.45, 50.41, 59.9, 70.4, 80.36, 90.25, 95.14]
# uptake_p = [9.2723, 14.0845, 21.502, 38.99, 40.117, 40.845, 41.314, 41.596, 41.807, 41.877, 41.948]

# df_p = pd.DataFrame({'hpv':hpv_p, 'uptake':uptake_p})

# print(df_p)

# fig,ax = plt.subplots()
# ax.plot(df_p['hpv'], df_p['uptake']/0.08, marker='o', label='MOF-303_ntu_1230')
# ax.set_xlabel('humidity (%RH)')
# ax.set_ylabel('water uptake (wt.%)')
# ax.legend(loc='center right')
# plt.xlim(0,100)
# plt.ylim(0,600)
# plt.savefig('MOF-303_ntu_1230 adsorption isotherm of water_cm3g-1.png', dpi=1000)
# plt.show()