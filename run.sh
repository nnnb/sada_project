#!/usr/bin/env python
# coding: utf-8


# Importing and installig packages
pip install pandas
pip install numpy
#pip install natsort
import numpy as np
import pandas as pd
#from natsort import index_natsorted


# Uploading data from github
url = (r'https://gist.githubusercontent.com/bobbae/b4eec5b5cb0263e7e3e63a6806d045f2/raw/279b794a834a62dc108fc843a72c94c49361b501/data.csv')
data_original = pd.read_csv(url)
data_original.head()


# Renaming the last two columns
data_original.rename(columns={'Revenue (in millions)':'Revenue', 'Profit (in millions)':'Profit'}, inplace=True)
data_original.columns


# Counting the number of rows
row_count = len(data_original)
row_count

# ## The results above shows that there are 25500 rows in the CSV data.


# Producing CSV file that contains the total row count for he CSV data
a = pd.Series(['25500'])
a.reset_index()
a.to_csv('row_count.csv',index = False, header=False)



# checking for data types and counting rows
data_original.info()


# Displacing the non-numeric rows in boolean format
df_profit_numeric = data_original['Profit'].apply(lambda x: not x.isnumeric())
df_profit_numeric.head(5)


# Making Profit a dataframe
df_profit_numeric =df_profit_numeric.to_frame()
df_profit_numeric.head()



# Renaming the column
df_profit_numeric.rename(columns={'Profit':'Profit_data_type'}, inplace=True)
df_profit_numeric.columns


# Counting the non-numeric rows in For Profit column
df_profit_numeric.value_counts()



# Joining the profit column(boolean) and the original data
frames = [df_profit_numeric, data_original]
joined_df = pd.concat(frames, axis=1)
#joined_df.rename(columns={[0], 'Profit_data_type'}, inplace=True)
joined_df.head()


# Joining the df_profit_numeric data and the original data
frames = [df_profit_numeric, data_original]
joined_df = pd.concat(frames, axis=1)
joined_df.head()



# Deleting non-numeric rows for Profit column
df_clean = joined_df[joined_df.Profit_data_type != True]
df_clean.head()


# Deleting the Profit_data_type column
df_clean.drop('Profit_data_type', axis=1, inplace=True)
df_clean.head()


# reseting the unsorted index
df_clean.reset_index(drop=True, inplace=True)
df_clean.head()


df_clean.info()


# ## The results above shows that there are 4976 rows left in the data frame 


# Producing CSV data without non-numeric row for Profit 
df_clean.to_csv("numeric_rows.csv")


# ## Part 2

# counting rows for each column
df_clean.info()


# turning the CSV file into a JSON file
df_clean.to_json("data2.json")


# Sorting the highest Profit
top_profit = df_clean.sort_values(by="Profit", key=lambda x: np.argsort(index_natsorted(df_clean["Profit"])) )


# Sorting and Printing the top 20 highest Profit
top20_profit = top_profit.tail(20)
top20_profit


# ### The above dataframe (top20_profit) shows the first 20 highest profit 


# Producing CSV data top 20 rows with the highest profit value
top20_profit.to_csv("top20_profit.csv")

