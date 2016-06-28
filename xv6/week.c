#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  if(argc != 4)
  {
	printf(1,"wrong input\nF: week year month day\nEx:week 2016 6 24\n");
	exit();
  }

int flag = 0;
int j,i;

for(j = 1; j < 4; j++)
{
  for(i = 0; i < strlen(argv[j]); i++)
  {
     if (argv[j][i] < '0' || argv[j][i] > '9')	flag = 1;
  }
}

  int y = atoi(argv[1]);
  int m = atoi(argv[2]); 
  int d = atoi(argv[3]);

  if(flag == 1 || y < 0 || y > 3000 || m < 0 || m > 12 || d < 0 || d > 31
	|| (m%2==0 && m<8 && d==31) || (m%2!=0 && m>8 && d==31))
  {
     	printf(1,"wrong input\nF: week year month day\nEx:week 2016 6 24\n");
	exit();
  }


    if(m==1||m==2) {
        m+=12;
        y--;
    }
    int iWeek=(d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7;
    switch(iWeek)
    {
    case 0: printf(1,"Monday\n"); break;
    case 1: printf(1,"Tuesday\n"); break;
    case 2: printf(1,"Wednesday\n"); break;
    case 3: printf(1,"Thursday\n"); break;
    case 4: printf(1,"Friday\n"); break;
    case 5: printf(1,"Saturday\n"); break;
    case 6: printf(1,"Sunday\n"); break;
    }
  exit();

}