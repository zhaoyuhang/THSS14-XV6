#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "context.h"
#include "drawingAPI.h"
#include "message.h"
#include "bitmap.h"
#include "windowStyle.h"
#include "clickable.h"
#include "fcntl.h"


#define WINDOW_WIDTH 500
#define WINDOW_HEIGHT 550

#define TITLE_HEIGHT 50

#define RBAR_WIDTH 50

#define SAVEBUT_WIDTH 50
#define SAVEBUT_HEIGHT 35

#define UPDNBUT_WIDTH 30
#define UPDNBUT_HEIGHT 30

//--1
#define line_width 50
#define page_height 16
#define HEADER_HEIGHT 10
#define CHAR_HEIGHT 30
#define LEFT_WIDTH 10
#define CHAR_COLOR 1
//--1

struct Context context;
ClickableManager cm;
int isRun = 1;
int isChoose = 0;//点击choose按钮为choose状态（1），再点击一次变为非choose状态（0）
int align_style = 0;//0为左对齐 1为居中对齐 2为右对齐
PICNODE pic_close;
PICNODE pic_up, pic_down, pic_save;
PICNODE pic_choose, pic_black, pic_red, pic_green, pic_blue;
PICNODE pic_cut, pic_copy, pic_paste, pic_search;
PICNODE pic_center, pic_left, pic_right;


//--2   2016/6/28新增功能：
//1 choose √ 2 对齐方式√ 3 改变文字颜色√ 4 复制剪切粘贴删除 5 渐变色API函数添加，并应用一次 6 查找
int* color;//黑0红1绿2蓝3
char* str;
char* buf_str;
char* fnm;
int line_num = 0; // 当前显示的行数
int head_line[1024] = {};
int total_line_num = 1024;
int cursor = 0;  //光标在当前页面的位置
int icursor = 0;//第二维的光标，用于选择区域，注意icursor >= cursor 时才生效
int character_in_this_page = 0;  //当前页面的字符数量
//--2


//　draw the beautiful graphical user interface
void drawEditorWnd(Context context, char *fileName);
void drawTxtContent(Context context);

void saveButton_onClick();
void upButton_onClick();
void downButton_onClick();
void choose_onClick();
void black_onClick();
void red_onClick();
void green_onClick();
void blue_onClick();
void cut_onClick();
void copy_onClick();
void paste_onClick();
void search_onClick();
void center_onClick();
void left_onClick();
void right_onClick();

void printCursor(int x, int y);
void chooseArea(int x, int y);
void no_clearing_reloadPage();
void paintArea();
void createAllPages();
//Handlers
void hCloseWnd(Point p) {
    isRun = 0;
    printf(1, "close!!!");
}

void strncpy(char *s, char *t, int n)
{
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
    *s++ = 0;
}

