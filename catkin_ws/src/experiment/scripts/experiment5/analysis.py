import math
import os

import roslib.packages
import yaml

pkg_path = roslib.packages.get_pkg_dir("experiment")
import matplotlib.pyplot as plt


def main():
    dataset_path = os.path.join(pkg_path,"dataset","experiment5","annotation")
    yaml_path = os.path.join(pkg_path,"analysis","experiment5","speed.yaml")
    with open(yaml_path,'r') as f:
        time_data = yaml.safe_load(f)
    f.close()
    yaml_path = yaml_path.replace("speed","result")
    with open(yaml_path,'r') as f:
        result_data = yaml.safe_load(f)
    f.close()
    print(time_data)
    print(result_data)
    dista_data = {
        "mycobot":[],
        "cobotta":[]
    }
    speed_data = {
        "mycobot":[0 for _ in range(20)],
        "cobotta":[0 for _ in range(19)]
    }
    for _,_,files in os.walk(dataset_path):
        for file in files:
            if file == "classes.txt":
                continue
            if "finish" in file:
                continue
            cnt = -1
            for i in range(len(file)):
                for j in range(len(file),i,-1):
                    if file[i:j].isdigit():
                        cnt = int(file[i:j])
                        break
                if cnt != -1:
                    break
            start_data = file
            finish_data = file.replace("start","finish").replace(f"{cnt}",f"{cnt+1}")
            with open(os.path.join(dataset_path,start_data),'r') as f:
                _,sx,sy,_,_ = f.read().split(' ')
                sx,sy = float(sx),float(sy)
                sx,sy = int(sx*640),int(sy*480)
            f.close()
            with open(os.path.join(dataset_path,finish_data),'r') as f:
                _,fx,fy,_,_ = f.read().split(' ')
                fx,fy = float(fx),float(fy)
                fx,fy = int(fx*640),int(fy*480)
            f.close()
            print((sx,sy,fx,fy))
            dist = math.sqrt((sx - fx)**2 + (sy - fy) ** 2)
            print(dist)
            id = cnt % 20
            if "mycobot" in start_data:
                speed_data["mycobot"][id] = dist / time_data["mycobot"][id]
            else:
                if id == 19:
                    continue
                else:
                    speed_data["cobotta"][id] = dist / time_data["cobotta"][id]
    print(speed_data)
    print(result_data)
    plt.scatter([i for i in range(20)],speed_data["mycobot"])
    plt.show()
if __name__ == "__main__":
    main()