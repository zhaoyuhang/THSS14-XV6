#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "date.h"
#include "fcntl.h"
#include "x86.h"
#define CMOS_STATA   0x0a
#define CMOS_STATB   0x0b
#define CMOS_UIP    (1 << 7)        // RTC update in progress
#define SECS    0x00
#define MINS    0x02
#define HOURS   0x04
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09
#define D_SHOW_STAMP 	0x4
#define D_SHOW_DATE 	0x1
#define D_SHOW_TIME 	0x2
#define D_NO_DATE_TIME  0xfffffffc
#define D_UTC0			0x10
#define D_SET_UTC		0x100
#define CMOS_PORT    0x70
#define CMOS_RETURN  0x71
int memcmp(const void *v1, const void *v2, uint n)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
static uint cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
}
void cmostime(struct rtcdate *r)
{
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
  bcd = (sb & (1 << 2)) == 0;
  // make sure CMOS doesn't modify time while we read it
  for (;;) {
    fill_rtcdate(&t1);
    if (cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if (memcmp(&t1, &t2, sizeof(t1)) == 0)
      break;
  }
  // convert
  if (bcd) {
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
    CONV(minute);
    CONV(hour  );
    CONV(day   );
    CONV(month );
    CONV(year  );
#undef     CONV
  }
  *r = t1;
  r->year += 2000;
}
void timestampToDate(rtcdate* date, const uint timestamp)
{
  int daysec = timestamp % 86400;
  date->hour = daysec / 3600;
  date->minute = (daysec % 3600) / 60;
  date->second = daysec % 60;
  
  int daynum = (timestamp-946684800) / 86400; //utc+0 2000/1/1 0:0:0 946684800
  int days[]={31,28,31,30,31,30,31,31,30,31,30,31};
  int yearfor4 = daynum / (365*4+1);
  int daysfor4 = daynum % (365*4+1);
  int year = yearfor4 * 4 + 2000;
  if(daysfor4 >= 366)
  {
    daysfor4-=366;
    year++;
    year += (daysfor4 / 365);
    daysfor4 %= 365;
  }
  else
    days[1] = 29;
  date->year = year;
  date->month = 1;
  int i;
  for(i = 0; i < 12; i++)
  {
    if(daysfor4 >= days[i])
    {
      date->month++;
      daysfor4 -= days[i];
    }
    else
      break;
  }
  date->day = daysfor4+1;
} 


uint dateToTimestamp(rtcdate* date)
{
  uint ret = 946684800; //utc+0 2000/1/1 0:0:0 946684800
  int days[]={31,28,31,30,31,30,31,31,30,31,30,31};
  int year4num = (date->year - 2000) / 4;
  ret += year4num*(365*4+1)*86400;
  int yearfor4 = date->year - year4num * 4 - 2000;
  if(yearfor4>0)
  {
    ret += 366 * 86400;
    yearfor4--;
    ret += yearfor4 * 365 * 86400;
  }
  else
    days[1] = 29;
  int i;
  for(i = 1; i < date->month; i++)
    ret += days[i-1]*86400;
  ret += (date->day - 1) * 86400;
  ret += (date->hour * 3600 + date->minute * 60 + date->second);
  return ret;
}
//transfer

void dateAddHour(rtcdate* date,short hour)
{
  int days[]={31,28,31,30,31,30,31,31,30,31,30,31};
  hour += date->hour; 
  if(hour < 0)
  {
    date->hour = hour + 24;
    date->day --;
    if(date->day < 1)
    {
      if(date->month == 1)
      {
        date->year--;
        date->month = 12;
        date->day = 31;
      }
      else
      {
        if(date->year % 4 == 0)
          days[1]++;
        date->month--;
        date->day = days[date->month - 1];
      }
    }
  }
  else if(hour >= 24)
  {
    date->hour = hour - 24;
    date->day ++;
    if(date->year % 4 == 0)
      days[1]++;
    if(date->day > days[date->month - 1])
    {
      date->month++;
      date->day = 1;
      if(date->month > 12)
      {
        date->year++;
        date->month = 1;
      }
    }
  }
  else
  {
    date->hour = hour;
  }
}

int setTimeZone(int zone)
{
	if(zone > 12 || zone < -12)
    return 1;
  int fp = open("/.timezone",O_WRONLY | O_CREATE);
  char c;
	if(zone < 0)
	{
		c = '-';
		write(fp,&c,1);
	}
	if(zone >= 10)
	{
		c = '1';
		write(fp,&c,1);
	}
	c = zone % 10 + '0';
	write(fp,&c,1);
	c = 0;
	write(fp,&c,1);
	close(fp);
  return 0;
}

int getTimeZone()
{
	int fp = open("/.timezone",O_RDWR | O_CREATE);
	int zone = 1, now = 0;
	char buf[4];
	read(fp,buf,3);
	if(buf[0] == '-')
	{
		zone = -1;
		now++;
	}
	zone = zone * (buf[now++] - '0');
	if(buf[now])
		zone = zone * 10 + (buf[now] - '0');
	close(fp);
	if(zone > 12 || zone < -12)
	{
		buf[0]='8';
		buf[1]=0;
		write(fp,buf,2);
		return 8;
	}
  return zone;
}

int strToInt(char* a)
{
	int len = strlen(a);
	int ret = 0;
	int flag = 1;
	int i;
	for(i = 0; i < len; i++)
	{
		switch (a[i])
		{
		case '+':
			flag = 1;
			break;
		case '-':
			flag = -1;
			break;
		default:
			ret = ret * 10 + a[i] - '0';
		}
	}
	return ret * flag;
}

char*
fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}