void drawEditorWnd(Context content, char *fileName) {
    fill_rect(context, 0, 0, content.width, context.height, 0xFFFF);
    fill_rect_vertical_gradient(context, 0, 0, content.width, TITLE_HEIGHT, 0, 255);
    draw_line(context, 0, 0, context.width - 1, 0, BORDERLINE_COLOR);
    draw_line(context, context.width - 1, 0, context.width - 1,
			context.height - 1, BORDERLINE_COLOR);
	draw_line(context, 0, context.height - 1, context.width - 1, context.height - 1, BORDERLINE_COLOR);
	draw_line(context, 0, context.height - 1, 0, 0, BORDERLINE_COLOR);
    draw_line(context, 0, TITLE_HEIGHT, context.width-1, TITLE_HEIGHT, BORDERLINE_COLOR);
    draw_line(context, context.width-RBAR_WIDTH, TITLE_HEIGHT, context.width-RBAR_WIDTH, context.height-1, BORDERLINE_COLOR);
    draw_picture(context, pic_close, context.width-50, 10);
	draw_picture(context, pic_choose, context.width-RBAR_WIDTH+10, 52);
	draw_picture(context, pic_black, context.width-RBAR_WIDTH+10, 87);
	draw_picture(context, pic_red, context.width-RBAR_WIDTH+10, 122);
	draw_picture(context, pic_green, context.width-RBAR_WIDTH+10, 157);
	draw_picture(context, pic_blue, context.width-RBAR_WIDTH+10, 192);
	draw_picture(context, pic_cut, context.width-RBAR_WIDTH+10, 227);
	draw_picture(context, pic_copy, context.width-RBAR_WIDTH+10, 262);
	draw_picture(context, pic_paste, context.width-RBAR_WIDTH+10, 297);
	draw_picture(context, pic_search, context.width-RBAR_WIDTH+10, 332);
	draw_picture(context, pic_left, context.width-RBAR_WIDTH+10, 367);
	draw_picture(context, pic_center, context.width-RBAR_WIDTH+10, 402);
	draw_picture(context, pic_right, context.width-RBAR_WIDTH+10, 437);
    draw_picture(context, pic_up, context.width-RBAR_WIDTH+10, 472);
    draw_picture(context, pic_down, context.width-RBAR_WIDTH+10, 507);
    draw_picture(context, pic_save, context.width-150, 5);
    createClickable(&cm, initRect(450, 10, 30, 30), MSG_LPRESS, hCloseWnd);
	createClickable(&cm, initRect(460, 52, 32, 32), MSG_LPRESS, choose_onClick);
	createClickable(&cm, initRect(460, 87, 32, 32), MSG_LPRESS, black_onClick);
	createClickable(&cm, initRect(460, 122, 32, 32), MSG_LPRESS, red_onClick);
	createClickable(&cm, initRect(460, 157, 32, 32), MSG_LPRESS, green_onClick);
	createClickable(&cm, initRect(460, 192, 32, 32), MSG_LPRESS, blue_onClick);
	createClickable(&cm, initRect(460, 227, 32, 32), MSG_LPRESS, cut_onClick);
	createClickable(&cm, initRect(460, 262, 32, 32), MSG_LPRESS, copy_onClick);
	createClickable(&cm, initRect(460, 297, 32, 32), MSG_LPRESS, paste_onClick);
	createClickable(&cm, initRect(460, 332, 32, 32), MSG_LPRESS, search_onClick);
	createClickable(&cm, initRect(460, 367, 32, 32), MSG_LPRESS, left_onClick);
    createClickable(&cm, initRect(460, 402, 32, 32), MSG_LPRESS, center_onClick);
	createClickable(&cm, initRect(460, 437, 32, 32), MSG_LPRESS, right_onClick);
	createClickable(&cm, initRect(460, 472, 32, 32), MSG_LPRESS, upButton_onClick);
    createClickable(&cm, initRect(460, 507, 32, 32), MSG_LPRESS, downButton_onClick);
    createClickable(&cm, initRect(350, 5, 40, 40), MSG_LPRESS, saveButton_onClick);

    puts_str(context, fileName, 0XFFFF, 20, 3);
}

//--3
char* readFileTxt(int fd)
{
  int n;
  // int i;
  str=(char*)malloc(1024*80);
  buf_str=(char*)malloc(1024*80);
  color = (int*)malloc(1024*80);
  memset(color, 0, 1024*80);
  memset(str, 0, 1024*80);
  memset(buf_str, 0, 1024*80);
  n = read(fd, str, 1024*80);

  if(n < 0){
    printf(1, "fileEditor: read error\r\n");
    free(str);
    // releaseTxtDom();
    // releasedom(GUIENT_DIV, windowDom);
    exit();
  }
  return str;
}

void clearText() {
	fill_rect(context, 1, TITLE_HEIGHT+1, context.width-RBAR_WIDTH-2, context.height-TITLE_HEIGHT-2, 0xFFFF);
}

