import matplotlib.pyplot as plt


def main():
    map50_data_all = [
        0.904,
        0.778,
        0.961,
        0.944,
        0.917
    ]
    map50_pipette = [
        0.826,
        0.565,
        0.938,
        0.914,
        0.855,
    ]
    map50_dish = [
        0.982,
        0.991,
        0.984,
        0.975,
        0.979,
    ]
    map5095_data_all = [
        0.445,
        0.426,
        0.482,
        0.469,
        0.481,
    ]
    map5095_pipette = [
        0.274,
        0.165,
        0.331,
        0.319,
        0.32
    ]
    map5095_dish = [
        0.617,
        0.687,
        0.633,
        0.619,
        0.642
    ]
    x = [200*(i+1) for i in range(5)]
    plt.rcParams["font.size"] = 26
    plt.plot(x, map5095_data_all, label="all",color="red")
    plt.plot(x, map5095_pipette, label="pipette",color="blue")
    plt.plot(x, map5095_dish, label="dish",color="green")
    plt.legend(bbox_to_anchor=(1, 1), loc='upper right', borderaxespad=0,fontsize=18)
    # x = 0, y = 0
    # 原点を (0, 0) に設定
    plt.axhline(y=0, color='black', linewidth=0.5)
    plt.title("mAP@50-95")
    plt.xlabel("train data size")
    plt.ylabel("mAP")
    plt.savefig("map50-95.png",
                bbox_inches="tight")
if __name__ == "__main__":
    main()