#define L_ALL 0x1
#define L_LIST  0x2

int flag = 0;

void showInvalidOption()
{
  printf(2,"Invalid option\n");
  printf(2,"Try 'ls -h' for help\n"); 
}

void showHelpText()
{
	printf(2,"Usage: ls [-a] [-l] path\n");
	printf(2,"-a:Show all files\n");
	printf(2,"-l:List details\n");
}


void
ls(char *path)
{
  const char* nodeTypeStr[] = {"","DIR","FILE","DEVICE"};
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  rtcdate date;
  int t = 0;

  switch(st.type){
  case T_FILE:
    if((flag & L_ALL) || fmtname(path)[0] != '.'){
      if(flag & L_LIST)
      {
        if(st.ctime < 1452978035)
            st.ctime = 1452978035;
        timestampToDate(&date, st.ctime);
        dateAddHour(&date,getTimeZone());
        printf(1, "%s %s %d", fmtname(path), nodeTypeStr[st.type], st.size);
        printf(1, "%d/%d/%d %d:%d:%d\n", date.year,date.month,date.day,date.hour,date.minute,date.second);
      }
      else
      {
        printf(1, "%s ", fmtname(path));
        if(++t==4)
        {
          t = 0;
          printf(1, "\n");
        }
      }
      
    }

    break;
/*
void timestampToDate(rtcdate* date, const uint timestamp);
uint dateToTimestamp(rtcdate* date);
void dateAddHour(rtcdate* date,short hour);
int setTimeZone(int);
int getTimeZone(); 
*/ 
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
	int fdw;
    while(read(fd, &de, sizeof(de)) == sizeof(de))
	{
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
	  if(fmtname(buf)[0] == '.' && strcmp(path, ".") != 0)
	  {
		  continue;
	  }
	  fdw = open(buf, 0);
      if(fstat(fdw, &st) < 0)
	  {
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      if((flag & L_ALL) || fmtname(buf)[0] != '.')
      {
        if(flag & L_LIST)
        {
          if(st.ctime < 1452978035)
            st.ctime = 1452978035;
          timestampToDate(&date, st.ctime);
          dateAddHour(&date,getTimeZone());
          printf(1, "%s %s %d ", fmtname(buf), nodeTypeStr[st.type], st.size);
          printf(1, "%d/%d/%d %d:%d:%d\n", date.year,date.month,date.day,date.hour,date.minute,date.second);
          //printf(1, "%s %s %d %d\n", fmtname(buf), nodeTypeStr[st.type], st.size, st.ctime);  
        }
        else
        {
          printf(1, "%s", fmtname(buf));
          if(++t==4)
          {
            t = 0;
            printf(1, "\n");
          }
        }       
      }
	  close(fdw);
    }
    break;
  }
  close(fd);
  printf(1, "\n");
}

int
main(int argc, char *argv[])
{
  int i = 1;

  if(argc < 2)
  {
    ls(".");
    exit();
  }
  if(argc > i && argv[i][0] == '-')
  {
    if(argv[i][2] != 0)
    {
      showInvalidOption();
      exit();
    }
    switch(argv[i][1])
    {
      case 'h':
        showHelpText();
        exit();
      case 'l':
        flag |= L_LIST;
        break;
      case 'a':
        flag |= L_ALL;
        break;
      default:
        showInvalidOption();
        exit();
    }
    i++;
    if(argc > i && argv[i][0] == '-')
    {
      if(argv[i][2] != 0)
      {
        showInvalidOption();
        exit();
      }
      switch(argv[i][1])
      {
        case 'h':
          showHelpText();
          exit();
        case 'l':
          flag |= L_LIST;
          break;
        case 'a':
          flag |= L_ALL;
          break;
        default:
          showInvalidOption();
          exit();
      }
      i++;
    }
  }
  if(i >= argc)
    ls(".");
  for(; i<argc; i++)
    ls(argv[i]);
  return 0;
  exit();
}
