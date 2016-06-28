#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "fs.h"
#define LENGTH 8//8 lines and 8 rows
#define NUMOFLANDMINE 8//8 landmines
#define THEREISALANDMINE 9//9 represent landmines that have not digged
#define STEP 1//you think there is not a landmine
#define DIG 2//you think there is a landmine
void sroundzero(int x, int y, int info[][LENGTH])
	//clear all nearby zero
{
	if(info[x][y] != 0)
	{
		if(info[x][y] <= 8)
		{
			info[x][y] = info[x][y] + 10;
		}
		return;
	}
	info[x][y] = 10;
	if(x - 1 >= 0 && y - 1 >= 0)
	{
		sroundzero(x - 1, y - 1, info);
	}
	if(y - 1 >= 0)
	{
		sroundzero(x, y - 1, info);
	}
	if(x + 1 < LENGTH && y - 1 >= 0)
	{
		sroundzero(x + 1, y - 1, info);
	}
	if(x - 1 >= 0)
	{
		sroundzero(x - 1, y, info);
	}
	if(x + 1 < LENGTH)
	{
		sroundzero(x + 1, y, info);
	}
	if(x - 1 >= 0 && y + 1 < LENGTH)
	{
		sroundzero(x - 1, y + 1, info);
	}
	if(y + 1 < LENGTH)
	{
		sroundzero(x, y + 1, info);
	}
	if(x + 1 < LENGTH && y + 1 < LENGTH)
	{
		sroundzero(x + 1, y + 1, info);
	}
}
int main(int argc, char *argv[])
{
	if(argc != 2)
		//do not have 2 parameters
	{
		printf(1, "Format is wrong!\nthe true format is'game begin' or 'game (x,y,operation)'\n");
		return 0;
	}
	else
	{
		int fd;
		int i, j, k, flag;
		int info[8][8];//information of a grid
		char information[66];
		int landmineposition[NUMOFLANDMINE][2];
		if(strcmp(argv[1], "begin") == 0)
			//game begins
		{
			int x, y;
			int seed = uptime() * 1.5; //a seed of random
			seed = seed % 1000;
			int holdrand = seed;//random num
			for(i = 0; i < NUMOFLANDMINE; i++)
			{
				flag = 0;
				holdrand = ((holdrand * 214013L + 2531011L) >> 16) & 0x7fff;
				//imitation of founction rand() in c
				landmineposition[i][0] = holdrand % LENGTH;
				holdrand = ((holdrand * 214013L + 2531011L) >> 16) & 0x7fff;
				landmineposition[i][1] = holdrand % LENGTH;
				for(k = 0; k < i; k++)
				{
					if(landmineposition[i][0] == landmineposition[k][0] && landmineposition[i][1] == landmineposition[k][1])
					{
						flag = 1;
						break;
					}
					if(flag == 1)
					{
						i--;//if the landmine is a superposition, reproduce it.
					}
				}
			}
			//now we have the landmine position
			for(i = 0; i < LENGTH; i++)
			{
				for(j = 0; j < LENGTH; j++)
				{
					info[i][j] = 0;
					for(k = 0; k < NUMOFLANDMINE; k++)
					{
						if(i == landmineposition[k][0] && j == landmineposition[k][1])
						{
							break;
						}
					}
					if(k != NUMOFLANDMINE)
						//no landmine here
					{
						info[i][j] = THEREISALANDMINE;
					}
				}
			}
			for(k = 0; k < NUMOFLANDMINE; k++)
			{
				x = landmineposition[k][0];
				y = landmineposition[k][1];
				if(x - 1 >= 0 && y - 1 >= 0)
				{
					if(info[x - 1][y - 1] < 8)
					{
						info[x - 1][y - 1]++;//has landmine sround.
					}
				}
				if(y - 1 >= 0)
				{
					if(info[x][y - 1] < 8)
					{
						info[x][y - 1]++;
					}
				}
				if(x + 1 < LENGTH && y - 1 >= 0)
				{
					if(info[x + 1][y - 1] < 8)
					{
						info[x + 1][y - 1]++;
					}
				}
				if(x - 1 >= 0)
				{
					if(info[x - 1][y] < 8)
					{
						info[x - 1][y]++;
					}
				}
				if(x + 1 < LENGTH)
				{
					if(info[x + 1][y] < 8)
					{
						info[x + 1][y]++;
					}
				}
				if(x - 1 >= 0 && y + 1 < LENGTH)
				{
					if(info[x - 1][y + 1] < 8)
					{
						info[x - 1][y + 1]++;
					}
				}
				if(y + 1 < LENGTH)
				{
					if(info[x][y + 1] < 8)
					{
						info[x][y + 1]++;
					}
				}
				if(x + 1 < LENGTH && y + 1 < LENGTH)
				{
					if(info[x + 1][y + 1] < 8)
					{
						info[x + 1][y + 1]++;
					}
				}
			}
			for(i = 0; i < LENGTH; i++)
			{
				for(j = 0; j < LENGTH; j++)
				{
					information[LENGTH * i + j] = info[i][j] + '0';//put it in file to record
				}
			}
			information[64] = NUMOFLANDMINE + '0';//landleft
			information[65] = '\0';
			fd = open("gamedata.txt", O_WRONLY | O_CREATE);
			write(fd, information, strlen(information));
			printf(1,"minesweeping game begin!\n");
			for(i = 0; i < LENGTH; i++)
			{
				for(j = 0; j < LENGTH; j++)
				{
					printf(1,"- ");
				}
				printf(1,"\n");
			}
			return 0;
		}
		else
		{
			int leftlandminenum;
			fd = open("gamedata.txt", O_RDONLY);
			//读文件获取游戏信息
			if (fd < 0)
				return fd;
			read(fd, information, 66);
			//重新写回文件里
			for(i = 0; i < LENGTH; i++)
			{
				for(j = 0; j < LENGTH; j++)
				{
					info[i][j] = information[LENGTH * i + j] - '0';
				}
			}
			int positionx, positiony, operation;
			positionx = argv[1][1] - '0' - 1;
			positiony = argv[1][3] - '0' - 1;//input is "chaetosema+1"
			operation = argv[1][5] - '0';
			leftlandminenum = information[64] - '0';
			if(positionx < 0 || positionx >= 8 || positiony < 0 || positiony >= 8 || operation < 1 || operation > 2)
			{
				printf(1,"wrong input!\n");
				return 0;
			}
			if(operation == 1)
				//you think it is not a landmine
			{
				if(info[positionx][positiony] <= 8)
					//not landmine and not digged
				{
					if(info[positionx][positiony] == 0)
					{
						sroundzero(positionx, positiony, info);
					}
					else
					{
						info[positionx][positiony] = info[positionx][positiony] + 10;
					}
				}
				else if(info[positionx][positiony] >= 10 && info[positionx][positiony] < 20)
				{
					printf(1,"this position has been chosen!!!\n");
				}
				else
				{
					printf(1,"You lose! This is a landmine\n");//you lose this game
					for(i = 0; i < LENGTH; i++)
					{
						for(j = 0; j < LENGTH; j++)
						{
							if(info[i][j] < 9)
							{
								printf(1, "- ");
							}
							else if(info[i][j] == 9)
							{
								printf(1, "* ");
							}
							else if(info[i][j] == 20)
							{
								printf(1, "+ ");
							}
							else if(info[i][j] == 21)
							{
								printf(1, "# ");//wrong digged(it is not a landmine but you think it is)
							}
							else
							{
								printf(1, "%d ", info[i][j] - 10);
							}
						}
						printf(1, "\n");
					}
					return 0;
				}
			}
			else
				//you think this is a landmine
			{
				if(info[positionx][positiony] == 9)
				{
					info[positionx][positiony] = 20;
					leftlandminenum--;//correct!
				}
				else if(info[positionx][positiony] <= 8)
					//you think it is a landmine but is not
				{
					info[positionx][positiony] = 21;
				}
				else
				{
					printf(1,"It has digged or it has chosen and not has a landmine!");
				}
			}
			if(leftlandminenum == 0)
			{
				for(i = 0; i < LENGTH; i++)
				{
					for(j = 0; j < LENGTH; j++)
					{
						if(info[i][j] == 21)
							//this is not a landmine but you think it is
						{
							break;
						}
					}
				}
				if(i == LENGTH && j == LENGTH)
					//you do not choose sth wrong and you win!
				{
					printf(1,"YOU WIN\n");
					for(i = 0; i < LENGTH; i++)
					{
						for(j = 0; j < LENGTH; j++)
						{
							if(info[i][j] < 9)
							{
								printf(1, "- ");
							}
							else if(info[i][j] == 9)
							{
								printf(1, "* ");
							}
							else if(info[i][j] == 20)
							{
								printf(1, "+ ");
							}
							else if(info[i][j] == 21)
							{
								printf(1, "# ");
							}
							else
							{
								printf(1, "%d ", info[i][j] - 10);
							}
						}
						printf(1, "\n");
					}
					return 0;
				}
			}
			for(i = 0; i < LENGTH; i++)
			{
				for(j = 0; j < LENGTH; j++)
				{
					if(info[i][j] < 10)
					{
						printf(1, "- ");
					}
					else if(info[i][j] == 20 || info[i][j] == 21)
					{
						printf(1, "+ ");
					}
					else
					{
						printf(1, "%d ", info[i][j] - 10);
					}
				}
				printf(1, "\n");
			}
			for(i = 0; i < LENGTH; i++)
			{
				for(j = 0; j < LENGTH; j++)
				{
					information[LENGTH * i + j] = info[i][j] + '0';//put it in file to record
				}
			}
			information[64] = leftlandminenum;//landmine left
			information[65] = '\0';
			fd = open("gamedata.txt", O_WRONLY | O_CREATE);
			if (fd < 0)
				return fd;
			write(fd, information, strlen(information));
			close(fd);
			return 0;
		}
	}
}