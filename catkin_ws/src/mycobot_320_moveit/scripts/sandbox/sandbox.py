import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

# サンプルデータを生成
data1 = np.random.rand(10, 10)
data2 = np.random.rand(10, 10)

# ヒートマップを描画
plt.figure(figsize=(10, 8))

# 最初のヒートマップ
sns.heatmap(data1, cmap="Blues", alpha=0.5, cbar=False)

# 二つ目のヒートマップ
sns.heatmap(data2, cmap="Reds", alpha=0.5, cbar=False)

# データポイントをプロットし、点線でつなぐ
for i in range(data1.shape[0]):
    for j in range(data1.shape[1]):
        plt.plot([j, j], [i, i], "o", color="black")
        plt.plot([j, j], [i, i], "o", color="black")
        if i < data1.shape[0] - 1:
            plt.plot([j, j], [i, i + 1], linestyle=":", color="black")
        if j < data1.shape[1] - 1:
            plt.plot([j, j + 1], [i, i], linestyle=":", color="black")

plt.show()
