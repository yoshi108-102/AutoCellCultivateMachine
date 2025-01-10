import os

import matplotlib.pyplot as plt
import roslib.packages
import yaml

PKG_PATH = roslib.packages.get_pkg_dir("experiment")


def main():
    target = os.path.join(PKG_PATH, "analysis", "experiment2_real_data.yaml")
    with open(target, "r") as f:
        data = yaml.safe_load(f)
    xData = list()
    yData = list()
    pixels = [50, 100, 150, 200, 250]
    angles = [15, 30, 45, 60, 75, 90, 105, 120, 135, 150]
    base_point = data["base"]["points"]
    xData.append(base_point[0])
    yData.append(base_point[1])
    for pixel in pixels:
        for angle in angles:
            try:
                points = data[pixel][angle]["points"]
                (x, y, z) = (points[0], points[1], points[2])
                xData.append(x)
                yData.append(y)
            except Exception as e:
                continue
    plt.scatter(xData, yData)
    plt.xlabel("x")
    plt.ylabel("y")
    plt.title("mapping of pipette pose")
    plt.savefig(os.path.join(PKG_PATH, "analysis", "experiment2_real_data.png"))


if __name__ == "__main__":
    main()
