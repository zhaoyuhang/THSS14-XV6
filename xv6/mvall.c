#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "fs.h"

#define BUF_SIZE 128
void move(char* original, char* target)
{
	//判断第二个参数是不是以"/"结尾，如果是，则补全路径
	char com[128];
	strcpy(com, target);
	int len1 = strlen(original);
	int len2 = strlen(target);
	if (target[len2-1] == '/')
	{
		//找到argv[1]中的文件名
		int i = len1 - 1;
		for (; i >= 0; i--)
			if (original[i] == '/')
				break;
		i++;
		strcpy(&com[len2], &original[i]);
	}
	
	//打开目标文件
	int fd_dest = open(com, O_WRONLY|O_CREATE);
	if (fd_dest < 0)
	{
		return;
	}
	int fd_src = open(original, O_WRONLY|O_CREATE);
	if(fd_src < 0)
	{
		return;
	}
	//复制文件
	char buf[BUF_SIZE];
	int len = 0;
	while(1)
	{
		len = read(fd_src, buf, BUF_SIZE);
		if(len <= 0)
		{
			break;
		}
		write(fd_dest, buf, len);
	}	
	//关闭文件
	close(fd_src);
	close(fd_dest);
	
	//删除源文件
	if(unlink(original) < 0)
		printf(2, "delete source file failed\n");
	return;
}
int main(int argc, char *argv[])
{
	//判断参数
	if (argc !=3)
	{
		printf(2, "please input the command as [mvall originaldirectory targetdirectory\n");
		exit();
	}
	if(argv[1][strlen(argv[1]) - 1] != '/')
	{
		printf(2, "directory should be end with '/' \n");
		return 0;
	}
	if(argv[2][strlen(argv[2]) - 1] != '/')
	{
		printf(2, "directory should be end with '/' \n");
		return 0;
	}
	int fd_src = open(argv[1], O_RDONLY);
	if (fd_src < 0)
	{
		printf(2, "original directory does not exist\n");
		return 0;
	}
	struct stat st;
	fstat(fd_src, &st);
	if (st.type == T_FILE)
	{
		printf(2, "source is a file, please use 'mv' to finish your operation\n");
		return 0;
	}
	fd_src = open(argv[2], O_RDONLY);
	if (fd_src < 0)
	{
		printf(2, "target directory does not exist\n");
		return 0;
	}
	fstat(fd_src, &st);
	if (st.type == T_FILE)
	{
		printf(2, "target should be a direcotry\n");
		return 0;
	}
	if(strcmp(argv[1], argv[2]) == 0)
	{
		printf(2, "original directory is the same as target directory\n");
		return 0;
	}
	char buf[512], *p;
	int fd;
	struct dirent de;
	if((fd = open(argv[1], 0)) < 0)
	{
		printf(2, "cannot open %s\n", argv[1]);
		return 0;
	}
	if(fstat(fd, &st) < 0)
	{
		printf(2, "cannot stat %s\n", argv[1]);
		close(fd);
		return 0;
	}	
	strcpy(buf, argv[1]);
	p = buf+strlen(buf);
	while(read(fd, &de, sizeof(de)) == sizeof(de))
	{
		if(de.inum == 0)
			continue;
		memmove(p, de.name, DIRSIZ);
		//put name in the last of p
		p[DIRSIZ] = 0;
		if(stat(buf, &st) < 0)
		{
			continue;
		}
		move(buf, argv[2]);
	}
	close(fd);
	return 0;
}

