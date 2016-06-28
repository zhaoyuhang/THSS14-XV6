#ifndef TASKLIST_H
#define TASKLIST_H

#include "bitmap.h"
#include "context.h"

//tasklist
typedef struct taskNode
{
//   int taskID;
    int appID;
    struct taskNode* next;
} TASKNODE;

//tasklist functions
int init_tasklist();
void add_tasknode(int appID);
void delete_tasknode(int appID);
void draw_tasklist(struct Context context, PICNODE pic[]);
int save_tasklist();

extern TASKNODE* taskLinkHead;
extern TASKNODE* taskLinkTail;

#endif
