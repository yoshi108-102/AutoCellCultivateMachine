#include "ros/console.h"
#include "ros/node_handle.h"
int main(int argc,char ** argv){
    ros::init(argc,argv,"dish_grasp");
    ros::NodeHandle nh;

    ROS_INFO("cobotta_moveit: dish_grasp node has started.");

}