//
//  main.m
//  learnProject
//
//  Created by gwq on 2020/10/26.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void sort_list01(int list[],int len);
void sort_list02(int list[],int len);
void sort_list03(int list[],int len);

void exchange(int *a,int *b);
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    
    
//    int arr[10] = {42,5,2,98,324,5,67,45,34,456};
//    sort_list02(arr, 10);
//
//    for (int i = 0; i < 10; i ++) {
//        int num = arr[i];
//        printf("num = %d \n",num);
//    }
//
//    return 1;
}

void exchange(int *a,int *b){
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

//冒泡排序
void sort_list01(int list[],int len){
    if (len < 2) {
        return;
    }
    for (int i = 0; i < len; i ++) {
        int tag = 0;
        for (int j = 0; j < len - i - 1; j++) {
            if(list[j] >= list[j + 1]){
                exchange(&list[j],&list[j + 1]);
                tag ++;
            }
        }
        if (tag == 0) {
            break;
        }
    }
}

//选择排序
/*
 首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置。
 再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。
 重复第二步，直到所有元素均排序完毕。
 */
void sort_list02(int list[],int len){
    if (len < 2) {
        return;
    }
    for (int i = 0; i < len - 1; i ++) {
        int *min = &list[i];
        for (int j = i + 1; j <len; j ++) {
            if (*min > list[j]) {
                exchange(min, &list[j]);
            }
        }
    }
}

//插入排序
/*
 将第一待排序序列第一个元素看做一个有序序列，把第二个元素到最后一个元素当成是未排序序列。
 从头到尾依次扫描未排序序列，将扫描到的每个元素插入有序序列的适当位置。
 （如果待插入的元素与有序序列中的某个元素相等，则将待插入元素插入到相等元素的后面。）
 */
void sort_list03(int list[],int len){
    
}
