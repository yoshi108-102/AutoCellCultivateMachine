#!/usr/bin/env python3
import os

import cv2
import numpy as np
import roslib.packages
import rospy

pkg_path = roslib.packages.get_pkg_dir("experiment")


class UnionFind:
    def __init__(self, n):
        self.parent = [i for i in range(n)]
        self.rank = [n] * n
        self.size = [1] * n

    def find(self, x):
        if self.parent[x] == x:
            return x
        else:
            self.parent[x] = self.find(self.parent[x])
            return self.parent[x]

    def enqiv(self, x, y):
        return self.find(x) == self.find(y)

    def union(self, x, y):
        rx = self.find(x)
        ry = self.find(y)
        if rx == ry:
            return
        rank_x = self.rank[rx]
        rank_y = self.rank[ry]
        if rank_x <= rank_y:
            self.rank[rx] = ry
            self.parent[rx] = ry
            self.size[ry] += self.size[rx]
            if rank_x == rank_y:
                self.rank[ry] += 1
        else:
            self.rank[ry] = rx
            self.parent[ry] = rx
            self.size[rx] += self.size[ry]

    def get_size(self, x):
        rx = self.find(x)
        return self.size[rx]
def filter(image):
    w,h = 640,480
    img = image
    uf = UnionFind(w*h)
    for i in range(w):
        for j in range(h):
            target = i*480 + j
            dx = [0,0,1,-1]
            dy = [1,-1,0,0]
            for k in range(4):
                nx = i + dx[k]
                ny = j + dy[k]
                if nx < 0 or nx >= 640 or ny < 0 or ny >= 480:
                    continue
                if np.array_equal(img[j][i] ,[0,0,0]) or np.array_equal(img[ny][nx],[0,0,0]):
                    continue
                else:
                    uf.union(i*480+j,nx*480+ny)
    max_size,max_id = max([(uf.get_size(x),uf.find(x)) for x in range(640*480)])
    print(max_size)
    for i in range(w):
        for j in range(h):
            if uf.find(i*480+j) != max_id:
                img[j][i] = [0,0,0]
    return img
def main():
    target = os.path.join(pkg_path,"dataset","experiment4","real_hand")
    save_path = os.path.join(pkg_path,"dataset","experiment4","filtered_hand")
    if not os.path.exists(save_path):
        os.makedirs(save_path)
    img_files = []
    for cur,dirs,files in os.walk(target):
        print((cur,dirs,files))
        if len(dirs) == 0:
            for file in files:
                img_files.append(os.path.join(cur,file))
    for file in img_files:
        print(file)
        target_image = cv2.imread(file)
        filtered = filter(target_image)
        save_file_path = file.replace("real_hand","filtered_hand")
        if not os.path.exists(os.path.dirname(save_file_path)):
            os.makedirs(os.path.dirname(save_file_path))
        cv2.imwrite(save_file_path,filtered)
if __name__ == "__main__":
    main()