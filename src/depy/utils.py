"""Helper to annotate DEA results with 'Up', 'Down', 'ns' for volcano_plot method"""
import pandas as pd
import numpy as np

def _annotate_features_reg(res):
    res = res.copy()
    up = ((res["adj_p_val"] < 0.05) & (res["logfc"] > 0))
    down = ((res["adj_p_val"] < 0.05) & (res["logfc"] < 0))
    res["reg"] = np.select([up, down], ["Up", "Down"], "ns")
    res["reg"] = pd.Categorical(res["reg"], categories=["Up", "Down", "ns"], ordered=True)

    return res

def clean_names(df: pd.DataFrame) -> pd.DataFrame:
    chars = ["[", "(", ")", "$", "@", "/", ",", "%", "+", "?", "!", "]"]
    chars = "".join(chars)
    old_cols = df.columns
    new_cols = (old_cols
                .str.strip()
                .str.lower()
                .str.replace(r"\s", "_", regex=True)
                .str.replace(chars, "", regex=True)
                .str.replace("[", "", regex=False)
                .str.replace("]", "", regex=False)
                .str.replace("-", "_", regex=False)
                .str.replace(".", "_", regex=False)
                .str.replace("_+", "_", regex=True)
                .str.replace(r"^_+|_+$", "", regex=True)
                )

    mapper = dict(zip(list(old_cols), list(new_cols)))

    return df.rename(axis="columns", mapper=mapper)
