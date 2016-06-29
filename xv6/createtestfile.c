#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "fs.h"
int main(int argc, char *argv[])
{
	int fd;
	fd = open("testfile1", O_WRONLY | O_CREATE);
	write(fd, "thisisthetestfile1", 19);
	close(fd);
	fd = open("testfile2", O_WRONLY | O_CREATE);
	write(fd, "thisisthetestfile2", 19);
	close(fd);
	fd = open("testfile3", O_WRONLY | O_CREATE);
	write(fd, "thisisthetestfile3", 19);
	close(fd);
	fd = open("testfile4", O_WRONLY | O_CREATE);
	write(fd, "thisisthetestfile4", 19);
	close(fd);
	fd = open("testfile5", O_WRONLY | O_CREATE);
	write(fd, "thisisthetestfile5", 19);
	close(fd);
	fd = open("testfile6", O_WRONLY | O_CREATE);
	write(fd, "thisisthetestfile6", 19);
	close(fd);
	return 0;
}