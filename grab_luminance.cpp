#include <stdlib.h>
#include <iostream>

using namespace std;

int main(int argc,char **argv)
{
    int luminance = (int)atoi(argv[1]) * 0.2126 + (int)atoi(argv[2]) * 0.7152 + (int)atoi(argv[3]) * 0.0722;

    cout << luminance << "\n";

    return 0;
}
