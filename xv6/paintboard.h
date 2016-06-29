#ifndef PAINTBOARD
#define PAINTBOARD

#include "drawingAPI.h"
#include "bitmap.h"
#include "context.h"
#include "user.h"
#include "message.h"
#include "clickable.h"
#include "windowStyle.h"
#include "fcntl.h"
#include "math.h"

#define BOARD_WIDTH 400
#define BOARD_HEIGHT 400
#define AVAILABLE_WIDTH 397
#define AVAILABLE_HEIGHT 368

#define PEN 160514
#define ERASER 51801
#define RECT 180503
#define TRI 201809
#define CIRCLE 30918

#define MIN(a,b) (a>b)?b:a

void addWndEvent(ClickableManager *cm);
void h_closeWnd(Point p);
void drawPaintBoardWnd(Context context);

void changePen(Point p);
void changeEraser(Point p);
void drawRect(Point p);
void drawTri(Point p);
void drawCircle(Point p);
void changeRed(Point p);
void changeGreen(Point p);
void changeBlue(Point p);
void painting(Point p);

#endif