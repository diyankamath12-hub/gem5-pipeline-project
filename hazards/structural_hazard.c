#include <stdio.h>
int arr[10000];
int main()
{
    for (int i = 0; i < 10000; i++)
        arr[i] = i;
    for (int r = 0; r < 20; r++)
        for (int i = 1; i < 9999; i++)
            arr[i] = arr[i-1] + arr[i+1];
    printf("%d\n", arr[500]);
    return 0;
}
