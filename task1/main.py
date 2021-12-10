import pandas

# SOLUTION 1

# Load file
data = pandas.read_csv("biostats.csv")
# Transform dataframe to required format
data_dict = data.to_dict(orient="records")
# Create new list with list comprehension where if statement works as our filter, can add multiple filters with
# and/or operators - filter out males therefore only females that weigh more than 1 pound will remain on the list
new_data = [i for i in data_dict if i["Sex"] != "M" and i["Weight (lbs)"] > 1]
# Create output dataframe
final = pandas.DataFrame(new_data)
# Transform dataframe to csv format and create a new file so we can keep the old one in case we need to go back to it
# if we want to rewrite the old file we just use the same name for both initial input file and final output file
final.to_csv("final_output.csv")

# SOLUTION 2 - same as SOLUTION 1 but instead of list comprehension using for loop

# # Load file
# data = pandas.read_csv("biostats.csv")
# # Transform dataframe to required format
# data_dict = data.to_dict(orient="records")
# # Create our empty output list that will be filled with data that passed the filters
# new_data = []
# # Iterate through the provided data
# for row in data_dict:
#     # Select the filters, can add multiple filters with and/or operators
#     if row["Sex"] != "M" and row["Weight (lbs)"] > 1:
#         # Add data that passed the filters to the output list
#         new_data.append(row)
# # Create output dataframe
# final = pandas.DataFrame(new_data)
# # Transform dataframe to csv format
# final.to_csv("final_output.csv")
