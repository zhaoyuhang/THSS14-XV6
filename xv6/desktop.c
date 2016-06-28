#include "types.h"
#include "stat.h"
#include "user.h"
#include "context.h"
#include "drawingAPI.h"
#include "bitmap.h"
#include "message.h"
#include "clickable.h"
#include "tasklist.h"
#include "uptime.h"

//unused
ICON iconlist[] = {
    {"music.bmp", 175, 400},
    {"finder.bmp", 300, 400},
    {"terminal.bmp", 425, 400},
    //{"setting.bmp", 550, 400}
};

void shellinit(Point point)
{
    int pid;
    char* shell_argv[] = { "shell_gui", 0 };

    printf(1, "init shell: starting shell\n");
    pid = fork();
    if (pid < 0)
    {
        printf(1, "init shell: fork failed\n");
        exit();
    }
    if (pid == 0)
    {
        exec("shell_gui", shell_argv);
        printf(1, "init shell: exec shell failed\n");
        exit();
    }
//    return pid;
}

void finderinit(Point point)
{
    int pid;
    char* finder_argv[] = { "finder", 0 };

    printf(1, "init finder: starting finder\n");
    pid = fork();
    if (pid < 0)
    {
        printf(1, "init finder: fork failed\n");
        exit();
    }
    if (pid == 0)
    {
        exec("finder", finder_argv);
        printf(1, "init finder: exec finder failed\n");
        exit();
    }
//    return pid;
}

void shutdownxv6(Point point)
{
    int pid;
    char* argv[] = { "halt", 0};
    printf(0, "init shutdown: starting shutdown \n");
    pid = fork();
    if (pid < 0)
    {
        printf(1, "init shutdown: fork failed\n");
        exit();
    }
    if (pid == 0)
    {
        exec("halt", argv);
        printf(1, "init shutdown: exec shutdown failed\n");
        exit();
    }
}

