#include "types.h"
#include "user.h"
#include "param.h"
#include "mmu.h"
#include "proc.h"
#include "tasklist.h"
#include "window.h"
#include "drawingAPI.h"
#include "stat.h"
#include "fcntl.h"
#include "fs.h"

struct taskNode* taskLinkHead = 0;
struct taskNode* taskLinkTail = 0;

int init_tasklist()
{
    int fd;
    char nodeInfo[64];
    struct taskNode* tasknode;
    fd = open("tasklist.txt", O_RDONLY);
    if (fd < 0)
    {
        return fd;
    }  
    read(fd, nodeInfo, 64);
    if (nodeInfo[1] == ' ')
    {
        taskLinkHead = 0;
        taskLinkTail = 0;
        return 0;
    }
    int i = 0;
    while (nodeInfo[i] != '\0')
    {
        tasknode = (TASKNODE*)malloc(sizeof(TASKNODE));
        if (i == 0)
        {
            tasknode->next = 0;
            tasknode->appID = nodeInfo[i] - '0';
            taskLinkHead = tasknode;
            taskLinkTail = tasknode;
        }
        else
        {
            tasknode->next = 0;
            tasknode->appID = nodeInfo[i] - '0';
            taskLinkTail->next = tasknode;
            taskLinkTail = tasknode;
        }
        i++;
    }
    close(fd);
    return i;
}

void add_tasknodeToTail(int appID)
{
    printf(0, "add_tasknode called\n");
    struct taskNode* tasknode = (TASKNODE*)malloc(sizeof(TASKNODE));
    if (taskLinkHead == 0)
    {
        printf(0, "inserting into list %d\n", (int)tasknode);
        tasknode->next = 0;
        tasknode->appID = appID;
        taskLinkHead = tasknode;
        taskLinkTail = tasknode;
    }
    else
    {
        tasknode->next = 0;
        tasknode->appID = appID;
        taskLinkTail->next = tasknode;
        taskLinkTail = tasknode;
    }
    printf(0, "task added\n");
    save_tasklist();
}

void add_tasknode(int appID)
{
    struct taskNode* tasknode = (TASKNODE*)malloc(sizeof(TASKNODE));
    tasknode->next = taskLinkHead;
    tasknode->appID = appID;
    if (taskLinkHead == 0)
    {
        taskLinkTail = tasknode;
    }
    taskLinkHead = tasknode;
    save_tasklist();
}

void delete_tasknode(int appID)
{
    printf(0, "delete_tasknode called\n");
    if (taskLinkHead == 0)
    {
        printf(0, "delete error: nothing to delete\n");
        return;
    }
    struct taskNode* tasknode = taskLinkHead;
    struct taskNode* previousTasknode = 0;
    while (tasknode != 0)
    {
        if (tasknode->appID == appID)
        {
            break;
        }
        previousTasknode = tasknode;
        tasknode = tasknode->next;
    }
    if (tasknode == 0)
    {
        printf(0, "delete error: no such app to delete\n");
        return;
    }
    if (previousTasknode == 0)
    {
        taskLinkHead = tasknode->next;
        if (tasknode->next == 0)
        {
            taskLinkTail = 0;
        }
        free(tasknode);
    }
    else
    {
        previousTasknode->next = tasknode->next;
        if (tasknode->next == 0)
        {
            taskLinkTail = 0;
        }
        free(tasknode);
    }
    printf(0, "delete finished\n");
//    save_tasklist();
}

void draw_tasklist(struct Context context, PICNODE pic[])
{
    printf(0, "draw_tasknode called\n");
    struct taskNode* tasknode = taskLinkHead;
    if (taskLinkHead == 0)
    {
        printf(0, "task draw error: nothing to draw\n");
        return;
    }
    int i = 1;
    while (tasknode != 0)
    {
        draw_picture(context, pic[tasknode->appID - 1], 75*i, 525);
        tasknode = tasknode->next;
        i++;
        if (i == 11)
        {
            break;
        }
    }
    printf(0, "draw finished\n");   
}

int save_tasklist()
{
    int fd;
    fd = open("tasklist.txt", O_WRONLY | O_CREATE);
    struct taskNode* tasknode = taskLinkHead;
    char nodeInfo[100];
    if (taskLinkHead == 0)
    {
        nodeInfo[0] = ' ';
        nodeInfo[1] = '\0';
        write(fd, nodeInfo, strlen(nodeInfo));
        return 0;
    }
    int i = 0;
    while (tasknode != 0)
    {
        nodeInfo[i] = tasknode->appID + '0';
        tasknode = tasknode->next;
        i++;
        if (i == 100)
        {
            break;
        }
    }
    write(fd, nodeInfo, strlen(nodeInfo));
    return i;
}
