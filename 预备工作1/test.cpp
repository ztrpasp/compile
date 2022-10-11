#define pi 3.14 //pi的大小
#include<iostream>
#include<math.h>
using namespace std;
float cal_area(float r) //计算圆的面积
{
    return pi*pow(r,2);
}

float cal_perimeter(float r) //计算圆的周长
{
    return 2*pi*r;
}

int main()
{
    int n;
    cin>>n;
    int i = 1;
    while(i<=n)
    {
        float area;
        area = cal_area(i);
        cout<<area<<endl;
    }
    return 0;
}