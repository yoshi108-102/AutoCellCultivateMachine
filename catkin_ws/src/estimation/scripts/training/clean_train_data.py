#! /usr/bin/env python3
import os
import random
import sys

import roslib.packages


def main(argv):

    try:
        dataset_type = argv[1]
    except IndexError:
        print("Please input dataset_type: pipette,dish or so")
        sys.exit(1)
    root_dir = f"./{dataset_type}_datasets"

    # os.system("rm -rf {}".format(os.path.join(root_dir, "original_data")))
    os.system("rm -rf {}".format(os.path.join(root_dir, "annotation")))

    # os.makedirs(os.path.join(root_dir, "original_data"))
    os.makedirs(os.path.join(root_dir, "annotation"))

    print("Done!")


if __name__ == "__main__":
    main(sys.argv)
