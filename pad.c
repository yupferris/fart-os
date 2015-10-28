#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char **argv)
{
    char buf[512];
    for (int i = 0; i < 512; i++)
        buf[i] = 0;

    int inputFile = open(argv[1], O_RDONLY);
    read(inputFile, buf, 510);
    close(inputFile);

    buf[510] = 0x55;
    buf[511] = 0xaa;

    int outputFile = open(argv[2], O_CREAT | O_WRONLY);
    write(outputFile, buf, 512);
    close(outputFile);
}
