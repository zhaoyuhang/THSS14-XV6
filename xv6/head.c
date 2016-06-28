#include "types.h"
#include "stat.h"
#include "user.h"

void head(int fp,int num){
	int i,length,pos;
	const int bufSize = 128;
	char buf[bufSize];
	char tmp[bufSize];
	int counter = 0;
	while((length = read(fp,buf,bufSize)) > 0){
		if(length > bufSize)
			return;
		for(i = 0;i < length;++i){
			if(buf[i] == '\n'){
				tmp[pos] = 0;
				counter++;
				printf(1,"%d : %s\n",counter,tmp);
				pos = 0;
				if(counter == num){
					exit();
				}
			}
			else{
				tmp[pos++] = buf[i];
				if(pos==(bufSize-1))
				{
					buf[bufSize-1]=0;
					counter++;
					printf(1,"%d : %s\n",counter,tmp);
					pos = 0;
					if(counter == num){
						exit();
					}
				}
			}
		
		}
	}
}

int main(int argc,char* argv[]){
	int i;
	int fp;
	if(argc < 2){
		printf(1, "Usage: head files...\n");
		exit();
	}
	for(i = 1;i < argc;i++){
		if((fp = open(argv[i],0)) < 0){
			printf(1,"head : cannot open %s\n",argv[i]);
			exit();
		}
		head(fp,10);
		close(fp);
	}
	exit();
}