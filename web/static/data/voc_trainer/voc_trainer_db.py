#encoding=utf8
import pandas as pd
import os
import json
import re

POSLABELS = {
  "noun": "Nomen",
  "verb": "Verb",
  "adj": "Adjektiv/Adverb",
  "prep": "Präpositionen",
  "pron": "Pronomen",
  "mix": "Gemischt",
}

repls={ 
"substantiv":"noun",
"verb":"verb",
"adverb":"adj",
"adjektiv":"adj",
"pronom":"pron",
"präposition":"prep"
}

def rename_pos(word):
    word=word.lower()
    res=[repls[re.search(pat,word).group(0)] for pat in repls if re.search(pat,word)]
    return res[0] if res else "mix"

#os.chdir("/home/igor/Documents/eclipse/Misc_Web/apps/voc_trainer")
path="./vocab/"
vocab_df=pd.DataFrame()
vocab_df=list()
for fl in filter( lambda x:  x.endswith(".txt"),os.listdir(path)):
    df=pd.read_csv(path+fl,sep="\t",names=["foreignWord","pos","gen","nativeWord"])
    df["les"]=fl[3:-4]
    vocab_df.append(df)

vocab_df=pd.concat(vocab_df,axis=0,ignore_index=True)
vocab_df=vocab_df[-(vocab_df["pos"].isnull())]#.dropna()

vocab_df["foreignWord"]=vocab_df["foreignWord"].str.replace(" $", "")
vocab_df=vocab_df.drop_duplicates(cols="foreignWord")
vocab_df["fullpos"]=vocab_df["pos"] #rename the specific tags to more general
vocab_df["pos"]=vocab_df["pos"].map(rename_pos)
les_dct={}
print(vocab_df["pos"].unique())
print(vocab_df["pos"].value_counts())
vocab_df["pos_freq"]=vocab_df["pos"].groupby(vocab_df["pos"]).transform(len)

vocab_df=vocab_df.fillna("-")
print(vocab_df.head(100))
pos_freq=vocab_df["pos"].value_counts()
df_lit5=vocab_df[vocab_df["pos_freq"]<5]


les_js=json.dumps(map(lambda x: dict(x[1]),vocab_df.iterrows()),indent=1)


with open("../vocApp.json","w+")  as f:
    f.write(les_js)


vocab_df["pos"].value_counts()
