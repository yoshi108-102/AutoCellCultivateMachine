import matplotlib.pyplot as plt 
import numpy as np
def main():
    #棒グラフ
    x = ["myCobot","COBOTTA"]
    y = [11/19,14/19]
    #色は青とオレンジ
    plt.bar(x,y,width=0.3,color=np.array([[0,0,1],[1,0.5,0]]))
    plt.title("success rate")
    plt.xlabel("robot arm")
    plt.ylabel("success rate")
    plt.savefig("success_rate.png")
if __name__ == "__main__":
    main()