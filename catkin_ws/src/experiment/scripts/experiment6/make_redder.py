import cv2
def make_redder(img,xmin,ymin,xmax,ymax,color):
    overlay = img.copy()
    cv2.rectangle(overlay, (xmin, ymin), (xmax, ymax), color, -1)
    alpha = 0.3
    cv2.addWeighted(overlay, alpha, img, 1 - alpha, 0, img)
    return img
def main():
    img = cv2.imread("experiment6_status.png")
    size = 160
    for i in range(640//size):
        for j in range(480//size):
            if i == 2 and j == 0:
                color = (0,0,255)
                center = (i*size + size//2,j*size + size//2)
                img = make_redder(
                    img,
                    i*size,
                    j*size,
                    (i+1)*size,
                    (j+1)*size,
                    color
                )
                cv2.putText(
                    img,
                    "A",
                    (center[0]-5,center[1]+5),
                    cv2.FONT_HERSHEY_SIMPLEX,
                    1,
                    (0,0,0),
                    thickness=3
                )
            if i == 2 and j == 1:
                color = (255,255,0)
                center = (i*size + size//2,j*size + size//2)
                img = make_redder(
                    img,
                    i*size,
                    j*size,
                    (i+1)*size,
                    (j+1)*size,
                    color
                )
                cv2.putText(
                    img,
                    "B",
                    (center[0]-5,center[1]+5),
                    cv2.FONT_HERSHEY_SIMPLEX,
                    1,
                    (0,0,0),
                    thickness=3
                )
            if i == 1 and j == 1:
                color = (0,255,255)
                center = (i*size + size//2,j*size + size//2)
                img = make_redder(
                    img,
                    i*size,
                    j*size,
                    (i+1)*size,
                    (j+1)*size,
                    color
                )
                cv2.putText(
                    img,
                    "C",
                    (center[0]-5,center[1]+5),
                    cv2.FONT_HERSHEY_SIMPLEX,
                    1,
                    (0,0,0),
                    thickness=3
                )
    cv2.imwrite(img=img,filename="experiment6_status_red.png")
if __name__ == "__main__":
    main()