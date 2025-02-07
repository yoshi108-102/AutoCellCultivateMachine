import os
import roslib.packages
PKG_PATH = roslib.packages.get_pkg_dir("experiment")
def main():
    dish_dataset_path = os.path.join(PKG_PATH, "dataset", "experiment1", "experiment_dish_datasets", "original_data")
    pipette_dataset_path = os.path.join(PKG_PATH, "dataset", "experiment1", "experiment_pipette_datasets", "original_data")
    double_dataset_path = os.path.join(PKG_PATH, "dataset", "experiment1", "experiment_double_datasets")
    if not os.path.exists(double_dataset_path):
        os.makedirs(double_dataset_path)
    cnt = 0
    for cur,dirs,files in os.walk(pipette_dataset_path):
        for file in files:
            if file.endswith(".png"):
                img_data = os.path.join(cur, file)
                annotation_data = os.path.join(cur.replace("original_data","annotation"), file.replace(".png", ".txt"))
                new_img_data = os.path.join(double_dataset_path, "images", file)
                if not os.path.exists(os.path.dirname(new_img_data)):
                    os.makedirs(os.path.dirname(new_img_data))
                new_annotation_data = os.path.join(double_dataset_path, "labels", file.replace(".png", ".txt"))
                if not os.path.exists(os.path.dirname(new_annotation_data)):
                    os.makedirs(os.path.dirname(new_annotation_data))
                if not os.path.exists(annotation_data):
                    continue
                if not os.path.exists(os.path.dirname(new_annotation_data)):
                    os.makedirs(os.path.dirname(new_annotation_data))
                os.system(f"touch {new_img_data}")
                os.system(f"touch {new_annotation_data}")
                os.system(f"cp {img_data} {new_img_data}")
                os.system(f"cp {annotation_data} {new_annotation_data}")
                cnt += 1
                if cnt >= 100:
                    break
    cnt = 0
    for cur,dirs,files in os.walk(dish_dataset_path):
        for file in files:
            if file.endswith(".png"):
                img_data = os.path.join(cur, file)
                annotation_data = os.path.join(cur.replace("original_data","annotation"), file.replace(".png", ".txt"))
                if not os.path.exists(annotation_data):
                    continue
                print(annotation_data)
                with open(annotation_data, "r") as f:
                    label,xg,yg,w,h = f.readline().split(' ')
                label = "1"
                #上書き
                with open(annotation_data, "w") as f:
                    f.write(f"{label} {xg} {yg} {w} {h}")
                new_img_data = os.path.join(double_dataset_path, "images", file)
                if not os.path.exists(os.path.dirname(new_img_data)):
                    os.makedirs(os.path.dirname(new_img_data))
                new_annotation_data = os.path.join(double_dataset_path, "labels", file.replace(".png", ".txt"))
                if not os.path.exists(os.path.dirname(new_annotation_data)):
                    os.makedirs(os.path.dirname(new_annotation_data))
                if not os.path.exists(annotation_data):
                    continue
                if not os.path.exists(os.path.dirname(new_annotation_data)):
                    os.makedirs(os.path.dirname(new_annotation_data))
                os.system(f"touch {new_img_data}")
                os.system(f"touch {new_annotation_data}")
                os.system(f"cp {img_data} {new_img_data}")
                os.system(f"cp {annotation_data} {new_annotation_data}")
                cnt += 1
                if cnt >= 100:
                    break
    
if __name__ == "__main__":
    main()