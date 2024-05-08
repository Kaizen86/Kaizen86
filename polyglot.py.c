#pragma/*
"""
 * C-Python Polyglot by Kaizen86 2024
 * I had a silly idea one day, to see if C preprocessors
 * macros could be used to generate the equivalent C code
 * for a simple Python script, so that the file is
 * simultaneously a valid C and Python program. At first
 * my goal was making a simple Hello World polyglot, but
 * then I wanted to see how far I could push the technique.
 *
 * After solving a lot of interesting challenges, I got
 * print() and str() working fine, but while, if, and else
 * can each only be used once due to macro weirdness. :(
 * Oh and while/else need a closing brace in C, which I
 * hid inside the pass statements.
"""#*/

#include <stdio.h>
#include <stdlib.h>

#define def int
#define S1 /
#define S2 /
#define S3 /
#define S4 /
#define main(...) main(){S1S1
#define exit() return 0;}
#define print(...) printf("%s %s %s\n",__VA_ARGS__,"","");
#define while(c) while(c){S2S2
#define if(c) if(c){S3S3
#define else }else{S4S4
#define pass }
#define True 1
#define False 0

#pragma/*
"""#*/
// Allow up to 3 usages of str per print,
// each with space for 15 digits
char buf[3][15];
int bufid = 0;
char* str(int i) {
    bufid = bufid>2 ? 0 : bufid;
    sprintf(buf[bufid++], "%d", i);
    return buf[bufid-1];
}

// Declare your variables here! //
int i;
int boundary;

#pragma/*
"""#*/


def main():
    print("hello world")
    print(str(40+2), str(69))
    i = 0;
    boundary = 7;
    while (i < 10):
        if (i <= boundary):
            print(str(i), "is less than or equal to", str(boundary))
        else:
            print(str(i), "is greater than", str(boundary))
        pass
        i = i + 1;
    pass
    exit()

#if 0
main()
#endif
