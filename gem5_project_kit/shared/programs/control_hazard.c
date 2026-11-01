volatile long sink;
int main(void)
{
    unsigned int x = 12345;
    long sum = 0;
    for (int i = 0; i < 100000; i++)
    {
        x = x * 1103515245u + 12345u;
        if ((x >> 16) & 1) { sum += 2; }
        else { sum -= 1; }
    }
    sink = sum;
    return 0;
}
