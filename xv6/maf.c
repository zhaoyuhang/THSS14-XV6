#include "types.h"
#include "stat.h"
#include "user.h"

//由小数寻找其最近似的分数
double Mult10(int n);
double strtod(const char* s);


double Mult10(int n) // 计算10的n次方
{  
  double sum = 1;  
  int m;  
  if(n==0) return 1; 
  else if(n==1) return 10;
  else if(n==-1) return 0.1;
  else if(n>1){ 
     for(m=1;m<n;m++){
        sum= sum * 10;
     }  
  }
  else{
      for(m=1;m<=-n;m++){
        sum= sum / 10;
      }  
  }
  return sum;
}


double strtod(const char* s)
{
   int i, temp=1;
   double result=0;
   int num;
   for(i = 0; s[i] != '\0'; i ++){
       if(s[i] == '.'){
         temp = i;
         break;
       }
   }
   for(i = 0; i < temp; i ++){
       num = s[temp-i-1] - '0';
       result = result + (double)(num * Mult10(i)); 
   }
   for(i = temp + 1; s[i] != '\0'; i ++){
       num = s[i] - '0';
       result = result + (num * Mult10(temp-i));
   }
   return result;
}


int main(int argc, char* argv[]){
    double fractional, fractional1;//小数部分
    double approach;//近似精度
    int w_num, w_num1;//整数部分
    int Numerator = 1, Denominator = 1;//分子和分母
    if(argc!= 3){
       printf(1, "Sorry, Wrong Input! The right is like: mAf 3.1415926 3\n");  
       exit();
    }
    int i, j;
    int flag = 0;
    for(i = 1; i < 3; i ++){
       for(j = 0; j < strlen(argv[i]); j ++){
          if(argv[i][j] == '.') continue;
          if(argv[i][j] < '0' || argv[i][j] > '9') flag = 1;
       }
    } 
    double num;
    num = strtod(argv[1]);
    w_num = (int) num;
    fractional = num - w_num;
    approach = fractional;

    if(flag == 1 || atoi(argv[2]) < 3 || num == 0)
    {
       printf(1, "Sorry, Wrong Input! The right is like: mAf 3.1415926 3\n");  
       exit();
    }

    for (i = 2; i < atoi(argv[2]); i++)
    {
       w_num1 = (int)(i * fractional);
       fractional1 = i * fractional - w_num1;

       if (fractional1 >= 1)//四舍五入
       {
         printf(1, "Error!\n");
         exit();
       }
       else if(fractional1 >= 0.5){
         fractional1 = 1 - fractional1;
         w_num1 += 1;
       }
       if(fractional1 < approach){
         Denominator = i;
         Numerator = w_num1;
         approach = fractional1;
       }
    }
    printf(2, "The most Approximate Fraction is: %d/%d \n", w_num*Denominator+Numerator, Denominator);
    exit();
}


/*int main(int argc,char* argv[]){
        int week; 
  if(argc!= 4)
  {
     printf(1,"Error!\n");
  }else
        {
           int y = atoi(argv[1]);
           int m = atoi(argv[2]);
           int d = atoi(argv[3]);
           week =(d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7; //1752年9月3日之后的公式
           switch(week)
           {
              case 0:
                printf(1,"Monday");
                break;
              case 1:
                printf(1,"Tuesday");
                break;
              case 2:
                printf(1,"Wednesday");
                break;
              case 3:
                printf(1,"Thursday");
                break; 
              case 4:
                printf(1,"Friday");
                break;
              case 5:
                printf(1,"Satursday");
                break;
              case 6:
                printf(1,"Sunday");
                break; 
           }  
        } 
     exit();
}
*/

