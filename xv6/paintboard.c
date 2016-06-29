#include "paintboard.h"

struct Icon wndRes[] = {
	{"close.bmp", 3, 3},
	{"pen.bmp", 1, 31},
	{"eraser.bmp", 31, 31},
	{"rectangle.bmp", 61, 31},
	{"triangle.bmp", 91, 31},
	{"circle.bmp", 121, 31},
	{"red.bmp", 151, 31},
	{"green.bmp", 181, 31},
	{"blue.bmp", 211, 31},
};

Handler wndEvents[] = {
	h_closeWnd,
	changePen,
	changeEraser,
	drawRect,
	drawTri,
	drawCircle,
	changeRed,
	changeGreen,
	changeBlue,
};

int isRun = 1;
unsigned short painter_color = 0x0000;
unsigned int painter_type = PEN;			// stand for the type of painting you are doing
Point Prev;				// some mode of painting may need this to record a start point
struct Context context;		

void changePen(Point p){painter_type = PEN; Prev.x = -1;}
void changeEraser(Point p){painter_type = ERASER; Prev.x = -1;}
void drawRect(Point p){painter_type = RECT; Prev.x = -1;}
void drawTri(Point p){painter_type = TRI; Prev.x = -1;}
void drawCircle(Point p){painter_type = CIRCLE; Prev.x = -1;}
void changeRed(Point p){painter_color = 0xF000;}
void changeGreen(Point p){painter_color = 0x0F00;}
void changeBlue(Point p){painter_color = 0x00F0;}

void painting(Point p){
	switch(painter_type)
	{
	case PEN:
		draw_point(context, p.x, p.y, painter_color);
		if(Prev.x < 0){	Prev = p;}
		else{
			draw_line(context, p.x, p.y, Prev.x, Prev.y, painter_color);
			Prev = p;
		}
		break;
	case ERASER:   // size: 8 * 8
		fill_rect(context, p.x-4, p.y-4, 8, 8, 0xFFFF);
		break;
	case RECT:
		if(Prev.x < 0){ Prev = p; draw_point(context, p.x, p.y, painter_color); }
		else{
			Point start_point = initPoint(MIN(Prev.x, p.x), MIN(Prev.y, p.y));
			fill_rect(context, start_point.x, start_point.y ,abs(Prev.x-p.x), abs(Prev.y-p.y), painter_color);
			Prev.x = -1;
		}
		break;
	case TRI:
		if(Prev.x < 0) Prev = p;
		else{
			if((Prev.x == p.x) | (Prev.y == p.y))
				draw_line(context, p.x, p.y, Prev.x, Prev.y, painter_color);
			else{
				Point peak = initPoint((p.x+Prev.x)/2, MIN(p.y, Prev.y));
				int height = abs(p.y - Prev.y);
				float anti_slope = 0.5 * abs(Prev.x - p.x) / height;

				int tmp = peak.y;	// go through y axis to paint horizontal lines
				for(; tmp < peak.y + height;tmp ++)
					draw_line(context, peak.x-(tmp-peak.y)*anti_slope, tmp, peak.x+(tmp-peak.y)*anti_slope, tmp, painter_color);
			}
			Prev.x = -1;
		}
		break;
	case CIRCLE:
		if(Prev.x < 0) Prev = p;
		else{
			if((Prev.x == p.x) | (Prev.y == p.y))
				Prev = p;
			else{
				Point center = initPoint((p.x+Prev.x)/2, (p.y+Prev.y)/2);
				int radius = MIN(abs(p.x-Prev.x), abs(p.y-Prev.y)) / 2;
				
				int tmp = center.y - radius; 	// go through y axis to paint horizontal lines
				for(; tmp < center.y + radius; tmp ++){
					int chord_length = sqrt(radius * radius - abs(center.y - tmp)*abs(center.y - tmp));
					draw_line(context, center.x - chord_length, tmp, center.x + chord_length, tmp, painter_color);
				}
			}
			Prev.x = -1;
		}
		break;
	default:
		break;
	}
}

void addWndEvent(ClickableManager *cm){
	int i = 0;
	int n = sizeof(wndEvents) / sizeof(Handler);

	for (i = 0;i < n;i ++){
		createClickable(cm,
				initRect(wndRes[i].position_x,
					wndRes[i].position_y,
					wndRes[i].pic.width,
					wndRes[i].pic.height),
				MSG_LPRESS,
				wndEvents[i]);
	}
	createClickable(cm, initRect(1, 61, BOARD_WIDTH-1, BOARD_HEIGHT-60), MSG_LPRESS, painting);
}

void h_closeWnd(Point p){
	isRun = 0;
}

void drawPaintBoardWnd(Context context){
	int width, height;

	width = context.width;
	height = context.height;

	fill_rect(context, 1, 0, width, 30, 0xa514);
	fill_rect(context, 1, 31, width, 61, 0x9514);
	fill_rect(context, 1, 62, width, height, 0xFFFF);
	puts_str(context, "PaintBoard", 0, BOARD_WIDTH/2 - 53, 3);

	draw_iconlist(context, wndRes, sizeof(wndRes)/sizeof(ICON));

	draw_line(context, 1, 1, 1, 399, 0x0000);
	draw_line(context, 1, 1, 399, 1, 0x0000);
	draw_line(context, 1, 399, 399, 399, 0x0000);
	draw_line(context, 399, 1, 399, 399, 0x0000);
	draw_line(context, 1, 30, 399, 30, 0x0000);
	draw_line(context, 1, 61, 399, 61, 0x0000);
}

int main(int argc, char* argv[]){
	
	ClickableManager cm;
	int winid;
	struct Msg msg;
	Point p;

	Prev.x = -1;
	Prev.y = 0;

	winid = init_context(&context, BOARD_WIDTH, BOARD_HEIGHT);
	cm = initClickManager(context);
	load_iconlist(wndRes, sizeof(wndRes) / sizeof(ICON));

	deleteClickable(&cm.left_click, initRect(0, 0, 800, 600));
	addWndEvent(&cm);

	while (isRun) {
		getMsg(&msg);
		switch (msg.msg_type) {
		case MSG_DOUBLECLICK:
			p = initPoint(msg.concrete_msg.msg_mouse.x, msg.concrete_msg.msg_mouse.y);
			if (executeHandler(cm.double_click, p)){
				updateWindow(winid, context.addr, msg.msg_detail);
			}
			break;
		case MSG_UPDATE:
			drawPaintBoardWnd(context);
			updateWindow(winid, context.addr, msg.msg_detail);
			break;
		case MSG_LPRESS:
			p = initPoint(msg.concrete_msg.msg_mouse.x, msg.concrete_msg.msg_mouse.y);
			if(executeHandler(cm.left_click, p)){
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