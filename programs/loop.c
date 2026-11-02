#include <stdio.h>

int main(void)
{
    long long sum = 0;

    for (int i = 1; i <= 1000000; i++)
    {
        sum += i;
    }

    printf("Sum = %lld\n", sum);

    return 0;
}
