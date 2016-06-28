
void getTime(int* h, int * m, int* s){
	int result = uptime() * 1.5;
	int hour = result / 360000;
	int minute = (result % 360000) / 6000;
	int second = (result % 6000) / 100;
	//int point1 = (result % 100) / 10;
	//int point2 = result % 10;
	//printf(1,"getHour:%d,getMinute:%d,getSecond:%d\n",*h,*m,*s);
	result++;
	*h = hour;
	*m = minute;
	*s = second;
	//point1++;
	//point2++;
	//printf(1,"getHour:%d,getMinute:%d,getSecond:%d\n",*h,*m,*s);
}
void 
convert(int num, char *string){
	//printf(1,"getnum:%d\n",num);
	int n = 0 ,i = 0, j=i;
	n = num % 10;
	char tmp[20];
	if(n == 0){
	    tmp[i++] = '0';
	    tmp[i++] = num/10 + '0';
	}
	while(n>0){
		tmp[i++] = n+'0';
		num = (num-n)/10;
		n = num % 10;	
	}
	tmp[i] = '\0';
	j=i;
	//printf(1,"getTemp:%s\n",tmp);
	for(i = 0;i<=j-1;i++){
		string[i]= tmp[j-i-1];
	}
	string[i] = '\0';
	if(i == 1){
		string[1] = string[0];
		string[0] = '0';
		string[2] = '\0';
		return;
	}
	if (i == 0){
		string[0] = '0';
                string[1] = '0';
		string[2] = '\0';
	}
	printf(1,"getnewaaaa:%s\n",string);
}
