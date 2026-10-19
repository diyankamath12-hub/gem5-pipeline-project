#include <stdio.h>
int main()
{
    long sum = 0;
    for (int i = 0; i < 100000; i++)
    {
        if (i % 3 == 0)
        {
            sum += 2;
        }
        else if (i % 3 == 1)
        {
            sum -= 1;
        }
        else
        {
            sum += 5;
        }
    }
    printf("%ld\n", sum);
    return 0;
}
