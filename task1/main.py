import pandas
# RULES section - 'i["<COLUMN_NAME>"] <OPERATOR> <VALUE>'
RULES = ['i["Sex"] != "M"', 'i["Weight (lbs)"] > 1', 'i["Height (in)"] > 1',]


# Function transforming RULES into required format for list comprehension
def conditions():
    c_list = ""
    for i in RULES:
        c_list += f"{i} and "
    c_list = c_list[:-4]
    return c_list


# Load file
data = pandas.read_csv("biostats.csv")
# Transform dataframe to required format
data_dict = data.to_dict(orient="records")
# Create new list with list comprehension
new_data = [i for i in data_dict if eval(conditions())]
# Create output dataframe
final = pandas.DataFrame(new_data)
# Transform dataframe to csv format and create a new file so we can keep the old one in case we need to go back to it
# if we want to rewrite the old file we just use the same name for both initial input file and final output file
final.to_csv("final_output.csv")
