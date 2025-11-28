from sqlalchemy import create_engine

def load_data(df):
    engine = create_engine("postgresql+psycopg2://username:password@localhost:5432/project1")
    df.to_sql('psp', con=engine, if_exists='replace', index=False)

    
    print("Success")
