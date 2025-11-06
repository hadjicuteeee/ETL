from extractpsp import extract_data
from psp import transform_data
from pspload import load_data

def etl_pipeline():
    df_raw = extract_data("C:\\Users\\apues\\Downloads\\archive (30)\\psp.csv")
    df_cleaned = transform_data(df_raw)
    load_data(df_cleaned, 'psp.cleaned')
    print("Success")

if __name__ == "__main__":
    etl_pipeline()