void playmusic(Point point)
{
    int pid;
    char* argv[] = { "playmusic", "qian.wav" , "test.wav", "in.mp3"};
    printf(0, "init player: starting player \n");
    pid = fork();
    if (pid < 0)
    {
        printf(1, "init player: fork failed\n");
        exit();
    }
    if (pid == 0)
    {
        exec("playmusic", argv);
        printf(1, "init player: exec play failed\n");
        exit();
    }
}
int main(int argc, char *argv[])
{
    int winid;
    struct Msg msg;
    struct Context context;
//    struct taskNode* tasknode;
    //int shell_pid;
    //int finder_pid;
    short isRun = 1;
//    short isInit = 1;
    ClickableManager manager;
    taskLinkHead = 0;
    taskLinkTail = 0;

    winid = init_context(&context, 800, 600);
    fill_rect(context, 0, 0, context.width, context.height, 0xffff);
//    puts_str(context, "desktop: welcome", 0x0, 0, 0);

    int hour = 0, minute = 0, second = 0;
    int *t,*m,*s;
    char hou_str[5], min_str[5], sec_str[5];
    t = &hour;
    m = &minute;
    s = &second;
    //getTime(t,m,s);
    //convert(hour, hou_str);
    //convert(minute, min_str);
    //convert(second, sec_str);
    //printf(1,"convert:%s\n",a);
    //printf(1,"hour:%d ,minite:%d, second:%d",*t,*m,*s);
    //puts_str(context, hou_str, 0x0101, 200, 200);
    //puts_str(context, ":", 0x0101, 215, 200);
    //puts_str(context, min_str, 0,220, 200);
    //puts_str(context, ":", 0x0101, 235, 200);
    //puts_str(context, sec_str, 0x0101, 240, 200);

    PICNODE pic[4];
    loadBitmap(&pic[0], "music.bmp");
    loadBitmap(&pic[1], "setting.bmp");
    loadBitmap(&pic[2], "notes.bmp");
//    loadBitmap(&pic[3], "bg.bmp");
    set_icon_alpha(&pic[0]);
    set_icon_alpha(&pic[1]);
    set_icon_alpha(&pic[2]);
//
    //fill_rect(context, 160, 400, 500, 150, 0x0101);

    draw_picture(context, pic[3], 0, 0);
    draw_picture(context, pic[0], 50, 50);
    draw_picture(context, pic[1], 50, 192);
    draw_picture(context, pic[2], 50, 325);
    draw_picture(context, pic[1], 0, 525);
    //draw_iconlist(context, iconlist, sizeof(iconlist) / sizeof(ICON));

    manager = initClickManager(context);
    createClickable(&manager, initRect(50, 50, 75, 75), MSG_DOUBLECLICK, playmusic);
    createClickable(&manager, initRect(50, 192, 75, 75), MSG_DOUBLECLICK, shellinit);
    createClickable(&manager, initRect(50, 325, 75, 75), MSG_DOUBLECLICK, finderinit);
    createClickable(&manager, initRect(0, 525, 75, 75), MSG_LPRESS, shutdownxv6);
    
    int p = 0;
    int formerminute = -1;
    int i = 100000;
    while(isRun)
    {
        getMsg(&msg);
        switch(msg.msg_type)
        {
            default:
                 if (i == 100000)
                 {
                     getTime(t,m,s);
                     if (formerminute != minute)
                     {
        	         convert(hour, hou_str);
        	         convert(minute, min_str);
   	 	         convert(second, sec_str);
	 	         fill_rect(context, 680, 550, 50, 18, 0x0101);
   	 	         puts_str(context, hou_str, 0xffff, 680, 550);
   	 	         puts_str(context, ":", 0xffff, 695, 550);
   		         puts_str(context, min_str, 0xffff,700, 550);
//   		         puts_str(context, ":", 0xffff, 715, 550);
//   		         puts_str(context, sec_str, 0xffff, 720, 550);
		         updateWindow(winid, context.addr, msg.msg_detail);
                         formerminute = minute;
                     }
                     i = 0;
                 }
                 i++;
                //break;
            case MSG_UPDATE:
                printf(1, "msg_detail %d\n", msg.msg_detail);
                updateWindow(winid, context.addr, msg.msg_detail);
                printf(1, "winid %d\n", winid);
                //printf(0, "desktop");
                /*if (isInit)
                {
                    finderinit((Point){0, 0});
                    //finderinit((Point){0, 0});
                    //shell_pid = shellinit((Point){context.width / 2, context.height / 2});
                    //shellinit((Point){context.width / 2, context.height / 2});
                    isInit = 0;
                }*/
                break;
            case MSG_PARTIAL_UPDATE:
                updatePartialWindow(winid, context.addr, msg.concrete_msg.msg_partial_update.x1, msg.concrete_msg.msg_partial_update.y1, msg.concrete_msg.msg_partial_update.x2, msg.concrete_msg.msg_partial_update.y2);
                break;
            case MSG_LPRESS:
                p = executeHandler(manager.left_click, initPoint(msg.concrete_msg.msg_mouse.x, msg.concrete_msg.msg_mouse.y));
                printf(0, "curID:%d\n", p);
                updateWindow(winid, context.addr, msg.msg_detail);             
                break; 
            case MSG_DOUBLECLICK:
                p = executeHandler(manager.double_click, initPoint(msg.concrete_msg.msg_mouse.x, msg.concrete_msg.msg_mouse.y));
                if (p != 0)
                {
                    add_tasknode(p);
                }
                printf(0, "curID:%d\n", p);
                p = 0;
                draw_tasklist(context, pic);
                updateWindow(winid, context.addr, msg.msg_detail);
                break;
        }
    }

    //int windowId;
    //int result;

    //windowId = createWindow(0, 0, 800, 600);
    //printf(0, "windowId: %d\n", windowId);


    //result = updateWindow(windowId, context.addr);
    //printf(0, "updateResult: %d\n", result);

    free_context(&context, winid);
    exit();
}
