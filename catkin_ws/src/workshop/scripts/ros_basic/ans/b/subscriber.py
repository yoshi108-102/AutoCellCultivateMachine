import rospy
from std_msgs.msg import Int32MultiArray
from std_msgs.msg import String

now_operator = "+"

def num_data_cb(data):
    global now_operator
    x = data.data[0]
    y = data.data[1]
    
    if now_operator == "+":
        result = x + y
        print(f"{x} + {y} = {result}")
    elif now_operator == "-":
        result = x - y
        print(f"{x} - {y} = {result}")
    elif now_operator == "*":
        result = x * y
        print(f"{x} * {y} = {result}")
    elif now_operator == "/":
        result = x / y
        print(f"{x} / {y} = {result}")
    elif now_operator == "%":
        result = x % y
        print(f"{x} % {y} = {result}")

def operator_cb(data):
    global now_operator
    
    candidate = ["+", "-", "*", "/", "%"]
    if data.data in candidate:
        now_operator = data.data
    else:
        print(f"Unknown operator: {data.data}. Using {now_operator}.")
    

def main():
    rospy.init_node('subscriber', anonymous=True)
    
    # Subscribe to num_data_topic
    rospy.Subscriber("num_data_topic", Int32MultiArray, num_data_cb)
    
    # Subscribe to operator topic
    rospy.Subscriber("operator_topic", String, operator_cb)
    
    rospy.spin()

if __name__ == '__main__':
    main()