void printChar()
{
	//printf(1, "changeColor!\n");
	int tempCursor = 0;
	while (head_line[line_num] + tempCursor < strlen(str))
	{
		int chcolor = color[head_line[line_num] + tempCursor];
		char ch = str[head_line[line_num] + tempCursor];
		if (chcolor == 0 || ch == '\n')
		{
			tempCursor++;
			continue;
		}
		int temp_x=0, temp_y=0;
		int j = 0;
		while(j <= tempCursor)
		{
			if (head_line[line_num + temp_y + 1] == strlen(str))
			{
				temp_y++;
				if (head_line[line_num + temp_y + 1] == strlen(str) && strlen(str) != 0)
					temp_y++;
				break;
			}
			j += head_line[line_num + temp_y + 1] - head_line[line_num + temp_y];
			temp_y++;
			//printf(1, "loop:   tempy = %d,  j = %d\n", temp_y, j);
		}
		temp_y--;
		temp_x = tempCursor - head_line[temp_y+line_num]+head_line[line_num];
		if (align_style == 1)
		{
			temp_x += (line_width - head_line[line_num + temp_y + 1] + head_line[line_num + temp_y]) / 2;
		}
		if (align_style == 2)
		{
			temp_x += line_width - head_line[line_num + temp_y + 1] + head_line[line_num + temp_y];
		}
		if (chcolor == 1)
		{
			put_ascii(context, ch, _RGB16BIT565(255, 0, 0), LEFT_WIDTH + temp_x * 8, TITLE_HEIGHT + HEADER_HEIGHT + CHAR_HEIGHT * temp_y);
		}
		else if (chcolor == 2)
		{
			put_ascii(context, ch, _RGB16BIT565(0, 255, 0), LEFT_WIDTH + temp_x * 8, TITLE_HEIGHT + HEADER_HEIGHT + CHAR_HEIGHT * temp_y);
		}
		else
		{
			put_ascii(context, ch, _RGB16BIT565(0, 0, 255), LEFT_WIDTH + temp_x * 8, TITLE_HEIGHT + HEADER_HEIGHT + CHAR_HEIGHT * temp_y);
		}
		tempCursor++;
	}
}

void reloadPage(){
	//printf(1, "reloading\n");
	clearText();
    char temp_str[51];
    int temp_x=0, temp_y=0;
    int j = 0, i = 0;
    while(j <= cursor){
	if (head_line[line_num + temp_y + 1] == strlen(str))
	{
		temp_y++;
		if (head_line[line_num + temp_y + 1] == strlen(str) && strlen(str) != 0)
			temp_y++;
		break;
	}
        j += head_line[line_num + temp_y + 1] - head_line[line_num + temp_y];
        temp_y++;
	//printf(1, "loop:   tempy = %d,  j = %d\n", temp_y, j);
    }
    temp_y--;
    temp_x = cursor - head_line[temp_y+line_num]+head_line[line_num];
    printf(1,"%d,%d,%d\r\n", temp_x, temp_y, cursor);
	if (align_style == 1)
	{
		temp_x += (line_width - head_line[line_num + temp_y + 1] + head_line[line_num + temp_y]) / 2;
	}
	if (align_style == 2)
	{
		temp_x += line_width - head_line[line_num + temp_y + 1] + head_line[line_num + temp_y];
	}
    printCursor(temp_x,temp_y);
    // character_in_this_page = head_line[line_num + 20] - head_line[line_num];
    printf(1, "line_num: %d     total: %d\n", line_num, total_line_num);
    if(line_num < total_line_num - page_height){
    	for(i = 0;i < page_height; i++) {
	        memset(temp_str, 0, 51);
	        if(str[head_line[i + line_num + 1] - 1] != '\n')
	            strncpy(temp_str, str + head_line[i+line_num], head_line[i+line_num+1] - head_line[line_num+i]);
	        else
	            strncpy(temp_str, str + head_line[i+line_num], head_line[i+line_num+1] - head_line[line_num+i] - 1);
			int align_offset = 0;
			if (align_style == 1)
				align_offset = (line_width - head_line[line_num + i + 1] + head_line[line_num + i]) / 2;
			if (align_style == 2)
				align_offset = line_width - head_line[line_num + i + 1] + head_line[line_num + i];
	        puts_str(context, temp_str, CHAR_COLOR, LEFT_WIDTH + align_offset * 8, TITLE_HEIGHT + HEADER_HEIGHT+i*CHAR_HEIGHT);
	    }
    } else {
    	for(i = 0;i <= total_line_num - line_num && i < page_height; i++) {
	        memset(temp_str, 0, 51);
	        if(str[head_line[i + line_num + 1] - 1] != '\n')
	            strncpy(temp_str, str + head_line[i+line_num], head_line[i+line_num+1] - head_line[line_num+i]);
	        else
	            strncpy(temp_str, str + head_line[i+line_num], head_line[i+line_num+1] - head_line[line_num+i] - 1);
			int align_offset = 0;
			if (align_style == 1)
				align_offset = (line_width - head_line[line_num + i + 1] + head_line[line_num + i]) / 2;
			if (align_style == 2)
				align_offset = line_width - head_line[line_num + i + 1] + head_line[line_num + i];
	        puts_str(context, temp_str, CHAR_COLOR, LEFT_WIDTH + align_offset * 8, TITLE_HEIGHT + HEADER_HEIGHT+i*CHAR_HEIGHT);
	    }
    }
	printChar();
}

