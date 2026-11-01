int arr[10000];
volatile long sink;
int main(void)
{
    long sum = 0;
    for (int i = 0; i < 10000; i++) arr[i] = i;
    for (int r = 0; r < 50; r++)
        for (int i = 0; i < 10000; i++) sum += arr[i];
    sink = sum;
    return 0;
}
