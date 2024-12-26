import os

import matplotlib.pyplot as plt
import roslib.packages
import yaml

PKG_PATH = roslib.packages.get_pkg_dir("experiment")
def main():
    data = os.path.join(PKG_PATH,"analysis","experiment2_dish.yaml")
    real = os.path.join(PKG_PATH,"analysis","experiment2_real_data.yaml")
    with open(data,'r') as f:
        data = yaml.safe_load(f)
    with open(real,'r') as f:
        real = yaml.safe_load(f)
    distance = [50,100,150,200,250]
    angles = [15,30,45,60,75,90,105,120,135,150]
    base = real["base"]["points"]
    plt.scatter(0,0,color="black")
    diffs = list()
    base = [x/100 for x in base]
    for dist in distance:
        diff_dist = 0
        cnt = 0
        for angle in angles:
            try:
                data_points = data[dist][angle]["points"]
                data_points_ave = [0.0,0.0,0.0]
                for i in data_points:
                    data_points_ave[0] += i[0]
                    data_points_ave[1] += i[1]
                    data_points_ave[2] += i[2]
                data_points_ave = [x/len(data_points) for x in data_points_ave]
                if data_points_ave[1] < -1:
                    continue
                data_points = data_points_ave
                real_points = real[dist][angle]["points"]
                real_points = [x/100 for x in real_points]
                """ plt.scatter(-data_points[0],-data_points[1],color="blue")
                plt.scatter(real_points[0] - base[0],real_points[1] - base[1],color="red") """
                print("data:",data_points)
                print("real:",[real_points[i] - base[i] for i in range(3)])
                data_points[0] = -data_points[0]
                data_points[1] = -data_points[1]
                diff_angle = [(data_points[i] - (real_points[i] - base[i]))**2 for i in range(3)]
                print(diff_angle)
                diff = sum(diff_angle)**0.5
                diff_dist += diff
                cnt += 1
            except Exception as e:
                print(e)
                continue
        diffs.append(diff_dist/cnt)
    plt.plot(distance,diffs)
    plt.xlabel("dist")
    plt.ylabel("average diff")
    plt.title("mapping of dish pose")
    plt.savefig(os.path.join(PKG_PATH,"analysis","experiment2_dish.png"))
if __name__ == "__main__":
    main()