void saveButton_onClick(char* fileName, char* str)
{
    int fd;
    int len;
    int n;

    // if (unlink(fileName) < 0)
    // {
    //     printf(1, "fileEditor: cannot remove old file \"%s\" while saving\r\n", fileName);
    //     return -1;
    // }
    // if((fd = open(fileName, 0x200)) < 0){
    //     printf(1, "fileEditor: cannot create new file \"%s\" while saving\r\n", fileName);
    //     return -1;
    // }
    // close(fd);
    // if((fd = open(fileName, 1)) < 0){
    //     printf(1, "fileEditor: cannot open new file \"%s\" while saving\r\n", fileName);
    //     return -1;
    // }

    // getattr(GUIENT_TXT, contentTxt, GUIATTR_TXT_TXTLEN, &len);
    // getattr(GUIENT_TXT, contentTxt, GUIATTR_TXT_STR, str);
    printf(1,"0\n");
    // if(unlink(fnm)<0)
    //     printf(1,"shanchushibai\n");
    // else
    //     printf(1,"shanchuchenggong\n");
    // printf(1,"1\n");
    // fd = open(fnm, O_CREATE);
    // printf(1,"2\n");
    len = strlen(str);
    // printf(1,"3\n")s;
    fd = open(fnm,0);
   	n=write(fd, str, len);
    printf(1,"%d\n",n);
    if (n < 0)
    {
        printf(1, "fileEditor: save error\r\n");
    }
    close(fd);
}



void upButton_onClick()
{
    // int y;
    // int top = 0;

    // getattr(GUIENT_TXT, contentTxt, GUIATTR_TXT_Y, &y);
    // if (y == top)
    //     return;
    // y += 72;
    // if (y > top)
    //     y = top;
    // setattr(GUIENT_TXT, contentTxt, GUIATTR_TXT_Y, &y);
    if (line_num == 0)
        return;
    line_num -= (page_height / 2);
    cursor = 0;

    if (line_num < 0) {
        line_num = 0;
        reloadPage();
    } else {
        if (isChoose)
		{
			paintArea();
			no_clearing_reloadPage();
		}
		else
			reloadPage();
    }

}

void downButton_onClick()
{
    // int y;
    // int h;
    // int bottom = 720;

    // getattr(GUIENT_TXT, contentTxt, GUIATTR_TXT_Y, &y);
    // getattr(GUIENT_TXT, contentTxt, GUIATTR_TXT_HEIGHT, &h);
    // if (y + h <= bottom)
    //     return;
    // y -= 72;
    // if (y + h < bottom)
    //     y = bottom - h;
    // setattr(GUIENT_TXT, contentTxt, GUIATTR_TXT_Y, &y);
    if (line_num +(page_height / 2) >= total_line_num){
        return;
    } else {
        line_num += (page_height / 2);
        cursor = 0;
        if (isChoose)
		{
			paintArea();
			no_clearing_reloadPage();
		}
		else
			reloadPage();
    }
}

void choose_onClick()
{
	printf(1, "choose\n");
	if (isChoose)
	{
		isChoose = 0;
	}
	else
	{
		isChoose = 1;
	}
	reloadPage();
}

void black_onClick()
{
	//printf(1, "black\n");
	if (isChoose)
	{
		int s;
		for (s = head_line[line_num] + cursor; s <= head_line[line_num] + icursor; s++)
			color[s] = 0;
		paintArea();
		no_clearing_reloadPage();
	}
	else
		reloadPage();
}

void red_onClick()
{
	//printf(1, "red\n");
	if (isChoose)
	{
		int s;
		for (s = head_line[line_num] + cursor; s <= head_line[line_num] + icursor; s++)
			color[s] = 1;
		paintArea();
		no_clearing_reloadPage();
	}
	else
		reloadPage();
}

void green_onClick()
{
	//printf(1, "green\n");
	if (isChoose)
	{
		int s;
		for (s = head_line[line_num] + cursor; s <= head_line[line_num] + icursor; s++)
			color[s] = 2;
		paintArea();
		no_clearing_reloadPage();
	}
	else
		reloadPage();
}

void blue_onClick()
{
	//printf(1, "blue\n");
	if (isChoose)
	{
		int s;
		for (s = head_line[line_num] + cursor; s <= head_line[line_num] + icursor; s++)
			color[s] = 3;
		paintArea();
		no_clearing_reloadPage();
	}
	else
		reloadPage();
}

