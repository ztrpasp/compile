#include<stdio.h>
int main() {
    const int size = 10;
    int sum = 0;
    int index = 0;
    while(index < size) {
        if(! (index % 2 == 0)) {
            sum = sum + 1;
        }
        index ++;
    }
    printf("%d",sum);
    return 0;
}
