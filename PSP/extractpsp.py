import pandas as pd
def extract_data(path):
    df = pd.read_csv(path)
    print("Success")
    return df


df_raw = extract_data("C:\\Users\\apues\\Downloads\\archive (30)\\psp.csv")