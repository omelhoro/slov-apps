import pandas as pd
import json
df=pd.read_csv("../vocAppOr.csv")
drop_notrans=lambda x: x[x.translate!="0"]
edited_df=drop_notrans(df).drop_duplicates("nativeWord")
edited_df.to_csv("../vocAppPro.csv")
dump_tojson=lambda x: json.dumps(map(lambda x: dict(x[1]),x.iterrows()),indent=1)
with open("../vocApp.json","w+")  as f:
    f.write(dump_tojson(edited_df.fillna("-")))
    c_trainer_csv.py
    
