import pandas as pd
import matplotlib.pyplot as plt


df = pd.read_excel("dataset.xlsx")

fig, ax1 = plt.subplots()

color='tab:red'
ax1.scatter(x=df['time_s']/3600, y=df['hpv'], color=color, s=5)
ax1.set_xlabel('time (hr)', color=color)
ax1.set_ylabel('humidity (%RH)')
ax1.tick_params(axis='y', labelcolor=color)


ax2 =ax1.twinx()
color='tab:blue'
ax2.scatter(x=df['time_s']/3600, y=df['uptake']*100, color=color, s=5)
ax2.set_ylabel('water uptake (wt.%)')
ax2.tick_params(axis='y', labelcolor=color)
ax2.set_title('Al2O3 Adsorption Isotherm 20230115-T12')

# plt.savefig('plot.png', dpi=2000)

# plt.savefig('plot.pdf')

# plt.show()



# save high resolution picture
def pdf2image():
    from pdf2image import convert_from_path
    images = convert_from_path("data_processing.pdf",dpi=1000, poppler_path=r'C:\Program Files\poppler-22.12.0\Library\bin')
    for i, image in enumerate(images):
        fname = 'image'+str(i)+'.png'
        image.save(fname, "PNG")

pdf2image()

# keywords: pdf2image, poppler not in the path
url = 'https://github.com/Belval/pdf2image'





'''
#---------------sample code--------------------------
# import libraries
import numpy as np
import matplotlib.pyplot as plt

# Creating dataset
x = np.arange(1.0, 100.0, 0.191)
dataset_1 = np.exp(x**0.25) - np.exp(x**0.5)
dataset_2 = np.sin(0.4 * np.pi * x**0.5) + np.cos(0.8 * np.pi * x**0.25)

# Creating plot with dataset_1
fig, ax1 = plt.subplots()

color = 'tab:red'
ax1.set_xlabel('X-axis')
ax1.set_ylabel('Y1-axis', color = color)
ax1.plot(x, dataset_1, color = color)
ax1.tick_params(axis ='y', labelcolor = color)

# Adding Twin Axes to plot using dataset_2
ax2 = ax1.twinx()

color = 'tab:green'
ax2.set_ylabel('Y2-axis', color = color)
ax2.plot(x, dataset_2, color = color)
ax2.tick_params(axis ='y', labelcolor = color)

# Adding title
plt.title('Use different y-axes on the left and right of a Matplotlib plot', fontweight ="bold")

# Show plot
plt.show()
'''
