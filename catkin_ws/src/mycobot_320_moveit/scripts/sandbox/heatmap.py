import math

import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D

# 点の座標を定義
x = [-2, 0, 2] * 9
y = ([16.5] * 3 + [18.5] * 3 + [20.5] * 3) * 3
z = [4] * 9 + [6] * 9 + [8] * 9
# x,y,zを一次元に
x = np.array(x).flatten()
y = np.array(y).flatten()
z = np.array(z).flatten()
# 例として、ランダムな誤差を生成
lens1 = [
    0.15929999947547913,
    0.16519999504089355,
    0.16269999742507935,
    0.1841999888420105,
    0.18439999222755432,
    0.18490000069141388,
    0.1996999979019165,
    0.20089998841285706,
    0.20349998772144318,
]
lens2 = [
    0.15839999914169312,
    0.16659998893737793,
    0.16749998927116394,
    0.18469999730587006,
    0.18439999222755432,
    0.18529999256134033,
    0.2110999971628189,
    0.20469999313354492,
    0.20679999887943268,
]
lens3 = [
    0.16409999132156372,
    0.16449999809265137,
    0.16749998927116394,
    0.1882999986410141,
    0.18439999222755432,
    0.1859000027179718,
    0.2076999992132187,
    0.2061999887228012,
    0.20889998972415924,
]
lens4 = [
    0.1655000001192093,
    0.1655000001192093,
    0.1639000028371811,
    0.1859000027179718,
    0.18379999697208405,
    0.1859000027179718,
    0.2044999897480011,
    0.20409999787807465,
    0.20520000159740448,
]
lens5 = [
    0.16409999132156372,
    0.1664000004529953,
    0.16359999775886536,
    0.1826999932527542,
    0.18439999222755432,
    0.1850000023841858,
    0.20430000126361847,
    0.20430000126361847,
    0.202799990773201,
]
lens6 = [
    0.16359999775886536,
    0.16329999268054962,
    0.16579999029636383,
    0.18410000205039978,
    0.18359999358654022,
    0.18809999525547028,
    0.202799990773201,
    0.202799990773201,
    0.20389999449253082,
]
lens7 = [
    0.16259999573230743,
    0.1631999909877777,
    0.16269999742507935,
    0.1832999885082245,
    0.18379999697208405,
    0.18289999663829803,
    0.2044999897480011,
    0.20430000126361847,
    0.203699991106987,
]
lens8 = [
    0.16409999132156372,
    0.16409999132156372,
    0.16300000250339508,
    0.18359999358654022,
    0.1826999932527542,
    0.18289999663829803,
    0.20349998772144318,
    0.20389999449253082,
    0.20349998772144318,
]
lens9 = [
    0.16380000114440918,
    0.16380000114440918,
    0.16409999132156372,
    0.18439999222755432,
    0.18469999730587006,
    0.18519999086856842,
    0.20389999449253082,
    0.20389999449253082,
    0.20329999923706055,
]
lens_ave1 = [(lens1[i] + lens2[i] + lens3[i]) * 100 / 3 for i in range(9)]
lens_ave2 = [(lens4[i] + lens5[i] + lens6[i]) * 100 / 3 for i in range(9)]
len_ave3 = [(lens7[i] + lens8[i] + lens9[i]) * 100 / 3 for i in range(9)]
lens_ave = lens_ave1 + lens_ave2 + len_ave3
print(lens_ave)
print(y)
errors = [abs(lens_ave[i] - y[i]) for i in range(27)]
print(errors)
fig = plt.figure()
ax = fig.add_subplot(111, projection="3d")

# カラーマップを使用して誤差を色としてプロット
sc = ax.scatter(x, y, z, c=errors, cmap="Dark2", vmin=0, vmax=1, s=100)

# カラーバーを追加
cbar = plt.colorbar(sc)
cbar.set_label("Error(cm)")

# ラベルを設定
ax.set_xlabel("X(cm)")
ax.set_ylabel("Z(cm)")
ax.set_zlabel("Y(cm)")

# 各点をx水平に点線で結ぶ
for j in range(3):
    for i in range(9):
        if i % 3 != 2:
            ax.plot(
                [x[i + 9 * j], x[i + 1 + 9 * j]],
                [y[i + 9 * j], y[i + 1 + 9 * j]],
                [z[i + 9 * j]],
                linestyle=":",
                color="gray",
            )
        try:
            ax.plot(
                [x[i + 9 * j], x[i + 3 + 9 * j]],
                [y[i + 9 * j], y[i + 3 + 9 * j]],
                [z[i + 9 * j]],
                linestyle=":",
                color="gray",
            )
        except:
            pass
plt.show()
