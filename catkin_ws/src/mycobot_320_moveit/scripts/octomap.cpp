#include <math.h>
#include <queue>
#include <ratio>
#include <vector>
#include <deque>
struct PointCloud{
    float x;
    float y;
    float z;
};
const int DIMENSION=3;
struct TreeNode{
    TreeNode* parent;
    TreeNode* children[1<<DIMENSION];
    std::vector<PointCloud> points;
    float split_boundry[2*DIMENSION];
    float node_boundry[2*DIMENSION];
    int depth;
};
struct OcTree{
    TreeNode* root;
    int depth;

    void push(PointCloud point){
        TreeNode* now = root;
        std::deque<TreeNode*> deque = {now};
        while (!deque.empty()){
            int depth = now->depth;
        }
    }
};