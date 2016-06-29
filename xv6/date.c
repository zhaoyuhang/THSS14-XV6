#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "fs.h"
#include "date.h"
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
void showInvalidOption()
{
	printf(1, "Invalid option!\n");
	printf(1, "use 'date -h' for help\n");
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

void showHelpText()
{
  printf(1,"Usage: date -z timezone\n");
  printf(1,"-z:Set timezone\n");
  printf(1,"Usage: date [-s|-d|-t] [-u]\n");
  printf(1,"option:\n");
  printf(1,"-u:Show time at UTC+00\n");
  printf(1,"-s:Show Timestamp\n");
  printf(1,"-d:Only show date\n");
  printf(1,"-t:Only show time\n");
}

int main(int argc,char* argv[])
{
	if(argc < 1 || argc > 3)
	{
		showInvalidOption();
		return 0;
	}
	int flags = D_SHOW_DATE | D_SHOW_TIME;
	int i,zone = 1;
	for(i = 1; i < argc; i++)
	{
		if(strlen(argv[i]) != 2 || argv[i][0] != '-')
		{
			showInvalidOption();
			return 0;
		}
		switch (argv[i][1])
		{
			case 'h':
				showHelpText();
				exit();
			case 'u':
				flags |= D_UTC0;
				break;
			case 'd':
				flags &= D_NO_DATE_TIME;
				flags |= D_SHOW_DATE;
				break;
			case 't':
				flags &= D_NO_DATE_TIME;
				flags |= D_SHOW_TIME;
				break;
			case 's':
				flags |= D_SHOW_STAMP;
				break;
			case 'z':
				if(i == 2 || argc < 3)
				{
					showInvalidOption();
				}
				else
				{
					zone = strToInt(argv[2]);
					if(setTimeZone(zone))
					{
						showInvalidOption();
					}
					else
					{
						if(setTimeZone(zone))
						{
							showInvalidOption();
						}
						else
						{
							printf(1,"Set time zone to UTC");
							if(zone >= 0)
							{
								printf(1,"+");
							}
							printf(1,"%d",zone);
							printf(1,"\n");
						}
					}
				}
				exit();
				break;
			default:
				showInvalidOption();
				return 0;
		}
	}
	struct rtcdate date;
	cmostime(&date);
	if(!(flags & D_UTC0))
	{
		dateAddHour(&date,getTimeZone());
	}
	if(flags & D_SHOW_STAMP)
	{
		printf(1,"%d\n",dateToTimestamp(&date));
	}
	else
	{
		if(flags & D_SHOW_DATE)
		{
			printf(1,"%d/%d/%d ",date.year,date.month,date.day);
		}
		if(flags & D_SHOW_TIME)
		{
			printf(1,"%d:%d:%d ",date.hour,date.minute,date.second);	
		}
		printf(1,"\n");
	}
    return 0;
}
