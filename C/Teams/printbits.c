void print_bits(const unsigned int b);

int main(void)
{
    int a = 36152;

    print_bits(a);
    print_bits(a << 5);
    print_bits(a >> 5);
    print_bits(-1);
    print_bits(~0);
    print_bits(4 & 5);
    print_bits(5);
    print_bits(4);

    return 0;
}
