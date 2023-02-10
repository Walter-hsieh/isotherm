import pandas as pd


df = pd.read_excel("dropna.xlsx")

df_dropped = df.dropna()

df_dropped.to_excel("result.xlsx", index=False)