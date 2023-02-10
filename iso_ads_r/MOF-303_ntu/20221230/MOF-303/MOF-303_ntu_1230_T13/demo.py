import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_excel("dataset.xlsx")

print(df.columns)

# df.hist(bins=50, figsize=(20,15))
# plt.savefig("hist.png", dpi=500)
# plt.show()


from pandas.plotting import scatter_matrix

scatter_matrix(df, figsize=(12,8))
plt.savefig("scatter_matrix.png", dpi=500)
# plt.show()


