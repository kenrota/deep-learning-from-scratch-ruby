import pickle
import json

with open("sample_weight.pkl", "rb") as f:
    weight = pickle.load(f)

weight_dict = {}

for k, v in weight.items():
    weight_dict[k] = v.flatten().tolist()

with open("sample_weight.json", "w") as f:
    json.dump(weight_dict, f)
