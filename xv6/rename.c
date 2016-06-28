#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[]) {
	if (argc != 3) 
	//参数数量不正确
	{
		printf(1, "Less or more arguments!\n");
		exit();
	}
	int fp;
	if ((fp = open(argv[2], O_RDONLY)) >= 0) 
		//newname已经被占用
	{
		close(fp);
		printf(1, "ERROR: newname has been used!\n");
	}
	close(fp);
	int result = link(argv[1], argv[2]);
	if (result == 0) {
		unlink(argv[1]);
	}
	else {
		printf(1, "ERROR: Rename failed!\n");
	}
	exit();
}