void delete_onClick()
{
	int i;
	int dlen = strlen(str);
	for (i = cursor; i + head_line[line_num] + icursor - cursor + 1 < dlen; i++)
	{
		str[head_line[line_num] + i] = str[head_line[line_num] + i + icursor - cursor + 1];
		color[head_line[line_num] + i] = color[head_line[line_num] + i + icursor - cursor + 1];
	}
	for (; i + head_line[line_num] < dlen; i++)
	{
		str[i + head_line[line_num]] = 0;
		color[i + head_line[line_num]] = 0;
	}
	isChoose = 0;
	createAllPages();
}

void cut_onClick()
{
	printf(1, "cut\n");
	if (isChoose)
	{
        copy_onClick();
		delete_onClick();
	}
}

void copy_onClick()
{
	printf(1, "copy\n");
	if (isChoose)
	{
		int i;
		for (i = 0; i < 1024 * 80; i++)
			buf_str[i] = 0;
		for (i = 0; i <= icursor - cursor; i++)
		{
			buf_str[i] = str[head_line[line_num] + cursor + i];
		}
	}
	isChoose = 0;
	createAllPages();
}

void paste_onClick()
{
	printf(1, "paste\n");
	if (isChoose)
	{
		delete_onClick();
	}
	int plen = strlen(buf_str);
	int i;
	for (i = strlen(str); i >= head_line[line_num] + cursor; i--)
	{
		str[plen + i] = str[i];
		color[plen + i] = color[i];
	}
	for (i = head_line[line_num] + cursor; i < head_line[line_num] + cursor + plen; i++)
	{
		str[i] = buf_str[i - head_line[line_num] - cursor];
		color[i] = 0;
	}
	isChoose = 0;
	createAllPages();
}

void search_onClick() //来不及做了，报纸媒体会给学弟学妹很多很好的评价，嘻嘻
{
	printf(1, "search\n");
	if (isChoose)
	{
		paintArea();
		no_clearing_reloadPage();
	}
	else
		reloadPage();
}

void center_onClick()
{
	//printf(1, "center\n");
	align_style = 1;
	if (isChoose)
	{
		paintArea();
		no_clearing_reloadPage();
	}
	else
		reloadPage();
}

void left_onClick()
{
	//printf(1, "left\n");
	align_style = 0;
	if (isChoose)
	{
		paintArea();
		no_clearing_reloadPage();
	}
	else
		reloadPage();
}

void right_onClick()
{
	//printf(1, "right\n");
	align_style = 2;
	if (isChoose)
	{
		paintArea();
		no_clearing_reloadPage();
	}
	else
		reloadPage();
}

void createAllPages(){
    //printf(1, "creating.\n");
    int length_str = strlen(str);
    int i = 0;
    int j = 0;
    int line = 0;
    int k;
    for (k = 0; k < 1024; k++)
	head_line[k] = 0;//debug
    while (i < length_str) {
        if (str[i] == '\n'){
            j = 0;
            line++;
            i++;
            head_line[line] = i;
            continue;
        }
        j++;
        if (j == line_width){
            line++;
            i++;
            head_line[line] = i;
            j = 0;
            continue;
        }
        i++;
    }
    head_line[line + 1] = length_str;
    total_line_num = line;
    reloadPage();
}

void deleteChar(int i){
    while(str[i] != '\0'){
        str[i] = str[i + 1];
		color[i] = color[i + 1];
        i++;
    }
}

void insertChar(int i, char c){
    int j = strlen(str);
    while(j > i){
        str[j] = str[j - 1];
		color[j] = color[j - 1];
        j--;
    }
    str[i] = c;
}

void printCursor(int x, int y){
	//printf(1, "printingCursor\n");
    fill_rect(context, LEFT_WIDTH+x*8, TITLE_HEIGHT+HEADER_HEIGHT+CHAR_HEIGHT*y, 8, CHAR_HEIGHT, 0xFF0F);
    // puts_str(context, temp_str, CHAR_COLOR, LEFT_WIDTH, HEADER_HEIGHT+i*CHAR_HEIGHT);
}

