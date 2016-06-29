#include"types.h"
#include"stat.h"
#include"user.h"

int halt();

int main(int argc,char *argv[])
{
  printf(1, "halt start\n");
  halt();
  return 0;
}
