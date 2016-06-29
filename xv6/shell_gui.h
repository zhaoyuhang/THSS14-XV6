/*
 * FileName: shell_gui
 * Author: Liu Tongtong
 * Date: 2015.01.23
 * Version: 2.0
 *
 * TODO:
 * 1. Add a cursor to the shell
 * 2. Support the arrow keys
 * 3. Support the text editor
 * 4. Support page scrolling
 *
 */

#include "types.h"
#include "stat.h"
#include "user.h"
#include "bitmap.h"
#include "clickable.h"
#include "context.h"
#include "drawingAPI.h"
#include "message.h"

#define KEY_HOME        0xE0
#define KEY_END         0xE1
#define KEY_UP          0xE2
#define KEY_DN          0xE3
#define KEY_LF          0xE4
#define KEY_RT          0xE5
#define KEY_PGUP        0xE6
#define KEY_PGDN        0xE7
#define KEY_INS         0xE8
#define KEY_DEL         0xE9

// Define the height of the header and footer
// Define the width of the left and right border
// The process of drawing is in drawingAPI.c
#define HEADERHEIGHT 22
#define FOOTERHEIGHT 22
#define LEFTWIDTH 8
#define RIGHTWIDTH 8

// Define the width and height of a character
#define CHARWIDTH 8
#define CHARHEIGHT 20

// Define the numbers of line and characters of per line
#define CHARS 80
#define LINES 20

// Define the color of the background and characters
// Define the color of the background and characters
#define BACKGROUNDCOLOR 0x44
#define CHARCOLOR 0xff0
#define WIGHT 0xffff
#define BLACK 0x0
#define GREEN 0xf00 //0xff0
#define BLUE 0xf //0xff
#define RED 0xf000

// The buffer and indexes of the printer
char printer_buf[LINES][CHARS];
char printer_buf_his[10*LINES][CHARS];
int line_index = 0;
int char_index = 0;
int linehis_index = 0;
int curHisLine = 0;
int charhis_index = 0;
// If the screen is full
int isFull = 0;
int isHisFull = 0;
int isRun = 1;

// Define the max length of the command
#define COMMANDMAXLEN 1024
char write_cmd[COMMANDMAXLEN];
char cmd_history[100][COMMANDMAXLEN];
int write_index = 0;
int cur_write = -1;
int his_index = -1;
int cur_his = -1;

// Define the size of the read buffer
#define READBUFFERSIZE 1024
char read_buf[READBUFFERSIZE];

char init_string[] = "$ ";
// Store the info of the window
struct windowinfo {
    int id;
    struct Msg msg;
    struct Context context;
};

// Use for the close button
ClickableManager cm;
Point p;
void h_closeWnd(Point p);

Handler wndEvents[] = { h_closeWnd};
struct Icon wndRes[] = { { "close.bmp", 3, 3 } };

void
init_printer();

void
clean_printer(struct Context context, int draw);

void
cleanline_printer(struct Context context, int line, int draw);

void
string_printer(struct Context context, char* read_buf, int len);

void
init_window(struct windowinfo* winfo, char* title);

void
create_shell(int* p_pid, int* p_rfd, int* p_wfd);

void
init_screen(struct Context context, int rfd);

void
handle_keydown(struct Context context, char ch, int rfd, int wfd);

void addWndEvent(ClickableManager *cm);
