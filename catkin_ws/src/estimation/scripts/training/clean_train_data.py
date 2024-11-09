#! /usr/bin/env python3
import os
import random
import roslib.packages

root_dir = "./datasets"

# os.system("rm -rf {}".format(os.path.join(root_dir, "original_data")))
os.system("rm -rf {}".format(os.path.join(root_dir, "annotation")))

# os.makedirs(os.path.join(root_dir, "original_data"))
os.makedirs(os.path.join(root_dir, "annotation"))

print("Done!")
