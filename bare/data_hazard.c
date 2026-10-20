volatile long sink;
int main(void)
{
    long a = 1, b = 2, c = 3, d = 4, e = 5;
    for (int i = 0; i < 100000; i++)
    {
        a = a + b;
        c = a + d;
        e = c + a;
        b = e + c;
    }
    sink = b;
    return 0;
}
