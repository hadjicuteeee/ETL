import pandas as pd

#EXTRACT
df = pd.read_csv("C:\\Users\\apues\\Downloads\\archive (30)\\psp.csv")

def transform_data(df):
    df.drop('metacritic', axis=1, inplace=True)

    df['genres'] = df['genres'].replace(r'^\s*$', 'No Data', regex=True).fillna('No Data')

    df['ratings_count'] = pd.to_numeric(df['ratings_count'], errors='coerce').fillna(0)
    df['rating'] = pd.to_numeric(df['rating'], errors='coerce').fillna(0)

    # cleaning last update column
    df['Last Update'] = (
        df['Last Update']
        .astype('string')
        .str.strip()
        .replace('', pd.NA)
        .pipe(pd.to_datetime, errors='coerce')
        .astype('string')
        .fillna('No Date')
    )

    # cleaning platforms column
    df['platforms'] = (df['platforms']
                       .replace(r'^\s*$', pd.NA, regex=True)
                       .fillna('Unknown')
                       .str.strip()
                       .str.title())
    print(df['platforms'].head(10))

    num_duplicates = df.duplicated().sum()
    df.drop_duplicates(inplace=True)
    print(num_duplicates)

    
    df.columns = [c.strip().lower().replace(' ', '_') for c in df.columns]

    df.to_csv("C:\\Users\\apues\\Downloads\\psp.cleaned.csv", index=False, na_rep='')

    return df




