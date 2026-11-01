volatile long sink;
volatile long limit = 1000000;
int main(void)
{
    long sum = 0;
    for (long i = 1; i <= limit; i++) sum += i;
    sink = sum;
    return 0;
}
