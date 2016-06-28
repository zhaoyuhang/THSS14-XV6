
_shell_gui:     file format elf32-i386


Disassembly of section .text:

00000000 <init_printer>:
#include "shell_gui.h"

// Initialize the buffer of the printer
void
init_printer()
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < LINES; i++) {
       6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
       d:	eb 2e                	jmp    3d <init_printer+0x3d>
        memset(printer_buf[i], 0, sizeof(char) * CHARS);
       f:	8b 55 f4             	mov    -0xc(%ebp),%edx
      12:	89 d0                	mov    %edx,%eax
      14:	c1 e0 02             	shl    $0x2,%eax
      17:	01 d0                	add    %edx,%eax
      19:	c1 e0 04             	shl    $0x4,%eax
      1c:	05 80 64 01 00       	add    $0x16480,%eax
      21:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
      28:	00 
      29:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      30:	00 
      31:	89 04 24             	mov    %eax,(%esp)
      34:	e8 38 44 00 00       	call   4471 <memset>
// Initialize the buffer of the printer
void
init_printer()
{
    int i;
    for (i = 0; i < LINES; i++) {
      39:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      3d:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
      41:	7e cc                	jle    f <init_printer+0xf>
        memset(printer_buf[i], 0, sizeof(char) * CHARS);
    }
    for (i = 0; i < 10 * LINES; i++) {
      43:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      4a:	eb 2e                	jmp    7a <init_printer+0x7a>
        memset(printer_buf_his[i], 0, sizeof(char) * CHARS);
      4c:	8b 55 f4             	mov    -0xc(%ebp),%edx
      4f:	89 d0                	mov    %edx,%eax
      51:	c1 e0 02             	shl    $0x2,%eax
      54:	01 d0                	add    %edx,%eax
      56:	c1 e0 04             	shl    $0x4,%eax
      59:	05 c0 1d 01 00       	add    $0x11dc0,%eax
      5e:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
      65:	00 
      66:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      6d:	00 
      6e:	89 04 24             	mov    %eax,(%esp)
      71:	e8 fb 43 00 00       	call   4471 <memset>
{
    int i;
    for (i = 0; i < LINES; i++) {
        memset(printer_buf[i], 0, sizeof(char) * CHARS);
    }
    for (i = 0; i < 10 * LINES; i++) {
      76:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      7a:	81 7d f4 c7 00 00 00 	cmpl   $0xc7,-0xc(%ebp)
      81:	7e c9                	jle    4c <init_printer+0x4c>
        memset(printer_buf_his[i], 0, sizeof(char) * CHARS);
    }
}
      83:	c9                   	leave  
      84:	c3                   	ret    

00000085 <clean_printer>:

// Clean the screen
void
clean_printer(struct Context context, int draw)
{
      85:	55                   	push   %ebp
      86:	89 e5                	mov    %esp,%ebp
      88:	83 ec 28             	sub    $0x28,%esp
    fill_rect(context, 0, HEADERHEIGHT, context.width,
            context.height - HEADERHEIGHT - FOOTERHEIGHT, BACKGROUNDCOLOR);
      8b:	8b 45 10             	mov    0x10(%ebp),%eax
      8e:	83 e8 2c             	sub    $0x2c,%eax

// Clean the screen
void
clean_printer(struct Context context, int draw)
{
    fill_rect(context, 0, HEADERHEIGHT, context.width,
      91:	89 c2                	mov    %eax,%edx
      93:	8b 45 0c             	mov    0xc(%ebp),%eax
      96:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
      9d:	00 
      9e:	89 54 24 18          	mov    %edx,0x18(%esp)
      a2:	89 44 24 14          	mov    %eax,0x14(%esp)
      a6:	c7 44 24 10 16 00 00 	movl   $0x16,0x10(%esp)
      ad:	00 
      ae:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
      b5:	00 
      b6:	8b 45 08             	mov    0x8(%ebp),%eax
      b9:	89 04 24             	mov    %eax,(%esp)
      bc:	8b 45 0c             	mov    0xc(%ebp),%eax
      bf:	89 44 24 04          	mov    %eax,0x4(%esp)
      c3:	8b 45 10             	mov    0x10(%ebp),%eax
      c6:	89 44 24 08          	mov    %eax,0x8(%esp)
      ca:	e8 c0 24 00 00       	call   258f <fill_rect>
            context.height - HEADERHEIGHT - FOOTERHEIGHT, BACKGROUNDCOLOR);
    if (!draw)
      cf:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
      d3:	75 05                	jne    da <clean_printer+0x55>
    {
        return;
      d5:	e9 ac 00 00 00       	jmp    186 <clean_printer+0x101>
    }
    if (!isFull)
      da:	a1 b4 ef 00 00       	mov    0xefb4,%eax
      df:	85 c0                	test   %eax,%eax
      e1:	75 5b                	jne    13e <clean_printer+0xb9>
    {
        fill_rect(context, CHARWIDTH * (char_index + 1), HEADERHEIGHT + CHARHEIGHT * (line_index + 0), CHARWIDTH,
      e3:	8b 15 a0 ef 00 00    	mov    0xefa0,%edx
      e9:	89 d0                	mov    %edx,%eax
      eb:	c1 e0 02             	shl    $0x2,%eax
      ee:	01 d0                	add    %edx,%eax
      f0:	c1 e0 02             	shl    $0x2,%eax
      f3:	83 c0 16             	add    $0x16,%eax
      f6:	89 c2                	mov    %eax,%edx
      f8:	a1 a4 ef 00 00       	mov    0xefa4,%eax
      fd:	83 c0 01             	add    $0x1,%eax
     100:	c1 e0 03             	shl    $0x3,%eax
     103:	c7 44 24 1c f0 0f 00 	movl   $0xff0,0x1c(%esp)
     10a:	00 
     10b:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
     112:	00 
     113:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
     11a:	00 
     11b:	89 54 24 10          	mov    %edx,0x10(%esp)
     11f:	89 44 24 0c          	mov    %eax,0xc(%esp)
     123:	8b 45 08             	mov    0x8(%ebp),%eax
     126:	89 04 24             	mov    %eax,(%esp)
     129:	8b 45 0c             	mov    0xc(%ebp),%eax
     12c:	89 44 24 04          	mov    %eax,0x4(%esp)
     130:	8b 45 10             	mov    0x10(%ebp),%eax
     133:	89 44 24 08          	mov    %eax,0x8(%esp)
     137:	e8 53 24 00 00       	call   258f <fill_rect>
     13c:	eb 48                	jmp    186 <clean_printer+0x101>
            CHARHEIGHT, CHARCOLOR);
    }
    else
    {
        fill_rect(context, CHARWIDTH * (char_index + 1), HEADERHEIGHT + CHARHEIGHT * (LINES - 1), CHARWIDTH,
     13e:	a1 a4 ef 00 00       	mov    0xefa4,%eax
     143:	83 c0 01             	add    $0x1,%eax
     146:	c1 e0 03             	shl    $0x3,%eax
     149:	c7 44 24 1c f0 0f 00 	movl   $0xff0,0x1c(%esp)
     150:	00 
     151:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
     158:	00 
     159:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
     160:	00 
     161:	c7 44 24 10 92 01 00 	movl   $0x192,0x10(%esp)
     168:	00 
     169:	89 44 24 0c          	mov    %eax,0xc(%esp)
     16d:	8b 45 08             	mov    0x8(%ebp),%eax
     170:	89 04 24             	mov    %eax,(%esp)
     173:	8b 45 0c             	mov    0xc(%ebp),%eax
     176:	89 44 24 04          	mov    %eax,0x4(%esp)
     17a:	8b 45 10             	mov    0x10(%ebp),%eax
     17d:	89 44 24 08          	mov    %eax,0x8(%esp)
     181:	e8 09 24 00 00       	call   258f <fill_rect>
            CHARHEIGHT, CHARCOLOR);
    }

}
     186:	c9                   	leave  
     187:	c3                   	ret    

00000188 <cleanline_printer>:
// Clean the line
void
cleanline_printer(struct Context context, int line, int draw)
{
     188:	55                   	push   %ebp
     189:	89 e5                	mov    %esp,%ebp
     18b:	83 ec 28             	sub    $0x28,%esp
    fill_rect(context, 0, HEADERHEIGHT + line * CHARHEIGHT, 
        context.width, CHARHEIGHT, BACKGROUNDCOLOR);
     18e:	8b 45 0c             	mov    0xc(%ebp),%eax
}
// Clean the line
void
cleanline_printer(struct Context context, int line, int draw)
{
    fill_rect(context, 0, HEADERHEIGHT + line * CHARHEIGHT, 
     191:	89 c1                	mov    %eax,%ecx
     193:	8b 55 14             	mov    0x14(%ebp),%edx
     196:	89 d0                	mov    %edx,%eax
     198:	c1 e0 02             	shl    $0x2,%eax
     19b:	01 d0                	add    %edx,%eax
     19d:	c1 e0 02             	shl    $0x2,%eax
     1a0:	83 c0 16             	add    $0x16,%eax
     1a3:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     1aa:	00 
     1ab:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
     1b2:	00 
     1b3:	89 4c 24 14          	mov    %ecx,0x14(%esp)
     1b7:	89 44 24 10          	mov    %eax,0x10(%esp)
     1bb:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     1c2:	00 
     1c3:	8b 45 08             	mov    0x8(%ebp),%eax
     1c6:	89 04 24             	mov    %eax,(%esp)
     1c9:	8b 45 0c             	mov    0xc(%ebp),%eax
     1cc:	89 44 24 04          	mov    %eax,0x4(%esp)
     1d0:	8b 45 10             	mov    0x10(%ebp),%eax
     1d3:	89 44 24 08          	mov    %eax,0x8(%esp)
     1d7:	e8 b3 23 00 00       	call   258f <fill_rect>
        context.width, CHARHEIGHT, BACKGROUNDCOLOR);
    if (!draw)
     1dc:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
     1e0:	75 05                	jne    1e7 <cleanline_printer+0x5f>
    {
        return;
     1e2:	e9 ac 00 00 00       	jmp    293 <cleanline_printer+0x10b>
    }
    if (!isFull)
     1e7:	a1 b4 ef 00 00       	mov    0xefb4,%eax
     1ec:	85 c0                	test   %eax,%eax
     1ee:	75 5b                	jne    24b <cleanline_printer+0xc3>
    {
        fill_rect(context, CHARWIDTH * (char_index + 1), HEADERHEIGHT + CHARHEIGHT * (line_index + 0), CHARWIDTH,
     1f0:	8b 15 a0 ef 00 00    	mov    0xefa0,%edx
     1f6:	89 d0                	mov    %edx,%eax
     1f8:	c1 e0 02             	shl    $0x2,%eax
     1fb:	01 d0                	add    %edx,%eax
     1fd:	c1 e0 02             	shl    $0x2,%eax
     200:	83 c0 16             	add    $0x16,%eax
     203:	89 c2                	mov    %eax,%edx
     205:	a1 a4 ef 00 00       	mov    0xefa4,%eax
     20a:	83 c0 01             	add    $0x1,%eax
     20d:	c1 e0 03             	shl    $0x3,%eax
     210:	c7 44 24 1c f0 0f 00 	movl   $0xff0,0x1c(%esp)
     217:	00 
     218:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
     21f:	00 
     220:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
     227:	00 
     228:	89 54 24 10          	mov    %edx,0x10(%esp)
     22c:	89 44 24 0c          	mov    %eax,0xc(%esp)
     230:	8b 45 08             	mov    0x8(%ebp),%eax
     233:	89 04 24             	mov    %eax,(%esp)
     236:	8b 45 0c             	mov    0xc(%ebp),%eax
     239:	89 44 24 04          	mov    %eax,0x4(%esp)
     23d:	8b 45 10             	mov    0x10(%ebp),%eax
     240:	89 44 24 08          	mov    %eax,0x8(%esp)
     244:	e8 46 23 00 00       	call   258f <fill_rect>
     249:	eb 48                	jmp    293 <cleanline_printer+0x10b>
            CHARHEIGHT, CHARCOLOR);
    }
    else
    {
        fill_rect(context, CHARWIDTH * (char_index + 1), HEADERHEIGHT + CHARHEIGHT * (LINES - 1), CHARWIDTH,
     24b:	a1 a4 ef 00 00       	mov    0xefa4,%eax
     250:	83 c0 01             	add    $0x1,%eax
     253:	c1 e0 03             	shl    $0x3,%eax
     256:	c7 44 24 1c f0 0f 00 	movl   $0xff0,0x1c(%esp)
     25d:	00 
     25e:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
     265:	00 
     266:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
     26d:	00 
     26e:	c7 44 24 10 92 01 00 	movl   $0x192,0x10(%esp)
     275:	00 
     276:	89 44 24 0c          	mov    %eax,0xc(%esp)
     27a:	8b 45 08             	mov    0x8(%ebp),%eax
     27d:	89 04 24             	mov    %eax,(%esp)
     280:	8b 45 0c             	mov    0xc(%ebp),%eax
     283:	89 44 24 04          	mov    %eax,0x4(%esp)
     287:	8b 45 10             	mov    0x10(%ebp),%eax
     28a:	89 44 24 08          	mov    %eax,0x8(%esp)
     28e:	e8 fc 22 00 00       	call   258f <fill_rect>
            CHARHEIGHT, CHARCOLOR);
    }

}
     293:	c9                   	leave  
     294:	c3                   	ret    

00000295 <string_printer>:

// Load the read_buf(0..len-1) into the buffer
// and print strings in the buffer to the screen
void
string_printer(struct Context context, char* read_buf, int len)
{
     295:	55                   	push   %ebp
     296:	89 e5                	mov    %esp,%ebp
     298:	53                   	push   %ebx
     299:	83 ec 44             	sub    $0x44,%esp
    int i, j;

    if (len < 0) {
     29c:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
     2a0:	0f 89 85 00 00 00    	jns    32b <string_printer+0x96>
        // If len < 0, delete characters in the buffer
        for (i = 0; i > len; i--) {
     2a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     2ad:	eb 6f                	jmp    31e <string_printer+0x89>
            if (char_index > 0) {
     2af:	a1 a4 ef 00 00       	mov    0xefa4,%eax
     2b4:	85 c0                	test   %eax,%eax
     2b6:	7e 60                	jle    318 <string_printer+0x83>
                printer_buf[line_index][--char_index] = 0;
     2b8:	8b 15 a0 ef 00 00    	mov    0xefa0,%edx
     2be:	a1 a4 ef 00 00       	mov    0xefa4,%eax
     2c3:	83 e8 01             	sub    $0x1,%eax
     2c6:	a3 a4 ef 00 00       	mov    %eax,0xefa4
     2cb:	8b 0d a4 ef 00 00    	mov    0xefa4,%ecx
     2d1:	89 d0                	mov    %edx,%eax
     2d3:	c1 e0 02             	shl    $0x2,%eax
     2d6:	01 d0                	add    %edx,%eax
     2d8:	c1 e0 04             	shl    $0x4,%eax
     2db:	01 c8                	add    %ecx,%eax
     2dd:	05 80 64 01 00       	add    $0x16480,%eax
     2e2:	c6 00 00             	movb   $0x0,(%eax)
                printer_buf_his[linehis_index][--charhis_index] = 0;
     2e5:	8b 15 a8 ef 00 00    	mov    0xefa8,%edx
     2eb:	a1 b0 ef 00 00       	mov    0xefb0,%eax
     2f0:	83 e8 01             	sub    $0x1,%eax
     2f3:	a3 b0 ef 00 00       	mov    %eax,0xefb0
     2f8:	8b 0d b0 ef 00 00    	mov    0xefb0,%ecx
     2fe:	89 d0                	mov    %edx,%eax
     300:	c1 e0 02             	shl    $0x2,%eax
     303:	01 d0                	add    %edx,%eax
     305:	c1 e0 04             	shl    $0x4,%eax
     308:	01 c8                	add    %ecx,%eax
     30a:	05 c0 1d 01 00       	add    $0x11dc0,%eax
     30f:	c6 00 00             	movb   $0x0,(%eax)
{
    int i, j;

    if (len < 0) {
        // If len < 0, delete characters in the buffer
        for (i = 0; i > len; i--) {
     312:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     316:	eb 06                	jmp    31e <string_printer+0x89>
            if (char_index > 0) {
                printer_buf[line_index][--char_index] = 0;
                printer_buf_his[linehis_index][--charhis_index] = 0;
            } else {
                break;
     318:	90                   	nop
     319:	e9 e3 01 00 00       	jmp    501 <string_printer+0x26c>
{
    int i, j;

    if (len < 0) {
        // If len < 0, delete characters in the buffer
        for (i = 0; i > len; i--) {
     31e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     321:	3b 45 18             	cmp    0x18(%ebp),%eax
     324:	7f 89                	jg     2af <string_printer+0x1a>
     326:	e9 d6 01 00 00       	jmp    501 <string_printer+0x26c>
            }
        }
    }
    else {
        // Load the read_buf(0..len-1) into the buffer
        for (i = 0; i < len; i++) {
     32b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     332:	e9 be 01 00 00       	jmp    4f5 <string_printer+0x260>
            if (read_buf[i] == '\n') {
     337:	8b 55 f4             	mov    -0xc(%ebp),%edx
     33a:	8b 45 14             	mov    0x14(%ebp),%eax
     33d:	01 d0                	add    %edx,%eax
     33f:	0f b6 00             	movzbl (%eax),%eax
     342:	3c 0a                	cmp    $0xa,%al
     344:	0f 85 cb 00 00 00    	jne    415 <string_printer+0x180>
                line_index++;
     34a:	a1 a0 ef 00 00       	mov    0xefa0,%eax
     34f:	83 c0 01             	add    $0x1,%eax
     352:	a3 a0 ef 00 00       	mov    %eax,0xefa0
                if (line_index >= LINES) {
     357:	a1 a0 ef 00 00       	mov    0xefa0,%eax
     35c:	83 f8 13             	cmp    $0x13,%eax
     35f:	7e 14                	jle    375 <string_printer+0xe0>
                    isFull = 1;
     361:	c7 05 b4 ef 00 00 01 	movl   $0x1,0xefb4
     368:	00 00 00 
                    line_index = 0;
     36b:	c7 05 a0 ef 00 00 00 	movl   $0x0,0xefa0
     372:	00 00 00 
                }
                char_index = 0;
     375:	c7 05 a4 ef 00 00 00 	movl   $0x0,0xefa4
     37c:	00 00 00 
                linehis_index++;
     37f:	a1 a8 ef 00 00       	mov    0xefa8,%eax
     384:	83 c0 01             	add    $0x1,%eax
     387:	a3 a8 ef 00 00       	mov    %eax,0xefa8
                if (linehis_index >= 10 * LINES) {
     38c:	a1 a8 ef 00 00       	mov    0xefa8,%eax
     391:	3d c7 00 00 00       	cmp    $0xc7,%eax
     396:	7e 14                	jle    3ac <string_printer+0x117>
                    isHisFull = 1;
     398:	c7 05 b8 ef 00 00 01 	movl   $0x1,0xefb8
     39f:	00 00 00 
                    linehis_index = 0;
     3a2:	c7 05 a8 ef 00 00 00 	movl   $0x0,0xefa8
     3a9:	00 00 00 
                }
                charhis_index = 0;
     3ac:	c7 05 b0 ef 00 00 00 	movl   $0x0,0xefb0
     3b3:	00 00 00 
                memset(printer_buf[line_index], 0, sizeof(char) * CHARS);
     3b6:	8b 15 a0 ef 00 00    	mov    0xefa0,%edx
     3bc:	89 d0                	mov    %edx,%eax
     3be:	c1 e0 02             	shl    $0x2,%eax
     3c1:	01 d0                	add    %edx,%eax
     3c3:	c1 e0 04             	shl    $0x4,%eax
     3c6:	05 80 64 01 00       	add    $0x16480,%eax
     3cb:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
     3d2:	00 
     3d3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3da:	00 
     3db:	89 04 24             	mov    %eax,(%esp)
     3de:	e8 8e 40 00 00       	call   4471 <memset>
                memset(printer_buf_his[linehis_index], 0, sizeof(char) * CHARS);
     3e3:	8b 15 a8 ef 00 00    	mov    0xefa8,%edx
     3e9:	89 d0                	mov    %edx,%eax
     3eb:	c1 e0 02             	shl    $0x2,%eax
     3ee:	01 d0                	add    %edx,%eax
     3f0:	c1 e0 04             	shl    $0x4,%eax
     3f3:	05 c0 1d 01 00       	add    $0x11dc0,%eax
     3f8:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
     3ff:	00 
     400:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     407:	00 
     408:	89 04 24             	mov    %eax,(%esp)
     40b:	e8 61 40 00 00       	call   4471 <memset>
     410:	e9 dc 00 00 00       	jmp    4f1 <string_printer+0x25c>
                
            } else {
                printer_buf[line_index][char_index++] = read_buf[i];
     415:	8b 0d a0 ef 00 00    	mov    0xefa0,%ecx
     41b:	a1 a4 ef 00 00       	mov    0xefa4,%eax
     420:	89 c2                	mov    %eax,%edx
     422:	8d 42 01             	lea    0x1(%edx),%eax
     425:	a3 a4 ef 00 00       	mov    %eax,0xefa4
     42a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     42d:	8b 45 14             	mov    0x14(%ebp),%eax
     430:	01 d8                	add    %ebx,%eax
     432:	0f b6 18             	movzbl (%eax),%ebx
     435:	89 c8                	mov    %ecx,%eax
     437:	c1 e0 02             	shl    $0x2,%eax
     43a:	01 c8                	add    %ecx,%eax
     43c:	c1 e0 04             	shl    $0x4,%eax
     43f:	01 d0                	add    %edx,%eax
     441:	05 80 64 01 00       	add    $0x16480,%eax
     446:	88 18                	mov    %bl,(%eax)
                printer_buf_his[linehis_index][charhis_index++] = read_buf[i];
     448:	8b 0d a8 ef 00 00    	mov    0xefa8,%ecx
     44e:	a1 b0 ef 00 00       	mov    0xefb0,%eax
     453:	89 c2                	mov    %eax,%edx
     455:	8d 42 01             	lea    0x1(%edx),%eax
     458:	a3 b0 ef 00 00       	mov    %eax,0xefb0
     45d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     460:	8b 45 14             	mov    0x14(%ebp),%eax
     463:	01 d8                	add    %ebx,%eax
     465:	0f b6 18             	movzbl (%eax),%ebx
     468:	89 c8                	mov    %ecx,%eax
     46a:	c1 e0 02             	shl    $0x2,%eax
     46d:	01 c8                	add    %ecx,%eax
     46f:	c1 e0 04             	shl    $0x4,%eax
     472:	01 d0                	add    %edx,%eax
     474:	05 c0 1d 01 00       	add    $0x11dc0,%eax
     479:	88 18                	mov    %bl,(%eax)
                if (char_index >= CHARS) {
     47b:	a1 a4 ef 00 00       	mov    0xefa4,%eax
     480:	83 f8 4f             	cmp    $0x4f,%eax
     483:	7e 6c                	jle    4f1 <string_printer+0x25c>
                    line_index++;
     485:	a1 a0 ef 00 00       	mov    0xefa0,%eax
     48a:	83 c0 01             	add    $0x1,%eax
     48d:	a3 a0 ef 00 00       	mov    %eax,0xefa0
                    if (line_index >= LINES) {
     492:	a1 a0 ef 00 00       	mov    0xefa0,%eax
     497:	83 f8 13             	cmp    $0x13,%eax
     49a:	7e 14                	jle    4b0 <string_printer+0x21b>
                        isFull = 1;
     49c:	c7 05 b4 ef 00 00 01 	movl   $0x1,0xefb4
     4a3:	00 00 00 
                        line_index = 0;
     4a6:	c7 05 a0 ef 00 00 00 	movl   $0x0,0xefa0
     4ad:	00 00 00 
                    }
                    char_index = 0;
     4b0:	c7 05 a4 ef 00 00 00 	movl   $0x0,0xefa4
     4b7:	00 00 00 
                    linehis_index++;
     4ba:	a1 a8 ef 00 00       	mov    0xefa8,%eax
     4bf:	83 c0 01             	add    $0x1,%eax
     4c2:	a3 a8 ef 00 00       	mov    %eax,0xefa8
                    if (linehis_index >= 10 * LINES) {
     4c7:	a1 a8 ef 00 00       	mov    0xefa8,%eax
     4cc:	3d c7 00 00 00       	cmp    $0xc7,%eax
     4d1:	7e 14                	jle    4e7 <string_printer+0x252>
                        isHisFull = 1;
     4d3:	c7 05 b8 ef 00 00 01 	movl   $0x1,0xefb8
     4da:	00 00 00 
                        linehis_index = 0;
     4dd:	c7 05 a8 ef 00 00 00 	movl   $0x0,0xefa8
     4e4:	00 00 00 
                    }
                    charhis_index = 0;
     4e7:	c7 05 b0 ef 00 00 00 	movl   $0x0,0xefb0
     4ee:	00 00 00 
            }
        }
    }
    else {
        // Load the read_buf(0..len-1) into the buffer
        for (i = 0; i < len; i++) {
     4f1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     4f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f8:	3b 45 18             	cmp    0x18(%ebp),%eax
     4fb:	0f 8c 36 fe ff ff    	jl     337 <string_printer+0xa2>
                }
            }
        }
    }

    clean_printer(context, 1);
     501:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     508:	00 
     509:	8b 45 08             	mov    0x8(%ebp),%eax
     50c:	89 04 24             	mov    %eax,(%esp)
     50f:	8b 45 0c             	mov    0xc(%ebp),%eax
     512:	89 44 24 04          	mov    %eax,0x4(%esp)
     516:	8b 45 10             	mov    0x10(%ebp),%eax
     519:	89 44 24 08          	mov    %eax,0x8(%esp)
     51d:	e8 63 fb ff ff       	call   85 <clean_printer>
    if (!isFull) {
     522:	a1 b4 ef 00 00       	mov    0xefb4,%eax
     527:	85 c0                	test   %eax,%eax
     529:	0f 85 99 01 00 00    	jne    6c8 <string_printer+0x433>
        // The buffer isn't full.
        // Just print 0..line_index lines to the screen.
        for (i = 0; i <= line_index; i++) {
     52f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     536:	e9 7a 01 00 00       	jmp    6b5 <string_printer+0x420>
            if (i < line_index) {
     53b:	a1 a0 ef 00 00       	mov    0xefa0,%eax
     540:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     543:	7d 58                	jge    59d <string_printer+0x308>
                puts_str(context, printer_buf[i], CHARCOLOR,
                    LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
     545:	8b 55 f4             	mov    -0xc(%ebp),%edx
     548:	89 d0                	mov    %edx,%eax
     54a:	c1 e0 02             	shl    $0x2,%eax
     54d:	01 d0                	add    %edx,%eax
     54f:	c1 e0 02             	shl    $0x2,%eax
    if (!isFull) {
        // The buffer isn't full.
        // Just print 0..line_index lines to the screen.
        for (i = 0; i <= line_index; i++) {
            if (i < line_index) {
                puts_str(context, printer_buf[i], CHARCOLOR,
     552:	8d 48 16             	lea    0x16(%eax),%ecx
     555:	8b 55 f4             	mov    -0xc(%ebp),%edx
     558:	89 d0                	mov    %edx,%eax
     55a:	c1 e0 02             	shl    $0x2,%eax
     55d:	01 d0                	add    %edx,%eax
     55f:	c1 e0 04             	shl    $0x4,%eax
     562:	05 80 64 01 00       	add    $0x16480,%eax
     567:	89 4c 24 18          	mov    %ecx,0x18(%esp)
     56b:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
     572:	00 
     573:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
     57a:	00 
     57b:	89 44 24 0c          	mov    %eax,0xc(%esp)
     57f:	8b 45 08             	mov    0x8(%ebp),%eax
     582:	89 04 24             	mov    %eax,(%esp)
     585:	8b 45 0c             	mov    0xc(%ebp),%eax
     588:	89 44 24 04          	mov    %eax,0x4(%esp)
     58c:	8b 45 10             	mov    0x10(%ebp),%eax
     58f:	89 44 24 08          	mov    %eax,0x8(%esp)
     593:	e8 d6 25 00 00       	call   2b6e <puts_str>
     598:	e9 14 01 00 00       	jmp    6b1 <string_printer+0x41c>
                    LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
            }
            else {
                int line_len = strlen(printer_buf[i]);
     59d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     5a0:	89 d0                	mov    %edx,%eax
     5a2:	c1 e0 02             	shl    $0x2,%eax
     5a5:	01 d0                	add    %edx,%eax
     5a7:	c1 e0 04             	shl    $0x4,%eax
     5aa:	05 80 64 01 00       	add    $0x16480,%eax
     5af:	89 04 24             	mov    %eax,(%esp)
     5b2:	e8 93 3e 00 00       	call   444a <strlen>
     5b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                int k;
                for (k = 0; k < line_len; k++)
     5ba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     5c1:	e9 df 00 00 00       	jmp    6a5 <string_printer+0x410>
                {
                    if (k < line_len - 1)
     5c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5c9:	83 e8 01             	sub    $0x1,%eax
     5cc:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     5cf:	7e 69                	jle    63a <string_printer+0x3a5>
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
     5d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     5d4:	89 d0                	mov    %edx,%eax
     5d6:	c1 e0 02             	shl    $0x2,%eax
     5d9:	01 d0                	add    %edx,%eax
     5db:	c1 e0 02             	shl    $0x2,%eax
                int k;
                for (k = 0; k < line_len; k++)
                {
                    if (k < line_len - 1)
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
     5de:	8d 58 16             	lea    0x16(%eax),%ebx
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
     5e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     5e4:	83 c0 01             	add    $0x1,%eax
                int k;
                for (k = 0; k < line_len; k++)
                {
                    if (k < line_len - 1)
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
     5e7:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     5ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
     5f1:	89 d0                	mov    %edx,%eax
     5f3:	c1 e0 02             	shl    $0x2,%eax
     5f6:	01 d0                	add    %edx,%eax
     5f8:	c1 e0 04             	shl    $0x4,%eax
     5fb:	8b 55 ec             	mov    -0x14(%ebp),%edx
     5fe:	01 d0                	add    %edx,%eax
     600:	05 80 64 01 00       	add    $0x16480,%eax
     605:	0f b6 00             	movzbl (%eax),%eax
     608:	0f be c0             	movsbl %al,%eax
     60b:	89 5c 24 18          	mov    %ebx,0x18(%esp)
     60f:	89 4c 24 14          	mov    %ecx,0x14(%esp)
     613:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
     61a:	00 
     61b:	89 44 24 0c          	mov    %eax,0xc(%esp)
     61f:	8b 45 08             	mov    0x8(%ebp),%eax
     622:	89 04 24             	mov    %eax,(%esp)
     625:	8b 45 0c             	mov    0xc(%ebp),%eax
     628:	89 44 24 04          	mov    %eax,0x4(%esp)
     62c:	8b 45 10             	mov    0x10(%ebp),%eax
     62f:	89 44 24 08          	mov    %eax,0x8(%esp)
     633:	e8 ba 25 00 00       	call   2bf2 <put_str>
     638:	eb 67                	jmp    6a1 <string_printer+0x40c>
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
     63a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     63d:	89 d0                	mov    %edx,%eax
     63f:	c1 e0 02             	shl    $0x2,%eax
     642:	01 d0                	add    %edx,%eax
     644:	c1 e0 02             	shl    $0x2,%eax
                        put_str(context, printer_buf[i][k], CHARCOLOR,
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
     647:	8d 58 16             	lea    0x16(%eax),%ebx
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
     64a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     64d:	83 c0 01             	add    $0x1,%eax
                        put_str(context, printer_buf[i][k], CHARCOLOR,
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
     650:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     657:	8b 55 f4             	mov    -0xc(%ebp),%edx
     65a:	89 d0                	mov    %edx,%eax
     65c:	c1 e0 02             	shl    $0x2,%eax
     65f:	01 d0                	add    %edx,%eax
     661:	c1 e0 04             	shl    $0x4,%eax
     664:	8b 55 ec             	mov    -0x14(%ebp),%edx
     667:	01 d0                	add    %edx,%eax
     669:	05 80 64 01 00       	add    $0x16480,%eax
     66e:	0f b6 00             	movzbl (%eax),%eax
     671:	0f be c0             	movsbl %al,%eax
     674:	89 5c 24 18          	mov    %ebx,0x18(%esp)
     678:	89 4c 24 14          	mov    %ecx,0x14(%esp)
     67c:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
     683:	00 
     684:	89 44 24 0c          	mov    %eax,0xc(%esp)
     688:	8b 45 08             	mov    0x8(%ebp),%eax
     68b:	89 04 24             	mov    %eax,(%esp)
     68e:	8b 45 0c             	mov    0xc(%ebp),%eax
     691:	89 44 24 04          	mov    %eax,0x4(%esp)
     695:	8b 45 10             	mov    0x10(%ebp),%eax
     698:	89 44 24 08          	mov    %eax,0x8(%esp)
     69c:	e8 51 25 00 00       	call   2bf2 <put_str>
                    LEFTWIDTH, CHARHEIGHT * i + HEADERHEIGHT);
            }
            else {
                int line_len = strlen(printer_buf[i]);
                int k;
                for (k = 0; k < line_len; k++)
     6a1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     6a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6a8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
     6ab:	0f 8c 15 ff ff ff    	jl     5c6 <string_printer+0x331>

    clean_printer(context, 1);
    if (!isFull) {
        // The buffer isn't full.
        // Just print 0..line_index lines to the screen.
        for (i = 0; i <= line_index; i++) {
     6b1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     6b5:	a1 a0 ef 00 00       	mov    0xefa0,%eax
     6ba:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     6bd:	0f 8e 78 fe ff ff    	jle    53b <string_printer+0x2a6>
     6c3:	e9 f9 01 00 00       	jmp    8c1 <string_printer+0x62c>
        }
    }
    else {
        // The buffer is full.
        // Print (line_index+1)..LINES, 0..line_index lines to the screen.
        for (i = (line_index + 1) % LINES, j = 0; j < LINES; i = (i + 1) % LINES, j++) {
     6c8:	a1 a0 ef 00 00       	mov    0xefa0,%eax
     6cd:	8d 48 01             	lea    0x1(%eax),%ecx
     6d0:	ba 67 66 66 66       	mov    $0x66666667,%edx
     6d5:	89 c8                	mov    %ecx,%eax
     6d7:	f7 ea                	imul   %edx
     6d9:	c1 fa 03             	sar    $0x3,%edx
     6dc:	89 c8                	mov    %ecx,%eax
     6de:	c1 f8 1f             	sar    $0x1f,%eax
     6e1:	29 c2                	sub    %eax,%edx
     6e3:	89 d0                	mov    %edx,%eax
     6e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6eb:	89 d0                	mov    %edx,%eax
     6ed:	c1 e0 02             	shl    $0x2,%eax
     6f0:	01 d0                	add    %edx,%eax
     6f2:	c1 e0 02             	shl    $0x2,%eax
     6f5:	29 c1                	sub    %eax,%ecx
     6f7:	89 c8                	mov    %ecx,%eax
     6f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6fc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     703:	e9 af 01 00 00       	jmp    8b7 <string_printer+0x622>
            if (j < line_index - 1) {
     708:	a1 a0 ef 00 00       	mov    0xefa0,%eax
     70d:	83 e8 01             	sub    $0x1,%eax
     710:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     713:	7e 58                	jle    76d <string_printer+0x4d8>
                puts_str(context, printer_buf[i], CHARCOLOR,
                    LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
     715:	8b 55 f0             	mov    -0x10(%ebp),%edx
     718:	89 d0                	mov    %edx,%eax
     71a:	c1 e0 02             	shl    $0x2,%eax
     71d:	01 d0                	add    %edx,%eax
     71f:	c1 e0 02             	shl    $0x2,%eax
    else {
        // The buffer is full.
        // Print (line_index+1)..LINES, 0..line_index lines to the screen.
        for (i = (line_index + 1) % LINES, j = 0; j < LINES; i = (i + 1) % LINES, j++) {
            if (j < line_index - 1) {
                puts_str(context, printer_buf[i], CHARCOLOR,
     722:	8d 48 16             	lea    0x16(%eax),%ecx
     725:	8b 55 f4             	mov    -0xc(%ebp),%edx
     728:	89 d0                	mov    %edx,%eax
     72a:	c1 e0 02             	shl    $0x2,%eax
     72d:	01 d0                	add    %edx,%eax
     72f:	c1 e0 04             	shl    $0x4,%eax
     732:	05 80 64 01 00       	add    $0x16480,%eax
     737:	89 4c 24 18          	mov    %ecx,0x18(%esp)
     73b:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
     742:	00 
     743:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
     74a:	00 
     74b:	89 44 24 0c          	mov    %eax,0xc(%esp)
     74f:	8b 45 08             	mov    0x8(%ebp),%eax
     752:	89 04 24             	mov    %eax,(%esp)
     755:	8b 45 0c             	mov    0xc(%ebp),%eax
     758:	89 44 24 04          	mov    %eax,0x4(%esp)
     75c:	8b 45 10             	mov    0x10(%ebp),%eax
     75f:	89 44 24 08          	mov    %eax,0x8(%esp)
     763:	e8 06 24 00 00       	call   2b6e <puts_str>
     768:	e9 14 01 00 00       	jmp    881 <string_printer+0x5ec>
                    LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
            }
            else {
                int line_len = strlen(printer_buf[i]);
     76d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     770:	89 d0                	mov    %edx,%eax
     772:	c1 e0 02             	shl    $0x2,%eax
     775:	01 d0                	add    %edx,%eax
     777:	c1 e0 04             	shl    $0x4,%eax
     77a:	05 80 64 01 00       	add    $0x16480,%eax
     77f:	89 04 24             	mov    %eax,(%esp)
     782:	e8 c3 3c 00 00       	call   444a <strlen>
     787:	89 45 e0             	mov    %eax,-0x20(%ebp)
                int k;
                for (k = 0; k < line_len; k++)
     78a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
     791:	e9 df 00 00 00       	jmp    875 <string_printer+0x5e0>
                {
                    if (k < line_len - 1)
     796:	8b 45 e0             	mov    -0x20(%ebp),%eax
     799:	83 e8 01             	sub    $0x1,%eax
     79c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     79f:	7e 69                	jle    80a <string_printer+0x575>
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
     7a1:	8b 55 f0             	mov    -0x10(%ebp),%edx
     7a4:	89 d0                	mov    %edx,%eax
     7a6:	c1 e0 02             	shl    $0x2,%eax
     7a9:	01 d0                	add    %edx,%eax
     7ab:	c1 e0 02             	shl    $0x2,%eax
                int k;
                for (k = 0; k < line_len; k++)
                {
                    if (k < line_len - 1)
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
     7ae:	8d 58 16             	lea    0x16(%eax),%ebx
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
     7b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7b4:	83 c0 01             	add    $0x1,%eax
                int k;
                for (k = 0; k < line_len; k++)
                {
                    if (k < line_len - 1)
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
     7b7:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     7be:	8b 55 f4             	mov    -0xc(%ebp),%edx
     7c1:	89 d0                	mov    %edx,%eax
     7c3:	c1 e0 02             	shl    $0x2,%eax
     7c6:	01 d0                	add    %edx,%eax
     7c8:	c1 e0 04             	shl    $0x4,%eax
     7cb:	8b 55 e8             	mov    -0x18(%ebp),%edx
     7ce:	01 d0                	add    %edx,%eax
     7d0:	05 80 64 01 00       	add    $0x16480,%eax
     7d5:	0f b6 00             	movzbl (%eax),%eax
     7d8:	0f be c0             	movsbl %al,%eax
     7db:	89 5c 24 18          	mov    %ebx,0x18(%esp)
     7df:	89 4c 24 14          	mov    %ecx,0x14(%esp)
     7e3:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
     7ea:	00 
     7eb:	89 44 24 0c          	mov    %eax,0xc(%esp)
     7ef:	8b 45 08             	mov    0x8(%ebp),%eax
     7f2:	89 04 24             	mov    %eax,(%esp)
     7f5:	8b 45 0c             	mov    0xc(%ebp),%eax
     7f8:	89 44 24 04          	mov    %eax,0x4(%esp)
     7fc:	8b 45 10             	mov    0x10(%ebp),%eax
     7ff:	89 44 24 08          	mov    %eax,0x8(%esp)
     803:	e8 ea 23 00 00       	call   2bf2 <put_str>
     808:	eb 67                	jmp    871 <string_printer+0x5dc>
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
     80a:	8b 55 f0             	mov    -0x10(%ebp),%edx
     80d:	89 d0                	mov    %edx,%eax
     80f:	c1 e0 02             	shl    $0x2,%eax
     812:	01 d0                	add    %edx,%eax
     814:	c1 e0 02             	shl    $0x2,%eax
                        put_str(context, printer_buf[i][k], CHARCOLOR,
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
     817:	8d 58 16             	lea    0x16(%eax),%ebx
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
     81a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     81d:	83 c0 01             	add    $0x1,%eax
                        put_str(context, printer_buf[i][k], CHARCOLOR,
                            CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, printer_buf[i][k], CHARCOLOR,
     820:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     827:	8b 55 f4             	mov    -0xc(%ebp),%edx
     82a:	89 d0                	mov    %edx,%eax
     82c:	c1 e0 02             	shl    $0x2,%eax
     82f:	01 d0                	add    %edx,%eax
     831:	c1 e0 04             	shl    $0x4,%eax
     834:	8b 55 e8             	mov    -0x18(%ebp),%edx
     837:	01 d0                	add    %edx,%eax
     839:	05 80 64 01 00       	add    $0x16480,%eax
     83e:	0f b6 00             	movzbl (%eax),%eax
     841:	0f be c0             	movsbl %al,%eax
     844:	89 5c 24 18          	mov    %ebx,0x18(%esp)
     848:	89 4c 24 14          	mov    %ecx,0x14(%esp)
     84c:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
     853:	00 
     854:	89 44 24 0c          	mov    %eax,0xc(%esp)
     858:	8b 45 08             	mov    0x8(%ebp),%eax
     85b:	89 04 24             	mov    %eax,(%esp)
     85e:	8b 45 0c             	mov    0xc(%ebp),%eax
     861:	89 44 24 04          	mov    %eax,0x4(%esp)
     865:	8b 45 10             	mov    0x10(%ebp),%eax
     868:	89 44 24 08          	mov    %eax,0x8(%esp)
     86c:	e8 81 23 00 00       	call   2bf2 <put_str>
                    LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
            }
            else {
                int line_len = strlen(printer_buf[i]);
                int k;
                for (k = 0; k < line_len; k++)
     871:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
     875:	8b 45 e8             	mov    -0x18(%ebp),%eax
     878:	3b 45 e0             	cmp    -0x20(%ebp),%eax
     87b:	0f 8c 15 ff ff ff    	jl     796 <string_printer+0x501>
        }
    }
    else {
        // The buffer is full.
        // Print (line_index+1)..LINES, 0..line_index lines to the screen.
        for (i = (line_index + 1) % LINES, j = 0; j < LINES; i = (i + 1) % LINES, j++) {
     881:	8b 45 f4             	mov    -0xc(%ebp),%eax
     884:	8d 48 01             	lea    0x1(%eax),%ecx
     887:	ba 67 66 66 66       	mov    $0x66666667,%edx
     88c:	89 c8                	mov    %ecx,%eax
     88e:	f7 ea                	imul   %edx
     890:	c1 fa 03             	sar    $0x3,%edx
     893:	89 c8                	mov    %ecx,%eax
     895:	c1 f8 1f             	sar    $0x1f,%eax
     898:	29 c2                	sub    %eax,%edx
     89a:	89 d0                	mov    %edx,%eax
     89c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     89f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     8a2:	89 d0                	mov    %edx,%eax
     8a4:	c1 e0 02             	shl    $0x2,%eax
     8a7:	01 d0                	add    %edx,%eax
     8a9:	c1 e0 02             	shl    $0x2,%eax
     8ac:	29 c1                	sub    %eax,%ecx
     8ae:	89 c8                	mov    %ecx,%eax
     8b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8b3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8b7:	83 7d f0 13          	cmpl   $0x13,-0x10(%ebp)
     8bb:	0f 8e 47 fe ff ff    	jle    708 <string_printer+0x473>
                    }
                }
            }
        }
    }
    curHisLine = linehis_index;
     8c1:	a1 a8 ef 00 00       	mov    0xefa8,%eax
     8c6:	a3 ac ef 00 00       	mov    %eax,0xefac
}
     8cb:	83 c4 44             	add    $0x44,%esp
     8ce:	5b                   	pop    %ebx
     8cf:	5d                   	pop    %ebp
     8d0:	c3                   	ret    

000008d1 <init_window>:


// Initialize the windowinfo
void
init_window(struct windowinfo* winfo, char* title)
{
     8d1:	55                   	push   %ebp
     8d2:	89 e5                	mov    %esp,%ebp
     8d4:	83 ec 28             	sub    $0x28,%esp
    winfo->id = init_context(&(winfo->context),
     8d7:	8b 45 08             	mov    0x8(%ebp),%eax
     8da:	83 c0 20             	add    $0x20,%eax
     8dd:	c7 44 24 08 bc 01 00 	movl   $0x1bc,0x8(%esp)
     8e4:	00 
     8e5:	c7 44 24 04 90 02 00 	movl   $0x290,0x4(%esp)
     8ec:	00 
     8ed:	89 04 24             	mov    %eax,(%esp)
     8f0:	e8 ae 1b 00 00       	call   24a3 <init_context>
     8f5:	8b 55 08             	mov    0x8(%ebp),%edx
     8f8:	89 02                	mov    %eax,(%edx)
            CHARS*CHARWIDTH + LEFTWIDTH + RIGHTWIDTH,
            LINES*CHARHEIGHT + HEADERHEIGHT + FOOTERHEIGHT);
    fill_rect(winfo->context, 0, 0,
            (winfo->context).width, (winfo->context).height, BACKGROUNDCOLOR);
     8fa:	8b 45 08             	mov    0x8(%ebp),%eax
     8fd:	8b 40 28             	mov    0x28(%eax),%eax
init_window(struct windowinfo* winfo, char* title)
{
    winfo->id = init_context(&(winfo->context),
            CHARS*CHARWIDTH + LEFTWIDTH + RIGHTWIDTH,
            LINES*CHARHEIGHT + HEADERHEIGHT + FOOTERHEIGHT);
    fill_rect(winfo->context, 0, 0,
     900:	89 c2                	mov    %eax,%edx
            (winfo->context).width, (winfo->context).height, BACKGROUNDCOLOR);
     902:	8b 45 08             	mov    0x8(%ebp),%eax
     905:	8b 40 24             	mov    0x24(%eax),%eax
init_window(struct windowinfo* winfo, char* title)
{
    winfo->id = init_context(&(winfo->context),
            CHARS*CHARWIDTH + LEFTWIDTH + RIGHTWIDTH,
            LINES*CHARHEIGHT + HEADERHEIGHT + FOOTERHEIGHT);
    fill_rect(winfo->context, 0, 0,
     908:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     90f:	00 
     910:	89 54 24 18          	mov    %edx,0x18(%esp)
     914:	89 44 24 14          	mov    %eax,0x14(%esp)
     918:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     91f:	00 
     920:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     927:	00 
     928:	8b 45 08             	mov    0x8(%ebp),%eax
     92b:	8b 50 20             	mov    0x20(%eax),%edx
     92e:	89 14 24             	mov    %edx,(%esp)
     931:	8b 50 24             	mov    0x24(%eax),%edx
     934:	89 54 24 04          	mov    %edx,0x4(%esp)
     938:	8b 40 28             	mov    0x28(%eax),%eax
     93b:	89 44 24 08          	mov    %eax,0x8(%esp)
     93f:	e8 4b 1c 00 00       	call   258f <fill_rect>
            (winfo->context).width, (winfo->context).height, BACKGROUNDCOLOR);
    draw_window2(winfo->context, title, 11, RED);
     944:	c7 44 24 14 00 f0 00 	movl   $0xf000,0x14(%esp)
     94b:	00 
     94c:	c7 44 24 10 0b 00 00 	movl   $0xb,0x10(%esp)
     953:	00 
     954:	8b 45 0c             	mov    0xc(%ebp),%eax
     957:	89 44 24 0c          	mov    %eax,0xc(%esp)
     95b:	8b 45 08             	mov    0x8(%ebp),%eax
     95e:	8b 50 20             	mov    0x20(%eax),%edx
     961:	89 14 24             	mov    %edx,(%esp)
     964:	8b 50 24             	mov    0x24(%eax),%edx
     967:	89 54 24 04          	mov    %edx,0x4(%esp)
     96b:	8b 40 28             	mov    0x28(%eax),%eax
     96e:	89 44 24 08          	mov    %eax,0x8(%esp)
     972:	e8 75 27 00 00       	call   30ec <draw_window2>
}
     977:	c9                   	leave  
     978:	c3                   	ret    

00000979 <create_shell>:

// Create the sh to run the command and build pipe between the gui and the sh.
void
create_shell(int* p_pid, int* p_rfd, int* p_wfd)
{
     979:	55                   	push   %ebp
     97a:	89 e5                	mov    %esp,%ebp
     97c:	83 ec 38             	sub    $0x38,%esp
    char *sh_argv[] = { "shell_sh", 0, 0 };
     97f:	c7 45 ec 80 ae 00 00 	movl   $0xae80,-0x14(%ebp)
     986:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     98d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char rfd[2], wfd[2];
    int gui2sh_fd[2], sh2gui_fd[2];

    memset(rfd, 0, sizeof(char) * 2);
     994:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
     99b:	00 
     99c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     9a3:	00 
     9a4:	8d 45 ea             	lea    -0x16(%ebp),%eax
     9a7:	89 04 24             	mov    %eax,(%esp)
     9aa:	e8 c2 3a 00 00       	call   4471 <memset>
    memset(wfd, 0, sizeof(char) * 2);
     9af:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
     9b6:	00 
     9b7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     9be:	00 
     9bf:	8d 45 e8             	lea    -0x18(%ebp),%eax
     9c2:	89 04 24             	mov    %eax,(%esp)
     9c5:	e8 a7 3a 00 00       	call   4471 <memset>
    sh_argv[1] = rfd;
     9ca:	8d 45 ea             	lea    -0x16(%ebp),%eax
     9cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    sh_argv[2] = wfd;
     9d0:	8d 45 e8             	lea    -0x18(%ebp),%eax
     9d3:	89 45 f4             	mov    %eax,-0xc(%ebp)

    printf(1, "init pipe: starting pipe\n");
     9d6:	c7 44 24 04 89 ae 00 	movl   $0xae89,0x4(%esp)
     9dd:	00 
     9de:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9e5:	e8 1c 3e 00 00       	call   4806 <printf>
    if (pipe(gui2sh_fd) != 0) {
     9ea:	8d 45 e0             	lea    -0x20(%ebp),%eax
     9ed:	89 04 24             	mov    %eax,(%esp)
     9f0:	e8 39 3c 00 00       	call   462e <pipe>
     9f5:	85 c0                	test   %eax,%eax
     9f7:	74 19                	je     a12 <create_shell+0x99>
        printf(1, "init gui->sh pipe: pipe() failed\n");
     9f9:	c7 44 24 04 a4 ae 00 	movl   $0xaea4,0x4(%esp)
     a00:	00 
     a01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a08:	e8 f9 3d 00 00       	call   4806 <printf>
        exit();
     a0d:	e8 0c 3c 00 00       	call   461e <exit>
    }
    if (pipe(sh2gui_fd) != 0) {
     a12:	8d 45 d8             	lea    -0x28(%ebp),%eax
     a15:	89 04 24             	mov    %eax,(%esp)
     a18:	e8 11 3c 00 00       	call   462e <pipe>
     a1d:	85 c0                	test   %eax,%eax
     a1f:	74 19                	je     a3a <create_shell+0xc1>
        printf(1, "init sh->gui pipe: pipe() failed\n");
     a21:	c7 44 24 04 c8 ae 00 	movl   $0xaec8,0x4(%esp)
     a28:	00 
     a29:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a30:	e8 d1 3d 00 00       	call   4806 <printf>
        exit();
     a35:	e8 e4 3b 00 00       	call   461e <exit>
    }
    printf(1, "init pipe: pipe is ok\n");
     a3a:	c7 44 24 04 ea ae 00 	movl   $0xaeea,0x4(%esp)
     a41:	00 
     a42:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a49:	e8 b8 3d 00 00       	call   4806 <printf>

    printf(1, "init sh: starting sh\n");
     a4e:	c7 44 24 04 01 af 00 	movl   $0xaf01,0x4(%esp)
     a55:	00 
     a56:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a5d:	e8 a4 3d 00 00       	call   4806 <printf>
    *p_pid = fork();
     a62:	e8 af 3b 00 00       	call   4616 <fork>
     a67:	8b 55 08             	mov    0x8(%ebp),%edx
     a6a:	89 02                	mov    %eax,(%edx)
    if (*p_pid < 0) {
     a6c:	8b 45 08             	mov    0x8(%ebp),%eax
     a6f:	8b 00                	mov    (%eax),%eax
     a71:	85 c0                	test   %eax,%eax
     a73:	79 45                	jns    aba <create_shell+0x141>
        printf(1, "init sh: fork failed\n");
     a75:	c7 44 24 04 17 af 00 	movl   $0xaf17,0x4(%esp)
     a7c:	00 
     a7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     a84:	e8 7d 3d 00 00       	call   4806 <printf>
        close(gui2sh_fd[0]);
     a89:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a8c:	89 04 24             	mov    %eax,(%esp)
     a8f:	e8 b2 3b 00 00       	call   4646 <close>
        close(gui2sh_fd[1]);
     a94:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a97:	89 04 24             	mov    %eax,(%esp)
     a9a:	e8 a7 3b 00 00       	call   4646 <close>
        close(sh2gui_fd[0]);
     a9f:	8b 45 d8             	mov    -0x28(%ebp),%eax
     aa2:	89 04 24             	mov    %eax,(%esp)
     aa5:	e8 9c 3b 00 00       	call   4646 <close>
        close(sh2gui_fd[1]);
     aaa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aad:	89 04 24             	mov    %eax,(%esp)
     ab0:	e8 91 3b 00 00       	call   4646 <close>
        exit();
     ab5:	e8 64 3b 00 00       	call   461e <exit>
    }
    else if (*p_pid == 0) {
     aba:	8b 45 08             	mov    0x8(%ebp),%eax
     abd:	8b 00                	mov    (%eax),%eax
     abf:	85 c0                	test   %eax,%eax
     ac1:	75 4e                	jne    b11 <create_shell+0x198>
        close(gui2sh_fd[1]);
     ac3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ac6:	89 04 24             	mov    %eax,(%esp)
     ac9:	e8 78 3b 00 00       	call   4646 <close>
        rfd[0] = (char)gui2sh_fd[0];
     ace:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ad1:	88 45 ea             	mov    %al,-0x16(%ebp)
        close(sh2gui_fd[0]);
     ad4:	8b 45 d8             	mov    -0x28(%ebp),%eax
     ad7:	89 04 24             	mov    %eax,(%esp)
     ada:	e8 67 3b 00 00       	call   4646 <close>
        wfd[0] = (char)sh2gui_fd[1];
     adf:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ae2:	88 45 e8             	mov    %al,-0x18(%ebp)
        exec("shell_sh", sh_argv);
     ae5:	8d 45 ec             	lea    -0x14(%ebp),%eax
     ae8:	89 44 24 04          	mov    %eax,0x4(%esp)
     aec:	c7 04 24 80 ae 00 00 	movl   $0xae80,(%esp)
     af3:	e8 5e 3b 00 00       	call   4656 <exec>
        printf(1, "init sh: exec sh failed\n");
     af8:	c7 44 24 04 2d af 00 	movl   $0xaf2d,0x4(%esp)
     aff:	00 
     b00:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b07:	e8 fa 3c 00 00       	call   4806 <printf>
        exit();
     b0c:	e8 0d 3b 00 00       	call   461e <exit>
    }
    else {
        close(gui2sh_fd[0]);
     b11:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b14:	89 04 24             	mov    %eax,(%esp)
     b17:	e8 2a 3b 00 00       	call   4646 <close>
        *p_wfd = gui2sh_fd[1];
     b1c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     b1f:	8b 45 10             	mov    0x10(%ebp),%eax
     b22:	89 10                	mov    %edx,(%eax)
        close(sh2gui_fd[1]);
     b24:	8b 45 dc             	mov    -0x24(%ebp),%eax
     b27:	89 04 24             	mov    %eax,(%esp)
     b2a:	e8 17 3b 00 00       	call   4646 <close>
        *p_rfd = sh2gui_fd[0];
     b2f:	8b 55 d8             	mov    -0x28(%ebp),%edx
     b32:	8b 45 0c             	mov    0xc(%ebp),%eax
     b35:	89 10                	mov    %edx,(%eax)
    }
}
     b37:	c9                   	leave  
     b38:	c3                   	ret    

00000b39 <init_screen>:

// Initial the screen

void
init_screen(struct Context context, int rfd)
{
     b39:	55                   	push   %ebp
     b3a:	89 e5                	mov    %esp,%ebp
     b3c:	53                   	push   %ebx
     b3d:	83 ec 34             	sub    $0x34,%esp
    int total = 0, single = 0;
     b40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b47:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char tmp_buf[2];

    init_printer();
     b4e:	e8 ad f4 ff ff       	call   0 <init_printer>
    memset(write_cmd, 0, sizeof(char) * COMMANDMAXLEN);
     b53:	c7 44 24 08 00 04 00 	movl   $0x400,0x8(%esp)
     b5a:	00 
     b5b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     b62:	00 
     b63:	c7 04 24 60 5c 01 00 	movl   $0x15c60,(%esp)
     b6a:	e8 02 39 00 00       	call   4471 <memset>
    memset(read_buf, 0, sizeof(char) * READBUFFERSIZE);
     b6f:	c7 44 24 08 00 04 00 	movl   $0x400,0x8(%esp)
     b76:	00 
     b77:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     b7e:	00 
     b7f:	c7 04 24 80 60 01 00 	movl   $0x16080,(%esp)
     b86:	e8 e6 38 00 00       	call   4471 <memset>
    memset(cmd_history, 0, sizeof(char) * 100 * COMMANDMAXLEN);
     b8b:	c7 44 24 08 00 90 01 	movl   $0x19000,0x8(%esp)
     b92:	00 
     b93:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     b9a:	00 
     b9b:	c7 04 24 c0 6a 01 00 	movl   $0x16ac0,(%esp)
     ba2:	e8 ca 38 00 00       	call   4471 <memset>

    // Print the initial string "$ "
    while (total < strlen(init_string)) {
     ba7:	eb 50                	jmp    bf9 <init_screen+0xc0>
        if ((single = read(rfd, tmp_buf, sizeof(tmp_buf))) > 0) {
     ba9:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
     bb0:	00 
     bb1:	8d 45 ee             	lea    -0x12(%ebp),%eax
     bb4:	89 44 24 04          	mov    %eax,0x4(%esp)
     bb8:	8b 45 14             	mov    0x14(%ebp),%eax
     bbb:	89 04 24             	mov    %eax,(%esp)
     bbe:	e8 73 3a 00 00       	call   4636 <read>
     bc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
     bc6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     bca:	7e 2d                	jle    bf9 <init_screen+0xc0>
            total += single;
     bcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bcf:	01 45 f4             	add    %eax,-0xc(%ebp)
            string_printer(context, tmp_buf, single);
     bd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bd5:	89 44 24 10          	mov    %eax,0x10(%esp)
     bd9:	8d 45 ee             	lea    -0x12(%ebp),%eax
     bdc:	89 44 24 0c          	mov    %eax,0xc(%esp)
     be0:	8b 45 08             	mov    0x8(%ebp),%eax
     be3:	89 04 24             	mov    %eax,(%esp)
     be6:	8b 45 0c             	mov    0xc(%ebp),%eax
     be9:	89 44 24 04          	mov    %eax,0x4(%esp)
     bed:	8b 45 10             	mov    0x10(%ebp),%eax
     bf0:	89 44 24 08          	mov    %eax,0x8(%esp)
     bf4:	e8 9c f6 ff ff       	call   295 <string_printer>
    memset(write_cmd, 0, sizeof(char) * COMMANDMAXLEN);
    memset(read_buf, 0, sizeof(char) * READBUFFERSIZE);
    memset(cmd_history, 0, sizeof(char) * 100 * COMMANDMAXLEN);

    // Print the initial string "$ "
    while (total < strlen(init_string)) {
     bf9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     bfc:	c7 04 24 50 ea 00 00 	movl   $0xea50,(%esp)
     c03:	e8 42 38 00 00       	call   444a <strlen>
     c08:	39 c3                	cmp    %eax,%ebx
     c0a:	72 9d                	jb     ba9 <init_screen+0x70>
        if ((single = read(rfd, tmp_buf, sizeof(tmp_buf))) > 0) {
            total += single;
            string_printer(context, tmp_buf, single);
        }
    }
}
     c0c:	83 c4 34             	add    $0x34,%esp
     c0f:	5b                   	pop    %ebx
     c10:	5d                   	pop    %ebp
     c11:	c3                   	ret    

00000c12 <handle_keydown>:

// Deal with the keydown event
void
handle_keydown(struct Context context, char ch, int rfd, int wfd) {
     c12:	55                   	push   %ebp
     c13:	89 e5                	mov    %esp,%ebp
     c15:	53                   	push   %ebx
     c16:	83 ec 64             	sub    $0x64,%esp
     c19:	8b 45 14             	mov    0x14(%ebp),%eax
     c1c:	88 45 c4             	mov    %al,-0x3c(%ebp)
    int n;
    int k = 0;
     c1f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int j;
    if (ch == 8) {
     c26:	0f b6 45 c4          	movzbl -0x3c(%ebp),%eax
     c2a:	3c 08                	cmp    $0x8,%al
     c2c:	75 62                	jne    c90 <handle_keydown+0x7e>
        // ch == 8 is delete. Delete the newest character.
        if (write_index > 0) {
     c2e:	a1 bc ef 00 00       	mov    0xefbc,%eax
     c33:	85 c0                	test   %eax,%eax
     c35:	7e 54                	jle    c8b <handle_keydown+0x79>
            write_cmd[--write_index] = 0;
     c37:	a1 bc ef 00 00       	mov    0xefbc,%eax
     c3c:	83 e8 01             	sub    $0x1,%eax
     c3f:	a3 bc ef 00 00       	mov    %eax,0xefbc
     c44:	a1 bc ef 00 00       	mov    0xefbc,%eax
     c49:	c6 80 60 5c 01 00 00 	movb   $0x0,0x15c60(%eax)
            cur_write = write_index - 1;
     c50:	a1 bc ef 00 00       	mov    0xefbc,%eax
     c55:	83 e8 01             	sub    $0x1,%eax
     c58:	a3 44 ea 00 00       	mov    %eax,0xea44
            string_printer(context, 0, -1);
     c5d:	c7 44 24 10 ff ff ff 	movl   $0xffffffff,0x10(%esp)
     c64:	ff 
     c65:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     c6c:	00 
     c6d:	8b 45 08             	mov    0x8(%ebp),%eax
     c70:	89 04 24             	mov    %eax,(%esp)
     c73:	8b 45 0c             	mov    0xc(%ebp),%eax
     c76:	89 44 24 04          	mov    %eax,0x4(%esp)
     c7a:	8b 45 10             	mov    0x10(%ebp),%eax
     c7d:	89 44 24 08          	mov    %eax,0x8(%esp)
     c81:	e8 0f f6 ff ff       	call   295 <string_printer>
        }
        return;
     c86:	e9 6a 14 00 00       	jmp    20f5 <handle_keydown+0x14e3>
     c8b:	e9 65 14 00 00       	jmp    20f5 <handle_keydown+0x14e3>
    }
    if (ch == '\t')
     c90:	0f b6 45 c4          	movzbl -0x3c(%ebp),%eax
     c94:	3c 09                	cmp    $0x9,%al
     c96:	75 05                	jne    c9d <handle_keydown+0x8b>
    {
        return;
     c98:	e9 58 14 00 00       	jmp    20f5 <handle_keydown+0x14e3>
    }
    //ch = (256 + ch) % 256;
    int nch = ch + 256;
     c9d:	0f b6 45 c4          	movzbl -0x3c(%ebp),%eax
     ca1:	0f be c0             	movsbl %al,%eax
     ca4:	05 00 01 00 00       	add    $0x100,%eax
     ca9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    int line_len; // = strlen(printer_buf[i]);
    if (nch == KEY_UP || nch == KEY_DN || nch == KEY_LF || nch == KEY_RT || nch == KEY_PGUP || nch == KEY_PGDN || nch == KEY_HOME || nch == KEY_END)
     cac:	81 7d f0 e2 00 00 00 	cmpl   $0xe2,-0x10(%ebp)
     cb3:	74 43                	je     cf8 <handle_keydown+0xe6>
     cb5:	81 7d f0 e3 00 00 00 	cmpl   $0xe3,-0x10(%ebp)
     cbc:	74 3a                	je     cf8 <handle_keydown+0xe6>
     cbe:	81 7d f0 e4 00 00 00 	cmpl   $0xe4,-0x10(%ebp)
     cc5:	74 31                	je     cf8 <handle_keydown+0xe6>
     cc7:	81 7d f0 e5 00 00 00 	cmpl   $0xe5,-0x10(%ebp)
     cce:	74 28                	je     cf8 <handle_keydown+0xe6>
     cd0:	81 7d f0 e6 00 00 00 	cmpl   $0xe6,-0x10(%ebp)
     cd7:	74 1f                	je     cf8 <handle_keydown+0xe6>
     cd9:	81 7d f0 e7 00 00 00 	cmpl   $0xe7,-0x10(%ebp)
     ce0:	74 16                	je     cf8 <handle_keydown+0xe6>
     ce2:	81 7d f0 e0 00 00 00 	cmpl   $0xe0,-0x10(%ebp)
     ce9:	74 0d                	je     cf8 <handle_keydown+0xe6>
     ceb:	81 7d f0 e1 00 00 00 	cmpl   $0xe1,-0x10(%ebp)
     cf2:	0f 85 80 11 00 00    	jne    1e78 <handle_keydown+0x1266>
    {
        printf(0, "dd %d\n", ch);
     cf8:	0f b6 45 c4          	movzbl -0x3c(%ebp),%eax
     cfc:	0f be c0             	movsbl %al,%eax
     cff:	89 44 24 08          	mov    %eax,0x8(%esp)
     d03:	c7 44 24 04 46 af 00 	movl   $0xaf46,0x4(%esp)
     d0a:	00 
     d0b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d12:	e8 ef 3a 00 00       	call   4806 <printf>

        switch (nch)
     d17:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d1a:	2d e0 00 00 00       	sub    $0xe0,%eax
     d1f:	83 f8 07             	cmp    $0x7,%eax
     d22:	0f 87 36 11 00 00    	ja     1e5e <handle_keydown+0x124c>
     d28:	8b 04 85 7c af 00 00 	mov    0xaf7c(,%eax,4),%eax
     d2f:	ff e0                	jmp    *%eax
        {
            case KEY_HOME:
            //printf(0, "get ");
                clean_printer(context, 0);
     d31:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     d38:	00 
     d39:	8b 45 08             	mov    0x8(%ebp),%eax
     d3c:	89 04 24             	mov    %eax,(%esp)
     d3f:	8b 45 0c             	mov    0xc(%ebp),%eax
     d42:	89 44 24 04          	mov    %eax,0x4(%esp)
     d46:	8b 45 10             	mov    0x10(%ebp),%eax
     d49:	89 44 24 08          	mov    %eax,0x8(%esp)
     d4d:	e8 33 f3 ff ff       	call   85 <clean_printer>
                if (!isHisFull && linehis_index < LINES)
     d52:	a1 b8 ef 00 00       	mov    0xefb8,%eax
     d57:	85 c0                	test   %eax,%eax
     d59:	75 79                	jne    dd4 <handle_keydown+0x1c2>
     d5b:	a1 a8 ef 00 00       	mov    0xefa8,%eax
     d60:	83 f8 13             	cmp    $0x13,%eax
     d63:	7f 6f                	jg     dd4 <handle_keydown+0x1c2>
                {
                    for (k = 0; k < linehis_index; k++)
     d65:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d6c:	eb 57                	jmp    dc5 <handle_keydown+0x1b3>
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
     d6e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d71:	89 d0                	mov    %edx,%eax
     d73:	c1 e0 02             	shl    $0x2,%eax
     d76:	01 d0                	add    %edx,%eax
     d78:	c1 e0 02             	shl    $0x2,%eax
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
                {
                    for (k = 0; k < linehis_index; k++)
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
     d7b:	8d 48 16             	lea    0x16(%eax),%ecx
     d7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d81:	89 d0                	mov    %edx,%eax
     d83:	c1 e0 02             	shl    $0x2,%eax
     d86:	01 d0                	add    %edx,%eax
     d88:	c1 e0 04             	shl    $0x4,%eax
     d8b:	05 c0 1d 01 00       	add    $0x11dc0,%eax
     d90:	89 4c 24 18          	mov    %ecx,0x18(%esp)
     d94:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
     d9b:	00 
     d9c:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
     da3:	00 
     da4:	89 44 24 0c          	mov    %eax,0xc(%esp)
     da8:	8b 45 08             	mov    0x8(%ebp),%eax
     dab:	89 04 24             	mov    %eax,(%esp)
     dae:	8b 45 0c             	mov    0xc(%ebp),%eax
     db1:	89 44 24 04          	mov    %eax,0x4(%esp)
     db5:	8b 45 10             	mov    0x10(%ebp),%eax
     db8:	89 44 24 08          	mov    %eax,0x8(%esp)
     dbc:	e8 ad 1d 00 00       	call   2b6e <puts_str>
            case KEY_HOME:
            //printf(0, "get ");
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
                {
                    for (k = 0; k < linehis_index; k++)
     dc1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     dc5:	a1 a8 ef 00 00       	mov    0xefa8,%eax
     dca:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     dcd:	7c 9f                	jl     d6e <handle_keydown+0x15c>
        switch (nch)
        {
            case KEY_HOME:
            //printf(0, "get ");
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
     dcf:	e9 0a 01 00 00       	jmp    ede <handle_keydown+0x2cc>
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else if (isHisFull)
     dd4:	a1 b8 ef 00 00       	mov    0xefb8,%eax
     dd9:	85 c0                	test   %eax,%eax
     ddb:	0f 84 97 00 00 00    	je     e78 <handle_keydown+0x266>
                {
                    for (k = 0; k < LINES; k++)
     de1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     de8:	eb 7f                	jmp    e69 <handle_keydown+0x257>
                    {
                        puts_str(context, printer_buf_his[(k + linehis_index + 1) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
     dea:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ded:	89 d0                	mov    %edx,%eax
     def:	c1 e0 02             	shl    $0x2,%eax
     df2:	01 d0                	add    %edx,%eax
     df4:	c1 e0 02             	shl    $0x2,%eax
                }
                else if (isHisFull)
                {
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + linehis_index + 1) % (10 * LINES)], CHARCOLOR,
     df7:	8d 58 16             	lea    0x16(%eax),%ebx
     dfa:	8b 15 a8 ef 00 00    	mov    0xefa8,%edx
     e00:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e03:	01 d0                	add    %edx,%eax
     e05:	8d 48 01             	lea    0x1(%eax),%ecx
     e08:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
     e0d:	89 c8                	mov    %ecx,%eax
     e0f:	f7 ea                	imul   %edx
     e11:	c1 fa 06             	sar    $0x6,%edx
     e14:	89 c8                	mov    %ecx,%eax
     e16:	c1 f8 1f             	sar    $0x1f,%eax
     e19:	29 c2                	sub    %eax,%edx
     e1b:	69 c2 c8 00 00 00    	imul   $0xc8,%edx,%eax
     e21:	29 c1                	sub    %eax,%ecx
     e23:	89 ca                	mov    %ecx,%edx
     e25:	89 d0                	mov    %edx,%eax
     e27:	c1 e0 02             	shl    $0x2,%eax
     e2a:	01 d0                	add    %edx,%eax
     e2c:	c1 e0 04             	shl    $0x4,%eax
     e2f:	05 c0 1d 01 00       	add    $0x11dc0,%eax
     e34:	89 5c 24 18          	mov    %ebx,0x18(%esp)
     e38:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
     e3f:	00 
     e40:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
     e47:	00 
     e48:	89 44 24 0c          	mov    %eax,0xc(%esp)
     e4c:	8b 45 08             	mov    0x8(%ebp),%eax
     e4f:	89 04 24             	mov    %eax,(%esp)
     e52:	8b 45 0c             	mov    0xc(%ebp),%eax
     e55:	89 44 24 04          	mov    %eax,0x4(%esp)
     e59:	8b 45 10             	mov    0x10(%ebp),%eax
     e5c:	89 44 24 08          	mov    %eax,0x8(%esp)
     e60:	e8 09 1d 00 00       	call   2b6e <puts_str>
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else if (isHisFull)
                {
                    for (k = 0; k < LINES; k++)
     e65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e69:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
     e6d:	0f 8e 77 ff ff ff    	jle    dea <handle_keydown+0x1d8>
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                break;
     e73:	e9 fb 0f 00 00       	jmp    1e73 <handle_keydown+0x1261>
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else
                {
                    for (k = 0; k < LINES; k++)
     e78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e7f:	eb 57                	jmp    ed8 <handle_keydown+0x2c6>
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
     e81:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e84:	89 d0                	mov    %edx,%eax
     e86:	c1 e0 02             	shl    $0x2,%eax
     e89:	01 d0                	add    %edx,%eax
     e8b:	c1 e0 02             	shl    $0x2,%eax
                }
                else
                {
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
     e8e:	8d 48 16             	lea    0x16(%eax),%ecx
     e91:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e94:	89 d0                	mov    %edx,%eax
     e96:	c1 e0 02             	shl    $0x2,%eax
     e99:	01 d0                	add    %edx,%eax
     e9b:	c1 e0 04             	shl    $0x4,%eax
     e9e:	05 c0 1d 01 00       	add    $0x11dc0,%eax
     ea3:	89 4c 24 18          	mov    %ecx,0x18(%esp)
     ea7:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
     eae:	00 
     eaf:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
     eb6:	00 
     eb7:	89 44 24 0c          	mov    %eax,0xc(%esp)
     ebb:	8b 45 08             	mov    0x8(%ebp),%eax
     ebe:	89 04 24             	mov    %eax,(%esp)
     ec1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec4:	89 44 24 04          	mov    %eax,0x4(%esp)
     ec8:	8b 45 10             	mov    0x10(%ebp),%eax
     ecb:	89 44 24 08          	mov    %eax,0x8(%esp)
     ecf:	e8 9a 1c 00 00       	call   2b6e <puts_str>
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else
                {
                    for (k = 0; k < LINES; k++)
     ed4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ed8:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
     edc:	7e a3                	jle    e81 <handle_keydown+0x26f>
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                break;
     ede:	e9 90 0f 00 00       	jmp    1e73 <handle_keydown+0x1261>
            case KEY_END:
                clean_printer(context, 0);
     ee3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     eea:	00 
     eeb:	8b 45 08             	mov    0x8(%ebp),%eax
     eee:	89 04 24             	mov    %eax,(%esp)
     ef1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef4:	89 44 24 04          	mov    %eax,0x4(%esp)
     ef8:	8b 45 10             	mov    0x10(%ebp),%eax
     efb:	89 44 24 08          	mov    %eax,0x8(%esp)
     eff:	e8 81 f1 ff ff       	call   85 <clean_printer>
                if (!isHisFull && linehis_index < LINES)
     f04:	a1 b8 ef 00 00       	mov    0xefb8,%eax
     f09:	85 c0                	test   %eax,%eax
     f0b:	75 79                	jne    f86 <handle_keydown+0x374>
     f0d:	a1 a8 ef 00 00       	mov    0xefa8,%eax
     f12:	83 f8 13             	cmp    $0x13,%eax
     f15:	7f 6f                	jg     f86 <handle_keydown+0x374>
                {
                    for (k = 0; k < linehis_index; k++)
     f17:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f1e:	eb 57                	jmp    f77 <handle_keydown+0x365>
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
     f20:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f23:	89 d0                	mov    %edx,%eax
     f25:	c1 e0 02             	shl    $0x2,%eax
     f28:	01 d0                	add    %edx,%eax
     f2a:	c1 e0 02             	shl    $0x2,%eax
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
                {
                    for (k = 0; k < linehis_index; k++)
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
     f2d:	8d 48 16             	lea    0x16(%eax),%ecx
     f30:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f33:	89 d0                	mov    %edx,%eax
     f35:	c1 e0 02             	shl    $0x2,%eax
     f38:	01 d0                	add    %edx,%eax
     f3a:	c1 e0 04             	shl    $0x4,%eax
     f3d:	05 c0 1d 01 00       	add    $0x11dc0,%eax
     f42:	89 4c 24 18          	mov    %ecx,0x18(%esp)
     f46:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
     f4d:	00 
     f4e:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
     f55:	00 
     f56:	89 44 24 0c          	mov    %eax,0xc(%esp)
     f5a:	8b 45 08             	mov    0x8(%ebp),%eax
     f5d:	89 04 24             	mov    %eax,(%esp)
     f60:	8b 45 0c             	mov    0xc(%ebp),%eax
     f63:	89 44 24 04          	mov    %eax,0x4(%esp)
     f67:	8b 45 10             	mov    0x10(%ebp),%eax
     f6a:	89 44 24 08          	mov    %eax,0x8(%esp)
     f6e:	e8 fb 1b 00 00       	call   2b6e <puts_str>
                break;
            case KEY_END:
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
                {
                    for (k = 0; k < linehis_index; k++)
     f73:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f77:	a1 a8 ef 00 00       	mov    0xefa8,%eax
     f7c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     f7f:	7c 9f                	jl     f20 <handle_keydown+0x30e>
                    }
                }
                break;
            case KEY_END:
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
     f81:	e9 36 01 00 00       	jmp    10bc <handle_keydown+0x4aa>
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else if (isHisFull)
     f86:	a1 b8 ef 00 00       	mov    0xefb8,%eax
     f8b:	85 c0                	test   %eax,%eax
     f8d:	0f 84 97 00 00 00    	je     102a <handle_keydown+0x418>
                {
                    for (k = 0; k < LINES; k++)
     f93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f9a:	eb 7f                	jmp    101b <handle_keydown+0x409>
                    {
                        puts_str(context, printer_buf_his[(k + linehis_index - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
     f9c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f9f:	89 d0                	mov    %edx,%eax
     fa1:	c1 e0 02             	shl    $0x2,%eax
     fa4:	01 d0                	add    %edx,%eax
     fa6:	c1 e0 02             	shl    $0x2,%eax
                }
                else if (isHisFull)
                {
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + linehis_index - LINES) % (10 * LINES)], CHARCOLOR,
     fa9:	8d 58 16             	lea    0x16(%eax),%ebx
     fac:	8b 15 a8 ef 00 00    	mov    0xefa8,%edx
     fb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fb5:	01 d0                	add    %edx,%eax
     fb7:	8d 48 ec             	lea    -0x14(%eax),%ecx
     fba:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
     fbf:	89 c8                	mov    %ecx,%eax
     fc1:	f7 ea                	imul   %edx
     fc3:	c1 fa 06             	sar    $0x6,%edx
     fc6:	89 c8                	mov    %ecx,%eax
     fc8:	c1 f8 1f             	sar    $0x1f,%eax
     fcb:	29 c2                	sub    %eax,%edx
     fcd:	69 c2 c8 00 00 00    	imul   $0xc8,%edx,%eax
     fd3:	29 c1                	sub    %eax,%ecx
     fd5:	89 ca                	mov    %ecx,%edx
     fd7:	89 d0                	mov    %edx,%eax
     fd9:	c1 e0 02             	shl    $0x2,%eax
     fdc:	01 d0                	add    %edx,%eax
     fde:	c1 e0 04             	shl    $0x4,%eax
     fe1:	05 c0 1d 01 00       	add    $0x11dc0,%eax
     fe6:	89 5c 24 18          	mov    %ebx,0x18(%esp)
     fea:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
     ff1:	00 
     ff2:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
     ff9:	00 
     ffa:	89 44 24 0c          	mov    %eax,0xc(%esp)
     ffe:	8b 45 08             	mov    0x8(%ebp),%eax
    1001:	89 04 24             	mov    %eax,(%esp)
    1004:	8b 45 0c             	mov    0xc(%ebp),%eax
    1007:	89 44 24 04          	mov    %eax,0x4(%esp)
    100b:	8b 45 10             	mov    0x10(%ebp),%eax
    100e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1012:	e8 57 1b 00 00       	call   2b6e <puts_str>
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else if (isHisFull)
                {
                    for (k = 0; k < LINES; k++)
    1017:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    101b:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    101f:	0f 8e 77 ff ff ff    	jle    f9c <handle_keydown+0x38a>
                    {
                        puts_str(context, printer_buf_his[(k + linehis_index - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                break;
    1025:	e9 49 0e 00 00       	jmp    1e73 <handle_keydown+0x1261>
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else
                {
                    for (k = 0; k < LINES; k++)
    102a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1031:	eb 7f                	jmp    10b2 <handle_keydown+0x4a0>
                    {
                        puts_str(context, printer_buf_his[(k + linehis_index - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
    1033:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1036:	89 d0                	mov    %edx,%eax
    1038:	c1 e0 02             	shl    $0x2,%eax
    103b:	01 d0                	add    %edx,%eax
    103d:	c1 e0 02             	shl    $0x2,%eax
                }
                else
                {
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + linehis_index - LINES) % (10 * LINES)], CHARCOLOR,
    1040:	8d 58 16             	lea    0x16(%eax),%ebx
    1043:	8b 15 a8 ef 00 00    	mov    0xefa8,%edx
    1049:	8b 45 f4             	mov    -0xc(%ebp),%eax
    104c:	01 d0                	add    %edx,%eax
    104e:	8d 48 ec             	lea    -0x14(%eax),%ecx
    1051:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    1056:	89 c8                	mov    %ecx,%eax
    1058:	f7 ea                	imul   %edx
    105a:	c1 fa 06             	sar    $0x6,%edx
    105d:	89 c8                	mov    %ecx,%eax
    105f:	c1 f8 1f             	sar    $0x1f,%eax
    1062:	29 c2                	sub    %eax,%edx
    1064:	69 c2 c8 00 00 00    	imul   $0xc8,%edx,%eax
    106a:	29 c1                	sub    %eax,%ecx
    106c:	89 ca                	mov    %ecx,%edx
    106e:	89 d0                	mov    %edx,%eax
    1070:	c1 e0 02             	shl    $0x2,%eax
    1073:	01 d0                	add    %edx,%eax
    1075:	c1 e0 04             	shl    $0x4,%eax
    1078:	05 c0 1d 01 00       	add    $0x11dc0,%eax
    107d:	89 5c 24 18          	mov    %ebx,0x18(%esp)
    1081:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
    1088:	00 
    1089:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1090:	00 
    1091:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1095:	8b 45 08             	mov    0x8(%ebp),%eax
    1098:	89 04 24             	mov    %eax,(%esp)
    109b:	8b 45 0c             	mov    0xc(%ebp),%eax
    109e:	89 44 24 04          	mov    %eax,0x4(%esp)
    10a2:	8b 45 10             	mov    0x10(%ebp),%eax
    10a5:	89 44 24 08          	mov    %eax,0x8(%esp)
    10a9:	e8 c0 1a 00 00       	call   2b6e <puts_str>
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else
                {
                    for (k = 0; k < LINES; k++)
    10ae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10b2:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    10b6:	0f 8e 77 ff ff ff    	jle    1033 <handle_keydown+0x421>
                    {
                        puts_str(context, printer_buf_his[(k + linehis_index - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                break;
    10bc:	e9 b2 0d 00 00       	jmp    1e73 <handle_keydown+0x1261>
            case KEY_PGUP:
                if (curHisLine <= LINES)
    10c1:	a1 ac ef 00 00       	mov    0xefac,%eax
    10c6:	83 f8 14             	cmp    $0x14,%eax
    10c9:	7f 05                	jg     10d0 <handle_keydown+0x4be>
                {
                    break;
    10cb:	e9 a3 0d 00 00       	jmp    1e73 <handle_keydown+0x1261>
                }
                clean_printer(context, 0);
    10d0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    10d7:	00 
    10d8:	8b 45 08             	mov    0x8(%ebp),%eax
    10db:	89 04 24             	mov    %eax,(%esp)
    10de:	8b 45 0c             	mov    0xc(%ebp),%eax
    10e1:	89 44 24 04          	mov    %eax,0x4(%esp)
    10e5:	8b 45 10             	mov    0x10(%ebp),%eax
    10e8:	89 44 24 08          	mov    %eax,0x8(%esp)
    10ec:	e8 94 ef ff ff       	call   85 <clean_printer>
                if (!isHisFull && linehis_index < LINES)
    10f1:	a1 b8 ef 00 00       	mov    0xefb8,%eax
    10f6:	85 c0                	test   %eax,%eax
    10f8:	75 79                	jne    1173 <handle_keydown+0x561>
    10fa:	a1 a8 ef 00 00       	mov    0xefa8,%eax
    10ff:	83 f8 13             	cmp    $0x13,%eax
    1102:	7f 6f                	jg     1173 <handle_keydown+0x561>
                {
                    for (k = 0; k < linehis_index; k++)
    1104:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    110b:	eb 57                	jmp    1164 <handle_keydown+0x552>
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
    110d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1110:	89 d0                	mov    %edx,%eax
    1112:	c1 e0 02             	shl    $0x2,%eax
    1115:	01 d0                	add    %edx,%eax
    1117:	c1 e0 02             	shl    $0x2,%eax
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
                {
                    for (k = 0; k < linehis_index; k++)
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
    111a:	8d 48 16             	lea    0x16(%eax),%ecx
    111d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1120:	89 d0                	mov    %edx,%eax
    1122:	c1 e0 02             	shl    $0x2,%eax
    1125:	01 d0                	add    %edx,%eax
    1127:	c1 e0 04             	shl    $0x4,%eax
    112a:	05 c0 1d 01 00       	add    $0x11dc0,%eax
    112f:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    1133:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
    113a:	00 
    113b:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1142:	00 
    1143:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1147:	8b 45 08             	mov    0x8(%ebp),%eax
    114a:	89 04 24             	mov    %eax,(%esp)
    114d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1150:	89 44 24 04          	mov    %eax,0x4(%esp)
    1154:	8b 45 10             	mov    0x10(%ebp),%eax
    1157:	89 44 24 08          	mov    %eax,0x8(%esp)
    115b:	e8 0e 1a 00 00       	call   2b6e <puts_str>
                    break;
                }
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
                {
                    for (k = 0; k < linehis_index; k++)
    1160:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1164:	a1 a8 ef 00 00       	mov    0xefa8,%eax
    1169:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    116c:	7c 9f                	jl     110d <handle_keydown+0x4fb>
                if (curHisLine <= LINES)
                {
                    break;
                }
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
    116e:	e9 85 01 00 00       	jmp    12f8 <handle_keydown+0x6e6>
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else if (isHisFull)
    1173:	a1 b8 ef 00 00       	mov    0xefb8,%eax
    1178:	85 c0                	test   %eax,%eax
    117a:	0f 84 c3 00 00 00    	je     1243 <handle_keydown+0x631>
                {
                    curHisLine = (curHisLine - LINES) % (10 * LINES);
    1180:	a1 ac ef 00 00       	mov    0xefac,%eax
    1185:	8d 48 ec             	lea    -0x14(%eax),%ecx
    1188:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    118d:	89 c8                	mov    %ecx,%eax
    118f:	f7 ea                	imul   %edx
    1191:	c1 fa 06             	sar    $0x6,%edx
    1194:	89 c8                	mov    %ecx,%eax
    1196:	c1 f8 1f             	sar    $0x1f,%eax
    1199:	29 c2                	sub    %eax,%edx
    119b:	89 d0                	mov    %edx,%eax
    119d:	69 c0 c8 00 00 00    	imul   $0xc8,%eax,%eax
    11a3:	29 c1                	sub    %eax,%ecx
    11a5:	89 c8                	mov    %ecx,%eax
    11a7:	a3 ac ef 00 00       	mov    %eax,0xefac
                    for (k = 0; k < LINES; k++)
    11ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11b3:	eb 7f                	jmp    1234 <handle_keydown+0x622>
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
    11b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11b8:	89 d0                	mov    %edx,%eax
    11ba:	c1 e0 02             	shl    $0x2,%eax
    11bd:	01 d0                	add    %edx,%eax
    11bf:	c1 e0 02             	shl    $0x2,%eax
                else if (isHisFull)
                {
                    curHisLine = (curHisLine - LINES) % (10 * LINES);
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
    11c2:	8d 58 16             	lea    0x16(%eax),%ebx
    11c5:	8b 15 ac ef 00 00    	mov    0xefac,%edx
    11cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ce:	01 d0                	add    %edx,%eax
    11d0:	8d 48 ec             	lea    -0x14(%eax),%ecx
    11d3:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    11d8:	89 c8                	mov    %ecx,%eax
    11da:	f7 ea                	imul   %edx
    11dc:	c1 fa 06             	sar    $0x6,%edx
    11df:	89 c8                	mov    %ecx,%eax
    11e1:	c1 f8 1f             	sar    $0x1f,%eax
    11e4:	29 c2                	sub    %eax,%edx
    11e6:	69 c2 c8 00 00 00    	imul   $0xc8,%edx,%eax
    11ec:	29 c1                	sub    %eax,%ecx
    11ee:	89 ca                	mov    %ecx,%edx
    11f0:	89 d0                	mov    %edx,%eax
    11f2:	c1 e0 02             	shl    $0x2,%eax
    11f5:	01 d0                	add    %edx,%eax
    11f7:	c1 e0 04             	shl    $0x4,%eax
    11fa:	05 c0 1d 01 00       	add    $0x11dc0,%eax
    11ff:	89 5c 24 18          	mov    %ebx,0x18(%esp)
    1203:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
    120a:	00 
    120b:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1212:	00 
    1213:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1217:	8b 45 08             	mov    0x8(%ebp),%eax
    121a:	89 04 24             	mov    %eax,(%esp)
    121d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1220:	89 44 24 04          	mov    %eax,0x4(%esp)
    1224:	8b 45 10             	mov    0x10(%ebp),%eax
    1227:	89 44 24 08          	mov    %eax,0x8(%esp)
    122b:	e8 3e 19 00 00       	call   2b6e <puts_str>
                    }
                }
                else if (isHisFull)
                {
                    curHisLine = (curHisLine - LINES) % (10 * LINES);
                    for (k = 0; k < LINES; k++)
    1230:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1234:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1238:	0f 8e 77 ff ff ff    	jle    11b5 <handle_keydown+0x5a3>
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                break;
    123e:	e9 30 0c 00 00       	jmp    1e73 <handle_keydown+0x1261>
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else
                {
                    if (curHisLine > LINES * 2)
    1243:	a1 ac ef 00 00       	mov    0xefac,%eax
    1248:	83 f8 28             	cmp    $0x28,%eax
    124b:	7e 0f                	jle    125c <handle_keydown+0x64a>
                    {
                        curHisLine = curHisLine - LINES;
    124d:	a1 ac ef 00 00       	mov    0xefac,%eax
    1252:	83 e8 14             	sub    $0x14,%eax
    1255:	a3 ac ef 00 00       	mov    %eax,0xefac
    125a:	eb 0a                	jmp    1266 <handle_keydown+0x654>
                    }
                    else
                    {
                        curHisLine = LINES;
    125c:	c7 05 ac ef 00 00 14 	movl   $0x14,0xefac
    1263:	00 00 00 
                    }
                    for (k = 0; k < LINES; k++)
    1266:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    126d:	eb 7f                	jmp    12ee <handle_keydown+0x6dc>
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
    126f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1272:	89 d0                	mov    %edx,%eax
    1274:	c1 e0 02             	shl    $0x2,%eax
    1277:	01 d0                	add    %edx,%eax
    1279:	c1 e0 02             	shl    $0x2,%eax
                    {
                        curHisLine = LINES;
                    }
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
    127c:	8d 58 16             	lea    0x16(%eax),%ebx
    127f:	8b 15 ac ef 00 00    	mov    0xefac,%edx
    1285:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1288:	01 d0                	add    %edx,%eax
    128a:	8d 48 ec             	lea    -0x14(%eax),%ecx
    128d:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    1292:	89 c8                	mov    %ecx,%eax
    1294:	f7 ea                	imul   %edx
    1296:	c1 fa 06             	sar    $0x6,%edx
    1299:	89 c8                	mov    %ecx,%eax
    129b:	c1 f8 1f             	sar    $0x1f,%eax
    129e:	29 c2                	sub    %eax,%edx
    12a0:	69 c2 c8 00 00 00    	imul   $0xc8,%edx,%eax
    12a6:	29 c1                	sub    %eax,%ecx
    12a8:	89 ca                	mov    %ecx,%edx
    12aa:	89 d0                	mov    %edx,%eax
    12ac:	c1 e0 02             	shl    $0x2,%eax
    12af:	01 d0                	add    %edx,%eax
    12b1:	c1 e0 04             	shl    $0x4,%eax
    12b4:	05 c0 1d 01 00       	add    $0x11dc0,%eax
    12b9:	89 5c 24 18          	mov    %ebx,0x18(%esp)
    12bd:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
    12c4:	00 
    12c5:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    12cc:	00 
    12cd:	89 44 24 0c          	mov    %eax,0xc(%esp)
    12d1:	8b 45 08             	mov    0x8(%ebp),%eax
    12d4:	89 04 24             	mov    %eax,(%esp)
    12d7:	8b 45 0c             	mov    0xc(%ebp),%eax
    12da:	89 44 24 04          	mov    %eax,0x4(%esp)
    12de:	8b 45 10             	mov    0x10(%ebp),%eax
    12e1:	89 44 24 08          	mov    %eax,0x8(%esp)
    12e5:	e8 84 18 00 00       	call   2b6e <puts_str>
                    }
                    else
                    {
                        curHisLine = LINES;
                    }
                    for (k = 0; k < LINES; k++)
    12ea:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    12ee:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    12f2:	0f 8e 77 ff ff ff    	jle    126f <handle_keydown+0x65d>
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                break;
    12f8:	e9 76 0b 00 00       	jmp    1e73 <handle_keydown+0x1261>
            case KEY_PGDN:
                if (curHisLine == linehis_index)
    12fd:	8b 15 ac ef 00 00    	mov    0xefac,%edx
    1303:	a1 a8 ef 00 00       	mov    0xefa8,%eax
    1308:	39 c2                	cmp    %eax,%edx
    130a:	75 05                	jne    1311 <handle_keydown+0x6ff>
                {
                    break;
    130c:	e9 62 0b 00 00       	jmp    1e73 <handle_keydown+0x1261>
                }
                clean_printer(context, 0);
    1311:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1318:	00 
    1319:	8b 45 08             	mov    0x8(%ebp),%eax
    131c:	89 04 24             	mov    %eax,(%esp)
    131f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1322:	89 44 24 04          	mov    %eax,0x4(%esp)
    1326:	8b 45 10             	mov    0x10(%ebp),%eax
    1329:	89 44 24 08          	mov    %eax,0x8(%esp)
    132d:	e8 53 ed ff ff       	call   85 <clean_printer>
                if (!isHisFull && linehis_index < LINES)
    1332:	a1 b8 ef 00 00       	mov    0xefb8,%eax
    1337:	85 c0                	test   %eax,%eax
    1339:	75 79                	jne    13b4 <handle_keydown+0x7a2>
    133b:	a1 a8 ef 00 00       	mov    0xefa8,%eax
    1340:	83 f8 13             	cmp    $0x13,%eax
    1343:	7f 6f                	jg     13b4 <handle_keydown+0x7a2>
                {
                    for (k = 0; k < linehis_index; k++)
    1345:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    134c:	eb 57                	jmp    13a5 <handle_keydown+0x793>
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
    134e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1351:	89 d0                	mov    %edx,%eax
    1353:	c1 e0 02             	shl    $0x2,%eax
    1356:	01 d0                	add    %edx,%eax
    1358:	c1 e0 02             	shl    $0x2,%eax
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
                {
                    for (k = 0; k < linehis_index; k++)
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
    135b:	8d 48 16             	lea    0x16(%eax),%ecx
    135e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1361:	89 d0                	mov    %edx,%eax
    1363:	c1 e0 02             	shl    $0x2,%eax
    1366:	01 d0                	add    %edx,%eax
    1368:	c1 e0 04             	shl    $0x4,%eax
    136b:	05 c0 1d 01 00       	add    $0x11dc0,%eax
    1370:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    1374:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
    137b:	00 
    137c:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1383:	00 
    1384:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1388:	8b 45 08             	mov    0x8(%ebp),%eax
    138b:	89 04 24             	mov    %eax,(%esp)
    138e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1391:	89 44 24 04          	mov    %eax,0x4(%esp)
    1395:	8b 45 10             	mov    0x10(%ebp),%eax
    1398:	89 44 24 08          	mov    %eax,0x8(%esp)
    139c:	e8 cd 17 00 00       	call   2b6e <puts_str>
                    break;
                }
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
                {
                    for (k = 0; k < linehis_index; k++)
    13a1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13a5:	a1 a8 ef 00 00       	mov    0xefa8,%eax
    13aa:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    13ad:	7c 9f                	jl     134e <handle_keydown+0x73c>
                if (curHisLine == linehis_index)
                {
                    break;
                }
                clean_printer(context, 0);
                if (!isHisFull && linehis_index < LINES)
    13af:	e9 8f 01 00 00       	jmp    1543 <handle_keydown+0x931>
                    {
                        puts_str(context, printer_buf_his[k], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else if (isHisFull)
    13b4:	a1 b8 ef 00 00       	mov    0xefb8,%eax
    13b9:	85 c0                	test   %eax,%eax
    13bb:	0f 84 c3 00 00 00    	je     1484 <handle_keydown+0x872>
                {
                    curHisLine = (curHisLine + LINES) % (10 * LINES);
    13c1:	a1 ac ef 00 00       	mov    0xefac,%eax
    13c6:	8d 48 14             	lea    0x14(%eax),%ecx
    13c9:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    13ce:	89 c8                	mov    %ecx,%eax
    13d0:	f7 ea                	imul   %edx
    13d2:	c1 fa 06             	sar    $0x6,%edx
    13d5:	89 c8                	mov    %ecx,%eax
    13d7:	c1 f8 1f             	sar    $0x1f,%eax
    13da:	29 c2                	sub    %eax,%edx
    13dc:	89 d0                	mov    %edx,%eax
    13de:	69 c0 c8 00 00 00    	imul   $0xc8,%eax,%eax
    13e4:	29 c1                	sub    %eax,%ecx
    13e6:	89 c8                	mov    %ecx,%eax
    13e8:	a3 ac ef 00 00       	mov    %eax,0xefac
                    for (k = 0; k < LINES; k++)
    13ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13f4:	eb 7f                	jmp    1475 <handle_keydown+0x863>
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
    13f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    13f9:	89 d0                	mov    %edx,%eax
    13fb:	c1 e0 02             	shl    $0x2,%eax
    13fe:	01 d0                	add    %edx,%eax
    1400:	c1 e0 02             	shl    $0x2,%eax
                else if (isHisFull)
                {
                    curHisLine = (curHisLine + LINES) % (10 * LINES);
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
    1403:	8d 58 16             	lea    0x16(%eax),%ebx
    1406:	8b 15 ac ef 00 00    	mov    0xefac,%edx
    140c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    140f:	01 d0                	add    %edx,%eax
    1411:	8d 48 ec             	lea    -0x14(%eax),%ecx
    1414:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    1419:	89 c8                	mov    %ecx,%eax
    141b:	f7 ea                	imul   %edx
    141d:	c1 fa 06             	sar    $0x6,%edx
    1420:	89 c8                	mov    %ecx,%eax
    1422:	c1 f8 1f             	sar    $0x1f,%eax
    1425:	29 c2                	sub    %eax,%edx
    1427:	69 c2 c8 00 00 00    	imul   $0xc8,%edx,%eax
    142d:	29 c1                	sub    %eax,%ecx
    142f:	89 ca                	mov    %ecx,%edx
    1431:	89 d0                	mov    %edx,%eax
    1433:	c1 e0 02             	shl    $0x2,%eax
    1436:	01 d0                	add    %edx,%eax
    1438:	c1 e0 04             	shl    $0x4,%eax
    143b:	05 c0 1d 01 00       	add    $0x11dc0,%eax
    1440:	89 5c 24 18          	mov    %ebx,0x18(%esp)
    1444:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
    144b:	00 
    144c:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1453:	00 
    1454:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1458:	8b 45 08             	mov    0x8(%ebp),%eax
    145b:	89 04 24             	mov    %eax,(%esp)
    145e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1461:	89 44 24 04          	mov    %eax,0x4(%esp)
    1465:	8b 45 10             	mov    0x10(%ebp),%eax
    1468:	89 44 24 08          	mov    %eax,0x8(%esp)
    146c:	e8 fd 16 00 00       	call   2b6e <puts_str>
                    }
                }
                else if (isHisFull)
                {
                    curHisLine = (curHisLine + LINES) % (10 * LINES);
                    for (k = 0; k < LINES; k++)
    1471:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1475:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1479:	0f 8e 77 ff ff ff    	jle    13f6 <handle_keydown+0x7e4>
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                break;
    147f:	e9 ef 09 00 00       	jmp    1e73 <handle_keydown+0x1261>
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                else
                {
                    if (linehis_index - curHisLine >= LINES)
    1484:	8b 15 a8 ef 00 00    	mov    0xefa8,%edx
    148a:	a1 ac ef 00 00       	mov    0xefac,%eax
    148f:	29 c2                	sub    %eax,%edx
    1491:	89 d0                	mov    %edx,%eax
    1493:	83 f8 13             	cmp    $0x13,%eax
    1496:	7e 0f                	jle    14a7 <handle_keydown+0x895>
                    {
                        curHisLine = curHisLine + LINES;
    1498:	a1 ac ef 00 00       	mov    0xefac,%eax
    149d:	83 c0 14             	add    $0x14,%eax
    14a0:	a3 ac ef 00 00       	mov    %eax,0xefac
    14a5:	eb 0a                	jmp    14b1 <handle_keydown+0x89f>
                    }
                    else
                    {
                        curHisLine = linehis_index;
    14a7:	a1 a8 ef 00 00       	mov    0xefa8,%eax
    14ac:	a3 ac ef 00 00       	mov    %eax,0xefac
                    }
                    for (k = 0; k < LINES; k++)
    14b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14b8:	eb 7f                	jmp    1539 <handle_keydown+0x927>
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
    14ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
    14bd:	89 d0                	mov    %edx,%eax
    14bf:	c1 e0 02             	shl    $0x2,%eax
    14c2:	01 d0                	add    %edx,%eax
    14c4:	c1 e0 02             	shl    $0x2,%eax
                    {
                        curHisLine = linehis_index;
                    }
                    for (k = 0; k < LINES; k++)
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
    14c7:	8d 58 16             	lea    0x16(%eax),%ebx
    14ca:	8b 15 ac ef 00 00    	mov    0xefac,%edx
    14d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d3:	01 d0                	add    %edx,%eax
    14d5:	8d 48 ec             	lea    -0x14(%eax),%ecx
    14d8:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    14dd:	89 c8                	mov    %ecx,%eax
    14df:	f7 ea                	imul   %edx
    14e1:	c1 fa 06             	sar    $0x6,%edx
    14e4:	89 c8                	mov    %ecx,%eax
    14e6:	c1 f8 1f             	sar    $0x1f,%eax
    14e9:	29 c2                	sub    %eax,%edx
    14eb:	69 c2 c8 00 00 00    	imul   $0xc8,%edx,%eax
    14f1:	29 c1                	sub    %eax,%ecx
    14f3:	89 ca                	mov    %ecx,%edx
    14f5:	89 d0                	mov    %edx,%eax
    14f7:	c1 e0 02             	shl    $0x2,%eax
    14fa:	01 d0                	add    %edx,%eax
    14fc:	c1 e0 04             	shl    $0x4,%eax
    14ff:	05 c0 1d 01 00       	add    $0x11dc0,%eax
    1504:	89 5c 24 18          	mov    %ebx,0x18(%esp)
    1508:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
    150f:	00 
    1510:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1517:	00 
    1518:	89 44 24 0c          	mov    %eax,0xc(%esp)
    151c:	8b 45 08             	mov    0x8(%ebp),%eax
    151f:	89 04 24             	mov    %eax,(%esp)
    1522:	8b 45 0c             	mov    0xc(%ebp),%eax
    1525:	89 44 24 04          	mov    %eax,0x4(%esp)
    1529:	8b 45 10             	mov    0x10(%ebp),%eax
    152c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1530:	e8 39 16 00 00       	call   2b6e <puts_str>
                    }
                    else
                    {
                        curHisLine = linehis_index;
                    }
                    for (k = 0; k < LINES; k++)
    1535:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1539:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    153d:	0f 8e 77 ff ff ff    	jle    14ba <handle_keydown+0x8a8>
                    {
                        puts_str(context, printer_buf_his[(k + curHisLine - LINES) % (10 * LINES)], CHARCOLOR,
                            LEFTWIDTH, CHARHEIGHT * k + HEADERHEIGHT);
                    }
                }
                break;
    1543:	e9 2b 09 00 00       	jmp    1e73 <handle_keydown+0x1261>
            case KEY_RT:
                if (cur_write >= write_index - 1)
    1548:	a1 bc ef 00 00       	mov    0xefbc,%eax
    154d:	8d 50 ff             	lea    -0x1(%eax),%edx
    1550:	a1 44 ea 00 00       	mov    0xea44,%eax
    1555:	39 c2                	cmp    %eax,%edx
    1557:	7f 05                	jg     155e <handle_keydown+0x94c>
                {
                    break;
    1559:	e9 15 09 00 00       	jmp    1e73 <handle_keydown+0x1261>
                }
                cur_write++;
    155e:	a1 44 ea 00 00       	mov    0xea44,%eax
    1563:	83 c0 01             	add    $0x1,%eax
    1566:	a3 44 ea 00 00       	mov    %eax,0xea44
                j = isFull ? (LINES - 1) : (line_index + 0);
    156b:	a1 b4 ef 00 00       	mov    0xefb4,%eax
    1570:	85 c0                	test   %eax,%eax
    1572:	75 07                	jne    157b <handle_keydown+0x969>
    1574:	a1 a0 ef 00 00       	mov    0xefa0,%eax
    1579:	eb 05                	jmp    1580 <handle_keydown+0x96e>
    157b:	b8 13 00 00 00       	mov    $0x13,%eax
    1580:	89 45 e8             	mov    %eax,-0x18(%ebp)
                cleanline_printer(context, j, 0);
    1583:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    158a:	00 
    158b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    158e:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1592:	8b 45 08             	mov    0x8(%ebp),%eax
    1595:	89 04 24             	mov    %eax,(%esp)
    1598:	8b 45 0c             	mov    0xc(%ebp),%eax
    159b:	89 44 24 04          	mov    %eax,0x4(%esp)
    159f:	8b 45 10             	mov    0x10(%ebp),%eax
    15a2:	89 44 24 08          	mov    %eax,0x8(%esp)
    15a6:	e8 dd eb ff ff       	call   188 <cleanline_printer>
                line_len = strlen(write_cmd);
    15ab:	c7 04 24 60 5c 01 00 	movl   $0x15c60,(%esp)
    15b2:	e8 93 2e 00 00       	call   444a <strlen>
    15b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                //puts_str(context, "$ ", CHARCOLOR,
                //    LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 fill_rect(context, CHARWIDTH * (cur_write + 4), HEADERHEIGHT + CHARHEIGHT * (j + 0), 
    15ba:	8b 55 e8             	mov    -0x18(%ebp),%edx
    15bd:	89 d0                	mov    %edx,%eax
    15bf:	c1 e0 02             	shl    $0x2,%eax
    15c2:	01 d0                	add    %edx,%eax
    15c4:	c1 e0 02             	shl    $0x2,%eax
    15c7:	83 c0 16             	add    $0x16,%eax
    15ca:	89 c2                	mov    %eax,%edx
    15cc:	a1 44 ea 00 00       	mov    0xea44,%eax
    15d1:	83 c0 04             	add    $0x4,%eax
    15d4:	c1 e0 03             	shl    $0x3,%eax
    15d7:	c7 44 24 1c f0 0f 00 	movl   $0xff0,0x1c(%esp)
    15de:	00 
    15df:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    15e6:	00 
    15e7:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
    15ee:	00 
    15ef:	89 54 24 10          	mov    %edx,0x10(%esp)
    15f3:	89 44 24 0c          	mov    %eax,0xc(%esp)
    15f7:	8b 45 08             	mov    0x8(%ebp),%eax
    15fa:	89 04 24             	mov    %eax,(%esp)
    15fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1600:	89 44 24 04          	mov    %eax,0x4(%esp)
    1604:	8b 45 10             	mov    0x10(%ebp),%eax
    1607:	89 44 24 08          	mov    %eax,0x8(%esp)
    160b:	e8 7f 0f 00 00       	call   258f <fill_rect>
                    CHARWIDTH, CHARHEIGHT, CHARCOLOR);
                 put_str(context, '$', CHARCOLOR,
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1610:	8b 55 e8             	mov    -0x18(%ebp),%edx
    1613:	89 d0                	mov    %edx,%eax
    1615:	c1 e0 02             	shl    $0x2,%eax
    1618:	01 d0                	add    %edx,%eax
    161a:	c1 e0 02             	shl    $0x2,%eax
                line_len = strlen(write_cmd);
                //puts_str(context, "$ ", CHARCOLOR,
                //    LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 fill_rect(context, CHARWIDTH * (cur_write + 4), HEADERHEIGHT + CHARHEIGHT * (j + 0), 
                    CHARWIDTH, CHARHEIGHT, CHARCOLOR);
                 put_str(context, '$', CHARCOLOR,
    161d:	8d 50 16             	lea    0x16(%eax),%edx
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1620:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1623:	83 c0 01             	add    $0x1,%eax
                line_len = strlen(write_cmd);
                //puts_str(context, "$ ", CHARCOLOR,
                //    LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 fill_rect(context, CHARWIDTH * (cur_write + 4), HEADERHEIGHT + CHARHEIGHT * (j + 0), 
                    CHARWIDTH, CHARHEIGHT, CHARCOLOR);
                 put_str(context, '$', CHARCOLOR,
    1626:	c1 e0 03             	shl    $0x3,%eax
    1629:	89 54 24 18          	mov    %edx,0x18(%esp)
    162d:	89 44 24 14          	mov    %eax,0x14(%esp)
    1631:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1638:	00 
    1639:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
    1640:	00 
    1641:	8b 45 08             	mov    0x8(%ebp),%eax
    1644:	89 04 24             	mov    %eax,(%esp)
    1647:	8b 45 0c             	mov    0xc(%ebp),%eax
    164a:	89 44 24 04          	mov    %eax,0x4(%esp)
    164e:	8b 45 10             	mov    0x10(%ebp),%eax
    1651:	89 44 24 08          	mov    %eax,0x8(%esp)
    1655:	e8 98 15 00 00       	call   2bf2 <put_str>
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 put_str(context, ' ', CHARCOLOR,
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    165a:	8b 55 e8             	mov    -0x18(%ebp),%edx
    165d:	89 d0                	mov    %edx,%eax
    165f:	c1 e0 02             	shl    $0x2,%eax
    1662:	01 d0                	add    %edx,%eax
    1664:	c1 e0 02             	shl    $0x2,%eax
                //    LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 fill_rect(context, CHARWIDTH * (cur_write + 4), HEADERHEIGHT + CHARHEIGHT * (j + 0), 
                    CHARWIDTH, CHARHEIGHT, CHARCOLOR);
                 put_str(context, '$', CHARCOLOR,
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 put_str(context, ' ', CHARCOLOR,
    1667:	8d 50 16             	lea    0x16(%eax),%edx
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    166a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166d:	83 c0 01             	add    $0x1,%eax
                //    LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 fill_rect(context, CHARWIDTH * (cur_write + 4), HEADERHEIGHT + CHARHEIGHT * (j + 0), 
                    CHARWIDTH, CHARHEIGHT, CHARCOLOR);
                 put_str(context, '$', CHARCOLOR,
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 put_str(context, ' ', CHARCOLOR,
    1670:	c1 e0 03             	shl    $0x3,%eax
    1673:	89 54 24 18          	mov    %edx,0x18(%esp)
    1677:	89 44 24 14          	mov    %eax,0x14(%esp)
    167b:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1682:	00 
    1683:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
    168a:	00 
    168b:	8b 45 08             	mov    0x8(%ebp),%eax
    168e:	89 04 24             	mov    %eax,(%esp)
    1691:	8b 45 0c             	mov    0xc(%ebp),%eax
    1694:	89 44 24 04          	mov    %eax,0x4(%esp)
    1698:	8b 45 10             	mov    0x10(%ebp),%eax
    169b:	89 44 24 08          	mov    %eax,0x8(%esp)
    169f:	e8 4e 15 00 00       	call   2bf2 <put_str>
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
    16a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    16ab:	e9 c3 00 00 00       	jmp    1773 <handle_keydown+0xb61>
                {
                    if (k != cur_write + 1)
    16b0:	a1 44 ea 00 00       	mov    0xea44,%eax
    16b5:	83 c0 01             	add    $0x1,%eax
    16b8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    16bb:	74 5a                	je     1717 <handle_keydown+0xb05>
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    16bd:	8b 55 e8             	mov    -0x18(%ebp),%edx
    16c0:	89 d0                	mov    %edx,%eax
    16c2:	c1 e0 02             	shl    $0x2,%eax
    16c5:	01 d0                	add    %edx,%eax
    16c7:	c1 e0 02             	shl    $0x2,%eax
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
                {
                    if (k != cur_write + 1)
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
    16ca:	8d 48 16             	lea    0x16(%eax),%ecx
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    16cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d0:	83 c0 03             	add    $0x3,%eax
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
                {
                    if (k != cur_write + 1)
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
    16d3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    16da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16dd:	05 60 5c 01 00       	add    $0x15c60,%eax
    16e2:	0f b6 00             	movzbl (%eax),%eax
    16e5:	0f be c0             	movsbl %al,%eax
    16e8:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    16ec:	89 54 24 14          	mov    %edx,0x14(%esp)
    16f0:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    16f7:	00 
    16f8:	89 44 24 0c          	mov    %eax,0xc(%esp)
    16fc:	8b 45 08             	mov    0x8(%ebp),%eax
    16ff:	89 04 24             	mov    %eax,(%esp)
    1702:	8b 45 0c             	mov    0xc(%ebp),%eax
    1705:	89 44 24 04          	mov    %eax,0x4(%esp)
    1709:	8b 45 10             	mov    0x10(%ebp),%eax
    170c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1710:	e8 dd 14 00 00       	call   2bf2 <put_str>
    1715:	eb 58                	jmp    176f <handle_keydown+0xb5d>
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], BACKGROUNDCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1717:	8b 55 e8             	mov    -0x18(%ebp),%edx
    171a:	89 d0                	mov    %edx,%eax
    171c:	c1 e0 02             	shl    $0x2,%eax
    171f:	01 d0                	add    %edx,%eax
    1721:	c1 e0 02             	shl    $0x2,%eax
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], BACKGROUNDCOLOR,
    1724:	8d 48 16             	lea    0x16(%eax),%ecx
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1727:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172a:	83 c0 03             	add    $0x3,%eax
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], BACKGROUNDCOLOR,
    172d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1734:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1737:	05 60 5c 01 00       	add    $0x15c60,%eax
    173c:	0f b6 00             	movzbl (%eax),%eax
    173f:	0f be c0             	movsbl %al,%eax
    1742:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    1746:	89 54 24 14          	mov    %edx,0x14(%esp)
    174a:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    1751:	00 
    1752:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1756:	8b 45 08             	mov    0x8(%ebp),%eax
    1759:	89 04 24             	mov    %eax,(%esp)
    175c:	8b 45 0c             	mov    0xc(%ebp),%eax
    175f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1763:	8b 45 10             	mov    0x10(%ebp),%eax
    1766:	89 44 24 08          	mov    %eax,0x8(%esp)
    176a:	e8 83 14 00 00       	call   2bf2 <put_str>
                    CHARWIDTH, CHARHEIGHT, CHARCOLOR);
                 put_str(context, '$', CHARCOLOR,
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 put_str(context, ' ', CHARCOLOR,
                             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
    176f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1773:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1776:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1779:	0f 8c 31 ff ff ff    	jl     16b0 <handle_keydown+0xa9e>
                    {
                        put_str(context, write_cmd[k], BACKGROUNDCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                }
               break;
    177f:	e9 ef 06 00 00       	jmp    1e73 <handle_keydown+0x1261>
            case KEY_LF:
                if (cur_write < 0)
    1784:	a1 44 ea 00 00       	mov    0xea44,%eax
    1789:	85 c0                	test   %eax,%eax
    178b:	79 05                	jns    1792 <handle_keydown+0xb80>
                {
                    break;
    178d:	e9 e1 06 00 00       	jmp    1e73 <handle_keydown+0x1261>
                }
                cur_write--;
    1792:	a1 44 ea 00 00       	mov    0xea44,%eax
    1797:	83 e8 01             	sub    $0x1,%eax
    179a:	a3 44 ea 00 00       	mov    %eax,0xea44
                j = isFull ? (LINES - 1) : (line_index + 0);
    179f:	a1 b4 ef 00 00       	mov    0xefb4,%eax
    17a4:	85 c0                	test   %eax,%eax
    17a6:	75 07                	jne    17af <handle_keydown+0xb9d>
    17a8:	a1 a0 ef 00 00       	mov    0xefa0,%eax
    17ad:	eb 05                	jmp    17b4 <handle_keydown+0xba2>
    17af:	b8 13 00 00 00       	mov    $0x13,%eax
    17b4:	89 45 e8             	mov    %eax,-0x18(%ebp)
                cleanline_printer(context, j, 0);
    17b7:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    17be:	00 
    17bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17c2:	89 44 24 0c          	mov    %eax,0xc(%esp)
    17c6:	8b 45 08             	mov    0x8(%ebp),%eax
    17c9:	89 04 24             	mov    %eax,(%esp)
    17cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    17cf:	89 44 24 04          	mov    %eax,0x4(%esp)
    17d3:	8b 45 10             	mov    0x10(%ebp),%eax
    17d6:	89 44 24 08          	mov    %eax,0x8(%esp)
    17da:	e8 a9 e9 ff ff       	call   188 <cleanline_printer>
                line_len = strlen(write_cmd);
    17df:	c7 04 24 60 5c 01 00 	movl   $0x15c60,(%esp)
    17e6:	e8 5f 2c 00 00       	call   444a <strlen>
    17eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                fill_rect(context, CHARWIDTH * (cur_write + 4), HEADERHEIGHT + CHARHEIGHT * (j + 0), 
    17ee:	8b 55 e8             	mov    -0x18(%ebp),%edx
    17f1:	89 d0                	mov    %edx,%eax
    17f3:	c1 e0 02             	shl    $0x2,%eax
    17f6:	01 d0                	add    %edx,%eax
    17f8:	c1 e0 02             	shl    $0x2,%eax
    17fb:	83 c0 16             	add    $0x16,%eax
    17fe:	89 c2                	mov    %eax,%edx
    1800:	a1 44 ea 00 00       	mov    0xea44,%eax
    1805:	83 c0 04             	add    $0x4,%eax
    1808:	c1 e0 03             	shl    $0x3,%eax
    180b:	c7 44 24 1c f0 0f 00 	movl   $0xff0,0x1c(%esp)
    1812:	00 
    1813:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    181a:	00 
    181b:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
    1822:	00 
    1823:	89 54 24 10          	mov    %edx,0x10(%esp)
    1827:	89 44 24 0c          	mov    %eax,0xc(%esp)
    182b:	8b 45 08             	mov    0x8(%ebp),%eax
    182e:	89 04 24             	mov    %eax,(%esp)
    1831:	8b 45 0c             	mov    0xc(%ebp),%eax
    1834:	89 44 24 04          	mov    %eax,0x4(%esp)
    1838:	8b 45 10             	mov    0x10(%ebp),%eax
    183b:	89 44 24 08          	mov    %eax,0x8(%esp)
    183f:	e8 4b 0d 00 00       	call   258f <fill_rect>
                    CHARWIDTH, CHARHEIGHT, CHARCOLOR);
                 puts_str(context, "$ ", CHARCOLOR,
                   LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1844:	8b 55 e8             	mov    -0x18(%ebp),%edx
    1847:	89 d0                	mov    %edx,%eax
    1849:	c1 e0 02             	shl    $0x2,%eax
    184c:	01 d0                	add    %edx,%eax
    184e:	c1 e0 02             	shl    $0x2,%eax
                j = isFull ? (LINES - 1) : (line_index + 0);
                cleanline_printer(context, j, 0);
                line_len = strlen(write_cmd);
                fill_rect(context, CHARWIDTH * (cur_write + 4), HEADERHEIGHT + CHARHEIGHT * (j + 0), 
                    CHARWIDTH, CHARHEIGHT, CHARCOLOR);
                 puts_str(context, "$ ", CHARCOLOR,
    1851:	83 c0 16             	add    $0x16,%eax
    1854:	89 44 24 18          	mov    %eax,0x18(%esp)
    1858:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
    185f:	00 
    1860:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1867:	00 
    1868:	c7 44 24 0c 4d af 00 	movl   $0xaf4d,0xc(%esp)
    186f:	00 
    1870:	8b 45 08             	mov    0x8(%ebp),%eax
    1873:	89 04 24             	mov    %eax,(%esp)
    1876:	8b 45 0c             	mov    0xc(%ebp),%eax
    1879:	89 44 24 04          	mov    %eax,0x4(%esp)
    187d:	8b 45 10             	mov    0x10(%ebp),%eax
    1880:	89 44 24 08          	mov    %eax,0x8(%esp)
    1884:	e8 e5 12 00 00       	call   2b6e <puts_str>
                   LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, '$', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, ' ', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
    1889:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1890:	e9 c3 00 00 00       	jmp    1958 <handle_keydown+0xd46>
                {
                    if (k != cur_write + 1)
    1895:	a1 44 ea 00 00       	mov    0xea44,%eax
    189a:	83 c0 01             	add    $0x1,%eax
    189d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    18a0:	74 5a                	je     18fc <handle_keydown+0xcea>
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    18a2:	8b 55 e8             	mov    -0x18(%ebp),%edx
    18a5:	89 d0                	mov    %edx,%eax
    18a7:	c1 e0 02             	shl    $0x2,%eax
    18aa:	01 d0                	add    %edx,%eax
    18ac:	c1 e0 02             	shl    $0x2,%eax
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
                {
                    if (k != cur_write + 1)
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
    18af:	8d 48 16             	lea    0x16(%eax),%ecx
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    18b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b5:	83 c0 03             	add    $0x3,%eax
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
                {
                    if (k != cur_write + 1)
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
    18b8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    18bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c2:	05 60 5c 01 00       	add    $0x15c60,%eax
    18c7:	0f b6 00             	movzbl (%eax),%eax
    18ca:	0f be c0             	movsbl %al,%eax
    18cd:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    18d1:	89 54 24 14          	mov    %edx,0x14(%esp)
    18d5:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    18dc:	00 
    18dd:	89 44 24 0c          	mov    %eax,0xc(%esp)
    18e1:	8b 45 08             	mov    0x8(%ebp),%eax
    18e4:	89 04 24             	mov    %eax,(%esp)
    18e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    18ea:	89 44 24 04          	mov    %eax,0x4(%esp)
    18ee:	8b 45 10             	mov    0x10(%ebp),%eax
    18f1:	89 44 24 08          	mov    %eax,0x8(%esp)
    18f5:	e8 f8 12 00 00       	call   2bf2 <put_str>
    18fa:	eb 58                	jmp    1954 <handle_keydown+0xd42>
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], BACKGROUNDCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    18fc:	8b 55 e8             	mov    -0x18(%ebp),%edx
    18ff:	89 d0                	mov    %edx,%eax
    1901:	c1 e0 02             	shl    $0x2,%eax
    1904:	01 d0                	add    %edx,%eax
    1906:	c1 e0 02             	shl    $0x2,%eax
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], BACKGROUNDCOLOR,
    1909:	8d 48 16             	lea    0x16(%eax),%ecx
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    190c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    190f:	83 c0 03             	add    $0x3,%eax
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], BACKGROUNDCOLOR,
    1912:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1919:	8b 45 f4             	mov    -0xc(%ebp),%eax
    191c:	05 60 5c 01 00       	add    $0x15c60,%eax
    1921:	0f b6 00             	movzbl (%eax),%eax
    1924:	0f be c0             	movsbl %al,%eax
    1927:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    192b:	89 54 24 14          	mov    %edx,0x14(%esp)
    192f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    1936:	00 
    1937:	89 44 24 0c          	mov    %eax,0xc(%esp)
    193b:	8b 45 08             	mov    0x8(%ebp),%eax
    193e:	89 04 24             	mov    %eax,(%esp)
    1941:	8b 45 0c             	mov    0xc(%ebp),%eax
    1944:	89 44 24 04          	mov    %eax,0x4(%esp)
    1948:	8b 45 10             	mov    0x10(%ebp),%eax
    194b:	89 44 24 08          	mov    %eax,0x8(%esp)
    194f:	e8 9e 12 00 00       	call   2bf2 <put_str>
                   LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, '$', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, ' ', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
    1954:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1958:	8b 45 f4             	mov    -0xc(%ebp),%eax
    195b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    195e:	0f 8c 31 ff ff ff    	jl     1895 <handle_keydown+0xc83>
                    {
                        put_str(context, write_cmd[k], BACKGROUNDCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                }
                break;
    1964:	e9 0a 05 00 00       	jmp    1e73 <handle_keydown+0x1261>
            case KEY_DN:
                if (cur_his >= his_index)
    1969:	8b 15 4c ea 00 00    	mov    0xea4c,%edx
    196f:	a1 48 ea 00 00       	mov    0xea48,%eax
    1974:	39 c2                	cmp    %eax,%edx
    1976:	7c 05                	jl     197d <handle_keydown+0xd6b>
                {
                    break;
    1978:	e9 f6 04 00 00       	jmp    1e73 <handle_keydown+0x1261>
                }
                cur_his++;
    197d:	a1 4c ea 00 00       	mov    0xea4c,%eax
    1982:	83 c0 01             	add    $0x1,%eax
    1985:	a3 4c ea 00 00       	mov    %eax,0xea4c
                for (k = 0; k < COMMANDMAXLEN; k++)
    198a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1991:	e9 b3 00 00 00       	jmp    1a49 <handle_keydown+0xe37>
                {
                    if (cmd_history[cur_his][k] == '\n')
    1996:	a1 4c ea 00 00       	mov    0xea4c,%eax
    199b:	c1 e0 0a             	shl    $0xa,%eax
    199e:	89 c2                	mov    %eax,%edx
    19a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19a3:	01 d0                	add    %edx,%eax
    19a5:	05 c0 6a 01 00       	add    $0x16ac0,%eax
    19aa:	0f b6 00             	movzbl (%eax),%eax
    19ad:	3c 0a                	cmp    $0xa,%al
    19af:	75 2f                	jne    19e0 <handle_keydown+0xdce>
                    {
                        write_index = k;
    19b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b4:	a3 bc ef 00 00       	mov    %eax,0xefbc
                        cur_write = k - 1;
    19b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19bc:	83 e8 01             	sub    $0x1,%eax
    19bf:	a3 44 ea 00 00       	mov    %eax,0xea44
                        while (k < COMMANDMAXLEN)
    19c4:	eb 0f                	jmp    19d5 <handle_keydown+0xdc3>
                        {
                            write_cmd[k] = 0;
    19c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19c9:	05 60 5c 01 00       	add    $0x15c60,%eax
    19ce:	c6 00 00             	movb   $0x0,(%eax)
                            k++;
    19d1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                {
                    if (cmd_history[cur_his][k] == '\n')
                    {
                        write_index = k;
                        cur_write = k - 1;
                        while (k < COMMANDMAXLEN)
    19d5:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
    19dc:	7e e8                	jle    19c6 <handle_keydown+0xdb4>
                        // while (k + char_index < CHARS)
                        // {
                        //     printer_buf[line_index][k+char_index] = 0;
                        //     k++;
                        // }
                        break;
    19de:	eb 76                	jmp    1a56 <handle_keydown+0xe44>
                    }
                    printer_buf[line_index][char_index] = cmd_history[cur_his][k];
    19e0:	8b 15 a0 ef 00 00    	mov    0xefa0,%edx
    19e6:	8b 1d a4 ef 00 00    	mov    0xefa4,%ebx
    19ec:	a1 4c ea 00 00       	mov    0xea4c,%eax
    19f1:	c1 e0 0a             	shl    $0xa,%eax
    19f4:	89 c1                	mov    %eax,%ecx
    19f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19f9:	01 c8                	add    %ecx,%eax
    19fb:	05 c0 6a 01 00       	add    $0x16ac0,%eax
    1a00:	0f b6 08             	movzbl (%eax),%ecx
    1a03:	89 d0                	mov    %edx,%eax
    1a05:	c1 e0 02             	shl    $0x2,%eax
    1a08:	01 d0                	add    %edx,%eax
    1a0a:	c1 e0 04             	shl    $0x4,%eax
    1a0d:	01 d8                	add    %ebx,%eax
    1a0f:	05 80 64 01 00       	add    $0x16480,%eax
    1a14:	88 08                	mov    %cl,(%eax)
                    char_index++;
    1a16:	a1 a4 ef 00 00       	mov    0xefa4,%eax
    1a1b:	83 c0 01             	add    $0x1,%eax
    1a1e:	a3 a4 ef 00 00       	mov    %eax,0xefa4
                    //         isFull = 1;
                    //         line_index = 0;
                    //     }
                    //         char_index = 0;
                    // }
                    write_cmd[k] = cmd_history[cur_his][k];
    1a23:	a1 4c ea 00 00       	mov    0xea4c,%eax
    1a28:	c1 e0 0a             	shl    $0xa,%eax
    1a2b:	89 c2                	mov    %eax,%edx
    1a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a30:	01 d0                	add    %edx,%eax
    1a32:	05 c0 6a 01 00       	add    $0x16ac0,%eax
    1a37:	0f b6 00             	movzbl (%eax),%eax
    1a3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a3d:	81 c2 60 5c 01 00    	add    $0x15c60,%edx
    1a43:	88 02                	mov    %al,(%edx)
                if (cur_his >= his_index)
                {
                    break;
                }
                cur_his++;
                for (k = 0; k < COMMANDMAXLEN; k++)
    1a45:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1a49:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
    1a50:	0f 8e 40 ff ff ff    	jle    1996 <handle_keydown+0xd84>
                    //     }
                    //         char_index = 0;
                    // }
                    write_cmd[k] = cmd_history[cur_his][k];
                }
                j = isFull ? (LINES - 1) : (line_index + 0);
    1a56:	a1 b4 ef 00 00       	mov    0xefb4,%eax
    1a5b:	85 c0                	test   %eax,%eax
    1a5d:	75 07                	jne    1a66 <handle_keydown+0xe54>
    1a5f:	a1 a0 ef 00 00       	mov    0xefa0,%eax
    1a64:	eb 05                	jmp    1a6b <handle_keydown+0xe59>
    1a66:	b8 13 00 00 00       	mov    $0x13,%eax
    1a6b:	89 45 e8             	mov    %eax,-0x18(%ebp)
                cleanline_printer(context, j, 0);
    1a6e:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    1a75:	00 
    1a76:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a79:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1a7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a80:	89 04 24             	mov    %eax,(%esp)
    1a83:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a86:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a8a:	8b 45 10             	mov    0x10(%ebp),%eax
    1a8d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1a91:	e8 f2 e6 ff ff       	call   188 <cleanline_printer>
                line_len = strlen(write_cmd);
    1a96:	c7 04 24 60 5c 01 00 	movl   $0x15c60,(%esp)
    1a9d:	e8 a8 29 00 00       	call   444a <strlen>
    1aa2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                 puts_str(context, "$ ", CHARCOLOR,
                   LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1aa5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    1aa8:	89 d0                	mov    %edx,%eax
    1aaa:	c1 e0 02             	shl    $0x2,%eax
    1aad:	01 d0                	add    %edx,%eax
    1aaf:	c1 e0 02             	shl    $0x2,%eax
                    write_cmd[k] = cmd_history[cur_his][k];
                }
                j = isFull ? (LINES - 1) : (line_index + 0);
                cleanline_printer(context, j, 0);
                line_len = strlen(write_cmd);
                 puts_str(context, "$ ", CHARCOLOR,
    1ab2:	83 c0 16             	add    $0x16,%eax
    1ab5:	89 44 24 18          	mov    %eax,0x18(%esp)
    1ab9:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
    1ac0:	00 
    1ac1:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1ac8:	00 
    1ac9:	c7 44 24 0c 4d af 00 	movl   $0xaf4d,0xc(%esp)
    1ad0:	00 
    1ad1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad4:	89 04 24             	mov    %eax,(%esp)
    1ad7:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ada:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ade:	8b 45 10             	mov    0x10(%ebp),%eax
    1ae1:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ae5:	e8 84 10 00 00       	call   2b6e <puts_str>
                   LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, '$', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, ' ', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
    1aea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1af1:	e9 c0 00 00 00       	jmp    1bb6 <handle_keydown+0xfa4>
                {
                    if (k != write_index)
    1af6:	a1 bc ef 00 00       	mov    0xefbc,%eax
    1afb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1afe:	74 5a                	je     1b5a <handle_keydown+0xf48>
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1b00:	8b 55 e8             	mov    -0x18(%ebp),%edx
    1b03:	89 d0                	mov    %edx,%eax
    1b05:	c1 e0 02             	shl    $0x2,%eax
    1b08:	01 d0                	add    %edx,%eax
    1b0a:	c1 e0 02             	shl    $0x2,%eax
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
                {
                    if (k != write_index)
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
    1b0d:	8d 48 16             	lea    0x16(%eax),%ecx
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1b10:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b13:	83 c0 03             	add    $0x3,%eax
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
                {
                    if (k != write_index)
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
    1b16:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b20:	05 60 5c 01 00       	add    $0x15c60,%eax
    1b25:	0f b6 00             	movzbl (%eax),%eax
    1b28:	0f be c0             	movsbl %al,%eax
    1b2b:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    1b2f:	89 54 24 14          	mov    %edx,0x14(%esp)
    1b33:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1b3a:	00 
    1b3b:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1b3f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b42:	89 04 24             	mov    %eax,(%esp)
    1b45:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b48:	89 44 24 04          	mov    %eax,0x4(%esp)
    1b4c:	8b 45 10             	mov    0x10(%ebp),%eax
    1b4f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1b53:	e8 9a 10 00 00       	call   2bf2 <put_str>
    1b58:	eb 58                	jmp    1bb2 <handle_keydown+0xfa0>
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1b5a:	8b 55 e8             	mov    -0x18(%ebp),%edx
    1b5d:	89 d0                	mov    %edx,%eax
    1b5f:	c1 e0 02             	shl    $0x2,%eax
    1b62:	01 d0                	add    %edx,%eax
    1b64:	c1 e0 02             	shl    $0x2,%eax
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
    1b67:	8d 48 16             	lea    0x16(%eax),%ecx
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b6d:	83 c0 03             	add    $0x3,%eax
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
    1b70:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1b77:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b7a:	05 60 5c 01 00       	add    $0x15c60,%eax
    1b7f:	0f b6 00             	movzbl (%eax),%eax
    1b82:	0f be c0             	movsbl %al,%eax
    1b85:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    1b89:	89 54 24 14          	mov    %edx,0x14(%esp)
    1b8d:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1b94:	00 
    1b95:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1b99:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9c:	89 04 24             	mov    %eax,(%esp)
    1b9f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ba2:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ba6:	8b 45 10             	mov    0x10(%ebp),%eax
    1ba9:	89 44 24 08          	mov    %eax,0x8(%esp)
    1bad:	e8 40 10 00 00       	call   2bf2 <put_str>
                   LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, '$', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, ' ', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
    1bb2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1bb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bb9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1bbc:	0f 8c 34 ff ff ff    	jl     1af6 <handle_keydown+0xee4>
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                }
                break;
    1bc2:	e9 ac 02 00 00       	jmp    1e73 <handle_keydown+0x1261>
            case KEY_UP:
                if (cur_his < 0)
    1bc7:	a1 4c ea 00 00       	mov    0xea4c,%eax
    1bcc:	85 c0                	test   %eax,%eax
    1bce:	79 05                	jns    1bd5 <handle_keydown+0xfc3>
                {
                    break;
    1bd0:	e9 9e 02 00 00       	jmp    1e73 <handle_keydown+0x1261>
                }
                //cur_his--;
                //printf(0, "blabla");
                for (k = 0; k < COMMANDMAXLEN - 1; k++)
    1bd5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1bdc:	e9 f5 00 00 00       	jmp    1cd6 <handle_keydown+0x10c4>
                {
                    if (cmd_history[cur_his][k] == '\n')
    1be1:	a1 4c ea 00 00       	mov    0xea4c,%eax
    1be6:	c1 e0 0a             	shl    $0xa,%eax
    1be9:	89 c2                	mov    %eax,%edx
    1beb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bee:	01 d0                	add    %edx,%eax
    1bf0:	05 c0 6a 01 00       	add    $0x16ac0,%eax
    1bf5:	0f b6 00             	movzbl (%eax),%eax
    1bf8:	3c 0a                	cmp    $0xa,%al
    1bfa:	75 32                	jne    1c2e <handle_keydown+0x101c>
                    {
                        //printf(0, "aaaa");
                        write_index = k;
    1bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bff:	a3 bc ef 00 00       	mov    %eax,0xefbc
                        cur_write = k - 1;
    1c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c07:	83 e8 01             	sub    $0x1,%eax
    1c0a:	a3 44 ea 00 00       	mov    %eax,0xea44
                        while (k < COMMANDMAXLEN)
    1c0f:	eb 0f                	jmp    1c20 <handle_keydown+0x100e>
                        {
                            write_cmd[k] = 0;
    1c11:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c14:	05 60 5c 01 00       	add    $0x15c60,%eax
    1c19:	c6 00 00             	movb   $0x0,(%eax)
                            k++;
    1c1c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                    if (cmd_history[cur_his][k] == '\n')
                    {
                        //printf(0, "aaaa");
                        write_index = k;
                        cur_write = k - 1;
                        while (k < COMMANDMAXLEN)
    1c20:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
    1c27:	7e e8                	jle    1c11 <handle_keydown+0xfff>
                        // while (k + char_index < CHARS)
                        // {
                        //     printer_buf[line_index][k+char_index] = 0;
                        //     k++;
                        // }
                        break;
    1c29:	e9 b5 00 00 00       	jmp    1ce3 <handle_keydown+0x10d1>
                    }
                    printer_buf[line_index][char_index] = cmd_history[cur_his][k];
    1c2e:	8b 15 a0 ef 00 00    	mov    0xefa0,%edx
    1c34:	8b 1d a4 ef 00 00    	mov    0xefa4,%ebx
    1c3a:	a1 4c ea 00 00       	mov    0xea4c,%eax
    1c3f:	c1 e0 0a             	shl    $0xa,%eax
    1c42:	89 c1                	mov    %eax,%ecx
    1c44:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c47:	01 c8                	add    %ecx,%eax
    1c49:	05 c0 6a 01 00       	add    $0x16ac0,%eax
    1c4e:	0f b6 08             	movzbl (%eax),%ecx
    1c51:	89 d0                	mov    %edx,%eax
    1c53:	c1 e0 02             	shl    $0x2,%eax
    1c56:	01 d0                	add    %edx,%eax
    1c58:	c1 e0 04             	shl    $0x4,%eax
    1c5b:	01 d8                	add    %ebx,%eax
    1c5d:	05 80 64 01 00       	add    $0x16480,%eax
    1c62:	88 08                	mov    %cl,(%eax)
                    char_index++;
    1c64:	a1 a4 ef 00 00       	mov    0xefa4,%eax
    1c69:	83 c0 01             	add    $0x1,%eax
    1c6c:	a3 a4 ef 00 00       	mov    %eax,0xefa4
                    if (char_index >= CHARS) {
    1c71:	a1 a4 ef 00 00       	mov    0xefa4,%eax
    1c76:	83 f8 4f             	cmp    $0x4f,%eax
    1c79:	7e 35                	jle    1cb0 <handle_keydown+0x109e>
                        line_index++;
    1c7b:	a1 a0 ef 00 00       	mov    0xefa0,%eax
    1c80:	83 c0 01             	add    $0x1,%eax
    1c83:	a3 a0 ef 00 00       	mov    %eax,0xefa0
                        if (line_index >= LINES) {
    1c88:	a1 a0 ef 00 00       	mov    0xefa0,%eax
    1c8d:	83 f8 13             	cmp    $0x13,%eax
    1c90:	7e 14                	jle    1ca6 <handle_keydown+0x1094>
                            isFull = 1;
    1c92:	c7 05 b4 ef 00 00 01 	movl   $0x1,0xefb4
    1c99:	00 00 00 
                            line_index = 0;
    1c9c:	c7 05 a0 ef 00 00 00 	movl   $0x0,0xefa0
    1ca3:	00 00 00 
                        }
                            char_index = 0;
    1ca6:	c7 05 a4 ef 00 00 00 	movl   $0x0,0xefa4
    1cad:	00 00 00 
                    }
                    write_cmd[k] = cmd_history[cur_his][k];
    1cb0:	a1 4c ea 00 00       	mov    0xea4c,%eax
    1cb5:	c1 e0 0a             	shl    $0xa,%eax
    1cb8:	89 c2                	mov    %eax,%edx
    1cba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cbd:	01 d0                	add    %edx,%eax
    1cbf:	05 c0 6a 01 00       	add    $0x16ac0,%eax
    1cc4:	0f b6 00             	movzbl (%eax),%eax
    1cc7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1cca:	81 c2 60 5c 01 00    	add    $0x15c60,%edx
    1cd0:	88 02                	mov    %al,(%edx)
                {
                    break;
                }
                //cur_his--;
                //printf(0, "blabla");
                for (k = 0; k < COMMANDMAXLEN - 1; k++)
    1cd2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1cd6:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
    1cdd:	0f 8e fe fe ff ff    	jle    1be1 <handle_keydown+0xfcf>
                        }
                            char_index = 0;
                    }
                    write_cmd[k] = cmd_history[cur_his][k];
                }
                cur_his--;
    1ce3:	a1 4c ea 00 00       	mov    0xea4c,%eax
    1ce8:	83 e8 01             	sub    $0x1,%eax
    1ceb:	a3 4c ea 00 00       	mov    %eax,0xea4c
                j = isFull ? (LINES - 1) : (line_index + 0);
    1cf0:	a1 b4 ef 00 00       	mov    0xefb4,%eax
    1cf5:	85 c0                	test   %eax,%eax
    1cf7:	75 07                	jne    1d00 <handle_keydown+0x10ee>
    1cf9:	a1 a0 ef 00 00       	mov    0xefa0,%eax
    1cfe:	eb 05                	jmp    1d05 <handle_keydown+0x10f3>
    1d00:	b8 13 00 00 00       	mov    $0x13,%eax
    1d05:	89 45 e8             	mov    %eax,-0x18(%ebp)
                cleanline_printer(context, j, 0);
    1d08:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    1d0f:	00 
    1d10:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1d13:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1d17:	8b 45 08             	mov    0x8(%ebp),%eax
    1d1a:	89 04 24             	mov    %eax,(%esp)
    1d1d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d20:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d24:	8b 45 10             	mov    0x10(%ebp),%eax
    1d27:	89 44 24 08          	mov    %eax,0x8(%esp)
    1d2b:	e8 58 e4 ff ff       	call   188 <cleanline_printer>
                line_len = strlen(write_cmd);
    1d30:	c7 04 24 60 5c 01 00 	movl   $0x15c60,(%esp)
    1d37:	e8 0e 27 00 00       	call   444a <strlen>
    1d3c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                 puts_str(context, "$ ", CHARCOLOR,
                   LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1d3f:	8b 55 e8             	mov    -0x18(%ebp),%edx
    1d42:	89 d0                	mov    %edx,%eax
    1d44:	c1 e0 02             	shl    $0x2,%eax
    1d47:	01 d0                	add    %edx,%eax
    1d49:	c1 e0 02             	shl    $0x2,%eax
                }
                cur_his--;
                j = isFull ? (LINES - 1) : (line_index + 0);
                cleanline_printer(context, j, 0);
                line_len = strlen(write_cmd);
                 puts_str(context, "$ ", CHARCOLOR,
    1d4c:	83 c0 16             	add    $0x16,%eax
    1d4f:	89 44 24 18          	mov    %eax,0x18(%esp)
    1d53:	c7 44 24 14 08 00 00 	movl   $0x8,0x14(%esp)
    1d5a:	00 
    1d5b:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1d62:	00 
    1d63:	c7 44 24 0c 4d af 00 	movl   $0xaf4d,0xc(%esp)
    1d6a:	00 
    1d6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d6e:	89 04 24             	mov    %eax,(%esp)
    1d71:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d74:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d78:	8b 45 10             	mov    0x10(%ebp),%eax
    1d7b:	89 44 24 08          	mov    %eax,0x8(%esp)
    1d7f:	e8 ea 0d 00 00       	call   2b6e <puts_str>
                   LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, '$', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, ' ', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
    1d84:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1d8b:	e9 c0 00 00 00       	jmp    1e50 <handle_keydown+0x123e>
                {
                    if (k != write_index)
    1d90:	a1 bc ef 00 00       	mov    0xefbc,%eax
    1d95:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1d98:	74 5a                	je     1df4 <handle_keydown+0x11e2>
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1d9a:	8b 55 e8             	mov    -0x18(%ebp),%edx
    1d9d:	89 d0                	mov    %edx,%eax
    1d9f:	c1 e0 02             	shl    $0x2,%eax
    1da2:	01 d0                	add    %edx,%eax
    1da4:	c1 e0 02             	shl    $0x2,%eax
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
                {
                    if (k != write_index)
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
    1da7:	8d 48 16             	lea    0x16(%eax),%ecx
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1daa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dad:	83 c0 03             	add    $0x3,%eax
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
                {
                    if (k != write_index)
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
    1db0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1db7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dba:	05 60 5c 01 00       	add    $0x15c60,%eax
    1dbf:	0f b6 00             	movzbl (%eax),%eax
    1dc2:	0f be c0             	movsbl %al,%eax
    1dc5:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    1dc9:	89 54 24 14          	mov    %edx,0x14(%esp)
    1dcd:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1dd4:	00 
    1dd5:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1dd9:	8b 45 08             	mov    0x8(%ebp),%eax
    1ddc:	89 04 24             	mov    %eax,(%esp)
    1ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
    1de2:	89 44 24 04          	mov    %eax,0x4(%esp)
    1de6:	8b 45 10             	mov    0x10(%ebp),%eax
    1de9:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ded:	e8 00 0e 00 00       	call   2bf2 <put_str>
    1df2:	eb 58                	jmp    1e4c <handle_keydown+0x123a>
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1df4:	8b 55 e8             	mov    -0x18(%ebp),%edx
    1df7:	89 d0                	mov    %edx,%eax
    1df9:	c1 e0 02             	shl    $0x2,%eax
    1dfc:	01 d0                	add    %edx,%eax
    1dfe:	c1 e0 02             	shl    $0x2,%eax
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
    1e01:	8d 48 16             	lea    0x16(%eax),%ecx
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
    1e04:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e07:	83 c0 03             	add    $0x3,%eax
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                    else
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
    1e0a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1e11:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e14:	05 60 5c 01 00       	add    $0x15c60,%eax
    1e19:	0f b6 00             	movzbl (%eax),%eax
    1e1c:	0f be c0             	movsbl %al,%eax
    1e1f:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    1e23:	89 54 24 14          	mov    %edx,0x14(%esp)
    1e27:	c7 44 24 10 f0 0f 00 	movl   $0xff0,0x10(%esp)
    1e2e:	00 
    1e2f:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1e33:	8b 45 08             	mov    0x8(%ebp),%eax
    1e36:	89 04 24             	mov    %eax,(%esp)
    1e39:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e3c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e40:	8b 45 10             	mov    0x10(%ebp),%eax
    1e43:	89 44 24 08          	mov    %eax,0x8(%esp)
    1e47:	e8 a6 0d 00 00       	call   2bf2 <put_str>
                   LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, '$', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                 // put_str(context, ' ', CHARCOLOR,
                 //             CHARWIDTH * k + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                for (k = 0; k < line_len; k++)
    1e4c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1e50:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e53:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1e56:	0f 8c 34 ff ff ff    	jl     1d90 <handle_keydown+0x117e>
                    {
                        put_str(context, write_cmd[k], CHARCOLOR,
                            CHARWIDTH * (k + 2) + LEFTWIDTH, CHARHEIGHT * j + HEADERHEIGHT);
                    }
                }
                break;
    1e5c:	eb 15                	jmp    1e73 <handle_keydown+0x1261>
            default:
                printf(0, "unknown error");
    1e5e:	c7 44 24 04 50 af 00 	movl   $0xaf50,0x4(%esp)
    1e65:	00 
    1e66:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1e6d:	e8 94 29 00 00       	call   4806 <printf>
                break;
    1e72:	90                   	nop
        }
        //string_printer(context, &ch, 0);

        return;
    1e73:	e9 7d 02 00 00       	jmp    20f5 <handle_keydown+0x14e3>
    }

    printf(0, "%d\n", ch);
    1e78:	0f b6 45 c4          	movzbl -0x3c(%ebp),%eax
    1e7c:	0f be c0             	movsbl %al,%eax
    1e7f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1e83:	c7 44 24 04 5e af 00 	movl   $0xaf5e,0x4(%esp)
    1e8a:	00 
    1e8b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1e92:	e8 6f 29 00 00       	call   4806 <printf>
    // append the ch to the command and display the command
    cur_write = write_index;
    1e97:	a1 bc ef 00 00       	mov    0xefbc,%eax
    1e9c:	a3 44 ea 00 00       	mov    %eax,0xea44
    write_cmd[write_index++] = ch;
    1ea1:	a1 bc ef 00 00       	mov    0xefbc,%eax
    1ea6:	8d 50 01             	lea    0x1(%eax),%edx
    1ea9:	89 15 bc ef 00 00    	mov    %edx,0xefbc
    1eaf:	0f b6 55 c4          	movzbl -0x3c(%ebp),%edx
    1eb3:	88 90 60 5c 01 00    	mov    %dl,0x15c60(%eax)
    string_printer(context, &ch, 1);
    1eb9:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
    1ec0:	00 
    1ec1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
    1ec4:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1ec8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ecb:	89 04 24             	mov    %eax,(%esp)
    1ece:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ed1:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ed5:	8b 45 10             	mov    0x10(%ebp),%eax
    1ed8:	89 44 24 08          	mov    %eax,0x8(%esp)
    1edc:	e8 b4 e3 ff ff       	call   295 <string_printer>

    // If user input a '\n', the command will be sent to the sh
    // and the printer will show the result.
    if (ch == '\n') {
    1ee1:	0f b6 45 c4          	movzbl -0x3c(%ebp),%eax
    1ee5:	3c 0a                	cmp    $0xa,%al
    1ee7:	0f 85 62 01 00 00    	jne    204f <handle_keydown+0x143d>
        if (write(wfd, write_cmd, strlen(write_cmd)) != strlen(write_cmd)) {
    1eed:	c7 04 24 60 5c 01 00 	movl   $0x15c60,(%esp)
    1ef4:	e8 51 25 00 00       	call   444a <strlen>
    1ef9:	89 44 24 08          	mov    %eax,0x8(%esp)
    1efd:	c7 44 24 04 60 5c 01 	movl   $0x15c60,0x4(%esp)
    1f04:	00 
    1f05:	8b 45 1c             	mov    0x1c(%ebp),%eax
    1f08:	89 04 24             	mov    %eax,(%esp)
    1f0b:	e8 2e 27 00 00       	call   463e <write>
    1f10:	89 c3                	mov    %eax,%ebx
    1f12:	c7 04 24 60 5c 01 00 	movl   $0x15c60,(%esp)
    1f19:	e8 2c 25 00 00       	call   444a <strlen>
    1f1e:	39 c3                	cmp    %eax,%ebx
    1f20:	74 19                	je     1f3b <handle_keydown+0x1329>
            printf(1, "gui pipe write: failed");
    1f22:	c7 44 24 04 62 af 00 	movl   $0xaf62,0x4(%esp)
    1f29:	00 
    1f2a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f31:	e8 d0 28 00 00       	call   4806 <printf>
    1f36:	e9 80 00 00 00       	jmp    1fbb <handle_keydown+0x13a9>
        }
        else {
            // Read the result until get the initial string "$ "
            while (1) {
                if ((n = read(rfd, read_buf, READBUFFERSIZE)) > 0) {
    1f3b:	c7 44 24 08 00 04 00 	movl   $0x400,0x8(%esp)
    1f42:	00 
    1f43:	c7 44 24 04 80 60 01 	movl   $0x16080,0x4(%esp)
    1f4a:	00 
    1f4b:	8b 45 18             	mov    0x18(%ebp),%eax
    1f4e:	89 04 24             	mov    %eax,(%esp)
    1f51:	e8 e0 26 00 00       	call   4636 <read>
    1f56:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1f59:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f5d:	7e 5a                	jle    1fb9 <handle_keydown+0x13a7>
                    string_printer(context, read_buf, n);
    1f5f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f62:	89 44 24 10          	mov    %eax,0x10(%esp)
    1f66:	c7 44 24 0c 80 60 01 	movl   $0x16080,0xc(%esp)
    1f6d:	00 
    1f6e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f71:	89 04 24             	mov    %eax,(%esp)
    1f74:	8b 45 0c             	mov    0xc(%ebp),%eax
    1f77:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f7b:	8b 45 10             	mov    0x10(%ebp),%eax
    1f7e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1f82:	e8 0e e3 ff ff       	call   295 <string_printer>
                    // if the read_buf ends with init_string("$ "),
                    // the result is over and stop reading.
                    if (read_buf[n - 2] == init_string[0]
    1f87:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1f8a:	83 e8 02             	sub    $0x2,%eax
    1f8d:	0f b6 90 80 60 01 00 	movzbl 0x16080(%eax),%edx
    1f94:	0f b6 05 50 ea 00 00 	movzbl 0xea50,%eax
    1f9b:	38 c2                	cmp    %al,%dl
    1f9d:	75 1a                	jne    1fb9 <handle_keydown+0x13a7>
                            && read_buf[n - 1] == init_string[1]) {
    1f9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1fa2:	83 e8 01             	sub    $0x1,%eax
    1fa5:	0f b6 90 80 60 01 00 	movzbl 0x16080(%eax),%edx
    1fac:	0f b6 05 51 ea 00 00 	movzbl 0xea51,%eax
    1fb3:	38 c2                	cmp    %al,%dl
    1fb5:	75 02                	jne    1fb9 <handle_keydown+0x13a7>
                        break;
    1fb7:	eb 02                	jmp    1fbb <handle_keydown+0x13a9>
                    }
                }
            }
    1fb9:	eb 80                	jmp    1f3b <handle_keydown+0x1329>
        }
        his_index++;
    1fbb:	a1 48 ea 00 00       	mov    0xea48,%eax
    1fc0:	83 c0 01             	add    $0x1,%eax
    1fc3:	a3 48 ea 00 00       	mov    %eax,0xea48
        if (his_index >= 100)
    1fc8:	a1 48 ea 00 00       	mov    0xea48,%eax
    1fcd:	83 f8 63             	cmp    $0x63,%eax
    1fd0:	7e 0a                	jle    1fdc <handle_keydown+0x13ca>
        {
            his_index = 0;
    1fd2:	c7 05 48 ea 00 00 00 	movl   $0x0,0xea48
    1fd9:	00 00 00 
        }
        cur_his = his_index;
    1fdc:	a1 48 ea 00 00       	mov    0xea48,%eax
    1fe1:	a3 4c ea 00 00       	mov    %eax,0xea4c
        //int k = 0;
        for (k = 0; k < COMMANDMAXLEN; k++)
    1fe6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1fed:	eb 27                	jmp    2016 <handle_keydown+0x1404>
        {
            cmd_history[his_index][k] = write_cmd[k];
    1fef:	8b 15 48 ea 00 00    	mov    0xea48,%edx
    1ff5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ff8:	05 60 5c 01 00       	add    $0x15c60,%eax
    1ffd:	0f b6 00             	movzbl (%eax),%eax
    2000:	89 d1                	mov    %edx,%ecx
    2002:	c1 e1 0a             	shl    $0xa,%ecx
    2005:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2008:	01 ca                	add    %ecx,%edx
    200a:	81 c2 c0 6a 01 00    	add    $0x16ac0,%edx
    2010:	88 02                	mov    %al,(%edx)
        {
            his_index = 0;
        }
        cur_his = his_index;
        //int k = 0;
        for (k = 0; k < COMMANDMAXLEN; k++)
    2012:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2016:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
    201d:	7e d0                	jle    1fef <handle_keydown+0x13dd>
        {
            cmd_history[his_index][k] = write_cmd[k];
        }
        // Clean the write_cmd buffer
        memset(write_cmd, 0, sizeof(char) * COMMANDMAXLEN);
    201f:	c7 44 24 08 00 04 00 	movl   $0x400,0x8(%esp)
    2026:	00 
    2027:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    202e:	00 
    202f:	c7 04 24 60 5c 01 00 	movl   $0x15c60,(%esp)
    2036:	e8 36 24 00 00       	call   4471 <memset>
        write_index = 0;
    203b:	c7 05 bc ef 00 00 00 	movl   $0x0,0xefbc
    2042:	00 00 00 
        cur_write = -1;
    2045:	c7 05 44 ea 00 00 ff 	movl   $0xffffffff,0xea44
    204c:	ff ff ff 
    }

    char toolongcmdhint[] = "\nThe command is too long!\n";
    204f:	c7 45 c9 0a 54 68 65 	movl   $0x6568540a,-0x37(%ebp)
    2056:	c7 45 cd 20 63 6f 6d 	movl   $0x6d6f6320,-0x33(%ebp)
    205d:	c7 45 d1 6d 61 6e 64 	movl   $0x646e616d,-0x2f(%ebp)
    2064:	c7 45 d5 20 69 73 20 	movl   $0x20736920,-0x2b(%ebp)
    206b:	c7 45 d9 74 6f 6f 20 	movl   $0x206f6f74,-0x27(%ebp)
    2072:	c7 45 dd 6c 6f 6e 67 	movl   $0x676e6f6c,-0x23(%ebp)
    2079:	66 c7 45 e1 21 0a    	movw   $0xa21,-0x1f(%ebp)
    207f:	c6 45 e3 00          	movb   $0x0,-0x1d(%ebp)
    // The command cannot be longer than write_len.
    // Otherwise show the hint and clean the write_cmd buffer.
    if (strlen(write_cmd) == COMMANDMAXLEN - 1) {
    2083:	c7 04 24 60 5c 01 00 	movl   $0x15c60,(%esp)
    208a:	e8 bb 23 00 00       	call   444a <strlen>
    208f:	3d ff 03 00 00       	cmp    $0x3ff,%eax
    2094:	75 5f                	jne    20f5 <handle_keydown+0x14e3>
        // Print the hint
        string_printer(context, toolongcmdhint, strlen(toolongcmdhint));
    2096:	8d 45 c9             	lea    -0x37(%ebp),%eax
    2099:	89 04 24             	mov    %eax,(%esp)
    209c:	e8 a9 23 00 00       	call   444a <strlen>
    20a1:	89 44 24 10          	mov    %eax,0x10(%esp)
    20a5:	8d 45 c9             	lea    -0x37(%ebp),%eax
    20a8:	89 44 24 0c          	mov    %eax,0xc(%esp)
    20ac:	8b 45 08             	mov    0x8(%ebp),%eax
    20af:	89 04 24             	mov    %eax,(%esp)
    20b2:	8b 45 0c             	mov    0xc(%ebp),%eax
    20b5:	89 44 24 04          	mov    %eax,0x4(%esp)
    20b9:	8b 45 10             	mov    0x10(%ebp),%eax
    20bc:	89 44 24 08          	mov    %eax,0x8(%esp)
    20c0:	e8 d0 e1 ff ff       	call   295 <string_printer>
        // Clean the write_cmd buffer
        memset(write_cmd, 0, sizeof(char) * COMMANDMAXLEN);
    20c5:	c7 44 24 08 00 04 00 	movl   $0x400,0x8(%esp)
    20cc:	00 
    20cd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    20d4:	00 
    20d5:	c7 04 24 60 5c 01 00 	movl   $0x15c60,(%esp)
    20dc:	e8 90 23 00 00       	call   4471 <memset>
        write_index = 0;
    20e1:	c7 05 bc ef 00 00 00 	movl   $0x0,0xefbc
    20e8:	00 00 00 
        cur_write = -1;
    20eb:	c7 05 44 ea 00 00 ff 	movl   $0xffffffff,0xea44
    20f2:	ff ff ff 
    }
}
    20f5:	83 c4 64             	add    $0x64,%esp
    20f8:	5b                   	pop    %ebx
    20f9:	5d                   	pop    %ebp
    20fa:	c3                   	ret    

000020fb <h_closeWnd>:

void h_closeWnd(Point p) {
    20fb:	55                   	push   %ebp
    20fc:	89 e5                	mov    %esp,%ebp
    isRun = 0;
    20fe:	c7 05 40 ea 00 00 00 	movl   $0x0,0xea40
    2105:	00 00 00 
}
    2108:	5d                   	pop    %ebp
    2109:	c3                   	ret    

0000210a <addWndEvent>:

void addWndEvent(ClickableManager *cm) {
    210a:	55                   	push   %ebp
    210b:	89 e5                	mov    %esp,%ebp
    210d:	57                   	push   %edi
    210e:	56                   	push   %esi
    210f:	53                   	push   %ebx
    2110:	83 ec 4c             	sub    $0x4c,%esp
    int i;
    int n = sizeof(wndEvents) / sizeof(Handler);
    2113:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
    for (i = 0; i < n; i++) {
    211a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    2121:	e9 d3 00 00 00       	jmp    21f9 <addWndEvent+0xef>
        printf(0, "adding handler\n");
    2126:	c7 44 24 04 9c af 00 	movl   $0xaf9c,0x4(%esp)
    212d:	00 
    212e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2135:	e8 cc 26 00 00       	call   4806 <printf>
        loadBitmap(&wndRes[i].pic, wndRes[i].name);
    213a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    213d:	6b c0 34             	imul   $0x34,%eax,%eax
    2140:	8d 90 60 ea 00 00    	lea    0xea60(%eax),%edx
    2146:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2149:	6b c0 34             	imul   $0x34,%eax,%eax
    214c:	83 c0 20             	add    $0x20,%eax
    214f:	05 60 ea 00 00       	add    $0xea60,%eax
    2154:	83 c0 08             	add    $0x8,%eax
    2157:	89 54 24 04          	mov    %edx,0x4(%esp)
    215b:	89 04 24             	mov    %eax,(%esp)
    215e:	e8 e9 12 00 00       	call   344c <loadBitmap>
        createClickable(cm,
    2163:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2166:	8b 1c 85 54 ea 00 00 	mov    0xea54(,%eax,4),%ebx
    216d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2170:	6b c0 34             	imul   $0x34,%eax,%eax
    2173:	05 80 ea 00 00       	add    $0xea80,%eax
    2178:	8b 78 10             	mov    0x10(%eax),%edi
    217b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    217e:	6b c0 34             	imul   $0x34,%eax,%eax
    2181:	05 80 ea 00 00       	add    $0xea80,%eax
    2186:	8b 70 0c             	mov    0xc(%eax),%esi
    2189:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    218c:	6b c0 34             	imul   $0x34,%eax,%eax
    218f:	05 80 ea 00 00       	add    $0xea80,%eax
    2194:	8b 48 04             	mov    0x4(%eax),%ecx
    2197:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    219a:	6b c0 34             	imul   $0x34,%eax,%eax
    219d:	05 80 ea 00 00       	add    $0xea80,%eax
    21a2:	8b 10                	mov    (%eax),%edx
    21a4:	8d 45 d0             	lea    -0x30(%ebp),%eax
    21a7:	89 7c 24 10          	mov    %edi,0x10(%esp)
    21ab:	89 74 24 0c          	mov    %esi,0xc(%esp)
    21af:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    21b3:	89 54 24 04          	mov    %edx,0x4(%esp)
    21b7:	89 04 24             	mov    %eax,(%esp)
    21ba:	e8 08 1b 00 00       	call   3cc7 <initRect>
    21bf:	83 ec 04             	sub    $0x4,%esp
    21c2:	89 5c 24 18          	mov    %ebx,0x18(%esp)
    21c6:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    21cd:	00 
    21ce:	8b 45 d0             	mov    -0x30(%ebp),%eax
    21d1:	89 44 24 04          	mov    %eax,0x4(%esp)
    21d5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    21d8:	89 44 24 08          	mov    %eax,0x8(%esp)
    21dc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    21df:	89 44 24 0c          	mov    %eax,0xc(%esp)
    21e3:	8b 45 dc             	mov    -0x24(%ebp),%eax
    21e6:	89 44 24 10          	mov    %eax,0x10(%esp)
    21ea:	8b 45 08             	mov    0x8(%ebp),%eax
    21ed:	89 04 24             	mov    %eax,(%esp)
    21f0:	e8 be 1b 00 00       	call   3db3 <createClickable>
}

void addWndEvent(ClickableManager *cm) {
    int i;
    int n = sizeof(wndEvents) / sizeof(Handler);
    for (i = 0; i < n; i++) {
    21f5:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    21f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21fc:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    21ff:	0f 8c 21 ff ff ff    	jl     2126 <addWndEvent+0x1c>
        createClickable(cm,
                initRect(wndRes[i].position_x, wndRes[i].position_y,
                        wndRes[i].pic.width, wndRes[i].pic.height), MSG_LPRESS,
                wndEvents[i]);
    }
}
    2205:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2208:	5b                   	pop    %ebx
    2209:	5e                   	pop    %esi
    220a:	5f                   	pop    %edi
    220b:	5d                   	pop    %ebp
    220c:	c3                   	ret    

0000220d <main>:

int
main(int argc, char *argv[])
{
    220d:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    2211:	83 e4 f0             	and    $0xfffffff0,%esp
    2214:	ff 71 fc             	pushl  -0x4(%ecx)
    2217:	55                   	push   %ebp
    2218:	89 e5                	mov    %esp,%ebp
    221a:	57                   	push   %edi
    221b:	56                   	push   %esi
    221c:	53                   	push   %ebx
    221d:	51                   	push   %ecx
    221e:	81 ec 98 00 00 00    	sub    $0x98,%esp
    struct windowinfo winfo;
    int sh_pid, rfd, wfd;

    init_window(&winfo, "I'm a SHELL");
    2224:	c7 44 24 04 ac af 00 	movl   $0xafac,0x4(%esp)
    222b:	00 
    222c:	8d 45 a8             	lea    -0x58(%ebp),%eax
    222f:	89 04 24             	mov    %eax,(%esp)
    2232:	e8 9a e6 ff ff       	call   8d1 <init_window>
    create_shell(&sh_pid, &rfd, &wfd);
    2237:	8d 45 9c             	lea    -0x64(%ebp),%eax
    223a:	89 44 24 08          	mov    %eax,0x8(%esp)
    223e:	8d 45 a0             	lea    -0x60(%ebp),%eax
    2241:	89 44 24 04          	mov    %eax,0x4(%esp)
    2245:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    2248:	89 04 24             	mov    %eax,(%esp)
    224b:	e8 29 e7 ff ff       	call   979 <create_shell>
    init_screen(winfo.context, rfd);
    2250:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2253:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2257:	8b 45 c8             	mov    -0x38(%ebp),%eax
    225a:	89 04 24             	mov    %eax,(%esp)
    225d:	8b 45 cc             	mov    -0x34(%ebp),%eax
    2260:	89 44 24 04          	mov    %eax,0x4(%esp)
    2264:	8b 45 d0             	mov    -0x30(%ebp),%eax
    2267:	89 44 24 08          	mov    %eax,0x8(%esp)
    226b:	e8 c9 e8 ff ff       	call   b39 <init_screen>

    cm = initClickManager(winfo.context);
    2270:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
    2276:	8b 55 c8             	mov    -0x38(%ebp),%edx
    2279:	89 54 24 04          	mov    %edx,0x4(%esp)
    227d:	8b 55 cc             	mov    -0x34(%ebp),%edx
    2280:	89 54 24 08          	mov    %edx,0x8(%esp)
    2284:	8b 55 d0             	mov    -0x30(%ebp),%edx
    2287:	89 54 24 0c          	mov    %edx,0xc(%esp)
    228b:	89 04 24             	mov    %eax,(%esp)
    228e:	e8 d2 1a 00 00       	call   3d65 <initClickManager>
    2293:	83 ec 04             	sub    $0x4,%esp
    2296:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
    229c:	a3 60 60 01 00       	mov    %eax,0x16060
    22a1:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
    22a7:	a3 64 60 01 00       	mov    %eax,0x16064
    22ac:	8b 45 80             	mov    -0x80(%ebp),%eax
    22af:	a3 68 60 01 00       	mov    %eax,0x16068
    22b4:	8b 45 84             	mov    -0x7c(%ebp),%eax
    22b7:	a3 6c 60 01 00       	mov    %eax,0x1606c
    22bc:	8b 45 88             	mov    -0x78(%ebp),%eax
    22bf:	a3 70 60 01 00       	mov    %eax,0x16070
    deleteClickable(&cm.left_click, initRect(0, 0, 800, 600));
    22c4:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    22c7:	c7 44 24 10 58 02 00 	movl   $0x258,0x10(%esp)
    22ce:	00 
    22cf:	c7 44 24 0c 20 03 00 	movl   $0x320,0xc(%esp)
    22d6:	00 
    22d7:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    22de:	00 
    22df:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    22e6:	00 
    22e7:	89 04 24             	mov    %eax,(%esp)
    22ea:	e8 d8 19 00 00       	call   3cc7 <initRect>
    22ef:	83 ec 04             	sub    $0x4,%esp
    22f2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    22f5:	89 44 24 04          	mov    %eax,0x4(%esp)
    22f9:	8b 45 d8             	mov    -0x28(%ebp),%eax
    22fc:	89 44 24 08          	mov    %eax,0x8(%esp)
    2300:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2303:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2307:	8b 45 e0             	mov    -0x20(%ebp),%eax
    230a:	89 44 24 10          	mov    %eax,0x10(%esp)
    230e:	c7 04 24 60 60 01 00 	movl   $0x16060,(%esp)
    2315:	e8 b0 1b 00 00       	call   3eca <deleteClickable>
    addWndEvent(&cm);
    231a:	c7 04 24 60 60 01 00 	movl   $0x16060,(%esp)
    2321:	e8 e4 fd ff ff       	call   210a <addWndEvent>

    char write_cmd_ch;
    while (isRun) {
    2326:	e9 51 01 00 00       	jmp    247c <main+0x26f>
        getMsg(&(winfo.msg));
    232b:	8d 45 a8             	lea    -0x58(%ebp),%eax
    232e:	83 c0 04             	add    $0x4,%eax
    2331:	89 04 24             	mov    %eax,(%esp)
    2334:	e8 85 23 00 00       	call   46be <getMsg>
        switch(winfo.msg.msg_type) {
    2339:	8b 45 ac             	mov    -0x54(%ebp),%eax
    233c:	83 f8 06             	cmp    $0x6,%eax
    233f:	0f 84 b7 00 00 00    	je     23fc <main+0x1ef>
    2345:	83 f8 06             	cmp    $0x6,%eax
    2348:	7f 0a                	jg     2354 <main+0x147>
    234a:	83 f8 02             	cmp    $0x2,%eax
    234d:	74 51                	je     23a0 <main+0x193>
                        winfo.msg.concrete_msg.msg_partial_update.y1,
                        winfo.msg.concrete_msg.msg_partial_update.x2,
                        winfo.msg.concrete_msg.msg_partial_update.y2);
                break;
            default:
                break;
    234f:	e9 28 01 00 00       	jmp    247c <main+0x26f>
    addWndEvent(&cm);

    char write_cmd_ch;
    while (isRun) {
        getMsg(&(winfo.msg));
        switch(winfo.msg.msg_type) {
    2354:	83 f8 07             	cmp    $0x7,%eax
    2357:	74 0e                	je     2367 <main+0x15a>
    2359:	83 f8 08             	cmp    $0x8,%eax
    235c:	0f 84 eb 00 00 00    	je     244d <main+0x240>
                        winfo.msg.concrete_msg.msg_partial_update.y1,
                        winfo.msg.concrete_msg.msg_partial_update.x2,
                        winfo.msg.concrete_msg.msg_partial_update.y2);
                break;
            default:
                break;
    2362:	e9 15 01 00 00       	jmp    247c <main+0x26f>
    char write_cmd_ch;
    while (isRun) {
        getMsg(&(winfo.msg));
        switch(winfo.msg.msg_type) {
            case MSG_UPDATE:
                printf(1, "msg_detail %d\n", winfo.msg.msg_detail);
    2367:	8b 45 b0             	mov    -0x50(%ebp),%eax
    236a:	89 44 24 08          	mov    %eax,0x8(%esp)
    236e:	c7 44 24 04 b8 af 00 	movl   $0xafb8,0x4(%esp)
    2375:	00 
    2376:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    237d:	e8 84 24 00 00       	call   4806 <printf>
                updateWindow(winfo.id, winfo.context.addr, winfo.msg.msg_detail);
    2382:	8b 4d b0             	mov    -0x50(%ebp),%ecx
    2385:	8b 55 c8             	mov    -0x38(%ebp),%edx
    2388:	8b 45 a8             	mov    -0x58(%ebp),%eax
    238b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    238f:	89 54 24 04          	mov    %edx,0x4(%esp)
    2393:	89 04 24             	mov    %eax,(%esp)
    2396:	e8 3b 23 00 00       	call   46d6 <updateWindow>
                break;
    239b:	e9 dc 00 00 00       	jmp    247c <main+0x26f>
            case MSG_LPRESS:
                p = initPoint(winfo.msg.concrete_msg.msg_mouse.x,
    23a0:	8b 4d b8             	mov    -0x48(%ebp),%ecx
    23a3:	8b 55 b4             	mov    -0x4c(%ebp),%edx
    23a6:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
    23ac:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    23b0:	89 54 24 04          	mov    %edx,0x4(%esp)
    23b4:	89 04 24             	mov    %eax,(%esp)
    23b7:	e8 e4 18 00 00       	call   3ca0 <initPoint>
    23bc:	83 ec 04             	sub    $0x4,%esp
    23bf:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
    23c5:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
    23cb:	a3 40 5c 01 00       	mov    %eax,0x15c40
    23d0:	89 15 44 5c 01 00    	mov    %edx,0x15c44
                    winfo.msg.concrete_msg.msg_mouse.y);
                executeHandler(cm.left_click, p);
    23d6:	8b 0d 60 60 01 00    	mov    0x16060,%ecx
    23dc:	a1 40 5c 01 00       	mov    0x15c40,%eax
    23e1:	8b 15 44 5c 01 00    	mov    0x15c44,%edx
    23e7:	89 44 24 04          	mov    %eax,0x4(%esp)
    23eb:	89 54 24 08          	mov    %edx,0x8(%esp)
    23ef:	89 0c 24             	mov    %ecx,(%esp)
    23f2:	e8 b3 1b 00 00       	call   3faa <executeHandler>
                break;
    23f7:	e9 80 00 00 00       	jmp    247c <main+0x26f>
            case MSG_KEYDOWN:
                write_cmd_ch = winfo.msg.concrete_msg.msg_key.key;
    23fc:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
    2400:	88 45 e7             	mov    %al,-0x19(%ebp)
                handle_keydown(winfo.context, write_cmd_ch, rfd, wfd);
    2403:	8b 4d 9c             	mov    -0x64(%ebp),%ecx
    2406:	8b 55 a0             	mov    -0x60(%ebp),%edx
    2409:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
    240d:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2411:	89 54 24 10          	mov    %edx,0x10(%esp)
    2415:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2419:	8b 45 c8             	mov    -0x38(%ebp),%eax
    241c:	89 04 24             	mov    %eax,(%esp)
    241f:	8b 45 cc             	mov    -0x34(%ebp),%eax
    2422:	89 44 24 04          	mov    %eax,0x4(%esp)
    2426:	8b 45 d0             	mov    -0x30(%ebp),%eax
    2429:	89 44 24 08          	mov    %eax,0x8(%esp)
    242d:	e8 e0 e7 ff ff       	call   c12 <handle_keydown>
                updateWindow(winfo.id, winfo.context.addr, winfo.msg.msg_detail);
    2432:	8b 4d b0             	mov    -0x50(%ebp),%ecx
    2435:	8b 55 c8             	mov    -0x38(%ebp),%edx
    2438:	8b 45 a8             	mov    -0x58(%ebp),%eax
    243b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    243f:	89 54 24 04          	mov    %edx,0x4(%esp)
    2443:	89 04 24             	mov    %eax,(%esp)
    2446:	e8 8b 22 00 00       	call   46d6 <updateWindow>
                break;
    244b:	eb 2f                	jmp    247c <main+0x26f>
            case MSG_PARTIAL_UPDATE:
                updatePartialWindow(winfo.id, winfo.context.addr,
    244d:	8b 7d c0             	mov    -0x40(%ebp),%edi
    2450:	8b 75 bc             	mov    -0x44(%ebp),%esi
    2453:	8b 5d b8             	mov    -0x48(%ebp),%ebx
    2456:	8b 4d b4             	mov    -0x4c(%ebp),%ecx
    2459:	8b 55 c8             	mov    -0x38(%ebp),%edx
    245c:	8b 45 a8             	mov    -0x58(%ebp),%eax
    245f:	89 7c 24 14          	mov    %edi,0x14(%esp)
    2463:	89 74 24 10          	mov    %esi,0x10(%esp)
    2467:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    246b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    246f:	89 54 24 04          	mov    %edx,0x4(%esp)
    2473:	89 04 24             	mov    %eax,(%esp)
    2476:	e8 63 22 00 00       	call   46de <updatePartialWindow>
                        winfo.msg.concrete_msg.msg_partial_update.x1,
                        winfo.msg.concrete_msg.msg_partial_update.y1,
                        winfo.msg.concrete_msg.msg_partial_update.x2,
                        winfo.msg.concrete_msg.msg_partial_update.y2);
                break;
    247b:	90                   	nop
    cm = initClickManager(winfo.context);
    deleteClickable(&cm.left_click, initRect(0, 0, 800, 600));
    addWndEvent(&cm);

    char write_cmd_ch;
    while (isRun) {
    247c:	a1 40 ea 00 00       	mov    0xea40,%eax
    2481:	85 c0                	test   %eax,%eax
    2483:	0f 85 a2 fe ff ff    	jne    232b <main+0x11e>
            default:
                break;
        }
    }

    free_context(&(winfo.context), winfo.id);
    2489:	8b 45 a8             	mov    -0x58(%ebp),%eax
    248c:	89 44 24 04          	mov    %eax,0x4(%esp)
    2490:	8d 45 a8             	lea    -0x58(%ebp),%eax
    2493:	83 c0 20             	add    $0x20,%eax
    2496:	89 04 24             	mov    %eax,(%esp)
    2499:	e8 88 00 00 00       	call   2526 <free_context>
    exit();
    249e:	e8 7b 21 00 00       	call   461e <exit>

000024a3 <init_context>:
#include "stat.h"
#include "user.h"
#include "drawingAPI.h"

int init_context(struct Context* context_ptr, int width, int height)
{
    24a3:	55                   	push   %ebp
    24a4:	89 e5                	mov    %esp,%ebp
    24a6:	83 ec 18             	sub    $0x18,%esp
    context_ptr->width = width;
    24a9:	8b 45 08             	mov    0x8(%ebp),%eax
    24ac:	8b 55 0c             	mov    0xc(%ebp),%edx
    24af:	89 50 04             	mov    %edx,0x4(%eax)
    context_ptr->height = height;
    24b2:	8b 45 08             	mov    0x8(%ebp),%eax
    24b5:	8b 55 10             	mov    0x10(%ebp),%edx
    24b8:	89 50 08             	mov    %edx,0x8(%eax)
    context_ptr->addr = (unsigned short*)malloc(sizeof(unsigned short) * width * height);
    24bb:	8b 55 0c             	mov    0xc(%ebp),%edx
    24be:	8b 45 10             	mov    0x10(%ebp),%eax
    24c1:	0f af c2             	imul   %edx,%eax
    24c4:	01 c0                	add    %eax,%eax
    24c6:	89 04 24             	mov    %eax,(%esp)
    24c9:	e8 24 26 00 00       	call   4af2 <malloc>
    24ce:	8b 55 08             	mov    0x8(%ebp),%edx
    24d1:	89 02                	mov    %eax,(%edx)
    memset(context_ptr->addr, 0, sizeof(unsigned short) * width * height);
    24d3:	8b 55 0c             	mov    0xc(%ebp),%edx
    24d6:	8b 45 10             	mov    0x10(%ebp),%eax
    24d9:	0f af c2             	imul   %edx,%eax
    24dc:	8d 14 00             	lea    (%eax,%eax,1),%edx
    24df:	8b 45 08             	mov    0x8(%ebp),%eax
    24e2:	8b 00                	mov    (%eax),%eax
    24e4:	89 54 24 08          	mov    %edx,0x8(%esp)
    24e8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    24ef:	00 
    24f0:	89 04 24             	mov    %eax,(%esp)
    24f3:	e8 79 1f 00 00       	call   4471 <memset>
    initializeASCII();
    24f8:	e8 93 01 00 00       	call   2690 <initializeASCII>
    initializeGBK();
    24fd:	e8 17 03 00 00       	call   2819 <initializeGBK>
    return createWindow(0, 0, width, height);
    2502:	8b 45 10             	mov    0x10(%ebp),%eax
    2505:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2509:	8b 45 0c             	mov    0xc(%ebp),%eax
    250c:	89 44 24 08          	mov    %eax,0x8(%esp)
    2510:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2517:	00 
    2518:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    251f:	e8 a2 21 00 00       	call   46c6 <createWindow>
}
    2524:	c9                   	leave  
    2525:	c3                   	ret    

00002526 <free_context>:

void free_context(struct Context* context_ptr, int winid)
{
    2526:	55                   	push   %ebp
    2527:	89 e5                	mov    %esp,%ebp
    2529:	83 ec 18             	sub    $0x18,%esp
    free(context_ptr->addr);
    252c:	8b 45 08             	mov    0x8(%ebp),%eax
    252f:	8b 00                	mov    (%eax),%eax
    2531:	89 04 24             	mov    %eax,(%esp)
    2534:	e8 80 24 00 00       	call   49b9 <free>
    freeASCII();
    2539:	e8 c6 02 00 00       	call   2804 <freeASCII>
    freeGBK();
    253e:	e8 7e 03 00 00       	call   28c1 <freeGBK>
    destroyWindow(winid);
    2543:	8b 45 0c             	mov    0xc(%ebp),%eax
    2546:	89 04 24             	mov    %eax,(%esp)
    2549:	e8 80 21 00 00       	call   46ce <destroyWindow>
}
    254e:	c9                   	leave  
    254f:	c3                   	ret    

00002550 <draw_point>:
*             then do nothing!
*/

void
draw_point(struct Context c, unsigned int x, unsigned int y, unsigned short color)
{
    2550:	55                   	push   %ebp
    2551:	89 e5                	mov    %esp,%ebp
    2553:	83 ec 04             	sub    $0x4,%esp
    2556:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2559:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  if(x >= c.width)
    255d:	8b 45 0c             	mov    0xc(%ebp),%eax
    2560:	3b 45 14             	cmp    0x14(%ebp),%eax
    2563:	77 02                	ja     2567 <draw_point+0x17>
    return;
    2565:	eb 26                	jmp    258d <draw_point+0x3d>
  if(y >= c.height)
    2567:	8b 45 10             	mov    0x10(%ebp),%eax
    256a:	3b 45 18             	cmp    0x18(%ebp),%eax
    256d:	77 02                	ja     2571 <draw_point+0x21>
    return;
    256f:	eb 1c                	jmp    258d <draw_point+0x3d>
  c.addr[y*c.width+x] = color;
    2571:	8b 55 08             	mov    0x8(%ebp),%edx
    2574:	8b 45 0c             	mov    0xc(%ebp),%eax
    2577:	0f af 45 18          	imul   0x18(%ebp),%eax
    257b:	89 c1                	mov    %eax,%ecx
    257d:	8b 45 14             	mov    0x14(%ebp),%eax
    2580:	01 c8                	add    %ecx,%eax
    2582:	01 c0                	add    %eax,%eax
    2584:	01 c2                	add    %eax,%edx
    2586:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
    258a:	66 89 02             	mov    %ax,(%edx)
}
    258d:	c9                   	leave  
    258e:	c3                   	ret    

0000258f <fill_rect>:
/*
*fill_rect: set a rect area with a certain color
*/
void
fill_rect(struct Context c, unsigned int bx, unsigned int by, unsigned int width, unsigned int height, unsigned short color)
{
    258f:	55                   	push   %ebp
    2590:	89 e5                	mov    %esp,%ebp
    2592:	83 ec 2c             	sub    $0x2c,%esp
    2595:	8b 45 24             	mov    0x24(%ebp),%eax
    2598:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
    259c:	8b 45 1c             	mov    0x1c(%ebp),%eax
    259f:	8b 55 14             	mov    0x14(%ebp),%edx
    25a2:	01 c2                	add    %eax,%edx
    25a4:	8b 45 0c             	mov    0xc(%ebp),%eax
    25a7:	39 c2                	cmp    %eax,%edx
    25a9:	0f 46 c2             	cmovbe %edx,%eax
    25ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int my = c.height < by + height ? c.height : by + height;
    25af:	8b 45 20             	mov    0x20(%ebp),%eax
    25b2:	8b 55 18             	mov    0x18(%ebp),%edx
    25b5:	01 c2                	add    %eax,%edx
    25b7:	8b 45 10             	mov    0x10(%ebp),%eax
    25ba:	39 c2                	cmp    %eax,%edx
    25bc:	0f 46 c2             	cmovbe %edx,%eax
    25bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	for (y = by; y < my; y++)
    25c2:	8b 45 18             	mov    0x18(%ebp),%eax
    25c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    25c8:	eb 47                	jmp    2611 <fill_rect+0x82>
	{
		for (x = bx; x < mx; x++)
    25ca:	8b 45 14             	mov    0x14(%ebp),%eax
    25cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
    25d0:	eb 33                	jmp    2605 <fill_rect+0x76>
		{
			draw_point(c, x, y, color);
    25d2:	0f b7 4d ec          	movzwl -0x14(%ebp),%ecx
    25d6:	8b 55 f8             	mov    -0x8(%ebp),%edx
    25d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    25dc:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    25e0:	89 54 24 10          	mov    %edx,0x10(%esp)
    25e4:	89 44 24 0c          	mov    %eax,0xc(%esp)
    25e8:	8b 45 08             	mov    0x8(%ebp),%eax
    25eb:	89 04 24             	mov    %eax,(%esp)
    25ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    25f1:	89 44 24 04          	mov    %eax,0x4(%esp)
    25f5:	8b 45 10             	mov    0x10(%ebp),%eax
    25f8:	89 44 24 08          	mov    %eax,0x8(%esp)
    25fc:	e8 4f ff ff ff       	call   2550 <draw_point>
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
	int my = c.height < by + height ? c.height : by + height;
	for (y = by; y < my; y++)
	{
		for (x = bx; x < mx; x++)
    2601:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    2605:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2608:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    260b:	7c c5                	jl     25d2 <fill_rect+0x43>
fill_rect(struct Context c, unsigned int bx, unsigned int by, unsigned int width, unsigned int height, unsigned short color)
{
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
	int my = c.height < by + height ? c.height : by + height;
	for (y = by; y < my; y++)
    260d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    2611:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2614:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    2617:	7c b1                	jl     25ca <fill_rect+0x3b>
		for (x = bx; x < mx; x++)
		{
			draw_point(c, x, y, color);
		}
	}
}
    2619:	c9                   	leave  
    261a:	c3                   	ret    

0000261b <printBinary>:

void printBinary(char c)
{
    261b:	55                   	push   %ebp
    261c:	89 e5                	mov    %esp,%ebp
    261e:	83 ec 28             	sub    $0x28,%esp
    2621:	8b 45 08             	mov    0x8(%ebp),%eax
    2624:	88 45 e4             	mov    %al,-0x1c(%ebp)
	int i;
	for (i = 0; i < 8; i++)
    2627:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    262e:	eb 44                	jmp    2674 <printBinary+0x59>
	{
		if(((c << i) & 0x80) != 0)
    2630:	0f be 55 e4          	movsbl -0x1c(%ebp),%edx
    2634:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2637:	89 c1                	mov    %eax,%ecx
    2639:	d3 e2                	shl    %cl,%edx
    263b:	89 d0                	mov    %edx,%eax
    263d:	25 80 00 00 00       	and    $0x80,%eax
    2642:	85 c0                	test   %eax,%eax
    2644:	74 16                	je     265c <printBinary+0x41>
		{
			printf(0, "1");
    2646:	c7 44 24 04 c7 af 00 	movl   $0xafc7,0x4(%esp)
    264d:	00 
    264e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2655:	e8 ac 21 00 00       	call   4806 <printf>
    265a:	eb 14                	jmp    2670 <printBinary+0x55>
		}
		else
		{
			printf(0, "0");
    265c:	c7 44 24 04 c9 af 00 	movl   $0xafc9,0x4(%esp)
    2663:	00 
    2664:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    266b:	e8 96 21 00 00       	call   4806 <printf>
}

void printBinary(char c)
{
	int i;
	for (i = 0; i < 8; i++)
    2670:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2674:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    2678:	7e b6                	jle    2630 <printBinary+0x15>
		{
			printf(0, "0");
		}
	}

	printf(0, "\n");
    267a:	c7 44 24 04 cb af 00 	movl   $0xafcb,0x4(%esp)
    2681:	00 
    2682:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2689:	e8 78 21 00 00       	call   4806 <printf>
}
    268e:	c9                   	leave  
    268f:	c3                   	ret    

00002690 <initializeASCII>:
char buf[512];
//hankaku是一个数组，将hankaku.txt文件中的每一行转化成一个8位整数（unsigned short）
//每16个整数可以代表一个字符
unsigned char *hankaku;
void initializeASCII()
{
    2690:	55                   	push   %ebp
    2691:	89 e5                	mov    %esp,%ebp
    2693:	56                   	push   %esi
    2694:	53                   	push   %ebx
    2695:	83 ec 30             	sub    $0x30,%esp

	int fd, n, i;
	int x, y;
	printf(0,"initialzing ASCII\n");
    2698:	c7 44 24 04 cd af 00 	movl   $0xafcd,0x4(%esp)
    269f:	00 
    26a0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26a7:	e8 5a 21 00 00       	call   4806 <printf>
	//打开hankaku.txt文件
	if((fd = open(HANKAKU, 0)) < 0){
    26ac:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    26b3:	00 
    26b4:	c7 04 24 e0 af 00 00 	movl   $0xafe0,(%esp)
    26bb:	e8 9e 1f 00 00       	call   465e <open>
    26c0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    26c3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    26c7:	79 21                	jns    26ea <initializeASCII+0x5a>
	  printf(0,"cannot open %s\n", HANKAKU);
    26c9:	c7 44 24 08 e0 af 00 	movl   $0xafe0,0x8(%esp)
    26d0:	00 
    26d1:	c7 44 24 04 ec af 00 	movl   $0xafec,0x4(%esp)
    26d8:	00 
    26d9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    26e0:	e8 21 21 00 00       	call   4806 <printf>
	  return;
    26e5:	e9 13 01 00 00       	jmp    27fd <initializeASCII+0x16d>
	}
	//申请hankaku数组
	hankaku = malloc(ASCII_NUM*ASCII_HEIGHT);
    26ea:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    26f1:	e8 fc 23 00 00       	call   4af2 <malloc>
    26f6:	a3 c0 fa 02 00       	mov    %eax,0x2fac0
	for (i = 0; i < ASCII_NUM; i++)
    26fb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2702:	eb 12                	jmp    2716 <initializeASCII+0x86>
	{
		hankaku[i] = 0;
    2704:	8b 15 c0 fa 02 00    	mov    0x2fac0,%edx
    270a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    270d:	01 d0                	add    %edx,%eax
    270f:	c6 00 00             	movb   $0x0,(%eax)
	  printf(0,"cannot open %s\n", HANKAKU);
	  return;
	}
	//申请hankaku数组
	hankaku = malloc(ASCII_NUM*ASCII_HEIGHT);
	for (i = 0; i < ASCII_NUM; i++)
    2712:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2716:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
    271d:	7e e5                	jle    2704 <initializeASCII+0x74>

	//不断读取文件，如果读到的字符是“*/."，就按顺序记录到hankaku数组中
	//y表示当前记录到第几行（对应于hankaku数组里的第几个数），x表示当前记录到第几列
	//如果当前字符是"*",则对应第y个数第x位置为1
	//每当x == ASCII_WIDTH，x重新置为0, y++
	x = 0;
    271f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	y = 0;
    2726:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	while((n = read(fd, buf, sizeof(buf))) > 0)
    272d:	e9 84 00 00 00       	jmp    27b6 <initializeASCII+0x126>
	{
		for (i = 0; i < n; i++){
    2732:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2739:	eb 73                	jmp    27ae <initializeASCII+0x11e>
			//printf(0,"%c, %d", buf[i], i);
			if (buf[i] == '*' || buf[i] == '.')
    273b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    273e:	05 e0 fa 02 00       	add    $0x2fae0,%eax
    2743:	0f b6 00             	movzbl (%eax),%eax
    2746:	3c 2a                	cmp    $0x2a,%al
    2748:	74 0f                	je     2759 <initializeASCII+0xc9>
    274a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    274d:	05 e0 fa 02 00       	add    $0x2fae0,%eax
    2752:	0f b6 00             	movzbl (%eax),%eax
    2755:	3c 2e                	cmp    $0x2e,%al
    2757:	75 51                	jne    27aa <initializeASCII+0x11a>
			{
				if (buf[i] == '*')
    2759:	8b 45 f4             	mov    -0xc(%ebp),%eax
    275c:	05 e0 fa 02 00       	add    $0x2fae0,%eax
    2761:	0f b6 00             	movzbl (%eax),%eax
    2764:	3c 2a                	cmp    $0x2a,%al
    2766:	75 2d                	jne    2795 <initializeASCII+0x105>
				{
					hankaku[y] |= (0x80 >> x);
    2768:	8b 15 c0 fa 02 00    	mov    0x2fac0,%edx
    276e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2771:	01 c2                	add    %eax,%edx
    2773:	8b 0d c0 fa 02 00    	mov    0x2fac0,%ecx
    2779:	8b 45 ec             	mov    -0x14(%ebp),%eax
    277c:	01 c8                	add    %ecx,%eax
    277e:	0f b6 00             	movzbl (%eax),%eax
    2781:	89 c3                	mov    %eax,%ebx
    2783:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2786:	be 80 00 00 00       	mov    $0x80,%esi
    278b:	89 c1                	mov    %eax,%ecx
    278d:	d3 fe                	sar    %cl,%esi
    278f:	89 f0                	mov    %esi,%eax
    2791:	09 d8                	or     %ebx,%eax
    2793:	88 02                	mov    %al,(%edx)
				}
				x ++;
    2795:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
				if (x >= ASCII_WIDTH)
    2799:	83 7d f0 07          	cmpl   $0x7,-0x10(%ebp)
    279d:	7e 0b                	jle    27aa <initializeASCII+0x11a>
				{
					x = 0;
    279f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
					y ++;
    27a6:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
	//每当x == ASCII_WIDTH，x重新置为0, y++
	x = 0;
	y = 0;
	while((n = read(fd, buf, sizeof(buf))) > 0)
	{
		for (i = 0; i < n; i++){
    27aa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    27ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27b1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    27b4:	7c 85                	jl     273b <initializeASCII+0xab>
	//y表示当前记录到第几行（对应于hankaku数组里的第几个数），x表示当前记录到第几列
	//如果当前字符是"*",则对应第y个数第x位置为1
	//每当x == ASCII_WIDTH，x重新置为0, y++
	x = 0;
	y = 0;
	while((n = read(fd, buf, sizeof(buf))) > 0)
    27b6:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    27bd:	00 
    27be:	c7 44 24 04 e0 fa 02 	movl   $0x2fae0,0x4(%esp)
    27c5:	00 
    27c6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    27c9:	89 04 24             	mov    %eax,(%esp)
    27cc:	e8 65 1e 00 00       	call   4636 <read>
    27d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    27d4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    27d8:	0f 8f 54 ff ff ff    	jg     2732 <initializeASCII+0xa2>

//	for (i = 0; i < ASCII_NUM * ASCII_HEIGHT; i++)
//	{
//		printBinary(hankaku[i]);
//	}
	printf(0,"initialzing ASCII complete!\n");
    27de:	c7 44 24 04 fc af 00 	movl   $0xaffc,0x4(%esp)
    27e5:	00 
    27e6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    27ed:	e8 14 20 00 00       	call   4806 <printf>
	close(fd);
    27f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    27f5:	89 04 24             	mov    %eax,(%esp)
    27f8:	e8 49 1e 00 00       	call   4646 <close>
}
    27fd:	83 c4 30             	add    $0x30,%esp
    2800:	5b                   	pop    %ebx
    2801:	5e                   	pop    %esi
    2802:	5d                   	pop    %ebp
    2803:	c3                   	ret    

00002804 <freeASCII>:

void freeASCII(){
    2804:	55                   	push   %ebp
    2805:	89 e5                	mov    %esp,%ebp
    2807:	83 ec 18             	sub    $0x18,%esp
	free(hankaku);
    280a:	a1 c0 fa 02 00       	mov    0x2fac0,%eax
    280f:	89 04 24             	mov    %eax,(%esp)
    2812:	e8 a2 21 00 00       	call   49b9 <free>
}
    2817:	c9                   	leave  
    2818:	c3                   	ret    

00002819 <initializeGBK>:

struct File_Node fontFile;
void initializeGBK(){
    2819:	55                   	push   %ebp
    281a:	89 e5                	mov    %esp,%ebp
    281c:	83 ec 28             	sub    $0x28,%esp
	int fd;
	printf(0,"initialzing gbk\n");
    281f:	c7 44 24 04 19 b0 00 	movl   $0xb019,0x4(%esp)
    2826:	00 
    2827:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    282e:	e8 d3 1f 00 00       	call   4806 <printf>
	if((fd = open(HZK16, 0)) < 0){
    2833:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    283a:	00 
    283b:	c7 04 24 2a b0 00 00 	movl   $0xb02a,(%esp)
    2842:	e8 17 1e 00 00       	call   465e <open>
    2847:	89 45 f4             	mov    %eax,-0xc(%ebp)
    284a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    284e:	79 1e                	jns    286e <initializeGBK+0x55>
		printf(0,"cannot open %s\n", HZK16);
    2850:	c7 44 24 08 2a b0 00 	movl   $0xb02a,0x8(%esp)
    2857:	00 
    2858:	c7 44 24 04 ec af 00 	movl   $0xafec,0x4(%esp)
    285f:	00 
    2860:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2867:	e8 9a 1f 00 00       	call   4806 <printf>
		return;
    286c:	eb 51                	jmp    28bf <initializeGBK+0xa6>
	}
	fontFile.buf = malloc(27000*sizeof(unsigned char));
    286e:	c7 04 24 78 69 00 00 	movl   $0x6978,(%esp)
    2875:	e8 78 22 00 00       	call   4af2 <malloc>
    287a:	a3 c4 fa 02 00       	mov    %eax,0x2fac4
	fontFile.size = read(fd, fontFile.buf, 27000);
    287f:	a1 c4 fa 02 00       	mov    0x2fac4,%eax
    2884:	c7 44 24 08 78 69 00 	movl   $0x6978,0x8(%esp)
    288b:	00 
    288c:	89 44 24 04          	mov    %eax,0x4(%esp)
    2890:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2893:	89 04 24             	mov    %eax,(%esp)
    2896:	e8 9b 1d 00 00       	call   4636 <read>
    289b:	a3 c8 fa 02 00       	mov    %eax,0x2fac8
	printf(0,"initialzing gbk complete!\n");
    28a0:	c7 44 24 04 34 b0 00 	movl   $0xb034,0x4(%esp)
    28a7:	00 
    28a8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    28af:	e8 52 1f 00 00       	call   4806 <printf>
	close(fd);
    28b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28b7:	89 04 24             	mov    %eax,(%esp)
    28ba:	e8 87 1d 00 00       	call   4646 <close>
}
    28bf:	c9                   	leave  
    28c0:	c3                   	ret    

000028c1 <freeGBK>:

void freeGBK(){
    28c1:	55                   	push   %ebp
    28c2:	89 e5                	mov    %esp,%ebp
    28c4:	83 ec 18             	sub    $0x18,%esp
	free(fontFile.buf);
    28c7:	a1 c4 fa 02 00       	mov    0x2fac4,%eax
    28cc:	89 04 24             	mov    %eax,(%esp)
    28cf:	e8 e5 20 00 00       	call   49b9 <free>
}
    28d4:	c9                   	leave  
    28d5:	c3                   	ret    

000028d6 <put_ascii>:

void put_ascii(struct Context c, unsigned char ascii, unsigned short colorNum, int x, int y)
{
    28d6:	55                   	push   %ebp
    28d7:	89 e5                	mov    %esp,%ebp
    28d9:	53                   	push   %ebx
    28da:	83 ec 30             	sub    $0x30,%esp
    28dd:	8b 55 14             	mov    0x14(%ebp),%edx
    28e0:	8b 45 18             	mov    0x18(%ebp),%eax
    28e3:	88 55 e8             	mov    %dl,-0x18(%ebp)
    28e6:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
	int tmpX, tmpY;
	//printf(0, "put ascii: %c, color: %d\n", ascii, colorNum);
	for(tmpY = y; tmpY < y + 16; tmpY++) {
    28ea:	8b 45 20             	mov    0x20(%ebp),%eax
    28ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
    28f0:	eb 7f                	jmp    2971 <put_ascii+0x9b>
		for(tmpX = 0; tmpX < 8; tmpX++) {
    28f2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    28f9:	eb 6c                	jmp    2967 <put_ascii+0x91>
			if((((hankaku + (ascii * 16))[tmpY - y] << tmpX) & 0x80) == 0x80) {
    28fb:	a1 c0 fa 02 00       	mov    0x2fac0,%eax
    2900:	0f b6 55 e8          	movzbl -0x18(%ebp),%edx
    2904:	c1 e2 04             	shl    $0x4,%edx
    2907:	89 d1                	mov    %edx,%ecx
    2909:	8b 55 20             	mov    0x20(%ebp),%edx
    290c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    290f:	29 d3                	sub    %edx,%ebx
    2911:	89 da                	mov    %ebx,%edx
    2913:	01 ca                	add    %ecx,%edx
    2915:	01 d0                	add    %edx,%eax
    2917:	0f b6 00             	movzbl (%eax),%eax
    291a:	0f b6 d0             	movzbl %al,%edx
    291d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2920:	89 c1                	mov    %eax,%ecx
    2922:	d3 e2                	shl    %cl,%edx
    2924:	89 d0                	mov    %edx,%eax
    2926:	25 80 00 00 00       	and    $0x80,%eax
    292b:	85 c0                	test   %eax,%eax
    292d:	74 34                	je     2963 <put_ascii+0x8d>
				//printf(0, "x: %d, y: %d\n", x + tmpX, tmpY);
				draw_point(c, x + tmpX, tmpY, colorNum);
    292f:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
    2933:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2936:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2939:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
    293c:	01 d8                	add    %ebx,%eax
    293e:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2942:	89 54 24 10          	mov    %edx,0x10(%esp)
    2946:	89 44 24 0c          	mov    %eax,0xc(%esp)
    294a:	8b 45 08             	mov    0x8(%ebp),%eax
    294d:	89 04 24             	mov    %eax,(%esp)
    2950:	8b 45 0c             	mov    0xc(%ebp),%eax
    2953:	89 44 24 04          	mov    %eax,0x4(%esp)
    2957:	8b 45 10             	mov    0x10(%ebp),%eax
    295a:	89 44 24 08          	mov    %eax,0x8(%esp)
    295e:	e8 ed fb ff ff       	call   2550 <draw_point>
void put_ascii(struct Context c, unsigned char ascii, unsigned short colorNum, int x, int y)
{
	int tmpX, tmpY;
	//printf(0, "put ascii: %c, color: %d\n", ascii, colorNum);
	for(tmpY = y; tmpY < y + 16; tmpY++) {
		for(tmpX = 0; tmpX < 8; tmpX++) {
    2963:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    2967:	83 7d f8 07          	cmpl   $0x7,-0x8(%ebp)
    296b:	7e 8e                	jle    28fb <put_ascii+0x25>

void put_ascii(struct Context c, unsigned char ascii, unsigned short colorNum, int x, int y)
{
	int tmpX, tmpY;
	//printf(0, "put ascii: %c, color: %d\n", ascii, colorNum);
	for(tmpY = y; tmpY < y + 16; tmpY++) {
    296d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2971:	8b 45 20             	mov    0x20(%ebp),%eax
    2974:	83 c0 10             	add    $0x10,%eax
    2977:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    297a:	0f 8f 72 ff ff ff    	jg     28f2 <put_ascii+0x1c>
				draw_point(c, x + tmpX, tmpY, colorNum);
				//sheet->buf[tmpY * sheet->width + x + tmpX] = colorNum;
			}
		}
	}
}
    2980:	83 c4 30             	add    $0x30,%esp
    2983:	5b                   	pop    %ebx
    2984:	5d                   	pop    %ebp
    2985:	c3                   	ret    

00002986 <put_gbk>:

void put_gbk(struct Context c, short gbk, unsigned short colorNum, int x, int y)
{
    2986:	55                   	push   %ebp
    2987:	89 e5                	mov    %esp,%ebp
    2989:	53                   	push   %ebx
    298a:	83 ec 34             	sub    $0x34,%esp
    298d:	8b 55 14             	mov    0x14(%ebp),%edx
    2990:	8b 45 18             	mov    0x18(%ebp),%eax
    2993:	66 89 55 e8          	mov    %dx,-0x18(%ebp)
    2997:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
	int tmpX, tmpY;
	unsigned int offset;
	unsigned char *hzk16Base;
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
    299b:	0f bf 45 e8          	movswl -0x18(%ebp),%eax
    299f:	0f b6 c0             	movzbl %al,%eax
    29a2:	3d a0 00 00 00       	cmp    $0xa0,%eax
    29a7:	0f 8e 40 01 00 00    	jle    2aed <put_gbk+0x167>
    29ad:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
    29b1:	66 c1 f8 08          	sar    $0x8,%ax
    29b5:	98                   	cwtl   
    29b6:	0f b6 c0             	movzbl %al,%eax
    29b9:	3d a0 00 00 00       	cmp    $0xa0,%eax
    29be:	0f 8e 29 01 00 00    	jle    2aed <put_gbk+0x167>
		hzk16Base = fontFile.buf;
    29c4:	a1 c4 fa 02 00       	mov    0x2fac4,%eax
    29c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
		offset = (((gbk & 0x00FF) - 0xa1) * 94 + (((gbk >> 8) & 0x00FF) - 0xa1)) * 32;
    29cc:	0f bf 45 e8          	movswl -0x18(%ebp),%eax
    29d0:	0f b6 c0             	movzbl %al,%eax
    29d3:	2d a1 00 00 00       	sub    $0xa1,%eax
    29d8:	6b c0 5e             	imul   $0x5e,%eax,%eax
    29db:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
    29df:	66 c1 fa 08          	sar    $0x8,%dx
    29e3:	0f bf d2             	movswl %dx,%edx
    29e6:	0f b6 d2             	movzbl %dl,%edx
    29e9:	81 ea a1 00 00 00    	sub    $0xa1,%edx
    29ef:	01 d0                	add    %edx,%eax
    29f1:	c1 e0 05             	shl    $0x5,%eax
    29f4:	89 45 f0             	mov    %eax,-0x10(%ebp)

		for(tmpY = y; tmpY < 16 + y; tmpY++) {
    29f7:	8b 45 20             	mov    0x20(%ebp),%eax
    29fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    29fd:	e9 da 00 00 00       	jmp    2adc <put_gbk+0x156>
			for(tmpX = 0; tmpX < 8; tmpX++) {
    2a02:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    2a09:	eb 58                	jmp    2a63 <put_gbk+0xdd>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
    2a0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2a0e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    2a11:	01 d0                	add    %edx,%eax
    2a13:	0f b6 00             	movzbl (%eax),%eax
    2a16:	0f b6 d0             	movzbl %al,%edx
    2a19:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a1c:	89 c1                	mov    %eax,%ecx
    2a1e:	d3 e2                	shl    %cl,%edx
    2a20:	89 d0                	mov    %edx,%eax
    2a22:	25 80 00 00 00       	and    $0x80,%eax
    2a27:	85 c0                	test   %eax,%eax
    2a29:	74 34                	je     2a5f <put_gbk+0xd9>
					draw_point(c, x + tmpX, tmpY, colorNum);
    2a2b:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
    2a2f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2a32:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a35:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
    2a38:	01 d8                	add    %ebx,%eax
    2a3a:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2a3e:	89 54 24 10          	mov    %edx,0x10(%esp)
    2a42:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2a46:	8b 45 08             	mov    0x8(%ebp),%eax
    2a49:	89 04 24             	mov    %eax,(%esp)
    2a4c:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a4f:	89 44 24 04          	mov    %eax,0x4(%esp)
    2a53:	8b 45 10             	mov    0x10(%ebp),%eax
    2a56:	89 44 24 08          	mov    %eax,0x8(%esp)
    2a5a:	e8 f1 fa ff ff       	call   2550 <draw_point>
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
		hzk16Base = fontFile.buf;
		offset = (((gbk & 0x00FF) - 0xa1) * 94 + (((gbk >> 8) & 0x00FF) - 0xa1)) * 32;

		for(tmpY = y; tmpY < 16 + y; tmpY++) {
			for(tmpX = 0; tmpX < 8; tmpX++) {
    2a5f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    2a63:	83 7d f8 07          	cmpl   $0x7,-0x8(%ebp)
    2a67:	7e a2                	jle    2a0b <put_gbk+0x85>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
					draw_point(c, x + tmpX, tmpY, colorNum);
					//sheet->buf[tmpY * sheet->width + x + tmpX] = colorNum;
				}
			}
			offset++;
    2a69:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
			for(tmpX = 0; tmpX < 8; tmpX++) {
    2a6d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    2a74:	eb 58                	jmp    2ace <put_gbk+0x148>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
    2a76:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2a79:	8b 55 ec             	mov    -0x14(%ebp),%edx
    2a7c:	01 d0                	add    %edx,%eax
    2a7e:	0f b6 00             	movzbl (%eax),%eax
    2a81:	0f b6 d0             	movzbl %al,%edx
    2a84:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a87:	89 c1                	mov    %eax,%ecx
    2a89:	d3 e2                	shl    %cl,%edx
    2a8b:	89 d0                	mov    %edx,%eax
    2a8d:	25 80 00 00 00       	and    $0x80,%eax
    2a92:	85 c0                	test   %eax,%eax
    2a94:	74 34                	je     2aca <put_gbk+0x144>
					draw_point(c, x + tmpX, tmpY, colorNum);
    2a96:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
    2a9a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2a9d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2aa0:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
    2aa3:	01 d8                	add    %ebx,%eax
    2aa5:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2aa9:	89 54 24 10          	mov    %edx,0x10(%esp)
    2aad:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2ab1:	8b 45 08             	mov    0x8(%ebp),%eax
    2ab4:	89 04 24             	mov    %eax,(%esp)
    2ab7:	8b 45 0c             	mov    0xc(%ebp),%eax
    2aba:	89 44 24 04          	mov    %eax,0x4(%esp)
    2abe:	8b 45 10             	mov    0x10(%ebp),%eax
    2ac1:	89 44 24 08          	mov    %eax,0x8(%esp)
    2ac5:	e8 86 fa ff ff       	call   2550 <draw_point>
					draw_point(c, x + tmpX, tmpY, colorNum);
					//sheet->buf[tmpY * sheet->width + x + tmpX] = colorNum;
				}
			}
			offset++;
			for(tmpX = 0; tmpX < 8; tmpX++) {
    2aca:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    2ace:	83 7d f8 07          	cmpl   $0x7,-0x8(%ebp)
    2ad2:	7e a2                	jle    2a76 <put_gbk+0xf0>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
					draw_point(c, x + tmpX, tmpY, colorNum);
					//sheet->buf[tmpY * sheet->width + x + tmpX + 8] = colorNum;
				}
			}
			offset++;
    2ad4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
	unsigned char *hzk16Base;
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
		hzk16Base = fontFile.buf;
		offset = (((gbk & 0x00FF) - 0xa1) * 94 + (((gbk >> 8) & 0x00FF) - 0xa1)) * 32;

		for(tmpY = y; tmpY < 16 + y; tmpY++) {
    2ad8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2adc:	8b 45 20             	mov    0x20(%ebp),%eax
    2adf:	83 c0 10             	add    $0x10,%eax
    2ae2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2ae5:	0f 8f 17 ff ff ff    	jg     2a02 <put_gbk+0x7c>
void put_gbk(struct Context c, short gbk, unsigned short colorNum, int x, int y)
{
	int tmpX, tmpY;
	unsigned int offset;
	unsigned char *hzk16Base;
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
    2aeb:	eb 7b                	jmp    2b68 <put_gbk+0x1e2>
			}
			offset++;
		}
	}
	else {
		put_ascii(c, (gbk & 0x00FF), colorNum, x, y);
    2aed:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
    2af1:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
    2af5:	0f b6 c0             	movzbl %al,%eax
    2af8:	8b 4d 20             	mov    0x20(%ebp),%ecx
    2afb:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2aff:	8b 4d 1c             	mov    0x1c(%ebp),%ecx
    2b02:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2b06:	89 54 24 10          	mov    %edx,0x10(%esp)
    2b0a:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2b0e:	8b 45 08             	mov    0x8(%ebp),%eax
    2b11:	89 04 24             	mov    %eax,(%esp)
    2b14:	8b 45 0c             	mov    0xc(%ebp),%eax
    2b17:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b1b:	8b 45 10             	mov    0x10(%ebp),%eax
    2b1e:	89 44 24 08          	mov    %eax,0x8(%esp)
    2b22:	e8 af fd ff ff       	call   28d6 <put_ascii>
		put_ascii(c, ((gbk >> 8) & 0x00FF), colorNum, x + 8, y);
    2b27:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2b2a:	8d 58 08             	lea    0x8(%eax),%ebx
    2b2d:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
    2b31:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
    2b35:	66 c1 f8 08          	sar    $0x8,%ax
    2b39:	0f b6 c0             	movzbl %al,%eax
    2b3c:	8b 4d 20             	mov    0x20(%ebp),%ecx
    2b3f:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2b43:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    2b47:	89 54 24 10          	mov    %edx,0x10(%esp)
    2b4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2b4f:	8b 45 08             	mov    0x8(%ebp),%eax
    2b52:	89 04 24             	mov    %eax,(%esp)
    2b55:	8b 45 0c             	mov    0xc(%ebp),%eax
    2b58:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b5c:	8b 45 10             	mov    0x10(%ebp),%eax
    2b5f:	89 44 24 08          	mov    %eax,0x8(%esp)
    2b63:	e8 6e fd ff ff       	call   28d6 <put_ascii>
	}
}
    2b68:	83 c4 34             	add    $0x34,%esp
    2b6b:	5b                   	pop    %ebx
    2b6c:	5d                   	pop    %ebp
    2b6d:	c3                   	ret    

00002b6e <puts_str>:

void puts_str(struct Context c, char *str, unsigned short colorNum, int x, int y)
{
    2b6e:	55                   	push   %ebp
    2b6f:	89 e5                	mov    %esp,%ebp
    2b71:	83 ec 38             	sub    $0x38,%esp
    2b74:	8b 45 18             	mov    0x18(%ebp),%eax
    2b77:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
	//printf(0,"puts string : %s\n", str);
	int i = 0, xTmp;
    2b7b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	short wStr;
	uint rowLetterCnt;

	rowLetterCnt = strlen(str);
    2b82:	8b 45 14             	mov    0x14(%ebp),%eax
    2b85:	89 04 24             	mov    %eax,(%esp)
    2b88:	e8 bd 18 00 00       	call   444a <strlen>
    2b8d:	89 45 ec             	mov    %eax,-0x14(%ebp)
	for(i = 0, xTmp = x; i < rowLetterCnt;) {
    2b90:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2b97:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2b9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2b9d:	eb 49                	jmp    2be8 <puts_str+0x7a>
		if(str[i] < 0xA1) {
			put_ascii(c, str[i], colorNum, xTmp, y);
    2b9f:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
    2ba3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2ba6:	8b 45 14             	mov    0x14(%ebp),%eax
    2ba9:	01 c8                	add    %ecx,%eax
    2bab:	0f b6 00             	movzbl (%eax),%eax
    2bae:	0f b6 c0             	movzbl %al,%eax
    2bb1:	8b 4d 20             	mov    0x20(%ebp),%ecx
    2bb4:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2bb8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    2bbb:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2bbf:	89 54 24 10          	mov    %edx,0x10(%esp)
    2bc3:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2bc7:	8b 45 08             	mov    0x8(%ebp),%eax
    2bca:	89 04 24             	mov    %eax,(%esp)
    2bcd:	8b 45 0c             	mov    0xc(%ebp),%eax
    2bd0:	89 44 24 04          	mov    %eax,0x4(%esp)
    2bd4:	8b 45 10             	mov    0x10(%ebp),%eax
    2bd7:	89 44 24 08          	mov    %eax,0x8(%esp)
    2bdb:	e8 f6 fc ff ff       	call   28d6 <put_ascii>
			xTmp += 8;
    2be0:	83 45 f0 08          	addl   $0x8,-0x10(%ebp)
			i++;
    2be4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	int i = 0, xTmp;
	short wStr;
	uint rowLetterCnt;

	rowLetterCnt = strlen(str);
	for(i = 0, xTmp = x; i < rowLetterCnt;) {
    2be8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2beb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2bee:	72 af                	jb     2b9f <puts_str+0x31>
			put_gbk(c, wStr, colorNum, xTmp, y);
			xTmp += 16;
			i += 2;
		}
	}
}
    2bf0:	c9                   	leave  
    2bf1:	c3                   	ret    

00002bf2 <put_str>:

void put_str(struct Context c, char ch, unsigned short colorNum, int x, int y)
{
    2bf2:	55                   	push   %ebp
    2bf3:	89 e5                	mov    %esp,%ebp
    2bf5:	83 ec 24             	sub    $0x24,%esp
    2bf8:	8b 55 14             	mov    0x14(%ebp),%edx
    2bfb:	8b 45 18             	mov    0x18(%ebp),%eax
    2bfe:	88 55 fc             	mov    %dl,-0x4(%ebp)
    2c01:	66 89 45 f8          	mov    %ax,-0x8(%ebp)
	//printf(0,"puts string : %s\n", str);
	if(ch < 0xA1) {
		put_ascii(c, ch, colorNum, x, y);
    2c05:	0f b7 55 f8          	movzwl -0x8(%ebp),%edx
    2c09:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
    2c0d:	0f b6 c0             	movzbl %al,%eax
    2c10:	8b 4d 20             	mov    0x20(%ebp),%ecx
    2c13:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2c17:	8b 4d 1c             	mov    0x1c(%ebp),%ecx
    2c1a:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2c1e:	89 54 24 10          	mov    %edx,0x10(%esp)
    2c22:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2c26:	8b 45 08             	mov    0x8(%ebp),%eax
    2c29:	89 04 24             	mov    %eax,(%esp)
    2c2c:	8b 45 0c             	mov    0xc(%ebp),%eax
    2c2f:	89 44 24 04          	mov    %eax,0x4(%esp)
    2c33:	8b 45 10             	mov    0x10(%ebp),%eax
    2c36:	89 44 24 08          	mov    %eax,0x8(%esp)
    2c3a:	e8 97 fc ff ff       	call   28d6 <put_ascii>
	}
	else {
		put_gbk(c, ch, colorNum, x, y);		
	}	
}
    2c3f:	c9                   	leave  
    2c40:	c3                   	ret    

00002c41 <_RGB16BIT565>:

int _RGB16BIT565(int r,int g,int b){
    2c41:	55                   	push   %ebp
    2c42:	89 e5                	mov    %esp,%ebp
	return ((b / 8)+((g / 4)<<5)+((r / 8)<<11));
    2c44:	8b 45 10             	mov    0x10(%ebp),%eax
    2c47:	8d 50 07             	lea    0x7(%eax),%edx
    2c4a:	85 c0                	test   %eax,%eax
    2c4c:	0f 48 c2             	cmovs  %edx,%eax
    2c4f:	c1 f8 03             	sar    $0x3,%eax
    2c52:	89 c2                	mov    %eax,%edx
    2c54:	8b 45 0c             	mov    0xc(%ebp),%eax
    2c57:	8d 48 03             	lea    0x3(%eax),%ecx
    2c5a:	85 c0                	test   %eax,%eax
    2c5c:	0f 48 c1             	cmovs  %ecx,%eax
    2c5f:	c1 f8 02             	sar    $0x2,%eax
    2c62:	c1 e0 05             	shl    $0x5,%eax
    2c65:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    2c68:	8b 45 08             	mov    0x8(%ebp),%eax
    2c6b:	8d 50 07             	lea    0x7(%eax),%edx
    2c6e:	85 c0                	test   %eax,%eax
    2c70:	0f 48 c2             	cmovs  %edx,%eax
    2c73:	c1 f8 03             	sar    $0x3,%eax
    2c76:	c1 e0 0b             	shl    $0xb,%eax
    2c79:	01 c8                	add    %ecx,%eax
}
    2c7b:	5d                   	pop    %ebp
    2c7c:	c3                   	ret    

00002c7d <draw_picture>:

void draw_picture(Context c, PICNODE pic, int x, int y)
{
    2c7d:	55                   	push   %ebp
    2c7e:	89 e5                	mov    %esp,%ebp
    2c80:	53                   	push   %ebx
    2c81:	83 ec 28             	sub    $0x28,%esp
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
    2c84:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    2c8b:	e9 b1 00 00 00       	jmp    2d41 <draw_picture+0xc4>
	{
		for (j = 0; j < pic.width; j++)
    2c90:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2c97:	e9 95 00 00 00       	jmp    2d31 <draw_picture+0xb4>
		{
			rgb = pic.data[i*pic.width+j];
    2c9c:	8b 55 14             	mov    0x14(%ebp),%edx
    2c9f:	8b 45 18             	mov    0x18(%ebp),%eax
    2ca2:	0f af 45 f8          	imul   -0x8(%ebp),%eax
    2ca6:	89 c1                	mov    %eax,%ecx
    2ca8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2cab:	01 c8                	add    %ecx,%eax
    2cad:	c1 e0 02             	shl    $0x2,%eax
    2cb0:	01 d0                	add    %edx,%eax
    2cb2:	8b 00                	mov    (%eax),%eax
    2cb4:	89 45 ee             	mov    %eax,-0x12(%ebp)
			if (rgb.rgbReserved == 1) continue;
    2cb7:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
    2cbb:	3c 01                	cmp    $0x1,%al
    2cbd:	75 02                	jne    2cc1 <draw_picture+0x44>
    2cbf:	eb 6c                	jmp    2d2d <draw_picture+0xb0>
			color = (unsigned short)_RGB16BIT565(rgb.rgbRed, rgb.rgbGreen, rgb.rgbBlue);
    2cc1:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
    2cc5:	0f b6 c8             	movzbl %al,%ecx
    2cc8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    2ccc:	0f b6 d0             	movzbl %al,%edx
    2ccf:	0f b6 45 f0          	movzbl -0x10(%ebp),%eax
    2cd3:	0f b6 c0             	movzbl %al,%eax
    2cd6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    2cda:	89 54 24 04          	mov    %edx,0x4(%esp)
    2cde:	89 04 24             	mov    %eax,(%esp)
    2ce1:	e8 5b ff ff ff       	call   2c41 <_RGB16BIT565>
    2ce6:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
			draw_point(c, j + x, pic.height - 1 - i + y, color);
    2cea:	0f b7 4d f2          	movzwl -0xe(%ebp),%ecx
    2cee:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2cf1:	83 e8 01             	sub    $0x1,%eax
    2cf4:	2b 45 f8             	sub    -0x8(%ebp),%eax
    2cf7:	89 c2                	mov    %eax,%edx
    2cf9:	8b 45 24             	mov    0x24(%ebp),%eax
    2cfc:	01 d0                	add    %edx,%eax
    2cfe:	89 c2                	mov    %eax,%edx
    2d00:	8b 45 20             	mov    0x20(%ebp),%eax
    2d03:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    2d06:	01 d8                	add    %ebx,%eax
    2d08:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2d0c:	89 54 24 10          	mov    %edx,0x10(%esp)
    2d10:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2d14:	8b 45 08             	mov    0x8(%ebp),%eax
    2d17:	89 04 24             	mov    %eax,(%esp)
    2d1a:	8b 45 0c             	mov    0xc(%ebp),%eax
    2d1d:	89 44 24 04          	mov    %eax,0x4(%esp)
    2d21:	8b 45 10             	mov    0x10(%ebp),%eax
    2d24:	89 44 24 08          	mov    %eax,0x8(%esp)
    2d28:	e8 23 f8 ff ff       	call   2550 <draw_point>
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
	{
		for (j = 0; j < pic.width; j++)
    2d2d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2d31:	8b 45 18             	mov    0x18(%ebp),%eax
    2d34:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2d37:	0f 8f 5f ff ff ff    	jg     2c9c <draw_picture+0x1f>
void draw_picture(Context c, PICNODE pic, int x, int y)
{
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
    2d3d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    2d41:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2d44:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2d47:	0f 8f 43 ff ff ff    	jg     2c90 <draw_picture+0x13>
			if (rgb.rgbReserved == 1) continue;
			color = (unsigned short)_RGB16BIT565(rgb.rgbRed, rgb.rgbGreen, rgb.rgbBlue);
			draw_point(c, j + x, pic.height - 1 - i + y, color);
		}
	}
}
    2d4d:	83 c4 28             	add    $0x28,%esp
    2d50:	5b                   	pop    %ebx
    2d51:	5d                   	pop    %ebp
    2d52:	c3                   	ret    

00002d53 <draw_line>:

void draw_line(Context c, int x0, int y0, int x1, int y1, unsigned short color)
{
    2d53:	55                   	push   %ebp
    2d54:	89 e5                	mov    %esp,%ebp
    2d56:	83 ec 3c             	sub    $0x3c,%esp
    2d59:	8b 45 24             	mov    0x24(%ebp),%eax
    2d5c:	66 89 45 dc          	mov    %ax,-0x24(%ebp)
	int dx, dy, x, y, len, i;
	dx = x1 - x0;
    2d60:	8b 45 14             	mov    0x14(%ebp),%eax
    2d63:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2d66:	29 c2                	sub    %eax,%edx
    2d68:	89 d0                	mov    %edx,%eax
    2d6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	dy = y1 - y0;
    2d6d:	8b 45 18             	mov    0x18(%ebp),%eax
    2d70:	8b 55 20             	mov    0x20(%ebp),%edx
    2d73:	29 c2                	sub    %eax,%edx
    2d75:	89 d0                	mov    %edx,%eax
    2d77:	89 45 f8             	mov    %eax,-0x8(%ebp)
	x = x0 << 10;
    2d7a:	8b 45 14             	mov    0x14(%ebp),%eax
    2d7d:	c1 e0 0a             	shl    $0xa,%eax
    2d80:	89 45 f4             	mov    %eax,-0xc(%ebp)
	y = y0 << 10;
    2d83:	8b 45 18             	mov    0x18(%ebp),%eax
    2d86:	c1 e0 0a             	shl    $0xa,%eax
    2d89:	89 45 f0             	mov    %eax,-0x10(%ebp)
	dx = (dx < 0) ? -dx : dx;
    2d8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2d8f:	c1 f8 1f             	sar    $0x1f,%eax
    2d92:	31 45 fc             	xor    %eax,-0x4(%ebp)
    2d95:	29 45 fc             	sub    %eax,-0x4(%ebp)
	dy = (dy < 0) ? -dy : dy;
    2d98:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2d9b:	c1 f8 1f             	sar    $0x1f,%eax
    2d9e:	31 45 f8             	xor    %eax,-0x8(%ebp)
    2da1:	29 45 f8             	sub    %eax,-0x8(%ebp)
	if(dx >= dy) {
    2da4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2da7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2daa:	7c 57                	jl     2e03 <draw_line+0xb0>
		len = dx + 1;
    2dac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2daf:	83 c0 01             	add    $0x1,%eax
    2db2:	89 45 ec             	mov    %eax,-0x14(%ebp)
		dx = (x1 > x0) ? 1024 : -1024;
    2db5:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2db8:	3b 45 14             	cmp    0x14(%ebp),%eax
    2dbb:	7e 07                	jle    2dc4 <draw_line+0x71>
    2dbd:	b8 00 04 00 00       	mov    $0x400,%eax
    2dc2:	eb 05                	jmp    2dc9 <draw_line+0x76>
    2dc4:	b8 00 fc ff ff       	mov    $0xfffffc00,%eax
    2dc9:	89 45 fc             	mov    %eax,-0x4(%ebp)
		dy = (y1 >= y0) ? (((y1 - y0 + 1) << 10) / len) : (((y1 - y0 - 1) << 10) / len);
    2dcc:	8b 45 20             	mov    0x20(%ebp),%eax
    2dcf:	3b 45 18             	cmp    0x18(%ebp),%eax
    2dd2:	7c 16                	jl     2dea <draw_line+0x97>
    2dd4:	8b 45 18             	mov    0x18(%ebp),%eax
    2dd7:	8b 55 20             	mov    0x20(%ebp),%edx
    2dda:	29 c2                	sub    %eax,%edx
    2ddc:	89 d0                	mov    %edx,%eax
    2dde:	83 c0 01             	add    $0x1,%eax
    2de1:	c1 e0 0a             	shl    $0xa,%eax
    2de4:	99                   	cltd   
    2de5:	f7 7d ec             	idivl  -0x14(%ebp)
    2de8:	eb 14                	jmp    2dfe <draw_line+0xab>
    2dea:	8b 45 18             	mov    0x18(%ebp),%eax
    2ded:	8b 55 20             	mov    0x20(%ebp),%edx
    2df0:	29 c2                	sub    %eax,%edx
    2df2:	89 d0                	mov    %edx,%eax
    2df4:	83 e8 01             	sub    $0x1,%eax
    2df7:	c1 e0 0a             	shl    $0xa,%eax
    2dfa:	99                   	cltd   
    2dfb:	f7 7d ec             	idivl  -0x14(%ebp)
    2dfe:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2e01:	eb 55                	jmp    2e58 <draw_line+0x105>
	}
	else {
		len = dy + 1;
    2e03:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2e06:	83 c0 01             	add    $0x1,%eax
    2e09:	89 45 ec             	mov    %eax,-0x14(%ebp)
		dy = (y1 > y0) ? 1024 : -1024;
    2e0c:	8b 45 20             	mov    0x20(%ebp),%eax
    2e0f:	3b 45 18             	cmp    0x18(%ebp),%eax
    2e12:	7e 07                	jle    2e1b <draw_line+0xc8>
    2e14:	b8 00 04 00 00       	mov    $0x400,%eax
    2e19:	eb 05                	jmp    2e20 <draw_line+0xcd>
    2e1b:	b8 00 fc ff ff       	mov    $0xfffffc00,%eax
    2e20:	89 45 f8             	mov    %eax,-0x8(%ebp)
		dx = (x1 >= x0) ? (((x1 - x0 + 1) << 10) / len) : (((x1 - x0 - 1) << 10) / len);
    2e23:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2e26:	3b 45 14             	cmp    0x14(%ebp),%eax
    2e29:	7c 16                	jl     2e41 <draw_line+0xee>
    2e2b:	8b 45 14             	mov    0x14(%ebp),%eax
    2e2e:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2e31:	29 c2                	sub    %eax,%edx
    2e33:	89 d0                	mov    %edx,%eax
    2e35:	83 c0 01             	add    $0x1,%eax
    2e38:	c1 e0 0a             	shl    $0xa,%eax
    2e3b:	99                   	cltd   
    2e3c:	f7 7d ec             	idivl  -0x14(%ebp)
    2e3f:	eb 14                	jmp    2e55 <draw_line+0x102>
    2e41:	8b 45 14             	mov    0x14(%ebp),%eax
    2e44:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2e47:	29 c2                	sub    %eax,%edx
    2e49:	89 d0                	mov    %edx,%eax
    2e4b:	83 e8 01             	sub    $0x1,%eax
    2e4e:	c1 e0 0a             	shl    $0xa,%eax
    2e51:	99                   	cltd   
    2e52:	f7 7d ec             	idivl  -0x14(%ebp)
    2e55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	}
	for(i = 0; i < len; i++) {
    2e58:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    2e5f:	eb 47                	jmp    2ea8 <draw_line+0x155>
		//printf(0, "draw line point: x=%d, y=%d\n", (x >> 10), (y >> 10));
		draw_point(c, (x >> 10), (y >> 10), color);
    2e61:	0f b7 4d dc          	movzwl -0x24(%ebp),%ecx
    2e65:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2e68:	c1 f8 0a             	sar    $0xa,%eax
    2e6b:	89 c2                	mov    %eax,%edx
    2e6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2e70:	c1 f8 0a             	sar    $0xa,%eax
    2e73:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2e77:	89 54 24 10          	mov    %edx,0x10(%esp)
    2e7b:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2e7f:	8b 45 08             	mov    0x8(%ebp),%eax
    2e82:	89 04 24             	mov    %eax,(%esp)
    2e85:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e88:	89 44 24 04          	mov    %eax,0x4(%esp)
    2e8c:	8b 45 10             	mov    0x10(%ebp),%eax
    2e8f:	89 44 24 08          	mov    %eax,0x8(%esp)
    2e93:	e8 b8 f6 ff ff       	call   2550 <draw_point>
		y += dy;
    2e98:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2e9b:	01 45 f0             	add    %eax,-0x10(%ebp)
		x += dx;
    2e9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2ea1:	01 45 f4             	add    %eax,-0xc(%ebp)
	else {
		len = dy + 1;
		dy = (y1 > y0) ? 1024 : -1024;
		dx = (x1 >= x0) ? (((x1 - x0 + 1) << 10) / len) : (((x1 - x0 - 1) << 10) / len);
	}
	for(i = 0; i < len; i++) {
    2ea4:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    2ea8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2eab:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2eae:	7c b1                	jl     2e61 <draw_line+0x10e>
		//printf(0, "draw line point: x=%d, y=%d\n", (x >> 10), (y >> 10));
		draw_point(c, (x >> 10), (y >> 10), color);
		y += dy;
		x += dx;
	}
}
    2eb0:	c9                   	leave  
    2eb1:	c3                   	ret    

00002eb2 <draw_window>:

void
draw_window(Context c, char *title)
{
    2eb2:	55                   	push   %ebp
    2eb3:	89 e5                	mov    %esp,%ebp
    2eb5:	83 ec 38             	sub    $0x38,%esp
  PICNODE pic;
  draw_line(c, 0, 0, c.width - 1, 0, BORDERLINE_COLOR);
    2eb8:	8b 45 0c             	mov    0xc(%ebp),%eax
    2ebb:	83 e8 01             	sub    $0x1,%eax
    2ebe:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2ec5:	00 
    2ec6:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    2ecd:	00 
    2ece:	89 44 24 14          	mov    %eax,0x14(%esp)
    2ed2:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    2ed9:	00 
    2eda:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    2ee1:	00 
    2ee2:	8b 45 08             	mov    0x8(%ebp),%eax
    2ee5:	89 04 24             	mov    %eax,(%esp)
    2ee8:	8b 45 0c             	mov    0xc(%ebp),%eax
    2eeb:	89 44 24 04          	mov    %eax,0x4(%esp)
    2eef:	8b 45 10             	mov    0x10(%ebp),%eax
    2ef2:	89 44 24 08          	mov    %eax,0x8(%esp)
    2ef6:	e8 58 fe ff ff       	call   2d53 <draw_line>
  draw_line(c, c.width - 1, 0, c.width - 1, c.height - 1, BORDERLINE_COLOR);
    2efb:	8b 45 10             	mov    0x10(%ebp),%eax
    2efe:	8d 48 ff             	lea    -0x1(%eax),%ecx
    2f01:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f04:	8d 50 ff             	lea    -0x1(%eax),%edx
    2f07:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f0a:	83 e8 01             	sub    $0x1,%eax
    2f0d:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2f14:	00 
    2f15:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2f19:	89 54 24 14          	mov    %edx,0x14(%esp)
    2f1d:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    2f24:	00 
    2f25:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2f29:	8b 45 08             	mov    0x8(%ebp),%eax
    2f2c:	89 04 24             	mov    %eax,(%esp)
    2f2f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f32:	89 44 24 04          	mov    %eax,0x4(%esp)
    2f36:	8b 45 10             	mov    0x10(%ebp),%eax
    2f39:	89 44 24 08          	mov    %eax,0x8(%esp)
    2f3d:	e8 11 fe ff ff       	call   2d53 <draw_line>
  draw_line(c, c.width - 1, c.height - 1, 0, c.height - 1, BORDERLINE_COLOR);
    2f42:	8b 45 10             	mov    0x10(%ebp),%eax
    2f45:	8d 48 ff             	lea    -0x1(%eax),%ecx
    2f48:	8b 45 10             	mov    0x10(%ebp),%eax
    2f4b:	8d 50 ff             	lea    -0x1(%eax),%edx
    2f4e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f51:	83 e8 01             	sub    $0x1,%eax
    2f54:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2f5b:	00 
    2f5c:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2f60:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    2f67:	00 
    2f68:	89 54 24 10          	mov    %edx,0x10(%esp)
    2f6c:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2f70:	8b 45 08             	mov    0x8(%ebp),%eax
    2f73:	89 04 24             	mov    %eax,(%esp)
    2f76:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f79:	89 44 24 04          	mov    %eax,0x4(%esp)
    2f7d:	8b 45 10             	mov    0x10(%ebp),%eax
    2f80:	89 44 24 08          	mov    %eax,0x8(%esp)
    2f84:	e8 ca fd ff ff       	call   2d53 <draw_line>
  draw_line(c, 0, c.height - 1, 0, 0, BORDERLINE_COLOR);
    2f89:	8b 45 10             	mov    0x10(%ebp),%eax
    2f8c:	83 e8 01             	sub    $0x1,%eax
    2f8f:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2f96:	00 
    2f97:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    2f9e:	00 
    2f9f:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    2fa6:	00 
    2fa7:	89 44 24 10          	mov    %eax,0x10(%esp)
    2fab:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    2fb2:	00 
    2fb3:	8b 45 08             	mov    0x8(%ebp),%eax
    2fb6:	89 04 24             	mov    %eax,(%esp)
    2fb9:	8b 45 0c             	mov    0xc(%ebp),%eax
    2fbc:	89 44 24 04          	mov    %eax,0x4(%esp)
    2fc0:	8b 45 10             	mov    0x10(%ebp),%eax
    2fc3:	89 44 24 08          	mov    %eax,0x8(%esp)
    2fc7:	e8 87 fd ff ff       	call   2d53 <draw_line>
  fill_rect(c, 1, 1, c.width - 2, BOTTOMBAR_HEIGHT, TOPBAR_COLOR);
    2fcc:	8b 45 0c             	mov    0xc(%ebp),%eax
    2fcf:	83 e8 02             	sub    $0x2,%eax
    2fd2:	c7 44 24 1c cb 5a 00 	movl   $0x5acb,0x1c(%esp)
    2fd9:	00 
    2fda:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    2fe1:	00 
    2fe2:	89 44 24 14          	mov    %eax,0x14(%esp)
    2fe6:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
    2fed:	00 
    2fee:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    2ff5:	00 
    2ff6:	8b 45 08             	mov    0x8(%ebp),%eax
    2ff9:	89 04 24             	mov    %eax,(%esp)
    2ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
    2fff:	89 44 24 04          	mov    %eax,0x4(%esp)
    3003:	8b 45 10             	mov    0x10(%ebp),%eax
    3006:	89 44 24 08          	mov    %eax,0x8(%esp)
    300a:	e8 80 f5 ff ff       	call   258f <fill_rect>
  fill_rect(c, 1, c.height - 1 - BOTTOMBAR_HEIGHT, c.width - 2, BOTTOMBAR_HEIGHT, BOTTOMBAR_COLOR);
    300f:	8b 45 0c             	mov    0xc(%ebp),%eax
    3012:	83 e8 02             	sub    $0x2,%eax
    3015:	89 c2                	mov    %eax,%edx
    3017:	8b 45 10             	mov    0x10(%ebp),%eax
    301a:	83 e8 15             	sub    $0x15,%eax
    301d:	c7 44 24 1c cb 5a 00 	movl   $0x5acb,0x1c(%esp)
    3024:	00 
    3025:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    302c:	00 
    302d:	89 54 24 14          	mov    %edx,0x14(%esp)
    3031:	89 44 24 10          	mov    %eax,0x10(%esp)
    3035:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    303c:	00 
    303d:	8b 45 08             	mov    0x8(%ebp),%eax
    3040:	89 04 24             	mov    %eax,(%esp)
    3043:	8b 45 0c             	mov    0xc(%ebp),%eax
    3046:	89 44 24 04          	mov    %eax,0x4(%esp)
    304a:	8b 45 10             	mov    0x10(%ebp),%eax
    304d:	89 44 24 08          	mov    %eax,0x8(%esp)
    3051:	e8 39 f5 ff ff       	call   258f <fill_rect>

  loadBitmap(&pic, "close.bmp");
    3056:	c7 44 24 04 4f b0 00 	movl   $0xb04f,0x4(%esp)
    305d:	00 
    305e:	8d 45 ec             	lea    -0x14(%ebp),%eax
    3061:	89 04 24             	mov    %eax,(%esp)
    3064:	e8 e3 03 00 00       	call   344c <loadBitmap>
  draw_picture(c, pic, 3, 3);
    3069:	c7 44 24 1c 03 00 00 	movl   $0x3,0x1c(%esp)
    3070:	00 
    3071:	c7 44 24 18 03 00 00 	movl   $0x3,0x18(%esp)
    3078:	00 
    3079:	8b 45 ec             	mov    -0x14(%ebp),%eax
    307c:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3080:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3083:	89 44 24 10          	mov    %eax,0x10(%esp)
    3087:	8b 45 f4             	mov    -0xc(%ebp),%eax
    308a:	89 44 24 14          	mov    %eax,0x14(%esp)
    308e:	8b 45 08             	mov    0x8(%ebp),%eax
    3091:	89 04 24             	mov    %eax,(%esp)
    3094:	8b 45 0c             	mov    0xc(%ebp),%eax
    3097:	89 44 24 04          	mov    %eax,0x4(%esp)
    309b:	8b 45 10             	mov    0x10(%ebp),%eax
    309e:	89 44 24 08          	mov    %eax,0x8(%esp)
    30a2:	e8 d6 fb ff ff       	call   2c7d <draw_picture>
  puts_str(c, title, TITLE_COLOR, TITLE_OFFSET_X, TITLE_OFFSET_Y);
    30a7:	c7 44 24 18 02 00 00 	movl   $0x2,0x18(%esp)
    30ae:	00 
    30af:	c7 44 24 14 19 00 00 	movl   $0x19,0x14(%esp)
    30b6:	00 
    30b7:	c7 44 24 10 ff ff 00 	movl   $0xffff,0x10(%esp)
    30be:	00 
    30bf:	8b 45 14             	mov    0x14(%ebp),%eax
    30c2:	89 44 24 0c          	mov    %eax,0xc(%esp)
    30c6:	8b 45 08             	mov    0x8(%ebp),%eax
    30c9:	89 04 24             	mov    %eax,(%esp)
    30cc:	8b 45 0c             	mov    0xc(%ebp),%eax
    30cf:	89 44 24 04          	mov    %eax,0x4(%esp)
    30d3:	8b 45 10             	mov    0x10(%ebp),%eax
    30d6:	89 44 24 08          	mov    %eax,0x8(%esp)
    30da:	e8 8f fa ff ff       	call   2b6e <puts_str>
  freepic(&pic);
    30df:	8d 45 ec             	lea    -0x14(%ebp),%eax
    30e2:	89 04 24             	mov    %eax,(%esp)
    30e5:	e8 0e 09 00 00       	call   39f8 <freepic>
}
    30ea:	c9                   	leave  
    30eb:	c3                   	ret    

000030ec <draw_window2>:

void
draw_window2(Context c, char *title, int len, unsigned short color)
{
    30ec:	55                   	push   %ebp
    30ed:	89 e5                	mov    %esp,%ebp
    30ef:	53                   	push   %ebx
    30f0:	83 ec 44             	sub    $0x44,%esp
    30f3:	8b 45 1c             	mov    0x1c(%ebp),%eax
    30f6:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  PICNODE pic;
  draw_line(c, 0, 0, c.width - 1, 0, BORDERLINE_COLOR);
    30fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    30fd:	83 e8 01             	sub    $0x1,%eax
    3100:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    3107:	00 
    3108:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    310f:	00 
    3110:	89 44 24 14          	mov    %eax,0x14(%esp)
    3114:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    311b:	00 
    311c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    3123:	00 
    3124:	8b 45 08             	mov    0x8(%ebp),%eax
    3127:	89 04 24             	mov    %eax,(%esp)
    312a:	8b 45 0c             	mov    0xc(%ebp),%eax
    312d:	89 44 24 04          	mov    %eax,0x4(%esp)
    3131:	8b 45 10             	mov    0x10(%ebp),%eax
    3134:	89 44 24 08          	mov    %eax,0x8(%esp)
    3138:	e8 16 fc ff ff       	call   2d53 <draw_line>
  draw_line(c, c.width - 1, 0, c.width - 1, c.height - 1, BORDERLINE_COLOR);
    313d:	8b 45 10             	mov    0x10(%ebp),%eax
    3140:	8d 48 ff             	lea    -0x1(%eax),%ecx
    3143:	8b 45 0c             	mov    0xc(%ebp),%eax
    3146:	8d 50 ff             	lea    -0x1(%eax),%edx
    3149:	8b 45 0c             	mov    0xc(%ebp),%eax
    314c:	83 e8 01             	sub    $0x1,%eax
    314f:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    3156:	00 
    3157:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    315b:	89 54 24 14          	mov    %edx,0x14(%esp)
    315f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    3166:	00 
    3167:	89 44 24 0c          	mov    %eax,0xc(%esp)
    316b:	8b 45 08             	mov    0x8(%ebp),%eax
    316e:	89 04 24             	mov    %eax,(%esp)
    3171:	8b 45 0c             	mov    0xc(%ebp),%eax
    3174:	89 44 24 04          	mov    %eax,0x4(%esp)
    3178:	8b 45 10             	mov    0x10(%ebp),%eax
    317b:	89 44 24 08          	mov    %eax,0x8(%esp)
    317f:	e8 cf fb ff ff       	call   2d53 <draw_line>
  draw_line(c, c.width - 1, c.height - 1, 0, c.height - 1, BORDERLINE_COLOR);
    3184:	8b 45 10             	mov    0x10(%ebp),%eax
    3187:	8d 48 ff             	lea    -0x1(%eax),%ecx
    318a:	8b 45 10             	mov    0x10(%ebp),%eax
    318d:	8d 50 ff             	lea    -0x1(%eax),%edx
    3190:	8b 45 0c             	mov    0xc(%ebp),%eax
    3193:	83 e8 01             	sub    $0x1,%eax
    3196:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    319d:	00 
    319e:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    31a2:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    31a9:	00 
    31aa:	89 54 24 10          	mov    %edx,0x10(%esp)
    31ae:	89 44 24 0c          	mov    %eax,0xc(%esp)
    31b2:	8b 45 08             	mov    0x8(%ebp),%eax
    31b5:	89 04 24             	mov    %eax,(%esp)
    31b8:	8b 45 0c             	mov    0xc(%ebp),%eax
    31bb:	89 44 24 04          	mov    %eax,0x4(%esp)
    31bf:	8b 45 10             	mov    0x10(%ebp),%eax
    31c2:	89 44 24 08          	mov    %eax,0x8(%esp)
    31c6:	e8 88 fb ff ff       	call   2d53 <draw_line>
  draw_line(c, 0, c.height - 1, 0, 0, BORDERLINE_COLOR);
    31cb:	8b 45 10             	mov    0x10(%ebp),%eax
    31ce:	83 e8 01             	sub    $0x1,%eax
    31d1:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    31d8:	00 
    31d9:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    31e0:	00 
    31e1:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    31e8:	00 
    31e9:	89 44 24 10          	mov    %eax,0x10(%esp)
    31ed:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    31f4:	00 
    31f5:	8b 45 08             	mov    0x8(%ebp),%eax
    31f8:	89 04 24             	mov    %eax,(%esp)
    31fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    31fe:	89 44 24 04          	mov    %eax,0x4(%esp)
    3202:	8b 45 10             	mov    0x10(%ebp),%eax
    3205:	89 44 24 08          	mov    %eax,0x8(%esp)
    3209:	e8 45 fb ff ff       	call   2d53 <draw_line>
  fill_rect(c, 1, 1, len * 8, BOTTOMBAR_HEIGHT, color);
    320e:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
    3212:	8b 45 18             	mov    0x18(%ebp),%eax
    3215:	c1 e0 03             	shl    $0x3,%eax
    3218:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    321c:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    3223:	00 
    3224:	89 44 24 14          	mov    %eax,0x14(%esp)
    3228:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
    322f:	00 
    3230:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    3237:	00 
    3238:	8b 45 08             	mov    0x8(%ebp),%eax
    323b:	89 04 24             	mov    %eax,(%esp)
    323e:	8b 45 0c             	mov    0xc(%ebp),%eax
    3241:	89 44 24 04          	mov    %eax,0x4(%esp)
    3245:	8b 45 10             	mov    0x10(%ebp),%eax
    3248:	89 44 24 08          	mov    %eax,0x8(%esp)
    324c:	e8 3e f3 ff ff       	call   258f <fill_rect>
  fill_rect(c, 1 + len * 8, 1, c.width - 2 - len * 8, BOTTOMBAR_HEIGHT, color);
    3251:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
    3255:	8b 45 0c             	mov    0xc(%ebp),%eax
    3258:	8d 58 fe             	lea    -0x2(%eax),%ebx
    325b:	8b 55 18             	mov    0x18(%ebp),%edx
    325e:	b8 00 00 00 00       	mov    $0x0,%eax
    3263:	29 d0                	sub    %edx,%eax
    3265:	c1 e0 03             	shl    $0x3,%eax
    3268:	01 d8                	add    %ebx,%eax
    326a:	89 c2                	mov    %eax,%edx
    326c:	8b 45 18             	mov    0x18(%ebp),%eax
    326f:	c1 e0 03             	shl    $0x3,%eax
    3272:	83 c0 01             	add    $0x1,%eax
    3275:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    3279:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    3280:	00 
    3281:	89 54 24 14          	mov    %edx,0x14(%esp)
    3285:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
    328c:	00 
    328d:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3291:	8b 45 08             	mov    0x8(%ebp),%eax
    3294:	89 04 24             	mov    %eax,(%esp)
    3297:	8b 45 0c             	mov    0xc(%ebp),%eax
    329a:	89 44 24 04          	mov    %eax,0x4(%esp)
    329e:	8b 45 10             	mov    0x10(%ebp),%eax
    32a1:	89 44 24 08          	mov    %eax,0x8(%esp)
    32a5:	e8 e5 f2 ff ff       	call   258f <fill_rect>
  fill_rect(c, 1, c.height - 1 - BOTTOMBAR_HEIGHT, c.width - 2, BOTTOMBAR_HEIGHT, color);
    32aa:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
    32ae:	8b 45 0c             	mov    0xc(%ebp),%eax
    32b1:	83 e8 02             	sub    $0x2,%eax
    32b4:	89 c2                	mov    %eax,%edx
    32b6:	8b 45 10             	mov    0x10(%ebp),%eax
    32b9:	83 e8 15             	sub    $0x15,%eax
    32bc:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    32c0:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    32c7:	00 
    32c8:	89 54 24 14          	mov    %edx,0x14(%esp)
    32cc:	89 44 24 10          	mov    %eax,0x10(%esp)
    32d0:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    32d7:	00 
    32d8:	8b 45 08             	mov    0x8(%ebp),%eax
    32db:	89 04 24             	mov    %eax,(%esp)
    32de:	8b 45 0c             	mov    0xc(%ebp),%eax
    32e1:	89 44 24 04          	mov    %eax,0x4(%esp)
    32e5:	8b 45 10             	mov    0x10(%ebp),%eax
    32e8:	89 44 24 08          	mov    %eax,0x8(%esp)
    32ec:	e8 9e f2 ff ff       	call   258f <fill_rect>

  loadBitmap(&pic, "close.bmp");
    32f1:	c7 44 24 04 4f b0 00 	movl   $0xb04f,0x4(%esp)
    32f8:	00 
    32f9:	8d 45 ec             	lea    -0x14(%ebp),%eax
    32fc:	89 04 24             	mov    %eax,(%esp)
    32ff:	e8 48 01 00 00       	call   344c <loadBitmap>
  draw_picture(c, pic, 3, 3);
    3304:	c7 44 24 1c 03 00 00 	movl   $0x3,0x1c(%esp)
    330b:	00 
    330c:	c7 44 24 18 03 00 00 	movl   $0x3,0x18(%esp)
    3313:	00 
    3314:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3317:	89 44 24 0c          	mov    %eax,0xc(%esp)
    331b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    331e:	89 44 24 10          	mov    %eax,0x10(%esp)
    3322:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3325:	89 44 24 14          	mov    %eax,0x14(%esp)
    3329:	8b 45 08             	mov    0x8(%ebp),%eax
    332c:	89 04 24             	mov    %eax,(%esp)
    332f:	8b 45 0c             	mov    0xc(%ebp),%eax
    3332:	89 44 24 04          	mov    %eax,0x4(%esp)
    3336:	8b 45 10             	mov    0x10(%ebp),%eax
    3339:	89 44 24 08          	mov    %eax,0x8(%esp)
    333d:	e8 3b f9 ff ff       	call   2c7d <draw_picture>
  puts_str(c, title, TITLE_COLOR, TITLE_OFFSET_X, TITLE_OFFSET_Y);
    3342:	c7 44 24 18 02 00 00 	movl   $0x2,0x18(%esp)
    3349:	00 
    334a:	c7 44 24 14 19 00 00 	movl   $0x19,0x14(%esp)
    3351:	00 
    3352:	c7 44 24 10 ff ff 00 	movl   $0xffff,0x10(%esp)
    3359:	00 
    335a:	8b 45 14             	mov    0x14(%ebp),%eax
    335d:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3361:	8b 45 08             	mov    0x8(%ebp),%eax
    3364:	89 04 24             	mov    %eax,(%esp)
    3367:	8b 45 0c             	mov    0xc(%ebp),%eax
    336a:	89 44 24 04          	mov    %eax,0x4(%esp)
    336e:	8b 45 10             	mov    0x10(%ebp),%eax
    3371:	89 44 24 08          	mov    %eax,0x8(%esp)
    3375:	e8 f4 f7 ff ff       	call   2b6e <puts_str>
  freepic(&pic);
    337a:	8d 45 ec             	lea    -0x14(%ebp),%eax
    337d:	89 04 24             	mov    %eax,(%esp)
    3380:	e8 73 06 00 00       	call   39f8 <freepic>
}
    3385:	83 c4 44             	add    $0x44,%esp
    3388:	5b                   	pop    %ebx
    3389:	5d                   	pop    %ebp
    338a:	c3                   	ret    

0000338b <load_iconlist>:

void load_iconlist(ICON* iconlist, int len)
{
    338b:	55                   	push   %ebp
    338c:	89 e5                	mov    %esp,%ebp
    338e:	83 ec 28             	sub    $0x28,%esp
	int i;
	for (i = 0; i < len; i++)
    3391:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3398:	eb 29                	jmp    33c3 <load_iconlist+0x38>
	{
	    loadBitmap(&(iconlist[i].pic), iconlist[i].name);
    339a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    339d:	6b d0 34             	imul   $0x34,%eax,%edx
    33a0:	8b 45 08             	mov    0x8(%ebp),%eax
    33a3:	01 d0                	add    %edx,%eax
    33a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
    33a8:	6b ca 34             	imul   $0x34,%edx,%ecx
    33ab:	8b 55 08             	mov    0x8(%ebp),%edx
    33ae:	01 ca                	add    %ecx,%edx
    33b0:	83 c2 28             	add    $0x28,%edx
    33b3:	89 44 24 04          	mov    %eax,0x4(%esp)
    33b7:	89 14 24             	mov    %edx,(%esp)
    33ba:	e8 8d 00 00 00       	call   344c <loadBitmap>
}

void load_iconlist(ICON* iconlist, int len)
{
	int i;
	for (i = 0; i < len; i++)
    33bf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    33c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    33c6:	3b 45 0c             	cmp    0xc(%ebp),%eax
    33c9:	7c cf                	jl     339a <load_iconlist+0xf>
	{
	    loadBitmap(&(iconlist[i].pic), iconlist[i].name);
	}
}
    33cb:	c9                   	leave  
    33cc:	c3                   	ret    

000033cd <draw_iconlist>:
void draw_iconlist(Context c, ICON* iconlist, int len)
{
    33cd:	55                   	push   %ebp
    33ce:	89 e5                	mov    %esp,%ebp
    33d0:	53                   	push   %ebx
    33d1:	83 ec 30             	sub    $0x30,%esp
    int i;
    for (i = 0; i < len; i++)
    33d4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    33db:	eb 61                	jmp    343e <draw_iconlist+0x71>
    {
        draw_picture(c, iconlist[i].pic, iconlist[i].position_x, iconlist[i].position_y);
    33dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    33e0:	6b d0 34             	imul   $0x34,%eax,%edx
    33e3:	8b 45 14             	mov    0x14(%ebp),%eax
    33e6:	01 d0                	add    %edx,%eax
    33e8:	8b 48 24             	mov    0x24(%eax),%ecx
    33eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    33ee:	6b d0 34             	imul   $0x34,%eax,%edx
    33f1:	8b 45 14             	mov    0x14(%ebp),%eax
    33f4:	01 d0                	add    %edx,%eax
    33f6:	8b 50 20             	mov    0x20(%eax),%edx
    33f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    33fc:	6b d8 34             	imul   $0x34,%eax,%ebx
    33ff:	8b 45 14             	mov    0x14(%ebp),%eax
    3402:	01 d8                	add    %ebx,%eax
    3404:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    3408:	89 54 24 18          	mov    %edx,0x18(%esp)
    340c:	8b 50 28             	mov    0x28(%eax),%edx
    340f:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3413:	8b 50 2c             	mov    0x2c(%eax),%edx
    3416:	89 54 24 10          	mov    %edx,0x10(%esp)
    341a:	8b 40 30             	mov    0x30(%eax),%eax
    341d:	89 44 24 14          	mov    %eax,0x14(%esp)
    3421:	8b 45 08             	mov    0x8(%ebp),%eax
    3424:	89 04 24             	mov    %eax,(%esp)
    3427:	8b 45 0c             	mov    0xc(%ebp),%eax
    342a:	89 44 24 04          	mov    %eax,0x4(%esp)
    342e:	8b 45 10             	mov    0x10(%ebp),%eax
    3431:	89 44 24 08          	mov    %eax,0x8(%esp)
    3435:	e8 43 f8 ff ff       	call   2c7d <draw_picture>
	}
}
void draw_iconlist(Context c, ICON* iconlist, int len)
{
    int i;
    for (i = 0; i < len; i++)
    343a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    343e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3441:	3b 45 18             	cmp    0x18(%ebp),%eax
    3444:	7c 97                	jl     33dd <draw_iconlist+0x10>
    {
        draw_picture(c, iconlist[i].pic, iconlist[i].position_x, iconlist[i].position_y);
    }
}
    3446:	83 c4 30             	add    $0x30,%esp
    3449:	5b                   	pop    %ebx
    344a:	5d                   	pop    %ebp
    344b:	c3                   	ret    

0000344c <loadBitmap>:
#include "clickable.h"

void showRgbQuan(RGBQUAD* pRGB);
void showBmpHead(BITMAPFILEHEADER* pBmpHead);
void showBmpInforHead(BITMAPINFOHEADER* pBmpInforHead);
void loadBitmap(PICNODE *pic, char pic_name[]) {
    344c:	55                   	push   %ebp
    344d:	89 e5                	mov    %esp,%ebp
    344f:	81 ec a8 00 00 00    	sub    $0xa8,%esp
	BITMAPFILEHEADER bitHead;
	BITMAPINFOHEADER bitInfoHead;
	char *BmpFileHeader;
	WORD *temp_WORD;
	DWORD *temp_DWORD;
	int fd, n, i, j, k, index = 0;
    3455:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int width;
	int height;

	if ((fd = open(pic_name, 0)) < 0) {
    345c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3463:	00 
    3464:	8b 45 0c             	mov    0xc(%ebp),%eax
    3467:	89 04 24             	mov    %eax,(%esp)
    346a:	e8 ef 11 00 00       	call   465e <open>
    346f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    3472:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3476:	79 20                	jns    3498 <loadBitmap+0x4c>
		printf(0, "cannot open %s\n", pic_name);
    3478:	8b 45 0c             	mov    0xc(%ebp),%eax
    347b:	89 44 24 08          	mov    %eax,0x8(%esp)
    347f:	c7 44 24 04 5c b0 00 	movl   $0xb05c,0x4(%esp)
    3486:	00 
    3487:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    348e:	e8 73 13 00 00       	call   4806 <printf>
		return;
    3493:	e9 ef 02 00 00       	jmp    3787 <loadBitmap+0x33b>
	}
	printf(0, "reading bitmap: %s\n", pic_name);
    3498:	8b 45 0c             	mov    0xc(%ebp),%eax
    349b:	89 44 24 08          	mov    %eax,0x8(%esp)
    349f:	c7 44 24 04 6c b0 00 	movl   $0xb06c,0x4(%esp)
    34a6:	00 
    34a7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    34ae:	e8 53 13 00 00       	call   4806 <printf>
	//pfile = fopen(strFile,"rb");//打开文件
	BmpFileHeader = (char *) malloc(14 * sizeof(char));
    34b3:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
    34ba:	e8 33 16 00 00       	call   4af2 <malloc>
    34bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//printf(0, "file bmp open success.\n");
	//读取位图文件头信息
	//printf(0, "reading BmpFileHeader.\n");
	n = read(fd, BmpFileHeader, 14);
    34c2:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
    34c9:	00 
    34ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    34cd:	89 44 24 04          	mov    %eax,0x4(%esp)
    34d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    34d4:	89 04 24             	mov    %eax,(%esp)
    34d7:	e8 5a 11 00 00       	call   4636 <read>
    34dc:	89 45 e0             	mov    %eax,-0x20(%ebp)
	//fread(BmpFileHeader,1,14,pfile);
	temp_WORD = (WORD*) (BmpFileHeader);
    34df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    34e2:	89 45 dc             	mov    %eax,-0x24(%ebp)
	bitHead.bfType = *temp_WORD;
    34e5:	8b 45 dc             	mov    -0x24(%ebp),%eax
    34e8:	0f b7 00             	movzwl (%eax),%eax
    34eb:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
	if (bitHead.bfType != 0x4d42) {
    34ef:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    34f3:	66 3d 42 4d          	cmp    $0x4d42,%ax
    34f7:	74 19                	je     3512 <loadBitmap+0xc6>
		printf(0, "file is not .bmp file!");
    34f9:	c7 44 24 04 80 b0 00 	movl   $0xb080,0x4(%esp)
    3500:	00 
    3501:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3508:	e8 f9 12 00 00       	call   4806 <printf>
		return;
    350d:	e9 75 02 00 00       	jmp    3787 <loadBitmap+0x33b>
	}
	temp_DWORD = (DWORD *) (BmpFileHeader + sizeof(bitHead.bfType));
    3512:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3515:	83 c0 02             	add    $0x2,%eax
    3518:	89 45 d8             	mov    %eax,-0x28(%ebp)
	bitHead.bfSize = *temp_DWORD;
    351b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    351e:	8b 00                	mov    (%eax),%eax
    3520:	89 45 b0             	mov    %eax,-0x50(%ebp)
	temp_WORD = (WORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    3523:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3526:	83 c0 06             	add    $0x6,%eax
    3529:	89 45 dc             	mov    %eax,-0x24(%ebp)
			+ sizeof(bitHead.bfSize));
	bitHead.bfReserved1 = *temp_WORD;
    352c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    352f:	0f b7 00             	movzwl (%eax),%eax
    3532:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
	temp_WORD = (WORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    3536:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3539:	83 c0 08             	add    $0x8,%eax
    353c:	89 45 dc             	mov    %eax,-0x24(%ebp)
			+ sizeof(bitHead.bfSize) + sizeof(bitHead.bfReserved1));
	bitHead.bfReserved2 = *temp_WORD;
    353f:	8b 45 dc             	mov    -0x24(%ebp),%eax
    3542:	0f b7 00             	movzwl (%eax),%eax
    3545:	66 89 45 b6          	mov    %ax,-0x4a(%ebp)
	temp_DWORD = (DWORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    3549:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    354c:	83 c0 0a             	add    $0xa,%eax
    354f:	89 45 d8             	mov    %eax,-0x28(%ebp)
			+ sizeof(bitHead.bfSize) + sizeof(bitHead.bfReserved1)
			+ sizeof(bitHead.bfReserved2));
	bitHead.bfOffBits = *temp_DWORD;
    3552:	8b 45 d8             	mov    -0x28(%ebp),%eax
    3555:	8b 00                	mov    (%eax),%eax
    3557:	89 45 b8             	mov    %eax,-0x48(%ebp)
	//printf(0, "reading BmpFileHeader success!\n");
	//showBmpHead(&bitHead);
	//printf(0, "\n\n");
//
//	//读取位图信息头信息
	read(fd, &bitInfoHead, sizeof(BITMAPINFOHEADER));
    355a:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    3561:	00 
    3562:	8d 45 84             	lea    -0x7c(%ebp),%eax
    3565:	89 44 24 04          	mov    %eax,0x4(%esp)
    3569:	8b 45 e8             	mov    -0x18(%ebp),%eax
    356c:	89 04 24             	mov    %eax,(%esp)
    356f:	e8 c2 10 00 00       	call   4636 <read>
	width = bitInfoHead.biWidth;
    3574:	8b 45 88             	mov    -0x78(%ebp),%eax
    3577:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	height = bitInfoHead.biHeight;
    357a:	8b 45 8c             	mov    -0x74(%ebp),%eax
    357d:	89 45 d0             	mov    %eax,-0x30(%ebp)
	printf(0, "bmp width: %d, height: %d, size: %d\n", width, height,
			width * height * sizeof(RGBQUAD));
    3580:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3583:	0f af 45 d0          	imul   -0x30(%ebp),%eax
//
//	//读取位图信息头信息
	read(fd, &bitInfoHead, sizeof(BITMAPINFOHEADER));
	width = bitInfoHead.biWidth;
	height = bitInfoHead.biHeight;
	printf(0, "bmp width: %d, height: %d, size: %d\n", width, height,
    3587:	c1 e0 02             	shl    $0x2,%eax
    358a:	89 44 24 10          	mov    %eax,0x10(%esp)
    358e:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3591:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3595:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3598:	89 44 24 08          	mov    %eax,0x8(%esp)
    359c:	c7 44 24 04 98 b0 00 	movl   $0xb098,0x4(%esp)
    35a3:	00 
    35a4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35ab:	e8 56 12 00 00       	call   4806 <printf>
			width * height * sizeof(RGBQUAD));
	//fread(&bitInfoHead,1,sizeof(BITMAPINFOHEADER),pfile);
	//showBmpInforHead(&bitInfoHead);
	//printf(0, "\n");
	if (n == 0) {
    35b0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    35b4:	75 14                	jne    35ca <loadBitmap+0x17e>
		printf(0, "0");
    35b6:	c7 44 24 04 bd b0 00 	movl   $0xb0bd,0x4(%esp)
    35bd:	00 
    35be:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35c5:	e8 3c 12 00 00       	call   4806 <printf>
	}

	//分配内存空间把源图存入内存
	int l_width = WIDTHBYTES(width * bitInfoHead.biBitCount);//计算位图的实际宽度并确保它为32的倍数
    35ca:	0f b7 45 92          	movzwl -0x6e(%ebp),%eax
    35ce:	0f b7 c0             	movzwl %ax,%eax
    35d1:	0f af 45 d4          	imul   -0x2c(%ebp),%eax
    35d5:	83 c0 1f             	add    $0x1f,%eax
    35d8:	8d 50 1f             	lea    0x1f(%eax),%edx
    35db:	85 c0                	test   %eax,%eax
    35dd:	0f 48 c2             	cmovs  %edx,%eax
    35e0:	c1 f8 05             	sar    $0x5,%eax
    35e3:	c1 e0 02             	shl    $0x2,%eax
    35e6:	89 45 cc             	mov    %eax,-0x34(%ebp)
	BYTE *pColorData = (BYTE *) malloc(height * l_width);
    35e9:	8b 45 d0             	mov    -0x30(%ebp),%eax
    35ec:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    35f0:	89 04 24             	mov    %eax,(%esp)
    35f3:	e8 fa 14 00 00       	call   4af2 <malloc>
    35f8:	89 45 c8             	mov    %eax,-0x38(%ebp)
	memset(pColorData, 0, (uint) height * l_width);
    35fb:	8b 55 d0             	mov    -0x30(%ebp),%edx
    35fe:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3601:	0f af c2             	imul   %edx,%eax
    3604:	89 44 24 08          	mov    %eax,0x8(%esp)
    3608:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    360f:	00 
    3610:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3613:	89 04 24             	mov    %eax,(%esp)
    3616:	e8 56 0e 00 00       	call   4471 <memset>
	long nData = height * l_width;
    361b:	8b 45 d0             	mov    -0x30(%ebp),%eax
    361e:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    3622:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	//把位图数据信息读到数组里
	read(fd, pColorData, nData);
    3625:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    3628:	89 44 24 08          	mov    %eax,0x8(%esp)
    362c:	8b 45 c8             	mov    -0x38(%ebp),%eax
    362f:	89 44 24 04          	mov    %eax,0x4(%esp)
    3633:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3636:	89 04 24             	mov    %eax,(%esp)
    3639:	e8 f8 0f 00 00       	call   4636 <read>

	//printf(0, "reading bmp data.\n");
	//将位图数据转化为RGB数据
	RGBQUAD* dataOfBmp;

	dataOfBmp = (RGBQUAD *) malloc(width * height * sizeof(RGBQUAD));//用于保存各像素对应的RGB数据
    363e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3641:	0f af 45 d0          	imul   -0x30(%ebp),%eax
    3645:	c1 e0 02             	shl    $0x2,%eax
    3648:	89 04 24             	mov    %eax,(%esp)
    364b:	e8 a2 14 00 00       	call   4af2 <malloc>
    3650:	89 45 c0             	mov    %eax,-0x40(%ebp)
	memset(dataOfBmp, 0, (uint) width * height * sizeof(RGBQUAD));
    3653:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    3656:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3659:	0f af c2             	imul   %edx,%eax
    365c:	c1 e0 02             	shl    $0x2,%eax
    365f:	89 44 24 08          	mov    %eax,0x8(%esp)
    3663:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    366a:	00 
    366b:	8b 45 c0             	mov    -0x40(%ebp),%eax
    366e:	89 04 24             	mov    %eax,(%esp)
    3671:	e8 fb 0d 00 00       	call   4471 <memset>
	if (bitInfoHead.biBitCount < 24)	//有调色板，即位图为非真彩色
    3676:	0f b7 45 92          	movzwl -0x6e(%ebp),%eax
    367a:	66 83 f8 17          	cmp    $0x17,%ax
    367e:	77 19                	ja     3699 <loadBitmap+0x24d>
			{
		printf(0, "%s is not a 24 bit bmp! return.");
    3680:	c7 44 24 04 c0 b0 00 	movl   $0xb0c0,0x4(%esp)
    3687:	00 
    3688:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    368f:	e8 72 11 00 00       	call   4806 <printf>
		return;
    3694:	e9 ee 00 00 00       	jmp    3787 <loadBitmap+0x33b>
	} else	//位图为24位真彩色
	{
		index = 0;
    3699:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (i = 0; i < height; i++)
    36a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    36a7:	e9 94 00 00 00       	jmp    3740 <loadBitmap+0x2f4>
			for (j = 0; j < width; j++) {
    36ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    36b3:	eb 7b                	jmp    3730 <loadBitmap+0x2e4>
				k = i * l_width + j * 3;
    36b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    36b8:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    36bc:	89 c1                	mov    %eax,%ecx
    36be:	8b 55 f0             	mov    -0x10(%ebp),%edx
    36c1:	89 d0                	mov    %edx,%eax
    36c3:	01 c0                	add    %eax,%eax
    36c5:	01 d0                	add    %edx,%eax
    36c7:	01 c8                	add    %ecx,%eax
    36c9:	89 45 bc             	mov    %eax,-0x44(%ebp)
				dataOfBmp[index].rgbRed = pColorData[k + 2];
    36cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    36cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    36d6:	8b 45 c0             	mov    -0x40(%ebp),%eax
    36d9:	01 c2                	add    %eax,%edx
    36db:	8b 45 bc             	mov    -0x44(%ebp),%eax
    36de:	8d 48 02             	lea    0x2(%eax),%ecx
    36e1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    36e4:	01 c8                	add    %ecx,%eax
    36e6:	0f b6 00             	movzbl (%eax),%eax
    36e9:	88 42 02             	mov    %al,0x2(%edx)
				dataOfBmp[index].rgbGreen = pColorData[k + 1];
    36ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
    36ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    36f6:	8b 45 c0             	mov    -0x40(%ebp),%eax
    36f9:	01 c2                	add    %eax,%edx
    36fb:	8b 45 bc             	mov    -0x44(%ebp),%eax
    36fe:	8d 48 01             	lea    0x1(%eax),%ecx
    3701:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3704:	01 c8                	add    %ecx,%eax
    3706:	0f b6 00             	movzbl (%eax),%eax
    3709:	88 42 01             	mov    %al,0x1(%edx)
				dataOfBmp[index].rgbBlue = pColorData[k];
    370c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    370f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3716:	8b 45 c0             	mov    -0x40(%ebp),%eax
    3719:	01 c2                	add    %eax,%edx
    371b:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    371e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3721:	01 c8                	add    %ecx,%eax
    3723:	0f b6 00             	movzbl (%eax),%eax
    3726:	88 02                	mov    %al,(%edx)
				index++;
    3728:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
		return;
	} else	//位图为24位真彩色
	{
		index = 0;
		for (i = 0; i < height; i++)
			for (j = 0; j < width; j++) {
    372c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3730:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3733:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
    3736:	0f 8c 79 ff ff ff    	jl     36b5 <loadBitmap+0x269>
		printf(0, "%s is not a 24 bit bmp! return.");
		return;
	} else	//位图为24位真彩色
	{
		index = 0;
		for (i = 0; i < height; i++)
    373c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3740:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3743:	3b 45 d0             	cmp    -0x30(%ebp),%eax
    3746:	0f 8c 60 ff ff ff    	jl     36ac <loadBitmap+0x260>
//			printf(0, "\n");
//		}
//		showRgbQuan(&dataOfBmp[i]);
//	}

	close(fd);
    374c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    374f:	89 04 24             	mov    %eax,(%esp)
    3752:	e8 ef 0e 00 00       	call   4646 <close>

	//free(dataOfBmp);
	pic->data = dataOfBmp;
    3757:	8b 45 08             	mov    0x8(%ebp),%eax
    375a:	8b 55 c0             	mov    -0x40(%ebp),%edx
    375d:	89 10                	mov    %edx,(%eax)
	pic->width = width;
    375f:	8b 45 08             	mov    0x8(%ebp),%eax
    3762:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    3765:	89 50 04             	mov    %edx,0x4(%eax)
	pic->height = height;
    3768:	8b 45 08             	mov    0x8(%ebp),%eax
    376b:	8b 55 d0             	mov    -0x30(%ebp),%edx
    376e:	89 50 08             	mov    %edx,0x8(%eax)
	free(pColorData);
    3771:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3774:	89 04 24             	mov    %eax,(%esp)
    3777:	e8 3d 12 00 00       	call   49b9 <free>
	free(BmpFileHeader);
    377c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    377f:	89 04 24             	mov    %eax,(%esp)
    3782:	e8 32 12 00 00       	call   49b9 <free>
	//printf("\n");
}
    3787:	c9                   	leave  
    3788:	c3                   	ret    

00003789 <showBmpHead>:

void showBmpHead(BITMAPFILEHEADER* pBmpHead) {
    3789:	55                   	push   %ebp
    378a:	89 e5                	mov    %esp,%ebp
    378c:	83 ec 18             	sub    $0x18,%esp
	printf(0, "位图文件头:\n");
    378f:	c7 44 24 04 e0 b0 00 	movl   $0xb0e0,0x4(%esp)
    3796:	00 
    3797:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    379e:	e8 63 10 00 00       	call   4806 <printf>
	printf(0, "bmp格式标志bftype：0x%x\n", pBmpHead->bfType);
    37a3:	8b 45 08             	mov    0x8(%ebp),%eax
    37a6:	0f b7 00             	movzwl (%eax),%eax
    37a9:	0f b7 c0             	movzwl %ax,%eax
    37ac:	89 44 24 08          	mov    %eax,0x8(%esp)
    37b0:	c7 44 24 04 f2 b0 00 	movl   $0xb0f2,0x4(%esp)
    37b7:	00 
    37b8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37bf:	e8 42 10 00 00       	call   4806 <printf>
	printf(0, "文件大小:%d\n", pBmpHead->bfSize);
    37c4:	8b 45 08             	mov    0x8(%ebp),%eax
    37c7:	8b 40 04             	mov    0x4(%eax),%eax
    37ca:	89 44 24 08          	mov    %eax,0x8(%esp)
    37ce:	c7 44 24 04 10 b1 00 	movl   $0xb110,0x4(%esp)
    37d5:	00 
    37d6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37dd:	e8 24 10 00 00       	call   4806 <printf>
	printf(0, "保留字:%d\n", pBmpHead->bfReserved1);
    37e2:	8b 45 08             	mov    0x8(%ebp),%eax
    37e5:	0f b7 40 08          	movzwl 0x8(%eax),%eax
    37e9:	0f b7 c0             	movzwl %ax,%eax
    37ec:	89 44 24 08          	mov    %eax,0x8(%esp)
    37f0:	c7 44 24 04 21 b1 00 	movl   $0xb121,0x4(%esp)
    37f7:	00 
    37f8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37ff:	e8 02 10 00 00       	call   4806 <printf>
	printf(0, "保留字:%d\n", pBmpHead->bfReserved2);
    3804:	8b 45 08             	mov    0x8(%ebp),%eax
    3807:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    380b:	0f b7 c0             	movzwl %ax,%eax
    380e:	89 44 24 08          	mov    %eax,0x8(%esp)
    3812:	c7 44 24 04 21 b1 00 	movl   $0xb121,0x4(%esp)
    3819:	00 
    381a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3821:	e8 e0 0f 00 00       	call   4806 <printf>
	printf(0, "实际位图数据的偏移字节数:%d\n", pBmpHead->bfOffBits);
    3826:	8b 45 08             	mov    0x8(%ebp),%eax
    3829:	8b 40 0c             	mov    0xc(%eax),%eax
    382c:	89 44 24 08          	mov    %eax,0x8(%esp)
    3830:	c7 44 24 04 30 b1 00 	movl   $0xb130,0x4(%esp)
    3837:	00 
    3838:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    383f:	e8 c2 0f 00 00       	call   4806 <printf>
}
    3844:	c9                   	leave  
    3845:	c3                   	ret    

00003846 <showBmpInforHead>:

void showBmpInforHead(BITMAPINFOHEADER* pBmpInforHead) {
    3846:	55                   	push   %ebp
    3847:	89 e5                	mov    %esp,%ebp
    3849:	83 ec 18             	sub    $0x18,%esp
	printf(0, "位图信息头:\n");
    384c:	c7 44 24 04 59 b1 00 	movl   $0xb159,0x4(%esp)
    3853:	00 
    3854:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    385b:	e8 a6 0f 00 00       	call   4806 <printf>
	printf(0, "结构体的长度:%d\n", pBmpInforHead->biSize);
    3860:	8b 45 08             	mov    0x8(%ebp),%eax
    3863:	8b 00                	mov    (%eax),%eax
    3865:	89 44 24 08          	mov    %eax,0x8(%esp)
    3869:	c7 44 24 04 6b b1 00 	movl   $0xb16b,0x4(%esp)
    3870:	00 
    3871:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3878:	e8 89 0f 00 00       	call   4806 <printf>
	printf(0, "位图宽:%d\n", pBmpInforHead->biWidth);
    387d:	8b 45 08             	mov    0x8(%ebp),%eax
    3880:	8b 40 04             	mov    0x4(%eax),%eax
    3883:	89 44 24 08          	mov    %eax,0x8(%esp)
    3887:	c7 44 24 04 82 b1 00 	movl   $0xb182,0x4(%esp)
    388e:	00 
    388f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3896:	e8 6b 0f 00 00       	call   4806 <printf>
	printf(0, "位图高:%d\n", pBmpInforHead->biHeight);
    389b:	8b 45 08             	mov    0x8(%ebp),%eax
    389e:	8b 40 08             	mov    0x8(%eax),%eax
    38a1:	89 44 24 08          	mov    %eax,0x8(%esp)
    38a5:	c7 44 24 04 90 b1 00 	movl   $0xb190,0x4(%esp)
    38ac:	00 
    38ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    38b4:	e8 4d 0f 00 00       	call   4806 <printf>
	printf(0, "biPlanes平面数:%d\n", pBmpInforHead->biPlanes);
    38b9:	8b 45 08             	mov    0x8(%ebp),%eax
    38bc:	0f b7 40 0c          	movzwl 0xc(%eax),%eax
    38c0:	0f b7 c0             	movzwl %ax,%eax
    38c3:	89 44 24 08          	mov    %eax,0x8(%esp)
    38c7:	c7 44 24 04 9e b1 00 	movl   $0xb19e,0x4(%esp)
    38ce:	00 
    38cf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    38d6:	e8 2b 0f 00 00       	call   4806 <printf>
	printf(0, "biBitCount采用颜色位数:%d\n", pBmpInforHead->biBitCount);
    38db:	8b 45 08             	mov    0x8(%ebp),%eax
    38de:	0f b7 40 0e          	movzwl 0xe(%eax),%eax
    38e2:	0f b7 c0             	movzwl %ax,%eax
    38e5:	89 44 24 08          	mov    %eax,0x8(%esp)
    38e9:	c7 44 24 04 b4 b1 00 	movl   $0xb1b4,0x4(%esp)
    38f0:	00 
    38f1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    38f8:	e8 09 0f 00 00       	call   4806 <printf>
	printf(0, "压缩方式:%d\n", pBmpInforHead->biCompression);
    38fd:	8b 45 08             	mov    0x8(%ebp),%eax
    3900:	8b 40 10             	mov    0x10(%eax),%eax
    3903:	89 44 24 08          	mov    %eax,0x8(%esp)
    3907:	c7 44 24 04 d5 b1 00 	movl   $0xb1d5,0x4(%esp)
    390e:	00 
    390f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3916:	e8 eb 0e 00 00       	call   4806 <printf>
	printf(0, "biSizeImage实际位图数据占用的字节数:%d\n", pBmpInforHead->biSizeImage);
    391b:	8b 45 08             	mov    0x8(%ebp),%eax
    391e:	8b 40 14             	mov    0x14(%eax),%eax
    3921:	89 44 24 08          	mov    %eax,0x8(%esp)
    3925:	c7 44 24 04 e8 b1 00 	movl   $0xb1e8,0x4(%esp)
    392c:	00 
    392d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3934:	e8 cd 0e 00 00       	call   4806 <printf>
	printf(0, "X方向分辨率:%d\n", pBmpInforHead->biXPelsPerMeter);
    3939:	8b 45 08             	mov    0x8(%ebp),%eax
    393c:	8b 40 18             	mov    0x18(%eax),%eax
    393f:	89 44 24 08          	mov    %eax,0x8(%esp)
    3943:	c7 44 24 04 1c b2 00 	movl   $0xb21c,0x4(%esp)
    394a:	00 
    394b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3952:	e8 af 0e 00 00       	call   4806 <printf>
	printf(0, "Y方向分辨率:%d\n", pBmpInforHead->biYPelsPerMeter);
    3957:	8b 45 08             	mov    0x8(%ebp),%eax
    395a:	8b 40 1c             	mov    0x1c(%eax),%eax
    395d:	89 44 24 08          	mov    %eax,0x8(%esp)
    3961:	c7 44 24 04 31 b2 00 	movl   $0xb231,0x4(%esp)
    3968:	00 
    3969:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3970:	e8 91 0e 00 00       	call   4806 <printf>
	printf(0, "使用的颜色数:%d\n", pBmpInforHead->biClrUsed);
    3975:	8b 45 08             	mov    0x8(%ebp),%eax
    3978:	8b 40 20             	mov    0x20(%eax),%eax
    397b:	89 44 24 08          	mov    %eax,0x8(%esp)
    397f:	c7 44 24 04 46 b2 00 	movl   $0xb246,0x4(%esp)
    3986:	00 
    3987:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    398e:	e8 73 0e 00 00       	call   4806 <printf>
	printf(0, "重要颜色数:%d\n", pBmpInforHead->biClrImportant);
    3993:	8b 45 08             	mov    0x8(%ebp),%eax
    3996:	8b 40 24             	mov    0x24(%eax),%eax
    3999:	89 44 24 08          	mov    %eax,0x8(%esp)
    399d:	c7 44 24 04 5d b2 00 	movl   $0xb25d,0x4(%esp)
    39a4:	00 
    39a5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    39ac:	e8 55 0e 00 00       	call   4806 <printf>
}
    39b1:	c9                   	leave  
    39b2:	c3                   	ret    

000039b3 <showRgbQuan>:
void showRgbQuan(RGBQUAD* pRGB) {
    39b3:	55                   	push   %ebp
    39b4:	89 e5                	mov    %esp,%ebp
    39b6:	83 ec 28             	sub    $0x28,%esp
	printf(0, "(%d,%d,%d) ", pRGB->rgbRed, pRGB->rgbGreen, pRGB->rgbBlue);
    39b9:	8b 45 08             	mov    0x8(%ebp),%eax
    39bc:	0f b6 00             	movzbl (%eax),%eax
    39bf:	0f b6 c8             	movzbl %al,%ecx
    39c2:	8b 45 08             	mov    0x8(%ebp),%eax
    39c5:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    39c9:	0f b6 d0             	movzbl %al,%edx
    39cc:	8b 45 08             	mov    0x8(%ebp),%eax
    39cf:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    39d3:	0f b6 c0             	movzbl %al,%eax
    39d6:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    39da:	89 54 24 0c          	mov    %edx,0xc(%esp)
    39de:	89 44 24 08          	mov    %eax,0x8(%esp)
    39e2:	c7 44 24 04 71 b2 00 	movl   $0xb271,0x4(%esp)
    39e9:	00 
    39ea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    39f1:	e8 10 0e 00 00       	call   4806 <printf>
}
    39f6:	c9                   	leave  
    39f7:	c3                   	ret    

000039f8 <freepic>:

void freepic(PICNODE *pic) {
    39f8:	55                   	push   %ebp
    39f9:	89 e5                	mov    %esp,%ebp
    39fb:	83 ec 18             	sub    $0x18,%esp
	free(pic->data);
    39fe:	8b 45 08             	mov    0x8(%ebp),%eax
    3a01:	8b 00                	mov    (%eax),%eax
    3a03:	89 04 24             	mov    %eax,(%esp)
    3a06:	e8 ae 0f 00 00       	call   49b9 <free>
}
    3a0b:	c9                   	leave  
    3a0c:	c3                   	ret    

00003a0d <set_icon_alpha>:

void set_icon_alpha(PICNODE *pic) {
    3a0d:	55                   	push   %ebp
    3a0e:	89 e5                	mov    %esp,%ebp
    3a10:	53                   	push   %ebx
    3a11:	81 ec 84 00 00 00    	sub    $0x84,%esp
	int W = 15;
    3a17:	c7 45 ec 0f 00 00 00 	movl   $0xf,-0x14(%ebp)
	Rect r1 = initRect(0, 0, W, W);
    3a1e:	8d 45 dc             	lea    -0x24(%ebp),%eax
    3a21:	8b 55 ec             	mov    -0x14(%ebp),%edx
    3a24:	89 54 24 10          	mov    %edx,0x10(%esp)
    3a28:	8b 55 ec             	mov    -0x14(%ebp),%edx
    3a2b:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3a2f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    3a36:	00 
    3a37:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3a3e:	00 
    3a3f:	89 04 24             	mov    %eax,(%esp)
    3a42:	e8 80 02 00 00       	call   3cc7 <initRect>
    3a47:	83 ec 04             	sub    $0x4,%esp
	Rect r2 = initRect(pic->width - W, 0, W, W);
    3a4a:	8b 45 08             	mov    0x8(%ebp),%eax
    3a4d:	8b 40 04             	mov    0x4(%eax),%eax
    3a50:	2b 45 ec             	sub    -0x14(%ebp),%eax
    3a53:	89 c2                	mov    %eax,%edx
    3a55:	8d 45 cc             	lea    -0x34(%ebp),%eax
    3a58:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    3a5b:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    3a5f:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    3a62:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    3a66:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    3a6d:	00 
    3a6e:	89 54 24 04          	mov    %edx,0x4(%esp)
    3a72:	89 04 24             	mov    %eax,(%esp)
    3a75:	e8 4d 02 00 00       	call   3cc7 <initRect>
    3a7a:	83 ec 04             	sub    $0x4,%esp
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
    3a7d:	8b 45 08             	mov    0x8(%ebp),%eax
    3a80:	8b 40 08             	mov    0x8(%eax),%eax
    3a83:	2b 45 ec             	sub    -0x14(%ebp),%eax
    3a86:	89 c1                	mov    %eax,%ecx
    3a88:	8b 45 08             	mov    0x8(%ebp),%eax
    3a8b:	8b 40 04             	mov    0x4(%eax),%eax
    3a8e:	2b 45 ec             	sub    -0x14(%ebp),%eax
    3a91:	89 c2                	mov    %eax,%edx
    3a93:	8d 45 bc             	lea    -0x44(%ebp),%eax
    3a96:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    3a99:	89 5c 24 10          	mov    %ebx,0x10(%esp)
    3a9d:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    3aa0:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    3aa4:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    3aa8:	89 54 24 04          	mov    %edx,0x4(%esp)
    3aac:	89 04 24             	mov    %eax,(%esp)
    3aaf:	e8 13 02 00 00       	call   3cc7 <initRect>
    3ab4:	83 ec 04             	sub    $0x4,%esp
	Rect r4 = initRect(0, pic->height - W, W, W);
    3ab7:	8b 45 08             	mov    0x8(%ebp),%eax
    3aba:	8b 40 08             	mov    0x8(%eax),%eax
    3abd:	2b 45 ec             	sub    -0x14(%ebp),%eax
    3ac0:	89 c2                	mov    %eax,%edx
    3ac2:	8d 45 ac             	lea    -0x54(%ebp),%eax
    3ac5:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    3ac8:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    3acc:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    3acf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    3ad3:	89 54 24 08          	mov    %edx,0x8(%esp)
    3ad7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3ade:	00 
    3adf:	89 04 24             	mov    %eax,(%esp)
    3ae2:	e8 e0 01 00 00       	call   3cc7 <initRect>
    3ae7:	83 ec 04             	sub    $0x4,%esp
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
    3aea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3af1:	e9 96 01 00 00       	jmp    3c8c <set_icon_alpha+0x27f>
		for (j = 0; j < pic->height; j++) {
    3af6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3afd:	e9 77 01 00 00       	jmp    3c79 <set_icon_alpha+0x26c>
			p = initPoint(i, j);
    3b02:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3b05:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3b08:	89 54 24 08          	mov    %edx,0x8(%esp)
    3b0c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3b0f:	89 54 24 04          	mov    %edx,0x4(%esp)
    3b13:	89 04 24             	mov    %eax,(%esp)
    3b16:	e8 85 01 00 00       	call   3ca0 <initPoint>
    3b1b:	83 ec 04             	sub    $0x4,%esp
			if (isIn(p, r1) || isIn(p, r2) || isIn(p, r3) || isIn(p, r4)) {
    3b1e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    3b21:	89 44 24 08          	mov    %eax,0x8(%esp)
    3b25:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3b28:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3b2c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3b2f:	89 44 24 10          	mov    %eax,0x10(%esp)
    3b33:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3b36:	89 44 24 14          	mov    %eax,0x14(%esp)
    3b3a:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3b3d:	8b 55 a8             	mov    -0x58(%ebp),%edx
    3b40:	89 04 24             	mov    %eax,(%esp)
    3b43:	89 54 24 04          	mov    %edx,0x4(%esp)
    3b47:	e8 d6 01 00 00       	call   3d22 <isIn>
    3b4c:	85 c0                	test   %eax,%eax
    3b4e:	0f 85 9a 00 00 00    	jne    3bee <set_icon_alpha+0x1e1>
    3b54:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3b57:	89 44 24 08          	mov    %eax,0x8(%esp)
    3b5b:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3b5e:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3b62:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3b65:	89 44 24 10          	mov    %eax,0x10(%esp)
    3b69:	8b 45 d8             	mov    -0x28(%ebp),%eax
    3b6c:	89 44 24 14          	mov    %eax,0x14(%esp)
    3b70:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3b73:	8b 55 a8             	mov    -0x58(%ebp),%edx
    3b76:	89 04 24             	mov    %eax,(%esp)
    3b79:	89 54 24 04          	mov    %edx,0x4(%esp)
    3b7d:	e8 a0 01 00 00       	call   3d22 <isIn>
    3b82:	85 c0                	test   %eax,%eax
    3b84:	75 68                	jne    3bee <set_icon_alpha+0x1e1>
    3b86:	8b 45 bc             	mov    -0x44(%ebp),%eax
    3b89:	89 44 24 08          	mov    %eax,0x8(%esp)
    3b8d:	8b 45 c0             	mov    -0x40(%ebp),%eax
    3b90:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3b94:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    3b97:	89 44 24 10          	mov    %eax,0x10(%esp)
    3b9b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3b9e:	89 44 24 14          	mov    %eax,0x14(%esp)
    3ba2:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3ba5:	8b 55 a8             	mov    -0x58(%ebp),%edx
    3ba8:	89 04 24             	mov    %eax,(%esp)
    3bab:	89 54 24 04          	mov    %edx,0x4(%esp)
    3baf:	e8 6e 01 00 00       	call   3d22 <isIn>
    3bb4:	85 c0                	test   %eax,%eax
    3bb6:	75 36                	jne    3bee <set_icon_alpha+0x1e1>
    3bb8:	8b 45 ac             	mov    -0x54(%ebp),%eax
    3bbb:	89 44 24 08          	mov    %eax,0x8(%esp)
    3bbf:	8b 45 b0             	mov    -0x50(%ebp),%eax
    3bc2:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3bc6:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    3bc9:	89 44 24 10          	mov    %eax,0x10(%esp)
    3bcd:	8b 45 b8             	mov    -0x48(%ebp),%eax
    3bd0:	89 44 24 14          	mov    %eax,0x14(%esp)
    3bd4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3bd7:	8b 55 a8             	mov    -0x58(%ebp),%edx
    3bda:	89 04 24             	mov    %eax,(%esp)
    3bdd:	89 54 24 04          	mov    %edx,0x4(%esp)
    3be1:	e8 3c 01 00 00       	call   3d22 <isIn>
    3be6:	85 c0                	test   %eax,%eax
    3be8:	0f 84 87 00 00 00    	je     3c75 <set_icon_alpha+0x268>
				if (pic->data[j * pic->width + i].rgbBlue == 0xff
    3bee:	8b 45 08             	mov    0x8(%ebp),%eax
    3bf1:	8b 10                	mov    (%eax),%edx
    3bf3:	8b 45 08             	mov    0x8(%ebp),%eax
    3bf6:	8b 40 04             	mov    0x4(%eax),%eax
    3bf9:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    3bfd:	89 c1                	mov    %eax,%ecx
    3bff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3c02:	01 c8                	add    %ecx,%eax
    3c04:	c1 e0 02             	shl    $0x2,%eax
    3c07:	01 d0                	add    %edx,%eax
    3c09:	0f b6 00             	movzbl (%eax),%eax
    3c0c:	3c ff                	cmp    $0xff,%al
    3c0e:	75 65                	jne    3c75 <set_icon_alpha+0x268>
						&& pic->data[j * pic->width + i].rgbGreen == 0xff
    3c10:	8b 45 08             	mov    0x8(%ebp),%eax
    3c13:	8b 10                	mov    (%eax),%edx
    3c15:	8b 45 08             	mov    0x8(%ebp),%eax
    3c18:	8b 40 04             	mov    0x4(%eax),%eax
    3c1b:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    3c1f:	89 c1                	mov    %eax,%ecx
    3c21:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3c24:	01 c8                	add    %ecx,%eax
    3c26:	c1 e0 02             	shl    $0x2,%eax
    3c29:	01 d0                	add    %edx,%eax
    3c2b:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    3c2f:	3c ff                	cmp    $0xff,%al
    3c31:	75 42                	jne    3c75 <set_icon_alpha+0x268>
						&& pic->data[j * pic->width + i].rgbRed == 0xff) {
    3c33:	8b 45 08             	mov    0x8(%ebp),%eax
    3c36:	8b 10                	mov    (%eax),%edx
    3c38:	8b 45 08             	mov    0x8(%ebp),%eax
    3c3b:	8b 40 04             	mov    0x4(%eax),%eax
    3c3e:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    3c42:	89 c1                	mov    %eax,%ecx
    3c44:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3c47:	01 c8                	add    %ecx,%eax
    3c49:	c1 e0 02             	shl    $0x2,%eax
    3c4c:	01 d0                	add    %edx,%eax
    3c4e:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    3c52:	3c ff                	cmp    $0xff,%al
    3c54:	75 1f                	jne    3c75 <set_icon_alpha+0x268>
					pic->data[j * pic->width + i].rgbReserved = 1;
    3c56:	8b 45 08             	mov    0x8(%ebp),%eax
    3c59:	8b 10                	mov    (%eax),%edx
    3c5b:	8b 45 08             	mov    0x8(%ebp),%eax
    3c5e:	8b 40 04             	mov    0x4(%eax),%eax
    3c61:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    3c65:	89 c1                	mov    %eax,%ecx
    3c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3c6a:	01 c8                	add    %ecx,%eax
    3c6c:	c1 e0 02             	shl    $0x2,%eax
    3c6f:	01 d0                	add    %edx,%eax
    3c71:	c6 40 03 01          	movb   $0x1,0x3(%eax)
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
	Rect r4 = initRect(0, pic->height - W, W, W);
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
		for (j = 0; j < pic->height; j++) {
    3c75:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3c79:	8b 45 08             	mov    0x8(%ebp),%eax
    3c7c:	8b 40 08             	mov    0x8(%eax),%eax
    3c7f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    3c82:	0f 8f 7a fe ff ff    	jg     3b02 <set_icon_alpha+0xf5>
	Rect r2 = initRect(pic->width - W, 0, W, W);
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
	Rect r4 = initRect(0, pic->height - W, W, W);
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
    3c88:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3c8c:	8b 45 08             	mov    0x8(%ebp),%eax
    3c8f:	8b 40 04             	mov    0x4(%eax),%eax
    3c92:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3c95:	0f 8f 5b fe ff ff    	jg     3af6 <set_icon_alpha+0xe9>
					pic->data[j * pic->width + i].rgbReserved = 1;
				}
			}
		}
	}
}
    3c9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3c9e:	c9                   	leave  
    3c9f:	c3                   	ret    

00003ca0 <initPoint>:
#include "message.h"
#include "types.h"
#include "user.h"
#include "finder.h"
Point initPoint(int x, int y)
{
    3ca0:	55                   	push   %ebp
    3ca1:	89 e5                	mov    %esp,%ebp
    3ca3:	83 ec 10             	sub    $0x10,%esp
	Point p;
	p.x = x;
    3ca6:	8b 45 0c             	mov    0xc(%ebp),%eax
    3ca9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	p.y = y;
    3cac:	8b 45 10             	mov    0x10(%ebp),%eax
    3caf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return p;
    3cb2:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3cb5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3cb8:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3cbb:	89 01                	mov    %eax,(%ecx)
    3cbd:	89 51 04             	mov    %edx,0x4(%ecx)
}
    3cc0:	8b 45 08             	mov    0x8(%ebp),%eax
    3cc3:	c9                   	leave  
    3cc4:	c2 04 00             	ret    $0x4

00003cc7 <initRect>:

Rect initRect(int x, int y, int w, int h)
{
    3cc7:	55                   	push   %ebp
    3cc8:	89 e5                	mov    %esp,%ebp
    3cca:	83 ec 24             	sub    $0x24,%esp
	Rect r;
	r.start = initPoint(x, y);
    3ccd:	8d 45 e8             	lea    -0x18(%ebp),%eax
    3cd0:	8b 55 10             	mov    0x10(%ebp),%edx
    3cd3:	89 54 24 08          	mov    %edx,0x8(%esp)
    3cd7:	8b 55 0c             	mov    0xc(%ebp),%edx
    3cda:	89 54 24 04          	mov    %edx,0x4(%esp)
    3cde:	89 04 24             	mov    %eax,(%esp)
    3ce1:	e8 ba ff ff ff       	call   3ca0 <initPoint>
    3ce6:	83 ec 04             	sub    $0x4,%esp
    3ce9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3cec:	8b 55 ec             	mov    -0x14(%ebp),%edx
    3cef:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3cf2:	89 55 f4             	mov    %edx,-0xc(%ebp)
	r.width = w;
    3cf5:	8b 45 14             	mov    0x14(%ebp),%eax
    3cf8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	r.height = h;
    3cfb:	8b 45 18             	mov    0x18(%ebp),%eax
    3cfe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return r;
    3d01:	8b 45 08             	mov    0x8(%ebp),%eax
    3d04:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3d07:	89 10                	mov    %edx,(%eax)
    3d09:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3d0c:	89 50 04             	mov    %edx,0x4(%eax)
    3d0f:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3d12:	89 50 08             	mov    %edx,0x8(%eax)
    3d15:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3d18:	89 50 0c             	mov    %edx,0xc(%eax)
}
    3d1b:	8b 45 08             	mov    0x8(%ebp),%eax
    3d1e:	c9                   	leave  
    3d1f:	c2 04 00             	ret    $0x4

00003d22 <isIn>:

int isIn(Point p, Rect r)
{
    3d22:	55                   	push   %ebp
    3d23:	89 e5                	mov    %esp,%ebp
	return (p.x >= r.start.x) && (p.x < r.start.x+r.width)
    3d25:	8b 55 08             	mov    0x8(%ebp),%edx
    3d28:	8b 45 10             	mov    0x10(%ebp),%eax
			&& (p.y >= r.start.y) && (p.y < r.start.y+r.height);
    3d2b:	39 c2                	cmp    %eax,%edx
    3d2d:	7c 2f                	jl     3d5e <isIn+0x3c>
	return r;
}

int isIn(Point p, Rect r)
{
	return (p.x >= r.start.x) && (p.x < r.start.x+r.width)
    3d2f:	8b 45 08             	mov    0x8(%ebp),%eax
    3d32:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3d35:	8b 55 18             	mov    0x18(%ebp),%edx
    3d38:	01 ca                	add    %ecx,%edx
    3d3a:	39 d0                	cmp    %edx,%eax
    3d3c:	7d 20                	jge    3d5e <isIn+0x3c>
			&& (p.y >= r.start.y) && (p.y < r.start.y+r.height);
    3d3e:	8b 55 0c             	mov    0xc(%ebp),%edx
    3d41:	8b 45 14             	mov    0x14(%ebp),%eax
    3d44:	39 c2                	cmp    %eax,%edx
    3d46:	7c 16                	jl     3d5e <isIn+0x3c>
    3d48:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d4b:	8b 4d 14             	mov    0x14(%ebp),%ecx
    3d4e:	8b 55 1c             	mov    0x1c(%ebp),%edx
    3d51:	01 ca                	add    %ecx,%edx
    3d53:	39 d0                	cmp    %edx,%eax
    3d55:	7d 07                	jge    3d5e <isIn+0x3c>
    3d57:	b8 01 00 00 00       	mov    $0x1,%eax
    3d5c:	eb 05                	jmp    3d63 <isIn+0x41>
    3d5e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3d63:	5d                   	pop    %ebp
    3d64:	c3                   	ret    

00003d65 <initClickManager>:

ClickableManager initClickManager(struct Context c)
{
    3d65:	55                   	push   %ebp
    3d66:	89 e5                	mov    %esp,%ebp
    3d68:	83 ec 20             	sub    $0x20,%esp
	ClickableManager cm;
	cm.left_click = 0;
    3d6b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	cm.double_click = 0;
    3d72:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	cm.right_click = 0;
    3d79:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	cm.wndWidth = c.width;
    3d80:	8b 45 10             	mov    0x10(%ebp),%eax
    3d83:	89 45 f8             	mov    %eax,-0x8(%ebp)
	cm.wndHeight = c.height;
    3d86:	8b 45 14             	mov    0x14(%ebp),%eax
    3d89:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return cm;
    3d8c:	8b 45 08             	mov    0x8(%ebp),%eax
    3d8f:	8b 55 ec             	mov    -0x14(%ebp),%edx
    3d92:	89 10                	mov    %edx,(%eax)
    3d94:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3d97:	89 50 04             	mov    %edx,0x4(%eax)
    3d9a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3d9d:	89 50 08             	mov    %edx,0x8(%eax)
    3da0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3da3:	89 50 0c             	mov    %edx,0xc(%eax)
    3da6:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3da9:	89 50 10             	mov    %edx,0x10(%eax)
}
    3dac:	8b 45 08             	mov    0x8(%ebp),%eax
    3daf:	c9                   	leave  
    3db0:	c2 04 00             	ret    $0x4

00003db3 <createClickable>:

void createClickable(ClickableManager *c, Rect r, int MsgType, Handler h)
{
    3db3:	55                   	push   %ebp
    3db4:	89 e5                	mov    %esp,%ebp
    3db6:	83 ec 28             	sub    $0x28,%esp
	switch (MsgType)
    3db9:	8b 45 1c             	mov    0x1c(%ebp),%eax
    3dbc:	83 f8 03             	cmp    $0x3,%eax
    3dbf:	74 72                	je     3e33 <createClickable+0x80>
    3dc1:	83 f8 04             	cmp    $0x4,%eax
    3dc4:	74 0a                	je     3dd0 <createClickable+0x1d>
    3dc6:	83 f8 02             	cmp    $0x2,%eax
    3dc9:	74 38                	je     3e03 <createClickable+0x50>
    3dcb:	e9 96 00 00 00       	jmp    3e66 <createClickable+0xb3>
	{
		case MSG_DOUBLECLICK:
			addClickable(&c->double_click, r, h);
    3dd0:	8b 45 08             	mov    0x8(%ebp),%eax
    3dd3:	8d 50 04             	lea    0x4(%eax),%edx
    3dd6:	8b 45 20             	mov    0x20(%ebp),%eax
    3dd9:	89 44 24 14          	mov    %eax,0x14(%esp)
    3ddd:	8b 45 0c             	mov    0xc(%ebp),%eax
    3de0:	89 44 24 04          	mov    %eax,0x4(%esp)
    3de4:	8b 45 10             	mov    0x10(%ebp),%eax
    3de7:	89 44 24 08          	mov    %eax,0x8(%esp)
    3deb:	8b 45 14             	mov    0x14(%ebp),%eax
    3dee:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3df2:	8b 45 18             	mov    0x18(%ebp),%eax
    3df5:	89 44 24 10          	mov    %eax,0x10(%esp)
    3df9:	89 14 24             	mov    %edx,(%esp)
    3dfc:	e8 7c 00 00 00       	call   3e7d <addClickable>
	        break;
    3e01:	eb 78                	jmp    3e7b <createClickable+0xc8>
	    case MSG_LPRESS:
	    	addClickable(&c->left_click, r, h);
    3e03:	8b 45 08             	mov    0x8(%ebp),%eax
    3e06:	8b 55 20             	mov    0x20(%ebp),%edx
    3e09:	89 54 24 14          	mov    %edx,0x14(%esp)
    3e0d:	8b 55 0c             	mov    0xc(%ebp),%edx
    3e10:	89 54 24 04          	mov    %edx,0x4(%esp)
    3e14:	8b 55 10             	mov    0x10(%ebp),%edx
    3e17:	89 54 24 08          	mov    %edx,0x8(%esp)
    3e1b:	8b 55 14             	mov    0x14(%ebp),%edx
    3e1e:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3e22:	8b 55 18             	mov    0x18(%ebp),%edx
    3e25:	89 54 24 10          	mov    %edx,0x10(%esp)
    3e29:	89 04 24             	mov    %eax,(%esp)
    3e2c:	e8 4c 00 00 00       	call   3e7d <addClickable>
	    	break;
    3e31:	eb 48                	jmp    3e7b <createClickable+0xc8>
	    case MSG_RPRESS:
	    	addClickable(&c->right_click, r, h);
    3e33:	8b 45 08             	mov    0x8(%ebp),%eax
    3e36:	8d 50 08             	lea    0x8(%eax),%edx
    3e39:	8b 45 20             	mov    0x20(%ebp),%eax
    3e3c:	89 44 24 14          	mov    %eax,0x14(%esp)
    3e40:	8b 45 0c             	mov    0xc(%ebp),%eax
    3e43:	89 44 24 04          	mov    %eax,0x4(%esp)
    3e47:	8b 45 10             	mov    0x10(%ebp),%eax
    3e4a:	89 44 24 08          	mov    %eax,0x8(%esp)
    3e4e:	8b 45 14             	mov    0x14(%ebp),%eax
    3e51:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3e55:	8b 45 18             	mov    0x18(%ebp),%eax
    3e58:	89 44 24 10          	mov    %eax,0x10(%esp)
    3e5c:	89 14 24             	mov    %edx,(%esp)
    3e5f:	e8 19 00 00 00       	call   3e7d <addClickable>
	    	break;
    3e64:	eb 15                	jmp    3e7b <createClickable+0xc8>
	    default:
	    	printf(0, "向clickable传递了非鼠标点击事件！");
    3e66:	c7 44 24 04 80 b2 00 	movl   $0xb280,0x4(%esp)
    3e6d:	00 
    3e6e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3e75:	e8 8c 09 00 00       	call   4806 <printf>
	    	break;
    3e7a:	90                   	nop
	}
}
    3e7b:	c9                   	leave  
    3e7c:	c3                   	ret    

00003e7d <addClickable>:

void addClickable(Clickable **head, Rect r, Handler h)
{
    3e7d:	55                   	push   %ebp
    3e7e:	89 e5                	mov    %esp,%ebp
    3e80:	83 ec 28             	sub    $0x28,%esp
	//printf(0, "adding clickable\n");
	Clickable *c = (Clickable *)malloc(sizeof(Clickable));
    3e83:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
    3e8a:	e8 63 0c 00 00       	call   4af2 <malloc>
    3e8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	c->area = r;
    3e92:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e95:	8b 55 0c             	mov    0xc(%ebp),%edx
    3e98:	89 10                	mov    %edx,(%eax)
    3e9a:	8b 55 10             	mov    0x10(%ebp),%edx
    3e9d:	89 50 04             	mov    %edx,0x4(%eax)
    3ea0:	8b 55 14             	mov    0x14(%ebp),%edx
    3ea3:	89 50 08             	mov    %edx,0x8(%eax)
    3ea6:	8b 55 18             	mov    0x18(%ebp),%edx
    3ea9:	89 50 0c             	mov    %edx,0xc(%eax)
	c->handler = h;
    3eac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3eaf:	8b 55 1c             	mov    0x1c(%ebp),%edx
    3eb2:	89 50 10             	mov    %edx,0x10(%eax)
	c->next = *head;
    3eb5:	8b 45 08             	mov    0x8(%ebp),%eax
    3eb8:	8b 10                	mov    (%eax),%edx
    3eba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ebd:	89 50 14             	mov    %edx,0x14(%eax)
	*head = c;
    3ec0:	8b 45 08             	mov    0x8(%ebp),%eax
    3ec3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3ec6:	89 10                	mov    %edx,(%eax)
}
    3ec8:	c9                   	leave  
    3ec9:	c3                   	ret    

00003eca <deleteClickable>:

void deleteClickable(Clickable **head, Rect region)
{
    3eca:	55                   	push   %ebp
    3ecb:	89 e5                	mov    %esp,%ebp
    3ecd:	83 ec 38             	sub    $0x38,%esp
	Clickable *prev, *cur, *temp;
	prev = cur = *head;
    3ed0:	8b 45 08             	mov    0x8(%ebp),%eax
    3ed3:	8b 00                	mov    (%eax),%eax
    3ed5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3ed8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3edb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (cur != 0)
    3ede:	e9 bb 00 00 00       	jmp    3f9e <deleteClickable+0xd4>
	{
		if (isIn(cur->area.start, region))
    3ee3:	8b 45 0c             	mov    0xc(%ebp),%eax
    3ee6:	89 44 24 08          	mov    %eax,0x8(%esp)
    3eea:	8b 45 10             	mov    0x10(%ebp),%eax
    3eed:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3ef1:	8b 45 14             	mov    0x14(%ebp),%eax
    3ef4:	89 44 24 10          	mov    %eax,0x10(%esp)
    3ef8:	8b 45 18             	mov    0x18(%ebp),%eax
    3efb:	89 44 24 14          	mov    %eax,0x14(%esp)
    3eff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3f02:	8b 50 04             	mov    0x4(%eax),%edx
    3f05:	8b 00                	mov    (%eax),%eax
    3f07:	89 04 24             	mov    %eax,(%esp)
    3f0a:	89 54 24 04          	mov    %edx,0x4(%esp)
    3f0e:	e8 0f fe ff ff       	call   3d22 <isIn>
    3f13:	85 c0                	test   %eax,%eax
    3f15:	74 60                	je     3f77 <deleteClickable+0xad>
		{
			//如果当前指针指向头部
			if (cur == *head)
    3f17:	8b 45 08             	mov    0x8(%ebp),%eax
    3f1a:	8b 00                	mov    (%eax),%eax
    3f1c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    3f1f:	75 2e                	jne    3f4f <deleteClickable+0x85>
			{
				//删除头节点
				temp = *head;
    3f21:	8b 45 08             	mov    0x8(%ebp),%eax
    3f24:	8b 00                	mov    (%eax),%eax
    3f26:	89 45 ec             	mov    %eax,-0x14(%ebp)
				*head = cur->next;
    3f29:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3f2c:	8b 50 14             	mov    0x14(%eax),%edx
    3f2f:	8b 45 08             	mov    0x8(%ebp),%eax
    3f32:	89 10                	mov    %edx,(%eax)
				cur = prev = *head;
    3f34:	8b 45 08             	mov    0x8(%ebp),%eax
    3f37:	8b 00                	mov    (%eax),%eax
    3f39:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3f3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3f3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
				free(temp);
    3f42:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3f45:	89 04 24             	mov    %eax,(%esp)
    3f48:	e8 6c 0a 00 00       	call   49b9 <free>
    3f4d:	eb 4f                	jmp    3f9e <deleteClickable+0xd4>
			}
			else
			{
				//删除当前节点
				prev->next = cur->next;
    3f4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3f52:	8b 50 14             	mov    0x14(%eax),%edx
    3f55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3f58:	89 50 14             	mov    %edx,0x14(%eax)
				temp = cur;
    3f5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3f5e:	89 45 ec             	mov    %eax,-0x14(%ebp)
				cur = cur->next;
    3f61:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3f64:	8b 40 14             	mov    0x14(%eax),%eax
    3f67:	89 45 f0             	mov    %eax,-0x10(%ebp)
				free(temp);
    3f6a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3f6d:	89 04 24             	mov    %eax,(%esp)
    3f70:	e8 44 0a 00 00       	call   49b9 <free>
    3f75:	eb 27                	jmp    3f9e <deleteClickable+0xd4>
			}
		}
		else
		{
			//如果当前节点是头节点，
			if (cur == *head)
    3f77:	8b 45 08             	mov    0x8(%ebp),%eax
    3f7a:	8b 00                	mov    (%eax),%eax
    3f7c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    3f7f:	75 0b                	jne    3f8c <deleteClickable+0xc2>
			{
				cur = cur->next;
    3f81:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3f84:	8b 40 14             	mov    0x14(%eax),%eax
    3f87:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3f8a:	eb 12                	jmp    3f9e <deleteClickable+0xd4>
			}
			else
			{
				cur = cur->next;
    3f8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3f8f:	8b 40 14             	mov    0x14(%eax),%eax
    3f92:	89 45 f0             	mov    %eax,-0x10(%ebp)
				prev = prev->next;
    3f95:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3f98:	8b 40 14             	mov    0x14(%eax),%eax
    3f9b:	89 45 f4             	mov    %eax,-0xc(%ebp)

void deleteClickable(Clickable **head, Rect region)
{
	Clickable *prev, *cur, *temp;
	prev = cur = *head;
	while (cur != 0)
    3f9e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3fa2:	0f 85 3b ff ff ff    	jne    3ee3 <deleteClickable+0x19>
				cur = cur->next;
				prev = prev->next;
			}
		}
	}
}
    3fa8:	c9                   	leave  
    3fa9:	c3                   	ret    

00003faa <executeHandler>:

int executeHandler(Clickable *head, Point click)
{
    3faa:	55                   	push   %ebp
    3fab:	89 e5                	mov    %esp,%ebp
    3fad:	83 ec 38             	sub    $0x38,%esp
	Clickable *cur = head;
    3fb0:	8b 45 08             	mov    0x8(%ebp),%eax
    3fb3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (cur != 0)
    3fb6:	eb 6d                	jmp    4025 <executeHandler+0x7b>
	{
		if (isIn(click, cur->area))
    3fb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3fbb:	8b 10                	mov    (%eax),%edx
    3fbd:	89 54 24 08          	mov    %edx,0x8(%esp)
    3fc1:	8b 50 04             	mov    0x4(%eax),%edx
    3fc4:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3fc8:	8b 50 08             	mov    0x8(%eax),%edx
    3fcb:	89 54 24 10          	mov    %edx,0x10(%esp)
    3fcf:	8b 40 0c             	mov    0xc(%eax),%eax
    3fd2:	89 44 24 14          	mov    %eax,0x14(%esp)
    3fd6:	8b 45 0c             	mov    0xc(%ebp),%eax
    3fd9:	8b 55 10             	mov    0x10(%ebp),%edx
    3fdc:	89 04 24             	mov    %eax,(%esp)
    3fdf:	89 54 24 04          	mov    %edx,0x4(%esp)
    3fe3:	e8 3a fd ff ff       	call   3d22 <isIn>
    3fe8:	85 c0                	test   %eax,%eax
    3fea:	74 30                	je     401c <executeHandler+0x72>
		{
			renaming = 0;
    3fec:	c7 05 e4 fc 02 00 00 	movl   $0x0,0x2fce4
    3ff3:	00 00 00 
			isSearching = 0;
    3ff6:	c7 05 e0 fc 02 00 00 	movl   $0x0,0x2fce0
    3ffd:	00 00 00 
			cur->handler(click);
    4000:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4003:	8b 48 10             	mov    0x10(%eax),%ecx
    4006:	8b 45 0c             	mov    0xc(%ebp),%eax
    4009:	8b 55 10             	mov    0x10(%ebp),%edx
    400c:	89 04 24             	mov    %eax,(%esp)
    400f:	89 54 24 04          	mov    %edx,0x4(%esp)
    4013:	ff d1                	call   *%ecx
			return 1;
    4015:	b8 01 00 00 00       	mov    $0x1,%eax
    401a:	eb 4d                	jmp    4069 <executeHandler+0xbf>
		}
		cur = cur->next;
    401c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    401f:	8b 40 14             	mov    0x14(%eax),%eax
    4022:	89 45 f4             	mov    %eax,-0xc(%ebp)
}

int executeHandler(Clickable *head, Point click)
{
	Clickable *cur = head;
	while (cur != 0)
    4025:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4029:	75 8d                	jne    3fb8 <executeHandler+0xe>
			cur->handler(click);
			return 1;
		}
		cur = cur->next;
	}
	isSearching = 0;
    402b:	c7 05 e0 fc 02 00 00 	movl   $0x0,0x2fce0
    4032:	00 00 00 
	if (renaming == 1){
    4035:	a1 e4 fc 02 00       	mov    0x2fce4,%eax
    403a:	83 f8 01             	cmp    $0x1,%eax
    403d:	75 11                	jne    4050 <executeHandler+0xa6>
		renaming = 0;
    403f:	c7 05 e4 fc 02 00 00 	movl   $0x0,0x2fce4
    4046:	00 00 00 
		return 1;
    4049:	b8 01 00 00 00       	mov    $0x1,%eax
    404e:	eb 19                	jmp    4069 <executeHandler+0xbf>
	}
	printf(0, "execute: none!\n");
    4050:	c7 44 24 04 ae b2 00 	movl   $0xb2ae,0x4(%esp)
    4057:	00 
    4058:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    405f:	e8 a2 07 00 00       	call   4806 <printf>
	return 0;
    4064:	b8 00 00 00 00       	mov    $0x0,%eax
}
    4069:	c9                   	leave  
    406a:	c3                   	ret    

0000406b <printClickable>:

void printClickable(Clickable *c)
{
    406b:	55                   	push   %ebp
    406c:	89 e5                	mov    %esp,%ebp
    406e:	53                   	push   %ebx
    406f:	83 ec 24             	sub    $0x24,%esp
	printf(0, "(%d, %d, %d, %d)\n", c->area.start.x, c->area.start.y, c->area.width, c->area.height);
    4072:	8b 45 08             	mov    0x8(%ebp),%eax
    4075:	8b 58 0c             	mov    0xc(%eax),%ebx
    4078:	8b 45 08             	mov    0x8(%ebp),%eax
    407b:	8b 48 08             	mov    0x8(%eax),%ecx
    407e:	8b 45 08             	mov    0x8(%ebp),%eax
    4081:	8b 50 04             	mov    0x4(%eax),%edx
    4084:	8b 45 08             	mov    0x8(%ebp),%eax
    4087:	8b 00                	mov    (%eax),%eax
    4089:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    408d:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    4091:	89 54 24 0c          	mov    %edx,0xc(%esp)
    4095:	89 44 24 08          	mov    %eax,0x8(%esp)
    4099:	c7 44 24 04 be b2 00 	movl   $0xb2be,0x4(%esp)
    40a0:	00 
    40a1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    40a8:	e8 59 07 00 00       	call   4806 <printf>
}
    40ad:	83 c4 24             	add    $0x24,%esp
    40b0:	5b                   	pop    %ebx
    40b1:	5d                   	pop    %ebp
    40b2:	c3                   	ret    

000040b3 <printClickableList>:

void printClickableList(Clickable *head)
{
    40b3:	55                   	push   %ebp
    40b4:	89 e5                	mov    %esp,%ebp
    40b6:	83 ec 28             	sub    $0x28,%esp
	Clickable *cur = head;
    40b9:	8b 45 08             	mov    0x8(%ebp),%eax
    40bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(0, "Clickable List:\n");
    40bf:	c7 44 24 04 d0 b2 00 	movl   $0xb2d0,0x4(%esp)
    40c6:	00 
    40c7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    40ce:	e8 33 07 00 00       	call   4806 <printf>
	while(cur != 0)
    40d3:	eb 14                	jmp    40e9 <printClickableList+0x36>
	{
		printClickable(cur);
    40d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40d8:	89 04 24             	mov    %eax,(%esp)
    40db:	e8 8b ff ff ff       	call   406b <printClickable>
		cur = cur->next;
    40e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40e3:	8b 40 14             	mov    0x14(%eax),%eax
    40e6:	89 45 f4             	mov    %eax,-0xc(%ebp)

void printClickableList(Clickable *head)
{
	Clickable *cur = head;
	printf(0, "Clickable List:\n");
	while(cur != 0)
    40e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    40ed:	75 e6                	jne    40d5 <printClickableList+0x22>
	{
		printClickable(cur);
		cur = cur->next;
	}
	printf(0, "\n");
    40ef:	c7 44 24 04 e1 b2 00 	movl   $0xb2e1,0x4(%esp)
    40f6:	00 
    40f7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    40fe:	e8 03 07 00 00       	call   4806 <printf>
}
    4103:	c9                   	leave  
    4104:	c3                   	ret    

00004105 <testHanler>:

void testHanler(struct Point p)
{
    4105:	55                   	push   %ebp
    4106:	89 e5                	mov    %esp,%ebp
    4108:	83 ec 18             	sub    $0x18,%esp
	printf(0, "execute: (%d, %d)!\n", p.x, p.y);
    410b:	8b 55 0c             	mov    0xc(%ebp),%edx
    410e:	8b 45 08             	mov    0x8(%ebp),%eax
    4111:	89 54 24 0c          	mov    %edx,0xc(%esp)
    4115:	89 44 24 08          	mov    %eax,0x8(%esp)
    4119:	c7 44 24 04 e3 b2 00 	movl   $0xb2e3,0x4(%esp)
    4120:	00 
    4121:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4128:	e8 d9 06 00 00       	call   4806 <printf>
}
    412d:	c9                   	leave  
    412e:	c3                   	ret    

0000412f <testClickable>:
void testClickable(struct Context c)
{
    412f:	55                   	push   %ebp
    4130:	89 e5                	mov    %esp,%ebp
    4132:	81 ec 98 00 00 00    	sub    $0x98,%esp
	ClickableManager cm = initClickManager(c);
    4138:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    413b:	8b 55 08             	mov    0x8(%ebp),%edx
    413e:	89 54 24 04          	mov    %edx,0x4(%esp)
    4142:	8b 55 0c             	mov    0xc(%ebp),%edx
    4145:	89 54 24 08          	mov    %edx,0x8(%esp)
    4149:	8b 55 10             	mov    0x10(%ebp),%edx
    414c:	89 54 24 0c          	mov    %edx,0xc(%esp)
    4150:	89 04 24             	mov    %eax,(%esp)
    4153:	e8 0d fc ff ff       	call   3d65 <initClickManager>
    4158:	83 ec 04             	sub    $0x4,%esp

	Rect r1 = initRect(5,5,20,20);
    415b:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    415e:	c7 44 24 10 14 00 00 	movl   $0x14,0x10(%esp)
    4165:	00 
    4166:	c7 44 24 0c 14 00 00 	movl   $0x14,0xc(%esp)
    416d:	00 
    416e:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    4175:	00 
    4176:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    417d:	00 
    417e:	89 04 24             	mov    %eax,(%esp)
    4181:	e8 41 fb ff ff       	call   3cc7 <initRect>
    4186:	83 ec 04             	sub    $0x4,%esp
	Rect r2 = initRect(20,20,20,20);
    4189:	8d 45 c4             	lea    -0x3c(%ebp),%eax
    418c:	c7 44 24 10 14 00 00 	movl   $0x14,0x10(%esp)
    4193:	00 
    4194:	c7 44 24 0c 14 00 00 	movl   $0x14,0xc(%esp)
    419b:	00 
    419c:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
    41a3:	00 
    41a4:	c7 44 24 04 14 00 00 	movl   $0x14,0x4(%esp)
    41ab:	00 
    41ac:	89 04 24             	mov    %eax,(%esp)
    41af:	e8 13 fb ff ff       	call   3cc7 <initRect>
    41b4:	83 ec 04             	sub    $0x4,%esp
	Rect r3 = initRect(50,50,15,15);
    41b7:	8d 45 b4             	lea    -0x4c(%ebp),%eax
    41ba:	c7 44 24 10 0f 00 00 	movl   $0xf,0x10(%esp)
    41c1:	00 
    41c2:	c7 44 24 0c 0f 00 00 	movl   $0xf,0xc(%esp)
    41c9:	00 
    41ca:	c7 44 24 08 32 00 00 	movl   $0x32,0x8(%esp)
    41d1:	00 
    41d2:	c7 44 24 04 32 00 00 	movl   $0x32,0x4(%esp)
    41d9:	00 
    41da:	89 04 24             	mov    %eax,(%esp)
    41dd:	e8 e5 fa ff ff       	call   3cc7 <initRect>
    41e2:	83 ec 04             	sub    $0x4,%esp
	Rect r4 = initRect(0,0,30,30);
    41e5:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    41e8:	c7 44 24 10 1e 00 00 	movl   $0x1e,0x10(%esp)
    41ef:	00 
    41f0:	c7 44 24 0c 1e 00 00 	movl   $0x1e,0xc(%esp)
    41f7:	00 
    41f8:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    41ff:	00 
    4200:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    4207:	00 
    4208:	89 04 24             	mov    %eax,(%esp)
    420b:	e8 b7 fa ff ff       	call   3cc7 <initRect>
    4210:	83 ec 04             	sub    $0x4,%esp
	Point p1 = initPoint(23, 23);
    4213:	8d 45 9c             	lea    -0x64(%ebp),%eax
    4216:	c7 44 24 08 17 00 00 	movl   $0x17,0x8(%esp)
    421d:	00 
    421e:	c7 44 24 04 17 00 00 	movl   $0x17,0x4(%esp)
    4225:	00 
    4226:	89 04 24             	mov    %eax,(%esp)
    4229:	e8 72 fa ff ff       	call   3ca0 <initPoint>
    422e:	83 ec 04             	sub    $0x4,%esp
	Point p2 = initPoint(70, 70);
    4231:	8d 45 94             	lea    -0x6c(%ebp),%eax
    4234:	c7 44 24 08 46 00 00 	movl   $0x46,0x8(%esp)
    423b:	00 
    423c:	c7 44 24 04 46 00 00 	movl   $0x46,0x4(%esp)
    4243:	00 
    4244:	89 04 24             	mov    %eax,(%esp)
    4247:	e8 54 fa ff ff       	call   3ca0 <initPoint>
    424c:	83 ec 04             	sub    $0x4,%esp
	createClickable(&cm, r1, MSG_LPRESS, &testHanler);
    424f:	c7 44 24 18 05 41 00 	movl   $0x4105,0x18(%esp)
    4256:	00 
    4257:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    425e:	00 
    425f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    4262:	89 44 24 04          	mov    %eax,0x4(%esp)
    4266:	8b 45 d8             	mov    -0x28(%ebp),%eax
    4269:	89 44 24 08          	mov    %eax,0x8(%esp)
    426d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    4270:	89 44 24 0c          	mov    %eax,0xc(%esp)
    4274:	8b 45 e0             	mov    -0x20(%ebp),%eax
    4277:	89 44 24 10          	mov    %eax,0x10(%esp)
    427b:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    427e:	89 04 24             	mov    %eax,(%esp)
    4281:	e8 2d fb ff ff       	call   3db3 <createClickable>
	printf(0, "left_click: %d\n", cm.left_click);
    4286:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4289:	89 44 24 08          	mov    %eax,0x8(%esp)
    428d:	c7 44 24 04 f7 b2 00 	movl   $0xb2f7,0x4(%esp)
    4294:	00 
    4295:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    429c:	e8 65 05 00 00       	call   4806 <printf>
	createClickable(&cm, r2, MSG_LPRESS, &testHanler);
    42a1:	c7 44 24 18 05 41 00 	movl   $0x4105,0x18(%esp)
    42a8:	00 
    42a9:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    42b0:	00 
    42b1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    42b4:	89 44 24 04          	mov    %eax,0x4(%esp)
    42b8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    42bb:	89 44 24 08          	mov    %eax,0x8(%esp)
    42bf:	8b 45 cc             	mov    -0x34(%ebp),%eax
    42c2:	89 44 24 0c          	mov    %eax,0xc(%esp)
    42c6:	8b 45 d0             	mov    -0x30(%ebp),%eax
    42c9:	89 44 24 10          	mov    %eax,0x10(%esp)
    42cd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    42d0:	89 04 24             	mov    %eax,(%esp)
    42d3:	e8 db fa ff ff       	call   3db3 <createClickable>
	printf(0, "left_click: %d\n", cm.left_click);
    42d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    42db:	89 44 24 08          	mov    %eax,0x8(%esp)
    42df:	c7 44 24 04 f7 b2 00 	movl   $0xb2f7,0x4(%esp)
    42e6:	00 
    42e7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    42ee:	e8 13 05 00 00       	call   4806 <printf>
	createClickable(&cm, r3, MSG_LPRESS, &testHanler);
    42f3:	c7 44 24 18 05 41 00 	movl   $0x4105,0x18(%esp)
    42fa:	00 
    42fb:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    4302:	00 
    4303:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    4306:	89 44 24 04          	mov    %eax,0x4(%esp)
    430a:	8b 45 b8             	mov    -0x48(%ebp),%eax
    430d:	89 44 24 08          	mov    %eax,0x8(%esp)
    4311:	8b 45 bc             	mov    -0x44(%ebp),%eax
    4314:	89 44 24 0c          	mov    %eax,0xc(%esp)
    4318:	8b 45 c0             	mov    -0x40(%ebp),%eax
    431b:	89 44 24 10          	mov    %eax,0x10(%esp)
    431f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    4322:	89 04 24             	mov    %eax,(%esp)
    4325:	e8 89 fa ff ff       	call   3db3 <createClickable>
	printf(0, "left_click: %d\n", cm.left_click);
    432a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    432d:	89 44 24 08          	mov    %eax,0x8(%esp)
    4331:	c7 44 24 04 f7 b2 00 	movl   $0xb2f7,0x4(%esp)
    4338:	00 
    4339:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4340:	e8 c1 04 00 00       	call   4806 <printf>
	printClickableList(cm.left_click);
    4345:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4348:	89 04 24             	mov    %eax,(%esp)
    434b:	e8 63 fd ff ff       	call   40b3 <printClickableList>
	executeHandler(cm.left_click, p1);
    4350:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    4353:	8b 45 9c             	mov    -0x64(%ebp),%eax
    4356:	8b 55 a0             	mov    -0x60(%ebp),%edx
    4359:	89 44 24 04          	mov    %eax,0x4(%esp)
    435d:	89 54 24 08          	mov    %edx,0x8(%esp)
    4361:	89 0c 24             	mov    %ecx,(%esp)
    4364:	e8 41 fc ff ff       	call   3faa <executeHandler>
	executeHandler(cm.left_click, p2);
    4369:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    436c:	8b 45 94             	mov    -0x6c(%ebp),%eax
    436f:	8b 55 98             	mov    -0x68(%ebp),%edx
    4372:	89 44 24 04          	mov    %eax,0x4(%esp)
    4376:	89 54 24 08          	mov    %edx,0x8(%esp)
    437a:	89 0c 24             	mov    %ecx,(%esp)
    437d:	e8 28 fc ff ff       	call   3faa <executeHandler>
	deleteClickable(&cm.left_click, r4);
    4382:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    4385:	89 44 24 04          	mov    %eax,0x4(%esp)
    4389:	8b 45 a8             	mov    -0x58(%ebp),%eax
    438c:	89 44 24 08          	mov    %eax,0x8(%esp)
    4390:	8b 45 ac             	mov    -0x54(%ebp),%eax
    4393:	89 44 24 0c          	mov    %eax,0xc(%esp)
    4397:	8b 45 b0             	mov    -0x50(%ebp),%eax
    439a:	89 44 24 10          	mov    %eax,0x10(%esp)
    439e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    43a1:	89 04 24             	mov    %eax,(%esp)
    43a4:	e8 21 fb ff ff       	call   3eca <deleteClickable>
	printClickableList(cm.left_click);
    43a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    43ac:	89 04 24             	mov    %eax,(%esp)
    43af:	e8 ff fc ff ff       	call   40b3 <printClickableList>
}
    43b4:	c9                   	leave  
    43b5:	c3                   	ret    

000043b6 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    43b6:	55                   	push   %ebp
    43b7:	89 e5                	mov    %esp,%ebp
    43b9:	57                   	push   %edi
    43ba:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    43bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
    43be:	8b 55 10             	mov    0x10(%ebp),%edx
    43c1:	8b 45 0c             	mov    0xc(%ebp),%eax
    43c4:	89 cb                	mov    %ecx,%ebx
    43c6:	89 df                	mov    %ebx,%edi
    43c8:	89 d1                	mov    %edx,%ecx
    43ca:	fc                   	cld    
    43cb:	f3 aa                	rep stos %al,%es:(%edi)
    43cd:	89 ca                	mov    %ecx,%edx
    43cf:	89 fb                	mov    %edi,%ebx
    43d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
    43d4:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    43d7:	5b                   	pop    %ebx
    43d8:	5f                   	pop    %edi
    43d9:	5d                   	pop    %ebp
    43da:	c3                   	ret    

000043db <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    43db:	55                   	push   %ebp
    43dc:	89 e5                	mov    %esp,%ebp
    43de:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    43e1:	8b 45 08             	mov    0x8(%ebp),%eax
    43e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    43e7:	90                   	nop
    43e8:	8b 45 08             	mov    0x8(%ebp),%eax
    43eb:	8d 50 01             	lea    0x1(%eax),%edx
    43ee:	89 55 08             	mov    %edx,0x8(%ebp)
    43f1:	8b 55 0c             	mov    0xc(%ebp),%edx
    43f4:	8d 4a 01             	lea    0x1(%edx),%ecx
    43f7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    43fa:	0f b6 12             	movzbl (%edx),%edx
    43fd:	88 10                	mov    %dl,(%eax)
    43ff:	0f b6 00             	movzbl (%eax),%eax
    4402:	84 c0                	test   %al,%al
    4404:	75 e2                	jne    43e8 <strcpy+0xd>
    ;
  return os;
    4406:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    4409:	c9                   	leave  
    440a:	c3                   	ret    

0000440b <strcmp>:

int
strcmp(const char *p, const char *q)
{
    440b:	55                   	push   %ebp
    440c:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    440e:	eb 08                	jmp    4418 <strcmp+0xd>
    p++, q++;
    4410:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    4414:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    4418:	8b 45 08             	mov    0x8(%ebp),%eax
    441b:	0f b6 00             	movzbl (%eax),%eax
    441e:	84 c0                	test   %al,%al
    4420:	74 10                	je     4432 <strcmp+0x27>
    4422:	8b 45 08             	mov    0x8(%ebp),%eax
    4425:	0f b6 10             	movzbl (%eax),%edx
    4428:	8b 45 0c             	mov    0xc(%ebp),%eax
    442b:	0f b6 00             	movzbl (%eax),%eax
    442e:	38 c2                	cmp    %al,%dl
    4430:	74 de                	je     4410 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    4432:	8b 45 08             	mov    0x8(%ebp),%eax
    4435:	0f b6 00             	movzbl (%eax),%eax
    4438:	0f b6 d0             	movzbl %al,%edx
    443b:	8b 45 0c             	mov    0xc(%ebp),%eax
    443e:	0f b6 00             	movzbl (%eax),%eax
    4441:	0f b6 c0             	movzbl %al,%eax
    4444:	29 c2                	sub    %eax,%edx
    4446:	89 d0                	mov    %edx,%eax
}
    4448:	5d                   	pop    %ebp
    4449:	c3                   	ret    

0000444a <strlen>:

uint
strlen(char *s)
{
    444a:	55                   	push   %ebp
    444b:	89 e5                	mov    %esp,%ebp
    444d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    4450:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    4457:	eb 04                	jmp    445d <strlen+0x13>
    4459:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    445d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    4460:	8b 45 08             	mov    0x8(%ebp),%eax
    4463:	01 d0                	add    %edx,%eax
    4465:	0f b6 00             	movzbl (%eax),%eax
    4468:	84 c0                	test   %al,%al
    446a:	75 ed                	jne    4459 <strlen+0xf>
    ;
  return n;
    446c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    446f:	c9                   	leave  
    4470:	c3                   	ret    

00004471 <memset>:

void*
memset(void *dst, int c, uint n)
{
    4471:	55                   	push   %ebp
    4472:	89 e5                	mov    %esp,%ebp
    4474:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    4477:	8b 45 10             	mov    0x10(%ebp),%eax
    447a:	89 44 24 08          	mov    %eax,0x8(%esp)
    447e:	8b 45 0c             	mov    0xc(%ebp),%eax
    4481:	89 44 24 04          	mov    %eax,0x4(%esp)
    4485:	8b 45 08             	mov    0x8(%ebp),%eax
    4488:	89 04 24             	mov    %eax,(%esp)
    448b:	e8 26 ff ff ff       	call   43b6 <stosb>
  return dst;
    4490:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4493:	c9                   	leave  
    4494:	c3                   	ret    

00004495 <strchr>:

char*
strchr(const char *s, char c)
{
    4495:	55                   	push   %ebp
    4496:	89 e5                	mov    %esp,%ebp
    4498:	83 ec 04             	sub    $0x4,%esp
    449b:	8b 45 0c             	mov    0xc(%ebp),%eax
    449e:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    44a1:	eb 14                	jmp    44b7 <strchr+0x22>
    if(*s == c)
    44a3:	8b 45 08             	mov    0x8(%ebp),%eax
    44a6:	0f b6 00             	movzbl (%eax),%eax
    44a9:	3a 45 fc             	cmp    -0x4(%ebp),%al
    44ac:	75 05                	jne    44b3 <strchr+0x1e>
      return (char*)s;
    44ae:	8b 45 08             	mov    0x8(%ebp),%eax
    44b1:	eb 13                	jmp    44c6 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    44b3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    44b7:	8b 45 08             	mov    0x8(%ebp),%eax
    44ba:	0f b6 00             	movzbl (%eax),%eax
    44bd:	84 c0                	test   %al,%al
    44bf:	75 e2                	jne    44a3 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    44c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
    44c6:	c9                   	leave  
    44c7:	c3                   	ret    

000044c8 <gets>:

char*
gets(char *buf, int max)
{
    44c8:	55                   	push   %ebp
    44c9:	89 e5                	mov    %esp,%ebp
    44cb:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    44ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    44d5:	eb 4c                	jmp    4523 <gets+0x5b>
    cc = read(0, &c, 1);
    44d7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    44de:	00 
    44df:	8d 45 ef             	lea    -0x11(%ebp),%eax
    44e2:	89 44 24 04          	mov    %eax,0x4(%esp)
    44e6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    44ed:	e8 44 01 00 00       	call   4636 <read>
    44f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    44f5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    44f9:	7f 02                	jg     44fd <gets+0x35>
      break;
    44fb:	eb 31                	jmp    452e <gets+0x66>
    buf[i++] = c;
    44fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4500:	8d 50 01             	lea    0x1(%eax),%edx
    4503:	89 55 f4             	mov    %edx,-0xc(%ebp)
    4506:	89 c2                	mov    %eax,%edx
    4508:	8b 45 08             	mov    0x8(%ebp),%eax
    450b:	01 c2                	add    %eax,%edx
    450d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    4511:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    4513:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    4517:	3c 0a                	cmp    $0xa,%al
    4519:	74 13                	je     452e <gets+0x66>
    451b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    451f:	3c 0d                	cmp    $0xd,%al
    4521:	74 0b                	je     452e <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    4523:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4526:	83 c0 01             	add    $0x1,%eax
    4529:	3b 45 0c             	cmp    0xc(%ebp),%eax
    452c:	7c a9                	jl     44d7 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    452e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    4531:	8b 45 08             	mov    0x8(%ebp),%eax
    4534:	01 d0                	add    %edx,%eax
    4536:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    4539:	8b 45 08             	mov    0x8(%ebp),%eax
}
    453c:	c9                   	leave  
    453d:	c3                   	ret    

0000453e <stat>:

int
stat(char *n, struct stat *st)
{
    453e:	55                   	push   %ebp
    453f:	89 e5                	mov    %esp,%ebp
    4541:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4544:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    454b:	00 
    454c:	8b 45 08             	mov    0x8(%ebp),%eax
    454f:	89 04 24             	mov    %eax,(%esp)
    4552:	e8 07 01 00 00       	call   465e <open>
    4557:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    455a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    455e:	79 07                	jns    4567 <stat+0x29>
    return -1;
    4560:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    4565:	eb 23                	jmp    458a <stat+0x4c>
  r = fstat(fd, st);
    4567:	8b 45 0c             	mov    0xc(%ebp),%eax
    456a:	89 44 24 04          	mov    %eax,0x4(%esp)
    456e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4571:	89 04 24             	mov    %eax,(%esp)
    4574:	e8 fd 00 00 00       	call   4676 <fstat>
    4579:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    457c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    457f:	89 04 24             	mov    %eax,(%esp)
    4582:	e8 bf 00 00 00       	call   4646 <close>
  return r;
    4587:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    458a:	c9                   	leave  
    458b:	c3                   	ret    

0000458c <atoi>:

int
atoi(const char *s)
{
    458c:	55                   	push   %ebp
    458d:	89 e5                	mov    %esp,%ebp
    458f:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    4592:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    4599:	eb 25                	jmp    45c0 <atoi+0x34>
    n = n*10 + *s++ - '0';
    459b:	8b 55 fc             	mov    -0x4(%ebp),%edx
    459e:	89 d0                	mov    %edx,%eax
    45a0:	c1 e0 02             	shl    $0x2,%eax
    45a3:	01 d0                	add    %edx,%eax
    45a5:	01 c0                	add    %eax,%eax
    45a7:	89 c1                	mov    %eax,%ecx
    45a9:	8b 45 08             	mov    0x8(%ebp),%eax
    45ac:	8d 50 01             	lea    0x1(%eax),%edx
    45af:	89 55 08             	mov    %edx,0x8(%ebp)
    45b2:	0f b6 00             	movzbl (%eax),%eax
    45b5:	0f be c0             	movsbl %al,%eax
    45b8:	01 c8                	add    %ecx,%eax
    45ba:	83 e8 30             	sub    $0x30,%eax
    45bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    45c0:	8b 45 08             	mov    0x8(%ebp),%eax
    45c3:	0f b6 00             	movzbl (%eax),%eax
    45c6:	3c 2f                	cmp    $0x2f,%al
    45c8:	7e 0a                	jle    45d4 <atoi+0x48>
    45ca:	8b 45 08             	mov    0x8(%ebp),%eax
    45cd:	0f b6 00             	movzbl (%eax),%eax
    45d0:	3c 39                	cmp    $0x39,%al
    45d2:	7e c7                	jle    459b <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    45d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    45d7:	c9                   	leave  
    45d8:	c3                   	ret    

000045d9 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    45d9:	55                   	push   %ebp
    45da:	89 e5                	mov    %esp,%ebp
    45dc:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    45df:	8b 45 08             	mov    0x8(%ebp),%eax
    45e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    45e5:	8b 45 0c             	mov    0xc(%ebp),%eax
    45e8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    45eb:	eb 17                	jmp    4604 <memmove+0x2b>
    *dst++ = *src++;
    45ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    45f0:	8d 50 01             	lea    0x1(%eax),%edx
    45f3:	89 55 fc             	mov    %edx,-0x4(%ebp)
    45f6:	8b 55 f8             	mov    -0x8(%ebp),%edx
    45f9:	8d 4a 01             	lea    0x1(%edx),%ecx
    45fc:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    45ff:	0f b6 12             	movzbl (%edx),%edx
    4602:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    4604:	8b 45 10             	mov    0x10(%ebp),%eax
    4607:	8d 50 ff             	lea    -0x1(%eax),%edx
    460a:	89 55 10             	mov    %edx,0x10(%ebp)
    460d:	85 c0                	test   %eax,%eax
    460f:	7f dc                	jg     45ed <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    4611:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4614:	c9                   	leave  
    4615:	c3                   	ret    

00004616 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    4616:	b8 01 00 00 00       	mov    $0x1,%eax
    461b:	cd 40                	int    $0x40
    461d:	c3                   	ret    

0000461e <exit>:
SYSCALL(exit)
    461e:	b8 02 00 00 00       	mov    $0x2,%eax
    4623:	cd 40                	int    $0x40
    4625:	c3                   	ret    

00004626 <wait>:
SYSCALL(wait)
    4626:	b8 03 00 00 00       	mov    $0x3,%eax
    462b:	cd 40                	int    $0x40
    462d:	c3                   	ret    

0000462e <pipe>:
SYSCALL(pipe)
    462e:	b8 04 00 00 00       	mov    $0x4,%eax
    4633:	cd 40                	int    $0x40
    4635:	c3                   	ret    

00004636 <read>:
SYSCALL(read)
    4636:	b8 05 00 00 00       	mov    $0x5,%eax
    463b:	cd 40                	int    $0x40
    463d:	c3                   	ret    

0000463e <write>:
SYSCALL(write)
    463e:	b8 10 00 00 00       	mov    $0x10,%eax
    4643:	cd 40                	int    $0x40
    4645:	c3                   	ret    

00004646 <close>:
SYSCALL(close)
    4646:	b8 15 00 00 00       	mov    $0x15,%eax
    464b:	cd 40                	int    $0x40
    464d:	c3                   	ret    

0000464e <kill>:
SYSCALL(kill)
    464e:	b8 06 00 00 00       	mov    $0x6,%eax
    4653:	cd 40                	int    $0x40
    4655:	c3                   	ret    

00004656 <exec>:
SYSCALL(exec)
    4656:	b8 07 00 00 00       	mov    $0x7,%eax
    465b:	cd 40                	int    $0x40
    465d:	c3                   	ret    

0000465e <open>:
SYSCALL(open)
    465e:	b8 0f 00 00 00       	mov    $0xf,%eax
    4663:	cd 40                	int    $0x40
    4665:	c3                   	ret    

00004666 <mknod>:
SYSCALL(mknod)
    4666:	b8 11 00 00 00       	mov    $0x11,%eax
    466b:	cd 40                	int    $0x40
    466d:	c3                   	ret    

0000466e <unlink>:
SYSCALL(unlink)
    466e:	b8 12 00 00 00       	mov    $0x12,%eax
    4673:	cd 40                	int    $0x40
    4675:	c3                   	ret    

00004676 <fstat>:
SYSCALL(fstat)
    4676:	b8 08 00 00 00       	mov    $0x8,%eax
    467b:	cd 40                	int    $0x40
    467d:	c3                   	ret    

0000467e <link>:
SYSCALL(link)
    467e:	b8 13 00 00 00       	mov    $0x13,%eax
    4683:	cd 40                	int    $0x40
    4685:	c3                   	ret    

00004686 <mkdir>:
SYSCALL(mkdir)
    4686:	b8 14 00 00 00       	mov    $0x14,%eax
    468b:	cd 40                	int    $0x40
    468d:	c3                   	ret    

0000468e <chdir>:
SYSCALL(chdir)
    468e:	b8 09 00 00 00       	mov    $0x9,%eax
    4693:	cd 40                	int    $0x40
    4695:	c3                   	ret    

00004696 <dup>:
SYSCALL(dup)
    4696:	b8 0a 00 00 00       	mov    $0xa,%eax
    469b:	cd 40                	int    $0x40
    469d:	c3                   	ret    

0000469e <getpid>:
SYSCALL(getpid)
    469e:	b8 0b 00 00 00       	mov    $0xb,%eax
    46a3:	cd 40                	int    $0x40
    46a5:	c3                   	ret    

000046a6 <sbrk>:
SYSCALL(sbrk)
    46a6:	b8 0c 00 00 00       	mov    $0xc,%eax
    46ab:	cd 40                	int    $0x40
    46ad:	c3                   	ret    

000046ae <sleep>:
SYSCALL(sleep)
    46ae:	b8 0d 00 00 00       	mov    $0xd,%eax
    46b3:	cd 40                	int    $0x40
    46b5:	c3                   	ret    

000046b6 <uptime>:
SYSCALL(uptime)
    46b6:	b8 0e 00 00 00       	mov    $0xe,%eax
    46bb:	cd 40                	int    $0x40
    46bd:	c3                   	ret    

000046be <getMsg>:
SYSCALL(getMsg)
    46be:	b8 16 00 00 00       	mov    $0x16,%eax
    46c3:	cd 40                	int    $0x40
    46c5:	c3                   	ret    

000046c6 <createWindow>:
SYSCALL(createWindow)
    46c6:	b8 17 00 00 00       	mov    $0x17,%eax
    46cb:	cd 40                	int    $0x40
    46cd:	c3                   	ret    

000046ce <destroyWindow>:
SYSCALL(destroyWindow)
    46ce:	b8 18 00 00 00       	mov    $0x18,%eax
    46d3:	cd 40                	int    $0x40
    46d5:	c3                   	ret    

000046d6 <updateWindow>:
SYSCALL(updateWindow)
    46d6:	b8 19 00 00 00       	mov    $0x19,%eax
    46db:	cd 40                	int    $0x40
    46dd:	c3                   	ret    

000046de <updatePartialWindow>:
SYSCALL(updatePartialWindow)
    46de:	b8 1a 00 00 00       	mov    $0x1a,%eax
    46e3:	cd 40                	int    $0x40
    46e5:	c3                   	ret    

000046e6 <kwrite>:
SYSCALL(kwrite)
    46e6:	b8 1c 00 00 00       	mov    $0x1c,%eax
    46eb:	cd 40                	int    $0x40
    46ed:	c3                   	ret    

000046ee <setSampleRate>:
SYSCALL(setSampleRate)
    46ee:	b8 1b 00 00 00       	mov    $0x1b,%eax
    46f3:	cd 40                	int    $0x40
    46f5:	c3                   	ret    

000046f6 <pause>:
SYSCALL(pause)
    46f6:	b8 1d 00 00 00       	mov    $0x1d,%eax
    46fb:	cd 40                	int    $0x40
    46fd:	c3                   	ret    

000046fe <wavdecode>:
SYSCALL(wavdecode)
    46fe:	b8 1e 00 00 00       	mov    $0x1e,%eax
    4703:	cd 40                	int    $0x40
    4705:	c3                   	ret    

00004706 <beginDecode>:
SYSCALL(beginDecode)
    4706:	b8 1f 00 00 00       	mov    $0x1f,%eax
    470b:	cd 40                	int    $0x40
    470d:	c3                   	ret    

0000470e <waitForDecode>:
SYSCALL(waitForDecode)
    470e:	b8 20 00 00 00       	mov    $0x20,%eax
    4713:	cd 40                	int    $0x40
    4715:	c3                   	ret    

00004716 <endDecode>:
SYSCALL(endDecode)
    4716:	b8 21 00 00 00       	mov    $0x21,%eax
    471b:	cd 40                	int    $0x40
    471d:	c3                   	ret    

0000471e <getCoreBuf>:
    471e:	b8 22 00 00 00       	mov    $0x22,%eax
    4723:	cd 40                	int    $0x40
    4725:	c3                   	ret    

00004726 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    4726:	55                   	push   %ebp
    4727:	89 e5                	mov    %esp,%ebp
    4729:	83 ec 18             	sub    $0x18,%esp
    472c:	8b 45 0c             	mov    0xc(%ebp),%eax
    472f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    4732:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    4739:	00 
    473a:	8d 45 f4             	lea    -0xc(%ebp),%eax
    473d:	89 44 24 04          	mov    %eax,0x4(%esp)
    4741:	8b 45 08             	mov    0x8(%ebp),%eax
    4744:	89 04 24             	mov    %eax,(%esp)
    4747:	e8 f2 fe ff ff       	call   463e <write>
}
    474c:	c9                   	leave  
    474d:	c3                   	ret    

0000474e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    474e:	55                   	push   %ebp
    474f:	89 e5                	mov    %esp,%ebp
    4751:	56                   	push   %esi
    4752:	53                   	push   %ebx
    4753:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    4756:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    475d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    4761:	74 17                	je     477a <printint+0x2c>
    4763:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    4767:	79 11                	jns    477a <printint+0x2c>
    neg = 1;
    4769:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    4770:	8b 45 0c             	mov    0xc(%ebp),%eax
    4773:	f7 d8                	neg    %eax
    4775:	89 45 ec             	mov    %eax,-0x14(%ebp)
    4778:	eb 06                	jmp    4780 <printint+0x32>
  } else {
    x = xx;
    477a:	8b 45 0c             	mov    0xc(%ebp),%eax
    477d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    4780:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    4787:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    478a:	8d 41 01             	lea    0x1(%ecx),%eax
    478d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4790:	8b 5d 10             	mov    0x10(%ebp),%ebx
    4793:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4796:	ba 00 00 00 00       	mov    $0x0,%edx
    479b:	f7 f3                	div    %ebx
    479d:	89 d0                	mov    %edx,%eax
    479f:	0f b6 80 94 ea 00 00 	movzbl 0xea94(%eax),%eax
    47a6:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    47aa:	8b 75 10             	mov    0x10(%ebp),%esi
    47ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
    47b0:	ba 00 00 00 00       	mov    $0x0,%edx
    47b5:	f7 f6                	div    %esi
    47b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    47ba:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    47be:	75 c7                	jne    4787 <printint+0x39>
  if(neg)
    47c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    47c4:	74 10                	je     47d6 <printint+0x88>
    buf[i++] = '-';
    47c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47c9:	8d 50 01             	lea    0x1(%eax),%edx
    47cc:	89 55 f4             	mov    %edx,-0xc(%ebp)
    47cf:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    47d4:	eb 1f                	jmp    47f5 <printint+0xa7>
    47d6:	eb 1d                	jmp    47f5 <printint+0xa7>
    putc(fd, buf[i]);
    47d8:	8d 55 dc             	lea    -0x24(%ebp),%edx
    47db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47de:	01 d0                	add    %edx,%eax
    47e0:	0f b6 00             	movzbl (%eax),%eax
    47e3:	0f be c0             	movsbl %al,%eax
    47e6:	89 44 24 04          	mov    %eax,0x4(%esp)
    47ea:	8b 45 08             	mov    0x8(%ebp),%eax
    47ed:	89 04 24             	mov    %eax,(%esp)
    47f0:	e8 31 ff ff ff       	call   4726 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    47f5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    47f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    47fd:	79 d9                	jns    47d8 <printint+0x8a>
    putc(fd, buf[i]);
}
    47ff:	83 c4 30             	add    $0x30,%esp
    4802:	5b                   	pop    %ebx
    4803:	5e                   	pop    %esi
    4804:	5d                   	pop    %ebp
    4805:	c3                   	ret    

00004806 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    4806:	55                   	push   %ebp
    4807:	89 e5                	mov    %esp,%ebp
    4809:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    480c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    4813:	8d 45 0c             	lea    0xc(%ebp),%eax
    4816:	83 c0 04             	add    $0x4,%eax
    4819:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    481c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    4823:	e9 7c 01 00 00       	jmp    49a4 <printf+0x19e>
    c = fmt[i] & 0xff;
    4828:	8b 55 0c             	mov    0xc(%ebp),%edx
    482b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    482e:	01 d0                	add    %edx,%eax
    4830:	0f b6 00             	movzbl (%eax),%eax
    4833:	0f be c0             	movsbl %al,%eax
    4836:	25 ff 00 00 00       	and    $0xff,%eax
    483b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    483e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4842:	75 2c                	jne    4870 <printf+0x6a>
      if(c == '%'){
    4844:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4848:	75 0c                	jne    4856 <printf+0x50>
        state = '%';
    484a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    4851:	e9 4a 01 00 00       	jmp    49a0 <printf+0x19a>
      } else {
        putc(fd, c);
    4856:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4859:	0f be c0             	movsbl %al,%eax
    485c:	89 44 24 04          	mov    %eax,0x4(%esp)
    4860:	8b 45 08             	mov    0x8(%ebp),%eax
    4863:	89 04 24             	mov    %eax,(%esp)
    4866:	e8 bb fe ff ff       	call   4726 <putc>
    486b:	e9 30 01 00 00       	jmp    49a0 <printf+0x19a>
      }
    } else if(state == '%'){
    4870:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    4874:	0f 85 26 01 00 00    	jne    49a0 <printf+0x19a>
      if(c == 'd'){
    487a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    487e:	75 2d                	jne    48ad <printf+0xa7>
        printint(fd, *ap, 10, 1);
    4880:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4883:	8b 00                	mov    (%eax),%eax
    4885:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    488c:	00 
    488d:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    4894:	00 
    4895:	89 44 24 04          	mov    %eax,0x4(%esp)
    4899:	8b 45 08             	mov    0x8(%ebp),%eax
    489c:	89 04 24             	mov    %eax,(%esp)
    489f:	e8 aa fe ff ff       	call   474e <printint>
        ap++;
    48a4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    48a8:	e9 ec 00 00 00       	jmp    4999 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    48ad:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    48b1:	74 06                	je     48b9 <printf+0xb3>
    48b3:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    48b7:	75 2d                	jne    48e6 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    48b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    48bc:	8b 00                	mov    (%eax),%eax
    48be:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    48c5:	00 
    48c6:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    48cd:	00 
    48ce:	89 44 24 04          	mov    %eax,0x4(%esp)
    48d2:	8b 45 08             	mov    0x8(%ebp),%eax
    48d5:	89 04 24             	mov    %eax,(%esp)
    48d8:	e8 71 fe ff ff       	call   474e <printint>
        ap++;
    48dd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    48e1:	e9 b3 00 00 00       	jmp    4999 <printf+0x193>
      } else if(c == 's'){
    48e6:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    48ea:	75 45                	jne    4931 <printf+0x12b>
        s = (char*)*ap;
    48ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
    48ef:	8b 00                	mov    (%eax),%eax
    48f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    48f4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    48f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    48fc:	75 09                	jne    4907 <printf+0x101>
          s = "(null)";
    48fe:	c7 45 f4 07 b3 00 00 	movl   $0xb307,-0xc(%ebp)
        while(*s != 0){
    4905:	eb 1e                	jmp    4925 <printf+0x11f>
    4907:	eb 1c                	jmp    4925 <printf+0x11f>
          putc(fd, *s);
    4909:	8b 45 f4             	mov    -0xc(%ebp),%eax
    490c:	0f b6 00             	movzbl (%eax),%eax
    490f:	0f be c0             	movsbl %al,%eax
    4912:	89 44 24 04          	mov    %eax,0x4(%esp)
    4916:	8b 45 08             	mov    0x8(%ebp),%eax
    4919:	89 04 24             	mov    %eax,(%esp)
    491c:	e8 05 fe ff ff       	call   4726 <putc>
          s++;
    4921:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    4925:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4928:	0f b6 00             	movzbl (%eax),%eax
    492b:	84 c0                	test   %al,%al
    492d:	75 da                	jne    4909 <printf+0x103>
    492f:	eb 68                	jmp    4999 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    4931:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    4935:	75 1d                	jne    4954 <printf+0x14e>
        putc(fd, *ap);
    4937:	8b 45 e8             	mov    -0x18(%ebp),%eax
    493a:	8b 00                	mov    (%eax),%eax
    493c:	0f be c0             	movsbl %al,%eax
    493f:	89 44 24 04          	mov    %eax,0x4(%esp)
    4943:	8b 45 08             	mov    0x8(%ebp),%eax
    4946:	89 04 24             	mov    %eax,(%esp)
    4949:	e8 d8 fd ff ff       	call   4726 <putc>
        ap++;
    494e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4952:	eb 45                	jmp    4999 <printf+0x193>
      } else if(c == '%'){
    4954:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4958:	75 17                	jne    4971 <printf+0x16b>
        putc(fd, c);
    495a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    495d:	0f be c0             	movsbl %al,%eax
    4960:	89 44 24 04          	mov    %eax,0x4(%esp)
    4964:	8b 45 08             	mov    0x8(%ebp),%eax
    4967:	89 04 24             	mov    %eax,(%esp)
    496a:	e8 b7 fd ff ff       	call   4726 <putc>
    496f:	eb 28                	jmp    4999 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    4971:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    4978:	00 
    4979:	8b 45 08             	mov    0x8(%ebp),%eax
    497c:	89 04 24             	mov    %eax,(%esp)
    497f:	e8 a2 fd ff ff       	call   4726 <putc>
        putc(fd, c);
    4984:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4987:	0f be c0             	movsbl %al,%eax
    498a:	89 44 24 04          	mov    %eax,0x4(%esp)
    498e:	8b 45 08             	mov    0x8(%ebp),%eax
    4991:	89 04 24             	mov    %eax,(%esp)
    4994:	e8 8d fd ff ff       	call   4726 <putc>
      }
      state = 0;
    4999:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    49a0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    49a4:	8b 55 0c             	mov    0xc(%ebp),%edx
    49a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    49aa:	01 d0                	add    %edx,%eax
    49ac:	0f b6 00             	movzbl (%eax),%eax
    49af:	84 c0                	test   %al,%al
    49b1:	0f 85 71 fe ff ff    	jne    4828 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    49b7:	c9                   	leave  
    49b8:	c3                   	ret    

000049b9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    49b9:	55                   	push   %ebp
    49ba:	89 e5                	mov    %esp,%ebp
    49bc:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    49bf:	8b 45 08             	mov    0x8(%ebp),%eax
    49c2:	83 e8 08             	sub    $0x8,%eax
    49c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    49c8:	a1 c8 ef 00 00       	mov    0xefc8,%eax
    49cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
    49d0:	eb 24                	jmp    49f6 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    49d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    49d5:	8b 00                	mov    (%eax),%eax
    49d7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    49da:	77 12                	ja     49ee <free+0x35>
    49dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    49df:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    49e2:	77 24                	ja     4a08 <free+0x4f>
    49e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    49e7:	8b 00                	mov    (%eax),%eax
    49e9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    49ec:	77 1a                	ja     4a08 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    49ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
    49f1:	8b 00                	mov    (%eax),%eax
    49f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    49f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    49f9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    49fc:	76 d4                	jbe    49d2 <free+0x19>
    49fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a01:	8b 00                	mov    (%eax),%eax
    4a03:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4a06:	76 ca                	jbe    49d2 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    4a08:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4a0b:	8b 40 04             	mov    0x4(%eax),%eax
    4a0e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    4a15:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4a18:	01 c2                	add    %eax,%edx
    4a1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a1d:	8b 00                	mov    (%eax),%eax
    4a1f:	39 c2                	cmp    %eax,%edx
    4a21:	75 24                	jne    4a47 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    4a23:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4a26:	8b 50 04             	mov    0x4(%eax),%edx
    4a29:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a2c:	8b 00                	mov    (%eax),%eax
    4a2e:	8b 40 04             	mov    0x4(%eax),%eax
    4a31:	01 c2                	add    %eax,%edx
    4a33:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4a36:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    4a39:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a3c:	8b 00                	mov    (%eax),%eax
    4a3e:	8b 10                	mov    (%eax),%edx
    4a40:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4a43:	89 10                	mov    %edx,(%eax)
    4a45:	eb 0a                	jmp    4a51 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    4a47:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a4a:	8b 10                	mov    (%eax),%edx
    4a4c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4a4f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    4a51:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a54:	8b 40 04             	mov    0x4(%eax),%eax
    4a57:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    4a5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a61:	01 d0                	add    %edx,%eax
    4a63:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4a66:	75 20                	jne    4a88 <free+0xcf>
    p->s.size += bp->s.size;
    4a68:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a6b:	8b 50 04             	mov    0x4(%eax),%edx
    4a6e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4a71:	8b 40 04             	mov    0x4(%eax),%eax
    4a74:	01 c2                	add    %eax,%edx
    4a76:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a79:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    4a7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4a7f:	8b 10                	mov    (%eax),%edx
    4a81:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a84:	89 10                	mov    %edx,(%eax)
    4a86:	eb 08                	jmp    4a90 <free+0xd7>
  } else
    p->s.ptr = bp;
    4a88:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a8b:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4a8e:	89 10                	mov    %edx,(%eax)
  freep = p;
    4a90:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a93:	a3 c8 ef 00 00       	mov    %eax,0xefc8
}
    4a98:	c9                   	leave  
    4a99:	c3                   	ret    

00004a9a <morecore>:

static Header*
morecore(uint nu)
{
    4a9a:	55                   	push   %ebp
    4a9b:	89 e5                	mov    %esp,%ebp
    4a9d:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    4aa0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    4aa7:	77 07                	ja     4ab0 <morecore+0x16>
    nu = 4096;
    4aa9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    4ab0:	8b 45 08             	mov    0x8(%ebp),%eax
    4ab3:	c1 e0 03             	shl    $0x3,%eax
    4ab6:	89 04 24             	mov    %eax,(%esp)
    4ab9:	e8 e8 fb ff ff       	call   46a6 <sbrk>
    4abe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    4ac1:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    4ac5:	75 07                	jne    4ace <morecore+0x34>
    return 0;
    4ac7:	b8 00 00 00 00       	mov    $0x0,%eax
    4acc:	eb 22                	jmp    4af0 <morecore+0x56>
  hp = (Header*)p;
    4ace:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4ad1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    4ad4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4ad7:	8b 55 08             	mov    0x8(%ebp),%edx
    4ada:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    4add:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4ae0:	83 c0 08             	add    $0x8,%eax
    4ae3:	89 04 24             	mov    %eax,(%esp)
    4ae6:	e8 ce fe ff ff       	call   49b9 <free>
  return freep;
    4aeb:	a1 c8 ef 00 00       	mov    0xefc8,%eax
}
    4af0:	c9                   	leave  
    4af1:	c3                   	ret    

00004af2 <malloc>:

void*
malloc(uint nbytes)
{
    4af2:	55                   	push   %ebp
    4af3:	89 e5                	mov    %esp,%ebp
    4af5:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4af8:	8b 45 08             	mov    0x8(%ebp),%eax
    4afb:	83 c0 07             	add    $0x7,%eax
    4afe:	c1 e8 03             	shr    $0x3,%eax
    4b01:	83 c0 01             	add    $0x1,%eax
    4b04:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    4b07:	a1 c8 ef 00 00       	mov    0xefc8,%eax
    4b0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4b0f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4b13:	75 23                	jne    4b38 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    4b15:	c7 45 f0 c0 ef 00 00 	movl   $0xefc0,-0x10(%ebp)
    4b1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4b1f:	a3 c8 ef 00 00       	mov    %eax,0xefc8
    4b24:	a1 c8 ef 00 00       	mov    0xefc8,%eax
    4b29:	a3 c0 ef 00 00       	mov    %eax,0xefc0
    base.s.size = 0;
    4b2e:	c7 05 c4 ef 00 00 00 	movl   $0x0,0xefc4
    4b35:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4b38:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4b3b:	8b 00                	mov    (%eax),%eax
    4b3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4b40:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4b43:	8b 40 04             	mov    0x4(%eax),%eax
    4b46:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4b49:	72 4d                	jb     4b98 <malloc+0xa6>
      if(p->s.size == nunits)
    4b4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4b4e:	8b 40 04             	mov    0x4(%eax),%eax
    4b51:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4b54:	75 0c                	jne    4b62 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    4b56:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4b59:	8b 10                	mov    (%eax),%edx
    4b5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4b5e:	89 10                	mov    %edx,(%eax)
    4b60:	eb 26                	jmp    4b88 <malloc+0x96>
      else {
        p->s.size -= nunits;
    4b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4b65:	8b 40 04             	mov    0x4(%eax),%eax
    4b68:	2b 45 ec             	sub    -0x14(%ebp),%eax
    4b6b:	89 c2                	mov    %eax,%edx
    4b6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4b70:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    4b73:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4b76:	8b 40 04             	mov    0x4(%eax),%eax
    4b79:	c1 e0 03             	shl    $0x3,%eax
    4b7c:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    4b7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4b82:	8b 55 ec             	mov    -0x14(%ebp),%edx
    4b85:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    4b88:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4b8b:	a3 c8 ef 00 00       	mov    %eax,0xefc8
      return (void*)(p + 1);
    4b90:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4b93:	83 c0 08             	add    $0x8,%eax
    4b96:	eb 38                	jmp    4bd0 <malloc+0xde>
    }
    if(p == freep)
    4b98:	a1 c8 ef 00 00       	mov    0xefc8,%eax
    4b9d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    4ba0:	75 1b                	jne    4bbd <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    4ba2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4ba5:	89 04 24             	mov    %eax,(%esp)
    4ba8:	e8 ed fe ff ff       	call   4a9a <morecore>
    4bad:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4bb0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4bb4:	75 07                	jne    4bbd <malloc+0xcb>
        return 0;
    4bb6:	b8 00 00 00 00       	mov    $0x0,%eax
    4bbb:	eb 13                	jmp    4bd0 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4bbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4bc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4bc6:	8b 00                	mov    (%eax),%eax
    4bc8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    4bcb:	e9 70 ff ff ff       	jmp    4b40 <malloc+0x4e>
}
    4bd0:	c9                   	leave  
    4bd1:	c3                   	ret    

00004bd2 <abs>:
#include "math.h"
#define pi 3.1415926535898 
int abs(int x)
{
    4bd2:	55                   	push   %ebp
    4bd3:	89 e5                	mov    %esp,%ebp
	if (x < 0)
    4bd5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    4bd9:	79 07                	jns    4be2 <abs+0x10>
		return x * -1;
    4bdb:	8b 45 08             	mov    0x8(%ebp),%eax
    4bde:	f7 d8                	neg    %eax
    4be0:	eb 03                	jmp    4be5 <abs+0x13>
	else
		return x;
    4be2:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4be5:	5d                   	pop    %ebp
    4be6:	c3                   	ret    

00004be7 <sin>:
double sin(double x)  
{  
    4be7:	55                   	push   %ebp
    4be8:	89 e5                	mov    %esp,%ebp
    4bea:	83 ec 3c             	sub    $0x3c,%esp
    4bed:	8b 45 08             	mov    0x8(%ebp),%eax
    4bf0:	89 45 c8             	mov    %eax,-0x38(%ebp)
    4bf3:	8b 45 0c             	mov    0xc(%ebp),%eax
    4bf6:	89 45 cc             	mov    %eax,-0x34(%ebp)
	double Result=x,Fac=1.0,Xn=x,Precious=x;  
    4bf9:	dd 45 c8             	fldl   -0x38(%ebp)
    4bfc:	dd 5d f8             	fstpl  -0x8(%ebp)
    4bff:	d9 e8                	fld1   
    4c01:	dd 5d f0             	fstpl  -0x10(%ebp)
    4c04:	dd 45 c8             	fldl   -0x38(%ebp)
    4c07:	dd 5d e8             	fstpl  -0x18(%ebp)
    4c0a:	dd 45 c8             	fldl   -0x38(%ebp)
    4c0d:	dd 5d e0             	fstpl  -0x20(%ebp)
	int n=1,sign=1;  
    4c10:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
    4c17:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
	while(Precious>1e-6)  
    4c1e:	eb 50                	jmp    4c70 <sin+0x89>
	{  
		n = n+1;  
    4c20:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
		Fac=Fac*n*(n + 1);
    4c24:	db 45 dc             	fildl  -0x24(%ebp)
    4c27:	dc 4d f0             	fmull  -0x10(%ebp)
    4c2a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    4c2d:	83 c0 01             	add    $0x1,%eax
    4c30:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    4c33:	db 45 c4             	fildl  -0x3c(%ebp)
    4c36:	de c9                	fmulp  %st,%st(1)
    4c38:	dd 5d f0             	fstpl  -0x10(%ebp)
		n = n + 1;  
    4c3b:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
		Xn*=x*x;  
    4c3f:	dd 45 c8             	fldl   -0x38(%ebp)
    4c42:	dc 4d c8             	fmull  -0x38(%ebp)
    4c45:	dd 45 e8             	fldl   -0x18(%ebp)
    4c48:	de c9                	fmulp  %st,%st(1)
    4c4a:	dd 5d e8             	fstpl  -0x18(%ebp)
		sign=-sign;  
    4c4d:	f7 5d d8             	negl   -0x28(%ebp)
		Precious=Xn/Fac;  
    4c50:	dd 45 e8             	fldl   -0x18(%ebp)
    4c53:	dc 75 f0             	fdivl  -0x10(%ebp)
    4c56:	dd 5d e0             	fstpl  -0x20(%ebp)
		Result=sign>0?Result+Precious:Result-Precious;  
    4c59:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    4c5d:	7e 08                	jle    4c67 <sin+0x80>
    4c5f:	dd 45 f8             	fldl   -0x8(%ebp)
    4c62:	dc 45 e0             	faddl  -0x20(%ebp)
    4c65:	eb 06                	jmp    4c6d <sin+0x86>
    4c67:	dd 45 f8             	fldl   -0x8(%ebp)
    4c6a:	dc 65 e0             	fsubl  -0x20(%ebp)
    4c6d:	dd 5d f8             	fstpl  -0x8(%ebp)
}
double sin(double x)  
{  
	double Result=x,Fac=1.0,Xn=x,Precious=x;  
	int n=1,sign=1;  
	while(Precious>1e-6)  
    4c70:	dd 45 e0             	fldl   -0x20(%ebp)
    4c73:	dd 05 10 b3 00 00    	fldl   0xb310
    4c79:	d9 c9                	fxch   %st(1)
    4c7b:	df e9                	fucomip %st(1),%st
    4c7d:	dd d8                	fstp   %st(0)
    4c7f:	77 9f                	ja     4c20 <sin+0x39>
		Xn*=x*x;  
		sign=-sign;  
		Precious=Xn/Fac;  
		Result=sign>0?Result+Precious:Result-Precious;  
	}  
	return Result;  
    4c81:	dd 45 f8             	fldl   -0x8(%ebp)
}  
    4c84:	c9                   	leave  
    4c85:	c3                   	ret    

00004c86 <cos>:
double cos(double x)  
{  
    4c86:	55                   	push   %ebp
    4c87:	89 e5                	mov    %esp,%ebp
    4c89:	83 ec 10             	sub    $0x10,%esp
    4c8c:	8b 45 08             	mov    0x8(%ebp),%eax
    4c8f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    4c92:	8b 45 0c             	mov    0xc(%ebp),%eax
    4c95:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return sin(pi/2-x);  
    4c98:	dd 05 18 b3 00 00    	fldl   0xb318
    4c9e:	dc 65 f8             	fsubl  -0x8(%ebp)
    4ca1:	dd 1c 24             	fstpl  (%esp)
    4ca4:	e8 3e ff ff ff       	call   4be7 <sin>
}  
    4ca9:	c9                   	leave  
    4caa:	c3                   	ret    

00004cab <tan>:
double tan(double x)  
{  
    4cab:	55                   	push   %ebp
    4cac:	89 e5                	mov    %esp,%ebp
    4cae:	83 ec 18             	sub    $0x18,%esp
    4cb1:	8b 45 08             	mov    0x8(%ebp),%eax
    4cb4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    4cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
    4cba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return sin(x)/cos(x);  
    4cbd:	dd 45 f8             	fldl   -0x8(%ebp)
    4cc0:	dd 1c 24             	fstpl  (%esp)
    4cc3:	e8 1f ff ff ff       	call   4be7 <sin>
    4cc8:	dd 5d f0             	fstpl  -0x10(%ebp)
    4ccb:	dd 45 f8             	fldl   -0x8(%ebp)
    4cce:	dd 1c 24             	fstpl  (%esp)
    4cd1:	e8 b0 ff ff ff       	call   4c86 <cos>
    4cd6:	dc 7d f0             	fdivrl -0x10(%ebp)
}  
    4cd9:	c9                   	leave  
    4cda:	c3                   	ret    

00004cdb <pow>:

double pow(double x, double y)
{
    4cdb:	55                   	push   %ebp
    4cdc:	89 e5                	mov    %esp,%ebp
    4cde:	83 ec 48             	sub    $0x48,%esp
    4ce1:	8b 45 08             	mov    0x8(%ebp),%eax
    4ce4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    4ce7:	8b 45 0c             	mov    0xc(%ebp),%eax
    4cea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    4ced:	8b 45 10             	mov    0x10(%ebp),%eax
    4cf0:	89 45 d8             	mov    %eax,-0x28(%ebp)
    4cf3:	8b 45 14             	mov    0x14(%ebp),%eax
    4cf6:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if(x==0 && y!=0) return 0;
    4cf9:	dd 45 e0             	fldl   -0x20(%ebp)
    4cfc:	d9 ee                	fldz   
    4cfe:	df e9                	fucomip %st(1),%st
    4d00:	dd d8                	fstp   %st(0)
    4d02:	7a 28                	jp     4d2c <pow+0x51>
    4d04:	dd 45 e0             	fldl   -0x20(%ebp)
    4d07:	d9 ee                	fldz   
    4d09:	df e9                	fucomip %st(1),%st
    4d0b:	dd d8                	fstp   %st(0)
    4d0d:	75 1d                	jne    4d2c <pow+0x51>
    4d0f:	dd 45 d8             	fldl   -0x28(%ebp)
    4d12:	d9 ee                	fldz   
    4d14:	df e9                	fucomip %st(1),%st
    4d16:	dd d8                	fstp   %st(0)
    4d18:	7a 0b                	jp     4d25 <pow+0x4a>
    4d1a:	dd 45 d8             	fldl   -0x28(%ebp)
    4d1d:	d9 ee                	fldz   
    4d1f:	df e9                	fucomip %st(1),%st
    4d21:	dd d8                	fstp   %st(0)
    4d23:	74 07                	je     4d2c <pow+0x51>
    4d25:	d9 ee                	fldz   
    4d27:	e9 30 01 00 00       	jmp    4e5c <pow+0x181>
	else if(x==0 && y==0) return 1;
    4d2c:	dd 45 e0             	fldl   -0x20(%ebp)
    4d2f:	d9 ee                	fldz   
    4d31:	df e9                	fucomip %st(1),%st
    4d33:	dd d8                	fstp   %st(0)
    4d35:	7a 28                	jp     4d5f <pow+0x84>
    4d37:	dd 45 e0             	fldl   -0x20(%ebp)
    4d3a:	d9 ee                	fldz   
    4d3c:	df e9                	fucomip %st(1),%st
    4d3e:	dd d8                	fstp   %st(0)
    4d40:	75 1d                	jne    4d5f <pow+0x84>
    4d42:	dd 45 d8             	fldl   -0x28(%ebp)
    4d45:	d9 ee                	fldz   
    4d47:	df e9                	fucomip %st(1),%st
    4d49:	dd d8                	fstp   %st(0)
    4d4b:	7a 12                	jp     4d5f <pow+0x84>
    4d4d:	dd 45 d8             	fldl   -0x28(%ebp)
    4d50:	d9 ee                	fldz   
    4d52:	df e9                	fucomip %st(1),%st
    4d54:	dd d8                	fstp   %st(0)
    4d56:	75 07                	jne    4d5f <pow+0x84>
    4d58:	d9 e8                	fld1   
    4d5a:	e9 fd 00 00 00       	jmp    4e5c <pow+0x181>
	else if(y<0) return 1/pow(x,-y);//把指数小于0的情况转为1/x^-y计算
    4d5f:	d9 ee                	fldz   
    4d61:	dd 45 d8             	fldl   -0x28(%ebp)
    4d64:	d9 c9                	fxch   %st(1)
    4d66:	df e9                	fucomip %st(1),%st
    4d68:	dd d8                	fstp   %st(0)
    4d6a:	76 1d                	jbe    4d89 <pow+0xae>
    4d6c:	dd 45 d8             	fldl   -0x28(%ebp)
    4d6f:	d9 e0                	fchs   
    4d71:	dd 5c 24 08          	fstpl  0x8(%esp)
    4d75:	dd 45 e0             	fldl   -0x20(%ebp)
    4d78:	dd 1c 24             	fstpl  (%esp)
    4d7b:	e8 5b ff ff ff       	call   4cdb <pow>
    4d80:	d9 e8                	fld1   
    4d82:	de f1                	fdivp  %st,%st(1)
    4d84:	e9 d3 00 00 00       	jmp    4e5c <pow+0x181>
	else if(x<0 && y-(int)y!=0) return 0;//若x为负，且y不为整数数，则出错，返回0  
    4d89:	d9 ee                	fldz   
    4d8b:	dd 45 e0             	fldl   -0x20(%ebp)
    4d8e:	d9 c9                	fxch   %st(1)
    4d90:	df e9                	fucomip %st(1),%st
    4d92:	dd d8                	fstp   %st(0)
    4d94:	76 40                	jbe    4dd6 <pow+0xfb>
    4d96:	dd 45 d8             	fldl   -0x28(%ebp)
    4d99:	d9 7d d6             	fnstcw -0x2a(%ebp)
    4d9c:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    4da0:	b4 0c                	mov    $0xc,%ah
    4da2:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    4da6:	d9 6d d4             	fldcw  -0x2c(%ebp)
    4da9:	db 5d d0             	fistpl -0x30(%ebp)
    4dac:	d9 6d d6             	fldcw  -0x2a(%ebp)
    4daf:	8b 45 d0             	mov    -0x30(%ebp),%eax
    4db2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    4db5:	db 45 d0             	fildl  -0x30(%ebp)
    4db8:	dd 45 d8             	fldl   -0x28(%ebp)
    4dbb:	de e1                	fsubp  %st,%st(1)
    4dbd:	d9 ee                	fldz   
    4dbf:	df e9                	fucomip %st(1),%st
    4dc1:	7a 0a                	jp     4dcd <pow+0xf2>
    4dc3:	d9 ee                	fldz   
    4dc5:	df e9                	fucomip %st(1),%st
    4dc7:	dd d8                	fstp   %st(0)
    4dc9:	74 0b                	je     4dd6 <pow+0xfb>
    4dcb:	eb 02                	jmp    4dcf <pow+0xf4>
    4dcd:	dd d8                	fstp   %st(0)
    4dcf:	d9 ee                	fldz   
    4dd1:	e9 86 00 00 00       	jmp    4e5c <pow+0x181>
	else if(x<0 && y-(int)y==0)//若x为负，且y为整数数，则用循环计算 
    4dd6:	d9 ee                	fldz   
    4dd8:	dd 45 e0             	fldl   -0x20(%ebp)
    4ddb:	d9 c9                	fxch   %st(1)
    4ddd:	df e9                	fucomip %st(1),%st
    4ddf:	dd d8                	fstp   %st(0)
    4de1:	76 63                	jbe    4e46 <pow+0x16b>
    4de3:	dd 45 d8             	fldl   -0x28(%ebp)
    4de6:	d9 7d d6             	fnstcw -0x2a(%ebp)
    4de9:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    4ded:	b4 0c                	mov    $0xc,%ah
    4def:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    4df3:	d9 6d d4             	fldcw  -0x2c(%ebp)
    4df6:	db 5d d0             	fistpl -0x30(%ebp)
    4df9:	d9 6d d6             	fldcw  -0x2a(%ebp)
    4dfc:	8b 45 d0             	mov    -0x30(%ebp),%eax
    4dff:	89 45 d0             	mov    %eax,-0x30(%ebp)
    4e02:	db 45 d0             	fildl  -0x30(%ebp)
    4e05:	dd 45 d8             	fldl   -0x28(%ebp)
    4e08:	de e1                	fsubp  %st,%st(1)
    4e0a:	d9 ee                	fldz   
    4e0c:	df e9                	fucomip %st(1),%st
    4e0e:	7a 34                	jp     4e44 <pow+0x169>
    4e10:	d9 ee                	fldz   
    4e12:	df e9                	fucomip %st(1),%st
    4e14:	dd d8                	fstp   %st(0)
    4e16:	75 2e                	jne    4e46 <pow+0x16b>
	{
		double powint=1;
    4e18:	d9 e8                	fld1   
    4e1a:	dd 5d f0             	fstpl  -0x10(%ebp)
		int i;
		for(i=1;i<=y;i++) powint*=x;
    4e1d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    4e24:	eb 0d                	jmp    4e33 <pow+0x158>
    4e26:	dd 45 f0             	fldl   -0x10(%ebp)
    4e29:	dc 4d e0             	fmull  -0x20(%ebp)
    4e2c:	dd 5d f0             	fstpl  -0x10(%ebp)
    4e2f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    4e33:	db 45 ec             	fildl  -0x14(%ebp)
    4e36:	dd 45 d8             	fldl   -0x28(%ebp)
    4e39:	df e9                	fucomip %st(1),%st
    4e3b:	dd d8                	fstp   %st(0)
    4e3d:	73 e7                	jae    4e26 <pow+0x14b>
		return powint;
    4e3f:	dd 45 f0             	fldl   -0x10(%ebp)
    4e42:	eb 18                	jmp    4e5c <pow+0x181>
    4e44:	dd d8                	fstp   %st(0)
	}
	return exp(y*ln(x));
    4e46:	dd 45 e0             	fldl   -0x20(%ebp)
    4e49:	dd 1c 24             	fstpl  (%esp)
    4e4c:	e8 36 00 00 00       	call   4e87 <ln>
    4e51:	dc 4d d8             	fmull  -0x28(%ebp)
    4e54:	dd 1c 24             	fstpl  (%esp)
    4e57:	e8 0e 02 00 00       	call   506a <exp>
}
    4e5c:	c9                   	leave  
    4e5d:	c3                   	ret    

00004e5e <sqrt>:
// 求根
double sqrt(double x)
{
    4e5e:	55                   	push   %ebp
    4e5f:	89 e5                	mov    %esp,%ebp
    4e61:	83 ec 28             	sub    $0x28,%esp
    4e64:	8b 45 08             	mov    0x8(%ebp),%eax
    4e67:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4e6a:	8b 45 0c             	mov    0xc(%ebp),%eax
    4e6d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	return pow(x,0.5);
    4e70:	dd 05 20 b3 00 00    	fldl   0xb320
    4e76:	dd 5c 24 08          	fstpl  0x8(%esp)
    4e7a:	dd 45 f0             	fldl   -0x10(%ebp)
    4e7d:	dd 1c 24             	fstpl  (%esp)
    4e80:	e8 56 fe ff ff       	call   4cdb <pow>
}
    4e85:	c9                   	leave  
    4e86:	c3                   	ret    

00004e87 <ln>:

// ln(x) = 2 arctanh((x-1)/(x+1))
// 调用了Arctanh(double) 方法
double ln(double x)
{
    4e87:	55                   	push   %ebp
    4e88:	89 e5                	mov    %esp,%ebp
    4e8a:	81 ec 88 00 00 00    	sub    $0x88,%esp
    4e90:	8b 45 08             	mov    0x8(%ebp),%eax
    4e93:	89 45 90             	mov    %eax,-0x70(%ebp)
    4e96:	8b 45 0c             	mov    0xc(%ebp),%eax
    4e99:	89 45 94             	mov    %eax,-0x6c(%ebp)
	double y=x-1,ln_p1=0,ln_p2=0,ln_p3=0,ln_px=0,ln_tmp=1,dln_px=1,tmp;
    4e9c:	dd 45 90             	fldl   -0x70(%ebp)
    4e9f:	d9 e8                	fld1   
    4ea1:	de e9                	fsubrp %st,%st(1)
    4ea3:	dd 5d c0             	fstpl  -0x40(%ebp)
    4ea6:	d9 ee                	fldz   
    4ea8:	dd 5d f0             	fstpl  -0x10(%ebp)
    4eab:	d9 ee                	fldz   
    4ead:	dd 5d b8             	fstpl  -0x48(%ebp)
    4eb0:	d9 ee                	fldz   
    4eb2:	dd 5d b0             	fstpl  -0x50(%ebp)
    4eb5:	d9 ee                	fldz   
    4eb7:	dd 5d e8             	fstpl  -0x18(%ebp)
    4eba:	d9 e8                	fld1   
    4ebc:	dd 5d e0             	fstpl  -0x20(%ebp)
    4ebf:	d9 e8                	fld1   
    4ec1:	dd 5d a8             	fstpl  -0x58(%ebp)
	int l;
	if(x==1) return 0;
    4ec4:	dd 45 90             	fldl   -0x70(%ebp)
    4ec7:	d9 e8                	fld1   
    4ec9:	df e9                	fucomip %st(1),%st
    4ecb:	dd d8                	fstp   %st(0)
    4ecd:	7a 12                	jp     4ee1 <ln+0x5a>
    4ecf:	dd 45 90             	fldl   -0x70(%ebp)
    4ed2:	d9 e8                	fld1   
    4ed4:	df e9                	fucomip %st(1),%st
    4ed6:	dd d8                	fstp   %st(0)
    4ed8:	75 07                	jne    4ee1 <ln+0x5a>
    4eda:	d9 ee                	fldz   
    4edc:	e9 87 01 00 00       	jmp    5068 <ln+0x1e1>
	else if(x>2) return -ln(1/x);
    4ee1:	dd 45 90             	fldl   -0x70(%ebp)
    4ee4:	dd 05 28 b3 00 00    	fldl   0xb328
    4eea:	d9 c9                	fxch   %st(1)
    4eec:	df e9                	fucomip %st(1),%st
    4eee:	dd d8                	fstp   %st(0)
    4ef0:	76 14                	jbe    4f06 <ln+0x7f>
    4ef2:	d9 e8                	fld1   
    4ef4:	dc 75 90             	fdivl  -0x70(%ebp)
    4ef7:	dd 1c 24             	fstpl  (%esp)
    4efa:	e8 88 ff ff ff       	call   4e87 <ln>
    4eff:	d9 e0                	fchs   
    4f01:	e9 62 01 00 00       	jmp    5068 <ln+0x1e1>
	else if(x<.1)
    4f06:	dd 05 30 b3 00 00    	fldl   0xb330
    4f0c:	dd 45 90             	fldl   -0x70(%ebp)
    4f0f:	d9 c9                	fxch   %st(1)
    4f11:	df e9                	fucomip %st(1),%st
    4f13:	dd d8                	fstp   %st(0)
    4f15:	76 59                	jbe    4f70 <ln+0xe9>
	{
		double n=-1;
    4f17:	d9 e8                	fld1   
    4f19:	d9 e0                	fchs   
    4f1b:	dd 5d c8             	fstpl  -0x38(%ebp)
		double a;
		do
		{
			n=n-.6;
    4f1e:	dd 45 c8             	fldl   -0x38(%ebp)
    4f21:	dd 05 38 b3 00 00    	fldl   0xb338
    4f27:	de e9                	fsubrp %st,%st(1)
    4f29:	dd 5d c8             	fstpl  -0x38(%ebp)
			a=x/exp(n);
    4f2c:	dd 45 c8             	fldl   -0x38(%ebp)
    4f2f:	dd 1c 24             	fstpl  (%esp)
    4f32:	e8 33 01 00 00       	call   506a <exp>
    4f37:	dd 45 90             	fldl   -0x70(%ebp)
    4f3a:	de f1                	fdivp  %st,%st(1)
    4f3c:	dd 5d a0             	fstpl  -0x60(%ebp)
		}
		while(a>2 || a<1);
    4f3f:	dd 45 a0             	fldl   -0x60(%ebp)
    4f42:	dd 05 28 b3 00 00    	fldl   0xb328
    4f48:	d9 c9                	fxch   %st(1)
    4f4a:	df e9                	fucomip %st(1),%st
    4f4c:	dd d8                	fstp   %st(0)
    4f4e:	77 ce                	ja     4f1e <ln+0x97>
    4f50:	d9 e8                	fld1   
    4f52:	dd 45 a0             	fldl   -0x60(%ebp)
    4f55:	d9 c9                	fxch   %st(1)
    4f57:	df e9                	fucomip %st(1),%st
    4f59:	dd d8                	fstp   %st(0)
    4f5b:	77 c1                	ja     4f1e <ln+0x97>
		return ln(a)+n;
    4f5d:	dd 45 a0             	fldl   -0x60(%ebp)
    4f60:	dd 1c 24             	fstpl  (%esp)
    4f63:	e8 1f ff ff ff       	call   4e87 <ln>
    4f68:	dc 45 c8             	faddl  -0x38(%ebp)
    4f6b:	e9 f8 00 00 00       	jmp    5068 <ln+0x1e1>
	}
	for(l=1,tmp=1;(ln_px-ln_tmp)>1e-9 || (ln_px-ln_tmp)<-1e-9;l++)
    4f70:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    4f77:	d9 e8                	fld1   
    4f79:	dd 5d d8             	fstpl  -0x28(%ebp)
    4f7c:	e9 b6 00 00 00       	jmp    5037 <ln+0x1b0>
	{
		ln_tmp=ln_px;
    4f81:	dd 45 e8             	fldl   -0x18(%ebp)
    4f84:	dd 5d e0             	fstpl  -0x20(%ebp)
		tmp*=y;
    4f87:	dd 45 d8             	fldl   -0x28(%ebp)
    4f8a:	dc 4d c0             	fmull  -0x40(%ebp)
    4f8d:	dd 5d d8             	fstpl  -0x28(%ebp)
		if(l==1) tmp=tmp/l;
    4f90:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
    4f94:	75 0d                	jne    4fa3 <ln+0x11c>
    4f96:	db 45 d4             	fildl  -0x2c(%ebp)
    4f99:	dd 45 d8             	fldl   -0x28(%ebp)
    4f9c:	de f1                	fdivp  %st,%st(1)
    4f9e:	dd 5d d8             	fstpl  -0x28(%ebp)
    4fa1:	eb 13                	jmp    4fb6 <ln+0x12f>
		else tmp=tmp/-l;
    4fa3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    4fa6:	f7 d8                	neg    %eax
    4fa8:	89 45 8c             	mov    %eax,-0x74(%ebp)
    4fab:	db 45 8c             	fildl  -0x74(%ebp)
    4fae:	dd 45 d8             	fldl   -0x28(%ebp)
    4fb1:	de f1                	fdivp  %st,%st(1)
    4fb3:	dd 5d d8             	fstpl  -0x28(%ebp)
		ln_p1+=tmp;
    4fb6:	dd 45 f0             	fldl   -0x10(%ebp)
    4fb9:	dc 45 d8             	faddl  -0x28(%ebp)
    4fbc:	dd 5d f0             	fstpl  -0x10(%ebp)
		ln_p2=ln_p1+-1*tmp*y*l/(l+1);
    4fbf:	dd 45 d8             	fldl   -0x28(%ebp)
    4fc2:	d9 e0                	fchs   
    4fc4:	dc 4d c0             	fmull  -0x40(%ebp)
    4fc7:	db 45 d4             	fildl  -0x2c(%ebp)
    4fca:	de c9                	fmulp  %st,%st(1)
    4fcc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    4fcf:	83 c0 01             	add    $0x1,%eax
    4fd2:	89 45 8c             	mov    %eax,-0x74(%ebp)
    4fd5:	db 45 8c             	fildl  -0x74(%ebp)
    4fd8:	de f9                	fdivrp %st,%st(1)
    4fda:	dc 45 f0             	faddl  -0x10(%ebp)
    4fdd:	dd 5d b8             	fstpl  -0x48(%ebp)
		ln_p3=ln_p2+tmp*y*y*l/(l+2);
    4fe0:	dd 45 d8             	fldl   -0x28(%ebp)
    4fe3:	dc 4d c0             	fmull  -0x40(%ebp)
    4fe6:	dc 4d c0             	fmull  -0x40(%ebp)
    4fe9:	db 45 d4             	fildl  -0x2c(%ebp)
    4fec:	de c9                	fmulp  %st,%st(1)
    4fee:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    4ff1:	83 c0 02             	add    $0x2,%eax
    4ff4:	89 45 8c             	mov    %eax,-0x74(%ebp)
    4ff7:	db 45 8c             	fildl  -0x74(%ebp)
    4ffa:	de f9                	fdivrp %st,%st(1)
    4ffc:	dc 45 b8             	faddl  -0x48(%ebp)
    4fff:	dd 5d b0             	fstpl  -0x50(%ebp)
		dln_px=ln_p3-ln_p2;
    5002:	dd 45 b0             	fldl   -0x50(%ebp)
    5005:	dc 65 b8             	fsubl  -0x48(%ebp)
    5008:	dd 5d a8             	fstpl  -0x58(%ebp)
		ln_px=ln_p3-dln_px*dln_px/(ln_p3-2*ln_p2+ln_p1);
    500b:	dd 45 a8             	fldl   -0x58(%ebp)
    500e:	dc 4d a8             	fmull  -0x58(%ebp)
    5011:	dd 45 b8             	fldl   -0x48(%ebp)
    5014:	d8 c0                	fadd   %st(0),%st
    5016:	dd 45 b0             	fldl   -0x50(%ebp)
    5019:	de e1                	fsubp  %st,%st(1)
    501b:	dc 45 f0             	faddl  -0x10(%ebp)
    501e:	de f9                	fdivrp %st,%st(1)
    5020:	dd 45 b0             	fldl   -0x50(%ebp)
    5023:	de e1                	fsubp  %st,%st(1)
    5025:	dd 5d e8             	fstpl  -0x18(%ebp)
		tmp*=l;
    5028:	db 45 d4             	fildl  -0x2c(%ebp)
    502b:	dd 45 d8             	fldl   -0x28(%ebp)
    502e:	de c9                	fmulp  %st,%st(1)
    5030:	dd 5d d8             	fstpl  -0x28(%ebp)
			a=x/exp(n);
		}
		while(a>2 || a<1);
		return ln(a)+n;
	}
	for(l=1,tmp=1;(ln_px-ln_tmp)>1e-9 || (ln_px-ln_tmp)<-1e-9;l++)
    5033:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    5037:	dd 45 e8             	fldl   -0x18(%ebp)
    503a:	dc 65 e0             	fsubl  -0x20(%ebp)
    503d:	dd 05 40 b3 00 00    	fldl   0xb340
    5043:	d9 c9                	fxch   %st(1)
    5045:	df e9                	fucomip %st(1),%st
    5047:	dd d8                	fstp   %st(0)
    5049:	0f 87 32 ff ff ff    	ja     4f81 <ln+0xfa>
    504f:	dd 45 e8             	fldl   -0x18(%ebp)
    5052:	dc 65 e0             	fsubl  -0x20(%ebp)
    5055:	dd 05 48 b3 00 00    	fldl   0xb348
    505b:	df e9                	fucomip %st(1),%st
    505d:	dd d8                	fstp   %st(0)
    505f:	0f 87 1c ff ff ff    	ja     4f81 <ln+0xfa>
		ln_p3=ln_p2+tmp*y*y*l/(l+2);
		dln_px=ln_p3-ln_p2;
		ln_px=ln_p3-dln_px*dln_px/(ln_p3-2*ln_p2+ln_p1);
		tmp*=l;
	}
	return ln_px;
    5065:	dd 45 e8             	fldl   -0x18(%ebp)
}
    5068:	c9                   	leave  
    5069:	c3                   	ret    

0000506a <exp>:

// 求e^x 用于Pow( double, double )调用
// e^x = 1+x+(x^2)/2!+(x^3)/3!+...
// 精度为7位
double exp( double x )
{
    506a:	55                   	push   %ebp
    506b:	89 e5                	mov    %esp,%ebp
    506d:	83 ec 78             	sub    $0x78,%esp
    5070:	8b 45 08             	mov    0x8(%ebp),%eax
    5073:	89 45 a0             	mov    %eax,-0x60(%ebp)
    5076:	8b 45 0c             	mov    0xc(%ebp),%eax
    5079:	89 45 a4             	mov    %eax,-0x5c(%ebp)
	double y=x,ex_p1=0,ex_p2=0,ex_p3=0,ex_px=0,ex_tmp=1,dex_px=1,tmp;
    507c:	dd 45 a0             	fldl   -0x60(%ebp)
    507f:	dd 5d c0             	fstpl  -0x40(%ebp)
    5082:	d9 ee                	fldz   
    5084:	dd 5d f0             	fstpl  -0x10(%ebp)
    5087:	d9 ee                	fldz   
    5089:	dd 5d b8             	fstpl  -0x48(%ebp)
    508c:	d9 ee                	fldz   
    508e:	dd 5d b0             	fstpl  -0x50(%ebp)
    5091:	d9 ee                	fldz   
    5093:	dd 5d e8             	fstpl  -0x18(%ebp)
    5096:	d9 e8                	fld1   
    5098:	dd 5d e0             	fstpl  -0x20(%ebp)
    509b:	d9 e8                	fld1   
    509d:	dd 5d d8             	fstpl  -0x28(%ebp)
	int l;
	if(x==0) return 1;
    50a0:	dd 45 a0             	fldl   -0x60(%ebp)
    50a3:	d9 ee                	fldz   
    50a5:	df e9                	fucomip %st(1),%st
    50a7:	dd d8                	fstp   %st(0)
    50a9:	7a 12                	jp     50bd <exp+0x53>
    50ab:	dd 45 a0             	fldl   -0x60(%ebp)
    50ae:	d9 ee                	fldz   
    50b0:	df e9                	fucomip %st(1),%st
    50b2:	dd d8                	fstp   %st(0)
    50b4:	75 07                	jne    50bd <exp+0x53>
    50b6:	d9 e8                	fld1   
    50b8:	e9 08 01 00 00       	jmp    51c5 <exp+0x15b>
	if(x<0) return 1/exp(-x); 
    50bd:	d9 ee                	fldz   
    50bf:	dd 45 a0             	fldl   -0x60(%ebp)
    50c2:	d9 c9                	fxch   %st(1)
    50c4:	df e9                	fucomip %st(1),%st
    50c6:	dd d8                	fstp   %st(0)
    50c8:	76 16                	jbe    50e0 <exp+0x76>
    50ca:	dd 45 a0             	fldl   -0x60(%ebp)
    50cd:	d9 e0                	fchs   
    50cf:	dd 1c 24             	fstpl  (%esp)
    50d2:	e8 93 ff ff ff       	call   506a <exp>
    50d7:	d9 e8                	fld1   
    50d9:	de f1                	fdivp  %st,%st(1)
    50db:	e9 e5 00 00 00       	jmp    51c5 <exp+0x15b>
	for(l=1,tmp=1;((ex_px-ex_tmp)>1e-10 || (ex_px-ex_tmp)<-1e-10) && dex_px>1e-10;l++)
    50e0:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
    50e7:	d9 e8                	fld1   
    50e9:	dd 5d d0             	fstpl  -0x30(%ebp)
    50ec:	e9 92 00 00 00       	jmp    5183 <exp+0x119>
	{
		ex_tmp=ex_px;
    50f1:	dd 45 e8             	fldl   -0x18(%ebp)
    50f4:	dd 5d e0             	fstpl  -0x20(%ebp)
		tmp*=y;
    50f7:	dd 45 d0             	fldl   -0x30(%ebp)
    50fa:	dc 4d c0             	fmull  -0x40(%ebp)
    50fd:	dd 5d d0             	fstpl  -0x30(%ebp)
		tmp=tmp/l;
    5100:	db 45 cc             	fildl  -0x34(%ebp)
    5103:	dd 45 d0             	fldl   -0x30(%ebp)
    5106:	de f1                	fdivp  %st,%st(1)
    5108:	dd 5d d0             	fstpl  -0x30(%ebp)
		ex_p1+=tmp;
    510b:	dd 45 f0             	fldl   -0x10(%ebp)
    510e:	dc 45 d0             	faddl  -0x30(%ebp)
    5111:	dd 5d f0             	fstpl  -0x10(%ebp)
		ex_p2=ex_p1+tmp*y/(l+1);
    5114:	dd 45 d0             	fldl   -0x30(%ebp)
    5117:	dc 4d c0             	fmull  -0x40(%ebp)
    511a:	8b 45 cc             	mov    -0x34(%ebp),%eax
    511d:	83 c0 01             	add    $0x1,%eax
    5120:	89 45 9c             	mov    %eax,-0x64(%ebp)
    5123:	db 45 9c             	fildl  -0x64(%ebp)
    5126:	de f9                	fdivrp %st,%st(1)
    5128:	dc 45 f0             	faddl  -0x10(%ebp)
    512b:	dd 5d b8             	fstpl  -0x48(%ebp)
		ex_p3=ex_p2+tmp*y*y/(l+1)/(l+2);
    512e:	dd 45 d0             	fldl   -0x30(%ebp)
    5131:	dc 4d c0             	fmull  -0x40(%ebp)
    5134:	dc 4d c0             	fmull  -0x40(%ebp)
    5137:	8b 45 cc             	mov    -0x34(%ebp),%eax
    513a:	83 c0 01             	add    $0x1,%eax
    513d:	89 45 9c             	mov    %eax,-0x64(%ebp)
    5140:	db 45 9c             	fildl  -0x64(%ebp)
    5143:	de f9                	fdivrp %st,%st(1)
    5145:	8b 45 cc             	mov    -0x34(%ebp),%eax
    5148:	83 c0 02             	add    $0x2,%eax
    514b:	89 45 9c             	mov    %eax,-0x64(%ebp)
    514e:	db 45 9c             	fildl  -0x64(%ebp)
    5151:	de f9                	fdivrp %st,%st(1)
    5153:	dc 45 b8             	faddl  -0x48(%ebp)
    5156:	dd 5d b0             	fstpl  -0x50(%ebp)
		dex_px=ex_p3-ex_p2;
    5159:	dd 45 b0             	fldl   -0x50(%ebp)
    515c:	dc 65 b8             	fsubl  -0x48(%ebp)
    515f:	dd 5d d8             	fstpl  -0x28(%ebp)
		ex_px=ex_p3-dex_px*dex_px/(ex_p3-2*ex_p2+ex_p1);
    5162:	dd 45 d8             	fldl   -0x28(%ebp)
    5165:	dc 4d d8             	fmull  -0x28(%ebp)
    5168:	dd 45 b8             	fldl   -0x48(%ebp)
    516b:	d8 c0                	fadd   %st(0),%st
    516d:	dd 45 b0             	fldl   -0x50(%ebp)
    5170:	de e1                	fsubp  %st,%st(1)
    5172:	dc 45 f0             	faddl  -0x10(%ebp)
    5175:	de f9                	fdivrp %st,%st(1)
    5177:	dd 45 b0             	fldl   -0x50(%ebp)
    517a:	de e1                	fsubp  %st,%st(1)
    517c:	dd 5d e8             	fstpl  -0x18(%ebp)
{
	double y=x,ex_p1=0,ex_p2=0,ex_p3=0,ex_px=0,ex_tmp=1,dex_px=1,tmp;
	int l;
	if(x==0) return 1;
	if(x<0) return 1/exp(-x); 
	for(l=1,tmp=1;((ex_px-ex_tmp)>1e-10 || (ex_px-ex_tmp)<-1e-10) && dex_px>1e-10;l++)
    517f:	83 45 cc 01          	addl   $0x1,-0x34(%ebp)
    5183:	dd 45 e8             	fldl   -0x18(%ebp)
    5186:	dc 65 e0             	fsubl  -0x20(%ebp)
    5189:	dd 05 50 b3 00 00    	fldl   0xb350
    518f:	d9 c9                	fxch   %st(1)
    5191:	df e9                	fucomip %st(1),%st
    5193:	dd d8                	fstp   %st(0)
    5195:	77 12                	ja     51a9 <exp+0x13f>
    5197:	dd 45 e8             	fldl   -0x18(%ebp)
    519a:	dc 65 e0             	fsubl  -0x20(%ebp)
    519d:	dd 05 58 b3 00 00    	fldl   0xb358
    51a3:	df e9                	fucomip %st(1),%st
    51a5:	dd d8                	fstp   %st(0)
    51a7:	76 15                	jbe    51be <exp+0x154>
    51a9:	dd 45 d8             	fldl   -0x28(%ebp)
    51ac:	dd 05 50 b3 00 00    	fldl   0xb350
    51b2:	d9 c9                	fxch   %st(1)
    51b4:	df e9                	fucomip %st(1),%st
    51b6:	dd d8                	fstp   %st(0)
    51b8:	0f 87 33 ff ff ff    	ja     50f1 <exp+0x87>
		ex_p2=ex_p1+tmp*y/(l+1);
		ex_p3=ex_p2+tmp*y*y/(l+1)/(l+2);
		dex_px=ex_p3-ex_p2;
		ex_px=ex_p3-dex_px*dex_px/(ex_p3-2*ex_p2+ex_p1);
	}
	return ex_px+1;
    51be:	dd 45 e8             	fldl   -0x18(%ebp)
    51c1:	d9 e8                	fld1   
    51c3:	de c1                	faddp  %st,%st(1)
    51c5:	c9                   	leave  
    51c6:	c3                   	ret    

000051c7 <OpenTableFile>:
};
double  s_freq[4] = {44.1, 48, 32, 0};
char *mode_names[4] = { "stereo", "j-stereo", "dual-ch", "single-ch" };

int OpenTableFile(char *name)
{
    51c7:	55                   	push   %ebp
    51c8:	89 e5                	mov    %esp,%ebp
    51ca:	83 ec 78             	sub    $0x78,%esp
	char fulname[80];
	int f;

	fulname[0] = '\0';
    51cd:	c6 45 a4 00          	movb   $0x0,-0x5c(%ebp)
	strcpy(fulname, name);
    51d1:	8b 45 08             	mov    0x8(%ebp),%eax
    51d4:	89 44 24 04          	mov    %eax,0x4(%esp)
    51d8:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    51db:	89 04 24             	mov    %eax,(%esp)
    51de:	e8 f8 f1 ff ff       	call   43db <strcpy>
	//-1 ?
	if( (f=open(fulname,O_RDWR))==-1 ) {
    51e3:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    51ea:	00 
    51eb:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    51ee:	89 04 24             	mov    %eax,(%esp)
    51f1:	e8 68 f4 ff ff       	call   465e <open>
    51f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    51f9:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    51fd:	75 1b                	jne    521a <OpenTableFile+0x53>
		printf(0,"\nOpenTable: could not find %s\n", fulname);
    51ff:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    5202:	89 44 24 08          	mov    %eax,0x8(%esp)
    5206:	c7 44 24 04 8c b3 00 	movl   $0xb38c,0x4(%esp)
    520d:	00 
    520e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5215:	e8 ec f5 ff ff       	call   4806 <printf>
    }
    return f;
    521a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    521d:	c9                   	leave  
    521e:	c3                   	ret    

0000521f <WriteHdr>:


void WriteHdr(struct frame_params *fr_ps)
{
    521f:	55                   	push   %ebp
    5220:	89 e5                	mov    %esp,%ebp
    5222:	57                   	push   %edi
    5223:	56                   	push   %esi
    5224:	53                   	push   %ebx
    5225:	83 ec 3c             	sub    $0x3c,%esp
	layer *info = fr_ps->header;
    5228:	8b 45 08             	mov    0x8(%ebp),%eax
    522b:	8b 00                	mov    (%eax),%eax
    522d:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	printf(0, "HDR:  sync=FFF, id=%X, layer=%X, ep=%X, br=%X, sf=%X, pd=%X, ",
    5230:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5233:	8b 78 14             	mov    0x14(%eax),%edi
    5236:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5239:	8b 70 10             	mov    0x10(%eax),%esi
    523c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    523f:	8b 58 0c             	mov    0xc(%eax),%ebx
		info->version, info->lay, !info->error_protection,
    5242:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5245:	8b 40 08             	mov    0x8(%eax),%eax

void WriteHdr(struct frame_params *fr_ps)
{
	layer *info = fr_ps->header;

	printf(0, "HDR:  sync=FFF, id=%X, layer=%X, ep=%X, br=%X, sf=%X, pd=%X, ",
    5248:	85 c0                	test   %eax,%eax
    524a:	0f 94 c0             	sete   %al
    524d:	0f b6 c8             	movzbl %al,%ecx
    5250:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5253:	8b 50 04             	mov    0x4(%eax),%edx
    5256:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5259:	8b 00                	mov    (%eax),%eax
    525b:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
    525f:	89 74 24 18          	mov    %esi,0x18(%esp)
    5263:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    5267:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    526b:	89 54 24 0c          	mov    %edx,0xc(%esp)
    526f:	89 44 24 08          	mov    %eax,0x8(%esp)
    5273:	c7 44 24 04 ac b3 00 	movl   $0xb3ac,0x4(%esp)
    527a:	00 
    527b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5282:	e8 7f f5 ff ff       	call   4806 <printf>
		info->version, info->lay, !info->error_protection,
		info->bitrate_index, info->sampling_frequency, info->padding);

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
    5287:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    528a:	8b 78 2c             	mov    0x2c(%eax),%edi
    528d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5290:	8b 70 28             	mov    0x28(%eax),%esi
    5293:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5296:	8b 58 24             	mov    0x24(%eax),%ebx
    5299:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    529c:	8b 48 20             	mov    0x20(%eax),%ecx
    529f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    52a2:	8b 50 1c             	mov    0x1c(%eax),%edx
    52a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    52a8:	8b 40 18             	mov    0x18(%eax),%eax
    52ab:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
    52af:	89 74 24 18          	mov    %esi,0x18(%esp)
    52b3:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    52b7:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    52bb:	89 54 24 0c          	mov    %edx,0xc(%esp)
    52bf:	89 44 24 08          	mov    %eax,0x8(%esp)
    52c3:	c7 44 24 04 ec b3 00 	movl   $0xb3ec,0x4(%esp)
    52ca:	00 
    52cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    52d2:	e8 2f f5 ff ff       	call   4806 <printf>
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);
    52d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    52da:	8b 40 1c             	mov    0x1c(%eax),%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    52dd:	8b 0c 85 c0 eb 00 00 	mov    0xebc0(,%eax,4),%ecx
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);
    52e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    52e7:	8b 40 10             	mov    0x10(%eax),%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    52ea:	dd 04 c5 a0 eb 00 00 	fldl   0xeba0(,%eax,8)
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
    52f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    52f4:	8b 40 04             	mov    0x4(%eax),%eax
    52f7:	8d 50 ff             	lea    -0x1(%eax),%edx
    52fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    52fd:	8b 58 0c             	mov    0xc(%eax),%ebx

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    5300:	89 d0                	mov    %edx,%eax
    5302:	c1 e0 04             	shl    $0x4,%eax
    5305:	29 d0                	sub    %edx,%eax
    5307:	01 d8                	add    %ebx,%eax
    5309:	8b 14 85 e0 ea 00 00 	mov    0xeae0(,%eax,4),%edx
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
    5310:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5313:	8b 40 04             	mov    0x4(%eax),%eax
    5316:	83 e8 01             	sub    $0x1,%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    5319:	8b 04 85 c0 ea 00 00 	mov    0xeac0(,%eax,4),%eax
    5320:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    5324:	dd 5c 24 10          	fstpl  0x10(%esp)
    5328:	89 54 24 0c          	mov    %edx,0xc(%esp)
    532c:	89 44 24 08          	mov    %eax,0x8(%esp)
    5330:	c7 44 24 04 14 b4 00 	movl   $0xb414,0x4(%esp)
    5337:	00 
    5338:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    533f:	e8 c2 f4 ff ff       	call   4806 <printf>
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);

	printf(0, "sblim=%d, jsbd=%d, ch=%d\n",
    5344:	8b 45 08             	mov    0x8(%ebp),%eax
    5347:	8b 48 08             	mov    0x8(%eax),%ecx
    534a:	8b 45 08             	mov    0x8(%ebp),%eax
    534d:	8b 50 0c             	mov    0xc(%eax),%edx
    5350:	8b 45 08             	mov    0x8(%ebp),%eax
    5353:	8b 40 10             	mov    0x10(%eax),%eax
    5356:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    535a:	89 54 24 0c          	mov    %edx,0xc(%esp)
    535e:	89 44 24 08          	mov    %eax,0x8(%esp)
    5362:	c7 44 24 04 43 b4 00 	movl   $0xb443,0x4(%esp)
    5369:	00 
    536a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5371:	e8 90 f4 ff ff       	call   4806 <printf>
		fr_ps->sblimit, fr_ps->jsbound, fr_ps->stereo);
}
    5376:	83 c4 3c             	add    $0x3c,%esp
    5379:	5b                   	pop    %ebx
    537a:	5e                   	pop    %esi
    537b:	5f                   	pop    %edi
    537c:	5d                   	pop    %ebp
    537d:	c3                   	ret    

0000537e <mem_alloc>:

void *mem_alloc(unsigned long block, char *item)
{
    537e:	55                   	push   %ebp
    537f:	89 e5                	mov    %esp,%ebp
    5381:	83 ec 28             	sub    $0x28,%esp
	void *ptr;
	ptr = (void *)malloc((unsigned long)block);
    5384:	8b 45 08             	mov    0x8(%ebp),%eax
    5387:	89 04 24             	mov    %eax,(%esp)
    538a:	e8 63 f7 ff ff       	call   4af2 <malloc>
    538f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if (ptr != 0)
    5392:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    5396:	74 1c                	je     53b4 <mem_alloc+0x36>
		memset(ptr, 0, block);
    5398:	8b 45 08             	mov    0x8(%ebp),%eax
    539b:	89 44 24 08          	mov    %eax,0x8(%esp)
    539f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    53a6:	00 
    53a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    53aa:	89 04 24             	mov    %eax,(%esp)
    53ad:	e8 bf f0 ff ff       	call   4471 <memset>
    53b2:	eb 20                	jmp    53d4 <mem_alloc+0x56>
	else{
		printf(0, "Unable to allocate %s\n", item);
    53b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    53b7:	89 44 24 08          	mov    %eax,0x8(%esp)
    53bb:	c7 44 24 04 5d b4 00 	movl   $0xb45d,0x4(%esp)
    53c2:	00 
    53c3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    53ca:	e8 37 f4 ff ff       	call   4806 <printf>
		exit();
    53cf:	e8 4a f2 ff ff       	call   461e <exit>
	}
	return ptr;
    53d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    53d7:	c9                   	leave  
    53d8:	c3                   	ret    

000053d9 <alloc_buffer>:

void alloc_buffer(Bit_stream_struc *bs, int size)
{
    53d9:	55                   	push   %ebp
    53da:	89 e5                	mov    %esp,%ebp
    53dc:	83 ec 18             	sub    $0x18,%esp
	bs->buf = (unsigned char *) mem_alloc(size*sizeof(unsigned char), "buffer");
    53df:	8b 45 0c             	mov    0xc(%ebp),%eax
    53e2:	c7 44 24 04 74 b4 00 	movl   $0xb474,0x4(%esp)
    53e9:	00 
    53ea:	89 04 24             	mov    %eax,(%esp)
    53ed:	e8 8c ff ff ff       	call   537e <mem_alloc>
    53f2:	8b 55 08             	mov    0x8(%ebp),%edx
    53f5:	89 42 04             	mov    %eax,0x4(%edx)
	bs->buf_size = size;
    53f8:	8b 45 08             	mov    0x8(%ebp),%eax
    53fb:	8b 55 0c             	mov    0xc(%ebp),%edx
    53fe:	89 50 08             	mov    %edx,0x8(%eax)
}
    5401:	c9                   	leave  
    5402:	c3                   	ret    

00005403 <desalloc_buffer>:

void desalloc_buffer(Bit_stream_struc *bs)
{
    5403:	55                   	push   %ebp
    5404:	89 e5                	mov    %esp,%ebp
    5406:	83 ec 18             	sub    $0x18,%esp
	free(bs->buf);
    5409:	8b 45 08             	mov    0x8(%ebp),%eax
    540c:	8b 40 04             	mov    0x4(%eax),%eax
    540f:	89 04 24             	mov    %eax,(%esp)
    5412:	e8 a2 f5 ff ff       	call   49b9 <free>
}
    5417:	c9                   	leave  
    5418:	c3                   	ret    

00005419 <open_bit_stream_r>:

void open_bit_stream_r(Bit_stream_struc *bs, char *bs_filenam, int size)
{
    5419:	55                   	push   %ebp
    541a:	89 e5                	mov    %esp,%ebp
    541c:	83 ec 18             	sub    $0x18,%esp
	//register unsigned char flag = 1;

	if ((bs->pt = open(bs_filenam, O_RDWR)) == -1) {
    541f:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    5426:	00 
    5427:	8b 45 0c             	mov    0xc(%ebp),%eax
    542a:	89 04 24             	mov    %eax,(%esp)
    542d:	e8 2c f2 ff ff       	call   465e <open>
    5432:	8b 55 08             	mov    0x8(%ebp),%edx
    5435:	89 02                	mov    %eax,(%edx)
    5437:	8b 45 08             	mov    0x8(%ebp),%eax
    543a:	8b 00                	mov    (%eax),%eax
    543c:	83 f8 ff             	cmp    $0xffffffff,%eax
    543f:	75 20                	jne    5461 <open_bit_stream_r+0x48>
		printf(0, "Could not find \"%s\".\n", bs_filenam);
    5441:	8b 45 0c             	mov    0xc(%ebp),%eax
    5444:	89 44 24 08          	mov    %eax,0x8(%esp)
    5448:	c7 44 24 04 7b b4 00 	movl   $0xb47b,0x4(%esp)
    544f:	00 
    5450:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5457:	e8 aa f3 ff ff       	call   4806 <printf>
		exit();
    545c:	e8 bd f1 ff ff       	call   461e <exit>
	}

	bs->format = BINARY;
    5461:	8b 45 08             	mov    0x8(%ebp),%eax
    5464:	c6 40 24 00          	movb   $0x0,0x24(%eax)
	alloc_buffer(bs, size);
    5468:	8b 45 10             	mov    0x10(%ebp),%eax
    546b:	89 44 24 04          	mov    %eax,0x4(%esp)
    546f:	8b 45 08             	mov    0x8(%ebp),%eax
    5472:	89 04 24             	mov    %eax,(%esp)
    5475:	e8 5f ff ff ff       	call   53d9 <alloc_buffer>
	bs->buf_byte_idx=0;
    547a:	8b 45 08             	mov    0x8(%ebp),%eax
    547d:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
	bs->buf_bit_idx=0;
    5484:	8b 45 08             	mov    0x8(%ebp),%eax
    5487:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
	bs->totbit=0;
    548e:	8b 45 08             	mov    0x8(%ebp),%eax
    5491:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	bs->mode = READ_MODE;
    5498:	8b 45 08             	mov    0x8(%ebp),%eax
    549b:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
	bs->eob = FALSE;
    54a2:	8b 45 08             	mov    0x8(%ebp),%eax
    54a5:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
	bs->eobs = FALSE;
    54ac:	8b 45 08             	mov    0x8(%ebp),%eax
    54af:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
    54b6:	c9                   	leave  
    54b7:	c3                   	ret    

000054b8 <close_bit_stream_r>:

void close_bit_stream_r(Bit_stream_struc *bs)
{
    54b8:	55                   	push   %ebp
    54b9:	89 e5                	mov    %esp,%ebp
    54bb:	83 ec 18             	sub    $0x18,%esp
	close(bs->pt);
    54be:	8b 45 08             	mov    0x8(%ebp),%eax
    54c1:	8b 00                	mov    (%eax),%eax
    54c3:	89 04 24             	mov    %eax,(%esp)
    54c6:	e8 7b f1 ff ff       	call   4646 <close>
	desalloc_buffer(bs);
    54cb:	8b 45 08             	mov    0x8(%ebp),%eax
    54ce:	89 04 24             	mov    %eax,(%esp)
    54d1:	e8 2d ff ff ff       	call   5403 <desalloc_buffer>
}
    54d6:	c9                   	leave  
    54d7:	c3                   	ret    

000054d8 <end_bs>:

int end_bs(Bit_stream_struc *bs)
{
    54d8:	55                   	push   %ebp
    54d9:	89 e5                	mov    %esp,%ebp
  return(bs->eobs);
    54db:	8b 45 08             	mov    0x8(%ebp),%eax
    54de:	8b 40 20             	mov    0x20(%eax),%eax
}
    54e1:	5d                   	pop    %ebp
    54e2:	c3                   	ret    

000054e3 <sstell>:


unsigned long sstell(Bit_stream_struc *bs)
{
    54e3:	55                   	push   %ebp
    54e4:	89 e5                	mov    %esp,%ebp
  return(bs->totbit);
    54e6:	8b 45 08             	mov    0x8(%ebp),%eax
    54e9:	8b 40 0c             	mov    0xc(%eax),%eax
}
    54ec:	5d                   	pop    %ebp
    54ed:	c3                   	ret    

000054ee <refill_buffer>:


void refill_buffer(Bit_stream_struc *bs)
{
    54ee:	55                   	push   %ebp
    54ef:	89 e5                	mov    %esp,%ebp
    54f1:	56                   	push   %esi
    54f2:	53                   	push   %ebx
    54f3:	83 ec 10             	sub    $0x10,%esp
	register int i=bs->buf_size-2-bs->buf_byte_idx;
    54f6:	8b 45 08             	mov    0x8(%ebp),%eax
    54f9:	8b 40 08             	mov    0x8(%eax),%eax
    54fc:	8d 50 fe             	lea    -0x2(%eax),%edx
    54ff:	8b 45 08             	mov    0x8(%ebp),%eax
    5502:	8b 40 10             	mov    0x10(%eax),%eax
    5505:	89 d3                	mov    %edx,%ebx
    5507:	29 c3                	sub    %eax,%ebx
	register unsigned long n=1;
    5509:	be 01 00 00 00       	mov    $0x1,%esi

	while ((i>=0) && (!bs->eob)) {
    550e:	eb 35                	jmp    5545 <refill_buffer+0x57>
			n=read(bs->pt, &bs->buf[i--], sizeof(unsigned char));
    5510:	8b 45 08             	mov    0x8(%ebp),%eax
    5513:	8b 50 04             	mov    0x4(%eax),%edx
    5516:	89 d8                	mov    %ebx,%eax
    5518:	8d 58 ff             	lea    -0x1(%eax),%ebx
    551b:	01 c2                	add    %eax,%edx
    551d:	8b 45 08             	mov    0x8(%ebp),%eax
    5520:	8b 00                	mov    (%eax),%eax
    5522:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    5529:	00 
    552a:	89 54 24 04          	mov    %edx,0x4(%esp)
    552e:	89 04 24             	mov    %eax,(%esp)
    5531:	e8 00 f1 ff ff       	call   4636 <read>
    5536:	89 c6                	mov    %eax,%esi
		if (!n)
    5538:	85 f6                	test   %esi,%esi
    553a:	75 09                	jne    5545 <refill_buffer+0x57>
		bs->eob= i+1;
    553c:	8d 53 01             	lea    0x1(%ebx),%edx
    553f:	8b 45 08             	mov    0x8(%ebp),%eax
    5542:	89 50 1c             	mov    %edx,0x1c(%eax)
void refill_buffer(Bit_stream_struc *bs)
{
	register int i=bs->buf_size-2-bs->buf_byte_idx;
	register unsigned long n=1;

	while ((i>=0) && (!bs->eob)) {
    5545:	85 db                	test   %ebx,%ebx
    5547:	78 0a                	js     5553 <refill_buffer+0x65>
    5549:	8b 45 08             	mov    0x8(%ebp),%eax
    554c:	8b 40 1c             	mov    0x1c(%eax),%eax
    554f:	85 c0                	test   %eax,%eax
    5551:	74 bd                	je     5510 <refill_buffer+0x22>
			n=read(bs->pt, &bs->buf[i--], sizeof(unsigned char));
		if (!n)
		bs->eob= i+1;
	}
}
    5553:	83 c4 10             	add    $0x10,%esp
    5556:	5b                   	pop    %ebx
    5557:	5e                   	pop    %esi
    5558:	5d                   	pop    %ebp
    5559:	c3                   	ret    

0000555a <get1bit>:


int mask[8]={0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80};

unsigned int get1bit(Bit_stream_struc *bs)
{
    555a:	55                   	push   %ebp
    555b:	89 e5                	mov    %esp,%ebp
    555d:	53                   	push   %ebx
    555e:	83 ec 24             	sub    $0x24,%esp
   unsigned int bit;
   register int i;

   bs->totbit++;
    5561:	8b 45 08             	mov    0x8(%ebp),%eax
    5564:	8b 40 0c             	mov    0xc(%eax),%eax
    5567:	8d 50 01             	lea    0x1(%eax),%edx
    556a:	8b 45 08             	mov    0x8(%ebp),%eax
    556d:	89 50 0c             	mov    %edx,0xc(%eax)

   if (!bs->buf_bit_idx) {
    5570:	8b 45 08             	mov    0x8(%ebp),%eax
    5573:	8b 40 14             	mov    0x14(%eax),%eax
    5576:	85 c0                	test   %eax,%eax
    5578:	0f 85 9f 00 00 00    	jne    561d <get1bit+0xc3>
        bs->buf_bit_idx = 8;
    557e:	8b 45 08             	mov    0x8(%ebp),%eax
    5581:	c7 40 14 08 00 00 00 	movl   $0x8,0x14(%eax)
        bs->buf_byte_idx--;
    5588:	8b 45 08             	mov    0x8(%ebp),%eax
    558b:	8b 40 10             	mov    0x10(%eax),%eax
    558e:	8d 50 ff             	lea    -0x1(%eax),%edx
    5591:	8b 45 08             	mov    0x8(%ebp),%eax
    5594:	89 50 10             	mov    %edx,0x10(%eax)
        if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
    5597:	8b 45 08             	mov    0x8(%ebp),%eax
    559a:	8b 40 10             	mov    0x10(%eax),%eax
    559d:	83 f8 03             	cmp    $0x3,%eax
    55a0:	7e 10                	jle    55b2 <get1bit+0x58>
    55a2:	8b 45 08             	mov    0x8(%ebp),%eax
    55a5:	8b 50 10             	mov    0x10(%eax),%edx
    55a8:	8b 45 08             	mov    0x8(%ebp),%eax
    55ab:	8b 40 1c             	mov    0x1c(%eax),%eax
    55ae:	39 c2                	cmp    %eax,%edx
    55b0:	7d 6b                	jge    561d <get1bit+0xc3>
             if (bs->eob)
    55b2:	8b 45 08             	mov    0x8(%ebp),%eax
    55b5:	8b 40 1c             	mov    0x1c(%eax),%eax
    55b8:	85 c0                	test   %eax,%eax
    55ba:	74 0c                	je     55c8 <get1bit+0x6e>
                bs->eobs = TRUE;
    55bc:	8b 45 08             	mov    0x8(%ebp),%eax
    55bf:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
    55c6:	eb 55                	jmp    561d <get1bit+0xc3>
             else {
                for (i=bs->buf_byte_idx; i>=0;i--)
    55c8:	8b 45 08             	mov    0x8(%ebp),%eax
    55cb:	8b 58 10             	mov    0x10(%eax),%ebx
    55ce:	eb 2f                	jmp    55ff <get1bit+0xa5>
                  bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
    55d0:	8b 45 08             	mov    0x8(%ebp),%eax
    55d3:	8b 50 04             	mov    0x4(%eax),%edx
    55d6:	8b 45 08             	mov    0x8(%ebp),%eax
    55d9:	8b 40 08             	mov    0x8(%eax),%eax
    55dc:	8d 48 ff             	lea    -0x1(%eax),%ecx
    55df:	8b 45 08             	mov    0x8(%ebp),%eax
    55e2:	8b 40 10             	mov    0x10(%eax),%eax
    55e5:	29 c1                	sub    %eax,%ecx
    55e7:	89 c8                	mov    %ecx,%eax
    55e9:	01 d8                	add    %ebx,%eax
    55eb:	01 c2                	add    %eax,%edx
    55ed:	8b 45 08             	mov    0x8(%ebp),%eax
    55f0:	8b 48 04             	mov    0x4(%eax),%ecx
    55f3:	89 d8                	mov    %ebx,%eax
    55f5:	01 c8                	add    %ecx,%eax
    55f7:	0f b6 00             	movzbl (%eax),%eax
    55fa:	88 02                	mov    %al,(%edx)
        bs->buf_byte_idx--;
        if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
             if (bs->eob)
                bs->eobs = TRUE;
             else {
                for (i=bs->buf_byte_idx; i>=0;i--)
    55fc:	83 eb 01             	sub    $0x1,%ebx
    55ff:	85 db                	test   %ebx,%ebx
    5601:	79 cd                	jns    55d0 <get1bit+0x76>
                  bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
                refill_buffer(bs);
    5603:	8b 45 08             	mov    0x8(%ebp),%eax
    5606:	89 04 24             	mov    %eax,(%esp)
    5609:	e8 e0 fe ff ff       	call   54ee <refill_buffer>
                bs->buf_byte_idx = bs->buf_size-1;
    560e:	8b 45 08             	mov    0x8(%ebp),%eax
    5611:	8b 40 08             	mov    0x8(%eax),%eax
    5614:	8d 50 ff             	lea    -0x1(%eax),%edx
    5617:	8b 45 08             	mov    0x8(%ebp),%eax
    561a:	89 50 10             	mov    %edx,0x10(%eax)
             }
        }
   }
   bit = bs->buf[bs->buf_byte_idx]&mask[bs->buf_bit_idx-1];
    561d:	8b 45 08             	mov    0x8(%ebp),%eax
    5620:	8b 50 04             	mov    0x4(%eax),%edx
    5623:	8b 45 08             	mov    0x8(%ebp),%eax
    5626:	8b 40 10             	mov    0x10(%eax),%eax
    5629:	01 d0                	add    %edx,%eax
    562b:	0f b6 00             	movzbl (%eax),%eax
    562e:	0f b6 d0             	movzbl %al,%edx
    5631:	8b 45 08             	mov    0x8(%ebp),%eax
    5634:	8b 40 14             	mov    0x14(%eax),%eax
    5637:	83 e8 01             	sub    $0x1,%eax
    563a:	8b 04 85 e0 eb 00 00 	mov    0xebe0(,%eax,4),%eax
    5641:	21 d0                	and    %edx,%eax
    5643:	89 45 f4             	mov    %eax,-0xc(%ebp)
   bit = bit >> (bs->buf_bit_idx-1);
    5646:	8b 45 08             	mov    0x8(%ebp),%eax
    5649:	8b 40 14             	mov    0x14(%eax),%eax
    564c:	83 e8 01             	sub    $0x1,%eax
    564f:	89 c1                	mov    %eax,%ecx
    5651:	d3 6d f4             	shrl   %cl,-0xc(%ebp)
   bs->buf_bit_idx--;
    5654:	8b 45 08             	mov    0x8(%ebp),%eax
    5657:	8b 40 14             	mov    0x14(%eax),%eax
    565a:	8d 50 ff             	lea    -0x1(%eax),%edx
    565d:	8b 45 08             	mov    0x8(%ebp),%eax
    5660:	89 50 14             	mov    %edx,0x14(%eax)
   return(bit);
    5663:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    5666:	83 c4 24             	add    $0x24,%esp
    5669:	5b                   	pop    %ebx
    566a:	5d                   	pop    %ebp
    566b:	c3                   	ret    

0000566c <getbits>:

int putmask[9]={0x0, 0x1, 0x3, 0x7, 0xf, 0x1f, 0x3f, 0x7f, 0xff};

unsigned long getbits(Bit_stream_struc *bs, int N)
{
    566c:	55                   	push   %ebp
    566d:	89 e5                	mov    %esp,%ebp
    566f:	57                   	push   %edi
    5670:	56                   	push   %esi
    5671:	53                   	push   %ebx
    5672:	83 ec 2c             	sub    $0x2c,%esp
	unsigned long val=0;
    5675:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	register int i;
	register int j = N;
    567c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	register int k, tmp;

	if (N > MAX_LENGTH)
    567f:	83 7d 0c 20          	cmpl   $0x20,0xc(%ebp)
    5683:	7e 1c                	jle    56a1 <getbits+0x35>
		printf(0,"Cannot read or write more than %d bits at a time.\n", MAX_LENGTH);
    5685:	c7 44 24 08 20 00 00 	movl   $0x20,0x8(%esp)
    568c:	00 
    568d:	c7 44 24 04 94 b4 00 	movl   $0xb494,0x4(%esp)
    5694:	00 
    5695:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    569c:	e8 65 f1 ff ff       	call   4806 <printf>

	bs->totbit += N;
    56a1:	8b 45 08             	mov    0x8(%ebp),%eax
    56a4:	8b 50 0c             	mov    0xc(%eax),%edx
    56a7:	8b 45 0c             	mov    0xc(%ebp),%eax
    56aa:	01 c2                	add    %eax,%edx
    56ac:	8b 45 08             	mov    0x8(%ebp),%eax
    56af:	89 50 0c             	mov    %edx,0xc(%eax)
	while (j > 0) {
    56b2:	e9 0a 01 00 00       	jmp    57c1 <getbits+0x155>
		if (!bs->buf_bit_idx) {
    56b7:	8b 45 08             	mov    0x8(%ebp),%eax
    56ba:	8b 40 14             	mov    0x14(%eax),%eax
    56bd:	85 c0                	test   %eax,%eax
    56bf:	0f 85 9f 00 00 00    	jne    5764 <getbits+0xf8>
			bs->buf_bit_idx = 8;
    56c5:	8b 45 08             	mov    0x8(%ebp),%eax
    56c8:	c7 40 14 08 00 00 00 	movl   $0x8,0x14(%eax)
			bs->buf_byte_idx--;
    56cf:	8b 45 08             	mov    0x8(%ebp),%eax
    56d2:	8b 40 10             	mov    0x10(%eax),%eax
    56d5:	8d 50 ff             	lea    -0x1(%eax),%edx
    56d8:	8b 45 08             	mov    0x8(%ebp),%eax
    56db:	89 50 10             	mov    %edx,0x10(%eax)
			if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
    56de:	8b 45 08             	mov    0x8(%ebp),%eax
    56e1:	8b 40 10             	mov    0x10(%eax),%eax
    56e4:	83 f8 03             	cmp    $0x3,%eax
    56e7:	7e 10                	jle    56f9 <getbits+0x8d>
    56e9:	8b 45 08             	mov    0x8(%ebp),%eax
    56ec:	8b 50 10             	mov    0x10(%eax),%edx
    56ef:	8b 45 08             	mov    0x8(%ebp),%eax
    56f2:	8b 40 1c             	mov    0x1c(%eax),%eax
    56f5:	39 c2                	cmp    %eax,%edx
    56f7:	7d 6b                	jge    5764 <getbits+0xf8>
				if (bs->eob)
    56f9:	8b 45 08             	mov    0x8(%ebp),%eax
    56fc:	8b 40 1c             	mov    0x1c(%eax),%eax
    56ff:	85 c0                	test   %eax,%eax
    5701:	74 0c                	je     570f <getbits+0xa3>
					bs->eobs = TRUE;
    5703:	8b 45 08             	mov    0x8(%ebp),%eax
    5706:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
    570d:	eb 55                	jmp    5764 <getbits+0xf8>
				else {
					for (i=bs->buf_byte_idx; i>=0;i--)
    570f:	8b 45 08             	mov    0x8(%ebp),%eax
    5712:	8b 70 10             	mov    0x10(%eax),%esi
    5715:	eb 2f                	jmp    5746 <getbits+0xda>
						bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
    5717:	8b 45 08             	mov    0x8(%ebp),%eax
    571a:	8b 50 04             	mov    0x4(%eax),%edx
    571d:	8b 45 08             	mov    0x8(%ebp),%eax
    5720:	8b 40 08             	mov    0x8(%eax),%eax
    5723:	8d 48 ff             	lea    -0x1(%eax),%ecx
    5726:	8b 45 08             	mov    0x8(%ebp),%eax
    5729:	8b 40 10             	mov    0x10(%eax),%eax
    572c:	29 c1                	sub    %eax,%ecx
    572e:	89 c8                	mov    %ecx,%eax
    5730:	01 f0                	add    %esi,%eax
    5732:	01 c2                	add    %eax,%edx
    5734:	8b 45 08             	mov    0x8(%ebp),%eax
    5737:	8b 48 04             	mov    0x4(%eax),%ecx
    573a:	89 f0                	mov    %esi,%eax
    573c:	01 c8                	add    %ecx,%eax
    573e:	0f b6 00             	movzbl (%eax),%eax
    5741:	88 02                	mov    %al,(%edx)
			bs->buf_byte_idx--;
			if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
				if (bs->eob)
					bs->eobs = TRUE;
				else {
					for (i=bs->buf_byte_idx; i>=0;i--)
    5743:	83 ee 01             	sub    $0x1,%esi
    5746:	85 f6                	test   %esi,%esi
    5748:	79 cd                	jns    5717 <getbits+0xab>
						bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
						refill_buffer(bs);
    574a:	8b 45 08             	mov    0x8(%ebp),%eax
    574d:	89 04 24             	mov    %eax,(%esp)
    5750:	e8 99 fd ff ff       	call   54ee <refill_buffer>
					bs->buf_byte_idx = bs->buf_size-1;
    5755:	8b 45 08             	mov    0x8(%ebp),%eax
    5758:	8b 40 08             	mov    0x8(%eax),%eax
    575b:	8d 50 ff             	lea    -0x1(%eax),%edx
    575e:	8b 45 08             	mov    0x8(%ebp),%eax
    5761:	89 50 10             	mov    %edx,0x10(%eax)
				}
			}
		}
		k = MIN(j, bs->buf_bit_idx);
    5764:	8b 45 08             	mov    0x8(%ebp),%eax
    5767:	8b 40 14             	mov    0x14(%eax),%eax
    576a:	39 d8                	cmp    %ebx,%eax
    576c:	0f 4f c3             	cmovg  %ebx,%eax
    576f:	89 c6                	mov    %eax,%esi
		tmp = bs->buf[bs->buf_byte_idx]&putmask[bs->buf_bit_idx];
    5771:	8b 45 08             	mov    0x8(%ebp),%eax
    5774:	8b 50 04             	mov    0x4(%eax),%edx
    5777:	8b 45 08             	mov    0x8(%ebp),%eax
    577a:	8b 40 10             	mov    0x10(%eax),%eax
    577d:	01 d0                	add    %edx,%eax
    577f:	0f b6 00             	movzbl (%eax),%eax
    5782:	0f b6 d0             	movzbl %al,%edx
    5785:	8b 45 08             	mov    0x8(%ebp),%eax
    5788:	8b 40 14             	mov    0x14(%eax),%eax
    578b:	8b 04 85 00 ec 00 00 	mov    0xec00(,%eax,4),%eax
    5792:	89 d7                	mov    %edx,%edi
    5794:	21 c7                	and    %eax,%edi
		tmp = tmp >> (bs->buf_bit_idx-k);
    5796:	8b 45 08             	mov    0x8(%ebp),%eax
    5799:	8b 40 14             	mov    0x14(%eax),%eax
    579c:	29 f0                	sub    %esi,%eax
    579e:	89 c1                	mov    %eax,%ecx
    57a0:	d3 ff                	sar    %cl,%edi
		val |= tmp << (j-k);
    57a2:	89 d8                	mov    %ebx,%eax
    57a4:	29 f0                	sub    %esi,%eax
    57a6:	89 c1                	mov    %eax,%ecx
    57a8:	d3 e7                	shl    %cl,%edi
    57aa:	89 f8                	mov    %edi,%eax
    57ac:	09 45 e4             	or     %eax,-0x1c(%ebp)
		bs->buf_bit_idx -= k;
    57af:	8b 45 08             	mov    0x8(%ebp),%eax
    57b2:	8b 40 14             	mov    0x14(%eax),%eax
    57b5:	29 f0                	sub    %esi,%eax
    57b7:	89 c2                	mov    %eax,%edx
    57b9:	8b 45 08             	mov    0x8(%ebp),%eax
    57bc:	89 50 14             	mov    %edx,0x14(%eax)
		j -= k;
    57bf:	29 f3                	sub    %esi,%ebx

	if (N > MAX_LENGTH)
		printf(0,"Cannot read or write more than %d bits at a time.\n", MAX_LENGTH);

	bs->totbit += N;
	while (j > 0) {
    57c1:	85 db                	test   %ebx,%ebx
    57c3:	0f 8f ee fe ff ff    	jg     56b7 <getbits+0x4b>
		tmp = tmp >> (bs->buf_bit_idx-k);
		val |= tmp << (j-k);
		bs->buf_bit_idx -= k;
		j -= k;
	}
	return val;
    57c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
    57cc:	83 c4 2c             	add    $0x2c,%esp
    57cf:	5b                   	pop    %ebx
    57d0:	5e                   	pop    %esi
    57d1:	5f                   	pop    %edi
    57d2:	5d                   	pop    %ebp
    57d3:	c3                   	ret    

000057d4 <seek_sync>:


int seek_sync(Bit_stream_struc *bs, unsigned long sync, int N)
{
    57d4:	55                   	push   %ebp
    57d5:	89 e5                	mov    %esp,%ebp
    57d7:	83 ec 38             	sub    $0x38,%esp
	unsigned long aligning;
	unsigned long val;
	long maxi = (int)pow(2.0, (double)N) - 1;
    57da:	db 45 10             	fildl  0x10(%ebp)
    57dd:	dd 5c 24 08          	fstpl  0x8(%esp)
    57e1:	dd 05 00 b5 00 00    	fldl   0xb500
    57e7:	dd 1c 24             	fstpl  (%esp)
    57ea:	e8 ec f4 ff ff       	call   4cdb <pow>
    57ef:	d9 7d e6             	fnstcw -0x1a(%ebp)
    57f2:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    57f6:	b4 0c                	mov    $0xc,%ah
    57f8:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    57fc:	d9 6d e4             	fldcw  -0x1c(%ebp)
    57ff:	db 5d e0             	fistpl -0x20(%ebp)
    5802:	d9 6d e6             	fldcw  -0x1a(%ebp)
    5805:	8b 45 e0             	mov    -0x20(%ebp),%eax
    5808:	83 e8 01             	sub    $0x1,%eax
    580b:	89 45 f0             	mov    %eax,-0x10(%ebp)

	aligning = sstell(bs)%ALIGNING;
    580e:	8b 45 08             	mov    0x8(%ebp),%eax
    5811:	89 04 24             	mov    %eax,(%esp)
    5814:	e8 ca fc ff ff       	call   54e3 <sstell>
    5819:	83 e0 07             	and    $0x7,%eax
    581c:	89 45 ec             	mov    %eax,-0x14(%ebp)
	if (aligning)
    581f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    5823:	74 17                	je     583c <seek_sync+0x68>
		getbits(bs, (int)(ALIGNING-aligning));
    5825:	b8 08 00 00 00       	mov    $0x8,%eax
    582a:	2b 45 ec             	sub    -0x14(%ebp),%eax
    582d:	89 44 24 04          	mov    %eax,0x4(%esp)
    5831:	8b 45 08             	mov    0x8(%ebp),%eax
    5834:	89 04 24             	mov    %eax,(%esp)
    5837:	e8 30 fe ff ff       	call   566c <getbits>

	val = getbits(bs, N);
    583c:	8b 45 10             	mov    0x10(%ebp),%eax
    583f:	89 44 24 04          	mov    %eax,0x4(%esp)
    5843:	8b 45 08             	mov    0x8(%ebp),%eax
    5846:	89 04 24             	mov    %eax,(%esp)
    5849:	e8 1e fe ff ff       	call   566c <getbits>
    584e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (((val&maxi) != sync) && (!end_bs(bs))) {
    5851:	eb 1a                	jmp    586d <seek_sync+0x99>
		val <<= ALIGNING;
    5853:	c1 65 f4 08          	shll   $0x8,-0xc(%ebp)
		val |= getbits(bs, ALIGNING);
    5857:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
    585e:	00 
    585f:	8b 45 08             	mov    0x8(%ebp),%eax
    5862:	89 04 24             	mov    %eax,(%esp)
    5865:	e8 02 fe ff ff       	call   566c <getbits>
    586a:	09 45 f4             	or     %eax,-0xc(%ebp)
	aligning = sstell(bs)%ALIGNING;
	if (aligning)
		getbits(bs, (int)(ALIGNING-aligning));

	val = getbits(bs, N);
	while (((val&maxi) != sync) && (!end_bs(bs))) {
    586d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5870:	23 45 f4             	and    -0xc(%ebp),%eax
    5873:	3b 45 0c             	cmp    0xc(%ebp),%eax
    5876:	74 0f                	je     5887 <seek_sync+0xb3>
    5878:	8b 45 08             	mov    0x8(%ebp),%eax
    587b:	89 04 24             	mov    %eax,(%esp)
    587e:	e8 55 fc ff ff       	call   54d8 <end_bs>
    5883:	85 c0                	test   %eax,%eax
    5885:	74 cc                	je     5853 <seek_sync+0x7f>
		val <<= ALIGNING;
		val |= getbits(bs, ALIGNING);
	}

	if (end_bs(bs))
    5887:	8b 45 08             	mov    0x8(%ebp),%eax
    588a:	89 04 24             	mov    %eax,(%esp)
    588d:	e8 46 fc ff ff       	call   54d8 <end_bs>
    5892:	85 c0                	test   %eax,%eax
    5894:	74 07                	je     589d <seek_sync+0xc9>
		return(0);
    5896:	b8 00 00 00 00       	mov    $0x0,%eax
    589b:	eb 05                	jmp    58a2 <seek_sync+0xce>
	else
		return(1);
    589d:	b8 01 00 00 00       	mov    $0x1,%eax
}
    58a2:	c9                   	leave  
    58a3:	c3                   	ret    

000058a4 <js_bound>:

int js_bound(int lay, int m_ext)
{
    58a4:	55                   	push   %ebp
    58a5:	89 e5                	mov    %esp,%ebp
    58a7:	83 ec 18             	sub    $0x18,%esp
		{ 4, 8, 12, 16 },
		{ 4, 8, 12, 16},
		{ 0, 4, 8, 16}
	};  /* lay+m_e -> jsbound */

    if(lay<1 || lay >3 || m_ext<0 || m_ext>3) {
    58aa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    58ae:	7e 12                	jle    58c2 <js_bound+0x1e>
    58b0:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
    58b4:	7f 0c                	jg     58c2 <js_bound+0x1e>
    58b6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    58ba:	78 06                	js     58c2 <js_bound+0x1e>
    58bc:	83 7d 0c 03          	cmpl   $0x3,0xc(%ebp)
    58c0:	7e 27                	jle    58e9 <js_bound+0x45>
        printf(0, "js_bound bad layer/modext (%d/%d)\n", lay, m_ext);
    58c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    58c5:	89 44 24 0c          	mov    %eax,0xc(%esp)
    58c9:	8b 45 08             	mov    0x8(%ebp),%eax
    58cc:	89 44 24 08          	mov    %eax,0x8(%esp)
    58d0:	c7 44 24 04 c8 b4 00 	movl   $0xb4c8,0x4(%esp)
    58d7:	00 
    58d8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    58df:	e8 22 ef ff ff       	call   4806 <printf>
        exit();
    58e4:	e8 35 ed ff ff       	call   461e <exit>
    }
	return(jsb_table[lay-1][m_ext]);
    58e9:	8b 45 08             	mov    0x8(%ebp),%eax
    58ec:	83 e8 01             	sub    $0x1,%eax
    58ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    58f6:	8b 45 0c             	mov    0xc(%ebp),%eax
    58f9:	01 d0                	add    %edx,%eax
    58fb:	8b 04 85 40 ec 00 00 	mov    0xec40(,%eax,4),%eax
}
    5902:	c9                   	leave  
    5903:	c3                   	ret    

00005904 <hdr_to_frps>:

void hdr_to_frps(struct frame_params *fr_ps)
{
    5904:	55                   	push   %ebp
    5905:	89 e5                	mov    %esp,%ebp
    5907:	83 ec 28             	sub    $0x28,%esp
	layer *hdr = fr_ps->header;     /* (or pass in as arg?) */
    590a:	8b 45 08             	mov    0x8(%ebp),%eax
    590d:	8b 00                	mov    (%eax),%eax
    590f:	89 45 f4             	mov    %eax,-0xc(%ebp)

	fr_ps->actual_mode = hdr->mode;
    5912:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5915:	8b 50 1c             	mov    0x1c(%eax),%edx
    5918:	8b 45 08             	mov    0x8(%ebp),%eax
    591b:	89 50 04             	mov    %edx,0x4(%eax)
	fr_ps->stereo = (hdr->mode == MPG_MD_MONO) ? 1 : 2;
    591e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5921:	8b 40 1c             	mov    0x1c(%eax),%eax
    5924:	83 f8 03             	cmp    $0x3,%eax
    5927:	75 07                	jne    5930 <hdr_to_frps+0x2c>
    5929:	b8 01 00 00 00       	mov    $0x1,%eax
    592e:	eb 05                	jmp    5935 <hdr_to_frps+0x31>
    5930:	b8 02 00 00 00       	mov    $0x2,%eax
    5935:	8b 55 08             	mov    0x8(%ebp),%edx
    5938:	89 42 08             	mov    %eax,0x8(%edx)
	fr_ps->sblimit = SBLIMIT;
    593b:	8b 45 08             	mov    0x8(%ebp),%eax
    593e:	c7 40 10 20 00 00 00 	movl   $0x20,0x10(%eax)
	if(hdr->mode == MPG_MD_JOINT_STEREO)
    5945:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5948:	8b 40 1c             	mov    0x1c(%eax),%eax
    594b:	83 f8 01             	cmp    $0x1,%eax
    594e:	75 20                	jne    5970 <hdr_to_frps+0x6c>
		fr_ps->jsbound = js_bound(hdr->lay, hdr->mode_ext);
    5950:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5953:	8b 50 20             	mov    0x20(%eax),%edx
    5956:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5959:	8b 40 04             	mov    0x4(%eax),%eax
    595c:	89 54 24 04          	mov    %edx,0x4(%esp)
    5960:	89 04 24             	mov    %eax,(%esp)
    5963:	e8 3c ff ff ff       	call   58a4 <js_bound>
    5968:	8b 55 08             	mov    0x8(%ebp),%edx
    596b:	89 42 0c             	mov    %eax,0xc(%edx)
    596e:	eb 0c                	jmp    597c <hdr_to_frps+0x78>
	else
		fr_ps->jsbound = fr_ps->sblimit;
    5970:	8b 45 08             	mov    0x8(%ebp),%eax
    5973:	8b 50 10             	mov    0x10(%eax),%edx
    5976:	8b 45 08             	mov    0x8(%ebp),%eax
    5979:	89 50 0c             	mov    %edx,0xc(%eax)
}
    597c:	c9                   	leave  
    597d:	c3                   	ret    

0000597e <hputbuf>:

void hputbuf(unsigned int val, int N)
{
    597e:	55                   	push   %ebp
    597f:	89 e5                	mov    %esp,%ebp
    5981:	83 ec 18             	sub    $0x18,%esp
	if (N != 8) {
    5984:	83 7d 0c 08          	cmpl   $0x8,0xc(%ebp)
    5988:	74 19                	je     59a3 <hputbuf+0x25>
		printf(0,"Not Supported yet!!\n");
    598a:	c7 44 24 04 eb b4 00 	movl   $0xb4eb,0x4(%esp)
    5991:	00 
    5992:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5999:	e8 68 ee ff ff       	call   4806 <printf>
		exit();
    599e:	e8 7b ec ff ff       	call   461e <exit>
	}
	getCoreBuf(1, val);
    59a3:	8b 45 08             	mov    0x8(%ebp),%eax
    59a6:	89 44 24 04          	mov    %eax,0x4(%esp)
    59aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    59b1:	e8 68 ed ff ff       	call   471e <getCoreBuf>
//	buf[offset % BUFSIZE] = val;
//	offset++;
}
    59b6:	c9                   	leave  
    59b7:	c3                   	ret    

000059b8 <hsstell>:

unsigned long hsstell()
{
    59b8:	55                   	push   %ebp
    59b9:	89 e5                	mov    %esp,%ebp
    59bb:	83 ec 18             	sub    $0x18,%esp
	return getCoreBuf(2, 0);
    59be:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    59c5:	00 
    59c6:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    59cd:	e8 4c ed ff ff       	call   471e <getCoreBuf>
//	return(totbit);
}
    59d2:	c9                   	leave  
    59d3:	c3                   	ret    

000059d4 <hgetbits>:

unsigned long hgetbits(int N)
{
    59d4:	55                   	push   %ebp
    59d5:	89 e5                	mov    %esp,%ebp
    59d7:	83 ec 18             	sub    $0x18,%esp

	return getCoreBuf(3, N);
    59da:	8b 45 08             	mov    0x8(%ebp),%eax
    59dd:	89 44 24 04          	mov    %eax,0x4(%esp)
    59e1:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
    59e8:	e8 31 ed ff ff       	call   471e <getCoreBuf>
}
    59ed:	c9                   	leave  
    59ee:	c3                   	ret    

000059ef <hget1bit>:


unsigned int hget1bit()
{
    59ef:	55                   	push   %ebp
    59f0:	89 e5                	mov    %esp,%ebp
    59f2:	83 ec 18             	sub    $0x18,%esp
	return(hgetbits(1));
    59f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    59fc:	e8 d3 ff ff ff       	call   59d4 <hgetbits>
}
    5a01:	c9                   	leave  
    5a02:	c3                   	ret    

00005a03 <rewindNbits>:


void rewindNbits(int N)
{
    5a03:	55                   	push   %ebp
    5a04:	89 e5                	mov    %esp,%ebp
    5a06:	83 ec 18             	sub    $0x18,%esp
	getCoreBuf(4, N);
    5a09:	8b 45 08             	mov    0x8(%ebp),%eax
    5a0c:	89 44 24 04          	mov    %eax,0x4(%esp)
    5a10:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
    5a17:	e8 02 ed ff ff       	call   471e <getCoreBuf>
}
    5a1c:	c9                   	leave  
    5a1d:	c3                   	ret    

00005a1e <rewindNbytes>:


void rewindNbytes(int N)
{
    5a1e:	55                   	push   %ebp
    5a1f:	89 e5                	mov    %esp,%ebp
    5a21:	83 ec 18             	sub    $0x18,%esp
	getCoreBuf(5, N);
    5a24:	8b 45 08             	mov    0x8(%ebp),%eax
    5a27:	89 44 24 04          	mov    %eax,0x4(%esp)
    5a2b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    5a32:	e8 e7 ec ff ff       	call   471e <getCoreBuf>
}
    5a37:	c9                   	leave  
    5a38:	c3                   	ret    

00005a39 <read_decoder_table>:
				/* 0..31 Huffman code table 0..31	*/
				/* 32,33 count1-tables			*/

/* ��ȡ huffman ����� */
void read_decoder_table() 
{
    5a39:	55                   	push   %ebp
    5a3a:	89 e5                	mov    %esp,%ebp
    5a3c:	57                   	push   %edi
    5a3d:	56                   	push   %esi
    5a3e:	53                   	push   %ebx
    5a3f:	81 ec 40 1b 00 00    	sub    $0x1b40,%esp
	unsigned char h1[7][2] = {{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11}};
    5a45:	c6 45 e6 02          	movb   $0x2,-0x1a(%ebp)
    5a49:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
    5a4d:	c6 45 e8 00          	movb   $0x0,-0x18(%ebp)
    5a51:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    5a55:	c6 45 ea 02          	movb   $0x2,-0x16(%ebp)
    5a59:	c6 45 eb 01          	movb   $0x1,-0x15(%ebp)
    5a5d:	c6 45 ec 00          	movb   $0x0,-0x14(%ebp)
    5a61:	c6 45 ed 10          	movb   $0x10,-0x13(%ebp)
    5a65:	c6 45 ee 02          	movb   $0x2,-0x12(%ebp)
    5a69:	c6 45 ef 01          	movb   $0x1,-0x11(%ebp)
    5a6d:	c6 45 f0 00          	movb   $0x0,-0x10(%ebp)
    5a71:	c6 45 f1 01          	movb   $0x1,-0xf(%ebp)
    5a75:	c6 45 f2 00          	movb   $0x0,-0xe(%ebp)
    5a79:	c6 45 f3 11          	movb   $0x11,-0xd(%ebp)

	unsigned char h2[17][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22}};
    5a7d:	c6 45 c4 02          	movb   $0x2,-0x3c(%ebp)
    5a81:	c6 45 c5 01          	movb   $0x1,-0x3b(%ebp)
    5a85:	c6 45 c6 00          	movb   $0x0,-0x3a(%ebp)
    5a89:	c6 45 c7 00          	movb   $0x0,-0x39(%ebp)
    5a8d:	c6 45 c8 04          	movb   $0x4,-0x38(%ebp)
    5a91:	c6 45 c9 01          	movb   $0x1,-0x37(%ebp)
    5a95:	c6 45 ca 02          	movb   $0x2,-0x36(%ebp)
    5a99:	c6 45 cb 01          	movb   $0x1,-0x35(%ebp)
    5a9d:	c6 45 cc 00          	movb   $0x0,-0x34(%ebp)
    5aa1:	c6 45 cd 10          	movb   $0x10,-0x33(%ebp)
    5aa5:	c6 45 ce 00          	movb   $0x0,-0x32(%ebp)
    5aa9:	c6 45 cf 01          	movb   $0x1,-0x31(%ebp)
    5aad:	c6 45 d0 02          	movb   $0x2,-0x30(%ebp)
    5ab1:	c6 45 d1 01          	movb   $0x1,-0x2f(%ebp)
    5ab5:	c6 45 d2 00          	movb   $0x0,-0x2e(%ebp)
    5ab9:	c6 45 d3 11          	movb   $0x11,-0x2d(%ebp)
    5abd:	c6 45 d4 04          	movb   $0x4,-0x2c(%ebp)
    5ac1:	c6 45 d5 01          	movb   $0x1,-0x2b(%ebp)
    5ac5:	c6 45 d6 02          	movb   $0x2,-0x2a(%ebp)
    5ac9:	c6 45 d7 01          	movb   $0x1,-0x29(%ebp)
    5acd:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
    5ad1:	c6 45 d9 20          	movb   $0x20,-0x27(%ebp)
    5ad5:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
    5ad9:	c6 45 db 21          	movb   $0x21,-0x25(%ebp)
    5add:	c6 45 dc 02          	movb   $0x2,-0x24(%ebp)
    5ae1:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
    5ae5:	c6 45 de 00          	movb   $0x0,-0x22(%ebp)
    5ae9:	c6 45 df 12          	movb   $0x12,-0x21(%ebp)
    5aed:	c6 45 e0 02          	movb   $0x2,-0x20(%ebp)
    5af1:	c6 45 e1 01          	movb   $0x1,-0x1f(%ebp)
    5af5:	c6 45 e2 00          	movb   $0x0,-0x1e(%ebp)
    5af9:	c6 45 e3 02          	movb   $0x2,-0x1d(%ebp)
    5afd:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
    5b01:	c6 45 e5 22          	movb   $0x22,-0x1b(%ebp)

	unsigned char h3[17][2] = {{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x2,0x1},{0x0,0x10},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22}};
    5b05:	c6 45 a2 04          	movb   $0x4,-0x5e(%ebp)
    5b09:	c6 45 a3 01          	movb   $0x1,-0x5d(%ebp)
    5b0d:	c6 45 a4 02          	movb   $0x2,-0x5c(%ebp)
    5b11:	c6 45 a5 01          	movb   $0x1,-0x5b(%ebp)
    5b15:	c6 45 a6 00          	movb   $0x0,-0x5a(%ebp)
    5b19:	c6 45 a7 00          	movb   $0x0,-0x59(%ebp)
    5b1d:	c6 45 a8 00          	movb   $0x0,-0x58(%ebp)
    5b21:	c6 45 a9 01          	movb   $0x1,-0x57(%ebp)
    5b25:	c6 45 aa 02          	movb   $0x2,-0x56(%ebp)
    5b29:	c6 45 ab 01          	movb   $0x1,-0x55(%ebp)
    5b2d:	c6 45 ac 00          	movb   $0x0,-0x54(%ebp)
    5b31:	c6 45 ad 11          	movb   $0x11,-0x53(%ebp)
    5b35:	c6 45 ae 02          	movb   $0x2,-0x52(%ebp)
    5b39:	c6 45 af 01          	movb   $0x1,-0x51(%ebp)
    5b3d:	c6 45 b0 00          	movb   $0x0,-0x50(%ebp)
    5b41:	c6 45 b1 10          	movb   $0x10,-0x4f(%ebp)
    5b45:	c6 45 b2 04          	movb   $0x4,-0x4e(%ebp)
    5b49:	c6 45 b3 01          	movb   $0x1,-0x4d(%ebp)
    5b4d:	c6 45 b4 02          	movb   $0x2,-0x4c(%ebp)
    5b51:	c6 45 b5 01          	movb   $0x1,-0x4b(%ebp)
    5b55:	c6 45 b6 00          	movb   $0x0,-0x4a(%ebp)
    5b59:	c6 45 b7 20          	movb   $0x20,-0x49(%ebp)
    5b5d:	c6 45 b8 00          	movb   $0x0,-0x48(%ebp)
    5b61:	c6 45 b9 21          	movb   $0x21,-0x47(%ebp)
    5b65:	c6 45 ba 02          	movb   $0x2,-0x46(%ebp)
    5b69:	c6 45 bb 01          	movb   $0x1,-0x45(%ebp)
    5b6d:	c6 45 bc 00          	movb   $0x0,-0x44(%ebp)
    5b71:	c6 45 bd 12          	movb   $0x12,-0x43(%ebp)
    5b75:	c6 45 be 02          	movb   $0x2,-0x42(%ebp)
    5b79:	c6 45 bf 01          	movb   $0x1,-0x41(%ebp)
    5b7d:	c6 45 c0 00          	movb   $0x0,-0x40(%ebp)
    5b81:	c6 45 c1 02          	movb   $0x2,-0x3f(%ebp)
    5b85:	c6 45 c2 00          	movb   $0x0,-0x3e(%ebp)
    5b89:	c6 45 c3 22          	movb   $0x22,-0x3d(%ebp)

	unsigned char h5[31][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x13},{0x2,0x1},{0x0,0x31},{0x2,0x1},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x33}};
    5b8d:	c6 85 64 ff ff ff 02 	movb   $0x2,-0x9c(%ebp)
    5b94:	c6 85 65 ff ff ff 01 	movb   $0x1,-0x9b(%ebp)
    5b9b:	c6 85 66 ff ff ff 00 	movb   $0x0,-0x9a(%ebp)
    5ba2:	c6 85 67 ff ff ff 00 	movb   $0x0,-0x99(%ebp)
    5ba9:	c6 85 68 ff ff ff 04 	movb   $0x4,-0x98(%ebp)
    5bb0:	c6 85 69 ff ff ff 01 	movb   $0x1,-0x97(%ebp)
    5bb7:	c6 85 6a ff ff ff 02 	movb   $0x2,-0x96(%ebp)
    5bbe:	c6 85 6b ff ff ff 01 	movb   $0x1,-0x95(%ebp)
    5bc5:	c6 85 6c ff ff ff 00 	movb   $0x0,-0x94(%ebp)
    5bcc:	c6 85 6d ff ff ff 10 	movb   $0x10,-0x93(%ebp)
    5bd3:	c6 85 6e ff ff ff 00 	movb   $0x0,-0x92(%ebp)
    5bda:	c6 85 6f ff ff ff 01 	movb   $0x1,-0x91(%ebp)
    5be1:	c6 85 70 ff ff ff 02 	movb   $0x2,-0x90(%ebp)
    5be8:	c6 85 71 ff ff ff 01 	movb   $0x1,-0x8f(%ebp)
    5bef:	c6 85 72 ff ff ff 00 	movb   $0x0,-0x8e(%ebp)
    5bf6:	c6 85 73 ff ff ff 11 	movb   $0x11,-0x8d(%ebp)
    5bfd:	c6 85 74 ff ff ff 08 	movb   $0x8,-0x8c(%ebp)
    5c04:	c6 85 75 ff ff ff 01 	movb   $0x1,-0x8b(%ebp)
    5c0b:	c6 85 76 ff ff ff 04 	movb   $0x4,-0x8a(%ebp)
    5c12:	c6 85 77 ff ff ff 01 	movb   $0x1,-0x89(%ebp)
    5c19:	c6 85 78 ff ff ff 02 	movb   $0x2,-0x88(%ebp)
    5c20:	c6 85 79 ff ff ff 01 	movb   $0x1,-0x87(%ebp)
    5c27:	c6 85 7a ff ff ff 00 	movb   $0x0,-0x86(%ebp)
    5c2e:	c6 85 7b ff ff ff 20 	movb   $0x20,-0x85(%ebp)
    5c35:	c6 85 7c ff ff ff 00 	movb   $0x0,-0x84(%ebp)
    5c3c:	c6 85 7d ff ff ff 02 	movb   $0x2,-0x83(%ebp)
    5c43:	c6 85 7e ff ff ff 02 	movb   $0x2,-0x82(%ebp)
    5c4a:	c6 85 7f ff ff ff 01 	movb   $0x1,-0x81(%ebp)
    5c51:	c6 45 80 00          	movb   $0x0,-0x80(%ebp)
    5c55:	c6 45 81 21          	movb   $0x21,-0x7f(%ebp)
    5c59:	c6 45 82 00          	movb   $0x0,-0x7e(%ebp)
    5c5d:	c6 45 83 12          	movb   $0x12,-0x7d(%ebp)
    5c61:	c6 45 84 08          	movb   $0x8,-0x7c(%ebp)
    5c65:	c6 45 85 01          	movb   $0x1,-0x7b(%ebp)
    5c69:	c6 45 86 04          	movb   $0x4,-0x7a(%ebp)
    5c6d:	c6 45 87 01          	movb   $0x1,-0x79(%ebp)
    5c71:	c6 45 88 02          	movb   $0x2,-0x78(%ebp)
    5c75:	c6 45 89 01          	movb   $0x1,-0x77(%ebp)
    5c79:	c6 45 8a 00          	movb   $0x0,-0x76(%ebp)
    5c7d:	c6 45 8b 22          	movb   $0x22,-0x75(%ebp)
    5c81:	c6 45 8c 00          	movb   $0x0,-0x74(%ebp)
    5c85:	c6 45 8d 30          	movb   $0x30,-0x73(%ebp)
    5c89:	c6 45 8e 02          	movb   $0x2,-0x72(%ebp)
    5c8d:	c6 45 8f 01          	movb   $0x1,-0x71(%ebp)
    5c91:	c6 45 90 00          	movb   $0x0,-0x70(%ebp)
    5c95:	c6 45 91 03          	movb   $0x3,-0x6f(%ebp)
    5c99:	c6 45 92 00          	movb   $0x0,-0x6e(%ebp)
    5c9d:	c6 45 93 13          	movb   $0x13,-0x6d(%ebp)
    5ca1:	c6 45 94 02          	movb   $0x2,-0x6c(%ebp)
    5ca5:	c6 45 95 01          	movb   $0x1,-0x6b(%ebp)
    5ca9:	c6 45 96 00          	movb   $0x0,-0x6a(%ebp)
    5cad:	c6 45 97 31          	movb   $0x31,-0x69(%ebp)
    5cb1:	c6 45 98 02          	movb   $0x2,-0x68(%ebp)
    5cb5:	c6 45 99 01          	movb   $0x1,-0x67(%ebp)
    5cb9:	c6 45 9a 00          	movb   $0x0,-0x66(%ebp)
    5cbd:	c6 45 9b 32          	movb   $0x32,-0x65(%ebp)
    5cc1:	c6 45 9c 02          	movb   $0x2,-0x64(%ebp)
    5cc5:	c6 45 9d 01          	movb   $0x1,-0x63(%ebp)
    5cc9:	c6 45 9e 00          	movb   $0x0,-0x62(%ebp)
    5ccd:	c6 45 9f 23          	movb   $0x23,-0x61(%ebp)
    5cd1:	c6 45 a0 00          	movb   $0x0,-0x60(%ebp)
    5cd5:	c6 45 a1 33          	movb   $0x33,-0x5f(%ebp)

	unsigned char h6[31][2] = {{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x0,0x11},{0x6,0x1},{0x2,0x1},{0x0,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x6,0x1},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x2,0x1},{0x0,0x3},{0x0,0x33}};
    5cd9:	c6 85 26 ff ff ff 06 	movb   $0x6,-0xda(%ebp)
    5ce0:	c6 85 27 ff ff ff 01 	movb   $0x1,-0xd9(%ebp)
    5ce7:	c6 85 28 ff ff ff 04 	movb   $0x4,-0xd8(%ebp)
    5cee:	c6 85 29 ff ff ff 01 	movb   $0x1,-0xd7(%ebp)
    5cf5:	c6 85 2a ff ff ff 02 	movb   $0x2,-0xd6(%ebp)
    5cfc:	c6 85 2b ff ff ff 01 	movb   $0x1,-0xd5(%ebp)
    5d03:	c6 85 2c ff ff ff 00 	movb   $0x0,-0xd4(%ebp)
    5d0a:	c6 85 2d ff ff ff 00 	movb   $0x0,-0xd3(%ebp)
    5d11:	c6 85 2e ff ff ff 00 	movb   $0x0,-0xd2(%ebp)
    5d18:	c6 85 2f ff ff ff 10 	movb   $0x10,-0xd1(%ebp)
    5d1f:	c6 85 30 ff ff ff 00 	movb   $0x0,-0xd0(%ebp)
    5d26:	c6 85 31 ff ff ff 11 	movb   $0x11,-0xcf(%ebp)
    5d2d:	c6 85 32 ff ff ff 06 	movb   $0x6,-0xce(%ebp)
    5d34:	c6 85 33 ff ff ff 01 	movb   $0x1,-0xcd(%ebp)
    5d3b:	c6 85 34 ff ff ff 02 	movb   $0x2,-0xcc(%ebp)
    5d42:	c6 85 35 ff ff ff 01 	movb   $0x1,-0xcb(%ebp)
    5d49:	c6 85 36 ff ff ff 00 	movb   $0x0,-0xca(%ebp)
    5d50:	c6 85 37 ff ff ff 01 	movb   $0x1,-0xc9(%ebp)
    5d57:	c6 85 38 ff ff ff 02 	movb   $0x2,-0xc8(%ebp)
    5d5e:	c6 85 39 ff ff ff 01 	movb   $0x1,-0xc7(%ebp)
    5d65:	c6 85 3a ff ff ff 00 	movb   $0x0,-0xc6(%ebp)
    5d6c:	c6 85 3b ff ff ff 20 	movb   $0x20,-0xc5(%ebp)
    5d73:	c6 85 3c ff ff ff 00 	movb   $0x0,-0xc4(%ebp)
    5d7a:	c6 85 3d ff ff ff 21 	movb   $0x21,-0xc3(%ebp)
    5d81:	c6 85 3e ff ff ff 06 	movb   $0x6,-0xc2(%ebp)
    5d88:	c6 85 3f ff ff ff 01 	movb   $0x1,-0xc1(%ebp)
    5d8f:	c6 85 40 ff ff ff 02 	movb   $0x2,-0xc0(%ebp)
    5d96:	c6 85 41 ff ff ff 01 	movb   $0x1,-0xbf(%ebp)
    5d9d:	c6 85 42 ff ff ff 00 	movb   $0x0,-0xbe(%ebp)
    5da4:	c6 85 43 ff ff ff 12 	movb   $0x12,-0xbd(%ebp)
    5dab:	c6 85 44 ff ff ff 02 	movb   $0x2,-0xbc(%ebp)
    5db2:	c6 85 45 ff ff ff 01 	movb   $0x1,-0xbb(%ebp)
    5db9:	c6 85 46 ff ff ff 00 	movb   $0x0,-0xba(%ebp)
    5dc0:	c6 85 47 ff ff ff 02 	movb   $0x2,-0xb9(%ebp)
    5dc7:	c6 85 48 ff ff ff 00 	movb   $0x0,-0xb8(%ebp)
    5dce:	c6 85 49 ff ff ff 22 	movb   $0x22,-0xb7(%ebp)
    5dd5:	c6 85 4a ff ff ff 04 	movb   $0x4,-0xb6(%ebp)
    5ddc:	c6 85 4b ff ff ff 01 	movb   $0x1,-0xb5(%ebp)
    5de3:	c6 85 4c ff ff ff 02 	movb   $0x2,-0xb4(%ebp)
    5dea:	c6 85 4d ff ff ff 01 	movb   $0x1,-0xb3(%ebp)
    5df1:	c6 85 4e ff ff ff 00 	movb   $0x0,-0xb2(%ebp)
    5df8:	c6 85 4f ff ff ff 31 	movb   $0x31,-0xb1(%ebp)
    5dff:	c6 85 50 ff ff ff 00 	movb   $0x0,-0xb0(%ebp)
    5e06:	c6 85 51 ff ff ff 13 	movb   $0x13,-0xaf(%ebp)
    5e0d:	c6 85 52 ff ff ff 04 	movb   $0x4,-0xae(%ebp)
    5e14:	c6 85 53 ff ff ff 01 	movb   $0x1,-0xad(%ebp)
    5e1b:	c6 85 54 ff ff ff 02 	movb   $0x2,-0xac(%ebp)
    5e22:	c6 85 55 ff ff ff 01 	movb   $0x1,-0xab(%ebp)
    5e29:	c6 85 56 ff ff ff 00 	movb   $0x0,-0xaa(%ebp)
    5e30:	c6 85 57 ff ff ff 30 	movb   $0x30,-0xa9(%ebp)
    5e37:	c6 85 58 ff ff ff 00 	movb   $0x0,-0xa8(%ebp)
    5e3e:	c6 85 59 ff ff ff 32 	movb   $0x32,-0xa7(%ebp)
    5e45:	c6 85 5a ff ff ff 02 	movb   $0x2,-0xa6(%ebp)
    5e4c:	c6 85 5b ff ff ff 01 	movb   $0x1,-0xa5(%ebp)
    5e53:	c6 85 5c ff ff ff 00 	movb   $0x0,-0xa4(%ebp)
    5e5a:	c6 85 5d ff ff ff 23 	movb   $0x23,-0xa3(%ebp)
    5e61:	c6 85 5e ff ff ff 02 	movb   $0x2,-0xa2(%ebp)
    5e68:	c6 85 5f ff ff ff 01 	movb   $0x1,-0xa1(%ebp)
    5e6f:	c6 85 60 ff ff ff 00 	movb   $0x0,-0xa0(%ebp)
    5e76:	c6 85 61 ff ff ff 03 	movb   $0x3,-0x9f(%ebp)
    5e7d:	c6 85 62 ff ff ff 00 	movb   $0x0,-0x9e(%ebp)
    5e84:	c6 85 63 ff ff ff 33 	movb   $0x33,-0x9d(%ebp)

	unsigned char h7[71][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x21},{0x12,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x3},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x4},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x41},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x43},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x34},{0x0,0x5},{0x0,0x51},{0x6,0x1},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x4,0x1},{0x2,0x1},{0x0,0x53},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x55}};
    5e8b:	8d 95 98 fe ff ff    	lea    -0x168(%ebp),%edx
    5e91:	b8 20 b5 00 00       	mov    $0xb520,%eax
    5e96:	b9 23 00 00 00       	mov    $0x23,%ecx
    5e9b:	89 d7                	mov    %edx,%edi
    5e9d:	89 c6                	mov    %eax,%esi
    5e9f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    5ea1:	89 f0                	mov    %esi,%eax
    5ea3:	89 fa                	mov    %edi,%edx
    5ea5:	0f b7 08             	movzwl (%eax),%ecx
    5ea8:	66 89 0a             	mov    %cx,(%edx)
    5eab:	83 c2 02             	add    $0x2,%edx
    5eae:	83 c0 02             	add    $0x2,%eax

	unsigned char h8[71][2] = {{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x22},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x2,0x1},{0x0,0x41},{0x2,0x1},{0x0,0x14},{0x0,0x42},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x24},{0x2,0x1},{0x0,0x33},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x6,0x1},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x6,0x1},{0x2,0x1},{0x0,0x25},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x2,0x1},{0x0,0x53},{0x2,0x1},{0x0,0x45},{0x2,0x1},{0x0,0x54},{0x0,0x55}};
    5eb1:	8d 85 0a fe ff ff    	lea    -0x1f6(%ebp),%eax
    5eb7:	ba c0 b5 00 00       	mov    $0xb5c0,%edx
    5ebc:	bb 8e 00 00 00       	mov    $0x8e,%ebx
    5ec1:	89 c1                	mov    %eax,%ecx
    5ec3:	83 e1 02             	and    $0x2,%ecx
    5ec6:	85 c9                	test   %ecx,%ecx
    5ec8:	74 0f                	je     5ed9 <read_decoder_table+0x4a0>
    5eca:	0f b7 0a             	movzwl (%edx),%ecx
    5ecd:	66 89 08             	mov    %cx,(%eax)
    5ed0:	83 c0 02             	add    $0x2,%eax
    5ed3:	83 c2 02             	add    $0x2,%edx
    5ed6:	83 eb 02             	sub    $0x2,%ebx
    5ed9:	89 d9                	mov    %ebx,%ecx
    5edb:	c1 e9 02             	shr    $0x2,%ecx
    5ede:	89 c7                	mov    %eax,%edi
    5ee0:	89 d6                	mov    %edx,%esi
    5ee2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    5ee4:	89 f2                	mov    %esi,%edx
    5ee6:	89 f8                	mov    %edi,%eax
    5ee8:	b9 00 00 00 00       	mov    $0x0,%ecx
    5eed:	89 de                	mov    %ebx,%esi
    5eef:	83 e6 02             	and    $0x2,%esi
    5ef2:	85 f6                	test   %esi,%esi
    5ef4:	74 0b                	je     5f01 <read_decoder_table+0x4c8>
    5ef6:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    5efa:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    5efe:	83 c1 02             	add    $0x2,%ecx
    5f01:	83 e3 01             	and    $0x1,%ebx
    5f04:	85 db                	test   %ebx,%ebx
    5f06:	74 07                	je     5f0f <read_decoder_table+0x4d6>
    5f08:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    5f0c:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h9[71][2] = {{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x0,0x31},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x50},{0x0,0x43},{0x2,0x1},{0x0,0x34},{0x0,0x51},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x15},{0x0,0x52},{0x2,0x1},{0x0,0x25},{0x0,0x44},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x54},{0x0,0x53},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x45},{0x0,0x55}};
    5f0f:	8d 95 7c fd ff ff    	lea    -0x284(%ebp),%edx
    5f15:	b8 60 b6 00 00       	mov    $0xb660,%eax
    5f1a:	b9 23 00 00 00       	mov    $0x23,%ecx
    5f1f:	89 d7                	mov    %edx,%edi
    5f21:	89 c6                	mov    %eax,%esi
    5f23:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    5f25:	89 f0                	mov    %esi,%eax
    5f27:	89 fa                	mov    %edi,%edx
    5f29:	0f b7 08             	movzwl (%eax),%ecx
    5f2c:	66 89 0a             	mov    %cx,(%edx)
    5f2f:	83 c2 02             	add    $0x2,%edx
    5f32:	83 c0 02             	add    $0x2,%eax

	unsigned char h10[127][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0xa,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x1c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x3},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x40},{0x4,0x1},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x1c,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x0,0x60},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x36},{0x0,0x71},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x17},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x0,0x6},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x35},{0x0,0x45},{0x0,0x62},{0x2,0x1},{0x0,0x70},{0x2,0x1},{0x0,0x7},{0x0,0x64},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x6,0x1},{0x2,0x1},{0x0,0x63},{0x2,0x1},{0x0,0x54},{0x0,0x55},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x37},{0x0,0x65},{0x2,0x1},{0x0,0x56},{0x0,0x74},{0x6,0x1},{0x2,0x1},{0x0,0x47},{0x2,0x1},{0x0,0x66},{0x0,0x75},{0x4,0x1},{0x2,0x1},{0x0,0x57},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    5f35:	8d 85 7e fc ff ff    	lea    -0x382(%ebp),%eax
    5f3b:	ba 00 b7 00 00       	mov    $0xb700,%edx
    5f40:	bb fe 00 00 00       	mov    $0xfe,%ebx
    5f45:	89 c1                	mov    %eax,%ecx
    5f47:	83 e1 02             	and    $0x2,%ecx
    5f4a:	85 c9                	test   %ecx,%ecx
    5f4c:	74 0f                	je     5f5d <read_decoder_table+0x524>
    5f4e:	0f b7 0a             	movzwl (%edx),%ecx
    5f51:	66 89 08             	mov    %cx,(%eax)
    5f54:	83 c0 02             	add    $0x2,%eax
    5f57:	83 c2 02             	add    $0x2,%edx
    5f5a:	83 eb 02             	sub    $0x2,%ebx
    5f5d:	89 d9                	mov    %ebx,%ecx
    5f5f:	c1 e9 02             	shr    $0x2,%ecx
    5f62:	89 c7                	mov    %eax,%edi
    5f64:	89 d6                	mov    %edx,%esi
    5f66:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    5f68:	89 f2                	mov    %esi,%edx
    5f6a:	89 f8                	mov    %edi,%eax
    5f6c:	b9 00 00 00 00       	mov    $0x0,%ecx
    5f71:	89 de                	mov    %ebx,%esi
    5f73:	83 e6 02             	and    $0x2,%esi
    5f76:	85 f6                	test   %esi,%esi
    5f78:	74 0b                	je     5f85 <read_decoder_table+0x54c>
    5f7a:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    5f7e:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    5f82:	83 c1 02             	add    $0x2,%ecx
    5f85:	83 e3 01             	and    $0x1,%ebx
    5f88:	85 db                	test   %ebx,%ebx
    5f8a:	74 07                	je     5f93 <read_decoder_table+0x55a>
    5f8c:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    5f90:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h11[127][2] = {{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x12},{0x18,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x21},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x1e,0x1},{0x10,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x43},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x34},{0x0,0x51},{0x0,0x61},{0x6,0x1},{0x2,0x1},{0x0,0x16},{0x2,0x1},{0x0,0x6},{0x0,0x26},{0x2,0x1},{0x0,0x62},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x10,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x25},{0x0,0x44},{0x0,0x60},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x17},{0x0,0x71},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x7},{0x0,0x64},{0x0,0x72},{0x2,0x1},{0x0,0x27},{0x4,0x1},{0x2,0x1},{0x0,0x53},{0x0,0x35},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x2,0x1},{0x0,0x65},{0x0,0x56},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x55},{0x0,0x57},{0x0,0x74},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    5f93:	8d 95 80 fb ff ff    	lea    -0x480(%ebp),%edx
    5f99:	b8 00 b8 00 00       	mov    $0xb800,%eax
    5f9e:	b9 3f 00 00 00       	mov    $0x3f,%ecx
    5fa3:	89 d7                	mov    %edx,%edi
    5fa5:	89 c6                	mov    %eax,%esi
    5fa7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    5fa9:	89 f0                	mov    %esi,%eax
    5fab:	89 fa                	mov    %edi,%edx
    5fad:	0f b7 08             	movzwl (%eax),%ecx
    5fb0:	66 89 0a             	mov    %cx,(%edx)
    5fb3:	83 c2 02             	add    $0x2,%edx
    5fb6:	83 c0 02             	add    $0x2,%eax

	unsigned char h12[127][2] = {{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x10,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x31},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x40},{0x1a,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x2,0x1},{0x0,0x41},{0x0,0x33},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x14},{0x0,0x42},{0x2,0x1},{0x0,0x24},{0x2,0x1},{0x0,0x4},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x1c,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x2,0x1},{0x0,0x53},{0x0,0x35},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x16},{0x0,0x61},{0x4,0x1},{0x2,0x1},{0x0,0x62},{0x0,0x26},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x6},{0x0,0x44},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x0,0x71},{0x4,0x1},{0x2,0x1},{0x0,0x17},{0x0,0x64},{0x2,0x1},{0x0,0x46},{0x0,0x72},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x27},{0x2,0x1},{0x0,0x55},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x0,0x56},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x65},{0x0,0x74},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    5fb9:	8d 85 82 fa ff ff    	lea    -0x57e(%ebp),%eax
    5fbf:	ba 00 b9 00 00       	mov    $0xb900,%edx
    5fc4:	bb fe 00 00 00       	mov    $0xfe,%ebx
    5fc9:	89 c1                	mov    %eax,%ecx
    5fcb:	83 e1 02             	and    $0x2,%ecx
    5fce:	85 c9                	test   %ecx,%ecx
    5fd0:	74 0f                	je     5fe1 <read_decoder_table+0x5a8>
    5fd2:	0f b7 0a             	movzwl (%edx),%ecx
    5fd5:	66 89 08             	mov    %cx,(%eax)
    5fd8:	83 c0 02             	add    $0x2,%eax
    5fdb:	83 c2 02             	add    $0x2,%edx
    5fde:	83 eb 02             	sub    $0x2,%ebx
    5fe1:	89 d9                	mov    %ebx,%ecx
    5fe3:	c1 e9 02             	shr    $0x2,%ecx
    5fe6:	89 c7                	mov    %eax,%edi
    5fe8:	89 d6                	mov    %edx,%esi
    5fea:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    5fec:	89 f2                	mov    %esi,%edx
    5fee:	89 f8                	mov    %edi,%eax
    5ff0:	b9 00 00 00 00       	mov    $0x0,%ecx
    5ff5:	89 de                	mov    %ebx,%esi
    5ff7:	83 e6 02             	and    $0x2,%esi
    5ffa:	85 f6                	test   %esi,%esi
    5ffc:	74 0b                	je     6009 <read_decoder_table+0x5d0>
    5ffe:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    6002:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    6006:	83 c1 02             	add    $0x2,%ecx
    6009:	83 e3 01             	and    $0x1,%ebx
    600c:	85 db                	test   %ebx,%ebx
    600e:	74 07                	je     6017 <read_decoder_table+0x5de>
    6010:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    6014:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h13[511][2] = {{0x2,0x1},{0x0,0x0},{0x6,0x1},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0x1c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x31},{0x6,0x1},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x46,0x1},{0x1c,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x4,0x1},{0x2,0x1},{0x0,0x24},{0x0,0x50},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x4,0x1},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x2,0x1},{0x0,0x25},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0x4,0x1},{0x2,0x1},{0x0,0x80},{0x0,0x8},{0x0,0x81},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x35},{0x0,0x62},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x4,0x1},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0x2,0x1},{0x0,0x36},{0x0,0x70},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x7},{0x0,0x55},{0x0,0x71},{0x2,0x1},{0x0,0x17},{0x2,0x1},{0x0,0x27},{0x0,0x37},{0x48,0x1},{0x18,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x18},{0x0,0x82},{0x2,0x1},{0x0,0x28},{0x4,0x1},{0x2,0x1},{0x0,0x64},{0x0,0x46},{0x0,0x72},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x2,0x1},{0x0,0x90},{0x0,0x9},{0x2,0x1},{0x0,0x91},{0x0,0x19},{0x18,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x73},{0x0,0x65},{0x2,0x1},{0x0,0x56},{0x0,0x74},{0x4,0x1},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x0,0x83},{0x6,0x1},{0x2,0x1},{0x0,0x38},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x92},{0x0,0x29},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x67},{0x0,0x85},{0x2,0x1},{0x0,0x58},{0x0,0x39},{0x2,0x1},{0x0,0x93},{0x2,0x1},{0x0,0x49},{0x0,0x86},{0x6,0x1},{0x2,0x1},{0x0,0xa0},{0x2,0x1},{0x0,0x68},{0x0,0xa},{0x2,0x1},{0x0,0xa1},{0x0,0x1a},{0x44,0x1},{0x18,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x4,0x1},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x2,0x1},{0x0,0xa3},{0x0,0x3a},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4a},{0x0,0x96},{0x2,0x1},{0x0,0xb0},{0x0,0xb},{0x2,0x1},{0x0,0xb1},{0x0,0x1b},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0xb2},{0x4,0x1},{0x2,0x1},{0x0,0x76},{0x0,0x77},{0x0,0x94},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x87},{0x0,0x78},{0x0,0xa4},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xa5},{0x0,0x2b},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5a},{0x0,0x88},{0x0,0xb3},{0x2,0x1},{0x0,0x3b},{0x2,0x1},{0x0,0x79},{0x0,0xa6},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x6a},{0x0,0xb4},{0x0,0xc0},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0x98},{0x0,0xc1},{0x3c,0x1},{0x16,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x1c},{0x2,0x1},{0x0,0x89},{0x0,0xb5},{0x2,0x1},{0x0,0x5b},{0x0,0xc2},{0x4,0x1},{0x2,0x1},{0x0,0x2c},{0x0,0x3c},{0x4,0x1},{0x2,0x1},{0x0,0xb6},{0x0,0x6b},{0x2,0x1},{0x0,0xc4},{0x0,0x4c},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa8},{0x0,0x8a},{0x2,0x1},{0x0,0xd0},{0x0,0xd},{0x2,0x1},{0x0,0xd1},{0x2,0x1},{0x0,0x4b},{0x2,0x1},{0x0,0x97},{0x0,0xa7},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xc3},{0x2,0x1},{0x0,0x7a},{0x0,0x99},{0x4,0x1},{0x2,0x1},{0x0,0xc5},{0x0,0x5c},{0x0,0xb7},{0x4,0x1},{0x2,0x1},{0x0,0x1d},{0x0,0xd2},{0x2,0x1},{0x0,0x2d},{0x2,0x1},{0x0,0x7b},{0x0,0xd3},{0x34,0x1},{0x1c,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x4,0x1},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x2,0x1},{0x0,0x9a},{0x0,0xd4},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb8},{0x0,0x8b},{0x2,0x1},{0x0,0x4d},{0x0,0xc7},{0x4,0x1},{0x2,0x1},{0x0,0x7c},{0x0,0xd5},{0x2,0x1},{0x0,0x5d},{0x0,0xe0},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe1},{0x0,0x1e},{0x4,0x1},{0x2,0x1},{0x0,0xe},{0x0,0x2e},{0x0,0xe2},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe3},{0x0,0x6d},{0x2,0x1},{0x0,0x8c},{0x0,0xe4},{0x4,0x1},{0x2,0x1},{0x0,0xe5},{0x0,0xba},{0x0,0xf0},{0x26,0x1},{0x10,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf1},{0x0,0x1f},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xaa},{0x0,0x9b},{0x0,0xb9},{0x2,0x1},{0x0,0x3e},{0x2,0x1},{0x0,0xd6},{0x0,0xc8},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x4e},{0x2,0x1},{0x0,0xd7},{0x0,0x7d},{0x2,0x1},{0x0,0xab},{0x2,0x1},{0x0,0x5e},{0x0,0xc9},{0x6,0x1},{0x2,0x1},{0x0,0xf},{0x2,0x1},{0x0,0x9c},{0x0,0x6e},{0x2,0x1},{0x0,0xf2},{0x0,0x2f},{0x20,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0x8d},{0x0,0x3f},{0x6,0x1},{0x2,0x1},{0x0,0xf3},{0x2,0x1},{0x0,0xe6},{0x0,0xca},{0x2,0x1},{0x0,0xf4},{0x0,0x4f},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbb},{0x0,0xac},{0x2,0x1},{0x0,0xe7},{0x0,0xf5},{0x4,0x1},{0x2,0x1},{0x0,0xd9},{0x0,0x9d},{0x2,0x1},{0x0,0x5f},{0x0,0xe8},{0x1e,0x1},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x6f},{0x2,0x1},{0x0,0xf6},{0x0,0xcb},{0x4,0x1},{0x2,0x1},{0x0,0xbc},{0x0,0xad},{0x0,0xda},{0x8,0x1},{0x2,0x1},{0x0,0xf7},{0x4,0x1},{0x2,0x1},{0x0,0x7e},{0x0,0x7f},{0x0,0x8e},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xae},{0x0,0xcc},{0x2,0x1},{0x0,0xf8},{0x0,0x8f},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x2,0x1},{0x0,0xea},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xeb},{0x2,0x1},{0x0,0xbe},{0x2,0x1},{0x0,0xcd},{0x0,0xfa},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe9},{0x0,0xaf},{0x0,0xdc},{0x2,0x1},{0x0,0xce},{0x0,0xfb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbf},{0x0,0xde},{0x2,0x1},{0x0,0xcf},{0x0,0xee},{0x4,0x1},{0x2,0x1},{0x0,0xdf},{0x0,0xef},{0x2,0x1},{0x0,0xff},{0x2,0x1},{0x0,0xed},{0x2,0x1},{0x0,0xfd},{0x2,0x1},{0x0,0xfc},{0x0,0xfe}};
    6017:	8d 95 84 f6 ff ff    	lea    -0x97c(%ebp),%edx
    601d:	b8 00 ba 00 00       	mov    $0xba00,%eax
    6022:	b9 ff 00 00 00       	mov    $0xff,%ecx
    6027:	89 d7                	mov    %edx,%edi
    6029:	89 c6                	mov    %eax,%esi
    602b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    602d:	89 f0                	mov    %esi,%eax
    602f:	89 fa                	mov    %edi,%edx
    6031:	0f b7 08             	movzwl (%eax),%ecx
    6034:	66 89 0a             	mov    %cx,(%edx)
    6037:	83 c2 02             	add    $0x2,%edx
    603a:	83 c0 02             	add    $0x2,%eax

	unsigned char h15[511][2] = {{0x10,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x32,0x1},{0x10,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x31},{0x6,0x1},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x3},{0x0,0x40},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x14},{0x0,0x41},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x2,0x1},{0x0,0x24},{0x0,0x43},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x34},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x0,0x61},{0x5a,0x1},{0x24,0x1},{0x12,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x2,0x1},{0x0,0x16},{0x0,0x62},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x36},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x2,0x1},{0x0,0x71},{0x0,0x55},{0x4,0x1},{0x2,0x1},{0x0,0x17},{0x0,0x64},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x18,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x0,0x65},{0x4,0x1},{0x2,0x1},{0x0,0x56},{0x0,0x80},{0x2,0x1},{0x0,0x8},{0x0,0x74},{0x4,0x1},{0x2,0x1},{0x0,0x81},{0x0,0x18},{0x2,0x1},{0x0,0x82},{0x0,0x28},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x90},{0x0,0x19},{0x0,0x91},{0x4,0x1},{0x2,0x1},{0x0,0x92},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x29},{0x5c,0x1},{0x24,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x4,0x1},{0x2,0x1},{0x0,0x9},{0x0,0x77},{0x0,0x93},{0x4,0x1},{0x2,0x1},{0x0,0x39},{0x0,0x94},{0x2,0x1},{0x0,0x49},{0x0,0x86},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x68},{0x2,0x1},{0x0,0xa0},{0x0,0xa},{0x2,0x1},{0x0,0xa1},{0x0,0x1a},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x1a,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xa3},{0x2,0x1},{0x0,0x3a},{0x0,0x87},{0x4,0x1},{0x2,0x1},{0x0,0x78},{0x0,0xa4},{0x2,0x1},{0x0,0x4a},{0x0,0x96},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xb0},{0x0,0xb1},{0x4,0x1},{0x2,0x1},{0x0,0x1b},{0x0,0xa5},{0x0,0xb2},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5a},{0x0,0x2b},{0x2,0x1},{0x0,0x88},{0x0,0x97},{0x2,0x1},{0x0,0xb3},{0x2,0x1},{0x0,0x79},{0x0,0x3b},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x6a},{0x0,0xb4},{0x2,0x1},{0x0,0x4b},{0x0,0xc1},{0x4,0x1},{0x2,0x1},{0x0,0x98},{0x0,0x89},{0x2,0x1},{0x0,0x1c},{0x0,0xb5},{0x50,0x1},{0x22,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5b},{0x0,0x2c},{0x0,0xc2},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb},{0x0,0xc0},{0x0,0xa6},{0x2,0x1},{0x0,0xa7},{0x0,0x7a},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc3},{0x0,0x3c},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0x99},{0x0,0xb6},{0x4,0x1},{0x2,0x1},{0x0,0x6b},{0x0,0xc4},{0x2,0x1},{0x0,0x4c},{0x0,0xa8},{0x14,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8a},{0x0,0xc5},{0x4,0x1},{0x2,0x1},{0x0,0xd0},{0x0,0x5c},{0x0,0xd1},{0x4,0x1},{0x2,0x1},{0x0,0xb7},{0x0,0x7b},{0x2,0x1},{0x0,0x1d},{0x2,0x1},{0x0,0xd},{0x0,0x2d},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd2},{0x0,0xd3},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9a},{0x0,0xb8},{0x0,0xd4},{0x4,0x1},{0x2,0x1},{0x0,0x8b},{0x0,0x4d},{0x2,0x1},{0x0,0xc7},{0x0,0x7c},{0x44,0x1},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd5},{0x0,0x5d},{0x4,0x1},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x0,0xe1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0xe2},{0x2,0x1},{0x0,0xaa},{0x0,0x2e},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb9},{0x0,0x9b},{0x2,0x1},{0x0,0xe3},{0x0,0xd6},{0x4,0x1},{0x2,0x1},{0x0,0x6d},{0x0,0x3e},{0x2,0x1},{0x0,0xc8},{0x0,0x8c},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe4},{0x0,0x4e},{0x2,0x1},{0x0,0xd7},{0x0,0x7d},{0x4,0x1},{0x2,0x1},{0x0,0xe5},{0x0,0xba},{0x2,0x1},{0x0,0xab},{0x0,0x5e},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc9},{0x0,0x9c},{0x2,0x1},{0x0,0xf1},{0x0,0x1f},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf0},{0x0,0x6e},{0x0,0xf2},{0x2,0x1},{0x0,0x2f},{0x0,0xe6},{0x26,0x1},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0xf3},{0x2,0x1},{0x0,0x3f},{0x0,0xf4},{0x6,0x1},{0x2,0x1},{0x0,0x4f},{0x2,0x1},{0x0,0x8d},{0x0,0xd9},{0x2,0x1},{0x0,0xbb},{0x0,0xca},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xac},{0x0,0xe7},{0x2,0x1},{0x0,0x7e},{0x0,0xf5},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9d},{0x0,0x5f},{0x2,0x1},{0x0,0xe8},{0x0,0x8e},{0x2,0x1},{0x0,0xf6},{0x0,0xcb},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf},{0x0,0xae},{0x0,0x6f},{0x2,0x1},{0x0,0xbc},{0x0,0xda},{0x4,0x1},{0x2,0x1},{0x0,0xad},{0x0,0xf7},{0x2,0x1},{0x0,0x7f},{0x0,0xe9},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xcc},{0x2,0x1},{0x0,0xf8},{0x0,0x8f},{0x4,0x1},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x2,0x1},{0x0,0xea},{0x0,0xf9},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xdc},{0x2,0x1},{0x0,0xcd},{0x0,0xeb},{0x4,0x1},{0x2,0x1},{0x0,0xbe},{0x0,0xfa},{0x2,0x1},{0x0,0xaf},{0x0,0xdd},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xec},{0x0,0xce},{0x0,0xfb},{0x4,0x1},{0x2,0x1},{0x0,0xbf},{0x0,0xed},{0x2,0x1},{0x0,0xde},{0x0,0xfc},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xcf},{0x0,0xfd},{0x0,0xee},{0x4,0x1},{0x2,0x1},{0x0,0xdf},{0x0,0xfe},{0x2,0x1},{0x0,0xef},{0x0,0xff}};
    603d:	8d 85 86 f2 ff ff    	lea    -0xd7a(%ebp),%eax
    6043:	ba 00 be 00 00       	mov    $0xbe00,%edx
    6048:	bb fe 03 00 00       	mov    $0x3fe,%ebx
    604d:	89 c1                	mov    %eax,%ecx
    604f:	83 e1 02             	and    $0x2,%ecx
    6052:	85 c9                	test   %ecx,%ecx
    6054:	74 0f                	je     6065 <read_decoder_table+0x62c>
    6056:	0f b7 0a             	movzwl (%edx),%ecx
    6059:	66 89 08             	mov    %cx,(%eax)
    605c:	83 c0 02             	add    $0x2,%eax
    605f:	83 c2 02             	add    $0x2,%edx
    6062:	83 eb 02             	sub    $0x2,%ebx
    6065:	89 d9                	mov    %ebx,%ecx
    6067:	c1 e9 02             	shr    $0x2,%ecx
    606a:	89 c7                	mov    %eax,%edi
    606c:	89 d6                	mov    %edx,%esi
    606e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    6070:	89 f2                	mov    %esi,%edx
    6072:	89 f8                	mov    %edi,%eax
    6074:	b9 00 00 00 00       	mov    $0x0,%ecx
    6079:	89 de                	mov    %ebx,%esi
    607b:	83 e6 02             	and    $0x2,%esi
    607e:	85 f6                	test   %esi,%esi
    6080:	74 0b                	je     608d <read_decoder_table+0x654>
    6082:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    6086:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    608a:	83 c1 02             	add    $0x2,%ecx
    608d:	83 e3 01             	and    $0x1,%ebx
    6090:	85 db                	test   %ebx,%ebx
    6092:	74 07                	je     609b <read_decoder_table+0x662>
    6094:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    6098:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h16[511][2] = {{0x2,0x1},{0x0,0x0},{0x6,0x1},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0x2a,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x6,0x1},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x4,0x1},{0x2,0x1},{0x0,0x24},{0x0,0x50},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x8a,0x1},{0x28,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x15},{0x0,0x51},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x0,0x53},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x0,0x61},{0x2,0x1},{0x0,0x16},{0x0,0x62},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0x4,0x1},{0x2,0x1},{0x0,0x36},{0x0,0x70},{0x0,0x71},{0x28,0x1},{0x12,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x17},{0x2,0x1},{0x0,0x7},{0x2,0x1},{0x0,0x55},{0x0,0x64},{0x4,0x1},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x65},{0x0,0x73},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x37},{0x2,0x1},{0x0,0x56},{0x0,0x8},{0x2,0x1},{0x0,0x80},{0x0,0x81},{0x6,0x1},{0x2,0x1},{0x0,0x18},{0x2,0x1},{0x0,0x74},{0x0,0x47},{0x2,0x1},{0x0,0x82},{0x2,0x1},{0x0,0x28},{0x0,0x66},{0x18,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x2,0x1},{0x0,0x75},{0x0,0x84},{0x4,0x1},{0x2,0x1},{0x0,0x48},{0x0,0x90},{0x0,0x91},{0x6,0x1},{0x2,0x1},{0x0,0x19},{0x2,0x1},{0x0,0x9},{0x0,0x76},{0x2,0x1},{0x0,0x92},{0x0,0x29},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x2,0x1},{0x0,0x93},{0x0,0x39},{0x4,0x1},{0x2,0x1},{0x0,0xa0},{0x0,0xa},{0x0,0x1a},{0x8,0x1},{0x2,0x1},{0x0,0xa2},{0x2,0x1},{0x0,0x67},{0x2,0x1},{0x0,0x57},{0x0,0x49},{0x6,0x1},{0x2,0x1},{0x0,0x94},{0x2,0x1},{0x0,0x77},{0x0,0x86},{0x2,0x1},{0x0,0xa1},{0x2,0x1},{0x0,0x68},{0x0,0x95},{0xdc,0x1},{0x7e,0x1},{0x32,0x1},{0x1a,0x1},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x2a},{0x2,0x1},{0x0,0x59},{0x0,0x3a},{0x2,0x1},{0x0,0xa3},{0x2,0x1},{0x0,0x87},{0x0,0x78},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa4},{0x0,0x4a},{0x2,0x1},{0x0,0x96},{0x0,0x69},{0x4,0x1},{0x2,0x1},{0x0,0xb0},{0x0,0xb},{0x0,0xb1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1b},{0x0,0xb2},{0x2,0x1},{0x0,0x2b},{0x2,0x1},{0x0,0xa5},{0x0,0x5a},{0x6,0x1},{0x2,0x1},{0x0,0xb3},{0x2,0x1},{0x0,0xa6},{0x0,0x6a},{0x4,0x1},{0x2,0x1},{0x0,0xb4},{0x0,0x4b},{0x2,0x1},{0x0,0xc},{0x0,0xc1},{0x1e,0x1},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb5},{0x0,0xc2},{0x0,0x2c},{0x4,0x1},{0x2,0x1},{0x0,0xa7},{0x0,0xc3},{0x2,0x1},{0x0,0x6b},{0x0,0xc4},{0x8,0x1},{0x2,0x1},{0x0,0x1d},{0x4,0x1},{0x2,0x1},{0x0,0x88},{0x0,0x97},{0x0,0x3b},{0x4,0x1},{0x2,0x1},{0x0,0xd1},{0x0,0xd2},{0x2,0x1},{0x0,0x2d},{0x0,0xd3},{0x12,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0x2e},{0x0,0xe2},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x79},{0x0,0x98},{0x0,0xc0},{0x2,0x1},{0x0,0x1c},{0x2,0x1},{0x0,0x89},{0x0,0x5b},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3c},{0x2,0x1},{0x0,0x7a},{0x0,0xb6},{0x4,0x1},{0x2,0x1},{0x0,0x4c},{0x0,0x99},{0x2,0x1},{0x0,0xa8},{0x0,0x8a},{0x6,0x1},{0x2,0x1},{0x0,0xd},{0x2,0x1},{0x0,0xc5},{0x0,0x5c},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x2,0x1},{0x0,0x6c},{0x0,0x9a},{0x58,0x1},{0x56,0x1},{0x24,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8b},{0x0,0x4d},{0x2,0x1},{0x0,0xc7},{0x0,0x7c},{0x4,0x1},{0x2,0x1},{0x0,0xd5},{0x0,0x5d},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x8,0x1},{0x2,0x1},{0x0,0xe3},{0x4,0x1},{0x2,0x1},{0x0,0xd0},{0x0,0xb7},{0x0,0x7b},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa9},{0x0,0xb8},{0x0,0xd4},{0x2,0x1},{0x0,0xe1},{0x2,0x1},{0x0,0xaa},{0x0,0xb9},{0x18,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9b},{0x0,0xd6},{0x0,0x6d},{0x2,0x1},{0x0,0x3e},{0x0,0xc8},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8c},{0x0,0xe4},{0x0,0x4e},{0x4,0x1},{0x2,0x1},{0x0,0xd7},{0x0,0xe5},{0x2,0x1},{0x0,0xba},{0x0,0xab},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9c},{0x0,0xe6},{0x4,0x1},{0x2,0x1},{0x0,0x6e},{0x0,0xd8},{0x2,0x1},{0x0,0x8d},{0x0,0xbb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe7},{0x0,0x9d},{0x2,0x1},{0x0,0xe8},{0x0,0x8e},{0x4,0x1},{0x2,0x1},{0x0,0xcb},{0x0,0xbc},{0x0,0x9e},{0x0,0xf1},{0x2,0x1},{0x0,0x1f},{0x2,0x1},{0x0,0xf},{0x0,0x2f},{0x42,0x1},{0x38,0x1},{0x2,0x1},{0x0,0xf2},{0x34,0x1},{0x32,0x1},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0xbd},{0x2,0x1},{0x0,0x5e},{0x2,0x1},{0x0,0x7d},{0x0,0xc9},{0x6,0x1},{0x2,0x1},{0x0,0xca},{0x2,0x1},{0x0,0xac},{0x0,0x7e},{0x4,0x1},{0x2,0x1},{0x0,0xda},{0x0,0xad},{0x0,0xcc},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xae},{0x2,0x1},{0x0,0xdb},{0x0,0xdc},{0x2,0x1},{0x0,0xcd},{0x0,0xbe},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xeb},{0x0,0xed},{0x0,0xee},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd9},{0x0,0xea},{0x0,0xe9},{0x2,0x1},{0x0,0xde},{0x4,0x1},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x0,0xce},{0x0,0x3f},{0x0,0xf0},{0x4,0x1},{0x2,0x1},{0x0,0xf3},{0x0,0xf4},{0x2,0x1},{0x0,0x4f},{0x2,0x1},{0x0,0xf5},{0x0,0x5f},{0xa,0x1},{0x2,0x1},{0x0,0xff},{0x4,0x1},{0x2,0x1},{0x0,0xf6},{0x0,0x6f},{0x2,0x1},{0x0,0xf7},{0x0,0x7f},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x8f},{0x2,0x1},{0x0,0xf8},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xfa},{0x0,0xaf},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xfb},{0x0,0xbf},{0x2,0x1},{0x0,0xfc},{0x0,0xcf},{0x4,0x1},{0x2,0x1},{0x0,0xfd},{0x0,0xdf},{0x2,0x1},{0x0,0xfe},{0x0,0xef}};
    609b:	8d 95 88 ee ff ff    	lea    -0x1178(%ebp),%edx
    60a1:	b8 00 c2 00 00       	mov    $0xc200,%eax
    60a6:	b9 ff 00 00 00       	mov    $0xff,%ecx
    60ab:	89 d7                	mov    %edx,%edi
    60ad:	89 c6                	mov    %eax,%esi
    60af:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    60b1:	89 f0                	mov    %esi,%eax
    60b3:	89 fa                	mov    %edi,%edx
    60b5:	0f b7 08             	movzwl (%eax),%ecx
    60b8:	66 89 0a             	mov    %cx,(%edx)
    60bb:	83 c2 02             	add    $0x2,%edx
    60be:	83 c0 02             	add    $0x2,%eax

	unsigned char h24[512][2] = {{0x3c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x14},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0xfa,0x1},{0x62,0x1},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x4,0x1},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0x2,0x1},{0x0,0x62},{0x0,0x26},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x71},{0x0,0x55},{0x2,0x1},{0x0,0x64},{0x0,0x46},{0x20,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x72},{0x2,0x1},{0x0,0x27},{0x0,0x37},{0x2,0x1},{0x0,0x73},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x0,0x17},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x65},{0x0,0x56},{0x4,0x1},{0x2,0x1},{0x0,0x80},{0x0,0x8},{0x0,0x81},{0x4,0x1},{0x2,0x1},{0x0,0x74},{0x0,0x47},{0x2,0x1},{0x0,0x18},{0x0,0x82},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x28},{0x0,0x66},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x91},{0x0,0x19},{0x2,0x1},{0x0,0x92},{0x0,0x76},{0x4,0x1},{0x2,0x1},{0x0,0x67},{0x0,0x29},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x5c,0x1},{0x22,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x93},{0x0,0x39},{0x2,0x1},{0x0,0x94},{0x0,0x49},{0x4,0x1},{0x2,0x1},{0x0,0x77},{0x0,0x86},{0x2,0x1},{0x0,0x68},{0x0,0xa1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x4,0x1},{0x2,0x1},{0x0,0xa3},{0x0,0x3a},{0x2,0x1},{0x0,0x87},{0x2,0x1},{0x0,0x78},{0x0,0x4a},{0x16,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa4},{0x0,0x96},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xb1},{0x2,0x1},{0x0,0x1b},{0x0,0xa5},{0x6,0x1},{0x2,0x1},{0x0,0xb2},{0x2,0x1},{0x0,0x5a},{0x0,0x2b},{0x2,0x1},{0x0,0x88},{0x0,0xb3},{0x10,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x90},{0x2,0x1},{0x0,0x9},{0x0,0xa0},{0x2,0x1},{0x0,0x97},{0x0,0x79},{0x4,0x1},{0x2,0x1},{0x0,0xa6},{0x0,0x6a},{0x0,0xb4},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x1a},{0x2,0x1},{0x0,0xa},{0x0,0xb0},{0x2,0x1},{0x0,0x3b},{0x2,0x1},{0x0,0xb},{0x0,0xc0},{0x4,0x1},{0x2,0x1},{0x0,0x4b},{0x0,0xc1},{0x2,0x1},{0x0,0x98},{0x0,0x89},{0x43,0x1},{0x22,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1c},{0x0,0xb5},{0x2,0x1},{0x0,0x5b},{0x0,0xc2},{0x4,0x1},{0x2,0x1},{0x0,0x2c},{0x0,0xa7},{0x2,0x1},{0x0,0x7a},{0x0,0xc3},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3c},{0x2,0x1},{0x0,0xc},{0x0,0xd0},{0x2,0x1},{0x0,0xb6},{0x0,0x6b},{0x4,0x1},{0x2,0x1},{0x0,0xc4},{0x0,0x4c},{0x2,0x1},{0x0,0x99},{0x0,0xa8},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8a},{0x0,0xc5},{0x2,0x1},{0x0,0x5c},{0x0,0xd1},{0x4,0x1},{0x2,0x1},{0x0,0xb7},{0x0,0x7b},{0x2,0x1},{0x0,0x1d},{0x0,0xd2},{0x9,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x2d},{0x0,0xd3},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x55,0xfa},{0x4,0x1},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x2,0x1},{0x0,0x9a},{0x0,0xd4},{0x20,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb8},{0x0,0x8b},{0x2,0x1},{0x0,0x4d},{0x0,0xc7},{0x4,0x1},{0x2,0x1},{0x0,0x7c},{0x0,0xd5},{0x2,0x1},{0x0,0x5d},{0x0,0xe1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0xe2},{0x2,0x1},{0x0,0xaa},{0x0,0xb9},{0x4,0x1},{0x2,0x1},{0x0,0x9b},{0x0,0xe3},{0x2,0x1},{0x0,0xd6},{0x0,0x6d},{0x14,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3e},{0x2,0x1},{0x0,0x2e},{0x0,0x4e},{0x2,0x1},{0x0,0xc8},{0x0,0x8c},{0x4,0x1},{0x2,0x1},{0x0,0xe4},{0x0,0xd7},{0x4,0x1},{0x2,0x1},{0x0,0x7d},{0x0,0xab},{0x0,0xe5},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xba},{0x0,0x5e},{0x2,0x1},{0x0,0xc9},{0x2,0x1},{0x0,0x9c},{0x0,0x6e},{0x8,0x1},{0x2,0x1},{0x0,0xe6},{0x2,0x1},{0x0,0xd},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0x8d},{0x2,0x1},{0x0,0xbb},{0x0,0xca},{0x4a,0x1},{0x2,0x1},{0x0,0xff},{0x40,0x1},{0x3a,0x1},{0x20,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xac},{0x0,0xe7},{0x2,0x1},{0x0,0x7e},{0x0,0xd9},{0x4,0x1},{0x2,0x1},{0x0,0x9d},{0x0,0xe8},{0x2,0x1},{0x0,0x8e},{0x0,0xcb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbc},{0x0,0xda},{0x2,0x1},{0x0,0xad},{0x0,0xe9},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xcc},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xea},{0x0,0xae},{0x2,0x1},{0x0,0xdc},{0x0,0xcd},{0x4,0x1},{0x2,0x1},{0x0,0xeb},{0x0,0xbe},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xce},{0x0,0xed},{0x2,0x1},{0x0,0xde},{0x0,0xee},{0x0,0xf},{0x4,0x1},{0x2,0x1},{0x0,0xf0},{0x0,0x1f},{0x0,0xf1},{0x4,0x1},{0x2,0x1},{0x0,0xf2},{0x0,0x2f},{0x2,0x1},{0x0,0xf3},{0x0,0x3f},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf4},{0x0,0x4f},{0x2,0x1},{0x0,0xf5},{0x0,0x5f},{0x4,0x1},{0x2,0x1},{0x0,0xf6},{0x0,0x6f},{0x2,0x1},{0x0,0xf7},{0x2,0x1},{0x0,0x7f},{0x0,0x8f},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf8},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xaf},{0x0,0xfa},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xfb},{0x0,0xbf},{0x2,0x1},{0x0,0xfc},{0x0,0xcf},{0x4,0x1},{0x2,0x1},{0x0,0xfd},{0x0,0xdf},{0x2,0x1},{0x0,0xfe},{0x0,0xef}};
    60c1:	8d 95 88 ea ff ff    	lea    -0x1578(%ebp),%edx
    60c7:	bb 00 c6 00 00       	mov    $0xc600,%ebx
    60cc:	b8 00 01 00 00       	mov    $0x100,%eax
    60d1:	89 d7                	mov    %edx,%edi
    60d3:	89 de                	mov    %ebx,%esi
    60d5:	89 c1                	mov    %eax,%ecx
    60d7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	unsigned char hA[31][2] = {{0x2,0x1},{0x0,0x0},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8},{0x0,0x4},{0x2,0x1},{0x0,0x1},{0x0,0x2},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0xa},{0x2,0x1},{0x0,0x3},{0x0,0x6},{0x6,0x1},{0x2,0x1},{0x0,0x9},{0x2,0x1},{0x0,0x5},{0x0,0x7},{0x4,0x1},{0x2,0x1},{0x0,0xe},{0x0,0xd},{0x2,0x1},{0x0,0xf},{0x0,0xb}};
    60d9:	c6 85 4a ea ff ff 02 	movb   $0x2,-0x15b6(%ebp)
    60e0:	c6 85 4b ea ff ff 01 	movb   $0x1,-0x15b5(%ebp)
    60e7:	c6 85 4c ea ff ff 00 	movb   $0x0,-0x15b4(%ebp)
    60ee:	c6 85 4d ea ff ff 00 	movb   $0x0,-0x15b3(%ebp)
    60f5:	c6 85 4e ea ff ff 08 	movb   $0x8,-0x15b2(%ebp)
    60fc:	c6 85 4f ea ff ff 01 	movb   $0x1,-0x15b1(%ebp)
    6103:	c6 85 50 ea ff ff 04 	movb   $0x4,-0x15b0(%ebp)
    610a:	c6 85 51 ea ff ff 01 	movb   $0x1,-0x15af(%ebp)
    6111:	c6 85 52 ea ff ff 02 	movb   $0x2,-0x15ae(%ebp)
    6118:	c6 85 53 ea ff ff 01 	movb   $0x1,-0x15ad(%ebp)
    611f:	c6 85 54 ea ff ff 00 	movb   $0x0,-0x15ac(%ebp)
    6126:	c6 85 55 ea ff ff 08 	movb   $0x8,-0x15ab(%ebp)
    612d:	c6 85 56 ea ff ff 00 	movb   $0x0,-0x15aa(%ebp)
    6134:	c6 85 57 ea ff ff 04 	movb   $0x4,-0x15a9(%ebp)
    613b:	c6 85 58 ea ff ff 02 	movb   $0x2,-0x15a8(%ebp)
    6142:	c6 85 59 ea ff ff 01 	movb   $0x1,-0x15a7(%ebp)
    6149:	c6 85 5a ea ff ff 00 	movb   $0x0,-0x15a6(%ebp)
    6150:	c6 85 5b ea ff ff 01 	movb   $0x1,-0x15a5(%ebp)
    6157:	c6 85 5c ea ff ff 00 	movb   $0x0,-0x15a4(%ebp)
    615e:	c6 85 5d ea ff ff 02 	movb   $0x2,-0x15a3(%ebp)
    6165:	c6 85 5e ea ff ff 08 	movb   $0x8,-0x15a2(%ebp)
    616c:	c6 85 5f ea ff ff 01 	movb   $0x1,-0x15a1(%ebp)
    6173:	c6 85 60 ea ff ff 04 	movb   $0x4,-0x15a0(%ebp)
    617a:	c6 85 61 ea ff ff 01 	movb   $0x1,-0x159f(%ebp)
    6181:	c6 85 62 ea ff ff 02 	movb   $0x2,-0x159e(%ebp)
    6188:	c6 85 63 ea ff ff 01 	movb   $0x1,-0x159d(%ebp)
    618f:	c6 85 64 ea ff ff 00 	movb   $0x0,-0x159c(%ebp)
    6196:	c6 85 65 ea ff ff 0c 	movb   $0xc,-0x159b(%ebp)
    619d:	c6 85 66 ea ff ff 00 	movb   $0x0,-0x159a(%ebp)
    61a4:	c6 85 67 ea ff ff 0a 	movb   $0xa,-0x1599(%ebp)
    61ab:	c6 85 68 ea ff ff 02 	movb   $0x2,-0x1598(%ebp)
    61b2:	c6 85 69 ea ff ff 01 	movb   $0x1,-0x1597(%ebp)
    61b9:	c6 85 6a ea ff ff 00 	movb   $0x0,-0x1596(%ebp)
    61c0:	c6 85 6b ea ff ff 03 	movb   $0x3,-0x1595(%ebp)
    61c7:	c6 85 6c ea ff ff 00 	movb   $0x0,-0x1594(%ebp)
    61ce:	c6 85 6d ea ff ff 06 	movb   $0x6,-0x1593(%ebp)
    61d5:	c6 85 6e ea ff ff 06 	movb   $0x6,-0x1592(%ebp)
    61dc:	c6 85 6f ea ff ff 01 	movb   $0x1,-0x1591(%ebp)
    61e3:	c6 85 70 ea ff ff 02 	movb   $0x2,-0x1590(%ebp)
    61ea:	c6 85 71 ea ff ff 01 	movb   $0x1,-0x158f(%ebp)
    61f1:	c6 85 72 ea ff ff 00 	movb   $0x0,-0x158e(%ebp)
    61f8:	c6 85 73 ea ff ff 09 	movb   $0x9,-0x158d(%ebp)
    61ff:	c6 85 74 ea ff ff 02 	movb   $0x2,-0x158c(%ebp)
    6206:	c6 85 75 ea ff ff 01 	movb   $0x1,-0x158b(%ebp)
    620d:	c6 85 76 ea ff ff 00 	movb   $0x0,-0x158a(%ebp)
    6214:	c6 85 77 ea ff ff 05 	movb   $0x5,-0x1589(%ebp)
    621b:	c6 85 78 ea ff ff 00 	movb   $0x0,-0x1588(%ebp)
    6222:	c6 85 79 ea ff ff 07 	movb   $0x7,-0x1587(%ebp)
    6229:	c6 85 7a ea ff ff 04 	movb   $0x4,-0x1586(%ebp)
    6230:	c6 85 7b ea ff ff 01 	movb   $0x1,-0x1585(%ebp)
    6237:	c6 85 7c ea ff ff 02 	movb   $0x2,-0x1584(%ebp)
    623e:	c6 85 7d ea ff ff 01 	movb   $0x1,-0x1583(%ebp)
    6245:	c6 85 7e ea ff ff 00 	movb   $0x0,-0x1582(%ebp)
    624c:	c6 85 7f ea ff ff 0e 	movb   $0xe,-0x1581(%ebp)
    6253:	c6 85 80 ea ff ff 00 	movb   $0x0,-0x1580(%ebp)
    625a:	c6 85 81 ea ff ff 0d 	movb   $0xd,-0x157f(%ebp)
    6261:	c6 85 82 ea ff ff 02 	movb   $0x2,-0x157e(%ebp)
    6268:	c6 85 83 ea ff ff 01 	movb   $0x1,-0x157d(%ebp)
    626f:	c6 85 84 ea ff ff 00 	movb   $0x0,-0x157c(%ebp)
    6276:	c6 85 85 ea ff ff 0f 	movb   $0xf,-0x157b(%ebp)
    627d:	c6 85 86 ea ff ff 00 	movb   $0x0,-0x157a(%ebp)
    6284:	c6 85 87 ea ff ff 0b 	movb   $0xb,-0x1579(%ebp)

	unsigned char hB[31][2] = {{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x1},{0x2,0x1},{0x0,0x2},{0x0,0x3},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x5},{0x2,0x1},{0x0,0x6},{0x0,0x7},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8},{0x0,0x9},{0x2,0x1},{0x0,0xa},{0x0,0xb},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0xd},{0x2,0x1},{0x0,0xe},{0x0,0xf}};
    628b:	c6 85 0c ea ff ff 10 	movb   $0x10,-0x15f4(%ebp)
    6292:	c6 85 0d ea ff ff 01 	movb   $0x1,-0x15f3(%ebp)
    6299:	c6 85 0e ea ff ff 08 	movb   $0x8,-0x15f2(%ebp)
    62a0:	c6 85 0f ea ff ff 01 	movb   $0x1,-0x15f1(%ebp)
    62a7:	c6 85 10 ea ff ff 04 	movb   $0x4,-0x15f0(%ebp)
    62ae:	c6 85 11 ea ff ff 01 	movb   $0x1,-0x15ef(%ebp)
    62b5:	c6 85 12 ea ff ff 02 	movb   $0x2,-0x15ee(%ebp)
    62bc:	c6 85 13 ea ff ff 01 	movb   $0x1,-0x15ed(%ebp)
    62c3:	c6 85 14 ea ff ff 00 	movb   $0x0,-0x15ec(%ebp)
    62ca:	c6 85 15 ea ff ff 00 	movb   $0x0,-0x15eb(%ebp)
    62d1:	c6 85 16 ea ff ff 00 	movb   $0x0,-0x15ea(%ebp)
    62d8:	c6 85 17 ea ff ff 01 	movb   $0x1,-0x15e9(%ebp)
    62df:	c6 85 18 ea ff ff 02 	movb   $0x2,-0x15e8(%ebp)
    62e6:	c6 85 19 ea ff ff 01 	movb   $0x1,-0x15e7(%ebp)
    62ed:	c6 85 1a ea ff ff 00 	movb   $0x0,-0x15e6(%ebp)
    62f4:	c6 85 1b ea ff ff 02 	movb   $0x2,-0x15e5(%ebp)
    62fb:	c6 85 1c ea ff ff 00 	movb   $0x0,-0x15e4(%ebp)
    6302:	c6 85 1d ea ff ff 03 	movb   $0x3,-0x15e3(%ebp)
    6309:	c6 85 1e ea ff ff 04 	movb   $0x4,-0x15e2(%ebp)
    6310:	c6 85 1f ea ff ff 01 	movb   $0x1,-0x15e1(%ebp)
    6317:	c6 85 20 ea ff ff 02 	movb   $0x2,-0x15e0(%ebp)
    631e:	c6 85 21 ea ff ff 01 	movb   $0x1,-0x15df(%ebp)
    6325:	c6 85 22 ea ff ff 00 	movb   $0x0,-0x15de(%ebp)
    632c:	c6 85 23 ea ff ff 04 	movb   $0x4,-0x15dd(%ebp)
    6333:	c6 85 24 ea ff ff 00 	movb   $0x0,-0x15dc(%ebp)
    633a:	c6 85 25 ea ff ff 05 	movb   $0x5,-0x15db(%ebp)
    6341:	c6 85 26 ea ff ff 02 	movb   $0x2,-0x15da(%ebp)
    6348:	c6 85 27 ea ff ff 01 	movb   $0x1,-0x15d9(%ebp)
    634f:	c6 85 28 ea ff ff 00 	movb   $0x0,-0x15d8(%ebp)
    6356:	c6 85 29 ea ff ff 06 	movb   $0x6,-0x15d7(%ebp)
    635d:	c6 85 2a ea ff ff 00 	movb   $0x0,-0x15d6(%ebp)
    6364:	c6 85 2b ea ff ff 07 	movb   $0x7,-0x15d5(%ebp)
    636b:	c6 85 2c ea ff ff 08 	movb   $0x8,-0x15d4(%ebp)
    6372:	c6 85 2d ea ff ff 01 	movb   $0x1,-0x15d3(%ebp)
    6379:	c6 85 2e ea ff ff 04 	movb   $0x4,-0x15d2(%ebp)
    6380:	c6 85 2f ea ff ff 01 	movb   $0x1,-0x15d1(%ebp)
    6387:	c6 85 30 ea ff ff 02 	movb   $0x2,-0x15d0(%ebp)
    638e:	c6 85 31 ea ff ff 01 	movb   $0x1,-0x15cf(%ebp)
    6395:	c6 85 32 ea ff ff 00 	movb   $0x0,-0x15ce(%ebp)
    639c:	c6 85 33 ea ff ff 08 	movb   $0x8,-0x15cd(%ebp)
    63a3:	c6 85 34 ea ff ff 00 	movb   $0x0,-0x15cc(%ebp)
    63aa:	c6 85 35 ea ff ff 09 	movb   $0x9,-0x15cb(%ebp)
    63b1:	c6 85 36 ea ff ff 02 	movb   $0x2,-0x15ca(%ebp)
    63b8:	c6 85 37 ea ff ff 01 	movb   $0x1,-0x15c9(%ebp)
    63bf:	c6 85 38 ea ff ff 00 	movb   $0x0,-0x15c8(%ebp)
    63c6:	c6 85 39 ea ff ff 0a 	movb   $0xa,-0x15c7(%ebp)
    63cd:	c6 85 3a ea ff ff 00 	movb   $0x0,-0x15c6(%ebp)
    63d4:	c6 85 3b ea ff ff 0b 	movb   $0xb,-0x15c5(%ebp)
    63db:	c6 85 3c ea ff ff 04 	movb   $0x4,-0x15c4(%ebp)
    63e2:	c6 85 3d ea ff ff 01 	movb   $0x1,-0x15c3(%ebp)
    63e9:	c6 85 3e ea ff ff 02 	movb   $0x2,-0x15c2(%ebp)
    63f0:	c6 85 3f ea ff ff 01 	movb   $0x1,-0x15c1(%ebp)
    63f7:	c6 85 40 ea ff ff 00 	movb   $0x0,-0x15c0(%ebp)
    63fe:	c6 85 41 ea ff ff 0c 	movb   $0xc,-0x15bf(%ebp)
    6405:	c6 85 42 ea ff ff 00 	movb   $0x0,-0x15be(%ebp)
    640c:	c6 85 43 ea ff ff 0d 	movb   $0xd,-0x15bd(%ebp)
    6413:	c6 85 44 ea ff ff 02 	movb   $0x2,-0x15bc(%ebp)
    641a:	c6 85 45 ea ff ff 01 	movb   $0x1,-0x15bb(%ebp)
    6421:	c6 85 46 ea ff ff 00 	movb   $0x0,-0x15ba(%ebp)
    6428:	c6 85 47 ea ff ff 0e 	movb   $0xe,-0x15b9(%ebp)
    642f:	c6 85 48 ea ff ff 00 	movb   $0x0,-0x15b8(%ebp)
    6436:	c6 85 49 ea ff ff 0f 	movb   $0xf,-0x15b7(%ebp)
	
	struct huffcodetab ht[HTN] = {
    643d:	66 c7 85 bc e4 ff ff 	movw   $0x30,-0x1b44(%ebp)
    6444:	30 00 
    6446:	c6 85 be e4 ff ff 00 	movb   $0x0,-0x1b42(%ebp)
    644d:	c7 85 c0 e4 ff ff 00 	movl   $0x0,-0x1b40(%ebp)
    6454:	00 00 00 
    6457:	c7 85 c4 e4 ff ff 00 	movl   $0x0,-0x1b3c(%ebp)
    645e:	00 00 00 
    6461:	c7 85 c8 e4 ff ff 00 	movl   $0x0,-0x1b38(%ebp)
    6468:	00 00 00 
    646b:	c7 85 cc e4 ff ff 00 	movl   $0x0,-0x1b34(%ebp)
    6472:	00 00 00 
    6475:	c7 85 d0 e4 ff ff ff 	movl   $0xffffffff,-0x1b30(%ebp)
    647c:	ff ff ff 
    647f:	c7 85 d4 e4 ff ff 00 	movl   $0x0,-0x1b2c(%ebp)
    6486:	00 00 00 
    6489:	c7 85 d8 e4 ff ff 00 	movl   $0x0,-0x1b28(%ebp)
    6490:	00 00 00 
    6493:	c7 85 dc e4 ff ff 00 	movl   $0x0,-0x1b24(%ebp)
    649a:	00 00 00 
    649d:	c7 85 e0 e4 ff ff 00 	movl   $0x0,-0x1b20(%ebp)
    64a4:	00 00 00 
    64a7:	66 c7 85 e4 e4 ff ff 	movw   $0x31,-0x1b1c(%ebp)
    64ae:	31 00 
    64b0:	c6 85 e6 e4 ff ff 00 	movb   $0x0,-0x1b1a(%ebp)
    64b7:	c7 85 e8 e4 ff ff 02 	movl   $0x2,-0x1b18(%ebp)
    64be:	00 00 00 
    64c1:	c7 85 ec e4 ff ff 02 	movl   $0x2,-0x1b14(%ebp)
    64c8:	00 00 00 
    64cb:	c7 85 f0 e4 ff ff 00 	movl   $0x0,-0x1b10(%ebp)
    64d2:	00 00 00 
    64d5:	c7 85 f4 e4 ff ff 00 	movl   $0x0,-0x1b0c(%ebp)
    64dc:	00 00 00 
    64df:	c7 85 f8 e4 ff ff ff 	movl   $0xffffffff,-0x1b08(%ebp)
    64e6:	ff ff ff 
    64e9:	c7 85 fc e4 ff ff 00 	movl   $0x0,-0x1b04(%ebp)
    64f0:	00 00 00 
    64f3:	c7 85 00 e5 ff ff 00 	movl   $0x0,-0x1b00(%ebp)
    64fa:	00 00 00 
    64fd:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    6500:	89 85 04 e5 ff ff    	mov    %eax,-0x1afc(%ebp)
    6506:	c7 85 08 e5 ff ff 07 	movl   $0x7,-0x1af8(%ebp)
    650d:	00 00 00 
    6510:	66 c7 85 0c e5 ff ff 	movw   $0x32,-0x1af4(%ebp)
    6517:	32 00 
    6519:	c6 85 0e e5 ff ff 00 	movb   $0x0,-0x1af2(%ebp)
    6520:	c7 85 10 e5 ff ff 03 	movl   $0x3,-0x1af0(%ebp)
    6527:	00 00 00 
    652a:	c7 85 14 e5 ff ff 03 	movl   $0x3,-0x1aec(%ebp)
    6531:	00 00 00 
    6534:	c7 85 18 e5 ff ff 00 	movl   $0x0,-0x1ae8(%ebp)
    653b:	00 00 00 
    653e:	c7 85 1c e5 ff ff 00 	movl   $0x0,-0x1ae4(%ebp)
    6545:	00 00 00 
    6548:	c7 85 20 e5 ff ff ff 	movl   $0xffffffff,-0x1ae0(%ebp)
    654f:	ff ff ff 
    6552:	c7 85 24 e5 ff ff 00 	movl   $0x0,-0x1adc(%ebp)
    6559:	00 00 00 
    655c:	c7 85 28 e5 ff ff 00 	movl   $0x0,-0x1ad8(%ebp)
    6563:	00 00 00 
    6566:	8d 45 c4             	lea    -0x3c(%ebp),%eax
    6569:	89 85 2c e5 ff ff    	mov    %eax,-0x1ad4(%ebp)
    656f:	c7 85 30 e5 ff ff 11 	movl   $0x11,-0x1ad0(%ebp)
    6576:	00 00 00 
    6579:	66 c7 85 34 e5 ff ff 	movw   $0x33,-0x1acc(%ebp)
    6580:	33 00 
    6582:	c6 85 36 e5 ff ff 00 	movb   $0x0,-0x1aca(%ebp)
    6589:	c7 85 38 e5 ff ff 03 	movl   $0x3,-0x1ac8(%ebp)
    6590:	00 00 00 
    6593:	c7 85 3c e5 ff ff 03 	movl   $0x3,-0x1ac4(%ebp)
    659a:	00 00 00 
    659d:	c7 85 40 e5 ff ff 00 	movl   $0x0,-0x1ac0(%ebp)
    65a4:	00 00 00 
    65a7:	c7 85 44 e5 ff ff 00 	movl   $0x0,-0x1abc(%ebp)
    65ae:	00 00 00 
    65b1:	c7 85 48 e5 ff ff ff 	movl   $0xffffffff,-0x1ab8(%ebp)
    65b8:	ff ff ff 
    65bb:	c7 85 4c e5 ff ff 00 	movl   $0x0,-0x1ab4(%ebp)
    65c2:	00 00 00 
    65c5:	c7 85 50 e5 ff ff 00 	movl   $0x0,-0x1ab0(%ebp)
    65cc:	00 00 00 
    65cf:	8d 45 a2             	lea    -0x5e(%ebp),%eax
    65d2:	89 85 54 e5 ff ff    	mov    %eax,-0x1aac(%ebp)
    65d8:	c7 85 58 e5 ff ff 11 	movl   $0x11,-0x1aa8(%ebp)
    65df:	00 00 00 
    65e2:	66 c7 85 5c e5 ff ff 	movw   $0x34,-0x1aa4(%ebp)
    65e9:	34 00 
    65eb:	c6 85 5e e5 ff ff 00 	movb   $0x0,-0x1aa2(%ebp)
    65f2:	c7 85 60 e5 ff ff 00 	movl   $0x0,-0x1aa0(%ebp)
    65f9:	00 00 00 
    65fc:	c7 85 64 e5 ff ff 00 	movl   $0x0,-0x1a9c(%ebp)
    6603:	00 00 00 
    6606:	c7 85 68 e5 ff ff 00 	movl   $0x0,-0x1a98(%ebp)
    660d:	00 00 00 
    6610:	c7 85 6c e5 ff ff 00 	movl   $0x0,-0x1a94(%ebp)
    6617:	00 00 00 
    661a:	c7 85 70 e5 ff ff ff 	movl   $0xffffffff,-0x1a90(%ebp)
    6621:	ff ff ff 
    6624:	c7 85 74 e5 ff ff 00 	movl   $0x0,-0x1a8c(%ebp)
    662b:	00 00 00 
    662e:	c7 85 78 e5 ff ff 00 	movl   $0x0,-0x1a88(%ebp)
    6635:	00 00 00 
    6638:	c7 85 7c e5 ff ff 00 	movl   $0x0,-0x1a84(%ebp)
    663f:	00 00 00 
    6642:	c7 85 80 e5 ff ff 00 	movl   $0x0,-0x1a80(%ebp)
    6649:	00 00 00 
    664c:	66 c7 85 84 e5 ff ff 	movw   $0x35,-0x1a7c(%ebp)
    6653:	35 00 
    6655:	c6 85 86 e5 ff ff 00 	movb   $0x0,-0x1a7a(%ebp)
    665c:	c7 85 88 e5 ff ff 04 	movl   $0x4,-0x1a78(%ebp)
    6663:	00 00 00 
    6666:	c7 85 8c e5 ff ff 04 	movl   $0x4,-0x1a74(%ebp)
    666d:	00 00 00 
    6670:	c7 85 90 e5 ff ff 00 	movl   $0x0,-0x1a70(%ebp)
    6677:	00 00 00 
    667a:	c7 85 94 e5 ff ff 00 	movl   $0x0,-0x1a6c(%ebp)
    6681:	00 00 00 
    6684:	c7 85 98 e5 ff ff ff 	movl   $0xffffffff,-0x1a68(%ebp)
    668b:	ff ff ff 
    668e:	c7 85 9c e5 ff ff 00 	movl   $0x0,-0x1a64(%ebp)
    6695:	00 00 00 
    6698:	c7 85 a0 e5 ff ff 00 	movl   $0x0,-0x1a60(%ebp)
    669f:	00 00 00 
    66a2:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
    66a8:	89 85 a4 e5 ff ff    	mov    %eax,-0x1a5c(%ebp)
    66ae:	c7 85 a8 e5 ff ff 1f 	movl   $0x1f,-0x1a58(%ebp)
    66b5:	00 00 00 
    66b8:	66 c7 85 ac e5 ff ff 	movw   $0x36,-0x1a54(%ebp)
    66bf:	36 00 
    66c1:	c6 85 ae e5 ff ff 00 	movb   $0x0,-0x1a52(%ebp)
    66c8:	c7 85 b0 e5 ff ff 04 	movl   $0x4,-0x1a50(%ebp)
    66cf:	00 00 00 
    66d2:	c7 85 b4 e5 ff ff 04 	movl   $0x4,-0x1a4c(%ebp)
    66d9:	00 00 00 
    66dc:	c7 85 b8 e5 ff ff 00 	movl   $0x0,-0x1a48(%ebp)
    66e3:	00 00 00 
    66e6:	c7 85 bc e5 ff ff 00 	movl   $0x0,-0x1a44(%ebp)
    66ed:	00 00 00 
    66f0:	c7 85 c0 e5 ff ff ff 	movl   $0xffffffff,-0x1a40(%ebp)
    66f7:	ff ff ff 
    66fa:	c7 85 c4 e5 ff ff 00 	movl   $0x0,-0x1a3c(%ebp)
    6701:	00 00 00 
    6704:	c7 85 c8 e5 ff ff 00 	movl   $0x0,-0x1a38(%ebp)
    670b:	00 00 00 
    670e:	8d 85 26 ff ff ff    	lea    -0xda(%ebp),%eax
    6714:	89 85 cc e5 ff ff    	mov    %eax,-0x1a34(%ebp)
    671a:	c7 85 d0 e5 ff ff 1f 	movl   $0x1f,-0x1a30(%ebp)
    6721:	00 00 00 
    6724:	66 c7 85 d4 e5 ff ff 	movw   $0x37,-0x1a2c(%ebp)
    672b:	37 00 
    672d:	c6 85 d6 e5 ff ff 00 	movb   $0x0,-0x1a2a(%ebp)
    6734:	c7 85 d8 e5 ff ff 06 	movl   $0x6,-0x1a28(%ebp)
    673b:	00 00 00 
    673e:	c7 85 dc e5 ff ff 06 	movl   $0x6,-0x1a24(%ebp)
    6745:	00 00 00 
    6748:	c7 85 e0 e5 ff ff 00 	movl   $0x0,-0x1a20(%ebp)
    674f:	00 00 00 
    6752:	c7 85 e4 e5 ff ff 00 	movl   $0x0,-0x1a1c(%ebp)
    6759:	00 00 00 
    675c:	c7 85 e8 e5 ff ff ff 	movl   $0xffffffff,-0x1a18(%ebp)
    6763:	ff ff ff 
    6766:	c7 85 ec e5 ff ff 00 	movl   $0x0,-0x1a14(%ebp)
    676d:	00 00 00 
    6770:	c7 85 f0 e5 ff ff 00 	movl   $0x0,-0x1a10(%ebp)
    6777:	00 00 00 
    677a:	8d 85 98 fe ff ff    	lea    -0x168(%ebp),%eax
    6780:	89 85 f4 e5 ff ff    	mov    %eax,-0x1a0c(%ebp)
    6786:	c7 85 f8 e5 ff ff 47 	movl   $0x47,-0x1a08(%ebp)
    678d:	00 00 00 
    6790:	66 c7 85 fc e5 ff ff 	movw   $0x38,-0x1a04(%ebp)
    6797:	38 00 
    6799:	c6 85 fe e5 ff ff 00 	movb   $0x0,-0x1a02(%ebp)
    67a0:	c7 85 00 e6 ff ff 06 	movl   $0x6,-0x1a00(%ebp)
    67a7:	00 00 00 
    67aa:	c7 85 04 e6 ff ff 06 	movl   $0x6,-0x19fc(%ebp)
    67b1:	00 00 00 
    67b4:	c7 85 08 e6 ff ff 00 	movl   $0x0,-0x19f8(%ebp)
    67bb:	00 00 00 
    67be:	c7 85 0c e6 ff ff 00 	movl   $0x0,-0x19f4(%ebp)
    67c5:	00 00 00 
    67c8:	c7 85 10 e6 ff ff ff 	movl   $0xffffffff,-0x19f0(%ebp)
    67cf:	ff ff ff 
    67d2:	c7 85 14 e6 ff ff 00 	movl   $0x0,-0x19ec(%ebp)
    67d9:	00 00 00 
    67dc:	c7 85 18 e6 ff ff 00 	movl   $0x0,-0x19e8(%ebp)
    67e3:	00 00 00 
    67e6:	8d 85 0a fe ff ff    	lea    -0x1f6(%ebp),%eax
    67ec:	89 85 1c e6 ff ff    	mov    %eax,-0x19e4(%ebp)
    67f2:	c7 85 20 e6 ff ff 47 	movl   $0x47,-0x19e0(%ebp)
    67f9:	00 00 00 
    67fc:	66 c7 85 24 e6 ff ff 	movw   $0x39,-0x19dc(%ebp)
    6803:	39 00 
    6805:	c6 85 26 e6 ff ff 00 	movb   $0x0,-0x19da(%ebp)
    680c:	c7 85 28 e6 ff ff 06 	movl   $0x6,-0x19d8(%ebp)
    6813:	00 00 00 
    6816:	c7 85 2c e6 ff ff 06 	movl   $0x6,-0x19d4(%ebp)
    681d:	00 00 00 
    6820:	c7 85 30 e6 ff ff 00 	movl   $0x0,-0x19d0(%ebp)
    6827:	00 00 00 
    682a:	c7 85 34 e6 ff ff 00 	movl   $0x0,-0x19cc(%ebp)
    6831:	00 00 00 
    6834:	c7 85 38 e6 ff ff ff 	movl   $0xffffffff,-0x19c8(%ebp)
    683b:	ff ff ff 
    683e:	c7 85 3c e6 ff ff 00 	movl   $0x0,-0x19c4(%ebp)
    6845:	00 00 00 
    6848:	c7 85 40 e6 ff ff 00 	movl   $0x0,-0x19c0(%ebp)
    684f:	00 00 00 
    6852:	8d 85 7c fd ff ff    	lea    -0x284(%ebp),%eax
    6858:	89 85 44 e6 ff ff    	mov    %eax,-0x19bc(%ebp)
    685e:	c7 85 48 e6 ff ff 47 	movl   $0x47,-0x19b8(%ebp)
    6865:	00 00 00 
    6868:	66 c7 85 4c e6 ff ff 	movw   $0x3031,-0x19b4(%ebp)
    686f:	31 30 
    6871:	c6 85 4e e6 ff ff 00 	movb   $0x0,-0x19b2(%ebp)
    6878:	c7 85 50 e6 ff ff 08 	movl   $0x8,-0x19b0(%ebp)
    687f:	00 00 00 
    6882:	c7 85 54 e6 ff ff 08 	movl   $0x8,-0x19ac(%ebp)
    6889:	00 00 00 
    688c:	c7 85 58 e6 ff ff 00 	movl   $0x0,-0x19a8(%ebp)
    6893:	00 00 00 
    6896:	c7 85 5c e6 ff ff 00 	movl   $0x0,-0x19a4(%ebp)
    689d:	00 00 00 
    68a0:	c7 85 60 e6 ff ff ff 	movl   $0xffffffff,-0x19a0(%ebp)
    68a7:	ff ff ff 
    68aa:	c7 85 64 e6 ff ff 00 	movl   $0x0,-0x199c(%ebp)
    68b1:	00 00 00 
    68b4:	c7 85 68 e6 ff ff 00 	movl   $0x0,-0x1998(%ebp)
    68bb:	00 00 00 
    68be:	8d 85 7e fc ff ff    	lea    -0x382(%ebp),%eax
    68c4:	89 85 6c e6 ff ff    	mov    %eax,-0x1994(%ebp)
    68ca:	c7 85 70 e6 ff ff 7f 	movl   $0x7f,-0x1990(%ebp)
    68d1:	00 00 00 
    68d4:	66 c7 85 74 e6 ff ff 	movw   $0x3131,-0x198c(%ebp)
    68db:	31 31 
    68dd:	c6 85 76 e6 ff ff 00 	movb   $0x0,-0x198a(%ebp)
    68e4:	c7 85 78 e6 ff ff 08 	movl   $0x8,-0x1988(%ebp)
    68eb:	00 00 00 
    68ee:	c7 85 7c e6 ff ff 08 	movl   $0x8,-0x1984(%ebp)
    68f5:	00 00 00 
    68f8:	c7 85 80 e6 ff ff 00 	movl   $0x0,-0x1980(%ebp)
    68ff:	00 00 00 
    6902:	c7 85 84 e6 ff ff 00 	movl   $0x0,-0x197c(%ebp)
    6909:	00 00 00 
    690c:	c7 85 88 e6 ff ff ff 	movl   $0xffffffff,-0x1978(%ebp)
    6913:	ff ff ff 
    6916:	c7 85 8c e6 ff ff 00 	movl   $0x0,-0x1974(%ebp)
    691d:	00 00 00 
    6920:	c7 85 90 e6 ff ff 00 	movl   $0x0,-0x1970(%ebp)
    6927:	00 00 00 
    692a:	8d 85 80 fb ff ff    	lea    -0x480(%ebp),%eax
    6930:	89 85 94 e6 ff ff    	mov    %eax,-0x196c(%ebp)
    6936:	c7 85 98 e6 ff ff 7f 	movl   $0x7f,-0x1968(%ebp)
    693d:	00 00 00 
    6940:	66 c7 85 9c e6 ff ff 	movw   $0x3231,-0x1964(%ebp)
    6947:	31 32 
    6949:	c6 85 9e e6 ff ff 00 	movb   $0x0,-0x1962(%ebp)
    6950:	c7 85 a0 e6 ff ff 08 	movl   $0x8,-0x1960(%ebp)
    6957:	00 00 00 
    695a:	c7 85 a4 e6 ff ff 08 	movl   $0x8,-0x195c(%ebp)
    6961:	00 00 00 
    6964:	c7 85 a8 e6 ff ff 00 	movl   $0x0,-0x1958(%ebp)
    696b:	00 00 00 
    696e:	c7 85 ac e6 ff ff 00 	movl   $0x0,-0x1954(%ebp)
    6975:	00 00 00 
    6978:	c7 85 b0 e6 ff ff ff 	movl   $0xffffffff,-0x1950(%ebp)
    697f:	ff ff ff 
    6982:	c7 85 b4 e6 ff ff 00 	movl   $0x0,-0x194c(%ebp)
    6989:	00 00 00 
    698c:	c7 85 b8 e6 ff ff 00 	movl   $0x0,-0x1948(%ebp)
    6993:	00 00 00 
    6996:	8d 85 82 fa ff ff    	lea    -0x57e(%ebp),%eax
    699c:	89 85 bc e6 ff ff    	mov    %eax,-0x1944(%ebp)
    69a2:	c7 85 c0 e6 ff ff 7f 	movl   $0x7f,-0x1940(%ebp)
    69a9:	00 00 00 
    69ac:	66 c7 85 c4 e6 ff ff 	movw   $0x3331,-0x193c(%ebp)
    69b3:	31 33 
    69b5:	c6 85 c6 e6 ff ff 00 	movb   $0x0,-0x193a(%ebp)
    69bc:	c7 85 c8 e6 ff ff 10 	movl   $0x10,-0x1938(%ebp)
    69c3:	00 00 00 
    69c6:	c7 85 cc e6 ff ff 10 	movl   $0x10,-0x1934(%ebp)
    69cd:	00 00 00 
    69d0:	c7 85 d0 e6 ff ff 00 	movl   $0x0,-0x1930(%ebp)
    69d7:	00 00 00 
    69da:	c7 85 d4 e6 ff ff 00 	movl   $0x0,-0x192c(%ebp)
    69e1:	00 00 00 
    69e4:	c7 85 d8 e6 ff ff ff 	movl   $0xffffffff,-0x1928(%ebp)
    69eb:	ff ff ff 
    69ee:	c7 85 dc e6 ff ff 00 	movl   $0x0,-0x1924(%ebp)
    69f5:	00 00 00 
    69f8:	c7 85 e0 e6 ff ff 00 	movl   $0x0,-0x1920(%ebp)
    69ff:	00 00 00 
    6a02:	8d 85 84 f6 ff ff    	lea    -0x97c(%ebp),%eax
    6a08:	89 85 e4 e6 ff ff    	mov    %eax,-0x191c(%ebp)
    6a0e:	c7 85 e8 e6 ff ff ff 	movl   $0x1ff,-0x1918(%ebp)
    6a15:	01 00 00 
    6a18:	66 c7 85 ec e6 ff ff 	movw   $0x3431,-0x1914(%ebp)
    6a1f:	31 34 
    6a21:	c6 85 ee e6 ff ff 00 	movb   $0x0,-0x1912(%ebp)
    6a28:	c7 85 f0 e6 ff ff 00 	movl   $0x0,-0x1910(%ebp)
    6a2f:	00 00 00 
    6a32:	c7 85 f4 e6 ff ff 00 	movl   $0x0,-0x190c(%ebp)
    6a39:	00 00 00 
    6a3c:	c7 85 f8 e6 ff ff 00 	movl   $0x0,-0x1908(%ebp)
    6a43:	00 00 00 
    6a46:	c7 85 fc e6 ff ff 00 	movl   $0x0,-0x1904(%ebp)
    6a4d:	00 00 00 
    6a50:	c7 85 00 e7 ff ff ff 	movl   $0xffffffff,-0x1900(%ebp)
    6a57:	ff ff ff 
    6a5a:	c7 85 04 e7 ff ff 00 	movl   $0x0,-0x18fc(%ebp)
    6a61:	00 00 00 
    6a64:	c7 85 08 e7 ff ff 00 	movl   $0x0,-0x18f8(%ebp)
    6a6b:	00 00 00 
    6a6e:	c7 85 0c e7 ff ff 00 	movl   $0x0,-0x18f4(%ebp)
    6a75:	00 00 00 
    6a78:	c7 85 10 e7 ff ff 00 	movl   $0x0,-0x18f0(%ebp)
    6a7f:	00 00 00 
    6a82:	66 c7 85 14 e7 ff ff 	movw   $0x3531,-0x18ec(%ebp)
    6a89:	31 35 
    6a8b:	c6 85 16 e7 ff ff 00 	movb   $0x0,-0x18ea(%ebp)
    6a92:	c7 85 18 e7 ff ff 10 	movl   $0x10,-0x18e8(%ebp)
    6a99:	00 00 00 
    6a9c:	c7 85 1c e7 ff ff 10 	movl   $0x10,-0x18e4(%ebp)
    6aa3:	00 00 00 
    6aa6:	c7 85 20 e7 ff ff 00 	movl   $0x0,-0x18e0(%ebp)
    6aad:	00 00 00 
    6ab0:	c7 85 24 e7 ff ff 00 	movl   $0x0,-0x18dc(%ebp)
    6ab7:	00 00 00 
    6aba:	c7 85 28 e7 ff ff ff 	movl   $0xffffffff,-0x18d8(%ebp)
    6ac1:	ff ff ff 
    6ac4:	c7 85 2c e7 ff ff 00 	movl   $0x0,-0x18d4(%ebp)
    6acb:	00 00 00 
    6ace:	c7 85 30 e7 ff ff 00 	movl   $0x0,-0x18d0(%ebp)
    6ad5:	00 00 00 
    6ad8:	8d 85 86 f2 ff ff    	lea    -0xd7a(%ebp),%eax
    6ade:	89 85 34 e7 ff ff    	mov    %eax,-0x18cc(%ebp)
    6ae4:	c7 85 38 e7 ff ff ff 	movl   $0x1ff,-0x18c8(%ebp)
    6aeb:	01 00 00 
    6aee:	66 c7 85 3c e7 ff ff 	movw   $0x3631,-0x18c4(%ebp)
    6af5:	31 36 
    6af7:	c6 85 3e e7 ff ff 00 	movb   $0x0,-0x18c2(%ebp)
    6afe:	c7 85 40 e7 ff ff 10 	movl   $0x10,-0x18c0(%ebp)
    6b05:	00 00 00 
    6b08:	c7 85 44 e7 ff ff 10 	movl   $0x10,-0x18bc(%ebp)
    6b0f:	00 00 00 
    6b12:	c7 85 48 e7 ff ff 01 	movl   $0x1,-0x18b8(%ebp)
    6b19:	00 00 00 
    6b1c:	c7 85 4c e7 ff ff 01 	movl   $0x1,-0x18b4(%ebp)
    6b23:	00 00 00 
    6b26:	c7 85 50 e7 ff ff ff 	movl   $0xffffffff,-0x18b0(%ebp)
    6b2d:	ff ff ff 
    6b30:	c7 85 54 e7 ff ff 00 	movl   $0x0,-0x18ac(%ebp)
    6b37:	00 00 00 
    6b3a:	c7 85 58 e7 ff ff 00 	movl   $0x0,-0x18a8(%ebp)
    6b41:	00 00 00 
    6b44:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6b4a:	89 85 5c e7 ff ff    	mov    %eax,-0x18a4(%ebp)
    6b50:	c7 85 60 e7 ff ff ff 	movl   $0x1ff,-0x18a0(%ebp)
    6b57:	01 00 00 
    6b5a:	66 c7 85 64 e7 ff ff 	movw   $0x3731,-0x189c(%ebp)
    6b61:	31 37 
    6b63:	c6 85 66 e7 ff ff 00 	movb   $0x0,-0x189a(%ebp)
    6b6a:	c7 85 68 e7 ff ff 10 	movl   $0x10,-0x1898(%ebp)
    6b71:	00 00 00 
    6b74:	c7 85 6c e7 ff ff 10 	movl   $0x10,-0x1894(%ebp)
    6b7b:	00 00 00 
    6b7e:	c7 85 70 e7 ff ff 02 	movl   $0x2,-0x1890(%ebp)
    6b85:	00 00 00 
    6b88:	c7 85 74 e7 ff ff 03 	movl   $0x3,-0x188c(%ebp)
    6b8f:	00 00 00 
    6b92:	c7 85 78 e7 ff ff 10 	movl   $0x10,-0x1888(%ebp)
    6b99:	00 00 00 
    6b9c:	c7 85 7c e7 ff ff 00 	movl   $0x0,-0x1884(%ebp)
    6ba3:	00 00 00 
    6ba6:	c7 85 80 e7 ff ff 00 	movl   $0x0,-0x1880(%ebp)
    6bad:	00 00 00 
    6bb0:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6bb6:	89 85 84 e7 ff ff    	mov    %eax,-0x187c(%ebp)
    6bbc:	c7 85 88 e7 ff ff ff 	movl   $0x1ff,-0x1878(%ebp)
    6bc3:	01 00 00 
    6bc6:	66 c7 85 8c e7 ff ff 	movw   $0x3831,-0x1874(%ebp)
    6bcd:	31 38 
    6bcf:	c6 85 8e e7 ff ff 00 	movb   $0x0,-0x1872(%ebp)
    6bd6:	c7 85 90 e7 ff ff 10 	movl   $0x10,-0x1870(%ebp)
    6bdd:	00 00 00 
    6be0:	c7 85 94 e7 ff ff 10 	movl   $0x10,-0x186c(%ebp)
    6be7:	00 00 00 
    6bea:	c7 85 98 e7 ff ff 03 	movl   $0x3,-0x1868(%ebp)
    6bf1:	00 00 00 
    6bf4:	c7 85 9c e7 ff ff 07 	movl   $0x7,-0x1864(%ebp)
    6bfb:	00 00 00 
    6bfe:	c7 85 a0 e7 ff ff 10 	movl   $0x10,-0x1860(%ebp)
    6c05:	00 00 00 
    6c08:	c7 85 a4 e7 ff ff 00 	movl   $0x0,-0x185c(%ebp)
    6c0f:	00 00 00 
    6c12:	c7 85 a8 e7 ff ff 00 	movl   $0x0,-0x1858(%ebp)
    6c19:	00 00 00 
    6c1c:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6c22:	89 85 ac e7 ff ff    	mov    %eax,-0x1854(%ebp)
    6c28:	c7 85 b0 e7 ff ff ff 	movl   $0x1ff,-0x1850(%ebp)
    6c2f:	01 00 00 
    6c32:	66 c7 85 b4 e7 ff ff 	movw   $0x3931,-0x184c(%ebp)
    6c39:	31 39 
    6c3b:	c6 85 b6 e7 ff ff 00 	movb   $0x0,-0x184a(%ebp)
    6c42:	c7 85 b8 e7 ff ff 10 	movl   $0x10,-0x1848(%ebp)
    6c49:	00 00 00 
    6c4c:	c7 85 bc e7 ff ff 10 	movl   $0x10,-0x1844(%ebp)
    6c53:	00 00 00 
    6c56:	c7 85 c0 e7 ff ff 04 	movl   $0x4,-0x1840(%ebp)
    6c5d:	00 00 00 
    6c60:	c7 85 c4 e7 ff ff 0f 	movl   $0xf,-0x183c(%ebp)
    6c67:	00 00 00 
    6c6a:	c7 85 c8 e7 ff ff 10 	movl   $0x10,-0x1838(%ebp)
    6c71:	00 00 00 
    6c74:	c7 85 cc e7 ff ff 00 	movl   $0x0,-0x1834(%ebp)
    6c7b:	00 00 00 
    6c7e:	c7 85 d0 e7 ff ff 00 	movl   $0x0,-0x1830(%ebp)
    6c85:	00 00 00 
    6c88:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6c8e:	89 85 d4 e7 ff ff    	mov    %eax,-0x182c(%ebp)
    6c94:	c7 85 d8 e7 ff ff ff 	movl   $0x1ff,-0x1828(%ebp)
    6c9b:	01 00 00 
    6c9e:	66 c7 85 dc e7 ff ff 	movw   $0x3032,-0x1824(%ebp)
    6ca5:	32 30 
    6ca7:	c6 85 de e7 ff ff 00 	movb   $0x0,-0x1822(%ebp)
    6cae:	c7 85 e0 e7 ff ff 10 	movl   $0x10,-0x1820(%ebp)
    6cb5:	00 00 00 
    6cb8:	c7 85 e4 e7 ff ff 10 	movl   $0x10,-0x181c(%ebp)
    6cbf:	00 00 00 
    6cc2:	c7 85 e8 e7 ff ff 06 	movl   $0x6,-0x1818(%ebp)
    6cc9:	00 00 00 
    6ccc:	c7 85 ec e7 ff ff 3f 	movl   $0x3f,-0x1814(%ebp)
    6cd3:	00 00 00 
    6cd6:	c7 85 f0 e7 ff ff 10 	movl   $0x10,-0x1810(%ebp)
    6cdd:	00 00 00 
    6ce0:	c7 85 f4 e7 ff ff 00 	movl   $0x0,-0x180c(%ebp)
    6ce7:	00 00 00 
    6cea:	c7 85 f8 e7 ff ff 00 	movl   $0x0,-0x1808(%ebp)
    6cf1:	00 00 00 
    6cf4:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6cfa:	89 85 fc e7 ff ff    	mov    %eax,-0x1804(%ebp)
    6d00:	c7 85 00 e8 ff ff ff 	movl   $0x1ff,-0x1800(%ebp)
    6d07:	01 00 00 
    6d0a:	66 c7 85 04 e8 ff ff 	movw   $0x3132,-0x17fc(%ebp)
    6d11:	32 31 
    6d13:	c6 85 06 e8 ff ff 00 	movb   $0x0,-0x17fa(%ebp)
    6d1a:	c7 85 08 e8 ff ff 10 	movl   $0x10,-0x17f8(%ebp)
    6d21:	00 00 00 
    6d24:	c7 85 0c e8 ff ff 10 	movl   $0x10,-0x17f4(%ebp)
    6d2b:	00 00 00 
    6d2e:	c7 85 10 e8 ff ff 08 	movl   $0x8,-0x17f0(%ebp)
    6d35:	00 00 00 
    6d38:	c7 85 14 e8 ff ff ff 	movl   $0xff,-0x17ec(%ebp)
    6d3f:	00 00 00 
    6d42:	c7 85 18 e8 ff ff 10 	movl   $0x10,-0x17e8(%ebp)
    6d49:	00 00 00 
    6d4c:	c7 85 1c e8 ff ff 00 	movl   $0x0,-0x17e4(%ebp)
    6d53:	00 00 00 
    6d56:	c7 85 20 e8 ff ff 00 	movl   $0x0,-0x17e0(%ebp)
    6d5d:	00 00 00 
    6d60:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6d66:	89 85 24 e8 ff ff    	mov    %eax,-0x17dc(%ebp)
    6d6c:	c7 85 28 e8 ff ff ff 	movl   $0x1ff,-0x17d8(%ebp)
    6d73:	01 00 00 
    6d76:	66 c7 85 2c e8 ff ff 	movw   $0x3232,-0x17d4(%ebp)
    6d7d:	32 32 
    6d7f:	c6 85 2e e8 ff ff 00 	movb   $0x0,-0x17d2(%ebp)
    6d86:	c7 85 30 e8 ff ff 10 	movl   $0x10,-0x17d0(%ebp)
    6d8d:	00 00 00 
    6d90:	c7 85 34 e8 ff ff 10 	movl   $0x10,-0x17cc(%ebp)
    6d97:	00 00 00 
    6d9a:	c7 85 38 e8 ff ff 0a 	movl   $0xa,-0x17c8(%ebp)
    6da1:	00 00 00 
    6da4:	c7 85 3c e8 ff ff ff 	movl   $0x3ff,-0x17c4(%ebp)
    6dab:	03 00 00 
    6dae:	c7 85 40 e8 ff ff 10 	movl   $0x10,-0x17c0(%ebp)
    6db5:	00 00 00 
    6db8:	c7 85 44 e8 ff ff 00 	movl   $0x0,-0x17bc(%ebp)
    6dbf:	00 00 00 
    6dc2:	c7 85 48 e8 ff ff 00 	movl   $0x0,-0x17b8(%ebp)
    6dc9:	00 00 00 
    6dcc:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6dd2:	89 85 4c e8 ff ff    	mov    %eax,-0x17b4(%ebp)
    6dd8:	c7 85 50 e8 ff ff ff 	movl   $0x1ff,-0x17b0(%ebp)
    6ddf:	01 00 00 
    6de2:	66 c7 85 54 e8 ff ff 	movw   $0x3332,-0x17ac(%ebp)
    6de9:	32 33 
    6deb:	c6 85 56 e8 ff ff 00 	movb   $0x0,-0x17aa(%ebp)
    6df2:	c7 85 58 e8 ff ff 10 	movl   $0x10,-0x17a8(%ebp)
    6df9:	00 00 00 
    6dfc:	c7 85 5c e8 ff ff 10 	movl   $0x10,-0x17a4(%ebp)
    6e03:	00 00 00 
    6e06:	c7 85 60 e8 ff ff 0d 	movl   $0xd,-0x17a0(%ebp)
    6e0d:	00 00 00 
    6e10:	c7 85 64 e8 ff ff ff 	movl   $0x1fff,-0x179c(%ebp)
    6e17:	1f 00 00 
    6e1a:	c7 85 68 e8 ff ff 10 	movl   $0x10,-0x1798(%ebp)
    6e21:	00 00 00 
    6e24:	c7 85 6c e8 ff ff 00 	movl   $0x0,-0x1794(%ebp)
    6e2b:	00 00 00 
    6e2e:	c7 85 70 e8 ff ff 00 	movl   $0x0,-0x1790(%ebp)
    6e35:	00 00 00 
    6e38:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6e3e:	89 85 74 e8 ff ff    	mov    %eax,-0x178c(%ebp)
    6e44:	c7 85 78 e8 ff ff ff 	movl   $0x1ff,-0x1788(%ebp)
    6e4b:	01 00 00 
    6e4e:	66 c7 85 7c e8 ff ff 	movw   $0x3432,-0x1784(%ebp)
    6e55:	32 34 
    6e57:	c6 85 7e e8 ff ff 00 	movb   $0x0,-0x1782(%ebp)
    6e5e:	c7 85 80 e8 ff ff 10 	movl   $0x10,-0x1780(%ebp)
    6e65:	00 00 00 
    6e68:	c7 85 84 e8 ff ff 10 	movl   $0x10,-0x177c(%ebp)
    6e6f:	00 00 00 
    6e72:	c7 85 88 e8 ff ff 04 	movl   $0x4,-0x1778(%ebp)
    6e79:	00 00 00 
    6e7c:	c7 85 8c e8 ff ff 0f 	movl   $0xf,-0x1774(%ebp)
    6e83:	00 00 00 
    6e86:	c7 85 90 e8 ff ff ff 	movl   $0xffffffff,-0x1770(%ebp)
    6e8d:	ff ff ff 
    6e90:	c7 85 94 e8 ff ff 00 	movl   $0x0,-0x176c(%ebp)
    6e97:	00 00 00 
    6e9a:	c7 85 98 e8 ff ff 00 	movl   $0x0,-0x1768(%ebp)
    6ea1:	00 00 00 
    6ea4:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    6eaa:	89 85 9c e8 ff ff    	mov    %eax,-0x1764(%ebp)
    6eb0:	c7 85 a0 e8 ff ff 00 	movl   $0x200,-0x1760(%ebp)
    6eb7:	02 00 00 
    6eba:	66 c7 85 a4 e8 ff ff 	movw   $0x3532,-0x175c(%ebp)
    6ec1:	32 35 
    6ec3:	c6 85 a6 e8 ff ff 00 	movb   $0x0,-0x175a(%ebp)
    6eca:	c7 85 a8 e8 ff ff 10 	movl   $0x10,-0x1758(%ebp)
    6ed1:	00 00 00 
    6ed4:	c7 85 ac e8 ff ff 10 	movl   $0x10,-0x1754(%ebp)
    6edb:	00 00 00 
    6ede:	c7 85 b0 e8 ff ff 05 	movl   $0x5,-0x1750(%ebp)
    6ee5:	00 00 00 
    6ee8:	c7 85 b4 e8 ff ff 1f 	movl   $0x1f,-0x174c(%ebp)
    6eef:	00 00 00 
    6ef2:	c7 85 b8 e8 ff ff 18 	movl   $0x18,-0x1748(%ebp)
    6ef9:	00 00 00 
    6efc:	c7 85 bc e8 ff ff 00 	movl   $0x0,-0x1744(%ebp)
    6f03:	00 00 00 
    6f06:	c7 85 c0 e8 ff ff 00 	movl   $0x0,-0x1740(%ebp)
    6f0d:	00 00 00 
    6f10:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    6f16:	89 85 c4 e8 ff ff    	mov    %eax,-0x173c(%ebp)
    6f1c:	c7 85 c8 e8 ff ff 00 	movl   $0x200,-0x1738(%ebp)
    6f23:	02 00 00 
    6f26:	66 c7 85 cc e8 ff ff 	movw   $0x3632,-0x1734(%ebp)
    6f2d:	32 36 
    6f2f:	c6 85 ce e8 ff ff 00 	movb   $0x0,-0x1732(%ebp)
    6f36:	c7 85 d0 e8 ff ff 10 	movl   $0x10,-0x1730(%ebp)
    6f3d:	00 00 00 
    6f40:	c7 85 d4 e8 ff ff 10 	movl   $0x10,-0x172c(%ebp)
    6f47:	00 00 00 
    6f4a:	c7 85 d8 e8 ff ff 06 	movl   $0x6,-0x1728(%ebp)
    6f51:	00 00 00 
    6f54:	c7 85 dc e8 ff ff 3f 	movl   $0x3f,-0x1724(%ebp)
    6f5b:	00 00 00 
    6f5e:	c7 85 e0 e8 ff ff 18 	movl   $0x18,-0x1720(%ebp)
    6f65:	00 00 00 
    6f68:	c7 85 e4 e8 ff ff 00 	movl   $0x0,-0x171c(%ebp)
    6f6f:	00 00 00 
    6f72:	c7 85 e8 e8 ff ff 00 	movl   $0x0,-0x1718(%ebp)
    6f79:	00 00 00 
    6f7c:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    6f82:	89 85 ec e8 ff ff    	mov    %eax,-0x1714(%ebp)
    6f88:	c7 85 f0 e8 ff ff 00 	movl   $0x200,-0x1710(%ebp)
    6f8f:	02 00 00 
    6f92:	66 c7 85 f4 e8 ff ff 	movw   $0x3732,-0x170c(%ebp)
    6f99:	32 37 
    6f9b:	c6 85 f6 e8 ff ff 00 	movb   $0x0,-0x170a(%ebp)
    6fa2:	c7 85 f8 e8 ff ff 10 	movl   $0x10,-0x1708(%ebp)
    6fa9:	00 00 00 
    6fac:	c7 85 fc e8 ff ff 10 	movl   $0x10,-0x1704(%ebp)
    6fb3:	00 00 00 
    6fb6:	c7 85 00 e9 ff ff 07 	movl   $0x7,-0x1700(%ebp)
    6fbd:	00 00 00 
    6fc0:	c7 85 04 e9 ff ff 7f 	movl   $0x7f,-0x16fc(%ebp)
    6fc7:	00 00 00 
    6fca:	c7 85 08 e9 ff ff 18 	movl   $0x18,-0x16f8(%ebp)
    6fd1:	00 00 00 
    6fd4:	c7 85 0c e9 ff ff 00 	movl   $0x0,-0x16f4(%ebp)
    6fdb:	00 00 00 
    6fde:	c7 85 10 e9 ff ff 00 	movl   $0x0,-0x16f0(%ebp)
    6fe5:	00 00 00 
    6fe8:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    6fee:	89 85 14 e9 ff ff    	mov    %eax,-0x16ec(%ebp)
    6ff4:	c7 85 18 e9 ff ff 00 	movl   $0x200,-0x16e8(%ebp)
    6ffb:	02 00 00 
    6ffe:	66 c7 85 1c e9 ff ff 	movw   $0x3832,-0x16e4(%ebp)
    7005:	32 38 
    7007:	c6 85 1e e9 ff ff 00 	movb   $0x0,-0x16e2(%ebp)
    700e:	c7 85 20 e9 ff ff 10 	movl   $0x10,-0x16e0(%ebp)
    7015:	00 00 00 
    7018:	c7 85 24 e9 ff ff 10 	movl   $0x10,-0x16dc(%ebp)
    701f:	00 00 00 
    7022:	c7 85 28 e9 ff ff 08 	movl   $0x8,-0x16d8(%ebp)
    7029:	00 00 00 
    702c:	c7 85 2c e9 ff ff ff 	movl   $0xff,-0x16d4(%ebp)
    7033:	00 00 00 
    7036:	c7 85 30 e9 ff ff 18 	movl   $0x18,-0x16d0(%ebp)
    703d:	00 00 00 
    7040:	c7 85 34 e9 ff ff 00 	movl   $0x0,-0x16cc(%ebp)
    7047:	00 00 00 
    704a:	c7 85 38 e9 ff ff 00 	movl   $0x0,-0x16c8(%ebp)
    7051:	00 00 00 
    7054:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    705a:	89 85 3c e9 ff ff    	mov    %eax,-0x16c4(%ebp)
    7060:	c7 85 40 e9 ff ff 00 	movl   $0x200,-0x16c0(%ebp)
    7067:	02 00 00 
    706a:	66 c7 85 44 e9 ff ff 	movw   $0x3932,-0x16bc(%ebp)
    7071:	32 39 
    7073:	c6 85 46 e9 ff ff 00 	movb   $0x0,-0x16ba(%ebp)
    707a:	c7 85 48 e9 ff ff 10 	movl   $0x10,-0x16b8(%ebp)
    7081:	00 00 00 
    7084:	c7 85 4c e9 ff ff 10 	movl   $0x10,-0x16b4(%ebp)
    708b:	00 00 00 
    708e:	c7 85 50 e9 ff ff 09 	movl   $0x9,-0x16b0(%ebp)
    7095:	00 00 00 
    7098:	c7 85 54 e9 ff ff ff 	movl   $0x1ff,-0x16ac(%ebp)
    709f:	01 00 00 
    70a2:	c7 85 58 e9 ff ff 18 	movl   $0x18,-0x16a8(%ebp)
    70a9:	00 00 00 
    70ac:	c7 85 5c e9 ff ff 00 	movl   $0x0,-0x16a4(%ebp)
    70b3:	00 00 00 
    70b6:	c7 85 60 e9 ff ff 00 	movl   $0x0,-0x16a0(%ebp)
    70bd:	00 00 00 
    70c0:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    70c6:	89 85 64 e9 ff ff    	mov    %eax,-0x169c(%ebp)
    70cc:	c7 85 68 e9 ff ff 00 	movl   $0x200,-0x1698(%ebp)
    70d3:	02 00 00 
    70d6:	66 c7 85 6c e9 ff ff 	movw   $0x3033,-0x1694(%ebp)
    70dd:	33 30 
    70df:	c6 85 6e e9 ff ff 00 	movb   $0x0,-0x1692(%ebp)
    70e6:	c7 85 70 e9 ff ff 10 	movl   $0x10,-0x1690(%ebp)
    70ed:	00 00 00 
    70f0:	c7 85 74 e9 ff ff 10 	movl   $0x10,-0x168c(%ebp)
    70f7:	00 00 00 
    70fa:	c7 85 78 e9 ff ff 0b 	movl   $0xb,-0x1688(%ebp)
    7101:	00 00 00 
    7104:	c7 85 7c e9 ff ff ff 	movl   $0x7ff,-0x1684(%ebp)
    710b:	07 00 00 
    710e:	c7 85 80 e9 ff ff 18 	movl   $0x18,-0x1680(%ebp)
    7115:	00 00 00 
    7118:	c7 85 84 e9 ff ff 00 	movl   $0x0,-0x167c(%ebp)
    711f:	00 00 00 
    7122:	c7 85 88 e9 ff ff 00 	movl   $0x0,-0x1678(%ebp)
    7129:	00 00 00 
    712c:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    7132:	89 85 8c e9 ff ff    	mov    %eax,-0x1674(%ebp)
    7138:	c7 85 90 e9 ff ff 00 	movl   $0x200,-0x1670(%ebp)
    713f:	02 00 00 
    7142:	66 c7 85 94 e9 ff ff 	movw   $0x3133,-0x166c(%ebp)
    7149:	33 31 
    714b:	c6 85 96 e9 ff ff 00 	movb   $0x0,-0x166a(%ebp)
    7152:	c7 85 98 e9 ff ff 10 	movl   $0x10,-0x1668(%ebp)
    7159:	00 00 00 
    715c:	c7 85 9c e9 ff ff 10 	movl   $0x10,-0x1664(%ebp)
    7163:	00 00 00 
    7166:	c7 85 a0 e9 ff ff 0d 	movl   $0xd,-0x1660(%ebp)
    716d:	00 00 00 
    7170:	c7 85 a4 e9 ff ff ff 	movl   $0x1fff,-0x165c(%ebp)
    7177:	1f 00 00 
    717a:	c7 85 a8 e9 ff ff 18 	movl   $0x18,-0x1658(%ebp)
    7181:	00 00 00 
    7184:	c7 85 ac e9 ff ff 00 	movl   $0x0,-0x1654(%ebp)
    718b:	00 00 00 
    718e:	c7 85 b0 e9 ff ff 00 	movl   $0x0,-0x1650(%ebp)
    7195:	00 00 00 
    7198:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    719e:	89 85 b4 e9 ff ff    	mov    %eax,-0x164c(%ebp)
    71a4:	c7 85 b8 e9 ff ff 00 	movl   $0x200,-0x1648(%ebp)
    71ab:	02 00 00 
    71ae:	66 c7 85 bc e9 ff ff 	movw   $0x3233,-0x1644(%ebp)
    71b5:	33 32 
    71b7:	c6 85 be e9 ff ff 00 	movb   $0x0,-0x1642(%ebp)
    71be:	c7 85 c0 e9 ff ff 01 	movl   $0x1,-0x1640(%ebp)
    71c5:	00 00 00 
    71c8:	c7 85 c4 e9 ff ff 10 	movl   $0x10,-0x163c(%ebp)
    71cf:	00 00 00 
    71d2:	c7 85 c8 e9 ff ff 00 	movl   $0x0,-0x1638(%ebp)
    71d9:	00 00 00 
    71dc:	c7 85 cc e9 ff ff 00 	movl   $0x0,-0x1634(%ebp)
    71e3:	00 00 00 
    71e6:	c7 85 d0 e9 ff ff ff 	movl   $0xffffffff,-0x1630(%ebp)
    71ed:	ff ff ff 
    71f0:	c7 85 d4 e9 ff ff 00 	movl   $0x0,-0x162c(%ebp)
    71f7:	00 00 00 
    71fa:	c7 85 d8 e9 ff ff 00 	movl   $0x0,-0x1628(%ebp)
    7201:	00 00 00 
    7204:	8d 85 4a ea ff ff    	lea    -0x15b6(%ebp),%eax
    720a:	89 85 dc e9 ff ff    	mov    %eax,-0x1624(%ebp)
    7210:	c7 85 e0 e9 ff ff 1f 	movl   $0x1f,-0x1620(%ebp)
    7217:	00 00 00 
    721a:	66 c7 85 e4 e9 ff ff 	movw   $0x3333,-0x161c(%ebp)
    7221:	33 33 
    7223:	c6 85 e6 e9 ff ff 00 	movb   $0x0,-0x161a(%ebp)
    722a:	c7 85 e8 e9 ff ff 01 	movl   $0x1,-0x1618(%ebp)
    7231:	00 00 00 
    7234:	c7 85 ec e9 ff ff 10 	movl   $0x10,-0x1614(%ebp)
    723b:	00 00 00 
    723e:	c7 85 f0 e9 ff ff 00 	movl   $0x0,-0x1610(%ebp)
    7245:	00 00 00 
    7248:	c7 85 f4 e9 ff ff 00 	movl   $0x0,-0x160c(%ebp)
    724f:	00 00 00 
    7252:	c7 85 f8 e9 ff ff ff 	movl   $0xffffffff,-0x1608(%ebp)
    7259:	ff ff ff 
    725c:	c7 85 fc e9 ff ff 00 	movl   $0x0,-0x1604(%ebp)
    7263:	00 00 00 
    7266:	c7 85 00 ea ff ff 00 	movl   $0x0,-0x1600(%ebp)
    726d:	00 00 00 
    7270:	8d 85 0c ea ff ff    	lea    -0x15f4(%ebp),%eax
    7276:	89 85 04 ea ff ff    	mov    %eax,-0x15fc(%ebp)
    727c:	c7 85 08 ea ff ff 1f 	movl   $0x1f,-0x15f8(%ebp)
    7283:	00 00 00 
		{"31", 16, 16, 13, 8191, 24, 0, 0, h24, 512},
		{"32", 1, 16, 0, 0, -1, 0, 0, hA, 31},
		{"33", 1, 16, 0, 0, -1, 0, 0, hB, 31}
	};
	ht[0] = ht[0];
}
    7286:	81 c4 40 1b 00 00    	add    $0x1b40,%esp
    728c:	5b                   	pop    %ebx
    728d:	5e                   	pop    %esi
    728e:	5f                   	pop    %edi
    728f:	5d                   	pop    %ebp
    7290:	c3                   	ret    

00007291 <huffman_decoder>:


/* ����huffman����	*/
/* ע��! ��counta,countb - 4 bit ֵ �� y����, discard x */
int huffman_decoder(struct huffcodetab *h, int *x, int *y, int *v, int *w)
{  
    7291:	55                   	push   %ebp
    7292:	89 e5                	mov    %esp,%ebp
    7294:	53                   	push   %ebx
    7295:	83 ec 24             	sub    $0x24,%esp
  HUFFBITS level;
  int point = 0;
    7298:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int error = 1;
    729f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
  level     = dmask;
    72a6:	a1 70 ec 00 00       	mov    0xec70,%eax
    72ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (h->val == 0) return 2;
    72ae:	8b 45 08             	mov    0x8(%ebp),%eax
    72b1:	8b 40 20             	mov    0x20(%eax),%eax
    72b4:	85 c0                	test   %eax,%eax
    72b6:	75 0a                	jne    72c2 <huffman_decoder+0x31>
    72b8:	b8 02 00 00 00       	mov    $0x2,%eax
    72bd:	e9 0d 03 00 00       	jmp    75cf <huffman_decoder+0x33e>

  /* table 0 ����Ҫ bits */
  if ( h->treelen == 0)
    72c2:	8b 45 08             	mov    0x8(%ebp),%eax
    72c5:	8b 40 24             	mov    0x24(%eax),%eax
    72c8:	85 c0                	test   %eax,%eax
    72ca:	75 1d                	jne    72e9 <huffman_decoder+0x58>
  {  *x = *y = 0;
    72cc:	8b 45 10             	mov    0x10(%ebp),%eax
    72cf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    72d5:	8b 45 10             	mov    0x10(%ebp),%eax
    72d8:	8b 10                	mov    (%eax),%edx
    72da:	8b 45 0c             	mov    0xc(%ebp),%eax
    72dd:	89 10                	mov    %edx,(%eax)
     return 0;
    72df:	b8 00 00 00 00       	mov    $0x0,%eax
    72e4:	e9 e6 02 00 00       	jmp    75cf <huffman_decoder+0x33e>


  /* ���� Huffman table. */

  do {
    if (h->val[point][0]==0) {   /*���Ľ�β*/
    72e9:	8b 45 08             	mov    0x8(%ebp),%eax
    72ec:	8b 40 20             	mov    0x20(%eax),%eax
    72ef:	8b 55 f0             	mov    -0x10(%ebp),%edx
    72f2:	01 d2                	add    %edx,%edx
    72f4:	01 d0                	add    %edx,%eax
    72f6:	0f b6 00             	movzbl (%eax),%eax
    72f9:	84 c0                	test   %al,%al
    72fb:	75 46                	jne    7343 <huffman_decoder+0xb2>
      *x = h->val[point][1] >> 4;
    72fd:	8b 45 08             	mov    0x8(%ebp),%eax
    7300:	8b 40 20             	mov    0x20(%eax),%eax
    7303:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7306:	01 d2                	add    %edx,%edx
    7308:	01 d0                	add    %edx,%eax
    730a:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    730e:	c0 e8 04             	shr    $0x4,%al
    7311:	0f b6 d0             	movzbl %al,%edx
    7314:	8b 45 0c             	mov    0xc(%ebp),%eax
    7317:	89 10                	mov    %edx,(%eax)
      *y = h->val[point][1] & 0xf;
    7319:	8b 45 08             	mov    0x8(%ebp),%eax
    731c:	8b 40 20             	mov    0x20(%eax),%eax
    731f:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7322:	01 d2                	add    %edx,%edx
    7324:	01 d0                	add    %edx,%eax
    7326:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    732a:	0f b6 c0             	movzbl %al,%eax
    732d:	83 e0 0f             	and    $0xf,%eax
    7330:	89 c2                	mov    %eax,%edx
    7332:	8b 45 10             	mov    0x10(%ebp),%eax
    7335:	89 10                	mov    %edx,(%eax)

      error = 0;
    7337:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
      break;
    733e:	e9 af 00 00 00       	jmp    73f2 <huffman_decoder+0x161>
    } 
    if (hget1bit()) {
    7343:	e8 a7 e6 ff ff       	call   59ef <hget1bit>
    7348:	85 c0                	test   %eax,%eax
    734a:	74 47                	je     7393 <huffman_decoder+0x102>
      while (h->val[point][1] >= MXOFF) point += h->val[point][1]; 
    734c:	eb 17                	jmp    7365 <huffman_decoder+0xd4>
    734e:	8b 45 08             	mov    0x8(%ebp),%eax
    7351:	8b 40 20             	mov    0x20(%eax),%eax
    7354:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7357:	01 d2                	add    %edx,%edx
    7359:	01 d0                	add    %edx,%eax
    735b:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    735f:	0f b6 c0             	movzbl %al,%eax
    7362:	01 45 f0             	add    %eax,-0x10(%ebp)
    7365:	8b 45 08             	mov    0x8(%ebp),%eax
    7368:	8b 40 20             	mov    0x20(%eax),%eax
    736b:	8b 55 f0             	mov    -0x10(%ebp),%edx
    736e:	01 d2                	add    %edx,%edx
    7370:	01 d0                	add    %edx,%eax
    7372:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    7376:	3c f9                	cmp    $0xf9,%al
    7378:	77 d4                	ja     734e <huffman_decoder+0xbd>
      point += h->val[point][1];
    737a:	8b 45 08             	mov    0x8(%ebp),%eax
    737d:	8b 40 20             	mov    0x20(%eax),%eax
    7380:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7383:	01 d2                	add    %edx,%edx
    7385:	01 d0                	add    %edx,%eax
    7387:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    738b:	0f b6 c0             	movzbl %al,%eax
    738e:	01 45 f0             	add    %eax,-0x10(%ebp)
    7391:	eb 42                	jmp    73d5 <huffman_decoder+0x144>
    }
    else {
      while (h->val[point][0] >= MXOFF) point += h->val[point][0]; 
    7393:	eb 16                	jmp    73ab <huffman_decoder+0x11a>
    7395:	8b 45 08             	mov    0x8(%ebp),%eax
    7398:	8b 40 20             	mov    0x20(%eax),%eax
    739b:	8b 55 f0             	mov    -0x10(%ebp),%edx
    739e:	01 d2                	add    %edx,%edx
    73a0:	01 d0                	add    %edx,%eax
    73a2:	0f b6 00             	movzbl (%eax),%eax
    73a5:	0f b6 c0             	movzbl %al,%eax
    73a8:	01 45 f0             	add    %eax,-0x10(%ebp)
    73ab:	8b 45 08             	mov    0x8(%ebp),%eax
    73ae:	8b 40 20             	mov    0x20(%eax),%eax
    73b1:	8b 55 f0             	mov    -0x10(%ebp),%edx
    73b4:	01 d2                	add    %edx,%edx
    73b6:	01 d0                	add    %edx,%eax
    73b8:	0f b6 00             	movzbl (%eax),%eax
    73bb:	3c f9                	cmp    $0xf9,%al
    73bd:	77 d6                	ja     7395 <huffman_decoder+0x104>
      point += h->val[point][0];
    73bf:	8b 45 08             	mov    0x8(%ebp),%eax
    73c2:	8b 40 20             	mov    0x20(%eax),%eax
    73c5:	8b 55 f0             	mov    -0x10(%ebp),%edx
    73c8:	01 d2                	add    %edx,%edx
    73ca:	01 d0                	add    %edx,%eax
    73cc:	0f b6 00             	movzbl (%eax),%eax
    73cf:	0f b6 c0             	movzbl %al,%eax
    73d2:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    level >>= 1;
    73d5:	d1 6d f4             	shrl   -0xc(%ebp)
  } while (level  || (point < ht->treelen) );
    73d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    73dc:	0f 85 07 ff ff ff    	jne    72e9 <huffman_decoder+0x58>
    73e2:	8b 55 f0             	mov    -0x10(%ebp),%edx
    73e5:	a1 24 fd 02 00       	mov    0x2fd24,%eax
    73ea:	39 c2                	cmp    %eax,%edx
    73ec:	0f 82 f7 fe ff ff    	jb     72e9 <huffman_decoder+0x58>
  
  /* ������ */
  
  if (error) { /* ���� x �� y Ϊһ�м�ֵ */
    73f2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    73f6:	74 24                	je     741c <huffman_decoder+0x18b>
    //print(0, "Illegal Huffman code in data.\n");
    *x = ((h->xlen-1) << 1);
    73f8:	8b 45 08             	mov    0x8(%ebp),%eax
    73fb:	8b 40 04             	mov    0x4(%eax),%eax
    73fe:	83 e8 01             	sub    $0x1,%eax
    7401:	01 c0                	add    %eax,%eax
    7403:	89 c2                	mov    %eax,%edx
    7405:	8b 45 0c             	mov    0xc(%ebp),%eax
    7408:	89 10                	mov    %edx,(%eax)
    *y = ((h->ylen-1) << 1);
    740a:	8b 45 08             	mov    0x8(%ebp),%eax
    740d:	8b 40 08             	mov    0x8(%eax),%eax
    7410:	83 e8 01             	sub    $0x1,%eax
    7413:	01 c0                	add    %eax,%eax
    7415:	89 c2                	mov    %eax,%edx
    7417:	8b 45 10             	mov    0x10(%ebp),%eax
    741a:	89 10                	mov    %edx,(%eax)
  }

  /* �����źű��� */

  if (h->tablename[0] == '3'
    741c:	8b 45 08             	mov    0x8(%ebp),%eax
    741f:	0f b6 00             	movzbl (%eax),%eax
    7422:	3c 33                	cmp    $0x33,%al
    7424:	0f 85 ec 00 00 00    	jne    7516 <huffman_decoder+0x285>
      && (h->tablename[1] == '2' || h->tablename[1] == '3')) {
    742a:	8b 45 08             	mov    0x8(%ebp),%eax
    742d:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    7431:	3c 32                	cmp    $0x32,%al
    7433:	74 0f                	je     7444 <huffman_decoder+0x1b3>
    7435:	8b 45 08             	mov    0x8(%ebp),%eax
    7438:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    743c:	3c 33                	cmp    $0x33,%al
    743e:	0f 85 d2 00 00 00    	jne    7516 <huffman_decoder+0x285>
     *v = (*y>>3) & 1;
    7444:	8b 45 10             	mov    0x10(%ebp),%eax
    7447:	8b 00                	mov    (%eax),%eax
    7449:	c1 f8 03             	sar    $0x3,%eax
    744c:	83 e0 01             	and    $0x1,%eax
    744f:	89 c2                	mov    %eax,%edx
    7451:	8b 45 14             	mov    0x14(%ebp),%eax
    7454:	89 10                	mov    %edx,(%eax)
     *w = (*y>>2) & 1;
    7456:	8b 45 10             	mov    0x10(%ebp),%eax
    7459:	8b 00                	mov    (%eax),%eax
    745b:	c1 f8 02             	sar    $0x2,%eax
    745e:	83 e0 01             	and    $0x1,%eax
    7461:	89 c2                	mov    %eax,%edx
    7463:	8b 45 18             	mov    0x18(%ebp),%eax
    7466:	89 10                	mov    %edx,(%eax)
     *x = (*y>>1) & 1;
    7468:	8b 45 10             	mov    0x10(%ebp),%eax
    746b:	8b 00                	mov    (%eax),%eax
    746d:	d1 f8                	sar    %eax
    746f:	83 e0 01             	and    $0x1,%eax
    7472:	89 c2                	mov    %eax,%edx
    7474:	8b 45 0c             	mov    0xc(%ebp),%eax
    7477:	89 10                	mov    %edx,(%eax)
     *y = *y & 1;
    7479:	8b 45 10             	mov    0x10(%ebp),%eax
    747c:	8b 00                	mov    (%eax),%eax
    747e:	83 e0 01             	and    $0x1,%eax
    7481:	89 c2                	mov    %eax,%edx
    7483:	8b 45 10             	mov    0x10(%ebp),%eax
    7486:	89 10                	mov    %edx,(%eax)
     /* v, w, x �� y �ڱ��������ǵߵ��ģ��������� 
         */
     
/*   {int i=*v; *v=*y; *y=i; i=*w; *w=*x; *x=i;}  MI */

     if (*v)
    7488:	8b 45 14             	mov    0x14(%ebp),%eax
    748b:	8b 00                	mov    (%eax),%eax
    748d:	85 c0                	test   %eax,%eax
    748f:	74 18                	je     74a9 <huffman_decoder+0x218>
        if (hget1bit() == 1) *v = -*v;
    7491:	e8 59 e5 ff ff       	call   59ef <hget1bit>
    7496:	83 f8 01             	cmp    $0x1,%eax
    7499:	75 0e                	jne    74a9 <huffman_decoder+0x218>
    749b:	8b 45 14             	mov    0x14(%ebp),%eax
    749e:	8b 00                	mov    (%eax),%eax
    74a0:	f7 d8                	neg    %eax
    74a2:	89 c2                	mov    %eax,%edx
    74a4:	8b 45 14             	mov    0x14(%ebp),%eax
    74a7:	89 10                	mov    %edx,(%eax)
     if (*w)
    74a9:	8b 45 18             	mov    0x18(%ebp),%eax
    74ac:	8b 00                	mov    (%eax),%eax
    74ae:	85 c0                	test   %eax,%eax
    74b0:	74 18                	je     74ca <huffman_decoder+0x239>
        if (hget1bit() == 1) *w = -*w;
    74b2:	e8 38 e5 ff ff       	call   59ef <hget1bit>
    74b7:	83 f8 01             	cmp    $0x1,%eax
    74ba:	75 0e                	jne    74ca <huffman_decoder+0x239>
    74bc:	8b 45 18             	mov    0x18(%ebp),%eax
    74bf:	8b 00                	mov    (%eax),%eax
    74c1:	f7 d8                	neg    %eax
    74c3:	89 c2                	mov    %eax,%edx
    74c5:	8b 45 18             	mov    0x18(%ebp),%eax
    74c8:	89 10                	mov    %edx,(%eax)
     if (*x)
    74ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    74cd:	8b 00                	mov    (%eax),%eax
    74cf:	85 c0                	test   %eax,%eax
    74d1:	74 18                	je     74eb <huffman_decoder+0x25a>
        if (hget1bit() == 1) *x = -*x;
    74d3:	e8 17 e5 ff ff       	call   59ef <hget1bit>
    74d8:	83 f8 01             	cmp    $0x1,%eax
    74db:	75 0e                	jne    74eb <huffman_decoder+0x25a>
    74dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    74e0:	8b 00                	mov    (%eax),%eax
    74e2:	f7 d8                	neg    %eax
    74e4:	89 c2                	mov    %eax,%edx
    74e6:	8b 45 0c             	mov    0xc(%ebp),%eax
    74e9:	89 10                	mov    %edx,(%eax)
     if (*y)
    74eb:	8b 45 10             	mov    0x10(%ebp),%eax
    74ee:	8b 00                	mov    (%eax),%eax
    74f0:	85 c0                	test   %eax,%eax
    74f2:	74 1d                	je     7511 <huffman_decoder+0x280>
        if (hget1bit() == 1) *y = -*y;
    74f4:	e8 f6 e4 ff ff       	call   59ef <hget1bit>
    74f9:	83 f8 01             	cmp    $0x1,%eax
    74fc:	75 13                	jne    7511 <huffman_decoder+0x280>
    74fe:	8b 45 10             	mov    0x10(%ebp),%eax
    7501:	8b 00                	mov    (%eax),%eax
    7503:	f7 d8                	neg    %eax
    7505:	89 c2                	mov    %eax,%edx
    7507:	8b 45 10             	mov    0x10(%ebp),%eax
    750a:	89 10                	mov    %edx,(%eax)
        if (hget1bit() == 1) *v = -*v;
     if (*w)
        if (hget1bit() == 1) *w = -*w;
     if (*x)
        if (hget1bit() == 1) *x = -*x;
     if (*y)
    750c:	e9 bb 00 00 00       	jmp    75cc <huffman_decoder+0x33b>
    7511:	e9 b6 00 00 00       	jmp    75cc <huffman_decoder+0x33b>
  else {
  
      /* �ڲ��Ա�������x �� y�ǵߵ��� 
         ����ߵ� x �� y ʹ���Ա��������� */
    
     if (h->linbits)
    7516:	8b 45 08             	mov    0x8(%ebp),%eax
    7519:	8b 40 0c             	mov    0xc(%eax),%eax
    751c:	85 c0                	test   %eax,%eax
    751e:	74 30                	je     7550 <huffman_decoder+0x2bf>
       if ((h->xlen-1) == *x) 
    7520:	8b 45 08             	mov    0x8(%ebp),%eax
    7523:	8b 40 04             	mov    0x4(%eax),%eax
    7526:	8d 50 ff             	lea    -0x1(%eax),%edx
    7529:	8b 45 0c             	mov    0xc(%ebp),%eax
    752c:	8b 00                	mov    (%eax),%eax
    752e:	39 c2                	cmp    %eax,%edx
    7530:	75 1e                	jne    7550 <huffman_decoder+0x2bf>
         *x += hgetbits(h->linbits);
    7532:	8b 45 0c             	mov    0xc(%ebp),%eax
    7535:	8b 00                	mov    (%eax),%eax
    7537:	89 c3                	mov    %eax,%ebx
    7539:	8b 45 08             	mov    0x8(%ebp),%eax
    753c:	8b 40 0c             	mov    0xc(%eax),%eax
    753f:	89 04 24             	mov    %eax,(%esp)
    7542:	e8 8d e4 ff ff       	call   59d4 <hgetbits>
    7547:	01 d8                	add    %ebx,%eax
    7549:	89 c2                	mov    %eax,%edx
    754b:	8b 45 0c             	mov    0xc(%ebp),%eax
    754e:	89 10                	mov    %edx,(%eax)
     if (*x)
    7550:	8b 45 0c             	mov    0xc(%ebp),%eax
    7553:	8b 00                	mov    (%eax),%eax
    7555:	85 c0                	test   %eax,%eax
    7557:	74 18                	je     7571 <huffman_decoder+0x2e0>
        if (hget1bit() == 1) *x = -*x;
    7559:	e8 91 e4 ff ff       	call   59ef <hget1bit>
    755e:	83 f8 01             	cmp    $0x1,%eax
    7561:	75 0e                	jne    7571 <huffman_decoder+0x2e0>
    7563:	8b 45 0c             	mov    0xc(%ebp),%eax
    7566:	8b 00                	mov    (%eax),%eax
    7568:	f7 d8                	neg    %eax
    756a:	89 c2                	mov    %eax,%edx
    756c:	8b 45 0c             	mov    0xc(%ebp),%eax
    756f:	89 10                	mov    %edx,(%eax)
     if (h->linbits)	  
    7571:	8b 45 08             	mov    0x8(%ebp),%eax
    7574:	8b 40 0c             	mov    0xc(%eax),%eax
    7577:	85 c0                	test   %eax,%eax
    7579:	74 30                	je     75ab <huffman_decoder+0x31a>
       if ((h->ylen-1) == *y)
    757b:	8b 45 08             	mov    0x8(%ebp),%eax
    757e:	8b 40 08             	mov    0x8(%eax),%eax
    7581:	8d 50 ff             	lea    -0x1(%eax),%edx
    7584:	8b 45 10             	mov    0x10(%ebp),%eax
    7587:	8b 00                	mov    (%eax),%eax
    7589:	39 c2                	cmp    %eax,%edx
    758b:	75 1e                	jne    75ab <huffman_decoder+0x31a>
         *y += hgetbits(h->linbits);
    758d:	8b 45 10             	mov    0x10(%ebp),%eax
    7590:	8b 00                	mov    (%eax),%eax
    7592:	89 c3                	mov    %eax,%ebx
    7594:	8b 45 08             	mov    0x8(%ebp),%eax
    7597:	8b 40 0c             	mov    0xc(%eax),%eax
    759a:	89 04 24             	mov    %eax,(%esp)
    759d:	e8 32 e4 ff ff       	call   59d4 <hgetbits>
    75a2:	01 d8                	add    %ebx,%eax
    75a4:	89 c2                	mov    %eax,%edx
    75a6:	8b 45 10             	mov    0x10(%ebp),%eax
    75a9:	89 10                	mov    %edx,(%eax)
     if (*y)
    75ab:	8b 45 10             	mov    0x10(%ebp),%eax
    75ae:	8b 00                	mov    (%eax),%eax
    75b0:	85 c0                	test   %eax,%eax
    75b2:	74 18                	je     75cc <huffman_decoder+0x33b>
        if (hget1bit() == 1) *y = -*y;
    75b4:	e8 36 e4 ff ff       	call   59ef <hget1bit>
    75b9:	83 f8 01             	cmp    $0x1,%eax
    75bc:	75 0e                	jne    75cc <huffman_decoder+0x33b>
    75be:	8b 45 10             	mov    0x10(%ebp),%eax
    75c1:	8b 00                	mov    (%eax),%eax
    75c3:	f7 d8                	neg    %eax
    75c5:	89 c2                	mov    %eax,%edx
    75c7:	8b 45 10             	mov    0x10(%ebp),%eax
    75ca:	89 10                	mov    %edx,(%eax)
     }
	  
  return error;  
    75cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
    75cf:	83 c4 24             	add    $0x24,%esp
    75d2:	5b                   	pop    %ebx
    75d3:	5d                   	pop    %ebp
    75d4:	c3                   	ret    

000075d5 <decode_info>:
#include "common.h"
#include "decode.h"
#include "huffman.h"

void decode_info(Bit_stream_struc *bs, struct frame_params *fr_ps)
{
    75d5:	55                   	push   %ebp
    75d6:	89 e5                	mov    %esp,%ebp
    75d8:	83 ec 28             	sub    $0x28,%esp
    layer *hdr = fr_ps->header;
    75db:	8b 45 0c             	mov    0xc(%ebp),%eax
    75de:	8b 00                	mov    (%eax),%eax
    75e0:	89 45 f4             	mov    %eax,-0xc(%ebp)

    hdr->version = get1bit(bs);
    75e3:	8b 45 08             	mov    0x8(%ebp),%eax
    75e6:	89 04 24             	mov    %eax,(%esp)
    75e9:	e8 6c df ff ff       	call   555a <get1bit>
    75ee:	89 c2                	mov    %eax,%edx
    75f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    75f3:	89 10                	mov    %edx,(%eax)
    hdr->lay = 4-getbits(bs,2);
    75f5:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    75fc:	00 
    75fd:	8b 45 08             	mov    0x8(%ebp),%eax
    7600:	89 04 24             	mov    %eax,(%esp)
    7603:	e8 64 e0 ff ff       	call   566c <getbits>
    7608:	ba 04 00 00 00       	mov    $0x4,%edx
    760d:	29 c2                	sub    %eax,%edx
    760f:	89 d0                	mov    %edx,%eax
    7611:	89 c2                	mov    %eax,%edx
    7613:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7616:	89 50 04             	mov    %edx,0x4(%eax)
    hdr->error_protection = !get1bit(bs); /* ���󱣻�. TRUE/FALSE */
    7619:	8b 45 08             	mov    0x8(%ebp),%eax
    761c:	89 04 24             	mov    %eax,(%esp)
    761f:	e8 36 df ff ff       	call   555a <get1bit>
    7624:	85 c0                	test   %eax,%eax
    7626:	0f 94 c0             	sete   %al
    7629:	0f b6 d0             	movzbl %al,%edx
    762c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    762f:	89 50 08             	mov    %edx,0x8(%eax)
    hdr->bitrate_index = getbits(bs,4);
    7632:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
    7639:	00 
    763a:	8b 45 08             	mov    0x8(%ebp),%eax
    763d:	89 04 24             	mov    %eax,(%esp)
    7640:	e8 27 e0 ff ff       	call   566c <getbits>
    7645:	89 c2                	mov    %eax,%edx
    7647:	8b 45 f4             	mov    -0xc(%ebp),%eax
    764a:	89 50 0c             	mov    %edx,0xc(%eax)
    hdr->sampling_frequency = getbits(bs,2);
    764d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7654:	00 
    7655:	8b 45 08             	mov    0x8(%ebp),%eax
    7658:	89 04 24             	mov    %eax,(%esp)
    765b:	e8 0c e0 ff ff       	call   566c <getbits>
    7660:	89 c2                	mov    %eax,%edx
    7662:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7665:	89 50 10             	mov    %edx,0x10(%eax)
    hdr->padding = get1bit(bs);
    7668:	8b 45 08             	mov    0x8(%ebp),%eax
    766b:	89 04 24             	mov    %eax,(%esp)
    766e:	e8 e7 de ff ff       	call   555a <get1bit>
    7673:	89 c2                	mov    %eax,%edx
    7675:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7678:	89 50 14             	mov    %edx,0x14(%eax)
    hdr->extension = get1bit(bs);
    767b:	8b 45 08             	mov    0x8(%ebp),%eax
    767e:	89 04 24             	mov    %eax,(%esp)
    7681:	e8 d4 de ff ff       	call   555a <get1bit>
    7686:	89 c2                	mov    %eax,%edx
    7688:	8b 45 f4             	mov    -0xc(%ebp),%eax
    768b:	89 50 18             	mov    %edx,0x18(%eax)
    hdr->mode = getbits(bs,2);
    768e:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7695:	00 
    7696:	8b 45 08             	mov    0x8(%ebp),%eax
    7699:	89 04 24             	mov    %eax,(%esp)
    769c:	e8 cb df ff ff       	call   566c <getbits>
    76a1:	89 c2                	mov    %eax,%edx
    76a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    76a6:	89 50 1c             	mov    %edx,0x1c(%eax)
    hdr->mode_ext = getbits(bs,2);
    76a9:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    76b0:	00 
    76b1:	8b 45 08             	mov    0x8(%ebp),%eax
    76b4:	89 04 24             	mov    %eax,(%esp)
    76b7:	e8 b0 df ff ff       	call   566c <getbits>
    76bc:	89 c2                	mov    %eax,%edx
    76be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    76c1:	89 50 20             	mov    %edx,0x20(%eax)
    hdr->copyright = get1bit(bs);
    76c4:	8b 45 08             	mov    0x8(%ebp),%eax
    76c7:	89 04 24             	mov    %eax,(%esp)
    76ca:	e8 8b de ff ff       	call   555a <get1bit>
    76cf:	89 c2                	mov    %eax,%edx
    76d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    76d4:	89 50 24             	mov    %edx,0x24(%eax)
    hdr->original = get1bit(bs);
    76d7:	8b 45 08             	mov    0x8(%ebp),%eax
    76da:	89 04 24             	mov    %eax,(%esp)
    76dd:	e8 78 de ff ff       	call   555a <get1bit>
    76e2:	89 c2                	mov    %eax,%edx
    76e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    76e7:	89 50 28             	mov    %edx,0x28(%eax)
    hdr->emphasis = getbits(bs,2);
    76ea:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    76f1:	00 
    76f2:	8b 45 08             	mov    0x8(%ebp),%eax
    76f5:	89 04 24             	mov    %eax,(%esp)
    76f8:	e8 6f df ff ff       	call   566c <getbits>
    76fd:	89 c2                	mov    %eax,%edx
    76ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7702:	89 50 2c             	mov    %edx,0x2c(%eax)
}
    7705:	c9                   	leave  
    7706:	c3                   	ret    

00007707 <III_get_side_info>:

void III_get_side_info(Bit_stream_struc *bs, struct III_side_info_t *si, struct frame_params *fr_ps)
{
    7707:	55                   	push   %ebp
    7708:	89 e5                	mov    %esp,%ebp
    770a:	56                   	push   %esi
    770b:	53                   	push   %ebx
    770c:	83 ec 20             	sub    $0x20,%esp
	int ch, gr, i;
	int stereo = fr_ps->stereo;
    770f:	8b 45 10             	mov    0x10(%ebp),%eax
    7712:	8b 40 08             	mov    0x8(%eax),%eax
    7715:	89 45 e8             	mov    %eax,-0x18(%ebp)

	si->main_data_begin = getbits(bs, 9);
    7718:	c7 44 24 04 09 00 00 	movl   $0x9,0x4(%esp)
    771f:	00 
    7720:	8b 45 08             	mov    0x8(%ebp),%eax
    7723:	89 04 24             	mov    %eax,(%esp)
    7726:	e8 41 df ff ff       	call   566c <getbits>
    772b:	8b 55 0c             	mov    0xc(%ebp),%edx
    772e:	89 02                	mov    %eax,(%edx)
	if (stereo == 1)
    7730:	83 7d e8 01          	cmpl   $0x1,-0x18(%ebp)
    7734:	75 1b                	jne    7751 <III_get_side_info+0x4a>
		si->private_bits = getbits(bs,5);
    7736:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    773d:	00 
    773e:	8b 45 08             	mov    0x8(%ebp),%eax
    7741:	89 04 24             	mov    %eax,(%esp)
    7744:	e8 23 df ff ff       	call   566c <getbits>
    7749:	8b 55 0c             	mov    0xc(%ebp),%edx
    774c:	89 42 04             	mov    %eax,0x4(%edx)
    774f:	eb 19                	jmp    776a <III_get_side_info+0x63>
	else
		si->private_bits = getbits(bs,3);
    7751:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    7758:	00 
    7759:	8b 45 08             	mov    0x8(%ebp),%eax
    775c:	89 04 24             	mov    %eax,(%esp)
    775f:	e8 08 df ff ff       	call   566c <getbits>
    7764:	8b 55 0c             	mov    0xc(%ebp),%edx
    7767:	89 42 04             	mov    %eax,0x4(%edx)

	for (ch=0; ch<stereo; ch++)
    776a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    7771:	eb 3d                	jmp    77b0 <III_get_side_info+0xa9>
		for (i=0; i<4; i++)
    7773:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    777a:	eb 2a                	jmp    77a6 <III_get_side_info+0x9f>
			si->ch[ch].scfsi[i] = get1bit(bs);
    777c:	8b 45 08             	mov    0x8(%ebp),%eax
    777f:	89 04 24             	mov    %eax,(%esp)
    7782:	e8 d3 dd ff ff       	call   555a <get1bit>
    7787:	89 c1                	mov    %eax,%ecx
    7789:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    778c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    778f:	89 d0                	mov    %edx,%eax
    7791:	c1 e0 02             	shl    $0x2,%eax
    7794:	01 d0                	add    %edx,%eax
    7796:	c1 e0 03             	shl    $0x3,%eax
    7799:	8b 55 ec             	mov    -0x14(%ebp),%edx
    779c:	01 d0                	add    %edx,%eax
    779e:	89 4c 83 08          	mov    %ecx,0x8(%ebx,%eax,4)
		si->private_bits = getbits(bs,5);
	else
		si->private_bits = getbits(bs,3);

	for (ch=0; ch<stereo; ch++)
		for (i=0; i<4; i++)
    77a2:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    77a6:	83 7d ec 03          	cmpl   $0x3,-0x14(%ebp)
    77aa:	7e d0                	jle    777c <III_get_side_info+0x75>
	if (stereo == 1)
		si->private_bits = getbits(bs,5);
	else
		si->private_bits = getbits(bs,3);

	for (ch=0; ch<stereo; ch++)
    77ac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    77b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    77b3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    77b6:	7c bb                	jl     7773 <III_get_side_info+0x6c>
		for (i=0; i<4; i++)
			si->ch[ch].scfsi[i] = get1bit(bs);

	for (gr=0; gr<2; gr++) {
    77b8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    77bf:	e9 c5 05 00 00       	jmp    7d89 <III_get_side_info+0x682>
		for (ch=0; ch<stereo; ch++) {
    77c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    77cb:	e9 a9 05 00 00       	jmp    7d79 <III_get_side_info+0x672>
			si->ch[ch].gr[gr].part2_3_length = getbits(bs, 12);
    77d0:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
    77d7:	00 
    77d8:	8b 45 08             	mov    0x8(%ebp),%eax
    77db:	89 04 24             	mov    %eax,(%esp)
    77de:	e8 89 de ff ff       	call   566c <getbits>
    77e3:	89 c3                	mov    %eax,%ebx
    77e5:	8b 75 0c             	mov    0xc(%ebp),%esi
    77e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    77eb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    77ee:	89 c2                	mov    %eax,%edx
    77f0:	c1 e2 03             	shl    $0x3,%edx
    77f3:	01 c2                	add    %eax,%edx
    77f5:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    77fc:	89 c2                	mov    %eax,%edx
    77fe:	89 c8                	mov    %ecx,%eax
    7800:	c1 e0 02             	shl    $0x2,%eax
    7803:	01 c8                	add    %ecx,%eax
    7805:	c1 e0 05             	shl    $0x5,%eax
    7808:	01 d0                	add    %edx,%eax
    780a:	01 f0                	add    %esi,%eax
    780c:	83 c0 18             	add    $0x18,%eax
    780f:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].big_values = getbits(bs, 9);
    7811:	c7 44 24 04 09 00 00 	movl   $0x9,0x4(%esp)
    7818:	00 
    7819:	8b 45 08             	mov    0x8(%ebp),%eax
    781c:	89 04 24             	mov    %eax,(%esp)
    781f:	e8 48 de ff ff       	call   566c <getbits>
    7824:	89 c3                	mov    %eax,%ebx
    7826:	8b 75 0c             	mov    0xc(%ebp),%esi
    7829:	8b 45 f0             	mov    -0x10(%ebp),%eax
    782c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    782f:	89 c2                	mov    %eax,%edx
    7831:	c1 e2 03             	shl    $0x3,%edx
    7834:	01 c2                	add    %eax,%edx
    7836:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    783d:	89 c2                	mov    %eax,%edx
    783f:	89 c8                	mov    %ecx,%eax
    7841:	c1 e0 02             	shl    $0x2,%eax
    7844:	01 c8                	add    %ecx,%eax
    7846:	c1 e0 05             	shl    $0x5,%eax
    7849:	01 d0                	add    %edx,%eax
    784b:	01 f0                	add    %esi,%eax
    784d:	83 c0 1c             	add    $0x1c,%eax
    7850:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].global_gain = getbits(bs, 8);
    7852:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
    7859:	00 
    785a:	8b 45 08             	mov    0x8(%ebp),%eax
    785d:	89 04 24             	mov    %eax,(%esp)
    7860:	e8 07 de ff ff       	call   566c <getbits>
    7865:	89 c3                	mov    %eax,%ebx
    7867:	8b 75 0c             	mov    0xc(%ebp),%esi
    786a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    786d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7870:	89 c2                	mov    %eax,%edx
    7872:	c1 e2 03             	shl    $0x3,%edx
    7875:	01 c2                	add    %eax,%edx
    7877:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    787e:	89 c2                	mov    %eax,%edx
    7880:	89 c8                	mov    %ecx,%eax
    7882:	c1 e0 02             	shl    $0x2,%eax
    7885:	01 c8                	add    %ecx,%eax
    7887:	c1 e0 05             	shl    $0x5,%eax
    788a:	01 d0                	add    %edx,%eax
    788c:	01 f0                	add    %esi,%eax
    788e:	83 c0 20             	add    $0x20,%eax
    7891:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].scalefac_compress = getbits(bs, 4);
    7893:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
    789a:	00 
    789b:	8b 45 08             	mov    0x8(%ebp),%eax
    789e:	89 04 24             	mov    %eax,(%esp)
    78a1:	e8 c6 dd ff ff       	call   566c <getbits>
    78a6:	89 c3                	mov    %eax,%ebx
    78a8:	8b 75 0c             	mov    0xc(%ebp),%esi
    78ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
    78ae:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    78b1:	89 c2                	mov    %eax,%edx
    78b3:	c1 e2 03             	shl    $0x3,%edx
    78b6:	01 c2                	add    %eax,%edx
    78b8:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    78bf:	89 c2                	mov    %eax,%edx
    78c1:	89 c8                	mov    %ecx,%eax
    78c3:	c1 e0 02             	shl    $0x2,%eax
    78c6:	01 c8                	add    %ecx,%eax
    78c8:	c1 e0 05             	shl    $0x5,%eax
    78cb:	01 d0                	add    %edx,%eax
    78cd:	01 f0                	add    %esi,%eax
    78cf:	83 c0 24             	add    $0x24,%eax
    78d2:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].window_switching_flag = get1bit(bs);
    78d4:	8b 45 08             	mov    0x8(%ebp),%eax
    78d7:	89 04 24             	mov    %eax,(%esp)
    78da:	e8 7b dc ff ff       	call   555a <get1bit>
    78df:	89 c3                	mov    %eax,%ebx
    78e1:	8b 75 0c             	mov    0xc(%ebp),%esi
    78e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    78e7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    78ea:	89 c2                	mov    %eax,%edx
    78ec:	c1 e2 03             	shl    $0x3,%edx
    78ef:	01 c2                	add    %eax,%edx
    78f1:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    78f8:	89 c2                	mov    %eax,%edx
    78fa:	89 c8                	mov    %ecx,%eax
    78fc:	c1 e0 02             	shl    $0x2,%eax
    78ff:	01 c8                	add    %ecx,%eax
    7901:	c1 e0 05             	shl    $0x5,%eax
    7904:	01 d0                	add    %edx,%eax
    7906:	01 f0                	add    %esi,%eax
    7908:	83 c0 28             	add    $0x28,%eax
    790b:	89 18                	mov    %ebx,(%eax)
			if (si->ch[ch].gr[gr].window_switching_flag) {
    790d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7910:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7913:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7916:	89 c2                	mov    %eax,%edx
    7918:	c1 e2 03             	shl    $0x3,%edx
    791b:	01 c2                	add    %eax,%edx
    791d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7924:	89 c2                	mov    %eax,%edx
    7926:	89 c8                	mov    %ecx,%eax
    7928:	c1 e0 02             	shl    $0x2,%eax
    792b:	01 c8                	add    %ecx,%eax
    792d:	c1 e0 05             	shl    $0x5,%eax
    7930:	01 d0                	add    %edx,%eax
    7932:	01 d8                	add    %ebx,%eax
    7934:	83 c0 28             	add    $0x28,%eax
    7937:	8b 00                	mov    (%eax),%eax
    7939:	85 c0                	test   %eax,%eax
    793b:	0f 84 82 02 00 00    	je     7bc3 <III_get_side_info+0x4bc>
				si->ch[ch].gr[gr].block_type = getbits(bs, 2);
    7941:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7948:	00 
    7949:	8b 45 08             	mov    0x8(%ebp),%eax
    794c:	89 04 24             	mov    %eax,(%esp)
    794f:	e8 18 dd ff ff       	call   566c <getbits>
    7954:	89 c3                	mov    %eax,%ebx
    7956:	8b 75 0c             	mov    0xc(%ebp),%esi
    7959:	8b 45 f0             	mov    -0x10(%ebp),%eax
    795c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    795f:	89 c2                	mov    %eax,%edx
    7961:	c1 e2 03             	shl    $0x3,%edx
    7964:	01 c2                	add    %eax,%edx
    7966:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    796d:	89 c2                	mov    %eax,%edx
    796f:	89 c8                	mov    %ecx,%eax
    7971:	c1 e0 02             	shl    $0x2,%eax
    7974:	01 c8                	add    %ecx,%eax
    7976:	c1 e0 05             	shl    $0x5,%eax
    7979:	01 d0                	add    %edx,%eax
    797b:	01 f0                	add    %esi,%eax
    797d:	83 c0 2c             	add    $0x2c,%eax
    7980:	89 18                	mov    %ebx,(%eax)
				si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
    7982:	8b 45 08             	mov    0x8(%ebp),%eax
    7985:	89 04 24             	mov    %eax,(%esp)
    7988:	e8 cd db ff ff       	call   555a <get1bit>
    798d:	89 c3                	mov    %eax,%ebx
    798f:	8b 75 0c             	mov    0xc(%ebp),%esi
    7992:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7995:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7998:	89 c2                	mov    %eax,%edx
    799a:	c1 e2 03             	shl    $0x3,%edx
    799d:	01 c2                	add    %eax,%edx
    799f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    79a6:	89 c2                	mov    %eax,%edx
    79a8:	89 c8                	mov    %ecx,%eax
    79aa:	c1 e0 02             	shl    $0x2,%eax
    79ad:	01 c8                	add    %ecx,%eax
    79af:	c1 e0 05             	shl    $0x5,%eax
    79b2:	01 d0                	add    %edx,%eax
    79b4:	01 f0                	add    %esi,%eax
    79b6:	83 c0 30             	add    $0x30,%eax
    79b9:	89 18                	mov    %ebx,(%eax)
				for (i=0; i<2; i++)
    79bb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    79c2:	eb 46                	jmp    7a0a <III_get_side_info+0x303>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
    79c4:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    79cb:	00 
    79cc:	8b 45 08             	mov    0x8(%ebp),%eax
    79cf:	89 04 24             	mov    %eax,(%esp)
    79d2:	e8 95 dc ff ff       	call   566c <getbits>
    79d7:	89 c3                	mov    %eax,%ebx
    79d9:	8b 75 0c             	mov    0xc(%ebp),%esi
    79dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    79df:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    79e2:	89 c2                	mov    %eax,%edx
    79e4:	c1 e2 03             	shl    $0x3,%edx
    79e7:	01 c2                	add    %eax,%edx
    79e9:	8d 04 12             	lea    (%edx,%edx,1),%eax
    79ec:	89 c2                	mov    %eax,%edx
    79ee:	89 c8                	mov    %ecx,%eax
    79f0:	c1 e0 02             	shl    $0x2,%eax
    79f3:	01 c8                	add    %ecx,%eax
    79f5:	c1 e0 03             	shl    $0x3,%eax
    79f8:	01 c2                	add    %eax,%edx
    79fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
    79fd:	01 d0                	add    %edx,%eax
    79ff:	83 c0 08             	add    $0x8,%eax
    7a02:	89 5c 86 14          	mov    %ebx,0x14(%esi,%eax,4)
			si->ch[ch].gr[gr].scalefac_compress = getbits(bs, 4);
			si->ch[ch].gr[gr].window_switching_flag = get1bit(bs);
			if (si->ch[ch].gr[gr].window_switching_flag) {
				si->ch[ch].gr[gr].block_type = getbits(bs, 2);
				si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
				for (i=0; i<2; i++)
    7a06:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7a0a:	83 7d ec 01          	cmpl   $0x1,-0x14(%ebp)
    7a0e:	7e b4                	jle    79c4 <III_get_side_info+0x2bd>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
				for (i=0; i<3; i++)
    7a10:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7a17:	eb 46                	jmp    7a5f <III_get_side_info+0x358>
					si->ch[ch].gr[gr].subblock_gain[i] = getbits(bs, 3);
    7a19:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    7a20:	00 
    7a21:	8b 45 08             	mov    0x8(%ebp),%eax
    7a24:	89 04 24             	mov    %eax,(%esp)
    7a27:	e8 40 dc ff ff       	call   566c <getbits>
    7a2c:	89 c3                	mov    %eax,%ebx
    7a2e:	8b 75 0c             	mov    0xc(%ebp),%esi
    7a31:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7a34:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7a37:	89 c2                	mov    %eax,%edx
    7a39:	c1 e2 03             	shl    $0x3,%edx
    7a3c:	01 c2                	add    %eax,%edx
    7a3e:	8d 04 12             	lea    (%edx,%edx,1),%eax
    7a41:	89 c2                	mov    %eax,%edx
    7a43:	89 c8                	mov    %ecx,%eax
    7a45:	c1 e0 02             	shl    $0x2,%eax
    7a48:	01 c8                	add    %ecx,%eax
    7a4a:	c1 e0 03             	shl    $0x3,%eax
    7a4d:	01 c2                	add    %eax,%edx
    7a4f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7a52:	01 d0                	add    %edx,%eax
    7a54:	83 c0 0c             	add    $0xc,%eax
    7a57:	89 5c 86 10          	mov    %ebx,0x10(%esi,%eax,4)
			if (si->ch[ch].gr[gr].window_switching_flag) {
				si->ch[ch].gr[gr].block_type = getbits(bs, 2);
				si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
				for (i=0; i<2; i++)
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
				for (i=0; i<3; i++)
    7a5b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7a5f:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    7a63:	7e b4                	jle    7a19 <III_get_side_info+0x312>
					si->ch[ch].gr[gr].subblock_gain[i] = getbits(bs, 3);

				/* Set region_count parameters since they are implicit in this case. */

				if (si->ch[ch].gr[gr].block_type == 0) {
    7a65:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7a68:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7a6b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7a6e:	89 c2                	mov    %eax,%edx
    7a70:	c1 e2 03             	shl    $0x3,%edx
    7a73:	01 c2                	add    %eax,%edx
    7a75:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7a7c:	89 c2                	mov    %eax,%edx
    7a7e:	89 c8                	mov    %ecx,%eax
    7a80:	c1 e0 02             	shl    $0x2,%eax
    7a83:	01 c8                	add    %ecx,%eax
    7a85:	c1 e0 05             	shl    $0x5,%eax
    7a88:	01 d0                	add    %edx,%eax
    7a8a:	01 d8                	add    %ebx,%eax
    7a8c:	83 c0 2c             	add    $0x2c,%eax
    7a8f:	8b 00                	mov    (%eax),%eax
    7a91:	85 c0                	test   %eax,%eax
    7a93:	75 05                	jne    7a9a <III_get_side_info+0x393>
					//printf("Side info bad: block_type == 0 in split block.\n");
					exit();
    7a95:	e8 84 cb ff ff       	call   461e <exit>
				}
				else if (si->ch[ch].gr[gr].block_type == 2
    7a9a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7a9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7aa0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7aa3:	89 c2                	mov    %eax,%edx
    7aa5:	c1 e2 03             	shl    $0x3,%edx
    7aa8:	01 c2                	add    %eax,%edx
    7aaa:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7ab1:	89 c2                	mov    %eax,%edx
    7ab3:	89 c8                	mov    %ecx,%eax
    7ab5:	c1 e0 02             	shl    $0x2,%eax
    7ab8:	01 c8                	add    %ecx,%eax
    7aba:	c1 e0 05             	shl    $0x5,%eax
    7abd:	01 d0                	add    %edx,%eax
    7abf:	01 d8                	add    %ebx,%eax
    7ac1:	83 c0 2c             	add    $0x2c,%eax
    7ac4:	8b 00                	mov    (%eax),%eax
    7ac6:	83 f8 02             	cmp    $0x2,%eax
    7ac9:	75 62                	jne    7b2d <III_get_side_info+0x426>
						&& si->ch[ch].gr[gr].mixed_block_flag == 0)
    7acb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7ace:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7ad1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7ad4:	89 c2                	mov    %eax,%edx
    7ad6:	c1 e2 03             	shl    $0x3,%edx
    7ad9:	01 c2                	add    %eax,%edx
    7adb:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7ae2:	89 c2                	mov    %eax,%edx
    7ae4:	89 c8                	mov    %ecx,%eax
    7ae6:	c1 e0 02             	shl    $0x2,%eax
    7ae9:	01 c8                	add    %ecx,%eax
    7aeb:	c1 e0 05             	shl    $0x5,%eax
    7aee:	01 d0                	add    %edx,%eax
    7af0:	01 d8                	add    %ebx,%eax
    7af2:	83 c0 30             	add    $0x30,%eax
    7af5:	8b 00                	mov    (%eax),%eax
    7af7:	85 c0                	test   %eax,%eax
    7af9:	75 32                	jne    7b2d <III_get_side_info+0x426>
					si->ch[ch].gr[gr].region0_count = 8; /* MI 9; */
    7afb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7afe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7b01:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7b04:	89 c2                	mov    %eax,%edx
    7b06:	c1 e2 03             	shl    $0x3,%edx
    7b09:	01 c2                	add    %eax,%edx
    7b0b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7b12:	89 c2                	mov    %eax,%edx
    7b14:	89 c8                	mov    %ecx,%eax
    7b16:	c1 e0 02             	shl    $0x2,%eax
    7b19:	01 c8                	add    %ecx,%eax
    7b1b:	c1 e0 05             	shl    $0x5,%eax
    7b1e:	01 d0                	add    %edx,%eax
    7b20:	01 d8                	add    %ebx,%eax
    7b22:	83 c0 4c             	add    $0x4c,%eax
    7b25:	c7 00 08 00 00 00    	movl   $0x8,(%eax)
    7b2b:	eb 30                	jmp    7b5d <III_get_side_info+0x456>
				else si->ch[ch].gr[gr].region0_count = 7; /* MI 8; */
    7b2d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7b30:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7b33:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7b36:	89 c2                	mov    %eax,%edx
    7b38:	c1 e2 03             	shl    $0x3,%edx
    7b3b:	01 c2                	add    %eax,%edx
    7b3d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7b44:	89 c2                	mov    %eax,%edx
    7b46:	89 c8                	mov    %ecx,%eax
    7b48:	c1 e0 02             	shl    $0x2,%eax
    7b4b:	01 c8                	add    %ecx,%eax
    7b4d:	c1 e0 05             	shl    $0x5,%eax
    7b50:	01 d0                	add    %edx,%eax
    7b52:	01 d8                	add    %ebx,%eax
    7b54:	83 c0 4c             	add    $0x4c,%eax
    7b57:	c7 00 07 00 00 00    	movl   $0x7,(%eax)
					si->ch[ch].gr[gr].region1_count = 20 - si->ch[ch].gr[gr].region0_count;
    7b5d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7b60:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7b63:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7b66:	89 c2                	mov    %eax,%edx
    7b68:	c1 e2 03             	shl    $0x3,%edx
    7b6b:	01 c2                	add    %eax,%edx
    7b6d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7b74:	89 c2                	mov    %eax,%edx
    7b76:	89 c8                	mov    %ecx,%eax
    7b78:	c1 e0 02             	shl    $0x2,%eax
    7b7b:	01 c8                	add    %ecx,%eax
    7b7d:	c1 e0 05             	shl    $0x5,%eax
    7b80:	01 d0                	add    %edx,%eax
    7b82:	01 d8                	add    %ebx,%eax
    7b84:	83 c0 4c             	add    $0x4c,%eax
    7b87:	8b 00                	mov    (%eax),%eax
    7b89:	ba 14 00 00 00       	mov    $0x14,%edx
    7b8e:	89 d3                	mov    %edx,%ebx
    7b90:	29 c3                	sub    %eax,%ebx
    7b92:	8b 75 0c             	mov    0xc(%ebp),%esi
    7b95:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7b98:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7b9b:	89 c2                	mov    %eax,%edx
    7b9d:	c1 e2 03             	shl    $0x3,%edx
    7ba0:	01 c2                	add    %eax,%edx
    7ba2:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7ba9:	89 c2                	mov    %eax,%edx
    7bab:	89 c8                	mov    %ecx,%eax
    7bad:	c1 e0 02             	shl    $0x2,%eax
    7bb0:	01 c8                	add    %ecx,%eax
    7bb2:	c1 e0 05             	shl    $0x5,%eax
    7bb5:	01 d0                	add    %edx,%eax
    7bb7:	01 f0                	add    %esi,%eax
    7bb9:	83 c0 50             	add    $0x50,%eax
    7bbc:	89 18                	mov    %ebx,(%eax)
    7bbe:	e9 07 01 00 00       	jmp    7cca <III_get_side_info+0x5c3>
			}
			else {
				for (i=0; i<3; i++)
    7bc3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7bca:	eb 46                	jmp    7c12 <III_get_side_info+0x50b>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
    7bcc:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    7bd3:	00 
    7bd4:	8b 45 08             	mov    0x8(%ebp),%eax
    7bd7:	89 04 24             	mov    %eax,(%esp)
    7bda:	e8 8d da ff ff       	call   566c <getbits>
    7bdf:	89 c3                	mov    %eax,%ebx
    7be1:	8b 75 0c             	mov    0xc(%ebp),%esi
    7be4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7be7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7bea:	89 c2                	mov    %eax,%edx
    7bec:	c1 e2 03             	shl    $0x3,%edx
    7bef:	01 c2                	add    %eax,%edx
    7bf1:	8d 04 12             	lea    (%edx,%edx,1),%eax
    7bf4:	89 c2                	mov    %eax,%edx
    7bf6:	89 c8                	mov    %ecx,%eax
    7bf8:	c1 e0 02             	shl    $0x2,%eax
    7bfb:	01 c8                	add    %ecx,%eax
    7bfd:	c1 e0 03             	shl    $0x3,%eax
    7c00:	01 c2                	add    %eax,%edx
    7c02:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7c05:	01 d0                	add    %edx,%eax
    7c07:	83 c0 08             	add    $0x8,%eax
    7c0a:	89 5c 86 14          	mov    %ebx,0x14(%esi,%eax,4)
					si->ch[ch].gr[gr].region0_count = 8; /* MI 9; */
				else si->ch[ch].gr[gr].region0_count = 7; /* MI 8; */
					si->ch[ch].gr[gr].region1_count = 20 - si->ch[ch].gr[gr].region0_count;
			}
			else {
				for (i=0; i<3; i++)
    7c0e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7c12:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    7c16:	7e b4                	jle    7bcc <III_get_side_info+0x4c5>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
				si->ch[ch].gr[gr].region0_count = getbits(bs, 4);
    7c18:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
    7c1f:	00 
    7c20:	8b 45 08             	mov    0x8(%ebp),%eax
    7c23:	89 04 24             	mov    %eax,(%esp)
    7c26:	e8 41 da ff ff       	call   566c <getbits>
    7c2b:	89 c3                	mov    %eax,%ebx
    7c2d:	8b 75 0c             	mov    0xc(%ebp),%esi
    7c30:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7c33:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7c36:	89 c2                	mov    %eax,%edx
    7c38:	c1 e2 03             	shl    $0x3,%edx
    7c3b:	01 c2                	add    %eax,%edx
    7c3d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7c44:	89 c2                	mov    %eax,%edx
    7c46:	89 c8                	mov    %ecx,%eax
    7c48:	c1 e0 02             	shl    $0x2,%eax
    7c4b:	01 c8                	add    %ecx,%eax
    7c4d:	c1 e0 05             	shl    $0x5,%eax
    7c50:	01 d0                	add    %edx,%eax
    7c52:	01 f0                	add    %esi,%eax
    7c54:	83 c0 4c             	add    $0x4c,%eax
    7c57:	89 18                	mov    %ebx,(%eax)
				si->ch[ch].gr[gr].region1_count = getbits(bs, 3);
    7c59:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    7c60:	00 
    7c61:	8b 45 08             	mov    0x8(%ebp),%eax
    7c64:	89 04 24             	mov    %eax,(%esp)
    7c67:	e8 00 da ff ff       	call   566c <getbits>
    7c6c:	89 c3                	mov    %eax,%ebx
    7c6e:	8b 75 0c             	mov    0xc(%ebp),%esi
    7c71:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7c74:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7c77:	89 c2                	mov    %eax,%edx
    7c79:	c1 e2 03             	shl    $0x3,%edx
    7c7c:	01 c2                	add    %eax,%edx
    7c7e:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7c85:	89 c2                	mov    %eax,%edx
    7c87:	89 c8                	mov    %ecx,%eax
    7c89:	c1 e0 02             	shl    $0x2,%eax
    7c8c:	01 c8                	add    %ecx,%eax
    7c8e:	c1 e0 05             	shl    $0x5,%eax
    7c91:	01 d0                	add    %edx,%eax
    7c93:	01 f0                	add    %esi,%eax
    7c95:	83 c0 50             	add    $0x50,%eax
    7c98:	89 18                	mov    %ebx,(%eax)
				si->ch[ch].gr[gr].block_type = 0;
    7c9a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7c9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7ca0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7ca3:	89 c2                	mov    %eax,%edx
    7ca5:	c1 e2 03             	shl    $0x3,%edx
    7ca8:	01 c2                	add    %eax,%edx
    7caa:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7cb1:	89 c2                	mov    %eax,%edx
    7cb3:	89 c8                	mov    %ecx,%eax
    7cb5:	c1 e0 02             	shl    $0x2,%eax
    7cb8:	01 c8                	add    %ecx,%eax
    7cba:	c1 e0 05             	shl    $0x5,%eax
    7cbd:	01 d0                	add    %edx,%eax
    7cbf:	01 d8                	add    %ebx,%eax
    7cc1:	83 c0 2c             	add    $0x2c,%eax
    7cc4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
			}
			si->ch[ch].gr[gr].preflag = get1bit(bs);
    7cca:	8b 45 08             	mov    0x8(%ebp),%eax
    7ccd:	89 04 24             	mov    %eax,(%esp)
    7cd0:	e8 85 d8 ff ff       	call   555a <get1bit>
    7cd5:	89 c3                	mov    %eax,%ebx
    7cd7:	8b 75 0c             	mov    0xc(%ebp),%esi
    7cda:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7cdd:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7ce0:	89 c2                	mov    %eax,%edx
    7ce2:	c1 e2 03             	shl    $0x3,%edx
    7ce5:	01 c2                	add    %eax,%edx
    7ce7:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7cee:	89 c2                	mov    %eax,%edx
    7cf0:	89 c8                	mov    %ecx,%eax
    7cf2:	c1 e0 02             	shl    $0x2,%eax
    7cf5:	01 c8                	add    %ecx,%eax
    7cf7:	c1 e0 05             	shl    $0x5,%eax
    7cfa:	01 d0                	add    %edx,%eax
    7cfc:	01 f0                	add    %esi,%eax
    7cfe:	83 c0 54             	add    $0x54,%eax
    7d01:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].scalefac_scale = get1bit(bs);
    7d03:	8b 45 08             	mov    0x8(%ebp),%eax
    7d06:	89 04 24             	mov    %eax,(%esp)
    7d09:	e8 4c d8 ff ff       	call   555a <get1bit>
    7d0e:	89 c3                	mov    %eax,%ebx
    7d10:	8b 75 0c             	mov    0xc(%ebp),%esi
    7d13:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7d16:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7d19:	89 c2                	mov    %eax,%edx
    7d1b:	c1 e2 03             	shl    $0x3,%edx
    7d1e:	01 c2                	add    %eax,%edx
    7d20:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7d27:	89 c2                	mov    %eax,%edx
    7d29:	89 c8                	mov    %ecx,%eax
    7d2b:	c1 e0 02             	shl    $0x2,%eax
    7d2e:	01 c8                	add    %ecx,%eax
    7d30:	c1 e0 05             	shl    $0x5,%eax
    7d33:	01 d0                	add    %edx,%eax
    7d35:	01 f0                	add    %esi,%eax
    7d37:	83 c0 58             	add    $0x58,%eax
    7d3a:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].count1table_select = get1bit(bs);
    7d3c:	8b 45 08             	mov    0x8(%ebp),%eax
    7d3f:	89 04 24             	mov    %eax,(%esp)
    7d42:	e8 13 d8 ff ff       	call   555a <get1bit>
    7d47:	89 c3                	mov    %eax,%ebx
    7d49:	8b 75 0c             	mov    0xc(%ebp),%esi
    7d4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7d4f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7d52:	89 c2                	mov    %eax,%edx
    7d54:	c1 e2 03             	shl    $0x3,%edx
    7d57:	01 c2                	add    %eax,%edx
    7d59:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7d60:	89 c2                	mov    %eax,%edx
    7d62:	89 c8                	mov    %ecx,%eax
    7d64:	c1 e0 02             	shl    $0x2,%eax
    7d67:	01 c8                	add    %ecx,%eax
    7d69:	c1 e0 05             	shl    $0x5,%eax
    7d6c:	01 d0                	add    %edx,%eax
    7d6e:	01 f0                	add    %esi,%eax
    7d70:	83 c0 5c             	add    $0x5c,%eax
    7d73:	89 18                	mov    %ebx,(%eax)
	for (ch=0; ch<stereo; ch++)
		for (i=0; i<4; i++)
			si->ch[ch].scfsi[i] = get1bit(bs);

	for (gr=0; gr<2; gr++) {
		for (ch=0; ch<stereo; ch++) {
    7d75:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7d79:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7d7c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    7d7f:	0f 8c 4b fa ff ff    	jl     77d0 <III_get_side_info+0xc9>

	for (ch=0; ch<stereo; ch++)
		for (i=0; i<4; i++)
			si->ch[ch].scfsi[i] = get1bit(bs);

	for (gr=0; gr<2; gr++) {
    7d85:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    7d89:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    7d8d:	0f 8e 31 fa ff ff    	jle    77c4 <III_get_side_info+0xbd>
			si->ch[ch].gr[gr].preflag = get1bit(bs);
			si->ch[ch].gr[gr].scalefac_scale = get1bit(bs);
			si->ch[ch].gr[gr].count1table_select = get1bit(bs);
         }
	}
}
    7d93:	83 c4 20             	add    $0x20,%esp
    7d96:	5b                   	pop    %ebx
    7d97:	5e                   	pop    %esi
    7d98:	5d                   	pop    %ebp
    7d99:	c3                   	ret    

00007d9a <III_get_scale_factors>:
	{{0,4,8,12,16,20,24,30,36,44,54,66,82,102,126,156,194,240,296,364,448,550,576},
		{0,4,8,12,16,22,30,42,58,78,104,138,180,192}}
};

void III_get_scale_factors(III_scalefac_t *scalefac, struct III_side_info_t *si, int gr, int ch, struct frame_params *fr_ps)
{
    7d9a:	55                   	push   %ebp
    7d9b:	89 e5                	mov    %esp,%ebp
    7d9d:	56                   	push   %esi
    7d9e:	53                   	push   %ebx
    7d9f:	83 ec 20             	sub    $0x20,%esp
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);
    7da2:	8b 45 10             	mov    0x10(%ebp),%eax
    7da5:	89 c2                	mov    %eax,%edx
    7da7:	c1 e2 03             	shl    $0x3,%edx
    7daa:	01 c2                	add    %eax,%edx
    7dac:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7db3:	89 c2                	mov    %eax,%edx
    7db5:	8b 4d 14             	mov    0x14(%ebp),%ecx
    7db8:	89 c8                	mov    %ecx,%eax
    7dba:	c1 e0 02             	shl    $0x2,%eax
    7dbd:	01 c8                	add    %ecx,%eax
    7dbf:	c1 e0 05             	shl    $0x5,%eax
    7dc2:	01 d0                	add    %edx,%eax
    7dc4:	8d 50 10             	lea    0x10(%eax),%edx
    7dc7:	8b 45 0c             	mov    0xc(%ebp),%eax
    7dca:	01 d0                	add    %edx,%eax
    7dcc:	83 c0 08             	add    $0x8,%eax
    7dcf:	89 45 e8             	mov    %eax,-0x18(%ebp)

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    7dd2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7dd5:	8b 40 10             	mov    0x10(%eax),%eax
    7dd8:	85 c0                	test   %eax,%eax
    7dda:	0f 84 7e 02 00 00    	je     805e <III_get_scale_factors+0x2c4>
    7de0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7de3:	8b 40 14             	mov    0x14(%eax),%eax
    7de6:	83 f8 02             	cmp    $0x2,%eax
    7de9:	0f 85 6f 02 00 00    	jne    805e <III_get_scale_factors+0x2c4>
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    7def:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7df2:	8b 40 18             	mov    0x18(%eax),%eax
    7df5:	85 c0                	test   %eax,%eax
    7df7:	0f 84 6b 01 00 00    	je     7f68 <III_get_scale_factors+0x1ce>
			for (sfb = 0; sfb < 8; sfb++)
    7dfd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    7e04:	eb 32                	jmp    7e38 <III_get_scale_factors+0x9e>
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
    7e06:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7e09:	8b 40 0c             	mov    0xc(%eax),%eax
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
    7e0c:	8b 04 85 a0 ec 00 00 	mov    0xeca0(,%eax,4),%eax
    7e13:	89 04 24             	mov    %eax,(%esp)
    7e16:	e8 b9 db ff ff       	call   59d4 <hgetbits>
    7e1b:	89 c3                	mov    %eax,%ebx
    7e1d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    7e20:	8b 45 14             	mov    0x14(%ebp),%eax
    7e23:	01 c0                	add    %eax,%eax
    7e25:	89 c2                	mov    %eax,%edx
    7e27:	c1 e2 05             	shl    $0x5,%edx
    7e2a:	29 c2                	sub    %eax,%edx
    7e2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7e2f:	01 d0                	add    %edx,%eax
    7e31:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
    7e34:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7e38:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    7e3c:	7e c8                	jle    7e06 <III_get_scale_factors+0x6c>
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
    7e3e:	c7 45 f4 03 00 00 00 	movl   $0x3,-0xc(%ebp)
    7e45:	eb 5c                	jmp    7ea3 <III_get_scale_factors+0x109>
				for (window=0; window<3; window++)
    7e47:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7e4e:	eb 49                	jmp    7e99 <III_get_scale_factors+0xff>
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
    7e50:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7e53:	8b 40 0c             	mov    0xc(%eax),%eax
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
    7e56:	8b 04 85 a0 ec 00 00 	mov    0xeca0(,%eax,4),%eax
    7e5d:	89 04 24             	mov    %eax,(%esp)
    7e60:	e8 6f db ff ff       	call   59d4 <hgetbits>
    7e65:	89 c6                	mov    %eax,%esi
    7e67:	8b 5d 08             	mov    0x8(%ebp),%ebx
    7e6a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    7e6d:	8b 4d 14             	mov    0x14(%ebp),%ecx
    7e70:	89 d0                	mov    %edx,%eax
    7e72:	01 c0                	add    %eax,%eax
    7e74:	01 d0                	add    %edx,%eax
    7e76:	c1 e0 02             	shl    $0x2,%eax
    7e79:	01 d0                	add    %edx,%eax
    7e7b:	89 ca                	mov    %ecx,%edx
    7e7d:	01 d2                	add    %edx,%edx
    7e7f:	89 d1                	mov    %edx,%ecx
    7e81:	c1 e1 05             	shl    $0x5,%ecx
    7e84:	29 d1                	sub    %edx,%ecx
    7e86:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    7e89:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7e8c:	01 d0                	add    %edx,%eax
    7e8e:	83 c0 14             	add    $0x14,%eax
    7e91:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
    7e95:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7e99:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    7e9d:	7e b1                	jle    7e50 <III_get_scale_factors+0xb6>
	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
    7e9f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7ea3:	83 7d f4 05          	cmpl   $0x5,-0xc(%ebp)
    7ea7:	7e 9e                	jle    7e47 <III_get_scale_factors+0xad>
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
    7ea9:	c7 45 f4 06 00 00 00 	movl   $0x6,-0xc(%ebp)
    7eb0:	eb 5f                	jmp    7f11 <III_get_scale_factors+0x177>
				for (window=0; window<3; window++)
    7eb2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7eb9:	eb 4c                	jmp    7f07 <III_get_scale_factors+0x16d>
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[1][gr_info->scalefac_compress]);
    7ebb:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7ebe:	8b 40 0c             	mov    0xc(%eax),%eax
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
    7ec1:	83 c0 10             	add    $0x10,%eax
    7ec4:	8b 04 85 a0 ec 00 00 	mov    0xeca0(,%eax,4),%eax
    7ecb:	89 04 24             	mov    %eax,(%esp)
    7ece:	e8 01 db ff ff       	call   59d4 <hgetbits>
    7ed3:	89 c6                	mov    %eax,%esi
    7ed5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    7ed8:	8b 55 ec             	mov    -0x14(%ebp),%edx
    7edb:	8b 4d 14             	mov    0x14(%ebp),%ecx
    7ede:	89 d0                	mov    %edx,%eax
    7ee0:	01 c0                	add    %eax,%eax
    7ee2:	01 d0                	add    %edx,%eax
    7ee4:	c1 e0 02             	shl    $0x2,%eax
    7ee7:	01 d0                	add    %edx,%eax
    7ee9:	89 ca                	mov    %ecx,%edx
    7eeb:	01 d2                	add    %edx,%edx
    7eed:	89 d1                	mov    %edx,%ecx
    7eef:	c1 e1 05             	shl    $0x5,%ecx
    7ef2:	29 d1                	sub    %edx,%ecx
    7ef4:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    7ef7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7efa:	01 d0                	add    %edx,%eax
    7efc:	83 c0 14             	add    $0x14,%eax
    7eff:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
				for (window=0; window<3; window++)
    7f03:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7f07:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    7f0b:	7e ae                	jle    7ebb <III_get_scale_factors+0x121>
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
    7f0d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7f11:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    7f15:	7e 9b                	jle    7eb2 <III_get_scale_factors+0x118>
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
    7f17:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    7f1e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7f25:	eb 36                	jmp    7f5d <III_get_scale_factors+0x1c3>
				(*scalefac)[ch].s[window][sfb] = 0;
    7f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
    7f2a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    7f2d:	8b 4d 14             	mov    0x14(%ebp),%ecx
    7f30:	89 d0                	mov    %edx,%eax
    7f32:	01 c0                	add    %eax,%eax
    7f34:	01 d0                	add    %edx,%eax
    7f36:	c1 e0 02             	shl    $0x2,%eax
    7f39:	01 d0                	add    %edx,%eax
    7f3b:	89 ca                	mov    %ecx,%edx
    7f3d:	01 d2                	add    %edx,%edx
    7f3f:	89 d1                	mov    %edx,%ecx
    7f41:	c1 e1 05             	shl    $0x5,%ecx
    7f44:	29 d1                	sub    %edx,%ecx
    7f46:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    7f49:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7f4c:	01 d0                	add    %edx,%eax
    7f4e:	83 c0 14             	add    $0x14,%eax
    7f51:	c7 44 83 0c 00 00 00 	movl   $0x0,0xc(%ebx,%eax,4)
    7f58:	00 
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
    7f59:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7f5d:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    7f61:	7e c4                	jle    7f27 <III_get_scale_factors+0x18d>
{
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    7f63:	e9 b1 01 00 00       	jmp    8119 <III_get_scale_factors+0x37f>
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
    7f68:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    7f6f:	e9 8f 00 00 00       	jmp    8003 <III_get_scale_factors+0x269>
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
    7f74:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7f77:	83 c0 04             	add    $0x4,%eax
    7f7a:	8b 04 85 84 ec 00 00 	mov    0xec84(,%eax,4),%eax
    7f81:	89 45 f4             	mov    %eax,-0xc(%ebp)
    7f84:	eb 64                	jmp    7fea <III_get_scale_factors+0x250>
					for (window=0; window<3; window++)
    7f86:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7f8d:	eb 51                	jmp    7fe0 <III_get_scale_factors+0x246>
						(*scalefac)[ch].s[window][sfb] = hgetbits(
							slen[i][gr_info->scalefac_compress]);
    7f8f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7f92:	8b 40 0c             	mov    0xc(%eax),%eax
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
						(*scalefac)[ch].s[window][sfb] = hgetbits(
    7f95:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7f98:	c1 e2 04             	shl    $0x4,%edx
    7f9b:	01 d0                	add    %edx,%eax
    7f9d:	8b 04 85 a0 ec 00 00 	mov    0xeca0(,%eax,4),%eax
    7fa4:	89 04 24             	mov    %eax,(%esp)
    7fa7:	e8 28 da ff ff       	call   59d4 <hgetbits>
    7fac:	89 c6                	mov    %eax,%esi
    7fae:	8b 5d 08             	mov    0x8(%ebp),%ebx
    7fb1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    7fb4:	8b 4d 14             	mov    0x14(%ebp),%ecx
    7fb7:	89 d0                	mov    %edx,%eax
    7fb9:	01 c0                	add    %eax,%eax
    7fbb:	01 d0                	add    %edx,%eax
    7fbd:	c1 e0 02             	shl    $0x2,%eax
    7fc0:	01 d0                	add    %edx,%eax
    7fc2:	89 ca                	mov    %ecx,%edx
    7fc4:	01 d2                	add    %edx,%edx
    7fc6:	89 d1                	mov    %edx,%ecx
    7fc8:	c1 e1 05             	shl    $0x5,%ecx
    7fcb:	29 d1                	sub    %edx,%ecx
    7fcd:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    7fd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7fd3:	01 d0                	add    %edx,%eax
    7fd5:	83 c0 14             	add    $0x14,%eax
    7fd8:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
    7fdc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7fe0:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    7fe4:	7e a9                	jle    7f8f <III_get_scale_factors+0x1f5>
			for (sfb=12,window=0; window<3; window++)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
    7fe6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7fea:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7fed:	83 c0 01             	add    $0x1,%eax
    7ff0:	83 c0 04             	add    $0x4,%eax
    7ff3:	8b 04 85 84 ec 00 00 	mov    0xec84(,%eax,4),%eax
    7ffa:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    7ffd:	7f 87                	jg     7f86 <III_get_scale_factors+0x1ec>
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
    7fff:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    8003:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    8007:	0f 8e 67 ff ff ff    	jle    7f74 <III_get_scale_factors+0x1da>
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
						(*scalefac)[ch].s[window][sfb] = hgetbits(
							slen[i][gr_info->scalefac_compress]);
				for (sfb=12,window=0; window<3; window++)
    800d:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    8014:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    801b:	eb 36                	jmp    8053 <III_get_scale_factors+0x2b9>
					(*scalefac)[ch].s[window][sfb] = 0;
    801d:	8b 5d 08             	mov    0x8(%ebp),%ebx
    8020:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8023:	8b 4d 14             	mov    0x14(%ebp),%ecx
    8026:	89 d0                	mov    %edx,%eax
    8028:	01 c0                	add    %eax,%eax
    802a:	01 d0                	add    %edx,%eax
    802c:	c1 e0 02             	shl    $0x2,%eax
    802f:	01 d0                	add    %edx,%eax
    8031:	89 ca                	mov    %ecx,%edx
    8033:	01 d2                	add    %edx,%edx
    8035:	89 d1                	mov    %edx,%ecx
    8037:	c1 e1 05             	shl    $0x5,%ecx
    803a:	29 d1                	sub    %edx,%ecx
    803c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    803f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8042:	01 d0                	add    %edx,%eax
    8044:	83 c0 14             	add    $0x14,%eax
    8047:	c7 44 83 0c 00 00 00 	movl   $0x0,0xc(%ebx,%eax,4)
    804e:	00 
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
						(*scalefac)[ch].s[window][sfb] = hgetbits(
							slen[i][gr_info->scalefac_compress]);
				for (sfb=12,window=0; window<3; window++)
    804f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8053:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    8057:	7e c4                	jle    801d <III_get_scale_factors+0x283>
{
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    8059:	e9 bb 00 00 00       	jmp    8119 <III_get_scale_factors+0x37f>
				for (sfb=12,window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = 0;
		}
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
    805e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    8065:	e9 89 00 00 00       	jmp    80f3 <III_get_scale_factors+0x359>
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
    806a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    806d:	8b 55 14             	mov    0x14(%ebp),%edx
    8070:	89 d0                	mov    %edx,%eax
    8072:	c1 e0 02             	shl    $0x2,%eax
    8075:	01 d0                	add    %edx,%eax
    8077:	c1 e0 03             	shl    $0x3,%eax
    807a:	8b 55 f0             	mov    -0x10(%ebp),%edx
    807d:	01 d0                	add    %edx,%eax
    807f:	8b 44 81 08          	mov    0x8(%ecx,%eax,4),%eax
    8083:	85 c0                	test   %eax,%eax
    8085:	74 06                	je     808d <III_get_scale_factors+0x2f3>
    8087:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    808b:	75 62                	jne    80ef <III_get_scale_factors+0x355>
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
    808d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8090:	8b 04 85 80 ec 00 00 	mov    0xec80(,%eax,4),%eax
    8097:	89 45 f4             	mov    %eax,-0xc(%ebp)
    809a:	eb 41                	jmp    80dd <III_get_scale_factors+0x343>
					(*scalefac)[ch].l[sfb] = hgetbits(
						slen[(i<2)?0:1][gr_info->scalefac_compress]);
    809c:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    80a0:	0f 9f c0             	setg   %al
    80a3:	0f b6 d0             	movzbl %al,%edx
    80a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    80a9:	8b 40 0c             	mov    0xc(%eax),%eax
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
					(*scalefac)[ch].l[sfb] = hgetbits(
    80ac:	c1 e2 04             	shl    $0x4,%edx
    80af:	01 d0                	add    %edx,%eax
    80b1:	8b 04 85 a0 ec 00 00 	mov    0xeca0(,%eax,4),%eax
    80b8:	89 04 24             	mov    %eax,(%esp)
    80bb:	e8 14 d9 ff ff       	call   59d4 <hgetbits>
    80c0:	89 c3                	mov    %eax,%ebx
    80c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
    80c5:	8b 45 14             	mov    0x14(%ebp),%eax
    80c8:	01 c0                	add    %eax,%eax
    80ca:	89 c2                	mov    %eax,%edx
    80cc:	c1 e2 05             	shl    $0x5,%edx
    80cf:	29 c2                	sub    %eax,%edx
    80d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    80d4:	01 d0                	add    %edx,%eax
    80d6:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
		}
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
    80d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    80dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    80e0:	83 c0 01             	add    $0x1,%eax
    80e3:	8b 04 85 80 ec 00 00 	mov    0xec80(,%eax,4),%eax
    80ea:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    80ed:	7f ad                	jg     809c <III_get_scale_factors+0x302>
				for (sfb=12,window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = 0;
		}
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
    80ef:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    80f3:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    80f7:	0f 8e 6d ff ff ff    	jle    806a <III_get_scale_factors+0x2d0>
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
					(*scalefac)[ch].l[sfb] = hgetbits(
						slen[(i<2)?0:1][gr_info->scalefac_compress]);
		}
		(*scalefac)[ch].l[22] = 0;
    80fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    8100:	8b 45 14             	mov    0x14(%ebp),%eax
    8103:	c1 e0 03             	shl    $0x3,%eax
    8106:	89 c2                	mov    %eax,%edx
    8108:	c1 e2 05             	shl    $0x5,%edx
    810b:	29 c2                	sub    %eax,%edx
    810d:	8d 04 11             	lea    (%ecx,%edx,1),%eax
    8110:	83 c0 58             	add    $0x58,%eax
    8113:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
}
    8119:	83 c4 20             	add    $0x20,%esp
    811c:	5b                   	pop    %ebx
    811d:	5e                   	pop    %esi
    811e:	5d                   	pop    %ebp
    811f:	c3                   	ret    

00008120 <initialize_huffman>:
struct huffcodetab ht[HTN];
*/
int huffman_initialized = FALSE;

void initialize_huffman()
{
    8120:	55                   	push   %ebp
    8121:	89 e5                	mov    %esp,%ebp
    8123:	83 ec 08             	sub    $0x8,%esp
	if (huffman_initialized) return;
    8126:	a1 e0 ef 00 00       	mov    0xefe0,%eax
    812b:	85 c0                	test   %eax,%eax
    812d:	74 02                	je     8131 <initialize_huffman+0x11>
    812f:	eb 0f                	jmp    8140 <initialize_huffman+0x20>
	read_decoder_table();
    8131:	e8 03 d9 ff ff       	call   5a39 <read_decoder_table>
	huffman_initialized = TRUE;
    8136:	c7 05 e0 ef 00 00 01 	movl   $0x1,0xefe0
    813d:	00 00 00 
}
    8140:	c9                   	leave  
    8141:	c3                   	ret    

00008142 <III_hufman_decode>:


void III_hufman_decode(long int is[SBLIMIT][SSLIMIT], struct III_side_info_t *si, int ch, int gr, int part2_start, struct frame_params *fr_ps)
{
    8142:	55                   	push   %ebp
    8143:	89 e5                	mov    %esp,%ebp
    8145:	57                   	push   %edi
    8146:	56                   	push   %esi
    8147:	53                   	push   %ebx
    8148:	83 ec 4c             	sub    $0x4c,%esp
   struct huffcodetab *h;
   int region1Start;
   int region2Start;
   //int bt = (*si).ch[ch].gr[gr].window_switching_flag && ((*si).ch[ch].gr[gr].block_type == 2);

   initialize_huffman();
    814b:	e8 d0 ff ff ff       	call   8120 <initialize_huffman>

   /* ��������߽� */

   if ( ((*si).ch[ch].gr[gr].window_switching_flag) &&
    8150:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8153:	8b 45 14             	mov    0x14(%ebp),%eax
    8156:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8159:	89 c2                	mov    %eax,%edx
    815b:	c1 e2 03             	shl    $0x3,%edx
    815e:	01 c2                	add    %eax,%edx
    8160:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8167:	89 c2                	mov    %eax,%edx
    8169:	89 c8                	mov    %ecx,%eax
    816b:	c1 e0 02             	shl    $0x2,%eax
    816e:	01 c8                	add    %ecx,%eax
    8170:	c1 e0 05             	shl    $0x5,%eax
    8173:	01 d0                	add    %edx,%eax
    8175:	01 d8                	add    %ebx,%eax
    8177:	83 c0 28             	add    $0x28,%eax
    817a:	8b 00                	mov    (%eax),%eax
    817c:	85 c0                	test   %eax,%eax
    817e:	74 44                	je     81c4 <III_hufman_decode+0x82>
        ((*si).ch[ch].gr[gr].block_type == 2) ) {
    8180:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8183:	8b 45 14             	mov    0x14(%ebp),%eax
    8186:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8189:	89 c2                	mov    %eax,%edx
    818b:	c1 e2 03             	shl    $0x3,%edx
    818e:	01 c2                	add    %eax,%edx
    8190:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8197:	89 c2                	mov    %eax,%edx
    8199:	89 c8                	mov    %ecx,%eax
    819b:	c1 e0 02             	shl    $0x2,%eax
    819e:	01 c8                	add    %ecx,%eax
    81a0:	c1 e0 05             	shl    $0x5,%eax
    81a3:	01 d0                	add    %edx,%eax
    81a5:	01 d8                	add    %ebx,%eax
    81a7:	83 c0 2c             	add    $0x2c,%eax
    81aa:	8b 00                	mov    (%eax),%eax

   initialize_huffman();

   /* ��������߽� */

   if ( ((*si).ch[ch].gr[gr].window_switching_flag) &&
    81ac:	83 f8 02             	cmp    $0x2,%eax
    81af:	75 13                	jne    81c4 <III_hufman_decode+0x82>
        ((*si).ch[ch].gr[gr].block_type == 2) ) {

      /* Region2. */

      region1Start = 36;  /* sfb[9/3]*3=36 */
    81b1:	c7 45 dc 24 00 00 00 	movl   $0x24,-0x24(%ebp)
      region2Start = 576; /* No Region2 for short block case. */
    81b8:	c7 45 d8 40 02 00 00 	movl   $0x240,-0x28(%ebp)
    81bf:	e9 cc 00 00 00       	jmp    8290 <III_hufman_decode+0x14e>
   }


   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
    81c4:	8b 45 1c             	mov    0x1c(%ebp),%eax
    81c7:	8b 00                	mov    (%eax),%eax
    81c9:	8b 48 10             	mov    0x10(%eax),%ecx
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
    81cc:	8b 75 0c             	mov    0xc(%ebp),%esi
    81cf:	8b 45 14             	mov    0x14(%ebp),%eax
    81d2:	8b 5d 10             	mov    0x10(%ebp),%ebx
    81d5:	89 c2                	mov    %eax,%edx
    81d7:	c1 e2 03             	shl    $0x3,%edx
    81da:	01 c2                	add    %eax,%edx
    81dc:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    81e3:	89 c2                	mov    %eax,%edx
    81e5:	89 d8                	mov    %ebx,%eax
    81e7:	c1 e0 02             	shl    $0x2,%eax
    81ea:	01 d8                	add    %ebx,%eax
    81ec:	c1 e0 05             	shl    $0x5,%eax
    81ef:	01 d0                	add    %edx,%eax
    81f1:	01 f0                	add    %esi,%eax
    81f3:	83 c0 4c             	add    $0x4c,%eax
    81f6:	8b 00                	mov    (%eax),%eax
    81f8:	8d 50 01             	lea    0x1(%eax),%edx
   }


   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
    81fb:	89 c8                	mov    %ecx,%eax
    81fd:	c1 e0 03             	shl    $0x3,%eax
    8200:	01 c8                	add    %ecx,%eax
    8202:	c1 e0 02             	shl    $0x2,%eax
    8205:	01 c8                	add    %ecx,%eax
    8207:	01 d0                	add    %edx,%eax
    8209:	8b 04 85 20 ed 00 00 	mov    0xed20(,%eax,4),%eax
    8210:	89 45 dc             	mov    %eax,-0x24(%ebp)
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
      region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
    8213:	8b 45 1c             	mov    0x1c(%ebp),%eax
    8216:	8b 00                	mov    (%eax),%eax
    8218:	8b 48 10             	mov    0x10(%eax),%ecx
                              .l[(*si).ch[ch].gr[gr].region0_count +
    821b:	8b 75 0c             	mov    0xc(%ebp),%esi
    821e:	8b 45 14             	mov    0x14(%ebp),%eax
    8221:	8b 5d 10             	mov    0x10(%ebp),%ebx
    8224:	89 c2                	mov    %eax,%edx
    8226:	c1 e2 03             	shl    $0x3,%edx
    8229:	01 c2                	add    %eax,%edx
    822b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8232:	89 c2                	mov    %eax,%edx
    8234:	89 d8                	mov    %ebx,%eax
    8236:	c1 e0 02             	shl    $0x2,%eax
    8239:	01 d8                	add    %ebx,%eax
    823b:	c1 e0 05             	shl    $0x5,%eax
    823e:	01 d0                	add    %edx,%eax
    8240:	01 f0                	add    %esi,%eax
    8242:	83 c0 4c             	add    $0x4c,%eax
    8245:	8b 30                	mov    (%eax),%esi
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
    8247:	8b 7d 0c             	mov    0xc(%ebp),%edi
    824a:	8b 45 14             	mov    0x14(%ebp),%eax
    824d:	8b 5d 10             	mov    0x10(%ebp),%ebx
    8250:	89 c2                	mov    %eax,%edx
    8252:	c1 e2 03             	shl    $0x3,%edx
    8255:	01 c2                	add    %eax,%edx
    8257:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    825e:	89 c2                	mov    %eax,%edx
    8260:	89 d8                	mov    %ebx,%eax
    8262:	c1 e0 02             	shl    $0x2,%eax
    8265:	01 d8                	add    %ebx,%eax
    8267:	c1 e0 05             	shl    $0x5,%eax
    826a:	01 d0                	add    %edx,%eax
    826c:	01 f8                	add    %edi,%eax
    826e:	83 c0 50             	add    $0x50,%eax
    8271:	8b 00                	mov    (%eax),%eax
   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
      region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
                              .l[(*si).ch[ch].gr[gr].region0_count +
    8273:	01 f0                	add    %esi,%eax
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
    8275:	8d 50 02             	lea    0x2(%eax),%edx

   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
      region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
    8278:	89 c8                	mov    %ecx,%eax
    827a:	c1 e0 03             	shl    $0x3,%eax
    827d:	01 c8                	add    %ecx,%eax
    827f:	c1 e0 02             	shl    $0x2,%eax
    8282:	01 c8                	add    %ecx,%eax
    8284:	01 d0                	add    %edx,%eax
    8286:	8b 04 85 20 ed 00 00 	mov    0xed20(,%eax,4),%eax
    828d:	89 45 d8             	mov    %eax,-0x28(%ebp)
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
      }


   /* ��ȡ��ֵ����Read bigvalues area. */
   for (i=0; i<(*si).ch[ch].gr[gr].big_values*2; i+=2) {
    8290:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    8297:	e9 ac 01 00 00       	jmp    8448 <III_hufman_decode+0x306>
      if      (i<region1Start) h = &ht[(*si).ch[ch].gr[gr].table_select[0]];
    829c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    829f:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    82a2:	7d 43                	jge    82e7 <III_hufman_decode+0x1a5>
    82a4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    82a7:	8b 45 14             	mov    0x14(%ebp),%eax
    82aa:	8b 4d 10             	mov    0x10(%ebp),%ecx
    82ad:	89 c2                	mov    %eax,%edx
    82af:	c1 e2 03             	shl    $0x3,%edx
    82b2:	01 c2                	add    %eax,%edx
    82b4:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    82bb:	89 c2                	mov    %eax,%edx
    82bd:	89 c8                	mov    %ecx,%eax
    82bf:	c1 e0 02             	shl    $0x2,%eax
    82c2:	01 c8                	add    %ecx,%eax
    82c4:	c1 e0 05             	shl    $0x5,%eax
    82c7:	01 d0                	add    %edx,%eax
    82c9:	01 d8                	add    %ebx,%eax
    82cb:	83 c0 34             	add    $0x34,%eax
    82ce:	8b 10                	mov    (%eax),%edx
    82d0:	89 d0                	mov    %edx,%eax
    82d2:	c1 e0 02             	shl    $0x2,%eax
    82d5:	01 d0                	add    %edx,%eax
    82d7:	c1 e0 03             	shl    $0x3,%eax
    82da:	05 00 fd 02 00       	add    $0x2fd00,%eax
    82df:	89 45 e0             	mov    %eax,-0x20(%ebp)
    82e2:	e9 86 00 00 00       	jmp    836d <III_hufman_decode+0x22b>
      else if (i<region2Start) h = &ht[(*si).ch[ch].gr[gr].table_select[1]];
    82e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    82ea:	3b 45 d8             	cmp    -0x28(%ebp),%eax
    82ed:	7d 40                	jge    832f <III_hufman_decode+0x1ed>
    82ef:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    82f2:	8b 45 14             	mov    0x14(%ebp),%eax
    82f5:	8b 4d 10             	mov    0x10(%ebp),%ecx
    82f8:	89 c2                	mov    %eax,%edx
    82fa:	c1 e2 03             	shl    $0x3,%edx
    82fd:	01 c2                	add    %eax,%edx
    82ff:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8306:	89 c2                	mov    %eax,%edx
    8308:	89 c8                	mov    %ecx,%eax
    830a:	c1 e0 02             	shl    $0x2,%eax
    830d:	01 c8                	add    %ecx,%eax
    830f:	c1 e0 05             	shl    $0x5,%eax
    8312:	01 d0                	add    %edx,%eax
    8314:	01 d8                	add    %ebx,%eax
    8316:	83 c0 38             	add    $0x38,%eax
    8319:	8b 10                	mov    (%eax),%edx
    831b:	89 d0                	mov    %edx,%eax
    831d:	c1 e0 02             	shl    $0x2,%eax
    8320:	01 d0                	add    %edx,%eax
    8322:	c1 e0 03             	shl    $0x3,%eax
    8325:	05 00 fd 02 00       	add    $0x2fd00,%eax
    832a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    832d:	eb 3e                	jmp    836d <III_hufman_decode+0x22b>
           else                h = &ht[(*si).ch[ch].gr[gr].table_select[2]];
    832f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8332:	8b 45 14             	mov    0x14(%ebp),%eax
    8335:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8338:	89 c2                	mov    %eax,%edx
    833a:	c1 e2 03             	shl    $0x3,%edx
    833d:	01 c2                	add    %eax,%edx
    833f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8346:	89 c2                	mov    %eax,%edx
    8348:	89 c8                	mov    %ecx,%eax
    834a:	c1 e0 02             	shl    $0x2,%eax
    834d:	01 c8                	add    %ecx,%eax
    834f:	c1 e0 05             	shl    $0x5,%eax
    8352:	01 d0                	add    %edx,%eax
    8354:	01 d8                	add    %ebx,%eax
    8356:	83 c0 3c             	add    $0x3c,%eax
    8359:	8b 10                	mov    (%eax),%edx
    835b:	89 d0                	mov    %edx,%eax
    835d:	c1 e0 02             	shl    $0x2,%eax
    8360:	01 d0                	add    %edx,%eax
    8362:	c1 e0 03             	shl    $0x3,%eax
    8365:	05 00 fd 02 00       	add    $0x2fd00,%eax
    836a:	89 45 e0             	mov    %eax,-0x20(%ebp)
      huffman_decoder(h, &x, &y, &v, &w);
    836d:	8d 45 c8             	lea    -0x38(%ebp),%eax
    8370:	89 44 24 10          	mov    %eax,0x10(%esp)
    8374:	8d 45 cc             	lea    -0x34(%ebp),%eax
    8377:	89 44 24 0c          	mov    %eax,0xc(%esp)
    837b:	8d 45 d0             	lea    -0x30(%ebp),%eax
    837e:	89 44 24 08          	mov    %eax,0x8(%esp)
    8382:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    8385:	89 44 24 04          	mov    %eax,0x4(%esp)
    8389:	8b 45 e0             	mov    -0x20(%ebp),%eax
    838c:	89 04 24             	mov    %eax,(%esp)
    838f:	e8 fd ee ff ff       	call   7291 <huffman_decoder>
      is[i/SSLIMIT][i%SSLIMIT] = x;
    8394:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    8397:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    839c:	89 c8                	mov    %ecx,%eax
    839e:	f7 ea                	imul   %edx
    83a0:	c1 fa 02             	sar    $0x2,%edx
    83a3:	89 c8                	mov    %ecx,%eax
    83a5:	c1 f8 1f             	sar    $0x1f,%eax
    83a8:	29 c2                	sub    %eax,%edx
    83aa:	89 d0                	mov    %edx,%eax
    83ac:	89 c2                	mov    %eax,%edx
    83ae:	89 d0                	mov    %edx,%eax
    83b0:	c1 e0 03             	shl    $0x3,%eax
    83b3:	01 d0                	add    %edx,%eax
    83b5:	c1 e0 03             	shl    $0x3,%eax
    83b8:	89 c2                	mov    %eax,%edx
    83ba:	8b 45 08             	mov    0x8(%ebp),%eax
    83bd:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    83c0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    83c3:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    83c8:	89 c8                	mov    %ecx,%eax
    83ca:	f7 ea                	imul   %edx
    83cc:	c1 fa 02             	sar    $0x2,%edx
    83cf:	89 c8                	mov    %ecx,%eax
    83d1:	c1 f8 1f             	sar    $0x1f,%eax
    83d4:	29 c2                	sub    %eax,%edx
    83d6:	89 d0                	mov    %edx,%eax
    83d8:	c1 e0 03             	shl    $0x3,%eax
    83db:	01 d0                	add    %edx,%eax
    83dd:	01 c0                	add    %eax,%eax
    83df:	29 c1                	sub    %eax,%ecx
    83e1:	89 ca                	mov    %ecx,%edx
    83e3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    83e6:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = y;
    83e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    83ec:	8d 48 01             	lea    0x1(%eax),%ecx
    83ef:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    83f4:	89 c8                	mov    %ecx,%eax
    83f6:	f7 ea                	imul   %edx
    83f8:	c1 fa 02             	sar    $0x2,%edx
    83fb:	89 c8                	mov    %ecx,%eax
    83fd:	c1 f8 1f             	sar    $0x1f,%eax
    8400:	29 c2                	sub    %eax,%edx
    8402:	89 d0                	mov    %edx,%eax
    8404:	89 c2                	mov    %eax,%edx
    8406:	89 d0                	mov    %edx,%eax
    8408:	c1 e0 03             	shl    $0x3,%eax
    840b:	01 d0                	add    %edx,%eax
    840d:	c1 e0 03             	shl    $0x3,%eax
    8410:	89 c2                	mov    %eax,%edx
    8412:	8b 45 08             	mov    0x8(%ebp),%eax
    8415:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8418:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    841b:	8d 48 01             	lea    0x1(%eax),%ecx
    841e:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8423:	89 c8                	mov    %ecx,%eax
    8425:	f7 ea                	imul   %edx
    8427:	c1 fa 02             	sar    $0x2,%edx
    842a:	89 c8                	mov    %ecx,%eax
    842c:	c1 f8 1f             	sar    $0x1f,%eax
    842f:	29 c2                	sub    %eax,%edx
    8431:	89 d0                	mov    %edx,%eax
    8433:	c1 e0 03             	shl    $0x3,%eax
    8436:	01 d0                	add    %edx,%eax
    8438:	01 c0                	add    %eax,%eax
    843a:	29 c1                	sub    %eax,%ecx
    843c:	89 ca                	mov    %ecx,%edx
    843e:	8b 45 d0             	mov    -0x30(%ebp),%eax
    8441:	89 04 93             	mov    %eax,(%ebx,%edx,4)
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
      }


   /* ��ȡ��ֵ����Read bigvalues area. */
   for (i=0; i<(*si).ch[ch].gr[gr].big_values*2; i+=2) {
    8444:	83 45 e4 02          	addl   $0x2,-0x1c(%ebp)
    8448:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    844b:	8b 75 0c             	mov    0xc(%ebp),%esi
    844e:	8b 45 14             	mov    0x14(%ebp),%eax
    8451:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8454:	89 c2                	mov    %eax,%edx
    8456:	c1 e2 03             	shl    $0x3,%edx
    8459:	01 c2                	add    %eax,%edx
    845b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8462:	89 c2                	mov    %eax,%edx
    8464:	89 c8                	mov    %ecx,%eax
    8466:	c1 e0 02             	shl    $0x2,%eax
    8469:	01 c8                	add    %ecx,%eax
    846b:	c1 e0 05             	shl    $0x5,%eax
    846e:	01 d0                	add    %edx,%eax
    8470:	01 f0                	add    %esi,%eax
    8472:	83 c0 1c             	add    $0x1c,%eax
    8475:	8b 00                	mov    (%eax),%eax
    8477:	01 c0                	add    %eax,%eax
    8479:	39 c3                	cmp    %eax,%ebx
    847b:	0f 82 1b fe ff ff    	jb     829c <III_hufman_decode+0x15a>
      is[i/SSLIMIT][i%SSLIMIT] = x;
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = y;
      }

   /* Read count1 area. */
   h = &ht[(*si).ch[ch].gr[gr].count1table_select+32];
    8481:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8484:	8b 45 14             	mov    0x14(%ebp),%eax
    8487:	8b 4d 10             	mov    0x10(%ebp),%ecx
    848a:	89 c2                	mov    %eax,%edx
    848c:	c1 e2 03             	shl    $0x3,%edx
    848f:	01 c2                	add    %eax,%edx
    8491:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8498:	89 c2                	mov    %eax,%edx
    849a:	89 c8                	mov    %ecx,%eax
    849c:	c1 e0 02             	shl    $0x2,%eax
    849f:	01 c8                	add    %ecx,%eax
    84a1:	c1 e0 05             	shl    $0x5,%eax
    84a4:	01 d0                	add    %edx,%eax
    84a6:	01 d8                	add    %ebx,%eax
    84a8:	83 c0 5c             	add    $0x5c,%eax
    84ab:	8b 00                	mov    (%eax),%eax
    84ad:	8d 50 20             	lea    0x20(%eax),%edx
    84b0:	89 d0                	mov    %edx,%eax
    84b2:	c1 e0 02             	shl    $0x2,%eax
    84b5:	01 d0                	add    %edx,%eax
    84b7:	c1 e0 03             	shl    $0x3,%eax
    84ba:	05 00 fd 02 00       	add    $0x2fd00,%eax
    84bf:	89 45 e0             	mov    %eax,-0x20(%ebp)
   while ((hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length ) &&
    84c2:	e9 91 01 00 00       	jmp    8658 <III_hufman_decode+0x516>
     ( i < SSLIMIT*SBLIMIT )) {
      huffman_decoder(h, &x, &y, &v, &w);
    84c7:	8d 45 c8             	lea    -0x38(%ebp),%eax
    84ca:	89 44 24 10          	mov    %eax,0x10(%esp)
    84ce:	8d 45 cc             	lea    -0x34(%ebp),%eax
    84d1:	89 44 24 0c          	mov    %eax,0xc(%esp)
    84d5:	8d 45 d0             	lea    -0x30(%ebp),%eax
    84d8:	89 44 24 08          	mov    %eax,0x8(%esp)
    84dc:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    84df:	89 44 24 04          	mov    %eax,0x4(%esp)
    84e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
    84e6:	89 04 24             	mov    %eax,(%esp)
    84e9:	e8 a3 ed ff ff       	call   7291 <huffman_decoder>
      is[i/SSLIMIT][i%SSLIMIT] = v;
    84ee:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    84f1:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    84f6:	89 c8                	mov    %ecx,%eax
    84f8:	f7 ea                	imul   %edx
    84fa:	c1 fa 02             	sar    $0x2,%edx
    84fd:	89 c8                	mov    %ecx,%eax
    84ff:	c1 f8 1f             	sar    $0x1f,%eax
    8502:	29 c2                	sub    %eax,%edx
    8504:	89 d0                	mov    %edx,%eax
    8506:	89 c2                	mov    %eax,%edx
    8508:	89 d0                	mov    %edx,%eax
    850a:	c1 e0 03             	shl    $0x3,%eax
    850d:	01 d0                	add    %edx,%eax
    850f:	c1 e0 03             	shl    $0x3,%eax
    8512:	89 c2                	mov    %eax,%edx
    8514:	8b 45 08             	mov    0x8(%ebp),%eax
    8517:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    851a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    851d:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8522:	89 c8                	mov    %ecx,%eax
    8524:	f7 ea                	imul   %edx
    8526:	c1 fa 02             	sar    $0x2,%edx
    8529:	89 c8                	mov    %ecx,%eax
    852b:	c1 f8 1f             	sar    $0x1f,%eax
    852e:	29 c2                	sub    %eax,%edx
    8530:	89 d0                	mov    %edx,%eax
    8532:	c1 e0 03             	shl    $0x3,%eax
    8535:	01 d0                	add    %edx,%eax
    8537:	01 c0                	add    %eax,%eax
    8539:	29 c1                	sub    %eax,%ecx
    853b:	89 ca                	mov    %ecx,%edx
    853d:	8b 45 cc             	mov    -0x34(%ebp),%eax
    8540:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = w;
    8543:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    8546:	8d 48 01             	lea    0x1(%eax),%ecx
    8549:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    854e:	89 c8                	mov    %ecx,%eax
    8550:	f7 ea                	imul   %edx
    8552:	c1 fa 02             	sar    $0x2,%edx
    8555:	89 c8                	mov    %ecx,%eax
    8557:	c1 f8 1f             	sar    $0x1f,%eax
    855a:	29 c2                	sub    %eax,%edx
    855c:	89 d0                	mov    %edx,%eax
    855e:	89 c2                	mov    %eax,%edx
    8560:	89 d0                	mov    %edx,%eax
    8562:	c1 e0 03             	shl    $0x3,%eax
    8565:	01 d0                	add    %edx,%eax
    8567:	c1 e0 03             	shl    $0x3,%eax
    856a:	89 c2                	mov    %eax,%edx
    856c:	8b 45 08             	mov    0x8(%ebp),%eax
    856f:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8572:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    8575:	8d 48 01             	lea    0x1(%eax),%ecx
    8578:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    857d:	89 c8                	mov    %ecx,%eax
    857f:	f7 ea                	imul   %edx
    8581:	c1 fa 02             	sar    $0x2,%edx
    8584:	89 c8                	mov    %ecx,%eax
    8586:	c1 f8 1f             	sar    $0x1f,%eax
    8589:	29 c2                	sub    %eax,%edx
    858b:	89 d0                	mov    %edx,%eax
    858d:	c1 e0 03             	shl    $0x3,%eax
    8590:	01 d0                	add    %edx,%eax
    8592:	01 c0                	add    %eax,%eax
    8594:	29 c1                	sub    %eax,%ecx
    8596:	89 ca                	mov    %ecx,%edx
    8598:	8b 45 c8             	mov    -0x38(%ebp),%eax
    859b:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+2)/SSLIMIT][(i+2)%SSLIMIT] = x;
    859e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    85a1:	8d 48 02             	lea    0x2(%eax),%ecx
    85a4:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    85a9:	89 c8                	mov    %ecx,%eax
    85ab:	f7 ea                	imul   %edx
    85ad:	c1 fa 02             	sar    $0x2,%edx
    85b0:	89 c8                	mov    %ecx,%eax
    85b2:	c1 f8 1f             	sar    $0x1f,%eax
    85b5:	29 c2                	sub    %eax,%edx
    85b7:	89 d0                	mov    %edx,%eax
    85b9:	89 c2                	mov    %eax,%edx
    85bb:	89 d0                	mov    %edx,%eax
    85bd:	c1 e0 03             	shl    $0x3,%eax
    85c0:	01 d0                	add    %edx,%eax
    85c2:	c1 e0 03             	shl    $0x3,%eax
    85c5:	89 c2                	mov    %eax,%edx
    85c7:	8b 45 08             	mov    0x8(%ebp),%eax
    85ca:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    85cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    85d0:	8d 48 02             	lea    0x2(%eax),%ecx
    85d3:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    85d8:	89 c8                	mov    %ecx,%eax
    85da:	f7 ea                	imul   %edx
    85dc:	c1 fa 02             	sar    $0x2,%edx
    85df:	89 c8                	mov    %ecx,%eax
    85e1:	c1 f8 1f             	sar    $0x1f,%eax
    85e4:	29 c2                	sub    %eax,%edx
    85e6:	89 d0                	mov    %edx,%eax
    85e8:	c1 e0 03             	shl    $0x3,%eax
    85eb:	01 d0                	add    %edx,%eax
    85ed:	01 c0                	add    %eax,%eax
    85ef:	29 c1                	sub    %eax,%ecx
    85f1:	89 ca                	mov    %ecx,%edx
    85f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    85f6:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+3)/SSLIMIT][(i+3)%SSLIMIT] = y;
    85f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    85fc:	8d 48 03             	lea    0x3(%eax),%ecx
    85ff:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8604:	89 c8                	mov    %ecx,%eax
    8606:	f7 ea                	imul   %edx
    8608:	c1 fa 02             	sar    $0x2,%edx
    860b:	89 c8                	mov    %ecx,%eax
    860d:	c1 f8 1f             	sar    $0x1f,%eax
    8610:	29 c2                	sub    %eax,%edx
    8612:	89 d0                	mov    %edx,%eax
    8614:	89 c2                	mov    %eax,%edx
    8616:	89 d0                	mov    %edx,%eax
    8618:	c1 e0 03             	shl    $0x3,%eax
    861b:	01 d0                	add    %edx,%eax
    861d:	c1 e0 03             	shl    $0x3,%eax
    8620:	89 c2                	mov    %eax,%edx
    8622:	8b 45 08             	mov    0x8(%ebp),%eax
    8625:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8628:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    862b:	8d 48 03             	lea    0x3(%eax),%ecx
    862e:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8633:	89 c8                	mov    %ecx,%eax
    8635:	f7 ea                	imul   %edx
    8637:	c1 fa 02             	sar    $0x2,%edx
    863a:	89 c8                	mov    %ecx,%eax
    863c:	c1 f8 1f             	sar    $0x1f,%eax
    863f:	29 c2                	sub    %eax,%edx
    8641:	89 d0                	mov    %edx,%eax
    8643:	c1 e0 03             	shl    $0x3,%eax
    8646:	01 d0                	add    %edx,%eax
    8648:	01 c0                	add    %eax,%eax
    864a:	29 c1                	sub    %eax,%ecx
    864c:	89 ca                	mov    %ecx,%edx
    864e:	8b 45 d0             	mov    -0x30(%ebp),%eax
    8651:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      i += 4;
    8654:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = y;
      }

   /* Read count1 area. */
   h = &ht[(*si).ch[ch].gr[gr].count1table_select+32];
   while ((hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length ) &&
    8658:	e8 5b d3 ff ff       	call   59b8 <hsstell>
    865d:	89 c3                	mov    %eax,%ebx
    865f:	8b 75 0c             	mov    0xc(%ebp),%esi
    8662:	8b 45 14             	mov    0x14(%ebp),%eax
    8665:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8668:	89 c2                	mov    %eax,%edx
    866a:	c1 e2 03             	shl    $0x3,%edx
    866d:	01 c2                	add    %eax,%edx
    866f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8676:	89 c2                	mov    %eax,%edx
    8678:	89 c8                	mov    %ecx,%eax
    867a:	c1 e0 02             	shl    $0x2,%eax
    867d:	01 c8                	add    %ecx,%eax
    867f:	c1 e0 05             	shl    $0x5,%eax
    8682:	01 d0                	add    %edx,%eax
    8684:	01 f0                	add    %esi,%eax
    8686:	83 c0 18             	add    $0x18,%eax
    8689:	8b 10                	mov    (%eax),%edx
    868b:	8b 45 18             	mov    0x18(%ebp),%eax
    868e:	01 d0                	add    %edx,%eax
    8690:	39 c3                	cmp    %eax,%ebx
    8692:	73 0d                	jae    86a1 <III_hufman_decode+0x55f>
    8694:	81 7d e4 3f 02 00 00 	cmpl   $0x23f,-0x1c(%ebp)
    869b:	0f 8e 26 fe ff ff    	jle    84c7 <III_hufman_decode+0x385>
      is[(i+2)/SSLIMIT][(i+2)%SSLIMIT] = x;
      is[(i+3)/SSLIMIT][(i+3)%SSLIMIT] = y;
      i += 4;
      }

   if (hsstell() > part2_start + (*si).ch[ch].gr[gr].part2_3_length)
    86a1:	e8 12 d3 ff ff       	call   59b8 <hsstell>
    86a6:	89 c3                	mov    %eax,%ebx
    86a8:	8b 75 0c             	mov    0xc(%ebp),%esi
    86ab:	8b 45 14             	mov    0x14(%ebp),%eax
    86ae:	8b 4d 10             	mov    0x10(%ebp),%ecx
    86b1:	89 c2                	mov    %eax,%edx
    86b3:	c1 e2 03             	shl    $0x3,%edx
    86b6:	01 c2                	add    %eax,%edx
    86b8:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    86bf:	89 c2                	mov    %eax,%edx
    86c1:	89 c8                	mov    %ecx,%eax
    86c3:	c1 e0 02             	shl    $0x2,%eax
    86c6:	01 c8                	add    %ecx,%eax
    86c8:	c1 e0 05             	shl    $0x5,%eax
    86cb:	01 d0                	add    %edx,%eax
    86cd:	01 f0                	add    %esi,%eax
    86cf:	83 c0 18             	add    $0x18,%eax
    86d2:	8b 10                	mov    (%eax),%edx
    86d4:	8b 45 18             	mov    0x18(%ebp),%eax
    86d7:	01 d0                	add    %edx,%eax
    86d9:	39 c3                	cmp    %eax,%ebx
    86db:	76 48                	jbe    8725 <III_hufman_decode+0x5e3>
   {  i -=4;
    86dd:	83 6d e4 04          	subl   $0x4,-0x1c(%ebp)
      rewindNbits(hsstell()-part2_start - (*si).ch[ch].gr[gr].part2_3_length);
    86e1:	e8 d2 d2 ff ff       	call   59b8 <hsstell>
    86e6:	8b 55 18             	mov    0x18(%ebp),%edx
    86e9:	29 d0                	sub    %edx,%eax
    86eb:	89 c6                	mov    %eax,%esi
    86ed:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    86f0:	8b 45 14             	mov    0x14(%ebp),%eax
    86f3:	8b 4d 10             	mov    0x10(%ebp),%ecx
    86f6:	89 c2                	mov    %eax,%edx
    86f8:	c1 e2 03             	shl    $0x3,%edx
    86fb:	01 c2                	add    %eax,%edx
    86fd:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8704:	89 c2                	mov    %eax,%edx
    8706:	89 c8                	mov    %ecx,%eax
    8708:	c1 e0 02             	shl    $0x2,%eax
    870b:	01 c8                	add    %ecx,%eax
    870d:	c1 e0 05             	shl    $0x5,%eax
    8710:	01 d0                	add    %edx,%eax
    8712:	01 d8                	add    %ebx,%eax
    8714:	83 c0 18             	add    $0x18,%eax
    8717:	8b 00                	mov    (%eax),%eax
    8719:	29 c6                	sub    %eax,%esi
    871b:	89 f0                	mov    %esi,%eax
    871d:	89 04 24             	mov    %eax,(%esp)
    8720:	e8 de d2 ff ff       	call   5a03 <rewindNbits>
   }

   /* Dismiss stuffing Bits */
   if ( hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length )
    8725:	e8 8e d2 ff ff       	call   59b8 <hsstell>
    872a:	89 c3                	mov    %eax,%ebx
    872c:	8b 75 0c             	mov    0xc(%ebp),%esi
    872f:	8b 45 14             	mov    0x14(%ebp),%eax
    8732:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8735:	89 c2                	mov    %eax,%edx
    8737:	c1 e2 03             	shl    $0x3,%edx
    873a:	01 c2                	add    %eax,%edx
    873c:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8743:	89 c2                	mov    %eax,%edx
    8745:	89 c8                	mov    %ecx,%eax
    8747:	c1 e0 02             	shl    $0x2,%eax
    874a:	01 c8                	add    %ecx,%eax
    874c:	c1 e0 05             	shl    $0x5,%eax
    874f:	01 d0                	add    %edx,%eax
    8751:	01 f0                	add    %esi,%eax
    8753:	83 c0 18             	add    $0x18,%eax
    8756:	8b 10                	mov    (%eax),%edx
    8758:	8b 45 18             	mov    0x18(%ebp),%eax
    875b:	01 d0                	add    %edx,%eax
    875d:	39 c3                	cmp    %eax,%ebx
    875f:	73 45                	jae    87a6 <III_hufman_decode+0x664>
      hgetbits( part2_start + (*si).ch[ch].gr[gr].part2_3_length - hsstell());
    8761:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8764:	8b 45 14             	mov    0x14(%ebp),%eax
    8767:	8b 4d 10             	mov    0x10(%ebp),%ecx
    876a:	89 c2                	mov    %eax,%edx
    876c:	c1 e2 03             	shl    $0x3,%edx
    876f:	01 c2                	add    %eax,%edx
    8771:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8778:	89 c2                	mov    %eax,%edx
    877a:	89 c8                	mov    %ecx,%eax
    877c:	c1 e0 02             	shl    $0x2,%eax
    877f:	01 c8                	add    %ecx,%eax
    8781:	c1 e0 05             	shl    $0x5,%eax
    8784:	01 d0                	add    %edx,%eax
    8786:	01 d8                	add    %ebx,%eax
    8788:	83 c0 18             	add    $0x18,%eax
    878b:	8b 10                	mov    (%eax),%edx
    878d:	8b 45 18             	mov    0x18(%ebp),%eax
    8790:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8793:	e8 20 d2 ff ff       	call   59b8 <hsstell>
    8798:	29 c3                	sub    %eax,%ebx
    879a:	89 d8                	mov    %ebx,%eax
    879c:	89 04 24             	mov    %eax,(%esp)
    879f:	e8 30 d2 ff ff       	call   59d4 <hgetbits>

   /* Zero out rest. */
   for (; i<SSLIMIT*SBLIMIT; i++)
    87a4:	eb 5c                	jmp    8802 <III_hufman_decode+0x6c0>
    87a6:	eb 5a                	jmp    8802 <III_hufman_decode+0x6c0>
      is[i/SSLIMIT][i%SSLIMIT] = 0;
    87a8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    87ab:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    87b0:	89 c8                	mov    %ecx,%eax
    87b2:	f7 ea                	imul   %edx
    87b4:	c1 fa 02             	sar    $0x2,%edx
    87b7:	89 c8                	mov    %ecx,%eax
    87b9:	c1 f8 1f             	sar    $0x1f,%eax
    87bc:	29 c2                	sub    %eax,%edx
    87be:	89 d0                	mov    %edx,%eax
    87c0:	89 c2                	mov    %eax,%edx
    87c2:	89 d0                	mov    %edx,%eax
    87c4:	c1 e0 03             	shl    $0x3,%eax
    87c7:	01 d0                	add    %edx,%eax
    87c9:	c1 e0 03             	shl    $0x3,%eax
    87cc:	89 c2                	mov    %eax,%edx
    87ce:	8b 45 08             	mov    0x8(%ebp),%eax
    87d1:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    87d4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    87d7:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    87dc:	89 c8                	mov    %ecx,%eax
    87de:	f7 ea                	imul   %edx
    87e0:	c1 fa 02             	sar    $0x2,%edx
    87e3:	89 c8                	mov    %ecx,%eax
    87e5:	c1 f8 1f             	sar    $0x1f,%eax
    87e8:	29 c2                	sub    %eax,%edx
    87ea:	89 d0                	mov    %edx,%eax
    87ec:	c1 e0 03             	shl    $0x3,%eax
    87ef:	01 d0                	add    %edx,%eax
    87f1:	01 c0                	add    %eax,%eax
    87f3:	29 c1                	sub    %eax,%ecx
    87f5:	89 ca                	mov    %ecx,%edx
    87f7:	c7 04 93 00 00 00 00 	movl   $0x0,(%ebx,%edx,4)
   /* Dismiss stuffing Bits */
   if ( hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length )
      hgetbits( part2_start + (*si).ch[ch].gr[gr].part2_3_length - hsstell());

   /* Zero out rest. */
   for (; i<SSLIMIT*SBLIMIT; i++)
    87fe:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    8802:	81 7d e4 3f 02 00 00 	cmpl   $0x23f,-0x1c(%ebp)
    8809:	7e 9d                	jle    87a8 <III_hufman_decode+0x666>
      is[i/SSLIMIT][i%SSLIMIT] = 0;
}
    880b:	83 c4 4c             	add    $0x4c,%esp
    880e:	5b                   	pop    %ebx
    880f:	5e                   	pop    %esi
    8810:	5f                   	pop    %edi
    8811:	5d                   	pop    %ebp
    8812:	c3                   	ret    

00008813 <III_dequantize_sample>:


int pretab[22] = {0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,2,2,3,3,3,2,0};

void III_dequantize_sample(long int is[SBLIMIT][SSLIMIT], double xr[SBLIMIT][SSLIMIT], III_scalefac_t *scalefac, struct gr_info_s *gr_info, int ch, struct frame_params *fr_ps)
{
    8813:	55                   	push   %ebp
    8814:	89 e5                	mov    %esp,%ebp
    8816:	56                   	push   %esi
    8817:	53                   	push   %ebx
    8818:	83 ec 50             	sub    $0x50,%esp
	int ss,sb,cb=0,sfreq=fr_ps->header->sampling_frequency;
    881b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    8822:	8b 45 1c             	mov    0x1c(%ebp),%eax
    8825:	8b 00                	mov    (%eax),%eax
    8827:	8b 40 10             	mov    0x10(%eax),%eax
    882a:	89 45 dc             	mov    %eax,-0x24(%ebp)
	//int stereo = fr_ps->stereo;
	int next_cb_boundary, cb_begin, cb_width = 0, sign;
    882d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)

	/* choose correct scalefactor band per block type, initalize boundary */

	if (gr_info->window_switching_flag && (gr_info->block_type == 2) )
    8834:	8b 45 14             	mov    0x14(%ebp),%eax
    8837:	8b 40 10             	mov    0x10(%eax),%eax
    883a:	85 c0                	test   %eax,%eax
    883c:	74 61                	je     889f <III_dequantize_sample+0x8c>
    883e:	8b 45 14             	mov    0x14(%ebp),%eax
    8841:	8b 40 14             	mov    0x14(%eax),%eax
    8844:	83 f8 02             	cmp    $0x2,%eax
    8847:	75 56                	jne    889f <III_dequantize_sample+0x8c>
		if (gr_info->mixed_block_flag)
    8849:	8b 45 14             	mov    0x14(%ebp),%eax
    884c:	8b 40 18             	mov    0x18(%eax),%eax
    884f:	85 c0                	test   %eax,%eax
    8851:	74 15                	je     8868 <III_dequantize_sample+0x55>
			next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
    8853:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8856:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    885c:	05 24 ed 00 00       	add    $0xed24,%eax
    8861:	8b 00                	mov    (%eax),%eax
    8863:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int next_cb_boundary, cb_begin, cb_width = 0, sign;

	/* choose correct scalefactor band per block type, initalize boundary */

	if (gr_info->window_switching_flag && (gr_info->block_type == 2) )
		if (gr_info->mixed_block_flag)
    8866:	eb 4a                	jmp    88b2 <III_dequantize_sample+0x9f>
			next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
		else {
			next_cb_boundary=sfBandIndex[sfreq].s[1]*3; /* pure SHORT block */
    8868:	8b 45 dc             	mov    -0x24(%ebp),%eax
    886b:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8871:	05 74 ed 00 00       	add    $0xed74,%eax
    8876:	8b 50 0c             	mov    0xc(%eax),%edx
    8879:	89 d0                	mov    %edx,%eax
    887b:	01 c0                	add    %eax,%eax
    887d:	01 d0                	add    %edx,%eax
    887f:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cb_width = sfBandIndex[sfreq].s[1];
    8882:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8885:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    888b:	05 74 ed 00 00       	add    $0xed74,%eax
    8890:	8b 40 0c             	mov    0xc(%eax),%eax
    8893:	89 45 e0             	mov    %eax,-0x20(%ebp)
			cb_begin = 0;
    8896:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	int next_cb_boundary, cb_begin, cb_width = 0, sign;

	/* choose correct scalefactor band per block type, initalize boundary */

	if (gr_info->window_switching_flag && (gr_info->block_type == 2) )
		if (gr_info->mixed_block_flag)
    889d:	eb 13                	jmp    88b2 <III_dequantize_sample+0x9f>
			next_cb_boundary=sfBandIndex[sfreq].s[1]*3; /* pure SHORT block */
			cb_width = sfBandIndex[sfreq].s[1];
			cb_begin = 0;
		}
	else
		next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
    889f:	8b 45 dc             	mov    -0x24(%ebp),%eax
    88a2:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    88a8:	05 24 ed 00 00       	add    $0xed24,%eax
    88ad:	8b 00                	mov    (%eax),%eax
    88af:	89 45 e8             	mov    %eax,-0x18(%ebp)

	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
    88b2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    88b9:	e9 3d 06 00 00       	jmp    8efb <III_dequantize_sample+0x6e8>
		for (ss=0 ; ss < SSLIMIT ; ss++) {
    88be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    88c5:	e9 23 06 00 00       	jmp    8eed <III_dequantize_sample+0x6da>
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
    88ca:	8b 55 f0             	mov    -0x10(%ebp),%edx
    88cd:	89 d0                	mov    %edx,%eax
    88cf:	c1 e0 03             	shl    $0x3,%eax
    88d2:	01 d0                	add    %edx,%eax
    88d4:	01 c0                	add    %eax,%eax
    88d6:	89 c2                	mov    %eax,%edx
    88d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    88db:	01 d0                	add    %edx,%eax
    88dd:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    88e0:	0f 85 9e 02 00 00    	jne    8b84 <III_dequantize_sample+0x371>
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    88e6:	8b 45 14             	mov    0x14(%ebp),%eax
    88e9:	8b 40 10             	mov    0x10(%eax),%eax
    88ec:	85 c0                	test   %eax,%eax
    88ee:	0f 84 6b 02 00 00    	je     8b5f <III_dequantize_sample+0x34c>
    88f4:	8b 45 14             	mov    0x14(%ebp),%eax
    88f7:	8b 40 14             	mov    0x14(%eax),%eax
    88fa:	83 f8 02             	cmp    $0x2,%eax
    88fd:	0f 85 5c 02 00 00    	jne    8b5f <III_dequantize_sample+0x34c>
					if (gr_info->mixed_block_flag) {
    8903:	8b 45 14             	mov    0x14(%ebp),%eax
    8906:	8b 40 18             	mov    0x18(%eax),%eax
    8909:	85 c0                	test   %eax,%eax
    890b:	0f 84 af 01 00 00    	je     8ac0 <III_dequantize_sample+0x2ad>
						if (((sb*18)+ss) == sfBandIndex[sfreq].l[8])  {
    8911:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8914:	89 d0                	mov    %edx,%eax
    8916:	c1 e0 03             	shl    $0x3,%eax
    8919:	01 d0                	add    %edx,%eax
    891b:	01 c0                	add    %eax,%eax
    891d:	89 c2                	mov    %eax,%edx
    891f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8922:	01 c2                	add    %eax,%edx
    8924:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8927:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    892d:	05 40 ed 00 00       	add    $0xed40,%eax
    8932:	8b 00                	mov    (%eax),%eax
    8934:	39 c2                	cmp    %eax,%edx
    8936:	0f 85 93 00 00 00    	jne    89cf <III_dequantize_sample+0x1bc>
							next_cb_boundary=sfBandIndex[sfreq].s[4]*3;
    893c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    893f:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8945:	05 80 ed 00 00       	add    $0xed80,%eax
    894a:	8b 50 0c             	mov    0xc(%eax),%edx
    894d:	89 d0                	mov    %edx,%eax
    894f:	01 c0                	add    %eax,%eax
    8951:	01 d0                	add    %edx,%eax
    8953:	89 45 e8             	mov    %eax,-0x18(%ebp)
							cb = 3;
    8956:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    895d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8960:	8d 48 01             	lea    0x1(%eax),%ecx
    8963:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8966:	89 d0                	mov    %edx,%eax
    8968:	c1 e0 03             	shl    $0x3,%eax
    896b:	01 d0                	add    %edx,%eax
    896d:	c1 e0 02             	shl    $0x2,%eax
    8970:	01 d0                	add    %edx,%eax
    8972:	01 c8                	add    %ecx,%eax
    8974:	83 c0 14             	add    $0x14,%eax
    8977:	8b 0c 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%ecx
										sfBandIndex[sfreq].s[cb];
    897e:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8981:	89 d0                	mov    %edx,%eax
    8983:	c1 e0 03             	shl    $0x3,%eax
    8986:	01 d0                	add    %edx,%eax
    8988:	c1 e0 02             	shl    $0x2,%eax
    898b:	01 d0                	add    %edx,%eax
    898d:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8990:	01 d0                	add    %edx,%eax
    8992:	83 c0 14             	add    $0x14,%eax
    8995:	8b 04 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%eax
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
						if (((sb*18)+ss) == sfBandIndex[sfreq].l[8])  {
							next_cb_boundary=sfBandIndex[sfreq].s[4]*3;
							cb = 3;
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    899c:	29 c1                	sub    %eax,%ecx
    899e:	89 c8                	mov    %ecx,%eax
    89a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
    89a3:	8b 55 dc             	mov    -0x24(%ebp),%edx
    89a6:	89 d0                	mov    %edx,%eax
    89a8:	c1 e0 03             	shl    $0x3,%eax
    89ab:	01 d0                	add    %edx,%eax
    89ad:	c1 e0 02             	shl    $0x2,%eax
    89b0:	01 d0                	add    %edx,%eax
    89b2:	8b 55 ec             	mov    -0x14(%ebp),%edx
    89b5:	01 d0                	add    %edx,%eax
    89b7:	83 c0 14             	add    $0x14,%eax
    89ba:	8b 14 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%edx
    89c1:	89 d0                	mov    %edx,%eax
    89c3:	01 c0                	add    %eax,%eax
    89c5:	01 d0                	add    %edx,%eax
    89c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    89ca:	e9 8e 01 00 00       	jmp    8b5d <III_dequantize_sample+0x34a>
						}
						else if (((sb*18)+ss) < sfBandIndex[sfreq].l[8])
    89cf:	8b 55 f0             	mov    -0x10(%ebp),%edx
    89d2:	89 d0                	mov    %edx,%eax
    89d4:	c1 e0 03             	shl    $0x3,%eax
    89d7:	01 d0                	add    %edx,%eax
    89d9:	01 c0                	add    %eax,%eax
    89db:	89 c2                	mov    %eax,%edx
    89dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    89e0:	01 c2                	add    %eax,%edx
    89e2:	8b 45 dc             	mov    -0x24(%ebp),%eax
    89e5:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    89eb:	05 40 ed 00 00       	add    $0xed40,%eax
    89f0:	8b 00                	mov    (%eax),%eax
    89f2:	39 c2                	cmp    %eax,%edx
    89f4:	7d 2a                	jge    8a20 <III_dequantize_sample+0x20d>
							next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
    89f6:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    89fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
    89fd:	8d 48 01             	lea    0x1(%eax),%ecx
    8a00:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8a03:	89 d0                	mov    %edx,%eax
    8a05:	c1 e0 03             	shl    $0x3,%eax
    8a08:	01 d0                	add    %edx,%eax
    8a0a:	c1 e0 02             	shl    $0x2,%eax
    8a0d:	01 d0                	add    %edx,%eax
    8a0f:	01 c8                	add    %ecx,%eax
    8a11:	8b 04 85 20 ed 00 00 	mov    0xed20(,%eax,4),%eax
    8a18:	89 45 e8             	mov    %eax,-0x18(%ebp)
    8a1b:	e9 3d 01 00 00       	jmp    8b5d <III_dequantize_sample+0x34a>
						else {
							next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
    8a20:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8a24:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8a27:	8d 48 01             	lea    0x1(%eax),%ecx
    8a2a:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8a2d:	89 d0                	mov    %edx,%eax
    8a2f:	c1 e0 03             	shl    $0x3,%eax
    8a32:	01 d0                	add    %edx,%eax
    8a34:	c1 e0 02             	shl    $0x2,%eax
    8a37:	01 d0                	add    %edx,%eax
    8a39:	01 c8                	add    %ecx,%eax
    8a3b:	83 c0 14             	add    $0x14,%eax
    8a3e:	8b 14 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%edx
    8a45:	89 d0                	mov    %edx,%eax
    8a47:	01 c0                	add    %eax,%eax
    8a49:	01 d0                	add    %edx,%eax
    8a4b:	89 45 e8             	mov    %eax,-0x18(%ebp)
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    8a4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8a51:	8d 48 01             	lea    0x1(%eax),%ecx
    8a54:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8a57:	89 d0                	mov    %edx,%eax
    8a59:	c1 e0 03             	shl    $0x3,%eax
    8a5c:	01 d0                	add    %edx,%eax
    8a5e:	c1 e0 02             	shl    $0x2,%eax
    8a61:	01 d0                	add    %edx,%eax
    8a63:	01 c8                	add    %ecx,%eax
    8a65:	83 c0 14             	add    $0x14,%eax
    8a68:	8b 0c 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%ecx
										sfBandIndex[sfreq].s[cb];
    8a6f:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8a72:	89 d0                	mov    %edx,%eax
    8a74:	c1 e0 03             	shl    $0x3,%eax
    8a77:	01 d0                	add    %edx,%eax
    8a79:	c1 e0 02             	shl    $0x2,%eax
    8a7c:	01 d0                	add    %edx,%eax
    8a7e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8a81:	01 d0                	add    %edx,%eax
    8a83:	83 c0 14             	add    $0x14,%eax
    8a86:	8b 04 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%eax
						}
						else if (((sb*18)+ss) < sfBandIndex[sfreq].l[8])
							next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
						else {
							next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    8a8d:	29 c1                	sub    %eax,%ecx
    8a8f:	89 c8                	mov    %ecx,%eax
    8a91:	89 45 e0             	mov    %eax,-0x20(%ebp)
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
    8a94:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8a97:	89 d0                	mov    %edx,%eax
    8a99:	c1 e0 03             	shl    $0x3,%eax
    8a9c:	01 d0                	add    %edx,%eax
    8a9e:	c1 e0 02             	shl    $0x2,%eax
    8aa1:	01 d0                	add    %edx,%eax
    8aa3:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8aa6:	01 d0                	add    %edx,%eax
    8aa8:	83 c0 14             	add    $0x14,%eax
    8aab:	8b 14 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%edx
    8ab2:	89 d0                	mov    %edx,%eax
    8ab4:	01 c0                	add    %eax,%eax
    8ab6:	01 d0                	add    %edx,%eax
    8ab8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
    8abb:	e9 c4 00 00 00       	jmp    8b84 <III_dequantize_sample+0x371>
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
						}
					}
					else {
						next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
    8ac0:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8ac4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8ac7:	8d 48 01             	lea    0x1(%eax),%ecx
    8aca:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8acd:	89 d0                	mov    %edx,%eax
    8acf:	c1 e0 03             	shl    $0x3,%eax
    8ad2:	01 d0                	add    %edx,%eax
    8ad4:	c1 e0 02             	shl    $0x2,%eax
    8ad7:	01 d0                	add    %edx,%eax
    8ad9:	01 c8                	add    %ecx,%eax
    8adb:	83 c0 14             	add    $0x14,%eax
    8ade:	8b 14 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%edx
    8ae5:	89 d0                	mov    %edx,%eax
    8ae7:	01 c0                	add    %eax,%eax
    8ae9:	01 d0                	add    %edx,%eax
    8aeb:	89 45 e8             	mov    %eax,-0x18(%ebp)
						cb_width = sfBandIndex[sfreq].s[cb+1] -
    8aee:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8af1:	8d 48 01             	lea    0x1(%eax),%ecx
    8af4:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8af7:	89 d0                	mov    %edx,%eax
    8af9:	c1 e0 03             	shl    $0x3,%eax
    8afc:	01 d0                	add    %edx,%eax
    8afe:	c1 e0 02             	shl    $0x2,%eax
    8b01:	01 d0                	add    %edx,%eax
    8b03:	01 c8                	add    %ecx,%eax
    8b05:	83 c0 14             	add    $0x14,%eax
    8b08:	8b 0c 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%ecx
									sfBandIndex[sfreq].s[cb];
    8b0f:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8b12:	89 d0                	mov    %edx,%eax
    8b14:	c1 e0 03             	shl    $0x3,%eax
    8b17:	01 d0                	add    %edx,%eax
    8b19:	c1 e0 02             	shl    $0x2,%eax
    8b1c:	01 d0                	add    %edx,%eax
    8b1e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8b21:	01 d0                	add    %edx,%eax
    8b23:	83 c0 14             	add    $0x14,%eax
    8b26:	8b 04 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%eax
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
						}
					}
					else {
						next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
						cb_width = sfBandIndex[sfreq].s[cb+1] -
    8b2d:	29 c1                	sub    %eax,%ecx
    8b2f:	89 c8                	mov    %ecx,%eax
    8b31:	89 45 e0             	mov    %eax,-0x20(%ebp)
									sfBandIndex[sfreq].s[cb];
						cb_begin = sfBandIndex[sfreq].s[cb]*3;
    8b34:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8b37:	89 d0                	mov    %edx,%eax
    8b39:	c1 e0 03             	shl    $0x3,%eax
    8b3c:	01 d0                	add    %edx,%eax
    8b3e:	c1 e0 02             	shl    $0x2,%eax
    8b41:	01 d0                	add    %edx,%eax
    8b43:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8b46:	01 d0                	add    %edx,%eax
    8b48:	83 c0 14             	add    $0x14,%eax
    8b4b:	8b 14 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%edx
    8b52:	89 d0                	mov    %edx,%eax
    8b54:	01 c0                	add    %eax,%eax
    8b56:	01 d0                	add    %edx,%eax
    8b58:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
    8b5b:	eb 27                	jmp    8b84 <III_dequantize_sample+0x371>
    8b5d:	eb 25                	jmp    8b84 <III_dequantize_sample+0x371>
									sfBandIndex[sfreq].s[cb];
						cb_begin = sfBandIndex[sfreq].s[cb]*3;
					}
				}
	            else /* long blocks */
		           next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
    8b5f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8b63:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8b66:	8d 48 01             	lea    0x1(%eax),%ecx
    8b69:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8b6c:	89 d0                	mov    %edx,%eax
    8b6e:	c1 e0 03             	shl    $0x3,%eax
    8b71:	01 d0                	add    %edx,%eax
    8b73:	c1 e0 02             	shl    $0x2,%eax
    8b76:	01 d0                	add    %edx,%eax
    8b78:	01 c8                	add    %ecx,%eax
    8b7a:	8b 04 85 20 ed 00 00 	mov    0xed20(,%eax,4),%eax
    8b81:	89 45 e8             	mov    %eax,-0x18(%ebp)
			}

			/* Compute overall (global) scaling. */
			xr[sb][ss] = pow( 2.0 , (0.25 * (gr_info->global_gain - 210.0)));
    8b84:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8b87:	89 d0                	mov    %edx,%eax
    8b89:	c1 e0 03             	shl    $0x3,%eax
    8b8c:	01 d0                	add    %edx,%eax
    8b8e:	c1 e0 04             	shl    $0x4,%eax
    8b91:	89 c2                	mov    %eax,%edx
    8b93:	8b 45 0c             	mov    0xc(%ebp),%eax
    8b96:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8b99:	8b 45 14             	mov    0x14(%ebp),%eax
    8b9c:	8b 40 08             	mov    0x8(%eax),%eax
    8b9f:	ba 00 00 00 00       	mov    $0x0,%edx
    8ba4:	89 45 c8             	mov    %eax,-0x38(%ebp)
    8ba7:	89 55 cc             	mov    %edx,-0x34(%ebp)
    8baa:	df 6d c8             	fildll -0x38(%ebp)
    8bad:	dd 05 30 da 00 00    	fldl   0xda30
    8bb3:	de e9                	fsubrp %st,%st(1)
    8bb5:	dd 05 38 da 00 00    	fldl   0xda38
    8bbb:	de c9                	fmulp  %st,%st(1)
    8bbd:	dd 5c 24 08          	fstpl  0x8(%esp)
    8bc1:	dd 05 40 da 00 00    	fldl   0xda40
    8bc7:	dd 1c 24             	fstpl  (%esp)
    8bca:	e8 0c c1 ff ff       	call   4cdb <pow>
    8bcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8bd2:	dd 1c c3             	fstpl  (%ebx,%eax,8)

			/* Do long/short dependent scaling operations. */

			if (gr_info->window_switching_flag && (
    8bd5:	8b 45 14             	mov    0x14(%ebp),%eax
    8bd8:	8b 40 10             	mov    0x10(%eax),%eax
    8bdb:	85 c0                	test   %eax,%eax
    8bdd:	0f 84 86 01 00 00    	je     8d69 <III_dequantize_sample+0x556>
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    8be3:	8b 45 14             	mov    0x14(%ebp),%eax
    8be6:	8b 40 14             	mov    0x14(%eax),%eax
			/* Compute overall (global) scaling. */
			xr[sb][ss] = pow( 2.0 , (0.25 * (gr_info->global_gain - 210.0)));

			/* Do long/short dependent scaling operations. */

			if (gr_info->window_switching_flag && (
    8be9:	83 f8 02             	cmp    $0x2,%eax
    8bec:	75 0a                	jne    8bf8 <III_dequantize_sample+0x3e5>
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    8bee:	8b 45 14             	mov    0x14(%ebp),%eax
    8bf1:	8b 40 18             	mov    0x18(%eax),%eax
    8bf4:	85 c0                	test   %eax,%eax
    8bf6:	74 27                	je     8c1f <III_dequantize_sample+0x40c>
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {
    8bf8:	8b 45 14             	mov    0x14(%ebp),%eax
    8bfb:	8b 40 14             	mov    0x14(%eax),%eax
			xr[sb][ss] = pow( 2.0 , (0.25 * (gr_info->global_gain - 210.0)));

			/* Do long/short dependent scaling operations. */

			if (gr_info->window_switching_flag && (
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    8bfe:	83 f8 02             	cmp    $0x2,%eax
    8c01:	0f 85 62 01 00 00    	jne    8d69 <III_dequantize_sample+0x556>
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {
    8c07:	8b 45 14             	mov    0x14(%ebp),%eax
    8c0a:	8b 40 18             	mov    0x18(%eax),%eax
    8c0d:	85 c0                	test   %eax,%eax
    8c0f:	0f 84 54 01 00 00    	je     8d69 <III_dequantize_sample+0x556>
    8c15:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    8c19:	0f 8e 4a 01 00 00    	jle    8d69 <III_dequantize_sample+0x556>

				xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
    8c1f:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8c22:	89 d0                	mov    %edx,%eax
    8c24:	c1 e0 03             	shl    $0x3,%eax
    8c27:	01 d0                	add    %edx,%eax
    8c29:	c1 e0 04             	shl    $0x4,%eax
    8c2c:	89 c2                	mov    %eax,%edx
    8c2e:	8b 45 0c             	mov    0xc(%ebp),%eax
    8c31:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8c34:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8c37:	89 d0                	mov    %edx,%eax
    8c39:	c1 e0 03             	shl    $0x3,%eax
    8c3c:	01 d0                	add    %edx,%eax
    8c3e:	c1 e0 04             	shl    $0x4,%eax
    8c41:	89 c2                	mov    %eax,%edx
    8c43:	8b 45 0c             	mov    0xc(%ebp),%eax
    8c46:	01 c2                	add    %eax,%edx
    8c48:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8c4b:	dd 04 c2             	fldl   (%edx,%eax,8)
    8c4e:	dd 5d c0             	fstpl  -0x40(%ebp)
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
    8c51:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8c54:	89 d0                	mov    %edx,%eax
    8c56:	c1 e0 03             	shl    $0x3,%eax
    8c59:	01 d0                	add    %edx,%eax
    8c5b:	01 c0                	add    %eax,%eax
    8c5d:	89 c2                	mov    %eax,%edx
    8c5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8c62:	01 d0                	add    %edx,%eax
    8c64:	2b 45 e4             	sub    -0x1c(%ebp),%eax
    8c67:	99                   	cltd   
    8c68:	f7 7d e0             	idivl  -0x20(%ebp)
    8c6b:	89 c2                	mov    %eax,%edx
    8c6d:	8b 45 14             	mov    0x14(%ebp),%eax
    8c70:	83 c2 08             	add    $0x8,%edx
    8c73:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax

			if (gr_info->window_switching_flag && (
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {

				xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
    8c77:	ba 00 00 00 00       	mov    $0x0,%edx
    8c7c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    8c7f:	89 55 cc             	mov    %edx,-0x34(%ebp)
    8c82:	df 6d c8             	fildll -0x38(%ebp)
    8c85:	dd 05 48 da 00 00    	fldl   0xda48
    8c8b:	de c9                	fmulp  %st,%st(1)
    8c8d:	dd 5c 24 08          	fstpl  0x8(%esp)
    8c91:	dd 05 40 da 00 00    	fldl   0xda40
    8c97:	dd 1c 24             	fstpl  (%esp)
    8c9a:	e8 3c c0 ff ff       	call   4cdb <pow>
    8c9f:	dc 4d c0             	fmull  -0x40(%ebp)
    8ca2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8ca5:	dd 1c c3             	fstpl  (%ebx,%eax,8)
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
				xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0+gr_info->scalefac_scale)
    8ca8:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8cab:	89 d0                	mov    %edx,%eax
    8cad:	c1 e0 03             	shl    $0x3,%eax
    8cb0:	01 d0                	add    %edx,%eax
    8cb2:	c1 e0 04             	shl    $0x4,%eax
    8cb5:	89 c2                	mov    %eax,%edx
    8cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
    8cba:	8d 34 02             	lea    (%edx,%eax,1),%esi
    8cbd:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8cc0:	89 d0                	mov    %edx,%eax
    8cc2:	c1 e0 03             	shl    $0x3,%eax
    8cc5:	01 d0                	add    %edx,%eax
    8cc7:	c1 e0 04             	shl    $0x4,%eax
    8cca:	89 c2                	mov    %eax,%edx
    8ccc:	8b 45 0c             	mov    0xc(%ebp),%eax
    8ccf:	01 c2                	add    %eax,%edx
    8cd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8cd4:	dd 04 c2             	fldl   (%edx,%eax,8)
    8cd7:	dd 5d c0             	fstpl  -0x40(%ebp)
    8cda:	8b 45 14             	mov    0x14(%ebp),%eax
    8cdd:	8b 40 40             	mov    0x40(%eax),%eax
    8ce0:	ba 00 00 00 00       	mov    $0x0,%edx
    8ce5:	89 45 c8             	mov    %eax,-0x38(%ebp)
    8ce8:	89 55 cc             	mov    %edx,-0x34(%ebp)
    8ceb:	df 6d c8             	fildll -0x38(%ebp)
    8cee:	d9 e8                	fld1   
    8cf0:	de c1                	faddp  %st,%st(1)
    8cf2:	dd 05 50 da 00 00    	fldl   0xda50
    8cf8:	de c9                	fmulp  %st,%st(1)
						* (*scalefac)[ch].s[(((sb*18)+ss) - cb_begin)/cb_width][cb]);
    8cfa:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8cfd:	89 d0                	mov    %edx,%eax
    8cff:	c1 e0 03             	shl    $0x3,%eax
    8d02:	01 d0                	add    %edx,%eax
    8d04:	01 c0                	add    %eax,%eax
    8d06:	89 c2                	mov    %eax,%edx
    8d08:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8d0b:	01 d0                	add    %edx,%eax
    8d0d:	2b 45 e4             	sub    -0x1c(%ebp),%eax
    8d10:	99                   	cltd   
    8d11:	f7 7d e0             	idivl  -0x20(%ebp)
    8d14:	89 c2                	mov    %eax,%edx
    8d16:	8b 5d 10             	mov    0x10(%ebp),%ebx
    8d19:	8b 4d 18             	mov    0x18(%ebp),%ecx
    8d1c:	89 d0                	mov    %edx,%eax
    8d1e:	01 c0                	add    %eax,%eax
    8d20:	01 d0                	add    %edx,%eax
    8d22:	c1 e0 02             	shl    $0x2,%eax
    8d25:	01 d0                	add    %edx,%eax
    8d27:	89 ca                	mov    %ecx,%edx
    8d29:	01 d2                	add    %edx,%edx
    8d2b:	89 d1                	mov    %edx,%ecx
    8d2d:	c1 e1 05             	shl    $0x5,%ecx
    8d30:	29 d1                	sub    %edx,%ecx
    8d32:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    8d35:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8d38:	01 d0                	add    %edx,%eax
    8d3a:	83 c0 14             	add    $0x14,%eax
    8d3d:	8b 44 83 0c          	mov    0xc(%ebx,%eax,4),%eax
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {

				xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
				xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0+gr_info->scalefac_scale)
    8d41:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    8d44:	db 45 d4             	fildl  -0x2c(%ebp)
    8d47:	de c9                	fmulp  %st,%st(1)
    8d49:	dd 5c 24 08          	fstpl  0x8(%esp)
    8d4d:	dd 05 40 da 00 00    	fldl   0xda40
    8d53:	dd 1c 24             	fstpl  (%esp)
    8d56:	e8 80 bf ff ff       	call   4cdb <pow>
    8d5b:	dc 4d c0             	fmull  -0x40(%ebp)
    8d5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8d61:	dd 1c c6             	fstpl  (%esi,%eax,8)
    8d64:	e9 ab 00 00 00       	jmp    8e14 <III_dequantize_sample+0x601>
						* (*scalefac)[ch].s[(((sb*18)+ss) - cb_begin)/cb_width][cb]);
			}
			else {   /* LONG block types 0,1,3 & 1st 2 subbands of switched blocks */
				xr[sb][ss] *= pow(2.0, -0.5 * (1.0+gr_info->scalefac_scale)
    8d69:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8d6c:	89 d0                	mov    %edx,%eax
    8d6e:	c1 e0 03             	shl    $0x3,%eax
    8d71:	01 d0                	add    %edx,%eax
    8d73:	c1 e0 04             	shl    $0x4,%eax
    8d76:	89 c2                	mov    %eax,%edx
    8d78:	8b 45 0c             	mov    0xc(%ebp),%eax
    8d7b:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8d7e:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8d81:	89 d0                	mov    %edx,%eax
    8d83:	c1 e0 03             	shl    $0x3,%eax
    8d86:	01 d0                	add    %edx,%eax
    8d88:	c1 e0 04             	shl    $0x4,%eax
    8d8b:	89 c2                	mov    %eax,%edx
    8d8d:	8b 45 0c             	mov    0xc(%ebp),%eax
    8d90:	01 c2                	add    %eax,%edx
    8d92:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8d95:	dd 04 c2             	fldl   (%edx,%eax,8)
    8d98:	dd 5d c0             	fstpl  -0x40(%ebp)
    8d9b:	8b 45 14             	mov    0x14(%ebp),%eax
    8d9e:	8b 40 40             	mov    0x40(%eax),%eax
    8da1:	ba 00 00 00 00       	mov    $0x0,%edx
    8da6:	89 45 c8             	mov    %eax,-0x38(%ebp)
    8da9:	89 55 cc             	mov    %edx,-0x34(%ebp)
    8dac:	df 6d c8             	fildll -0x38(%ebp)
    8daf:	d9 e8                	fld1   
    8db1:	de c1                	faddp  %st,%st(1)
    8db3:	dd 05 50 da 00 00    	fldl   0xda50
    8db9:	de c9                	fmulp  %st,%st(1)
								* ((*scalefac)[ch].l[cb]
    8dbb:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8dbe:	8b 45 18             	mov    0x18(%ebp),%eax
    8dc1:	01 c0                	add    %eax,%eax
    8dc3:	89 c2                	mov    %eax,%edx
    8dc5:	c1 e2 05             	shl    $0x5,%edx
    8dc8:	29 c2                	sub    %eax,%edx
    8dca:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8dcd:	01 d0                	add    %edx,%eax
    8dcf:	8b 04 81             	mov    (%ecx,%eax,4),%eax
								+ gr_info->preflag * pretab[cb]));
    8dd2:	89 c2                	mov    %eax,%edx
    8dd4:	8b 45 14             	mov    0x14(%ebp),%eax
    8dd7:	8b 48 3c             	mov    0x3c(%eax),%ecx
    8dda:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8ddd:	8b 04 85 e0 ee 00 00 	mov    0xeee0(,%eax,4),%eax
    8de4:	0f af c1             	imul   %ecx,%eax
    8de7:	01 d0                	add    %edx,%eax
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
				xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0+gr_info->scalefac_scale)
						* (*scalefac)[ch].s[(((sb*18)+ss) - cb_begin)/cb_width][cb]);
			}
			else {   /* LONG block types 0,1,3 & 1st 2 subbands of switched blocks */
				xr[sb][ss] *= pow(2.0, -0.5 * (1.0+gr_info->scalefac_scale)
    8de9:	ba 00 00 00 00       	mov    $0x0,%edx
    8dee:	89 45 c8             	mov    %eax,-0x38(%ebp)
    8df1:	89 55 cc             	mov    %edx,-0x34(%ebp)
    8df4:	df 6d c8             	fildll -0x38(%ebp)
    8df7:	de c9                	fmulp  %st,%st(1)
    8df9:	dd 5c 24 08          	fstpl  0x8(%esp)
    8dfd:	dd 05 40 da 00 00    	fldl   0xda40
    8e03:	dd 1c 24             	fstpl  (%esp)
    8e06:	e8 d0 be ff ff       	call   4cdb <pow>
    8e0b:	dc 4d c0             	fmull  -0x40(%ebp)
    8e0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8e11:	dd 1c c3             	fstpl  (%ebx,%eax,8)
								+ gr_info->preflag * pretab[cb]));
			}

			/* Scale quantized value. */

			sign = (is[sb][ss]<0) ? 1 : 0;
    8e14:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8e17:	89 d0                	mov    %edx,%eax
    8e19:	c1 e0 03             	shl    $0x3,%eax
    8e1c:	01 d0                	add    %edx,%eax
    8e1e:	c1 e0 03             	shl    $0x3,%eax
    8e21:	89 c2                	mov    %eax,%edx
    8e23:	8b 45 08             	mov    0x8(%ebp),%eax
    8e26:	01 c2                	add    %eax,%edx
    8e28:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8e2b:	8b 04 82             	mov    (%edx,%eax,4),%eax
    8e2e:	c1 e8 1f             	shr    $0x1f,%eax
    8e31:	0f b6 c0             	movzbl %al,%eax
    8e34:	89 45 d8             	mov    %eax,-0x28(%ebp)
			xr[sb][ss] *= pow( (double) abs(is[sb][ss]), ((double)4.0/3.0) );
    8e37:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8e3a:	89 d0                	mov    %edx,%eax
    8e3c:	c1 e0 03             	shl    $0x3,%eax
    8e3f:	01 d0                	add    %edx,%eax
    8e41:	c1 e0 04             	shl    $0x4,%eax
    8e44:	89 c2                	mov    %eax,%edx
    8e46:	8b 45 0c             	mov    0xc(%ebp),%eax
    8e49:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8e4c:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8e4f:	89 d0                	mov    %edx,%eax
    8e51:	c1 e0 03             	shl    $0x3,%eax
    8e54:	01 d0                	add    %edx,%eax
    8e56:	c1 e0 04             	shl    $0x4,%eax
    8e59:	89 c2                	mov    %eax,%edx
    8e5b:	8b 45 0c             	mov    0xc(%ebp),%eax
    8e5e:	01 c2                	add    %eax,%edx
    8e60:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8e63:	dd 04 c2             	fldl   (%edx,%eax,8)
    8e66:	dd 5d c0             	fstpl  -0x40(%ebp)
    8e69:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8e6c:	89 d0                	mov    %edx,%eax
    8e6e:	c1 e0 03             	shl    $0x3,%eax
    8e71:	01 d0                	add    %edx,%eax
    8e73:	c1 e0 03             	shl    $0x3,%eax
    8e76:	89 c2                	mov    %eax,%edx
    8e78:	8b 45 08             	mov    0x8(%ebp),%eax
    8e7b:	01 c2                	add    %eax,%edx
    8e7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8e80:	8b 04 82             	mov    (%edx,%eax,4),%eax
    8e83:	89 04 24             	mov    %eax,(%esp)
    8e86:	e8 47 bd ff ff       	call   4bd2 <abs>
    8e8b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    8e8e:	db 45 d4             	fildl  -0x2c(%ebp)
    8e91:	dd 05 58 da 00 00    	fldl   0xda58
    8e97:	dd 5c 24 08          	fstpl  0x8(%esp)
    8e9b:	dd 1c 24             	fstpl  (%esp)
    8e9e:	e8 38 be ff ff       	call   4cdb <pow>
    8ea3:	dc 4d c0             	fmull  -0x40(%ebp)
    8ea6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8ea9:	dd 1c c3             	fstpl  (%ebx,%eax,8)
			if (sign) xr[sb][ss] = -xr[sb][ss];
    8eac:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    8eb0:	74 37                	je     8ee9 <III_dequantize_sample+0x6d6>
    8eb2:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8eb5:	89 d0                	mov    %edx,%eax
    8eb7:	c1 e0 03             	shl    $0x3,%eax
    8eba:	01 d0                	add    %edx,%eax
    8ebc:	c1 e0 04             	shl    $0x4,%eax
    8ebf:	89 c2                	mov    %eax,%edx
    8ec1:	8b 45 0c             	mov    0xc(%ebp),%eax
    8ec4:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    8ec7:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8eca:	89 d0                	mov    %edx,%eax
    8ecc:	c1 e0 03             	shl    $0x3,%eax
    8ecf:	01 d0                	add    %edx,%eax
    8ed1:	c1 e0 04             	shl    $0x4,%eax
    8ed4:	89 c2                	mov    %eax,%edx
    8ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
    8ed9:	01 c2                	add    %eax,%edx
    8edb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8ede:	dd 04 c2             	fldl   (%edx,%eax,8)
    8ee1:	d9 e0                	fchs   
    8ee3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8ee6:	dd 1c c1             	fstpl  (%ecx,%eax,8)
	else
		next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */

	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
    8ee9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8eed:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    8ef1:	0f 8e d3 f9 ff ff    	jle    88ca <III_dequantize_sample+0xb7>
		}
	else
		next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */

	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
    8ef7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    8efb:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    8eff:	0f 8e b9 f9 ff ff    	jle    88be <III_dequantize_sample+0xab>
			sign = (is[sb][ss]<0) ? 1 : 0;
			xr[sb][ss] *= pow( (double) abs(is[sb][ss]), ((double)4.0/3.0) );
			if (sign) xr[sb][ss] = -xr[sb][ss];
		}
	}
}
    8f05:	83 c4 50             	add    $0x50,%esp
    8f08:	5b                   	pop    %ebx
    8f09:	5e                   	pop    %esi
    8f0a:	5d                   	pop    %ebp
    8f0b:	c3                   	ret    

00008f0c <III_reorder>:


void III_reorder(double xr[SBLIMIT][SSLIMIT], double ro[SBLIMIT][SSLIMIT], struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
    8f0c:	55                   	push   %ebp
    8f0d:	89 e5                	mov    %esp,%ebp
    8f0f:	57                   	push   %edi
    8f10:	56                   	push   %esi
    8f11:	53                   	push   %ebx
    8f12:	83 ec 34             	sub    $0x34,%esp
   int sfreq=fr_ps->header->sampling_frequency;
    8f15:	8b 45 14             	mov    0x14(%ebp),%eax
    8f18:	8b 00                	mov    (%eax),%eax
    8f1a:	8b 40 10             	mov    0x10(%eax),%eax
    8f1d:	89 45 d0             	mov    %eax,-0x30(%ebp)
   int sfb, sfb_start, sfb_lines;
   int sb, ss, window, freq, src_line, des_line;

   for(sb=0;sb<SBLIMIT;sb++)
    8f20:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    8f27:	eb 33                	jmp    8f5c <III_reorder+0x50>
      for(ss=0;ss<SSLIMIT;ss++)
    8f29:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    8f30:	eb 20                	jmp    8f52 <III_reorder+0x46>
         ro[sb][ss] = 0;
    8f32:	8b 55 e0             	mov    -0x20(%ebp),%edx
    8f35:	89 d0                	mov    %edx,%eax
    8f37:	c1 e0 03             	shl    $0x3,%eax
    8f3a:	01 d0                	add    %edx,%eax
    8f3c:	c1 e0 04             	shl    $0x4,%eax
    8f3f:	89 c2                	mov    %eax,%edx
    8f41:	8b 45 0c             	mov    0xc(%ebp),%eax
    8f44:	01 c2                	add    %eax,%edx
    8f46:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8f49:	d9 ee                	fldz   
    8f4b:	dd 1c c2             	fstpl  (%edx,%eax,8)
   int sfreq=fr_ps->header->sampling_frequency;
   int sfb, sfb_start, sfb_lines;
   int sb, ss, window, freq, src_line, des_line;

   for(sb=0;sb<SBLIMIT;sb++)
      for(ss=0;ss<SSLIMIT;ss++)
    8f4e:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    8f52:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    8f56:	7e da                	jle    8f32 <III_reorder+0x26>
{
   int sfreq=fr_ps->header->sampling_frequency;
   int sfb, sfb_start, sfb_lines;
   int sb, ss, window, freq, src_line, des_line;

   for(sb=0;sb<SBLIMIT;sb++)
    8f58:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    8f5c:	83 7d e0 1f          	cmpl   $0x1f,-0x20(%ebp)
    8f60:	7e c7                	jle    8f29 <III_reorder+0x1d>
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    8f62:	8b 45 10             	mov    0x10(%ebp),%eax
    8f65:	8b 40 10             	mov    0x10(%eax),%eax
    8f68:	85 c0                	test   %eax,%eax
    8f6a:	0f 84 af 03 00 00    	je     931f <III_reorder+0x413>
    8f70:	8b 45 10             	mov    0x10(%ebp),%eax
    8f73:	8b 40 14             	mov    0x14(%eax),%eax
    8f76:	83 f8 02             	cmp    $0x2,%eax
    8f79:	0f 85 a0 03 00 00    	jne    931f <III_reorder+0x413>
      if (gr_info->mixed_block_flag) {
    8f7f:	8b 45 10             	mov    0x10(%ebp),%eax
    8f82:	8b 40 18             	mov    0x18(%eax),%eax
    8f85:	85 c0                	test   %eax,%eax
    8f87:	0f 84 00 02 00 00    	je     918d <III_reorder+0x281>
         for (sb=0 ; sb < 2 ; sb++)
    8f8d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    8f94:	eb 4c                	jmp    8fe2 <III_reorder+0xd6>
            for (ss=0 ; ss < SSLIMIT ; ss++) {
    8f96:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    8f9d:	eb 39                	jmp    8fd8 <III_reorder+0xcc>
               ro[sb][ss] = xr[sb][ss];
    8f9f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    8fa2:	89 d0                	mov    %edx,%eax
    8fa4:	c1 e0 03             	shl    $0x3,%eax
    8fa7:	01 d0                	add    %edx,%eax
    8fa9:	c1 e0 04             	shl    $0x4,%eax
    8fac:	89 c2                	mov    %eax,%edx
    8fae:	8b 45 0c             	mov    0xc(%ebp),%eax
    8fb1:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    8fb4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    8fb7:	89 d0                	mov    %edx,%eax
    8fb9:	c1 e0 03             	shl    $0x3,%eax
    8fbc:	01 d0                	add    %edx,%eax
    8fbe:	c1 e0 04             	shl    $0x4,%eax
    8fc1:	89 c2                	mov    %eax,%edx
    8fc3:	8b 45 08             	mov    0x8(%ebp),%eax
    8fc6:	01 c2                	add    %eax,%edx
    8fc8:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8fcb:	dd 04 c2             	fldl   (%edx,%eax,8)
    8fce:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8fd1:	dd 1c c1             	fstpl  (%ecx,%eax,8)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
            for (ss=0 ; ss < SSLIMIT ; ss++) {
    8fd4:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    8fd8:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    8fdc:	7e c1                	jle    8f9f <III_reorder+0x93>
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
    8fde:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    8fe2:	83 7d e0 01          	cmpl   $0x1,-0x20(%ebp)
    8fe6:	7e ae                	jle    8f96 <III_reorder+0x8a>
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
    8fe8:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
    8fef:	8b 45 d0             	mov    -0x30(%ebp),%eax
    8ff2:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8ff8:	05 7c ed 00 00       	add    $0xed7c,%eax
    8ffd:	8b 40 0c             	mov    0xc(%eax),%eax
    9000:	89 45 e8             	mov    %eax,-0x18(%ebp)
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
    9003:	8b 45 d0             	mov    -0x30(%ebp),%eax
    9006:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    900c:	05 80 ed 00 00       	add    $0xed80,%eax
    9011:	8b 40 0c             	mov    0xc(%eax),%eax
    9014:	2b 45 e8             	sub    -0x18(%ebp),%eax
    9017:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
    901a:	e9 5f 01 00 00       	jmp    917e <III_reorder+0x272>
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    901f:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    9026:	e9 fd 00 00 00       	jmp    9128 <III_reorder+0x21c>
                  for(freq=0;freq<sfb_lines;freq++) {
    902b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    9032:	e9 e1 00 00 00       	jmp    9118 <III_reorder+0x20c>
                     src_line = sfb_start*3 + window*sfb_lines + freq;
    9037:	8b 55 e8             	mov    -0x18(%ebp),%edx
    903a:	89 d0                	mov    %edx,%eax
    903c:	01 c0                	add    %eax,%eax
    903e:	01 c2                	add    %eax,%edx
    9040:	8b 45 d8             	mov    -0x28(%ebp),%eax
    9043:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    9047:	01 c2                	add    %eax,%edx
    9049:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    904c:	01 d0                	add    %edx,%eax
    904e:	89 45 cc             	mov    %eax,-0x34(%ebp)
                     des_line = (sfb_start*3) + window + (freq*3);
    9051:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9054:	89 d0                	mov    %edx,%eax
    9056:	01 c0                	add    %eax,%eax
    9058:	01 c2                	add    %eax,%edx
    905a:	8b 45 d8             	mov    -0x28(%ebp),%eax
    905d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    9060:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    9063:	89 d0                	mov    %edx,%eax
    9065:	01 c0                	add    %eax,%eax
    9067:	01 d0                	add    %edx,%eax
    9069:	01 c8                	add    %ecx,%eax
    906b:	89 45 c8             	mov    %eax,-0x38(%ebp)
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    906e:	8b 4d c8             	mov    -0x38(%ebp),%ecx
    9071:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    9076:	89 c8                	mov    %ecx,%eax
    9078:	f7 ea                	imul   %edx
    907a:	c1 fa 02             	sar    $0x2,%edx
    907d:	89 c8                	mov    %ecx,%eax
    907f:	c1 f8 1f             	sar    $0x1f,%eax
    9082:	29 c2                	sub    %eax,%edx
    9084:	89 d0                	mov    %edx,%eax
    9086:	89 c2                	mov    %eax,%edx
    9088:	89 d0                	mov    %edx,%eax
    908a:	c1 e0 03             	shl    $0x3,%eax
    908d:	01 d0                	add    %edx,%eax
    908f:	c1 e0 04             	shl    $0x4,%eax
    9092:	89 c2                	mov    %eax,%edx
    9094:	8b 45 0c             	mov    0xc(%ebp),%eax
    9097:	8d 34 02             	lea    (%edx,%eax,1),%esi
    909a:	8b 5d c8             	mov    -0x38(%ebp),%ebx
    909d:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    90a2:	89 d8                	mov    %ebx,%eax
    90a4:	f7 ea                	imul   %edx
    90a6:	c1 fa 02             	sar    $0x2,%edx
    90a9:	89 d8                	mov    %ebx,%eax
    90ab:	c1 f8 1f             	sar    $0x1f,%eax
    90ae:	89 d1                	mov    %edx,%ecx
    90b0:	29 c1                	sub    %eax,%ecx
    90b2:	89 c8                	mov    %ecx,%eax
    90b4:	c1 e0 03             	shl    $0x3,%eax
    90b7:	01 c8                	add    %ecx,%eax
    90b9:	01 c0                	add    %eax,%eax
    90bb:	29 c3                	sub    %eax,%ebx
    90bd:	89 d9                	mov    %ebx,%ecx
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
    90bf:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    90c2:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    90c7:	89 d8                	mov    %ebx,%eax
    90c9:	f7 ea                	imul   %edx
    90cb:	c1 fa 02             	sar    $0x2,%edx
    90ce:	89 d8                	mov    %ebx,%eax
    90d0:	c1 f8 1f             	sar    $0x1f,%eax
    90d3:	29 c2                	sub    %eax,%edx
    90d5:	89 d0                	mov    %edx,%eax
    90d7:	89 c2                	mov    %eax,%edx
    90d9:	89 d0                	mov    %edx,%eax
    90db:	c1 e0 03             	shl    $0x3,%eax
    90de:	01 d0                	add    %edx,%eax
    90e0:	c1 e0 04             	shl    $0x4,%eax
    90e3:	89 c2                	mov    %eax,%edx
    90e5:	8b 45 08             	mov    0x8(%ebp),%eax
    90e8:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    90eb:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    90ee:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    90f3:	89 d8                	mov    %ebx,%eax
    90f5:	f7 ea                	imul   %edx
    90f7:	c1 fa 02             	sar    $0x2,%edx
    90fa:	89 d8                	mov    %ebx,%eax
    90fc:	c1 f8 1f             	sar    $0x1f,%eax
    90ff:	29 c2                	sub    %eax,%edx
    9101:	89 d0                	mov    %edx,%eax
    9103:	c1 e0 03             	shl    $0x3,%eax
    9106:	01 d0                	add    %edx,%eax
    9108:	01 c0                	add    %eax,%eax
    910a:	29 c3                	sub    %eax,%ebx
    910c:	89 da                	mov    %ebx,%edx
    910e:	dd 04 d7             	fldl   (%edi,%edx,8)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
                     src_line = sfb_start*3 + window*sfb_lines + freq;
                     des_line = (sfb_start*3) + window + (freq*3);
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    9111:	dd 1c ce             	fstpl  (%esi,%ecx,8)
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
    9114:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    9118:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    911b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    911e:	0f 8c 13 ff ff ff    	jl     9037 <III_reorder+0x12b>
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    9124:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    9128:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
    912c:	0f 8e f9 fe ff ff    	jle    902b <III_reorder+0x11f>
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
    9132:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    9136:	8b 55 d0             	mov    -0x30(%ebp),%edx
    9139:	89 d0                	mov    %edx,%eax
    913b:	c1 e0 03             	shl    $0x3,%eax
    913e:	01 d0                	add    %edx,%eax
    9140:	c1 e0 02             	shl    $0x2,%eax
    9143:	01 d0                	add    %edx,%eax
    9145:	8b 55 ec             	mov    -0x14(%ebp),%edx
    9148:	01 d0                	add    %edx,%eax
    914a:	83 c0 14             	add    $0x14,%eax
    914d:	8b 04 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%eax
    9154:	89 45 e8             	mov    %eax,-0x18(%ebp)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
    9157:	8b 45 ec             	mov    -0x14(%ebp),%eax
    915a:	8d 48 01             	lea    0x1(%eax),%ecx
    915d:	8b 55 d0             	mov    -0x30(%ebp),%edx
    9160:	89 d0                	mov    %edx,%eax
    9162:	c1 e0 03             	shl    $0x3,%eax
    9165:	01 d0                	add    %edx,%eax
    9167:	c1 e0 02             	shl    $0x2,%eax
    916a:	01 d0                	add    %edx,%eax
    916c:	01 c8                	add    %ecx,%eax
    916e:	83 c0 14             	add    $0x14,%eax
    9171:	8b 04 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%eax
    9178:	2b 45 e8             	sub    -0x18(%ebp),%eax
    917b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
    917e:	83 7d ec 0c          	cmpl   $0xc,-0x14(%ebp)
    9182:	0f 8e 97 fe ff ff    	jle    901f <III_reorder+0x113>
   for(sb=0;sb<SBLIMIT;sb++)
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
    9188:	e9 ed 01 00 00       	jmp    937a <III_reorder+0x46e>
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
    918d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    9194:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    919b:	8b 45 d0             	mov    -0x30(%ebp),%eax
    919e:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    91a4:	05 74 ed 00 00       	add    $0xed74,%eax
    91a9:	8b 40 0c             	mov    0xc(%eax),%eax
    91ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    91af:	e9 5f 01 00 00       	jmp    9313 <III_reorder+0x407>
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    91b4:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    91bb:	e9 fd 00 00 00       	jmp    92bd <III_reorder+0x3b1>
                  for(freq=0;freq<sfb_lines;freq++) {
    91c0:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    91c7:	e9 e1 00 00 00       	jmp    92ad <III_reorder+0x3a1>
                     src_line = sfb_start*3 + window*sfb_lines + freq;
    91cc:	8b 55 e8             	mov    -0x18(%ebp),%edx
    91cf:	89 d0                	mov    %edx,%eax
    91d1:	01 c0                	add    %eax,%eax
    91d3:	01 c2                	add    %eax,%edx
    91d5:	8b 45 d8             	mov    -0x28(%ebp),%eax
    91d8:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    91dc:	01 c2                	add    %eax,%edx
    91de:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    91e1:	01 d0                	add    %edx,%eax
    91e3:	89 45 cc             	mov    %eax,-0x34(%ebp)
                     des_line = (sfb_start*3) + window + (freq*3);
    91e6:	8b 55 e8             	mov    -0x18(%ebp),%edx
    91e9:	89 d0                	mov    %edx,%eax
    91eb:	01 c0                	add    %eax,%eax
    91ed:	01 c2                	add    %eax,%edx
    91ef:	8b 45 d8             	mov    -0x28(%ebp),%eax
    91f2:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    91f5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    91f8:	89 d0                	mov    %edx,%eax
    91fa:	01 c0                	add    %eax,%eax
    91fc:	01 d0                	add    %edx,%eax
    91fe:	01 c8                	add    %ecx,%eax
    9200:	89 45 c8             	mov    %eax,-0x38(%ebp)
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    9203:	8b 4d c8             	mov    -0x38(%ebp),%ecx
    9206:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    920b:	89 c8                	mov    %ecx,%eax
    920d:	f7 ea                	imul   %edx
    920f:	c1 fa 02             	sar    $0x2,%edx
    9212:	89 c8                	mov    %ecx,%eax
    9214:	c1 f8 1f             	sar    $0x1f,%eax
    9217:	29 c2                	sub    %eax,%edx
    9219:	89 d0                	mov    %edx,%eax
    921b:	89 c2                	mov    %eax,%edx
    921d:	89 d0                	mov    %edx,%eax
    921f:	c1 e0 03             	shl    $0x3,%eax
    9222:	01 d0                	add    %edx,%eax
    9224:	c1 e0 04             	shl    $0x4,%eax
    9227:	89 c2                	mov    %eax,%edx
    9229:	8b 45 0c             	mov    0xc(%ebp),%eax
    922c:	8d 34 02             	lea    (%edx,%eax,1),%esi
    922f:	8b 5d c8             	mov    -0x38(%ebp),%ebx
    9232:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    9237:	89 d8                	mov    %ebx,%eax
    9239:	f7 ea                	imul   %edx
    923b:	c1 fa 02             	sar    $0x2,%edx
    923e:	89 d8                	mov    %ebx,%eax
    9240:	c1 f8 1f             	sar    $0x1f,%eax
    9243:	89 d1                	mov    %edx,%ecx
    9245:	29 c1                	sub    %eax,%ecx
    9247:	89 c8                	mov    %ecx,%eax
    9249:	c1 e0 03             	shl    $0x3,%eax
    924c:	01 c8                	add    %ecx,%eax
    924e:	01 c0                	add    %eax,%eax
    9250:	29 c3                	sub    %eax,%ebx
    9252:	89 d9                	mov    %ebx,%ecx
                       xr[src_line/SSLIMIT][src_line%SSLIMIT];
    9254:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    9257:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    925c:	89 d8                	mov    %ebx,%eax
    925e:	f7 ea                	imul   %edx
    9260:	c1 fa 02             	sar    $0x2,%edx
    9263:	89 d8                	mov    %ebx,%eax
    9265:	c1 f8 1f             	sar    $0x1f,%eax
    9268:	29 c2                	sub    %eax,%edx
    926a:	89 d0                	mov    %edx,%eax
    926c:	89 c2                	mov    %eax,%edx
    926e:	89 d0                	mov    %edx,%eax
    9270:	c1 e0 03             	shl    $0x3,%eax
    9273:	01 d0                	add    %edx,%eax
    9275:	c1 e0 04             	shl    $0x4,%eax
    9278:	89 c2                	mov    %eax,%edx
    927a:	8b 45 08             	mov    0x8(%ebp),%eax
    927d:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    9280:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    9283:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    9288:	89 d8                	mov    %ebx,%eax
    928a:	f7 ea                	imul   %edx
    928c:	c1 fa 02             	sar    $0x2,%edx
    928f:	89 d8                	mov    %ebx,%eax
    9291:	c1 f8 1f             	sar    $0x1f,%eax
    9294:	29 c2                	sub    %eax,%edx
    9296:	89 d0                	mov    %edx,%eax
    9298:	c1 e0 03             	shl    $0x3,%eax
    929b:	01 d0                	add    %edx,%eax
    929d:	01 c0                	add    %eax,%eax
    929f:	29 c3                	sub    %eax,%ebx
    92a1:	89 da                	mov    %ebx,%edx
    92a3:	dd 04 d7             	fldl   (%edi,%edx,8)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
                     src_line = sfb_start*3 + window*sfb_lines + freq;
                     des_line = (sfb_start*3) + window + (freq*3);
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    92a6:	dd 1c ce             	fstpl  (%esi,%ecx,8)
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
    92a9:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    92ad:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    92b0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    92b3:	0f 8c 13 ff ff ff    	jl     91cc <III_reorder+0x2c0>
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    92b9:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    92bd:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
    92c1:	0f 8e f9 fe ff ff    	jle    91c0 <III_reorder+0x2b4>
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
    92c7:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    92cb:	8b 55 d0             	mov    -0x30(%ebp),%edx
    92ce:	89 d0                	mov    %edx,%eax
    92d0:	c1 e0 03             	shl    $0x3,%eax
    92d3:	01 d0                	add    %edx,%eax
    92d5:	c1 e0 02             	shl    $0x2,%eax
    92d8:	01 d0                	add    %edx,%eax
    92da:	8b 55 ec             	mov    -0x14(%ebp),%edx
    92dd:	01 d0                	add    %edx,%eax
    92df:	83 c0 14             	add    $0x14,%eax
    92e2:	8b 04 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%eax
    92e9:	89 45 e8             	mov    %eax,-0x18(%ebp)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
    92ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
    92ef:	8d 48 01             	lea    0x1(%eax),%ecx
    92f2:	8b 55 d0             	mov    -0x30(%ebp),%edx
    92f5:	89 d0                	mov    %edx,%eax
    92f7:	c1 e0 03             	shl    $0x3,%eax
    92fa:	01 d0                	add    %edx,%eax
    92fc:	c1 e0 02             	shl    $0x2,%eax
    92ff:	01 d0                	add    %edx,%eax
    9301:	01 c8                	add    %ecx,%eax
    9303:	83 c0 14             	add    $0x14,%eax
    9306:	8b 04 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%eax
    930d:	2b 45 e8             	sub    -0x18(%ebp),%eax
    9310:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
    9313:	83 7d ec 0c          	cmpl   $0xc,-0x14(%ebp)
    9317:	0f 8e 97 fe ff ff    	jle    91b4 <III_reorder+0x2a8>
   for(sb=0;sb<SBLIMIT;sb++)
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
    931d:	eb 5b                	jmp    937a <III_reorder+0x46e>
                       xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
   }
   else {   /*long blocks */
      for (sb=0 ; sb < SBLIMIT ; sb++)
    931f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    9326:	eb 4c                	jmp    9374 <III_reorder+0x468>
         for (ss=0 ; ss < SSLIMIT ; ss++)
    9328:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    932f:	eb 39                	jmp    936a <III_reorder+0x45e>
            ro[sb][ss] = xr[sb][ss];
    9331:	8b 55 e0             	mov    -0x20(%ebp),%edx
    9334:	89 d0                	mov    %edx,%eax
    9336:	c1 e0 03             	shl    $0x3,%eax
    9339:	01 d0                	add    %edx,%eax
    933b:	c1 e0 04             	shl    $0x4,%eax
    933e:	89 c2                	mov    %eax,%edx
    9340:	8b 45 0c             	mov    0xc(%ebp),%eax
    9343:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    9346:	8b 55 e0             	mov    -0x20(%ebp),%edx
    9349:	89 d0                	mov    %edx,%eax
    934b:	c1 e0 03             	shl    $0x3,%eax
    934e:	01 d0                	add    %edx,%eax
    9350:	c1 e0 04             	shl    $0x4,%eax
    9353:	89 c2                	mov    %eax,%edx
    9355:	8b 45 08             	mov    0x8(%ebp),%eax
    9358:	01 c2                	add    %eax,%edx
    935a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    935d:	dd 04 c2             	fldl   (%edx,%eax,8)
    9360:	8b 45 dc             	mov    -0x24(%ebp),%eax
    9363:	dd 1c c1             	fstpl  (%ecx,%eax,8)
               }
      }
   }
   else {   /*long blocks */
      for (sb=0 ; sb < SBLIMIT ; sb++)
         for (ss=0 ; ss < SSLIMIT ; ss++)
    9366:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    936a:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    936e:	7e c1                	jle    9331 <III_reorder+0x425>
                       xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
   }
   else {   /*long blocks */
      for (sb=0 ; sb < SBLIMIT ; sb++)
    9370:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    9374:	83 7d e0 1f          	cmpl   $0x1f,-0x20(%ebp)
    9378:	7e ae                	jle    9328 <III_reorder+0x41c>
         for (ss=0 ; ss < SSLIMIT ; ss++)
            ro[sb][ss] = xr[sb][ss];
   }
}
    937a:	83 c4 34             	add    $0x34,%esp
    937d:	5b                   	pop    %ebx
    937e:	5e                   	pop    %esi
    937f:	5f                   	pop    %edi
    9380:	5d                   	pop    %ebp
    9381:	c3                   	ret    

00009382 <III_stereo>:


void III_stereo(double xr[2][SBLIMIT][SSLIMIT], double lr[2][SBLIMIT][SSLIMIT], III_scalefac_t *scalefac, struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
    9382:	55                   	push   %ebp
    9383:	89 e5                	mov    %esp,%ebp
    9385:	56                   	push   %esi
    9386:	53                   	push   %ebx
    9387:	81 ec 50 1b 00 00    	sub    $0x1b50,%esp
   int sfreq = fr_ps->header->sampling_frequency;
    938d:	8b 45 18             	mov    0x18(%ebp),%eax
    9390:	8b 00                	mov    (%eax),%eax
    9392:	8b 40 10             	mov    0x10(%eax),%eax
    9395:	89 45 c8             	mov    %eax,-0x38(%ebp)
   int stereo = fr_ps->stereo;
    9398:	8b 45 18             	mov    0x18(%ebp),%eax
    939b:	8b 40 08             	mov    0x8(%eax),%eax
    939e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
   int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    93a1:	8b 45 18             	mov    0x18(%ebp),%eax
    93a4:	8b 00                	mov    (%eax),%eax
    93a6:	8b 40 1c             	mov    0x1c(%eax),%eax
    93a9:	83 f8 01             	cmp    $0x1,%eax
    93ac:	75 16                	jne    93c4 <III_stereo+0x42>
                   (fr_ps->header->mode_ext & 0x2);
    93ae:	8b 45 18             	mov    0x18(%ebp),%eax
    93b1:	8b 00                	mov    (%eax),%eax
    93b3:	8b 40 20             	mov    0x20(%eax),%eax
    93b6:	83 e0 02             	and    $0x2,%eax

void III_stereo(double xr[2][SBLIMIT][SSLIMIT], double lr[2][SBLIMIT][SSLIMIT], III_scalefac_t *scalefac, struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
   int sfreq = fr_ps->header->sampling_frequency;
   int stereo = fr_ps->stereo;
   int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    93b9:	85 c0                	test   %eax,%eax
    93bb:	74 07                	je     93c4 <III_stereo+0x42>
    93bd:	b8 01 00 00 00       	mov    $0x1,%eax
    93c2:	eb 05                	jmp    93c9 <III_stereo+0x47>
    93c4:	b8 00 00 00 00       	mov    $0x0,%eax
    93c9:	89 45 c0             	mov    %eax,-0x40(%ebp)
                   (fr_ps->header->mode_ext & 0x2);
   int i_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    93cc:	8b 45 18             	mov    0x18(%ebp),%eax
    93cf:	8b 00                	mov    (%eax),%eax
    93d1:	8b 40 1c             	mov    0x1c(%eax),%eax
    93d4:	83 f8 01             	cmp    $0x1,%eax
    93d7:	75 16                	jne    93ef <III_stereo+0x6d>
                  (fr_ps->header->mode_ext & 0x1);
    93d9:	8b 45 18             	mov    0x18(%ebp),%eax
    93dc:	8b 00                	mov    (%eax),%eax
    93de:	8b 40 20             	mov    0x20(%eax),%eax
    93e1:	83 e0 01             	and    $0x1,%eax
{
   int sfreq = fr_ps->header->sampling_frequency;
   int stereo = fr_ps->stereo;
   int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
                   (fr_ps->header->mode_ext & 0x2);
   int i_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    93e4:	85 c0                	test   %eax,%eax
    93e6:	74 07                	je     93ef <III_stereo+0x6d>
    93e8:	b8 01 00 00 00       	mov    $0x1,%eax
    93ed:	eb 05                	jmp    93f4 <III_stereo+0x72>
    93ef:	b8 00 00 00 00       	mov    $0x0,%eax
    93f4:	89 45 bc             	mov    %eax,-0x44(%ebp)
   int sfb;
   int i,j,sb,ss,ch,is_pos[576];
   double is_ratio[576];

   /* intialization */
   for ( i=0; i<576; i++ )
    93f7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    93fe:	eb 12                	jmp    9412 <III_stereo+0x90>
      is_pos[i] = 7;
    9400:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9403:	c7 84 85 bc f6 ff ff 	movl   $0x7,-0x944(%ebp,%eax,4)
    940a:	07 00 00 00 
   int sfb;
   int i,j,sb,ss,ch,is_pos[576];
   double is_ratio[576];

   /* intialization */
   for ( i=0; i<576; i++ )
    940e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    9412:	81 7d f0 3f 02 00 00 	cmpl   $0x23f,-0x10(%ebp)
    9419:	7e e5                	jle    9400 <III_stereo+0x7e>
      is_pos[i] = 7;

   if ((stereo == 2) && i_stereo )
    941b:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
    941f:	0f 85 18 0a 00 00    	jne    9e3d <III_stereo+0xabb>
    9425:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
    9429:	0f 84 0e 0a 00 00    	je     9e3d <III_stereo+0xabb>
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
    942f:	8b 45 14             	mov    0x14(%ebp),%eax
    9432:	8b 40 10             	mov    0x10(%eax),%eax
    9435:	85 c0                	test   %eax,%eax
    9437:	0f 84 10 08 00 00    	je     9c4d <III_stereo+0x8cb>
    943d:	8b 45 14             	mov    0x14(%ebp),%eax
    9440:	8b 40 14             	mov    0x14(%eax),%eax
    9443:	83 f8 02             	cmp    $0x2,%eax
    9446:	0f 85 01 08 00 00    	jne    9c4d <III_stereo+0x8cb>
      {  if( gr_info->mixed_block_flag )
    944c:	8b 45 14             	mov    0x14(%ebp),%eax
    944f:	8b 40 18             	mov    0x18(%eax),%eax
    9452:	85 c0                	test   %eax,%eax
    9454:	0f 84 d0 04 00 00    	je     992a <III_stereo+0x5a8>
         {  int max_sfb = 0;
    945a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)

            for ( j=0; j<3; j++ )
    9461:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    9468:	e9 1b 03 00 00       	jmp    9788 <III_stereo+0x406>
            {  int sfbcnt;
               sfbcnt = 2;
    946d:	c7 45 d8 02 00 00 00 	movl   $0x2,-0x28(%ebp)
               for( sfb=12; sfb >=3; sfb-- )
    9474:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    947b:	e9 0f 01 00 00       	jmp    958f <III_stereo+0x20d>
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    9480:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9483:	8d 48 01             	lea    0x1(%eax),%ecx
    9486:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9489:	89 d0                	mov    %edx,%eax
    948b:	c1 e0 03             	shl    $0x3,%eax
    948e:	01 d0                	add    %edx,%eax
    9490:	c1 e0 02             	shl    $0x2,%eax
    9493:	01 d0                	add    %edx,%eax
    9495:	01 c8                	add    %ecx,%eax
    9497:	83 c0 14             	add    $0x14,%eax
    949a:	8b 0c 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%ecx
    94a1:	8b 55 c8             	mov    -0x38(%ebp),%edx
    94a4:	89 d0                	mov    %edx,%eax
    94a6:	c1 e0 03             	shl    $0x3,%eax
    94a9:	01 d0                	add    %edx,%eax
    94ab:	c1 e0 02             	shl    $0x2,%eax
    94ae:	01 d0                	add    %edx,%eax
    94b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    94b3:	01 d0                	add    %edx,%eax
    94b5:	83 c0 14             	add    $0x14,%eax
    94b8:	8b 04 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%eax
    94bf:	29 c1                	sub    %eax,%ecx
    94c1:	89 c8                	mov    %ecx,%eax
    94c3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
    94c6:	8b 55 c8             	mov    -0x38(%ebp),%edx
    94c9:	89 d0                	mov    %edx,%eax
    94cb:	c1 e0 03             	shl    $0x3,%eax
    94ce:	01 d0                	add    %edx,%eax
    94d0:	c1 e0 02             	shl    $0x2,%eax
    94d3:	01 d0                	add    %edx,%eax
    94d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
    94d8:	01 d0                	add    %edx,%eax
    94da:	83 c0 14             	add    $0x14,%eax
    94dd:	8b 14 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%edx
    94e4:	89 d0                	mov    %edx,%eax
    94e6:	01 c0                	add    %eax,%eax
    94e8:	01 c2                	add    %eax,%edx
    94ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
    94ed:	83 c0 01             	add    $0x1,%eax
    94f0:	0f af 45 d4          	imul   -0x2c(%ebp),%eax
    94f4:	01 d0                	add    %edx,%eax
    94f6:	83 e8 01             	sub    $0x1,%eax
    94f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  while ( lines > 0 )
    94fc:	e9 80 00 00 00       	jmp    9581 <III_stereo+0x1ff>
                  {  if ( xr[1][i/SSLIMIT][i%SSLIMIT] != 0.0 )
    9501:	8b 45 08             	mov    0x8(%ebp),%eax
    9504:	8d b0 00 12 00 00    	lea    0x1200(%eax),%esi
    950a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    950d:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    9512:	89 c8                	mov    %ecx,%eax
    9514:	f7 ea                	imul   %edx
    9516:	c1 fa 02             	sar    $0x2,%edx
    9519:	89 c8                	mov    %ecx,%eax
    951b:	c1 f8 1f             	sar    $0x1f,%eax
    951e:	89 d3                	mov    %edx,%ebx
    9520:	29 c3                	sub    %eax,%ebx
    9522:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    9525:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    952a:	89 c8                	mov    %ecx,%eax
    952c:	f7 ea                	imul   %edx
    952e:	c1 fa 02             	sar    $0x2,%edx
    9531:	89 c8                	mov    %ecx,%eax
    9533:	c1 f8 1f             	sar    $0x1f,%eax
    9536:	29 c2                	sub    %eax,%edx
    9538:	89 d0                	mov    %edx,%eax
    953a:	c1 e0 03             	shl    $0x3,%eax
    953d:	01 d0                	add    %edx,%eax
    953f:	01 c0                	add    %eax,%eax
    9541:	29 c1                	sub    %eax,%ecx
    9543:	89 ca                	mov    %ecx,%edx
    9545:	89 d8                	mov    %ebx,%eax
    9547:	c1 e0 03             	shl    $0x3,%eax
    954a:	01 d8                	add    %ebx,%eax
    954c:	01 c0                	add    %eax,%eax
    954e:	01 d0                	add    %edx,%eax
    9550:	dd 04 c6             	fldl   (%esi,%eax,8)
    9553:	d9 ee                	fldz   
    9555:	df e9                	fucomip %st(1),%st
    9557:	7a 0a                	jp     9563 <III_stereo+0x1e1>
    9559:	d9 ee                	fldz   
    955b:	df e9                	fucomip %st(1),%st
    955d:	dd d8                	fstp   %st(0)
    955f:	74 18                	je     9579 <III_stereo+0x1f7>
    9561:	eb 02                	jmp    9565 <III_stereo+0x1e3>
    9563:	dd d8                	fstp   %st(0)
                     {  sfbcnt = sfb;
    9565:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9568:	89 45 d8             	mov    %eax,-0x28(%ebp)
                        sfb = -10;
    956b:	c7 45 f4 f6 ff ff ff 	movl   $0xfffffff6,-0xc(%ebp)
                        lines = -10;
    9572:	c7 45 d4 f6 ff ff ff 	movl   $0xfffffff6,-0x2c(%ebp)
                     }
                     lines--;
    9579:	83 6d d4 01          	subl   $0x1,-0x2c(%ebp)
                     i--;
    957d:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
               sfbcnt = 2;
               for( sfb=12; sfb >=3; sfb-- )
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
                  while ( lines > 0 )
    9581:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    9585:	0f 8f 76 ff ff ff    	jg     9501 <III_stereo+0x17f>
         {  int max_sfb = 0;

            for ( j=0; j<3; j++ )
            {  int sfbcnt;
               sfbcnt = 2;
               for( sfb=12; sfb >=3; sfb-- )
    958b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    958f:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
    9593:	0f 8f e7 fe ff ff    	jg     9480 <III_stereo+0xfe>
                     }
                     lines--;
                     i--;
                  }
               }
               sfb = sfbcnt + 1;
    9599:	8b 45 d8             	mov    -0x28(%ebp),%eax
    959c:	83 c0 01             	add    $0x1,%eax
    959f:	89 45 f4             	mov    %eax,-0xc(%ebp)

               if ( sfb > max_sfb )
    95a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    95a5:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    95a8:	7e 0b                	jle    95b5 <III_stereo+0x233>
                  max_sfb = sfb;
    95aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    95ad:	89 45 dc             	mov    %eax,-0x24(%ebp)

               while( sfb<12 )
    95b0:	e9 f5 00 00 00       	jmp    96aa <III_stereo+0x328>
    95b5:	e9 f0 00 00 00       	jmp    96aa <III_stereo+0x328>
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    95ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    95bd:	8d 48 01             	lea    0x1(%eax),%ecx
    95c0:	8b 55 c8             	mov    -0x38(%ebp),%edx
    95c3:	89 d0                	mov    %edx,%eax
    95c5:	c1 e0 03             	shl    $0x3,%eax
    95c8:	01 d0                	add    %edx,%eax
    95ca:	c1 e0 02             	shl    $0x2,%eax
    95cd:	01 d0                	add    %edx,%eax
    95cf:	01 c8                	add    %ecx,%eax
    95d1:	83 c0 14             	add    $0x14,%eax
    95d4:	8b 0c 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%ecx
    95db:	8b 55 c8             	mov    -0x38(%ebp),%edx
    95de:	89 d0                	mov    %edx,%eax
    95e0:	c1 e0 03             	shl    $0x3,%eax
    95e3:	01 d0                	add    %edx,%eax
    95e5:	c1 e0 02             	shl    $0x2,%eax
    95e8:	01 d0                	add    %edx,%eax
    95ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
    95ed:	01 d0                	add    %edx,%eax
    95ef:	83 c0 14             	add    $0x14,%eax
    95f2:	8b 04 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%eax
    95f9:	29 c1                	sub    %eax,%ecx
    95fb:	89 c8                	mov    %ecx,%eax
    95fd:	89 45 e8             	mov    %eax,-0x18(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
    9600:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9603:	89 d0                	mov    %edx,%eax
    9605:	c1 e0 03             	shl    $0x3,%eax
    9608:	01 d0                	add    %edx,%eax
    960a:	c1 e0 02             	shl    $0x2,%eax
    960d:	01 d0                	add    %edx,%eax
    960f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9612:	01 d0                	add    %edx,%eax
    9614:	83 c0 14             	add    $0x14,%eax
    9617:	8b 14 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%edx
    961e:	89 d0                	mov    %edx,%eax
    9620:	01 c0                	add    %eax,%eax
    9622:	01 c2                	add    %eax,%edx
    9624:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9627:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    962b:	01 d0                	add    %edx,%eax
    962d:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  for ( ; sb > 0; sb--)
    9630:	eb 6e                	jmp    96a0 <III_stereo+0x31e>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
    9632:	8b 4d 10             	mov    0x10(%ebp),%ecx
    9635:	8b 55 ec             	mov    -0x14(%ebp),%edx
    9638:	89 d0                	mov    %edx,%eax
    963a:	01 c0                	add    %eax,%eax
    963c:	01 d0                	add    %edx,%eax
    963e:	c1 e0 02             	shl    $0x2,%eax
    9641:	01 d0                	add    %edx,%eax
    9643:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9646:	01 d0                	add    %edx,%eax
    9648:	83 c0 52             	add    $0x52,%eax
    964b:	8b 54 81 0c          	mov    0xc(%ecx,%eax,4),%edx
    964f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9652:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                     if ( is_pos[i] != 7 )
    9659:	8b 45 f0             	mov    -0x10(%ebp),%eax
    965c:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9663:	83 f8 07             	cmp    $0x7,%eax
    9666:	74 30                	je     9698 <III_stereo+0x316>
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
    9668:	8b 45 f0             	mov    -0x10(%ebp),%eax
    966b:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9672:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    9678:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    967e:	dd 05 60 da 00 00    	fldl   0xda60
    9684:	de c9                	fmulp  %st,%st(1)
    9686:	dd 1c 24             	fstpl  (%esp)
    9689:	e8 1d b6 ff ff       	call   4cab <tan>
    968e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9691:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                     i++;
    9698:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                  max_sfb = sfb;

               while( sfb<12 )
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
                  for ( ; sb > 0; sb--)
    969c:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    96a0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    96a4:	7f 8c                	jg     9632 <III_stereo+0x2b0>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
                     if ( is_pos[i] != 7 )
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
                     i++;
                  }
                  sfb++;
    96a6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
               sfb = sfbcnt + 1;

               if ( sfb > max_sfb )
                  max_sfb = sfb;

               while( sfb<12 )
    96aa:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    96ae:	0f 8e 06 ff ff ff    	jle    95ba <III_stereo+0x238>
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
                     i++;
                  }
                  sfb++;
               }
               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
    96b4:	8b 45 c8             	mov    -0x38(%ebp),%eax
    96b7:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    96bd:	05 9c ed 00 00       	add    $0xed9c,%eax
    96c2:	8b 50 0c             	mov    0xc(%eax),%edx
    96c5:	8b 45 c8             	mov    -0x38(%ebp),%eax
    96c8:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    96ce:	05 98 ed 00 00       	add    $0xed98,%eax
    96d3:	8b 40 0c             	mov    0xc(%eax),%eax
    96d6:	29 c2                	sub    %eax,%edx
    96d8:	89 d0                	mov    %edx,%eax
    96da:	89 45 e8             	mov    %eax,-0x18(%ebp)
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
    96dd:	8b 45 c8             	mov    -0x38(%ebp),%eax
    96e0:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    96e6:	05 98 ed 00 00       	add    $0xed98,%eax
    96eb:	8b 50 0c             	mov    0xc(%eax),%edx
    96ee:	89 d0                	mov    %edx,%eax
    96f0:	01 c0                	add    %eax,%eax
    96f2:	01 c2                	add    %eax,%edx
    96f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    96f7:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    96fb:	01 d0                	add    %edx,%eax
    96fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
    9700:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9703:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9709:	05 a0 ed 00 00       	add    $0xeda0,%eax
    970e:	8b 50 0c             	mov    0xc(%eax),%edx
    9711:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9714:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    971a:	05 9c ed 00 00       	add    $0xed9c,%eax
    971f:	8b 40 0c             	mov    0xc(%eax),%eax
    9722:	29 c2                	sub    %eax,%edx
    9724:	89 d0                	mov    %edx,%eax
    9726:	89 45 e8             	mov    %eax,-0x18(%ebp)
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
    9729:	8b 45 c8             	mov    -0x38(%ebp),%eax
    972c:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9732:	05 9c ed 00 00       	add    $0xed9c,%eax
    9737:	8b 50 0c             	mov    0xc(%eax),%edx
    973a:	89 d0                	mov    %edx,%eax
    973c:	01 c0                	add    %eax,%eax
    973e:	01 c2                	add    %eax,%edx
    9740:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9743:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    9747:	01 d0                	add    %edx,%eax
    9749:	89 45 f0             	mov    %eax,-0x10(%ebp)
               for ( ; sb > 0; sb-- )
    974c:	eb 30                	jmp    977e <III_stereo+0x3fc>
               {  is_pos[i] = is_pos[sfb];
    974e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9751:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    9758:	8b 45 f0             	mov    -0x10(%ebp),%eax
    975b:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                  is_ratio[i] = is_ratio[sfb];
    9762:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9765:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    976c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    976f:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                  i++;
    9776:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
               }
               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
               for ( ; sb > 0; sb-- )
    977a:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    977e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9782:	7f ca                	jg     974e <III_stereo+0x3cc>
   if ((stereo == 2) && i_stereo )
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
      {  if( gr_info->mixed_block_flag )
         {  int max_sfb = 0;

            for ( j=0; j<3; j++ )
    9784:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    9788:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    978c:	0f 8e db fc ff ff    	jle    946d <III_stereo+0xeb>
               {  is_pos[i] = is_pos[sfb];
                  is_ratio[i] = is_ratio[sfb];
                  i++;
               }
             }
             if ( max_sfb <= 3 )
    9792:	83 7d dc 03          	cmpl   $0x3,-0x24(%ebp)
    9796:	0f 8f 89 01 00 00    	jg     9925 <III_stereo+0x5a3>
             {  i = 2;
    979c:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
                ss = 17;
    97a3:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
                sb = -1;
    97aa:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
                while ( i >= 0 )
    97b1:	eb 63                	jmp    9816 <III_stereo+0x494>
                {  if ( xr[1][i][ss] != 0.0 )
    97b3:	8b 45 08             	mov    0x8(%ebp),%eax
    97b6:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    97bc:	8b 55 f0             	mov    -0x10(%ebp),%edx
    97bf:	89 d0                	mov    %edx,%eax
    97c1:	c1 e0 03             	shl    $0x3,%eax
    97c4:	01 d0                	add    %edx,%eax
    97c6:	01 c0                	add    %eax,%eax
    97c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    97cb:	01 d0                	add    %edx,%eax
    97cd:	dd 04 c1             	fldl   (%ecx,%eax,8)
    97d0:	d9 ee                	fldz   
    97d2:	df e9                	fucomip %st(1),%st
    97d4:	7a 0a                	jp     97e0 <III_stereo+0x45e>
    97d6:	d9 ee                	fldz   
    97d8:	df e9                	fucomip %st(1),%st
    97da:	dd d8                	fstp   %st(0)
    97dc:	74 23                	je     9801 <III_stereo+0x47f>
    97de:	eb 02                	jmp    97e2 <III_stereo+0x460>
    97e0:	dd d8                	fstp   %st(0)
                   {  sb = i*18+ss;
    97e2:	8b 55 f0             	mov    -0x10(%ebp),%edx
    97e5:	89 d0                	mov    %edx,%eax
    97e7:	c1 e0 03             	shl    $0x3,%eax
    97ea:	01 d0                	add    %edx,%eax
    97ec:	01 c0                	add    %eax,%eax
    97ee:	89 c2                	mov    %eax,%edx
    97f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    97f3:	01 d0                	add    %edx,%eax
    97f5:	89 45 e8             	mov    %eax,-0x18(%ebp)
                      i = -1;
    97f8:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    97ff:	eb 15                	jmp    9816 <III_stereo+0x494>
                   } else
                   {  ss--;
    9801:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
                      if ( ss < 0 )
    9805:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    9809:	79 0b                	jns    9816 <III_stereo+0x494>
                      {  i--;
    980b:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
                         ss = 17;
    980f:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
             }
             if ( max_sfb <= 3 )
             {  i = 2;
                ss = 17;
                sb = -1;
                while ( i >= 0 )
    9816:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    981a:	79 97                	jns    97b3 <III_stereo+0x431>
                      {  i--;
                         ss = 17;
                      }
                   }
                }
                i = 0;
    981c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                while ( sfBandIndex[sfreq].l[i] <= sb )
    9823:	eb 04                	jmp    9829 <III_stereo+0x4a7>
                   i++;
    9825:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                         ss = 17;
                      }
                   }
                }
                i = 0;
                while ( sfBandIndex[sfreq].l[i] <= sb )
    9829:	8b 55 c8             	mov    -0x38(%ebp),%edx
    982c:	89 d0                	mov    %edx,%eax
    982e:	c1 e0 03             	shl    $0x3,%eax
    9831:	01 d0                	add    %edx,%eax
    9833:	c1 e0 02             	shl    $0x2,%eax
    9836:	01 d0                	add    %edx,%eax
    9838:	8b 55 f0             	mov    -0x10(%ebp),%edx
    983b:	01 d0                	add    %edx,%eax
    983d:	8b 04 85 20 ed 00 00 	mov    0xed20(,%eax,4),%eax
    9844:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    9847:	7e dc                	jle    9825 <III_stereo+0x4a3>
                   i++;
                sfb = i;
    9849:	8b 45 f0             	mov    -0x10(%ebp),%eax
    984c:	89 45 f4             	mov    %eax,-0xc(%ebp)
                i = sfBandIndex[sfreq].l[i];
    984f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9852:	89 d0                	mov    %edx,%eax
    9854:	c1 e0 03             	shl    $0x3,%eax
    9857:	01 d0                	add    %edx,%eax
    9859:	c1 e0 02             	shl    $0x2,%eax
    985c:	01 d0                	add    %edx,%eax
    985e:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9861:	01 d0                	add    %edx,%eax
    9863:	8b 04 85 20 ed 00 00 	mov    0xed20(,%eax,4),%eax
    986a:	89 45 f0             	mov    %eax,-0x10(%ebp)
                for ( ; sfb<8; sfb++ )
    986d:	e9 a9 00 00 00       	jmp    991b <III_stereo+0x599>
                {  sb = sfBandIndex[sfreq].l[sfb+1]-sfBandIndex[sfreq].l[sfb];
    9872:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9875:	8d 48 01             	lea    0x1(%eax),%ecx
    9878:	8b 55 c8             	mov    -0x38(%ebp),%edx
    987b:	89 d0                	mov    %edx,%eax
    987d:	c1 e0 03             	shl    $0x3,%eax
    9880:	01 d0                	add    %edx,%eax
    9882:	c1 e0 02             	shl    $0x2,%eax
    9885:	01 d0                	add    %edx,%eax
    9887:	01 c8                	add    %ecx,%eax
    9889:	8b 0c 85 20 ed 00 00 	mov    0xed20(,%eax,4),%ecx
    9890:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9893:	89 d0                	mov    %edx,%eax
    9895:	c1 e0 03             	shl    $0x3,%eax
    9898:	01 d0                	add    %edx,%eax
    989a:	c1 e0 02             	shl    $0x2,%eax
    989d:	01 d0                	add    %edx,%eax
    989f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    98a2:	01 d0                	add    %edx,%eax
    98a4:	8b 04 85 20 ed 00 00 	mov    0xed20(,%eax,4),%eax
    98ab:	29 c1                	sub    %eax,%ecx
    98ad:	89 c8                	mov    %ecx,%eax
    98af:	89 45 e8             	mov    %eax,-0x18(%ebp)
                   for ( ; sb > 0; sb--)
    98b2:	eb 5d                	jmp    9911 <III_stereo+0x58f>
                   {  is_pos[i] = (*scalefac)[1].l[sfb];
    98b4:	8b 45 10             	mov    0x10(%ebp),%eax
    98b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    98ba:	83 c2 3e             	add    $0x3e,%edx
    98bd:	8b 14 90             	mov    (%eax,%edx,4),%edx
    98c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    98c3:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                      if ( is_pos[i] != 7 )
    98ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
    98cd:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    98d4:	83 f8 07             	cmp    $0x7,%eax
    98d7:	74 30                	je     9909 <III_stereo+0x587>
                         is_ratio[i] = tan( is_pos[i] * (PI / 12));
    98d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    98dc:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    98e3:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    98e9:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    98ef:	dd 05 60 da 00 00    	fldl   0xda60
    98f5:	de c9                	fmulp  %st,%st(1)
    98f7:	dd 1c 24             	fstpl  (%esp)
    98fa:	e8 ac b3 ff ff       	call   4cab <tan>
    98ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9902:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                      i++;
    9909:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                   i++;
                sfb = i;
                i = sfBandIndex[sfreq].l[i];
                for ( ; sfb<8; sfb++ )
                {  sb = sfBandIndex[sfreq].l[sfb+1]-sfBandIndex[sfreq].l[sfb];
                   for ( ; sb > 0; sb--)
    990d:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9911:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9915:	7f 9d                	jg     98b4 <III_stereo+0x532>
                i = 0;
                while ( sfBandIndex[sfreq].l[i] <= sb )
                   i++;
                sfb = i;
                i = sfBandIndex[sfreq].l[i];
                for ( ; sfb<8; sfb++ )
    9917:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    991b:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    991f:	0f 8e 4d ff ff ff    	jle    9872 <III_stereo+0x4f0>
    9925:	e9 1e 03 00 00       	jmp    9c48 <III_stereo+0x8c6>
                      i++;
                   }
                }
            }
         } else
         {  for ( j=0; j<3; j++ )
    992a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    9931:	e9 08 03 00 00       	jmp    9c3e <III_stereo+0x8bc>
            {  int sfbcnt;
               sfbcnt = -1;
    9936:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%ebp)
               for( sfb=12; sfb >=0; sfb-- )
    993d:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    9944:	e9 0f 01 00 00       	jmp    9a58 <III_stereo+0x6d6>
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    9949:	8b 45 f4             	mov    -0xc(%ebp),%eax
    994c:	8d 48 01             	lea    0x1(%eax),%ecx
    994f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9952:	89 d0                	mov    %edx,%eax
    9954:	c1 e0 03             	shl    $0x3,%eax
    9957:	01 d0                	add    %edx,%eax
    9959:	c1 e0 02             	shl    $0x2,%eax
    995c:	01 d0                	add    %edx,%eax
    995e:	01 c8                	add    %ecx,%eax
    9960:	83 c0 14             	add    $0x14,%eax
    9963:	8b 0c 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%ecx
    996a:	8b 55 c8             	mov    -0x38(%ebp),%edx
    996d:	89 d0                	mov    %edx,%eax
    996f:	c1 e0 03             	shl    $0x3,%eax
    9972:	01 d0                	add    %edx,%eax
    9974:	c1 e0 02             	shl    $0x2,%eax
    9977:	01 d0                	add    %edx,%eax
    9979:	8b 55 f4             	mov    -0xc(%ebp),%edx
    997c:	01 d0                	add    %edx,%eax
    997e:	83 c0 14             	add    $0x14,%eax
    9981:	8b 04 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%eax
    9988:	29 c1                	sub    %eax,%ecx
    998a:	89 c8                	mov    %ecx,%eax
    998c:	89 45 cc             	mov    %eax,-0x34(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
    998f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9992:	89 d0                	mov    %edx,%eax
    9994:	c1 e0 03             	shl    $0x3,%eax
    9997:	01 d0                	add    %edx,%eax
    9999:	c1 e0 02             	shl    $0x2,%eax
    999c:	01 d0                	add    %edx,%eax
    999e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    99a1:	01 d0                	add    %edx,%eax
    99a3:	83 c0 14             	add    $0x14,%eax
    99a6:	8b 14 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%edx
    99ad:	89 d0                	mov    %edx,%eax
    99af:	01 c0                	add    %eax,%eax
    99b1:	01 c2                	add    %eax,%edx
    99b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    99b6:	83 c0 01             	add    $0x1,%eax
    99b9:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    99bd:	01 d0                	add    %edx,%eax
    99bf:	83 e8 01             	sub    $0x1,%eax
    99c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  while ( lines > 0 )
    99c5:	e9 80 00 00 00       	jmp    9a4a <III_stereo+0x6c8>
                  {  if ( xr[1][i/SSLIMIT][i%SSLIMIT] != 0.0 )
    99ca:	8b 45 08             	mov    0x8(%ebp),%eax
    99cd:	8d b0 00 12 00 00    	lea    0x1200(%eax),%esi
    99d3:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    99d6:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    99db:	89 c8                	mov    %ecx,%eax
    99dd:	f7 ea                	imul   %edx
    99df:	c1 fa 02             	sar    $0x2,%edx
    99e2:	89 c8                	mov    %ecx,%eax
    99e4:	c1 f8 1f             	sar    $0x1f,%eax
    99e7:	89 d3                	mov    %edx,%ebx
    99e9:	29 c3                	sub    %eax,%ebx
    99eb:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    99ee:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    99f3:	89 c8                	mov    %ecx,%eax
    99f5:	f7 ea                	imul   %edx
    99f7:	c1 fa 02             	sar    $0x2,%edx
    99fa:	89 c8                	mov    %ecx,%eax
    99fc:	c1 f8 1f             	sar    $0x1f,%eax
    99ff:	29 c2                	sub    %eax,%edx
    9a01:	89 d0                	mov    %edx,%eax
    9a03:	c1 e0 03             	shl    $0x3,%eax
    9a06:	01 d0                	add    %edx,%eax
    9a08:	01 c0                	add    %eax,%eax
    9a0a:	29 c1                	sub    %eax,%ecx
    9a0c:	89 ca                	mov    %ecx,%edx
    9a0e:	89 d8                	mov    %ebx,%eax
    9a10:	c1 e0 03             	shl    $0x3,%eax
    9a13:	01 d8                	add    %ebx,%eax
    9a15:	01 c0                	add    %eax,%eax
    9a17:	01 d0                	add    %edx,%eax
    9a19:	dd 04 c6             	fldl   (%esi,%eax,8)
    9a1c:	d9 ee                	fldz   
    9a1e:	df e9                	fucomip %st(1),%st
    9a20:	7a 0a                	jp     9a2c <III_stereo+0x6aa>
    9a22:	d9 ee                	fldz   
    9a24:	df e9                	fucomip %st(1),%st
    9a26:	dd d8                	fstp   %st(0)
    9a28:	74 18                	je     9a42 <III_stereo+0x6c0>
    9a2a:	eb 02                	jmp    9a2e <III_stereo+0x6ac>
    9a2c:	dd d8                	fstp   %st(0)
                     {  sfbcnt = sfb;
    9a2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9a31:	89 45 d0             	mov    %eax,-0x30(%ebp)
                        sfb = -10;
    9a34:	c7 45 f4 f6 ff ff ff 	movl   $0xfffffff6,-0xc(%ebp)
                        lines = -10;
    9a3b:	c7 45 cc f6 ff ff ff 	movl   $0xfffffff6,-0x34(%ebp)
                     }
                     lines--;
    9a42:	83 6d cc 01          	subl   $0x1,-0x34(%ebp)
                     i--;
    9a46:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
               sfbcnt = -1;
               for( sfb=12; sfb >=0; sfb-- )
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
                  while ( lines > 0 )
    9a4a:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
    9a4e:	0f 8f 76 ff ff ff    	jg     99ca <III_stereo+0x648>
            }
         } else
         {  for ( j=0; j<3; j++ )
            {  int sfbcnt;
               sfbcnt = -1;
               for( sfb=12; sfb >=0; sfb-- )
    9a54:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    9a58:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    9a5c:	0f 89 e7 fe ff ff    	jns    9949 <III_stereo+0x5c7>
                     }
                     lines--;
                     i--;
                  }
               }
               sfb = sfbcnt + 1;
    9a62:	8b 45 d0             	mov    -0x30(%ebp),%eax
    9a65:	83 c0 01             	add    $0x1,%eax
    9a68:	89 45 f4             	mov    %eax,-0xc(%ebp)
               while( sfb<12 )
    9a6b:	e9 f0 00 00 00       	jmp    9b60 <III_stereo+0x7de>
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    9a70:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9a73:	8d 48 01             	lea    0x1(%eax),%ecx
    9a76:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9a79:	89 d0                	mov    %edx,%eax
    9a7b:	c1 e0 03             	shl    $0x3,%eax
    9a7e:	01 d0                	add    %edx,%eax
    9a80:	c1 e0 02             	shl    $0x2,%eax
    9a83:	01 d0                	add    %edx,%eax
    9a85:	01 c8                	add    %ecx,%eax
    9a87:	83 c0 14             	add    $0x14,%eax
    9a8a:	8b 0c 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%ecx
    9a91:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9a94:	89 d0                	mov    %edx,%eax
    9a96:	c1 e0 03             	shl    $0x3,%eax
    9a99:	01 d0                	add    %edx,%eax
    9a9b:	c1 e0 02             	shl    $0x2,%eax
    9a9e:	01 d0                	add    %edx,%eax
    9aa0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9aa3:	01 d0                	add    %edx,%eax
    9aa5:	83 c0 14             	add    $0x14,%eax
    9aa8:	8b 04 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%eax
    9aaf:	29 c1                	sub    %eax,%ecx
    9ab1:	89 c8                	mov    %ecx,%eax
    9ab3:	89 45 e8             	mov    %eax,-0x18(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
    9ab6:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9ab9:	89 d0                	mov    %edx,%eax
    9abb:	c1 e0 03             	shl    $0x3,%eax
    9abe:	01 d0                	add    %edx,%eax
    9ac0:	c1 e0 02             	shl    $0x2,%eax
    9ac3:	01 d0                	add    %edx,%eax
    9ac5:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9ac8:	01 d0                	add    %edx,%eax
    9aca:	83 c0 14             	add    $0x14,%eax
    9acd:	8b 14 85 2c ed 00 00 	mov    0xed2c(,%eax,4),%edx
    9ad4:	89 d0                	mov    %edx,%eax
    9ad6:	01 c0                	add    %eax,%eax
    9ad8:	01 c2                	add    %eax,%edx
    9ada:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9add:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    9ae1:	01 d0                	add    %edx,%eax
    9ae3:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  for ( ; sb > 0; sb--)
    9ae6:	eb 6e                	jmp    9b56 <III_stereo+0x7d4>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
    9ae8:	8b 4d 10             	mov    0x10(%ebp),%ecx
    9aeb:	8b 55 ec             	mov    -0x14(%ebp),%edx
    9aee:	89 d0                	mov    %edx,%eax
    9af0:	01 c0                	add    %eax,%eax
    9af2:	01 d0                	add    %edx,%eax
    9af4:	c1 e0 02             	shl    $0x2,%eax
    9af7:	01 d0                	add    %edx,%eax
    9af9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9afc:	01 d0                	add    %edx,%eax
    9afe:	83 c0 52             	add    $0x52,%eax
    9b01:	8b 54 81 0c          	mov    0xc(%ecx,%eax,4),%edx
    9b05:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9b08:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                     if ( is_pos[i] != 7 )
    9b0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9b12:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9b19:	83 f8 07             	cmp    $0x7,%eax
    9b1c:	74 30                	je     9b4e <III_stereo+0x7cc>
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
    9b1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9b21:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9b28:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    9b2e:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    9b34:	dd 05 60 da 00 00    	fldl   0xda60
    9b3a:	de c9                	fmulp  %st,%st(1)
    9b3c:	dd 1c 24             	fstpl  (%esp)
    9b3f:	e8 67 b1 ff ff       	call   4cab <tan>
    9b44:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9b47:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                     i++;
    9b4e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
               }
               sfb = sfbcnt + 1;
               while( sfb<12 )
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
                  for ( ; sb > 0; sb--)
    9b52:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9b56:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9b5a:	7f 8c                	jg     9ae8 <III_stereo+0x766>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
                     if ( is_pos[i] != 7 )
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
                     i++;
                  }
                  sfb++;
    9b5c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                     lines--;
                     i--;
                  }
               }
               sfb = sfbcnt + 1;
               while( sfb<12 )
    9b60:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    9b64:	0f 8e 06 ff ff ff    	jle    9a70 <III_stereo+0x6ee>
                     i++;
                  }
                  sfb++;
               }

               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
    9b6a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9b6d:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9b73:	05 9c ed 00 00       	add    $0xed9c,%eax
    9b78:	8b 50 0c             	mov    0xc(%eax),%edx
    9b7b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9b7e:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9b84:	05 98 ed 00 00       	add    $0xed98,%eax
    9b89:	8b 40 0c             	mov    0xc(%eax),%eax
    9b8c:	29 c2                	sub    %eax,%edx
    9b8e:	89 d0                	mov    %edx,%eax
    9b90:	89 45 e8             	mov    %eax,-0x18(%ebp)
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
    9b93:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9b96:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9b9c:	05 98 ed 00 00       	add    $0xed98,%eax
    9ba1:	8b 50 0c             	mov    0xc(%eax),%edx
    9ba4:	89 d0                	mov    %edx,%eax
    9ba6:	01 c0                	add    %eax,%eax
    9ba8:	01 c2                	add    %eax,%edx
    9baa:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9bad:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    9bb1:	01 d0                	add    %edx,%eax
    9bb3:	89 45 f4             	mov    %eax,-0xc(%ebp)
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
    9bb6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9bb9:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9bbf:	05 a0 ed 00 00       	add    $0xeda0,%eax
    9bc4:	8b 50 0c             	mov    0xc(%eax),%edx
    9bc7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9bca:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9bd0:	05 9c ed 00 00       	add    $0xed9c,%eax
    9bd5:	8b 40 0c             	mov    0xc(%eax),%eax
    9bd8:	29 c2                	sub    %eax,%edx
    9bda:	89 d0                	mov    %edx,%eax
    9bdc:	89 45 e8             	mov    %eax,-0x18(%ebp)
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
    9bdf:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9be2:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9be8:	05 9c ed 00 00       	add    $0xed9c,%eax
    9bed:	8b 50 0c             	mov    0xc(%eax),%edx
    9bf0:	89 d0                	mov    %edx,%eax
    9bf2:	01 c0                	add    %eax,%eax
    9bf4:	01 c2                	add    %eax,%edx
    9bf6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9bf9:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    9bfd:	01 d0                	add    %edx,%eax
    9bff:	89 45 f0             	mov    %eax,-0x10(%ebp)
               for ( ; sb > 0; sb-- )
    9c02:	eb 30                	jmp    9c34 <III_stereo+0x8b2>
               {  is_pos[i] = is_pos[sfb];
    9c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9c07:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    9c0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9c11:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                  is_ratio[i] = is_ratio[sfb];
    9c18:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9c1b:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    9c22:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9c25:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                  i++;
    9c2c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)

               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
               for ( ; sb > 0; sb-- )
    9c30:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9c34:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9c38:	7f ca                	jg     9c04 <III_stereo+0x882>
                      i++;
                   }
                }
            }
         } else
         {  for ( j=0; j<3; j++ )
    9c3a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    9c3e:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    9c42:	0f 8e ee fc ff ff    	jle    9936 <III_stereo+0x5b4>
   for ( i=0; i<576; i++ )
      is_pos[i] = 7;

   if ((stereo == 2) && i_stereo )
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
      {  if( gr_info->mixed_block_flag )
    9c48:	e9 f0 01 00 00       	jmp    9e3d <III_stereo+0xabb>
                  i++;
               }
            }
         }
      } else
      {  i = 31;
    9c4d:	c7 45 f0 1f 00 00 00 	movl   $0x1f,-0x10(%ebp)
         ss = 17;
    9c54:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
         sb = 0;
    9c5b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
         while ( i >= 0 )
    9c62:	eb 63                	jmp    9cc7 <III_stereo+0x945>
         {  if ( xr[1][i][ss] != 0.0 )
    9c64:	8b 45 08             	mov    0x8(%ebp),%eax
    9c67:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    9c6d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9c70:	89 d0                	mov    %edx,%eax
    9c72:	c1 e0 03             	shl    $0x3,%eax
    9c75:	01 d0                	add    %edx,%eax
    9c77:	01 c0                	add    %eax,%eax
    9c79:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9c7c:	01 d0                	add    %edx,%eax
    9c7e:	dd 04 c1             	fldl   (%ecx,%eax,8)
    9c81:	d9 ee                	fldz   
    9c83:	df e9                	fucomip %st(1),%st
    9c85:	7a 0a                	jp     9c91 <III_stereo+0x90f>
    9c87:	d9 ee                	fldz   
    9c89:	df e9                	fucomip %st(1),%st
    9c8b:	dd d8                	fstp   %st(0)
    9c8d:	74 23                	je     9cb2 <III_stereo+0x930>
    9c8f:	eb 02                	jmp    9c93 <III_stereo+0x911>
    9c91:	dd d8                	fstp   %st(0)
            {  sb = i*18+ss;
    9c93:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9c96:	89 d0                	mov    %edx,%eax
    9c98:	c1 e0 03             	shl    $0x3,%eax
    9c9b:	01 d0                	add    %edx,%eax
    9c9d:	01 c0                	add    %eax,%eax
    9c9f:	89 c2                	mov    %eax,%edx
    9ca1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    9ca4:	01 d0                	add    %edx,%eax
    9ca6:	89 45 e8             	mov    %eax,-0x18(%ebp)
               i = -1;
    9ca9:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    9cb0:	eb 15                	jmp    9cc7 <III_stereo+0x945>
            } else
            {  ss--;
    9cb2:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
               if ( ss < 0 )
    9cb6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    9cba:	79 0b                	jns    9cc7 <III_stereo+0x945>
               {  i--;
    9cbc:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
                  ss = 17;
    9cc0:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
         }
      } else
      {  i = 31;
         ss = 17;
         sb = 0;
         while ( i >= 0 )
    9cc7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    9ccb:	79 97                	jns    9c64 <III_stereo+0x8e2>
               {  i--;
                  ss = 17;
               }
            }
         }
         i = 0;
    9ccd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
         while ( sfBandIndex[sfreq].l[i] <= sb )
    9cd4:	eb 04                	jmp    9cda <III_stereo+0x958>
            i++;
    9cd6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                  ss = 17;
               }
            }
         }
         i = 0;
         while ( sfBandIndex[sfreq].l[i] <= sb )
    9cda:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9cdd:	89 d0                	mov    %edx,%eax
    9cdf:	c1 e0 03             	shl    $0x3,%eax
    9ce2:	01 d0                	add    %edx,%eax
    9ce4:	c1 e0 02             	shl    $0x2,%eax
    9ce7:	01 d0                	add    %edx,%eax
    9ce9:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9cec:	01 d0                	add    %edx,%eax
    9cee:	8b 04 85 20 ed 00 00 	mov    0xed20(,%eax,4),%eax
    9cf5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    9cf8:	7e dc                	jle    9cd6 <III_stereo+0x954>
            i++;
         sfb = i;
    9cfa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9cfd:	89 45 f4             	mov    %eax,-0xc(%ebp)
         i = sfBandIndex[sfreq].l[i];
    9d00:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9d03:	89 d0                	mov    %edx,%eax
    9d05:	c1 e0 03             	shl    $0x3,%eax
    9d08:	01 d0                	add    %edx,%eax
    9d0a:	c1 e0 02             	shl    $0x2,%eax
    9d0d:	01 d0                	add    %edx,%eax
    9d0f:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9d12:	01 d0                	add    %edx,%eax
    9d14:	8b 04 85 20 ed 00 00 	mov    0xed20(,%eax,4),%eax
    9d1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
         for ( ; sfb<21; sfb++ )
    9d1e:	e9 a9 00 00 00       	jmp    9dcc <III_stereo+0xa4a>
         {  sb = sfBandIndex[sfreq].l[sfb+1] - sfBandIndex[sfreq].l[sfb];
    9d23:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9d26:	8d 48 01             	lea    0x1(%eax),%ecx
    9d29:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9d2c:	89 d0                	mov    %edx,%eax
    9d2e:	c1 e0 03             	shl    $0x3,%eax
    9d31:	01 d0                	add    %edx,%eax
    9d33:	c1 e0 02             	shl    $0x2,%eax
    9d36:	01 d0                	add    %edx,%eax
    9d38:	01 c8                	add    %ecx,%eax
    9d3a:	8b 0c 85 20 ed 00 00 	mov    0xed20(,%eax,4),%ecx
    9d41:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9d44:	89 d0                	mov    %edx,%eax
    9d46:	c1 e0 03             	shl    $0x3,%eax
    9d49:	01 d0                	add    %edx,%eax
    9d4b:	c1 e0 02             	shl    $0x2,%eax
    9d4e:	01 d0                	add    %edx,%eax
    9d50:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9d53:	01 d0                	add    %edx,%eax
    9d55:	8b 04 85 20 ed 00 00 	mov    0xed20(,%eax,4),%eax
    9d5c:	29 c1                	sub    %eax,%ecx
    9d5e:	89 c8                	mov    %ecx,%eax
    9d60:	89 45 e8             	mov    %eax,-0x18(%ebp)
            for ( ; sb > 0; sb--)
    9d63:	eb 5d                	jmp    9dc2 <III_stereo+0xa40>
            {  is_pos[i] = (*scalefac)[1].l[sfb];
    9d65:	8b 45 10             	mov    0x10(%ebp),%eax
    9d68:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9d6b:	83 c2 3e             	add    $0x3e,%edx
    9d6e:	8b 14 90             	mov    (%eax,%edx,4),%edx
    9d71:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9d74:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
               if ( is_pos[i] != 7 )
    9d7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9d7e:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9d85:	83 f8 07             	cmp    $0x7,%eax
    9d88:	74 30                	je     9dba <III_stereo+0xa38>
                  is_ratio[i] = tan( is_pos[i] * (PI / 12));
    9d8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9d8d:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9d94:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    9d9a:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    9da0:	dd 05 60 da 00 00    	fldl   0xda60
    9da6:	de c9                	fmulp  %st,%st(1)
    9da8:	dd 1c 24             	fstpl  (%esp)
    9dab:	e8 fb ae ff ff       	call   4cab <tan>
    9db0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9db3:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
               i++;
    9dba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
            i++;
         sfb = i;
         i = sfBandIndex[sfreq].l[i];
         for ( ; sfb<21; sfb++ )
         {  sb = sfBandIndex[sfreq].l[sfb+1] - sfBandIndex[sfreq].l[sfb];
            for ( ; sb > 0; sb--)
    9dbe:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9dc2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9dc6:	7f 9d                	jg     9d65 <III_stereo+0x9e3>
         i = 0;
         while ( sfBandIndex[sfreq].l[i] <= sb )
            i++;
         sfb = i;
         i = sfBandIndex[sfreq].l[i];
         for ( ; sfb<21; sfb++ )
    9dc8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    9dcc:	83 7d f4 14          	cmpl   $0x14,-0xc(%ebp)
    9dd0:	0f 8e 4d ff ff ff    	jle    9d23 <III_stereo+0x9a1>
               if ( is_pos[i] != 7 )
                  is_ratio[i] = tan( is_pos[i] * (PI / 12));
               i++;
            }
         }
         sfb = sfBandIndex[sfreq].l[20];
    9dd6:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9dd9:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9ddf:	05 70 ed 00 00       	add    $0xed70,%eax
    9de4:	8b 00                	mov    (%eax),%eax
    9de6:	89 45 f4             	mov    %eax,-0xc(%ebp)
         for ( sb = 576 - sfBandIndex[sfreq].l[21]; sb > 0; sb-- )
    9de9:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9dec:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9df2:	05 74 ed 00 00       	add    $0xed74,%eax
    9df7:	8b 00                	mov    (%eax),%eax
    9df9:	ba 40 02 00 00       	mov    $0x240,%edx
    9dfe:	29 c2                	sub    %eax,%edx
    9e00:	89 d0                	mov    %edx,%eax
    9e02:	89 45 e8             	mov    %eax,-0x18(%ebp)
    9e05:	eb 30                	jmp    9e37 <III_stereo+0xab5>
         {  is_pos[i] = is_pos[sfb];
    9e07:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9e0a:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    9e11:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9e14:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
            is_ratio[i] = is_ratio[sfb];
    9e1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9e1e:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    9e25:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9e28:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
            i++;
    9e2f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                  is_ratio[i] = tan( is_pos[i] * (PI / 12));
               i++;
            }
         }
         sfb = sfBandIndex[sfreq].l[20];
         for ( sb = 576 - sfBandIndex[sfreq].l[21]; sb > 0; sb-- )
    9e33:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9e37:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9e3b:	7f ca                	jg     9e07 <III_stereo+0xa85>
            i++;
         }
      }
   }

   for(ch=0;ch<2;ch++)
    9e3d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    9e44:	eb 55                	jmp    9e9b <III_stereo+0xb19>
      for(sb=0;sb<SBLIMIT;sb++)
    9e46:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    9e4d:	eb 42                	jmp    9e91 <III_stereo+0xb0f>
         for(ss=0;ss<SSLIMIT;ss++)
    9e4f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    9e56:	eb 2f                	jmp    9e87 <III_stereo+0xb05>
            lr[ch][sb][ss] = 0;
    9e58:	8b 55 e0             	mov    -0x20(%ebp),%edx
    9e5b:	89 d0                	mov    %edx,%eax
    9e5d:	c1 e0 03             	shl    $0x3,%eax
    9e60:	01 d0                	add    %edx,%eax
    9e62:	c1 e0 09             	shl    $0x9,%eax
    9e65:	89 c2                	mov    %eax,%edx
    9e67:	8b 45 0c             	mov    0xc(%ebp),%eax
    9e6a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    9e6d:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9e70:	89 d0                	mov    %edx,%eax
    9e72:	c1 e0 03             	shl    $0x3,%eax
    9e75:	01 d0                	add    %edx,%eax
    9e77:	01 c0                	add    %eax,%eax
    9e79:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9e7c:	01 d0                	add    %edx,%eax
    9e7e:	d9 ee                	fldz   
    9e80:	dd 1c c1             	fstpl  (%ecx,%eax,8)
      }
   }

   for(ch=0;ch<2;ch++)
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
    9e83:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    9e87:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    9e8b:	7e cb                	jle    9e58 <III_stereo+0xad6>
         }
      }
   }

   for(ch=0;ch<2;ch++)
      for(sb=0;sb<SBLIMIT;sb++)
    9e8d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    9e91:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    9e95:	7e b8                	jle    9e4f <III_stereo+0xacd>
            i++;
         }
      }
   }

   for(ch=0;ch<2;ch++)
    9e97:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    9e9b:	83 7d e0 01          	cmpl   $0x1,-0x20(%ebp)
    9e9f:	7e a5                	jle    9e46 <III_stereo+0xac4>
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
            lr[ch][sb][ss] = 0;

   if (stereo==2)
    9ea1:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
    9ea5:	0f 85 3d 02 00 00    	jne    a0e8 <III_stereo+0xd66>
      for(sb=0;sb<SBLIMIT;sb++)
    9eab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    9eb2:	e9 25 02 00 00       	jmp    a0dc <III_stereo+0xd5a>
         for(ss=0;ss<SSLIMIT;ss++) {
    9eb7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    9ebe:	e9 0b 02 00 00       	jmp    a0ce <III_stereo+0xd4c>
            i = (sb*18)+ss;
    9ec3:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9ec6:	89 d0                	mov    %edx,%eax
    9ec8:	c1 e0 03             	shl    $0x3,%eax
    9ecb:	01 d0                	add    %edx,%eax
    9ecd:	01 c0                	add    %eax,%eax
    9ecf:	89 c2                	mov    %eax,%edx
    9ed1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    9ed4:	01 d0                	add    %edx,%eax
    9ed6:	89 45 f0             	mov    %eax,-0x10(%ebp)
            if ( is_pos[i] == 7 ) {
    9ed9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9edc:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9ee3:	83 f8 07             	cmp    $0x7,%eax
    9ee6:	0f 85 2c 01 00 00    	jne    a018 <III_stereo+0xc96>
               if ( ms_stereo ) {
    9eec:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
    9ef0:	0f 84 b5 00 00 00    	je     9fab <III_stereo+0xc29>
                  lr[0][sb][ss] = (xr[0][sb][ss]+xr[1][sb][ss])/1.41421356;
    9ef6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    9ef9:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9efc:	89 d0                	mov    %edx,%eax
    9efe:	c1 e0 03             	shl    $0x3,%eax
    9f01:	01 d0                	add    %edx,%eax
    9f03:	01 c0                	add    %eax,%eax
    9f05:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9f08:	01 d0                	add    %edx,%eax
    9f0a:	dd 04 c1             	fldl   (%ecx,%eax,8)
    9f0d:	8b 45 08             	mov    0x8(%ebp),%eax
    9f10:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    9f16:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9f19:	89 d0                	mov    %edx,%eax
    9f1b:	c1 e0 03             	shl    $0x3,%eax
    9f1e:	01 d0                	add    %edx,%eax
    9f20:	01 c0                	add    %eax,%eax
    9f22:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9f25:	01 d0                	add    %edx,%eax
    9f27:	dd 04 c1             	fldl   (%ecx,%eax,8)
    9f2a:	de c1                	faddp  %st,%st(1)
    9f2c:	dd 05 68 da 00 00    	fldl   0xda68
    9f32:	de f9                	fdivrp %st,%st(1)
    9f34:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    9f37:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9f3a:	89 d0                	mov    %edx,%eax
    9f3c:	c1 e0 03             	shl    $0x3,%eax
    9f3f:	01 d0                	add    %edx,%eax
    9f41:	01 c0                	add    %eax,%eax
    9f43:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9f46:	01 d0                	add    %edx,%eax
    9f48:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                  lr[1][sb][ss] = (xr[0][sb][ss]-xr[1][sb][ss])/1.41421356;
    9f4b:	8b 45 0c             	mov    0xc(%ebp),%eax
    9f4e:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    9f54:	8b 4d 08             	mov    0x8(%ebp),%ecx
    9f57:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9f5a:	89 d0                	mov    %edx,%eax
    9f5c:	c1 e0 03             	shl    $0x3,%eax
    9f5f:	01 d0                	add    %edx,%eax
    9f61:	01 c0                	add    %eax,%eax
    9f63:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9f66:	01 d0                	add    %edx,%eax
    9f68:	dd 04 c1             	fldl   (%ecx,%eax,8)
    9f6b:	8b 45 08             	mov    0x8(%ebp),%eax
    9f6e:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    9f74:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9f77:	89 d0                	mov    %edx,%eax
    9f79:	c1 e0 03             	shl    $0x3,%eax
    9f7c:	01 d0                	add    %edx,%eax
    9f7e:	01 c0                	add    %eax,%eax
    9f80:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9f83:	01 d0                	add    %edx,%eax
    9f85:	dd 04 c1             	fldl   (%ecx,%eax,8)
    9f88:	de e9                	fsubrp %st,%st(1)
    9f8a:	dd 05 68 da 00 00    	fldl   0xda68
    9f90:	de f9                	fdivrp %st,%st(1)
    9f92:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9f95:	89 d0                	mov    %edx,%eax
    9f97:	c1 e0 03             	shl    $0x3,%eax
    9f9a:	01 d0                	add    %edx,%eax
    9f9c:	01 c0                	add    %eax,%eax
    9f9e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9fa1:	01 d0                	add    %edx,%eax
    9fa3:	dd 1c c3             	fstpl  (%ebx,%eax,8)
    9fa6:	e9 1f 01 00 00       	jmp    a0ca <III_stereo+0xd48>
               }
               else {
                  lr[0][sb][ss] = xr[0][sb][ss];
    9fab:	8b 4d 08             	mov    0x8(%ebp),%ecx
    9fae:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9fb1:	89 d0                	mov    %edx,%eax
    9fb3:	c1 e0 03             	shl    $0x3,%eax
    9fb6:	01 d0                	add    %edx,%eax
    9fb8:	01 c0                	add    %eax,%eax
    9fba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9fbd:	01 d0                	add    %edx,%eax
    9fbf:	dd 04 c1             	fldl   (%ecx,%eax,8)
    9fc2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    9fc5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9fc8:	89 d0                	mov    %edx,%eax
    9fca:	c1 e0 03             	shl    $0x3,%eax
    9fcd:	01 d0                	add    %edx,%eax
    9fcf:	01 c0                	add    %eax,%eax
    9fd1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9fd4:	01 d0                	add    %edx,%eax
    9fd6:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                  lr[1][sb][ss] = xr[1][sb][ss];
    9fd9:	8b 45 0c             	mov    0xc(%ebp),%eax
    9fdc:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    9fe2:	8b 45 08             	mov    0x8(%ebp),%eax
    9fe5:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    9feb:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9fee:	89 d0                	mov    %edx,%eax
    9ff0:	c1 e0 03             	shl    $0x3,%eax
    9ff3:	01 d0                	add    %edx,%eax
    9ff5:	01 c0                	add    %eax,%eax
    9ff7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9ffa:	01 d0                	add    %edx,%eax
    9ffc:	dd 04 c3             	fldl   (%ebx,%eax,8)
    9fff:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a002:	89 d0                	mov    %edx,%eax
    a004:	c1 e0 03             	shl    $0x3,%eax
    a007:	01 d0                	add    %edx,%eax
    a009:	01 c0                	add    %eax,%eax
    a00b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a00e:	01 d0                	add    %edx,%eax
    a010:	dd 1c c1             	fstpl  (%ecx,%eax,8)
    a013:	e9 b2 00 00 00       	jmp    a0ca <III_stereo+0xd48>
               }
            }
            else if (i_stereo ) {
    a018:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
    a01c:	0f 84 94 00 00 00    	je     a0b6 <III_stereo+0xd34>
               lr[0][sb][ss] = xr[0][sb][ss] * (is_ratio[i]/(1+is_ratio[i]));
    a022:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a025:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a028:	89 d0                	mov    %edx,%eax
    a02a:	c1 e0 03             	shl    $0x3,%eax
    a02d:	01 d0                	add    %edx,%eax
    a02f:	01 c0                	add    %eax,%eax
    a031:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a034:	01 d0                	add    %edx,%eax
    a036:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a039:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a03c:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    a043:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a046:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    a04d:	d9 e8                	fld1   
    a04f:	de c1                	faddp  %st,%st(1)
    a051:	de f9                	fdivrp %st,%st(1)
    a053:	de c9                	fmulp  %st,%st(1)
    a055:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    a058:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a05b:	89 d0                	mov    %edx,%eax
    a05d:	c1 e0 03             	shl    $0x3,%eax
    a060:	01 d0                	add    %edx,%eax
    a062:	01 c0                	add    %eax,%eax
    a064:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a067:	01 d0                	add    %edx,%eax
    a069:	dd 1c c1             	fstpl  (%ecx,%eax,8)
               lr[1][sb][ss] = xr[0][sb][ss] * (1/(1+is_ratio[i]));
    a06c:	8b 45 0c             	mov    0xc(%ebp),%eax
    a06f:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    a075:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a078:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a07b:	89 d0                	mov    %edx,%eax
    a07d:	c1 e0 03             	shl    $0x3,%eax
    a080:	01 d0                	add    %edx,%eax
    a082:	01 c0                	add    %eax,%eax
    a084:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a087:	01 d0                	add    %edx,%eax
    a089:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a08c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a08f:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    a096:	d9 e8                	fld1   
    a098:	de c1                	faddp  %st,%st(1)
    a09a:	d9 e8                	fld1   
    a09c:	de f1                	fdivp  %st,%st(1)
    a09e:	de c9                	fmulp  %st,%st(1)
    a0a0:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a0a3:	89 d0                	mov    %edx,%eax
    a0a5:	c1 e0 03             	shl    $0x3,%eax
    a0a8:	01 d0                	add    %edx,%eax
    a0aa:	01 c0                	add    %eax,%eax
    a0ac:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a0af:	01 d0                	add    %edx,%eax
    a0b1:	dd 1c c3             	fstpl  (%ebx,%eax,8)
    a0b4:	eb 14                	jmp    a0ca <III_stereo+0xd48>
            }
            else {
               printf(0,"Error in streo processing\n");
    a0b6:	c7 44 24 04 00 ca 00 	movl   $0xca00,0x4(%esp)
    a0bd:	00 
    a0be:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    a0c5:	e8 3c a7 ff ff       	call   4806 <printf>
         for(ss=0;ss<SSLIMIT;ss++)
            lr[ch][sb][ss] = 0;

   if (stereo==2)
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++) {
    a0ca:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    a0ce:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    a0d2:	0f 8e eb fd ff ff    	jle    9ec3 <III_stereo+0xb41>
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
            lr[ch][sb][ss] = 0;

   if (stereo==2)
      for(sb=0;sb<SBLIMIT;sb++)
    a0d8:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    a0dc:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    a0e0:	0f 8e d1 fd ff ff    	jle    9eb7 <III_stereo+0xb35>
    a0e6:	eb 54                	jmp    a13c <III_stereo+0xdba>
            else {
               printf(0,"Error in streo processing\n");
            }
         }
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
    a0e8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    a0ef:	eb 45                	jmp    a136 <III_stereo+0xdb4>
         for(ss=0;ss<SSLIMIT;ss++)
    a0f1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    a0f8:	eb 32                	jmp    a12c <III_stereo+0xdaa>
            lr[0][sb][ss] = xr[0][sb][ss];
    a0fa:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a0fd:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a100:	89 d0                	mov    %edx,%eax
    a102:	c1 e0 03             	shl    $0x3,%eax
    a105:	01 d0                	add    %edx,%eax
    a107:	01 c0                	add    %eax,%eax
    a109:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a10c:	01 d0                	add    %edx,%eax
    a10e:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a111:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    a114:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a117:	89 d0                	mov    %edx,%eax
    a119:	c1 e0 03             	shl    $0x3,%eax
    a11c:	01 d0                	add    %edx,%eax
    a11e:	01 c0                	add    %eax,%eax
    a120:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a123:	01 d0                	add    %edx,%eax
    a125:	dd 1c c1             	fstpl  (%ecx,%eax,8)
               printf(0,"Error in streo processing\n");
            }
         }
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
    a128:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    a12c:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    a130:	7e c8                	jle    a0fa <III_stereo+0xd78>
            else {
               printf(0,"Error in streo processing\n");
            }
         }
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
    a132:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    a136:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    a13a:	7e b5                	jle    a0f1 <III_stereo+0xd6f>
         for(ss=0;ss<SSLIMIT;ss++)
            lr[0][sb][ss] = xr[0][sb][ss];

}
    a13c:	81 c4 50 1b 00 00    	add    $0x1b50,%esp
    a142:	5b                   	pop    %ebx
    a143:	5e                   	pop    %esi
    a144:	5d                   	pop    %ebp
    a145:	c3                   	ret    

0000a146 <III_antialias>:


double Ci[8]={-0.6,-0.535,-0.33,-0.185,-0.095,-0.041,-0.0142,-0.0037};
void III_antialias(double xr[SBLIMIT][SSLIMIT], double hybridIn[SBLIMIT][SSLIMIT], struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
    a146:	55                   	push   %ebp
    a147:	89 e5                	mov    %esp,%ebp
    a149:	83 ec 48             	sub    $0x48,%esp
   static int    init = 1;
   static double ca[8],cs[8];
   double        bu,bd;  /* upper and lower butterfly inputs */
   int           ss,sb,sblim;

   if (init) {
    a14c:	a1 80 ef 00 00       	mov    0xef80,%eax
    a151:	85 c0                	test   %eax,%eax
    a153:	74 68                	je     a1bd <III_antialias+0x77>
      int i;
      double    sq;
      for (i=0;i<8;i++) {
    a155:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    a15c:	eb 4f                	jmp    a1ad <III_antialias+0x67>
         sq=sqrt(1.0+Ci[i]*Ci[i]);
    a15e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a161:	dd 04 c5 40 ef 00 00 	fldl   0xef40(,%eax,8)
    a168:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a16b:	dd 04 c5 40 ef 00 00 	fldl   0xef40(,%eax,8)
    a172:	de c9                	fmulp  %st,%st(1)
    a174:	d9 e8                	fld1   
    a176:	de c1                	faddp  %st,%st(1)
    a178:	dd 1c 24             	fstpl  (%esp)
    a17b:	e8 de ac ff ff       	call   4e5e <sqrt>
    a180:	dd 5d e0             	fstpl  -0x20(%ebp)
         cs[i] = 1.0/sq;
    a183:	d9 e8                	fld1   
    a185:	dc 75 e0             	fdivl  -0x20(%ebp)
    a188:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a18b:	dd 1c c5 00 f0 00 00 	fstpl  0xf000(,%eax,8)
         ca[i] = Ci[i]/sq;
    a192:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a195:	dd 04 c5 40 ef 00 00 	fldl   0xef40(,%eax,8)
    a19c:	dc 75 e0             	fdivl  -0x20(%ebp)
    a19f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a1a2:	dd 1c c5 40 f0 00 00 	fstpl  0xf040(,%eax,8)
   int           ss,sb,sblim;

   if (init) {
      int i;
      double    sq;
      for (i=0;i<8;i++) {
    a1a9:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    a1ad:	83 7d e8 07          	cmpl   $0x7,-0x18(%ebp)
    a1b1:	7e ab                	jle    a15e <III_antialias+0x18>
         sq=sqrt(1.0+Ci[i]*Ci[i]);
         cs[i] = 1.0/sq;
         ca[i] = Ci[i]/sq;
      }
      init = 0;
    a1b3:	c7 05 80 ef 00 00 00 	movl   $0x0,0xef80
    a1ba:	00 00 00 
   }

   /* clear all inputs */

    for(sb=0;sb<SBLIMIT;sb++)
    a1bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    a1c4:	eb 4c                	jmp    a212 <III_antialias+0xcc>
       for(ss=0;ss<SSLIMIT;ss++)
    a1c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a1cd:	eb 39                	jmp    a208 <III_antialias+0xc2>
          hybridIn[sb][ss] = xr[sb][ss];
    a1cf:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a1d2:	89 d0                	mov    %edx,%eax
    a1d4:	c1 e0 03             	shl    $0x3,%eax
    a1d7:	01 d0                	add    %edx,%eax
    a1d9:	c1 e0 04             	shl    $0x4,%eax
    a1dc:	89 c2                	mov    %eax,%edx
    a1de:	8b 45 0c             	mov    0xc(%ebp),%eax
    a1e1:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    a1e4:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a1e7:	89 d0                	mov    %edx,%eax
    a1e9:	c1 e0 03             	shl    $0x3,%eax
    a1ec:	01 d0                	add    %edx,%eax
    a1ee:	c1 e0 04             	shl    $0x4,%eax
    a1f1:	89 c2                	mov    %eax,%edx
    a1f3:	8b 45 08             	mov    0x8(%ebp),%eax
    a1f6:	01 c2                	add    %eax,%edx
    a1f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a1fb:	dd 04 c2             	fldl   (%edx,%eax,8)
    a1fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a201:	dd 1c c1             	fstpl  (%ecx,%eax,8)
   }

   /* clear all inputs */

    for(sb=0;sb<SBLIMIT;sb++)
       for(ss=0;ss<SSLIMIT;ss++)
    a204:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a208:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    a20c:	7e c1                	jle    a1cf <III_antialias+0x89>
      init = 0;
   }

   /* clear all inputs */

    for(sb=0;sb<SBLIMIT;sb++)
    a20e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    a212:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    a216:	7e ae                	jle    a1c6 <III_antialias+0x80>
       for(ss=0;ss<SSLIMIT;ss++)
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
    a218:	8b 45 10             	mov    0x10(%ebp),%eax
    a21b:	8b 40 10             	mov    0x10(%eax),%eax
    a21e:	85 c0                	test   %eax,%eax
    a220:	74 1a                	je     a23c <III_antialias+0xf6>
    a222:	8b 45 10             	mov    0x10(%ebp),%eax
    a225:	8b 40 14             	mov    0x14(%eax),%eax
    a228:	83 f8 02             	cmp    $0x2,%eax
    a22b:	75 0f                	jne    a23c <III_antialias+0xf6>
       !gr_info->mixed_block_flag ) return;
    a22d:	8b 45 10             	mov    0x10(%ebp),%eax
    a230:	8b 40 18             	mov    0x18(%eax),%eax

    for(sb=0;sb<SBLIMIT;sb++)
       for(ss=0;ss<SSLIMIT;ss++)
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
    a233:	85 c0                	test   %eax,%eax
    a235:	75 05                	jne    a23c <III_antialias+0xf6>
       !gr_info->mixed_block_flag ) return;
    a237:	e9 1c 01 00 00       	jmp    a358 <III_antialias+0x212>

   if ( gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    a23c:	8b 45 10             	mov    0x10(%ebp),%eax
    a23f:	8b 40 10             	mov    0x10(%eax),%eax
    a242:	85 c0                	test   %eax,%eax
    a244:	74 1e                	je     a264 <III_antialias+0x11e>
    a246:	8b 45 10             	mov    0x10(%ebp),%eax
    a249:	8b 40 18             	mov    0x18(%eax),%eax
    a24c:	85 c0                	test   %eax,%eax
    a24e:	74 14                	je     a264 <III_antialias+0x11e>
     (gr_info->block_type == 2))
    a250:	8b 45 10             	mov    0x10(%ebp),%eax
    a253:	8b 40 14             	mov    0x14(%eax),%eax
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
       !gr_info->mixed_block_flag ) return;

   if ( gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    a256:	83 f8 02             	cmp    $0x2,%eax
    a259:	75 09                	jne    a264 <III_antialias+0x11e>
     (gr_info->block_type == 2))
      sblim = 1;
    a25b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    a262:	eb 07                	jmp    a26b <III_antialias+0x125>
   else
      sblim = SBLIMIT-1;
    a264:	c7 45 ec 1f 00 00 00 	movl   $0x1f,-0x14(%ebp)

   /* 31 alias-reduction operations between each pair of sub-bands */
   /* with 8 butterflies between each pair                         */

   for(sb=0;sb<sblim;sb++)
    a26b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    a272:	e9 d5 00 00 00       	jmp    a34c <III_antialias+0x206>
      for(ss=0;ss<8;ss++) {
    a277:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a27e:	e9 bb 00 00 00       	jmp    a33e <III_antialias+0x1f8>
         bu = xr[sb][17-ss];
    a283:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a286:	89 d0                	mov    %edx,%eax
    a288:	c1 e0 03             	shl    $0x3,%eax
    a28b:	01 d0                	add    %edx,%eax
    a28d:	c1 e0 04             	shl    $0x4,%eax
    a290:	89 c2                	mov    %eax,%edx
    a292:	8b 45 08             	mov    0x8(%ebp),%eax
    a295:	01 c2                	add    %eax,%edx
    a297:	b8 11 00 00 00       	mov    $0x11,%eax
    a29c:	2b 45 f4             	sub    -0xc(%ebp),%eax
    a29f:	dd 04 c2             	fldl   (%edx,%eax,8)
    a2a2:	dd 5d d8             	fstpl  -0x28(%ebp)
         bd = xr[sb+1][ss];
    a2a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a2a8:	8d 50 01             	lea    0x1(%eax),%edx
    a2ab:	89 d0                	mov    %edx,%eax
    a2ad:	c1 e0 03             	shl    $0x3,%eax
    a2b0:	01 d0                	add    %edx,%eax
    a2b2:	c1 e0 04             	shl    $0x4,%eax
    a2b5:	89 c2                	mov    %eax,%edx
    a2b7:	8b 45 08             	mov    0x8(%ebp),%eax
    a2ba:	01 c2                	add    %eax,%edx
    a2bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a2bf:	dd 04 c2             	fldl   (%edx,%eax,8)
    a2c2:	dd 5d d0             	fstpl  -0x30(%ebp)
         hybridIn[sb][17-ss] = (bu * cs[ss]) - (bd * ca[ss]);
    a2c5:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a2c8:	89 d0                	mov    %edx,%eax
    a2ca:	c1 e0 03             	shl    $0x3,%eax
    a2cd:	01 d0                	add    %edx,%eax
    a2cf:	c1 e0 04             	shl    $0x4,%eax
    a2d2:	89 c2                	mov    %eax,%edx
    a2d4:	8b 45 0c             	mov    0xc(%ebp),%eax
    a2d7:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    a2da:	b8 11 00 00 00       	mov    $0x11,%eax
    a2df:	2b 45 f4             	sub    -0xc(%ebp),%eax
    a2e2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    a2e5:	dd 04 d5 00 f0 00 00 	fldl   0xf000(,%edx,8)
    a2ec:	dc 4d d8             	fmull  -0x28(%ebp)
    a2ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
    a2f2:	dd 04 d5 40 f0 00 00 	fldl   0xf040(,%edx,8)
    a2f9:	dc 4d d0             	fmull  -0x30(%ebp)
    a2fc:	de e9                	fsubrp %st,%st(1)
    a2fe:	dd 1c c1             	fstpl  (%ecx,%eax,8)
         hybridIn[sb+1][ss] = (bd * cs[ss]) + (bu * ca[ss]);
    a301:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a304:	8d 50 01             	lea    0x1(%eax),%edx
    a307:	89 d0                	mov    %edx,%eax
    a309:	c1 e0 03             	shl    $0x3,%eax
    a30c:	01 d0                	add    %edx,%eax
    a30e:	c1 e0 04             	shl    $0x4,%eax
    a311:	89 c2                	mov    %eax,%edx
    a313:	8b 45 0c             	mov    0xc(%ebp),%eax
    a316:	01 c2                	add    %eax,%edx
    a318:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a31b:	dd 04 c5 00 f0 00 00 	fldl   0xf000(,%eax,8)
    a322:	dc 4d d0             	fmull  -0x30(%ebp)
    a325:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a328:	dd 04 c5 40 f0 00 00 	fldl   0xf040(,%eax,8)
    a32f:	dc 4d d8             	fmull  -0x28(%ebp)
    a332:	de c1                	faddp  %st,%st(1)
    a334:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a337:	dd 1c c2             	fstpl  (%edx,%eax,8)

   /* 31 alias-reduction operations between each pair of sub-bands */
   /* with 8 butterflies between each pair                         */

   for(sb=0;sb<sblim;sb++)
      for(ss=0;ss<8;ss++) {
    a33a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a33e:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    a342:	0f 8e 3b ff ff ff    	jle    a283 <III_antialias+0x13d>
      sblim = SBLIMIT-1;

   /* 31 alias-reduction operations between each pair of sub-bands */
   /* with 8 butterflies between each pair                         */

   for(sb=0;sb<sblim;sb++)
    a348:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    a34c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a34f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    a352:	0f 8c 1f ff ff ff    	jl     a277 <III_antialias+0x131>
         bu = xr[sb][17-ss];
         bd = xr[sb+1][ss];
         hybridIn[sb][17-ss] = (bu * cs[ss]) - (bd * ca[ss]);
         hybridIn[sb+1][ss] = (bd * cs[ss]) + (bu * ca[ss]);
         }
}
    a358:	c9                   	leave  
    a359:	c3                   	ret    

0000a35a <inv_mdct>:


void inv_mdct(double in[18], double out[36], int block_type)
{
    a35a:	55                   	push   %ebp
    a35b:	89 e5                	mov    %esp,%ebp
    a35d:	81 ec a8 00 00 00    	sub    $0xa8,%esp
	double  tmp[12],sum;
	static  double  win[4][36];
	static  int init=0;
	static  double COS[4*36];

    if(init==0){
    a363:	a1 80 f0 00 00       	mov    0xf080,%eax
    a368:	85 c0                	test   %eax,%eax
    a36a:	0f 85 59 02 00 00    	jne    a5c9 <inv_mdct+0x26f>

    /* type 0 */
      for(i=0;i<36;i++)
    a370:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a377:	eb 29                	jmp    a3a2 <inv_mdct+0x48>
         win[0][i] = sin( PI/36 *(i+0.5) );
    a379:	db 45 f4             	fildl  -0xc(%ebp)
    a37c:	dd 05 70 da 00 00    	fldl   0xda70
    a382:	de c1                	faddp  %st,%st(1)
    a384:	dd 05 78 da 00 00    	fldl   0xda78
    a38a:	de c9                	fmulp  %st,%st(1)
    a38c:	dd 1c 24             	fstpl  (%esp)
    a38f:	e8 53 a8 ff ff       	call   4be7 <sin>
    a394:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a397:	dd 1c c5 a0 f0 00 00 	fstpl  0xf0a0(,%eax,8)
	static  double COS[4*36];

    if(init==0){

    /* type 0 */
      for(i=0;i<36;i++)
    a39e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a3a2:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a3a6:	7e d1                	jle    a379 <inv_mdct+0x1f>
         win[0][i] = sin( PI/36 *(i+0.5) );

    /* type 1*/
      for(i=0;i<18;i++)
    a3a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a3af:	eb 2c                	jmp    a3dd <inv_mdct+0x83>
         win[1][i] = sin( PI/36 *(i+0.5) );
    a3b1:	db 45 f4             	fildl  -0xc(%ebp)
    a3b4:	dd 05 70 da 00 00    	fldl   0xda70
    a3ba:	de c1                	faddp  %st,%st(1)
    a3bc:	dd 05 78 da 00 00    	fldl   0xda78
    a3c2:	de c9                	fmulp  %st,%st(1)
    a3c4:	dd 1c 24             	fstpl  (%esp)
    a3c7:	e8 1b a8 ff ff       	call   4be7 <sin>
    a3cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a3cf:	83 c0 24             	add    $0x24,%eax
    a3d2:	dd 1c c5 a0 f0 00 00 	fstpl  0xf0a0(,%eax,8)
    /* type 0 */
      for(i=0;i<36;i++)
         win[0][i] = sin( PI/36 *(i+0.5) );

    /* type 1*/
      for(i=0;i<18;i++)
    a3d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a3dd:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    a3e1:	7e ce                	jle    a3b1 <inv_mdct+0x57>
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
    a3e3:	c7 45 f4 12 00 00 00 	movl   $0x12,-0xc(%ebp)
    a3ea:	eb 13                	jmp    a3ff <inv_mdct+0xa5>
         win[1][i] = 1.0;
    a3ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a3ef:	83 c0 24             	add    $0x24,%eax
    a3f2:	d9 e8                	fld1   
    a3f4:	dd 1c c5 a0 f0 00 00 	fstpl  0xf0a0(,%eax,8)
         win[0][i] = sin( PI/36 *(i+0.5) );

    /* type 1*/
      for(i=0;i<18;i++)
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
    a3fb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a3ff:	83 7d f4 17          	cmpl   $0x17,-0xc(%ebp)
    a403:	7e e7                	jle    a3ec <inv_mdct+0x92>
         win[1][i] = 1.0;
      for(i=24;i<30;i++)
    a405:	c7 45 f4 18 00 00 00 	movl   $0x18,-0xc(%ebp)
    a40c:	eb 34                	jmp    a442 <inv_mdct+0xe8>
         win[1][i] = sin( PI/12 *(i+0.5-18) );
    a40e:	db 45 f4             	fildl  -0xc(%ebp)
    a411:	dd 05 70 da 00 00    	fldl   0xda70
    a417:	de c1                	faddp  %st,%st(1)
    a419:	dd 05 80 da 00 00    	fldl   0xda80
    a41f:	de e9                	fsubrp %st,%st(1)
    a421:	dd 05 60 da 00 00    	fldl   0xda60
    a427:	de c9                	fmulp  %st,%st(1)
    a429:	dd 1c 24             	fstpl  (%esp)
    a42c:	e8 b6 a7 ff ff       	call   4be7 <sin>
    a431:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a434:	83 c0 24             	add    $0x24,%eax
    a437:	dd 1c c5 a0 f0 00 00 	fstpl  0xf0a0(,%eax,8)
    /* type 1*/
      for(i=0;i<18;i++)
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
         win[1][i] = 1.0;
      for(i=24;i<30;i++)
    a43e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a442:	83 7d f4 1d          	cmpl   $0x1d,-0xc(%ebp)
    a446:	7e c6                	jle    a40e <inv_mdct+0xb4>
         win[1][i] = sin( PI/12 *(i+0.5-18) );
      for(i=30;i<36;i++)
    a448:	c7 45 f4 1e 00 00 00 	movl   $0x1e,-0xc(%ebp)
    a44f:	eb 13                	jmp    a464 <inv_mdct+0x10a>
         win[1][i] = 0.0;
    a451:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a454:	83 c0 24             	add    $0x24,%eax
    a457:	d9 ee                	fldz   
    a459:	dd 1c c5 a0 f0 00 00 	fstpl  0xf0a0(,%eax,8)
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
         win[1][i] = 1.0;
      for(i=24;i<30;i++)
         win[1][i] = sin( PI/12 *(i+0.5-18) );
      for(i=30;i<36;i++)
    a460:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a464:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a468:	7e e7                	jle    a451 <inv_mdct+0xf7>
         win[1][i] = 0.0;

    /* type 3*/
      for(i=0;i<6;i++)
    a46a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a471:	eb 13                	jmp    a486 <inv_mdct+0x12c>
         win[3][i] = 0.0;
    a473:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a476:	83 c0 6c             	add    $0x6c,%eax
    a479:	d9 ee                	fldz   
    a47b:	dd 1c c5 a0 f0 00 00 	fstpl  0xf0a0(,%eax,8)
         win[1][i] = sin( PI/12 *(i+0.5-18) );
      for(i=30;i<36;i++)
         win[1][i] = 0.0;

    /* type 3*/
      for(i=0;i<6;i++)
    a482:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a486:	83 7d f4 05          	cmpl   $0x5,-0xc(%ebp)
    a48a:	7e e7                	jle    a473 <inv_mdct+0x119>
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
    a48c:	c7 45 f4 06 00 00 00 	movl   $0x6,-0xc(%ebp)
    a493:	eb 34                	jmp    a4c9 <inv_mdct+0x16f>
         win[3][i] = sin( PI/12 *(i+0.5-6) );
    a495:	db 45 f4             	fildl  -0xc(%ebp)
    a498:	dd 05 70 da 00 00    	fldl   0xda70
    a49e:	de c1                	faddp  %st,%st(1)
    a4a0:	dd 05 88 da 00 00    	fldl   0xda88
    a4a6:	de e9                	fsubrp %st,%st(1)
    a4a8:	dd 05 60 da 00 00    	fldl   0xda60
    a4ae:	de c9                	fmulp  %st,%st(1)
    a4b0:	dd 1c 24             	fstpl  (%esp)
    a4b3:	e8 2f a7 ff ff       	call   4be7 <sin>
    a4b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a4bb:	83 c0 6c             	add    $0x6c,%eax
    a4be:	dd 1c c5 a0 f0 00 00 	fstpl  0xf0a0(,%eax,8)
         win[1][i] = 0.0;

    /* type 3*/
      for(i=0;i<6;i++)
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
    a4c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a4c9:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    a4cd:	7e c6                	jle    a495 <inv_mdct+0x13b>
         win[3][i] = sin( PI/12 *(i+0.5-6) );
      for(i=12;i<18;i++)
    a4cf:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    a4d6:	eb 13                	jmp    a4eb <inv_mdct+0x191>
         win[3][i] =1.0;
    a4d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a4db:	83 c0 6c             	add    $0x6c,%eax
    a4de:	d9 e8                	fld1   
    a4e0:	dd 1c c5 a0 f0 00 00 	fstpl  0xf0a0(,%eax,8)
    /* type 3*/
      for(i=0;i<6;i++)
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
         win[3][i] = sin( PI/12 *(i+0.5-6) );
      for(i=12;i<18;i++)
    a4e7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a4eb:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    a4ef:	7e e7                	jle    a4d8 <inv_mdct+0x17e>
         win[3][i] =1.0;
      for(i=18;i<36;i++)
    a4f1:	c7 45 f4 12 00 00 00 	movl   $0x12,-0xc(%ebp)
    a4f8:	eb 2c                	jmp    a526 <inv_mdct+0x1cc>
         win[3][i] = sin( PI/36*(i+0.5) );
    a4fa:	db 45 f4             	fildl  -0xc(%ebp)
    a4fd:	dd 05 70 da 00 00    	fldl   0xda70
    a503:	de c1                	faddp  %st,%st(1)
    a505:	dd 05 78 da 00 00    	fldl   0xda78
    a50b:	de c9                	fmulp  %st,%st(1)
    a50d:	dd 1c 24             	fstpl  (%esp)
    a510:	e8 d2 a6 ff ff       	call   4be7 <sin>
    a515:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a518:	83 c0 6c             	add    $0x6c,%eax
    a51b:	dd 1c c5 a0 f0 00 00 	fstpl  0xf0a0(,%eax,8)
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
         win[3][i] = sin( PI/12 *(i+0.5-6) );
      for(i=12;i<18;i++)
         win[3][i] =1.0;
      for(i=18;i<36;i++)
    a522:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a526:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a52a:	7e ce                	jle    a4fa <inv_mdct+0x1a0>
         win[3][i] = sin( PI/36*(i+0.5) );

    /* type 2*/
      for(i=0;i<12;i++)
    a52c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a533:	eb 2c                	jmp    a561 <inv_mdct+0x207>
         win[2][i] = sin( PI/12*(i+0.5) ) ;
    a535:	db 45 f4             	fildl  -0xc(%ebp)
    a538:	dd 05 70 da 00 00    	fldl   0xda70
    a53e:	de c1                	faddp  %st,%st(1)
    a540:	dd 05 60 da 00 00    	fldl   0xda60
    a546:	de c9                	fmulp  %st,%st(1)
    a548:	dd 1c 24             	fstpl  (%esp)
    a54b:	e8 97 a6 ff ff       	call   4be7 <sin>
    a550:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a553:	83 c0 48             	add    $0x48,%eax
    a556:	dd 1c c5 a0 f0 00 00 	fstpl  0xf0a0(,%eax,8)
         win[3][i] =1.0;
      for(i=18;i<36;i++)
         win[3][i] = sin( PI/36*(i+0.5) );

    /* type 2*/
      for(i=0;i<12;i++)
    a55d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a561:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    a565:	7e ce                	jle    a535 <inv_mdct+0x1db>
         win[2][i] = sin( PI/12*(i+0.5) ) ;
      for(i=12;i<36;i++)
    a567:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    a56e:	eb 13                	jmp    a583 <inv_mdct+0x229>
         win[2][i] = 0.0 ;
    a570:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a573:	83 c0 48             	add    $0x48,%eax
    a576:	d9 ee                	fldz   
    a578:	dd 1c c5 a0 f0 00 00 	fstpl  0xf0a0(,%eax,8)
         win[3][i] = sin( PI/36*(i+0.5) );

    /* type 2*/
      for(i=0;i<12;i++)
         win[2][i] = sin( PI/12*(i+0.5) ) ;
      for(i=12;i<36;i++)
    a57f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a583:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a587:	7e e7                	jle    a570 <inv_mdct+0x216>
         win[2][i] = 0.0 ;

      for (i=0; i<4*36; i++)
    a589:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a590:	eb 21                	jmp    a5b3 <inv_mdct+0x259>
         COS[i] = cos(PI/(2*36) * i);
    a592:	db 45 f4             	fildl  -0xc(%ebp)
    a595:	dd 05 90 da 00 00    	fldl   0xda90
    a59b:	de c9                	fmulp  %st,%st(1)
    a59d:	dd 1c 24             	fstpl  (%esp)
    a5a0:	e8 e1 a6 ff ff       	call   4c86 <cos>
    a5a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a5a8:	dd 1c c5 20 f5 00 00 	fstpl  0xf520(,%eax,8)
      for(i=0;i<12;i++)
         win[2][i] = sin( PI/12*(i+0.5) ) ;
      for(i=12;i<36;i++)
         win[2][i] = 0.0 ;

      for (i=0; i<4*36; i++)
    a5af:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a5b3:	81 7d f4 8f 00 00 00 	cmpl   $0x8f,-0xc(%ebp)
    a5ba:	7e d6                	jle    a592 <inv_mdct+0x238>
         COS[i] = cos(PI/(2*36) * i);

      init++;
    a5bc:	a1 80 f0 00 00       	mov    0xf080,%eax
    a5c1:	83 c0 01             	add    $0x1,%eax
    a5c4:	a3 80 f0 00 00       	mov    %eax,0xf080
    }

    for(i=0;i<36;i++)
    a5c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a5d0:	eb 17                	jmp    a5e9 <inv_mdct+0x28f>
       out[i]=0;
    a5d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a5d5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a5dc:	8b 45 0c             	mov    0xc(%ebp),%eax
    a5df:	01 d0                	add    %edx,%eax
    a5e1:	d9 ee                	fldz   
    a5e3:	dd 18                	fstpl  (%eax)
         COS[i] = cos(PI/(2*36) * i);

      init++;
    }

    for(i=0;i<36;i++)
    a5e5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a5e9:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a5ed:	7e e3                	jle    a5d2 <inv_mdct+0x278>
       out[i]=0;

    if(block_type == 2){
    a5ef:	83 7d 10 02          	cmpl   $0x2,0x10(%ebp)
    a5f3:	0f 85 85 01 00 00    	jne    a77e <inv_mdct+0x424>
       N=12;
    a5f9:	c7 45 dc 0c 00 00 00 	movl   $0xc,-0x24(%ebp)
       for(i=0;i<3;i++){
    a600:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a607:	e9 63 01 00 00       	jmp    a76f <inv_mdct+0x415>
          for(p= 0;p<N;p++){
    a60c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    a613:	e9 df 00 00 00       	jmp    a6f7 <inv_mdct+0x39d>
             sum = 0.0;
    a618:	d9 ee                	fldz   
    a61a:	dd 5d e0             	fstpl  -0x20(%ebp)
             for(m=0;m<N/2;m++)
    a61d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    a624:	e9 8f 00 00 00       	jmp    a6b8 <inv_mdct+0x35e>
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
    a629:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a62c:	89 d0                	mov    %edx,%eax
    a62e:	01 c0                	add    %eax,%eax
    a630:	01 c2                	add    %eax,%edx
    a632:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a635:	01 d0                	add    %edx,%eax
    a637:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a63e:	8b 45 08             	mov    0x8(%ebp),%eax
    a641:	01 d0                	add    %edx,%eax
    a643:	dd 00                	fldl   (%eax)
    a645:	dd 9d 68 ff ff ff    	fstpl  -0x98(%ebp)
    a64b:	8b 45 dc             	mov    -0x24(%ebp),%eax
    a64e:	01 c0                	add    %eax,%eax
    a650:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    a656:	db 85 74 ff ff ff    	fildl  -0x8c(%ebp)
    a65c:	dd 05 98 da 00 00    	fldl   0xda98
    a662:	de f1                	fdivp  %st,%st(1)
    a664:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a667:	01 c0                	add    %eax,%eax
    a669:	8d 50 01             	lea    0x1(%eax),%edx
    a66c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    a66f:	89 c1                	mov    %eax,%ecx
    a671:	c1 e9 1f             	shr    $0x1f,%ecx
    a674:	01 c8                	add    %ecx,%eax
    a676:	d1 f8                	sar    %eax
    a678:	01 d0                	add    %edx,%eax
    a67a:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    a680:	db 85 74 ff ff ff    	fildl  -0x8c(%ebp)
    a686:	de c9                	fmulp  %st,%st(1)
    a688:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a68b:	01 c0                	add    %eax,%eax
    a68d:	83 c0 01             	add    $0x1,%eax
    a690:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    a696:	db 85 74 ff ff ff    	fildl  -0x8c(%ebp)
    a69c:	de c9                	fmulp  %st,%st(1)
    a69e:	dd 1c 24             	fstpl  (%esp)
    a6a1:	e8 e0 a5 ff ff       	call   4c86 <cos>
    a6a6:	dc 8d 68 ff ff ff    	fmull  -0x98(%ebp)
    a6ac:	dd 45 e0             	fldl   -0x20(%ebp)
    a6af:	de c1                	faddp  %st,%st(1)
    a6b1:	dd 5d e0             	fstpl  -0x20(%ebp)
    if(block_type == 2){
       N=12;
       for(i=0;i<3;i++){
          for(p= 0;p<N;p++){
             sum = 0.0;
             for(m=0;m<N/2;m++)
    a6b4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    a6b8:	8b 45 dc             	mov    -0x24(%ebp),%eax
    a6bb:	89 c2                	mov    %eax,%edx
    a6bd:	c1 ea 1f             	shr    $0x1f,%edx
    a6c0:	01 d0                	add    %edx,%eax
    a6c2:	d1 f8                	sar    %eax
    a6c4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    a6c7:	0f 8f 5c ff ff ff    	jg     a629 <inv_mdct+0x2cf>
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
             tmp[p] = sum * win[block_type][p] ;
    a6cd:	8b 55 10             	mov    0x10(%ebp),%edx
    a6d0:	89 d0                	mov    %edx,%eax
    a6d2:	c1 e0 03             	shl    $0x3,%eax
    a6d5:	01 d0                	add    %edx,%eax
    a6d7:	c1 e0 02             	shl    $0x2,%eax
    a6da:	8b 55 ec             	mov    -0x14(%ebp),%edx
    a6dd:	01 d0                	add    %edx,%eax
    a6df:	dd 04 c5 a0 f0 00 00 	fldl   0xf0a0(,%eax,8)
    a6e6:	dc 4d e0             	fmull  -0x20(%ebp)
    a6e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a6ec:	dd 9c c5 78 ff ff ff 	fstpl  -0x88(%ebp,%eax,8)
       out[i]=0;

    if(block_type == 2){
       N=12;
       for(i=0;i<3;i++){
          for(p= 0;p<N;p++){
    a6f3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    a6f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a6fa:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    a6fd:	0f 8c 15 ff ff ff    	jl     a618 <inv_mdct+0x2be>
             sum = 0.0;
             for(m=0;m<N/2;m++)
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
             tmp[p] = sum * win[block_type][p] ;
          }
          for(p=0;p<N;p++)
    a703:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    a70a:	eb 57                	jmp    a763 <inv_mdct+0x409>
             out[6*i+p+6] += tmp[p];
    a70c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    a70f:	89 d0                	mov    %edx,%eax
    a711:	01 c0                	add    %eax,%eax
    a713:	01 d0                	add    %edx,%eax
    a715:	01 c0                	add    %eax,%eax
    a717:	89 c2                	mov    %eax,%edx
    a719:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a71c:	01 d0                	add    %edx,%eax
    a71e:	83 c0 06             	add    $0x6,%eax
    a721:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a728:	8b 45 0c             	mov    0xc(%ebp),%eax
    a72b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    a72e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    a731:	89 d0                	mov    %edx,%eax
    a733:	01 c0                	add    %eax,%eax
    a735:	01 d0                	add    %edx,%eax
    a737:	01 c0                	add    %eax,%eax
    a739:	89 c2                	mov    %eax,%edx
    a73b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a73e:	01 d0                	add    %edx,%eax
    a740:	83 c0 06             	add    $0x6,%eax
    a743:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a74a:	8b 45 0c             	mov    0xc(%ebp),%eax
    a74d:	01 d0                	add    %edx,%eax
    a74f:	dd 00                	fldl   (%eax)
    a751:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a754:	dd 84 c5 78 ff ff ff 	fldl   -0x88(%ebp,%eax,8)
    a75b:	de c1                	faddp  %st,%st(1)
    a75d:	dd 19                	fstpl  (%ecx)
             sum = 0.0;
             for(m=0;m<N/2;m++)
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
             tmp[p] = sum * win[block_type][p] ;
          }
          for(p=0;p<N;p++)
    a75f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    a763:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a766:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    a769:	7c a1                	jl     a70c <inv_mdct+0x3b2>
    for(i=0;i<36;i++)
       out[i]=0;

    if(block_type == 2){
       N=12;
       for(i=0;i<3;i++){
    a76b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a76f:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
    a773:	0f 8e 93 fe ff ff    	jle    a60c <inv_mdct+0x2b2>
    a779:	e9 da 00 00 00       	jmp    a858 <inv_mdct+0x4fe>
          for(p=0;p<N;p++)
             out[6*i+p+6] += tmp[p];
       }
    }
    else{
      N=36;
    a77e:	c7 45 dc 24 00 00 00 	movl   $0x24,-0x24(%ebp)
      for(p= 0;p<N;p++){
    a785:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    a78c:	e9 bb 00 00 00       	jmp    a84c <inv_mdct+0x4f2>
         sum = 0.0;
    a791:	d9 ee                	fldz   
    a793:	dd 5d e0             	fstpl  -0x20(%ebp)
         for(m=0;m<N/2;m++)
    a796:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    a79d:	eb 6a                	jmp    a809 <inv_mdct+0x4af>
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
    a79f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a7a2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a7a9:	8b 45 08             	mov    0x8(%ebp),%eax
    a7ac:	01 d0                	add    %edx,%eax
    a7ae:	dd 00                	fldl   (%eax)
    a7b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a7b3:	01 c0                	add    %eax,%eax
    a7b5:	8d 50 01             	lea    0x1(%eax),%edx
    a7b8:	8b 45 dc             	mov    -0x24(%ebp),%eax
    a7bb:	89 c1                	mov    %eax,%ecx
    a7bd:	c1 e9 1f             	shr    $0x1f,%ecx
    a7c0:	01 c8                	add    %ecx,%eax
    a7c2:	d1 f8                	sar    %eax
    a7c4:	01 c2                	add    %eax,%edx
    a7c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a7c9:	01 c0                	add    %eax,%eax
    a7cb:	83 c0 01             	add    $0x1,%eax
    a7ce:	89 d1                	mov    %edx,%ecx
    a7d0:	0f af c8             	imul   %eax,%ecx
    a7d3:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    a7d8:	89 c8                	mov    %ecx,%eax
    a7da:	f7 ea                	imul   %edx
    a7dc:	c1 fa 05             	sar    $0x5,%edx
    a7df:	89 c8                	mov    %ecx,%eax
    a7e1:	c1 f8 1f             	sar    $0x1f,%eax
    a7e4:	29 c2                	sub    %eax,%edx
    a7e6:	89 d0                	mov    %edx,%eax
    a7e8:	c1 e0 03             	shl    $0x3,%eax
    a7eb:	01 d0                	add    %edx,%eax
    a7ed:	c1 e0 04             	shl    $0x4,%eax
    a7f0:	29 c1                	sub    %eax,%ecx
    a7f2:	89 ca                	mov    %ecx,%edx
    a7f4:	dd 04 d5 20 f5 00 00 	fldl   0xf520(,%edx,8)
    a7fb:	de c9                	fmulp  %st,%st(1)
    a7fd:	dd 45 e0             	fldl   -0x20(%ebp)
    a800:	de c1                	faddp  %st,%st(1)
    a802:	dd 5d e0             	fstpl  -0x20(%ebp)
    }
    else{
      N=36;
      for(p= 0;p<N;p++){
         sum = 0.0;
         for(m=0;m<N/2;m++)
    a805:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    a809:	8b 45 dc             	mov    -0x24(%ebp),%eax
    a80c:	89 c2                	mov    %eax,%edx
    a80e:	c1 ea 1f             	shr    $0x1f,%edx
    a811:	01 d0                	add    %edx,%eax
    a813:	d1 f8                	sar    %eax
    a815:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    a818:	7f 85                	jg     a79f <inv_mdct+0x445>
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
         out[p] = sum * win[block_type][p];
    a81a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a81d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a824:	8b 45 0c             	mov    0xc(%ebp),%eax
    a827:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    a82a:	8b 55 10             	mov    0x10(%ebp),%edx
    a82d:	89 d0                	mov    %edx,%eax
    a82f:	c1 e0 03             	shl    $0x3,%eax
    a832:	01 d0                	add    %edx,%eax
    a834:	c1 e0 02             	shl    $0x2,%eax
    a837:	8b 55 ec             	mov    -0x14(%ebp),%edx
    a83a:	01 d0                	add    %edx,%eax
    a83c:	dd 04 c5 a0 f0 00 00 	fldl   0xf0a0(,%eax,8)
    a843:	dc 4d e0             	fmull  -0x20(%ebp)
    a846:	dd 19                	fstpl  (%ecx)
             out[6*i+p+6] += tmp[p];
       }
    }
    else{
      N=36;
      for(p= 0;p<N;p++){
    a848:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    a84c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a84f:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    a852:	0f 8c 39 ff ff ff    	jl     a791 <inv_mdct+0x437>
         for(m=0;m<N/2;m++)
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
         out[p] = sum * win[block_type][p];
      }
    }
}
    a858:	c9                   	leave  
    a859:	c3                   	ret    

0000a85a <III_hybrid>:


void III_hybrid(double fsIn[SSLIMIT], double tsOut[SSLIMIT], int sb, int ch, struct gr_info_s *gr_info, struct frame_params *fr_ps)
/* fsIn:freq samples per subband in */
/* tsOut:time samples per subband out */
{
    a85a:	55                   	push   %ebp
    a85b:	89 e5                	mov    %esp,%ebp
    a85d:	53                   	push   %ebx
    a85e:	81 ec 54 01 00 00    	sub    $0x154,%esp
   double rawout[36];
   static double prevblck[2][SBLIMIT][SSLIMIT];
   static int init = 1;
   int bt;

   if (init) {
    a864:	a1 84 ef 00 00       	mov    0xef84,%eax
    a869:	85 c0                	test   %eax,%eax
    a86b:	74 6f                	je     a8dc <III_hybrid+0x82>
      int i,j,k;

      for(i=0;i<2;i++)
    a86d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    a874:	eb 56                	jmp    a8cc <III_hybrid+0x72>
         for(j=0;j<SBLIMIT;j++)
    a876:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    a87d:	eb 43                	jmp    a8c2 <III_hybrid+0x68>
            for(k=0;k<SSLIMIT;k++)
    a87f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    a886:	eb 30                	jmp    a8b8 <III_hybrid+0x5e>
               prevblck[i][j][k]=0.0;
    a888:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a88b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    a88e:	89 c2                	mov    %eax,%edx
    a890:	c1 e2 03             	shl    $0x3,%edx
    a893:	01 c2                	add    %eax,%edx
    a895:	8d 04 12             	lea    (%edx,%edx,1),%eax
    a898:	89 c2                	mov    %eax,%edx
    a89a:	89 c8                	mov    %ecx,%eax
    a89c:	c1 e0 03             	shl    $0x3,%eax
    a89f:	01 c8                	add    %ecx,%eax
    a8a1:	c1 e0 06             	shl    $0x6,%eax
    a8a4:	01 c2                	add    %eax,%edx
    a8a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a8a9:	01 d0                	add    %edx,%eax
    a8ab:	d9 ee                	fldz   
    a8ad:	dd 1c c5 a0 f9 00 00 	fstpl  0xf9a0(,%eax,8)
   if (init) {
      int i,j,k;

      for(i=0;i<2;i++)
         for(j=0;j<SBLIMIT;j++)
            for(k=0;k<SSLIMIT;k++)
    a8b4:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    a8b8:	83 7d e8 11          	cmpl   $0x11,-0x18(%ebp)
    a8bc:	7e ca                	jle    a888 <III_hybrid+0x2e>

   if (init) {
      int i,j,k;

      for(i=0;i<2;i++)
         for(j=0;j<SBLIMIT;j++)
    a8be:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    a8c2:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
    a8c6:	7e b7                	jle    a87f <III_hybrid+0x25>
   int bt;

   if (init) {
      int i,j,k;

      for(i=0;i<2;i++)
    a8c8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    a8cc:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    a8d0:	7e a4                	jle    a876 <III_hybrid+0x1c>
         for(j=0;j<SBLIMIT;j++)
            for(k=0;k<SSLIMIT;k++)
               prevblck[i][j][k]=0.0;
      init = 0;
    a8d2:	c7 05 84 ef 00 00 00 	movl   $0x0,0xef84
    a8d9:	00 00 00 
   }

   bt = (gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    a8dc:	8b 45 18             	mov    0x18(%ebp),%eax
    a8df:	8b 40 10             	mov    0x10(%eax),%eax
    a8e2:	85 c0                	test   %eax,%eax
    a8e4:	74 10                	je     a8f6 <III_hybrid+0x9c>
    a8e6:	8b 45 18             	mov    0x18(%ebp),%eax
    a8e9:	8b 40 18             	mov    0x18(%eax),%eax
    a8ec:	85 c0                	test   %eax,%eax
    a8ee:	74 06                	je     a8f6 <III_hybrid+0x9c>
    a8f0:	83 7d 10 01          	cmpl   $0x1,0x10(%ebp)
    a8f4:	7e 08                	jle    a8fe <III_hybrid+0xa4>
          (sb < 2)) ? 0 : gr_info->block_type;
    a8f6:	8b 45 18             	mov    0x18(%ebp),%eax
    a8f9:	8b 40 14             	mov    0x14(%eax),%eax
            for(k=0;k<SSLIMIT;k++)
               prevblck[i][j][k]=0.0;
      init = 0;
   }

   bt = (gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    a8fc:	eb 05                	jmp    a903 <III_hybrid+0xa9>
    a8fe:	b8 00 00 00 00       	mov    $0x0,%eax
    a903:	89 45 e4             	mov    %eax,-0x1c(%ebp)
          (sb < 2)) ? 0 : gr_info->block_type;

   inv_mdct( fsIn, rawout, bt);
    a906:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    a909:	89 44 24 08          	mov    %eax,0x8(%esp)
    a90d:	8d 85 c0 fe ff ff    	lea    -0x140(%ebp),%eax
    a913:	89 44 24 04          	mov    %eax,0x4(%esp)
    a917:	8b 45 08             	mov    0x8(%ebp),%eax
    a91a:	89 04 24             	mov    %eax,(%esp)
    a91d:	e8 38 fa ff ff       	call   a35a <inv_mdct>

   /* overlap addition */
   for(ss=0; ss<SSLIMIT; ss++) {
    a922:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a929:	e9 83 00 00 00       	jmp    a9b1 <III_hybrid+0x157>
      tsOut[ss] = rawout[ss] + prevblck[ch][sb][ss];
    a92e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a931:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a938:	8b 45 0c             	mov    0xc(%ebp),%eax
    a93b:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    a93e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a941:	dd 84 c5 c0 fe ff ff 	fldl   -0x140(%ebp,%eax,8)
    a948:	8b 45 10             	mov    0x10(%ebp),%eax
    a94b:	8b 4d 14             	mov    0x14(%ebp),%ecx
    a94e:	89 c2                	mov    %eax,%edx
    a950:	c1 e2 03             	shl    $0x3,%edx
    a953:	01 c2                	add    %eax,%edx
    a955:	8d 04 12             	lea    (%edx,%edx,1),%eax
    a958:	89 c2                	mov    %eax,%edx
    a95a:	89 c8                	mov    %ecx,%eax
    a95c:	c1 e0 03             	shl    $0x3,%eax
    a95f:	01 c8                	add    %ecx,%eax
    a961:	c1 e0 06             	shl    $0x6,%eax
    a964:	01 c2                	add    %eax,%edx
    a966:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a969:	01 d0                	add    %edx,%eax
    a96b:	dd 04 c5 a0 f9 00 00 	fldl   0xf9a0(,%eax,8)
    a972:	de c1                	faddp  %st,%st(1)
    a974:	dd 1b                	fstpl  (%ebx)
      prevblck[ch][sb][ss] = rawout[ss+18];
    a976:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a979:	83 c0 12             	add    $0x12,%eax
    a97c:	dd 84 c5 c0 fe ff ff 	fldl   -0x140(%ebp,%eax,8)
    a983:	8b 45 10             	mov    0x10(%ebp),%eax
    a986:	8b 4d 14             	mov    0x14(%ebp),%ecx
    a989:	89 c2                	mov    %eax,%edx
    a98b:	c1 e2 03             	shl    $0x3,%edx
    a98e:	01 c2                	add    %eax,%edx
    a990:	8d 04 12             	lea    (%edx,%edx,1),%eax
    a993:	89 c2                	mov    %eax,%edx
    a995:	89 c8                	mov    %ecx,%eax
    a997:	c1 e0 03             	shl    $0x3,%eax
    a99a:	01 c8                	add    %ecx,%eax
    a99c:	c1 e0 06             	shl    $0x6,%eax
    a99f:	01 c2                	add    %eax,%edx
    a9a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a9a4:	01 d0                	add    %edx,%eax
    a9a6:	dd 1c c5 a0 f9 00 00 	fstpl  0xf9a0(,%eax,8)
          (sb < 2)) ? 0 : gr_info->block_type;

   inv_mdct( fsIn, rawout, bt);

   /* overlap addition */
   for(ss=0; ss<SSLIMIT; ss++) {
    a9ad:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a9b1:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    a9b5:	0f 8e 73 ff ff ff    	jle    a92e <III_hybrid+0xd4>
      tsOut[ss] = rawout[ss] + prevblck[ch][sb][ss];
      prevblck[ch][sb][ss] = rawout[ss+18];
   }
}
    a9bb:	81 c4 54 01 00 00    	add    $0x154,%esp
    a9c1:	5b                   	pop    %ebx
    a9c2:	5d                   	pop    %ebp
    a9c3:	c3                   	ret    

0000a9c4 <create_syn_filter>:


/* create in synthesis filter */
void create_syn_filter(double filter[64][SBLIMIT])
{
    a9c4:	55                   	push   %ebp
    a9c5:	89 e5                	mov    %esp,%ebp
    a9c7:	57                   	push   %edi
    a9c8:	56                   	push   %esi
    a9c9:	53                   	push   %ebx
    a9ca:	83 ec 1c             	sub    $0x1c,%esp
	register int i,k;

	for (i=0; i<64; i++)
    a9cd:	be 00 00 00 00       	mov    $0x0,%esi
    a9d2:	e9 1c 01 00 00       	jmp    aaf3 <create_syn_filter+0x12f>
		for (k=0; k<32; k++) {
    a9d7:	bb 00 00 00 00       	mov    $0x0,%ebx
    a9dc:	e9 06 01 00 00       	jmp    aae7 <create_syn_filter+0x123>
			if ((filter[i][k] = 1e9*cos((double)((PI64*i+PI4)*(2*k+1)))) >= 0)
    a9e1:	89 f0                	mov    %esi,%eax
    a9e3:	c1 e0 08             	shl    $0x8,%eax
    a9e6:	89 c2                	mov    %eax,%edx
    a9e8:	8b 45 08             	mov    0x8(%ebp),%eax
    a9eb:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    a9ee:	89 75 e0             	mov    %esi,-0x20(%ebp)
    a9f1:	db 45 e0             	fildl  -0x20(%ebp)
    a9f4:	dd 05 a0 da 00 00    	fldl   0xdaa0
    a9fa:	de c9                	fmulp  %st,%st(1)
    a9fc:	dd 05 a8 da 00 00    	fldl   0xdaa8
    aa02:	de c1                	faddp  %st,%st(1)
    aa04:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
    aa07:	83 c0 01             	add    $0x1,%eax
    aa0a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    aa0d:	db 45 e0             	fildl  -0x20(%ebp)
    aa10:	de c9                	fmulp  %st,%st(1)
    aa12:	dd 1c 24             	fstpl  (%esp)
    aa15:	e8 6c a2 ff ff       	call   4c86 <cos>
    aa1a:	dd 05 b0 da 00 00    	fldl   0xdab0
    aa20:	de c9                	fmulp  %st,%st(1)
    aa22:	dd 1c df             	fstpl  (%edi,%ebx,8)
    aa25:	dd 04 df             	fldl   (%edi,%ebx,8)
    aa28:	d9 ee                	fldz   
    aa2a:	d9 c9                	fxch   %st(1)
    aa2c:	df e9                	fucomip %st(1),%st
    aa2e:	dd d8                	fstp   %st(0)
    aa30:	72 47                	jb     aa79 <create_syn_filter+0xb5>
				filter[i][k] = (int)(filter[i][k]+0.5);
    aa32:	89 f0                	mov    %esi,%eax
    aa34:	c1 e0 08             	shl    $0x8,%eax
    aa37:	89 c2                	mov    %eax,%edx
    aa39:	8b 45 08             	mov    0x8(%ebp),%eax
    aa3c:	01 c2                	add    %eax,%edx
    aa3e:	89 f0                	mov    %esi,%eax
    aa40:	c1 e0 08             	shl    $0x8,%eax
    aa43:	89 c1                	mov    %eax,%ecx
    aa45:	8b 45 08             	mov    0x8(%ebp),%eax
    aa48:	01 c8                	add    %ecx,%eax
    aa4a:	dd 04 d8             	fldl   (%eax,%ebx,8)
    aa4d:	dd 05 70 da 00 00    	fldl   0xda70
    aa53:	de c1                	faddp  %st,%st(1)
    aa55:	d9 7d e6             	fnstcw -0x1a(%ebp)
    aa58:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    aa5c:	b4 0c                	mov    $0xc,%ah
    aa5e:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    aa62:	d9 6d e4             	fldcw  -0x1c(%ebp)
    aa65:	db 5d e0             	fistpl -0x20(%ebp)
    aa68:	d9 6d e6             	fldcw  -0x1a(%ebp)
    aa6b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    aa6e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    aa71:	db 45 e0             	fildl  -0x20(%ebp)
    aa74:	dd 1c da             	fstpl  (%edx,%ebx,8)
    aa77:	eb 45                	jmp    aabe <create_syn_filter+0xfa>
				//modf(filter[i][k]+0.5, &filter[i][k]);
			else
				filter[i][k] = (int)(filter[i][k]-0.5);
    aa79:	89 f0                	mov    %esi,%eax
    aa7b:	c1 e0 08             	shl    $0x8,%eax
    aa7e:	89 c2                	mov    %eax,%edx
    aa80:	8b 45 08             	mov    0x8(%ebp),%eax
    aa83:	01 c2                	add    %eax,%edx
    aa85:	89 f0                	mov    %esi,%eax
    aa87:	c1 e0 08             	shl    $0x8,%eax
    aa8a:	89 c1                	mov    %eax,%ecx
    aa8c:	8b 45 08             	mov    0x8(%ebp),%eax
    aa8f:	01 c8                	add    %ecx,%eax
    aa91:	dd 04 d8             	fldl   (%eax,%ebx,8)
    aa94:	dd 05 70 da 00 00    	fldl   0xda70
    aa9a:	de e9                	fsubrp %st,%st(1)
    aa9c:	d9 7d e6             	fnstcw -0x1a(%ebp)
    aa9f:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    aaa3:	b4 0c                	mov    $0xc,%ah
    aaa5:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    aaa9:	d9 6d e4             	fldcw  -0x1c(%ebp)
    aaac:	db 5d e0             	fistpl -0x20(%ebp)
    aaaf:	d9 6d e6             	fldcw  -0x1a(%ebp)
    aab2:	8b 45 e0             	mov    -0x20(%ebp),%eax
    aab5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    aab8:	db 45 e0             	fildl  -0x20(%ebp)
    aabb:	dd 1c da             	fstpl  (%edx,%ebx,8)
				//modf(filter[i][k]-0.5, &filter[i][k]);
			filter[i][k] *= 1e-9;
    aabe:	89 f0                	mov    %esi,%eax
    aac0:	c1 e0 08             	shl    $0x8,%eax
    aac3:	89 c2                	mov    %eax,%edx
    aac5:	8b 45 08             	mov    0x8(%ebp),%eax
    aac8:	01 d0                	add    %edx,%eax
    aaca:	89 f2                	mov    %esi,%edx
    aacc:	89 d1                	mov    %edx,%ecx
    aace:	c1 e1 08             	shl    $0x8,%ecx
    aad1:	8b 55 08             	mov    0x8(%ebp),%edx
    aad4:	01 ca                	add    %ecx,%edx
    aad6:	dd 04 da             	fldl   (%edx,%ebx,8)
    aad9:	dd 05 b8 da 00 00    	fldl   0xdab8
    aadf:	de c9                	fmulp  %st,%st(1)
    aae1:	dd 1c d8             	fstpl  (%eax,%ebx,8)
void create_syn_filter(double filter[64][SBLIMIT])
{
	register int i,k;

	for (i=0; i<64; i++)
		for (k=0; k<32; k++) {
    aae4:	83 c3 01             	add    $0x1,%ebx
    aae7:	83 fb 1f             	cmp    $0x1f,%ebx
    aaea:	0f 8e f1 fe ff ff    	jle    a9e1 <create_syn_filter+0x1d>
/* create in synthesis filter */
void create_syn_filter(double filter[64][SBLIMIT])
{
	register int i,k;

	for (i=0; i<64; i++)
    aaf0:	83 c6 01             	add    $0x1,%esi
    aaf3:	83 fe 3f             	cmp    $0x3f,%esi
    aaf6:	0f 8e db fe ff ff    	jle    a9d7 <create_syn_filter+0x13>
			else
				filter[i][k] = (int)(filter[i][k]-0.5);
				//modf(filter[i][k]-0.5, &filter[i][k]);
			filter[i][k] *= 1e-9;
		}
}
    aafc:	83 c4 1c             	add    $0x1c,%esp
    aaff:	5b                   	pop    %ebx
    ab00:	5e                   	pop    %esi
    ab01:	5f                   	pop    %edi
    ab02:	5d                   	pop    %ebp
    ab03:	c3                   	ret    

0000ab04 <read_syn_window>:



/* read in synthesis window */
void read_syn_window(double window[HAN_SIZE])
{
    ab04:	55                   	push   %ebp
    ab05:	89 e5                	mov    %esp,%ebp
    ab07:	57                   	push   %edi
    ab08:	56                   	push   %esi
    ab09:	53                   	push   %ebx
    ab0a:	81 ec 14 10 00 00    	sub    $0x1014,%esp
	double gb_window[HAN_SIZE] = {0.0000000000, -0.0000152590, -0.0000152590, -0.0000152590,
    ab10:	8d 95 e8 ef ff ff    	lea    -0x1018(%ebp),%edx
    ab16:	bb 20 ca 00 00       	mov    $0xca20,%ebx
    ab1b:	b8 00 04 00 00       	mov    $0x400,%eax
    ab20:	89 d7                	mov    %edx,%edi
    ab22:	89 de                	mov    %ebx,%esi
    ab24:	89 c1                	mov    %eax,%ecx
    ab26:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		0.0000762940, 0.0000762940, 0.0000610350, 0.0000610350,
		0.0000457760, 0.0000457760, 0.0000305180, 0.0000305180,
		0.0000305180, 0.0000305180, 0.0000152590, 0.0000152590,
		0.0000152590, 0.0000152590, 0.0000152590, 0.0000152590,
	};
	window = gb_window;
    ab28:	8d 85 e8 ef ff ff    	lea    -0x1018(%ebp),%eax
    ab2e:	89 45 ec             	mov    %eax,-0x14(%ebp)
}
    ab31:	81 c4 14 10 00 00    	add    $0x1014,%esp
    ab37:	5b                   	pop    %ebx
    ab38:	5e                   	pop    %esi
    ab39:	5f                   	pop    %edi
    ab3a:	5d                   	pop    %ebp
    ab3b:	c3                   	ret    

0000ab3c <SubBandSynthesis>:

int SubBandSynthesis (double *bandPtr, int channel, short *samples)
{
    ab3c:	55                   	push   %ebp
    ab3d:	89 e5                	mov    %esp,%ebp
    ab3f:	57                   	push   %edi
    ab40:	56                   	push   %esi
    ab41:	53                   	push   %ebx
    ab42:	83 ec 2c             	sub    $0x2c,%esp
	static NN *filter;
	typedef double BB[2][2*HAN_SIZE];
	static BB *buf;
	static int bufOffset[2] = {64,64};
	static double *window;
	int clip = 0;               /* count & return how many samples clipped */
    ab45:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	if (init) {
    ab4c:	a1 88 ef 00 00       	mov    0xef88,%eax
    ab51:	85 c0                	test   %eax,%eax
    ab53:	74 6f                	je     abc4 <SubBandSynthesis+0x88>
		buf = (BB *) mem_alloc(sizeof(BB),"BB");
    ab55:	c7 44 24 04 20 da 00 	movl   $0xda20,0x4(%esp)
    ab5c:	00 
    ab5d:	c7 04 24 00 40 00 00 	movl   $0x4000,(%esp)
    ab64:	e8 15 a8 ff ff       	call   537e <mem_alloc>
    ab69:	a3 a0 1d 01 00       	mov    %eax,0x11da0
		filter = (NN *) mem_alloc(sizeof(NN), "NN");
    ab6e:	c7 44 24 04 23 da 00 	movl   $0xda23,0x4(%esp)
    ab75:	00 
    ab76:	c7 04 24 00 40 00 00 	movl   $0x4000,(%esp)
    ab7d:	e8 fc a7 ff ff       	call   537e <mem_alloc>
    ab82:	a3 a4 1d 01 00       	mov    %eax,0x11da4
		create_syn_filter(*filter);
    ab87:	a1 a4 1d 01 00       	mov    0x11da4,%eax
    ab8c:	89 04 24             	mov    %eax,(%esp)
    ab8f:	e8 30 fe ff ff       	call   a9c4 <create_syn_filter>
		window = (double *) mem_alloc(sizeof(double) * HAN_SIZE, "WIN");
    ab94:	c7 44 24 04 26 da 00 	movl   $0xda26,0x4(%esp)
    ab9b:	00 
    ab9c:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    aba3:	e8 d6 a7 ff ff       	call   537e <mem_alloc>
    aba8:	a3 a8 1d 01 00       	mov    %eax,0x11da8
		read_syn_window(window);
    abad:	a1 a8 1d 01 00       	mov    0x11da8,%eax
    abb2:	89 04 24             	mov    %eax,(%esp)
    abb5:	e8 4a ff ff ff       	call   ab04 <read_syn_window>
		init = 0;
    abba:	c7 05 88 ef 00 00 00 	movl   $0x0,0xef88
    abc1:	00 00 00 
	}
/*    if (channel == 0) */
	bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
    abc4:	8b 45 0c             	mov    0xc(%ebp),%eax
    abc7:	8b 04 85 8c ef 00 00 	mov    0xef8c(,%eax,4),%eax
    abce:	83 e8 40             	sub    $0x40,%eax
    abd1:	25 ff 03 00 00       	and    $0x3ff,%eax
    abd6:	89 c2                	mov    %eax,%edx
    abd8:	8b 45 0c             	mov    0xc(%ebp),%eax
    abdb:	89 14 85 8c ef 00 00 	mov    %edx,0xef8c(,%eax,4)
	bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);
    abe2:	8b 15 a0 1d 01 00    	mov    0x11da0,%edx
    abe8:	8b 45 0c             	mov    0xc(%ebp),%eax
    abeb:	8b 04 85 8c ef 00 00 	mov    0xef8c(,%eax,4),%eax
    abf2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    abf5:	c1 e1 0a             	shl    $0xa,%ecx
    abf8:	01 c8                	add    %ecx,%eax
    abfa:	c1 e0 03             	shl    $0x3,%eax
    abfd:	8d 3c 02             	lea    (%edx,%eax,1),%edi

	for (i=0; i<64; i++) {
    ac00:	bb 00 00 00 00       	mov    $0x0,%ebx
    ac05:	eb 40                	jmp    ac47 <SubBandSynthesis+0x10b>
		sum = 0;
    ac07:	d9 ee                	fldz   
		for (k=0; k<32; k++)
    ac09:	be 00 00 00 00       	mov    $0x0,%esi
    ac0e:	eb 26                	jmp    ac36 <SubBandSynthesis+0xfa>
			sum += bandPtr[k] * (*filter)[i][k];
    ac10:	89 f0                	mov    %esi,%eax
    ac12:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    ac19:	8b 45 08             	mov    0x8(%ebp),%eax
    ac1c:	01 d0                	add    %edx,%eax
    ac1e:	dd 00                	fldl   (%eax)
    ac20:	a1 a4 1d 01 00       	mov    0x11da4,%eax
    ac25:	89 da                	mov    %ebx,%edx
    ac27:	c1 e2 05             	shl    $0x5,%edx
    ac2a:	01 f2                	add    %esi,%edx
    ac2c:	dd 04 d0             	fldl   (%eax,%edx,8)
    ac2f:	de c9                	fmulp  %st,%st(1)
    ac31:	de c1                	faddp  %st,%st(1)
	bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
	bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);

	for (i=0; i<64; i++) {
		sum = 0;
		for (k=0; k<32; k++)
    ac33:	83 c6 01             	add    $0x1,%esi
    ac36:	83 fe 1f             	cmp    $0x1f,%esi
    ac39:	7e d5                	jle    ac10 <SubBandSynthesis+0xd4>
			sum += bandPtr[k] * (*filter)[i][k];
		bufOffsetPtr[i] = sum;
    ac3b:	89 d8                	mov    %ebx,%eax
    ac3d:	c1 e0 03             	shl    $0x3,%eax
    ac40:	01 f8                	add    %edi,%eax
    ac42:	dd 18                	fstpl  (%eax)
	}
/*    if (channel == 0) */
	bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
	bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);

	for (i=0; i<64; i++) {
    ac44:	83 c3 01             	add    $0x1,%ebx
    ac47:	83 fb 3f             	cmp    $0x3f,%ebx
    ac4a:	7e bb                	jle    ac07 <SubBandSynthesis+0xcb>
			sum += bandPtr[k] * (*filter)[i][k];
		bufOffsetPtr[i] = sum;
	}
	/*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
    ac4c:	bf 00 00 00 00       	mov    $0x0,%edi
    ac51:	e9 c7 00 00 00       	jmp    ad1d <SubBandSynthesis+0x1e1>
		sum = 0;
    ac56:	d9 ee                	fldz   
		for (i=0; i<16; i++) {
    ac58:	bb 00 00 00 00       	mov    $0x0,%ebx
    ac5d:	eb 4c                	jmp    acab <SubBandSynthesis+0x16f>
			k = j + (i<<5);
    ac5f:	89 d8                	mov    %ebx,%eax
    ac61:	c1 e0 05             	shl    $0x5,%eax
    ac64:	8d 34 38             	lea    (%eax,%edi,1),%esi
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
    ac67:	a1 a8 1d 01 00       	mov    0x11da8,%eax
    ac6c:	89 f2                	mov    %esi,%edx
    ac6e:	c1 e2 03             	shl    $0x3,%edx
    ac71:	01 d0                	add    %edx,%eax
    ac73:	dd 00                	fldl   (%eax)
    ac75:	a1 a0 1d 01 00       	mov    0x11da0,%eax
    ac7a:	8d 53 01             	lea    0x1(%ebx),%edx
    ac7d:	d1 fa                	sar    %edx
    ac7f:	c1 e2 06             	shl    $0x6,%edx
    ac82:	8d 0c 32             	lea    (%edx,%esi,1),%ecx
												bufOffset[channel]) & 0x3ff];
    ac85:	8b 55 0c             	mov    0xc(%ebp),%edx
    ac88:	8b 14 95 8c ef 00 00 	mov    0xef8c(,%edx,4),%edx
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
		sum = 0;
		for (i=0; i<16; i++) {
			k = j + (i<<5);
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
    ac8f:	01 ca                	add    %ecx,%edx
												bufOffset[channel]) & 0x3ff];
    ac91:	89 d1                	mov    %edx,%ecx
    ac93:	81 e1 ff 03 00 00    	and    $0x3ff,%ecx
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
		sum = 0;
		for (i=0; i<16; i++) {
			k = j + (i<<5);
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
    ac99:	8b 55 0c             	mov    0xc(%ebp),%edx
    ac9c:	c1 e2 0a             	shl    $0xa,%edx
    ac9f:	01 ca                	add    %ecx,%edx
    aca1:	dd 04 d0             	fldl   (%eax,%edx,8)
    aca4:	de c9                	fmulp  %st,%st(1)
    aca6:	de c1                	faddp  %st,%st(1)
	}
	/*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
		sum = 0;
		for (i=0; i<16; i++) {
    aca8:	83 c3 01             	add    $0x1,%ebx
    acab:	83 fb 0f             	cmp    $0xf,%ebx
    acae:	7e af                	jle    ac5f <SubBandSynthesis+0x123>
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
												bufOffset[channel]) & 0x3ff];
		}
		{
			/*long foo = (sum > 0) ? sum * SCALE + 0.5 : sum * SCALE - 0.5; */
			long foo = sum * SCALE;
    acb0:	dd 05 c0 da 00 00    	fldl   0xdac0
    acb6:	de c9                	fmulp  %st,%st(1)
    acb8:	d9 7d d6             	fnstcw -0x2a(%ebp)
    acbb:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    acbf:	b4 0c                	mov    $0xc,%ah
    acc1:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    acc5:	d9 6d d4             	fldcw  -0x2c(%ebp)
    acc8:	db 5d e0             	fistpl -0x20(%ebp)
    accb:	d9 6d d6             	fldcw  -0x2a(%ebp)
			if (foo >= (long) SCALE)      {samples[j] = SCALE-1; ++clip;}
    acce:	81 7d e0 ff 7f 00 00 	cmpl   $0x7fff,-0x20(%ebp)
    acd5:	7e 15                	jle    acec <SubBandSynthesis+0x1b0>
    acd7:	89 f8                	mov    %edi,%eax
    acd9:	8d 14 00             	lea    (%eax,%eax,1),%edx
    acdc:	8b 45 10             	mov    0x10(%ebp),%eax
    acdf:	01 d0                	add    %edx,%eax
    ace1:	66 c7 00 ff 7f       	movw   $0x7fff,(%eax)
    ace6:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    acea:	eb 2e                	jmp    ad1a <SubBandSynthesis+0x1de>
			else if (foo < (long) -SCALE) {samples[j] = -SCALE;  ++clip;}
    acec:	81 7d e0 00 80 ff ff 	cmpl   $0xffff8000,-0x20(%ebp)
    acf3:	7d 15                	jge    ad0a <SubBandSynthesis+0x1ce>
    acf5:	89 f8                	mov    %edi,%eax
    acf7:	8d 14 00             	lea    (%eax,%eax,1),%edx
    acfa:	8b 45 10             	mov    0x10(%ebp),%eax
    acfd:	01 d0                	add    %edx,%eax
    acff:	66 c7 00 00 80       	movw   $0x8000,(%eax)
    ad04:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    ad08:	eb 10                	jmp    ad1a <SubBandSynthesis+0x1de>
			else                           samples[j] = foo;
    ad0a:	89 f8                	mov    %edi,%eax
    ad0c:	8d 14 00             	lea    (%eax,%eax,1),%edx
    ad0f:	8b 45 10             	mov    0x10(%ebp),%eax
    ad12:	01 c2                	add    %eax,%edx
    ad14:	8b 45 e0             	mov    -0x20(%ebp),%eax
    ad17:	66 89 02             	mov    %ax,(%edx)
			sum += bandPtr[k] * (*filter)[i][k];
		bufOffsetPtr[i] = sum;
	}
	/*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
    ad1a:	83 c7 01             	add    $0x1,%edi
    ad1d:	83 ff 1f             	cmp    $0x1f,%edi
    ad20:	0f 8e 30 ff ff ff    	jle    ac56 <SubBandSynthesis+0x11a>
			if (foo >= (long) SCALE)      {samples[j] = SCALE-1; ++clip;}
			else if (foo < (long) -SCALE) {samples[j] = -SCALE;  ++clip;}
			else                           samples[j] = foo;
		}
	}
    return(clip);
    ad26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
    ad29:	83 c4 2c             	add    $0x2c,%esp
    ad2c:	5b                   	pop    %ebx
    ad2d:	5e                   	pop    %esi
    ad2e:	5f                   	pop    %edi
    ad2f:	5d                   	pop    %ebp
    ad30:	c3                   	ret    

0000ad31 <out_fifo>:

void out_fifo(short pcm_sample[2][SSLIMIT][SBLIMIT], int num, struct frame_params *fr_ps, unsigned long *psampFrames)
{
    ad31:	55                   	push   %ebp
    ad32:	89 e5                	mov    %esp,%ebp
    ad34:	83 ec 10             	sub    $0x10,%esp
	int i,j,l;
	int stereo = fr_ps->stereo;
    ad37:	8b 45 10             	mov    0x10(%ebp),%eax
    ad3a:	8b 40 08             	mov    0x8(%eax),%eax
    ad3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	//int sblimit = fr_ps->sblimit;
	static long k = 0;

        for (i=0;i<num;i++) for (j=0;j<SBLIMIT;j++) {
    ad40:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    ad47:	eb 75                	jmp    adbe <out_fifo+0x8d>
    ad49:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    ad50:	eb 62                	jmp    adb4 <out_fifo+0x83>
            (*psampFrames)++;
    ad52:	8b 45 14             	mov    0x14(%ebp),%eax
    ad55:	8b 00                	mov    (%eax),%eax
    ad57:	8d 50 01             	lea    0x1(%eax),%edx
    ad5a:	8b 45 14             	mov    0x14(%ebp),%eax
    ad5d:	89 10                	mov    %edx,(%eax)
            for (l=0;l<stereo;l++) {
    ad5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    ad66:	eb 40                	jmp    ada8 <out_fifo+0x77>
                if (!(k%1600) && k) {
    ad68:	8b 0d ac 1d 01 00    	mov    0x11dac,%ecx
    ad6e:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    ad73:	89 c8                	mov    %ecx,%eax
    ad75:	f7 ea                	imul   %edx
    ad77:	c1 fa 09             	sar    $0x9,%edx
    ad7a:	89 c8                	mov    %ecx,%eax
    ad7c:	c1 f8 1f             	sar    $0x1f,%eax
    ad7f:	29 c2                	sub    %eax,%edx
    ad81:	89 d0                	mov    %edx,%eax
    ad83:	69 c0 40 06 00 00    	imul   $0x640,%eax,%eax
    ad89:	29 c1                	sub    %eax,%ecx
    ad8b:	89 c8                	mov    %ecx,%eax
    ad8d:	85 c0                	test   %eax,%eax
    ad8f:	75 13                	jne    ada4 <out_fifo+0x73>
    ad91:	a1 ac 1d 01 00       	mov    0x11dac,%eax
    ad96:	85 c0                	test   %eax,%eax
    ad98:	74 0a                	je     ada4 <out_fifo+0x73>
                    //fwrite(outsamp,2,1600,outFile);
                    k = 0;
    ad9a:	c7 05 ac 1d 01 00 00 	movl   $0x0,0x11dac
    ada1:	00 00 00 
	//int sblimit = fr_ps->sblimit;
	static long k = 0;

        for (i=0;i<num;i++) for (j=0;j<SBLIMIT;j++) {
            (*psampFrames)++;
            for (l=0;l<stereo;l++) {
    ada4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    ada8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    adab:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    adae:	7c b8                	jl     ad68 <out_fifo+0x37>
	int i,j,l;
	int stereo = fr_ps->stereo;
	//int sblimit = fr_ps->sblimit;
	static long k = 0;

        for (i=0;i<num;i++) for (j=0;j<SBLIMIT;j++) {
    adb0:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    adb4:	83 7d f8 1f          	cmpl   $0x1f,-0x8(%ebp)
    adb8:	7e 98                	jle    ad52 <out_fifo+0x21>
    adba:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    adbe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    adc1:	3b 45 0c             	cmp    0xc(%ebp),%eax
    adc4:	7c 83                	jl     ad49 <out_fifo+0x18>
                    k = 0;
                }
                //outsamp[k++] = pcm_sample[l][i][j];
            }
        }
}
    adc6:	c9                   	leave  
    adc7:	c3                   	ret    

0000adc8 <buffer_CRC>:


void  buffer_CRC(Bit_stream_struc *bs, unsigned int *old_crc)
{
    adc8:	55                   	push   %ebp
    adc9:	89 e5                	mov    %esp,%ebp
    adcb:	83 ec 18             	sub    $0x18,%esp
    *old_crc = getbits(bs, 16);
    adce:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
    add5:	00 
    add6:	8b 45 08             	mov    0x8(%ebp),%eax
    add9:	89 04 24             	mov    %eax,(%esp)
    addc:	e8 8b a8 ff ff       	call   566c <getbits>
    ade1:	8b 55 0c             	mov    0xc(%ebp),%edx
    ade4:	89 02                	mov    %eax,(%edx)
}
    ade6:	c9                   	leave  
    ade7:	c3                   	ret    

0000ade8 <main_data_slots>:

extern int bitrate[3][15];
extern double s_freq[4];
/* Return the number of slots for main data of current frame, */
int main_data_slots(struct frame_params fr_ps)
{
    ade8:	55                   	push   %ebp
    ade9:	89 e5                	mov    %esp,%ebp
    adeb:	83 ec 18             	sub    $0x18,%esp
	int nSlots;

	nSlots = (144 * bitrate[2][fr_ps.header->bitrate_index])
    adee:	8b 45 08             	mov    0x8(%ebp),%eax
    adf1:	8b 40 0c             	mov    0xc(%eax),%eax
    adf4:	83 c0 1e             	add    $0x1e,%eax
    adf7:	8b 14 85 e0 ea 00 00 	mov    0xeae0(,%eax,4),%edx
    adfe:	89 d0                	mov    %edx,%eax
    ae00:	c1 e0 03             	shl    $0x3,%eax
    ae03:	01 d0                	add    %edx,%eax
    ae05:	c1 e0 04             	shl    $0x4,%eax
			/ s_freq[fr_ps.header->sampling_frequency];
    ae08:	89 45 ec             	mov    %eax,-0x14(%ebp)
    ae0b:	db 45 ec             	fildl  -0x14(%ebp)
    ae0e:	8b 45 08             	mov    0x8(%ebp),%eax
    ae11:	8b 40 10             	mov    0x10(%eax),%eax
    ae14:	dd 04 c5 a0 eb 00 00 	fldl   0xeba0(,%eax,8)
    ae1b:	de f9                	fdivrp %st,%st(1)
/* Return the number of slots for main data of current frame, */
int main_data_slots(struct frame_params fr_ps)
{
	int nSlots;

	nSlots = (144 * bitrate[2][fr_ps.header->bitrate_index])
    ae1d:	d9 7d ea             	fnstcw -0x16(%ebp)
    ae20:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
    ae24:	b4 0c                	mov    $0xc,%ah
    ae26:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
    ae2a:	d9 6d e8             	fldcw  -0x18(%ebp)
    ae2d:	db 5d fc             	fistpl -0x4(%ebp)
    ae30:	d9 6d ea             	fldcw  -0x16(%ebp)
			/ s_freq[fr_ps.header->sampling_frequency];
	if (fr_ps.header->padding) nSlots++;
    ae33:	8b 45 08             	mov    0x8(%ebp),%eax
    ae36:	8b 40 14             	mov    0x14(%eax),%eax
    ae39:	85 c0                	test   %eax,%eax
    ae3b:	74 04                	je     ae41 <main_data_slots+0x59>
    ae3d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
	nSlots -= 4;
    ae41:	83 6d fc 04          	subl   $0x4,-0x4(%ebp)
	if (fr_ps.header->error_protection)
    ae45:	8b 45 08             	mov    0x8(%ebp),%eax
    ae48:	8b 40 08             	mov    0x8(%eax),%eax
    ae4b:	85 c0                	test   %eax,%eax
    ae4d:	74 04                	je     ae53 <main_data_slots+0x6b>
		nSlots -= 2;
    ae4f:	83 6d fc 02          	subl   $0x2,-0x4(%ebp)
	if (fr_ps.stereo == 1)
    ae53:	8b 45 10             	mov    0x10(%ebp),%eax
    ae56:	83 f8 01             	cmp    $0x1,%eax
    ae59:	75 06                	jne    ae61 <main_data_slots+0x79>
		nSlots -= 17;
    ae5b:	83 6d fc 11          	subl   $0x11,-0x4(%ebp)
    ae5f:	eb 04                	jmp    ae65 <main_data_slots+0x7d>
	else
		nSlots -=32;
    ae61:	83 6d fc 20          	subl   $0x20,-0x4(%ebp)
	return(nSlots);
    ae65:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    ae68:	c9                   	leave  
    ae69:	c3                   	ret    
