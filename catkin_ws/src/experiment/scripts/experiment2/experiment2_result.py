import os

import matplotlib.pyplot as plt
import roslib.packages
import yaml

PKG_PATH = roslib.packages.get_pkg_dir("experiment")


def main():
    print("start")
    data = os.path.join(PKG_PATH, "analysis", "experiment2_2_pipette.yaml")
    real = os.path.join(PKG_PATH, "analysis", "experiment2_real_data.yaml")
    with open(data, "r") as f:
        data = yaml.safe_load(f)
    with open(real, "r") as f:
        real = yaml.safe_load(f)
    distance = [50, 100, 150, 200]
    angles = [15, 30, 45, 60, 75, 90, 105, 120, 135, 150]
    excepts = [(50, 15), (50, 30), (200, 75), (200, 90), (200, 105)]
    diffs = list()
    for dist in distance:
        diff_dist = 0
        cnt = 0
        for angle in angles:
            if (dist, angle) in excepts:
                continue
            try:
                data_points = data[dist][angle]["points"]
                data_points_ave = [0.0, 0.0, 0.0]
                for i in data_points:
                    data_points_ave[0] += i[0]
                    data_points_ave[1] += i[1]
                    data_points_ave[2] += i[2]
                data_points_ave = [x / len(data_points) for x in data_points_ave]
                print(data_points_ave)
                data_z = data_points_ave[2]
                real_z = (63.2 - 23.5) / 100
                diff = abs(data_z - real_z)
                print(data_z, real_z, diff)
                diff_dist += diff
                cnt += 1
            except Exception as e:
                continue
        diff_dist = diff_dist / cnt
        diffs.append(diff_dist)
    print(diffs)
    plt.plot(distance,diffs)
    plt.xlabel("z diff (mm)")
    plt.ylabel("average diff")
    plt.title("piette z diff between real and detected")
    plt.savefig(os.path.join(PKG_PATH, "experiment2_z_diff_pipette.png"))

def main2():
    x = [50, 100, 150, 200]
    y = [0.00856248128414152, 0.047391980767250035, 0.07249197828769682, 0.10251712744576587]
    plt.plot(x, y)
    plt.xlabel("distance from camera center (mm)")
    plt.ylabel("average diff")
    plt.title("piette z diff between real and detected")
    plt.savefig(os.path.join(PKG_PATH, "experiment2_z_diff_pipette.png"))
if __name__ == "__main__":
    main2()