void handle_keydown(struct Context context, char ch) {
    // printf(1,"cursor%d\r\n", cursor);
    // printf(1,"%d\r\n",ch);
    character_in_this_page = head_line[line_num + page_height] - head_line[line_num];
    //退格
    if (ch == 8) {
		if (isChoose)
		{
			delete_onClick();
		}
        else if (cursor != 0) 
		{
            deleteChar(head_line[line_num]+cursor - 1);
            cursor--;
            createAllPages();
            //reloadPage();
        }
		//printf(1, "%s\n", str);
        return;
    }

    // //左方向键
    // if (ch == 37) {
    //     if (cursor != 0) {
    //         cursor--;
    //     }
    // }

    // //右方向键
    // if (ch == 39) {
    //     character_in_this_page = head_line[line_num + page_height] - head_line[line_num];
    //     if (cursor != character_in_this_page){
    //         cursor++;
    //     }
    // }


    //普通符号
    if (ch >= 32 && ch <= 126) {
        //if (cursor != character_in_this_page){
            // printf(1,"ready to change\r\n");
            insertChar(head_line[line_num]+cursor, ch);
            cursor++;
            // printf(1,"insertend\r\n");
            createAllPages();
            //reloadPage();
        //}
	//else if (cursor == 0 && character_in_this_page == 0)
	//{
		//insertChar(0, ch);
		//cursor++;
            	// printf(1,"insertend\r\n");
            	//createAllPages();
            	//reloadPage();
	//}
	//printf(1, "%s\n", str);
			return;
    }

    //huiche
    if (ch == '\n') {
        insertChar(head_line[line_num]+cursor, ch);
        cursor++;
        createAllPages();
        //reloadPage();
	//printf(1, "%s\n", str);
        return;
    }
}
//--3

void moveCursor(int x, int y){
    if (LEFT_WIDTH < x && x < LEFT_WIDTH + 8*line_width && y >TITLE_HEIGHT+HEADER_HEIGHT && y < TITLE_HEIGHT+HEADER_HEIGHT+page_height*CHAR_HEIGHT) {
        int temp_x = (x - LEFT_WIDTH)/8;
        int temp_y = (y - TITLE_HEIGHT - HEADER_HEIGHT)/CHAR_HEIGHT;
		if (align_style == 1)
		{
			temp_x -= (line_width - head_line[line_num + temp_y + 1] + head_line[line_num + temp_y]) / 2;
		}
		if (align_style == 2)
		{
			temp_x -= line_width - head_line[line_num + temp_y + 1] + head_line[line_num + temp_y];
		}
        if(line_num + temp_y > total_line_num){
            return;
        }
        if(0 <= temp_y && temp_y < page_height){
            if(temp_x < head_line[line_num + 1 + temp_y] - head_line[line_num + temp_y]){
                cursor = head_line[line_num + temp_y] + temp_x - head_line[line_num];
                reloadPage();
                // printCursor(temp_x,temp_y);
            } else {
                if(temp_y < page_height - 1){
                    cursor = head_line[line_num + 1 + temp_y] - head_line[line_num];
                    reloadPage();
                    // temp_y++;
                    // temp_x = 0;
                    // printCursor(temp_x,temp_y);
                }

            }
        }
    }
}

void paintArea()
{
	//printf(1, "paintingArea\n");
	clearText();
	int tempCursor = cursor;
	while (tempCursor <= icursor)
	{
		int temp_x=0, temp_y=0;
		int j = 0;
		while(j <= tempCursor)
		{
			if (head_line[line_num + temp_y + 1] == strlen(str))
			{
				temp_y++;
				if (head_line[line_num + temp_y + 1] == strlen(str) && strlen(str) != 0)
					temp_y++;
				break;
			}
		j += head_line[line_num + temp_y + 1] - head_line[line_num + temp_y];
        temp_y++;
		//printf(1, "loop:   tempy = %d,  j = %d\n", temp_y, j);
		}
		temp_y--;
		temp_x = tempCursor - head_line[temp_y+line_num]+head_line[line_num];
		if (align_style == 1)
		{
			temp_x += (line_width - head_line[line_num + temp_y + 1] + head_line[line_num + temp_y]) / 2;
		}
		if (align_style == 2)
		{
			temp_x += line_width - head_line[line_num + temp_y + 1] + head_line[line_num + temp_y];
		}
		printCursor(temp_x,temp_y);
		tempCursor++;
	}
}

