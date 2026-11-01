volatile long sink;
volatile long top = 10;
int main(void)
{
    long result = 1;
    for (int n = 0; n < 100000; n++)
    {
        result = 1;
        for (long i = 1; i <= top; i++) result *= i;
    }
    sink = result;
    return 0;
}
