#include <stdio.h>

int main(void)
{
    int arr[10000];
    long long sum = 0;

    for (int i = 0; i < 10000; i++)
    {
        arr[i] = i + 1;
    }

    for (int i = 0; i < 10000; i++)
    {
        sum += arr[i];
    }

    printf("Array sum = %lld\n", sum);

    return 0;
}