void no_clearing_reloadPage()
{
	//printf(1, "ncreloading\n");
	char temp_str[51];
    int temp_x=0, temp_y=0;
    int j = 0, i = 0;
    while(j <= cursor){
	if (head_line[line_num + temp_y + 1] == strlen(str))
	{
		temp_y++;
		if (head_line[line_num + temp_y + 1] == strlen(str) && strlen(str) != 0)
			temp_y++;
		break;
	}
        j += head_line[line_num + temp_y + 1] - head_line[line_num + temp_y];
        temp_y++;
	//printf(1, "loop:   tempy = %d,  j = %d\n", temp_y, j);
    }
    temp_y--;
    temp_x = cursor - head_line[temp_y+line_num]+head_line[line_num];
    printf(1,"%d,%d,%d\r\n", temp_x, temp_y, cursor);
	if (align_style == 1)
	{
		temp_x += (line_width - head_line[line_num + temp_y + 1] + head_line[line_num + temp_y]) / 2;
	}
	if (align_style == 2)
	{
		temp_x += line_width - head_line[line_num + temp_y + 1] + head_line[line_num + temp_y];
	}
    printCursor(temp_x,temp_y);
    // character_in_this_page = head_line[line_num + 20] - head_line[line_num];
    printf(1, "line_num: %d     total: %d\n", line_num, total_line_num);
    if(line_num < total_line_num - page_height){
    	for(i = 0;i < page_height; i++) {
	        memset(temp_str, 0, 51);
	        if(str[head_line[i + line_num + 1] - 1] != '\n')
	            strncpy(temp_str, str + head_line[i+line_num], head_line[i+line_num+1] - head_line[line_num+i]);
	        else
	            strncpy(temp_str, str + head_line[i+line_num], head_line[i+line_num+1] - head_line[line_num+i] - 1);
			int align_offset = 0;
			if (align_style == 1)
				align_offset = (line_width - head_line[line_num + i + 1] + head_line[line_num + i]) / 2;
			if (align_style == 2)
				align_offset = line_width - head_line[line_num + i + 1] + head_line[line_num + i];
	        puts_str(context, temp_str, CHAR_COLOR, LEFT_WIDTH + align_offset * 8, TITLE_HEIGHT + HEADER_HEIGHT+i*CHAR_HEIGHT);
	    }
    } else {
    	for(i = 0;i <= total_line_num - line_num && i < page_height; i++) {
	        memset(temp_str, 0, 51);
	        if(str[head_line[i + line_num + 1] - 1] != '\n')
	            strncpy(temp_str, str + head_line[i+line_num], head_line[i+line_num+1] - head_line[line_num+i]);
	        else
	            strncpy(temp_str, str + head_line[i+line_num], head_line[i+line_num+1] - head_line[line_num+i] - 1);
			int align_offset = 0;
			if (align_style == 1)
				align_offset = (line_width - head_line[line_num + i + 1] + head_line[line_num + i]) / 2;
			if (align_style == 2)
				align_offset = line_width - head_line[line_num + i + 1] + head_line[line_num + i];
	        puts_str(context, temp_str, CHAR_COLOR, LEFT_WIDTH + align_offset * 8, TITLE_HEIGHT + HEADER_HEIGHT+i*CHAR_HEIGHT);
	    }
    }
	printChar();
}

void chooseArea(int x, int y){
	//printf(1, "chooseArea\n");
	if (LEFT_WIDTH < x && x < LEFT_WIDTH + 8*line_width && y >TITLE_HEIGHT+HEADER_HEIGHT && y < TITLE_HEIGHT+HEADER_HEIGHT+page_height*CHAR_HEIGHT) {
        int temp_x = (x - LEFT_WIDTH)/8;
        int temp_y = (y - TITLE_HEIGHT - HEADER_HEIGHT)/CHAR_HEIGHT;
		if (align_style == 1)
		{
			temp_x -= (line_width - head_line[line_num + temp_y + 1] + head_line[line_num + temp_y]) / 2;
		}
		if (align_style == 2)
		{
			temp_x -= line_width - head_line[line_num + temp_y + 1] + head_line[line_num + temp_y];
		}
        if(line_num + temp_y > total_line_num){
            return;
        }
        if(0 <= temp_y && temp_y < page_height){
            if(temp_x < head_line[line_num + 1 + temp_y] - head_line[line_num + temp_y]){
                icursor = head_line[line_num + temp_y] + temp_x - head_line[line_num];
                // printCursor(temp_x,temp_y);
            } else {
                if(temp_y < page_height - 1){
                    icursor = head_line[line_num + 1 + temp_y] - head_line[line_num];
                    // temp_y++;
                    // temp_x = 0;
                    // printCursor(temp_x,temp_y);
                }

            }
        }
    }
	int temp;
	if (icursor < cursor)
	{
		temp = cursor;
		cursor = icursor;
		icursor = temp;
	}
	paintArea();
	no_clearing_reloadPage();
}


