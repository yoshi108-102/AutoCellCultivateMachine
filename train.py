from ultralytics import YOLO

model = YOLO("yolov8n.pt")
model.train(data="./datasets/data.yaml", epochs=100)
metrics = model.val()
