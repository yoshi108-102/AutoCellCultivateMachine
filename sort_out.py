import glob
import os
import random

dataset_dir = "./datasets"

img_list = glob.glob(os.path.join(dataset_dir+"/annotation", "*.txt"))
random.shuffle(img_list)

# 80% for training, 10% for validation, 10% for testing

num_data = len(img_list)
num_train = int(num_data * 0.8)
num_val = int(num_data * 0.1)
num_test = num_data - num_train - num_val

split_dict = {}
split_dict["train"] = img_list[:num_train]
split_dict["val"] = img_list[num_train:num_train+num_val]
split_dict["test"] = img_list[num_train+num_val:]

for name in ["train", "val", "test"]:
    # create folder
    if not os.path.exists(os.path.join(dataset_dir, name)):
        os.makedirs(os.path.join(dataset_dir, name))
    else:
        os.system("rm -rf {}".format(os.path.join(dataset_dir, name)))
        os.makedirs(os.path.join(dataset_dir, name))
    for folder in ["images", "labels"]:
        dir_path = os.path.join(dataset_dir, name, folder)
        if not os.path.exists(dir_path):
            os.makedirs(dir_path)
        for path in split_dict[name]:
            txt_path = path
            img_path = txt_path.replace("annotation", "original_data").replace("txt", "png")
            if os.path.basename(txt_path) == "classes.txt":
                continue
            if os.path.exists(img_path) or os.path.exists(txt_path):
                pass
            if folder == "images":
                os.system("cp {} {}".format(img_path, os.path.join(dir_path, os.path.basename(img_path))))
            else:
                os.system("cp {} {}".format(txt_path, os.path.join(dir_path, os.path.basename(txt_path))))
print("Done!")
            
        