int main(int argc, char *argv[]) {
    int winid;
    struct Msg msg;

    Point p;

    winid = init_context(&context, WINDOW_WIDTH, WINDOW_HEIGHT);
    cm = initClickManager(context);
    deleteClickable(&cm.left_click, initRect(0,0,800,600));

    //--4
    int fd;

    fnm = argv[1];
    if((fd = open(fnm, 0)) < 0){
        printf(1, "fileEditor: cannot open %s\r\n", fnm);
        exit();
    }
    str = readFileTxt(fd);
    close(fd);
    printf(1,"fileEditor: reading complete!\r\n");
    // printf(1, "%s\r\n", str);
    //--4
    char write_cmd_ch;
	// draw close icon
    loadBitmap(&pic_close, "close.bmp");
    loadBitmap(&pic_up, "up1.bmp");
    loadBitmap(&pic_down, "down.bmp");
    loadBitmap(&pic_save, "save.bmp");
	loadBitmap(&pic_choose, "choose.bmp");
	loadBitmap(&pic_black, "black.bmp");
	loadBitmap(&pic_red, "s_red.bmp");
	loadBitmap(&pic_green, "s_green.bmp");
	loadBitmap(&pic_blue, "s_blue.bmp");
	loadBitmap(&pic_cut, "cut.bmp");
	loadBitmap(&pic_copy, "copy.bmp");
	loadBitmap(&pic_paste, "paste.bmp");
	loadBitmap(&pic_search, "search.bmp");
	loadBitmap(&pic_center, "center.bmp");
	loadBitmap(&pic_left, "left.bmp");
	loadBitmap(&pic_right, "right.bmp");
    while (isRun) {
		getMsg(&msg);
		switch (msg.msg_type) {
		case MSG_DOUBLECLICK:
			p = initPoint(msg.concrete_msg.msg_mouse.x,
					msg.concrete_msg.msg_mouse.y);
			if (executeHandler(cm.double_click, p)) {
				updateWindow(winid, context.addr, msg.msg_detail);
			}
			break;
		case MSG_UPDATE:
			//printf(0, "update event!\n");
            drawEditorWnd(context, argv[1]);
            printf(1,"fileEditor: window displayed!\r\n");
            createAllPages();
            printf(1,"fileEditor: text displayed!\r\n");
			updateWindow(winid, context.addr, msg.msg_detail);
			break;
		case MSG_PARTIAL_UPDATE:
			updatePartialWindow(winid, context.addr,
					msg.concrete_msg.msg_partial_update.x1,
					msg.concrete_msg.msg_partial_update.y1,
					msg.concrete_msg.msg_partial_update.x2,
					msg.concrete_msg.msg_partial_update.y2);
			break;
		case MSG_KEYDOWN:
			write_cmd_ch = msg.concrete_msg.msg_key.key;
			handle_keydown(context, write_cmd_ch);
			updateWindow(winid, context.addr, msg.msg_detail);
			break;
		case MSG_LPRESS:
			//printf(0, "left click event!\n");
			if (!isChoose)
				moveCursor(msg.concrete_msg.msg_mouse.x, msg.concrete_msg.msg_mouse.y);
			else
			{
				chooseArea(msg.concrete_msg.msg_mouse.x, msg.concrete_msg.msg_mouse.y);
			}
			p = initPoint(msg.concrete_msg.msg_mouse.x,
					msg.concrete_msg.msg_mouse.y);

			if (executeHandler(cm.left_click, p)) {
                	updateWindow(winid, context.addr, msg.msg_detail);
			}
			updateWindow(winid, context.addr, msg.msg_detail);//debug
			break;
		case MSG_RPRESS:
			p = initPoint(msg.concrete_msg.msg_mouse.x,
					msg.concrete_msg.msg_mouse.y);
			if (executeHandler(cm.right_click, p)) {
				updateWindow(winid, context.addr, msg.msg_detail);
			}
			break;
		default:
			break;
		}
	}
	free_context(&context, winid);
	exit();
}
