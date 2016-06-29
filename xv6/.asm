
_picviewer:     file format elf32-i386


Disassembly of section .text:

00000000 <Initialize>:
void drawPicViewerContent(Context context, char* fileName);
void updateWindowWithoutBlank(Context context);

//Initialize
void Initialize(Context context)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
	startXsave = (context.width-pic.width) >> 1;
       3:	8b 55 0c             	mov    0xc(%ebp),%edx
       6:	a1 44 25 01 00       	mov    0x12544,%eax
       b:	29 c2                	sub    %eax,%edx
       d:	89 d0                	mov    %edx,%eax
       f:	d1 f8                	sar    %eax
      11:	a3 24 f7 00 00       	mov    %eax,0xf724
	startYsave = TOPBAR_HEIGHT + ((context.height-pic.height) >> 1);
      16:	8b 55 10             	mov    0x10(%ebp),%edx
      19:	a1 48 25 01 00       	mov    0x12548,%eax
      1e:	29 c2                	sub    %eax,%edx
      20:	89 d0                	mov    %edx,%eax
      22:	d1 f8                	sar    %eax
      24:	83 c0 14             	add    $0x14,%eax
      27:	a3 28 f7 00 00       	mov    %eax,0xf728
}
      2c:	5d                   	pop    %ebp
      2d:	c3                   	ret    

0000002e <compressPic>:

// 压缩图片
void compressPic(int width, int height) {
      2e:	55                   	push   %ebp
      2f:	89 e5                	mov    %esp,%ebp
      31:	81 ec 98 00 00 00    	sub    $0x98,%esp
    int x0, y0, x1, x2, y1, y2;
    float fx1, fx2, fy1, fy2;
    int x, y, index;
    RGBQUAD* data;

    w0 = pic.width;//图宽
      37:	a1 44 25 01 00       	mov    0x12544,%eax
      3c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    h0 = pic.height;//图高
      3f:	a1 48 25 01 00       	mov    0x12548,%eax
      44:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    w1 = width;//设定宽
      47:	8b 45 08             	mov    0x8(%ebp),%eax
      4a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    h1 = height;//设定高
      4d:	8b 45 0c             	mov    0xc(%ebp),%eax
      50:	89 45 dc             	mov    %eax,-0x24(%ebp)

    fw = w0 * 1.0 / w1;//宽缩比
      53:	db 45 e8             	fildl  -0x18(%ebp)
      56:	db 45 e0             	fildl  -0x20(%ebp)
      59:	de f9                	fdivrp %st,%st(1)
      5b:	d9 5d d8             	fstps  -0x28(%ebp)
    fh = h0 * 1.0 / h1;//高缩比
      5e:	db 45 e4             	fildl  -0x1c(%ebp)
      61:	db 45 dc             	fildl  -0x24(%ebp)
      64:	de f9                	fdivrp %st,%st(1)
      66:	d9 5d d4             	fstps  -0x2c(%ebp)

    index = 0;
      69:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    data = (RGBQUAD*)malloc(w1*h1*sizeof(RGBQUAD));//新图颜色表
      70:	8b 45 e0             	mov    -0x20(%ebp),%eax
      73:	0f af 45 dc          	imul   -0x24(%ebp),%eax
      77:	c1 e0 02             	shl    $0x2,%eax
      7a:	89 04 24             	mov    %eax,(%esp)
      7d:	e8 b4 4e 00 00       	call   4f36 <malloc>
      82:	89 45 d0             	mov    %eax,-0x30(%ebp)
    memset(data, 0, (uint)w1*h1*sizeof(RGBQUAD));
      85:	8b 55 e0             	mov    -0x20(%ebp),%edx
      88:	8b 45 dc             	mov    -0x24(%ebp),%eax
      8b:	0f af c2             	imul   %edx,%eax
      8e:	c1 e0 02             	shl    $0x2,%eax
      91:	89 44 24 08          	mov    %eax,0x8(%esp)
      95:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      9c:	00 
      9d:	8b 45 d0             	mov    -0x30(%ebp),%eax
      a0:	89 04 24             	mov    %eax,(%esp)
      a3:	e8 05 48 00 00       	call   48ad <memset>
    
    for (y = 0; y < h1; ++y)//双线性插值法  此算法个人认为需要看一下效果，如果好就用它缩放 h1=10,h0=5,w1=9,w0=3
      a8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      af:	e9 07 03 00 00       	jmp    3bb <compressPic+0x38d>
    {
        y0 = y*fh;//y=0,y0=0
      b4:	db 45 f0             	fildl  -0x10(%ebp)
      b7:	d8 4d d4             	fmuls  -0x2c(%ebp)
      ba:	d9 bd 7e ff ff ff    	fnstcw -0x82(%ebp)
      c0:	0f b7 85 7e ff ff ff 	movzwl -0x82(%ebp),%eax
      c7:	b4 0c                	mov    $0xc,%ah
      c9:	66 89 85 7c ff ff ff 	mov    %ax,-0x84(%ebp)
      d0:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
      d6:	db 5d cc             	fistpl -0x34(%ebp)
      d9:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
        y1 = (int)y0;//y1=0
      df:	8b 45 cc             	mov    -0x34(%ebp),%eax
      e2:	89 45 c8             	mov    %eax,-0x38(%ebp)
        y2 = (y1 == h0-1) ? y1 : y1 + 1;//y2=1
      e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      e8:	83 e8 01             	sub    $0x1,%eax
      eb:	3b 45 c8             	cmp    -0x38(%ebp),%eax
      ee:	74 08                	je     f8 <compressPic+0xca>
      f0:	8b 45 c8             	mov    -0x38(%ebp),%eax
      f3:	83 c0 01             	add    $0x1,%eax
      f6:	eb 03                	jmp    fb <compressPic+0xcd>
      f8:	8b 45 c8             	mov    -0x38(%ebp),%eax
      fb:	89 45 c4             	mov    %eax,-0x3c(%ebp)

        fy1 = y1-y0;//fy1=0
      fe:	8b 45 cc             	mov    -0x34(%ebp),%eax
     101:	8b 55 c8             	mov    -0x38(%ebp),%edx
     104:	29 c2                	sub    %eax,%edx
     106:	89 d0                	mov    %edx,%eax
     108:	89 45 80             	mov    %eax,-0x80(%ebp)
     10b:	db 45 80             	fildl  -0x80(%ebp)
     10e:	d9 5d c0             	fstps  -0x40(%ebp)
        fy2 = 1.0f-fy1;//fy2=1
     111:	d9 e8                	fld1   
     113:	d8 65 c0             	fsubs  -0x40(%ebp)
     116:	d9 5d bc             	fstps  -0x44(%ebp)

        for (x = 0; x < w1; ++x) {
     119:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     120:	e9 86 02 00 00       	jmp    3ab <compressPic+0x37d>
            x0 = x*fw;//x=0,x0=0
     125:	db 45 f4             	fildl  -0xc(%ebp)
     128:	d8 4d d8             	fmuls  -0x28(%ebp)
     12b:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     131:	db 5d b8             	fistpl -0x48(%ebp)
     134:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
            x1 = (int)x0;//x1=0
     13a:	8b 45 b8             	mov    -0x48(%ebp),%eax
     13d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
            x2 = (x1 == w0-1) ? x1 : x1 + 1;//x2=1
     140:	8b 45 e8             	mov    -0x18(%ebp),%eax
     143:	83 e8 01             	sub    $0x1,%eax
     146:	3b 45 b4             	cmp    -0x4c(%ebp),%eax
     149:	74 08                	je     153 <compressPic+0x125>
     14b:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     14e:	83 c0 01             	add    $0x1,%eax
     151:	eb 03                	jmp    156 <compressPic+0x128>
     153:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     156:	89 45 b0             	mov    %eax,-0x50(%ebp)

            fx1 = x1-x0;//fx1=0    //y1=y0??????
     159:	8b 45 b8             	mov    -0x48(%ebp),%eax
     15c:	8b 55 b4             	mov    -0x4c(%ebp),%edx
     15f:	29 c2                	sub    %eax,%edx
     161:	89 d0                	mov    %edx,%eax
     163:	89 45 80             	mov    %eax,-0x80(%ebp)
     166:	db 45 80             	fildl  -0x80(%ebp)
     169:	d9 5d ac             	fstps  -0x54(%ebp)
            fx2 = 1.0f-fx1;//fx2=1
     16c:	d9 e8                	fld1   
     16e:	d8 65 ac             	fsubs  -0x54(%ebp)
     171:	d9 5d a8             	fstps  -0x58(%ebp)

            float s1 = fx1*fy1;//s1=0
     174:	d9 45 ac             	flds   -0x54(%ebp)
     177:	d8 4d c0             	fmuls  -0x40(%ebp)
     17a:	d9 5d a4             	fstps  -0x5c(%ebp)
            float s2 = fx2*fy1;//s2=0
     17d:	d9 45 a8             	flds   -0x58(%ebp)
     180:	d8 4d c0             	fmuls  -0x40(%ebp)
     183:	d9 5d a0             	fstps  -0x60(%ebp)
            float s3 = fx2*fy2;//s3=1
     186:	d9 45 a8             	flds   -0x58(%ebp)
     189:	d8 4d bc             	fmuls  -0x44(%ebp)
     18c:	d9 5d 9c             	fstps  -0x64(%ebp)
            float s4 = fx1*fy2;//s4=0
     18f:	d9 45 ac             	flds   -0x54(%ebp)
     192:	d8 4d bc             	fmuls  -0x44(%ebp)
     195:	d9 5d 98             	fstps  -0x68(%ebp)

            RGBQUAD p1, p2, p3, p4;
            p1 = pic.data[x1+y1*w0];//p1=pic.data[0]
     198:	8b 15 40 25 01 00    	mov    0x12540,%edx
     19e:	8b 45 c8             	mov    -0x38(%ebp),%eax
     1a1:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     1a5:	89 c1                	mov    %eax,%ecx
     1a7:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     1aa:	01 c8                	add    %ecx,%eax
     1ac:	c1 e0 02             	shl    $0x2,%eax
     1af:	01 d0                	add    %edx,%eax
     1b1:	8b 00                	mov    (%eax),%eax
     1b3:	89 45 94             	mov    %eax,-0x6c(%ebp)
            p2 = pic.data[x2+y1*w0];//p2=pic.data[1]
     1b6:	8b 15 40 25 01 00    	mov    0x12540,%edx
     1bc:	8b 45 c8             	mov    -0x38(%ebp),%eax
     1bf:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     1c3:	89 c1                	mov    %eax,%ecx
     1c5:	8b 45 b0             	mov    -0x50(%ebp),%eax
     1c8:	01 c8                	add    %ecx,%eax
     1ca:	c1 e0 02             	shl    $0x2,%eax
     1cd:	01 d0                	add    %edx,%eax
     1cf:	8b 00                	mov    (%eax),%eax
     1d1:	89 45 90             	mov    %eax,-0x70(%ebp)
            p3 = pic.data[x1+y2*w0];//p3=pic.data[3]
     1d4:	8b 15 40 25 01 00    	mov    0x12540,%edx
     1da:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     1dd:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     1e1:	89 c1                	mov    %eax,%ecx
     1e3:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     1e6:	01 c8                	add    %ecx,%eax
     1e8:	c1 e0 02             	shl    $0x2,%eax
     1eb:	01 d0                	add    %edx,%eax
     1ed:	8b 00                	mov    (%eax),%eax
     1ef:	89 45 8c             	mov    %eax,-0x74(%ebp)
            p4 = pic.data[x2+y2*w0];//p4=pic.data[4]
     1f2:	8b 15 40 25 01 00    	mov    0x12540,%edx
     1f8:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     1fb:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     1ff:	89 c1                	mov    %eax,%ecx
     201:	8b 45 b0             	mov    -0x50(%ebp),%eax
     204:	01 c8                	add    %ecx,%eax
     206:	c1 e0 02             	shl    $0x2,%eax
     209:	01 d0                	add    %edx,%eax
     20b:	8b 00                	mov    (%eax),%eax
     20d:	89 45 88             	mov    %eax,-0x78(%ebp)

            data[index].rgbRed = (BYTE)(p1.rgbRed*s3 + p2.rgbRed*s4 + p3.rgbRed*s2 + p4.rgbRed*s1);
     210:	8b 45 ec             	mov    -0x14(%ebp),%eax
     213:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     21a:	8b 45 d0             	mov    -0x30(%ebp),%eax
     21d:	01 c2                	add    %eax,%edx
     21f:	0f b6 45 96          	movzbl -0x6a(%ebp),%eax
     223:	0f b6 c0             	movzbl %al,%eax
     226:	89 45 80             	mov    %eax,-0x80(%ebp)
     229:	db 45 80             	fildl  -0x80(%ebp)
     22c:	d8 4d 9c             	fmuls  -0x64(%ebp)
     22f:	0f b6 45 92          	movzbl -0x6e(%ebp),%eax
     233:	0f b6 c0             	movzbl %al,%eax
     236:	89 45 80             	mov    %eax,-0x80(%ebp)
     239:	db 45 80             	fildl  -0x80(%ebp)
     23c:	d8 4d 98             	fmuls  -0x68(%ebp)
     23f:	de c1                	faddp  %st,%st(1)
     241:	0f b6 45 8e          	movzbl -0x72(%ebp),%eax
     245:	0f b6 c0             	movzbl %al,%eax
     248:	89 45 80             	mov    %eax,-0x80(%ebp)
     24b:	db 45 80             	fildl  -0x80(%ebp)
     24e:	d8 4d a0             	fmuls  -0x60(%ebp)
     251:	de c1                	faddp  %st,%st(1)
     253:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
     257:	0f b6 c0             	movzbl %al,%eax
     25a:	89 45 80             	mov    %eax,-0x80(%ebp)
     25d:	db 45 80             	fildl  -0x80(%ebp)
     260:	d8 4d a4             	fmuls  -0x5c(%ebp)
     263:	de c1                	faddp  %st,%st(1)
     265:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     26b:	df 9d 7a ff ff ff    	fistp  -0x86(%ebp)
     271:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
     277:	0f b7 85 7a ff ff ff 	movzwl -0x86(%ebp),%eax
     27e:	88 42 02             	mov    %al,0x2(%edx)
            data[index].rgbGreen = (BYTE)(p1.rgbGreen*s3 + p2.rgbGreen*s4 + p3.rgbGreen*s2 + p4.rgbGreen*s1);
     281:	8b 45 ec             	mov    -0x14(%ebp),%eax
     284:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     28b:	8b 45 d0             	mov    -0x30(%ebp),%eax
     28e:	01 c2                	add    %eax,%edx
     290:	0f b6 45 95          	movzbl -0x6b(%ebp),%eax
     294:	0f b6 c0             	movzbl %al,%eax
     297:	89 45 80             	mov    %eax,-0x80(%ebp)
     29a:	db 45 80             	fildl  -0x80(%ebp)
     29d:	d8 4d 9c             	fmuls  -0x64(%ebp)
     2a0:	0f b6 45 91          	movzbl -0x6f(%ebp),%eax
     2a4:	0f b6 c0             	movzbl %al,%eax
     2a7:	89 45 80             	mov    %eax,-0x80(%ebp)
     2aa:	db 45 80             	fildl  -0x80(%ebp)
     2ad:	d8 4d 98             	fmuls  -0x68(%ebp)
     2b0:	de c1                	faddp  %st,%st(1)
     2b2:	0f b6 45 8d          	movzbl -0x73(%ebp),%eax
     2b6:	0f b6 c0             	movzbl %al,%eax
     2b9:	89 45 80             	mov    %eax,-0x80(%ebp)
     2bc:	db 45 80             	fildl  -0x80(%ebp)
     2bf:	d8 4d a0             	fmuls  -0x60(%ebp)
     2c2:	de c1                	faddp  %st,%st(1)
     2c4:	0f b6 45 89          	movzbl -0x77(%ebp),%eax
     2c8:	0f b6 c0             	movzbl %al,%eax
     2cb:	89 45 80             	mov    %eax,-0x80(%ebp)
     2ce:	db 45 80             	fildl  -0x80(%ebp)
     2d1:	d8 4d a4             	fmuls  -0x5c(%ebp)
     2d4:	de c1                	faddp  %st,%st(1)
     2d6:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     2dc:	df 9d 7a ff ff ff    	fistp  -0x86(%ebp)
     2e2:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
     2e8:	0f b7 85 7a ff ff ff 	movzwl -0x86(%ebp),%eax
     2ef:	88 42 01             	mov    %al,0x1(%edx)
            data[index].rgbBlue = (BYTE)(p1.rgbBlue*s3 + p2.rgbBlue*s4 + p3.rgbBlue*s2 + p4.rgbBlue*s1);
     2f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     2f5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     2fc:	8b 45 d0             	mov    -0x30(%ebp),%eax
     2ff:	01 c2                	add    %eax,%edx
     301:	0f b6 45 94          	movzbl -0x6c(%ebp),%eax
     305:	0f b6 c0             	movzbl %al,%eax
     308:	89 45 80             	mov    %eax,-0x80(%ebp)
     30b:	db 45 80             	fildl  -0x80(%ebp)
     30e:	d8 4d 9c             	fmuls  -0x64(%ebp)
     311:	0f b6 45 90          	movzbl -0x70(%ebp),%eax
     315:	0f b6 c0             	movzbl %al,%eax
     318:	89 45 80             	mov    %eax,-0x80(%ebp)
     31b:	db 45 80             	fildl  -0x80(%ebp)
     31e:	d8 4d 98             	fmuls  -0x68(%ebp)
     321:	de c1                	faddp  %st,%st(1)
     323:	0f b6 45 8c          	movzbl -0x74(%ebp),%eax
     327:	0f b6 c0             	movzbl %al,%eax
     32a:	89 45 80             	mov    %eax,-0x80(%ebp)
     32d:	db 45 80             	fildl  -0x80(%ebp)
     330:	d8 4d a0             	fmuls  -0x60(%ebp)
     333:	de c1                	faddp  %st,%st(1)
     335:	0f b6 45 88          	movzbl -0x78(%ebp),%eax
     339:	0f b6 c0             	movzbl %al,%eax
     33c:	89 45 80             	mov    %eax,-0x80(%ebp)
     33f:	db 45 80             	fildl  -0x80(%ebp)
     342:	d8 4d a4             	fmuls  -0x5c(%ebp)
     345:	de c1                	faddp  %st,%st(1)
     347:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     34d:	df 9d 7a ff ff ff    	fistp  -0x86(%ebp)
     353:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
     359:	0f b7 85 7a ff ff ff 	movzwl -0x86(%ebp),%eax
     360:	88 02                	mov    %al,(%edx)

            data[index].rgbRed = p1.rgbRed;
     362:	8b 45 ec             	mov    -0x14(%ebp),%eax
     365:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     36c:	8b 45 d0             	mov    -0x30(%ebp),%eax
     36f:	01 c2                	add    %eax,%edx
     371:	0f b6 45 96          	movzbl -0x6a(%ebp),%eax
     375:	88 42 02             	mov    %al,0x2(%edx)
            data[index].rgbGreen = p1.rgbGreen;
     378:	8b 45 ec             	mov    -0x14(%ebp),%eax
     37b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     382:	8b 45 d0             	mov    -0x30(%ebp),%eax
     385:	01 c2                	add    %eax,%edx
     387:	0f b6 45 95          	movzbl -0x6b(%ebp),%eax
     38b:	88 42 01             	mov    %al,0x1(%edx)
            data[index].rgbBlue = p1.rgbBlue;
     38e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     391:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     398:	8b 45 d0             	mov    -0x30(%ebp),%eax
     39b:	01 c2                	add    %eax,%edx
     39d:	0f b6 45 94          	movzbl -0x6c(%ebp),%eax
     3a1:	88 02                	mov    %al,(%edx)

            ++index;
     3a3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        y2 = (y1 == h0-1) ? y1 : y1 + 1;//y2=1

        fy1 = y1-y0;//fy1=0
        fy2 = 1.0f-fy1;//fy2=1

        for (x = 0; x < w1; ++x) {
     3a7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     3ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3ae:	3b 45 e0             	cmp    -0x20(%ebp),%eax
     3b1:	0f 8c 6e fd ff ff    	jl     125 <compressPic+0xf7>

    index = 0;
    data = (RGBQUAD*)malloc(w1*h1*sizeof(RGBQUAD));//新图颜色表
    memset(data, 0, (uint)w1*h1*sizeof(RGBQUAD));
    
    for (y = 0; y < h1; ++y)//双线性插值法  此算法个人认为需要看一下效果，如果好就用它缩放 h1=10,h0=5,w1=9,w0=3
     3b7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     3bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     3be:	3b 45 dc             	cmp    -0x24(%ebp),%eax
     3c1:	0f 8c ed fc ff ff    	jl     b4 <compressPic+0x86>

            ++index;
        }
    }

    freepic(&pic);
     3c7:	c7 04 24 40 25 01 00 	movl   $0x12540,(%esp)
     3ce:	e8 9b 35 00 00       	call   396e <freepic>
    pic.data = data;
     3d3:	8b 45 d0             	mov    -0x30(%ebp),%eax
     3d6:	a3 40 25 01 00       	mov    %eax,0x12540
    pic.width = width;
     3db:	8b 45 08             	mov    0x8(%ebp),%eax
     3de:	a3 44 25 01 00       	mov    %eax,0x12544
    pic.height = height;
     3e3:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e6:	a3 48 25 01 00       	mov    %eax,0x12548
}
     3eb:	c9                   	leave  
     3ec:	c3                   	ret    

000003ed <compressAnyPic>:

void compressAnyPic(PICNODE* anypic, int width, int height) {
     3ed:	55                   	push   %ebp
     3ee:	89 e5                	mov    %esp,%ebp
     3f0:	81 ec 98 00 00 00    	sub    $0x98,%esp
    int x0, y0, x1, x2, y1, y2;
    float fx1, fx2, fy1, fy2;
    int x, y, index;
    RGBQUAD* data;

    w0 = anypic->width;//图宽
     3f6:	8b 45 08             	mov    0x8(%ebp),%eax
     3f9:	8b 40 04             	mov    0x4(%eax),%eax
     3fc:	89 45 e8             	mov    %eax,-0x18(%ebp)
    h0 = anypic->height;//图高
     3ff:	8b 45 08             	mov    0x8(%ebp),%eax
     402:	8b 40 08             	mov    0x8(%eax),%eax
     405:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    w1 = width;//设定宽
     408:	8b 45 0c             	mov    0xc(%ebp),%eax
     40b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    h1 = height;//设定高
     40e:	8b 45 10             	mov    0x10(%ebp),%eax
     411:	89 45 dc             	mov    %eax,-0x24(%ebp)

    fw = w0 * 1.0 / w1;//宽缩比
     414:	db 45 e8             	fildl  -0x18(%ebp)
     417:	db 45 e0             	fildl  -0x20(%ebp)
     41a:	de f9                	fdivrp %st,%st(1)
     41c:	d9 5d d8             	fstps  -0x28(%ebp)
    fh = h0 * 1.0 / h1;//高缩比
     41f:	db 45 e4             	fildl  -0x1c(%ebp)
     422:	db 45 dc             	fildl  -0x24(%ebp)
     425:	de f9                	fdivrp %st,%st(1)
     427:	d9 5d d4             	fstps  -0x2c(%ebp)

    index = 0;
     42a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    data = (RGBQUAD*)malloc(w1*h1*sizeof(RGBQUAD));//新图颜色表
     431:	8b 45 e0             	mov    -0x20(%ebp),%eax
     434:	0f af 45 dc          	imul   -0x24(%ebp),%eax
     438:	c1 e0 02             	shl    $0x2,%eax
     43b:	89 04 24             	mov    %eax,(%esp)
     43e:	e8 f3 4a 00 00       	call   4f36 <malloc>
     443:	89 45 d0             	mov    %eax,-0x30(%ebp)
    memset(data, 0, (uint)w1*h1*sizeof(RGBQUAD));
     446:	8b 55 e0             	mov    -0x20(%ebp),%edx
     449:	8b 45 dc             	mov    -0x24(%ebp),%eax
     44c:	0f af c2             	imul   %edx,%eax
     44f:	c1 e0 02             	shl    $0x2,%eax
     452:	89 44 24 08          	mov    %eax,0x8(%esp)
     456:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     45d:	00 
     45e:	8b 45 d0             	mov    -0x30(%ebp),%eax
     461:	89 04 24             	mov    %eax,(%esp)
     464:	e8 44 44 00 00       	call   48ad <memset>
    
    for (y = 0; y < h1; ++y)//双线性插值法  此算法个人认为需要看一下效果，如果好就用它缩放 h1=10,h0=5,w1=9,w0=3
     469:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     470:	e9 03 03 00 00       	jmp    778 <compressAnyPic+0x38b>
    {
        y0 = y*fh;//y=0,y0=0
     475:	db 45 f0             	fildl  -0x10(%ebp)
     478:	d8 4d d4             	fmuls  -0x2c(%ebp)
     47b:	d9 bd 7e ff ff ff    	fnstcw -0x82(%ebp)
     481:	0f b7 85 7e ff ff ff 	movzwl -0x82(%ebp),%eax
     488:	b4 0c                	mov    $0xc,%ah
     48a:	66 89 85 7c ff ff ff 	mov    %ax,-0x84(%ebp)
     491:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     497:	db 5d cc             	fistpl -0x34(%ebp)
     49a:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
        y1 = (int)y0;//y1=0
     4a0:	8b 45 cc             	mov    -0x34(%ebp),%eax
     4a3:	89 45 c8             	mov    %eax,-0x38(%ebp)
        y2 = (y1 == h0-1) ? y1 : y1 + 1;//y2=1
     4a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4a9:	83 e8 01             	sub    $0x1,%eax
     4ac:	3b 45 c8             	cmp    -0x38(%ebp),%eax
     4af:	74 08                	je     4b9 <compressAnyPic+0xcc>
     4b1:	8b 45 c8             	mov    -0x38(%ebp),%eax
     4b4:	83 c0 01             	add    $0x1,%eax
     4b7:	eb 03                	jmp    4bc <compressAnyPic+0xcf>
     4b9:	8b 45 c8             	mov    -0x38(%ebp),%eax
     4bc:	89 45 c4             	mov    %eax,-0x3c(%ebp)

        fy1 = y1-y0;//fy1=0
     4bf:	8b 45 cc             	mov    -0x34(%ebp),%eax
     4c2:	8b 55 c8             	mov    -0x38(%ebp),%edx
     4c5:	29 c2                	sub    %eax,%edx
     4c7:	89 d0                	mov    %edx,%eax
     4c9:	89 45 80             	mov    %eax,-0x80(%ebp)
     4cc:	db 45 80             	fildl  -0x80(%ebp)
     4cf:	d9 5d c0             	fstps  -0x40(%ebp)
        fy2 = 1.0f-fy1;//fy2=1
     4d2:	d9 e8                	fld1   
     4d4:	d8 65 c0             	fsubs  -0x40(%ebp)
     4d7:	d9 5d bc             	fstps  -0x44(%ebp)

        for (x = 0; x < w1; ++x) {
     4da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4e1:	e9 82 02 00 00       	jmp    768 <compressAnyPic+0x37b>
            x0 = x*fw;//x=0,x0=0
     4e6:	db 45 f4             	fildl  -0xc(%ebp)
     4e9:	d8 4d d8             	fmuls  -0x28(%ebp)
     4ec:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     4f2:	db 5d b8             	fistpl -0x48(%ebp)
     4f5:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
            x1 = (int)x0;//x1=0
     4fb:	8b 45 b8             	mov    -0x48(%ebp),%eax
     4fe:	89 45 b4             	mov    %eax,-0x4c(%ebp)
            x2 = (x1 == w0-1) ? x1 : x1 + 1;//x2=1
     501:	8b 45 e8             	mov    -0x18(%ebp),%eax
     504:	83 e8 01             	sub    $0x1,%eax
     507:	3b 45 b4             	cmp    -0x4c(%ebp),%eax
     50a:	74 08                	je     514 <compressAnyPic+0x127>
     50c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     50f:	83 c0 01             	add    $0x1,%eax
     512:	eb 03                	jmp    517 <compressAnyPic+0x12a>
     514:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     517:	89 45 b0             	mov    %eax,-0x50(%ebp)

            fx1 = x1-x0;//fx1=0    //y1=y0??????
     51a:	8b 45 b8             	mov    -0x48(%ebp),%eax
     51d:	8b 55 b4             	mov    -0x4c(%ebp),%edx
     520:	29 c2                	sub    %eax,%edx
     522:	89 d0                	mov    %edx,%eax
     524:	89 45 80             	mov    %eax,-0x80(%ebp)
     527:	db 45 80             	fildl  -0x80(%ebp)
     52a:	d9 5d ac             	fstps  -0x54(%ebp)
            fx2 = 1.0f-fx1;//fx2=1
     52d:	d9 e8                	fld1   
     52f:	d8 65 ac             	fsubs  -0x54(%ebp)
     532:	d9 5d a8             	fstps  -0x58(%ebp)

            float s1 = fx1*fy1;//s1=0
     535:	d9 45 ac             	flds   -0x54(%ebp)
     538:	d8 4d c0             	fmuls  -0x40(%ebp)
     53b:	d9 5d a4             	fstps  -0x5c(%ebp)
            float s2 = fx2*fy1;//s2=0
     53e:	d9 45 a8             	flds   -0x58(%ebp)
     541:	d8 4d c0             	fmuls  -0x40(%ebp)
     544:	d9 5d a0             	fstps  -0x60(%ebp)
            float s3 = fx2*fy2;//s3=1
     547:	d9 45 a8             	flds   -0x58(%ebp)
     54a:	d8 4d bc             	fmuls  -0x44(%ebp)
     54d:	d9 5d 9c             	fstps  -0x64(%ebp)
            float s4 = fx1*fy2;//s4=0
     550:	d9 45 ac             	flds   -0x54(%ebp)
     553:	d8 4d bc             	fmuls  -0x44(%ebp)
     556:	d9 5d 98             	fstps  -0x68(%ebp)

            RGBQUAD p1, p2, p3, p4;
            p1 = anypic->data[x1+y1*w0];//p1=pic.data[0]
     559:	8b 45 08             	mov    0x8(%ebp),%eax
     55c:	8b 10                	mov    (%eax),%edx
     55e:	8b 45 c8             	mov    -0x38(%ebp),%eax
     561:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     565:	89 c1                	mov    %eax,%ecx
     567:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     56a:	01 c8                	add    %ecx,%eax
     56c:	c1 e0 02             	shl    $0x2,%eax
     56f:	01 d0                	add    %edx,%eax
     571:	8b 00                	mov    (%eax),%eax
     573:	89 45 94             	mov    %eax,-0x6c(%ebp)
            p2 = anypic->data[x2+y1*w0];//p2=pic.data[1]
     576:	8b 45 08             	mov    0x8(%ebp),%eax
     579:	8b 10                	mov    (%eax),%edx
     57b:	8b 45 c8             	mov    -0x38(%ebp),%eax
     57e:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     582:	89 c1                	mov    %eax,%ecx
     584:	8b 45 b0             	mov    -0x50(%ebp),%eax
     587:	01 c8                	add    %ecx,%eax
     589:	c1 e0 02             	shl    $0x2,%eax
     58c:	01 d0                	add    %edx,%eax
     58e:	8b 00                	mov    (%eax),%eax
     590:	89 45 90             	mov    %eax,-0x70(%ebp)
            p3 = anypic->data[x1+y2*w0];//p3=pic.data[3]
     593:	8b 45 08             	mov    0x8(%ebp),%eax
     596:	8b 10                	mov    (%eax),%edx
     598:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     59b:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     59f:	89 c1                	mov    %eax,%ecx
     5a1:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     5a4:	01 c8                	add    %ecx,%eax
     5a6:	c1 e0 02             	shl    $0x2,%eax
     5a9:	01 d0                	add    %edx,%eax
     5ab:	8b 00                	mov    (%eax),%eax
     5ad:	89 45 8c             	mov    %eax,-0x74(%ebp)
            p4 = anypic->data[x2+y2*w0];//p4=pic.data[4]
     5b0:	8b 45 08             	mov    0x8(%ebp),%eax
     5b3:	8b 10                	mov    (%eax),%edx
     5b5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     5b8:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     5bc:	89 c1                	mov    %eax,%ecx
     5be:	8b 45 b0             	mov    -0x50(%ebp),%eax
     5c1:	01 c8                	add    %ecx,%eax
     5c3:	c1 e0 02             	shl    $0x2,%eax
     5c6:	01 d0                	add    %edx,%eax
     5c8:	8b 00                	mov    (%eax),%eax
     5ca:	89 45 88             	mov    %eax,-0x78(%ebp)

            data[index].rgbRed = (BYTE)(p1.rgbRed*s3 + p2.rgbRed*s4 + p3.rgbRed*s2 + p4.rgbRed*s1);
     5cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
     5d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     5d7:	8b 45 d0             	mov    -0x30(%ebp),%eax
     5da:	01 c2                	add    %eax,%edx
     5dc:	0f b6 45 96          	movzbl -0x6a(%ebp),%eax
     5e0:	0f b6 c0             	movzbl %al,%eax
     5e3:	89 45 80             	mov    %eax,-0x80(%ebp)
     5e6:	db 45 80             	fildl  -0x80(%ebp)
     5e9:	d8 4d 9c             	fmuls  -0x64(%ebp)
     5ec:	0f b6 45 92          	movzbl -0x6e(%ebp),%eax
     5f0:	0f b6 c0             	movzbl %al,%eax
     5f3:	89 45 80             	mov    %eax,-0x80(%ebp)
     5f6:	db 45 80             	fildl  -0x80(%ebp)
     5f9:	d8 4d 98             	fmuls  -0x68(%ebp)
     5fc:	de c1                	faddp  %st,%st(1)
     5fe:	0f b6 45 8e          	movzbl -0x72(%ebp),%eax
     602:	0f b6 c0             	movzbl %al,%eax
     605:	89 45 80             	mov    %eax,-0x80(%ebp)
     608:	db 45 80             	fildl  -0x80(%ebp)
     60b:	d8 4d a0             	fmuls  -0x60(%ebp)
     60e:	de c1                	faddp  %st,%st(1)
     610:	0f b6 45 8a          	movzbl -0x76(%ebp),%eax
     614:	0f b6 c0             	movzbl %al,%eax
     617:	89 45 80             	mov    %eax,-0x80(%ebp)
     61a:	db 45 80             	fildl  -0x80(%ebp)
     61d:	d8 4d a4             	fmuls  -0x5c(%ebp)
     620:	de c1                	faddp  %st,%st(1)
     622:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     628:	df 9d 7a ff ff ff    	fistp  -0x86(%ebp)
     62e:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
     634:	0f b7 85 7a ff ff ff 	movzwl -0x86(%ebp),%eax
     63b:	88 42 02             	mov    %al,0x2(%edx)
            data[index].rgbGreen = (BYTE)(p1.rgbGreen*s3 + p2.rgbGreen*s4 + p3.rgbGreen*s2 + p4.rgbGreen*s1);
     63e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     641:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     648:	8b 45 d0             	mov    -0x30(%ebp),%eax
     64b:	01 c2                	add    %eax,%edx
     64d:	0f b6 45 95          	movzbl -0x6b(%ebp),%eax
     651:	0f b6 c0             	movzbl %al,%eax
     654:	89 45 80             	mov    %eax,-0x80(%ebp)
     657:	db 45 80             	fildl  -0x80(%ebp)
     65a:	d8 4d 9c             	fmuls  -0x64(%ebp)
     65d:	0f b6 45 91          	movzbl -0x6f(%ebp),%eax
     661:	0f b6 c0             	movzbl %al,%eax
     664:	89 45 80             	mov    %eax,-0x80(%ebp)
     667:	db 45 80             	fildl  -0x80(%ebp)
     66a:	d8 4d 98             	fmuls  -0x68(%ebp)
     66d:	de c1                	faddp  %st,%st(1)
     66f:	0f b6 45 8d          	movzbl -0x73(%ebp),%eax
     673:	0f b6 c0             	movzbl %al,%eax
     676:	89 45 80             	mov    %eax,-0x80(%ebp)
     679:	db 45 80             	fildl  -0x80(%ebp)
     67c:	d8 4d a0             	fmuls  -0x60(%ebp)
     67f:	de c1                	faddp  %st,%st(1)
     681:	0f b6 45 89          	movzbl -0x77(%ebp),%eax
     685:	0f b6 c0             	movzbl %al,%eax
     688:	89 45 80             	mov    %eax,-0x80(%ebp)
     68b:	db 45 80             	fildl  -0x80(%ebp)
     68e:	d8 4d a4             	fmuls  -0x5c(%ebp)
     691:	de c1                	faddp  %st,%st(1)
     693:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     699:	df 9d 7a ff ff ff    	fistp  -0x86(%ebp)
     69f:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
     6a5:	0f b7 85 7a ff ff ff 	movzwl -0x86(%ebp),%eax
     6ac:	88 42 01             	mov    %al,0x1(%edx)
            data[index].rgbBlue = (BYTE)(p1.rgbBlue*s3 + p2.rgbBlue*s4 + p3.rgbBlue*s2 + p4.rgbBlue*s1);
     6af:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6b2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     6b9:	8b 45 d0             	mov    -0x30(%ebp),%eax
     6bc:	01 c2                	add    %eax,%edx
     6be:	0f b6 45 94          	movzbl -0x6c(%ebp),%eax
     6c2:	0f b6 c0             	movzbl %al,%eax
     6c5:	89 45 80             	mov    %eax,-0x80(%ebp)
     6c8:	db 45 80             	fildl  -0x80(%ebp)
     6cb:	d8 4d 9c             	fmuls  -0x64(%ebp)
     6ce:	0f b6 45 90          	movzbl -0x70(%ebp),%eax
     6d2:	0f b6 c0             	movzbl %al,%eax
     6d5:	89 45 80             	mov    %eax,-0x80(%ebp)
     6d8:	db 45 80             	fildl  -0x80(%ebp)
     6db:	d8 4d 98             	fmuls  -0x68(%ebp)
     6de:	de c1                	faddp  %st,%st(1)
     6e0:	0f b6 45 8c          	movzbl -0x74(%ebp),%eax
     6e4:	0f b6 c0             	movzbl %al,%eax
     6e7:	89 45 80             	mov    %eax,-0x80(%ebp)
     6ea:	db 45 80             	fildl  -0x80(%ebp)
     6ed:	d8 4d a0             	fmuls  -0x60(%ebp)
     6f0:	de c1                	faddp  %st,%st(1)
     6f2:	0f b6 45 88          	movzbl -0x78(%ebp),%eax
     6f6:	0f b6 c0             	movzbl %al,%eax
     6f9:	89 45 80             	mov    %eax,-0x80(%ebp)
     6fc:	db 45 80             	fildl  -0x80(%ebp)
     6ff:	d8 4d a4             	fmuls  -0x5c(%ebp)
     702:	de c1                	faddp  %st,%st(1)
     704:	d9 ad 7c ff ff ff    	fldcw  -0x84(%ebp)
     70a:	df 9d 7a ff ff ff    	fistp  -0x86(%ebp)
     710:	d9 ad 7e ff ff ff    	fldcw  -0x82(%ebp)
     716:	0f b7 85 7a ff ff ff 	movzwl -0x86(%ebp),%eax
     71d:	88 02                	mov    %al,(%edx)

            data[index].rgbRed = p1.rgbRed;
     71f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     722:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     729:	8b 45 d0             	mov    -0x30(%ebp),%eax
     72c:	01 c2                	add    %eax,%edx
     72e:	0f b6 45 96          	movzbl -0x6a(%ebp),%eax
     732:	88 42 02             	mov    %al,0x2(%edx)
            data[index].rgbGreen = p1.rgbGreen;
     735:	8b 45 ec             	mov    -0x14(%ebp),%eax
     738:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     73f:	8b 45 d0             	mov    -0x30(%ebp),%eax
     742:	01 c2                	add    %eax,%edx
     744:	0f b6 45 95          	movzbl -0x6b(%ebp),%eax
     748:	88 42 01             	mov    %al,0x1(%edx)
            data[index].rgbBlue = p1.rgbBlue;
     74b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     74e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     755:	8b 45 d0             	mov    -0x30(%ebp),%eax
     758:	01 c2                	add    %eax,%edx
     75a:	0f b6 45 94          	movzbl -0x6c(%ebp),%eax
     75e:	88 02                	mov    %al,(%edx)

            ++index;
     760:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        y2 = (y1 == h0-1) ? y1 : y1 + 1;//y2=1

        fy1 = y1-y0;//fy1=0
        fy2 = 1.0f-fy1;//fy2=1

        for (x = 0; x < w1; ++x) {
     764:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     768:	8b 45 f4             	mov    -0xc(%ebp),%eax
     76b:	3b 45 e0             	cmp    -0x20(%ebp),%eax
     76e:	0f 8c 72 fd ff ff    	jl     4e6 <compressAnyPic+0xf9>

    index = 0;
    data = (RGBQUAD*)malloc(w1*h1*sizeof(RGBQUAD));//新图颜色表
    memset(data, 0, (uint)w1*h1*sizeof(RGBQUAD));
    
    for (y = 0; y < h1; ++y)//双线性插值法  此算法个人认为需要看一下效果，如果好就用它缩放 h1=10,h0=5,w1=9,w0=3
     774:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     778:	8b 45 f0             	mov    -0x10(%ebp),%eax
     77b:	3b 45 dc             	cmp    -0x24(%ebp),%eax
     77e:	0f 8c f1 fc ff ff    	jl     475 <compressAnyPic+0x88>

            ++index;
        }
    }

    freepic(anypic);
     784:	8b 45 08             	mov    0x8(%ebp),%eax
     787:	89 04 24             	mov    %eax,(%esp)
     78a:	e8 df 31 00 00       	call   396e <freepic>
    anypic->data = data;
     78f:	8b 45 08             	mov    0x8(%ebp),%eax
     792:	8b 55 d0             	mov    -0x30(%ebp),%edx
     795:	89 10                	mov    %edx,(%eax)
    anypic->width = width;
     797:	8b 45 08             	mov    0x8(%ebp),%eax
     79a:	8b 55 0c             	mov    0xc(%ebp),%edx
     79d:	89 50 04             	mov    %edx,0x4(%eax)
    anypic->height = height;
     7a0:	8b 45 08             	mov    0x8(%ebp),%eax
     7a3:	8b 55 10             	mov    0x10(%ebp),%edx
     7a6:	89 50 08             	mov    %edx,0x8(%eax)
}
     7a9:	c9                   	leave  
     7aa:	c3                   	ret    

000007ab <modifyPic>:

void modifyPic(Context context)//调整大小来适应背景
{
     7ab:	55                   	push   %ebp
     7ac:	89 e5                	mov    %esp,%ebp
     7ae:	83 ec 48             	sub    $0x48,%esp
    int c_width, c_height;
    int pic_width, pic_height;

    c_width = context.width;
     7b1:	8b 45 0c             	mov    0xc(%ebp),%eax
     7b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    c_height = context.height;
     7b7:	8b 45 10             	mov    0x10(%ebp),%eax
     7ba:	89 45 e8             	mov    %eax,-0x18(%ebp)
    pic_width = pic.width;
     7bd:	a1 44 25 01 00       	mov    0x12544,%eax
     7c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    pic_height = pic.height;
     7c5:	a1 48 25 01 00       	mov    0x12548,%eax
     7ca:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if (pic_width < c_width && pic_height < c_height) {//比背景小，不动
     7cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     7d3:	7d 0d                	jge    7e2 <modifyPic+0x37>
     7d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     7db:	7d 05                	jge    7e2 <modifyPic+0x37>
        return;
     7dd:	e9 b6 00 00 00       	jmp    898 <modifyPic+0xed>
    }

    float scale_p, scale_c;//宽高比
    scale_p = pic_width * 1.0 / pic_height;
     7e2:	db 45 f4             	fildl  -0xc(%ebp)
     7e5:	db 45 f0             	fildl  -0x10(%ebp)
     7e8:	de f9                	fdivrp %st,%st(1)
     7ea:	d9 5d e4             	fstps  -0x1c(%ebp)
    scale_c = c_width * 1.0 / c_height;
     7ed:	db 45 ec             	fildl  -0x14(%ebp)
     7f0:	db 45 e8             	fildl  -0x18(%ebp)
     7f3:	de f9                	fdivrp %st,%st(1)
     7f5:	d9 5d e0             	fstps  -0x20(%ebp)

    if (scale_p <= scale_c) {
     7f8:	d9 45 e0             	flds   -0x20(%ebp)
     7fb:	d9 45 e4             	flds   -0x1c(%ebp)
     7fe:	d9 c9                	fxch   %st(1)
     800:	df e9                	fucomip %st(1),%st
     802:	dd d8                	fstp   %st(0)
     804:	72 30                	jb     836 <modifyPic+0x8b>
        pic_width = scale_p * (c_height-10);
     806:	8b 45 e8             	mov    -0x18(%ebp),%eax
     809:	83 e8 0a             	sub    $0xa,%eax
     80c:	89 45 d0             	mov    %eax,-0x30(%ebp)
     80f:	db 45 d0             	fildl  -0x30(%ebp)
     812:	d8 4d e4             	fmuls  -0x1c(%ebp)
     815:	d9 7d ce             	fnstcw -0x32(%ebp)
     818:	0f b7 45 ce          	movzwl -0x32(%ebp),%eax
     81c:	b4 0c                	mov    $0xc,%ah
     81e:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
     822:	d9 6d cc             	fldcw  -0x34(%ebp)
     825:	db 5d f4             	fistpl -0xc(%ebp)
     828:	d9 6d ce             	fldcw  -0x32(%ebp)
        pic_height = c_height-10;
     82b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     82e:	83 e8 0a             	sub    $0xa,%eax
     831:	89 45 f0             	mov    %eax,-0x10(%ebp)
     834:	eb 2e                	jmp    864 <modifyPic+0xb9>
    } else {
        pic_height = (c_width-5) / scale_p;
     836:	8b 45 ec             	mov    -0x14(%ebp),%eax
     839:	83 e8 05             	sub    $0x5,%eax
     83c:	89 45 d0             	mov    %eax,-0x30(%ebp)
     83f:	db 45 d0             	fildl  -0x30(%ebp)
     842:	d8 75 e4             	fdivs  -0x1c(%ebp)
     845:	d9 7d ce             	fnstcw -0x32(%ebp)
     848:	0f b7 45 ce          	movzwl -0x32(%ebp),%eax
     84c:	b4 0c                	mov    $0xc,%ah
     84e:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
     852:	d9 6d cc             	fldcw  -0x34(%ebp)
     855:	db 5d f0             	fistpl -0x10(%ebp)
     858:	d9 6d ce             	fldcw  -0x32(%ebp)
        pic_width = c_width-5;
     85b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     85e:	83 e8 05             	sub    $0x5,%eax
     861:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    printf(0, "modifyPic: pic_width: %d, pic_height: %d\n", pic_width, pic_height);
     864:	8b 45 f0             	mov    -0x10(%ebp),%eax
     867:	89 44 24 0c          	mov    %eax,0xc(%esp)
     86b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86e:	89 44 24 08          	mov    %eax,0x8(%esp)
     872:	c7 44 24 04 c0 b2 00 	movl   $0xb2c0,0x4(%esp)
     879:	00 
     87a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     881:	e8 c4 43 00 00       	call   4c4a <printf>

    compressPic(pic_width, pic_height);
     886:	8b 45 f0             	mov    -0x10(%ebp),%eax
     889:	89 44 24 04          	mov    %eax,0x4(%esp)
     88d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     890:	89 04 24             	mov    %eax,(%esp)
     893:	e8 96 f7 ff ff       	call   2e <compressPic>
}
     898:	c9                   	leave  
     899:	c3                   	ret    

0000089a <enlargePic>:

//放大图片
void enlargePic(Context context,int enlargeRate,int centerX, int centerY)
{
     89a:	55                   	push   %ebp
     89b:	89 e5                	mov    %esp,%ebp
     89d:	56                   	push   %esi
     89e:	53                   	push   %ebx
     89f:	83 ec 30             	sub    $0x30,%esp
    if(centerX<0 || centerY<0 || centerX>context.width || centerY>context.height)return;
     8a2:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
     8a6:	78 16                	js     8be <enlargePic+0x24>
     8a8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     8ac:	78 10                	js     8be <enlargePic+0x24>
     8ae:	8b 45 0c             	mov    0xc(%ebp),%eax
     8b1:	3b 45 18             	cmp    0x18(%ebp),%eax
     8b4:	7c 08                	jl     8be <enlargePic+0x24>
     8b6:	8b 45 10             	mov    0x10(%ebp),%eax
     8b9:	3b 45 1c             	cmp    0x1c(%ebp),%eax
     8bc:	7d 05                	jge    8c3 <enlargePic+0x29>
     8be:	e9 30 02 00 00       	jmp    af3 <enlargePic+0x259>
    int width = pic.width*enlargeRate;
     8c3:	a1 44 25 01 00       	mov    0x12544,%eax
     8c8:	0f af 45 14          	imul   0x14(%ebp),%eax
     8cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int height = pic.height*enlargeRate;
     8cf:	a1 48 25 01 00       	mov    0x12548,%eax
     8d4:	0f af 45 14          	imul   0x14(%ebp),%eax
     8d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    compressPic(width,height);
     8db:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8de:	89 44 24 04          	mov    %eax,0x4(%esp)
     8e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8e5:	89 04 24             	mov    %eax,(%esp)
     8e8:	e8 41 f7 ff ff       	call   2e <compressPic>
    /*int centerConX = context.width/2.0;
    int centerConY = context.height/2.0;
    int moveX = centerConX - centerX;
    int moveY = centerConY - centerY;*/
    drawPicViewerWnd(context);
     8ed:	8b 45 08             	mov    0x8(%ebp),%eax
     8f0:	89 04 24             	mov    %eax,(%esp)
     8f3:	8b 45 0c             	mov    0xc(%ebp),%eax
     8f6:	89 44 24 04          	mov    %eax,0x4(%esp)
     8fa:	8b 45 10             	mov    0x10(%ebp),%eax
     8fd:	89 44 24 08          	mov    %eax,0x8(%esp)
     901:	e8 17 06 00 00       	call   f1d <drawPicViewerWnd>
    draw_picture(context, pic, ((context.width >> 1) - centerX)*enlargeRate + ((context.width-width/enlargeRate) >> 1)+X_shift*enlargeRate, 
TOPBAR_HEIGHT + (((context.height-TOPBAR_HEIGHT) >> 1) - (centerY-TOPBAR_HEIGHT))*enlargeRate + ((context.height-TOPBAR_HEIGHT-height/enlargeRate) >> 1)+Y_shift*enlargeRate);
     906:	8b 45 10             	mov    0x10(%ebp),%eax
     909:	83 e8 14             	sub    $0x14,%eax
     90c:	d1 f8                	sar    %eax
     90e:	89 c2                	mov    %eax,%edx
     910:	b8 14 00 00 00       	mov    $0x14,%eax
     915:	2b 45 1c             	sub    0x1c(%ebp),%eax
     918:	01 d0                	add    %edx,%eax
     91a:	0f af 45 14          	imul   0x14(%ebp),%eax
     91e:	8d 48 14             	lea    0x14(%eax),%ecx
     921:	8b 45 10             	mov    0x10(%ebp),%eax
     924:	8d 58 ec             	lea    -0x14(%eax),%ebx
     927:	8b 45 f0             	mov    -0x10(%ebp),%eax
     92a:	99                   	cltd   
     92b:	f7 7d 14             	idivl  0x14(%ebp)
     92e:	29 c3                	sub    %eax,%ebx
     930:	89 d8                	mov    %ebx,%eax
     932:	d1 f8                	sar    %eax
     934:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     937:	a1 30 f7 00 00       	mov    0xf730,%eax
     93c:	0f af 45 14          	imul   0x14(%ebp),%eax
    /*int centerConX = context.width/2.0;
    int centerConY = context.height/2.0;
    int moveX = centerConX - centerX;
    int moveY = centerConY - centerY;*/
    drawPicViewerWnd(context);
    draw_picture(context, pic, ((context.width >> 1) - centerX)*enlargeRate + ((context.width-width/enlargeRate) >> 1)+X_shift*enlargeRate, 
     940:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
     943:	8b 45 0c             	mov    0xc(%ebp),%eax
     946:	d1 f8                	sar    %eax
     948:	2b 45 18             	sub    0x18(%ebp),%eax
     94b:	0f af 45 14          	imul   0x14(%ebp),%eax
     94f:	89 c3                	mov    %eax,%ebx
     951:	8b 75 0c             	mov    0xc(%ebp),%esi
     954:	8b 45 f4             	mov    -0xc(%ebp),%eax
     957:	99                   	cltd   
     958:	f7 7d 14             	idivl  0x14(%ebp)
     95b:	29 c6                	sub    %eax,%esi
     95d:	89 f0                	mov    %esi,%eax
     95f:	d1 f8                	sar    %eax
     961:	8d 14 03             	lea    (%ebx,%eax,1),%edx
     964:	a1 2c f7 00 00       	mov    0xf72c,%eax
     969:	0f af 45 14          	imul   0x14(%ebp),%eax
     96d:	01 d0                	add    %edx,%eax
     96f:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
     973:	89 44 24 18          	mov    %eax,0x18(%esp)
     977:	a1 40 25 01 00       	mov    0x12540,%eax
     97c:	89 44 24 0c          	mov    %eax,0xc(%esp)
     980:	a1 44 25 01 00       	mov    0x12544,%eax
     985:	89 44 24 10          	mov    %eax,0x10(%esp)
     989:	a1 48 25 01 00       	mov    0x12548,%eax
     98e:	89 44 24 14          	mov    %eax,0x14(%esp)
     992:	8b 45 08             	mov    0x8(%ebp),%eax
     995:	89 04 24             	mov    %eax,(%esp)
     998:	8b 45 0c             	mov    0xc(%ebp),%eax
     99b:	89 44 24 04          	mov    %eax,0x4(%esp)
     99f:	8b 45 10             	mov    0x10(%ebp),%eax
     9a2:	89 44 24 08          	mov    %eax,0x8(%esp)
     9a6:	e8 36 22 00 00       	call   2be1 <draw_picture>
TOPBAR_HEIGHT + (((context.height-TOPBAR_HEIGHT) >> 1) - (centerY-TOPBAR_HEIGHT))*enlargeRate + ((context.height-TOPBAR_HEIGHT-height/enlargeRate) >> 1)+Y_shift*enlargeRate);
	startXsave = ((context.width >> 1) - centerX)*enlargeRate + ((context.width-width/enlargeRate) >> 1)+X_shift*enlargeRate;
     9ab:	8b 45 0c             	mov    0xc(%ebp),%eax
     9ae:	d1 f8                	sar    %eax
     9b0:	2b 45 18             	sub    0x18(%ebp),%eax
     9b3:	0f af 45 14          	imul   0x14(%ebp),%eax
     9b7:	89 c1                	mov    %eax,%ecx
     9b9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     9bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9bf:	99                   	cltd   
     9c0:	f7 7d 14             	idivl  0x14(%ebp)
     9c3:	29 c3                	sub    %eax,%ebx
     9c5:	89 d8                	mov    %ebx,%eax
     9c7:	d1 f8                	sar    %eax
     9c9:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     9cc:	a1 2c f7 00 00       	mov    0xf72c,%eax
     9d1:	0f af 45 14          	imul   0x14(%ebp),%eax
     9d5:	01 d0                	add    %edx,%eax
     9d7:	a3 24 f7 00 00       	mov    %eax,0xf724
	startYsave = TOPBAR_HEIGHT + (((context.height-TOPBAR_HEIGHT) >> 1) - (centerY-TOPBAR_HEIGHT))*enlargeRate + ((context.height-TOPBAR_HEIGHT-height/enlargeRate) >> 1)+Y_shift*enlargeRate;
     9dc:	8b 45 10             	mov    0x10(%ebp),%eax
     9df:	83 e8 14             	sub    $0x14,%eax
     9e2:	d1 f8                	sar    %eax
     9e4:	89 c2                	mov    %eax,%edx
     9e6:	b8 14 00 00 00       	mov    $0x14,%eax
     9eb:	2b 45 1c             	sub    0x1c(%ebp),%eax
     9ee:	01 d0                	add    %edx,%eax
     9f0:	0f af 45 14          	imul   0x14(%ebp),%eax
     9f4:	8d 48 14             	lea    0x14(%eax),%ecx
     9f7:	8b 45 10             	mov    0x10(%ebp),%eax
     9fa:	8d 58 ec             	lea    -0x14(%eax),%ebx
     9fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a00:	99                   	cltd   
     a01:	f7 7d 14             	idivl  0x14(%ebp)
     a04:	29 c3                	sub    %eax,%ebx
     a06:	89 d8                	mov    %ebx,%eax
     a08:	d1 f8                	sar    %eax
     a0a:	8d 14 01             	lea    (%ecx,%eax,1),%edx
     a0d:	a1 30 f7 00 00       	mov    0xf730,%eax
     a12:	0f af 45 14          	imul   0x14(%ebp),%eax
     a16:	01 d0                	add    %edx,%eax
     a18:	a3 28 f7 00 00       	mov    %eax,0xf728

	printf(0,"Enlarge: context_width: %d, context_height: %d\n", context.width, context.height);
     a1d:	8b 55 10             	mov    0x10(%ebp),%edx
     a20:	8b 45 0c             	mov    0xc(%ebp),%eax
     a23:	89 54 24 0c          	mov    %edx,0xc(%esp)
     a27:	89 44 24 08          	mov    %eax,0x8(%esp)
     a2b:	c7 44 24 04 ec b2 00 	movl   $0xb2ec,0x4(%esp)
     a32:	00 
     a33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     a3a:	e8 0b 42 00 00       	call   4c4a <printf>
	printf(0,"Enlarge: width: %d, height: %d\n", width, height);
     a3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a42:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a49:	89 44 24 08          	mov    %eax,0x8(%esp)
     a4d:	c7 44 24 04 1c b3 00 	movl   $0xb31c,0x4(%esp)
     a54:	00 
     a55:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     a5c:	e8 e9 41 00 00       	call   4c4a <printf>
        printf(0,"Enlarge: centerX: %d, centerY: %d\n", centerX, centerY);
     a61:	8b 45 1c             	mov    0x1c(%ebp),%eax
     a64:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a68:	8b 45 18             	mov    0x18(%ebp),%eax
     a6b:	89 44 24 08          	mov    %eax,0x8(%esp)
     a6f:	c7 44 24 04 3c b3 00 	movl   $0xb33c,0x4(%esp)
     a76:	00 
     a77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     a7e:	e8 c7 41 00 00       	call   4c4a <printf>
 	updateWindowWithoutBlank(context);
     a83:	8b 45 08             	mov    0x8(%ebp),%eax
     a86:	89 04 24             	mov    %eax,(%esp)
     a89:	8b 45 0c             	mov    0xc(%ebp),%eax
     a8c:	89 44 24 04          	mov    %eax,0x4(%esp)
     a90:	8b 45 10             	mov    0x10(%ebp),%eax
     a93:	89 44 24 08          	mov    %eax,0x8(%esp)
     a97:	e8 7b 07 00 00       	call   1217 <updateWindowWithoutBlank>
	X_shift *= ((context.width-width/enlargeRate) >> 1)+X_shift*enlargeRate;
     a9c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     a9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa2:	99                   	cltd   
     aa3:	f7 7d 14             	idivl  0x14(%ebp)
     aa6:	29 c1                	sub    %eax,%ecx
     aa8:	89 c8                	mov    %ecx,%eax
     aaa:	d1 f8                	sar    %eax
     aac:	89 c2                	mov    %eax,%edx
     aae:	a1 2c f7 00 00       	mov    0xf72c,%eax
     ab3:	0f af 45 14          	imul   0x14(%ebp),%eax
     ab7:	01 c2                	add    %eax,%edx
     ab9:	a1 2c f7 00 00       	mov    0xf72c,%eax
     abe:	0f af c2             	imul   %edx,%eax
     ac1:	a3 2c f7 00 00       	mov    %eax,0xf72c
    	Y_shift *= ((context.height-TOPBAR_HEIGHT-height/enlargeRate) >> 1)+Y_shift*enlargeRate;
     ac6:	8b 45 10             	mov    0x10(%ebp),%eax
     ac9:	8d 48 ec             	lea    -0x14(%eax),%ecx
     acc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     acf:	99                   	cltd   
     ad0:	f7 7d 14             	idivl  0x14(%ebp)
     ad3:	29 c1                	sub    %eax,%ecx
     ad5:	89 c8                	mov    %ecx,%eax
     ad7:	d1 f8                	sar    %eax
     ad9:	89 c2                	mov    %eax,%edx
     adb:	a1 30 f7 00 00       	mov    0xf730,%eax
     ae0:	0f af 45 14          	imul   0x14(%ebp),%eax
     ae4:	01 c2                	add    %eax,%edx
     ae6:	a1 30 f7 00 00       	mov    0xf730,%eax
     aeb:	0f af c2             	imul   %edx,%eax
     aee:	a3 30 f7 00 00       	mov    %eax,0xf730
}
     af3:	83 c4 30             	add    $0x30,%esp
     af6:	5b                   	pop    %ebx
     af7:	5e                   	pop    %esi
     af8:	5d                   	pop    %ebp
     af9:	c3                   	ret    

00000afa <narrowPic>:

//缩小图片
void narrowPic(Context context,int narrowRate,int centerX, int centerY)
{
     afa:	55                   	push   %ebp
     afb:	89 e5                	mov    %esp,%ebp
     afd:	83 ec 48             	sub    $0x48,%esp
    int width = pic.width/(double)narrowRate;
     b00:	a1 44 25 01 00       	mov    0x12544,%eax
     b05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     b08:	db 45 e4             	fildl  -0x1c(%ebp)
     b0b:	db 45 14             	fildl  0x14(%ebp)
     b0e:	de f9                	fdivrp %st,%st(1)
     b10:	d9 7d e2             	fnstcw -0x1e(%ebp)
     b13:	0f b7 45 e2          	movzwl -0x1e(%ebp),%eax
     b17:	b4 0c                	mov    $0xc,%ah
     b19:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
     b1d:	d9 6d e0             	fldcw  -0x20(%ebp)
     b20:	db 5d f4             	fistpl -0xc(%ebp)
     b23:	d9 6d e2             	fldcw  -0x1e(%ebp)
    int height = pic.height/(double)narrowRate;
     b26:	a1 48 25 01 00       	mov    0x12548,%eax
     b2b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     b2e:	db 45 e4             	fildl  -0x1c(%ebp)
     b31:	db 45 14             	fildl  0x14(%ebp)
     b34:	de f9                	fdivrp %st,%st(1)
     b36:	d9 6d e0             	fldcw  -0x20(%ebp)
     b39:	db 5d f0             	fistpl -0x10(%ebp)
     b3c:	d9 6d e2             	fldcw  -0x1e(%ebp)
    compressPic(width,height);
     b3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b42:	89 44 24 04          	mov    %eax,0x4(%esp)
     b46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b49:	89 04 24             	mov    %eax,(%esp)
     b4c:	e8 dd f4 ff ff       	call   2e <compressPic>
    /*int centerConX = context.width/2.0;
    int centerConY = context.height/2.0;
    int moveX = centerConX - centerX;
    int moveY = centerConY - centerY;*/
    drawPicViewerWnd(context);
     b51:	8b 45 08             	mov    0x8(%ebp),%eax
     b54:	89 04 24             	mov    %eax,(%esp)
     b57:	8b 45 0c             	mov    0xc(%ebp),%eax
     b5a:	89 44 24 04          	mov    %eax,0x4(%esp)
     b5e:	8b 45 10             	mov    0x10(%ebp),%eax
     b61:	89 44 24 08          	mov    %eax,0x8(%esp)
     b65:	e8 b3 03 00 00       	call   f1d <drawPicViewerWnd>
    draw_picture(context, pic, (context.width-width) >> 1, TOPBAR_HEIGHT + ((context.height-height) >> 1));
     b6a:	8b 45 10             	mov    0x10(%ebp),%eax
     b6d:	2b 45 f0             	sub    -0x10(%ebp),%eax
     b70:	d1 f8                	sar    %eax
     b72:	8d 50 14             	lea    0x14(%eax),%edx
     b75:	8b 45 0c             	mov    0xc(%ebp),%eax
     b78:	2b 45 f4             	sub    -0xc(%ebp),%eax
     b7b:	d1 f8                	sar    %eax
     b7d:	89 54 24 1c          	mov    %edx,0x1c(%esp)
     b81:	89 44 24 18          	mov    %eax,0x18(%esp)
     b85:	a1 40 25 01 00       	mov    0x12540,%eax
     b8a:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b8e:	a1 44 25 01 00       	mov    0x12544,%eax
     b93:	89 44 24 10          	mov    %eax,0x10(%esp)
     b97:	a1 48 25 01 00       	mov    0x12548,%eax
     b9c:	89 44 24 14          	mov    %eax,0x14(%esp)
     ba0:	8b 45 08             	mov    0x8(%ebp),%eax
     ba3:	89 04 24             	mov    %eax,(%esp)
     ba6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ba9:	89 44 24 04          	mov    %eax,0x4(%esp)
     bad:	8b 45 10             	mov    0x10(%ebp),%eax
     bb0:	89 44 24 08          	mov    %eax,0x8(%esp)
     bb4:	e8 28 20 00 00       	call   2be1 <draw_picture>
    startXsave = (context.width-width) >> 1;
     bb9:	8b 45 0c             	mov    0xc(%ebp),%eax
     bbc:	2b 45 f4             	sub    -0xc(%ebp),%eax
     bbf:	d1 f8                	sar    %eax
     bc1:	a3 24 f7 00 00       	mov    %eax,0xf724
    startYsave = TOPBAR_HEIGHT + ((context.height-height) >> 1);
     bc6:	8b 45 10             	mov    0x10(%ebp),%eax
     bc9:	2b 45 f0             	sub    -0x10(%ebp),%eax
     bcc:	d1 f8                	sar    %eax
     bce:	83 c0 14             	add    $0x14,%eax
     bd1:	a3 28 f7 00 00       	mov    %eax,0xf728
    X_shift = 0;
     bd6:	c7 05 2c f7 00 00 00 	movl   $0x0,0xf72c
     bdd:	00 00 00 
    Y_shift = 0;
     be0:	c7 05 30 f7 00 00 00 	movl   $0x0,0xf730
     be7:	00 00 00 
}
     bea:	c9                   	leave  
     beb:	c3                   	ret    

00000bec <zoomingPic>:

//图片放缩
void zoomingPic(Context context,int centerX, int centerY)
{
     bec:	55                   	push   %ebp
     bed:	89 e5                	mov    %esp,%ebp
     bef:	83 ec 38             	sub    $0x38,%esp
	
    if(centerX > context.width || centerY > context.height) return;
     bf2:	8b 45 0c             	mov    0xc(%ebp),%eax
     bf5:	3b 45 14             	cmp    0x14(%ebp),%eax
     bf8:	7c 08                	jl     c02 <zoomingPic+0x16>
     bfa:	8b 45 10             	mov    0x10(%ebp),%eax
     bfd:	3b 45 18             	cmp    0x18(%ebp),%eax
     c00:	7d 05                	jge    c07 <zoomingPic+0x1b>
     c02:	e9 97 00 00 00       	jmp    c9e <zoomingPic+0xb2>
    int rate = 2;//待定等改
     c07:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
    switch(isZooming)
     c0e:	a1 1c f2 00 00       	mov    0xf21c,%eax
     c13:	83 f8 01             	cmp    $0x1,%eax
     c16:	74 07                	je     c1f <zoomingPic+0x33>
     c18:	83 f8 02             	cmp    $0x2,%eax
     c1b:	74 3c                	je     c59 <zoomingPic+0x6d>
     c1d:	eb 74                	jmp    c93 <zoomingPic+0xa7>
    {
        case 1:
            enlargePic(context,rate,centerX,centerY);
     c1f:	8b 45 18             	mov    0x18(%ebp),%eax
     c22:	89 44 24 14          	mov    %eax,0x14(%esp)
     c26:	8b 45 14             	mov    0x14(%ebp),%eax
     c29:	89 44 24 10          	mov    %eax,0x10(%esp)
     c2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c30:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c34:	8b 45 08             	mov    0x8(%ebp),%eax
     c37:	89 04 24             	mov    %eax,(%esp)
     c3a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c3d:	89 44 24 04          	mov    %eax,0x4(%esp)
     c41:	8b 45 10             	mov    0x10(%ebp),%eax
     c44:	89 44 24 08          	mov    %eax,0x8(%esp)
     c48:	e8 4d fc ff ff       	call   89a <enlargePic>
            isZooming = 2;
     c4d:	c7 05 1c f2 00 00 02 	movl   $0x2,0xf21c
     c54:	00 00 00 
            break;
     c57:	eb 45                	jmp    c9e <zoomingPic+0xb2>
        case 2:
            narrowPic(context,rate,centerX,centerY);
     c59:	8b 45 18             	mov    0x18(%ebp),%eax
     c5c:	89 44 24 14          	mov    %eax,0x14(%esp)
     c60:	8b 45 14             	mov    0x14(%ebp),%eax
     c63:	89 44 24 10          	mov    %eax,0x10(%esp)
     c67:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c6a:	89 44 24 0c          	mov    %eax,0xc(%esp)
     c6e:	8b 45 08             	mov    0x8(%ebp),%eax
     c71:	89 04 24             	mov    %eax,(%esp)
     c74:	8b 45 0c             	mov    0xc(%ebp),%eax
     c77:	89 44 24 04          	mov    %eax,0x4(%esp)
     c7b:	8b 45 10             	mov    0x10(%ebp),%eax
     c7e:	89 44 24 08          	mov    %eax,0x8(%esp)
     c82:	e8 73 fe ff ff       	call   afa <narrowPic>
            isZooming = 1;
     c87:	c7 05 1c f2 00 00 01 	movl   $0x1,0xf21c
     c8e:	00 00 00 
            break;
     c91:	eb 0b                	jmp    c9e <zoomingPic+0xb2>
        default:
            isZooming = 1;
     c93:	c7 05 1c f2 00 00 01 	movl   $0x1,0xf21c
     c9a:	00 00 00 
            break;
     c9d:	90                   	nop
    }
} 
     c9e:	c9                   	leave  
     c9f:	c3                   	ret    

00000ca0 <rollingPic>:

//Picture Rolling
void rollingPic(Context context)
{
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	53                   	push   %ebx
     ca4:	83 ec 34             	sub    $0x34,%esp
	RGBQUAD* cache = (RGBQUAD *) malloc(pic.width * pic.height * sizeof(RGBQUAD));
     ca7:	8b 15 44 25 01 00    	mov    0x12544,%edx
     cad:	a1 48 25 01 00       	mov    0x12548,%eax
     cb2:	0f af c2             	imul   %edx,%eax
     cb5:	c1 e0 02             	shl    $0x2,%eax
     cb8:	89 04 24             	mov    %eax,(%esp)
     cbb:	e8 76 42 00 00       	call   4f36 <malloc>
     cc0:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int i,j;
	for (i = 0; i < pic.height; i++){
     cc3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cca:	eb 60                	jmp    d2c <rollingPic+0x8c>
		for(j = 0; j < pic.width;j++){
     ccc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     cd3:	eb 49                	jmp    d1e <rollingPic+0x7e>
			cache[(pic.width - 1 - j)*pic.height + i] = pic.data[i*pic.width + j];
     cd5:	a1 44 25 01 00       	mov    0x12544,%eax
     cda:	83 e8 01             	sub    $0x1,%eax
     cdd:	2b 45 f0             	sub    -0x10(%ebp),%eax
     ce0:	89 c2                	mov    %eax,%edx
     ce2:	a1 48 25 01 00       	mov    0x12548,%eax
     ce7:	0f af d0             	imul   %eax,%edx
     cea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ced:	01 d0                	add    %edx,%eax
     cef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     cf6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cf9:	01 c2                	add    %eax,%edx
     cfb:	8b 0d 40 25 01 00    	mov    0x12540,%ecx
     d01:	a1 44 25 01 00       	mov    0x12544,%eax
     d06:	0f af 45 f4          	imul   -0xc(%ebp),%eax
     d0a:	89 c3                	mov    %eax,%ebx
     d0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d0f:	01 d8                	add    %ebx,%eax
     d11:	c1 e0 02             	shl    $0x2,%eax
     d14:	01 c8                	add    %ecx,%eax
     d16:	8b 00                	mov    (%eax),%eax
     d18:	89 02                	mov    %eax,(%edx)
void rollingPic(Context context)
{
	RGBQUAD* cache = (RGBQUAD *) malloc(pic.width * pic.height * sizeof(RGBQUAD));
	int i,j;
	for (i = 0; i < pic.height; i++){
		for(j = 0; j < pic.width;j++){
     d1a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     d1e:	a1 44 25 01 00       	mov    0x12544,%eax
     d23:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d26:	7f ad                	jg     cd5 <rollingPic+0x35>
//Picture Rolling
void rollingPic(Context context)
{
	RGBQUAD* cache = (RGBQUAD *) malloc(pic.width * pic.height * sizeof(RGBQUAD));
	int i,j;
	for (i = 0; i < pic.height; i++){
     d28:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d2c:	a1 48 25 01 00       	mov    0x12548,%eax
     d31:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     d34:	7f 96                	jg     ccc <rollingPic+0x2c>
		for(j = 0; j < pic.width;j++){
			cache[(pic.width - 1 - j)*pic.height + i] = pic.data[i*pic.width + j];
		}	
	}
	free(pic.data);
     d36:	a1 40 25 01 00       	mov    0x12540,%eax
     d3b:	89 04 24             	mov    %eax,(%esp)
     d3e:	e8 ba 40 00 00       	call   4dfd <free>
	i = pic.width;
     d43:	a1 44 25 01 00       	mov    0x12544,%eax
     d48:	89 45 f4             	mov    %eax,-0xc(%ebp)
	pic.width = pic.height;
     d4b:	a1 48 25 01 00       	mov    0x12548,%eax
     d50:	a3 44 25 01 00       	mov    %eax,0x12544
	pic.height = i;
     d55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d58:	a3 48 25 01 00       	mov    %eax,0x12548
	pic.data = cache;	
     d5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d60:	a3 40 25 01 00       	mov    %eax,0x12540
	drawPicViewerWnd(context);
     d65:	8b 45 08             	mov    0x8(%ebp),%eax
     d68:	89 04 24             	mov    %eax,(%esp)
     d6b:	8b 45 0c             	mov    0xc(%ebp),%eax
     d6e:	89 44 24 04          	mov    %eax,0x4(%esp)
     d72:	8b 45 10             	mov    0x10(%ebp),%eax
     d75:	89 44 24 08          	mov    %eax,0x8(%esp)
     d79:	e8 9f 01 00 00       	call   f1d <drawPicViewerWnd>
    	draw_picture(context, pic, (context.width-pic.width) >> 1, TOPBAR_HEIGHT + ((context.height-pic.height) >> 1));
     d7e:	8b 55 10             	mov    0x10(%ebp),%edx
     d81:	a1 48 25 01 00       	mov    0x12548,%eax
     d86:	29 c2                	sub    %eax,%edx
     d88:	89 d0                	mov    %edx,%eax
     d8a:	d1 f8                	sar    %eax
     d8c:	8d 50 14             	lea    0x14(%eax),%edx
     d8f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     d92:	a1 44 25 01 00       	mov    0x12544,%eax
     d97:	29 c1                	sub    %eax,%ecx
     d99:	89 c8                	mov    %ecx,%eax
     d9b:	d1 f8                	sar    %eax
     d9d:	89 54 24 1c          	mov    %edx,0x1c(%esp)
     da1:	89 44 24 18          	mov    %eax,0x18(%esp)
     da5:	a1 40 25 01 00       	mov    0x12540,%eax
     daa:	89 44 24 0c          	mov    %eax,0xc(%esp)
     dae:	a1 44 25 01 00       	mov    0x12544,%eax
     db3:	89 44 24 10          	mov    %eax,0x10(%esp)
     db7:	a1 48 25 01 00       	mov    0x12548,%eax
     dbc:	89 44 24 14          	mov    %eax,0x14(%esp)
     dc0:	8b 45 08             	mov    0x8(%ebp),%eax
     dc3:	89 04 24             	mov    %eax,(%esp)
     dc6:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc9:	89 44 24 04          	mov    %eax,0x4(%esp)
     dcd:	8b 45 10             	mov    0x10(%ebp),%eax
     dd0:	89 44 24 08          	mov    %eax,0x8(%esp)
     dd4:	e8 08 1e 00 00       	call   2be1 <draw_picture>
	startXsave = (context.width-pic.width) >> 1;
     dd9:	8b 55 0c             	mov    0xc(%ebp),%edx
     ddc:	a1 44 25 01 00       	mov    0x12544,%eax
     de1:	29 c2                	sub    %eax,%edx
     de3:	89 d0                	mov    %edx,%eax
     de5:	d1 f8                	sar    %eax
     de7:	a3 24 f7 00 00       	mov    %eax,0xf724
        startYsave = TOPBAR_HEIGHT + ((context.height-pic.height) >> 1);
     dec:	8b 55 10             	mov    0x10(%ebp),%edx
     def:	a1 48 25 01 00       	mov    0x12548,%eax
     df4:	29 c2                	sub    %eax,%edx
     df6:	89 d0                	mov    %edx,%eax
     df8:	d1 f8                	sar    %eax
     dfa:	83 c0 14             	add    $0x14,%eax
     dfd:	a3 28 f7 00 00       	mov    %eax,0xf728
	updateWindowWithoutBlank(context);
     e02:	8b 45 08             	mov    0x8(%ebp),%eax
     e05:	89 04 24             	mov    %eax,(%esp)
     e08:	8b 45 0c             	mov    0xc(%ebp),%eax
     e0b:	89 44 24 04          	mov    %eax,0x4(%esp)
     e0f:	8b 45 10             	mov    0x10(%ebp),%eax
     e12:	89 44 24 08          	mov    %eax,0x8(%esp)
     e16:	e8 fc 03 00 00       	call   1217 <updateWindowWithoutBlank>
	
}
     e1b:	83 c4 34             	add    $0x34,%esp
     e1e:	5b                   	pop    %ebx
     e1f:	5d                   	pop    %ebp
     e20:	c3                   	ret    

00000e21 <nextPic>:

//Picture next
void nextPic(Context context)
{
     e21:	55                   	push   %ebp
     e22:	89 e5                	mov    %esp,%ebp
     e24:	83 ec 18             	sub    $0x18,%esp
	X_shift = 0;
     e27:	c7 05 2c f7 00 00 00 	movl   $0x0,0xf72c
     e2e:	00 00 00 
	Y_shift = 0;
     e31:	c7 05 30 f7 00 00 00 	movl   $0x0,0xf730
     e38:	00 00 00 
	isZooming = 1;
     e3b:	c7 05 1c f2 00 00 01 	movl   $0x1,0xf21c
     e42:	00 00 00 
	pos = (pos+1) % len;	
     e45:	a1 4c 25 01 00       	mov    0x1254c,%eax
     e4a:	83 c0 01             	add    $0x1,%eax
     e4d:	8b 0d f0 26 01 00    	mov    0x126f0,%ecx
     e53:	99                   	cltd   
     e54:	f7 f9                	idiv   %ecx
     e56:	89 d0                	mov    %edx,%eax
     e58:	a3 4c 25 01 00       	mov    %eax,0x1254c
	if(pos==0)pos++;
     e5d:	a1 4c 25 01 00       	mov    0x1254c,%eax
     e62:	85 c0                	test   %eax,%eax
     e64:	75 0d                	jne    e73 <nextPic+0x52>
     e66:	a1 4c 25 01 00       	mov    0x1254c,%eax
     e6b:	83 c0 01             	add    $0x1,%eax
     e6e:	a3 4c 25 01 00       	mov    %eax,0x1254c
	printf(0,"%d\n",pos);
     e73:	a1 4c 25 01 00       	mov    0x1254c,%eax
     e78:	89 44 24 08          	mov    %eax,0x8(%esp)
     e7c:	c7 44 24 04 5f b3 00 	movl   $0xb35f,0x4(%esp)
     e83:	00 
     e84:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e8b:	e8 ba 3d 00 00       	call   4c4a <printf>
	loadBitmap(&pic, file[pos]);
     e90:	a1 4c 25 01 00       	mov    0x1254c,%eax
     e95:	8b 04 85 60 25 01 00 	mov    0x12560(,%eax,4),%eax
     e9c:	89 44 24 04          	mov    %eax,0x4(%esp)
     ea0:	c7 04 24 40 25 01 00 	movl   $0x12540,(%esp)
     ea7:	e8 16 25 00 00       	call   33c2 <loadBitmap>
	drawPicViewerWnd(context);
     eac:	8b 45 08             	mov    0x8(%ebp),%eax
     eaf:	89 04 24             	mov    %eax,(%esp)
     eb2:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb5:	89 44 24 04          	mov    %eax,0x4(%esp)
     eb9:	8b 45 10             	mov    0x10(%ebp),%eax
     ebc:	89 44 24 08          	mov    %eax,0x8(%esp)
     ec0:	e8 58 00 00 00       	call   f1d <drawPicViewerWnd>
	drawPicViewerContent(context, file[pos]);
     ec5:	a1 4c 25 01 00       	mov    0x1254c,%eax
     eca:	8b 04 85 60 25 01 00 	mov    0x12560(,%eax,4),%eax
     ed1:	89 44 24 0c          	mov    %eax,0xc(%esp)
     ed5:	8b 45 08             	mov    0x8(%ebp),%eax
     ed8:	89 04 24             	mov    %eax,(%esp)
     edb:	8b 45 0c             	mov    0xc(%ebp),%eax
     ede:	89 44 24 04          	mov    %eax,0x4(%esp)
     ee2:	8b 45 10             	mov    0x10(%ebp),%eax
     ee5:	89 44 24 08          	mov    %eax,0x8(%esp)
     ee9:	e8 0b 06 00 00       	call   14f9 <drawPicViewerContent>
	updateWindowWithoutBlank(context);
     eee:	8b 45 08             	mov    0x8(%ebp),%eax
     ef1:	89 04 24             	mov    %eax,(%esp)
     ef4:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef7:	89 44 24 04          	mov    %eax,0x4(%esp)
     efb:	8b 45 10             	mov    0x10(%ebp),%eax
     efe:	89 44 24 08          	mov    %eax,0x8(%esp)
     f02:	e8 10 03 00 00       	call   1217 <updateWindowWithoutBlank>
	


	printf(0,"NEXT!\n");
     f07:	c7 44 24 04 63 b3 00 	movl   $0xb363,0x4(%esp)
     f0e:	00 
     f0f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f16:	e8 2f 3d 00 00       	call   4c4a <printf>
	
}
     f1b:	c9                   	leave  
     f1c:	c3                   	ret    

00000f1d <drawPicViewerWnd>:


// 绘制窗口
void drawPicViewerWnd(Context context) {
     f1d:	55                   	push   %ebp
     f1e:	89 e5                	mov    %esp,%ebp
     f20:	83 ec 48             	sub    $0x48,%esp
    int width, height;

    width = context.width;
     f23:	8b 45 0c             	mov    0xc(%ebp),%eax
     f26:	89 45 f4             	mov    %eax,-0xc(%ebp)
    height = context.height;
     f29:	8b 45 10             	mov    0x10(%ebp),%eax
     f2c:	89 45 f0             	mov    %eax,-0x10(%ebp)

    fill_rect(context, 0, 0, width, height, 0xFFFF);
     f2f:	8b 55 f0             	mov    -0x10(%ebp),%edx
     f32:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f35:	c7 44 24 1c ff ff 00 	movl   $0xffff,0x1c(%esp)
     f3c:	00 
     f3d:	89 54 24 18          	mov    %edx,0x18(%esp)
     f41:	89 44 24 14          	mov    %eax,0x14(%esp)
     f45:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     f4c:	00 
     f4d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     f54:	00 
     f55:	8b 45 08             	mov    0x8(%ebp),%eax
     f58:	89 04 24             	mov    %eax,(%esp)
     f5b:	8b 45 0c             	mov    0xc(%ebp),%eax
     f5e:	89 44 24 04          	mov    %eax,0x4(%esp)
     f62:	8b 45 10             	mov    0x10(%ebp),%eax
     f65:	89 44 24 08          	mov    %eax,0x8(%esp)
     f69:	e8 4b 14 00 00       	call   23b9 <fill_rect>

    draw_line(context, 0, 0, width-1, 0, BORDERLINE_COLOR);
     f6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f71:	83 e8 01             	sub    $0x1,%eax
     f74:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     f7b:	00 
     f7c:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
     f83:	00 
     f84:	89 44 24 14          	mov    %eax,0x14(%esp)
     f88:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     f8f:	00 
     f90:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     f97:	00 
     f98:	8b 45 08             	mov    0x8(%ebp),%eax
     f9b:	89 04 24             	mov    %eax,(%esp)
     f9e:	8b 45 0c             	mov    0xc(%ebp),%eax
     fa1:	89 44 24 04          	mov    %eax,0x4(%esp)
     fa5:	8b 45 10             	mov    0x10(%ebp),%eax
     fa8:	89 44 24 08          	mov    %eax,0x8(%esp)
     fac:	e8 06 1d 00 00       	call   2cb7 <draw_line>
    draw_line(context, width-1, 0, width-1, height-1, BORDERLINE_COLOR);
     fb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fb4:	8d 48 ff             	lea    -0x1(%eax),%ecx
     fb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fba:	8d 50 ff             	lea    -0x1(%eax),%edx
     fbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fc0:	83 e8 01             	sub    $0x1,%eax
     fc3:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
     fca:	00 
     fcb:	89 4c 24 18          	mov    %ecx,0x18(%esp)
     fcf:	89 54 24 14          	mov    %edx,0x14(%esp)
     fd3:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     fda:	00 
     fdb:	89 44 24 0c          	mov    %eax,0xc(%esp)
     fdf:	8b 45 08             	mov    0x8(%ebp),%eax
     fe2:	89 04 24             	mov    %eax,(%esp)
     fe5:	8b 45 0c             	mov    0xc(%ebp),%eax
     fe8:	89 44 24 04          	mov    %eax,0x4(%esp)
     fec:	8b 45 10             	mov    0x10(%ebp),%eax
     fef:	89 44 24 08          	mov    %eax,0x8(%esp)
     ff3:	e8 bf 1c 00 00       	call   2cb7 <draw_line>
    draw_line(context, 0, height-1, width-1, height-1, BORDERLINE_COLOR);
     ff8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ffb:	8d 48 ff             	lea    -0x1(%eax),%ecx
     ffe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1001:	8d 50 ff             	lea    -0x1(%eax),%edx
    1004:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1007:	83 e8 01             	sub    $0x1,%eax
    100a:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    1011:	00 
    1012:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    1016:	89 54 24 14          	mov    %edx,0x14(%esp)
    101a:	89 44 24 10          	mov    %eax,0x10(%esp)
    101e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1025:	00 
    1026:	8b 45 08             	mov    0x8(%ebp),%eax
    1029:	89 04 24             	mov    %eax,(%esp)
    102c:	8b 45 0c             	mov    0xc(%ebp),%eax
    102f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1033:	8b 45 10             	mov    0x10(%ebp),%eax
    1036:	89 44 24 08          	mov    %eax,0x8(%esp)
    103a:	e8 78 1c 00 00       	call   2cb7 <draw_line>
    draw_line(context, 0, height-1, 0, 0, BORDERLINE_COLOR);
    103f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1042:	83 e8 01             	sub    $0x1,%eax
    1045:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    104c:	00 
    104d:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    1054:	00 
    1055:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    105c:	00 
    105d:	89 44 24 10          	mov    %eax,0x10(%esp)
    1061:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1068:	00 
    1069:	8b 45 08             	mov    0x8(%ebp),%eax
    106c:	89 04 24             	mov    %eax,(%esp)
    106f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1072:	89 44 24 04          	mov    %eax,0x4(%esp)
    1076:	8b 45 10             	mov    0x10(%ebp),%eax
    1079:	89 44 24 08          	mov    %eax,0x8(%esp)
    107d:	e8 35 1c 00 00       	call   2cb7 <draw_line>

    fill_rect(context, 1, 1, width-2, TOPBAR_HEIGHT, TOPBAR_COLOR);
    1082:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1085:	83 e8 02             	sub    $0x2,%eax
    1088:	c7 44 24 1c cb 5a 00 	movl   $0x5acb,0x1c(%esp)
    108f:	00 
    1090:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    1097:	00 
    1098:	89 44 24 14          	mov    %eax,0x14(%esp)
    109c:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
    10a3:	00 
    10a4:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    10ab:	00 
    10ac:	8b 45 08             	mov    0x8(%ebp),%eax
    10af:	89 04 24             	mov    %eax,(%esp)
    10b2:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b5:	89 44 24 04          	mov    %eax,0x4(%esp)
    10b9:	8b 45 10             	mov    0x10(%ebp),%eax
    10bc:	89 44 24 08          	mov    %eax,0x8(%esp)
    10c0:	e8 f4 12 00 00       	call   23b9 <fill_rect>
    puts_str(context, "PictureViewer", 0, WINDOW_WIDTH/2 - 53, 3);
    10c5:	c7 44 24 18 03 00 00 	movl   $0x3,0x18(%esp)
    10cc:	00 
    10cd:	c7 44 24 14 c5 00 00 	movl   $0xc5,0x14(%esp)
    10d4:	00 
    10d5:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    10dc:	00 
    10dd:	c7 44 24 0c 6a b3 00 	movl   $0xb36a,0xc(%esp)
    10e4:	00 
    10e5:	8b 45 08             	mov    0x8(%ebp),%eax
    10e8:	89 04 24             	mov    %eax,(%esp)
    10eb:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ee:	89 44 24 04          	mov    %eax,0x4(%esp)
    10f2:	8b 45 10             	mov    0x10(%ebp),%eax
    10f5:	89 44 24 08          	mov    %eax,0x8(%esp)
    10f9:	e8 d4 19 00 00       	call   2ad2 <puts_str>

    draw_iconlist(context, wndRes, sizeof(wndRes) / sizeof(ICON));
    10fe:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
    1105:	00 
    1106:	c7 44 24 0c e0 f1 00 	movl   $0xf1e0,0xc(%esp)
    110d:	00 
    110e:	8b 45 08             	mov    0x8(%ebp),%eax
    1111:	89 04 24             	mov    %eax,(%esp)
    1114:	8b 45 0c             	mov    0xc(%ebp),%eax
    1117:	89 44 24 04          	mov    %eax,0x4(%esp)
    111b:	8b 45 10             	mov    0x10(%ebp),%eax
    111e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1122:	e8 1c 22 00 00       	call   3343 <draw_iconlist>
    PICNODE rolling;
    loadBitmap(&rolling, "rolling.bmp");
    1127:	c7 44 24 04 78 b3 00 	movl   $0xb378,0x4(%esp)
    112e:	00 
    112f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1132:	89 04 24             	mov    %eax,(%esp)
    1135:	e8 88 22 00 00       	call   33c2 <loadBitmap>
    compressAnyPic(&rolling,16,16);
    113a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1141:	00 
    1142:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
    1149:	00 
    114a:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    114d:	89 04 24             	mov    %eax,(%esp)
    1150:	e8 98 f2 ff ff       	call   3ed <compressAnyPic>
    draw_picture(context, rolling, 40, 3);
    1155:	c7 44 24 1c 03 00 00 	movl   $0x3,0x1c(%esp)
    115c:	00 
    115d:	c7 44 24 18 28 00 00 	movl   $0x28,0x18(%esp)
    1164:	00 
    1165:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1168:	89 44 24 0c          	mov    %eax,0xc(%esp)
    116c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    116f:	89 44 24 10          	mov    %eax,0x10(%esp)
    1173:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1176:	89 44 24 14          	mov    %eax,0x14(%esp)
    117a:	8b 45 08             	mov    0x8(%ebp),%eax
    117d:	89 04 24             	mov    %eax,(%esp)
    1180:	8b 45 0c             	mov    0xc(%ebp),%eax
    1183:	89 44 24 04          	mov    %eax,0x4(%esp)
    1187:	8b 45 10             	mov    0x10(%ebp),%eax
    118a:	89 44 24 08          	mov    %eax,0x8(%esp)
    118e:	e8 4e 1a 00 00       	call   2be1 <draw_picture>
    freepic(&rolling);
    1193:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1196:	89 04 24             	mov    %eax,(%esp)
    1199:	e8 d0 27 00 00       	call   396e <freepic>

    PICNODE next;
    loadBitmap(&next, "next.bmp");
    119e:	c7 44 24 04 84 b3 00 	movl   $0xb384,0x4(%esp)
    11a5:	00 
    11a6:	8d 45 d8             	lea    -0x28(%ebp),%eax
    11a9:	89 04 24             	mov    %eax,(%esp)
    11ac:	e8 11 22 00 00       	call   33c2 <loadBitmap>
    compressAnyPic(&next,16,16);
    11b1:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    11b8:	00 
    11b9:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
    11c0:	00 
    11c1:	8d 45 d8             	lea    -0x28(%ebp),%eax
    11c4:	89 04 24             	mov    %eax,(%esp)
    11c7:	e8 21 f2 ff ff       	call   3ed <compressAnyPic>
    draw_picture(context, next, 60, 3);
    11cc:	c7 44 24 1c 03 00 00 	movl   $0x3,0x1c(%esp)
    11d3:	00 
    11d4:	c7 44 24 18 3c 00 00 	movl   $0x3c,0x18(%esp)
    11db:	00 
    11dc:	8b 45 d8             	mov    -0x28(%ebp),%eax
    11df:	89 44 24 0c          	mov    %eax,0xc(%esp)
    11e3:	8b 45 dc             	mov    -0x24(%ebp),%eax
    11e6:	89 44 24 10          	mov    %eax,0x10(%esp)
    11ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11ed:	89 44 24 14          	mov    %eax,0x14(%esp)
    11f1:	8b 45 08             	mov    0x8(%ebp),%eax
    11f4:	89 04 24             	mov    %eax,(%esp)
    11f7:	8b 45 0c             	mov    0xc(%ebp),%eax
    11fa:	89 44 24 04          	mov    %eax,0x4(%esp)
    11fe:	8b 45 10             	mov    0x10(%ebp),%eax
    1201:	89 44 24 08          	mov    %eax,0x8(%esp)
    1205:	e8 d7 19 00 00       	call   2be1 <draw_picture>
    freepic(&next);
    120a:	8d 45 d8             	lea    -0x28(%ebp),%eax
    120d:	89 04 24             	mov    %eax,(%esp)
    1210:	e8 59 27 00 00       	call   396e <freepic>
}
    1215:	c9                   	leave  
    1216:	c3                   	ret    

00001217 <updateWindowWithoutBlank>:

//Update Something
void updateWindowWithoutBlank(Context context)
{
    1217:	55                   	push   %ebp
    1218:	89 e5                	mov    %esp,%ebp
    121a:	83 ec 58             	sub    $0x58,%esp
	PICNODE picCha;
  	draw_line(context, 0, 0, context.width - 1, 0, BORDERLINE_COLOR);
    121d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1220:	83 e8 01             	sub    $0x1,%eax
    1223:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    122a:	00 
    122b:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    1232:	00 
    1233:	89 44 24 14          	mov    %eax,0x14(%esp)
    1237:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    123e:	00 
    123f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1246:	00 
    1247:	8b 45 08             	mov    0x8(%ebp),%eax
    124a:	89 04 24             	mov    %eax,(%esp)
    124d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1250:	89 44 24 04          	mov    %eax,0x4(%esp)
    1254:	8b 45 10             	mov    0x10(%ebp),%eax
    1257:	89 44 24 08          	mov    %eax,0x8(%esp)
    125b:	e8 57 1a 00 00       	call   2cb7 <draw_line>
  	draw_line(context, context.width - 1, 0, context.width - 1, context.height - 1, BORDERLINE_COLOR);
    1260:	8b 45 10             	mov    0x10(%ebp),%eax
    1263:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1266:	8b 45 0c             	mov    0xc(%ebp),%eax
    1269:	8d 50 ff             	lea    -0x1(%eax),%edx
    126c:	8b 45 0c             	mov    0xc(%ebp),%eax
    126f:	83 e8 01             	sub    $0x1,%eax
    1272:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    1279:	00 
    127a:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    127e:	89 54 24 14          	mov    %edx,0x14(%esp)
    1282:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    1289:	00 
    128a:	89 44 24 0c          	mov    %eax,0xc(%esp)
    128e:	8b 45 08             	mov    0x8(%ebp),%eax
    1291:	89 04 24             	mov    %eax,(%esp)
    1294:	8b 45 0c             	mov    0xc(%ebp),%eax
    1297:	89 44 24 04          	mov    %eax,0x4(%esp)
    129b:	8b 45 10             	mov    0x10(%ebp),%eax
    129e:	89 44 24 08          	mov    %eax,0x8(%esp)
    12a2:	e8 10 1a 00 00       	call   2cb7 <draw_line>
  	draw_line(context, context.width - 1, context.height - 1, 0, context.height - 1, BORDERLINE_COLOR);
    12a7:	8b 45 10             	mov    0x10(%ebp),%eax
    12aa:	8d 48 ff             	lea    -0x1(%eax),%ecx
    12ad:	8b 45 10             	mov    0x10(%ebp),%eax
    12b0:	8d 50 ff             	lea    -0x1(%eax),%edx
    12b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b6:	83 e8 01             	sub    $0x1,%eax
    12b9:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    12c0:	00 
    12c1:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    12c5:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    12cc:	00 
    12cd:	89 54 24 10          	mov    %edx,0x10(%esp)
    12d1:	89 44 24 0c          	mov    %eax,0xc(%esp)
    12d5:	8b 45 08             	mov    0x8(%ebp),%eax
    12d8:	89 04 24             	mov    %eax,(%esp)
    12db:	8b 45 0c             	mov    0xc(%ebp),%eax
    12de:	89 44 24 04          	mov    %eax,0x4(%esp)
    12e2:	8b 45 10             	mov    0x10(%ebp),%eax
    12e5:	89 44 24 08          	mov    %eax,0x8(%esp)
    12e9:	e8 c9 19 00 00       	call   2cb7 <draw_line>
  	draw_line(context, 0, context.height - 1, 0, 0, BORDERLINE_COLOR);
    12ee:	8b 45 10             	mov    0x10(%ebp),%eax
    12f1:	83 e8 01             	sub    $0x1,%eax
    12f4:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    12fb:	00 
    12fc:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    1303:	00 
    1304:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    130b:	00 
    130c:	89 44 24 10          	mov    %eax,0x10(%esp)
    1310:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1317:	00 
    1318:	8b 45 08             	mov    0x8(%ebp),%eax
    131b:	89 04 24             	mov    %eax,(%esp)
    131e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1321:	89 44 24 04          	mov    %eax,0x4(%esp)
    1325:	8b 45 10             	mov    0x10(%ebp),%eax
    1328:	89 44 24 08          	mov    %eax,0x8(%esp)
    132c:	e8 86 19 00 00       	call   2cb7 <draw_line>
  	fill_rect(context, 1, 1, context.width - 2, BOTTOMBAR_HEIGHT, TOPBAR_COLOR);
    1331:	8b 45 0c             	mov    0xc(%ebp),%eax
    1334:	83 e8 02             	sub    $0x2,%eax
    1337:	c7 44 24 1c cb 5a 00 	movl   $0x5acb,0x1c(%esp)
    133e:	00 
    133f:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    1346:	00 
    1347:	89 44 24 14          	mov    %eax,0x14(%esp)
    134b:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
    1352:	00 
    1353:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    135a:	00 
    135b:	8b 45 08             	mov    0x8(%ebp),%eax
    135e:	89 04 24             	mov    %eax,(%esp)
    1361:	8b 45 0c             	mov    0xc(%ebp),%eax
    1364:	89 44 24 04          	mov    %eax,0x4(%esp)
    1368:	8b 45 10             	mov    0x10(%ebp),%eax
    136b:	89 44 24 08          	mov    %eax,0x8(%esp)
    136f:	e8 45 10 00 00       	call   23b9 <fill_rect>
  	loadBitmap(&picCha, "close.bmp");
    1374:	c7 44 24 04 8d b3 00 	movl   $0xb38d,0x4(%esp)
    137b:	00 
    137c:	8d 45 ec             	lea    -0x14(%ebp),%eax
    137f:	89 04 24             	mov    %eax,(%esp)
    1382:	e8 3b 20 00 00       	call   33c2 <loadBitmap>
  	draw_picture(context, picCha, 3, 3);
    1387:	c7 44 24 1c 03 00 00 	movl   $0x3,0x1c(%esp)
    138e:	00 
    138f:	c7 44 24 18 03 00 00 	movl   $0x3,0x18(%esp)
    1396:	00 
    1397:	8b 45 ec             	mov    -0x14(%ebp),%eax
    139a:	89 44 24 0c          	mov    %eax,0xc(%esp)
    139e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13a1:	89 44 24 10          	mov    %eax,0x10(%esp)
    13a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13a8:	89 44 24 14          	mov    %eax,0x14(%esp)
    13ac:	8b 45 08             	mov    0x8(%ebp),%eax
    13af:	89 04 24             	mov    %eax,(%esp)
    13b2:	8b 45 0c             	mov    0xc(%ebp),%eax
    13b5:	89 44 24 04          	mov    %eax,0x4(%esp)
    13b9:	8b 45 10             	mov    0x10(%ebp),%eax
    13bc:	89 44 24 08          	mov    %eax,0x8(%esp)
    13c0:	e8 1c 18 00 00       	call   2be1 <draw_picture>
  	puts_str(context, "PictureViewer", 0, WINDOW_WIDTH/2 - 53, 3);
    13c5:	c7 44 24 18 03 00 00 	movl   $0x3,0x18(%esp)
    13cc:	00 
    13cd:	c7 44 24 14 c5 00 00 	movl   $0xc5,0x14(%esp)
    13d4:	00 
    13d5:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    13dc:	00 
    13dd:	c7 44 24 0c 6a b3 00 	movl   $0xb36a,0xc(%esp)
    13e4:	00 
    13e5:	8b 45 08             	mov    0x8(%ebp),%eax
    13e8:	89 04 24             	mov    %eax,(%esp)
    13eb:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ee:	89 44 24 04          	mov    %eax,0x4(%esp)
    13f2:	8b 45 10             	mov    0x10(%ebp),%eax
    13f5:	89 44 24 08          	mov    %eax,0x8(%esp)
    13f9:	e8 d4 16 00 00       	call   2ad2 <puts_str>
  	freepic(&picCha);
    13fe:	8d 45 ec             	lea    -0x14(%ebp),%eax
    1401:	89 04 24             	mov    %eax,(%esp)
    1404:	e8 65 25 00 00       	call   396e <freepic>
	PICNODE rolling;
    	loadBitmap(&rolling, "rolling.bmp");
    1409:	c7 44 24 04 78 b3 00 	movl   $0xb378,0x4(%esp)
    1410:	00 
    1411:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1414:	89 04 24             	mov    %eax,(%esp)
    1417:	e8 a6 1f 00 00       	call   33c2 <loadBitmap>
    	compressAnyPic(&rolling,16,16);
    141c:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1423:	00 
    1424:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
    142b:	00 
    142c:	8d 45 e0             	lea    -0x20(%ebp),%eax
    142f:	89 04 24             	mov    %eax,(%esp)
    1432:	e8 b6 ef ff ff       	call   3ed <compressAnyPic>
    	draw_picture(context, rolling, 40, 3);
    1437:	c7 44 24 1c 03 00 00 	movl   $0x3,0x1c(%esp)
    143e:	00 
    143f:	c7 44 24 18 28 00 00 	movl   $0x28,0x18(%esp)
    1446:	00 
    1447:	8b 45 e0             	mov    -0x20(%ebp),%eax
    144a:	89 44 24 0c          	mov    %eax,0xc(%esp)
    144e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1451:	89 44 24 10          	mov    %eax,0x10(%esp)
    1455:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1458:	89 44 24 14          	mov    %eax,0x14(%esp)
    145c:	8b 45 08             	mov    0x8(%ebp),%eax
    145f:	89 04 24             	mov    %eax,(%esp)
    1462:	8b 45 0c             	mov    0xc(%ebp),%eax
    1465:	89 44 24 04          	mov    %eax,0x4(%esp)
    1469:	8b 45 10             	mov    0x10(%ebp),%eax
    146c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1470:	e8 6c 17 00 00       	call   2be1 <draw_picture>
    	freepic(&rolling);
    1475:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1478:	89 04 24             	mov    %eax,(%esp)
    147b:	e8 ee 24 00 00       	call   396e <freepic>

	PICNODE next;
        loadBitmap(&next, "next.bmp");
    1480:	c7 44 24 04 84 b3 00 	movl   $0xb384,0x4(%esp)
    1487:	00 
    1488:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    148b:	89 04 24             	mov    %eax,(%esp)
    148e:	e8 2f 1f 00 00       	call   33c2 <loadBitmap>
        compressAnyPic(&next,16,16);
    1493:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    149a:	00 
    149b:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
    14a2:	00 
    14a3:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    14a6:	89 04 24             	mov    %eax,(%esp)
    14a9:	e8 3f ef ff ff       	call   3ed <compressAnyPic>
        draw_picture(context, next, 60, 3);
    14ae:	c7 44 24 1c 03 00 00 	movl   $0x3,0x1c(%esp)
    14b5:	00 
    14b6:	c7 44 24 18 3c 00 00 	movl   $0x3c,0x18(%esp)
    14bd:	00 
    14be:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    14c1:	89 44 24 0c          	mov    %eax,0xc(%esp)
    14c5:	8b 45 d8             	mov    -0x28(%ebp),%eax
    14c8:	89 44 24 10          	mov    %eax,0x10(%esp)
    14cc:	8b 45 dc             	mov    -0x24(%ebp),%eax
    14cf:	89 44 24 14          	mov    %eax,0x14(%esp)
    14d3:	8b 45 08             	mov    0x8(%ebp),%eax
    14d6:	89 04 24             	mov    %eax,(%esp)
    14d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    14dc:	89 44 24 04          	mov    %eax,0x4(%esp)
    14e0:	8b 45 10             	mov    0x10(%ebp),%eax
    14e3:	89 44 24 08          	mov    %eax,0x8(%esp)
    14e7:	e8 f5 16 00 00       	call   2be1 <draw_picture>
        freepic(&next);
    14ec:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    14ef:	89 04 24             	mov    %eax,(%esp)
    14f2:	e8 77 24 00 00       	call   396e <freepic>
	
}
    14f7:	c9                   	leave  
    14f8:	c3                   	ret    

000014f9 <drawPicViewerContent>:

void drawPicViewerContent(Context context, char* fileName) {
    14f9:	55                   	push   %ebp
    14fa:	89 e5                	mov    %esp,%ebp
    14fc:	83 ec 38             	sub    $0x38,%esp
    int c_width, c_height;
    int pic_width, pic_height;

    c_width = context.width;
    14ff:	8b 45 0c             	mov    0xc(%ebp),%eax
    1502:	89 45 f4             	mov    %eax,-0xc(%ebp)
    c_height = context.height;
    1505:	8b 45 10             	mov    0x10(%ebp),%eax
    1508:	89 45 f0             	mov    %eax,-0x10(%ebp)
    pic_width = pic.width;
    150b:	a1 44 25 01 00       	mov    0x12544,%eax
    1510:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pic_height = pic.height;
    1513:	a1 48 25 01 00       	mov    0x12548,%eax
    1518:	89 45 e8             	mov    %eax,-0x18(%ebp)

    printf(0, "drawPicViewerContent: pic_width: %d, pic_height: %d\n", pic_width, pic_height);
    151b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    151e:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1522:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1525:	89 44 24 08          	mov    %eax,0x8(%esp)
    1529:	c7 44 24 04 98 b3 00 	movl   $0xb398,0x4(%esp)
    1530:	00 
    1531:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1538:	e8 0d 37 00 00       	call   4c4a <printf>
    draw_picture(context, pic, ((c_width-pic_width) >> 1) + X_shift, TOPBAR_HEIGHT + ((c_height-pic_height) >> 1) + Y_shift);
    153d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1540:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1543:	29 c2                	sub    %eax,%edx
    1545:	89 d0                	mov    %edx,%eax
    1547:	d1 f8                	sar    %eax
    1549:	8d 50 14             	lea    0x14(%eax),%edx
    154c:	a1 30 f7 00 00       	mov    0xf730,%eax
    1551:	01 c2                	add    %eax,%edx
    1553:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1556:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1559:	29 c1                	sub    %eax,%ecx
    155b:	89 c8                	mov    %ecx,%eax
    155d:	d1 f8                	sar    %eax
    155f:	89 c1                	mov    %eax,%ecx
    1561:	a1 2c f7 00 00       	mov    0xf72c,%eax
    1566:	01 c8                	add    %ecx,%eax
    1568:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    156c:	89 44 24 18          	mov    %eax,0x18(%esp)
    1570:	a1 40 25 01 00       	mov    0x12540,%eax
    1575:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1579:	a1 44 25 01 00       	mov    0x12544,%eax
    157e:	89 44 24 10          	mov    %eax,0x10(%esp)
    1582:	a1 48 25 01 00       	mov    0x12548,%eax
    1587:	89 44 24 14          	mov    %eax,0x14(%esp)
    158b:	8b 45 08             	mov    0x8(%ebp),%eax
    158e:	89 04 24             	mov    %eax,(%esp)
    1591:	8b 45 0c             	mov    0xc(%ebp),%eax
    1594:	89 44 24 04          	mov    %eax,0x4(%esp)
    1598:	8b 45 10             	mov    0x10(%ebp),%eax
    159b:	89 44 24 08          	mov    %eax,0x8(%esp)
    159f:	e8 3d 16 00 00       	call   2be1 <draw_picture>
    startXsave = ((c_width-pic_width) >> 1) + X_shift;
    15a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    15aa:	29 c2                	sub    %eax,%edx
    15ac:	89 d0                	mov    %edx,%eax
    15ae:	d1 f8                	sar    %eax
    15b0:	89 c2                	mov    %eax,%edx
    15b2:	a1 2c f7 00 00       	mov    0xf72c,%eax
    15b7:	01 d0                	add    %edx,%eax
    15b9:	a3 24 f7 00 00       	mov    %eax,0xf724
    startYsave = TOPBAR_HEIGHT + ((c_height-pic_height) >> 1) + Y_shift;
    15be:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15c1:	8b 55 f0             	mov    -0x10(%ebp),%edx
    15c4:	29 c2                	sub    %eax,%edx
    15c6:	89 d0                	mov    %edx,%eax
    15c8:	d1 f8                	sar    %eax
    15ca:	8d 50 14             	lea    0x14(%eax),%edx
    15cd:	a1 30 f7 00 00       	mov    0xf730,%eax
    15d2:	01 d0                	add    %edx,%eax
    15d4:	a3 28 f7 00 00       	mov    %eax,0xf728
}
    15d9:	c9                   	leave  
    15da:	c3                   	ret    

000015db <drawPicViewerContentForProper>:

void drawPicViewerContentForProper(Context context, char* fileName) {
    15db:	55                   	push   %ebp
    15dc:	89 e5                	mov    %esp,%ebp
    15de:	83 ec 28             	sub    $0x28,%esp
    
    draw_picture(context, pic, startXsave, startYsave);
    15e1:	8b 15 28 f7 00 00    	mov    0xf728,%edx
    15e7:	a1 24 f7 00 00       	mov    0xf724,%eax
    15ec:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    15f0:	89 44 24 18          	mov    %eax,0x18(%esp)
    15f4:	a1 40 25 01 00       	mov    0x12540,%eax
    15f9:	89 44 24 0c          	mov    %eax,0xc(%esp)
    15fd:	a1 44 25 01 00       	mov    0x12544,%eax
    1602:	89 44 24 10          	mov    %eax,0x10(%esp)
    1606:	a1 48 25 01 00       	mov    0x12548,%eax
    160b:	89 44 24 14          	mov    %eax,0x14(%esp)
    160f:	8b 45 08             	mov    0x8(%ebp),%eax
    1612:	89 04 24             	mov    %eax,(%esp)
    1615:	8b 45 0c             	mov    0xc(%ebp),%eax
    1618:	89 44 24 04          	mov    %eax,0x4(%esp)
    161c:	8b 45 10             	mov    0x10(%ebp),%eax
    161f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1623:	e8 b9 15 00 00       	call   2be1 <draw_picture>
}
    1628:	c9                   	leave  
    1629:	c3                   	ret    

0000162a <h_closeWnd>:

void h_closeWnd(Point p) {
    162a:	55                   	push   %ebp
    162b:	89 e5                	mov    %esp,%ebp
    isRun = 0;
    162d:	c7 05 18 f2 00 00 00 	movl   $0x0,0xf218
    1634:	00 00 00 
}
    1637:	5d                   	pop    %ebp
    1638:	c3                   	ret    

00001639 <addWndEvent>:

void addWndEvent(ClickableManager *cm) {
    1639:	55                   	push   %ebp
    163a:	89 e5                	mov    %esp,%ebp
    163c:	57                   	push   %edi
    163d:	56                   	push   %esi
    163e:	53                   	push   %ebx
    163f:	83 ec 4c             	sub    $0x4c,%esp
    int i;
	int n = sizeof(wndEvents) / sizeof(Handler);
    1642:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)

	for (i = 0; i < n; i++) {
    1649:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1650:	e9 96 00 00 00       	jmp    16eb <addWndEvent+0xb2>
		createClickable(cm,
    1655:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1658:	8b 1c 85 14 f2 00 00 	mov    0xf214(,%eax,4),%ebx
    165f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1662:	6b c0 34             	imul   $0x34,%eax,%eax
    1665:	05 00 f2 00 00       	add    $0xf200,%eax
    166a:	8b 78 10             	mov    0x10(%eax),%edi
    166d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1670:	6b c0 34             	imul   $0x34,%eax,%eax
    1673:	05 00 f2 00 00       	add    $0xf200,%eax
    1678:	8b 70 0c             	mov    0xc(%eax),%esi
    167b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    167e:	6b c0 34             	imul   $0x34,%eax,%eax
    1681:	05 00 f2 00 00       	add    $0xf200,%eax
    1686:	8b 48 04             	mov    0x4(%eax),%ecx
    1689:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    168c:	6b c0 34             	imul   $0x34,%eax,%eax
    168f:	05 00 f2 00 00       	add    $0xf200,%eax
    1694:	8b 10                	mov    (%eax),%edx
    1696:	8d 45 d0             	lea    -0x30(%ebp),%eax
    1699:	89 7c 24 10          	mov    %edi,0x10(%esp)
    169d:	89 74 24 0c          	mov    %esi,0xc(%esp)
    16a1:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    16a5:	89 54 24 04          	mov    %edx,0x4(%esp)
    16a9:	89 04 24             	mov    %eax,(%esp)
    16ac:	e8 8c 25 00 00       	call   3c3d <initRect>
    16b1:	83 ec 04             	sub    $0x4,%esp
    16b4:	89 5c 24 18          	mov    %ebx,0x18(%esp)
    16b8:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    16bf:	00 
    16c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    16c3:	89 44 24 04          	mov    %eax,0x4(%esp)
    16c7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    16ca:	89 44 24 08          	mov    %eax,0x8(%esp)
    16ce:	8b 45 d8             	mov    -0x28(%ebp),%eax
    16d1:	89 44 24 0c          	mov    %eax,0xc(%esp)
    16d5:	8b 45 dc             	mov    -0x24(%ebp),%eax
    16d8:	89 44 24 10          	mov    %eax,0x10(%esp)
    16dc:	8b 45 08             	mov    0x8(%ebp),%eax
    16df:	89 04 24             	mov    %eax,(%esp)
    16e2:	e8 42 26 00 00       	call   3d29 <createClickable>

void addWndEvent(ClickableManager *cm) {
    int i;
	int n = sizeof(wndEvents) / sizeof(Handler);

	for (i = 0; i < n; i++) {
    16e7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    16eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16ee:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    16f1:	0f 8c 5e ff ff ff    	jl     1655 <addWndEvent+0x1c>
		createClickable(cm,
				initRect(wndRes[i].position_x, wndRes[i].position_y,
						wndRes[i].pic.width, wndRes[i].pic.height), MSG_LPRESS,
				wndEvents[i]);
	}
}
    16f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    16fa:	5b                   	pop    %ebx
    16fb:	5e                   	pop    %esi
    16fc:	5f                   	pop    %edi
    16fd:	5d                   	pop    %ebp
    16fe:	c3                   	ret    

000016ff <propertyShow>:


void propertyShow(Context context, int startX, int startY)
{
    16ff:	55                   	push   %ebp
    1700:	89 e5                	mov    %esp,%ebp
    1702:	53                   	push   %ebx
    1703:	83 ec 64             	sub    $0x64,%esp
	printf(0, "Right Clicked: p.x:%d, p.y:%d\n",startX,startY);
    1706:	8b 45 18             	mov    0x18(%ebp),%eax
    1709:	89 44 24 0c          	mov    %eax,0xc(%esp)
    170d:	8b 45 14             	mov    0x14(%ebp),%eax
    1710:	89 44 24 08          	mov    %eax,0x8(%esp)
    1714:	c7 44 24 04 d0 b3 00 	movl   $0xb3d0,0x4(%esp)
    171b:	00 
    171c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1723:	e8 22 35 00 00       	call   4c4a <printf>
	printf(0, "Right Clicked: pic.width:%d, pic.height:%d\n",pic.width,pic.height);
    1728:	8b 15 48 25 01 00    	mov    0x12548,%edx
    172e:	a1 44 25 01 00       	mov    0x12544,%eax
    1733:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1737:	89 44 24 08          	mov    %eax,0x8(%esp)
    173b:	c7 44 24 04 f0 b3 00 	movl   $0xb3f0,0x4(%esp)
    1742:	00 
    1743:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    174a:	e8 fb 34 00 00       	call   4c4a <printf>
	//int lengthX = 100;
	//int lengthY = 200;
	int width = pic.width;
    174f:	a1 44 25 01 00       	mov    0x12544,%eax
    1754:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int height = pic.height;
    1757:	a1 48 25 01 00       	mov    0x12548,%eax
    175c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	
	char*strw = (char*)malloc(10*sizeof(char));
    175f:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    1766:	e8 cb 37 00 00       	call   4f36 <malloc>
    176b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	char*strh = (char*)malloc(10*sizeof(char));
    176e:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    1775:	e8 bc 37 00 00       	call   4f36 <malloc>
    177a:	89 45 d0             	mov    %eax,-0x30(%ebp)
	int i = 0;
    177d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int lengthwt; 
	while(width>0)
    1784:	eb 52                	jmp    17d8 <propertyShow+0xd9>
	{
		strw[i] = width%10 + '0';
    1786:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1789:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    178c:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    178f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1792:	ba 67 66 66 66       	mov    $0x66666667,%edx
    1797:	89 c8                	mov    %ecx,%eax
    1799:	f7 ea                	imul   %edx
    179b:	c1 fa 02             	sar    $0x2,%edx
    179e:	89 c8                	mov    %ecx,%eax
    17a0:	c1 f8 1f             	sar    $0x1f,%eax
    17a3:	29 c2                	sub    %eax,%edx
    17a5:	89 d0                	mov    %edx,%eax
    17a7:	c1 e0 02             	shl    $0x2,%eax
    17aa:	01 d0                	add    %edx,%eax
    17ac:	01 c0                	add    %eax,%eax
    17ae:	29 c1                	sub    %eax,%ecx
    17b0:	89 ca                	mov    %ecx,%edx
    17b2:	89 d0                	mov    %edx,%eax
    17b4:	83 c0 30             	add    $0x30,%eax
    17b7:	88 03                	mov    %al,(%ebx)
		width/=10;
    17b9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    17bc:	ba 67 66 66 66       	mov    $0x66666667,%edx
    17c1:	89 c8                	mov    %ecx,%eax
    17c3:	f7 ea                	imul   %edx
    17c5:	c1 fa 02             	sar    $0x2,%edx
    17c8:	89 c8                	mov    %ecx,%eax
    17ca:	c1 f8 1f             	sar    $0x1f,%eax
    17cd:	29 c2                	sub    %eax,%edx
    17cf:	89 d0                	mov    %edx,%eax
    17d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
		i++;	
    17d4:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
	
	char*strw = (char*)malloc(10*sizeof(char));
	char*strh = (char*)malloc(10*sizeof(char));
	int i = 0;
	int lengthwt; 
	while(width>0)
    17d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17dc:	7f a8                	jg     1786 <propertyShow+0x87>
		strw[i] = width%10 + '0';
		width/=10;
		i++;	
	}
	
	lengthwt = i;
    17de:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17e1:	89 45 cc             	mov    %eax,-0x34(%ebp)
	for(;i<=10;i++)
    17e4:	eb 0f                	jmp    17f5 <propertyShow+0xf6>
	{
		strw[i] = '\0';
    17e6:	8b 55 ec             	mov    -0x14(%ebp),%edx
    17e9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    17ec:	01 d0                	add    %edx,%eax
    17ee:	c6 00 00             	movb   $0x0,(%eax)
		width/=10;
		i++;	
	}
	
	lengthwt = i;
	for(;i<=10;i++)
    17f1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    17f5:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
    17f9:	7e eb                	jle    17e6 <propertyShow+0xe7>
	{
		strw[i] = '\0';
	}
	char* strwt = (char*)malloc((lengthwt+1)*sizeof(char));
    17fb:	8b 45 cc             	mov    -0x34(%ebp),%eax
    17fe:	83 c0 01             	add    $0x1,%eax
    1801:	89 04 24             	mov    %eax,(%esp)
    1804:	e8 2d 37 00 00       	call   4f36 <malloc>
    1809:	89 45 c8             	mov    %eax,-0x38(%ebp)
	//printf(0,"%d",lengthwt);
	int k0 = 0;
    180c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	int k = lengthwt - 1;
    1813:	8b 45 cc             	mov    -0x34(%ebp),%eax
    1816:	83 e8 01             	sub    $0x1,%eax
    1819:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	for(;k >= 0;k--)
    181c:	eb 30                	jmp    184e <propertyShow+0x14f>
	{
		if(strw[k0] != '\0')strwt[k] = strw[k0];
    181e:	8b 55 e8             	mov    -0x18(%ebp),%edx
    1821:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1824:	01 d0                	add    %edx,%eax
    1826:	0f b6 00             	movzbl (%eax),%eax
    1829:	84 c0                	test   %al,%al
    182b:	74 1f                	je     184c <propertyShow+0x14d>
    182d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1830:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1833:	01 c2                	add    %eax,%edx
    1835:	8b 4d e8             	mov    -0x18(%ebp),%ecx
    1838:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    183b:	01 c8                	add    %ecx,%eax
    183d:	0f b6 00             	movzbl (%eax),%eax
    1840:	88 02                	mov    %al,(%edx)
		else break;
		k0++;
    1842:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
	}
	char* strwt = (char*)malloc((lengthwt+1)*sizeof(char));
	//printf(0,"%d",lengthwt);
	int k0 = 0;
	int k = lengthwt - 1;
	for(;k >= 0;k--)
    1846:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
    184a:	eb 02                	jmp    184e <propertyShow+0x14f>
	{
		if(strw[k0] != '\0')strwt[k] = strw[k0];
		else break;
    184c:	eb 06                	jmp    1854 <propertyShow+0x155>
	}
	char* strwt = (char*)malloc((lengthwt+1)*sizeof(char));
	//printf(0,"%d",lengthwt);
	int k0 = 0;
	int k = lengthwt - 1;
	for(;k >= 0;k--)
    184e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1852:	79 ca                	jns    181e <propertyShow+0x11f>
		if(strw[k0] != '\0')strwt[k] = strw[k0];
		else break;
		k0++;
		
	}
	strwt[lengthwt] = '\0';
    1854:	8b 55 cc             	mov    -0x34(%ebp),%edx
    1857:	8b 45 c8             	mov    -0x38(%ebp),%eax
    185a:	01 d0                	add    %edx,%eax
    185c:	c6 00 00             	movb   $0x0,(%eax)
	free(strw);
    185f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1862:	89 04 24             	mov    %eax,(%esp)
    1865:	e8 93 35 00 00       	call   4dfd <free>
	
	printf(0,"In itoa w:");
    186a:	c7 44 24 04 1c b4 00 	movl   $0xb41c,0x4(%esp)
    1871:	00 
    1872:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1879:	e8 cc 33 00 00       	call   4c4a <printf>
	printf(0,strwt);
    187e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1881:	89 44 24 04          	mov    %eax,0x4(%esp)
    1885:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    188c:	e8 b9 33 00 00       	call   4c4a <printf>
	printf(0,"\n");
    1891:	c7 44 24 04 27 b4 00 	movl   $0xb427,0x4(%esp)
    1898:	00 
    1899:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    18a0:	e8 a5 33 00 00       	call   4c4a <printf>

	int j = 0;
    18a5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	int lengthht; 
	while(height>0)
    18ac:	eb 52                	jmp    1900 <propertyShow+0x201>
	{
		strh[j] = height%10 + '0';
    18ae:	8b 55 e0             	mov    -0x20(%ebp),%edx
    18b1:	8b 45 d0             	mov    -0x30(%ebp),%eax
    18b4:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    18b7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    18ba:	ba 67 66 66 66       	mov    $0x66666667,%edx
    18bf:	89 c8                	mov    %ecx,%eax
    18c1:	f7 ea                	imul   %edx
    18c3:	c1 fa 02             	sar    $0x2,%edx
    18c6:	89 c8                	mov    %ecx,%eax
    18c8:	c1 f8 1f             	sar    $0x1f,%eax
    18cb:	29 c2                	sub    %eax,%edx
    18cd:	89 d0                	mov    %edx,%eax
    18cf:	c1 e0 02             	shl    $0x2,%eax
    18d2:	01 d0                	add    %edx,%eax
    18d4:	01 c0                	add    %eax,%eax
    18d6:	29 c1                	sub    %eax,%ecx
    18d8:	89 ca                	mov    %ecx,%edx
    18da:	89 d0                	mov    %edx,%eax
    18dc:	83 c0 30             	add    $0x30,%eax
    18df:	88 03                	mov    %al,(%ebx)
		height/=10;
    18e1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    18e4:	ba 67 66 66 66       	mov    $0x66666667,%edx
    18e9:	89 c8                	mov    %ecx,%eax
    18eb:	f7 ea                	imul   %edx
    18ed:	c1 fa 02             	sar    $0x2,%edx
    18f0:	89 c8                	mov    %ecx,%eax
    18f2:	c1 f8 1f             	sar    $0x1f,%eax
    18f5:	29 c2                	sub    %eax,%edx
    18f7:	89 d0                	mov    %edx,%eax
    18f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		j++;	
    18fc:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
	printf(0,strwt);
	printf(0,"\n");

	int j = 0;
	int lengthht; 
	while(height>0)
    1900:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1904:	7f a8                	jg     18ae <propertyShow+0x1af>
		strh[j] = height%10 + '0';
		height/=10;
		j++;	
	}
	
	lengthht = j;
    1906:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1909:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	for(;j<=10;j++)
    190c:	eb 0f                	jmp    191d <propertyShow+0x21e>
	{
		strh[j] = '\0';
    190e:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1911:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1914:	01 d0                	add    %edx,%eax
    1916:	c6 00 00             	movb   $0x0,(%eax)
		height/=10;
		j++;	
	}
	
	lengthht = j;
	for(;j<=10;j++)
    1919:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    191d:	83 7d e0 0a          	cmpl   $0xa,-0x20(%ebp)
    1921:	7e eb                	jle    190e <propertyShow+0x20f>
	{
		strh[j] = '\0';
	}
	char* strht = (char*)malloc((lengthht+1)*sizeof(char));
    1923:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1926:	83 c0 01             	add    $0x1,%eax
    1929:	89 04 24             	mov    %eax,(%esp)
    192c:	e8 05 36 00 00       	call   4f36 <malloc>
    1931:	89 45 c0             	mov    %eax,-0x40(%ebp)
	//printf(0,"%d",lengthht);
	int t0 = 0;
    1934:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	int t = lengthht - 1;
    193b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    193e:	83 e8 01             	sub    $0x1,%eax
    1941:	89 45 d8             	mov    %eax,-0x28(%ebp)
	for(;t >= 0;t--)
    1944:	eb 30                	jmp    1976 <propertyShow+0x277>
	{
		if(strh[t0] != '\0')strht[t] = strh[t0];
    1946:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1949:	8b 45 d0             	mov    -0x30(%ebp),%eax
    194c:	01 d0                	add    %edx,%eax
    194e:	0f b6 00             	movzbl (%eax),%eax
    1951:	84 c0                	test   %al,%al
    1953:	74 1f                	je     1974 <propertyShow+0x275>
    1955:	8b 55 d8             	mov    -0x28(%ebp),%edx
    1958:	8b 45 c0             	mov    -0x40(%ebp),%eax
    195b:	01 c2                	add    %eax,%edx
    195d:	8b 4d dc             	mov    -0x24(%ebp),%ecx
    1960:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1963:	01 c8                	add    %ecx,%eax
    1965:	0f b6 00             	movzbl (%eax),%eax
    1968:	88 02                	mov    %al,(%edx)
		else break;
		t0++;
    196a:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
	}
	char* strht = (char*)malloc((lengthht+1)*sizeof(char));
	//printf(0,"%d",lengthht);
	int t0 = 0;
	int t = lengthht - 1;
	for(;t >= 0;t--)
    196e:	83 6d d8 01          	subl   $0x1,-0x28(%ebp)
    1972:	eb 02                	jmp    1976 <propertyShow+0x277>
	{
		if(strh[t0] != '\0')strht[t] = strh[t0];
		else break;
    1974:	eb 06                	jmp    197c <propertyShow+0x27d>
	}
	char* strht = (char*)malloc((lengthht+1)*sizeof(char));
	//printf(0,"%d",lengthht);
	int t0 = 0;
	int t = lengthht - 1;
	for(;t >= 0;t--)
    1976:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    197a:	79 ca                	jns    1946 <propertyShow+0x247>
		if(strh[t0] != '\0')strht[t] = strh[t0];
		else break;
		t0++;
		
	}
	strht[lengthht] = '\0';
    197c:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    197f:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1982:	01 d0                	add    %edx,%eax
    1984:	c6 00 00             	movb   $0x0,(%eax)
	free(strh);
    1987:	8b 45 d0             	mov    -0x30(%ebp),%eax
    198a:	89 04 24             	mov    %eax,(%esp)
    198d:	e8 6b 34 00 00       	call   4dfd <free>
	
	printf(0,"In itoa h:");
    1992:	c7 44 24 04 29 b4 00 	movl   $0xb429,0x4(%esp)
    1999:	00 
    199a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19a1:	e8 a4 32 00 00       	call   4c4a <printf>
	printf(0,strht);
    19a6:	8b 45 c0             	mov    -0x40(%ebp),%eax
    19a9:	89 44 24 04          	mov    %eax,0x4(%esp)
    19ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19b4:	e8 91 32 00 00       	call   4c4a <printf>
	printf(0,"\n");
    19b9:	c7 44 24 04 27 b4 00 	movl   $0xb427,0x4(%esp)
    19c0:	00 
    19c1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19c8:	e8 7d 32 00 00       	call   4c4a <printf>

	
	puts_str(context, "Width:", 0, startX+10, startY+10);
    19cd:	8b 45 18             	mov    0x18(%ebp),%eax
    19d0:	8d 50 0a             	lea    0xa(%eax),%edx
    19d3:	8b 45 14             	mov    0x14(%ebp),%eax
    19d6:	83 c0 0a             	add    $0xa,%eax
    19d9:	89 54 24 18          	mov    %edx,0x18(%esp)
    19dd:	89 44 24 14          	mov    %eax,0x14(%esp)
    19e1:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    19e8:	00 
    19e9:	c7 44 24 0c 34 b4 00 	movl   $0xb434,0xc(%esp)
    19f0:	00 
    19f1:	8b 45 08             	mov    0x8(%ebp),%eax
    19f4:	89 04 24             	mov    %eax,(%esp)
    19f7:	8b 45 0c             	mov    0xc(%ebp),%eax
    19fa:	89 44 24 04          	mov    %eax,0x4(%esp)
    19fe:	8b 45 10             	mov    0x10(%ebp),%eax
    1a01:	89 44 24 08          	mov    %eax,0x8(%esp)
    1a05:	e8 c8 10 00 00       	call   2ad2 <puts_str>
	puts_str(context, strwt, 0, startX+70, startY+10);
    1a0a:	8b 45 18             	mov    0x18(%ebp),%eax
    1a0d:	8d 50 0a             	lea    0xa(%eax),%edx
    1a10:	8b 45 14             	mov    0x14(%ebp),%eax
    1a13:	83 c0 46             	add    $0x46,%eax
    1a16:	89 54 24 18          	mov    %edx,0x18(%esp)
    1a1a:	89 44 24 14          	mov    %eax,0x14(%esp)
    1a1e:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    1a25:	00 
    1a26:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1a29:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1a2d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a30:	89 04 24             	mov    %eax,(%esp)
    1a33:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a36:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a3a:	8b 45 10             	mov    0x10(%ebp),%eax
    1a3d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1a41:	e8 8c 10 00 00       	call   2ad2 <puts_str>
	puts_str(context, "Height:", 0, startX+10, startY+30);
    1a46:	8b 45 18             	mov    0x18(%ebp),%eax
    1a49:	8d 50 1e             	lea    0x1e(%eax),%edx
    1a4c:	8b 45 14             	mov    0x14(%ebp),%eax
    1a4f:	83 c0 0a             	add    $0xa,%eax
    1a52:	89 54 24 18          	mov    %edx,0x18(%esp)
    1a56:	89 44 24 14          	mov    %eax,0x14(%esp)
    1a5a:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    1a61:	00 
    1a62:	c7 44 24 0c 3b b4 00 	movl   $0xb43b,0xc(%esp)
    1a69:	00 
    1a6a:	8b 45 08             	mov    0x8(%ebp),%eax
    1a6d:	89 04 24             	mov    %eax,(%esp)
    1a70:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a73:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a77:	8b 45 10             	mov    0x10(%ebp),%eax
    1a7a:	89 44 24 08          	mov    %eax,0x8(%esp)
    1a7e:	e8 4f 10 00 00       	call   2ad2 <puts_str>
	puts_str(context, strht, 0, startX+70, startY+30);
    1a83:	8b 45 18             	mov    0x18(%ebp),%eax
    1a86:	8d 50 1e             	lea    0x1e(%eax),%edx
    1a89:	8b 45 14             	mov    0x14(%ebp),%eax
    1a8c:	83 c0 46             	add    $0x46,%eax
    1a8f:	89 54 24 18          	mov    %edx,0x18(%esp)
    1a93:	89 44 24 14          	mov    %eax,0x14(%esp)
    1a97:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    1a9e:	00 
    1a9f:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1aa2:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1aa6:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa9:	89 04 24             	mov    %eax,(%esp)
    1aac:	8b 45 0c             	mov    0xc(%ebp),%eax
    1aaf:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ab3:	8b 45 10             	mov    0x10(%ebp),%eax
    1ab6:	89 44 24 08          	mov    %eax,0x8(%esp)
    1aba:	e8 13 10 00 00       	call   2ad2 <puts_str>
	
	//lengthX = 0;
	//lengthY = 0;
	updateWindowWithoutBlank(context);
    1abf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac2:	89 04 24             	mov    %eax,(%esp)
    1ac5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ac8:	89 44 24 04          	mov    %eax,0x4(%esp)
    1acc:	8b 45 10             	mov    0x10(%ebp),%eax
    1acf:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ad3:	e8 3f f7 ff ff       	call   1217 <updateWindowWithoutBlank>

}
    1ad8:	83 c4 64             	add    $0x64,%esp
    1adb:	5b                   	pop    %ebx
    1adc:	5d                   	pop    %ebp
    1add:	c3                   	ret    

00001ade <main>:



int main(int argc, char *argv[]) {
    1ade:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1ae2:	83 e4 f0             	and    $0xfffffff0,%esp
    1ae5:	ff 71 fc             	pushl  -0x4(%ecx)
    1ae8:	55                   	push   %ebp
    1ae9:	89 e5                	mov    %esp,%ebp
    1aeb:	56                   	push   %esi
    1aec:	53                   	push   %ebx
    1aed:	51                   	push   %ecx
    1aee:	81 ec dc 00 00 00    	sub    $0xdc,%esp
    1af4:	89 cb                	mov    %ecx,%ebx
    struct Context context;
    ClickableManager cm;//（这个东西是干吗用的？）
    int winid;
    struct Msg msg;
    Point p;
    len = atoi(argv[2]);
    1af6:	8b 43 04             	mov    0x4(%ebx),%eax
    1af9:	83 c0 08             	add    $0x8,%eax
    1afc:	8b 00                	mov    (%eax),%eax
    1afe:	89 04 24             	mov    %eax,(%esp)
    1b01:	e8 c2 2e 00 00       	call   49c8 <atoi>
    1b06:	a3 f0 26 01 00       	mov    %eax,0x126f0
    pos = atoi(argv[3]) - 1;
    1b0b:	8b 43 04             	mov    0x4(%ebx),%eax
    1b0e:	83 c0 0c             	add    $0xc,%eax
    1b11:	8b 00                	mov    (%eax),%eax
    1b13:	89 04 24             	mov    %eax,(%esp)
    1b16:	e8 ad 2e 00 00       	call   49c8 <atoi>
    1b1b:	83 e8 01             	sub    $0x1,%eax
    1b1e:	a3 4c 25 01 00       	mov    %eax,0x1254c
printf(0,"%d",pos);
    1b23:	a1 4c 25 01 00       	mov    0x1254c,%eax
    1b28:	89 44 24 08          	mov    %eax,0x8(%esp)
    1b2c:	c7 44 24 04 43 b4 00 	movl   $0xb443,0x4(%esp)
    1b33:	00 
    1b34:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b3b:	e8 0a 31 00 00       	call   4c4a <printf>
printf(0,"   %d   ",len);
    1b40:	a1 f0 26 01 00       	mov    0x126f0,%eax
    1b45:	89 44 24 08          	mov    %eax,0x8(%esp)
    1b49:	c7 44 24 04 46 b4 00 	movl   $0xb446,0x4(%esp)
    1b50:	00 
    1b51:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b58:	e8 ed 30 00 00       	call   4c4a <printf>
    int i = 0;
    1b5d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    int j = 0;
    1b64:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    int k = 0;
    1b6b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    int end = -1;
    1b72:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%ebp)
    while(i <= len + 3){
    1b79:	e9 9c 00 00 00       	jmp    1c1a <main+0x13c>
	if (argv[2][i]=='\1'){
    1b7e:	8b 43 04             	mov    0x4(%ebx),%eax
    1b81:	83 c0 08             	add    $0x8,%eax
    1b84:	8b 10                	mov    (%eax),%edx
    1b86:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b89:	01 d0                	add    %edx,%eax
    1b8b:	0f b6 00             	movzbl (%eax),%eax
    1b8e:	3c 01                	cmp    $0x1,%al
    1b90:	0f 85 80 00 00 00    	jne    1c16 <main+0x138>
	    file[j] = (char*)malloc((i-end)*sizeof(char));
    1b96:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1b99:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1b9c:	29 c2                	sub    %eax,%edx
    1b9e:	89 d0                	mov    %edx,%eax
    1ba0:	89 04 24             	mov    %eax,(%esp)
    1ba3:	e8 8e 33 00 00       	call   4f36 <malloc>
    1ba8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1bab:	89 04 95 60 25 01 00 	mov    %eax,0x12560(,%edx,4)
	    for(k = 0;k < (i-end);k++)
    1bb2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    1bb9:	eb 2d                	jmp    1be8 <main+0x10a>
		file[j][k] = argv[2][end+1+k];
    1bbb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bbe:	8b 14 85 60 25 01 00 	mov    0x12560(,%eax,4),%edx
    1bc5:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1bc8:	01 c2                	add    %eax,%edx
    1bca:	8b 43 04             	mov    0x4(%ebx),%eax
    1bcd:	83 c0 08             	add    $0x8,%eax
    1bd0:	8b 08                	mov    (%eax),%ecx
    1bd2:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1bd5:	8d 70 01             	lea    0x1(%eax),%esi
    1bd8:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1bdb:	01 f0                	add    %esi,%eax
    1bdd:	01 c8                	add    %ecx,%eax
    1bdf:	0f b6 00             	movzbl (%eax),%eax
    1be2:	88 02                	mov    %al,(%edx)
    int k = 0;
    int end = -1;
    while(i <= len + 3){
	if (argv[2][i]=='\1'){
	    file[j] = (char*)malloc((i-end)*sizeof(char));
	    for(k = 0;k < (i-end);k++)
    1be4:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    1be8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1beb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1bee:	29 c2                	sub    %eax,%edx
    1bf0:	89 d0                	mov    %edx,%eax
    1bf2:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    1bf5:	7f c4                	jg     1bbb <main+0xdd>
		file[j][k] = argv[2][end+1+k];
	    file[j][k-1] = '\0';
    1bf7:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bfa:	8b 04 85 60 25 01 00 	mov    0x12560(,%eax,4),%eax
    1c01:	8b 55 dc             	mov    -0x24(%ebp),%edx
    1c04:	83 ea 01             	sub    $0x1,%edx
    1c07:	01 d0                	add    %edx,%eax
    1c09:	c6 00 00             	movb   $0x0,(%eax)
	    end = i;
    1c0c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1c0f:	89 45 d8             	mov    %eax,-0x28(%ebp)
	    j++;
    1c12:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
	    
	}
	i++;
    1c16:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
printf(0,"   %d   ",len);
    int i = 0;
    int j = 0;
    int k = 0;
    int end = -1;
    while(i <= len + 3){
    1c1a:	a1 f0 26 01 00       	mov    0x126f0,%eax
    1c1f:	83 c0 03             	add    $0x3,%eax
    1c22:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1c25:	0f 8d 53 ff ff ff    	jge    1b7e <main+0xa0>
	    
	}
	i++;
    }

	len = j;
    1c2b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c2e:	a3 f0 26 01 00       	mov    %eax,0x126f0
	
	



    winid = init_context(&context, WINDOW_WIDTH, WINDOW_HEIGHT);//根据窗口大小初始化背景
    1c33:	c7 44 24 08 36 01 00 	movl   $0x136,0x8(%esp)
    1c3a:	00 
    1c3b:	c7 44 24 04 f4 01 00 	movl   $0x1f4,0x4(%esp)
    1c42:	00 
    1c43:	8d 45 98             	lea    -0x68(%ebp),%eax
    1c46:	89 04 24             	mov    %eax,(%esp)
    1c49:	e8 7f 06 00 00       	call   22cd <init_context>
    1c4e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    cm = initClickManager(context);//根据背景初始化ClickableManager
    1c51:	8d 85 38 ff ff ff    	lea    -0xc8(%ebp),%eax
    1c57:	8b 55 98             	mov    -0x68(%ebp),%edx
    1c5a:	89 54 24 04          	mov    %edx,0x4(%esp)
    1c5e:	8b 55 9c             	mov    -0x64(%ebp),%edx
    1c61:	89 54 24 08          	mov    %edx,0x8(%esp)
    1c65:	8b 55 a0             	mov    -0x60(%ebp),%edx
    1c68:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1c6c:	89 04 24             	mov    %eax,(%esp)
    1c6f:	e8 67 20 00 00       	call   3cdb <initClickManager>
    1c74:	83 ec 04             	sub    $0x4,%esp
    1c77:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
    1c7d:	89 45 84             	mov    %eax,-0x7c(%ebp)
    1c80:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
    1c86:	89 45 88             	mov    %eax,-0x78(%ebp)
    1c89:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
    1c8f:	89 45 8c             	mov    %eax,-0x74(%ebp)
    1c92:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
    1c98:	89 45 90             	mov    %eax,-0x70(%ebp)
    1c9b:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
    1ca1:	89 45 94             	mov    %eax,-0x6c(%ebp)

    loadBitmap(&pic, file[pos]);//载入bmp
    1ca4:	a1 4c 25 01 00       	mov    0x1254c,%eax
    1ca9:	8b 04 85 60 25 01 00 	mov    0x12560(,%eax,4),%eax
    1cb0:	89 44 24 04          	mov    %eax,0x4(%esp)
    1cb4:	c7 04 24 40 25 01 00 	movl   $0x12540,(%esp)
    1cbb:	e8 02 17 00 00       	call   33c2 <loadBitmap>
    load_iconlist(wndRes, sizeof(wndRes) / sizeof(ICON));//载入图标数组
    1cc0:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1cc7:	00 
    1cc8:	c7 04 24 e0 f1 00 00 	movl   $0xf1e0,(%esp)
    1ccf:	e8 2d 16 00 00       	call   3301 <load_iconlist>

    modifyPic(context);//按照背景修改图片
    1cd4:	8b 45 98             	mov    -0x68(%ebp),%eax
    1cd7:	89 04 24             	mov    %eax,(%esp)
    1cda:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1cdd:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ce1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ce4:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ce8:	e8 be ea ff ff       	call   7ab <modifyPic>
    deleteClickable(&cm.left_click, initRect(0, 0, 800, 600));
    1ced:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1cf0:	c7 44 24 10 58 02 00 	movl   $0x258,0x10(%esp)
    1cf7:	00 
    1cf8:	c7 44 24 0c 20 03 00 	movl   $0x320,0xc(%esp)
    1cff:	00 
    1d00:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    1d07:	00 
    1d08:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1d0f:	00 
    1d10:	89 04 24             	mov    %eax,(%esp)
    1d13:	e8 25 1f 00 00       	call   3c3d <initRect>
    1d18:	83 ec 04             	sub    $0x4,%esp
    1d1b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    1d1e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d22:	8b 45 a8             	mov    -0x58(%ebp),%eax
    1d25:	89 44 24 08          	mov    %eax,0x8(%esp)
    1d29:	8b 45 ac             	mov    -0x54(%ebp),%eax
    1d2c:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1d30:	8b 45 b0             	mov    -0x50(%ebp),%eax
    1d33:	89 44 24 10          	mov    %eax,0x10(%esp)
    1d37:	8d 45 84             	lea    -0x7c(%ebp),%eax
    1d3a:	89 04 24             	mov    %eax,(%esp)
    1d3d:	e8 25 21 00 00       	call   3e67 <deleteClickable>
    addWndEvent(&cm);//添加cm到窗口事件
    1d42:	8d 45 84             	lea    -0x7c(%ebp),%eax
    1d45:	89 04 24             	mov    %eax,(%esp)
    1d48:	e8 ec f8 ff ff       	call   1639 <addWndEvent>

    Initialize(context);
    1d4d:	8b 45 98             	mov    -0x68(%ebp),%eax
    1d50:	89 04 24             	mov    %eax,(%esp)
    1d53:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1d56:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d5a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1d5d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1d61:	e8 9a e2 ff ff       	call   0 <Initialize>

    while (isRun) {
    1d66:	e9 3e 05 00 00       	jmp    22a9 <main+0x7cb>
        getMsg(&msg);//获取消息
    1d6b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
    1d71:	89 04 24             	mov    %eax,(%esp)
    1d74:	e8 81 2d 00 00       	call   4afa <getMsg>
        switch (msg.msg_type) {//判断消息类型
    1d79:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
    1d7f:	83 f8 08             	cmp    $0x8,%eax
    1d82:	0f 87 20 05 00 00    	ja     22a8 <main+0x7ca>
    1d88:	8b 04 85 ac b4 00 00 	mov    0xb4ac(,%eax,4),%eax
    1d8f:	ff e0                	jmp    *%eax
		case MSG_DOUBLECLICK://双击消息
			p = initPoint(msg.concrete_msg.msg_mouse.x,msg.concrete_msg.msg_mouse.y);//获取到鼠标现在的点
    1d91:	8b 8d 74 ff ff ff    	mov    -0x8c(%ebp),%ecx
    1d97:	8b 95 70 ff ff ff    	mov    -0x90(%ebp),%edx
    1d9d:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
    1da3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1da7:	89 54 24 04          	mov    %edx,0x4(%esp)
    1dab:	89 04 24             	mov    %eax,(%esp)
    1dae:	e8 63 1e 00 00       	call   3c16 <initPoint>
    1db3:	83 ec 04             	sub    $0x4,%esp
			if (executeHandler(cm.double_click, p))//（暂时不懂）
    1db6:	8b 4d 88             	mov    -0x78(%ebp),%ecx
    1db9:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    1dbf:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
    1dc5:	89 44 24 04          	mov    %eax,0x4(%esp)
    1dc9:	89 54 24 08          	mov    %edx,0x8(%esp)
    1dcd:	89 0c 24             	mov    %ecx,(%esp)
    1dd0:	e8 72 21 00 00       	call   3f47 <executeHandler>
    1dd5:	85 c0                	test   %eax,%eax
    1dd7:	74 1c                	je     1df5 <main+0x317>
            		{
				updateWindow(winid, context.addr, msg.msg_detail);//更新窗口
    1dd9:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
    1ddf:	8b 45 98             	mov    -0x68(%ebp),%eax
    1de2:	89 54 24 08          	mov    %edx,0x8(%esp)
    1de6:	89 44 24 04          	mov    %eax,0x4(%esp)
    1dea:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1ded:	89 04 24             	mov    %eax,(%esp)
    1df0:	e8 1d 2d 00 00       	call   4b12 <updateWindow>
			}
            		printf(0,"DoubleClick: context_width: %d, context_height: %d\n", context.width, context.height);
    1df5:	8b 55 a0             	mov    -0x60(%ebp),%edx
    1df8:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1dfb:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1dff:	89 44 24 08          	mov    %eax,0x8(%esp)
    1e03:	c7 44 24 04 50 b4 00 	movl   $0xb450,0x4(%esp)
    1e0a:	00 
    1e0b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1e12:	e8 33 2e 00 00       	call   4c4a <printf>
			printf(0,"DoubleClick: mouseX: %d, mouseY: %d\n", p.x, p.y);
    1e17:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
    1e1d:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    1e23:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1e27:	89 44 24 08          	mov    %eax,0x8(%esp)
    1e2b:	c7 44 24 04 84 b4 00 	movl   $0xb484,0x4(%esp)
    1e32:	00 
    1e33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1e3a:	e8 0b 2e 00 00       	call   4c4a <printf>
            		zoomingPic(context,p.x,p.y);
    1e3f:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
    1e45:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    1e4b:	89 54 24 10          	mov    %edx,0x10(%esp)
    1e4f:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1e53:	8b 45 98             	mov    -0x68(%ebp),%eax
    1e56:	89 04 24             	mov    %eax,(%esp)
    1e59:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1e5c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e60:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1e63:	89 44 24 08          	mov    %eax,0x8(%esp)
    1e67:	e8 80 ed ff ff       	call   bec <zoomingPic>
            		updateWindow(winid, context.addr, msg.msg_detail);
    1e6c:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
    1e72:	8b 45 98             	mov    -0x68(%ebp),%eax
    1e75:	89 54 24 08          	mov    %edx,0x8(%esp)
    1e79:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e7d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1e80:	89 04 24             	mov    %eax,(%esp)
    1e83:	e8 8a 2c 00 00       	call   4b12 <updateWindow>
                
			break;
    1e88:	e9 1c 04 00 00       	jmp    22a9 <main+0x7cb>
		case MSG_UPDATE://更新消息（太好了貌似可以直接调重绘了）
			drawPicViewerWnd(context);//绘制窗口
    1e8d:	8b 45 98             	mov    -0x68(%ebp),%eax
    1e90:	89 04 24             	mov    %eax,(%esp)
    1e93:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1e96:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e9a:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1e9d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ea1:	e8 77 f0 ff ff       	call   f1d <drawPicViewerWnd>
			drawPicViewerContent(context, file[pos]);//背景里绘制图片
    1ea6:	a1 4c 25 01 00       	mov    0x1254c,%eax
    1eab:	8b 04 85 60 25 01 00 	mov    0x12560(,%eax,4),%eax
    1eb2:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1eb6:	8b 45 98             	mov    -0x68(%ebp),%eax
    1eb9:	89 04 24             	mov    %eax,(%esp)
    1ebc:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1ebf:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ec3:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1ec6:	89 44 24 08          	mov    %eax,0x8(%esp)
    1eca:	e8 2a f6 ff ff       	call   14f9 <drawPicViewerContent>
			updateWindow(winid, context.addr, msg.msg_detail);//更新窗口
    1ecf:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
    1ed5:	8b 45 98             	mov    -0x68(%ebp),%eax
    1ed8:	89 54 24 08          	mov    %edx,0x8(%esp)
    1edc:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ee0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1ee3:	89 04 24             	mov    %eax,(%esp)
    1ee6:	e8 27 2c 00 00       	call   4b12 <updateWindow>
			break;
    1eeb:	e9 b9 03 00 00       	jmp    22a9 <main+0x7cb>
		case MSG_PARTIAL_UPDATE://部分更新消息
			updatePartialWindow(winid, context.addr,
    1ef0:	8b b5 7c ff ff ff    	mov    -0x84(%ebp),%esi
    1ef6:	8b 9d 78 ff ff ff    	mov    -0x88(%ebp),%ebx
    1efc:	8b 8d 74 ff ff ff    	mov    -0x8c(%ebp),%ecx
    1f02:	8b 95 70 ff ff ff    	mov    -0x90(%ebp),%edx
    1f08:	8b 45 98             	mov    -0x68(%ebp),%eax
    1f0b:	89 74 24 14          	mov    %esi,0x14(%esp)
    1f0f:	89 5c 24 10          	mov    %ebx,0x10(%esp)
    1f13:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1f17:	89 54 24 08          	mov    %edx,0x8(%esp)
    1f1b:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f1f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1f22:	89 04 24             	mov    %eax,(%esp)
    1f25:	e8 f0 2b 00 00       	call   4b1a <updatePartialWindow>
					msg.concrete_msg.msg_partial_update.x1,
					msg.concrete_msg.msg_partial_update.y1,
					msg.concrete_msg.msg_partial_update.x2,
					msg.concrete_msg.msg_partial_update.y2);//还能部分更新窗口？以一个矩形区域更新
			break;
    1f2a:	e9 7a 03 00 00       	jmp    22a9 <main+0x7cb>
		case MSG_LPRESS://鼠标左键按下
			p = initPoint(msg.concrete_msg.msg_mouse.x,
    1f2f:	8b 8d 74 ff ff ff    	mov    -0x8c(%ebp),%ecx
    1f35:	8b 95 70 ff ff ff    	mov    -0x90(%ebp),%edx
    1f3b:	8d 85 30 ff ff ff    	lea    -0xd0(%ebp),%eax
    1f41:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1f45:	89 54 24 04          	mov    %edx,0x4(%esp)
    1f49:	89 04 24             	mov    %eax,(%esp)
    1f4c:	e8 c5 1c 00 00       	call   3c16 <initPoint>
    1f51:	83 ec 04             	sub    $0x4,%esp
    1f54:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
    1f5a:	8b 95 34 ff ff ff    	mov    -0xcc(%ebp),%edx
    1f60:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
    1f66:	89 95 64 ff ff ff    	mov    %edx,-0x9c(%ebp)
					msg.concrete_msg.msg_mouse.y);//获取到鼠标现在的点

			//Rolling Button Area:(40,3),(56,18)
			int RBlowX = 40;
    1f6c:	c7 45 d0 28 00 00 00 	movl   $0x28,-0x30(%ebp)
			int RBlowY = 3;
    1f73:	c7 45 cc 03 00 00 00 	movl   $0x3,-0x34(%ebp)
			int RBhighX = 56;
    1f7a:	c7 45 c8 38 00 00 00 	movl   $0x38,-0x38(%ebp)
			int RBhighY = 18;
    1f81:	c7 45 c4 12 00 00 00 	movl   $0x12,-0x3c(%ebp)
			if(p.x >= RBlowX && p.x <= RBhighX && p.y >= RBlowY && p.y <= RBhighY)
    1f88:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    1f8e:	3b 45 d0             	cmp    -0x30(%ebp),%eax
    1f91:	7c 3a                	jl     1fcd <main+0x4ef>
    1f93:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    1f99:	3b 45 c8             	cmp    -0x38(%ebp),%eax
    1f9c:	7f 2f                	jg     1fcd <main+0x4ef>
    1f9e:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
    1fa4:	3b 45 cc             	cmp    -0x34(%ebp),%eax
    1fa7:	7c 24                	jl     1fcd <main+0x4ef>
    1fa9:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
    1faf:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
    1fb2:	7f 19                	jg     1fcd <main+0x4ef>
			{
				rollingPic(context);
    1fb4:	8b 45 98             	mov    -0x68(%ebp),%eax
    1fb7:	89 04 24             	mov    %eax,(%esp)
    1fba:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1fbd:	89 44 24 04          	mov    %eax,0x4(%esp)
    1fc1:	8b 45 a0             	mov    -0x60(%ebp),%eax
    1fc4:	89 44 24 08          	mov    %eax,0x8(%esp)
    1fc8:	e8 d3 ec ff ff       	call   ca0 <rollingPic>
				
			}

			int NElowX = 60;
    1fcd:	c7 45 c0 3c 00 00 00 	movl   $0x3c,-0x40(%ebp)
			int NElowY = 3;
    1fd4:	c7 45 bc 03 00 00 00 	movl   $0x3,-0x44(%ebp)
			int NEhighX = 76;
    1fdb:	c7 45 b8 4c 00 00 00 	movl   $0x4c,-0x48(%ebp)
			int NEhighY = 18;
    1fe2:	c7 45 b4 12 00 00 00 	movl   $0x12,-0x4c(%ebp)
			if(p.x >= NElowX && p.x <= NEhighX && p.y >= NElowY && p.y <= NEhighY)
    1fe9:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    1fef:	3b 45 c0             	cmp    -0x40(%ebp),%eax
    1ff2:	7c 3a                	jl     202e <main+0x550>
    1ff4:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    1ffa:	3b 45 b8             	cmp    -0x48(%ebp),%eax
    1ffd:	7f 2f                	jg     202e <main+0x550>
    1fff:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
    2005:	3b 45 bc             	cmp    -0x44(%ebp),%eax
    2008:	7c 24                	jl     202e <main+0x550>
    200a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
    2010:	3b 45 b4             	cmp    -0x4c(%ebp),%eax
    2013:	7f 19                	jg     202e <main+0x550>
			{
				nextPic(context);
    2015:	8b 45 98             	mov    -0x68(%ebp),%eax
    2018:	89 04 24             	mov    %eax,(%esp)
    201b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    201e:	89 44 24 04          	mov    %eax,0x4(%esp)
    2022:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2025:	89 44 24 08          	mov    %eax,0x8(%esp)
    2029:	e8 f3 ed ff ff       	call   e21 <nextPic>
			}

			updateWindow(winid, context.addr, msg.msg_detail);//更新窗口
    202e:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
    2034:	8b 45 98             	mov    -0x68(%ebp),%eax
    2037:	89 54 24 08          	mov    %edx,0x8(%esp)
    203b:	89 44 24 04          	mov    %eax,0x4(%esp)
    203f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2042:	89 04 24             	mov    %eax,(%esp)
    2045:	e8 c8 2a 00 00       	call   4b12 <updateWindow>

			if (executeHandler(cm.left_click, p)) {//（暂时不懂）
    204a:	8b 4d 84             	mov    -0x7c(%ebp),%ecx
    204d:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    2053:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
    2059:	89 44 24 04          	mov    %eax,0x4(%esp)
    205d:	89 54 24 08          	mov    %edx,0x8(%esp)
    2061:	89 0c 24             	mov    %ecx,(%esp)
    2064:	e8 de 1e 00 00       	call   3f47 <executeHandler>
    2069:	85 c0                	test   %eax,%eax
    206b:	74 21                	je     208e <main+0x5b0>

				updateWindow(winid, context.addr, msg.msg_detail);
    206d:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
    2073:	8b 45 98             	mov    -0x68(%ebp),%eax
    2076:	89 54 24 08          	mov    %edx,0x8(%esp)
    207a:	89 44 24 04          	mov    %eax,0x4(%esp)
    207e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2081:	89 04 24             	mov    %eax,(%esp)
    2084:	e8 89 2a 00 00       	call   4b12 <updateWindow>
			}
			break;
    2089:	e9 1b 02 00 00       	jmp    22a9 <main+0x7cb>
    208e:	e9 16 02 00 00       	jmp    22a9 <main+0x7cb>
		case MSG_RPRESS://鼠标右键按下
			p = initPoint(msg.concrete_msg.msg_mouse.x,
    2093:	8b 8d 74 ff ff ff    	mov    -0x8c(%ebp),%ecx
    2099:	8b 95 70 ff ff ff    	mov    -0x90(%ebp),%edx
    209f:	8d 85 30 ff ff ff    	lea    -0xd0(%ebp),%eax
    20a5:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    20a9:	89 54 24 04          	mov    %edx,0x4(%esp)
    20ad:	89 04 24             	mov    %eax,(%esp)
    20b0:	e8 61 1b 00 00       	call   3c16 <initPoint>
    20b5:	83 ec 04             	sub    $0x4,%esp
    20b8:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
    20be:	8b 95 34 ff ff ff    	mov    -0xcc(%ebp),%edx
    20c4:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
    20ca:	89 95 64 ff ff ff    	mov    %edx,-0x9c(%ebp)
					msg.concrete_msg.msg_mouse.y);
			if(isShowing == 0)
    20d0:	a1 20 f7 00 00       	mov    0xf720,%eax
    20d5:	85 c0                	test   %eax,%eax
    20d7:	75 39                	jne    2112 <main+0x634>
			{
				propertyShow(context, p.x, p.y);
    20d9:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
    20df:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    20e5:	89 54 24 10          	mov    %edx,0x10(%esp)
    20e9:	89 44 24 0c          	mov    %eax,0xc(%esp)
    20ed:	8b 45 98             	mov    -0x68(%ebp),%eax
    20f0:	89 04 24             	mov    %eax,(%esp)
    20f3:	8b 45 9c             	mov    -0x64(%ebp),%eax
    20f6:	89 44 24 04          	mov    %eax,0x4(%esp)
    20fa:	8b 45 a0             	mov    -0x60(%ebp),%eax
    20fd:	89 44 24 08          	mov    %eax,0x8(%esp)
    2101:	e8 f9 f5 ff ff       	call   16ff <propertyShow>
				isShowing = 1;
    2106:	c7 05 20 f7 00 00 01 	movl   $0x1,0xf720
    210d:	00 00 00 
    2110:	eb 56                	jmp    2168 <main+0x68a>
			}
			else if(isShowing == 1)
    2112:	a1 20 f7 00 00       	mov    0xf720,%eax
    2117:	83 f8 01             	cmp    $0x1,%eax
    211a:	75 4c                	jne    2168 <main+0x68a>
			{
				drawPicViewerWnd(context);
    211c:	8b 45 98             	mov    -0x68(%ebp),%eax
    211f:	89 04 24             	mov    %eax,(%esp)
    2122:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2125:	89 44 24 04          	mov    %eax,0x4(%esp)
    2129:	8b 45 a0             	mov    -0x60(%ebp),%eax
    212c:	89 44 24 08          	mov    %eax,0x8(%esp)
    2130:	e8 e8 ed ff ff       	call   f1d <drawPicViewerWnd>
				drawPicViewerContentForProper(context, file[pos]);//背景里绘制图片
    2135:	a1 4c 25 01 00       	mov    0x1254c,%eax
    213a:	8b 04 85 60 25 01 00 	mov    0x12560(,%eax,4),%eax
    2141:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2145:	8b 45 98             	mov    -0x68(%ebp),%eax
    2148:	89 04 24             	mov    %eax,(%esp)
    214b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    214e:	89 44 24 04          	mov    %eax,0x4(%esp)
    2152:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2155:	89 44 24 08          	mov    %eax,0x8(%esp)
    2159:	e8 7d f4 ff ff       	call   15db <drawPicViewerContentForProper>
				isShowing = 0;
    215e:	c7 05 20 f7 00 00 00 	movl   $0x0,0xf720
    2165:	00 00 00 
			}
			updateWindow(winid, context.addr, msg.msg_detail);//更新窗口
    2168:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
    216e:	8b 45 98             	mov    -0x68(%ebp),%eax
    2171:	89 54 24 08          	mov    %edx,0x8(%esp)
    2175:	89 44 24 04          	mov    %eax,0x4(%esp)
    2179:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    217c:	89 04 24             	mov    %eax,(%esp)
    217f:	e8 8e 29 00 00       	call   4b12 <updateWindow>
			if (executeHandler(cm.right_click, p)) {
    2184:	8b 4d 8c             	mov    -0x74(%ebp),%ecx
    2187:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    218d:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
    2193:	89 44 24 04          	mov    %eax,0x4(%esp)
    2197:	89 54 24 08          	mov    %edx,0x8(%esp)
    219b:	89 0c 24             	mov    %ecx,(%esp)
    219e:	e8 a4 1d 00 00       	call   3f47 <executeHandler>
    21a3:	85 c0                	test   %eax,%eax
    21a5:	74 21                	je     21c8 <main+0x6ea>
				updateWindow(winid, context.addr, msg.msg_detail);
    21a7:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
    21ad:	8b 45 98             	mov    -0x68(%ebp),%eax
    21b0:	89 54 24 08          	mov    %edx,0x8(%esp)
    21b4:	89 44 24 04          	mov    %eax,0x4(%esp)
    21b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    21bb:	89 04 24             	mov    %eax,(%esp)
    21be:	e8 4f 29 00 00       	call   4b12 <updateWindow>
			}
			break;
    21c3:	e9 e1 00 00 00       	jmp    22a9 <main+0x7cb>
    21c8:	e9 dc 00 00 00       	jmp    22a9 <main+0x7cb>
		case MSG_KEYDOWN:
			switch(msg.concrete_msg.msg_key.key) {
    21cd:	0f b6 85 70 ff ff ff 	movzbl -0x90(%ebp),%eax
    21d4:	0f be c0             	movsbl %al,%eax
    21d7:	83 f8 34             	cmp    $0x34,%eax
    21da:	74 18                	je     21f4 <main+0x716>
    21dc:	83 f8 34             	cmp    $0x34,%eax
    21df:	7f 07                	jg     21e8 <main+0x70a>
    21e1:	83 f8 32             	cmp    $0x32,%eax
    21e4:	74 3b                	je     2221 <main+0x743>
					break;
				case 50:
					Y_shift += shift_at_once;
					break;
				default:
					break;
    21e6:	eb 47                	jmp    222f <main+0x751>
			if (executeHandler(cm.right_click, p)) {
				updateWindow(winid, context.addr, msg.msg_detail);
			}
			break;
		case MSG_KEYDOWN:
			switch(msg.concrete_msg.msg_key.key) {
    21e8:	83 f8 36             	cmp    $0x36,%eax
    21eb:	74 16                	je     2203 <main+0x725>
    21ed:	83 f8 38             	cmp    $0x38,%eax
    21f0:	74 20                	je     2212 <main+0x734>
					break;
				case 50:
					Y_shift += shift_at_once;
					break;
				default:
					break;
    21f2:	eb 3b                	jmp    222f <main+0x751>
			}
			break;
		case MSG_KEYDOWN:
			switch(msg.concrete_msg.msg_key.key) {
				case 52:
					X_shift -= shift_at_once;
    21f4:	a1 2c f7 00 00       	mov    0xf72c,%eax
    21f9:	83 e8 05             	sub    $0x5,%eax
    21fc:	a3 2c f7 00 00       	mov    %eax,0xf72c
					break;
    2201:	eb 2c                	jmp    222f <main+0x751>
				case 54:
					X_shift += shift_at_once;
    2203:	a1 2c f7 00 00       	mov    0xf72c,%eax
    2208:	83 c0 05             	add    $0x5,%eax
    220b:	a3 2c f7 00 00       	mov    %eax,0xf72c
					break;
    2210:	eb 1d                	jmp    222f <main+0x751>
				case 56:
					Y_shift -= shift_at_once;
    2212:	a1 30 f7 00 00       	mov    0xf730,%eax
    2217:	83 e8 05             	sub    $0x5,%eax
    221a:	a3 30 f7 00 00       	mov    %eax,0xf730
					break;
    221f:	eb 0e                	jmp    222f <main+0x751>
				case 50:
					Y_shift += shift_at_once;
    2221:	a1 30 f7 00 00       	mov    0xf730,%eax
    2226:	83 c0 05             	add    $0x5,%eax
    2229:	a3 30 f7 00 00       	mov    %eax,0xf730
					break;
    222e:	90                   	nop
				default:
					break;
			}
			drawPicViewerWnd(context);
    222f:	8b 45 98             	mov    -0x68(%ebp),%eax
    2232:	89 04 24             	mov    %eax,(%esp)
    2235:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2238:	89 44 24 04          	mov    %eax,0x4(%esp)
    223c:	8b 45 a0             	mov    -0x60(%ebp),%eax
    223f:	89 44 24 08          	mov    %eax,0x8(%esp)
    2243:	e8 d5 ec ff ff       	call   f1d <drawPicViewerWnd>
			drawPicViewerContent(context, file[pos]);
    2248:	a1 4c 25 01 00       	mov    0x1254c,%eax
    224d:	8b 04 85 60 25 01 00 	mov    0x12560(,%eax,4),%eax
    2254:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2258:	8b 45 98             	mov    -0x68(%ebp),%eax
    225b:	89 04 24             	mov    %eax,(%esp)
    225e:	8b 45 9c             	mov    -0x64(%ebp),%eax
    2261:	89 44 24 04          	mov    %eax,0x4(%esp)
    2265:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2268:	89 44 24 08          	mov    %eax,0x8(%esp)
    226c:	e8 88 f2 ff ff       	call   14f9 <drawPicViewerContent>
			updateWindowWithoutBlank(context);
    2271:	8b 45 98             	mov    -0x68(%ebp),%eax
    2274:	89 04 24             	mov    %eax,(%esp)
    2277:	8b 45 9c             	mov    -0x64(%ebp),%eax
    227a:	89 44 24 04          	mov    %eax,0x4(%esp)
    227e:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2281:	89 44 24 08          	mov    %eax,0x8(%esp)
    2285:	e8 8d ef ff ff       	call   1217 <updateWindowWithoutBlank>
			updateWindow(winid, context.addr, msg.msg_detail);
    228a:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
    2290:	8b 45 98             	mov    -0x68(%ebp),%eax
    2293:	89 54 24 08          	mov    %edx,0x8(%esp)
    2297:	89 44 24 04          	mov    %eax,0x4(%esp)
    229b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    229e:	89 04 24             	mov    %eax,(%esp)
    22a1:	e8 6c 28 00 00       	call   4b12 <updateWindow>
			break;
    22a6:	eb 01                	jmp    22a9 <main+0x7cb>
		default:
			break;
    22a8:	90                   	nop
    deleteClickable(&cm.left_click, initRect(0, 0, 800, 600));
    addWndEvent(&cm);//添加cm到窗口事件

    Initialize(context);

    while (isRun) {
    22a9:	a1 18 f2 00 00       	mov    0xf218,%eax
    22ae:	85 c0                	test   %eax,%eax
    22b0:	0f 85 b5 fa ff ff    	jne    1d6b <main+0x28d>
			break;
		default:
			break;
		}
    }
    free_context(&context, winid);
    22b6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    22b9:	89 44 24 04          	mov    %eax,0x4(%esp)
    22bd:	8d 45 98             	lea    -0x68(%ebp),%eax
    22c0:	89 04 24             	mov    %eax,(%esp)
    22c3:	e8 88 00 00 00       	call   2350 <free_context>
    exit();
    22c8:	e8 8d 27 00 00       	call   4a5a <exit>

000022cd <init_context>:
#include "user.h"
#include "message.h"
#include "drawingAPI.h"

int init_context(struct Context* context_ptr, int width, int height)
{
    22cd:	55                   	push   %ebp
    22ce:	89 e5                	mov    %esp,%ebp
    22d0:	83 ec 18             	sub    $0x18,%esp
    context_ptr->width = width;
    22d3:	8b 45 08             	mov    0x8(%ebp),%eax
    22d6:	8b 55 0c             	mov    0xc(%ebp),%edx
    22d9:	89 50 04             	mov    %edx,0x4(%eax)
    context_ptr->height = height;
    22dc:	8b 45 08             	mov    0x8(%ebp),%eax
    22df:	8b 55 10             	mov    0x10(%ebp),%edx
    22e2:	89 50 08             	mov    %edx,0x8(%eax)
    context_ptr->addr = (unsigned short*)malloc(sizeof(unsigned short) * width * height);
    22e5:	8b 55 0c             	mov    0xc(%ebp),%edx
    22e8:	8b 45 10             	mov    0x10(%ebp),%eax
    22eb:	0f af c2             	imul   %edx,%eax
    22ee:	01 c0                	add    %eax,%eax
    22f0:	89 04 24             	mov    %eax,(%esp)
    22f3:	e8 3e 2c 00 00       	call   4f36 <malloc>
    22f8:	8b 55 08             	mov    0x8(%ebp),%edx
    22fb:	89 02                	mov    %eax,(%edx)
    memset(context_ptr->addr, 0, sizeof(unsigned short) * width * height);
    22fd:	8b 55 0c             	mov    0xc(%ebp),%edx
    2300:	8b 45 10             	mov    0x10(%ebp),%eax
    2303:	0f af c2             	imul   %edx,%eax
    2306:	8d 14 00             	lea    (%eax,%eax,1),%edx
    2309:	8b 45 08             	mov    0x8(%ebp),%eax
    230c:	8b 00                	mov    (%eax),%eax
    230e:	89 54 24 08          	mov    %edx,0x8(%esp)
    2312:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2319:	00 
    231a:	89 04 24             	mov    %eax,(%esp)
    231d:	e8 8b 25 00 00       	call   48ad <memset>
    initializeASCII();
    2322:	e8 cd 02 00 00       	call   25f4 <initializeASCII>
    initializeGBK();
    2327:	e8 51 04 00 00       	call   277d <initializeGBK>
    return createWindow(0, 0, width, height);
    232c:	8b 45 10             	mov    0x10(%ebp),%eax
    232f:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2333:	8b 45 0c             	mov    0xc(%ebp),%eax
    2336:	89 44 24 08          	mov    %eax,0x8(%esp)
    233a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2341:	00 
    2342:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2349:	e8 b4 27 00 00       	call   4b02 <createWindow>
}
    234e:	c9                   	leave  
    234f:	c3                   	ret    

00002350 <free_context>:

void free_context(struct Context* context_ptr, int winid)
{
    2350:	55                   	push   %ebp
    2351:	89 e5                	mov    %esp,%ebp
    2353:	83 ec 18             	sub    $0x18,%esp
    free(context_ptr->addr);
    2356:	8b 45 08             	mov    0x8(%ebp),%eax
    2359:	8b 00                	mov    (%eax),%eax
    235b:	89 04 24             	mov    %eax,(%esp)
    235e:	e8 9a 2a 00 00       	call   4dfd <free>
    freeASCII();
    2363:	e8 00 04 00 00       	call   2768 <freeASCII>
    freeGBK();
    2368:	e8 b8 04 00 00       	call   2825 <freeGBK>
    destroyWindow(winid);
    236d:	8b 45 0c             	mov    0xc(%ebp),%eax
    2370:	89 04 24             	mov    %eax,(%esp)
    2373:	e8 92 27 00 00       	call   4b0a <destroyWindow>
}
    2378:	c9                   	leave  
    2379:	c3                   	ret    

0000237a <draw_point>:
*             then do nothing!
*/

void
draw_point(struct Context c, unsigned int x, unsigned int y, unsigned short color)
{
    237a:	55                   	push   %ebp
    237b:	89 e5                	mov    %esp,%ebp
    237d:	83 ec 04             	sub    $0x4,%esp
    2380:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2383:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  if(x >= c.width)
    2387:	8b 45 0c             	mov    0xc(%ebp),%eax
    238a:	3b 45 14             	cmp    0x14(%ebp),%eax
    238d:	77 02                	ja     2391 <draw_point+0x17>
    return;
    238f:	eb 26                	jmp    23b7 <draw_point+0x3d>
  if(y >= c.height)
    2391:	8b 45 10             	mov    0x10(%ebp),%eax
    2394:	3b 45 18             	cmp    0x18(%ebp),%eax
    2397:	77 02                	ja     239b <draw_point+0x21>
    return;
    2399:	eb 1c                	jmp    23b7 <draw_point+0x3d>
  c.addr[y*c.width+x] = color;
    239b:	8b 55 08             	mov    0x8(%ebp),%edx
    239e:	8b 45 0c             	mov    0xc(%ebp),%eax
    23a1:	0f af 45 18          	imul   0x18(%ebp),%eax
    23a5:	89 c1                	mov    %eax,%ecx
    23a7:	8b 45 14             	mov    0x14(%ebp),%eax
    23aa:	01 c8                	add    %ecx,%eax
    23ac:	01 c0                	add    %eax,%eax
    23ae:	01 c2                	add    %eax,%edx
    23b0:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
    23b4:	66 89 02             	mov    %ax,(%edx)
}
    23b7:	c9                   	leave  
    23b8:	c3                   	ret    

000023b9 <fill_rect>:
/*
*fill_rect: set a rect area with a certain color
*/
void
fill_rect(struct Context c, unsigned int bx, unsigned int by, unsigned int width, unsigned int height, unsigned short color)
{
    23b9:	55                   	push   %ebp
    23ba:	89 e5                	mov    %esp,%ebp
    23bc:	83 ec 2c             	sub    $0x2c,%esp
    23bf:	8b 45 24             	mov    0x24(%ebp),%eax
    23c2:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
    23c6:	8b 45 1c             	mov    0x1c(%ebp),%eax
    23c9:	8b 55 14             	mov    0x14(%ebp),%edx
    23cc:	01 c2                	add    %eax,%edx
    23ce:	8b 45 0c             	mov    0xc(%ebp),%eax
    23d1:	39 c2                	cmp    %eax,%edx
    23d3:	0f 46 c2             	cmovbe %edx,%eax
    23d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int my = c.height < by + height ? c.height : by + height;
    23d9:	8b 45 20             	mov    0x20(%ebp),%eax
    23dc:	8b 55 18             	mov    0x18(%ebp),%edx
    23df:	01 c2                	add    %eax,%edx
    23e1:	8b 45 10             	mov    0x10(%ebp),%eax
    23e4:	39 c2                	cmp    %eax,%edx
    23e6:	0f 46 c2             	cmovbe %edx,%eax
    23e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	for (y = by; y < my; y++)
    23ec:	8b 45 18             	mov    0x18(%ebp),%eax
    23ef:	89 45 f8             	mov    %eax,-0x8(%ebp)
    23f2:	eb 47                	jmp    243b <fill_rect+0x82>
	{
		for (x = bx; x < mx; x++)
    23f4:	8b 45 14             	mov    0x14(%ebp),%eax
    23f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    23fa:	eb 33                	jmp    242f <fill_rect+0x76>
		{
			draw_point(c, x, y, color);
    23fc:	0f b7 4d ec          	movzwl -0x14(%ebp),%ecx
    2400:	8b 55 f8             	mov    -0x8(%ebp),%edx
    2403:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2406:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    240a:	89 54 24 10          	mov    %edx,0x10(%esp)
    240e:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2412:	8b 45 08             	mov    0x8(%ebp),%eax
    2415:	89 04 24             	mov    %eax,(%esp)
    2418:	8b 45 0c             	mov    0xc(%ebp),%eax
    241b:	89 44 24 04          	mov    %eax,0x4(%esp)
    241f:	8b 45 10             	mov    0x10(%ebp),%eax
    2422:	89 44 24 08          	mov    %eax,0x8(%esp)
    2426:	e8 4f ff ff ff       	call   237a <draw_point>
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
	int my = c.height < by + height ? c.height : by + height;
	for (y = by; y < my; y++)
	{
		for (x = bx; x < mx; x++)
    242b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    242f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2432:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2435:	7c c5                	jl     23fc <fill_rect+0x43>
fill_rect(struct Context c, unsigned int bx, unsigned int by, unsigned int width, unsigned int height, unsigned short color)
{
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
	int my = c.height < by + height ? c.height : by + height;
	for (y = by; y < my; y++)
    2437:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    243b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    243e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    2441:	7c b1                	jl     23f4 <fill_rect+0x3b>
		for (x = bx; x < mx; x++)
		{
			draw_point(c, x, y, color);
		}
	}
}
    2443:	c9                   	leave  
    2444:	c3                   	ret    

00002445 <fill_rect_vertical_gradient>:

void fill_rect_vertical_gradient(struct Context c, unsigned int bx, unsigned int by, unsigned int width, unsigned int height, unsigned short color1, unsigned short color2)
{
    2445:	55                   	push   %ebp
    2446:	89 e5                	mov    %esp,%ebp
    2448:	83 ec 58             	sub    $0x58,%esp
    244b:	8b 55 24             	mov    0x24(%ebp),%edx
    244e:	8b 45 28             	mov    0x28(%ebp),%eax
    2451:	66 89 55 d4          	mov    %dx,-0x2c(%ebp)
    2455:	66 89 45 d0          	mov    %ax,-0x30(%ebp)
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
    2459:	8b 45 1c             	mov    0x1c(%ebp),%eax
    245c:	8b 55 14             	mov    0x14(%ebp),%edx
    245f:	01 c2                	add    %eax,%edx
    2461:	8b 45 0c             	mov    0xc(%ebp),%eax
    2464:	39 c2                	cmp    %eax,%edx
    2466:	0f 46 c2             	cmovbe %edx,%eax
    2469:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int my = c.height < by + height ? c.height : by + height;
    246c:	8b 45 20             	mov    0x20(%ebp),%eax
    246f:	8b 55 18             	mov    0x18(%ebp),%edx
    2472:	01 c2                	add    %eax,%edx
    2474:	8b 45 10             	mov    0x10(%ebp),%eax
    2477:	39 c2                	cmp    %eax,%edx
    2479:	0f 46 c2             	cmovbe %edx,%eax
    247c:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for (y = by; y < my; y++)
    247f:	8b 45 18             	mov    0x18(%ebp),%eax
    2482:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2485:	e9 e7 00 00 00       	jmp    2571 <fill_rect_vertical_gradient+0x12c>
	{
		int color = color1 * (1 - ((double)(y - by) / (double)(my - by))) + color2 * ((double)(y - by) / (double)(my - by));
    248a:	0f b7 45 d4          	movzwl -0x2c(%ebp),%eax
    248e:	89 45 cc             	mov    %eax,-0x34(%ebp)
    2491:	db 45 cc             	fildl  -0x34(%ebp)
    2494:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2497:	2b 45 18             	sub    0x18(%ebp),%eax
    249a:	ba 00 00 00 00       	mov    $0x0,%edx
    249f:	89 45 c0             	mov    %eax,-0x40(%ebp)
    24a2:	89 55 c4             	mov    %edx,-0x3c(%ebp)
    24a5:	df 6d c0             	fildll -0x40(%ebp)
    24a8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    24ab:	2b 45 18             	sub    0x18(%ebp),%eax
    24ae:	ba 00 00 00 00       	mov    $0x0,%edx
    24b3:	89 45 c0             	mov    %eax,-0x40(%ebp)
    24b6:	89 55 c4             	mov    %edx,-0x3c(%ebp)
    24b9:	df 6d c0             	fildll -0x40(%ebp)
    24bc:	de f9                	fdivrp %st,%st(1)
    24be:	d9 e8                	fld1   
    24c0:	de e1                	fsubp  %st,%st(1)
    24c2:	de c9                	fmulp  %st,%st(1)
    24c4:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
    24c8:	89 45 cc             	mov    %eax,-0x34(%ebp)
    24cb:	db 45 cc             	fildl  -0x34(%ebp)
    24ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
    24d1:	2b 45 18             	sub    0x18(%ebp),%eax
    24d4:	ba 00 00 00 00       	mov    $0x0,%edx
    24d9:	89 45 c0             	mov    %eax,-0x40(%ebp)
    24dc:	89 55 c4             	mov    %edx,-0x3c(%ebp)
    24df:	df 6d c0             	fildll -0x40(%ebp)
    24e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    24e5:	2b 45 18             	sub    0x18(%ebp),%eax
    24e8:	ba 00 00 00 00       	mov    $0x0,%edx
    24ed:	89 45 c0             	mov    %eax,-0x40(%ebp)
    24f0:	89 55 c4             	mov    %edx,-0x3c(%ebp)
    24f3:	df 6d c0             	fildll -0x40(%ebp)
    24f6:	de f9                	fdivrp %st,%st(1)
    24f8:	de c9                	fmulp  %st,%st(1)
    24fa:	de c1                	faddp  %st,%st(1)
    24fc:	d9 7d ca             	fnstcw -0x36(%ebp)
    24ff:	0f b7 45 ca          	movzwl -0x36(%ebp),%eax
    2503:	b4 0c                	mov    $0xc,%ah
    2505:	66 89 45 c8          	mov    %ax,-0x38(%ebp)
    2509:	d9 6d c8             	fldcw  -0x38(%ebp)
    250c:	db 5d e4             	fistpl -0x1c(%ebp)
    250f:	d9 6d ca             	fldcw  -0x36(%ebp)
		for (x = bx; x < mx; x++)
    2512:	8b 45 14             	mov    0x14(%ebp),%eax
    2515:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2518:	eb 4b                	jmp    2565 <fill_rect_vertical_gradient+0x120>
		{
			draw_point(c, x, y, _RGB16BIT565(color, color, color));
    251a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    251d:	89 44 24 08          	mov    %eax,0x8(%esp)
    2521:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2524:	89 44 24 04          	mov    %eax,0x4(%esp)
    2528:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    252b:	89 04 24             	mov    %eax,(%esp)
    252e:	e8 72 06 00 00       	call   2ba5 <_RGB16BIT565>
    2533:	0f b7 c8             	movzwl %ax,%ecx
    2536:	8b 55 f0             	mov    -0x10(%ebp),%edx
    2539:	8b 45 f4             	mov    -0xc(%ebp),%eax
    253c:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2540:	89 54 24 10          	mov    %edx,0x10(%esp)
    2544:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2548:	8b 45 08             	mov    0x8(%ebp),%eax
    254b:	89 04 24             	mov    %eax,(%esp)
    254e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2551:	89 44 24 04          	mov    %eax,0x4(%esp)
    2555:	8b 45 10             	mov    0x10(%ebp),%eax
    2558:	89 44 24 08          	mov    %eax,0x8(%esp)
    255c:	e8 19 fe ff ff       	call   237a <draw_point>
	int mx = c.width < bx + width ? c.width : bx + width;
	int my = c.height < by + height ? c.height : by + height;
	for (y = by; y < my; y++)
	{
		int color = color1 * (1 - ((double)(y - by) / (double)(my - by))) + color2 * ((double)(y - by) / (double)(my - by));
		for (x = bx; x < mx; x++)
    2561:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2565:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2568:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    256b:	7c ad                	jl     251a <fill_rect_vertical_gradient+0xd5>
void fill_rect_vertical_gradient(struct Context c, unsigned int bx, unsigned int by, unsigned int width, unsigned int height, unsigned short color1, unsigned short color2)
{
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
	int my = c.height < by + height ? c.height : by + height;
	for (y = by; y < my; y++)
    256d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2571:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2574:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    2577:	0f 8c 0d ff ff ff    	jl     248a <fill_rect_vertical_gradient+0x45>
		for (x = bx; x < mx; x++)
		{
			draw_point(c, x, y, _RGB16BIT565(color, color, color));
		}
	}
}
    257d:	c9                   	leave  
    257e:	c3                   	ret    

0000257f <printBinary>:

void printBinary(char c)
{
    257f:	55                   	push   %ebp
    2580:	89 e5                	mov    %esp,%ebp
    2582:	83 ec 28             	sub    $0x28,%esp
    2585:	8b 45 08             	mov    0x8(%ebp),%eax
    2588:	88 45 e4             	mov    %al,-0x1c(%ebp)
	int i;
	for (i = 0; i < 8; i++)
    258b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2592:	eb 44                	jmp    25d8 <printBinary+0x59>
	{
		if(((c << i) & 0x80) != 0)
    2594:	0f be 55 e4          	movsbl -0x1c(%ebp),%edx
    2598:	8b 45 f4             	mov    -0xc(%ebp),%eax
    259b:	89 c1                	mov    %eax,%ecx
    259d:	d3 e2                	shl    %cl,%edx
    259f:	89 d0                	mov    %edx,%eax
    25a1:	25 80 00 00 00       	and    $0x80,%eax
    25a6:	85 c0                	test   %eax,%eax
    25a8:	74 16                	je     25c0 <printBinary+0x41>
		{
			printf(0, "1");
    25aa:	c7 44 24 04 d0 b4 00 	movl   $0xb4d0,0x4(%esp)
    25b1:	00 
    25b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25b9:	e8 8c 26 00 00       	call   4c4a <printf>
    25be:	eb 14                	jmp    25d4 <printBinary+0x55>
		}
		else
		{
			printf(0, "0");
    25c0:	c7 44 24 04 d2 b4 00 	movl   $0xb4d2,0x4(%esp)
    25c7:	00 
    25c8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25cf:	e8 76 26 00 00       	call   4c4a <printf>
}

void printBinary(char c)
{
	int i;
	for (i = 0; i < 8; i++)
    25d4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    25d8:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    25dc:	7e b6                	jle    2594 <printBinary+0x15>
		{
			printf(0, "0");
		}
	}

	printf(0, "\n");
    25de:	c7 44 24 04 d4 b4 00 	movl   $0xb4d4,0x4(%esp)
    25e5:	00 
    25e6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25ed:	e8 58 26 00 00       	call   4c4a <printf>
}
    25f2:	c9                   	leave  
    25f3:	c3                   	ret    

000025f4 <initializeASCII>:
char buf[512];
//hankaku是一个数组，将hankaku.txt文件中的每一行转化成一个8位整数（unsigned short）
//每16个整数可以代表一个字符
unsigned char *hankaku;
void initializeASCII()
{
    25f4:	55                   	push   %ebp
    25f5:	89 e5                	mov    %esp,%ebp
    25f7:	56                   	push   %esi
    25f8:	53                   	push   %ebx
    25f9:	83 ec 30             	sub    $0x30,%esp

	int fd, n, i;
	int x, y;
	printf(0,"initialzing ASCII\n");
    25fc:	c7 44 24 04 d6 b4 00 	movl   $0xb4d6,0x4(%esp)
    2603:	00 
    2604:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    260b:	e8 3a 26 00 00       	call   4c4a <printf>
	//打开hankaku.txt文件
	if((fd = open(HANKAKU, 0)) < 0){
    2610:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2617:	00 
    2618:	c7 04 24 e9 b4 00 00 	movl   $0xb4e9,(%esp)
    261f:	e8 76 24 00 00       	call   4a9a <open>
    2624:	89 45 e8             	mov    %eax,-0x18(%ebp)
    2627:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    262b:	79 21                	jns    264e <initializeASCII+0x5a>
	  printf(0,"cannot open %s\n", HANKAKU);
    262d:	c7 44 24 08 e9 b4 00 	movl   $0xb4e9,0x8(%esp)
    2634:	00 
    2635:	c7 44 24 04 f5 b4 00 	movl   $0xb4f5,0x4(%esp)
    263c:	00 
    263d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2644:	e8 01 26 00 00       	call   4c4a <printf>
	  return;
    2649:	e9 13 01 00 00       	jmp    2761 <initializeASCII+0x16d>
	}
	//申请hankaku数组
	hankaku = malloc(ASCII_NUM*ASCII_HEIGHT);
    264e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2655:	e8 dc 28 00 00       	call   4f36 <malloc>
    265a:	a3 00 27 01 00       	mov    %eax,0x12700
	for (i = 0; i < ASCII_NUM; i++)
    265f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2666:	eb 12                	jmp    267a <initializeASCII+0x86>
	{
		hankaku[i] = 0;
    2668:	8b 15 00 27 01 00    	mov    0x12700,%edx
    266e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2671:	01 d0                	add    %edx,%eax
    2673:	c6 00 00             	movb   $0x0,(%eax)
	  printf(0,"cannot open %s\n", HANKAKU);
	  return;
	}
	//申请hankaku数组
	hankaku = malloc(ASCII_NUM*ASCII_HEIGHT);
	for (i = 0; i < ASCII_NUM; i++)
    2676:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    267a:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
    2681:	7e e5                	jle    2668 <initializeASCII+0x74>

	//不断读取文件，如果读到的字符是“*/."，就按顺序记录到hankaku数组中
	//y表示当前记录到第几行（对应于hankaku数组里的第几个数），x表示当前记录到第几列
	//如果当前字符是"*",则对应第y个数第x位置为1
	//每当x == ASCII_WIDTH，x重新置为0, y++
	x = 0;
    2683:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	y = 0;
    268a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	while((n = read(fd, buf, sizeof(buf))) > 0)
    2691:	e9 84 00 00 00       	jmp    271a <initializeASCII+0x126>
	{
		for (i = 0; i < n; i++){
    2696:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    269d:	eb 73                	jmp    2712 <initializeASCII+0x11e>
			//printf(0,"%c, %d", buf[i], i);
			if (buf[i] == '*' || buf[i] == '.')
    269f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26a2:	05 20 27 01 00       	add    $0x12720,%eax
    26a7:	0f b6 00             	movzbl (%eax),%eax
    26aa:	3c 2a                	cmp    $0x2a,%al
    26ac:	74 0f                	je     26bd <initializeASCII+0xc9>
    26ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26b1:	05 20 27 01 00       	add    $0x12720,%eax
    26b6:	0f b6 00             	movzbl (%eax),%eax
    26b9:	3c 2e                	cmp    $0x2e,%al
    26bb:	75 51                	jne    270e <initializeASCII+0x11a>
			{
				if (buf[i] == '*')
    26bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26c0:	05 20 27 01 00       	add    $0x12720,%eax
    26c5:	0f b6 00             	movzbl (%eax),%eax
    26c8:	3c 2a                	cmp    $0x2a,%al
    26ca:	75 2d                	jne    26f9 <initializeASCII+0x105>
				{
					hankaku[y] |= (0x80 >> x);
    26cc:	8b 15 00 27 01 00    	mov    0x12700,%edx
    26d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    26d5:	01 c2                	add    %eax,%edx
    26d7:	8b 0d 00 27 01 00    	mov    0x12700,%ecx
    26dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    26e0:	01 c8                	add    %ecx,%eax
    26e2:	0f b6 00             	movzbl (%eax),%eax
    26e5:	89 c3                	mov    %eax,%ebx
    26e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    26ea:	be 80 00 00 00       	mov    $0x80,%esi
    26ef:	89 c1                	mov    %eax,%ecx
    26f1:	d3 fe                	sar    %cl,%esi
    26f3:	89 f0                	mov    %esi,%eax
    26f5:	09 d8                	or     %ebx,%eax
    26f7:	88 02                	mov    %al,(%edx)
				}
				x ++;
    26f9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
				if (x >= ASCII_WIDTH)
    26fd:	83 7d f0 07          	cmpl   $0x7,-0x10(%ebp)
    2701:	7e 0b                	jle    270e <initializeASCII+0x11a>
				{
					x = 0;
    2703:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
					y ++;
    270a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
	//每当x == ASCII_WIDTH，x重新置为0, y++
	x = 0;
	y = 0;
	while((n = read(fd, buf, sizeof(buf))) > 0)
	{
		for (i = 0; i < n; i++){
    270e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2712:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2715:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    2718:	7c 85                	jl     269f <initializeASCII+0xab>
	//y表示当前记录到第几行（对应于hankaku数组里的第几个数），x表示当前记录到第几列
	//如果当前字符是"*",则对应第y个数第x位置为1
	//每当x == ASCII_WIDTH，x重新置为0, y++
	x = 0;
	y = 0;
	while((n = read(fd, buf, sizeof(buf))) > 0)
    271a:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    2721:	00 
    2722:	c7 44 24 04 20 27 01 	movl   $0x12720,0x4(%esp)
    2729:	00 
    272a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    272d:	89 04 24             	mov    %eax,(%esp)
    2730:	e8 3d 23 00 00       	call   4a72 <read>
    2735:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    2738:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    273c:	0f 8f 54 ff ff ff    	jg     2696 <initializeASCII+0xa2>

//	for (i = 0; i < ASCII_NUM * ASCII_HEIGHT; i++)
//	{
//		printBinary(hankaku[i]);
//	}
	printf(0,"initialzing ASCII complete!\n");
    2742:	c7 44 24 04 05 b5 00 	movl   $0xb505,0x4(%esp)
    2749:	00 
    274a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2751:	e8 f4 24 00 00       	call   4c4a <printf>
	close(fd);
    2756:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2759:	89 04 24             	mov    %eax,(%esp)
    275c:	e8 21 23 00 00       	call   4a82 <close>
}
    2761:	83 c4 30             	add    $0x30,%esp
    2764:	5b                   	pop    %ebx
    2765:	5e                   	pop    %esi
    2766:	5d                   	pop    %ebp
    2767:	c3                   	ret    

00002768 <freeASCII>:

void freeASCII(){
    2768:	55                   	push   %ebp
    2769:	89 e5                	mov    %esp,%ebp
    276b:	83 ec 18             	sub    $0x18,%esp
	free(hankaku);
    276e:	a1 00 27 01 00       	mov    0x12700,%eax
    2773:	89 04 24             	mov    %eax,(%esp)
    2776:	e8 82 26 00 00       	call   4dfd <free>
}
    277b:	c9                   	leave  
    277c:	c3                   	ret    

0000277d <initializeGBK>:

struct File_Node fontFile;
void initializeGBK(){
    277d:	55                   	push   %ebp
    277e:	89 e5                	mov    %esp,%ebp
    2780:	83 ec 28             	sub    $0x28,%esp
	int fd;
	printf(0,"initialzing gbk\n");
    2783:	c7 44 24 04 22 b5 00 	movl   $0xb522,0x4(%esp)
    278a:	00 
    278b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2792:	e8 b3 24 00 00       	call   4c4a <printf>
	if((fd = open(HZK16, 0)) < 0){
    2797:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    279e:	00 
    279f:	c7 04 24 33 b5 00 00 	movl   $0xb533,(%esp)
    27a6:	e8 ef 22 00 00       	call   4a9a <open>
    27ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
    27ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    27b2:	79 1e                	jns    27d2 <initializeGBK+0x55>
		printf(0,"cannot open %s\n", HZK16);
    27b4:	c7 44 24 08 33 b5 00 	movl   $0xb533,0x8(%esp)
    27bb:	00 
    27bc:	c7 44 24 04 f5 b4 00 	movl   $0xb4f5,0x4(%esp)
    27c3:	00 
    27c4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    27cb:	e8 7a 24 00 00       	call   4c4a <printf>
		return;
    27d0:	eb 51                	jmp    2823 <initializeGBK+0xa6>
	}
	fontFile.buf = malloc(27000*sizeof(unsigned char));
    27d2:	c7 04 24 78 69 00 00 	movl   $0x6978,(%esp)
    27d9:	e8 58 27 00 00       	call   4f36 <malloc>
    27de:	a3 04 27 01 00       	mov    %eax,0x12704
	fontFile.size = read(fd, fontFile.buf, 27000);
    27e3:	a1 04 27 01 00       	mov    0x12704,%eax
    27e8:	c7 44 24 08 78 69 00 	movl   $0x6978,0x8(%esp)
    27ef:	00 
    27f0:	89 44 24 04          	mov    %eax,0x4(%esp)
    27f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27f7:	89 04 24             	mov    %eax,(%esp)
    27fa:	e8 73 22 00 00       	call   4a72 <read>
    27ff:	a3 08 27 01 00       	mov    %eax,0x12708
	printf(0,"initialzing gbk complete!\n");
    2804:	c7 44 24 04 3d b5 00 	movl   $0xb53d,0x4(%esp)
    280b:	00 
    280c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2813:	e8 32 24 00 00       	call   4c4a <printf>
	close(fd);
    2818:	8b 45 f4             	mov    -0xc(%ebp),%eax
    281b:	89 04 24             	mov    %eax,(%esp)
    281e:	e8 5f 22 00 00       	call   4a82 <close>
}
    2823:	c9                   	leave  
    2824:	c3                   	ret    

00002825 <freeGBK>:

void freeGBK(){
    2825:	55                   	push   %ebp
    2826:	89 e5                	mov    %esp,%ebp
    2828:	83 ec 18             	sub    $0x18,%esp
	free(fontFile.buf);
    282b:	a1 04 27 01 00       	mov    0x12704,%eax
    2830:	89 04 24             	mov    %eax,(%esp)
    2833:	e8 c5 25 00 00       	call   4dfd <free>
}
    2838:	c9                   	leave  
    2839:	c3                   	ret    

0000283a <put_ascii>:

void put_ascii(struct Context c, unsigned char ascii, unsigned short colorNum, int x, int y)
{
    283a:	55                   	push   %ebp
    283b:	89 e5                	mov    %esp,%ebp
    283d:	53                   	push   %ebx
    283e:	83 ec 30             	sub    $0x30,%esp
    2841:	8b 55 14             	mov    0x14(%ebp),%edx
    2844:	8b 45 18             	mov    0x18(%ebp),%eax
    2847:	88 55 e8             	mov    %dl,-0x18(%ebp)
    284a:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
	int tmpX, tmpY;
	//printf(0, "put ascii: %c, color: %d\n", ascii, colorNum);
	for(tmpY = y; tmpY < y + 16; tmpY++) {
    284e:	8b 45 20             	mov    0x20(%ebp),%eax
    2851:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2854:	eb 7f                	jmp    28d5 <put_ascii+0x9b>
		for(tmpX = 0; tmpX < 8; tmpX++) {
    2856:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    285d:	eb 6c                	jmp    28cb <put_ascii+0x91>
			if((((hankaku + (ascii * 16))[tmpY - y] << tmpX) & 0x80) == 0x80) {
    285f:	a1 00 27 01 00       	mov    0x12700,%eax
    2864:	0f b6 55 e8          	movzbl -0x18(%ebp),%edx
    2868:	c1 e2 04             	shl    $0x4,%edx
    286b:	89 d1                	mov    %edx,%ecx
    286d:	8b 55 20             	mov    0x20(%ebp),%edx
    2870:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    2873:	29 d3                	sub    %edx,%ebx
    2875:	89 da                	mov    %ebx,%edx
    2877:	01 ca                	add    %ecx,%edx
    2879:	01 d0                	add    %edx,%eax
    287b:	0f b6 00             	movzbl (%eax),%eax
    287e:	0f b6 d0             	movzbl %al,%edx
    2881:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2884:	89 c1                	mov    %eax,%ecx
    2886:	d3 e2                	shl    %cl,%edx
    2888:	89 d0                	mov    %edx,%eax
    288a:	25 80 00 00 00       	and    $0x80,%eax
    288f:	85 c0                	test   %eax,%eax
    2891:	74 34                	je     28c7 <put_ascii+0x8d>
				//printf(0, "x: %d, y: %d\n", x + tmpX, tmpY);
				draw_point(c, x + tmpX, tmpY, colorNum);
    2893:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
    2897:	8b 55 f4             	mov    -0xc(%ebp),%edx
    289a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    289d:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
    28a0:	01 d8                	add    %ebx,%eax
    28a2:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    28a6:	89 54 24 10          	mov    %edx,0x10(%esp)
    28aa:	89 44 24 0c          	mov    %eax,0xc(%esp)
    28ae:	8b 45 08             	mov    0x8(%ebp),%eax
    28b1:	89 04 24             	mov    %eax,(%esp)
    28b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    28b7:	89 44 24 04          	mov    %eax,0x4(%esp)
    28bb:	8b 45 10             	mov    0x10(%ebp),%eax
    28be:	89 44 24 08          	mov    %eax,0x8(%esp)
    28c2:	e8 b3 fa ff ff       	call   237a <draw_point>
void put_ascii(struct Context c, unsigned char ascii, unsigned short colorNum, int x, int y)
{
	int tmpX, tmpY;
	//printf(0, "put ascii: %c, color: %d\n", ascii, colorNum);
	for(tmpY = y; tmpY < y + 16; tmpY++) {
		for(tmpX = 0; tmpX < 8; tmpX++) {
    28c7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    28cb:	83 7d f8 07          	cmpl   $0x7,-0x8(%ebp)
    28cf:	7e 8e                	jle    285f <put_ascii+0x25>

void put_ascii(struct Context c, unsigned char ascii, unsigned short colorNum, int x, int y)
{
	int tmpX, tmpY;
	//printf(0, "put ascii: %c, color: %d\n", ascii, colorNum);
	for(tmpY = y; tmpY < y + 16; tmpY++) {
    28d1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    28d5:	8b 45 20             	mov    0x20(%ebp),%eax
    28d8:	83 c0 10             	add    $0x10,%eax
    28db:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    28de:	0f 8f 72 ff ff ff    	jg     2856 <put_ascii+0x1c>
				draw_point(c, x + tmpX, tmpY, colorNum);
				//sheet->buf[tmpY * sheet->width + x + tmpX] = colorNum;
			}
		}
	}
}
    28e4:	83 c4 30             	add    $0x30,%esp
    28e7:	5b                   	pop    %ebx
    28e8:	5d                   	pop    %ebp
    28e9:	c3                   	ret    

000028ea <put_gbk>:

void put_gbk(struct Context c, short gbk, unsigned short colorNum, int x, int y)
{
    28ea:	55                   	push   %ebp
    28eb:	89 e5                	mov    %esp,%ebp
    28ed:	53                   	push   %ebx
    28ee:	83 ec 34             	sub    $0x34,%esp
    28f1:	8b 55 14             	mov    0x14(%ebp),%edx
    28f4:	8b 45 18             	mov    0x18(%ebp),%eax
    28f7:	66 89 55 e8          	mov    %dx,-0x18(%ebp)
    28fb:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
	int tmpX, tmpY;
	unsigned int offset;
	unsigned char *hzk16Base;
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
    28ff:	0f bf 45 e8          	movswl -0x18(%ebp),%eax
    2903:	0f b6 c0             	movzbl %al,%eax
    2906:	3d a0 00 00 00       	cmp    $0xa0,%eax
    290b:	0f 8e 40 01 00 00    	jle    2a51 <put_gbk+0x167>
    2911:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
    2915:	66 c1 f8 08          	sar    $0x8,%ax
    2919:	98                   	cwtl   
    291a:	0f b6 c0             	movzbl %al,%eax
    291d:	3d a0 00 00 00       	cmp    $0xa0,%eax
    2922:	0f 8e 29 01 00 00    	jle    2a51 <put_gbk+0x167>
		hzk16Base = fontFile.buf;
    2928:	a1 04 27 01 00       	mov    0x12704,%eax
    292d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		offset = (((gbk & 0x00FF) - 0xa1) * 94 + (((gbk >> 8) & 0x00FF) - 0xa1)) * 32;
    2930:	0f bf 45 e8          	movswl -0x18(%ebp),%eax
    2934:	0f b6 c0             	movzbl %al,%eax
    2937:	2d a1 00 00 00       	sub    $0xa1,%eax
    293c:	6b c0 5e             	imul   $0x5e,%eax,%eax
    293f:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
    2943:	66 c1 fa 08          	sar    $0x8,%dx
    2947:	0f bf d2             	movswl %dx,%edx
    294a:	0f b6 d2             	movzbl %dl,%edx
    294d:	81 ea a1 00 00 00    	sub    $0xa1,%edx
    2953:	01 d0                	add    %edx,%eax
    2955:	c1 e0 05             	shl    $0x5,%eax
    2958:	89 45 f0             	mov    %eax,-0x10(%ebp)

		for(tmpY = y; tmpY < 16 + y; tmpY++) {
    295b:	8b 45 20             	mov    0x20(%ebp),%eax
    295e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2961:	e9 da 00 00 00       	jmp    2a40 <put_gbk+0x156>
			for(tmpX = 0; tmpX < 8; tmpX++) {
    2966:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    296d:	eb 58                	jmp    29c7 <put_gbk+0xdd>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
    296f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2972:	8b 55 ec             	mov    -0x14(%ebp),%edx
    2975:	01 d0                	add    %edx,%eax
    2977:	0f b6 00             	movzbl (%eax),%eax
    297a:	0f b6 d0             	movzbl %al,%edx
    297d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2980:	89 c1                	mov    %eax,%ecx
    2982:	d3 e2                	shl    %cl,%edx
    2984:	89 d0                	mov    %edx,%eax
    2986:	25 80 00 00 00       	and    $0x80,%eax
    298b:	85 c0                	test   %eax,%eax
    298d:	74 34                	je     29c3 <put_gbk+0xd9>
					draw_point(c, x + tmpX, tmpY, colorNum);
    298f:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
    2993:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2996:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2999:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
    299c:	01 d8                	add    %ebx,%eax
    299e:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    29a2:	89 54 24 10          	mov    %edx,0x10(%esp)
    29a6:	89 44 24 0c          	mov    %eax,0xc(%esp)
    29aa:	8b 45 08             	mov    0x8(%ebp),%eax
    29ad:	89 04 24             	mov    %eax,(%esp)
    29b0:	8b 45 0c             	mov    0xc(%ebp),%eax
    29b3:	89 44 24 04          	mov    %eax,0x4(%esp)
    29b7:	8b 45 10             	mov    0x10(%ebp),%eax
    29ba:	89 44 24 08          	mov    %eax,0x8(%esp)
    29be:	e8 b7 f9 ff ff       	call   237a <draw_point>
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
		hzk16Base = fontFile.buf;
		offset = (((gbk & 0x00FF) - 0xa1) * 94 + (((gbk >> 8) & 0x00FF) - 0xa1)) * 32;

		for(tmpY = y; tmpY < 16 + y; tmpY++) {
			for(tmpX = 0; tmpX < 8; tmpX++) {
    29c3:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    29c7:	83 7d f8 07          	cmpl   $0x7,-0x8(%ebp)
    29cb:	7e a2                	jle    296f <put_gbk+0x85>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
					draw_point(c, x + tmpX, tmpY, colorNum);
					//sheet->buf[tmpY * sheet->width + x + tmpX] = colorNum;
				}
			}
			offset++;
    29cd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
			for(tmpX = 0; tmpX < 8; tmpX++) {
    29d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    29d8:	eb 58                	jmp    2a32 <put_gbk+0x148>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
    29da:	8b 45 f0             	mov    -0x10(%ebp),%eax
    29dd:	8b 55 ec             	mov    -0x14(%ebp),%edx
    29e0:	01 d0                	add    %edx,%eax
    29e2:	0f b6 00             	movzbl (%eax),%eax
    29e5:	0f b6 d0             	movzbl %al,%edx
    29e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    29eb:	89 c1                	mov    %eax,%ecx
    29ed:	d3 e2                	shl    %cl,%edx
    29ef:	89 d0                	mov    %edx,%eax
    29f1:	25 80 00 00 00       	and    $0x80,%eax
    29f6:	85 c0                	test   %eax,%eax
    29f8:	74 34                	je     2a2e <put_gbk+0x144>
					draw_point(c, x + tmpX, tmpY, colorNum);
    29fa:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
    29fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2a01:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2a04:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
    2a07:	01 d8                	add    %ebx,%eax
    2a09:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2a0d:	89 54 24 10          	mov    %edx,0x10(%esp)
    2a11:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2a15:	8b 45 08             	mov    0x8(%ebp),%eax
    2a18:	89 04 24             	mov    %eax,(%esp)
    2a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a1e:	89 44 24 04          	mov    %eax,0x4(%esp)
    2a22:	8b 45 10             	mov    0x10(%ebp),%eax
    2a25:	89 44 24 08          	mov    %eax,0x8(%esp)
    2a29:	e8 4c f9 ff ff       	call   237a <draw_point>
					draw_point(c, x + tmpX, tmpY, colorNum);
					//sheet->buf[tmpY * sheet->width + x + tmpX] = colorNum;
				}
			}
			offset++;
			for(tmpX = 0; tmpX < 8; tmpX++) {
    2a2e:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    2a32:	83 7d f8 07          	cmpl   $0x7,-0x8(%ebp)
    2a36:	7e a2                	jle    29da <put_gbk+0xf0>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
					draw_point(c, x + tmpX, tmpY, colorNum);
					//sheet->buf[tmpY * sheet->width + x + tmpX + 8] = colorNum;
				}
			}
			offset++;
    2a38:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
	unsigned char *hzk16Base;
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
		hzk16Base = fontFile.buf;
		offset = (((gbk & 0x00FF) - 0xa1) * 94 + (((gbk >> 8) & 0x00FF) - 0xa1)) * 32;

		for(tmpY = y; tmpY < 16 + y; tmpY++) {
    2a3c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2a40:	8b 45 20             	mov    0x20(%ebp),%eax
    2a43:	83 c0 10             	add    $0x10,%eax
    2a46:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2a49:	0f 8f 17 ff ff ff    	jg     2966 <put_gbk+0x7c>
void put_gbk(struct Context c, short gbk, unsigned short colorNum, int x, int y)
{
	int tmpX, tmpY;
	unsigned int offset;
	unsigned char *hzk16Base;
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
    2a4f:	eb 7b                	jmp    2acc <put_gbk+0x1e2>
			}
			offset++;
		}
	}
	else {
		put_ascii(c, (gbk & 0x00FF), colorNum, x, y);
    2a51:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
    2a55:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
    2a59:	0f b6 c0             	movzbl %al,%eax
    2a5c:	8b 4d 20             	mov    0x20(%ebp),%ecx
    2a5f:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2a63:	8b 4d 1c             	mov    0x1c(%ebp),%ecx
    2a66:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2a6a:	89 54 24 10          	mov    %edx,0x10(%esp)
    2a6e:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2a72:	8b 45 08             	mov    0x8(%ebp),%eax
    2a75:	89 04 24             	mov    %eax,(%esp)
    2a78:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a7b:	89 44 24 04          	mov    %eax,0x4(%esp)
    2a7f:	8b 45 10             	mov    0x10(%ebp),%eax
    2a82:	89 44 24 08          	mov    %eax,0x8(%esp)
    2a86:	e8 af fd ff ff       	call   283a <put_ascii>
		put_ascii(c, ((gbk >> 8) & 0x00FF), colorNum, x + 8, y);
    2a8b:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2a8e:	8d 58 08             	lea    0x8(%eax),%ebx
    2a91:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
    2a95:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
    2a99:	66 c1 f8 08          	sar    $0x8,%ax
    2a9d:	0f b6 c0             	movzbl %al,%eax
    2aa0:	8b 4d 20             	mov    0x20(%ebp),%ecx
    2aa3:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2aa7:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    2aab:	89 54 24 10          	mov    %edx,0x10(%esp)
    2aaf:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2ab3:	8b 45 08             	mov    0x8(%ebp),%eax
    2ab6:	89 04 24             	mov    %eax,(%esp)
    2ab9:	8b 45 0c             	mov    0xc(%ebp),%eax
    2abc:	89 44 24 04          	mov    %eax,0x4(%esp)
    2ac0:	8b 45 10             	mov    0x10(%ebp),%eax
    2ac3:	89 44 24 08          	mov    %eax,0x8(%esp)
    2ac7:	e8 6e fd ff ff       	call   283a <put_ascii>
	}
}
    2acc:	83 c4 34             	add    $0x34,%esp
    2acf:	5b                   	pop    %ebx
    2ad0:	5d                   	pop    %ebp
    2ad1:	c3                   	ret    

00002ad2 <puts_str>:

void puts_str(struct Context c, char *str, unsigned short colorNum, int x, int y)
{
    2ad2:	55                   	push   %ebp
    2ad3:	89 e5                	mov    %esp,%ebp
    2ad5:	83 ec 38             	sub    $0x38,%esp
    2ad8:	8b 45 18             	mov    0x18(%ebp),%eax
    2adb:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
	//printf(0,"puts string : %s\n", str);
	int i = 0, xTmp;
    2adf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	short wStr;
	uint rowLetterCnt;

	rowLetterCnt = strlen(str);
    2ae6:	8b 45 14             	mov    0x14(%ebp),%eax
    2ae9:	89 04 24             	mov    %eax,(%esp)
    2aec:	e8 95 1d 00 00       	call   4886 <strlen>
    2af1:	89 45 ec             	mov    %eax,-0x14(%ebp)
	for(i = 0, xTmp = x; i < rowLetterCnt;) {
    2af4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2afb:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2afe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2b01:	eb 49                	jmp    2b4c <puts_str+0x7a>
		if(str[i] < 0xA1) {
			put_ascii(c, str[i], colorNum, xTmp, y);
    2b03:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
    2b07:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2b0a:	8b 45 14             	mov    0x14(%ebp),%eax
    2b0d:	01 c8                	add    %ecx,%eax
    2b0f:	0f b6 00             	movzbl (%eax),%eax
    2b12:	0f b6 c0             	movzbl %al,%eax
    2b15:	8b 4d 20             	mov    0x20(%ebp),%ecx
    2b18:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2b1c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    2b1f:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2b23:	89 54 24 10          	mov    %edx,0x10(%esp)
    2b27:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2b2b:	8b 45 08             	mov    0x8(%ebp),%eax
    2b2e:	89 04 24             	mov    %eax,(%esp)
    2b31:	8b 45 0c             	mov    0xc(%ebp),%eax
    2b34:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b38:	8b 45 10             	mov    0x10(%ebp),%eax
    2b3b:	89 44 24 08          	mov    %eax,0x8(%esp)
    2b3f:	e8 f6 fc ff ff       	call   283a <put_ascii>
			xTmp += 8;
    2b44:	83 45 f0 08          	addl   $0x8,-0x10(%ebp)
			i++;
    2b48:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	int i = 0, xTmp;
	short wStr;
	uint rowLetterCnt;

	rowLetterCnt = strlen(str);
	for(i = 0, xTmp = x; i < rowLetterCnt;) {
    2b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2b4f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2b52:	72 af                	jb     2b03 <puts_str+0x31>
			put_gbk(c, wStr, colorNum, xTmp, y);
			xTmp += 16;
			i += 2;
		}
	}
}
    2b54:	c9                   	leave  
    2b55:	c3                   	ret    

00002b56 <put_str>:

void put_str(struct Context c, char ch, unsigned short colorNum, int x, int y)
{
    2b56:	55                   	push   %ebp
    2b57:	89 e5                	mov    %esp,%ebp
    2b59:	83 ec 24             	sub    $0x24,%esp
    2b5c:	8b 55 14             	mov    0x14(%ebp),%edx
    2b5f:	8b 45 18             	mov    0x18(%ebp),%eax
    2b62:	88 55 fc             	mov    %dl,-0x4(%ebp)
    2b65:	66 89 45 f8          	mov    %ax,-0x8(%ebp)
	//printf(0,"puts string : %s\n", str);
	if(ch < 0xA1) {
		put_ascii(c, ch, colorNum, x, y);
    2b69:	0f b7 55 f8          	movzwl -0x8(%ebp),%edx
    2b6d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
    2b71:	0f b6 c0             	movzbl %al,%eax
    2b74:	8b 4d 20             	mov    0x20(%ebp),%ecx
    2b77:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2b7b:	8b 4d 1c             	mov    0x1c(%ebp),%ecx
    2b7e:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2b82:	89 54 24 10          	mov    %edx,0x10(%esp)
    2b86:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2b8a:	8b 45 08             	mov    0x8(%ebp),%eax
    2b8d:	89 04 24             	mov    %eax,(%esp)
    2b90:	8b 45 0c             	mov    0xc(%ebp),%eax
    2b93:	89 44 24 04          	mov    %eax,0x4(%esp)
    2b97:	8b 45 10             	mov    0x10(%ebp),%eax
    2b9a:	89 44 24 08          	mov    %eax,0x8(%esp)
    2b9e:	e8 97 fc ff ff       	call   283a <put_ascii>
	}
	else {
		put_gbk(c, ch, colorNum, x, y);		
	}	
}
    2ba3:	c9                   	leave  
    2ba4:	c3                   	ret    

00002ba5 <_RGB16BIT565>:

int _RGB16BIT565(int r,int g,int b){
    2ba5:	55                   	push   %ebp
    2ba6:	89 e5                	mov    %esp,%ebp
	return ((b / 8)+((g / 4)<<5)+((r / 8)<<11));
    2ba8:	8b 45 10             	mov    0x10(%ebp),%eax
    2bab:	8d 50 07             	lea    0x7(%eax),%edx
    2bae:	85 c0                	test   %eax,%eax
    2bb0:	0f 48 c2             	cmovs  %edx,%eax
    2bb3:	c1 f8 03             	sar    $0x3,%eax
    2bb6:	89 c2                	mov    %eax,%edx
    2bb8:	8b 45 0c             	mov    0xc(%ebp),%eax
    2bbb:	8d 48 03             	lea    0x3(%eax),%ecx
    2bbe:	85 c0                	test   %eax,%eax
    2bc0:	0f 48 c1             	cmovs  %ecx,%eax
    2bc3:	c1 f8 02             	sar    $0x2,%eax
    2bc6:	c1 e0 05             	shl    $0x5,%eax
    2bc9:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    2bcc:	8b 45 08             	mov    0x8(%ebp),%eax
    2bcf:	8d 50 07             	lea    0x7(%eax),%edx
    2bd2:	85 c0                	test   %eax,%eax
    2bd4:	0f 48 c2             	cmovs  %edx,%eax
    2bd7:	c1 f8 03             	sar    $0x3,%eax
    2bda:	c1 e0 0b             	shl    $0xb,%eax
    2bdd:	01 c8                	add    %ecx,%eax
}
    2bdf:	5d                   	pop    %ebp
    2be0:	c3                   	ret    

00002be1 <draw_picture>:

void draw_picture(Context c, PICNODE pic, int x, int y)
{
    2be1:	55                   	push   %ebp
    2be2:	89 e5                	mov    %esp,%ebp
    2be4:	53                   	push   %ebx
    2be5:	83 ec 28             	sub    $0x28,%esp
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
    2be8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    2bef:	e9 b1 00 00 00       	jmp    2ca5 <draw_picture+0xc4>
	{
		for (j = 0; j < pic.width; j++)
    2bf4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2bfb:	e9 95 00 00 00       	jmp    2c95 <draw_picture+0xb4>
		{
			rgb = pic.data[i*pic.width+j];
    2c00:	8b 55 14             	mov    0x14(%ebp),%edx
    2c03:	8b 45 18             	mov    0x18(%ebp),%eax
    2c06:	0f af 45 f8          	imul   -0x8(%ebp),%eax
    2c0a:	89 c1                	mov    %eax,%ecx
    2c0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2c0f:	01 c8                	add    %ecx,%eax
    2c11:	c1 e0 02             	shl    $0x2,%eax
    2c14:	01 d0                	add    %edx,%eax
    2c16:	8b 00                	mov    (%eax),%eax
    2c18:	89 45 ee             	mov    %eax,-0x12(%ebp)
			if (rgb.rgbReserved == 1) continue;
    2c1b:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
    2c1f:	3c 01                	cmp    $0x1,%al
    2c21:	75 02                	jne    2c25 <draw_picture+0x44>
    2c23:	eb 6c                	jmp    2c91 <draw_picture+0xb0>
			color = (unsigned short)_RGB16BIT565(rgb.rgbRed, rgb.rgbGreen, rgb.rgbBlue);
    2c25:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
    2c29:	0f b6 c8             	movzbl %al,%ecx
    2c2c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    2c30:	0f b6 d0             	movzbl %al,%edx
    2c33:	0f b6 45 f0          	movzbl -0x10(%ebp),%eax
    2c37:	0f b6 c0             	movzbl %al,%eax
    2c3a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    2c3e:	89 54 24 04          	mov    %edx,0x4(%esp)
    2c42:	89 04 24             	mov    %eax,(%esp)
    2c45:	e8 5b ff ff ff       	call   2ba5 <_RGB16BIT565>
    2c4a:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
			draw_point(c, j + x, pic.height - 1 - i + y, color);
    2c4e:	0f b7 4d f2          	movzwl -0xe(%ebp),%ecx
    2c52:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2c55:	83 e8 01             	sub    $0x1,%eax
    2c58:	2b 45 f8             	sub    -0x8(%ebp),%eax
    2c5b:	89 c2                	mov    %eax,%edx
    2c5d:	8b 45 24             	mov    0x24(%ebp),%eax
    2c60:	01 d0                	add    %edx,%eax
    2c62:	89 c2                	mov    %eax,%edx
    2c64:	8b 45 20             	mov    0x20(%ebp),%eax
    2c67:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    2c6a:	01 d8                	add    %ebx,%eax
    2c6c:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2c70:	89 54 24 10          	mov    %edx,0x10(%esp)
    2c74:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2c78:	8b 45 08             	mov    0x8(%ebp),%eax
    2c7b:	89 04 24             	mov    %eax,(%esp)
    2c7e:	8b 45 0c             	mov    0xc(%ebp),%eax
    2c81:	89 44 24 04          	mov    %eax,0x4(%esp)
    2c85:	8b 45 10             	mov    0x10(%ebp),%eax
    2c88:	89 44 24 08          	mov    %eax,0x8(%esp)
    2c8c:	e8 e9 f6 ff ff       	call   237a <draw_point>
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
	{
		for (j = 0; j < pic.width; j++)
    2c91:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2c95:	8b 45 18             	mov    0x18(%ebp),%eax
    2c98:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2c9b:	0f 8f 5f ff ff ff    	jg     2c00 <draw_picture+0x1f>
void draw_picture(Context c, PICNODE pic, int x, int y)
{
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
    2ca1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    2ca5:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2ca8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2cab:	0f 8f 43 ff ff ff    	jg     2bf4 <draw_picture+0x13>
			if (rgb.rgbReserved == 1) continue;
			color = (unsigned short)_RGB16BIT565(rgb.rgbRed, rgb.rgbGreen, rgb.rgbBlue);
			draw_point(c, j + x, pic.height - 1 - i + y, color);
		}
	}
}
    2cb1:	83 c4 28             	add    $0x28,%esp
    2cb4:	5b                   	pop    %ebx
    2cb5:	5d                   	pop    %ebp
    2cb6:	c3                   	ret    

00002cb7 <draw_line>:

void draw_line(Context c, int x0, int y0, int x1, int y1, unsigned short color)
{
    2cb7:	55                   	push   %ebp
    2cb8:	89 e5                	mov    %esp,%ebp
    2cba:	83 ec 3c             	sub    $0x3c,%esp
    2cbd:	8b 45 24             	mov    0x24(%ebp),%eax
    2cc0:	66 89 45 dc          	mov    %ax,-0x24(%ebp)
	int dx, dy, x, y, len, i;
	dx = x1 - x0;
    2cc4:	8b 45 14             	mov    0x14(%ebp),%eax
    2cc7:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2cca:	29 c2                	sub    %eax,%edx
    2ccc:	89 d0                	mov    %edx,%eax
    2cce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	dy = y1 - y0;
    2cd1:	8b 45 18             	mov    0x18(%ebp),%eax
    2cd4:	8b 55 20             	mov    0x20(%ebp),%edx
    2cd7:	29 c2                	sub    %eax,%edx
    2cd9:	89 d0                	mov    %edx,%eax
    2cdb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	x = x0 << 10;
    2cde:	8b 45 14             	mov    0x14(%ebp),%eax
    2ce1:	c1 e0 0a             	shl    $0xa,%eax
    2ce4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	y = y0 << 10;
    2ce7:	8b 45 18             	mov    0x18(%ebp),%eax
    2cea:	c1 e0 0a             	shl    $0xa,%eax
    2ced:	89 45 f0             	mov    %eax,-0x10(%ebp)
	dx = (dx < 0) ? -dx : dx;
    2cf0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2cf3:	c1 f8 1f             	sar    $0x1f,%eax
    2cf6:	31 45 fc             	xor    %eax,-0x4(%ebp)
    2cf9:	29 45 fc             	sub    %eax,-0x4(%ebp)
	dy = (dy < 0) ? -dy : dy;
    2cfc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2cff:	c1 f8 1f             	sar    $0x1f,%eax
    2d02:	31 45 f8             	xor    %eax,-0x8(%ebp)
    2d05:	29 45 f8             	sub    %eax,-0x8(%ebp)
	if(dx >= dy) {
    2d08:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2d0b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2d0e:	7c 57                	jl     2d67 <draw_line+0xb0>
		len = dx + 1;
    2d10:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2d13:	83 c0 01             	add    $0x1,%eax
    2d16:	89 45 ec             	mov    %eax,-0x14(%ebp)
		dx = (x1 > x0) ? 1024 : -1024;
    2d19:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2d1c:	3b 45 14             	cmp    0x14(%ebp),%eax
    2d1f:	7e 07                	jle    2d28 <draw_line+0x71>
    2d21:	b8 00 04 00 00       	mov    $0x400,%eax
    2d26:	eb 05                	jmp    2d2d <draw_line+0x76>
    2d28:	b8 00 fc ff ff       	mov    $0xfffffc00,%eax
    2d2d:	89 45 fc             	mov    %eax,-0x4(%ebp)
		dy = (y1 >= y0) ? (((y1 - y0 + 1) << 10) / len) : (((y1 - y0 - 1) << 10) / len);
    2d30:	8b 45 20             	mov    0x20(%ebp),%eax
    2d33:	3b 45 18             	cmp    0x18(%ebp),%eax
    2d36:	7c 16                	jl     2d4e <draw_line+0x97>
    2d38:	8b 45 18             	mov    0x18(%ebp),%eax
    2d3b:	8b 55 20             	mov    0x20(%ebp),%edx
    2d3e:	29 c2                	sub    %eax,%edx
    2d40:	89 d0                	mov    %edx,%eax
    2d42:	83 c0 01             	add    $0x1,%eax
    2d45:	c1 e0 0a             	shl    $0xa,%eax
    2d48:	99                   	cltd   
    2d49:	f7 7d ec             	idivl  -0x14(%ebp)
    2d4c:	eb 14                	jmp    2d62 <draw_line+0xab>
    2d4e:	8b 45 18             	mov    0x18(%ebp),%eax
    2d51:	8b 55 20             	mov    0x20(%ebp),%edx
    2d54:	29 c2                	sub    %eax,%edx
    2d56:	89 d0                	mov    %edx,%eax
    2d58:	83 e8 01             	sub    $0x1,%eax
    2d5b:	c1 e0 0a             	shl    $0xa,%eax
    2d5e:	99                   	cltd   
    2d5f:	f7 7d ec             	idivl  -0x14(%ebp)
    2d62:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2d65:	eb 55                	jmp    2dbc <draw_line+0x105>
	}
	else {
		len = dy + 1;
    2d67:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2d6a:	83 c0 01             	add    $0x1,%eax
    2d6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		dy = (y1 > y0) ? 1024 : -1024;
    2d70:	8b 45 20             	mov    0x20(%ebp),%eax
    2d73:	3b 45 18             	cmp    0x18(%ebp),%eax
    2d76:	7e 07                	jle    2d7f <draw_line+0xc8>
    2d78:	b8 00 04 00 00       	mov    $0x400,%eax
    2d7d:	eb 05                	jmp    2d84 <draw_line+0xcd>
    2d7f:	b8 00 fc ff ff       	mov    $0xfffffc00,%eax
    2d84:	89 45 f8             	mov    %eax,-0x8(%ebp)
		dx = (x1 >= x0) ? (((x1 - x0 + 1) << 10) / len) : (((x1 - x0 - 1) << 10) / len);
    2d87:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2d8a:	3b 45 14             	cmp    0x14(%ebp),%eax
    2d8d:	7c 16                	jl     2da5 <draw_line+0xee>
    2d8f:	8b 45 14             	mov    0x14(%ebp),%eax
    2d92:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2d95:	29 c2                	sub    %eax,%edx
    2d97:	89 d0                	mov    %edx,%eax
    2d99:	83 c0 01             	add    $0x1,%eax
    2d9c:	c1 e0 0a             	shl    $0xa,%eax
    2d9f:	99                   	cltd   
    2da0:	f7 7d ec             	idivl  -0x14(%ebp)
    2da3:	eb 14                	jmp    2db9 <draw_line+0x102>
    2da5:	8b 45 14             	mov    0x14(%ebp),%eax
    2da8:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2dab:	29 c2                	sub    %eax,%edx
    2dad:	89 d0                	mov    %edx,%eax
    2daf:	83 e8 01             	sub    $0x1,%eax
    2db2:	c1 e0 0a             	shl    $0xa,%eax
    2db5:	99                   	cltd   
    2db6:	f7 7d ec             	idivl  -0x14(%ebp)
    2db9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	}
	for(i = 0; i < len; i++) {
    2dbc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    2dc3:	eb 47                	jmp    2e0c <draw_line+0x155>
		//printf(0, "draw line point: x=%d, y=%d\n", (x >> 10), (y >> 10));
		draw_point(c, (x >> 10), (y >> 10), color);
    2dc5:	0f b7 4d dc          	movzwl -0x24(%ebp),%ecx
    2dc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2dcc:	c1 f8 0a             	sar    $0xa,%eax
    2dcf:	89 c2                	mov    %eax,%edx
    2dd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2dd4:	c1 f8 0a             	sar    $0xa,%eax
    2dd7:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2ddb:	89 54 24 10          	mov    %edx,0x10(%esp)
    2ddf:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2de3:	8b 45 08             	mov    0x8(%ebp),%eax
    2de6:	89 04 24             	mov    %eax,(%esp)
    2de9:	8b 45 0c             	mov    0xc(%ebp),%eax
    2dec:	89 44 24 04          	mov    %eax,0x4(%esp)
    2df0:	8b 45 10             	mov    0x10(%ebp),%eax
    2df3:	89 44 24 08          	mov    %eax,0x8(%esp)
    2df7:	e8 7e f5 ff ff       	call   237a <draw_point>
		y += dy;
    2dfc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2dff:	01 45 f0             	add    %eax,-0x10(%ebp)
		x += dx;
    2e02:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2e05:	01 45 f4             	add    %eax,-0xc(%ebp)
	else {
		len = dy + 1;
		dy = (y1 > y0) ? 1024 : -1024;
		dx = (x1 >= x0) ? (((x1 - x0 + 1) << 10) / len) : (((x1 - x0 - 1) << 10) / len);
	}
	for(i = 0; i < len; i++) {
    2e08:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    2e0c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2e0f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2e12:	7c b1                	jl     2dc5 <draw_line+0x10e>
		//printf(0, "draw line point: x=%d, y=%d\n", (x >> 10), (y >> 10));
		draw_point(c, (x >> 10), (y >> 10), color);
		y += dy;
		x += dx;
	}
}
    2e14:	c9                   	leave  
    2e15:	c3                   	ret    

00002e16 <draw_window>:

void
draw_window(Context c, char *title)
{
    2e16:	55                   	push   %ebp
    2e17:	89 e5                	mov    %esp,%ebp
    2e19:	83 ec 48             	sub    $0x48,%esp
  PICNODE pic, edge;
  draw_line(c, 0, 0, c.width - 1, 0, BORDERLINE_COLOR);
    2e1c:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e1f:	83 e8 01             	sub    $0x1,%eax
    2e22:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2e29:	00 
    2e2a:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    2e31:	00 
    2e32:	89 44 24 14          	mov    %eax,0x14(%esp)
    2e36:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    2e3d:	00 
    2e3e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    2e45:	00 
    2e46:	8b 45 08             	mov    0x8(%ebp),%eax
    2e49:	89 04 24             	mov    %eax,(%esp)
    2e4c:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e4f:	89 44 24 04          	mov    %eax,0x4(%esp)
    2e53:	8b 45 10             	mov    0x10(%ebp),%eax
    2e56:	89 44 24 08          	mov    %eax,0x8(%esp)
    2e5a:	e8 58 fe ff ff       	call   2cb7 <draw_line>
  draw_line(c, c.width - 1, 0, c.width - 1, c.height - 1, BORDERLINE_COLOR);
    2e5f:	8b 45 10             	mov    0x10(%ebp),%eax
    2e62:	8d 48 ff             	lea    -0x1(%eax),%ecx
    2e65:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e68:	8d 50 ff             	lea    -0x1(%eax),%edx
    2e6b:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e6e:	83 e8 01             	sub    $0x1,%eax
    2e71:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2e78:	00 
    2e79:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2e7d:	89 54 24 14          	mov    %edx,0x14(%esp)
    2e81:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    2e88:	00 
    2e89:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2e8d:	8b 45 08             	mov    0x8(%ebp),%eax
    2e90:	89 04 24             	mov    %eax,(%esp)
    2e93:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e96:	89 44 24 04          	mov    %eax,0x4(%esp)
    2e9a:	8b 45 10             	mov    0x10(%ebp),%eax
    2e9d:	89 44 24 08          	mov    %eax,0x8(%esp)
    2ea1:	e8 11 fe ff ff       	call   2cb7 <draw_line>
  draw_line(c, c.width - 1, c.height - 1, 0, c.height - 1, BORDERLINE_COLOR);
    2ea6:	8b 45 10             	mov    0x10(%ebp),%eax
    2ea9:	8d 48 ff             	lea    -0x1(%eax),%ecx
    2eac:	8b 45 10             	mov    0x10(%ebp),%eax
    2eaf:	8d 50 ff             	lea    -0x1(%eax),%edx
    2eb2:	8b 45 0c             	mov    0xc(%ebp),%eax
    2eb5:	83 e8 01             	sub    $0x1,%eax
    2eb8:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2ebf:	00 
    2ec0:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2ec4:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    2ecb:	00 
    2ecc:	89 54 24 10          	mov    %edx,0x10(%esp)
    2ed0:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2ed4:	8b 45 08             	mov    0x8(%ebp),%eax
    2ed7:	89 04 24             	mov    %eax,(%esp)
    2eda:	8b 45 0c             	mov    0xc(%ebp),%eax
    2edd:	89 44 24 04          	mov    %eax,0x4(%esp)
    2ee1:	8b 45 10             	mov    0x10(%ebp),%eax
    2ee4:	89 44 24 08          	mov    %eax,0x8(%esp)
    2ee8:	e8 ca fd ff ff       	call   2cb7 <draw_line>
  draw_line(c, 0, c.height - 1, 0, 0, BORDERLINE_COLOR);
    2eed:	8b 45 10             	mov    0x10(%ebp),%eax
    2ef0:	83 e8 01             	sub    $0x1,%eax
    2ef3:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2efa:	00 
    2efb:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    2f02:	00 
    2f03:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    2f0a:	00 
    2f0b:	89 44 24 10          	mov    %eax,0x10(%esp)
    2f0f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    2f16:	00 
    2f17:	8b 45 08             	mov    0x8(%ebp),%eax
    2f1a:	89 04 24             	mov    %eax,(%esp)
    2f1d:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f20:	89 44 24 04          	mov    %eax,0x4(%esp)
    2f24:	8b 45 10             	mov    0x10(%ebp),%eax
    2f27:	89 44 24 08          	mov    %eax,0x8(%esp)
    2f2b:	e8 87 fd ff ff       	call   2cb7 <draw_line>
  loadBitmap(&pic, "close.bmp");
    2f30:	c7 44 24 04 58 b5 00 	movl   $0xb558,0x4(%esp)
    2f37:	00 
    2f38:	8d 45 ec             	lea    -0x14(%ebp),%eax
    2f3b:	89 04 24             	mov    %eax,(%esp)
    2f3e:	e8 7f 04 00 00       	call   33c2 <loadBitmap>
  loadBitmap(&edge, "bar2.bmp");
    2f43:	c7 44 24 04 62 b5 00 	movl   $0xb562,0x4(%esp)
    2f4a:	00 
    2f4b:	8d 45 e0             	lea    -0x20(%ebp),%eax
    2f4e:	89 04 24             	mov    %eax,(%esp)
    2f51:	e8 6c 04 00 00       	call   33c2 <loadBitmap>
  draw_picture(c, edge, 0, 0);
    2f56:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2f5d:	00 
    2f5e:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    2f65:	00 
    2f66:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2f69:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2f6d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2f70:	89 44 24 10          	mov    %eax,0x10(%esp)
    2f74:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2f77:	89 44 24 14          	mov    %eax,0x14(%esp)
    2f7b:	8b 45 08             	mov    0x8(%ebp),%eax
    2f7e:	89 04 24             	mov    %eax,(%esp)
    2f81:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f84:	89 44 24 04          	mov    %eax,0x4(%esp)
    2f88:	8b 45 10             	mov    0x10(%ebp),%eax
    2f8b:	89 44 24 08          	mov    %eax,0x8(%esp)
    2f8f:	e8 4d fc ff ff       	call   2be1 <draw_picture>
  draw_picture(c, edge, 0, c.height - 20);
    2f94:	8b 45 10             	mov    0x10(%ebp),%eax
    2f97:	83 e8 14             	sub    $0x14,%eax
    2f9a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    2f9e:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    2fa5:	00 
    2fa6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2fa9:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2fad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2fb0:	89 44 24 10          	mov    %eax,0x10(%esp)
    2fb4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2fb7:	89 44 24 14          	mov    %eax,0x14(%esp)
    2fbb:	8b 45 08             	mov    0x8(%ebp),%eax
    2fbe:	89 04 24             	mov    %eax,(%esp)
    2fc1:	8b 45 0c             	mov    0xc(%ebp),%eax
    2fc4:	89 44 24 04          	mov    %eax,0x4(%esp)
    2fc8:	8b 45 10             	mov    0x10(%ebp),%eax
    2fcb:	89 44 24 08          	mov    %eax,0x8(%esp)
    2fcf:	e8 0d fc ff ff       	call   2be1 <draw_picture>
  draw_picture(c, pic, 3, 0);
    2fd4:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2fdb:	00 
    2fdc:	c7 44 24 18 03 00 00 	movl   $0x3,0x18(%esp)
    2fe3:	00 
    2fe4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2fe7:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2feb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2fee:	89 44 24 10          	mov    %eax,0x10(%esp)
    2ff2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2ff5:	89 44 24 14          	mov    %eax,0x14(%esp)
    2ff9:	8b 45 08             	mov    0x8(%ebp),%eax
    2ffc:	89 04 24             	mov    %eax,(%esp)
    2fff:	8b 45 0c             	mov    0xc(%ebp),%eax
    3002:	89 44 24 04          	mov    %eax,0x4(%esp)
    3006:	8b 45 10             	mov    0x10(%ebp),%eax
    3009:	89 44 24 08          	mov    %eax,0x8(%esp)
    300d:	e8 cf fb ff ff       	call   2be1 <draw_picture>
  puts_str(c, title, TITLE_COLOR, TITLE_OFFSET_X, TITLE_OFFSET_Y);
    3012:	c7 44 24 18 02 00 00 	movl   $0x2,0x18(%esp)
    3019:	00 
    301a:	c7 44 24 14 19 00 00 	movl   $0x19,0x14(%esp)
    3021:	00 
    3022:	c7 44 24 10 ff ff 00 	movl   $0xffff,0x10(%esp)
    3029:	00 
    302a:	8b 45 14             	mov    0x14(%ebp),%eax
    302d:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3031:	8b 45 08             	mov    0x8(%ebp),%eax
    3034:	89 04 24             	mov    %eax,(%esp)
    3037:	8b 45 0c             	mov    0xc(%ebp),%eax
    303a:	89 44 24 04          	mov    %eax,0x4(%esp)
    303e:	8b 45 10             	mov    0x10(%ebp),%eax
    3041:	89 44 24 08          	mov    %eax,0x8(%esp)
    3045:	e8 88 fa ff ff       	call   2ad2 <puts_str>
  freepic(&pic);
    304a:	8d 45 ec             	lea    -0x14(%ebp),%eax
    304d:	89 04 24             	mov    %eax,(%esp)
    3050:	e8 19 09 00 00       	call   396e <freepic>
  freepic(&edge);
    3055:	8d 45 e0             	lea    -0x20(%ebp),%eax
    3058:	89 04 24             	mov    %eax,(%esp)
    305b:	e8 0e 09 00 00       	call   396e <freepic>
}
    3060:	c9                   	leave  
    3061:	c3                   	ret    

00003062 <draw_window2>:

void
draw_window2(Context c, char *title, int len, unsigned short color)
{
    3062:	55                   	push   %ebp
    3063:	89 e5                	mov    %esp,%ebp
    3065:	53                   	push   %ebx
    3066:	83 ec 44             	sub    $0x44,%esp
    3069:	8b 45 1c             	mov    0x1c(%ebp),%eax
    306c:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  PICNODE pic;
  draw_line(c, 0, 0, c.width - 1, 0, BORDERLINE_COLOR);
    3070:	8b 45 0c             	mov    0xc(%ebp),%eax
    3073:	83 e8 01             	sub    $0x1,%eax
    3076:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    307d:	00 
    307e:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    3085:	00 
    3086:	89 44 24 14          	mov    %eax,0x14(%esp)
    308a:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    3091:	00 
    3092:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    3099:	00 
    309a:	8b 45 08             	mov    0x8(%ebp),%eax
    309d:	89 04 24             	mov    %eax,(%esp)
    30a0:	8b 45 0c             	mov    0xc(%ebp),%eax
    30a3:	89 44 24 04          	mov    %eax,0x4(%esp)
    30a7:	8b 45 10             	mov    0x10(%ebp),%eax
    30aa:	89 44 24 08          	mov    %eax,0x8(%esp)
    30ae:	e8 04 fc ff ff       	call   2cb7 <draw_line>
  draw_line(c, c.width - 1, 0, c.width - 1, c.height - 1, BORDERLINE_COLOR);
    30b3:	8b 45 10             	mov    0x10(%ebp),%eax
    30b6:	8d 48 ff             	lea    -0x1(%eax),%ecx
    30b9:	8b 45 0c             	mov    0xc(%ebp),%eax
    30bc:	8d 50 ff             	lea    -0x1(%eax),%edx
    30bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    30c2:	83 e8 01             	sub    $0x1,%eax
    30c5:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    30cc:	00 
    30cd:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    30d1:	89 54 24 14          	mov    %edx,0x14(%esp)
    30d5:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    30dc:	00 
    30dd:	89 44 24 0c          	mov    %eax,0xc(%esp)
    30e1:	8b 45 08             	mov    0x8(%ebp),%eax
    30e4:	89 04 24             	mov    %eax,(%esp)
    30e7:	8b 45 0c             	mov    0xc(%ebp),%eax
    30ea:	89 44 24 04          	mov    %eax,0x4(%esp)
    30ee:	8b 45 10             	mov    0x10(%ebp),%eax
    30f1:	89 44 24 08          	mov    %eax,0x8(%esp)
    30f5:	e8 bd fb ff ff       	call   2cb7 <draw_line>
  draw_line(c, c.width - 1, c.height - 1, 0, c.height - 1, BORDERLINE_COLOR);
    30fa:	8b 45 10             	mov    0x10(%ebp),%eax
    30fd:	8d 48 ff             	lea    -0x1(%eax),%ecx
    3100:	8b 45 10             	mov    0x10(%ebp),%eax
    3103:	8d 50 ff             	lea    -0x1(%eax),%edx
    3106:	8b 45 0c             	mov    0xc(%ebp),%eax
    3109:	83 e8 01             	sub    $0x1,%eax
    310c:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    3113:	00 
    3114:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    3118:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    311f:	00 
    3120:	89 54 24 10          	mov    %edx,0x10(%esp)
    3124:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3128:	8b 45 08             	mov    0x8(%ebp),%eax
    312b:	89 04 24             	mov    %eax,(%esp)
    312e:	8b 45 0c             	mov    0xc(%ebp),%eax
    3131:	89 44 24 04          	mov    %eax,0x4(%esp)
    3135:	8b 45 10             	mov    0x10(%ebp),%eax
    3138:	89 44 24 08          	mov    %eax,0x8(%esp)
    313c:	e8 76 fb ff ff       	call   2cb7 <draw_line>
  draw_line(c, 0, c.height - 1, 0, 0, BORDERLINE_COLOR);
    3141:	8b 45 10             	mov    0x10(%ebp),%eax
    3144:	83 e8 01             	sub    $0x1,%eax
    3147:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    314e:	00 
    314f:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    3156:	00 
    3157:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    315e:	00 
    315f:	89 44 24 10          	mov    %eax,0x10(%esp)
    3163:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    316a:	00 
    316b:	8b 45 08             	mov    0x8(%ebp),%eax
    316e:	89 04 24             	mov    %eax,(%esp)
    3171:	8b 45 0c             	mov    0xc(%ebp),%eax
    3174:	89 44 24 04          	mov    %eax,0x4(%esp)
    3178:	8b 45 10             	mov    0x10(%ebp),%eax
    317b:	89 44 24 08          	mov    %eax,0x8(%esp)
    317f:	e8 33 fb ff ff       	call   2cb7 <draw_line>
  fill_rect(c, 1, 1, len * 8, BOTTOMBAR_HEIGHT, color);
    3184:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
    3188:	8b 45 18             	mov    0x18(%ebp),%eax
    318b:	c1 e0 03             	shl    $0x3,%eax
    318e:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    3192:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    3199:	00 
    319a:	89 44 24 14          	mov    %eax,0x14(%esp)
    319e:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
    31a5:	00 
    31a6:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    31ad:	00 
    31ae:	8b 45 08             	mov    0x8(%ebp),%eax
    31b1:	89 04 24             	mov    %eax,(%esp)
    31b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    31b7:	89 44 24 04          	mov    %eax,0x4(%esp)
    31bb:	8b 45 10             	mov    0x10(%ebp),%eax
    31be:	89 44 24 08          	mov    %eax,0x8(%esp)
    31c2:	e8 f2 f1 ff ff       	call   23b9 <fill_rect>
  fill_rect(c, 1 + len * 8, 1, c.width - 2 - len * 8, BOTTOMBAR_HEIGHT, color);
    31c7:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
    31cb:	8b 45 0c             	mov    0xc(%ebp),%eax
    31ce:	8d 58 fe             	lea    -0x2(%eax),%ebx
    31d1:	8b 55 18             	mov    0x18(%ebp),%edx
    31d4:	b8 00 00 00 00       	mov    $0x0,%eax
    31d9:	29 d0                	sub    %edx,%eax
    31db:	c1 e0 03             	shl    $0x3,%eax
    31de:	01 d8                	add    %ebx,%eax
    31e0:	89 c2                	mov    %eax,%edx
    31e2:	8b 45 18             	mov    0x18(%ebp),%eax
    31e5:	c1 e0 03             	shl    $0x3,%eax
    31e8:	83 c0 01             	add    $0x1,%eax
    31eb:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    31ef:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    31f6:	00 
    31f7:	89 54 24 14          	mov    %edx,0x14(%esp)
    31fb:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
    3202:	00 
    3203:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3207:	8b 45 08             	mov    0x8(%ebp),%eax
    320a:	89 04 24             	mov    %eax,(%esp)
    320d:	8b 45 0c             	mov    0xc(%ebp),%eax
    3210:	89 44 24 04          	mov    %eax,0x4(%esp)
    3214:	8b 45 10             	mov    0x10(%ebp),%eax
    3217:	89 44 24 08          	mov    %eax,0x8(%esp)
    321b:	e8 99 f1 ff ff       	call   23b9 <fill_rect>
  fill_rect(c, 1, c.height - 1 - BOTTOMBAR_HEIGHT, c.width - 2, BOTTOMBAR_HEIGHT, color);
    3220:	0f b7 4d e4          	movzwl -0x1c(%ebp),%ecx
    3224:	8b 45 0c             	mov    0xc(%ebp),%eax
    3227:	83 e8 02             	sub    $0x2,%eax
    322a:	89 c2                	mov    %eax,%edx
    322c:	8b 45 10             	mov    0x10(%ebp),%eax
    322f:	83 e8 15             	sub    $0x15,%eax
    3232:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    3236:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    323d:	00 
    323e:	89 54 24 14          	mov    %edx,0x14(%esp)
    3242:	89 44 24 10          	mov    %eax,0x10(%esp)
    3246:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    324d:	00 
    324e:	8b 45 08             	mov    0x8(%ebp),%eax
    3251:	89 04 24             	mov    %eax,(%esp)
    3254:	8b 45 0c             	mov    0xc(%ebp),%eax
    3257:	89 44 24 04          	mov    %eax,0x4(%esp)
    325b:	8b 45 10             	mov    0x10(%ebp),%eax
    325e:	89 44 24 08          	mov    %eax,0x8(%esp)
    3262:	e8 52 f1 ff ff       	call   23b9 <fill_rect>

  loadBitmap(&pic, "close.bmp");
    3267:	c7 44 24 04 58 b5 00 	movl   $0xb558,0x4(%esp)
    326e:	00 
    326f:	8d 45 ec             	lea    -0x14(%ebp),%eax
    3272:	89 04 24             	mov    %eax,(%esp)
    3275:	e8 48 01 00 00       	call   33c2 <loadBitmap>
  draw_picture(c, pic, 3, 3);
    327a:	c7 44 24 1c 03 00 00 	movl   $0x3,0x1c(%esp)
    3281:	00 
    3282:	c7 44 24 18 03 00 00 	movl   $0x3,0x18(%esp)
    3289:	00 
    328a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    328d:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3291:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3294:	89 44 24 10          	mov    %eax,0x10(%esp)
    3298:	8b 45 f4             	mov    -0xc(%ebp),%eax
    329b:	89 44 24 14          	mov    %eax,0x14(%esp)
    329f:	8b 45 08             	mov    0x8(%ebp),%eax
    32a2:	89 04 24             	mov    %eax,(%esp)
    32a5:	8b 45 0c             	mov    0xc(%ebp),%eax
    32a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    32ac:	8b 45 10             	mov    0x10(%ebp),%eax
    32af:	89 44 24 08          	mov    %eax,0x8(%esp)
    32b3:	e8 29 f9 ff ff       	call   2be1 <draw_picture>
  puts_str(c, title, TITLE_COLOR, TITLE_OFFSET_X, TITLE_OFFSET_Y);
    32b8:	c7 44 24 18 02 00 00 	movl   $0x2,0x18(%esp)
    32bf:	00 
    32c0:	c7 44 24 14 19 00 00 	movl   $0x19,0x14(%esp)
    32c7:	00 
    32c8:	c7 44 24 10 ff ff 00 	movl   $0xffff,0x10(%esp)
    32cf:	00 
    32d0:	8b 45 14             	mov    0x14(%ebp),%eax
    32d3:	89 44 24 0c          	mov    %eax,0xc(%esp)
    32d7:	8b 45 08             	mov    0x8(%ebp),%eax
    32da:	89 04 24             	mov    %eax,(%esp)
    32dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    32e0:	89 44 24 04          	mov    %eax,0x4(%esp)
    32e4:	8b 45 10             	mov    0x10(%ebp),%eax
    32e7:	89 44 24 08          	mov    %eax,0x8(%esp)
    32eb:	e8 e2 f7 ff ff       	call   2ad2 <puts_str>
  freepic(&pic);
    32f0:	8d 45 ec             	lea    -0x14(%ebp),%eax
    32f3:	89 04 24             	mov    %eax,(%esp)
    32f6:	e8 73 06 00 00       	call   396e <freepic>
}
    32fb:	83 c4 44             	add    $0x44,%esp
    32fe:	5b                   	pop    %ebx
    32ff:	5d                   	pop    %ebp
    3300:	c3                   	ret    

00003301 <load_iconlist>:

void load_iconlist(ICON* iconlist, int len)
{
    3301:	55                   	push   %ebp
    3302:	89 e5                	mov    %esp,%ebp
    3304:	83 ec 28             	sub    $0x28,%esp
	int i;
	for (i = 0; i < len; i++)
    3307:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    330e:	eb 29                	jmp    3339 <load_iconlist+0x38>
	{
	    loadBitmap(&(iconlist[i].pic), iconlist[i].name);
    3310:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3313:	6b d0 34             	imul   $0x34,%eax,%edx
    3316:	8b 45 08             	mov    0x8(%ebp),%eax
    3319:	01 d0                	add    %edx,%eax
    331b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    331e:	6b ca 34             	imul   $0x34,%edx,%ecx
    3321:	8b 55 08             	mov    0x8(%ebp),%edx
    3324:	01 ca                	add    %ecx,%edx
    3326:	83 c2 28             	add    $0x28,%edx
    3329:	89 44 24 04          	mov    %eax,0x4(%esp)
    332d:	89 14 24             	mov    %edx,(%esp)
    3330:	e8 8d 00 00 00       	call   33c2 <loadBitmap>
}

void load_iconlist(ICON* iconlist, int len)
{
	int i;
	for (i = 0; i < len; i++)
    3335:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3339:	8b 45 f4             	mov    -0xc(%ebp),%eax
    333c:	3b 45 0c             	cmp    0xc(%ebp),%eax
    333f:	7c cf                	jl     3310 <load_iconlist+0xf>
	{
	    loadBitmap(&(iconlist[i].pic), iconlist[i].name);
	}
}
    3341:	c9                   	leave  
    3342:	c3                   	ret    

00003343 <draw_iconlist>:
void draw_iconlist(Context c, ICON* iconlist, int len)
{
    3343:	55                   	push   %ebp
    3344:	89 e5                	mov    %esp,%ebp
    3346:	53                   	push   %ebx
    3347:	83 ec 30             	sub    $0x30,%esp
    int i;
    for (i = 0; i < len; i++)
    334a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    3351:	eb 61                	jmp    33b4 <draw_iconlist+0x71>
    {
        draw_picture(c, iconlist[i].pic, iconlist[i].position_x, iconlist[i].position_y);
    3353:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3356:	6b d0 34             	imul   $0x34,%eax,%edx
    3359:	8b 45 14             	mov    0x14(%ebp),%eax
    335c:	01 d0                	add    %edx,%eax
    335e:	8b 48 24             	mov    0x24(%eax),%ecx
    3361:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3364:	6b d0 34             	imul   $0x34,%eax,%edx
    3367:	8b 45 14             	mov    0x14(%ebp),%eax
    336a:	01 d0                	add    %edx,%eax
    336c:	8b 50 20             	mov    0x20(%eax),%edx
    336f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3372:	6b d8 34             	imul   $0x34,%eax,%ebx
    3375:	8b 45 14             	mov    0x14(%ebp),%eax
    3378:	01 d8                	add    %ebx,%eax
    337a:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    337e:	89 54 24 18          	mov    %edx,0x18(%esp)
    3382:	8b 50 28             	mov    0x28(%eax),%edx
    3385:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3389:	8b 50 2c             	mov    0x2c(%eax),%edx
    338c:	89 54 24 10          	mov    %edx,0x10(%esp)
    3390:	8b 40 30             	mov    0x30(%eax),%eax
    3393:	89 44 24 14          	mov    %eax,0x14(%esp)
    3397:	8b 45 08             	mov    0x8(%ebp),%eax
    339a:	89 04 24             	mov    %eax,(%esp)
    339d:	8b 45 0c             	mov    0xc(%ebp),%eax
    33a0:	89 44 24 04          	mov    %eax,0x4(%esp)
    33a4:	8b 45 10             	mov    0x10(%ebp),%eax
    33a7:	89 44 24 08          	mov    %eax,0x8(%esp)
    33ab:	e8 31 f8 ff ff       	call   2be1 <draw_picture>
	}
}
void draw_iconlist(Context c, ICON* iconlist, int len)
{
    int i;
    for (i = 0; i < len; i++)
    33b0:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    33b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    33b7:	3b 45 18             	cmp    0x18(%ebp),%eax
    33ba:	7c 97                	jl     3353 <draw_iconlist+0x10>
    {
        draw_picture(c, iconlist[i].pic, iconlist[i].position_x, iconlist[i].position_y);
    }
}
    33bc:	83 c4 30             	add    $0x30,%esp
    33bf:	5b                   	pop    %ebx
    33c0:	5d                   	pop    %ebp
    33c1:	c3                   	ret    

000033c2 <loadBitmap>:
#include "clickable.h"

void showRgbQuan(RGBQUAD* pRGB);
void showBmpHead(BITMAPFILEHEADER* pBmpHead);
void showBmpInforHead(BITMAPINFOHEADER* pBmpInforHead);
void loadBitmap(PICNODE *pic, char pic_name[]) {
    33c2:	55                   	push   %ebp
    33c3:	89 e5                	mov    %esp,%ebp
    33c5:	81 ec a8 00 00 00    	sub    $0xa8,%esp
	BITMAPFILEHEADER bitHead;
	BITMAPINFOHEADER bitInfoHead;
	char *BmpFileHeader;
	WORD *temp_WORD;
	DWORD *temp_DWORD;
	int fd, n, i, j, k, index = 0;
    33cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int width;
	int height;

	if ((fd = open(pic_name, 0)) < 0) {
    33d2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    33d9:	00 
    33da:	8b 45 0c             	mov    0xc(%ebp),%eax
    33dd:	89 04 24             	mov    %eax,(%esp)
    33e0:	e8 b5 16 00 00       	call   4a9a <open>
    33e5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    33e8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    33ec:	79 20                	jns    340e <loadBitmap+0x4c>
		printf(0, "cannot open %s\n", pic_name);
    33ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    33f1:	89 44 24 08          	mov    %eax,0x8(%esp)
    33f5:	c7 44 24 04 6c b5 00 	movl   $0xb56c,0x4(%esp)
    33fc:	00 
    33fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3404:	e8 41 18 00 00       	call   4c4a <printf>
		return;
    3409:	e9 ef 02 00 00       	jmp    36fd <loadBitmap+0x33b>
	}
	printf(0, "reading bitmap: %s\n", pic_name);
    340e:	8b 45 0c             	mov    0xc(%ebp),%eax
    3411:	89 44 24 08          	mov    %eax,0x8(%esp)
    3415:	c7 44 24 04 7c b5 00 	movl   $0xb57c,0x4(%esp)
    341c:	00 
    341d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3424:	e8 21 18 00 00       	call   4c4a <printf>
	//pfile = fopen(strFile,"rb");//打开文件
	BmpFileHeader = (char *) malloc(14 * sizeof(char));
    3429:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
    3430:	e8 01 1b 00 00       	call   4f36 <malloc>
    3435:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//printf(0, "file bmp open success.\n");
	//读取位图文件头信息
	//printf(0, "reading BmpFileHeader.\n");
	n = read(fd, BmpFileHeader, 14);
    3438:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
    343f:	00 
    3440:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3443:	89 44 24 04          	mov    %eax,0x4(%esp)
    3447:	8b 45 e8             	mov    -0x18(%ebp),%eax
    344a:	89 04 24             	mov    %eax,(%esp)
    344d:	e8 20 16 00 00       	call   4a72 <read>
    3452:	89 45 e0             	mov    %eax,-0x20(%ebp)
	//fread(BmpFileHeader,1,14,pfile);
	temp_WORD = (WORD*) (BmpFileHeader);
    3455:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3458:	89 45 dc             	mov    %eax,-0x24(%ebp)
	bitHead.bfType = *temp_WORD;
    345b:	8b 45 dc             	mov    -0x24(%ebp),%eax
    345e:	0f b7 00             	movzwl (%eax),%eax
    3461:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
	if (bitHead.bfType != 0x4d42) {
    3465:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    3469:	66 3d 42 4d          	cmp    $0x4d42,%ax
    346d:	74 19                	je     3488 <loadBitmap+0xc6>
		printf(0, "file is not .bmp file!");
    346f:	c7 44 24 04 90 b5 00 	movl   $0xb590,0x4(%esp)
    3476:	00 
    3477:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    347e:	e8 c7 17 00 00       	call   4c4a <printf>
		return;
    3483:	e9 75 02 00 00       	jmp    36fd <loadBitmap+0x33b>
	}
	temp_DWORD = (DWORD *) (BmpFileHeader + sizeof(bitHead.bfType));
    3488:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    348b:	83 c0 02             	add    $0x2,%eax
    348e:	89 45 d8             	mov    %eax,-0x28(%ebp)
	bitHead.bfSize = *temp_DWORD;
    3491:	8b 45 d8             	mov    -0x28(%ebp),%eax
    3494:	8b 00                	mov    (%eax),%eax
    3496:	89 45 b0             	mov    %eax,-0x50(%ebp)
	temp_WORD = (WORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    3499:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    349c:	83 c0 06             	add    $0x6,%eax
    349f:	89 45 dc             	mov    %eax,-0x24(%ebp)
			+ sizeof(bitHead.bfSize));
	bitHead.bfReserved1 = *temp_WORD;
    34a2:	8b 45 dc             	mov    -0x24(%ebp),%eax
    34a5:	0f b7 00             	movzwl (%eax),%eax
    34a8:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
	temp_WORD = (WORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    34ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    34af:	83 c0 08             	add    $0x8,%eax
    34b2:	89 45 dc             	mov    %eax,-0x24(%ebp)
			+ sizeof(bitHead.bfSize) + sizeof(bitHead.bfReserved1));
	bitHead.bfReserved2 = *temp_WORD;
    34b5:	8b 45 dc             	mov    -0x24(%ebp),%eax
    34b8:	0f b7 00             	movzwl (%eax),%eax
    34bb:	66 89 45 b6          	mov    %ax,-0x4a(%ebp)
	temp_DWORD = (DWORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    34bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    34c2:	83 c0 0a             	add    $0xa,%eax
    34c5:	89 45 d8             	mov    %eax,-0x28(%ebp)
			+ sizeof(bitHead.bfSize) + sizeof(bitHead.bfReserved1)
			+ sizeof(bitHead.bfReserved2));
	bitHead.bfOffBits = *temp_DWORD;
    34c8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    34cb:	8b 00                	mov    (%eax),%eax
    34cd:	89 45 b8             	mov    %eax,-0x48(%ebp)
	//printf(0, "reading BmpFileHeader success!\n");
	//showBmpHead(&bitHead);
	//printf(0, "\n\n");
//
//	//读取位图信息头信息
	read(fd, &bitInfoHead, sizeof(BITMAPINFOHEADER));
    34d0:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    34d7:	00 
    34d8:	8d 45 84             	lea    -0x7c(%ebp),%eax
    34db:	89 44 24 04          	mov    %eax,0x4(%esp)
    34df:	8b 45 e8             	mov    -0x18(%ebp),%eax
    34e2:	89 04 24             	mov    %eax,(%esp)
    34e5:	e8 88 15 00 00       	call   4a72 <read>
	width = bitInfoHead.biWidth;
    34ea:	8b 45 88             	mov    -0x78(%ebp),%eax
    34ed:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	height = bitInfoHead.biHeight;
    34f0:	8b 45 8c             	mov    -0x74(%ebp),%eax
    34f3:	89 45 d0             	mov    %eax,-0x30(%ebp)
	printf(0, "bmp width: %d, height: %d, size: %d\n", width, height,
			width * height * sizeof(RGBQUAD));
    34f6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    34f9:	0f af 45 d0          	imul   -0x30(%ebp),%eax
//
//	//读取位图信息头信息
	read(fd, &bitInfoHead, sizeof(BITMAPINFOHEADER));
	width = bitInfoHead.biWidth;
	height = bitInfoHead.biHeight;
	printf(0, "bmp width: %d, height: %d, size: %d\n", width, height,
    34fd:	c1 e0 02             	shl    $0x2,%eax
    3500:	89 44 24 10          	mov    %eax,0x10(%esp)
    3504:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3507:	89 44 24 0c          	mov    %eax,0xc(%esp)
    350b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    350e:	89 44 24 08          	mov    %eax,0x8(%esp)
    3512:	c7 44 24 04 a8 b5 00 	movl   $0xb5a8,0x4(%esp)
    3519:	00 
    351a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3521:	e8 24 17 00 00       	call   4c4a <printf>
			width * height * sizeof(RGBQUAD));
	//fread(&bitInfoHead,1,sizeof(BITMAPINFOHEADER),pfile);
	//showBmpInforHead(&bitInfoHead);
	//printf(0, "\n");
	if (n == 0) {
    3526:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    352a:	75 14                	jne    3540 <loadBitmap+0x17e>
		printf(0, "0");
    352c:	c7 44 24 04 cd b5 00 	movl   $0xb5cd,0x4(%esp)
    3533:	00 
    3534:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    353b:	e8 0a 17 00 00       	call   4c4a <printf>
	}

	//分配内存空间把源图存入内存
	int l_width = WIDTHBYTES(width * bitInfoHead.biBitCount);//计算位图的实际宽度并确保它为32的倍数
    3540:	0f b7 45 92          	movzwl -0x6e(%ebp),%eax
    3544:	0f b7 c0             	movzwl %ax,%eax
    3547:	0f af 45 d4          	imul   -0x2c(%ebp),%eax
    354b:	83 c0 1f             	add    $0x1f,%eax
    354e:	8d 50 1f             	lea    0x1f(%eax),%edx
    3551:	85 c0                	test   %eax,%eax
    3553:	0f 48 c2             	cmovs  %edx,%eax
    3556:	c1 f8 05             	sar    $0x5,%eax
    3559:	c1 e0 02             	shl    $0x2,%eax
    355c:	89 45 cc             	mov    %eax,-0x34(%ebp)
	BYTE *pColorData = (BYTE *) malloc(height * l_width);
    355f:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3562:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    3566:	89 04 24             	mov    %eax,(%esp)
    3569:	e8 c8 19 00 00       	call   4f36 <malloc>
    356e:	89 45 c8             	mov    %eax,-0x38(%ebp)
	memset(pColorData, 0, (uint) height * l_width);
    3571:	8b 55 d0             	mov    -0x30(%ebp),%edx
    3574:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3577:	0f af c2             	imul   %edx,%eax
    357a:	89 44 24 08          	mov    %eax,0x8(%esp)
    357e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3585:	00 
    3586:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3589:	89 04 24             	mov    %eax,(%esp)
    358c:	e8 1c 13 00 00       	call   48ad <memset>
	long nData = height * l_width;
    3591:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3594:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    3598:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	//把位图数据信息读到数组里
	read(fd, pColorData, nData);
    359b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    359e:	89 44 24 08          	mov    %eax,0x8(%esp)
    35a2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    35a5:	89 44 24 04          	mov    %eax,0x4(%esp)
    35a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    35ac:	89 04 24             	mov    %eax,(%esp)
    35af:	e8 be 14 00 00       	call   4a72 <read>

	//printf(0, "reading bmp data.\n");
	//将位图数据转化为RGB数据
	RGBQUAD* dataOfBmp;

	dataOfBmp = (RGBQUAD *) malloc(width * height * sizeof(RGBQUAD));//用于保存各像素对应的RGB数据
    35b4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    35b7:	0f af 45 d0          	imul   -0x30(%ebp),%eax
    35bb:	c1 e0 02             	shl    $0x2,%eax
    35be:	89 04 24             	mov    %eax,(%esp)
    35c1:	e8 70 19 00 00       	call   4f36 <malloc>
    35c6:	89 45 c0             	mov    %eax,-0x40(%ebp)
	memset(dataOfBmp, 0, (uint) width * height * sizeof(RGBQUAD));
    35c9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    35cc:	8b 45 d0             	mov    -0x30(%ebp),%eax
    35cf:	0f af c2             	imul   %edx,%eax
    35d2:	c1 e0 02             	shl    $0x2,%eax
    35d5:	89 44 24 08          	mov    %eax,0x8(%esp)
    35d9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    35e0:	00 
    35e1:	8b 45 c0             	mov    -0x40(%ebp),%eax
    35e4:	89 04 24             	mov    %eax,(%esp)
    35e7:	e8 c1 12 00 00       	call   48ad <memset>
	if (bitInfoHead.biBitCount < 24)	//有调色板，即位图为非真彩色
    35ec:	0f b7 45 92          	movzwl -0x6e(%ebp),%eax
    35f0:	66 83 f8 17          	cmp    $0x17,%ax
    35f4:	77 19                	ja     360f <loadBitmap+0x24d>
			{
		printf(0, "%s is not a 24 bit bmp! return.");
    35f6:	c7 44 24 04 d0 b5 00 	movl   $0xb5d0,0x4(%esp)
    35fd:	00 
    35fe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3605:	e8 40 16 00 00       	call   4c4a <printf>
		return;
    360a:	e9 ee 00 00 00       	jmp    36fd <loadBitmap+0x33b>
	} else	//位图为24位真彩色
	{
		index = 0;
    360f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (i = 0; i < height; i++)
    3616:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    361d:	e9 94 00 00 00       	jmp    36b6 <loadBitmap+0x2f4>
			for (j = 0; j < width; j++) {
    3622:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3629:	eb 7b                	jmp    36a6 <loadBitmap+0x2e4>
				k = i * l_width + j * 3;
    362b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    362e:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    3632:	89 c1                	mov    %eax,%ecx
    3634:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3637:	89 d0                	mov    %edx,%eax
    3639:	01 c0                	add    %eax,%eax
    363b:	01 d0                	add    %edx,%eax
    363d:	01 c8                	add    %ecx,%eax
    363f:	89 45 bc             	mov    %eax,-0x44(%ebp)
				dataOfBmp[index].rgbRed = pColorData[k + 2];
    3642:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3645:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    364c:	8b 45 c0             	mov    -0x40(%ebp),%eax
    364f:	01 c2                	add    %eax,%edx
    3651:	8b 45 bc             	mov    -0x44(%ebp),%eax
    3654:	8d 48 02             	lea    0x2(%eax),%ecx
    3657:	8b 45 c8             	mov    -0x38(%ebp),%eax
    365a:	01 c8                	add    %ecx,%eax
    365c:	0f b6 00             	movzbl (%eax),%eax
    365f:	88 42 02             	mov    %al,0x2(%edx)
				dataOfBmp[index].rgbGreen = pColorData[k + 1];
    3662:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3665:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    366c:	8b 45 c0             	mov    -0x40(%ebp),%eax
    366f:	01 c2                	add    %eax,%edx
    3671:	8b 45 bc             	mov    -0x44(%ebp),%eax
    3674:	8d 48 01             	lea    0x1(%eax),%ecx
    3677:	8b 45 c8             	mov    -0x38(%ebp),%eax
    367a:	01 c8                	add    %ecx,%eax
    367c:	0f b6 00             	movzbl (%eax),%eax
    367f:	88 42 01             	mov    %al,0x1(%edx)
				dataOfBmp[index].rgbBlue = pColorData[k];
    3682:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3685:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    368c:	8b 45 c0             	mov    -0x40(%ebp),%eax
    368f:	01 c2                	add    %eax,%edx
    3691:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3694:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3697:	01 c8                	add    %ecx,%eax
    3699:	0f b6 00             	movzbl (%eax),%eax
    369c:	88 02                	mov    %al,(%edx)
				index++;
    369e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
		return;
	} else	//位图为24位真彩色
	{
		index = 0;
		for (i = 0; i < height; i++)
			for (j = 0; j < width; j++) {
    36a2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    36a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    36a9:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
    36ac:	0f 8c 79 ff ff ff    	jl     362b <loadBitmap+0x269>
		printf(0, "%s is not a 24 bit bmp! return.");
		return;
	} else	//位图为24位真彩色
	{
		index = 0;
		for (i = 0; i < height; i++)
    36b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    36b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    36b9:	3b 45 d0             	cmp    -0x30(%ebp),%eax
    36bc:	0f 8c 60 ff ff ff    	jl     3622 <loadBitmap+0x260>
//			printf(0, "\n");
//		}
//		showRgbQuan(&dataOfBmp[i]);
//	}

	close(fd);
    36c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    36c5:	89 04 24             	mov    %eax,(%esp)
    36c8:	e8 b5 13 00 00       	call   4a82 <close>

	//free(dataOfBmp);
	pic->data = dataOfBmp;
    36cd:	8b 45 08             	mov    0x8(%ebp),%eax
    36d0:	8b 55 c0             	mov    -0x40(%ebp),%edx
    36d3:	89 10                	mov    %edx,(%eax)
	pic->width = width;
    36d5:	8b 45 08             	mov    0x8(%ebp),%eax
    36d8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    36db:	89 50 04             	mov    %edx,0x4(%eax)
	pic->height = height;
    36de:	8b 45 08             	mov    0x8(%ebp),%eax
    36e1:	8b 55 d0             	mov    -0x30(%ebp),%edx
    36e4:	89 50 08             	mov    %edx,0x8(%eax)
	free(pColorData);
    36e7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    36ea:	89 04 24             	mov    %eax,(%esp)
    36ed:	e8 0b 17 00 00       	call   4dfd <free>
	free(BmpFileHeader);
    36f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    36f5:	89 04 24             	mov    %eax,(%esp)
    36f8:	e8 00 17 00 00       	call   4dfd <free>
	//printf("\n");
}
    36fd:	c9                   	leave  
    36fe:	c3                   	ret    

000036ff <showBmpHead>:

void showBmpHead(BITMAPFILEHEADER* pBmpHead) {
    36ff:	55                   	push   %ebp
    3700:	89 e5                	mov    %esp,%ebp
    3702:	83 ec 18             	sub    $0x18,%esp
	printf(0, "位图文件头:\n");
    3705:	c7 44 24 04 f0 b5 00 	movl   $0xb5f0,0x4(%esp)
    370c:	00 
    370d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3714:	e8 31 15 00 00       	call   4c4a <printf>
	printf(0, "bmp格式标志bftype：0x%x\n", pBmpHead->bfType);
    3719:	8b 45 08             	mov    0x8(%ebp),%eax
    371c:	0f b7 00             	movzwl (%eax),%eax
    371f:	0f b7 c0             	movzwl %ax,%eax
    3722:	89 44 24 08          	mov    %eax,0x8(%esp)
    3726:	c7 44 24 04 02 b6 00 	movl   $0xb602,0x4(%esp)
    372d:	00 
    372e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3735:	e8 10 15 00 00       	call   4c4a <printf>
	printf(0, "文件大小:%d\n", pBmpHead->bfSize);
    373a:	8b 45 08             	mov    0x8(%ebp),%eax
    373d:	8b 40 04             	mov    0x4(%eax),%eax
    3740:	89 44 24 08          	mov    %eax,0x8(%esp)
    3744:	c7 44 24 04 20 b6 00 	movl   $0xb620,0x4(%esp)
    374b:	00 
    374c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3753:	e8 f2 14 00 00       	call   4c4a <printf>
	printf(0, "保留字:%d\n", pBmpHead->bfReserved1);
    3758:	8b 45 08             	mov    0x8(%ebp),%eax
    375b:	0f b7 40 08          	movzwl 0x8(%eax),%eax
    375f:	0f b7 c0             	movzwl %ax,%eax
    3762:	89 44 24 08          	mov    %eax,0x8(%esp)
    3766:	c7 44 24 04 31 b6 00 	movl   $0xb631,0x4(%esp)
    376d:	00 
    376e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3775:	e8 d0 14 00 00       	call   4c4a <printf>
	printf(0, "保留字:%d\n", pBmpHead->bfReserved2);
    377a:	8b 45 08             	mov    0x8(%ebp),%eax
    377d:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    3781:	0f b7 c0             	movzwl %ax,%eax
    3784:	89 44 24 08          	mov    %eax,0x8(%esp)
    3788:	c7 44 24 04 31 b6 00 	movl   $0xb631,0x4(%esp)
    378f:	00 
    3790:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3797:	e8 ae 14 00 00       	call   4c4a <printf>
	printf(0, "实际位图数据的偏移字节数:%d\n", pBmpHead->bfOffBits);
    379c:	8b 45 08             	mov    0x8(%ebp),%eax
    379f:	8b 40 0c             	mov    0xc(%eax),%eax
    37a2:	89 44 24 08          	mov    %eax,0x8(%esp)
    37a6:	c7 44 24 04 40 b6 00 	movl   $0xb640,0x4(%esp)
    37ad:	00 
    37ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37b5:	e8 90 14 00 00       	call   4c4a <printf>
}
    37ba:	c9                   	leave  
    37bb:	c3                   	ret    

000037bc <showBmpInforHead>:

void showBmpInforHead(BITMAPINFOHEADER* pBmpInforHead) {
    37bc:	55                   	push   %ebp
    37bd:	89 e5                	mov    %esp,%ebp
    37bf:	83 ec 18             	sub    $0x18,%esp
	printf(0, "位图信息头:\n");
    37c2:	c7 44 24 04 69 b6 00 	movl   $0xb669,0x4(%esp)
    37c9:	00 
    37ca:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37d1:	e8 74 14 00 00       	call   4c4a <printf>
	printf(0, "结构体的长度:%d\n", pBmpInforHead->biSize);
    37d6:	8b 45 08             	mov    0x8(%ebp),%eax
    37d9:	8b 00                	mov    (%eax),%eax
    37db:	89 44 24 08          	mov    %eax,0x8(%esp)
    37df:	c7 44 24 04 7b b6 00 	movl   $0xb67b,0x4(%esp)
    37e6:	00 
    37e7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    37ee:	e8 57 14 00 00       	call   4c4a <printf>
	printf(0, "位图宽:%d\n", pBmpInforHead->biWidth);
    37f3:	8b 45 08             	mov    0x8(%ebp),%eax
    37f6:	8b 40 04             	mov    0x4(%eax),%eax
    37f9:	89 44 24 08          	mov    %eax,0x8(%esp)
    37fd:	c7 44 24 04 92 b6 00 	movl   $0xb692,0x4(%esp)
    3804:	00 
    3805:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    380c:	e8 39 14 00 00       	call   4c4a <printf>
	printf(0, "位图高:%d\n", pBmpInforHead->biHeight);
    3811:	8b 45 08             	mov    0x8(%ebp),%eax
    3814:	8b 40 08             	mov    0x8(%eax),%eax
    3817:	89 44 24 08          	mov    %eax,0x8(%esp)
    381b:	c7 44 24 04 a0 b6 00 	movl   $0xb6a0,0x4(%esp)
    3822:	00 
    3823:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    382a:	e8 1b 14 00 00       	call   4c4a <printf>
	printf(0, "biPlanes平面数:%d\n", pBmpInforHead->biPlanes);
    382f:	8b 45 08             	mov    0x8(%ebp),%eax
    3832:	0f b7 40 0c          	movzwl 0xc(%eax),%eax
    3836:	0f b7 c0             	movzwl %ax,%eax
    3839:	89 44 24 08          	mov    %eax,0x8(%esp)
    383d:	c7 44 24 04 ae b6 00 	movl   $0xb6ae,0x4(%esp)
    3844:	00 
    3845:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    384c:	e8 f9 13 00 00       	call   4c4a <printf>
	printf(0, "biBitCount采用颜色位数:%d\n", pBmpInforHead->biBitCount);
    3851:	8b 45 08             	mov    0x8(%ebp),%eax
    3854:	0f b7 40 0e          	movzwl 0xe(%eax),%eax
    3858:	0f b7 c0             	movzwl %ax,%eax
    385b:	89 44 24 08          	mov    %eax,0x8(%esp)
    385f:	c7 44 24 04 c4 b6 00 	movl   $0xb6c4,0x4(%esp)
    3866:	00 
    3867:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    386e:	e8 d7 13 00 00       	call   4c4a <printf>
	printf(0, "压缩方式:%d\n", pBmpInforHead->biCompression);
    3873:	8b 45 08             	mov    0x8(%ebp),%eax
    3876:	8b 40 10             	mov    0x10(%eax),%eax
    3879:	89 44 24 08          	mov    %eax,0x8(%esp)
    387d:	c7 44 24 04 e5 b6 00 	movl   $0xb6e5,0x4(%esp)
    3884:	00 
    3885:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    388c:	e8 b9 13 00 00       	call   4c4a <printf>
	printf(0, "biSizeImage实际位图数据占用的字节数:%d\n", pBmpInforHead->biSizeImage);
    3891:	8b 45 08             	mov    0x8(%ebp),%eax
    3894:	8b 40 14             	mov    0x14(%eax),%eax
    3897:	89 44 24 08          	mov    %eax,0x8(%esp)
    389b:	c7 44 24 04 f8 b6 00 	movl   $0xb6f8,0x4(%esp)
    38a2:	00 
    38a3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    38aa:	e8 9b 13 00 00       	call   4c4a <printf>
	printf(0, "X方向分辨率:%d\n", pBmpInforHead->biXPelsPerMeter);
    38af:	8b 45 08             	mov    0x8(%ebp),%eax
    38b2:	8b 40 18             	mov    0x18(%eax),%eax
    38b5:	89 44 24 08          	mov    %eax,0x8(%esp)
    38b9:	c7 44 24 04 2c b7 00 	movl   $0xb72c,0x4(%esp)
    38c0:	00 
    38c1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    38c8:	e8 7d 13 00 00       	call   4c4a <printf>
	printf(0, "Y方向分辨率:%d\n", pBmpInforHead->biYPelsPerMeter);
    38cd:	8b 45 08             	mov    0x8(%ebp),%eax
    38d0:	8b 40 1c             	mov    0x1c(%eax),%eax
    38d3:	89 44 24 08          	mov    %eax,0x8(%esp)
    38d7:	c7 44 24 04 41 b7 00 	movl   $0xb741,0x4(%esp)
    38de:	00 
    38df:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    38e6:	e8 5f 13 00 00       	call   4c4a <printf>
	printf(0, "使用的颜色数:%d\n", pBmpInforHead->biClrUsed);
    38eb:	8b 45 08             	mov    0x8(%ebp),%eax
    38ee:	8b 40 20             	mov    0x20(%eax),%eax
    38f1:	89 44 24 08          	mov    %eax,0x8(%esp)
    38f5:	c7 44 24 04 56 b7 00 	movl   $0xb756,0x4(%esp)
    38fc:	00 
    38fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3904:	e8 41 13 00 00       	call   4c4a <printf>
	printf(0, "重要颜色数:%d\n", pBmpInforHead->biClrImportant);
    3909:	8b 45 08             	mov    0x8(%ebp),%eax
    390c:	8b 40 24             	mov    0x24(%eax),%eax
    390f:	89 44 24 08          	mov    %eax,0x8(%esp)
    3913:	c7 44 24 04 6d b7 00 	movl   $0xb76d,0x4(%esp)
    391a:	00 
    391b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3922:	e8 23 13 00 00       	call   4c4a <printf>
}
    3927:	c9                   	leave  
    3928:	c3                   	ret    

00003929 <showRgbQuan>:
void showRgbQuan(RGBQUAD* pRGB) {
    3929:	55                   	push   %ebp
    392a:	89 e5                	mov    %esp,%ebp
    392c:	83 ec 28             	sub    $0x28,%esp
	printf(0, "(%d,%d,%d) ", pRGB->rgbRed, pRGB->rgbGreen, pRGB->rgbBlue);
    392f:	8b 45 08             	mov    0x8(%ebp),%eax
    3932:	0f b6 00             	movzbl (%eax),%eax
    3935:	0f b6 c8             	movzbl %al,%ecx
    3938:	8b 45 08             	mov    0x8(%ebp),%eax
    393b:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    393f:	0f b6 d0             	movzbl %al,%edx
    3942:	8b 45 08             	mov    0x8(%ebp),%eax
    3945:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    3949:	0f b6 c0             	movzbl %al,%eax
    394c:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    3950:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3954:	89 44 24 08          	mov    %eax,0x8(%esp)
    3958:	c7 44 24 04 81 b7 00 	movl   $0xb781,0x4(%esp)
    395f:	00 
    3960:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3967:	e8 de 12 00 00       	call   4c4a <printf>
}
    396c:	c9                   	leave  
    396d:	c3                   	ret    

0000396e <freepic>:

void freepic(PICNODE *pic) {
    396e:	55                   	push   %ebp
    396f:	89 e5                	mov    %esp,%ebp
    3971:	83 ec 18             	sub    $0x18,%esp
	free(pic->data);
    3974:	8b 45 08             	mov    0x8(%ebp),%eax
    3977:	8b 00                	mov    (%eax),%eax
    3979:	89 04 24             	mov    %eax,(%esp)
    397c:	e8 7c 14 00 00       	call   4dfd <free>
}
    3981:	c9                   	leave  
    3982:	c3                   	ret    

00003983 <set_icon_alpha>:

void set_icon_alpha(PICNODE *pic) {
    3983:	55                   	push   %ebp
    3984:	89 e5                	mov    %esp,%ebp
    3986:	53                   	push   %ebx
    3987:	81 ec 84 00 00 00    	sub    $0x84,%esp
	int W = 15;
    398d:	c7 45 ec 0f 00 00 00 	movl   $0xf,-0x14(%ebp)
	Rect r1 = initRect(0, 0, W, W);
    3994:	8d 45 dc             	lea    -0x24(%ebp),%eax
    3997:	8b 55 ec             	mov    -0x14(%ebp),%edx
    399a:	89 54 24 10          	mov    %edx,0x10(%esp)
    399e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    39a1:	89 54 24 0c          	mov    %edx,0xc(%esp)
    39a5:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    39ac:	00 
    39ad:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    39b4:	00 
    39b5:	89 04 24             	mov    %eax,(%esp)
    39b8:	e8 80 02 00 00       	call   3c3d <initRect>
    39bd:	83 ec 04             	sub    $0x4,%esp
	Rect r2 = initRect(pic->width - W, 0, W, W);
    39c0:	8b 45 08             	mov    0x8(%ebp),%eax
    39c3:	8b 40 04             	mov    0x4(%eax),%eax
    39c6:	2b 45 ec             	sub    -0x14(%ebp),%eax
    39c9:	89 c2                	mov    %eax,%edx
    39cb:	8d 45 cc             	lea    -0x34(%ebp),%eax
    39ce:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    39d1:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    39d5:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    39d8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    39dc:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    39e3:	00 
    39e4:	89 54 24 04          	mov    %edx,0x4(%esp)
    39e8:	89 04 24             	mov    %eax,(%esp)
    39eb:	e8 4d 02 00 00       	call   3c3d <initRect>
    39f0:	83 ec 04             	sub    $0x4,%esp
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
    39f3:	8b 45 08             	mov    0x8(%ebp),%eax
    39f6:	8b 40 08             	mov    0x8(%eax),%eax
    39f9:	2b 45 ec             	sub    -0x14(%ebp),%eax
    39fc:	89 c1                	mov    %eax,%ecx
    39fe:	8b 45 08             	mov    0x8(%ebp),%eax
    3a01:	8b 40 04             	mov    0x4(%eax),%eax
    3a04:	2b 45 ec             	sub    -0x14(%ebp),%eax
    3a07:	89 c2                	mov    %eax,%edx
    3a09:	8d 45 bc             	lea    -0x44(%ebp),%eax
    3a0c:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    3a0f:	89 5c 24 10          	mov    %ebx,0x10(%esp)
    3a13:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    3a16:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    3a1a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    3a1e:	89 54 24 04          	mov    %edx,0x4(%esp)
    3a22:	89 04 24             	mov    %eax,(%esp)
    3a25:	e8 13 02 00 00       	call   3c3d <initRect>
    3a2a:	83 ec 04             	sub    $0x4,%esp
	Rect r4 = initRect(0, pic->height - W, W, W);
    3a2d:	8b 45 08             	mov    0x8(%ebp),%eax
    3a30:	8b 40 08             	mov    0x8(%eax),%eax
    3a33:	2b 45 ec             	sub    -0x14(%ebp),%eax
    3a36:	89 c2                	mov    %eax,%edx
    3a38:	8d 45 ac             	lea    -0x54(%ebp),%eax
    3a3b:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    3a3e:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    3a42:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    3a45:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    3a49:	89 54 24 08          	mov    %edx,0x8(%esp)
    3a4d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3a54:	00 
    3a55:	89 04 24             	mov    %eax,(%esp)
    3a58:	e8 e0 01 00 00       	call   3c3d <initRect>
    3a5d:	83 ec 04             	sub    $0x4,%esp
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
    3a60:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3a67:	e9 96 01 00 00       	jmp    3c02 <set_icon_alpha+0x27f>
		for (j = 0; j < pic->height; j++) {
    3a6c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3a73:	e9 77 01 00 00       	jmp    3bef <set_icon_alpha+0x26c>
			p = initPoint(i, j);
    3a78:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3a7b:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3a7e:	89 54 24 08          	mov    %edx,0x8(%esp)
    3a82:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3a85:	89 54 24 04          	mov    %edx,0x4(%esp)
    3a89:	89 04 24             	mov    %eax,(%esp)
    3a8c:	e8 85 01 00 00       	call   3c16 <initPoint>
    3a91:	83 ec 04             	sub    $0x4,%esp
			if (isIn(p, r1) || isIn(p, r2) || isIn(p, r3) || isIn(p, r4)) {
    3a94:	8b 45 dc             	mov    -0x24(%ebp),%eax
    3a97:	89 44 24 08          	mov    %eax,0x8(%esp)
    3a9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3a9e:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3aa2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3aa5:	89 44 24 10          	mov    %eax,0x10(%esp)
    3aa9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3aac:	89 44 24 14          	mov    %eax,0x14(%esp)
    3ab0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3ab3:	8b 55 a8             	mov    -0x58(%ebp),%edx
    3ab6:	89 04 24             	mov    %eax,(%esp)
    3ab9:	89 54 24 04          	mov    %edx,0x4(%esp)
    3abd:	e8 d6 01 00 00       	call   3c98 <isIn>
    3ac2:	85 c0                	test   %eax,%eax
    3ac4:	0f 85 9a 00 00 00    	jne    3b64 <set_icon_alpha+0x1e1>
    3aca:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3acd:	89 44 24 08          	mov    %eax,0x8(%esp)
    3ad1:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3ad4:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3ad8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3adb:	89 44 24 10          	mov    %eax,0x10(%esp)
    3adf:	8b 45 d8             	mov    -0x28(%ebp),%eax
    3ae2:	89 44 24 14          	mov    %eax,0x14(%esp)
    3ae6:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3ae9:	8b 55 a8             	mov    -0x58(%ebp),%edx
    3aec:	89 04 24             	mov    %eax,(%esp)
    3aef:	89 54 24 04          	mov    %edx,0x4(%esp)
    3af3:	e8 a0 01 00 00       	call   3c98 <isIn>
    3af8:	85 c0                	test   %eax,%eax
    3afa:	75 68                	jne    3b64 <set_icon_alpha+0x1e1>
    3afc:	8b 45 bc             	mov    -0x44(%ebp),%eax
    3aff:	89 44 24 08          	mov    %eax,0x8(%esp)
    3b03:	8b 45 c0             	mov    -0x40(%ebp),%eax
    3b06:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3b0a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    3b0d:	89 44 24 10          	mov    %eax,0x10(%esp)
    3b11:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3b14:	89 44 24 14          	mov    %eax,0x14(%esp)
    3b18:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3b1b:	8b 55 a8             	mov    -0x58(%ebp),%edx
    3b1e:	89 04 24             	mov    %eax,(%esp)
    3b21:	89 54 24 04          	mov    %edx,0x4(%esp)
    3b25:	e8 6e 01 00 00       	call   3c98 <isIn>
    3b2a:	85 c0                	test   %eax,%eax
    3b2c:	75 36                	jne    3b64 <set_icon_alpha+0x1e1>
    3b2e:	8b 45 ac             	mov    -0x54(%ebp),%eax
    3b31:	89 44 24 08          	mov    %eax,0x8(%esp)
    3b35:	8b 45 b0             	mov    -0x50(%ebp),%eax
    3b38:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3b3c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    3b3f:	89 44 24 10          	mov    %eax,0x10(%esp)
    3b43:	8b 45 b8             	mov    -0x48(%ebp),%eax
    3b46:	89 44 24 14          	mov    %eax,0x14(%esp)
    3b4a:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3b4d:	8b 55 a8             	mov    -0x58(%ebp),%edx
    3b50:	89 04 24             	mov    %eax,(%esp)
    3b53:	89 54 24 04          	mov    %edx,0x4(%esp)
    3b57:	e8 3c 01 00 00       	call   3c98 <isIn>
    3b5c:	85 c0                	test   %eax,%eax
    3b5e:	0f 84 87 00 00 00    	je     3beb <set_icon_alpha+0x268>
				if (pic->data[j * pic->width + i].rgbBlue == 0xff
    3b64:	8b 45 08             	mov    0x8(%ebp),%eax
    3b67:	8b 10                	mov    (%eax),%edx
    3b69:	8b 45 08             	mov    0x8(%ebp),%eax
    3b6c:	8b 40 04             	mov    0x4(%eax),%eax
    3b6f:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    3b73:	89 c1                	mov    %eax,%ecx
    3b75:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b78:	01 c8                	add    %ecx,%eax
    3b7a:	c1 e0 02             	shl    $0x2,%eax
    3b7d:	01 d0                	add    %edx,%eax
    3b7f:	0f b6 00             	movzbl (%eax),%eax
    3b82:	3c ff                	cmp    $0xff,%al
    3b84:	75 65                	jne    3beb <set_icon_alpha+0x268>
						&& pic->data[j * pic->width + i].rgbGreen == 0xff
    3b86:	8b 45 08             	mov    0x8(%ebp),%eax
    3b89:	8b 10                	mov    (%eax),%edx
    3b8b:	8b 45 08             	mov    0x8(%ebp),%eax
    3b8e:	8b 40 04             	mov    0x4(%eax),%eax
    3b91:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    3b95:	89 c1                	mov    %eax,%ecx
    3b97:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b9a:	01 c8                	add    %ecx,%eax
    3b9c:	c1 e0 02             	shl    $0x2,%eax
    3b9f:	01 d0                	add    %edx,%eax
    3ba1:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    3ba5:	3c ff                	cmp    $0xff,%al
    3ba7:	75 42                	jne    3beb <set_icon_alpha+0x268>
						&& pic->data[j * pic->width + i].rgbRed == 0xff) {
    3ba9:	8b 45 08             	mov    0x8(%ebp),%eax
    3bac:	8b 10                	mov    (%eax),%edx
    3bae:	8b 45 08             	mov    0x8(%ebp),%eax
    3bb1:	8b 40 04             	mov    0x4(%eax),%eax
    3bb4:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    3bb8:	89 c1                	mov    %eax,%ecx
    3bba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3bbd:	01 c8                	add    %ecx,%eax
    3bbf:	c1 e0 02             	shl    $0x2,%eax
    3bc2:	01 d0                	add    %edx,%eax
    3bc4:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    3bc8:	3c ff                	cmp    $0xff,%al
    3bca:	75 1f                	jne    3beb <set_icon_alpha+0x268>
					pic->data[j * pic->width + i].rgbReserved = 1;
    3bcc:	8b 45 08             	mov    0x8(%ebp),%eax
    3bcf:	8b 10                	mov    (%eax),%edx
    3bd1:	8b 45 08             	mov    0x8(%ebp),%eax
    3bd4:	8b 40 04             	mov    0x4(%eax),%eax
    3bd7:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    3bdb:	89 c1                	mov    %eax,%ecx
    3bdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3be0:	01 c8                	add    %ecx,%eax
    3be2:	c1 e0 02             	shl    $0x2,%eax
    3be5:	01 d0                	add    %edx,%eax
    3be7:	c6 40 03 01          	movb   $0x1,0x3(%eax)
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
	Rect r4 = initRect(0, pic->height - W, W, W);
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
		for (j = 0; j < pic->height; j++) {
    3beb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3bef:	8b 45 08             	mov    0x8(%ebp),%eax
    3bf2:	8b 40 08             	mov    0x8(%eax),%eax
    3bf5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    3bf8:	0f 8f 7a fe ff ff    	jg     3a78 <set_icon_alpha+0xf5>
	Rect r2 = initRect(pic->width - W, 0, W, W);
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
	Rect r4 = initRect(0, pic->height - W, W, W);
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
    3bfe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3c02:	8b 45 08             	mov    0x8(%ebp),%eax
    3c05:	8b 40 04             	mov    0x4(%eax),%eax
    3c08:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3c0b:	0f 8f 5b fe ff ff    	jg     3a6c <set_icon_alpha+0xe9>
					pic->data[j * pic->width + i].rgbReserved = 1;
				}
			}
		}
	}
}
    3c11:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3c14:	c9                   	leave  
    3c15:	c3                   	ret    

00003c16 <initPoint>:
#include "message.h"
#include "types.h"
#include "user.h"
#include "finder.h"
Point initPoint(int x, int y)
{
    3c16:	55                   	push   %ebp
    3c17:	89 e5                	mov    %esp,%ebp
    3c19:	83 ec 10             	sub    $0x10,%esp
	Point p;
	p.x = x;
    3c1c:	8b 45 0c             	mov    0xc(%ebp),%eax
    3c1f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	p.y = y;
    3c22:	8b 45 10             	mov    0x10(%ebp),%eax
    3c25:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return p;
    3c28:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3c2b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3c2e:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3c31:	89 01                	mov    %eax,(%ecx)
    3c33:	89 51 04             	mov    %edx,0x4(%ecx)
}
    3c36:	8b 45 08             	mov    0x8(%ebp),%eax
    3c39:	c9                   	leave  
    3c3a:	c2 04 00             	ret    $0x4

00003c3d <initRect>:

Rect initRect(int x, int y, int w, int h)
{
    3c3d:	55                   	push   %ebp
    3c3e:	89 e5                	mov    %esp,%ebp
    3c40:	83 ec 24             	sub    $0x24,%esp
	Rect r;
	r.start = initPoint(x, y);
    3c43:	8d 45 e8             	lea    -0x18(%ebp),%eax
    3c46:	8b 55 10             	mov    0x10(%ebp),%edx
    3c49:	89 54 24 08          	mov    %edx,0x8(%esp)
    3c4d:	8b 55 0c             	mov    0xc(%ebp),%edx
    3c50:	89 54 24 04          	mov    %edx,0x4(%esp)
    3c54:	89 04 24             	mov    %eax,(%esp)
    3c57:	e8 ba ff ff ff       	call   3c16 <initPoint>
    3c5c:	83 ec 04             	sub    $0x4,%esp
    3c5f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3c62:	8b 55 ec             	mov    -0x14(%ebp),%edx
    3c65:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3c68:	89 55 f4             	mov    %edx,-0xc(%ebp)
	r.width = w;
    3c6b:	8b 45 14             	mov    0x14(%ebp),%eax
    3c6e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	r.height = h;
    3c71:	8b 45 18             	mov    0x18(%ebp),%eax
    3c74:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return r;
    3c77:	8b 45 08             	mov    0x8(%ebp),%eax
    3c7a:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3c7d:	89 10                	mov    %edx,(%eax)
    3c7f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3c82:	89 50 04             	mov    %edx,0x4(%eax)
    3c85:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3c88:	89 50 08             	mov    %edx,0x8(%eax)
    3c8b:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3c8e:	89 50 0c             	mov    %edx,0xc(%eax)
}
    3c91:	8b 45 08             	mov    0x8(%ebp),%eax
    3c94:	c9                   	leave  
    3c95:	c2 04 00             	ret    $0x4

00003c98 <isIn>:

int isIn(Point p, Rect r)
{
    3c98:	55                   	push   %ebp
    3c99:	89 e5                	mov    %esp,%ebp
	return (p.x >= r.start.x) && (p.x < r.start.x+r.width)
    3c9b:	8b 55 08             	mov    0x8(%ebp),%edx
    3c9e:	8b 45 10             	mov    0x10(%ebp),%eax
			&& (p.y >= r.start.y) && (p.y < r.start.y+r.height);
    3ca1:	39 c2                	cmp    %eax,%edx
    3ca3:	7c 2f                	jl     3cd4 <isIn+0x3c>
	return r;
}

int isIn(Point p, Rect r)
{
	return (p.x >= r.start.x) && (p.x < r.start.x+r.width)
    3ca5:	8b 45 08             	mov    0x8(%ebp),%eax
    3ca8:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3cab:	8b 55 18             	mov    0x18(%ebp),%edx
    3cae:	01 ca                	add    %ecx,%edx
    3cb0:	39 d0                	cmp    %edx,%eax
    3cb2:	7d 20                	jge    3cd4 <isIn+0x3c>
			&& (p.y >= r.start.y) && (p.y < r.start.y+r.height);
    3cb4:	8b 55 0c             	mov    0xc(%ebp),%edx
    3cb7:	8b 45 14             	mov    0x14(%ebp),%eax
    3cba:	39 c2                	cmp    %eax,%edx
    3cbc:	7c 16                	jl     3cd4 <isIn+0x3c>
    3cbe:	8b 45 0c             	mov    0xc(%ebp),%eax
    3cc1:	8b 4d 14             	mov    0x14(%ebp),%ecx
    3cc4:	8b 55 1c             	mov    0x1c(%ebp),%edx
    3cc7:	01 ca                	add    %ecx,%edx
    3cc9:	39 d0                	cmp    %edx,%eax
    3ccb:	7d 07                	jge    3cd4 <isIn+0x3c>
    3ccd:	b8 01 00 00 00       	mov    $0x1,%eax
    3cd2:	eb 05                	jmp    3cd9 <isIn+0x41>
    3cd4:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3cd9:	5d                   	pop    %ebp
    3cda:	c3                   	ret    

00003cdb <initClickManager>:

ClickableManager initClickManager(struct Context c)
{
    3cdb:	55                   	push   %ebp
    3cdc:	89 e5                	mov    %esp,%ebp
    3cde:	83 ec 20             	sub    $0x20,%esp
	ClickableManager cm;
	cm.left_click = 0;
    3ce1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	cm.double_click = 0;
    3ce8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	cm.right_click = 0;
    3cef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	cm.wndWidth = c.width;
    3cf6:	8b 45 10             	mov    0x10(%ebp),%eax
    3cf9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	cm.wndHeight = c.height;
    3cfc:	8b 45 14             	mov    0x14(%ebp),%eax
    3cff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return cm;
    3d02:	8b 45 08             	mov    0x8(%ebp),%eax
    3d05:	8b 55 ec             	mov    -0x14(%ebp),%edx
    3d08:	89 10                	mov    %edx,(%eax)
    3d0a:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3d0d:	89 50 04             	mov    %edx,0x4(%eax)
    3d10:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3d13:	89 50 08             	mov    %edx,0x8(%eax)
    3d16:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3d19:	89 50 0c             	mov    %edx,0xc(%eax)
    3d1c:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3d1f:	89 50 10             	mov    %edx,0x10(%eax)
}
    3d22:	8b 45 08             	mov    0x8(%ebp),%eax
    3d25:	c9                   	leave  
    3d26:	c2 04 00             	ret    $0x4

00003d29 <createClickable>:

void createClickable(ClickableManager *c, Rect r, int MsgType, Handler h)
{
    3d29:	55                   	push   %ebp
    3d2a:	89 e5                	mov    %esp,%ebp
    3d2c:	83 ec 28             	sub    $0x28,%esp
	switch (MsgType)
    3d2f:	8b 45 1c             	mov    0x1c(%ebp),%eax
    3d32:	83 f8 03             	cmp    $0x3,%eax
    3d35:	74 72                	je     3da9 <createClickable+0x80>
    3d37:	83 f8 04             	cmp    $0x4,%eax
    3d3a:	74 0a                	je     3d46 <createClickable+0x1d>
    3d3c:	83 f8 02             	cmp    $0x2,%eax
    3d3f:	74 38                	je     3d79 <createClickable+0x50>
    3d41:	e9 96 00 00 00       	jmp    3ddc <createClickable+0xb3>
	{
	    case MSG_DOUBLECLICK:
		addClickable(&c->double_click, r, h);
    3d46:	8b 45 08             	mov    0x8(%ebp),%eax
    3d49:	8d 50 04             	lea    0x4(%eax),%edx
    3d4c:	8b 45 20             	mov    0x20(%ebp),%eax
    3d4f:	89 44 24 14          	mov    %eax,0x14(%esp)
    3d53:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d56:	89 44 24 04          	mov    %eax,0x4(%esp)
    3d5a:	8b 45 10             	mov    0x10(%ebp),%eax
    3d5d:	89 44 24 08          	mov    %eax,0x8(%esp)
    3d61:	8b 45 14             	mov    0x14(%ebp),%eax
    3d64:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3d68:	8b 45 18             	mov    0x18(%ebp),%eax
    3d6b:	89 44 24 10          	mov    %eax,0x10(%esp)
    3d6f:	89 14 24             	mov    %edx,(%esp)
    3d72:	e8 7c 00 00 00       	call   3df3 <addClickable>
	        break;
    3d77:	eb 78                	jmp    3df1 <createClickable+0xc8>
	    case MSG_LPRESS:
	    	addClickable(&c->left_click, r, h);
    3d79:	8b 45 08             	mov    0x8(%ebp),%eax
    3d7c:	8b 55 20             	mov    0x20(%ebp),%edx
    3d7f:	89 54 24 14          	mov    %edx,0x14(%esp)
    3d83:	8b 55 0c             	mov    0xc(%ebp),%edx
    3d86:	89 54 24 04          	mov    %edx,0x4(%esp)
    3d8a:	8b 55 10             	mov    0x10(%ebp),%edx
    3d8d:	89 54 24 08          	mov    %edx,0x8(%esp)
    3d91:	8b 55 14             	mov    0x14(%ebp),%edx
    3d94:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3d98:	8b 55 18             	mov    0x18(%ebp),%edx
    3d9b:	89 54 24 10          	mov    %edx,0x10(%esp)
    3d9f:	89 04 24             	mov    %eax,(%esp)
    3da2:	e8 4c 00 00 00       	call   3df3 <addClickable>
	    	break;
    3da7:	eb 48                	jmp    3df1 <createClickable+0xc8>
	    case MSG_RPRESS:
	    	addClickable(&c->right_click, r, h);
    3da9:	8b 45 08             	mov    0x8(%ebp),%eax
    3dac:	8d 50 08             	lea    0x8(%eax),%edx
    3daf:	8b 45 20             	mov    0x20(%ebp),%eax
    3db2:	89 44 24 14          	mov    %eax,0x14(%esp)
    3db6:	8b 45 0c             	mov    0xc(%ebp),%eax
    3db9:	89 44 24 04          	mov    %eax,0x4(%esp)
    3dbd:	8b 45 10             	mov    0x10(%ebp),%eax
    3dc0:	89 44 24 08          	mov    %eax,0x8(%esp)
    3dc4:	8b 45 14             	mov    0x14(%ebp),%eax
    3dc7:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3dcb:	8b 45 18             	mov    0x18(%ebp),%eax
    3dce:	89 44 24 10          	mov    %eax,0x10(%esp)
    3dd2:	89 14 24             	mov    %edx,(%esp)
    3dd5:	e8 19 00 00 00       	call   3df3 <addClickable>
	    	break;
    3dda:	eb 15                	jmp    3df1 <createClickable+0xc8>
	    default:
	    	printf(0, "向clickable传递了非鼠标点击事件！");
    3ddc:	c7 44 24 04 90 b7 00 	movl   $0xb790,0x4(%esp)
    3de3:	00 
    3de4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3deb:	e8 5a 0e 00 00       	call   4c4a <printf>
	    	break;
    3df0:	90                   	nop
	}
}
    3df1:	c9                   	leave  
    3df2:	c3                   	ret    

00003df3 <addClickable>:

void addClickable(Clickable **head, Rect r, Handler h)
{
    3df3:	55                   	push   %ebp
    3df4:	89 e5                	mov    %esp,%ebp
    3df6:	83 ec 28             	sub    $0x28,%esp
	//printf(0, "adding clickable\n");
	Clickable *c = (Clickable *)malloc(sizeof(Clickable));
    3df9:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
    3e00:	e8 31 11 00 00       	call   4f36 <malloc>
    3e05:	89 45 f4             	mov    %eax,-0xc(%ebp)
	c->area = r;
    3e08:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e0b:	8b 55 0c             	mov    0xc(%ebp),%edx
    3e0e:	89 10                	mov    %edx,(%eax)
    3e10:	8b 55 10             	mov    0x10(%ebp),%edx
    3e13:	89 50 04             	mov    %edx,0x4(%eax)
    3e16:	8b 55 14             	mov    0x14(%ebp),%edx
    3e19:	89 50 08             	mov    %edx,0x8(%eax)
    3e1c:	8b 55 18             	mov    0x18(%ebp),%edx
    3e1f:	89 50 0c             	mov    %edx,0xc(%eax)
	c->handler = h;
    3e22:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e25:	8b 55 1c             	mov    0x1c(%ebp),%edx
    3e28:	89 50 10             	mov    %edx,0x10(%eax)
	c->next = *head;
    3e2b:	8b 45 08             	mov    0x8(%ebp),%eax
    3e2e:	8b 10                	mov    (%eax),%edx
    3e30:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e33:	89 50 18             	mov    %edx,0x18(%eax)
        if (*head == 0)
    3e36:	8b 45 08             	mov    0x8(%ebp),%eax
    3e39:	8b 00                	mov    (%eax),%eax
    3e3b:	85 c0                	test   %eax,%eax
    3e3d:	75 0c                	jne    3e4b <addClickable+0x58>
        {
            c->ID = 1;
    3e3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e42:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    3e49:	eb 12                	jmp    3e5d <addClickable+0x6a>
        }
        else
        {
            c->ID = c->next->ID + 1;
    3e4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e4e:	8b 40 18             	mov    0x18(%eax),%eax
    3e51:	8b 40 14             	mov    0x14(%eax),%eax
    3e54:	8d 50 01             	lea    0x1(%eax),%edx
    3e57:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e5a:	89 50 14             	mov    %edx,0x14(%eax)
        }
	*head = c;
    3e5d:	8b 45 08             	mov    0x8(%ebp),%eax
    3e60:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3e63:	89 10                	mov    %edx,(%eax)
}
    3e65:	c9                   	leave  
    3e66:	c3                   	ret    

00003e67 <deleteClickable>:

void deleteClickable(Clickable **head, Rect region)
{
    3e67:	55                   	push   %ebp
    3e68:	89 e5                	mov    %esp,%ebp
    3e6a:	83 ec 38             	sub    $0x38,%esp
	Clickable *prev, *cur, *temp;
	prev = cur = *head;
    3e6d:	8b 45 08             	mov    0x8(%ebp),%eax
    3e70:	8b 00                	mov    (%eax),%eax
    3e72:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3e75:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3e78:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (cur != 0)
    3e7b:	e9 bb 00 00 00       	jmp    3f3b <deleteClickable+0xd4>
	{
		if (isIn(cur->area.start, region))
    3e80:	8b 45 0c             	mov    0xc(%ebp),%eax
    3e83:	89 44 24 08          	mov    %eax,0x8(%esp)
    3e87:	8b 45 10             	mov    0x10(%ebp),%eax
    3e8a:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3e8e:	8b 45 14             	mov    0x14(%ebp),%eax
    3e91:	89 44 24 10          	mov    %eax,0x10(%esp)
    3e95:	8b 45 18             	mov    0x18(%ebp),%eax
    3e98:	89 44 24 14          	mov    %eax,0x14(%esp)
    3e9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3e9f:	8b 50 04             	mov    0x4(%eax),%edx
    3ea2:	8b 00                	mov    (%eax),%eax
    3ea4:	89 04 24             	mov    %eax,(%esp)
    3ea7:	89 54 24 04          	mov    %edx,0x4(%esp)
    3eab:	e8 e8 fd ff ff       	call   3c98 <isIn>
    3eb0:	85 c0                	test   %eax,%eax
    3eb2:	74 60                	je     3f14 <deleteClickable+0xad>
		{
			//如果当前指针指向头部
			if (cur == *head)
    3eb4:	8b 45 08             	mov    0x8(%ebp),%eax
    3eb7:	8b 00                	mov    (%eax),%eax
    3eb9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    3ebc:	75 2e                	jne    3eec <deleteClickable+0x85>
			{
				//删除头节点
				temp = *head;
    3ebe:	8b 45 08             	mov    0x8(%ebp),%eax
    3ec1:	8b 00                	mov    (%eax),%eax
    3ec3:	89 45 ec             	mov    %eax,-0x14(%ebp)
				*head = cur->next;
    3ec6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3ec9:	8b 50 18             	mov    0x18(%eax),%edx
    3ecc:	8b 45 08             	mov    0x8(%ebp),%eax
    3ecf:	89 10                	mov    %edx,(%eax)
				cur = prev = *head;
    3ed1:	8b 45 08             	mov    0x8(%ebp),%eax
    3ed4:	8b 00                	mov    (%eax),%eax
    3ed6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3ed9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3edc:	89 45 f0             	mov    %eax,-0x10(%ebp)
				free(temp);
    3edf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3ee2:	89 04 24             	mov    %eax,(%esp)
    3ee5:	e8 13 0f 00 00       	call   4dfd <free>
    3eea:	eb 4f                	jmp    3f3b <deleteClickable+0xd4>
			}
			else
			{
				//删除当前节点
				prev->next = cur->next;
    3eec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3eef:	8b 50 18             	mov    0x18(%eax),%edx
    3ef2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ef5:	89 50 18             	mov    %edx,0x18(%eax)
				temp = cur;
    3ef8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3efb:	89 45 ec             	mov    %eax,-0x14(%ebp)
				cur = cur->next;
    3efe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3f01:	8b 40 18             	mov    0x18(%eax),%eax
    3f04:	89 45 f0             	mov    %eax,-0x10(%ebp)
				free(temp);
    3f07:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3f0a:	89 04 24             	mov    %eax,(%esp)
    3f0d:	e8 eb 0e 00 00       	call   4dfd <free>
    3f12:	eb 27                	jmp    3f3b <deleteClickable+0xd4>
			}
		}
		else
		{
			//如果当前节点是头节点，
			if (cur == *head)
    3f14:	8b 45 08             	mov    0x8(%ebp),%eax
    3f17:	8b 00                	mov    (%eax),%eax
    3f19:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    3f1c:	75 0b                	jne    3f29 <deleteClickable+0xc2>
			{
				cur = cur->next;
    3f1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3f21:	8b 40 18             	mov    0x18(%eax),%eax
    3f24:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3f27:	eb 12                	jmp    3f3b <deleteClickable+0xd4>
			}
			else
			{
				cur = cur->next;
    3f29:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3f2c:	8b 40 18             	mov    0x18(%eax),%eax
    3f2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
				prev = prev->next;
    3f32:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3f35:	8b 40 18             	mov    0x18(%eax),%eax
    3f38:	89 45 f4             	mov    %eax,-0xc(%ebp)

void deleteClickable(Clickable **head, Rect region)
{
	Clickable *prev, *cur, *temp;
	prev = cur = *head;
	while (cur != 0)
    3f3b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3f3f:	0f 85 3b ff ff ff    	jne    3e80 <deleteClickable+0x19>
				cur = cur->next;
				prev = prev->next;
			}
		}
	}
}
    3f45:	c9                   	leave  
    3f46:	c3                   	ret    

00003f47 <executeHandler>:

int executeHandler(Clickable *head, Point click)
{
    3f47:	55                   	push   %ebp
    3f48:	89 e5                	mov    %esp,%ebp
    3f4a:	83 ec 38             	sub    $0x38,%esp
	Clickable *cur = head;
    3f4d:	8b 45 08             	mov    0x8(%ebp),%eax
    3f50:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (cur != 0)
    3f53:	eb 6e                	jmp    3fc3 <executeHandler+0x7c>
	{
		if (isIn(click, cur->area))
    3f55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3f58:	8b 10                	mov    (%eax),%edx
    3f5a:	89 54 24 08          	mov    %edx,0x8(%esp)
    3f5e:	8b 50 04             	mov    0x4(%eax),%edx
    3f61:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3f65:	8b 50 08             	mov    0x8(%eax),%edx
    3f68:	89 54 24 10          	mov    %edx,0x10(%esp)
    3f6c:	8b 40 0c             	mov    0xc(%eax),%eax
    3f6f:	89 44 24 14          	mov    %eax,0x14(%esp)
    3f73:	8b 45 0c             	mov    0xc(%ebp),%eax
    3f76:	8b 55 10             	mov    0x10(%ebp),%edx
    3f79:	89 04 24             	mov    %eax,(%esp)
    3f7c:	89 54 24 04          	mov    %edx,0x4(%esp)
    3f80:	e8 13 fd ff ff       	call   3c98 <isIn>
    3f85:	85 c0                	test   %eax,%eax
    3f87:	74 31                	je     3fba <executeHandler+0x73>
		{
			renaming = 0;
    3f89:	c7 05 24 29 01 00 00 	movl   $0x0,0x12924
    3f90:	00 00 00 
			isSearching = 0;
    3f93:	c7 05 20 29 01 00 00 	movl   $0x0,0x12920
    3f9a:	00 00 00 
			cur->handler(click);
    3f9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3fa0:	8b 48 10             	mov    0x10(%eax),%ecx
    3fa3:	8b 45 0c             	mov    0xc(%ebp),%eax
    3fa6:	8b 55 10             	mov    0x10(%ebp),%edx
    3fa9:	89 04 24             	mov    %eax,(%esp)
    3fac:	89 54 24 04          	mov    %edx,0x4(%esp)
    3fb0:	ff d1                	call   *%ecx
			return cur->ID;
    3fb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3fb5:	8b 40 14             	mov    0x14(%eax),%eax
    3fb8:	eb 4d                	jmp    4007 <executeHandler+0xc0>
		}
		cur = cur->next;
    3fba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3fbd:	8b 40 18             	mov    0x18(%eax),%eax
    3fc0:	89 45 f4             	mov    %eax,-0xc(%ebp)
}

int executeHandler(Clickable *head, Point click)
{
	Clickable *cur = head;
	while (cur != 0)
    3fc3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3fc7:	75 8c                	jne    3f55 <executeHandler+0xe>
			cur->handler(click);
			return cur->ID;
		}
		cur = cur->next;
	}
	isSearching = 0;
    3fc9:	c7 05 20 29 01 00 00 	movl   $0x0,0x12920
    3fd0:	00 00 00 
	if (renaming == 1){
    3fd3:	a1 24 29 01 00       	mov    0x12924,%eax
    3fd8:	83 f8 01             	cmp    $0x1,%eax
    3fdb:	75 11                	jne    3fee <executeHandler+0xa7>
		renaming = 0;
    3fdd:	c7 05 24 29 01 00 00 	movl   $0x0,0x12924
    3fe4:	00 00 00 
		return -1;
    3fe7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3fec:	eb 19                	jmp    4007 <executeHandler+0xc0>
	}
	printf(0, "execute: none!\n");
    3fee:	c7 44 24 04 be b7 00 	movl   $0xb7be,0x4(%esp)
    3ff5:	00 
    3ff6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3ffd:	e8 48 0c 00 00       	call   4c4a <printf>
	return 0;
    4002:	b8 00 00 00 00       	mov    $0x0,%eax
}
    4007:	c9                   	leave  
    4008:	c3                   	ret    

00004009 <printClickable>:

void printClickable(Clickable *c)
{
    4009:	55                   	push   %ebp
    400a:	89 e5                	mov    %esp,%ebp
    400c:	53                   	push   %ebx
    400d:	83 ec 24             	sub    $0x24,%esp
	printf(0, "(%d, %d, %d, %d)\n", c->area.start.x, c->area.start.y, c->area.width, c->area.height);
    4010:	8b 45 08             	mov    0x8(%ebp),%eax
    4013:	8b 58 0c             	mov    0xc(%eax),%ebx
    4016:	8b 45 08             	mov    0x8(%ebp),%eax
    4019:	8b 48 08             	mov    0x8(%eax),%ecx
    401c:	8b 45 08             	mov    0x8(%ebp),%eax
    401f:	8b 50 04             	mov    0x4(%eax),%edx
    4022:	8b 45 08             	mov    0x8(%ebp),%eax
    4025:	8b 00                	mov    (%eax),%eax
    4027:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    402b:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    402f:	89 54 24 0c          	mov    %edx,0xc(%esp)
    4033:	89 44 24 08          	mov    %eax,0x8(%esp)
    4037:	c7 44 24 04 ce b7 00 	movl   $0xb7ce,0x4(%esp)
    403e:	00 
    403f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4046:	e8 ff 0b 00 00       	call   4c4a <printf>
}
    404b:	83 c4 24             	add    $0x24,%esp
    404e:	5b                   	pop    %ebx
    404f:	5d                   	pop    %ebp
    4050:	c3                   	ret    

00004051 <printClickableList>:

void printClickableList(Clickable *head)
{
    4051:	55                   	push   %ebp
    4052:	89 e5                	mov    %esp,%ebp
    4054:	83 ec 28             	sub    $0x28,%esp
	Clickable *cur = head;
    4057:	8b 45 08             	mov    0x8(%ebp),%eax
    405a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(0, "Clickable List:\n");
    405d:	c7 44 24 04 e0 b7 00 	movl   $0xb7e0,0x4(%esp)
    4064:	00 
    4065:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    406c:	e8 d9 0b 00 00       	call   4c4a <printf>
	while(cur != 0)
    4071:	eb 14                	jmp    4087 <printClickableList+0x36>
	{
		printClickable(cur);
    4073:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4076:	89 04 24             	mov    %eax,(%esp)
    4079:	e8 8b ff ff ff       	call   4009 <printClickable>
		cur = cur->next;
    407e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4081:	8b 40 18             	mov    0x18(%eax),%eax
    4084:	89 45 f4             	mov    %eax,-0xc(%ebp)

void printClickableList(Clickable *head)
{
	Clickable *cur = head;
	printf(0, "Clickable List:\n");
	while(cur != 0)
    4087:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    408b:	75 e6                	jne    4073 <printClickableList+0x22>
	{
		printClickable(cur);
		cur = cur->next;
	}
	printf(0, "\n");
    408d:	c7 44 24 04 f1 b7 00 	movl   $0xb7f1,0x4(%esp)
    4094:	00 
    4095:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    409c:	e8 a9 0b 00 00       	call   4c4a <printf>
}
    40a1:	c9                   	leave  
    40a2:	c3                   	ret    

000040a3 <testHanler>:

void testHanler(struct Point p)
{
    40a3:	55                   	push   %ebp
    40a4:	89 e5                	mov    %esp,%ebp
    40a6:	83 ec 18             	sub    $0x18,%esp
	printf(0, "execute: (%d, %d)!\n", p.x, p.y);
    40a9:	8b 55 0c             	mov    0xc(%ebp),%edx
    40ac:	8b 45 08             	mov    0x8(%ebp),%eax
    40af:	89 54 24 0c          	mov    %edx,0xc(%esp)
    40b3:	89 44 24 08          	mov    %eax,0x8(%esp)
    40b7:	c7 44 24 04 f3 b7 00 	movl   $0xb7f3,0x4(%esp)
    40be:	00 
    40bf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    40c6:	e8 7f 0b 00 00       	call   4c4a <printf>
}
    40cb:	c9                   	leave  
    40cc:	c3                   	ret    

000040cd <testClickable>:
void testClickable(struct Context c)
{
    40cd:	55                   	push   %ebp
    40ce:	89 e5                	mov    %esp,%ebp
    40d0:	81 ec 98 00 00 00    	sub    $0x98,%esp
	ClickableManager cm = initClickManager(c);
    40d6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    40d9:	8b 55 08             	mov    0x8(%ebp),%edx
    40dc:	89 54 24 04          	mov    %edx,0x4(%esp)
    40e0:	8b 55 0c             	mov    0xc(%ebp),%edx
    40e3:	89 54 24 08          	mov    %edx,0x8(%esp)
    40e7:	8b 55 10             	mov    0x10(%ebp),%edx
    40ea:	89 54 24 0c          	mov    %edx,0xc(%esp)
    40ee:	89 04 24             	mov    %eax,(%esp)
    40f1:	e8 e5 fb ff ff       	call   3cdb <initClickManager>
    40f6:	83 ec 04             	sub    $0x4,%esp

	Rect r1 = initRect(5,5,20,20);
    40f9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    40fc:	c7 44 24 10 14 00 00 	movl   $0x14,0x10(%esp)
    4103:	00 
    4104:	c7 44 24 0c 14 00 00 	movl   $0x14,0xc(%esp)
    410b:	00 
    410c:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    4113:	00 
    4114:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    411b:	00 
    411c:	89 04 24             	mov    %eax,(%esp)
    411f:	e8 19 fb ff ff       	call   3c3d <initRect>
    4124:	83 ec 04             	sub    $0x4,%esp
	Rect r2 = initRect(20,20,20,20);
    4127:	8d 45 c4             	lea    -0x3c(%ebp),%eax
    412a:	c7 44 24 10 14 00 00 	movl   $0x14,0x10(%esp)
    4131:	00 
    4132:	c7 44 24 0c 14 00 00 	movl   $0x14,0xc(%esp)
    4139:	00 
    413a:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
    4141:	00 
    4142:	c7 44 24 04 14 00 00 	movl   $0x14,0x4(%esp)
    4149:	00 
    414a:	89 04 24             	mov    %eax,(%esp)
    414d:	e8 eb fa ff ff       	call   3c3d <initRect>
    4152:	83 ec 04             	sub    $0x4,%esp
	Rect r3 = initRect(50,50,15,15);
    4155:	8d 45 b4             	lea    -0x4c(%ebp),%eax
    4158:	c7 44 24 10 0f 00 00 	movl   $0xf,0x10(%esp)
    415f:	00 
    4160:	c7 44 24 0c 0f 00 00 	movl   $0xf,0xc(%esp)
    4167:	00 
    4168:	c7 44 24 08 32 00 00 	movl   $0x32,0x8(%esp)
    416f:	00 
    4170:	c7 44 24 04 32 00 00 	movl   $0x32,0x4(%esp)
    4177:	00 
    4178:	89 04 24             	mov    %eax,(%esp)
    417b:	e8 bd fa ff ff       	call   3c3d <initRect>
    4180:	83 ec 04             	sub    $0x4,%esp
	Rect r4 = initRect(0,0,30,30);
    4183:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    4186:	c7 44 24 10 1e 00 00 	movl   $0x1e,0x10(%esp)
    418d:	00 
    418e:	c7 44 24 0c 1e 00 00 	movl   $0x1e,0xc(%esp)
    4195:	00 
    4196:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    419d:	00 
    419e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    41a5:	00 
    41a6:	89 04 24             	mov    %eax,(%esp)
    41a9:	e8 8f fa ff ff       	call   3c3d <initRect>
    41ae:	83 ec 04             	sub    $0x4,%esp
	Point p1 = initPoint(23, 23);
    41b1:	8d 45 9c             	lea    -0x64(%ebp),%eax
    41b4:	c7 44 24 08 17 00 00 	movl   $0x17,0x8(%esp)
    41bb:	00 
    41bc:	c7 44 24 04 17 00 00 	movl   $0x17,0x4(%esp)
    41c3:	00 
    41c4:	89 04 24             	mov    %eax,(%esp)
    41c7:	e8 4a fa ff ff       	call   3c16 <initPoint>
    41cc:	83 ec 04             	sub    $0x4,%esp
	Point p2 = initPoint(70, 70);
    41cf:	8d 45 94             	lea    -0x6c(%ebp),%eax
    41d2:	c7 44 24 08 46 00 00 	movl   $0x46,0x8(%esp)
    41d9:	00 
    41da:	c7 44 24 04 46 00 00 	movl   $0x46,0x4(%esp)
    41e1:	00 
    41e2:	89 04 24             	mov    %eax,(%esp)
    41e5:	e8 2c fa ff ff       	call   3c16 <initPoint>
    41ea:	83 ec 04             	sub    $0x4,%esp
	createClickable(&cm, r1, MSG_LPRESS, &testHanler);
    41ed:	c7 44 24 18 a3 40 00 	movl   $0x40a3,0x18(%esp)
    41f4:	00 
    41f5:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    41fc:	00 
    41fd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    4200:	89 44 24 04          	mov    %eax,0x4(%esp)
    4204:	8b 45 d8             	mov    -0x28(%ebp),%eax
    4207:	89 44 24 08          	mov    %eax,0x8(%esp)
    420b:	8b 45 dc             	mov    -0x24(%ebp),%eax
    420e:	89 44 24 0c          	mov    %eax,0xc(%esp)
    4212:	8b 45 e0             	mov    -0x20(%ebp),%eax
    4215:	89 44 24 10          	mov    %eax,0x10(%esp)
    4219:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    421c:	89 04 24             	mov    %eax,(%esp)
    421f:	e8 05 fb ff ff       	call   3d29 <createClickable>
	printf(0, "left_click: %d\n", cm.left_click);
    4224:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4227:	89 44 24 08          	mov    %eax,0x8(%esp)
    422b:	c7 44 24 04 07 b8 00 	movl   $0xb807,0x4(%esp)
    4232:	00 
    4233:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    423a:	e8 0b 0a 00 00       	call   4c4a <printf>
	createClickable(&cm, r2, MSG_LPRESS, &testHanler);
    423f:	c7 44 24 18 a3 40 00 	movl   $0x40a3,0x18(%esp)
    4246:	00 
    4247:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    424e:	00 
    424f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    4252:	89 44 24 04          	mov    %eax,0x4(%esp)
    4256:	8b 45 c8             	mov    -0x38(%ebp),%eax
    4259:	89 44 24 08          	mov    %eax,0x8(%esp)
    425d:	8b 45 cc             	mov    -0x34(%ebp),%eax
    4260:	89 44 24 0c          	mov    %eax,0xc(%esp)
    4264:	8b 45 d0             	mov    -0x30(%ebp),%eax
    4267:	89 44 24 10          	mov    %eax,0x10(%esp)
    426b:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    426e:	89 04 24             	mov    %eax,(%esp)
    4271:	e8 b3 fa ff ff       	call   3d29 <createClickable>
	printf(0, "left_click: %d\n", cm.left_click);
    4276:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4279:	89 44 24 08          	mov    %eax,0x8(%esp)
    427d:	c7 44 24 04 07 b8 00 	movl   $0xb807,0x4(%esp)
    4284:	00 
    4285:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    428c:	e8 b9 09 00 00       	call   4c4a <printf>
	createClickable(&cm, r3, MSG_LPRESS, &testHanler);
    4291:	c7 44 24 18 a3 40 00 	movl   $0x40a3,0x18(%esp)
    4298:	00 
    4299:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    42a0:	00 
    42a1:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    42a4:	89 44 24 04          	mov    %eax,0x4(%esp)
    42a8:	8b 45 b8             	mov    -0x48(%ebp),%eax
    42ab:	89 44 24 08          	mov    %eax,0x8(%esp)
    42af:	8b 45 bc             	mov    -0x44(%ebp),%eax
    42b2:	89 44 24 0c          	mov    %eax,0xc(%esp)
    42b6:	8b 45 c0             	mov    -0x40(%ebp),%eax
    42b9:	89 44 24 10          	mov    %eax,0x10(%esp)
    42bd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    42c0:	89 04 24             	mov    %eax,(%esp)
    42c3:	e8 61 fa ff ff       	call   3d29 <createClickable>
	printf(0, "left_click: %d\n", cm.left_click);
    42c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    42cb:	89 44 24 08          	mov    %eax,0x8(%esp)
    42cf:	c7 44 24 04 07 b8 00 	movl   $0xb807,0x4(%esp)
    42d6:	00 
    42d7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    42de:	e8 67 09 00 00       	call   4c4a <printf>
	printClickableList(cm.left_click);
    42e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    42e6:	89 04 24             	mov    %eax,(%esp)
    42e9:	e8 63 fd ff ff       	call   4051 <printClickableList>
	executeHandler(cm.left_click, p1);
    42ee:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    42f1:	8b 45 9c             	mov    -0x64(%ebp),%eax
    42f4:	8b 55 a0             	mov    -0x60(%ebp),%edx
    42f7:	89 44 24 04          	mov    %eax,0x4(%esp)
    42fb:	89 54 24 08          	mov    %edx,0x8(%esp)
    42ff:	89 0c 24             	mov    %ecx,(%esp)
    4302:	e8 40 fc ff ff       	call   3f47 <executeHandler>
	executeHandler(cm.left_click, p2);
    4307:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    430a:	8b 45 94             	mov    -0x6c(%ebp),%eax
    430d:	8b 55 98             	mov    -0x68(%ebp),%edx
    4310:	89 44 24 04          	mov    %eax,0x4(%esp)
    4314:	89 54 24 08          	mov    %edx,0x8(%esp)
    4318:	89 0c 24             	mov    %ecx,(%esp)
    431b:	e8 27 fc ff ff       	call   3f47 <executeHandler>
	deleteClickable(&cm.left_click, r4);
    4320:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    4323:	89 44 24 04          	mov    %eax,0x4(%esp)
    4327:	8b 45 a8             	mov    -0x58(%ebp),%eax
    432a:	89 44 24 08          	mov    %eax,0x8(%esp)
    432e:	8b 45 ac             	mov    -0x54(%ebp),%eax
    4331:	89 44 24 0c          	mov    %eax,0xc(%esp)
    4335:	8b 45 b0             	mov    -0x50(%ebp),%eax
    4338:	89 44 24 10          	mov    %eax,0x10(%esp)
    433c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    433f:	89 04 24             	mov    %eax,(%esp)
    4342:	e8 20 fb ff ff       	call   3e67 <deleteClickable>
	printClickableList(cm.left_click);
    4347:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    434a:	89 04 24             	mov    %eax,(%esp)
    434d:	e8 ff fc ff ff       	call   4051 <printClickableList>
}
    4352:	c9                   	leave  
    4353:	c3                   	ret    

00004354 <init_tasklist>:

struct taskNode* taskLinkHead = 0;
struct taskNode* taskLinkTail = 0;

int init_tasklist()
{
    4354:	55                   	push   %ebp
    4355:	89 e5                	mov    %esp,%ebp
    4357:	83 ec 68             	sub    $0x68,%esp
    int fd;
    char nodeInfo[64];
    struct taskNode* tasknode;
    fd = open("tasklist.txt", O_RDONLY);
    435a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    4361:	00 
    4362:	c7 04 24 18 b8 00 00 	movl   $0xb818,(%esp)
    4369:	e8 2c 07 00 00       	call   4a9a <open>
    436e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (fd < 0)
    4371:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4375:	79 08                	jns    437f <init_tasklist+0x2b>
    {
        return fd;
    4377:	8b 45 f0             	mov    -0x10(%ebp),%eax
    437a:	e9 e8 00 00 00       	jmp    4467 <init_tasklist+0x113>
    }  
    read(fd, nodeInfo, 64);
    437f:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
    4386:	00 
    4387:	8d 45 ac             	lea    -0x54(%ebp),%eax
    438a:	89 44 24 04          	mov    %eax,0x4(%esp)
    438e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4391:	89 04 24             	mov    %eax,(%esp)
    4394:	e8 d9 06 00 00       	call   4a72 <read>
    if (nodeInfo[1] == ' ')
    4399:	0f b6 45 ad          	movzbl -0x53(%ebp),%eax
    439d:	3c 20                	cmp    $0x20,%al
    439f:	75 1e                	jne    43bf <init_tasklist+0x6b>
    {
        taskLinkHead = 0;
    43a1:	c7 05 34 f7 00 00 00 	movl   $0x0,0xf734
    43a8:	00 00 00 
        taskLinkTail = 0;
    43ab:	c7 05 38 f7 00 00 00 	movl   $0x0,0xf738
    43b2:	00 00 00 
        return 0;
    43b5:	b8 00 00 00 00       	mov    $0x0,%eax
    43ba:	e9 a8 00 00 00       	jmp    4467 <init_tasklist+0x113>
    }
    int i = 0;
    43bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (nodeInfo[i] != '\0')
    43c6:	eb 7e                	jmp    4446 <init_tasklist+0xf2>
    {
        tasknode = (TASKNODE*)malloc(sizeof(TASKNODE));
    43c8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    43cf:	e8 62 0b 00 00       	call   4f36 <malloc>
    43d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if (i == 0)
    43d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    43db:	75 32                	jne    440f <init_tasklist+0xbb>
        {
            tasknode->next = 0;
    43dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    43e0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            tasknode->appID = nodeInfo[i] - '0';
    43e7:	8d 55 ac             	lea    -0x54(%ebp),%edx
    43ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43ed:	01 d0                	add    %edx,%eax
    43ef:	0f b6 00             	movzbl (%eax),%eax
    43f2:	0f be c0             	movsbl %al,%eax
    43f5:	8d 50 d0             	lea    -0x30(%eax),%edx
    43f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    43fb:	89 10                	mov    %edx,(%eax)
            taskLinkHead = tasknode;
    43fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4400:	a3 34 f7 00 00       	mov    %eax,0xf734
            taskLinkTail = tasknode;
    4405:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4408:	a3 38 f7 00 00       	mov    %eax,0xf738
    440d:	eb 33                	jmp    4442 <init_tasklist+0xee>
        }
        else
        {
            tasknode->next = 0;
    440f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4412:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            tasknode->appID = nodeInfo[i] - '0';
    4419:	8d 55 ac             	lea    -0x54(%ebp),%edx
    441c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    441f:	01 d0                	add    %edx,%eax
    4421:	0f b6 00             	movzbl (%eax),%eax
    4424:	0f be c0             	movsbl %al,%eax
    4427:	8d 50 d0             	lea    -0x30(%eax),%edx
    442a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    442d:	89 10                	mov    %edx,(%eax)
            taskLinkTail->next = tasknode;
    442f:	a1 38 f7 00 00       	mov    0xf738,%eax
    4434:	8b 55 ec             	mov    -0x14(%ebp),%edx
    4437:	89 50 04             	mov    %edx,0x4(%eax)
            taskLinkTail = tasknode;
    443a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    443d:	a3 38 f7 00 00       	mov    %eax,0xf738
        }
        i++;
    4442:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        taskLinkHead = 0;
        taskLinkTail = 0;
        return 0;
    }
    int i = 0;
    while (nodeInfo[i] != '\0')
    4446:	8d 55 ac             	lea    -0x54(%ebp),%edx
    4449:	8b 45 f4             	mov    -0xc(%ebp),%eax
    444c:	01 d0                	add    %edx,%eax
    444e:	0f b6 00             	movzbl (%eax),%eax
    4451:	84 c0                	test   %al,%al
    4453:	0f 85 6f ff ff ff    	jne    43c8 <init_tasklist+0x74>
            taskLinkTail->next = tasknode;
            taskLinkTail = tasknode;
        }
        i++;
    }
    close(fd);
    4459:	8b 45 f0             	mov    -0x10(%ebp),%eax
    445c:	89 04 24             	mov    %eax,(%esp)
    445f:	e8 1e 06 00 00       	call   4a82 <close>
    return i;
    4464:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    4467:	c9                   	leave  
    4468:	c3                   	ret    

00004469 <add_tasknodeToTail>:

void add_tasknodeToTail(int appID)
{
    4469:	55                   	push   %ebp
    446a:	89 e5                	mov    %esp,%ebp
    446c:	83 ec 28             	sub    $0x28,%esp
    printf(0, "add_tasknode called\n");
    446f:	c7 44 24 04 25 b8 00 	movl   $0xb825,0x4(%esp)
    4476:	00 
    4477:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    447e:	e8 c7 07 00 00       	call   4c4a <printf>
    struct taskNode* tasknode = (TASKNODE*)malloc(sizeof(TASKNODE));
    4483:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    448a:	e8 a7 0a 00 00       	call   4f36 <malloc>
    448f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (taskLinkHead == 0)
    4492:	a1 34 f7 00 00       	mov    0xf734,%eax
    4497:	85 c0                	test   %eax,%eax
    4499:	75 3f                	jne    44da <add_tasknodeToTail+0x71>
    {
        printf(0, "inserting into list %d\n", (int)tasknode);
    449b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    449e:	89 44 24 08          	mov    %eax,0x8(%esp)
    44a2:	c7 44 24 04 3a b8 00 	movl   $0xb83a,0x4(%esp)
    44a9:	00 
    44aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    44b1:	e8 94 07 00 00       	call   4c4a <printf>
        tasknode->next = 0;
    44b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44b9:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
        tasknode->appID = appID;
    44c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44c3:	8b 55 08             	mov    0x8(%ebp),%edx
    44c6:	89 10                	mov    %edx,(%eax)
        taskLinkHead = tasknode;
    44c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44cb:	a3 34 f7 00 00       	mov    %eax,0xf734
        taskLinkTail = tasknode;
    44d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44d3:	a3 38 f7 00 00       	mov    %eax,0xf738
    44d8:	eb 25                	jmp    44ff <add_tasknodeToTail+0x96>
    }
    else
    {
        tasknode->next = 0;
    44da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44dd:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
        tasknode->appID = appID;
    44e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44e7:	8b 55 08             	mov    0x8(%ebp),%edx
    44ea:	89 10                	mov    %edx,(%eax)
        taskLinkTail->next = tasknode;
    44ec:	a1 38 f7 00 00       	mov    0xf738,%eax
    44f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    44f4:	89 50 04             	mov    %edx,0x4(%eax)
        taskLinkTail = tasknode;
    44f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44fa:	a3 38 f7 00 00       	mov    %eax,0xf738
    }
    printf(0, "task added\n");
    44ff:	c7 44 24 04 52 b8 00 	movl   $0xb852,0x4(%esp)
    4506:	00 
    4507:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    450e:	e8 37 07 00 00       	call   4c4a <printf>
    save_tasklist();
    4513:	e8 1d 02 00 00       	call   4735 <save_tasklist>
}
    4518:	c9                   	leave  
    4519:	c3                   	ret    

0000451a <add_tasknode>:

void add_tasknode(int appID)
{
    451a:	55                   	push   %ebp
    451b:	89 e5                	mov    %esp,%ebp
    451d:	83 ec 28             	sub    $0x28,%esp
    struct taskNode* tasknode = (TASKNODE*)malloc(sizeof(TASKNODE));
    4520:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    4527:	e8 0a 0a 00 00       	call   4f36 <malloc>
    452c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    tasknode->next = taskLinkHead;
    452f:	8b 15 34 f7 00 00    	mov    0xf734,%edx
    4535:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4538:	89 50 04             	mov    %edx,0x4(%eax)
    tasknode->appID = appID;
    453b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    453e:	8b 55 08             	mov    0x8(%ebp),%edx
    4541:	89 10                	mov    %edx,(%eax)
    if (taskLinkHead == 0)
    4543:	a1 34 f7 00 00       	mov    0xf734,%eax
    4548:	85 c0                	test   %eax,%eax
    454a:	75 08                	jne    4554 <add_tasknode+0x3a>
    {
        taskLinkTail = tasknode;
    454c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    454f:	a3 38 f7 00 00       	mov    %eax,0xf738
    }
    taskLinkHead = tasknode;
    4554:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4557:	a3 34 f7 00 00       	mov    %eax,0xf734
    save_tasklist();
    455c:	e8 d4 01 00 00       	call   4735 <save_tasklist>
}
    4561:	c9                   	leave  
    4562:	c3                   	ret    

00004563 <delete_tasknode>:

void delete_tasknode(int appID)
{
    4563:	55                   	push   %ebp
    4564:	89 e5                	mov    %esp,%ebp
    4566:	83 ec 28             	sub    $0x28,%esp
    printf(0, "delete_tasknode called\n");
    4569:	c7 44 24 04 5e b8 00 	movl   $0xb85e,0x4(%esp)
    4570:	00 
    4571:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4578:	e8 cd 06 00 00       	call   4c4a <printf>
    if (taskLinkHead == 0)
    457d:	a1 34 f7 00 00       	mov    0xf734,%eax
    4582:	85 c0                	test   %eax,%eax
    4584:	75 19                	jne    459f <delete_tasknode+0x3c>
    {
        printf(0, "delete error: nothing to delete\n");
    4586:	c7 44 24 04 78 b8 00 	movl   $0xb878,0x4(%esp)
    458d:	00 
    458e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4595:	e8 b0 06 00 00       	call   4c4a <printf>
        return;
    459a:	e9 bf 00 00 00       	jmp    465e <delete_tasknode+0xfb>
    }
    struct taskNode* tasknode = taskLinkHead;
    459f:	a1 34 f7 00 00       	mov    0xf734,%eax
    45a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    struct taskNode* previousTasknode = 0;
    45a7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    while (tasknode != 0)
    45ae:	eb 1b                	jmp    45cb <delete_tasknode+0x68>
    {
        if (tasknode->appID == appID)
    45b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    45b3:	8b 00                	mov    (%eax),%eax
    45b5:	3b 45 08             	cmp    0x8(%ebp),%eax
    45b8:	75 02                	jne    45bc <delete_tasknode+0x59>
        {
            break;
    45ba:	eb 15                	jmp    45d1 <delete_tasknode+0x6e>
        }
        previousTasknode = tasknode;
    45bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    45bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
        tasknode = tasknode->next;
    45c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    45c5:	8b 40 04             	mov    0x4(%eax),%eax
    45c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        printf(0, "delete error: nothing to delete\n");
        return;
    }
    struct taskNode* tasknode = taskLinkHead;
    struct taskNode* previousTasknode = 0;
    while (tasknode != 0)
    45cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    45cf:	75 df                	jne    45b0 <delete_tasknode+0x4d>
            break;
        }
        previousTasknode = tasknode;
        tasknode = tasknode->next;
    }
    if (tasknode == 0)
    45d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    45d5:	75 16                	jne    45ed <delete_tasknode+0x8a>
    {
        printf(0, "delete error: no such app to delete\n");
    45d7:	c7 44 24 04 9c b8 00 	movl   $0xb89c,0x4(%esp)
    45de:	00 
    45df:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    45e6:	e8 5f 06 00 00       	call   4c4a <printf>
        return;
    45eb:	eb 71                	jmp    465e <delete_tasknode+0xfb>
    }
    if (previousTasknode == 0)
    45ed:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    45f1:	75 2c                	jne    461f <delete_tasknode+0xbc>
    {
        taskLinkHead = tasknode->next;
    45f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    45f6:	8b 40 04             	mov    0x4(%eax),%eax
    45f9:	a3 34 f7 00 00       	mov    %eax,0xf734
        if (tasknode->next == 0)
    45fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4601:	8b 40 04             	mov    0x4(%eax),%eax
    4604:	85 c0                	test   %eax,%eax
    4606:	75 0a                	jne    4612 <delete_tasknode+0xaf>
        {
            taskLinkTail = 0;
    4608:	c7 05 38 f7 00 00 00 	movl   $0x0,0xf738
    460f:	00 00 00 
        }
        free(tasknode);
    4612:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4615:	89 04 24             	mov    %eax,(%esp)
    4618:	e8 e0 07 00 00       	call   4dfd <free>
    461d:	eb 2b                	jmp    464a <delete_tasknode+0xe7>
    }
    else
    {
        previousTasknode->next = tasknode->next;
    461f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4622:	8b 50 04             	mov    0x4(%eax),%edx
    4625:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4628:	89 50 04             	mov    %edx,0x4(%eax)
        if (tasknode->next == 0)
    462b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    462e:	8b 40 04             	mov    0x4(%eax),%eax
    4631:	85 c0                	test   %eax,%eax
    4633:	75 0a                	jne    463f <delete_tasknode+0xdc>
        {
            taskLinkTail = 0;
    4635:	c7 05 38 f7 00 00 00 	movl   $0x0,0xf738
    463c:	00 00 00 
        }
        free(tasknode);
    463f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4642:	89 04 24             	mov    %eax,(%esp)
    4645:	e8 b3 07 00 00       	call   4dfd <free>
    }
    printf(0, "delete finished\n");
    464a:	c7 44 24 04 c1 b8 00 	movl   $0xb8c1,0x4(%esp)
    4651:	00 
    4652:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4659:	e8 ec 05 00 00       	call   4c4a <printf>
//    save_tasklist();
}
    465e:	c9                   	leave  
    465f:	c3                   	ret    

00004660 <draw_tasklist>:

void draw_tasklist(struct Context context, PICNODE pic[])
{
    4660:	55                   	push   %ebp
    4661:	89 e5                	mov    %esp,%ebp
    4663:	83 ec 38             	sub    $0x38,%esp
    printf(0, "draw_tasknode called\n");
    4666:	c7 44 24 04 d2 b8 00 	movl   $0xb8d2,0x4(%esp)
    466d:	00 
    466e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4675:	e8 d0 05 00 00       	call   4c4a <printf>
    struct taskNode* tasknode = taskLinkHead;
    467a:	a1 34 f7 00 00       	mov    0xf734,%eax
    467f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (taskLinkHead == 0)
    4682:	a1 34 f7 00 00       	mov    0xf734,%eax
    4687:	85 c0                	test   %eax,%eax
    4689:	75 19                	jne    46a4 <draw_tasklist+0x44>
    {
        printf(0, "task draw error: nothing to draw\n");
    468b:	c7 44 24 04 e8 b8 00 	movl   $0xb8e8,0x4(%esp)
    4692:	00 
    4693:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    469a:	e8 ab 05 00 00       	call   4c4a <printf>
        return;
    469f:	e9 8f 00 00 00       	jmp    4733 <draw_tasklist+0xd3>
    }
    int i = 1;
    46a4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    while (tasknode != 0)
    46ab:	eb 6c                	jmp    4719 <draw_tasklist+0xb9>
    {
        draw_picture(context, pic[tasknode->appID - 1], 75*i, 550);
    46ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    46b0:	6b c8 4b             	imul   $0x4b,%eax,%ecx
    46b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    46b6:	8b 00                	mov    (%eax),%eax
    46b8:	89 c2                	mov    %eax,%edx
    46ba:	89 d0                	mov    %edx,%eax
    46bc:	01 c0                	add    %eax,%eax
    46be:	01 d0                	add    %edx,%eax
    46c0:	c1 e0 02             	shl    $0x2,%eax
    46c3:	8d 50 f4             	lea    -0xc(%eax),%edx
    46c6:	8b 45 14             	mov    0x14(%ebp),%eax
    46c9:	01 d0                	add    %edx,%eax
    46cb:	c7 44 24 1c 26 02 00 	movl   $0x226,0x1c(%esp)
    46d2:	00 
    46d3:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    46d7:	8b 10                	mov    (%eax),%edx
    46d9:	89 54 24 0c          	mov    %edx,0xc(%esp)
    46dd:	8b 50 04             	mov    0x4(%eax),%edx
    46e0:	89 54 24 10          	mov    %edx,0x10(%esp)
    46e4:	8b 40 08             	mov    0x8(%eax),%eax
    46e7:	89 44 24 14          	mov    %eax,0x14(%esp)
    46eb:	8b 45 08             	mov    0x8(%ebp),%eax
    46ee:	89 04 24             	mov    %eax,(%esp)
    46f1:	8b 45 0c             	mov    0xc(%ebp),%eax
    46f4:	89 44 24 04          	mov    %eax,0x4(%esp)
    46f8:	8b 45 10             	mov    0x10(%ebp),%eax
    46fb:	89 44 24 08          	mov    %eax,0x8(%esp)
    46ff:	e8 dd e4 ff ff       	call   2be1 <draw_picture>
        tasknode = tasknode->next;
    4704:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4707:	8b 40 04             	mov    0x4(%eax),%eax
    470a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        i++;
    470d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
        if (i == 11)
    4711:	83 7d f0 0b          	cmpl   $0xb,-0x10(%ebp)
    4715:	75 02                	jne    4719 <draw_tasklist+0xb9>
        {
            break;
    4717:	eb 06                	jmp    471f <draw_tasklist+0xbf>
    {
        printf(0, "task draw error: nothing to draw\n");
        return;
    }
    int i = 1;
    while (tasknode != 0)
    4719:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    471d:	75 8e                	jne    46ad <draw_tasklist+0x4d>
        if (i == 11)
        {
            break;
        }
    }
    printf(0, "draw finished\n");   
    471f:	c7 44 24 04 0a b9 00 	movl   $0xb90a,0x4(%esp)
    4726:	00 
    4727:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    472e:	e8 17 05 00 00       	call   4c4a <printf>
}
    4733:	c9                   	leave  
    4734:	c3                   	ret    

00004735 <save_tasklist>:

int save_tasklist()
{
    4735:	55                   	push   %ebp
    4736:	89 e5                	mov    %esp,%ebp
    4738:	81 ec 88 00 00 00    	sub    $0x88,%esp
    int fd;
    fd = open("tasklist.txt", O_WRONLY | O_CREATE);
    473e:	c7 44 24 04 01 02 00 	movl   $0x201,0x4(%esp)
    4745:	00 
    4746:	c7 04 24 18 b8 00 00 	movl   $0xb818,(%esp)
    474d:	e8 48 03 00 00       	call   4a9a <open>
    4752:	89 45 ec             	mov    %eax,-0x14(%ebp)
    struct taskNode* tasknode = taskLinkHead;
    4755:	a1 34 f7 00 00       	mov    0xf734,%eax
    475a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char nodeInfo[100];
    if (taskLinkHead == 0)
    475d:	a1 34 f7 00 00       	mov    0xf734,%eax
    4762:	85 c0                	test   %eax,%eax
    4764:	75 30                	jne    4796 <save_tasklist+0x61>
    {
        nodeInfo[0] = ' ';
    4766:	c6 45 88 20          	movb   $0x20,-0x78(%ebp)
        nodeInfo[1] = '\0';
    476a:	c6 45 89 00          	movb   $0x0,-0x77(%ebp)
        write(fd, nodeInfo, strlen(nodeInfo));
    476e:	8d 45 88             	lea    -0x78(%ebp),%eax
    4771:	89 04 24             	mov    %eax,(%esp)
    4774:	e8 0d 01 00 00       	call   4886 <strlen>
    4779:	89 44 24 08          	mov    %eax,0x8(%esp)
    477d:	8d 45 88             	lea    -0x78(%ebp),%eax
    4780:	89 44 24 04          	mov    %eax,0x4(%esp)
    4784:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4787:	89 04 24             	mov    %eax,(%esp)
    478a:	e8 eb 02 00 00       	call   4a7a <write>
        return 0;
    478f:	b8 00 00 00 00       	mov    $0x0,%eax
    4794:	eb 5a                	jmp    47f0 <save_tasklist+0xbb>
    }
    int i = 0;
    4796:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    while (tasknode != 0)
    479d:	eb 27                	jmp    47c6 <save_tasklist+0x91>
    {
        nodeInfo[i] = tasknode->appID + '0';
    479f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47a2:	8b 00                	mov    (%eax),%eax
    47a4:	83 c0 30             	add    $0x30,%eax
    47a7:	8d 4d 88             	lea    -0x78(%ebp),%ecx
    47aa:	8b 55 f0             	mov    -0x10(%ebp),%edx
    47ad:	01 ca                	add    %ecx,%edx
    47af:	88 02                	mov    %al,(%edx)
        tasknode = tasknode->next;
    47b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    47b4:	8b 40 04             	mov    0x4(%eax),%eax
    47b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        i++;
    47ba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
        if (i == 100)
    47be:	83 7d f0 64          	cmpl   $0x64,-0x10(%ebp)
    47c2:	75 02                	jne    47c6 <save_tasklist+0x91>
        {
            break;
    47c4:	eb 06                	jmp    47cc <save_tasklist+0x97>
        nodeInfo[1] = '\0';
        write(fd, nodeInfo, strlen(nodeInfo));
        return 0;
    }
    int i = 0;
    while (tasknode != 0)
    47c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    47ca:	75 d3                	jne    479f <save_tasklist+0x6a>
        if (i == 100)
        {
            break;
        }
    }
    write(fd, nodeInfo, strlen(nodeInfo));
    47cc:	8d 45 88             	lea    -0x78(%ebp),%eax
    47cf:	89 04 24             	mov    %eax,(%esp)
    47d2:	e8 af 00 00 00       	call   4886 <strlen>
    47d7:	89 44 24 08          	mov    %eax,0x8(%esp)
    47db:	8d 45 88             	lea    -0x78(%ebp),%eax
    47de:	89 44 24 04          	mov    %eax,0x4(%esp)
    47e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    47e5:	89 04 24             	mov    %eax,(%esp)
    47e8:	e8 8d 02 00 00       	call   4a7a <write>
    return i;
    47ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    47f0:	c9                   	leave  
    47f1:	c3                   	ret    

000047f2 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    47f2:	55                   	push   %ebp
    47f3:	89 e5                	mov    %esp,%ebp
    47f5:	57                   	push   %edi
    47f6:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    47f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
    47fa:	8b 55 10             	mov    0x10(%ebp),%edx
    47fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    4800:	89 cb                	mov    %ecx,%ebx
    4802:	89 df                	mov    %ebx,%edi
    4804:	89 d1                	mov    %edx,%ecx
    4806:	fc                   	cld    
    4807:	f3 aa                	rep stos %al,%es:(%edi)
    4809:	89 ca                	mov    %ecx,%edx
    480b:	89 fb                	mov    %edi,%ebx
    480d:	89 5d 08             	mov    %ebx,0x8(%ebp)
    4810:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    4813:	5b                   	pop    %ebx
    4814:	5f                   	pop    %edi
    4815:	5d                   	pop    %ebp
    4816:	c3                   	ret    

00004817 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    4817:	55                   	push   %ebp
    4818:	89 e5                	mov    %esp,%ebp
    481a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    481d:	8b 45 08             	mov    0x8(%ebp),%eax
    4820:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    4823:	90                   	nop
    4824:	8b 45 08             	mov    0x8(%ebp),%eax
    4827:	8d 50 01             	lea    0x1(%eax),%edx
    482a:	89 55 08             	mov    %edx,0x8(%ebp)
    482d:	8b 55 0c             	mov    0xc(%ebp),%edx
    4830:	8d 4a 01             	lea    0x1(%edx),%ecx
    4833:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    4836:	0f b6 12             	movzbl (%edx),%edx
    4839:	88 10                	mov    %dl,(%eax)
    483b:	0f b6 00             	movzbl (%eax),%eax
    483e:	84 c0                	test   %al,%al
    4840:	75 e2                	jne    4824 <strcpy+0xd>
    ;
  return os;
    4842:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    4845:	c9                   	leave  
    4846:	c3                   	ret    

00004847 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4847:	55                   	push   %ebp
    4848:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    484a:	eb 08                	jmp    4854 <strcmp+0xd>
    p++, q++;
    484c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    4850:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    4854:	8b 45 08             	mov    0x8(%ebp),%eax
    4857:	0f b6 00             	movzbl (%eax),%eax
    485a:	84 c0                	test   %al,%al
    485c:	74 10                	je     486e <strcmp+0x27>
    485e:	8b 45 08             	mov    0x8(%ebp),%eax
    4861:	0f b6 10             	movzbl (%eax),%edx
    4864:	8b 45 0c             	mov    0xc(%ebp),%eax
    4867:	0f b6 00             	movzbl (%eax),%eax
    486a:	38 c2                	cmp    %al,%dl
    486c:	74 de                	je     484c <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    486e:	8b 45 08             	mov    0x8(%ebp),%eax
    4871:	0f b6 00             	movzbl (%eax),%eax
    4874:	0f b6 d0             	movzbl %al,%edx
    4877:	8b 45 0c             	mov    0xc(%ebp),%eax
    487a:	0f b6 00             	movzbl (%eax),%eax
    487d:	0f b6 c0             	movzbl %al,%eax
    4880:	29 c2                	sub    %eax,%edx
    4882:	89 d0                	mov    %edx,%eax
}
    4884:	5d                   	pop    %ebp
    4885:	c3                   	ret    

00004886 <strlen>:

uint
strlen(char *s)
{
    4886:	55                   	push   %ebp
    4887:	89 e5                	mov    %esp,%ebp
    4889:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    488c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    4893:	eb 04                	jmp    4899 <strlen+0x13>
    4895:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    4899:	8b 55 fc             	mov    -0x4(%ebp),%edx
    489c:	8b 45 08             	mov    0x8(%ebp),%eax
    489f:	01 d0                	add    %edx,%eax
    48a1:	0f b6 00             	movzbl (%eax),%eax
    48a4:	84 c0                	test   %al,%al
    48a6:	75 ed                	jne    4895 <strlen+0xf>
    ;
  return n;
    48a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    48ab:	c9                   	leave  
    48ac:	c3                   	ret    

000048ad <memset>:

void*
memset(void *dst, int c, uint n)
{
    48ad:	55                   	push   %ebp
    48ae:	89 e5                	mov    %esp,%ebp
    48b0:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    48b3:	8b 45 10             	mov    0x10(%ebp),%eax
    48b6:	89 44 24 08          	mov    %eax,0x8(%esp)
    48ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    48bd:	89 44 24 04          	mov    %eax,0x4(%esp)
    48c1:	8b 45 08             	mov    0x8(%ebp),%eax
    48c4:	89 04 24             	mov    %eax,(%esp)
    48c7:	e8 26 ff ff ff       	call   47f2 <stosb>
  return dst;
    48cc:	8b 45 08             	mov    0x8(%ebp),%eax
}
    48cf:	c9                   	leave  
    48d0:	c3                   	ret    

000048d1 <strchr>:

char*
strchr(const char *s, char c)
{
    48d1:	55                   	push   %ebp
    48d2:	89 e5                	mov    %esp,%ebp
    48d4:	83 ec 04             	sub    $0x4,%esp
    48d7:	8b 45 0c             	mov    0xc(%ebp),%eax
    48da:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    48dd:	eb 14                	jmp    48f3 <strchr+0x22>
    if(*s == c)
    48df:	8b 45 08             	mov    0x8(%ebp),%eax
    48e2:	0f b6 00             	movzbl (%eax),%eax
    48e5:	3a 45 fc             	cmp    -0x4(%ebp),%al
    48e8:	75 05                	jne    48ef <strchr+0x1e>
      return (char*)s;
    48ea:	8b 45 08             	mov    0x8(%ebp),%eax
    48ed:	eb 13                	jmp    4902 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    48ef:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    48f3:	8b 45 08             	mov    0x8(%ebp),%eax
    48f6:	0f b6 00             	movzbl (%eax),%eax
    48f9:	84 c0                	test   %al,%al
    48fb:	75 e2                	jne    48df <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    48fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
    4902:	c9                   	leave  
    4903:	c3                   	ret    

00004904 <gets>:

char*
gets(char *buf, int max)
{
    4904:	55                   	push   %ebp
    4905:	89 e5                	mov    %esp,%ebp
    4907:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    490a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    4911:	eb 4c                	jmp    495f <gets+0x5b>
    cc = read(0, &c, 1);
    4913:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    491a:	00 
    491b:	8d 45 ef             	lea    -0x11(%ebp),%eax
    491e:	89 44 24 04          	mov    %eax,0x4(%esp)
    4922:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4929:	e8 44 01 00 00       	call   4a72 <read>
    492e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    4931:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4935:	7f 02                	jg     4939 <gets+0x35>
      break;
    4937:	eb 31                	jmp    496a <gets+0x66>
    buf[i++] = c;
    4939:	8b 45 f4             	mov    -0xc(%ebp),%eax
    493c:	8d 50 01             	lea    0x1(%eax),%edx
    493f:	89 55 f4             	mov    %edx,-0xc(%ebp)
    4942:	89 c2                	mov    %eax,%edx
    4944:	8b 45 08             	mov    0x8(%ebp),%eax
    4947:	01 c2                	add    %eax,%edx
    4949:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    494d:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    494f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    4953:	3c 0a                	cmp    $0xa,%al
    4955:	74 13                	je     496a <gets+0x66>
    4957:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    495b:	3c 0d                	cmp    $0xd,%al
    495d:	74 0b                	je     496a <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    495f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4962:	83 c0 01             	add    $0x1,%eax
    4965:	3b 45 0c             	cmp    0xc(%ebp),%eax
    4968:	7c a9                	jl     4913 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    496a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    496d:	8b 45 08             	mov    0x8(%ebp),%eax
    4970:	01 d0                	add    %edx,%eax
    4972:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    4975:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4978:	c9                   	leave  
    4979:	c3                   	ret    

0000497a <stat>:

int
stat(char *n, struct stat *st)
{
    497a:	55                   	push   %ebp
    497b:	89 e5                	mov    %esp,%ebp
    497d:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4980:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    4987:	00 
    4988:	8b 45 08             	mov    0x8(%ebp),%eax
    498b:	89 04 24             	mov    %eax,(%esp)
    498e:	e8 07 01 00 00       	call   4a9a <open>
    4993:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    4996:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    499a:	79 07                	jns    49a3 <stat+0x29>
    return -1;
    499c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    49a1:	eb 23                	jmp    49c6 <stat+0x4c>
  r = fstat(fd, st);
    49a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    49a6:	89 44 24 04          	mov    %eax,0x4(%esp)
    49aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    49ad:	89 04 24             	mov    %eax,(%esp)
    49b0:	e8 fd 00 00 00       	call   4ab2 <fstat>
    49b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    49b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    49bb:	89 04 24             	mov    %eax,(%esp)
    49be:	e8 bf 00 00 00       	call   4a82 <close>
  return r;
    49c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    49c6:	c9                   	leave  
    49c7:	c3                   	ret    

000049c8 <atoi>:

int
atoi(const char *s)
{
    49c8:	55                   	push   %ebp
    49c9:	89 e5                	mov    %esp,%ebp
    49cb:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    49ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    49d5:	eb 25                	jmp    49fc <atoi+0x34>
    n = n*10 + *s++ - '0';
    49d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
    49da:	89 d0                	mov    %edx,%eax
    49dc:	c1 e0 02             	shl    $0x2,%eax
    49df:	01 d0                	add    %edx,%eax
    49e1:	01 c0                	add    %eax,%eax
    49e3:	89 c1                	mov    %eax,%ecx
    49e5:	8b 45 08             	mov    0x8(%ebp),%eax
    49e8:	8d 50 01             	lea    0x1(%eax),%edx
    49eb:	89 55 08             	mov    %edx,0x8(%ebp)
    49ee:	0f b6 00             	movzbl (%eax),%eax
    49f1:	0f be c0             	movsbl %al,%eax
    49f4:	01 c8                	add    %ecx,%eax
    49f6:	83 e8 30             	sub    $0x30,%eax
    49f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    49fc:	8b 45 08             	mov    0x8(%ebp),%eax
    49ff:	0f b6 00             	movzbl (%eax),%eax
    4a02:	3c 2f                	cmp    $0x2f,%al
    4a04:	7e 0a                	jle    4a10 <atoi+0x48>
    4a06:	8b 45 08             	mov    0x8(%ebp),%eax
    4a09:	0f b6 00             	movzbl (%eax),%eax
    4a0c:	3c 39                	cmp    $0x39,%al
    4a0e:	7e c7                	jle    49d7 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    4a10:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    4a13:	c9                   	leave  
    4a14:	c3                   	ret    

00004a15 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    4a15:	55                   	push   %ebp
    4a16:	89 e5                	mov    %esp,%ebp
    4a18:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    4a1b:	8b 45 08             	mov    0x8(%ebp),%eax
    4a1e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    4a21:	8b 45 0c             	mov    0xc(%ebp),%eax
    4a24:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    4a27:	eb 17                	jmp    4a40 <memmove+0x2b>
    *dst++ = *src++;
    4a29:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4a2c:	8d 50 01             	lea    0x1(%eax),%edx
    4a2f:	89 55 fc             	mov    %edx,-0x4(%ebp)
    4a32:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4a35:	8d 4a 01             	lea    0x1(%edx),%ecx
    4a38:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    4a3b:	0f b6 12             	movzbl (%edx),%edx
    4a3e:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    4a40:	8b 45 10             	mov    0x10(%ebp),%eax
    4a43:	8d 50 ff             	lea    -0x1(%eax),%edx
    4a46:	89 55 10             	mov    %edx,0x10(%ebp)
    4a49:	85 c0                	test   %eax,%eax
    4a4b:	7f dc                	jg     4a29 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    4a4d:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4a50:	c9                   	leave  
    4a51:	c3                   	ret    

00004a52 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    4a52:	b8 01 00 00 00       	mov    $0x1,%eax
    4a57:	cd 40                	int    $0x40
    4a59:	c3                   	ret    

00004a5a <exit>:
SYSCALL(exit)
    4a5a:	b8 02 00 00 00       	mov    $0x2,%eax
    4a5f:	cd 40                	int    $0x40
    4a61:	c3                   	ret    

00004a62 <wait>:
SYSCALL(wait)
    4a62:	b8 03 00 00 00       	mov    $0x3,%eax
    4a67:	cd 40                	int    $0x40
    4a69:	c3                   	ret    

00004a6a <pipe>:
SYSCALL(pipe)
    4a6a:	b8 04 00 00 00       	mov    $0x4,%eax
    4a6f:	cd 40                	int    $0x40
    4a71:	c3                   	ret    

00004a72 <read>:
SYSCALL(read)
    4a72:	b8 05 00 00 00       	mov    $0x5,%eax
    4a77:	cd 40                	int    $0x40
    4a79:	c3                   	ret    

00004a7a <write>:
SYSCALL(write)
    4a7a:	b8 10 00 00 00       	mov    $0x10,%eax
    4a7f:	cd 40                	int    $0x40
    4a81:	c3                   	ret    

00004a82 <close>:
SYSCALL(close)
    4a82:	b8 15 00 00 00       	mov    $0x15,%eax
    4a87:	cd 40                	int    $0x40
    4a89:	c3                   	ret    

00004a8a <kill>:
SYSCALL(kill)
    4a8a:	b8 06 00 00 00       	mov    $0x6,%eax
    4a8f:	cd 40                	int    $0x40
    4a91:	c3                   	ret    

00004a92 <exec>:
SYSCALL(exec)
    4a92:	b8 07 00 00 00       	mov    $0x7,%eax
    4a97:	cd 40                	int    $0x40
    4a99:	c3                   	ret    

00004a9a <open>:
SYSCALL(open)
    4a9a:	b8 0f 00 00 00       	mov    $0xf,%eax
    4a9f:	cd 40                	int    $0x40
    4aa1:	c3                   	ret    

00004aa2 <mknod>:
SYSCALL(mknod)
    4aa2:	b8 11 00 00 00       	mov    $0x11,%eax
    4aa7:	cd 40                	int    $0x40
    4aa9:	c3                   	ret    

00004aaa <unlink>:
SYSCALL(unlink)
    4aaa:	b8 12 00 00 00       	mov    $0x12,%eax
    4aaf:	cd 40                	int    $0x40
    4ab1:	c3                   	ret    

00004ab2 <fstat>:
SYSCALL(fstat)
    4ab2:	b8 08 00 00 00       	mov    $0x8,%eax
    4ab7:	cd 40                	int    $0x40
    4ab9:	c3                   	ret    

00004aba <link>:
SYSCALL(link)
    4aba:	b8 13 00 00 00       	mov    $0x13,%eax
    4abf:	cd 40                	int    $0x40
    4ac1:	c3                   	ret    

00004ac2 <mkdir>:
SYSCALL(mkdir)
    4ac2:	b8 14 00 00 00       	mov    $0x14,%eax
    4ac7:	cd 40                	int    $0x40
    4ac9:	c3                   	ret    

00004aca <chdir>:
SYSCALL(chdir)
    4aca:	b8 09 00 00 00       	mov    $0x9,%eax
    4acf:	cd 40                	int    $0x40
    4ad1:	c3                   	ret    

00004ad2 <dup>:
SYSCALL(dup)
    4ad2:	b8 0a 00 00 00       	mov    $0xa,%eax
    4ad7:	cd 40                	int    $0x40
    4ad9:	c3                   	ret    

00004ada <getpid>:
SYSCALL(getpid)
    4ada:	b8 0b 00 00 00       	mov    $0xb,%eax
    4adf:	cd 40                	int    $0x40
    4ae1:	c3                   	ret    

00004ae2 <sbrk>:
SYSCALL(sbrk)
    4ae2:	b8 0c 00 00 00       	mov    $0xc,%eax
    4ae7:	cd 40                	int    $0x40
    4ae9:	c3                   	ret    

00004aea <sleep>:
SYSCALL(sleep)
    4aea:	b8 0d 00 00 00       	mov    $0xd,%eax
    4aef:	cd 40                	int    $0x40
    4af1:	c3                   	ret    

00004af2 <uptime>:
SYSCALL(uptime)
    4af2:	b8 0e 00 00 00       	mov    $0xe,%eax
    4af7:	cd 40                	int    $0x40
    4af9:	c3                   	ret    

00004afa <getMsg>:
SYSCALL(getMsg)
    4afa:	b8 16 00 00 00       	mov    $0x16,%eax
    4aff:	cd 40                	int    $0x40
    4b01:	c3                   	ret    

00004b02 <createWindow>:
SYSCALL(createWindow)
    4b02:	b8 17 00 00 00       	mov    $0x17,%eax
    4b07:	cd 40                	int    $0x40
    4b09:	c3                   	ret    

00004b0a <destroyWindow>:
SYSCALL(destroyWindow)
    4b0a:	b8 18 00 00 00       	mov    $0x18,%eax
    4b0f:	cd 40                	int    $0x40
    4b11:	c3                   	ret    

00004b12 <updateWindow>:
SYSCALL(updateWindow)
    4b12:	b8 19 00 00 00       	mov    $0x19,%eax
    4b17:	cd 40                	int    $0x40
    4b19:	c3                   	ret    

00004b1a <updatePartialWindow>:
SYSCALL(updatePartialWindow)
    4b1a:	b8 1a 00 00 00       	mov    $0x1a,%eax
    4b1f:	cd 40                	int    $0x40
    4b21:	c3                   	ret    

00004b22 <kwrite>:
SYSCALL(kwrite)
    4b22:	b8 1c 00 00 00       	mov    $0x1c,%eax
    4b27:	cd 40                	int    $0x40
    4b29:	c3                   	ret    

00004b2a <setSampleRate>:
SYSCALL(setSampleRate)
    4b2a:	b8 1b 00 00 00       	mov    $0x1b,%eax
    4b2f:	cd 40                	int    $0x40
    4b31:	c3                   	ret    

00004b32 <pause>:
SYSCALL(pause)
    4b32:	b8 1d 00 00 00       	mov    $0x1d,%eax
    4b37:	cd 40                	int    $0x40
    4b39:	c3                   	ret    

00004b3a <wavdecode>:
SYSCALL(wavdecode)
    4b3a:	b8 1e 00 00 00       	mov    $0x1e,%eax
    4b3f:	cd 40                	int    $0x40
    4b41:	c3                   	ret    

00004b42 <beginDecode>:
SYSCALL(beginDecode)
    4b42:	b8 1f 00 00 00       	mov    $0x1f,%eax
    4b47:	cd 40                	int    $0x40
    4b49:	c3                   	ret    

00004b4a <waitForDecode>:
SYSCALL(waitForDecode)
    4b4a:	b8 20 00 00 00       	mov    $0x20,%eax
    4b4f:	cd 40                	int    $0x40
    4b51:	c3                   	ret    

00004b52 <endDecode>:
SYSCALL(endDecode)
    4b52:	b8 21 00 00 00       	mov    $0x21,%eax
    4b57:	cd 40                	int    $0x40
    4b59:	c3                   	ret    

00004b5a <getCoreBuf>:
SYSCALL(getCoreBuf)
    4b5a:	b8 22 00 00 00       	mov    $0x22,%eax
    4b5f:	cd 40                	int    $0x40
    4b61:	c3                   	ret    

00004b62 <halt>:
SYSCALL(halt)
    4b62:	b8 23 00 00 00       	mov    $0x23,%eax
    4b67:	cd 40                	int    $0x40
    4b69:	c3                   	ret    

00004b6a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    4b6a:	55                   	push   %ebp
    4b6b:	89 e5                	mov    %esp,%ebp
    4b6d:	83 ec 18             	sub    $0x18,%esp
    4b70:	8b 45 0c             	mov    0xc(%ebp),%eax
    4b73:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    4b76:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    4b7d:	00 
    4b7e:	8d 45 f4             	lea    -0xc(%ebp),%eax
    4b81:	89 44 24 04          	mov    %eax,0x4(%esp)
    4b85:	8b 45 08             	mov    0x8(%ebp),%eax
    4b88:	89 04 24             	mov    %eax,(%esp)
    4b8b:	e8 ea fe ff ff       	call   4a7a <write>
}
    4b90:	c9                   	leave  
    4b91:	c3                   	ret    

00004b92 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    4b92:	55                   	push   %ebp
    4b93:	89 e5                	mov    %esp,%ebp
    4b95:	56                   	push   %esi
    4b96:	53                   	push   %ebx
    4b97:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    4b9a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    4ba1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    4ba5:	74 17                	je     4bbe <printint+0x2c>
    4ba7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    4bab:	79 11                	jns    4bbe <printint+0x2c>
    neg = 1;
    4bad:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    4bb4:	8b 45 0c             	mov    0xc(%ebp),%eax
    4bb7:	f7 d8                	neg    %eax
    4bb9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    4bbc:	eb 06                	jmp    4bc4 <printint+0x32>
  } else {
    x = xx;
    4bbe:	8b 45 0c             	mov    0xc(%ebp),%eax
    4bc1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    4bc4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    4bcb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    4bce:	8d 41 01             	lea    0x1(%ecx),%eax
    4bd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4bd4:	8b 5d 10             	mov    0x10(%ebp),%ebx
    4bd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4bda:	ba 00 00 00 00       	mov    $0x0,%edx
    4bdf:	f7 f3                	div    %ebx
    4be1:	89 d0                	mov    %edx,%eax
    4be3:	0f b6 80 20 f2 00 00 	movzbl 0xf220(%eax),%eax
    4bea:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    4bee:	8b 75 10             	mov    0x10(%ebp),%esi
    4bf1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4bf4:	ba 00 00 00 00       	mov    $0x0,%edx
    4bf9:	f7 f6                	div    %esi
    4bfb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    4bfe:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4c02:	75 c7                	jne    4bcb <printint+0x39>
  if(neg)
    4c04:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4c08:	74 10                	je     4c1a <printint+0x88>
    buf[i++] = '-';
    4c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4c0d:	8d 50 01             	lea    0x1(%eax),%edx
    4c10:	89 55 f4             	mov    %edx,-0xc(%ebp)
    4c13:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    4c18:	eb 1f                	jmp    4c39 <printint+0xa7>
    4c1a:	eb 1d                	jmp    4c39 <printint+0xa7>
    putc(fd, buf[i]);
    4c1c:	8d 55 dc             	lea    -0x24(%ebp),%edx
    4c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4c22:	01 d0                	add    %edx,%eax
    4c24:	0f b6 00             	movzbl (%eax),%eax
    4c27:	0f be c0             	movsbl %al,%eax
    4c2a:	89 44 24 04          	mov    %eax,0x4(%esp)
    4c2e:	8b 45 08             	mov    0x8(%ebp),%eax
    4c31:	89 04 24             	mov    %eax,(%esp)
    4c34:	e8 31 ff ff ff       	call   4b6a <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    4c39:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    4c3d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4c41:	79 d9                	jns    4c1c <printint+0x8a>
    putc(fd, buf[i]);
}
    4c43:	83 c4 30             	add    $0x30,%esp
    4c46:	5b                   	pop    %ebx
    4c47:	5e                   	pop    %esi
    4c48:	5d                   	pop    %ebp
    4c49:	c3                   	ret    

00004c4a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    4c4a:	55                   	push   %ebp
    4c4b:	89 e5                	mov    %esp,%ebp
    4c4d:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    4c50:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    4c57:	8d 45 0c             	lea    0xc(%ebp),%eax
    4c5a:	83 c0 04             	add    $0x4,%eax
    4c5d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    4c60:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    4c67:	e9 7c 01 00 00       	jmp    4de8 <printf+0x19e>
    c = fmt[i] & 0xff;
    4c6c:	8b 55 0c             	mov    0xc(%ebp),%edx
    4c6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4c72:	01 d0                	add    %edx,%eax
    4c74:	0f b6 00             	movzbl (%eax),%eax
    4c77:	0f be c0             	movsbl %al,%eax
    4c7a:	25 ff 00 00 00       	and    $0xff,%eax
    4c7f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    4c82:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4c86:	75 2c                	jne    4cb4 <printf+0x6a>
      if(c == '%'){
    4c88:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4c8c:	75 0c                	jne    4c9a <printf+0x50>
        state = '%';
    4c8e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    4c95:	e9 4a 01 00 00       	jmp    4de4 <printf+0x19a>
      } else {
        putc(fd, c);
    4c9a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4c9d:	0f be c0             	movsbl %al,%eax
    4ca0:	89 44 24 04          	mov    %eax,0x4(%esp)
    4ca4:	8b 45 08             	mov    0x8(%ebp),%eax
    4ca7:	89 04 24             	mov    %eax,(%esp)
    4caa:	e8 bb fe ff ff       	call   4b6a <putc>
    4caf:	e9 30 01 00 00       	jmp    4de4 <printf+0x19a>
      }
    } else if(state == '%'){
    4cb4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    4cb8:	0f 85 26 01 00 00    	jne    4de4 <printf+0x19a>
      if(c == 'd'){
    4cbe:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    4cc2:	75 2d                	jne    4cf1 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    4cc4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4cc7:	8b 00                	mov    (%eax),%eax
    4cc9:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    4cd0:	00 
    4cd1:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    4cd8:	00 
    4cd9:	89 44 24 04          	mov    %eax,0x4(%esp)
    4cdd:	8b 45 08             	mov    0x8(%ebp),%eax
    4ce0:	89 04 24             	mov    %eax,(%esp)
    4ce3:	e8 aa fe ff ff       	call   4b92 <printint>
        ap++;
    4ce8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4cec:	e9 ec 00 00 00       	jmp    4ddd <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    4cf1:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    4cf5:	74 06                	je     4cfd <printf+0xb3>
    4cf7:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    4cfb:	75 2d                	jne    4d2a <printf+0xe0>
        printint(fd, *ap, 16, 0);
    4cfd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4d00:	8b 00                	mov    (%eax),%eax
    4d02:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    4d09:	00 
    4d0a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    4d11:	00 
    4d12:	89 44 24 04          	mov    %eax,0x4(%esp)
    4d16:	8b 45 08             	mov    0x8(%ebp),%eax
    4d19:	89 04 24             	mov    %eax,(%esp)
    4d1c:	e8 71 fe ff ff       	call   4b92 <printint>
        ap++;
    4d21:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4d25:	e9 b3 00 00 00       	jmp    4ddd <printf+0x193>
      } else if(c == 's'){
    4d2a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    4d2e:	75 45                	jne    4d75 <printf+0x12b>
        s = (char*)*ap;
    4d30:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4d33:	8b 00                	mov    (%eax),%eax
    4d35:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    4d38:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    4d3c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4d40:	75 09                	jne    4d4b <printf+0x101>
          s = "(null)";
    4d42:	c7 45 f4 19 b9 00 00 	movl   $0xb919,-0xc(%ebp)
        while(*s != 0){
    4d49:	eb 1e                	jmp    4d69 <printf+0x11f>
    4d4b:	eb 1c                	jmp    4d69 <printf+0x11f>
          putc(fd, *s);
    4d4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4d50:	0f b6 00             	movzbl (%eax),%eax
    4d53:	0f be c0             	movsbl %al,%eax
    4d56:	89 44 24 04          	mov    %eax,0x4(%esp)
    4d5a:	8b 45 08             	mov    0x8(%ebp),%eax
    4d5d:	89 04 24             	mov    %eax,(%esp)
    4d60:	e8 05 fe ff ff       	call   4b6a <putc>
          s++;
    4d65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    4d69:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4d6c:	0f b6 00             	movzbl (%eax),%eax
    4d6f:	84 c0                	test   %al,%al
    4d71:	75 da                	jne    4d4d <printf+0x103>
    4d73:	eb 68                	jmp    4ddd <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    4d75:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    4d79:	75 1d                	jne    4d98 <printf+0x14e>
        putc(fd, *ap);
    4d7b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4d7e:	8b 00                	mov    (%eax),%eax
    4d80:	0f be c0             	movsbl %al,%eax
    4d83:	89 44 24 04          	mov    %eax,0x4(%esp)
    4d87:	8b 45 08             	mov    0x8(%ebp),%eax
    4d8a:	89 04 24             	mov    %eax,(%esp)
    4d8d:	e8 d8 fd ff ff       	call   4b6a <putc>
        ap++;
    4d92:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4d96:	eb 45                	jmp    4ddd <printf+0x193>
      } else if(c == '%'){
    4d98:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4d9c:	75 17                	jne    4db5 <printf+0x16b>
        putc(fd, c);
    4d9e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4da1:	0f be c0             	movsbl %al,%eax
    4da4:	89 44 24 04          	mov    %eax,0x4(%esp)
    4da8:	8b 45 08             	mov    0x8(%ebp),%eax
    4dab:	89 04 24             	mov    %eax,(%esp)
    4dae:	e8 b7 fd ff ff       	call   4b6a <putc>
    4db3:	eb 28                	jmp    4ddd <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    4db5:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    4dbc:	00 
    4dbd:	8b 45 08             	mov    0x8(%ebp),%eax
    4dc0:	89 04 24             	mov    %eax,(%esp)
    4dc3:	e8 a2 fd ff ff       	call   4b6a <putc>
        putc(fd, c);
    4dc8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4dcb:	0f be c0             	movsbl %al,%eax
    4dce:	89 44 24 04          	mov    %eax,0x4(%esp)
    4dd2:	8b 45 08             	mov    0x8(%ebp),%eax
    4dd5:	89 04 24             	mov    %eax,(%esp)
    4dd8:	e8 8d fd ff ff       	call   4b6a <putc>
      }
      state = 0;
    4ddd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    4de4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    4de8:	8b 55 0c             	mov    0xc(%ebp),%edx
    4deb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4dee:	01 d0                	add    %edx,%eax
    4df0:	0f b6 00             	movzbl (%eax),%eax
    4df3:	84 c0                	test   %al,%al
    4df5:	0f 85 71 fe ff ff    	jne    4c6c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    4dfb:	c9                   	leave  
    4dfc:	c3                   	ret    

00004dfd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4dfd:	55                   	push   %ebp
    4dfe:	89 e5                	mov    %esp,%ebp
    4e00:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    4e03:	8b 45 08             	mov    0x8(%ebp),%eax
    4e06:	83 e8 08             	sub    $0x8,%eax
    4e09:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4e0c:	a1 44 f7 00 00       	mov    0xf744,%eax
    4e11:	89 45 fc             	mov    %eax,-0x4(%ebp)
    4e14:	eb 24                	jmp    4e3a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4e16:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4e19:	8b 00                	mov    (%eax),%eax
    4e1b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4e1e:	77 12                	ja     4e32 <free+0x35>
    4e20:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4e23:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4e26:	77 24                	ja     4e4c <free+0x4f>
    4e28:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4e2b:	8b 00                	mov    (%eax),%eax
    4e2d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4e30:	77 1a                	ja     4e4c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4e32:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4e35:	8b 00                	mov    (%eax),%eax
    4e37:	89 45 fc             	mov    %eax,-0x4(%ebp)
    4e3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4e3d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4e40:	76 d4                	jbe    4e16 <free+0x19>
    4e42:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4e45:	8b 00                	mov    (%eax),%eax
    4e47:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4e4a:	76 ca                	jbe    4e16 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    4e4c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4e4f:	8b 40 04             	mov    0x4(%eax),%eax
    4e52:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    4e59:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4e5c:	01 c2                	add    %eax,%edx
    4e5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4e61:	8b 00                	mov    (%eax),%eax
    4e63:	39 c2                	cmp    %eax,%edx
    4e65:	75 24                	jne    4e8b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    4e67:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4e6a:	8b 50 04             	mov    0x4(%eax),%edx
    4e6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4e70:	8b 00                	mov    (%eax),%eax
    4e72:	8b 40 04             	mov    0x4(%eax),%eax
    4e75:	01 c2                	add    %eax,%edx
    4e77:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4e7a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    4e7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4e80:	8b 00                	mov    (%eax),%eax
    4e82:	8b 10                	mov    (%eax),%edx
    4e84:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4e87:	89 10                	mov    %edx,(%eax)
    4e89:	eb 0a                	jmp    4e95 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    4e8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4e8e:	8b 10                	mov    (%eax),%edx
    4e90:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4e93:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    4e95:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4e98:	8b 40 04             	mov    0x4(%eax),%eax
    4e9b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    4ea2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4ea5:	01 d0                	add    %edx,%eax
    4ea7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4eaa:	75 20                	jne    4ecc <free+0xcf>
    p->s.size += bp->s.size;
    4eac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4eaf:	8b 50 04             	mov    0x4(%eax),%edx
    4eb2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4eb5:	8b 40 04             	mov    0x4(%eax),%eax
    4eb8:	01 c2                	add    %eax,%edx
    4eba:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4ebd:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    4ec0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4ec3:	8b 10                	mov    (%eax),%edx
    4ec5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4ec8:	89 10                	mov    %edx,(%eax)
    4eca:	eb 08                	jmp    4ed4 <free+0xd7>
  } else
    p->s.ptr = bp;
    4ecc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4ecf:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4ed2:	89 10                	mov    %edx,(%eax)
  freep = p;
    4ed4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4ed7:	a3 44 f7 00 00       	mov    %eax,0xf744
}
    4edc:	c9                   	leave  
    4edd:	c3                   	ret    

00004ede <morecore>:

static Header*
morecore(uint nu)
{
    4ede:	55                   	push   %ebp
    4edf:	89 e5                	mov    %esp,%ebp
    4ee1:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    4ee4:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    4eeb:	77 07                	ja     4ef4 <morecore+0x16>
    nu = 4096;
    4eed:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    4ef4:	8b 45 08             	mov    0x8(%ebp),%eax
    4ef7:	c1 e0 03             	shl    $0x3,%eax
    4efa:	89 04 24             	mov    %eax,(%esp)
    4efd:	e8 e0 fb ff ff       	call   4ae2 <sbrk>
    4f02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    4f05:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    4f09:	75 07                	jne    4f12 <morecore+0x34>
    return 0;
    4f0b:	b8 00 00 00 00       	mov    $0x0,%eax
    4f10:	eb 22                	jmp    4f34 <morecore+0x56>
  hp = (Header*)p;
    4f12:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    4f18:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4f1b:	8b 55 08             	mov    0x8(%ebp),%edx
    4f1e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    4f21:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4f24:	83 c0 08             	add    $0x8,%eax
    4f27:	89 04 24             	mov    %eax,(%esp)
    4f2a:	e8 ce fe ff ff       	call   4dfd <free>
  return freep;
    4f2f:	a1 44 f7 00 00       	mov    0xf744,%eax
}
    4f34:	c9                   	leave  
    4f35:	c3                   	ret    

00004f36 <malloc>:

void*
malloc(uint nbytes)
{
    4f36:	55                   	push   %ebp
    4f37:	89 e5                	mov    %esp,%ebp
    4f39:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4f3c:	8b 45 08             	mov    0x8(%ebp),%eax
    4f3f:	83 c0 07             	add    $0x7,%eax
    4f42:	c1 e8 03             	shr    $0x3,%eax
    4f45:	83 c0 01             	add    $0x1,%eax
    4f48:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    4f4b:	a1 44 f7 00 00       	mov    0xf744,%eax
    4f50:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4f53:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4f57:	75 23                	jne    4f7c <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    4f59:	c7 45 f0 3c f7 00 00 	movl   $0xf73c,-0x10(%ebp)
    4f60:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4f63:	a3 44 f7 00 00       	mov    %eax,0xf744
    4f68:	a1 44 f7 00 00       	mov    0xf744,%eax
    4f6d:	a3 3c f7 00 00       	mov    %eax,0xf73c
    base.s.size = 0;
    4f72:	c7 05 40 f7 00 00 00 	movl   $0x0,0xf740
    4f79:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4f7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4f7f:	8b 00                	mov    (%eax),%eax
    4f81:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4f84:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f87:	8b 40 04             	mov    0x4(%eax),%eax
    4f8a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4f8d:	72 4d                	jb     4fdc <malloc+0xa6>
      if(p->s.size == nunits)
    4f8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f92:	8b 40 04             	mov    0x4(%eax),%eax
    4f95:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4f98:	75 0c                	jne    4fa6 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    4f9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4f9d:	8b 10                	mov    (%eax),%edx
    4f9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4fa2:	89 10                	mov    %edx,(%eax)
    4fa4:	eb 26                	jmp    4fcc <malloc+0x96>
      else {
        p->s.size -= nunits;
    4fa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4fa9:	8b 40 04             	mov    0x4(%eax),%eax
    4fac:	2b 45 ec             	sub    -0x14(%ebp),%eax
    4faf:	89 c2                	mov    %eax,%edx
    4fb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4fb4:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    4fb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4fba:	8b 40 04             	mov    0x4(%eax),%eax
    4fbd:	c1 e0 03             	shl    $0x3,%eax
    4fc0:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    4fc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4fc6:	8b 55 ec             	mov    -0x14(%ebp),%edx
    4fc9:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    4fcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4fcf:	a3 44 f7 00 00       	mov    %eax,0xf744
      return (void*)(p + 1);
    4fd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4fd7:	83 c0 08             	add    $0x8,%eax
    4fda:	eb 38                	jmp    5014 <malloc+0xde>
    }
    if(p == freep)
    4fdc:	a1 44 f7 00 00       	mov    0xf744,%eax
    4fe1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    4fe4:	75 1b                	jne    5001 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    4fe6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4fe9:	89 04 24             	mov    %eax,(%esp)
    4fec:	e8 ed fe ff ff       	call   4ede <morecore>
    4ff1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4ff4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4ff8:	75 07                	jne    5001 <malloc+0xcb>
        return 0;
    4ffa:	b8 00 00 00 00       	mov    $0x0,%eax
    4fff:	eb 13                	jmp    5014 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5001:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5004:	89 45 f0             	mov    %eax,-0x10(%ebp)
    5007:	8b 45 f4             	mov    -0xc(%ebp),%eax
    500a:	8b 00                	mov    (%eax),%eax
    500c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    500f:	e9 70 ff ff ff       	jmp    4f84 <malloc+0x4e>
}
    5014:	c9                   	leave  
    5015:	c3                   	ret    

00005016 <abs>:
#include "math.h"
#define pi 3.1415926535898 
int abs(int x)
{
    5016:	55                   	push   %ebp
    5017:	89 e5                	mov    %esp,%ebp
	if (x < 0)
    5019:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    501d:	79 07                	jns    5026 <abs+0x10>
		return x * -1;
    501f:	8b 45 08             	mov    0x8(%ebp),%eax
    5022:	f7 d8                	neg    %eax
    5024:	eb 03                	jmp    5029 <abs+0x13>
	else
		return x;
    5026:	8b 45 08             	mov    0x8(%ebp),%eax
}
    5029:	5d                   	pop    %ebp
    502a:	c3                   	ret    

0000502b <sin>:
double sin(double x)  
{  
    502b:	55                   	push   %ebp
    502c:	89 e5                	mov    %esp,%ebp
    502e:	83 ec 3c             	sub    $0x3c,%esp
    5031:	8b 45 08             	mov    0x8(%ebp),%eax
    5034:	89 45 c8             	mov    %eax,-0x38(%ebp)
    5037:	8b 45 0c             	mov    0xc(%ebp),%eax
    503a:	89 45 cc             	mov    %eax,-0x34(%ebp)
	double Result=x,Fac=1.0,Xn=x,Precious=x;  
    503d:	dd 45 c8             	fldl   -0x38(%ebp)
    5040:	dd 5d f8             	fstpl  -0x8(%ebp)
    5043:	d9 e8                	fld1   
    5045:	dd 5d f0             	fstpl  -0x10(%ebp)
    5048:	dd 45 c8             	fldl   -0x38(%ebp)
    504b:	dd 5d e8             	fstpl  -0x18(%ebp)
    504e:	dd 45 c8             	fldl   -0x38(%ebp)
    5051:	dd 5d e0             	fstpl  -0x20(%ebp)
	int n=1,sign=1;  
    5054:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
    505b:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
	while(Precious>1e-6)  
    5062:	eb 50                	jmp    50b4 <sin+0x89>
	{  
		n = n+1;  
    5064:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
		Fac=Fac*n*(n + 1);
    5068:	db 45 dc             	fildl  -0x24(%ebp)
    506b:	dc 4d f0             	fmull  -0x10(%ebp)
    506e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    5071:	83 c0 01             	add    $0x1,%eax
    5074:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    5077:	db 45 c4             	fildl  -0x3c(%ebp)
    507a:	de c9                	fmulp  %st,%st(1)
    507c:	dd 5d f0             	fstpl  -0x10(%ebp)
		n = n + 1;  
    507f:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
		Xn*=x*x;  
    5083:	dd 45 c8             	fldl   -0x38(%ebp)
    5086:	dc 4d c8             	fmull  -0x38(%ebp)
    5089:	dd 45 e8             	fldl   -0x18(%ebp)
    508c:	de c9                	fmulp  %st,%st(1)
    508e:	dd 5d e8             	fstpl  -0x18(%ebp)
		sign=-sign;  
    5091:	f7 5d d8             	negl   -0x28(%ebp)
		Precious=Xn/Fac;  
    5094:	dd 45 e8             	fldl   -0x18(%ebp)
    5097:	dc 75 f0             	fdivl  -0x10(%ebp)
    509a:	dd 5d e0             	fstpl  -0x20(%ebp)
		Result=sign>0?Result+Precious:Result-Precious;  
    509d:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    50a1:	7e 08                	jle    50ab <sin+0x80>
    50a3:	dd 45 f8             	fldl   -0x8(%ebp)
    50a6:	dc 45 e0             	faddl  -0x20(%ebp)
    50a9:	eb 06                	jmp    50b1 <sin+0x86>
    50ab:	dd 45 f8             	fldl   -0x8(%ebp)
    50ae:	dc 65 e0             	fsubl  -0x20(%ebp)
    50b1:	dd 5d f8             	fstpl  -0x8(%ebp)
}
double sin(double x)  
{  
	double Result=x,Fac=1.0,Xn=x,Precious=x;  
	int n=1,sign=1;  
	while(Precious>1e-6)  
    50b4:	dd 45 e0             	fldl   -0x20(%ebp)
    50b7:	dd 05 20 b9 00 00    	fldl   0xb920
    50bd:	d9 c9                	fxch   %st(1)
    50bf:	df e9                	fucomip %st(1),%st
    50c1:	dd d8                	fstp   %st(0)
    50c3:	77 9f                	ja     5064 <sin+0x39>
		Xn*=x*x;  
		sign=-sign;  
		Precious=Xn/Fac;  
		Result=sign>0?Result+Precious:Result-Precious;  
	}  
	return Result;  
    50c5:	dd 45 f8             	fldl   -0x8(%ebp)
}  
    50c8:	c9                   	leave  
    50c9:	c3                   	ret    

000050ca <cos>:
double cos(double x)  
{  
    50ca:	55                   	push   %ebp
    50cb:	89 e5                	mov    %esp,%ebp
    50cd:	83 ec 10             	sub    $0x10,%esp
    50d0:	8b 45 08             	mov    0x8(%ebp),%eax
    50d3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    50d6:	8b 45 0c             	mov    0xc(%ebp),%eax
    50d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return sin(pi/2-x);  
    50dc:	dd 05 28 b9 00 00    	fldl   0xb928
    50e2:	dc 65 f8             	fsubl  -0x8(%ebp)
    50e5:	dd 1c 24             	fstpl  (%esp)
    50e8:	e8 3e ff ff ff       	call   502b <sin>
}  
    50ed:	c9                   	leave  
    50ee:	c3                   	ret    

000050ef <tan>:
double tan(double x)  
{  
    50ef:	55                   	push   %ebp
    50f0:	89 e5                	mov    %esp,%ebp
    50f2:	83 ec 18             	sub    $0x18,%esp
    50f5:	8b 45 08             	mov    0x8(%ebp),%eax
    50f8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    50fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    50fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return sin(x)/cos(x);  
    5101:	dd 45 f8             	fldl   -0x8(%ebp)
    5104:	dd 1c 24             	fstpl  (%esp)
    5107:	e8 1f ff ff ff       	call   502b <sin>
    510c:	dd 5d f0             	fstpl  -0x10(%ebp)
    510f:	dd 45 f8             	fldl   -0x8(%ebp)
    5112:	dd 1c 24             	fstpl  (%esp)
    5115:	e8 b0 ff ff ff       	call   50ca <cos>
    511a:	dc 7d f0             	fdivrl -0x10(%ebp)
}  
    511d:	c9                   	leave  
    511e:	c3                   	ret    

0000511f <pow>:

double pow(double x, double y)
{
    511f:	55                   	push   %ebp
    5120:	89 e5                	mov    %esp,%ebp
    5122:	83 ec 48             	sub    $0x48,%esp
    5125:	8b 45 08             	mov    0x8(%ebp),%eax
    5128:	89 45 e0             	mov    %eax,-0x20(%ebp)
    512b:	8b 45 0c             	mov    0xc(%ebp),%eax
    512e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    5131:	8b 45 10             	mov    0x10(%ebp),%eax
    5134:	89 45 d8             	mov    %eax,-0x28(%ebp)
    5137:	8b 45 14             	mov    0x14(%ebp),%eax
    513a:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if(x==0 && y!=0) return 0;
    513d:	dd 45 e0             	fldl   -0x20(%ebp)
    5140:	d9 ee                	fldz   
    5142:	df e9                	fucomip %st(1),%st
    5144:	dd d8                	fstp   %st(0)
    5146:	7a 28                	jp     5170 <pow+0x51>
    5148:	dd 45 e0             	fldl   -0x20(%ebp)
    514b:	d9 ee                	fldz   
    514d:	df e9                	fucomip %st(1),%st
    514f:	dd d8                	fstp   %st(0)
    5151:	75 1d                	jne    5170 <pow+0x51>
    5153:	dd 45 d8             	fldl   -0x28(%ebp)
    5156:	d9 ee                	fldz   
    5158:	df e9                	fucomip %st(1),%st
    515a:	dd d8                	fstp   %st(0)
    515c:	7a 0b                	jp     5169 <pow+0x4a>
    515e:	dd 45 d8             	fldl   -0x28(%ebp)
    5161:	d9 ee                	fldz   
    5163:	df e9                	fucomip %st(1),%st
    5165:	dd d8                	fstp   %st(0)
    5167:	74 07                	je     5170 <pow+0x51>
    5169:	d9 ee                	fldz   
    516b:	e9 30 01 00 00       	jmp    52a0 <pow+0x181>
	else if(x==0 && y==0) return 1;
    5170:	dd 45 e0             	fldl   -0x20(%ebp)
    5173:	d9 ee                	fldz   
    5175:	df e9                	fucomip %st(1),%st
    5177:	dd d8                	fstp   %st(0)
    5179:	7a 28                	jp     51a3 <pow+0x84>
    517b:	dd 45 e0             	fldl   -0x20(%ebp)
    517e:	d9 ee                	fldz   
    5180:	df e9                	fucomip %st(1),%st
    5182:	dd d8                	fstp   %st(0)
    5184:	75 1d                	jne    51a3 <pow+0x84>
    5186:	dd 45 d8             	fldl   -0x28(%ebp)
    5189:	d9 ee                	fldz   
    518b:	df e9                	fucomip %st(1),%st
    518d:	dd d8                	fstp   %st(0)
    518f:	7a 12                	jp     51a3 <pow+0x84>
    5191:	dd 45 d8             	fldl   -0x28(%ebp)
    5194:	d9 ee                	fldz   
    5196:	df e9                	fucomip %st(1),%st
    5198:	dd d8                	fstp   %st(0)
    519a:	75 07                	jne    51a3 <pow+0x84>
    519c:	d9 e8                	fld1   
    519e:	e9 fd 00 00 00       	jmp    52a0 <pow+0x181>
	else if(y<0) return 1/pow(x,-y);//把指数小于0的情况转为1/x^-y计算
    51a3:	d9 ee                	fldz   
    51a5:	dd 45 d8             	fldl   -0x28(%ebp)
    51a8:	d9 c9                	fxch   %st(1)
    51aa:	df e9                	fucomip %st(1),%st
    51ac:	dd d8                	fstp   %st(0)
    51ae:	76 1d                	jbe    51cd <pow+0xae>
    51b0:	dd 45 d8             	fldl   -0x28(%ebp)
    51b3:	d9 e0                	fchs   
    51b5:	dd 5c 24 08          	fstpl  0x8(%esp)
    51b9:	dd 45 e0             	fldl   -0x20(%ebp)
    51bc:	dd 1c 24             	fstpl  (%esp)
    51bf:	e8 5b ff ff ff       	call   511f <pow>
    51c4:	d9 e8                	fld1   
    51c6:	de f1                	fdivp  %st,%st(1)
    51c8:	e9 d3 00 00 00       	jmp    52a0 <pow+0x181>
	else if(x<0 && y-(int)y!=0) return 0;//若x为负，且y不为整数数，则出错，返回0  
    51cd:	d9 ee                	fldz   
    51cf:	dd 45 e0             	fldl   -0x20(%ebp)
    51d2:	d9 c9                	fxch   %st(1)
    51d4:	df e9                	fucomip %st(1),%st
    51d6:	dd d8                	fstp   %st(0)
    51d8:	76 40                	jbe    521a <pow+0xfb>
    51da:	dd 45 d8             	fldl   -0x28(%ebp)
    51dd:	d9 7d d6             	fnstcw -0x2a(%ebp)
    51e0:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    51e4:	b4 0c                	mov    $0xc,%ah
    51e6:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    51ea:	d9 6d d4             	fldcw  -0x2c(%ebp)
    51ed:	db 5d d0             	fistpl -0x30(%ebp)
    51f0:	d9 6d d6             	fldcw  -0x2a(%ebp)
    51f3:	8b 45 d0             	mov    -0x30(%ebp),%eax
    51f6:	89 45 d0             	mov    %eax,-0x30(%ebp)
    51f9:	db 45 d0             	fildl  -0x30(%ebp)
    51fc:	dd 45 d8             	fldl   -0x28(%ebp)
    51ff:	de e1                	fsubp  %st,%st(1)
    5201:	d9 ee                	fldz   
    5203:	df e9                	fucomip %st(1),%st
    5205:	7a 0a                	jp     5211 <pow+0xf2>
    5207:	d9 ee                	fldz   
    5209:	df e9                	fucomip %st(1),%st
    520b:	dd d8                	fstp   %st(0)
    520d:	74 0b                	je     521a <pow+0xfb>
    520f:	eb 02                	jmp    5213 <pow+0xf4>
    5211:	dd d8                	fstp   %st(0)
    5213:	d9 ee                	fldz   
    5215:	e9 86 00 00 00       	jmp    52a0 <pow+0x181>
	else if(x<0 && y-(int)y==0)//若x为负，且y为整数数，则用循环计算 
    521a:	d9 ee                	fldz   
    521c:	dd 45 e0             	fldl   -0x20(%ebp)
    521f:	d9 c9                	fxch   %st(1)
    5221:	df e9                	fucomip %st(1),%st
    5223:	dd d8                	fstp   %st(0)
    5225:	76 63                	jbe    528a <pow+0x16b>
    5227:	dd 45 d8             	fldl   -0x28(%ebp)
    522a:	d9 7d d6             	fnstcw -0x2a(%ebp)
    522d:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    5231:	b4 0c                	mov    $0xc,%ah
    5233:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    5237:	d9 6d d4             	fldcw  -0x2c(%ebp)
    523a:	db 5d d0             	fistpl -0x30(%ebp)
    523d:	d9 6d d6             	fldcw  -0x2a(%ebp)
    5240:	8b 45 d0             	mov    -0x30(%ebp),%eax
    5243:	89 45 d0             	mov    %eax,-0x30(%ebp)
    5246:	db 45 d0             	fildl  -0x30(%ebp)
    5249:	dd 45 d8             	fldl   -0x28(%ebp)
    524c:	de e1                	fsubp  %st,%st(1)
    524e:	d9 ee                	fldz   
    5250:	df e9                	fucomip %st(1),%st
    5252:	7a 34                	jp     5288 <pow+0x169>
    5254:	d9 ee                	fldz   
    5256:	df e9                	fucomip %st(1),%st
    5258:	dd d8                	fstp   %st(0)
    525a:	75 2e                	jne    528a <pow+0x16b>
	{
		double powint=1;
    525c:	d9 e8                	fld1   
    525e:	dd 5d f0             	fstpl  -0x10(%ebp)
		int i;
		for(i=1;i<=y;i++) powint*=x;
    5261:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    5268:	eb 0d                	jmp    5277 <pow+0x158>
    526a:	dd 45 f0             	fldl   -0x10(%ebp)
    526d:	dc 4d e0             	fmull  -0x20(%ebp)
    5270:	dd 5d f0             	fstpl  -0x10(%ebp)
    5273:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5277:	db 45 ec             	fildl  -0x14(%ebp)
    527a:	dd 45 d8             	fldl   -0x28(%ebp)
    527d:	df e9                	fucomip %st(1),%st
    527f:	dd d8                	fstp   %st(0)
    5281:	73 e7                	jae    526a <pow+0x14b>
		return powint;
    5283:	dd 45 f0             	fldl   -0x10(%ebp)
    5286:	eb 18                	jmp    52a0 <pow+0x181>
    5288:	dd d8                	fstp   %st(0)
	}
	return exp(y*ln(x));
    528a:	dd 45 e0             	fldl   -0x20(%ebp)
    528d:	dd 1c 24             	fstpl  (%esp)
    5290:	e8 36 00 00 00       	call   52cb <ln>
    5295:	dc 4d d8             	fmull  -0x28(%ebp)
    5298:	dd 1c 24             	fstpl  (%esp)
    529b:	e8 0e 02 00 00       	call   54ae <exp>
}
    52a0:	c9                   	leave  
    52a1:	c3                   	ret    

000052a2 <sqrt>:
// 求根
double sqrt(double x)
{
    52a2:	55                   	push   %ebp
    52a3:	89 e5                	mov    %esp,%ebp
    52a5:	83 ec 28             	sub    $0x28,%esp
    52a8:	8b 45 08             	mov    0x8(%ebp),%eax
    52ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
    52ae:	8b 45 0c             	mov    0xc(%ebp),%eax
    52b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	return pow(x,0.5);
    52b4:	dd 05 30 b9 00 00    	fldl   0xb930
    52ba:	dd 5c 24 08          	fstpl  0x8(%esp)
    52be:	dd 45 f0             	fldl   -0x10(%ebp)
    52c1:	dd 1c 24             	fstpl  (%esp)
    52c4:	e8 56 fe ff ff       	call   511f <pow>
}
    52c9:	c9                   	leave  
    52ca:	c3                   	ret    

000052cb <ln>:

// ln(x) = 2 arctanh((x-1)/(x+1))
// 调用了Arctanh(double) 方法
double ln(double x)
{
    52cb:	55                   	push   %ebp
    52cc:	89 e5                	mov    %esp,%ebp
    52ce:	81 ec 88 00 00 00    	sub    $0x88,%esp
    52d4:	8b 45 08             	mov    0x8(%ebp),%eax
    52d7:	89 45 90             	mov    %eax,-0x70(%ebp)
    52da:	8b 45 0c             	mov    0xc(%ebp),%eax
    52dd:	89 45 94             	mov    %eax,-0x6c(%ebp)
	double y=x-1,ln_p1=0,ln_p2=0,ln_p3=0,ln_px=0,ln_tmp=1,dln_px=1,tmp;
    52e0:	dd 45 90             	fldl   -0x70(%ebp)
    52e3:	d9 e8                	fld1   
    52e5:	de e9                	fsubrp %st,%st(1)
    52e7:	dd 5d c0             	fstpl  -0x40(%ebp)
    52ea:	d9 ee                	fldz   
    52ec:	dd 5d f0             	fstpl  -0x10(%ebp)
    52ef:	d9 ee                	fldz   
    52f1:	dd 5d b8             	fstpl  -0x48(%ebp)
    52f4:	d9 ee                	fldz   
    52f6:	dd 5d b0             	fstpl  -0x50(%ebp)
    52f9:	d9 ee                	fldz   
    52fb:	dd 5d e8             	fstpl  -0x18(%ebp)
    52fe:	d9 e8                	fld1   
    5300:	dd 5d e0             	fstpl  -0x20(%ebp)
    5303:	d9 e8                	fld1   
    5305:	dd 5d a8             	fstpl  -0x58(%ebp)
	int l;
	if(x==1) return 0;
    5308:	dd 45 90             	fldl   -0x70(%ebp)
    530b:	d9 e8                	fld1   
    530d:	df e9                	fucomip %st(1),%st
    530f:	dd d8                	fstp   %st(0)
    5311:	7a 12                	jp     5325 <ln+0x5a>
    5313:	dd 45 90             	fldl   -0x70(%ebp)
    5316:	d9 e8                	fld1   
    5318:	df e9                	fucomip %st(1),%st
    531a:	dd d8                	fstp   %st(0)
    531c:	75 07                	jne    5325 <ln+0x5a>
    531e:	d9 ee                	fldz   
    5320:	e9 87 01 00 00       	jmp    54ac <ln+0x1e1>
	else if(x>2) return -ln(1/x);
    5325:	dd 45 90             	fldl   -0x70(%ebp)
    5328:	dd 05 38 b9 00 00    	fldl   0xb938
    532e:	d9 c9                	fxch   %st(1)
    5330:	df e9                	fucomip %st(1),%st
    5332:	dd d8                	fstp   %st(0)
    5334:	76 14                	jbe    534a <ln+0x7f>
    5336:	d9 e8                	fld1   
    5338:	dc 75 90             	fdivl  -0x70(%ebp)
    533b:	dd 1c 24             	fstpl  (%esp)
    533e:	e8 88 ff ff ff       	call   52cb <ln>
    5343:	d9 e0                	fchs   
    5345:	e9 62 01 00 00       	jmp    54ac <ln+0x1e1>
	else if(x<.1)
    534a:	dd 05 40 b9 00 00    	fldl   0xb940
    5350:	dd 45 90             	fldl   -0x70(%ebp)
    5353:	d9 c9                	fxch   %st(1)
    5355:	df e9                	fucomip %st(1),%st
    5357:	dd d8                	fstp   %st(0)
    5359:	76 59                	jbe    53b4 <ln+0xe9>
	{
		double n=-1;
    535b:	d9 e8                	fld1   
    535d:	d9 e0                	fchs   
    535f:	dd 5d c8             	fstpl  -0x38(%ebp)
		double a;
		do
		{
			n=n-.6;
    5362:	dd 45 c8             	fldl   -0x38(%ebp)
    5365:	dd 05 48 b9 00 00    	fldl   0xb948
    536b:	de e9                	fsubrp %st,%st(1)
    536d:	dd 5d c8             	fstpl  -0x38(%ebp)
			a=x/exp(n);
    5370:	dd 45 c8             	fldl   -0x38(%ebp)
    5373:	dd 1c 24             	fstpl  (%esp)
    5376:	e8 33 01 00 00       	call   54ae <exp>
    537b:	dd 45 90             	fldl   -0x70(%ebp)
    537e:	de f1                	fdivp  %st,%st(1)
    5380:	dd 5d a0             	fstpl  -0x60(%ebp)
		}
		while(a>2 || a<1);
    5383:	dd 45 a0             	fldl   -0x60(%ebp)
    5386:	dd 05 38 b9 00 00    	fldl   0xb938
    538c:	d9 c9                	fxch   %st(1)
    538e:	df e9                	fucomip %st(1),%st
    5390:	dd d8                	fstp   %st(0)
    5392:	77 ce                	ja     5362 <ln+0x97>
    5394:	d9 e8                	fld1   
    5396:	dd 45 a0             	fldl   -0x60(%ebp)
    5399:	d9 c9                	fxch   %st(1)
    539b:	df e9                	fucomip %st(1),%st
    539d:	dd d8                	fstp   %st(0)
    539f:	77 c1                	ja     5362 <ln+0x97>
		return ln(a)+n;
    53a1:	dd 45 a0             	fldl   -0x60(%ebp)
    53a4:	dd 1c 24             	fstpl  (%esp)
    53a7:	e8 1f ff ff ff       	call   52cb <ln>
    53ac:	dc 45 c8             	faddl  -0x38(%ebp)
    53af:	e9 f8 00 00 00       	jmp    54ac <ln+0x1e1>
	}
	for(l=1,tmp=1;(ln_px-ln_tmp)>1e-9 || (ln_px-ln_tmp)<-1e-9;l++)
    53b4:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    53bb:	d9 e8                	fld1   
    53bd:	dd 5d d8             	fstpl  -0x28(%ebp)
    53c0:	e9 b6 00 00 00       	jmp    547b <ln+0x1b0>
	{
		ln_tmp=ln_px;
    53c5:	dd 45 e8             	fldl   -0x18(%ebp)
    53c8:	dd 5d e0             	fstpl  -0x20(%ebp)
		tmp*=y;
    53cb:	dd 45 d8             	fldl   -0x28(%ebp)
    53ce:	dc 4d c0             	fmull  -0x40(%ebp)
    53d1:	dd 5d d8             	fstpl  -0x28(%ebp)
		if(l==1) tmp=tmp/l;
    53d4:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
    53d8:	75 0d                	jne    53e7 <ln+0x11c>
    53da:	db 45 d4             	fildl  -0x2c(%ebp)
    53dd:	dd 45 d8             	fldl   -0x28(%ebp)
    53e0:	de f1                	fdivp  %st,%st(1)
    53e2:	dd 5d d8             	fstpl  -0x28(%ebp)
    53e5:	eb 13                	jmp    53fa <ln+0x12f>
		else tmp=tmp/-l;
    53e7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    53ea:	f7 d8                	neg    %eax
    53ec:	89 45 8c             	mov    %eax,-0x74(%ebp)
    53ef:	db 45 8c             	fildl  -0x74(%ebp)
    53f2:	dd 45 d8             	fldl   -0x28(%ebp)
    53f5:	de f1                	fdivp  %st,%st(1)
    53f7:	dd 5d d8             	fstpl  -0x28(%ebp)
		ln_p1+=tmp;
    53fa:	dd 45 f0             	fldl   -0x10(%ebp)
    53fd:	dc 45 d8             	faddl  -0x28(%ebp)
    5400:	dd 5d f0             	fstpl  -0x10(%ebp)
		ln_p2=ln_p1+-1*tmp*y*l/(l+1);
    5403:	dd 45 d8             	fldl   -0x28(%ebp)
    5406:	d9 e0                	fchs   
    5408:	dc 4d c0             	fmull  -0x40(%ebp)
    540b:	db 45 d4             	fildl  -0x2c(%ebp)
    540e:	de c9                	fmulp  %st,%st(1)
    5410:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    5413:	83 c0 01             	add    $0x1,%eax
    5416:	89 45 8c             	mov    %eax,-0x74(%ebp)
    5419:	db 45 8c             	fildl  -0x74(%ebp)
    541c:	de f9                	fdivrp %st,%st(1)
    541e:	dc 45 f0             	faddl  -0x10(%ebp)
    5421:	dd 5d b8             	fstpl  -0x48(%ebp)
		ln_p3=ln_p2+tmp*y*y*l/(l+2);
    5424:	dd 45 d8             	fldl   -0x28(%ebp)
    5427:	dc 4d c0             	fmull  -0x40(%ebp)
    542a:	dc 4d c0             	fmull  -0x40(%ebp)
    542d:	db 45 d4             	fildl  -0x2c(%ebp)
    5430:	de c9                	fmulp  %st,%st(1)
    5432:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    5435:	83 c0 02             	add    $0x2,%eax
    5438:	89 45 8c             	mov    %eax,-0x74(%ebp)
    543b:	db 45 8c             	fildl  -0x74(%ebp)
    543e:	de f9                	fdivrp %st,%st(1)
    5440:	dc 45 b8             	faddl  -0x48(%ebp)
    5443:	dd 5d b0             	fstpl  -0x50(%ebp)
		dln_px=ln_p3-ln_p2;
    5446:	dd 45 b0             	fldl   -0x50(%ebp)
    5449:	dc 65 b8             	fsubl  -0x48(%ebp)
    544c:	dd 5d a8             	fstpl  -0x58(%ebp)
		ln_px=ln_p3-dln_px*dln_px/(ln_p3-2*ln_p2+ln_p1);
    544f:	dd 45 a8             	fldl   -0x58(%ebp)
    5452:	dc 4d a8             	fmull  -0x58(%ebp)
    5455:	dd 45 b8             	fldl   -0x48(%ebp)
    5458:	d8 c0                	fadd   %st(0),%st
    545a:	dd 45 b0             	fldl   -0x50(%ebp)
    545d:	de e1                	fsubp  %st,%st(1)
    545f:	dc 45 f0             	faddl  -0x10(%ebp)
    5462:	de f9                	fdivrp %st,%st(1)
    5464:	dd 45 b0             	fldl   -0x50(%ebp)
    5467:	de e1                	fsubp  %st,%st(1)
    5469:	dd 5d e8             	fstpl  -0x18(%ebp)
		tmp*=l;
    546c:	db 45 d4             	fildl  -0x2c(%ebp)
    546f:	dd 45 d8             	fldl   -0x28(%ebp)
    5472:	de c9                	fmulp  %st,%st(1)
    5474:	dd 5d d8             	fstpl  -0x28(%ebp)
			a=x/exp(n);
		}
		while(a>2 || a<1);
		return ln(a)+n;
	}
	for(l=1,tmp=1;(ln_px-ln_tmp)>1e-9 || (ln_px-ln_tmp)<-1e-9;l++)
    5477:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    547b:	dd 45 e8             	fldl   -0x18(%ebp)
    547e:	dc 65 e0             	fsubl  -0x20(%ebp)
    5481:	dd 05 50 b9 00 00    	fldl   0xb950
    5487:	d9 c9                	fxch   %st(1)
    5489:	df e9                	fucomip %st(1),%st
    548b:	dd d8                	fstp   %st(0)
    548d:	0f 87 32 ff ff ff    	ja     53c5 <ln+0xfa>
    5493:	dd 45 e8             	fldl   -0x18(%ebp)
    5496:	dc 65 e0             	fsubl  -0x20(%ebp)
    5499:	dd 05 58 b9 00 00    	fldl   0xb958
    549f:	df e9                	fucomip %st(1),%st
    54a1:	dd d8                	fstp   %st(0)
    54a3:	0f 87 1c ff ff ff    	ja     53c5 <ln+0xfa>
		ln_p3=ln_p2+tmp*y*y*l/(l+2);
		dln_px=ln_p3-ln_p2;
		ln_px=ln_p3-dln_px*dln_px/(ln_p3-2*ln_p2+ln_p1);
		tmp*=l;
	}
	return ln_px;
    54a9:	dd 45 e8             	fldl   -0x18(%ebp)
}
    54ac:	c9                   	leave  
    54ad:	c3                   	ret    

000054ae <exp>:

// 求e^x 用于Pow( double, double )调用
// e^x = 1+x+(x^2)/2!+(x^3)/3!+...
// 精度为7位
double exp( double x )
{
    54ae:	55                   	push   %ebp
    54af:	89 e5                	mov    %esp,%ebp
    54b1:	83 ec 78             	sub    $0x78,%esp
    54b4:	8b 45 08             	mov    0x8(%ebp),%eax
    54b7:	89 45 a0             	mov    %eax,-0x60(%ebp)
    54ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    54bd:	89 45 a4             	mov    %eax,-0x5c(%ebp)
	double y=x,ex_p1=0,ex_p2=0,ex_p3=0,ex_px=0,ex_tmp=1,dex_px=1,tmp;
    54c0:	dd 45 a0             	fldl   -0x60(%ebp)
    54c3:	dd 5d c0             	fstpl  -0x40(%ebp)
    54c6:	d9 ee                	fldz   
    54c8:	dd 5d f0             	fstpl  -0x10(%ebp)
    54cb:	d9 ee                	fldz   
    54cd:	dd 5d b8             	fstpl  -0x48(%ebp)
    54d0:	d9 ee                	fldz   
    54d2:	dd 5d b0             	fstpl  -0x50(%ebp)
    54d5:	d9 ee                	fldz   
    54d7:	dd 5d e8             	fstpl  -0x18(%ebp)
    54da:	d9 e8                	fld1   
    54dc:	dd 5d e0             	fstpl  -0x20(%ebp)
    54df:	d9 e8                	fld1   
    54e1:	dd 5d d8             	fstpl  -0x28(%ebp)
	int l;
	if(x==0) return 1;
    54e4:	dd 45 a0             	fldl   -0x60(%ebp)
    54e7:	d9 ee                	fldz   
    54e9:	df e9                	fucomip %st(1),%st
    54eb:	dd d8                	fstp   %st(0)
    54ed:	7a 12                	jp     5501 <exp+0x53>
    54ef:	dd 45 a0             	fldl   -0x60(%ebp)
    54f2:	d9 ee                	fldz   
    54f4:	df e9                	fucomip %st(1),%st
    54f6:	dd d8                	fstp   %st(0)
    54f8:	75 07                	jne    5501 <exp+0x53>
    54fa:	d9 e8                	fld1   
    54fc:	e9 08 01 00 00       	jmp    5609 <exp+0x15b>
	if(x<0) return 1/exp(-x); 
    5501:	d9 ee                	fldz   
    5503:	dd 45 a0             	fldl   -0x60(%ebp)
    5506:	d9 c9                	fxch   %st(1)
    5508:	df e9                	fucomip %st(1),%st
    550a:	dd d8                	fstp   %st(0)
    550c:	76 16                	jbe    5524 <exp+0x76>
    550e:	dd 45 a0             	fldl   -0x60(%ebp)
    5511:	d9 e0                	fchs   
    5513:	dd 1c 24             	fstpl  (%esp)
    5516:	e8 93 ff ff ff       	call   54ae <exp>
    551b:	d9 e8                	fld1   
    551d:	de f1                	fdivp  %st,%st(1)
    551f:	e9 e5 00 00 00       	jmp    5609 <exp+0x15b>
	for(l=1,tmp=1;((ex_px-ex_tmp)>1e-10 || (ex_px-ex_tmp)<-1e-10) && dex_px>1e-10;l++)
    5524:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
    552b:	d9 e8                	fld1   
    552d:	dd 5d d0             	fstpl  -0x30(%ebp)
    5530:	e9 92 00 00 00       	jmp    55c7 <exp+0x119>
	{
		ex_tmp=ex_px;
    5535:	dd 45 e8             	fldl   -0x18(%ebp)
    5538:	dd 5d e0             	fstpl  -0x20(%ebp)
		tmp*=y;
    553b:	dd 45 d0             	fldl   -0x30(%ebp)
    553e:	dc 4d c0             	fmull  -0x40(%ebp)
    5541:	dd 5d d0             	fstpl  -0x30(%ebp)
		tmp=tmp/l;
    5544:	db 45 cc             	fildl  -0x34(%ebp)
    5547:	dd 45 d0             	fldl   -0x30(%ebp)
    554a:	de f1                	fdivp  %st,%st(1)
    554c:	dd 5d d0             	fstpl  -0x30(%ebp)
		ex_p1+=tmp;
    554f:	dd 45 f0             	fldl   -0x10(%ebp)
    5552:	dc 45 d0             	faddl  -0x30(%ebp)
    5555:	dd 5d f0             	fstpl  -0x10(%ebp)
		ex_p2=ex_p1+tmp*y/(l+1);
    5558:	dd 45 d0             	fldl   -0x30(%ebp)
    555b:	dc 4d c0             	fmull  -0x40(%ebp)
    555e:	8b 45 cc             	mov    -0x34(%ebp),%eax
    5561:	83 c0 01             	add    $0x1,%eax
    5564:	89 45 9c             	mov    %eax,-0x64(%ebp)
    5567:	db 45 9c             	fildl  -0x64(%ebp)
    556a:	de f9                	fdivrp %st,%st(1)
    556c:	dc 45 f0             	faddl  -0x10(%ebp)
    556f:	dd 5d b8             	fstpl  -0x48(%ebp)
		ex_p3=ex_p2+tmp*y*y/(l+1)/(l+2);
    5572:	dd 45 d0             	fldl   -0x30(%ebp)
    5575:	dc 4d c0             	fmull  -0x40(%ebp)
    5578:	dc 4d c0             	fmull  -0x40(%ebp)
    557b:	8b 45 cc             	mov    -0x34(%ebp),%eax
    557e:	83 c0 01             	add    $0x1,%eax
    5581:	89 45 9c             	mov    %eax,-0x64(%ebp)
    5584:	db 45 9c             	fildl  -0x64(%ebp)
    5587:	de f9                	fdivrp %st,%st(1)
    5589:	8b 45 cc             	mov    -0x34(%ebp),%eax
    558c:	83 c0 02             	add    $0x2,%eax
    558f:	89 45 9c             	mov    %eax,-0x64(%ebp)
    5592:	db 45 9c             	fildl  -0x64(%ebp)
    5595:	de f9                	fdivrp %st,%st(1)
    5597:	dc 45 b8             	faddl  -0x48(%ebp)
    559a:	dd 5d b0             	fstpl  -0x50(%ebp)
		dex_px=ex_p3-ex_p2;
    559d:	dd 45 b0             	fldl   -0x50(%ebp)
    55a0:	dc 65 b8             	fsubl  -0x48(%ebp)
    55a3:	dd 5d d8             	fstpl  -0x28(%ebp)
		ex_px=ex_p3-dex_px*dex_px/(ex_p3-2*ex_p2+ex_p1);
    55a6:	dd 45 d8             	fldl   -0x28(%ebp)
    55a9:	dc 4d d8             	fmull  -0x28(%ebp)
    55ac:	dd 45 b8             	fldl   -0x48(%ebp)
    55af:	d8 c0                	fadd   %st(0),%st
    55b1:	dd 45 b0             	fldl   -0x50(%ebp)
    55b4:	de e1                	fsubp  %st,%st(1)
    55b6:	dc 45 f0             	faddl  -0x10(%ebp)
    55b9:	de f9                	fdivrp %st,%st(1)
    55bb:	dd 45 b0             	fldl   -0x50(%ebp)
    55be:	de e1                	fsubp  %st,%st(1)
    55c0:	dd 5d e8             	fstpl  -0x18(%ebp)
{
	double y=x,ex_p1=0,ex_p2=0,ex_p3=0,ex_px=0,ex_tmp=1,dex_px=1,tmp;
	int l;
	if(x==0) return 1;
	if(x<0) return 1/exp(-x); 
	for(l=1,tmp=1;((ex_px-ex_tmp)>1e-10 || (ex_px-ex_tmp)<-1e-10) && dex_px>1e-10;l++)
    55c3:	83 45 cc 01          	addl   $0x1,-0x34(%ebp)
    55c7:	dd 45 e8             	fldl   -0x18(%ebp)
    55ca:	dc 65 e0             	fsubl  -0x20(%ebp)
    55cd:	dd 05 60 b9 00 00    	fldl   0xb960
    55d3:	d9 c9                	fxch   %st(1)
    55d5:	df e9                	fucomip %st(1),%st
    55d7:	dd d8                	fstp   %st(0)
    55d9:	77 12                	ja     55ed <exp+0x13f>
    55db:	dd 45 e8             	fldl   -0x18(%ebp)
    55de:	dc 65 e0             	fsubl  -0x20(%ebp)
    55e1:	dd 05 68 b9 00 00    	fldl   0xb968
    55e7:	df e9                	fucomip %st(1),%st
    55e9:	dd d8                	fstp   %st(0)
    55eb:	76 15                	jbe    5602 <exp+0x154>
    55ed:	dd 45 d8             	fldl   -0x28(%ebp)
    55f0:	dd 05 60 b9 00 00    	fldl   0xb960
    55f6:	d9 c9                	fxch   %st(1)
    55f8:	df e9                	fucomip %st(1),%st
    55fa:	dd d8                	fstp   %st(0)
    55fc:	0f 87 33 ff ff ff    	ja     5535 <exp+0x87>
		ex_p2=ex_p1+tmp*y/(l+1);
		ex_p3=ex_p2+tmp*y*y/(l+1)/(l+2);
		dex_px=ex_p3-ex_p2;
		ex_px=ex_p3-dex_px*dex_px/(ex_p3-2*ex_p2+ex_p1);
	}
	return ex_px+1;
    5602:	dd 45 e8             	fldl   -0x18(%ebp)
    5605:	d9 e8                	fld1   
    5607:	de c1                	faddp  %st,%st(1)
    5609:	c9                   	leave  
    560a:	c3                   	ret    

0000560b <OpenTableFile>:
};
double  s_freq[4] = {44.1, 48, 32, 0};
char *mode_names[4] = { "stereo", "j-stereo", "dual-ch", "single-ch" };

int OpenTableFile(char *name)
{
    560b:	55                   	push   %ebp
    560c:	89 e5                	mov    %esp,%ebp
    560e:	83 ec 78             	sub    $0x78,%esp
	char fulname[80];
	int f;

	fulname[0] = '\0';
    5611:	c6 45 a4 00          	movb   $0x0,-0x5c(%ebp)
	strcpy(fulname, name);
    5615:	8b 45 08             	mov    0x8(%ebp),%eax
    5618:	89 44 24 04          	mov    %eax,0x4(%esp)
    561c:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    561f:	89 04 24             	mov    %eax,(%esp)
    5622:	e8 f0 f1 ff ff       	call   4817 <strcpy>
	//-1 ?
	if( (f=open(fulname,O_RDWR))==-1 ) {
    5627:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    562e:	00 
    562f:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    5632:	89 04 24             	mov    %eax,(%esp)
    5635:	e8 60 f4 ff ff       	call   4a9a <open>
    563a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    563d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    5641:	75 1b                	jne    565e <OpenTableFile+0x53>
		printf(0,"\nOpenTable: could not find %s\n", fulname);
    5643:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    5646:	89 44 24 08          	mov    %eax,0x8(%esp)
    564a:	c7 44 24 04 9c b9 00 	movl   $0xb99c,0x4(%esp)
    5651:	00 
    5652:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5659:	e8 ec f5 ff ff       	call   4c4a <printf>
    }
    return f;
    565e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    5661:	c9                   	leave  
    5662:	c3                   	ret    

00005663 <WriteHdr>:


void WriteHdr(struct frame_params *fr_ps)
{
    5663:	55                   	push   %ebp
    5664:	89 e5                	mov    %esp,%ebp
    5666:	57                   	push   %edi
    5667:	56                   	push   %esi
    5668:	53                   	push   %ebx
    5669:	83 ec 3c             	sub    $0x3c,%esp
	layer *info = fr_ps->header;
    566c:	8b 45 08             	mov    0x8(%ebp),%eax
    566f:	8b 00                	mov    (%eax),%eax
    5671:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	printf(0, "HDR:  sync=FFF, id=%X, layer=%X, ep=%X, br=%X, sf=%X, pd=%X, ",
    5674:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5677:	8b 78 14             	mov    0x14(%eax),%edi
    567a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    567d:	8b 70 10             	mov    0x10(%eax),%esi
    5680:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5683:	8b 58 0c             	mov    0xc(%eax),%ebx
		info->version, info->lay, !info->error_protection,
    5686:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5689:	8b 40 08             	mov    0x8(%eax),%eax

void WriteHdr(struct frame_params *fr_ps)
{
	layer *info = fr_ps->header;

	printf(0, "HDR:  sync=FFF, id=%X, layer=%X, ep=%X, br=%X, sf=%X, pd=%X, ",
    568c:	85 c0                	test   %eax,%eax
    568e:	0f 94 c0             	sete   %al
    5691:	0f b6 c8             	movzbl %al,%ecx
    5694:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5697:	8b 50 04             	mov    0x4(%eax),%edx
    569a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    569d:	8b 00                	mov    (%eax),%eax
    569f:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
    56a3:	89 74 24 18          	mov    %esi,0x18(%esp)
    56a7:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    56ab:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    56af:	89 54 24 0c          	mov    %edx,0xc(%esp)
    56b3:	89 44 24 08          	mov    %eax,0x8(%esp)
    56b7:	c7 44 24 04 bc b9 00 	movl   $0xb9bc,0x4(%esp)
    56be:	00 
    56bf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    56c6:	e8 7f f5 ff ff       	call   4c4a <printf>
		info->version, info->lay, !info->error_protection,
		info->bitrate_index, info->sampling_frequency, info->padding);

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
    56cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    56ce:	8b 78 2c             	mov    0x2c(%eax),%edi
    56d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    56d4:	8b 70 28             	mov    0x28(%eax),%esi
    56d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    56da:	8b 58 24             	mov    0x24(%eax),%ebx
    56dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    56e0:	8b 48 20             	mov    0x20(%eax),%ecx
    56e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    56e6:	8b 50 1c             	mov    0x1c(%eax),%edx
    56e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    56ec:	8b 40 18             	mov    0x18(%eax),%eax
    56ef:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
    56f3:	89 74 24 18          	mov    %esi,0x18(%esp)
    56f7:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    56fb:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    56ff:	89 54 24 0c          	mov    %edx,0xc(%esp)
    5703:	89 44 24 08          	mov    %eax,0x8(%esp)
    5707:	c7 44 24 04 fc b9 00 	movl   $0xb9fc,0x4(%esp)
    570e:	00 
    570f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5716:	e8 2f f5 ff ff       	call   4c4a <printf>
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);
    571b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    571e:	8b 40 1c             	mov    0x1c(%eax),%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    5721:	8b 0c 85 40 f3 00 00 	mov    0xf340(,%eax,4),%ecx
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);
    5728:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    572b:	8b 40 10             	mov    0x10(%eax),%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    572e:	dd 04 c5 20 f3 00 00 	fldl   0xf320(,%eax,8)
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
    5735:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5738:	8b 40 04             	mov    0x4(%eax),%eax
    573b:	8d 50 ff             	lea    -0x1(%eax),%edx
    573e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5741:	8b 58 0c             	mov    0xc(%eax),%ebx

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    5744:	89 d0                	mov    %edx,%eax
    5746:	c1 e0 04             	shl    $0x4,%eax
    5749:	29 d0                	sub    %edx,%eax
    574b:	01 d8                	add    %ebx,%eax
    574d:	8b 14 85 60 f2 00 00 	mov    0xf260(,%eax,4),%edx
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
    5754:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5757:	8b 40 04             	mov    0x4(%eax),%eax
    575a:	83 e8 01             	sub    $0x1,%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    575d:	8b 04 85 40 f2 00 00 	mov    0xf240(,%eax,4),%eax
    5764:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    5768:	dd 5c 24 10          	fstpl  0x10(%esp)
    576c:	89 54 24 0c          	mov    %edx,0xc(%esp)
    5770:	89 44 24 08          	mov    %eax,0x8(%esp)
    5774:	c7 44 24 04 24 ba 00 	movl   $0xba24,0x4(%esp)
    577b:	00 
    577c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5783:	e8 c2 f4 ff ff       	call   4c4a <printf>
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);

	printf(0, "sblim=%d, jsbd=%d, ch=%d\n",
    5788:	8b 45 08             	mov    0x8(%ebp),%eax
    578b:	8b 48 08             	mov    0x8(%eax),%ecx
    578e:	8b 45 08             	mov    0x8(%ebp),%eax
    5791:	8b 50 0c             	mov    0xc(%eax),%edx
    5794:	8b 45 08             	mov    0x8(%ebp),%eax
    5797:	8b 40 10             	mov    0x10(%eax),%eax
    579a:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    579e:	89 54 24 0c          	mov    %edx,0xc(%esp)
    57a2:	89 44 24 08          	mov    %eax,0x8(%esp)
    57a6:	c7 44 24 04 53 ba 00 	movl   $0xba53,0x4(%esp)
    57ad:	00 
    57ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    57b5:	e8 90 f4 ff ff       	call   4c4a <printf>
		fr_ps->sblimit, fr_ps->jsbound, fr_ps->stereo);
}
    57ba:	83 c4 3c             	add    $0x3c,%esp
    57bd:	5b                   	pop    %ebx
    57be:	5e                   	pop    %esi
    57bf:	5f                   	pop    %edi
    57c0:	5d                   	pop    %ebp
    57c1:	c3                   	ret    

000057c2 <mem_alloc>:

void *mem_alloc(unsigned long block, char *item)
{
    57c2:	55                   	push   %ebp
    57c3:	89 e5                	mov    %esp,%ebp
    57c5:	83 ec 28             	sub    $0x28,%esp
	void *ptr;
	ptr = (void *)malloc((unsigned long)block);
    57c8:	8b 45 08             	mov    0x8(%ebp),%eax
    57cb:	89 04 24             	mov    %eax,(%esp)
    57ce:	e8 63 f7 ff ff       	call   4f36 <malloc>
    57d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if (ptr != 0)
    57d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    57da:	74 1c                	je     57f8 <mem_alloc+0x36>
		memset(ptr, 0, block);
    57dc:	8b 45 08             	mov    0x8(%ebp),%eax
    57df:	89 44 24 08          	mov    %eax,0x8(%esp)
    57e3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    57ea:	00 
    57eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    57ee:	89 04 24             	mov    %eax,(%esp)
    57f1:	e8 b7 f0 ff ff       	call   48ad <memset>
    57f6:	eb 20                	jmp    5818 <mem_alloc+0x56>
	else{
		printf(0, "Unable to allocate %s\n", item);
    57f8:	8b 45 0c             	mov    0xc(%ebp),%eax
    57fb:	89 44 24 08          	mov    %eax,0x8(%esp)
    57ff:	c7 44 24 04 6d ba 00 	movl   $0xba6d,0x4(%esp)
    5806:	00 
    5807:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    580e:	e8 37 f4 ff ff       	call   4c4a <printf>
		exit();
    5813:	e8 42 f2 ff ff       	call   4a5a <exit>
	}
	return ptr;
    5818:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    581b:	c9                   	leave  
    581c:	c3                   	ret    

0000581d <alloc_buffer>:

void alloc_buffer(Bit_stream_struc *bs, int size)
{
    581d:	55                   	push   %ebp
    581e:	89 e5                	mov    %esp,%ebp
    5820:	83 ec 18             	sub    $0x18,%esp
	bs->buf = (unsigned char *) mem_alloc(size*sizeof(unsigned char), "buffer");
    5823:	8b 45 0c             	mov    0xc(%ebp),%eax
    5826:	c7 44 24 04 84 ba 00 	movl   $0xba84,0x4(%esp)
    582d:	00 
    582e:	89 04 24             	mov    %eax,(%esp)
    5831:	e8 8c ff ff ff       	call   57c2 <mem_alloc>
    5836:	8b 55 08             	mov    0x8(%ebp),%edx
    5839:	89 42 04             	mov    %eax,0x4(%edx)
	bs->buf_size = size;
    583c:	8b 45 08             	mov    0x8(%ebp),%eax
    583f:	8b 55 0c             	mov    0xc(%ebp),%edx
    5842:	89 50 08             	mov    %edx,0x8(%eax)
}
    5845:	c9                   	leave  
    5846:	c3                   	ret    

00005847 <desalloc_buffer>:

void desalloc_buffer(Bit_stream_struc *bs)
{
    5847:	55                   	push   %ebp
    5848:	89 e5                	mov    %esp,%ebp
    584a:	83 ec 18             	sub    $0x18,%esp
	free(bs->buf);
    584d:	8b 45 08             	mov    0x8(%ebp),%eax
    5850:	8b 40 04             	mov    0x4(%eax),%eax
    5853:	89 04 24             	mov    %eax,(%esp)
    5856:	e8 a2 f5 ff ff       	call   4dfd <free>
}
    585b:	c9                   	leave  
    585c:	c3                   	ret    

0000585d <open_bit_stream_r>:

void open_bit_stream_r(Bit_stream_struc *bs, char *bs_filenam, int size)
{
    585d:	55                   	push   %ebp
    585e:	89 e5                	mov    %esp,%ebp
    5860:	83 ec 18             	sub    $0x18,%esp
	//register unsigned char flag = 1;

	if ((bs->pt = open(bs_filenam, O_RDWR)) == -1) {
    5863:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    586a:	00 
    586b:	8b 45 0c             	mov    0xc(%ebp),%eax
    586e:	89 04 24             	mov    %eax,(%esp)
    5871:	e8 24 f2 ff ff       	call   4a9a <open>
    5876:	8b 55 08             	mov    0x8(%ebp),%edx
    5879:	89 02                	mov    %eax,(%edx)
    587b:	8b 45 08             	mov    0x8(%ebp),%eax
    587e:	8b 00                	mov    (%eax),%eax
    5880:	83 f8 ff             	cmp    $0xffffffff,%eax
    5883:	75 20                	jne    58a5 <open_bit_stream_r+0x48>
		printf(0, "Could not find \"%s\".\n", bs_filenam);
    5885:	8b 45 0c             	mov    0xc(%ebp),%eax
    5888:	89 44 24 08          	mov    %eax,0x8(%esp)
    588c:	c7 44 24 04 8b ba 00 	movl   $0xba8b,0x4(%esp)
    5893:	00 
    5894:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    589b:	e8 aa f3 ff ff       	call   4c4a <printf>
		exit();
    58a0:	e8 b5 f1 ff ff       	call   4a5a <exit>
	}

	bs->format = BINARY;
    58a5:	8b 45 08             	mov    0x8(%ebp),%eax
    58a8:	c6 40 24 00          	movb   $0x0,0x24(%eax)
	alloc_buffer(bs, size);
    58ac:	8b 45 10             	mov    0x10(%ebp),%eax
    58af:	89 44 24 04          	mov    %eax,0x4(%esp)
    58b3:	8b 45 08             	mov    0x8(%ebp),%eax
    58b6:	89 04 24             	mov    %eax,(%esp)
    58b9:	e8 5f ff ff ff       	call   581d <alloc_buffer>
	bs->buf_byte_idx=0;
    58be:	8b 45 08             	mov    0x8(%ebp),%eax
    58c1:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
	bs->buf_bit_idx=0;
    58c8:	8b 45 08             	mov    0x8(%ebp),%eax
    58cb:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
	bs->totbit=0;
    58d2:	8b 45 08             	mov    0x8(%ebp),%eax
    58d5:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	bs->mode = READ_MODE;
    58dc:	8b 45 08             	mov    0x8(%ebp),%eax
    58df:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
	bs->eob = FALSE;
    58e6:	8b 45 08             	mov    0x8(%ebp),%eax
    58e9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
	bs->eobs = FALSE;
    58f0:	8b 45 08             	mov    0x8(%ebp),%eax
    58f3:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
    58fa:	c9                   	leave  
    58fb:	c3                   	ret    

000058fc <close_bit_stream_r>:

void close_bit_stream_r(Bit_stream_struc *bs)
{
    58fc:	55                   	push   %ebp
    58fd:	89 e5                	mov    %esp,%ebp
    58ff:	83 ec 18             	sub    $0x18,%esp
	close(bs->pt);
    5902:	8b 45 08             	mov    0x8(%ebp),%eax
    5905:	8b 00                	mov    (%eax),%eax
    5907:	89 04 24             	mov    %eax,(%esp)
    590a:	e8 73 f1 ff ff       	call   4a82 <close>
	desalloc_buffer(bs);
    590f:	8b 45 08             	mov    0x8(%ebp),%eax
    5912:	89 04 24             	mov    %eax,(%esp)
    5915:	e8 2d ff ff ff       	call   5847 <desalloc_buffer>
}
    591a:	c9                   	leave  
    591b:	c3                   	ret    

0000591c <end_bs>:

int end_bs(Bit_stream_struc *bs)
{
    591c:	55                   	push   %ebp
    591d:	89 e5                	mov    %esp,%ebp
  return(bs->eobs);
    591f:	8b 45 08             	mov    0x8(%ebp),%eax
    5922:	8b 40 20             	mov    0x20(%eax),%eax
}
    5925:	5d                   	pop    %ebp
    5926:	c3                   	ret    

00005927 <sstell>:


unsigned long sstell(Bit_stream_struc *bs)
{
    5927:	55                   	push   %ebp
    5928:	89 e5                	mov    %esp,%ebp
  return(bs->totbit);
    592a:	8b 45 08             	mov    0x8(%ebp),%eax
    592d:	8b 40 0c             	mov    0xc(%eax),%eax
}
    5930:	5d                   	pop    %ebp
    5931:	c3                   	ret    

00005932 <refill_buffer>:


void refill_buffer(Bit_stream_struc *bs)
{
    5932:	55                   	push   %ebp
    5933:	89 e5                	mov    %esp,%ebp
    5935:	56                   	push   %esi
    5936:	53                   	push   %ebx
    5937:	83 ec 10             	sub    $0x10,%esp
	register int i=bs->buf_size-2-bs->buf_byte_idx;
    593a:	8b 45 08             	mov    0x8(%ebp),%eax
    593d:	8b 40 08             	mov    0x8(%eax),%eax
    5940:	8d 50 fe             	lea    -0x2(%eax),%edx
    5943:	8b 45 08             	mov    0x8(%ebp),%eax
    5946:	8b 40 10             	mov    0x10(%eax),%eax
    5949:	89 d3                	mov    %edx,%ebx
    594b:	29 c3                	sub    %eax,%ebx
	register unsigned long n=1;
    594d:	be 01 00 00 00       	mov    $0x1,%esi

	while ((i>=0) && (!bs->eob)) {
    5952:	eb 35                	jmp    5989 <refill_buffer+0x57>
			n=read(bs->pt, &bs->buf[i--], sizeof(unsigned char));
    5954:	8b 45 08             	mov    0x8(%ebp),%eax
    5957:	8b 50 04             	mov    0x4(%eax),%edx
    595a:	89 d8                	mov    %ebx,%eax
    595c:	8d 58 ff             	lea    -0x1(%eax),%ebx
    595f:	01 c2                	add    %eax,%edx
    5961:	8b 45 08             	mov    0x8(%ebp),%eax
    5964:	8b 00                	mov    (%eax),%eax
    5966:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    596d:	00 
    596e:	89 54 24 04          	mov    %edx,0x4(%esp)
    5972:	89 04 24             	mov    %eax,(%esp)
    5975:	e8 f8 f0 ff ff       	call   4a72 <read>
    597a:	89 c6                	mov    %eax,%esi
		if (!n)
    597c:	85 f6                	test   %esi,%esi
    597e:	75 09                	jne    5989 <refill_buffer+0x57>
		bs->eob= i+1;
    5980:	8d 53 01             	lea    0x1(%ebx),%edx
    5983:	8b 45 08             	mov    0x8(%ebp),%eax
    5986:	89 50 1c             	mov    %edx,0x1c(%eax)
void refill_buffer(Bit_stream_struc *bs)
{
	register int i=bs->buf_size-2-bs->buf_byte_idx;
	register unsigned long n=1;

	while ((i>=0) && (!bs->eob)) {
    5989:	85 db                	test   %ebx,%ebx
    598b:	78 0a                	js     5997 <refill_buffer+0x65>
    598d:	8b 45 08             	mov    0x8(%ebp),%eax
    5990:	8b 40 1c             	mov    0x1c(%eax),%eax
    5993:	85 c0                	test   %eax,%eax
    5995:	74 bd                	je     5954 <refill_buffer+0x22>
			n=read(bs->pt, &bs->buf[i--], sizeof(unsigned char));
		if (!n)
		bs->eob= i+1;
	}
}
    5997:	83 c4 10             	add    $0x10,%esp
    599a:	5b                   	pop    %ebx
    599b:	5e                   	pop    %esi
    599c:	5d                   	pop    %ebp
    599d:	c3                   	ret    

0000599e <get1bit>:


int mask[8]={0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80};

unsigned int get1bit(Bit_stream_struc *bs)
{
    599e:	55                   	push   %ebp
    599f:	89 e5                	mov    %esp,%ebp
    59a1:	53                   	push   %ebx
    59a2:	83 ec 24             	sub    $0x24,%esp
   unsigned int bit;
   register int i;

   bs->totbit++;
    59a5:	8b 45 08             	mov    0x8(%ebp),%eax
    59a8:	8b 40 0c             	mov    0xc(%eax),%eax
    59ab:	8d 50 01             	lea    0x1(%eax),%edx
    59ae:	8b 45 08             	mov    0x8(%ebp),%eax
    59b1:	89 50 0c             	mov    %edx,0xc(%eax)

   if (!bs->buf_bit_idx) {
    59b4:	8b 45 08             	mov    0x8(%ebp),%eax
    59b7:	8b 40 14             	mov    0x14(%eax),%eax
    59ba:	85 c0                	test   %eax,%eax
    59bc:	0f 85 9f 00 00 00    	jne    5a61 <get1bit+0xc3>
        bs->buf_bit_idx = 8;
    59c2:	8b 45 08             	mov    0x8(%ebp),%eax
    59c5:	c7 40 14 08 00 00 00 	movl   $0x8,0x14(%eax)
        bs->buf_byte_idx--;
    59cc:	8b 45 08             	mov    0x8(%ebp),%eax
    59cf:	8b 40 10             	mov    0x10(%eax),%eax
    59d2:	8d 50 ff             	lea    -0x1(%eax),%edx
    59d5:	8b 45 08             	mov    0x8(%ebp),%eax
    59d8:	89 50 10             	mov    %edx,0x10(%eax)
        if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
    59db:	8b 45 08             	mov    0x8(%ebp),%eax
    59de:	8b 40 10             	mov    0x10(%eax),%eax
    59e1:	83 f8 03             	cmp    $0x3,%eax
    59e4:	7e 10                	jle    59f6 <get1bit+0x58>
    59e6:	8b 45 08             	mov    0x8(%ebp),%eax
    59e9:	8b 50 10             	mov    0x10(%eax),%edx
    59ec:	8b 45 08             	mov    0x8(%ebp),%eax
    59ef:	8b 40 1c             	mov    0x1c(%eax),%eax
    59f2:	39 c2                	cmp    %eax,%edx
    59f4:	7d 6b                	jge    5a61 <get1bit+0xc3>
             if (bs->eob)
    59f6:	8b 45 08             	mov    0x8(%ebp),%eax
    59f9:	8b 40 1c             	mov    0x1c(%eax),%eax
    59fc:	85 c0                	test   %eax,%eax
    59fe:	74 0c                	je     5a0c <get1bit+0x6e>
                bs->eobs = TRUE;
    5a00:	8b 45 08             	mov    0x8(%ebp),%eax
    5a03:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
    5a0a:	eb 55                	jmp    5a61 <get1bit+0xc3>
             else {
                for (i=bs->buf_byte_idx; i>=0;i--)
    5a0c:	8b 45 08             	mov    0x8(%ebp),%eax
    5a0f:	8b 58 10             	mov    0x10(%eax),%ebx
    5a12:	eb 2f                	jmp    5a43 <get1bit+0xa5>
                  bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
    5a14:	8b 45 08             	mov    0x8(%ebp),%eax
    5a17:	8b 50 04             	mov    0x4(%eax),%edx
    5a1a:	8b 45 08             	mov    0x8(%ebp),%eax
    5a1d:	8b 40 08             	mov    0x8(%eax),%eax
    5a20:	8d 48 ff             	lea    -0x1(%eax),%ecx
    5a23:	8b 45 08             	mov    0x8(%ebp),%eax
    5a26:	8b 40 10             	mov    0x10(%eax),%eax
    5a29:	29 c1                	sub    %eax,%ecx
    5a2b:	89 c8                	mov    %ecx,%eax
    5a2d:	01 d8                	add    %ebx,%eax
    5a2f:	01 c2                	add    %eax,%edx
    5a31:	8b 45 08             	mov    0x8(%ebp),%eax
    5a34:	8b 48 04             	mov    0x4(%eax),%ecx
    5a37:	89 d8                	mov    %ebx,%eax
    5a39:	01 c8                	add    %ecx,%eax
    5a3b:	0f b6 00             	movzbl (%eax),%eax
    5a3e:	88 02                	mov    %al,(%edx)
        bs->buf_byte_idx--;
        if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
             if (bs->eob)
                bs->eobs = TRUE;
             else {
                for (i=bs->buf_byte_idx; i>=0;i--)
    5a40:	83 eb 01             	sub    $0x1,%ebx
    5a43:	85 db                	test   %ebx,%ebx
    5a45:	79 cd                	jns    5a14 <get1bit+0x76>
                  bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
                refill_buffer(bs);
    5a47:	8b 45 08             	mov    0x8(%ebp),%eax
    5a4a:	89 04 24             	mov    %eax,(%esp)
    5a4d:	e8 e0 fe ff ff       	call   5932 <refill_buffer>
                bs->buf_byte_idx = bs->buf_size-1;
    5a52:	8b 45 08             	mov    0x8(%ebp),%eax
    5a55:	8b 40 08             	mov    0x8(%eax),%eax
    5a58:	8d 50 ff             	lea    -0x1(%eax),%edx
    5a5b:	8b 45 08             	mov    0x8(%ebp),%eax
    5a5e:	89 50 10             	mov    %edx,0x10(%eax)
             }
        }
   }
   bit = bs->buf[bs->buf_byte_idx]&mask[bs->buf_bit_idx-1];
    5a61:	8b 45 08             	mov    0x8(%ebp),%eax
    5a64:	8b 50 04             	mov    0x4(%eax),%edx
    5a67:	8b 45 08             	mov    0x8(%ebp),%eax
    5a6a:	8b 40 10             	mov    0x10(%eax),%eax
    5a6d:	01 d0                	add    %edx,%eax
    5a6f:	0f b6 00             	movzbl (%eax),%eax
    5a72:	0f b6 d0             	movzbl %al,%edx
    5a75:	8b 45 08             	mov    0x8(%ebp),%eax
    5a78:	8b 40 14             	mov    0x14(%eax),%eax
    5a7b:	83 e8 01             	sub    $0x1,%eax
    5a7e:	8b 04 85 60 f3 00 00 	mov    0xf360(,%eax,4),%eax
    5a85:	21 d0                	and    %edx,%eax
    5a87:	89 45 f4             	mov    %eax,-0xc(%ebp)
   bit = bit >> (bs->buf_bit_idx-1);
    5a8a:	8b 45 08             	mov    0x8(%ebp),%eax
    5a8d:	8b 40 14             	mov    0x14(%eax),%eax
    5a90:	83 e8 01             	sub    $0x1,%eax
    5a93:	89 c1                	mov    %eax,%ecx
    5a95:	d3 6d f4             	shrl   %cl,-0xc(%ebp)
   bs->buf_bit_idx--;
    5a98:	8b 45 08             	mov    0x8(%ebp),%eax
    5a9b:	8b 40 14             	mov    0x14(%eax),%eax
    5a9e:	8d 50 ff             	lea    -0x1(%eax),%edx
    5aa1:	8b 45 08             	mov    0x8(%ebp),%eax
    5aa4:	89 50 14             	mov    %edx,0x14(%eax)
   return(bit);
    5aa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    5aaa:	83 c4 24             	add    $0x24,%esp
    5aad:	5b                   	pop    %ebx
    5aae:	5d                   	pop    %ebp
    5aaf:	c3                   	ret    

00005ab0 <getbits>:

int putmask[9]={0x0, 0x1, 0x3, 0x7, 0xf, 0x1f, 0x3f, 0x7f, 0xff};

unsigned long getbits(Bit_stream_struc *bs, int N)
{
    5ab0:	55                   	push   %ebp
    5ab1:	89 e5                	mov    %esp,%ebp
    5ab3:	57                   	push   %edi
    5ab4:	56                   	push   %esi
    5ab5:	53                   	push   %ebx
    5ab6:	83 ec 2c             	sub    $0x2c,%esp
	unsigned long val=0;
    5ab9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	register int i;
	register int j = N;
    5ac0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	register int k, tmp;

	if (N > MAX_LENGTH)
    5ac3:	83 7d 0c 20          	cmpl   $0x20,0xc(%ebp)
    5ac7:	7e 1c                	jle    5ae5 <getbits+0x35>
		printf(0,"Cannot read or write more than %d bits at a time.\n", MAX_LENGTH);
    5ac9:	c7 44 24 08 20 00 00 	movl   $0x20,0x8(%esp)
    5ad0:	00 
    5ad1:	c7 44 24 04 a4 ba 00 	movl   $0xbaa4,0x4(%esp)
    5ad8:	00 
    5ad9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5ae0:	e8 65 f1 ff ff       	call   4c4a <printf>

	bs->totbit += N;
    5ae5:	8b 45 08             	mov    0x8(%ebp),%eax
    5ae8:	8b 50 0c             	mov    0xc(%eax),%edx
    5aeb:	8b 45 0c             	mov    0xc(%ebp),%eax
    5aee:	01 c2                	add    %eax,%edx
    5af0:	8b 45 08             	mov    0x8(%ebp),%eax
    5af3:	89 50 0c             	mov    %edx,0xc(%eax)
	while (j > 0) {
    5af6:	e9 0a 01 00 00       	jmp    5c05 <getbits+0x155>
		if (!bs->buf_bit_idx) {
    5afb:	8b 45 08             	mov    0x8(%ebp),%eax
    5afe:	8b 40 14             	mov    0x14(%eax),%eax
    5b01:	85 c0                	test   %eax,%eax
    5b03:	0f 85 9f 00 00 00    	jne    5ba8 <getbits+0xf8>
			bs->buf_bit_idx = 8;
    5b09:	8b 45 08             	mov    0x8(%ebp),%eax
    5b0c:	c7 40 14 08 00 00 00 	movl   $0x8,0x14(%eax)
			bs->buf_byte_idx--;
    5b13:	8b 45 08             	mov    0x8(%ebp),%eax
    5b16:	8b 40 10             	mov    0x10(%eax),%eax
    5b19:	8d 50 ff             	lea    -0x1(%eax),%edx
    5b1c:	8b 45 08             	mov    0x8(%ebp),%eax
    5b1f:	89 50 10             	mov    %edx,0x10(%eax)
			if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
    5b22:	8b 45 08             	mov    0x8(%ebp),%eax
    5b25:	8b 40 10             	mov    0x10(%eax),%eax
    5b28:	83 f8 03             	cmp    $0x3,%eax
    5b2b:	7e 10                	jle    5b3d <getbits+0x8d>
    5b2d:	8b 45 08             	mov    0x8(%ebp),%eax
    5b30:	8b 50 10             	mov    0x10(%eax),%edx
    5b33:	8b 45 08             	mov    0x8(%ebp),%eax
    5b36:	8b 40 1c             	mov    0x1c(%eax),%eax
    5b39:	39 c2                	cmp    %eax,%edx
    5b3b:	7d 6b                	jge    5ba8 <getbits+0xf8>
				if (bs->eob)
    5b3d:	8b 45 08             	mov    0x8(%ebp),%eax
    5b40:	8b 40 1c             	mov    0x1c(%eax),%eax
    5b43:	85 c0                	test   %eax,%eax
    5b45:	74 0c                	je     5b53 <getbits+0xa3>
					bs->eobs = TRUE;
    5b47:	8b 45 08             	mov    0x8(%ebp),%eax
    5b4a:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
    5b51:	eb 55                	jmp    5ba8 <getbits+0xf8>
				else {
					for (i=bs->buf_byte_idx; i>=0;i--)
    5b53:	8b 45 08             	mov    0x8(%ebp),%eax
    5b56:	8b 70 10             	mov    0x10(%eax),%esi
    5b59:	eb 2f                	jmp    5b8a <getbits+0xda>
						bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
    5b5b:	8b 45 08             	mov    0x8(%ebp),%eax
    5b5e:	8b 50 04             	mov    0x4(%eax),%edx
    5b61:	8b 45 08             	mov    0x8(%ebp),%eax
    5b64:	8b 40 08             	mov    0x8(%eax),%eax
    5b67:	8d 48 ff             	lea    -0x1(%eax),%ecx
    5b6a:	8b 45 08             	mov    0x8(%ebp),%eax
    5b6d:	8b 40 10             	mov    0x10(%eax),%eax
    5b70:	29 c1                	sub    %eax,%ecx
    5b72:	89 c8                	mov    %ecx,%eax
    5b74:	01 f0                	add    %esi,%eax
    5b76:	01 c2                	add    %eax,%edx
    5b78:	8b 45 08             	mov    0x8(%ebp),%eax
    5b7b:	8b 48 04             	mov    0x4(%eax),%ecx
    5b7e:	89 f0                	mov    %esi,%eax
    5b80:	01 c8                	add    %ecx,%eax
    5b82:	0f b6 00             	movzbl (%eax),%eax
    5b85:	88 02                	mov    %al,(%edx)
			bs->buf_byte_idx--;
			if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
				if (bs->eob)
					bs->eobs = TRUE;
				else {
					for (i=bs->buf_byte_idx; i>=0;i--)
    5b87:	83 ee 01             	sub    $0x1,%esi
    5b8a:	85 f6                	test   %esi,%esi
    5b8c:	79 cd                	jns    5b5b <getbits+0xab>
						bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
						refill_buffer(bs);
    5b8e:	8b 45 08             	mov    0x8(%ebp),%eax
    5b91:	89 04 24             	mov    %eax,(%esp)
    5b94:	e8 99 fd ff ff       	call   5932 <refill_buffer>
					bs->buf_byte_idx = bs->buf_size-1;
    5b99:	8b 45 08             	mov    0x8(%ebp),%eax
    5b9c:	8b 40 08             	mov    0x8(%eax),%eax
    5b9f:	8d 50 ff             	lea    -0x1(%eax),%edx
    5ba2:	8b 45 08             	mov    0x8(%ebp),%eax
    5ba5:	89 50 10             	mov    %edx,0x10(%eax)
				}
			}
		}
		k = MIN(j, bs->buf_bit_idx);
    5ba8:	8b 45 08             	mov    0x8(%ebp),%eax
    5bab:	8b 40 14             	mov    0x14(%eax),%eax
    5bae:	39 d8                	cmp    %ebx,%eax
    5bb0:	0f 4f c3             	cmovg  %ebx,%eax
    5bb3:	89 c6                	mov    %eax,%esi
		tmp = bs->buf[bs->buf_byte_idx]&putmask[bs->buf_bit_idx];
    5bb5:	8b 45 08             	mov    0x8(%ebp),%eax
    5bb8:	8b 50 04             	mov    0x4(%eax),%edx
    5bbb:	8b 45 08             	mov    0x8(%ebp),%eax
    5bbe:	8b 40 10             	mov    0x10(%eax),%eax
    5bc1:	01 d0                	add    %edx,%eax
    5bc3:	0f b6 00             	movzbl (%eax),%eax
    5bc6:	0f b6 d0             	movzbl %al,%edx
    5bc9:	8b 45 08             	mov    0x8(%ebp),%eax
    5bcc:	8b 40 14             	mov    0x14(%eax),%eax
    5bcf:	8b 04 85 80 f3 00 00 	mov    0xf380(,%eax,4),%eax
    5bd6:	89 d7                	mov    %edx,%edi
    5bd8:	21 c7                	and    %eax,%edi
		tmp = tmp >> (bs->buf_bit_idx-k);
    5bda:	8b 45 08             	mov    0x8(%ebp),%eax
    5bdd:	8b 40 14             	mov    0x14(%eax),%eax
    5be0:	29 f0                	sub    %esi,%eax
    5be2:	89 c1                	mov    %eax,%ecx
    5be4:	d3 ff                	sar    %cl,%edi
		val |= tmp << (j-k);
    5be6:	89 d8                	mov    %ebx,%eax
    5be8:	29 f0                	sub    %esi,%eax
    5bea:	89 c1                	mov    %eax,%ecx
    5bec:	d3 e7                	shl    %cl,%edi
    5bee:	89 f8                	mov    %edi,%eax
    5bf0:	09 45 e4             	or     %eax,-0x1c(%ebp)
		bs->buf_bit_idx -= k;
    5bf3:	8b 45 08             	mov    0x8(%ebp),%eax
    5bf6:	8b 40 14             	mov    0x14(%eax),%eax
    5bf9:	29 f0                	sub    %esi,%eax
    5bfb:	89 c2                	mov    %eax,%edx
    5bfd:	8b 45 08             	mov    0x8(%ebp),%eax
    5c00:	89 50 14             	mov    %edx,0x14(%eax)
		j -= k;
    5c03:	29 f3                	sub    %esi,%ebx

	if (N > MAX_LENGTH)
		printf(0,"Cannot read or write more than %d bits at a time.\n", MAX_LENGTH);

	bs->totbit += N;
	while (j > 0) {
    5c05:	85 db                	test   %ebx,%ebx
    5c07:	0f 8f ee fe ff ff    	jg     5afb <getbits+0x4b>
		tmp = tmp >> (bs->buf_bit_idx-k);
		val |= tmp << (j-k);
		bs->buf_bit_idx -= k;
		j -= k;
	}
	return val;
    5c0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
    5c10:	83 c4 2c             	add    $0x2c,%esp
    5c13:	5b                   	pop    %ebx
    5c14:	5e                   	pop    %esi
    5c15:	5f                   	pop    %edi
    5c16:	5d                   	pop    %ebp
    5c17:	c3                   	ret    

00005c18 <seek_sync>:


int seek_sync(Bit_stream_struc *bs, unsigned long sync, int N)
{
    5c18:	55                   	push   %ebp
    5c19:	89 e5                	mov    %esp,%ebp
    5c1b:	83 ec 38             	sub    $0x38,%esp
	unsigned long aligning;
	unsigned long val;
	long maxi = (int)pow(2.0, (double)N) - 1;
    5c1e:	db 45 10             	fildl  0x10(%ebp)
    5c21:	dd 5c 24 08          	fstpl  0x8(%esp)
    5c25:	dd 05 10 bb 00 00    	fldl   0xbb10
    5c2b:	dd 1c 24             	fstpl  (%esp)
    5c2e:	e8 ec f4 ff ff       	call   511f <pow>
    5c33:	d9 7d e6             	fnstcw -0x1a(%ebp)
    5c36:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    5c3a:	b4 0c                	mov    $0xc,%ah
    5c3c:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    5c40:	d9 6d e4             	fldcw  -0x1c(%ebp)
    5c43:	db 5d e0             	fistpl -0x20(%ebp)
    5c46:	d9 6d e6             	fldcw  -0x1a(%ebp)
    5c49:	8b 45 e0             	mov    -0x20(%ebp),%eax
    5c4c:	83 e8 01             	sub    $0x1,%eax
    5c4f:	89 45 f0             	mov    %eax,-0x10(%ebp)

	aligning = sstell(bs)%ALIGNING;
    5c52:	8b 45 08             	mov    0x8(%ebp),%eax
    5c55:	89 04 24             	mov    %eax,(%esp)
    5c58:	e8 ca fc ff ff       	call   5927 <sstell>
    5c5d:	83 e0 07             	and    $0x7,%eax
    5c60:	89 45 ec             	mov    %eax,-0x14(%ebp)
	if (aligning)
    5c63:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    5c67:	74 17                	je     5c80 <seek_sync+0x68>
		getbits(bs, (int)(ALIGNING-aligning));
    5c69:	b8 08 00 00 00       	mov    $0x8,%eax
    5c6e:	2b 45 ec             	sub    -0x14(%ebp),%eax
    5c71:	89 44 24 04          	mov    %eax,0x4(%esp)
    5c75:	8b 45 08             	mov    0x8(%ebp),%eax
    5c78:	89 04 24             	mov    %eax,(%esp)
    5c7b:	e8 30 fe ff ff       	call   5ab0 <getbits>

	val = getbits(bs, N);
    5c80:	8b 45 10             	mov    0x10(%ebp),%eax
    5c83:	89 44 24 04          	mov    %eax,0x4(%esp)
    5c87:	8b 45 08             	mov    0x8(%ebp),%eax
    5c8a:	89 04 24             	mov    %eax,(%esp)
    5c8d:	e8 1e fe ff ff       	call   5ab0 <getbits>
    5c92:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (((val&maxi) != sync) && (!end_bs(bs))) {
    5c95:	eb 1a                	jmp    5cb1 <seek_sync+0x99>
		val <<= ALIGNING;
    5c97:	c1 65 f4 08          	shll   $0x8,-0xc(%ebp)
		val |= getbits(bs, ALIGNING);
    5c9b:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
    5ca2:	00 
    5ca3:	8b 45 08             	mov    0x8(%ebp),%eax
    5ca6:	89 04 24             	mov    %eax,(%esp)
    5ca9:	e8 02 fe ff ff       	call   5ab0 <getbits>
    5cae:	09 45 f4             	or     %eax,-0xc(%ebp)
	aligning = sstell(bs)%ALIGNING;
	if (aligning)
		getbits(bs, (int)(ALIGNING-aligning));

	val = getbits(bs, N);
	while (((val&maxi) != sync) && (!end_bs(bs))) {
    5cb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5cb4:	23 45 f4             	and    -0xc(%ebp),%eax
    5cb7:	3b 45 0c             	cmp    0xc(%ebp),%eax
    5cba:	74 0f                	je     5ccb <seek_sync+0xb3>
    5cbc:	8b 45 08             	mov    0x8(%ebp),%eax
    5cbf:	89 04 24             	mov    %eax,(%esp)
    5cc2:	e8 55 fc ff ff       	call   591c <end_bs>
    5cc7:	85 c0                	test   %eax,%eax
    5cc9:	74 cc                	je     5c97 <seek_sync+0x7f>
		val <<= ALIGNING;
		val |= getbits(bs, ALIGNING);
	}

	if (end_bs(bs))
    5ccb:	8b 45 08             	mov    0x8(%ebp),%eax
    5cce:	89 04 24             	mov    %eax,(%esp)
    5cd1:	e8 46 fc ff ff       	call   591c <end_bs>
    5cd6:	85 c0                	test   %eax,%eax
    5cd8:	74 07                	je     5ce1 <seek_sync+0xc9>
		return(0);
    5cda:	b8 00 00 00 00       	mov    $0x0,%eax
    5cdf:	eb 05                	jmp    5ce6 <seek_sync+0xce>
	else
		return(1);
    5ce1:	b8 01 00 00 00       	mov    $0x1,%eax
}
    5ce6:	c9                   	leave  
    5ce7:	c3                   	ret    

00005ce8 <js_bound>:

int js_bound(int lay, int m_ext)
{
    5ce8:	55                   	push   %ebp
    5ce9:	89 e5                	mov    %esp,%ebp
    5ceb:	83 ec 18             	sub    $0x18,%esp
		{ 4, 8, 12, 16 },
		{ 4, 8, 12, 16},
		{ 0, 4, 8, 16}
	};  /* lay+m_e -> jsbound */

    if(lay<1 || lay >3 || m_ext<0 || m_ext>3) {
    5cee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    5cf2:	7e 12                	jle    5d06 <js_bound+0x1e>
    5cf4:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
    5cf8:	7f 0c                	jg     5d06 <js_bound+0x1e>
    5cfa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    5cfe:	78 06                	js     5d06 <js_bound+0x1e>
    5d00:	83 7d 0c 03          	cmpl   $0x3,0xc(%ebp)
    5d04:	7e 27                	jle    5d2d <js_bound+0x45>
        printf(0, "js_bound bad layer/modext (%d/%d)\n", lay, m_ext);
    5d06:	8b 45 0c             	mov    0xc(%ebp),%eax
    5d09:	89 44 24 0c          	mov    %eax,0xc(%esp)
    5d0d:	8b 45 08             	mov    0x8(%ebp),%eax
    5d10:	89 44 24 08          	mov    %eax,0x8(%esp)
    5d14:	c7 44 24 04 d8 ba 00 	movl   $0xbad8,0x4(%esp)
    5d1b:	00 
    5d1c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5d23:	e8 22 ef ff ff       	call   4c4a <printf>
        exit();
    5d28:	e8 2d ed ff ff       	call   4a5a <exit>
    }
	return(jsb_table[lay-1][m_ext]);
    5d2d:	8b 45 08             	mov    0x8(%ebp),%eax
    5d30:	83 e8 01             	sub    $0x1,%eax
    5d33:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    5d3a:	8b 45 0c             	mov    0xc(%ebp),%eax
    5d3d:	01 d0                	add    %edx,%eax
    5d3f:	8b 04 85 c0 f3 00 00 	mov    0xf3c0(,%eax,4),%eax
}
    5d46:	c9                   	leave  
    5d47:	c3                   	ret    

00005d48 <hdr_to_frps>:

void hdr_to_frps(struct frame_params *fr_ps)
{
    5d48:	55                   	push   %ebp
    5d49:	89 e5                	mov    %esp,%ebp
    5d4b:	83 ec 28             	sub    $0x28,%esp
	layer *hdr = fr_ps->header;     /* (or pass in as arg?) */
    5d4e:	8b 45 08             	mov    0x8(%ebp),%eax
    5d51:	8b 00                	mov    (%eax),%eax
    5d53:	89 45 f4             	mov    %eax,-0xc(%ebp)

	fr_ps->actual_mode = hdr->mode;
    5d56:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5d59:	8b 50 1c             	mov    0x1c(%eax),%edx
    5d5c:	8b 45 08             	mov    0x8(%ebp),%eax
    5d5f:	89 50 04             	mov    %edx,0x4(%eax)
	fr_ps->stereo = (hdr->mode == MPG_MD_MONO) ? 1 : 2;
    5d62:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5d65:	8b 40 1c             	mov    0x1c(%eax),%eax
    5d68:	83 f8 03             	cmp    $0x3,%eax
    5d6b:	75 07                	jne    5d74 <hdr_to_frps+0x2c>
    5d6d:	b8 01 00 00 00       	mov    $0x1,%eax
    5d72:	eb 05                	jmp    5d79 <hdr_to_frps+0x31>
    5d74:	b8 02 00 00 00       	mov    $0x2,%eax
    5d79:	8b 55 08             	mov    0x8(%ebp),%edx
    5d7c:	89 42 08             	mov    %eax,0x8(%edx)
	fr_ps->sblimit = SBLIMIT;
    5d7f:	8b 45 08             	mov    0x8(%ebp),%eax
    5d82:	c7 40 10 20 00 00 00 	movl   $0x20,0x10(%eax)
	if(hdr->mode == MPG_MD_JOINT_STEREO)
    5d89:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5d8c:	8b 40 1c             	mov    0x1c(%eax),%eax
    5d8f:	83 f8 01             	cmp    $0x1,%eax
    5d92:	75 20                	jne    5db4 <hdr_to_frps+0x6c>
		fr_ps->jsbound = js_bound(hdr->lay, hdr->mode_ext);
    5d94:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5d97:	8b 50 20             	mov    0x20(%eax),%edx
    5d9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5d9d:	8b 40 04             	mov    0x4(%eax),%eax
    5da0:	89 54 24 04          	mov    %edx,0x4(%esp)
    5da4:	89 04 24             	mov    %eax,(%esp)
    5da7:	e8 3c ff ff ff       	call   5ce8 <js_bound>
    5dac:	8b 55 08             	mov    0x8(%ebp),%edx
    5daf:	89 42 0c             	mov    %eax,0xc(%edx)
    5db2:	eb 0c                	jmp    5dc0 <hdr_to_frps+0x78>
	else
		fr_ps->jsbound = fr_ps->sblimit;
    5db4:	8b 45 08             	mov    0x8(%ebp),%eax
    5db7:	8b 50 10             	mov    0x10(%eax),%edx
    5dba:	8b 45 08             	mov    0x8(%ebp),%eax
    5dbd:	89 50 0c             	mov    %edx,0xc(%eax)
}
    5dc0:	c9                   	leave  
    5dc1:	c3                   	ret    

00005dc2 <hputbuf>:

void hputbuf(unsigned int val, int N)
{
    5dc2:	55                   	push   %ebp
    5dc3:	89 e5                	mov    %esp,%ebp
    5dc5:	83 ec 18             	sub    $0x18,%esp
	if (N != 8) {
    5dc8:	83 7d 0c 08          	cmpl   $0x8,0xc(%ebp)
    5dcc:	74 19                	je     5de7 <hputbuf+0x25>
		printf(0,"Not Supported yet!!\n");
    5dce:	c7 44 24 04 fb ba 00 	movl   $0xbafb,0x4(%esp)
    5dd5:	00 
    5dd6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5ddd:	e8 68 ee ff ff       	call   4c4a <printf>
		exit();
    5de2:	e8 73 ec ff ff       	call   4a5a <exit>
	}
	getCoreBuf(1, val);
    5de7:	8b 45 08             	mov    0x8(%ebp),%eax
    5dea:	89 44 24 04          	mov    %eax,0x4(%esp)
    5dee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    5df5:	e8 60 ed ff ff       	call   4b5a <getCoreBuf>
//	buf[offset % BUFSIZE] = val;
//	offset++;
}
    5dfa:	c9                   	leave  
    5dfb:	c3                   	ret    

00005dfc <hsstell>:

unsigned long hsstell()
{
    5dfc:	55                   	push   %ebp
    5dfd:	89 e5                	mov    %esp,%ebp
    5dff:	83 ec 18             	sub    $0x18,%esp
	return getCoreBuf(2, 0);
    5e02:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    5e09:	00 
    5e0a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    5e11:	e8 44 ed ff ff       	call   4b5a <getCoreBuf>
//	return(totbit);
}
    5e16:	c9                   	leave  
    5e17:	c3                   	ret    

00005e18 <hgetbits>:

unsigned long hgetbits(int N)
{
    5e18:	55                   	push   %ebp
    5e19:	89 e5                	mov    %esp,%ebp
    5e1b:	83 ec 18             	sub    $0x18,%esp

	return getCoreBuf(3, N);
    5e1e:	8b 45 08             	mov    0x8(%ebp),%eax
    5e21:	89 44 24 04          	mov    %eax,0x4(%esp)
    5e25:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
    5e2c:	e8 29 ed ff ff       	call   4b5a <getCoreBuf>
}
    5e31:	c9                   	leave  
    5e32:	c3                   	ret    

00005e33 <hget1bit>:


unsigned int hget1bit()
{
    5e33:	55                   	push   %ebp
    5e34:	89 e5                	mov    %esp,%ebp
    5e36:	83 ec 18             	sub    $0x18,%esp
	return(hgetbits(1));
    5e39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    5e40:	e8 d3 ff ff ff       	call   5e18 <hgetbits>
}
    5e45:	c9                   	leave  
    5e46:	c3                   	ret    

00005e47 <rewindNbits>:


void rewindNbits(int N)
{
    5e47:	55                   	push   %ebp
    5e48:	89 e5                	mov    %esp,%ebp
    5e4a:	83 ec 18             	sub    $0x18,%esp
	getCoreBuf(4, N);
    5e4d:	8b 45 08             	mov    0x8(%ebp),%eax
    5e50:	89 44 24 04          	mov    %eax,0x4(%esp)
    5e54:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
    5e5b:	e8 fa ec ff ff       	call   4b5a <getCoreBuf>
}
    5e60:	c9                   	leave  
    5e61:	c3                   	ret    

00005e62 <rewindNbytes>:


void rewindNbytes(int N)
{
    5e62:	55                   	push   %ebp
    5e63:	89 e5                	mov    %esp,%ebp
    5e65:	83 ec 18             	sub    $0x18,%esp
	getCoreBuf(5, N);
    5e68:	8b 45 08             	mov    0x8(%ebp),%eax
    5e6b:	89 44 24 04          	mov    %eax,0x4(%esp)
    5e6f:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    5e76:	e8 df ec ff ff       	call   4b5a <getCoreBuf>
}
    5e7b:	c9                   	leave  
    5e7c:	c3                   	ret    

00005e7d <read_decoder_table>:
				/* 0..31 Huffman code table 0..31	*/
				/* 32,33 count1-tables			*/

/* ��ȡ huffman ����� */
void read_decoder_table() 
{
    5e7d:	55                   	push   %ebp
    5e7e:	89 e5                	mov    %esp,%ebp
    5e80:	57                   	push   %edi
    5e81:	56                   	push   %esi
    5e82:	53                   	push   %ebx
    5e83:	81 ec 40 1b 00 00    	sub    $0x1b40,%esp
	unsigned char h1[7][2] = {{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11}};
    5e89:	c6 45 e6 02          	movb   $0x2,-0x1a(%ebp)
    5e8d:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
    5e91:	c6 45 e8 00          	movb   $0x0,-0x18(%ebp)
    5e95:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    5e99:	c6 45 ea 02          	movb   $0x2,-0x16(%ebp)
    5e9d:	c6 45 eb 01          	movb   $0x1,-0x15(%ebp)
    5ea1:	c6 45 ec 00          	movb   $0x0,-0x14(%ebp)
    5ea5:	c6 45 ed 10          	movb   $0x10,-0x13(%ebp)
    5ea9:	c6 45 ee 02          	movb   $0x2,-0x12(%ebp)
    5ead:	c6 45 ef 01          	movb   $0x1,-0x11(%ebp)
    5eb1:	c6 45 f0 00          	movb   $0x0,-0x10(%ebp)
    5eb5:	c6 45 f1 01          	movb   $0x1,-0xf(%ebp)
    5eb9:	c6 45 f2 00          	movb   $0x0,-0xe(%ebp)
    5ebd:	c6 45 f3 11          	movb   $0x11,-0xd(%ebp)

	unsigned char h2[17][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22}};
    5ec1:	c6 45 c4 02          	movb   $0x2,-0x3c(%ebp)
    5ec5:	c6 45 c5 01          	movb   $0x1,-0x3b(%ebp)
    5ec9:	c6 45 c6 00          	movb   $0x0,-0x3a(%ebp)
    5ecd:	c6 45 c7 00          	movb   $0x0,-0x39(%ebp)
    5ed1:	c6 45 c8 04          	movb   $0x4,-0x38(%ebp)
    5ed5:	c6 45 c9 01          	movb   $0x1,-0x37(%ebp)
    5ed9:	c6 45 ca 02          	movb   $0x2,-0x36(%ebp)
    5edd:	c6 45 cb 01          	movb   $0x1,-0x35(%ebp)
    5ee1:	c6 45 cc 00          	movb   $0x0,-0x34(%ebp)
    5ee5:	c6 45 cd 10          	movb   $0x10,-0x33(%ebp)
    5ee9:	c6 45 ce 00          	movb   $0x0,-0x32(%ebp)
    5eed:	c6 45 cf 01          	movb   $0x1,-0x31(%ebp)
    5ef1:	c6 45 d0 02          	movb   $0x2,-0x30(%ebp)
    5ef5:	c6 45 d1 01          	movb   $0x1,-0x2f(%ebp)
    5ef9:	c6 45 d2 00          	movb   $0x0,-0x2e(%ebp)
    5efd:	c6 45 d3 11          	movb   $0x11,-0x2d(%ebp)
    5f01:	c6 45 d4 04          	movb   $0x4,-0x2c(%ebp)
    5f05:	c6 45 d5 01          	movb   $0x1,-0x2b(%ebp)
    5f09:	c6 45 d6 02          	movb   $0x2,-0x2a(%ebp)
    5f0d:	c6 45 d7 01          	movb   $0x1,-0x29(%ebp)
    5f11:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
    5f15:	c6 45 d9 20          	movb   $0x20,-0x27(%ebp)
    5f19:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
    5f1d:	c6 45 db 21          	movb   $0x21,-0x25(%ebp)
    5f21:	c6 45 dc 02          	movb   $0x2,-0x24(%ebp)
    5f25:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
    5f29:	c6 45 de 00          	movb   $0x0,-0x22(%ebp)
    5f2d:	c6 45 df 12          	movb   $0x12,-0x21(%ebp)
    5f31:	c6 45 e0 02          	movb   $0x2,-0x20(%ebp)
    5f35:	c6 45 e1 01          	movb   $0x1,-0x1f(%ebp)
    5f39:	c6 45 e2 00          	movb   $0x0,-0x1e(%ebp)
    5f3d:	c6 45 e3 02          	movb   $0x2,-0x1d(%ebp)
    5f41:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
    5f45:	c6 45 e5 22          	movb   $0x22,-0x1b(%ebp)

	unsigned char h3[17][2] = {{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x2,0x1},{0x0,0x10},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22}};
    5f49:	c6 45 a2 04          	movb   $0x4,-0x5e(%ebp)
    5f4d:	c6 45 a3 01          	movb   $0x1,-0x5d(%ebp)
    5f51:	c6 45 a4 02          	movb   $0x2,-0x5c(%ebp)
    5f55:	c6 45 a5 01          	movb   $0x1,-0x5b(%ebp)
    5f59:	c6 45 a6 00          	movb   $0x0,-0x5a(%ebp)
    5f5d:	c6 45 a7 00          	movb   $0x0,-0x59(%ebp)
    5f61:	c6 45 a8 00          	movb   $0x0,-0x58(%ebp)
    5f65:	c6 45 a9 01          	movb   $0x1,-0x57(%ebp)
    5f69:	c6 45 aa 02          	movb   $0x2,-0x56(%ebp)
    5f6d:	c6 45 ab 01          	movb   $0x1,-0x55(%ebp)
    5f71:	c6 45 ac 00          	movb   $0x0,-0x54(%ebp)
    5f75:	c6 45 ad 11          	movb   $0x11,-0x53(%ebp)
    5f79:	c6 45 ae 02          	movb   $0x2,-0x52(%ebp)
    5f7d:	c6 45 af 01          	movb   $0x1,-0x51(%ebp)
    5f81:	c6 45 b0 00          	movb   $0x0,-0x50(%ebp)
    5f85:	c6 45 b1 10          	movb   $0x10,-0x4f(%ebp)
    5f89:	c6 45 b2 04          	movb   $0x4,-0x4e(%ebp)
    5f8d:	c6 45 b3 01          	movb   $0x1,-0x4d(%ebp)
    5f91:	c6 45 b4 02          	movb   $0x2,-0x4c(%ebp)
    5f95:	c6 45 b5 01          	movb   $0x1,-0x4b(%ebp)
    5f99:	c6 45 b6 00          	movb   $0x0,-0x4a(%ebp)
    5f9d:	c6 45 b7 20          	movb   $0x20,-0x49(%ebp)
    5fa1:	c6 45 b8 00          	movb   $0x0,-0x48(%ebp)
    5fa5:	c6 45 b9 21          	movb   $0x21,-0x47(%ebp)
    5fa9:	c6 45 ba 02          	movb   $0x2,-0x46(%ebp)
    5fad:	c6 45 bb 01          	movb   $0x1,-0x45(%ebp)
    5fb1:	c6 45 bc 00          	movb   $0x0,-0x44(%ebp)
    5fb5:	c6 45 bd 12          	movb   $0x12,-0x43(%ebp)
    5fb9:	c6 45 be 02          	movb   $0x2,-0x42(%ebp)
    5fbd:	c6 45 bf 01          	movb   $0x1,-0x41(%ebp)
    5fc1:	c6 45 c0 00          	movb   $0x0,-0x40(%ebp)
    5fc5:	c6 45 c1 02          	movb   $0x2,-0x3f(%ebp)
    5fc9:	c6 45 c2 00          	movb   $0x0,-0x3e(%ebp)
    5fcd:	c6 45 c3 22          	movb   $0x22,-0x3d(%ebp)

	unsigned char h5[31][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x13},{0x2,0x1},{0x0,0x31},{0x2,0x1},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x33}};
    5fd1:	c6 85 64 ff ff ff 02 	movb   $0x2,-0x9c(%ebp)
    5fd8:	c6 85 65 ff ff ff 01 	movb   $0x1,-0x9b(%ebp)
    5fdf:	c6 85 66 ff ff ff 00 	movb   $0x0,-0x9a(%ebp)
    5fe6:	c6 85 67 ff ff ff 00 	movb   $0x0,-0x99(%ebp)
    5fed:	c6 85 68 ff ff ff 04 	movb   $0x4,-0x98(%ebp)
    5ff4:	c6 85 69 ff ff ff 01 	movb   $0x1,-0x97(%ebp)
    5ffb:	c6 85 6a ff ff ff 02 	movb   $0x2,-0x96(%ebp)
    6002:	c6 85 6b ff ff ff 01 	movb   $0x1,-0x95(%ebp)
    6009:	c6 85 6c ff ff ff 00 	movb   $0x0,-0x94(%ebp)
    6010:	c6 85 6d ff ff ff 10 	movb   $0x10,-0x93(%ebp)
    6017:	c6 85 6e ff ff ff 00 	movb   $0x0,-0x92(%ebp)
    601e:	c6 85 6f ff ff ff 01 	movb   $0x1,-0x91(%ebp)
    6025:	c6 85 70 ff ff ff 02 	movb   $0x2,-0x90(%ebp)
    602c:	c6 85 71 ff ff ff 01 	movb   $0x1,-0x8f(%ebp)
    6033:	c6 85 72 ff ff ff 00 	movb   $0x0,-0x8e(%ebp)
    603a:	c6 85 73 ff ff ff 11 	movb   $0x11,-0x8d(%ebp)
    6041:	c6 85 74 ff ff ff 08 	movb   $0x8,-0x8c(%ebp)
    6048:	c6 85 75 ff ff ff 01 	movb   $0x1,-0x8b(%ebp)
    604f:	c6 85 76 ff ff ff 04 	movb   $0x4,-0x8a(%ebp)
    6056:	c6 85 77 ff ff ff 01 	movb   $0x1,-0x89(%ebp)
    605d:	c6 85 78 ff ff ff 02 	movb   $0x2,-0x88(%ebp)
    6064:	c6 85 79 ff ff ff 01 	movb   $0x1,-0x87(%ebp)
    606b:	c6 85 7a ff ff ff 00 	movb   $0x0,-0x86(%ebp)
    6072:	c6 85 7b ff ff ff 20 	movb   $0x20,-0x85(%ebp)
    6079:	c6 85 7c ff ff ff 00 	movb   $0x0,-0x84(%ebp)
    6080:	c6 85 7d ff ff ff 02 	movb   $0x2,-0x83(%ebp)
    6087:	c6 85 7e ff ff ff 02 	movb   $0x2,-0x82(%ebp)
    608e:	c6 85 7f ff ff ff 01 	movb   $0x1,-0x81(%ebp)
    6095:	c6 45 80 00          	movb   $0x0,-0x80(%ebp)
    6099:	c6 45 81 21          	movb   $0x21,-0x7f(%ebp)
    609d:	c6 45 82 00          	movb   $0x0,-0x7e(%ebp)
    60a1:	c6 45 83 12          	movb   $0x12,-0x7d(%ebp)
    60a5:	c6 45 84 08          	movb   $0x8,-0x7c(%ebp)
    60a9:	c6 45 85 01          	movb   $0x1,-0x7b(%ebp)
    60ad:	c6 45 86 04          	movb   $0x4,-0x7a(%ebp)
    60b1:	c6 45 87 01          	movb   $0x1,-0x79(%ebp)
    60b5:	c6 45 88 02          	movb   $0x2,-0x78(%ebp)
    60b9:	c6 45 89 01          	movb   $0x1,-0x77(%ebp)
    60bd:	c6 45 8a 00          	movb   $0x0,-0x76(%ebp)
    60c1:	c6 45 8b 22          	movb   $0x22,-0x75(%ebp)
    60c5:	c6 45 8c 00          	movb   $0x0,-0x74(%ebp)
    60c9:	c6 45 8d 30          	movb   $0x30,-0x73(%ebp)
    60cd:	c6 45 8e 02          	movb   $0x2,-0x72(%ebp)
    60d1:	c6 45 8f 01          	movb   $0x1,-0x71(%ebp)
    60d5:	c6 45 90 00          	movb   $0x0,-0x70(%ebp)
    60d9:	c6 45 91 03          	movb   $0x3,-0x6f(%ebp)
    60dd:	c6 45 92 00          	movb   $0x0,-0x6e(%ebp)
    60e1:	c6 45 93 13          	movb   $0x13,-0x6d(%ebp)
    60e5:	c6 45 94 02          	movb   $0x2,-0x6c(%ebp)
    60e9:	c6 45 95 01          	movb   $0x1,-0x6b(%ebp)
    60ed:	c6 45 96 00          	movb   $0x0,-0x6a(%ebp)
    60f1:	c6 45 97 31          	movb   $0x31,-0x69(%ebp)
    60f5:	c6 45 98 02          	movb   $0x2,-0x68(%ebp)
    60f9:	c6 45 99 01          	movb   $0x1,-0x67(%ebp)
    60fd:	c6 45 9a 00          	movb   $0x0,-0x66(%ebp)
    6101:	c6 45 9b 32          	movb   $0x32,-0x65(%ebp)
    6105:	c6 45 9c 02          	movb   $0x2,-0x64(%ebp)
    6109:	c6 45 9d 01          	movb   $0x1,-0x63(%ebp)
    610d:	c6 45 9e 00          	movb   $0x0,-0x62(%ebp)
    6111:	c6 45 9f 23          	movb   $0x23,-0x61(%ebp)
    6115:	c6 45 a0 00          	movb   $0x0,-0x60(%ebp)
    6119:	c6 45 a1 33          	movb   $0x33,-0x5f(%ebp)

	unsigned char h6[31][2] = {{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x0,0x11},{0x6,0x1},{0x2,0x1},{0x0,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x6,0x1},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x2,0x1},{0x0,0x3},{0x0,0x33}};
    611d:	c6 85 26 ff ff ff 06 	movb   $0x6,-0xda(%ebp)
    6124:	c6 85 27 ff ff ff 01 	movb   $0x1,-0xd9(%ebp)
    612b:	c6 85 28 ff ff ff 04 	movb   $0x4,-0xd8(%ebp)
    6132:	c6 85 29 ff ff ff 01 	movb   $0x1,-0xd7(%ebp)
    6139:	c6 85 2a ff ff ff 02 	movb   $0x2,-0xd6(%ebp)
    6140:	c6 85 2b ff ff ff 01 	movb   $0x1,-0xd5(%ebp)
    6147:	c6 85 2c ff ff ff 00 	movb   $0x0,-0xd4(%ebp)
    614e:	c6 85 2d ff ff ff 00 	movb   $0x0,-0xd3(%ebp)
    6155:	c6 85 2e ff ff ff 00 	movb   $0x0,-0xd2(%ebp)
    615c:	c6 85 2f ff ff ff 10 	movb   $0x10,-0xd1(%ebp)
    6163:	c6 85 30 ff ff ff 00 	movb   $0x0,-0xd0(%ebp)
    616a:	c6 85 31 ff ff ff 11 	movb   $0x11,-0xcf(%ebp)
    6171:	c6 85 32 ff ff ff 06 	movb   $0x6,-0xce(%ebp)
    6178:	c6 85 33 ff ff ff 01 	movb   $0x1,-0xcd(%ebp)
    617f:	c6 85 34 ff ff ff 02 	movb   $0x2,-0xcc(%ebp)
    6186:	c6 85 35 ff ff ff 01 	movb   $0x1,-0xcb(%ebp)
    618d:	c6 85 36 ff ff ff 00 	movb   $0x0,-0xca(%ebp)
    6194:	c6 85 37 ff ff ff 01 	movb   $0x1,-0xc9(%ebp)
    619b:	c6 85 38 ff ff ff 02 	movb   $0x2,-0xc8(%ebp)
    61a2:	c6 85 39 ff ff ff 01 	movb   $0x1,-0xc7(%ebp)
    61a9:	c6 85 3a ff ff ff 00 	movb   $0x0,-0xc6(%ebp)
    61b0:	c6 85 3b ff ff ff 20 	movb   $0x20,-0xc5(%ebp)
    61b7:	c6 85 3c ff ff ff 00 	movb   $0x0,-0xc4(%ebp)
    61be:	c6 85 3d ff ff ff 21 	movb   $0x21,-0xc3(%ebp)
    61c5:	c6 85 3e ff ff ff 06 	movb   $0x6,-0xc2(%ebp)
    61cc:	c6 85 3f ff ff ff 01 	movb   $0x1,-0xc1(%ebp)
    61d3:	c6 85 40 ff ff ff 02 	movb   $0x2,-0xc0(%ebp)
    61da:	c6 85 41 ff ff ff 01 	movb   $0x1,-0xbf(%ebp)
    61e1:	c6 85 42 ff ff ff 00 	movb   $0x0,-0xbe(%ebp)
    61e8:	c6 85 43 ff ff ff 12 	movb   $0x12,-0xbd(%ebp)
    61ef:	c6 85 44 ff ff ff 02 	movb   $0x2,-0xbc(%ebp)
    61f6:	c6 85 45 ff ff ff 01 	movb   $0x1,-0xbb(%ebp)
    61fd:	c6 85 46 ff ff ff 00 	movb   $0x0,-0xba(%ebp)
    6204:	c6 85 47 ff ff ff 02 	movb   $0x2,-0xb9(%ebp)
    620b:	c6 85 48 ff ff ff 00 	movb   $0x0,-0xb8(%ebp)
    6212:	c6 85 49 ff ff ff 22 	movb   $0x22,-0xb7(%ebp)
    6219:	c6 85 4a ff ff ff 04 	movb   $0x4,-0xb6(%ebp)
    6220:	c6 85 4b ff ff ff 01 	movb   $0x1,-0xb5(%ebp)
    6227:	c6 85 4c ff ff ff 02 	movb   $0x2,-0xb4(%ebp)
    622e:	c6 85 4d ff ff ff 01 	movb   $0x1,-0xb3(%ebp)
    6235:	c6 85 4e ff ff ff 00 	movb   $0x0,-0xb2(%ebp)
    623c:	c6 85 4f ff ff ff 31 	movb   $0x31,-0xb1(%ebp)
    6243:	c6 85 50 ff ff ff 00 	movb   $0x0,-0xb0(%ebp)
    624a:	c6 85 51 ff ff ff 13 	movb   $0x13,-0xaf(%ebp)
    6251:	c6 85 52 ff ff ff 04 	movb   $0x4,-0xae(%ebp)
    6258:	c6 85 53 ff ff ff 01 	movb   $0x1,-0xad(%ebp)
    625f:	c6 85 54 ff ff ff 02 	movb   $0x2,-0xac(%ebp)
    6266:	c6 85 55 ff ff ff 01 	movb   $0x1,-0xab(%ebp)
    626d:	c6 85 56 ff ff ff 00 	movb   $0x0,-0xaa(%ebp)
    6274:	c6 85 57 ff ff ff 30 	movb   $0x30,-0xa9(%ebp)
    627b:	c6 85 58 ff ff ff 00 	movb   $0x0,-0xa8(%ebp)
    6282:	c6 85 59 ff ff ff 32 	movb   $0x32,-0xa7(%ebp)
    6289:	c6 85 5a ff ff ff 02 	movb   $0x2,-0xa6(%ebp)
    6290:	c6 85 5b ff ff ff 01 	movb   $0x1,-0xa5(%ebp)
    6297:	c6 85 5c ff ff ff 00 	movb   $0x0,-0xa4(%ebp)
    629e:	c6 85 5d ff ff ff 23 	movb   $0x23,-0xa3(%ebp)
    62a5:	c6 85 5e ff ff ff 02 	movb   $0x2,-0xa2(%ebp)
    62ac:	c6 85 5f ff ff ff 01 	movb   $0x1,-0xa1(%ebp)
    62b3:	c6 85 60 ff ff ff 00 	movb   $0x0,-0xa0(%ebp)
    62ba:	c6 85 61 ff ff ff 03 	movb   $0x3,-0x9f(%ebp)
    62c1:	c6 85 62 ff ff ff 00 	movb   $0x0,-0x9e(%ebp)
    62c8:	c6 85 63 ff ff ff 33 	movb   $0x33,-0x9d(%ebp)

	unsigned char h7[71][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x21},{0x12,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x3},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x4},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x41},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x43},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x34},{0x0,0x5},{0x0,0x51},{0x6,0x1},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x4,0x1},{0x2,0x1},{0x0,0x53},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x55}};
    62cf:	8d 95 98 fe ff ff    	lea    -0x168(%ebp),%edx
    62d5:	b8 20 bb 00 00       	mov    $0xbb20,%eax
    62da:	b9 23 00 00 00       	mov    $0x23,%ecx
    62df:	89 d7                	mov    %edx,%edi
    62e1:	89 c6                	mov    %eax,%esi
    62e3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    62e5:	89 f0                	mov    %esi,%eax
    62e7:	89 fa                	mov    %edi,%edx
    62e9:	0f b7 08             	movzwl (%eax),%ecx
    62ec:	66 89 0a             	mov    %cx,(%edx)
    62ef:	83 c2 02             	add    $0x2,%edx
    62f2:	83 c0 02             	add    $0x2,%eax

	unsigned char h8[71][2] = {{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x22},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x2,0x1},{0x0,0x41},{0x2,0x1},{0x0,0x14},{0x0,0x42},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x24},{0x2,0x1},{0x0,0x33},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x6,0x1},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x6,0x1},{0x2,0x1},{0x0,0x25},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x2,0x1},{0x0,0x53},{0x2,0x1},{0x0,0x45},{0x2,0x1},{0x0,0x54},{0x0,0x55}};
    62f5:	8d 85 0a fe ff ff    	lea    -0x1f6(%ebp),%eax
    62fb:	ba c0 bb 00 00       	mov    $0xbbc0,%edx
    6300:	bb 8e 00 00 00       	mov    $0x8e,%ebx
    6305:	89 c1                	mov    %eax,%ecx
    6307:	83 e1 02             	and    $0x2,%ecx
    630a:	85 c9                	test   %ecx,%ecx
    630c:	74 0f                	je     631d <read_decoder_table+0x4a0>
    630e:	0f b7 0a             	movzwl (%edx),%ecx
    6311:	66 89 08             	mov    %cx,(%eax)
    6314:	83 c0 02             	add    $0x2,%eax
    6317:	83 c2 02             	add    $0x2,%edx
    631a:	83 eb 02             	sub    $0x2,%ebx
    631d:	89 d9                	mov    %ebx,%ecx
    631f:	c1 e9 02             	shr    $0x2,%ecx
    6322:	89 c7                	mov    %eax,%edi
    6324:	89 d6                	mov    %edx,%esi
    6326:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    6328:	89 f2                	mov    %esi,%edx
    632a:	89 f8                	mov    %edi,%eax
    632c:	b9 00 00 00 00       	mov    $0x0,%ecx
    6331:	89 de                	mov    %ebx,%esi
    6333:	83 e6 02             	and    $0x2,%esi
    6336:	85 f6                	test   %esi,%esi
    6338:	74 0b                	je     6345 <read_decoder_table+0x4c8>
    633a:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    633e:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    6342:	83 c1 02             	add    $0x2,%ecx
    6345:	83 e3 01             	and    $0x1,%ebx
    6348:	85 db                	test   %ebx,%ebx
    634a:	74 07                	je     6353 <read_decoder_table+0x4d6>
    634c:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    6350:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h9[71][2] = {{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x0,0x31},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x50},{0x0,0x43},{0x2,0x1},{0x0,0x34},{0x0,0x51},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x15},{0x0,0x52},{0x2,0x1},{0x0,0x25},{0x0,0x44},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x54},{0x0,0x53},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x45},{0x0,0x55}};
    6353:	8d 95 7c fd ff ff    	lea    -0x284(%ebp),%edx
    6359:	b8 60 bc 00 00       	mov    $0xbc60,%eax
    635e:	b9 23 00 00 00       	mov    $0x23,%ecx
    6363:	89 d7                	mov    %edx,%edi
    6365:	89 c6                	mov    %eax,%esi
    6367:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    6369:	89 f0                	mov    %esi,%eax
    636b:	89 fa                	mov    %edi,%edx
    636d:	0f b7 08             	movzwl (%eax),%ecx
    6370:	66 89 0a             	mov    %cx,(%edx)
    6373:	83 c2 02             	add    $0x2,%edx
    6376:	83 c0 02             	add    $0x2,%eax

	unsigned char h10[127][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0xa,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x1c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x3},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x40},{0x4,0x1},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x1c,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x0,0x60},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x36},{0x0,0x71},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x17},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x0,0x6},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x35},{0x0,0x45},{0x0,0x62},{0x2,0x1},{0x0,0x70},{0x2,0x1},{0x0,0x7},{0x0,0x64},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x6,0x1},{0x2,0x1},{0x0,0x63},{0x2,0x1},{0x0,0x54},{0x0,0x55},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x37},{0x0,0x65},{0x2,0x1},{0x0,0x56},{0x0,0x74},{0x6,0x1},{0x2,0x1},{0x0,0x47},{0x2,0x1},{0x0,0x66},{0x0,0x75},{0x4,0x1},{0x2,0x1},{0x0,0x57},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    6379:	8d 85 7e fc ff ff    	lea    -0x382(%ebp),%eax
    637f:	ba 00 bd 00 00       	mov    $0xbd00,%edx
    6384:	bb fe 00 00 00       	mov    $0xfe,%ebx
    6389:	89 c1                	mov    %eax,%ecx
    638b:	83 e1 02             	and    $0x2,%ecx
    638e:	85 c9                	test   %ecx,%ecx
    6390:	74 0f                	je     63a1 <read_decoder_table+0x524>
    6392:	0f b7 0a             	movzwl (%edx),%ecx
    6395:	66 89 08             	mov    %cx,(%eax)
    6398:	83 c0 02             	add    $0x2,%eax
    639b:	83 c2 02             	add    $0x2,%edx
    639e:	83 eb 02             	sub    $0x2,%ebx
    63a1:	89 d9                	mov    %ebx,%ecx
    63a3:	c1 e9 02             	shr    $0x2,%ecx
    63a6:	89 c7                	mov    %eax,%edi
    63a8:	89 d6                	mov    %edx,%esi
    63aa:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    63ac:	89 f2                	mov    %esi,%edx
    63ae:	89 f8                	mov    %edi,%eax
    63b0:	b9 00 00 00 00       	mov    $0x0,%ecx
    63b5:	89 de                	mov    %ebx,%esi
    63b7:	83 e6 02             	and    $0x2,%esi
    63ba:	85 f6                	test   %esi,%esi
    63bc:	74 0b                	je     63c9 <read_decoder_table+0x54c>
    63be:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    63c2:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    63c6:	83 c1 02             	add    $0x2,%ecx
    63c9:	83 e3 01             	and    $0x1,%ebx
    63cc:	85 db                	test   %ebx,%ebx
    63ce:	74 07                	je     63d7 <read_decoder_table+0x55a>
    63d0:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    63d4:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h11[127][2] = {{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x12},{0x18,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x21},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x1e,0x1},{0x10,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x43},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x34},{0x0,0x51},{0x0,0x61},{0x6,0x1},{0x2,0x1},{0x0,0x16},{0x2,0x1},{0x0,0x6},{0x0,0x26},{0x2,0x1},{0x0,0x62},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x10,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x25},{0x0,0x44},{0x0,0x60},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x17},{0x0,0x71},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x7},{0x0,0x64},{0x0,0x72},{0x2,0x1},{0x0,0x27},{0x4,0x1},{0x2,0x1},{0x0,0x53},{0x0,0x35},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x2,0x1},{0x0,0x65},{0x0,0x56},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x55},{0x0,0x57},{0x0,0x74},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    63d7:	8d 95 80 fb ff ff    	lea    -0x480(%ebp),%edx
    63dd:	b8 00 be 00 00       	mov    $0xbe00,%eax
    63e2:	b9 3f 00 00 00       	mov    $0x3f,%ecx
    63e7:	89 d7                	mov    %edx,%edi
    63e9:	89 c6                	mov    %eax,%esi
    63eb:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    63ed:	89 f0                	mov    %esi,%eax
    63ef:	89 fa                	mov    %edi,%edx
    63f1:	0f b7 08             	movzwl (%eax),%ecx
    63f4:	66 89 0a             	mov    %cx,(%edx)
    63f7:	83 c2 02             	add    $0x2,%edx
    63fa:	83 c0 02             	add    $0x2,%eax

	unsigned char h12[127][2] = {{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x10,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x31},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x40},{0x1a,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x2,0x1},{0x0,0x41},{0x0,0x33},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x14},{0x0,0x42},{0x2,0x1},{0x0,0x24},{0x2,0x1},{0x0,0x4},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x1c,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x2,0x1},{0x0,0x53},{0x0,0x35},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x16},{0x0,0x61},{0x4,0x1},{0x2,0x1},{0x0,0x62},{0x0,0x26},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x6},{0x0,0x44},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x0,0x71},{0x4,0x1},{0x2,0x1},{0x0,0x17},{0x0,0x64},{0x2,0x1},{0x0,0x46},{0x0,0x72},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x27},{0x2,0x1},{0x0,0x55},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x0,0x56},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x65},{0x0,0x74},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    63fd:	8d 85 82 fa ff ff    	lea    -0x57e(%ebp),%eax
    6403:	ba 00 bf 00 00       	mov    $0xbf00,%edx
    6408:	bb fe 00 00 00       	mov    $0xfe,%ebx
    640d:	89 c1                	mov    %eax,%ecx
    640f:	83 e1 02             	and    $0x2,%ecx
    6412:	85 c9                	test   %ecx,%ecx
    6414:	74 0f                	je     6425 <read_decoder_table+0x5a8>
    6416:	0f b7 0a             	movzwl (%edx),%ecx
    6419:	66 89 08             	mov    %cx,(%eax)
    641c:	83 c0 02             	add    $0x2,%eax
    641f:	83 c2 02             	add    $0x2,%edx
    6422:	83 eb 02             	sub    $0x2,%ebx
    6425:	89 d9                	mov    %ebx,%ecx
    6427:	c1 e9 02             	shr    $0x2,%ecx
    642a:	89 c7                	mov    %eax,%edi
    642c:	89 d6                	mov    %edx,%esi
    642e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    6430:	89 f2                	mov    %esi,%edx
    6432:	89 f8                	mov    %edi,%eax
    6434:	b9 00 00 00 00       	mov    $0x0,%ecx
    6439:	89 de                	mov    %ebx,%esi
    643b:	83 e6 02             	and    $0x2,%esi
    643e:	85 f6                	test   %esi,%esi
    6440:	74 0b                	je     644d <read_decoder_table+0x5d0>
    6442:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    6446:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    644a:	83 c1 02             	add    $0x2,%ecx
    644d:	83 e3 01             	and    $0x1,%ebx
    6450:	85 db                	test   %ebx,%ebx
    6452:	74 07                	je     645b <read_decoder_table+0x5de>
    6454:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    6458:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h13[511][2] = {{0x2,0x1},{0x0,0x0},{0x6,0x1},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0x1c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x31},{0x6,0x1},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x46,0x1},{0x1c,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x4,0x1},{0x2,0x1},{0x0,0x24},{0x0,0x50},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x4,0x1},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x2,0x1},{0x0,0x25},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0x4,0x1},{0x2,0x1},{0x0,0x80},{0x0,0x8},{0x0,0x81},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x35},{0x0,0x62},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x4,0x1},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0x2,0x1},{0x0,0x36},{0x0,0x70},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x7},{0x0,0x55},{0x0,0x71},{0x2,0x1},{0x0,0x17},{0x2,0x1},{0x0,0x27},{0x0,0x37},{0x48,0x1},{0x18,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x18},{0x0,0x82},{0x2,0x1},{0x0,0x28},{0x4,0x1},{0x2,0x1},{0x0,0x64},{0x0,0x46},{0x0,0x72},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x2,0x1},{0x0,0x90},{0x0,0x9},{0x2,0x1},{0x0,0x91},{0x0,0x19},{0x18,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x73},{0x0,0x65},{0x2,0x1},{0x0,0x56},{0x0,0x74},{0x4,0x1},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x0,0x83},{0x6,0x1},{0x2,0x1},{0x0,0x38},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x92},{0x0,0x29},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x67},{0x0,0x85},{0x2,0x1},{0x0,0x58},{0x0,0x39},{0x2,0x1},{0x0,0x93},{0x2,0x1},{0x0,0x49},{0x0,0x86},{0x6,0x1},{0x2,0x1},{0x0,0xa0},{0x2,0x1},{0x0,0x68},{0x0,0xa},{0x2,0x1},{0x0,0xa1},{0x0,0x1a},{0x44,0x1},{0x18,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x4,0x1},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x2,0x1},{0x0,0xa3},{0x0,0x3a},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4a},{0x0,0x96},{0x2,0x1},{0x0,0xb0},{0x0,0xb},{0x2,0x1},{0x0,0xb1},{0x0,0x1b},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0xb2},{0x4,0x1},{0x2,0x1},{0x0,0x76},{0x0,0x77},{0x0,0x94},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x87},{0x0,0x78},{0x0,0xa4},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xa5},{0x0,0x2b},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5a},{0x0,0x88},{0x0,0xb3},{0x2,0x1},{0x0,0x3b},{0x2,0x1},{0x0,0x79},{0x0,0xa6},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x6a},{0x0,0xb4},{0x0,0xc0},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0x98},{0x0,0xc1},{0x3c,0x1},{0x16,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x1c},{0x2,0x1},{0x0,0x89},{0x0,0xb5},{0x2,0x1},{0x0,0x5b},{0x0,0xc2},{0x4,0x1},{0x2,0x1},{0x0,0x2c},{0x0,0x3c},{0x4,0x1},{0x2,0x1},{0x0,0xb6},{0x0,0x6b},{0x2,0x1},{0x0,0xc4},{0x0,0x4c},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa8},{0x0,0x8a},{0x2,0x1},{0x0,0xd0},{0x0,0xd},{0x2,0x1},{0x0,0xd1},{0x2,0x1},{0x0,0x4b},{0x2,0x1},{0x0,0x97},{0x0,0xa7},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xc3},{0x2,0x1},{0x0,0x7a},{0x0,0x99},{0x4,0x1},{0x2,0x1},{0x0,0xc5},{0x0,0x5c},{0x0,0xb7},{0x4,0x1},{0x2,0x1},{0x0,0x1d},{0x0,0xd2},{0x2,0x1},{0x0,0x2d},{0x2,0x1},{0x0,0x7b},{0x0,0xd3},{0x34,0x1},{0x1c,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x4,0x1},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x2,0x1},{0x0,0x9a},{0x0,0xd4},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb8},{0x0,0x8b},{0x2,0x1},{0x0,0x4d},{0x0,0xc7},{0x4,0x1},{0x2,0x1},{0x0,0x7c},{0x0,0xd5},{0x2,0x1},{0x0,0x5d},{0x0,0xe0},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe1},{0x0,0x1e},{0x4,0x1},{0x2,0x1},{0x0,0xe},{0x0,0x2e},{0x0,0xe2},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe3},{0x0,0x6d},{0x2,0x1},{0x0,0x8c},{0x0,0xe4},{0x4,0x1},{0x2,0x1},{0x0,0xe5},{0x0,0xba},{0x0,0xf0},{0x26,0x1},{0x10,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf1},{0x0,0x1f},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xaa},{0x0,0x9b},{0x0,0xb9},{0x2,0x1},{0x0,0x3e},{0x2,0x1},{0x0,0xd6},{0x0,0xc8},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x4e},{0x2,0x1},{0x0,0xd7},{0x0,0x7d},{0x2,0x1},{0x0,0xab},{0x2,0x1},{0x0,0x5e},{0x0,0xc9},{0x6,0x1},{0x2,0x1},{0x0,0xf},{0x2,0x1},{0x0,0x9c},{0x0,0x6e},{0x2,0x1},{0x0,0xf2},{0x0,0x2f},{0x20,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0x8d},{0x0,0x3f},{0x6,0x1},{0x2,0x1},{0x0,0xf3},{0x2,0x1},{0x0,0xe6},{0x0,0xca},{0x2,0x1},{0x0,0xf4},{0x0,0x4f},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbb},{0x0,0xac},{0x2,0x1},{0x0,0xe7},{0x0,0xf5},{0x4,0x1},{0x2,0x1},{0x0,0xd9},{0x0,0x9d},{0x2,0x1},{0x0,0x5f},{0x0,0xe8},{0x1e,0x1},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x6f},{0x2,0x1},{0x0,0xf6},{0x0,0xcb},{0x4,0x1},{0x2,0x1},{0x0,0xbc},{0x0,0xad},{0x0,0xda},{0x8,0x1},{0x2,0x1},{0x0,0xf7},{0x4,0x1},{0x2,0x1},{0x0,0x7e},{0x0,0x7f},{0x0,0x8e},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xae},{0x0,0xcc},{0x2,0x1},{0x0,0xf8},{0x0,0x8f},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x2,0x1},{0x0,0xea},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xeb},{0x2,0x1},{0x0,0xbe},{0x2,0x1},{0x0,0xcd},{0x0,0xfa},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe9},{0x0,0xaf},{0x0,0xdc},{0x2,0x1},{0x0,0xce},{0x0,0xfb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbf},{0x0,0xde},{0x2,0x1},{0x0,0xcf},{0x0,0xee},{0x4,0x1},{0x2,0x1},{0x0,0xdf},{0x0,0xef},{0x2,0x1},{0x0,0xff},{0x2,0x1},{0x0,0xed},{0x2,0x1},{0x0,0xfd},{0x2,0x1},{0x0,0xfc},{0x0,0xfe}};
    645b:	8d 95 84 f6 ff ff    	lea    -0x97c(%ebp),%edx
    6461:	b8 00 c0 00 00       	mov    $0xc000,%eax
    6466:	b9 ff 00 00 00       	mov    $0xff,%ecx
    646b:	89 d7                	mov    %edx,%edi
    646d:	89 c6                	mov    %eax,%esi
    646f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    6471:	89 f0                	mov    %esi,%eax
    6473:	89 fa                	mov    %edi,%edx
    6475:	0f b7 08             	movzwl (%eax),%ecx
    6478:	66 89 0a             	mov    %cx,(%edx)
    647b:	83 c2 02             	add    $0x2,%edx
    647e:	83 c0 02             	add    $0x2,%eax

	unsigned char h15[511][2] = {{0x10,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x32,0x1},{0x10,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x31},{0x6,0x1},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x3},{0x0,0x40},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x14},{0x0,0x41},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x2,0x1},{0x0,0x24},{0x0,0x43},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x34},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x0,0x61},{0x5a,0x1},{0x24,0x1},{0x12,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x2,0x1},{0x0,0x16},{0x0,0x62},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x36},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x2,0x1},{0x0,0x71},{0x0,0x55},{0x4,0x1},{0x2,0x1},{0x0,0x17},{0x0,0x64},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x18,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x0,0x65},{0x4,0x1},{0x2,0x1},{0x0,0x56},{0x0,0x80},{0x2,0x1},{0x0,0x8},{0x0,0x74},{0x4,0x1},{0x2,0x1},{0x0,0x81},{0x0,0x18},{0x2,0x1},{0x0,0x82},{0x0,0x28},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x90},{0x0,0x19},{0x0,0x91},{0x4,0x1},{0x2,0x1},{0x0,0x92},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x29},{0x5c,0x1},{0x24,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x4,0x1},{0x2,0x1},{0x0,0x9},{0x0,0x77},{0x0,0x93},{0x4,0x1},{0x2,0x1},{0x0,0x39},{0x0,0x94},{0x2,0x1},{0x0,0x49},{0x0,0x86},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x68},{0x2,0x1},{0x0,0xa0},{0x0,0xa},{0x2,0x1},{0x0,0xa1},{0x0,0x1a},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x1a,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xa3},{0x2,0x1},{0x0,0x3a},{0x0,0x87},{0x4,0x1},{0x2,0x1},{0x0,0x78},{0x0,0xa4},{0x2,0x1},{0x0,0x4a},{0x0,0x96},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xb0},{0x0,0xb1},{0x4,0x1},{0x2,0x1},{0x0,0x1b},{0x0,0xa5},{0x0,0xb2},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5a},{0x0,0x2b},{0x2,0x1},{0x0,0x88},{0x0,0x97},{0x2,0x1},{0x0,0xb3},{0x2,0x1},{0x0,0x79},{0x0,0x3b},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x6a},{0x0,0xb4},{0x2,0x1},{0x0,0x4b},{0x0,0xc1},{0x4,0x1},{0x2,0x1},{0x0,0x98},{0x0,0x89},{0x2,0x1},{0x0,0x1c},{0x0,0xb5},{0x50,0x1},{0x22,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5b},{0x0,0x2c},{0x0,0xc2},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb},{0x0,0xc0},{0x0,0xa6},{0x2,0x1},{0x0,0xa7},{0x0,0x7a},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc3},{0x0,0x3c},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0x99},{0x0,0xb6},{0x4,0x1},{0x2,0x1},{0x0,0x6b},{0x0,0xc4},{0x2,0x1},{0x0,0x4c},{0x0,0xa8},{0x14,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8a},{0x0,0xc5},{0x4,0x1},{0x2,0x1},{0x0,0xd0},{0x0,0x5c},{0x0,0xd1},{0x4,0x1},{0x2,0x1},{0x0,0xb7},{0x0,0x7b},{0x2,0x1},{0x0,0x1d},{0x2,0x1},{0x0,0xd},{0x0,0x2d},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd2},{0x0,0xd3},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9a},{0x0,0xb8},{0x0,0xd4},{0x4,0x1},{0x2,0x1},{0x0,0x8b},{0x0,0x4d},{0x2,0x1},{0x0,0xc7},{0x0,0x7c},{0x44,0x1},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd5},{0x0,0x5d},{0x4,0x1},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x0,0xe1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0xe2},{0x2,0x1},{0x0,0xaa},{0x0,0x2e},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb9},{0x0,0x9b},{0x2,0x1},{0x0,0xe3},{0x0,0xd6},{0x4,0x1},{0x2,0x1},{0x0,0x6d},{0x0,0x3e},{0x2,0x1},{0x0,0xc8},{0x0,0x8c},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe4},{0x0,0x4e},{0x2,0x1},{0x0,0xd7},{0x0,0x7d},{0x4,0x1},{0x2,0x1},{0x0,0xe5},{0x0,0xba},{0x2,0x1},{0x0,0xab},{0x0,0x5e},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc9},{0x0,0x9c},{0x2,0x1},{0x0,0xf1},{0x0,0x1f},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf0},{0x0,0x6e},{0x0,0xf2},{0x2,0x1},{0x0,0x2f},{0x0,0xe6},{0x26,0x1},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0xf3},{0x2,0x1},{0x0,0x3f},{0x0,0xf4},{0x6,0x1},{0x2,0x1},{0x0,0x4f},{0x2,0x1},{0x0,0x8d},{0x0,0xd9},{0x2,0x1},{0x0,0xbb},{0x0,0xca},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xac},{0x0,0xe7},{0x2,0x1},{0x0,0x7e},{0x0,0xf5},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9d},{0x0,0x5f},{0x2,0x1},{0x0,0xe8},{0x0,0x8e},{0x2,0x1},{0x0,0xf6},{0x0,0xcb},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf},{0x0,0xae},{0x0,0x6f},{0x2,0x1},{0x0,0xbc},{0x0,0xda},{0x4,0x1},{0x2,0x1},{0x0,0xad},{0x0,0xf7},{0x2,0x1},{0x0,0x7f},{0x0,0xe9},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xcc},{0x2,0x1},{0x0,0xf8},{0x0,0x8f},{0x4,0x1},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x2,0x1},{0x0,0xea},{0x0,0xf9},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xdc},{0x2,0x1},{0x0,0xcd},{0x0,0xeb},{0x4,0x1},{0x2,0x1},{0x0,0xbe},{0x0,0xfa},{0x2,0x1},{0x0,0xaf},{0x0,0xdd},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xec},{0x0,0xce},{0x0,0xfb},{0x4,0x1},{0x2,0x1},{0x0,0xbf},{0x0,0xed},{0x2,0x1},{0x0,0xde},{0x0,0xfc},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xcf},{0x0,0xfd},{0x0,0xee},{0x4,0x1},{0x2,0x1},{0x0,0xdf},{0x0,0xfe},{0x2,0x1},{0x0,0xef},{0x0,0xff}};
    6481:	8d 85 86 f2 ff ff    	lea    -0xd7a(%ebp),%eax
    6487:	ba 00 c4 00 00       	mov    $0xc400,%edx
    648c:	bb fe 03 00 00       	mov    $0x3fe,%ebx
    6491:	89 c1                	mov    %eax,%ecx
    6493:	83 e1 02             	and    $0x2,%ecx
    6496:	85 c9                	test   %ecx,%ecx
    6498:	74 0f                	je     64a9 <read_decoder_table+0x62c>
    649a:	0f b7 0a             	movzwl (%edx),%ecx
    649d:	66 89 08             	mov    %cx,(%eax)
    64a0:	83 c0 02             	add    $0x2,%eax
    64a3:	83 c2 02             	add    $0x2,%edx
    64a6:	83 eb 02             	sub    $0x2,%ebx
    64a9:	89 d9                	mov    %ebx,%ecx
    64ab:	c1 e9 02             	shr    $0x2,%ecx
    64ae:	89 c7                	mov    %eax,%edi
    64b0:	89 d6                	mov    %edx,%esi
    64b2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    64b4:	89 f2                	mov    %esi,%edx
    64b6:	89 f8                	mov    %edi,%eax
    64b8:	b9 00 00 00 00       	mov    $0x0,%ecx
    64bd:	89 de                	mov    %ebx,%esi
    64bf:	83 e6 02             	and    $0x2,%esi
    64c2:	85 f6                	test   %esi,%esi
    64c4:	74 0b                	je     64d1 <read_decoder_table+0x654>
    64c6:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    64ca:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    64ce:	83 c1 02             	add    $0x2,%ecx
    64d1:	83 e3 01             	and    $0x1,%ebx
    64d4:	85 db                	test   %ebx,%ebx
    64d6:	74 07                	je     64df <read_decoder_table+0x662>
    64d8:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    64dc:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h16[511][2] = {{0x2,0x1},{0x0,0x0},{0x6,0x1},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0x2a,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x6,0x1},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x4,0x1},{0x2,0x1},{0x0,0x24},{0x0,0x50},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x8a,0x1},{0x28,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x15},{0x0,0x51},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x0,0x53},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x0,0x61},{0x2,0x1},{0x0,0x16},{0x0,0x62},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0x4,0x1},{0x2,0x1},{0x0,0x36},{0x0,0x70},{0x0,0x71},{0x28,0x1},{0x12,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x17},{0x2,0x1},{0x0,0x7},{0x2,0x1},{0x0,0x55},{0x0,0x64},{0x4,0x1},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x65},{0x0,0x73},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x37},{0x2,0x1},{0x0,0x56},{0x0,0x8},{0x2,0x1},{0x0,0x80},{0x0,0x81},{0x6,0x1},{0x2,0x1},{0x0,0x18},{0x2,0x1},{0x0,0x74},{0x0,0x47},{0x2,0x1},{0x0,0x82},{0x2,0x1},{0x0,0x28},{0x0,0x66},{0x18,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x2,0x1},{0x0,0x75},{0x0,0x84},{0x4,0x1},{0x2,0x1},{0x0,0x48},{0x0,0x90},{0x0,0x91},{0x6,0x1},{0x2,0x1},{0x0,0x19},{0x2,0x1},{0x0,0x9},{0x0,0x76},{0x2,0x1},{0x0,0x92},{0x0,0x29},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x2,0x1},{0x0,0x93},{0x0,0x39},{0x4,0x1},{0x2,0x1},{0x0,0xa0},{0x0,0xa},{0x0,0x1a},{0x8,0x1},{0x2,0x1},{0x0,0xa2},{0x2,0x1},{0x0,0x67},{0x2,0x1},{0x0,0x57},{0x0,0x49},{0x6,0x1},{0x2,0x1},{0x0,0x94},{0x2,0x1},{0x0,0x77},{0x0,0x86},{0x2,0x1},{0x0,0xa1},{0x2,0x1},{0x0,0x68},{0x0,0x95},{0xdc,0x1},{0x7e,0x1},{0x32,0x1},{0x1a,0x1},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x2a},{0x2,0x1},{0x0,0x59},{0x0,0x3a},{0x2,0x1},{0x0,0xa3},{0x2,0x1},{0x0,0x87},{0x0,0x78},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa4},{0x0,0x4a},{0x2,0x1},{0x0,0x96},{0x0,0x69},{0x4,0x1},{0x2,0x1},{0x0,0xb0},{0x0,0xb},{0x0,0xb1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1b},{0x0,0xb2},{0x2,0x1},{0x0,0x2b},{0x2,0x1},{0x0,0xa5},{0x0,0x5a},{0x6,0x1},{0x2,0x1},{0x0,0xb3},{0x2,0x1},{0x0,0xa6},{0x0,0x6a},{0x4,0x1},{0x2,0x1},{0x0,0xb4},{0x0,0x4b},{0x2,0x1},{0x0,0xc},{0x0,0xc1},{0x1e,0x1},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb5},{0x0,0xc2},{0x0,0x2c},{0x4,0x1},{0x2,0x1},{0x0,0xa7},{0x0,0xc3},{0x2,0x1},{0x0,0x6b},{0x0,0xc4},{0x8,0x1},{0x2,0x1},{0x0,0x1d},{0x4,0x1},{0x2,0x1},{0x0,0x88},{0x0,0x97},{0x0,0x3b},{0x4,0x1},{0x2,0x1},{0x0,0xd1},{0x0,0xd2},{0x2,0x1},{0x0,0x2d},{0x0,0xd3},{0x12,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0x2e},{0x0,0xe2},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x79},{0x0,0x98},{0x0,0xc0},{0x2,0x1},{0x0,0x1c},{0x2,0x1},{0x0,0x89},{0x0,0x5b},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3c},{0x2,0x1},{0x0,0x7a},{0x0,0xb6},{0x4,0x1},{0x2,0x1},{0x0,0x4c},{0x0,0x99},{0x2,0x1},{0x0,0xa8},{0x0,0x8a},{0x6,0x1},{0x2,0x1},{0x0,0xd},{0x2,0x1},{0x0,0xc5},{0x0,0x5c},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x2,0x1},{0x0,0x6c},{0x0,0x9a},{0x58,0x1},{0x56,0x1},{0x24,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8b},{0x0,0x4d},{0x2,0x1},{0x0,0xc7},{0x0,0x7c},{0x4,0x1},{0x2,0x1},{0x0,0xd5},{0x0,0x5d},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x8,0x1},{0x2,0x1},{0x0,0xe3},{0x4,0x1},{0x2,0x1},{0x0,0xd0},{0x0,0xb7},{0x0,0x7b},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa9},{0x0,0xb8},{0x0,0xd4},{0x2,0x1},{0x0,0xe1},{0x2,0x1},{0x0,0xaa},{0x0,0xb9},{0x18,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9b},{0x0,0xd6},{0x0,0x6d},{0x2,0x1},{0x0,0x3e},{0x0,0xc8},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8c},{0x0,0xe4},{0x0,0x4e},{0x4,0x1},{0x2,0x1},{0x0,0xd7},{0x0,0xe5},{0x2,0x1},{0x0,0xba},{0x0,0xab},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9c},{0x0,0xe6},{0x4,0x1},{0x2,0x1},{0x0,0x6e},{0x0,0xd8},{0x2,0x1},{0x0,0x8d},{0x0,0xbb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe7},{0x0,0x9d},{0x2,0x1},{0x0,0xe8},{0x0,0x8e},{0x4,0x1},{0x2,0x1},{0x0,0xcb},{0x0,0xbc},{0x0,0x9e},{0x0,0xf1},{0x2,0x1},{0x0,0x1f},{0x2,0x1},{0x0,0xf},{0x0,0x2f},{0x42,0x1},{0x38,0x1},{0x2,0x1},{0x0,0xf2},{0x34,0x1},{0x32,0x1},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0xbd},{0x2,0x1},{0x0,0x5e},{0x2,0x1},{0x0,0x7d},{0x0,0xc9},{0x6,0x1},{0x2,0x1},{0x0,0xca},{0x2,0x1},{0x0,0xac},{0x0,0x7e},{0x4,0x1},{0x2,0x1},{0x0,0xda},{0x0,0xad},{0x0,0xcc},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xae},{0x2,0x1},{0x0,0xdb},{0x0,0xdc},{0x2,0x1},{0x0,0xcd},{0x0,0xbe},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xeb},{0x0,0xed},{0x0,0xee},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd9},{0x0,0xea},{0x0,0xe9},{0x2,0x1},{0x0,0xde},{0x4,0x1},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x0,0xce},{0x0,0x3f},{0x0,0xf0},{0x4,0x1},{0x2,0x1},{0x0,0xf3},{0x0,0xf4},{0x2,0x1},{0x0,0x4f},{0x2,0x1},{0x0,0xf5},{0x0,0x5f},{0xa,0x1},{0x2,0x1},{0x0,0xff},{0x4,0x1},{0x2,0x1},{0x0,0xf6},{0x0,0x6f},{0x2,0x1},{0x0,0xf7},{0x0,0x7f},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x8f},{0x2,0x1},{0x0,0xf8},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xfa},{0x0,0xaf},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xfb},{0x0,0xbf},{0x2,0x1},{0x0,0xfc},{0x0,0xcf},{0x4,0x1},{0x2,0x1},{0x0,0xfd},{0x0,0xdf},{0x2,0x1},{0x0,0xfe},{0x0,0xef}};
    64df:	8d 95 88 ee ff ff    	lea    -0x1178(%ebp),%edx
    64e5:	b8 00 c8 00 00       	mov    $0xc800,%eax
    64ea:	b9 ff 00 00 00       	mov    $0xff,%ecx
    64ef:	89 d7                	mov    %edx,%edi
    64f1:	89 c6                	mov    %eax,%esi
    64f3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    64f5:	89 f0                	mov    %esi,%eax
    64f7:	89 fa                	mov    %edi,%edx
    64f9:	0f b7 08             	movzwl (%eax),%ecx
    64fc:	66 89 0a             	mov    %cx,(%edx)
    64ff:	83 c2 02             	add    $0x2,%edx
    6502:	83 c0 02             	add    $0x2,%eax

	unsigned char h24[512][2] = {{0x3c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x14},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0xfa,0x1},{0x62,0x1},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x4,0x1},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0x2,0x1},{0x0,0x62},{0x0,0x26},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x71},{0x0,0x55},{0x2,0x1},{0x0,0x64},{0x0,0x46},{0x20,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x72},{0x2,0x1},{0x0,0x27},{0x0,0x37},{0x2,0x1},{0x0,0x73},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x0,0x17},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x65},{0x0,0x56},{0x4,0x1},{0x2,0x1},{0x0,0x80},{0x0,0x8},{0x0,0x81},{0x4,0x1},{0x2,0x1},{0x0,0x74},{0x0,0x47},{0x2,0x1},{0x0,0x18},{0x0,0x82},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x28},{0x0,0x66},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x91},{0x0,0x19},{0x2,0x1},{0x0,0x92},{0x0,0x76},{0x4,0x1},{0x2,0x1},{0x0,0x67},{0x0,0x29},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x5c,0x1},{0x22,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x93},{0x0,0x39},{0x2,0x1},{0x0,0x94},{0x0,0x49},{0x4,0x1},{0x2,0x1},{0x0,0x77},{0x0,0x86},{0x2,0x1},{0x0,0x68},{0x0,0xa1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x4,0x1},{0x2,0x1},{0x0,0xa3},{0x0,0x3a},{0x2,0x1},{0x0,0x87},{0x2,0x1},{0x0,0x78},{0x0,0x4a},{0x16,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa4},{0x0,0x96},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xb1},{0x2,0x1},{0x0,0x1b},{0x0,0xa5},{0x6,0x1},{0x2,0x1},{0x0,0xb2},{0x2,0x1},{0x0,0x5a},{0x0,0x2b},{0x2,0x1},{0x0,0x88},{0x0,0xb3},{0x10,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x90},{0x2,0x1},{0x0,0x9},{0x0,0xa0},{0x2,0x1},{0x0,0x97},{0x0,0x79},{0x4,0x1},{0x2,0x1},{0x0,0xa6},{0x0,0x6a},{0x0,0xb4},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x1a},{0x2,0x1},{0x0,0xa},{0x0,0xb0},{0x2,0x1},{0x0,0x3b},{0x2,0x1},{0x0,0xb},{0x0,0xc0},{0x4,0x1},{0x2,0x1},{0x0,0x4b},{0x0,0xc1},{0x2,0x1},{0x0,0x98},{0x0,0x89},{0x43,0x1},{0x22,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1c},{0x0,0xb5},{0x2,0x1},{0x0,0x5b},{0x0,0xc2},{0x4,0x1},{0x2,0x1},{0x0,0x2c},{0x0,0xa7},{0x2,0x1},{0x0,0x7a},{0x0,0xc3},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3c},{0x2,0x1},{0x0,0xc},{0x0,0xd0},{0x2,0x1},{0x0,0xb6},{0x0,0x6b},{0x4,0x1},{0x2,0x1},{0x0,0xc4},{0x0,0x4c},{0x2,0x1},{0x0,0x99},{0x0,0xa8},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8a},{0x0,0xc5},{0x2,0x1},{0x0,0x5c},{0x0,0xd1},{0x4,0x1},{0x2,0x1},{0x0,0xb7},{0x0,0x7b},{0x2,0x1},{0x0,0x1d},{0x0,0xd2},{0x9,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x2d},{0x0,0xd3},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x55,0xfa},{0x4,0x1},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x2,0x1},{0x0,0x9a},{0x0,0xd4},{0x20,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb8},{0x0,0x8b},{0x2,0x1},{0x0,0x4d},{0x0,0xc7},{0x4,0x1},{0x2,0x1},{0x0,0x7c},{0x0,0xd5},{0x2,0x1},{0x0,0x5d},{0x0,0xe1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0xe2},{0x2,0x1},{0x0,0xaa},{0x0,0xb9},{0x4,0x1},{0x2,0x1},{0x0,0x9b},{0x0,0xe3},{0x2,0x1},{0x0,0xd6},{0x0,0x6d},{0x14,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3e},{0x2,0x1},{0x0,0x2e},{0x0,0x4e},{0x2,0x1},{0x0,0xc8},{0x0,0x8c},{0x4,0x1},{0x2,0x1},{0x0,0xe4},{0x0,0xd7},{0x4,0x1},{0x2,0x1},{0x0,0x7d},{0x0,0xab},{0x0,0xe5},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xba},{0x0,0x5e},{0x2,0x1},{0x0,0xc9},{0x2,0x1},{0x0,0x9c},{0x0,0x6e},{0x8,0x1},{0x2,0x1},{0x0,0xe6},{0x2,0x1},{0x0,0xd},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0x8d},{0x2,0x1},{0x0,0xbb},{0x0,0xca},{0x4a,0x1},{0x2,0x1},{0x0,0xff},{0x40,0x1},{0x3a,0x1},{0x20,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xac},{0x0,0xe7},{0x2,0x1},{0x0,0x7e},{0x0,0xd9},{0x4,0x1},{0x2,0x1},{0x0,0x9d},{0x0,0xe8},{0x2,0x1},{0x0,0x8e},{0x0,0xcb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbc},{0x0,0xda},{0x2,0x1},{0x0,0xad},{0x0,0xe9},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xcc},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xea},{0x0,0xae},{0x2,0x1},{0x0,0xdc},{0x0,0xcd},{0x4,0x1},{0x2,0x1},{0x0,0xeb},{0x0,0xbe},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xce},{0x0,0xed},{0x2,0x1},{0x0,0xde},{0x0,0xee},{0x0,0xf},{0x4,0x1},{0x2,0x1},{0x0,0xf0},{0x0,0x1f},{0x0,0xf1},{0x4,0x1},{0x2,0x1},{0x0,0xf2},{0x0,0x2f},{0x2,0x1},{0x0,0xf3},{0x0,0x3f},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf4},{0x0,0x4f},{0x2,0x1},{0x0,0xf5},{0x0,0x5f},{0x4,0x1},{0x2,0x1},{0x0,0xf6},{0x0,0x6f},{0x2,0x1},{0x0,0xf7},{0x2,0x1},{0x0,0x7f},{0x0,0x8f},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf8},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xaf},{0x0,0xfa},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xfb},{0x0,0xbf},{0x2,0x1},{0x0,0xfc},{0x0,0xcf},{0x4,0x1},{0x2,0x1},{0x0,0xfd},{0x0,0xdf},{0x2,0x1},{0x0,0xfe},{0x0,0xef}};
    6505:	8d 95 88 ea ff ff    	lea    -0x1578(%ebp),%edx
    650b:	bb 00 cc 00 00       	mov    $0xcc00,%ebx
    6510:	b8 00 01 00 00       	mov    $0x100,%eax
    6515:	89 d7                	mov    %edx,%edi
    6517:	89 de                	mov    %ebx,%esi
    6519:	89 c1                	mov    %eax,%ecx
    651b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	unsigned char hA[31][2] = {{0x2,0x1},{0x0,0x0},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8},{0x0,0x4},{0x2,0x1},{0x0,0x1},{0x0,0x2},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0xa},{0x2,0x1},{0x0,0x3},{0x0,0x6},{0x6,0x1},{0x2,0x1},{0x0,0x9},{0x2,0x1},{0x0,0x5},{0x0,0x7},{0x4,0x1},{0x2,0x1},{0x0,0xe},{0x0,0xd},{0x2,0x1},{0x0,0xf},{0x0,0xb}};
    651d:	c6 85 4a ea ff ff 02 	movb   $0x2,-0x15b6(%ebp)
    6524:	c6 85 4b ea ff ff 01 	movb   $0x1,-0x15b5(%ebp)
    652b:	c6 85 4c ea ff ff 00 	movb   $0x0,-0x15b4(%ebp)
    6532:	c6 85 4d ea ff ff 00 	movb   $0x0,-0x15b3(%ebp)
    6539:	c6 85 4e ea ff ff 08 	movb   $0x8,-0x15b2(%ebp)
    6540:	c6 85 4f ea ff ff 01 	movb   $0x1,-0x15b1(%ebp)
    6547:	c6 85 50 ea ff ff 04 	movb   $0x4,-0x15b0(%ebp)
    654e:	c6 85 51 ea ff ff 01 	movb   $0x1,-0x15af(%ebp)
    6555:	c6 85 52 ea ff ff 02 	movb   $0x2,-0x15ae(%ebp)
    655c:	c6 85 53 ea ff ff 01 	movb   $0x1,-0x15ad(%ebp)
    6563:	c6 85 54 ea ff ff 00 	movb   $0x0,-0x15ac(%ebp)
    656a:	c6 85 55 ea ff ff 08 	movb   $0x8,-0x15ab(%ebp)
    6571:	c6 85 56 ea ff ff 00 	movb   $0x0,-0x15aa(%ebp)
    6578:	c6 85 57 ea ff ff 04 	movb   $0x4,-0x15a9(%ebp)
    657f:	c6 85 58 ea ff ff 02 	movb   $0x2,-0x15a8(%ebp)
    6586:	c6 85 59 ea ff ff 01 	movb   $0x1,-0x15a7(%ebp)
    658d:	c6 85 5a ea ff ff 00 	movb   $0x0,-0x15a6(%ebp)
    6594:	c6 85 5b ea ff ff 01 	movb   $0x1,-0x15a5(%ebp)
    659b:	c6 85 5c ea ff ff 00 	movb   $0x0,-0x15a4(%ebp)
    65a2:	c6 85 5d ea ff ff 02 	movb   $0x2,-0x15a3(%ebp)
    65a9:	c6 85 5e ea ff ff 08 	movb   $0x8,-0x15a2(%ebp)
    65b0:	c6 85 5f ea ff ff 01 	movb   $0x1,-0x15a1(%ebp)
    65b7:	c6 85 60 ea ff ff 04 	movb   $0x4,-0x15a0(%ebp)
    65be:	c6 85 61 ea ff ff 01 	movb   $0x1,-0x159f(%ebp)
    65c5:	c6 85 62 ea ff ff 02 	movb   $0x2,-0x159e(%ebp)
    65cc:	c6 85 63 ea ff ff 01 	movb   $0x1,-0x159d(%ebp)
    65d3:	c6 85 64 ea ff ff 00 	movb   $0x0,-0x159c(%ebp)
    65da:	c6 85 65 ea ff ff 0c 	movb   $0xc,-0x159b(%ebp)
    65e1:	c6 85 66 ea ff ff 00 	movb   $0x0,-0x159a(%ebp)
    65e8:	c6 85 67 ea ff ff 0a 	movb   $0xa,-0x1599(%ebp)
    65ef:	c6 85 68 ea ff ff 02 	movb   $0x2,-0x1598(%ebp)
    65f6:	c6 85 69 ea ff ff 01 	movb   $0x1,-0x1597(%ebp)
    65fd:	c6 85 6a ea ff ff 00 	movb   $0x0,-0x1596(%ebp)
    6604:	c6 85 6b ea ff ff 03 	movb   $0x3,-0x1595(%ebp)
    660b:	c6 85 6c ea ff ff 00 	movb   $0x0,-0x1594(%ebp)
    6612:	c6 85 6d ea ff ff 06 	movb   $0x6,-0x1593(%ebp)
    6619:	c6 85 6e ea ff ff 06 	movb   $0x6,-0x1592(%ebp)
    6620:	c6 85 6f ea ff ff 01 	movb   $0x1,-0x1591(%ebp)
    6627:	c6 85 70 ea ff ff 02 	movb   $0x2,-0x1590(%ebp)
    662e:	c6 85 71 ea ff ff 01 	movb   $0x1,-0x158f(%ebp)
    6635:	c6 85 72 ea ff ff 00 	movb   $0x0,-0x158e(%ebp)
    663c:	c6 85 73 ea ff ff 09 	movb   $0x9,-0x158d(%ebp)
    6643:	c6 85 74 ea ff ff 02 	movb   $0x2,-0x158c(%ebp)
    664a:	c6 85 75 ea ff ff 01 	movb   $0x1,-0x158b(%ebp)
    6651:	c6 85 76 ea ff ff 00 	movb   $0x0,-0x158a(%ebp)
    6658:	c6 85 77 ea ff ff 05 	movb   $0x5,-0x1589(%ebp)
    665f:	c6 85 78 ea ff ff 00 	movb   $0x0,-0x1588(%ebp)
    6666:	c6 85 79 ea ff ff 07 	movb   $0x7,-0x1587(%ebp)
    666d:	c6 85 7a ea ff ff 04 	movb   $0x4,-0x1586(%ebp)
    6674:	c6 85 7b ea ff ff 01 	movb   $0x1,-0x1585(%ebp)
    667b:	c6 85 7c ea ff ff 02 	movb   $0x2,-0x1584(%ebp)
    6682:	c6 85 7d ea ff ff 01 	movb   $0x1,-0x1583(%ebp)
    6689:	c6 85 7e ea ff ff 00 	movb   $0x0,-0x1582(%ebp)
    6690:	c6 85 7f ea ff ff 0e 	movb   $0xe,-0x1581(%ebp)
    6697:	c6 85 80 ea ff ff 00 	movb   $0x0,-0x1580(%ebp)
    669e:	c6 85 81 ea ff ff 0d 	movb   $0xd,-0x157f(%ebp)
    66a5:	c6 85 82 ea ff ff 02 	movb   $0x2,-0x157e(%ebp)
    66ac:	c6 85 83 ea ff ff 01 	movb   $0x1,-0x157d(%ebp)
    66b3:	c6 85 84 ea ff ff 00 	movb   $0x0,-0x157c(%ebp)
    66ba:	c6 85 85 ea ff ff 0f 	movb   $0xf,-0x157b(%ebp)
    66c1:	c6 85 86 ea ff ff 00 	movb   $0x0,-0x157a(%ebp)
    66c8:	c6 85 87 ea ff ff 0b 	movb   $0xb,-0x1579(%ebp)

	unsigned char hB[31][2] = {{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x1},{0x2,0x1},{0x0,0x2},{0x0,0x3},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x5},{0x2,0x1},{0x0,0x6},{0x0,0x7},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8},{0x0,0x9},{0x2,0x1},{0x0,0xa},{0x0,0xb},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0xd},{0x2,0x1},{0x0,0xe},{0x0,0xf}};
    66cf:	c6 85 0c ea ff ff 10 	movb   $0x10,-0x15f4(%ebp)
    66d6:	c6 85 0d ea ff ff 01 	movb   $0x1,-0x15f3(%ebp)
    66dd:	c6 85 0e ea ff ff 08 	movb   $0x8,-0x15f2(%ebp)
    66e4:	c6 85 0f ea ff ff 01 	movb   $0x1,-0x15f1(%ebp)
    66eb:	c6 85 10 ea ff ff 04 	movb   $0x4,-0x15f0(%ebp)
    66f2:	c6 85 11 ea ff ff 01 	movb   $0x1,-0x15ef(%ebp)
    66f9:	c6 85 12 ea ff ff 02 	movb   $0x2,-0x15ee(%ebp)
    6700:	c6 85 13 ea ff ff 01 	movb   $0x1,-0x15ed(%ebp)
    6707:	c6 85 14 ea ff ff 00 	movb   $0x0,-0x15ec(%ebp)
    670e:	c6 85 15 ea ff ff 00 	movb   $0x0,-0x15eb(%ebp)
    6715:	c6 85 16 ea ff ff 00 	movb   $0x0,-0x15ea(%ebp)
    671c:	c6 85 17 ea ff ff 01 	movb   $0x1,-0x15e9(%ebp)
    6723:	c6 85 18 ea ff ff 02 	movb   $0x2,-0x15e8(%ebp)
    672a:	c6 85 19 ea ff ff 01 	movb   $0x1,-0x15e7(%ebp)
    6731:	c6 85 1a ea ff ff 00 	movb   $0x0,-0x15e6(%ebp)
    6738:	c6 85 1b ea ff ff 02 	movb   $0x2,-0x15e5(%ebp)
    673f:	c6 85 1c ea ff ff 00 	movb   $0x0,-0x15e4(%ebp)
    6746:	c6 85 1d ea ff ff 03 	movb   $0x3,-0x15e3(%ebp)
    674d:	c6 85 1e ea ff ff 04 	movb   $0x4,-0x15e2(%ebp)
    6754:	c6 85 1f ea ff ff 01 	movb   $0x1,-0x15e1(%ebp)
    675b:	c6 85 20 ea ff ff 02 	movb   $0x2,-0x15e0(%ebp)
    6762:	c6 85 21 ea ff ff 01 	movb   $0x1,-0x15df(%ebp)
    6769:	c6 85 22 ea ff ff 00 	movb   $0x0,-0x15de(%ebp)
    6770:	c6 85 23 ea ff ff 04 	movb   $0x4,-0x15dd(%ebp)
    6777:	c6 85 24 ea ff ff 00 	movb   $0x0,-0x15dc(%ebp)
    677e:	c6 85 25 ea ff ff 05 	movb   $0x5,-0x15db(%ebp)
    6785:	c6 85 26 ea ff ff 02 	movb   $0x2,-0x15da(%ebp)
    678c:	c6 85 27 ea ff ff 01 	movb   $0x1,-0x15d9(%ebp)
    6793:	c6 85 28 ea ff ff 00 	movb   $0x0,-0x15d8(%ebp)
    679a:	c6 85 29 ea ff ff 06 	movb   $0x6,-0x15d7(%ebp)
    67a1:	c6 85 2a ea ff ff 00 	movb   $0x0,-0x15d6(%ebp)
    67a8:	c6 85 2b ea ff ff 07 	movb   $0x7,-0x15d5(%ebp)
    67af:	c6 85 2c ea ff ff 08 	movb   $0x8,-0x15d4(%ebp)
    67b6:	c6 85 2d ea ff ff 01 	movb   $0x1,-0x15d3(%ebp)
    67bd:	c6 85 2e ea ff ff 04 	movb   $0x4,-0x15d2(%ebp)
    67c4:	c6 85 2f ea ff ff 01 	movb   $0x1,-0x15d1(%ebp)
    67cb:	c6 85 30 ea ff ff 02 	movb   $0x2,-0x15d0(%ebp)
    67d2:	c6 85 31 ea ff ff 01 	movb   $0x1,-0x15cf(%ebp)
    67d9:	c6 85 32 ea ff ff 00 	movb   $0x0,-0x15ce(%ebp)
    67e0:	c6 85 33 ea ff ff 08 	movb   $0x8,-0x15cd(%ebp)
    67e7:	c6 85 34 ea ff ff 00 	movb   $0x0,-0x15cc(%ebp)
    67ee:	c6 85 35 ea ff ff 09 	movb   $0x9,-0x15cb(%ebp)
    67f5:	c6 85 36 ea ff ff 02 	movb   $0x2,-0x15ca(%ebp)
    67fc:	c6 85 37 ea ff ff 01 	movb   $0x1,-0x15c9(%ebp)
    6803:	c6 85 38 ea ff ff 00 	movb   $0x0,-0x15c8(%ebp)
    680a:	c6 85 39 ea ff ff 0a 	movb   $0xa,-0x15c7(%ebp)
    6811:	c6 85 3a ea ff ff 00 	movb   $0x0,-0x15c6(%ebp)
    6818:	c6 85 3b ea ff ff 0b 	movb   $0xb,-0x15c5(%ebp)
    681f:	c6 85 3c ea ff ff 04 	movb   $0x4,-0x15c4(%ebp)
    6826:	c6 85 3d ea ff ff 01 	movb   $0x1,-0x15c3(%ebp)
    682d:	c6 85 3e ea ff ff 02 	movb   $0x2,-0x15c2(%ebp)
    6834:	c6 85 3f ea ff ff 01 	movb   $0x1,-0x15c1(%ebp)
    683b:	c6 85 40 ea ff ff 00 	movb   $0x0,-0x15c0(%ebp)
    6842:	c6 85 41 ea ff ff 0c 	movb   $0xc,-0x15bf(%ebp)
    6849:	c6 85 42 ea ff ff 00 	movb   $0x0,-0x15be(%ebp)
    6850:	c6 85 43 ea ff ff 0d 	movb   $0xd,-0x15bd(%ebp)
    6857:	c6 85 44 ea ff ff 02 	movb   $0x2,-0x15bc(%ebp)
    685e:	c6 85 45 ea ff ff 01 	movb   $0x1,-0x15bb(%ebp)
    6865:	c6 85 46 ea ff ff 00 	movb   $0x0,-0x15ba(%ebp)
    686c:	c6 85 47 ea ff ff 0e 	movb   $0xe,-0x15b9(%ebp)
    6873:	c6 85 48 ea ff ff 00 	movb   $0x0,-0x15b8(%ebp)
    687a:	c6 85 49 ea ff ff 0f 	movb   $0xf,-0x15b7(%ebp)
	
	struct huffcodetab ht[HTN] = {
    6881:	66 c7 85 bc e4 ff ff 	movw   $0x30,-0x1b44(%ebp)
    6888:	30 00 
    688a:	c6 85 be e4 ff ff 00 	movb   $0x0,-0x1b42(%ebp)
    6891:	c7 85 c0 e4 ff ff 00 	movl   $0x0,-0x1b40(%ebp)
    6898:	00 00 00 
    689b:	c7 85 c4 e4 ff ff 00 	movl   $0x0,-0x1b3c(%ebp)
    68a2:	00 00 00 
    68a5:	c7 85 c8 e4 ff ff 00 	movl   $0x0,-0x1b38(%ebp)
    68ac:	00 00 00 
    68af:	c7 85 cc e4 ff ff 00 	movl   $0x0,-0x1b34(%ebp)
    68b6:	00 00 00 
    68b9:	c7 85 d0 e4 ff ff ff 	movl   $0xffffffff,-0x1b30(%ebp)
    68c0:	ff ff ff 
    68c3:	c7 85 d4 e4 ff ff 00 	movl   $0x0,-0x1b2c(%ebp)
    68ca:	00 00 00 
    68cd:	c7 85 d8 e4 ff ff 00 	movl   $0x0,-0x1b28(%ebp)
    68d4:	00 00 00 
    68d7:	c7 85 dc e4 ff ff 00 	movl   $0x0,-0x1b24(%ebp)
    68de:	00 00 00 
    68e1:	c7 85 e0 e4 ff ff 00 	movl   $0x0,-0x1b20(%ebp)
    68e8:	00 00 00 
    68eb:	66 c7 85 e4 e4 ff ff 	movw   $0x31,-0x1b1c(%ebp)
    68f2:	31 00 
    68f4:	c6 85 e6 e4 ff ff 00 	movb   $0x0,-0x1b1a(%ebp)
    68fb:	c7 85 e8 e4 ff ff 02 	movl   $0x2,-0x1b18(%ebp)
    6902:	00 00 00 
    6905:	c7 85 ec e4 ff ff 02 	movl   $0x2,-0x1b14(%ebp)
    690c:	00 00 00 
    690f:	c7 85 f0 e4 ff ff 00 	movl   $0x0,-0x1b10(%ebp)
    6916:	00 00 00 
    6919:	c7 85 f4 e4 ff ff 00 	movl   $0x0,-0x1b0c(%ebp)
    6920:	00 00 00 
    6923:	c7 85 f8 e4 ff ff ff 	movl   $0xffffffff,-0x1b08(%ebp)
    692a:	ff ff ff 
    692d:	c7 85 fc e4 ff ff 00 	movl   $0x0,-0x1b04(%ebp)
    6934:	00 00 00 
    6937:	c7 85 00 e5 ff ff 00 	movl   $0x0,-0x1b00(%ebp)
    693e:	00 00 00 
    6941:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    6944:	89 85 04 e5 ff ff    	mov    %eax,-0x1afc(%ebp)
    694a:	c7 85 08 e5 ff ff 07 	movl   $0x7,-0x1af8(%ebp)
    6951:	00 00 00 
    6954:	66 c7 85 0c e5 ff ff 	movw   $0x32,-0x1af4(%ebp)
    695b:	32 00 
    695d:	c6 85 0e e5 ff ff 00 	movb   $0x0,-0x1af2(%ebp)
    6964:	c7 85 10 e5 ff ff 03 	movl   $0x3,-0x1af0(%ebp)
    696b:	00 00 00 
    696e:	c7 85 14 e5 ff ff 03 	movl   $0x3,-0x1aec(%ebp)
    6975:	00 00 00 
    6978:	c7 85 18 e5 ff ff 00 	movl   $0x0,-0x1ae8(%ebp)
    697f:	00 00 00 
    6982:	c7 85 1c e5 ff ff 00 	movl   $0x0,-0x1ae4(%ebp)
    6989:	00 00 00 
    698c:	c7 85 20 e5 ff ff ff 	movl   $0xffffffff,-0x1ae0(%ebp)
    6993:	ff ff ff 
    6996:	c7 85 24 e5 ff ff 00 	movl   $0x0,-0x1adc(%ebp)
    699d:	00 00 00 
    69a0:	c7 85 28 e5 ff ff 00 	movl   $0x0,-0x1ad8(%ebp)
    69a7:	00 00 00 
    69aa:	8d 45 c4             	lea    -0x3c(%ebp),%eax
    69ad:	89 85 2c e5 ff ff    	mov    %eax,-0x1ad4(%ebp)
    69b3:	c7 85 30 e5 ff ff 11 	movl   $0x11,-0x1ad0(%ebp)
    69ba:	00 00 00 
    69bd:	66 c7 85 34 e5 ff ff 	movw   $0x33,-0x1acc(%ebp)
    69c4:	33 00 
    69c6:	c6 85 36 e5 ff ff 00 	movb   $0x0,-0x1aca(%ebp)
    69cd:	c7 85 38 e5 ff ff 03 	movl   $0x3,-0x1ac8(%ebp)
    69d4:	00 00 00 
    69d7:	c7 85 3c e5 ff ff 03 	movl   $0x3,-0x1ac4(%ebp)
    69de:	00 00 00 
    69e1:	c7 85 40 e5 ff ff 00 	movl   $0x0,-0x1ac0(%ebp)
    69e8:	00 00 00 
    69eb:	c7 85 44 e5 ff ff 00 	movl   $0x0,-0x1abc(%ebp)
    69f2:	00 00 00 
    69f5:	c7 85 48 e5 ff ff ff 	movl   $0xffffffff,-0x1ab8(%ebp)
    69fc:	ff ff ff 
    69ff:	c7 85 4c e5 ff ff 00 	movl   $0x0,-0x1ab4(%ebp)
    6a06:	00 00 00 
    6a09:	c7 85 50 e5 ff ff 00 	movl   $0x0,-0x1ab0(%ebp)
    6a10:	00 00 00 
    6a13:	8d 45 a2             	lea    -0x5e(%ebp),%eax
    6a16:	89 85 54 e5 ff ff    	mov    %eax,-0x1aac(%ebp)
    6a1c:	c7 85 58 e5 ff ff 11 	movl   $0x11,-0x1aa8(%ebp)
    6a23:	00 00 00 
    6a26:	66 c7 85 5c e5 ff ff 	movw   $0x34,-0x1aa4(%ebp)
    6a2d:	34 00 
    6a2f:	c6 85 5e e5 ff ff 00 	movb   $0x0,-0x1aa2(%ebp)
    6a36:	c7 85 60 e5 ff ff 00 	movl   $0x0,-0x1aa0(%ebp)
    6a3d:	00 00 00 
    6a40:	c7 85 64 e5 ff ff 00 	movl   $0x0,-0x1a9c(%ebp)
    6a47:	00 00 00 
    6a4a:	c7 85 68 e5 ff ff 00 	movl   $0x0,-0x1a98(%ebp)
    6a51:	00 00 00 
    6a54:	c7 85 6c e5 ff ff 00 	movl   $0x0,-0x1a94(%ebp)
    6a5b:	00 00 00 
    6a5e:	c7 85 70 e5 ff ff ff 	movl   $0xffffffff,-0x1a90(%ebp)
    6a65:	ff ff ff 
    6a68:	c7 85 74 e5 ff ff 00 	movl   $0x0,-0x1a8c(%ebp)
    6a6f:	00 00 00 
    6a72:	c7 85 78 e5 ff ff 00 	movl   $0x0,-0x1a88(%ebp)
    6a79:	00 00 00 
    6a7c:	c7 85 7c e5 ff ff 00 	movl   $0x0,-0x1a84(%ebp)
    6a83:	00 00 00 
    6a86:	c7 85 80 e5 ff ff 00 	movl   $0x0,-0x1a80(%ebp)
    6a8d:	00 00 00 
    6a90:	66 c7 85 84 e5 ff ff 	movw   $0x35,-0x1a7c(%ebp)
    6a97:	35 00 
    6a99:	c6 85 86 e5 ff ff 00 	movb   $0x0,-0x1a7a(%ebp)
    6aa0:	c7 85 88 e5 ff ff 04 	movl   $0x4,-0x1a78(%ebp)
    6aa7:	00 00 00 
    6aaa:	c7 85 8c e5 ff ff 04 	movl   $0x4,-0x1a74(%ebp)
    6ab1:	00 00 00 
    6ab4:	c7 85 90 e5 ff ff 00 	movl   $0x0,-0x1a70(%ebp)
    6abb:	00 00 00 
    6abe:	c7 85 94 e5 ff ff 00 	movl   $0x0,-0x1a6c(%ebp)
    6ac5:	00 00 00 
    6ac8:	c7 85 98 e5 ff ff ff 	movl   $0xffffffff,-0x1a68(%ebp)
    6acf:	ff ff ff 
    6ad2:	c7 85 9c e5 ff ff 00 	movl   $0x0,-0x1a64(%ebp)
    6ad9:	00 00 00 
    6adc:	c7 85 a0 e5 ff ff 00 	movl   $0x0,-0x1a60(%ebp)
    6ae3:	00 00 00 
    6ae6:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
    6aec:	89 85 a4 e5 ff ff    	mov    %eax,-0x1a5c(%ebp)
    6af2:	c7 85 a8 e5 ff ff 1f 	movl   $0x1f,-0x1a58(%ebp)
    6af9:	00 00 00 
    6afc:	66 c7 85 ac e5 ff ff 	movw   $0x36,-0x1a54(%ebp)
    6b03:	36 00 
    6b05:	c6 85 ae e5 ff ff 00 	movb   $0x0,-0x1a52(%ebp)
    6b0c:	c7 85 b0 e5 ff ff 04 	movl   $0x4,-0x1a50(%ebp)
    6b13:	00 00 00 
    6b16:	c7 85 b4 e5 ff ff 04 	movl   $0x4,-0x1a4c(%ebp)
    6b1d:	00 00 00 
    6b20:	c7 85 b8 e5 ff ff 00 	movl   $0x0,-0x1a48(%ebp)
    6b27:	00 00 00 
    6b2a:	c7 85 bc e5 ff ff 00 	movl   $0x0,-0x1a44(%ebp)
    6b31:	00 00 00 
    6b34:	c7 85 c0 e5 ff ff ff 	movl   $0xffffffff,-0x1a40(%ebp)
    6b3b:	ff ff ff 
    6b3e:	c7 85 c4 e5 ff ff 00 	movl   $0x0,-0x1a3c(%ebp)
    6b45:	00 00 00 
    6b48:	c7 85 c8 e5 ff ff 00 	movl   $0x0,-0x1a38(%ebp)
    6b4f:	00 00 00 
    6b52:	8d 85 26 ff ff ff    	lea    -0xda(%ebp),%eax
    6b58:	89 85 cc e5 ff ff    	mov    %eax,-0x1a34(%ebp)
    6b5e:	c7 85 d0 e5 ff ff 1f 	movl   $0x1f,-0x1a30(%ebp)
    6b65:	00 00 00 
    6b68:	66 c7 85 d4 e5 ff ff 	movw   $0x37,-0x1a2c(%ebp)
    6b6f:	37 00 
    6b71:	c6 85 d6 e5 ff ff 00 	movb   $0x0,-0x1a2a(%ebp)
    6b78:	c7 85 d8 e5 ff ff 06 	movl   $0x6,-0x1a28(%ebp)
    6b7f:	00 00 00 
    6b82:	c7 85 dc e5 ff ff 06 	movl   $0x6,-0x1a24(%ebp)
    6b89:	00 00 00 
    6b8c:	c7 85 e0 e5 ff ff 00 	movl   $0x0,-0x1a20(%ebp)
    6b93:	00 00 00 
    6b96:	c7 85 e4 e5 ff ff 00 	movl   $0x0,-0x1a1c(%ebp)
    6b9d:	00 00 00 
    6ba0:	c7 85 e8 e5 ff ff ff 	movl   $0xffffffff,-0x1a18(%ebp)
    6ba7:	ff ff ff 
    6baa:	c7 85 ec e5 ff ff 00 	movl   $0x0,-0x1a14(%ebp)
    6bb1:	00 00 00 
    6bb4:	c7 85 f0 e5 ff ff 00 	movl   $0x0,-0x1a10(%ebp)
    6bbb:	00 00 00 
    6bbe:	8d 85 98 fe ff ff    	lea    -0x168(%ebp),%eax
    6bc4:	89 85 f4 e5 ff ff    	mov    %eax,-0x1a0c(%ebp)
    6bca:	c7 85 f8 e5 ff ff 47 	movl   $0x47,-0x1a08(%ebp)
    6bd1:	00 00 00 
    6bd4:	66 c7 85 fc e5 ff ff 	movw   $0x38,-0x1a04(%ebp)
    6bdb:	38 00 
    6bdd:	c6 85 fe e5 ff ff 00 	movb   $0x0,-0x1a02(%ebp)
    6be4:	c7 85 00 e6 ff ff 06 	movl   $0x6,-0x1a00(%ebp)
    6beb:	00 00 00 
    6bee:	c7 85 04 e6 ff ff 06 	movl   $0x6,-0x19fc(%ebp)
    6bf5:	00 00 00 
    6bf8:	c7 85 08 e6 ff ff 00 	movl   $0x0,-0x19f8(%ebp)
    6bff:	00 00 00 
    6c02:	c7 85 0c e6 ff ff 00 	movl   $0x0,-0x19f4(%ebp)
    6c09:	00 00 00 
    6c0c:	c7 85 10 e6 ff ff ff 	movl   $0xffffffff,-0x19f0(%ebp)
    6c13:	ff ff ff 
    6c16:	c7 85 14 e6 ff ff 00 	movl   $0x0,-0x19ec(%ebp)
    6c1d:	00 00 00 
    6c20:	c7 85 18 e6 ff ff 00 	movl   $0x0,-0x19e8(%ebp)
    6c27:	00 00 00 
    6c2a:	8d 85 0a fe ff ff    	lea    -0x1f6(%ebp),%eax
    6c30:	89 85 1c e6 ff ff    	mov    %eax,-0x19e4(%ebp)
    6c36:	c7 85 20 e6 ff ff 47 	movl   $0x47,-0x19e0(%ebp)
    6c3d:	00 00 00 
    6c40:	66 c7 85 24 e6 ff ff 	movw   $0x39,-0x19dc(%ebp)
    6c47:	39 00 
    6c49:	c6 85 26 e6 ff ff 00 	movb   $0x0,-0x19da(%ebp)
    6c50:	c7 85 28 e6 ff ff 06 	movl   $0x6,-0x19d8(%ebp)
    6c57:	00 00 00 
    6c5a:	c7 85 2c e6 ff ff 06 	movl   $0x6,-0x19d4(%ebp)
    6c61:	00 00 00 
    6c64:	c7 85 30 e6 ff ff 00 	movl   $0x0,-0x19d0(%ebp)
    6c6b:	00 00 00 
    6c6e:	c7 85 34 e6 ff ff 00 	movl   $0x0,-0x19cc(%ebp)
    6c75:	00 00 00 
    6c78:	c7 85 38 e6 ff ff ff 	movl   $0xffffffff,-0x19c8(%ebp)
    6c7f:	ff ff ff 
    6c82:	c7 85 3c e6 ff ff 00 	movl   $0x0,-0x19c4(%ebp)
    6c89:	00 00 00 
    6c8c:	c7 85 40 e6 ff ff 00 	movl   $0x0,-0x19c0(%ebp)
    6c93:	00 00 00 
    6c96:	8d 85 7c fd ff ff    	lea    -0x284(%ebp),%eax
    6c9c:	89 85 44 e6 ff ff    	mov    %eax,-0x19bc(%ebp)
    6ca2:	c7 85 48 e6 ff ff 47 	movl   $0x47,-0x19b8(%ebp)
    6ca9:	00 00 00 
    6cac:	66 c7 85 4c e6 ff ff 	movw   $0x3031,-0x19b4(%ebp)
    6cb3:	31 30 
    6cb5:	c6 85 4e e6 ff ff 00 	movb   $0x0,-0x19b2(%ebp)
    6cbc:	c7 85 50 e6 ff ff 08 	movl   $0x8,-0x19b0(%ebp)
    6cc3:	00 00 00 
    6cc6:	c7 85 54 e6 ff ff 08 	movl   $0x8,-0x19ac(%ebp)
    6ccd:	00 00 00 
    6cd0:	c7 85 58 e6 ff ff 00 	movl   $0x0,-0x19a8(%ebp)
    6cd7:	00 00 00 
    6cda:	c7 85 5c e6 ff ff 00 	movl   $0x0,-0x19a4(%ebp)
    6ce1:	00 00 00 
    6ce4:	c7 85 60 e6 ff ff ff 	movl   $0xffffffff,-0x19a0(%ebp)
    6ceb:	ff ff ff 
    6cee:	c7 85 64 e6 ff ff 00 	movl   $0x0,-0x199c(%ebp)
    6cf5:	00 00 00 
    6cf8:	c7 85 68 e6 ff ff 00 	movl   $0x0,-0x1998(%ebp)
    6cff:	00 00 00 
    6d02:	8d 85 7e fc ff ff    	lea    -0x382(%ebp),%eax
    6d08:	89 85 6c e6 ff ff    	mov    %eax,-0x1994(%ebp)
    6d0e:	c7 85 70 e6 ff ff 7f 	movl   $0x7f,-0x1990(%ebp)
    6d15:	00 00 00 
    6d18:	66 c7 85 74 e6 ff ff 	movw   $0x3131,-0x198c(%ebp)
    6d1f:	31 31 
    6d21:	c6 85 76 e6 ff ff 00 	movb   $0x0,-0x198a(%ebp)
    6d28:	c7 85 78 e6 ff ff 08 	movl   $0x8,-0x1988(%ebp)
    6d2f:	00 00 00 
    6d32:	c7 85 7c e6 ff ff 08 	movl   $0x8,-0x1984(%ebp)
    6d39:	00 00 00 
    6d3c:	c7 85 80 e6 ff ff 00 	movl   $0x0,-0x1980(%ebp)
    6d43:	00 00 00 
    6d46:	c7 85 84 e6 ff ff 00 	movl   $0x0,-0x197c(%ebp)
    6d4d:	00 00 00 
    6d50:	c7 85 88 e6 ff ff ff 	movl   $0xffffffff,-0x1978(%ebp)
    6d57:	ff ff ff 
    6d5a:	c7 85 8c e6 ff ff 00 	movl   $0x0,-0x1974(%ebp)
    6d61:	00 00 00 
    6d64:	c7 85 90 e6 ff ff 00 	movl   $0x0,-0x1970(%ebp)
    6d6b:	00 00 00 
    6d6e:	8d 85 80 fb ff ff    	lea    -0x480(%ebp),%eax
    6d74:	89 85 94 e6 ff ff    	mov    %eax,-0x196c(%ebp)
    6d7a:	c7 85 98 e6 ff ff 7f 	movl   $0x7f,-0x1968(%ebp)
    6d81:	00 00 00 
    6d84:	66 c7 85 9c e6 ff ff 	movw   $0x3231,-0x1964(%ebp)
    6d8b:	31 32 
    6d8d:	c6 85 9e e6 ff ff 00 	movb   $0x0,-0x1962(%ebp)
    6d94:	c7 85 a0 e6 ff ff 08 	movl   $0x8,-0x1960(%ebp)
    6d9b:	00 00 00 
    6d9e:	c7 85 a4 e6 ff ff 08 	movl   $0x8,-0x195c(%ebp)
    6da5:	00 00 00 
    6da8:	c7 85 a8 e6 ff ff 00 	movl   $0x0,-0x1958(%ebp)
    6daf:	00 00 00 
    6db2:	c7 85 ac e6 ff ff 00 	movl   $0x0,-0x1954(%ebp)
    6db9:	00 00 00 
    6dbc:	c7 85 b0 e6 ff ff ff 	movl   $0xffffffff,-0x1950(%ebp)
    6dc3:	ff ff ff 
    6dc6:	c7 85 b4 e6 ff ff 00 	movl   $0x0,-0x194c(%ebp)
    6dcd:	00 00 00 
    6dd0:	c7 85 b8 e6 ff ff 00 	movl   $0x0,-0x1948(%ebp)
    6dd7:	00 00 00 
    6dda:	8d 85 82 fa ff ff    	lea    -0x57e(%ebp),%eax
    6de0:	89 85 bc e6 ff ff    	mov    %eax,-0x1944(%ebp)
    6de6:	c7 85 c0 e6 ff ff 7f 	movl   $0x7f,-0x1940(%ebp)
    6ded:	00 00 00 
    6df0:	66 c7 85 c4 e6 ff ff 	movw   $0x3331,-0x193c(%ebp)
    6df7:	31 33 
    6df9:	c6 85 c6 e6 ff ff 00 	movb   $0x0,-0x193a(%ebp)
    6e00:	c7 85 c8 e6 ff ff 10 	movl   $0x10,-0x1938(%ebp)
    6e07:	00 00 00 
    6e0a:	c7 85 cc e6 ff ff 10 	movl   $0x10,-0x1934(%ebp)
    6e11:	00 00 00 
    6e14:	c7 85 d0 e6 ff ff 00 	movl   $0x0,-0x1930(%ebp)
    6e1b:	00 00 00 
    6e1e:	c7 85 d4 e6 ff ff 00 	movl   $0x0,-0x192c(%ebp)
    6e25:	00 00 00 
    6e28:	c7 85 d8 e6 ff ff ff 	movl   $0xffffffff,-0x1928(%ebp)
    6e2f:	ff ff ff 
    6e32:	c7 85 dc e6 ff ff 00 	movl   $0x0,-0x1924(%ebp)
    6e39:	00 00 00 
    6e3c:	c7 85 e0 e6 ff ff 00 	movl   $0x0,-0x1920(%ebp)
    6e43:	00 00 00 
    6e46:	8d 85 84 f6 ff ff    	lea    -0x97c(%ebp),%eax
    6e4c:	89 85 e4 e6 ff ff    	mov    %eax,-0x191c(%ebp)
    6e52:	c7 85 e8 e6 ff ff ff 	movl   $0x1ff,-0x1918(%ebp)
    6e59:	01 00 00 
    6e5c:	66 c7 85 ec e6 ff ff 	movw   $0x3431,-0x1914(%ebp)
    6e63:	31 34 
    6e65:	c6 85 ee e6 ff ff 00 	movb   $0x0,-0x1912(%ebp)
    6e6c:	c7 85 f0 e6 ff ff 00 	movl   $0x0,-0x1910(%ebp)
    6e73:	00 00 00 
    6e76:	c7 85 f4 e6 ff ff 00 	movl   $0x0,-0x190c(%ebp)
    6e7d:	00 00 00 
    6e80:	c7 85 f8 e6 ff ff 00 	movl   $0x0,-0x1908(%ebp)
    6e87:	00 00 00 
    6e8a:	c7 85 fc e6 ff ff 00 	movl   $0x0,-0x1904(%ebp)
    6e91:	00 00 00 
    6e94:	c7 85 00 e7 ff ff ff 	movl   $0xffffffff,-0x1900(%ebp)
    6e9b:	ff ff ff 
    6e9e:	c7 85 04 e7 ff ff 00 	movl   $0x0,-0x18fc(%ebp)
    6ea5:	00 00 00 
    6ea8:	c7 85 08 e7 ff ff 00 	movl   $0x0,-0x18f8(%ebp)
    6eaf:	00 00 00 
    6eb2:	c7 85 0c e7 ff ff 00 	movl   $0x0,-0x18f4(%ebp)
    6eb9:	00 00 00 
    6ebc:	c7 85 10 e7 ff ff 00 	movl   $0x0,-0x18f0(%ebp)
    6ec3:	00 00 00 
    6ec6:	66 c7 85 14 e7 ff ff 	movw   $0x3531,-0x18ec(%ebp)
    6ecd:	31 35 
    6ecf:	c6 85 16 e7 ff ff 00 	movb   $0x0,-0x18ea(%ebp)
    6ed6:	c7 85 18 e7 ff ff 10 	movl   $0x10,-0x18e8(%ebp)
    6edd:	00 00 00 
    6ee0:	c7 85 1c e7 ff ff 10 	movl   $0x10,-0x18e4(%ebp)
    6ee7:	00 00 00 
    6eea:	c7 85 20 e7 ff ff 00 	movl   $0x0,-0x18e0(%ebp)
    6ef1:	00 00 00 
    6ef4:	c7 85 24 e7 ff ff 00 	movl   $0x0,-0x18dc(%ebp)
    6efb:	00 00 00 
    6efe:	c7 85 28 e7 ff ff ff 	movl   $0xffffffff,-0x18d8(%ebp)
    6f05:	ff ff ff 
    6f08:	c7 85 2c e7 ff ff 00 	movl   $0x0,-0x18d4(%ebp)
    6f0f:	00 00 00 
    6f12:	c7 85 30 e7 ff ff 00 	movl   $0x0,-0x18d0(%ebp)
    6f19:	00 00 00 
    6f1c:	8d 85 86 f2 ff ff    	lea    -0xd7a(%ebp),%eax
    6f22:	89 85 34 e7 ff ff    	mov    %eax,-0x18cc(%ebp)
    6f28:	c7 85 38 e7 ff ff ff 	movl   $0x1ff,-0x18c8(%ebp)
    6f2f:	01 00 00 
    6f32:	66 c7 85 3c e7 ff ff 	movw   $0x3631,-0x18c4(%ebp)
    6f39:	31 36 
    6f3b:	c6 85 3e e7 ff ff 00 	movb   $0x0,-0x18c2(%ebp)
    6f42:	c7 85 40 e7 ff ff 10 	movl   $0x10,-0x18c0(%ebp)
    6f49:	00 00 00 
    6f4c:	c7 85 44 e7 ff ff 10 	movl   $0x10,-0x18bc(%ebp)
    6f53:	00 00 00 
    6f56:	c7 85 48 e7 ff ff 01 	movl   $0x1,-0x18b8(%ebp)
    6f5d:	00 00 00 
    6f60:	c7 85 4c e7 ff ff 01 	movl   $0x1,-0x18b4(%ebp)
    6f67:	00 00 00 
    6f6a:	c7 85 50 e7 ff ff ff 	movl   $0xffffffff,-0x18b0(%ebp)
    6f71:	ff ff ff 
    6f74:	c7 85 54 e7 ff ff 00 	movl   $0x0,-0x18ac(%ebp)
    6f7b:	00 00 00 
    6f7e:	c7 85 58 e7 ff ff 00 	movl   $0x0,-0x18a8(%ebp)
    6f85:	00 00 00 
    6f88:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6f8e:	89 85 5c e7 ff ff    	mov    %eax,-0x18a4(%ebp)
    6f94:	c7 85 60 e7 ff ff ff 	movl   $0x1ff,-0x18a0(%ebp)
    6f9b:	01 00 00 
    6f9e:	66 c7 85 64 e7 ff ff 	movw   $0x3731,-0x189c(%ebp)
    6fa5:	31 37 
    6fa7:	c6 85 66 e7 ff ff 00 	movb   $0x0,-0x189a(%ebp)
    6fae:	c7 85 68 e7 ff ff 10 	movl   $0x10,-0x1898(%ebp)
    6fb5:	00 00 00 
    6fb8:	c7 85 6c e7 ff ff 10 	movl   $0x10,-0x1894(%ebp)
    6fbf:	00 00 00 
    6fc2:	c7 85 70 e7 ff ff 02 	movl   $0x2,-0x1890(%ebp)
    6fc9:	00 00 00 
    6fcc:	c7 85 74 e7 ff ff 03 	movl   $0x3,-0x188c(%ebp)
    6fd3:	00 00 00 
    6fd6:	c7 85 78 e7 ff ff 10 	movl   $0x10,-0x1888(%ebp)
    6fdd:	00 00 00 
    6fe0:	c7 85 7c e7 ff ff 00 	movl   $0x0,-0x1884(%ebp)
    6fe7:	00 00 00 
    6fea:	c7 85 80 e7 ff ff 00 	movl   $0x0,-0x1880(%ebp)
    6ff1:	00 00 00 
    6ff4:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6ffa:	89 85 84 e7 ff ff    	mov    %eax,-0x187c(%ebp)
    7000:	c7 85 88 e7 ff ff ff 	movl   $0x1ff,-0x1878(%ebp)
    7007:	01 00 00 
    700a:	66 c7 85 8c e7 ff ff 	movw   $0x3831,-0x1874(%ebp)
    7011:	31 38 
    7013:	c6 85 8e e7 ff ff 00 	movb   $0x0,-0x1872(%ebp)
    701a:	c7 85 90 e7 ff ff 10 	movl   $0x10,-0x1870(%ebp)
    7021:	00 00 00 
    7024:	c7 85 94 e7 ff ff 10 	movl   $0x10,-0x186c(%ebp)
    702b:	00 00 00 
    702e:	c7 85 98 e7 ff ff 03 	movl   $0x3,-0x1868(%ebp)
    7035:	00 00 00 
    7038:	c7 85 9c e7 ff ff 07 	movl   $0x7,-0x1864(%ebp)
    703f:	00 00 00 
    7042:	c7 85 a0 e7 ff ff 10 	movl   $0x10,-0x1860(%ebp)
    7049:	00 00 00 
    704c:	c7 85 a4 e7 ff ff 00 	movl   $0x0,-0x185c(%ebp)
    7053:	00 00 00 
    7056:	c7 85 a8 e7 ff ff 00 	movl   $0x0,-0x1858(%ebp)
    705d:	00 00 00 
    7060:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    7066:	89 85 ac e7 ff ff    	mov    %eax,-0x1854(%ebp)
    706c:	c7 85 b0 e7 ff ff ff 	movl   $0x1ff,-0x1850(%ebp)
    7073:	01 00 00 
    7076:	66 c7 85 b4 e7 ff ff 	movw   $0x3931,-0x184c(%ebp)
    707d:	31 39 
    707f:	c6 85 b6 e7 ff ff 00 	movb   $0x0,-0x184a(%ebp)
    7086:	c7 85 b8 e7 ff ff 10 	movl   $0x10,-0x1848(%ebp)
    708d:	00 00 00 
    7090:	c7 85 bc e7 ff ff 10 	movl   $0x10,-0x1844(%ebp)
    7097:	00 00 00 
    709a:	c7 85 c0 e7 ff ff 04 	movl   $0x4,-0x1840(%ebp)
    70a1:	00 00 00 
    70a4:	c7 85 c4 e7 ff ff 0f 	movl   $0xf,-0x183c(%ebp)
    70ab:	00 00 00 
    70ae:	c7 85 c8 e7 ff ff 10 	movl   $0x10,-0x1838(%ebp)
    70b5:	00 00 00 
    70b8:	c7 85 cc e7 ff ff 00 	movl   $0x0,-0x1834(%ebp)
    70bf:	00 00 00 
    70c2:	c7 85 d0 e7 ff ff 00 	movl   $0x0,-0x1830(%ebp)
    70c9:	00 00 00 
    70cc:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    70d2:	89 85 d4 e7 ff ff    	mov    %eax,-0x182c(%ebp)
    70d8:	c7 85 d8 e7 ff ff ff 	movl   $0x1ff,-0x1828(%ebp)
    70df:	01 00 00 
    70e2:	66 c7 85 dc e7 ff ff 	movw   $0x3032,-0x1824(%ebp)
    70e9:	32 30 
    70eb:	c6 85 de e7 ff ff 00 	movb   $0x0,-0x1822(%ebp)
    70f2:	c7 85 e0 e7 ff ff 10 	movl   $0x10,-0x1820(%ebp)
    70f9:	00 00 00 
    70fc:	c7 85 e4 e7 ff ff 10 	movl   $0x10,-0x181c(%ebp)
    7103:	00 00 00 
    7106:	c7 85 e8 e7 ff ff 06 	movl   $0x6,-0x1818(%ebp)
    710d:	00 00 00 
    7110:	c7 85 ec e7 ff ff 3f 	movl   $0x3f,-0x1814(%ebp)
    7117:	00 00 00 
    711a:	c7 85 f0 e7 ff ff 10 	movl   $0x10,-0x1810(%ebp)
    7121:	00 00 00 
    7124:	c7 85 f4 e7 ff ff 00 	movl   $0x0,-0x180c(%ebp)
    712b:	00 00 00 
    712e:	c7 85 f8 e7 ff ff 00 	movl   $0x0,-0x1808(%ebp)
    7135:	00 00 00 
    7138:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    713e:	89 85 fc e7 ff ff    	mov    %eax,-0x1804(%ebp)
    7144:	c7 85 00 e8 ff ff ff 	movl   $0x1ff,-0x1800(%ebp)
    714b:	01 00 00 
    714e:	66 c7 85 04 e8 ff ff 	movw   $0x3132,-0x17fc(%ebp)
    7155:	32 31 
    7157:	c6 85 06 e8 ff ff 00 	movb   $0x0,-0x17fa(%ebp)
    715e:	c7 85 08 e8 ff ff 10 	movl   $0x10,-0x17f8(%ebp)
    7165:	00 00 00 
    7168:	c7 85 0c e8 ff ff 10 	movl   $0x10,-0x17f4(%ebp)
    716f:	00 00 00 
    7172:	c7 85 10 e8 ff ff 08 	movl   $0x8,-0x17f0(%ebp)
    7179:	00 00 00 
    717c:	c7 85 14 e8 ff ff ff 	movl   $0xff,-0x17ec(%ebp)
    7183:	00 00 00 
    7186:	c7 85 18 e8 ff ff 10 	movl   $0x10,-0x17e8(%ebp)
    718d:	00 00 00 
    7190:	c7 85 1c e8 ff ff 00 	movl   $0x0,-0x17e4(%ebp)
    7197:	00 00 00 
    719a:	c7 85 20 e8 ff ff 00 	movl   $0x0,-0x17e0(%ebp)
    71a1:	00 00 00 
    71a4:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    71aa:	89 85 24 e8 ff ff    	mov    %eax,-0x17dc(%ebp)
    71b0:	c7 85 28 e8 ff ff ff 	movl   $0x1ff,-0x17d8(%ebp)
    71b7:	01 00 00 
    71ba:	66 c7 85 2c e8 ff ff 	movw   $0x3232,-0x17d4(%ebp)
    71c1:	32 32 
    71c3:	c6 85 2e e8 ff ff 00 	movb   $0x0,-0x17d2(%ebp)
    71ca:	c7 85 30 e8 ff ff 10 	movl   $0x10,-0x17d0(%ebp)
    71d1:	00 00 00 
    71d4:	c7 85 34 e8 ff ff 10 	movl   $0x10,-0x17cc(%ebp)
    71db:	00 00 00 
    71de:	c7 85 38 e8 ff ff 0a 	movl   $0xa,-0x17c8(%ebp)
    71e5:	00 00 00 
    71e8:	c7 85 3c e8 ff ff ff 	movl   $0x3ff,-0x17c4(%ebp)
    71ef:	03 00 00 
    71f2:	c7 85 40 e8 ff ff 10 	movl   $0x10,-0x17c0(%ebp)
    71f9:	00 00 00 
    71fc:	c7 85 44 e8 ff ff 00 	movl   $0x0,-0x17bc(%ebp)
    7203:	00 00 00 
    7206:	c7 85 48 e8 ff ff 00 	movl   $0x0,-0x17b8(%ebp)
    720d:	00 00 00 
    7210:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    7216:	89 85 4c e8 ff ff    	mov    %eax,-0x17b4(%ebp)
    721c:	c7 85 50 e8 ff ff ff 	movl   $0x1ff,-0x17b0(%ebp)
    7223:	01 00 00 
    7226:	66 c7 85 54 e8 ff ff 	movw   $0x3332,-0x17ac(%ebp)
    722d:	32 33 
    722f:	c6 85 56 e8 ff ff 00 	movb   $0x0,-0x17aa(%ebp)
    7236:	c7 85 58 e8 ff ff 10 	movl   $0x10,-0x17a8(%ebp)
    723d:	00 00 00 
    7240:	c7 85 5c e8 ff ff 10 	movl   $0x10,-0x17a4(%ebp)
    7247:	00 00 00 
    724a:	c7 85 60 e8 ff ff 0d 	movl   $0xd,-0x17a0(%ebp)
    7251:	00 00 00 
    7254:	c7 85 64 e8 ff ff ff 	movl   $0x1fff,-0x179c(%ebp)
    725b:	1f 00 00 
    725e:	c7 85 68 e8 ff ff 10 	movl   $0x10,-0x1798(%ebp)
    7265:	00 00 00 
    7268:	c7 85 6c e8 ff ff 00 	movl   $0x0,-0x1794(%ebp)
    726f:	00 00 00 
    7272:	c7 85 70 e8 ff ff 00 	movl   $0x0,-0x1790(%ebp)
    7279:	00 00 00 
    727c:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    7282:	89 85 74 e8 ff ff    	mov    %eax,-0x178c(%ebp)
    7288:	c7 85 78 e8 ff ff ff 	movl   $0x1ff,-0x1788(%ebp)
    728f:	01 00 00 
    7292:	66 c7 85 7c e8 ff ff 	movw   $0x3432,-0x1784(%ebp)
    7299:	32 34 
    729b:	c6 85 7e e8 ff ff 00 	movb   $0x0,-0x1782(%ebp)
    72a2:	c7 85 80 e8 ff ff 10 	movl   $0x10,-0x1780(%ebp)
    72a9:	00 00 00 
    72ac:	c7 85 84 e8 ff ff 10 	movl   $0x10,-0x177c(%ebp)
    72b3:	00 00 00 
    72b6:	c7 85 88 e8 ff ff 04 	movl   $0x4,-0x1778(%ebp)
    72bd:	00 00 00 
    72c0:	c7 85 8c e8 ff ff 0f 	movl   $0xf,-0x1774(%ebp)
    72c7:	00 00 00 
    72ca:	c7 85 90 e8 ff ff ff 	movl   $0xffffffff,-0x1770(%ebp)
    72d1:	ff ff ff 
    72d4:	c7 85 94 e8 ff ff 00 	movl   $0x0,-0x176c(%ebp)
    72db:	00 00 00 
    72de:	c7 85 98 e8 ff ff 00 	movl   $0x0,-0x1768(%ebp)
    72e5:	00 00 00 
    72e8:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    72ee:	89 85 9c e8 ff ff    	mov    %eax,-0x1764(%ebp)
    72f4:	c7 85 a0 e8 ff ff 00 	movl   $0x200,-0x1760(%ebp)
    72fb:	02 00 00 
    72fe:	66 c7 85 a4 e8 ff ff 	movw   $0x3532,-0x175c(%ebp)
    7305:	32 35 
    7307:	c6 85 a6 e8 ff ff 00 	movb   $0x0,-0x175a(%ebp)
    730e:	c7 85 a8 e8 ff ff 10 	movl   $0x10,-0x1758(%ebp)
    7315:	00 00 00 
    7318:	c7 85 ac e8 ff ff 10 	movl   $0x10,-0x1754(%ebp)
    731f:	00 00 00 
    7322:	c7 85 b0 e8 ff ff 05 	movl   $0x5,-0x1750(%ebp)
    7329:	00 00 00 
    732c:	c7 85 b4 e8 ff ff 1f 	movl   $0x1f,-0x174c(%ebp)
    7333:	00 00 00 
    7336:	c7 85 b8 e8 ff ff 18 	movl   $0x18,-0x1748(%ebp)
    733d:	00 00 00 
    7340:	c7 85 bc e8 ff ff 00 	movl   $0x0,-0x1744(%ebp)
    7347:	00 00 00 
    734a:	c7 85 c0 e8 ff ff 00 	movl   $0x0,-0x1740(%ebp)
    7351:	00 00 00 
    7354:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    735a:	89 85 c4 e8 ff ff    	mov    %eax,-0x173c(%ebp)
    7360:	c7 85 c8 e8 ff ff 00 	movl   $0x200,-0x1738(%ebp)
    7367:	02 00 00 
    736a:	66 c7 85 cc e8 ff ff 	movw   $0x3632,-0x1734(%ebp)
    7371:	32 36 
    7373:	c6 85 ce e8 ff ff 00 	movb   $0x0,-0x1732(%ebp)
    737a:	c7 85 d0 e8 ff ff 10 	movl   $0x10,-0x1730(%ebp)
    7381:	00 00 00 
    7384:	c7 85 d4 e8 ff ff 10 	movl   $0x10,-0x172c(%ebp)
    738b:	00 00 00 
    738e:	c7 85 d8 e8 ff ff 06 	movl   $0x6,-0x1728(%ebp)
    7395:	00 00 00 
    7398:	c7 85 dc e8 ff ff 3f 	movl   $0x3f,-0x1724(%ebp)
    739f:	00 00 00 
    73a2:	c7 85 e0 e8 ff ff 18 	movl   $0x18,-0x1720(%ebp)
    73a9:	00 00 00 
    73ac:	c7 85 e4 e8 ff ff 00 	movl   $0x0,-0x171c(%ebp)
    73b3:	00 00 00 
    73b6:	c7 85 e8 e8 ff ff 00 	movl   $0x0,-0x1718(%ebp)
    73bd:	00 00 00 
    73c0:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    73c6:	89 85 ec e8 ff ff    	mov    %eax,-0x1714(%ebp)
    73cc:	c7 85 f0 e8 ff ff 00 	movl   $0x200,-0x1710(%ebp)
    73d3:	02 00 00 
    73d6:	66 c7 85 f4 e8 ff ff 	movw   $0x3732,-0x170c(%ebp)
    73dd:	32 37 
    73df:	c6 85 f6 e8 ff ff 00 	movb   $0x0,-0x170a(%ebp)
    73e6:	c7 85 f8 e8 ff ff 10 	movl   $0x10,-0x1708(%ebp)
    73ed:	00 00 00 
    73f0:	c7 85 fc e8 ff ff 10 	movl   $0x10,-0x1704(%ebp)
    73f7:	00 00 00 
    73fa:	c7 85 00 e9 ff ff 07 	movl   $0x7,-0x1700(%ebp)
    7401:	00 00 00 
    7404:	c7 85 04 e9 ff ff 7f 	movl   $0x7f,-0x16fc(%ebp)
    740b:	00 00 00 
    740e:	c7 85 08 e9 ff ff 18 	movl   $0x18,-0x16f8(%ebp)
    7415:	00 00 00 
    7418:	c7 85 0c e9 ff ff 00 	movl   $0x0,-0x16f4(%ebp)
    741f:	00 00 00 
    7422:	c7 85 10 e9 ff ff 00 	movl   $0x0,-0x16f0(%ebp)
    7429:	00 00 00 
    742c:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    7432:	89 85 14 e9 ff ff    	mov    %eax,-0x16ec(%ebp)
    7438:	c7 85 18 e9 ff ff 00 	movl   $0x200,-0x16e8(%ebp)
    743f:	02 00 00 
    7442:	66 c7 85 1c e9 ff ff 	movw   $0x3832,-0x16e4(%ebp)
    7449:	32 38 
    744b:	c6 85 1e e9 ff ff 00 	movb   $0x0,-0x16e2(%ebp)
    7452:	c7 85 20 e9 ff ff 10 	movl   $0x10,-0x16e0(%ebp)
    7459:	00 00 00 
    745c:	c7 85 24 e9 ff ff 10 	movl   $0x10,-0x16dc(%ebp)
    7463:	00 00 00 
    7466:	c7 85 28 e9 ff ff 08 	movl   $0x8,-0x16d8(%ebp)
    746d:	00 00 00 
    7470:	c7 85 2c e9 ff ff ff 	movl   $0xff,-0x16d4(%ebp)
    7477:	00 00 00 
    747a:	c7 85 30 e9 ff ff 18 	movl   $0x18,-0x16d0(%ebp)
    7481:	00 00 00 
    7484:	c7 85 34 e9 ff ff 00 	movl   $0x0,-0x16cc(%ebp)
    748b:	00 00 00 
    748e:	c7 85 38 e9 ff ff 00 	movl   $0x0,-0x16c8(%ebp)
    7495:	00 00 00 
    7498:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    749e:	89 85 3c e9 ff ff    	mov    %eax,-0x16c4(%ebp)
    74a4:	c7 85 40 e9 ff ff 00 	movl   $0x200,-0x16c0(%ebp)
    74ab:	02 00 00 
    74ae:	66 c7 85 44 e9 ff ff 	movw   $0x3932,-0x16bc(%ebp)
    74b5:	32 39 
    74b7:	c6 85 46 e9 ff ff 00 	movb   $0x0,-0x16ba(%ebp)
    74be:	c7 85 48 e9 ff ff 10 	movl   $0x10,-0x16b8(%ebp)
    74c5:	00 00 00 
    74c8:	c7 85 4c e9 ff ff 10 	movl   $0x10,-0x16b4(%ebp)
    74cf:	00 00 00 
    74d2:	c7 85 50 e9 ff ff 09 	movl   $0x9,-0x16b0(%ebp)
    74d9:	00 00 00 
    74dc:	c7 85 54 e9 ff ff ff 	movl   $0x1ff,-0x16ac(%ebp)
    74e3:	01 00 00 
    74e6:	c7 85 58 e9 ff ff 18 	movl   $0x18,-0x16a8(%ebp)
    74ed:	00 00 00 
    74f0:	c7 85 5c e9 ff ff 00 	movl   $0x0,-0x16a4(%ebp)
    74f7:	00 00 00 
    74fa:	c7 85 60 e9 ff ff 00 	movl   $0x0,-0x16a0(%ebp)
    7501:	00 00 00 
    7504:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    750a:	89 85 64 e9 ff ff    	mov    %eax,-0x169c(%ebp)
    7510:	c7 85 68 e9 ff ff 00 	movl   $0x200,-0x1698(%ebp)
    7517:	02 00 00 
    751a:	66 c7 85 6c e9 ff ff 	movw   $0x3033,-0x1694(%ebp)
    7521:	33 30 
    7523:	c6 85 6e e9 ff ff 00 	movb   $0x0,-0x1692(%ebp)
    752a:	c7 85 70 e9 ff ff 10 	movl   $0x10,-0x1690(%ebp)
    7531:	00 00 00 
    7534:	c7 85 74 e9 ff ff 10 	movl   $0x10,-0x168c(%ebp)
    753b:	00 00 00 
    753e:	c7 85 78 e9 ff ff 0b 	movl   $0xb,-0x1688(%ebp)
    7545:	00 00 00 
    7548:	c7 85 7c e9 ff ff ff 	movl   $0x7ff,-0x1684(%ebp)
    754f:	07 00 00 
    7552:	c7 85 80 e9 ff ff 18 	movl   $0x18,-0x1680(%ebp)
    7559:	00 00 00 
    755c:	c7 85 84 e9 ff ff 00 	movl   $0x0,-0x167c(%ebp)
    7563:	00 00 00 
    7566:	c7 85 88 e9 ff ff 00 	movl   $0x0,-0x1678(%ebp)
    756d:	00 00 00 
    7570:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    7576:	89 85 8c e9 ff ff    	mov    %eax,-0x1674(%ebp)
    757c:	c7 85 90 e9 ff ff 00 	movl   $0x200,-0x1670(%ebp)
    7583:	02 00 00 
    7586:	66 c7 85 94 e9 ff ff 	movw   $0x3133,-0x166c(%ebp)
    758d:	33 31 
    758f:	c6 85 96 e9 ff ff 00 	movb   $0x0,-0x166a(%ebp)
    7596:	c7 85 98 e9 ff ff 10 	movl   $0x10,-0x1668(%ebp)
    759d:	00 00 00 
    75a0:	c7 85 9c e9 ff ff 10 	movl   $0x10,-0x1664(%ebp)
    75a7:	00 00 00 
    75aa:	c7 85 a0 e9 ff ff 0d 	movl   $0xd,-0x1660(%ebp)
    75b1:	00 00 00 
    75b4:	c7 85 a4 e9 ff ff ff 	movl   $0x1fff,-0x165c(%ebp)
    75bb:	1f 00 00 
    75be:	c7 85 a8 e9 ff ff 18 	movl   $0x18,-0x1658(%ebp)
    75c5:	00 00 00 
    75c8:	c7 85 ac e9 ff ff 00 	movl   $0x0,-0x1654(%ebp)
    75cf:	00 00 00 
    75d2:	c7 85 b0 e9 ff ff 00 	movl   $0x0,-0x1650(%ebp)
    75d9:	00 00 00 
    75dc:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    75e2:	89 85 b4 e9 ff ff    	mov    %eax,-0x164c(%ebp)
    75e8:	c7 85 b8 e9 ff ff 00 	movl   $0x200,-0x1648(%ebp)
    75ef:	02 00 00 
    75f2:	66 c7 85 bc e9 ff ff 	movw   $0x3233,-0x1644(%ebp)
    75f9:	33 32 
    75fb:	c6 85 be e9 ff ff 00 	movb   $0x0,-0x1642(%ebp)
    7602:	c7 85 c0 e9 ff ff 01 	movl   $0x1,-0x1640(%ebp)
    7609:	00 00 00 
    760c:	c7 85 c4 e9 ff ff 10 	movl   $0x10,-0x163c(%ebp)
    7613:	00 00 00 
    7616:	c7 85 c8 e9 ff ff 00 	movl   $0x0,-0x1638(%ebp)
    761d:	00 00 00 
    7620:	c7 85 cc e9 ff ff 00 	movl   $0x0,-0x1634(%ebp)
    7627:	00 00 00 
    762a:	c7 85 d0 e9 ff ff ff 	movl   $0xffffffff,-0x1630(%ebp)
    7631:	ff ff ff 
    7634:	c7 85 d4 e9 ff ff 00 	movl   $0x0,-0x162c(%ebp)
    763b:	00 00 00 
    763e:	c7 85 d8 e9 ff ff 00 	movl   $0x0,-0x1628(%ebp)
    7645:	00 00 00 
    7648:	8d 85 4a ea ff ff    	lea    -0x15b6(%ebp),%eax
    764e:	89 85 dc e9 ff ff    	mov    %eax,-0x1624(%ebp)
    7654:	c7 85 e0 e9 ff ff 1f 	movl   $0x1f,-0x1620(%ebp)
    765b:	00 00 00 
    765e:	66 c7 85 e4 e9 ff ff 	movw   $0x3333,-0x161c(%ebp)
    7665:	33 33 
    7667:	c6 85 e6 e9 ff ff 00 	movb   $0x0,-0x161a(%ebp)
    766e:	c7 85 e8 e9 ff ff 01 	movl   $0x1,-0x1618(%ebp)
    7675:	00 00 00 
    7678:	c7 85 ec e9 ff ff 10 	movl   $0x10,-0x1614(%ebp)
    767f:	00 00 00 
    7682:	c7 85 f0 e9 ff ff 00 	movl   $0x0,-0x1610(%ebp)
    7689:	00 00 00 
    768c:	c7 85 f4 e9 ff ff 00 	movl   $0x0,-0x160c(%ebp)
    7693:	00 00 00 
    7696:	c7 85 f8 e9 ff ff ff 	movl   $0xffffffff,-0x1608(%ebp)
    769d:	ff ff ff 
    76a0:	c7 85 fc e9 ff ff 00 	movl   $0x0,-0x1604(%ebp)
    76a7:	00 00 00 
    76aa:	c7 85 00 ea ff ff 00 	movl   $0x0,-0x1600(%ebp)
    76b1:	00 00 00 
    76b4:	8d 85 0c ea ff ff    	lea    -0x15f4(%ebp),%eax
    76ba:	89 85 04 ea ff ff    	mov    %eax,-0x15fc(%ebp)
    76c0:	c7 85 08 ea ff ff 1f 	movl   $0x1f,-0x15f8(%ebp)
    76c7:	00 00 00 
		{"31", 16, 16, 13, 8191, 24, 0, 0, h24, 512},
		{"32", 1, 16, 0, 0, -1, 0, 0, hA, 31},
		{"33", 1, 16, 0, 0, -1, 0, 0, hB, 31}
	};
	ht[0] = ht[0];
}
    76ca:	81 c4 40 1b 00 00    	add    $0x1b40,%esp
    76d0:	5b                   	pop    %ebx
    76d1:	5e                   	pop    %esi
    76d2:	5f                   	pop    %edi
    76d3:	5d                   	pop    %ebp
    76d4:	c3                   	ret    

000076d5 <huffman_decoder>:


/* ����huffman����	*/
/* ע��! ��counta,countb - 4 bit ֵ �� y����, discard x */
int huffman_decoder(struct huffcodetab *h, int *x, int *y, int *v, int *w)
{  
    76d5:	55                   	push   %ebp
    76d6:	89 e5                	mov    %esp,%ebp
    76d8:	53                   	push   %ebx
    76d9:	83 ec 24             	sub    $0x24,%esp
  HUFFBITS level;
  int point = 0;
    76dc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int error = 1;
    76e3:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
  level     = dmask;
    76ea:	a1 f0 f3 00 00       	mov    0xf3f0,%eax
    76ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (h->val == 0) return 2;
    76f2:	8b 45 08             	mov    0x8(%ebp),%eax
    76f5:	8b 40 20             	mov    0x20(%eax),%eax
    76f8:	85 c0                	test   %eax,%eax
    76fa:	75 0a                	jne    7706 <huffman_decoder+0x31>
    76fc:	b8 02 00 00 00       	mov    $0x2,%eax
    7701:	e9 0d 03 00 00       	jmp    7a13 <huffman_decoder+0x33e>

  /* table 0 ����Ҫ bits */
  if ( h->treelen == 0)
    7706:	8b 45 08             	mov    0x8(%ebp),%eax
    7709:	8b 40 24             	mov    0x24(%eax),%eax
    770c:	85 c0                	test   %eax,%eax
    770e:	75 1d                	jne    772d <huffman_decoder+0x58>
  {  *x = *y = 0;
    7710:	8b 45 10             	mov    0x10(%ebp),%eax
    7713:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    7719:	8b 45 10             	mov    0x10(%ebp),%eax
    771c:	8b 10                	mov    (%eax),%edx
    771e:	8b 45 0c             	mov    0xc(%ebp),%eax
    7721:	89 10                	mov    %edx,(%eax)
     return 0;
    7723:	b8 00 00 00 00       	mov    $0x0,%eax
    7728:	e9 e6 02 00 00       	jmp    7a13 <huffman_decoder+0x33e>


  /* ���� Huffman table. */

  do {
    if (h->val[point][0]==0) {   /*���Ľ�β*/
    772d:	8b 45 08             	mov    0x8(%ebp),%eax
    7730:	8b 40 20             	mov    0x20(%eax),%eax
    7733:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7736:	01 d2                	add    %edx,%edx
    7738:	01 d0                	add    %edx,%eax
    773a:	0f b6 00             	movzbl (%eax),%eax
    773d:	84 c0                	test   %al,%al
    773f:	75 46                	jne    7787 <huffman_decoder+0xb2>
      *x = h->val[point][1] >> 4;
    7741:	8b 45 08             	mov    0x8(%ebp),%eax
    7744:	8b 40 20             	mov    0x20(%eax),%eax
    7747:	8b 55 f0             	mov    -0x10(%ebp),%edx
    774a:	01 d2                	add    %edx,%edx
    774c:	01 d0                	add    %edx,%eax
    774e:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    7752:	c0 e8 04             	shr    $0x4,%al
    7755:	0f b6 d0             	movzbl %al,%edx
    7758:	8b 45 0c             	mov    0xc(%ebp),%eax
    775b:	89 10                	mov    %edx,(%eax)
      *y = h->val[point][1] & 0xf;
    775d:	8b 45 08             	mov    0x8(%ebp),%eax
    7760:	8b 40 20             	mov    0x20(%eax),%eax
    7763:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7766:	01 d2                	add    %edx,%edx
    7768:	01 d0                	add    %edx,%eax
    776a:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    776e:	0f b6 c0             	movzbl %al,%eax
    7771:	83 e0 0f             	and    $0xf,%eax
    7774:	89 c2                	mov    %eax,%edx
    7776:	8b 45 10             	mov    0x10(%ebp),%eax
    7779:	89 10                	mov    %edx,(%eax)

      error = 0;
    777b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
      break;
    7782:	e9 af 00 00 00       	jmp    7836 <huffman_decoder+0x161>
    } 
    if (hget1bit()) {
    7787:	e8 a7 e6 ff ff       	call   5e33 <hget1bit>
    778c:	85 c0                	test   %eax,%eax
    778e:	74 47                	je     77d7 <huffman_decoder+0x102>
      while (h->val[point][1] >= MXOFF) point += h->val[point][1]; 
    7790:	eb 17                	jmp    77a9 <huffman_decoder+0xd4>
    7792:	8b 45 08             	mov    0x8(%ebp),%eax
    7795:	8b 40 20             	mov    0x20(%eax),%eax
    7798:	8b 55 f0             	mov    -0x10(%ebp),%edx
    779b:	01 d2                	add    %edx,%edx
    779d:	01 d0                	add    %edx,%eax
    779f:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    77a3:	0f b6 c0             	movzbl %al,%eax
    77a6:	01 45 f0             	add    %eax,-0x10(%ebp)
    77a9:	8b 45 08             	mov    0x8(%ebp),%eax
    77ac:	8b 40 20             	mov    0x20(%eax),%eax
    77af:	8b 55 f0             	mov    -0x10(%ebp),%edx
    77b2:	01 d2                	add    %edx,%edx
    77b4:	01 d0                	add    %edx,%eax
    77b6:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    77ba:	3c f9                	cmp    $0xf9,%al
    77bc:	77 d4                	ja     7792 <huffman_decoder+0xbd>
      point += h->val[point][1];
    77be:	8b 45 08             	mov    0x8(%ebp),%eax
    77c1:	8b 40 20             	mov    0x20(%eax),%eax
    77c4:	8b 55 f0             	mov    -0x10(%ebp),%edx
    77c7:	01 d2                	add    %edx,%edx
    77c9:	01 d0                	add    %edx,%eax
    77cb:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    77cf:	0f b6 c0             	movzbl %al,%eax
    77d2:	01 45 f0             	add    %eax,-0x10(%ebp)
    77d5:	eb 42                	jmp    7819 <huffman_decoder+0x144>
    }
    else {
      while (h->val[point][0] >= MXOFF) point += h->val[point][0]; 
    77d7:	eb 16                	jmp    77ef <huffman_decoder+0x11a>
    77d9:	8b 45 08             	mov    0x8(%ebp),%eax
    77dc:	8b 40 20             	mov    0x20(%eax),%eax
    77df:	8b 55 f0             	mov    -0x10(%ebp),%edx
    77e2:	01 d2                	add    %edx,%edx
    77e4:	01 d0                	add    %edx,%eax
    77e6:	0f b6 00             	movzbl (%eax),%eax
    77e9:	0f b6 c0             	movzbl %al,%eax
    77ec:	01 45 f0             	add    %eax,-0x10(%ebp)
    77ef:	8b 45 08             	mov    0x8(%ebp),%eax
    77f2:	8b 40 20             	mov    0x20(%eax),%eax
    77f5:	8b 55 f0             	mov    -0x10(%ebp),%edx
    77f8:	01 d2                	add    %edx,%edx
    77fa:	01 d0                	add    %edx,%eax
    77fc:	0f b6 00             	movzbl (%eax),%eax
    77ff:	3c f9                	cmp    $0xf9,%al
    7801:	77 d6                	ja     77d9 <huffman_decoder+0x104>
      point += h->val[point][0];
    7803:	8b 45 08             	mov    0x8(%ebp),%eax
    7806:	8b 40 20             	mov    0x20(%eax),%eax
    7809:	8b 55 f0             	mov    -0x10(%ebp),%edx
    780c:	01 d2                	add    %edx,%edx
    780e:	01 d0                	add    %edx,%eax
    7810:	0f b6 00             	movzbl (%eax),%eax
    7813:	0f b6 c0             	movzbl %al,%eax
    7816:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    level >>= 1;
    7819:	d1 6d f4             	shrl   -0xc(%ebp)
  } while (level  || (point < ht->treelen) );
    781c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    7820:	0f 85 07 ff ff ff    	jne    772d <huffman_decoder+0x58>
    7826:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7829:	a1 64 29 01 00       	mov    0x12964,%eax
    782e:	39 c2                	cmp    %eax,%edx
    7830:	0f 82 f7 fe ff ff    	jb     772d <huffman_decoder+0x58>
  
  /* ������ */
  
  if (error) { /* ���� x �� y Ϊһ�м�ֵ */
    7836:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    783a:	74 24                	je     7860 <huffman_decoder+0x18b>
    //print(0, "Illegal Huffman code in data.\n");
    *x = ((h->xlen-1) << 1);
    783c:	8b 45 08             	mov    0x8(%ebp),%eax
    783f:	8b 40 04             	mov    0x4(%eax),%eax
    7842:	83 e8 01             	sub    $0x1,%eax
    7845:	01 c0                	add    %eax,%eax
    7847:	89 c2                	mov    %eax,%edx
    7849:	8b 45 0c             	mov    0xc(%ebp),%eax
    784c:	89 10                	mov    %edx,(%eax)
    *y = ((h->ylen-1) << 1);
    784e:	8b 45 08             	mov    0x8(%ebp),%eax
    7851:	8b 40 08             	mov    0x8(%eax),%eax
    7854:	83 e8 01             	sub    $0x1,%eax
    7857:	01 c0                	add    %eax,%eax
    7859:	89 c2                	mov    %eax,%edx
    785b:	8b 45 10             	mov    0x10(%ebp),%eax
    785e:	89 10                	mov    %edx,(%eax)
  }

  /* �����źű��� */

  if (h->tablename[0] == '3'
    7860:	8b 45 08             	mov    0x8(%ebp),%eax
    7863:	0f b6 00             	movzbl (%eax),%eax
    7866:	3c 33                	cmp    $0x33,%al
    7868:	0f 85 ec 00 00 00    	jne    795a <huffman_decoder+0x285>
      && (h->tablename[1] == '2' || h->tablename[1] == '3')) {
    786e:	8b 45 08             	mov    0x8(%ebp),%eax
    7871:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    7875:	3c 32                	cmp    $0x32,%al
    7877:	74 0f                	je     7888 <huffman_decoder+0x1b3>
    7879:	8b 45 08             	mov    0x8(%ebp),%eax
    787c:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    7880:	3c 33                	cmp    $0x33,%al
    7882:	0f 85 d2 00 00 00    	jne    795a <huffman_decoder+0x285>
     *v = (*y>>3) & 1;
    7888:	8b 45 10             	mov    0x10(%ebp),%eax
    788b:	8b 00                	mov    (%eax),%eax
    788d:	c1 f8 03             	sar    $0x3,%eax
    7890:	83 e0 01             	and    $0x1,%eax
    7893:	89 c2                	mov    %eax,%edx
    7895:	8b 45 14             	mov    0x14(%ebp),%eax
    7898:	89 10                	mov    %edx,(%eax)
     *w = (*y>>2) & 1;
    789a:	8b 45 10             	mov    0x10(%ebp),%eax
    789d:	8b 00                	mov    (%eax),%eax
    789f:	c1 f8 02             	sar    $0x2,%eax
    78a2:	83 e0 01             	and    $0x1,%eax
    78a5:	89 c2                	mov    %eax,%edx
    78a7:	8b 45 18             	mov    0x18(%ebp),%eax
    78aa:	89 10                	mov    %edx,(%eax)
     *x = (*y>>1) & 1;
    78ac:	8b 45 10             	mov    0x10(%ebp),%eax
    78af:	8b 00                	mov    (%eax),%eax
    78b1:	d1 f8                	sar    %eax
    78b3:	83 e0 01             	and    $0x1,%eax
    78b6:	89 c2                	mov    %eax,%edx
    78b8:	8b 45 0c             	mov    0xc(%ebp),%eax
    78bb:	89 10                	mov    %edx,(%eax)
     *y = *y & 1;
    78bd:	8b 45 10             	mov    0x10(%ebp),%eax
    78c0:	8b 00                	mov    (%eax),%eax
    78c2:	83 e0 01             	and    $0x1,%eax
    78c5:	89 c2                	mov    %eax,%edx
    78c7:	8b 45 10             	mov    0x10(%ebp),%eax
    78ca:	89 10                	mov    %edx,(%eax)
     /* v, w, x �� y �ڱ��������ǵߵ��ģ��������� 
         */
     
/*   {int i=*v; *v=*y; *y=i; i=*w; *w=*x; *x=i;}  MI */

     if (*v)
    78cc:	8b 45 14             	mov    0x14(%ebp),%eax
    78cf:	8b 00                	mov    (%eax),%eax
    78d1:	85 c0                	test   %eax,%eax
    78d3:	74 18                	je     78ed <huffman_decoder+0x218>
        if (hget1bit() == 1) *v = -*v;
    78d5:	e8 59 e5 ff ff       	call   5e33 <hget1bit>
    78da:	83 f8 01             	cmp    $0x1,%eax
    78dd:	75 0e                	jne    78ed <huffman_decoder+0x218>
    78df:	8b 45 14             	mov    0x14(%ebp),%eax
    78e2:	8b 00                	mov    (%eax),%eax
    78e4:	f7 d8                	neg    %eax
    78e6:	89 c2                	mov    %eax,%edx
    78e8:	8b 45 14             	mov    0x14(%ebp),%eax
    78eb:	89 10                	mov    %edx,(%eax)
     if (*w)
    78ed:	8b 45 18             	mov    0x18(%ebp),%eax
    78f0:	8b 00                	mov    (%eax),%eax
    78f2:	85 c0                	test   %eax,%eax
    78f4:	74 18                	je     790e <huffman_decoder+0x239>
        if (hget1bit() == 1) *w = -*w;
    78f6:	e8 38 e5 ff ff       	call   5e33 <hget1bit>
    78fb:	83 f8 01             	cmp    $0x1,%eax
    78fe:	75 0e                	jne    790e <huffman_decoder+0x239>
    7900:	8b 45 18             	mov    0x18(%ebp),%eax
    7903:	8b 00                	mov    (%eax),%eax
    7905:	f7 d8                	neg    %eax
    7907:	89 c2                	mov    %eax,%edx
    7909:	8b 45 18             	mov    0x18(%ebp),%eax
    790c:	89 10                	mov    %edx,(%eax)
     if (*x)
    790e:	8b 45 0c             	mov    0xc(%ebp),%eax
    7911:	8b 00                	mov    (%eax),%eax
    7913:	85 c0                	test   %eax,%eax
    7915:	74 18                	je     792f <huffman_decoder+0x25a>
        if (hget1bit() == 1) *x = -*x;
    7917:	e8 17 e5 ff ff       	call   5e33 <hget1bit>
    791c:	83 f8 01             	cmp    $0x1,%eax
    791f:	75 0e                	jne    792f <huffman_decoder+0x25a>
    7921:	8b 45 0c             	mov    0xc(%ebp),%eax
    7924:	8b 00                	mov    (%eax),%eax
    7926:	f7 d8                	neg    %eax
    7928:	89 c2                	mov    %eax,%edx
    792a:	8b 45 0c             	mov    0xc(%ebp),%eax
    792d:	89 10                	mov    %edx,(%eax)
     if (*y)
    792f:	8b 45 10             	mov    0x10(%ebp),%eax
    7932:	8b 00                	mov    (%eax),%eax
    7934:	85 c0                	test   %eax,%eax
    7936:	74 1d                	je     7955 <huffman_decoder+0x280>
        if (hget1bit() == 1) *y = -*y;
    7938:	e8 f6 e4 ff ff       	call   5e33 <hget1bit>
    793d:	83 f8 01             	cmp    $0x1,%eax
    7940:	75 13                	jne    7955 <huffman_decoder+0x280>
    7942:	8b 45 10             	mov    0x10(%ebp),%eax
    7945:	8b 00                	mov    (%eax),%eax
    7947:	f7 d8                	neg    %eax
    7949:	89 c2                	mov    %eax,%edx
    794b:	8b 45 10             	mov    0x10(%ebp),%eax
    794e:	89 10                	mov    %edx,(%eax)
        if (hget1bit() == 1) *v = -*v;
     if (*w)
        if (hget1bit() == 1) *w = -*w;
     if (*x)
        if (hget1bit() == 1) *x = -*x;
     if (*y)
    7950:	e9 bb 00 00 00       	jmp    7a10 <huffman_decoder+0x33b>
    7955:	e9 b6 00 00 00       	jmp    7a10 <huffman_decoder+0x33b>
  else {
  
      /* �ڲ��Ա�������x �� y�ǵߵ��� 
         ����ߵ� x �� y ʹ���Ա��������� */
    
     if (h->linbits)
    795a:	8b 45 08             	mov    0x8(%ebp),%eax
    795d:	8b 40 0c             	mov    0xc(%eax),%eax
    7960:	85 c0                	test   %eax,%eax
    7962:	74 30                	je     7994 <huffman_decoder+0x2bf>
       if ((h->xlen-1) == *x) 
    7964:	8b 45 08             	mov    0x8(%ebp),%eax
    7967:	8b 40 04             	mov    0x4(%eax),%eax
    796a:	8d 50 ff             	lea    -0x1(%eax),%edx
    796d:	8b 45 0c             	mov    0xc(%ebp),%eax
    7970:	8b 00                	mov    (%eax),%eax
    7972:	39 c2                	cmp    %eax,%edx
    7974:	75 1e                	jne    7994 <huffman_decoder+0x2bf>
         *x += hgetbits(h->linbits);
    7976:	8b 45 0c             	mov    0xc(%ebp),%eax
    7979:	8b 00                	mov    (%eax),%eax
    797b:	89 c3                	mov    %eax,%ebx
    797d:	8b 45 08             	mov    0x8(%ebp),%eax
    7980:	8b 40 0c             	mov    0xc(%eax),%eax
    7983:	89 04 24             	mov    %eax,(%esp)
    7986:	e8 8d e4 ff ff       	call   5e18 <hgetbits>
    798b:	01 d8                	add    %ebx,%eax
    798d:	89 c2                	mov    %eax,%edx
    798f:	8b 45 0c             	mov    0xc(%ebp),%eax
    7992:	89 10                	mov    %edx,(%eax)
     if (*x)
    7994:	8b 45 0c             	mov    0xc(%ebp),%eax
    7997:	8b 00                	mov    (%eax),%eax
    7999:	85 c0                	test   %eax,%eax
    799b:	74 18                	je     79b5 <huffman_decoder+0x2e0>
        if (hget1bit() == 1) *x = -*x;
    799d:	e8 91 e4 ff ff       	call   5e33 <hget1bit>
    79a2:	83 f8 01             	cmp    $0x1,%eax
    79a5:	75 0e                	jne    79b5 <huffman_decoder+0x2e0>
    79a7:	8b 45 0c             	mov    0xc(%ebp),%eax
    79aa:	8b 00                	mov    (%eax),%eax
    79ac:	f7 d8                	neg    %eax
    79ae:	89 c2                	mov    %eax,%edx
    79b0:	8b 45 0c             	mov    0xc(%ebp),%eax
    79b3:	89 10                	mov    %edx,(%eax)
     if (h->linbits)	  
    79b5:	8b 45 08             	mov    0x8(%ebp),%eax
    79b8:	8b 40 0c             	mov    0xc(%eax),%eax
    79bb:	85 c0                	test   %eax,%eax
    79bd:	74 30                	je     79ef <huffman_decoder+0x31a>
       if ((h->ylen-1) == *y)
    79bf:	8b 45 08             	mov    0x8(%ebp),%eax
    79c2:	8b 40 08             	mov    0x8(%eax),%eax
    79c5:	8d 50 ff             	lea    -0x1(%eax),%edx
    79c8:	8b 45 10             	mov    0x10(%ebp),%eax
    79cb:	8b 00                	mov    (%eax),%eax
    79cd:	39 c2                	cmp    %eax,%edx
    79cf:	75 1e                	jne    79ef <huffman_decoder+0x31a>
         *y += hgetbits(h->linbits);
    79d1:	8b 45 10             	mov    0x10(%ebp),%eax
    79d4:	8b 00                	mov    (%eax),%eax
    79d6:	89 c3                	mov    %eax,%ebx
    79d8:	8b 45 08             	mov    0x8(%ebp),%eax
    79db:	8b 40 0c             	mov    0xc(%eax),%eax
    79de:	89 04 24             	mov    %eax,(%esp)
    79e1:	e8 32 e4 ff ff       	call   5e18 <hgetbits>
    79e6:	01 d8                	add    %ebx,%eax
    79e8:	89 c2                	mov    %eax,%edx
    79ea:	8b 45 10             	mov    0x10(%ebp),%eax
    79ed:	89 10                	mov    %edx,(%eax)
     if (*y)
    79ef:	8b 45 10             	mov    0x10(%ebp),%eax
    79f2:	8b 00                	mov    (%eax),%eax
    79f4:	85 c0                	test   %eax,%eax
    79f6:	74 18                	je     7a10 <huffman_decoder+0x33b>
        if (hget1bit() == 1) *y = -*y;
    79f8:	e8 36 e4 ff ff       	call   5e33 <hget1bit>
    79fd:	83 f8 01             	cmp    $0x1,%eax
    7a00:	75 0e                	jne    7a10 <huffman_decoder+0x33b>
    7a02:	8b 45 10             	mov    0x10(%ebp),%eax
    7a05:	8b 00                	mov    (%eax),%eax
    7a07:	f7 d8                	neg    %eax
    7a09:	89 c2                	mov    %eax,%edx
    7a0b:	8b 45 10             	mov    0x10(%ebp),%eax
    7a0e:	89 10                	mov    %edx,(%eax)
     }
	  
  return error;  
    7a10:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
    7a13:	83 c4 24             	add    $0x24,%esp
    7a16:	5b                   	pop    %ebx
    7a17:	5d                   	pop    %ebp
    7a18:	c3                   	ret    

00007a19 <decode_info>:
#include "math.h"
#include "common.h"
#include "decode.h"
#include "huffman.h"

void decode_info(Bit_stream_struc *bs, struct frame_params *fr_ps) {
    7a19:	55                   	push   %ebp
    7a1a:	89 e5                	mov    %esp,%ebp
    7a1c:	83 ec 28             	sub    $0x28,%esp
    layer *hdr = fr_ps->header;
    7a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
    7a22:	8b 00                	mov    (%eax),%eax
    7a24:	89 45 f4             	mov    %eax,-0xc(%ebp)

    hdr->version = get1bit(bs);
    7a27:	8b 45 08             	mov    0x8(%ebp),%eax
    7a2a:	89 04 24             	mov    %eax,(%esp)
    7a2d:	e8 6c df ff ff       	call   599e <get1bit>
    7a32:	89 c2                	mov    %eax,%edx
    7a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7a37:	89 10                	mov    %edx,(%eax)
    hdr->lay = 4 - getbits(bs, 2);
    7a39:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7a40:	00 
    7a41:	8b 45 08             	mov    0x8(%ebp),%eax
    7a44:	89 04 24             	mov    %eax,(%esp)
    7a47:	e8 64 e0 ff ff       	call   5ab0 <getbits>
    7a4c:	ba 04 00 00 00       	mov    $0x4,%edx
    7a51:	29 c2                	sub    %eax,%edx
    7a53:	89 d0                	mov    %edx,%eax
    7a55:	89 c2                	mov    %eax,%edx
    7a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7a5a:	89 50 04             	mov    %edx,0x4(%eax)
    hdr->error_protection = !get1bit(bs); /* ���󱣻�. TRUE/FALSE */
    7a5d:	8b 45 08             	mov    0x8(%ebp),%eax
    7a60:	89 04 24             	mov    %eax,(%esp)
    7a63:	e8 36 df ff ff       	call   599e <get1bit>
    7a68:	85 c0                	test   %eax,%eax
    7a6a:	0f 94 c0             	sete   %al
    7a6d:	0f b6 d0             	movzbl %al,%edx
    7a70:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7a73:	89 50 08             	mov    %edx,0x8(%eax)
    hdr->bitrate_index = getbits(bs, 4);
    7a76:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
    7a7d:	00 
    7a7e:	8b 45 08             	mov    0x8(%ebp),%eax
    7a81:	89 04 24             	mov    %eax,(%esp)
    7a84:	e8 27 e0 ff ff       	call   5ab0 <getbits>
    7a89:	89 c2                	mov    %eax,%edx
    7a8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7a8e:	89 50 0c             	mov    %edx,0xc(%eax)
    hdr->sampling_frequency = getbits(bs, 2);
    7a91:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7a98:	00 
    7a99:	8b 45 08             	mov    0x8(%ebp),%eax
    7a9c:	89 04 24             	mov    %eax,(%esp)
    7a9f:	e8 0c e0 ff ff       	call   5ab0 <getbits>
    7aa4:	89 c2                	mov    %eax,%edx
    7aa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7aa9:	89 50 10             	mov    %edx,0x10(%eax)
    hdr->padding = get1bit(bs);
    7aac:	8b 45 08             	mov    0x8(%ebp),%eax
    7aaf:	89 04 24             	mov    %eax,(%esp)
    7ab2:	e8 e7 de ff ff       	call   599e <get1bit>
    7ab7:	89 c2                	mov    %eax,%edx
    7ab9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7abc:	89 50 14             	mov    %edx,0x14(%eax)
    hdr->extension = get1bit(bs);
    7abf:	8b 45 08             	mov    0x8(%ebp),%eax
    7ac2:	89 04 24             	mov    %eax,(%esp)
    7ac5:	e8 d4 de ff ff       	call   599e <get1bit>
    7aca:	89 c2                	mov    %eax,%edx
    7acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7acf:	89 50 18             	mov    %edx,0x18(%eax)
    hdr->mode = getbits(bs, 2);
    7ad2:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7ad9:	00 
    7ada:	8b 45 08             	mov    0x8(%ebp),%eax
    7add:	89 04 24             	mov    %eax,(%esp)
    7ae0:	e8 cb df ff ff       	call   5ab0 <getbits>
    7ae5:	89 c2                	mov    %eax,%edx
    7ae7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7aea:	89 50 1c             	mov    %edx,0x1c(%eax)
    hdr->mode_ext = getbits(bs, 2);
    7aed:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7af4:	00 
    7af5:	8b 45 08             	mov    0x8(%ebp),%eax
    7af8:	89 04 24             	mov    %eax,(%esp)
    7afb:	e8 b0 df ff ff       	call   5ab0 <getbits>
    7b00:	89 c2                	mov    %eax,%edx
    7b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7b05:	89 50 20             	mov    %edx,0x20(%eax)
    hdr->copyright = get1bit(bs);
    7b08:	8b 45 08             	mov    0x8(%ebp),%eax
    7b0b:	89 04 24             	mov    %eax,(%esp)
    7b0e:	e8 8b de ff ff       	call   599e <get1bit>
    7b13:	89 c2                	mov    %eax,%edx
    7b15:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7b18:	89 50 24             	mov    %edx,0x24(%eax)
    hdr->original = get1bit(bs);
    7b1b:	8b 45 08             	mov    0x8(%ebp),%eax
    7b1e:	89 04 24             	mov    %eax,(%esp)
    7b21:	e8 78 de ff ff       	call   599e <get1bit>
    7b26:	89 c2                	mov    %eax,%edx
    7b28:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7b2b:	89 50 28             	mov    %edx,0x28(%eax)
    hdr->emphasis = getbits(bs, 2);
    7b2e:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7b35:	00 
    7b36:	8b 45 08             	mov    0x8(%ebp),%eax
    7b39:	89 04 24             	mov    %eax,(%esp)
    7b3c:	e8 6f df ff ff       	call   5ab0 <getbits>
    7b41:	89 c2                	mov    %eax,%edx
    7b43:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7b46:	89 50 2c             	mov    %edx,0x2c(%eax)
}
    7b49:	c9                   	leave  
    7b4a:	c3                   	ret    

00007b4b <III_get_side_info>:

void III_get_side_info(Bit_stream_struc *bs, struct III_side_info_t *si, struct frame_params *fr_ps) {
    7b4b:	55                   	push   %ebp
    7b4c:	89 e5                	mov    %esp,%ebp
    7b4e:	56                   	push   %esi
    7b4f:	53                   	push   %ebx
    7b50:	83 ec 20             	sub    $0x20,%esp
    int ch, gr, i;
    int stereo = fr_ps->stereo;
    7b53:	8b 45 10             	mov    0x10(%ebp),%eax
    7b56:	8b 40 08             	mov    0x8(%eax),%eax
    7b59:	89 45 e8             	mov    %eax,-0x18(%ebp)

    si->main_data_begin = getbits(bs, 9);
    7b5c:	c7 44 24 04 09 00 00 	movl   $0x9,0x4(%esp)
    7b63:	00 
    7b64:	8b 45 08             	mov    0x8(%ebp),%eax
    7b67:	89 04 24             	mov    %eax,(%esp)
    7b6a:	e8 41 df ff ff       	call   5ab0 <getbits>
    7b6f:	8b 55 0c             	mov    0xc(%ebp),%edx
    7b72:	89 02                	mov    %eax,(%edx)
    if (stereo == 1)
    7b74:	83 7d e8 01          	cmpl   $0x1,-0x18(%ebp)
    7b78:	75 1b                	jne    7b95 <III_get_side_info+0x4a>
        si->private_bits = getbits(bs, 5);
    7b7a:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    7b81:	00 
    7b82:	8b 45 08             	mov    0x8(%ebp),%eax
    7b85:	89 04 24             	mov    %eax,(%esp)
    7b88:	e8 23 df ff ff       	call   5ab0 <getbits>
    7b8d:	8b 55 0c             	mov    0xc(%ebp),%edx
    7b90:	89 42 04             	mov    %eax,0x4(%edx)
    7b93:	eb 19                	jmp    7bae <III_get_side_info+0x63>
    else
        si->private_bits = getbits(bs, 3);
    7b95:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    7b9c:	00 
    7b9d:	8b 45 08             	mov    0x8(%ebp),%eax
    7ba0:	89 04 24             	mov    %eax,(%esp)
    7ba3:	e8 08 df ff ff       	call   5ab0 <getbits>
    7ba8:	8b 55 0c             	mov    0xc(%ebp),%edx
    7bab:	89 42 04             	mov    %eax,0x4(%edx)

    for (ch = 0; ch < stereo; ch++)
    7bae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    7bb5:	eb 3d                	jmp    7bf4 <III_get_side_info+0xa9>
        for (i = 0; i < 4; i++)
    7bb7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7bbe:	eb 2a                	jmp    7bea <III_get_side_info+0x9f>
            si->ch[ch].scfsi[i] = get1bit(bs);
    7bc0:	8b 45 08             	mov    0x8(%ebp),%eax
    7bc3:	89 04 24             	mov    %eax,(%esp)
    7bc6:	e8 d3 dd ff ff       	call   599e <get1bit>
    7bcb:	89 c1                	mov    %eax,%ecx
    7bcd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7bd0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7bd3:	89 d0                	mov    %edx,%eax
    7bd5:	c1 e0 02             	shl    $0x2,%eax
    7bd8:	01 d0                	add    %edx,%eax
    7bda:	c1 e0 03             	shl    $0x3,%eax
    7bdd:	8b 55 ec             	mov    -0x14(%ebp),%edx
    7be0:	01 d0                	add    %edx,%eax
    7be2:	89 4c 83 08          	mov    %ecx,0x8(%ebx,%eax,4)
        si->private_bits = getbits(bs, 5);
    else
        si->private_bits = getbits(bs, 3);

    for (ch = 0; ch < stereo; ch++)
        for (i = 0; i < 4; i++)
    7be6:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7bea:	83 7d ec 03          	cmpl   $0x3,-0x14(%ebp)
    7bee:	7e d0                	jle    7bc0 <III_get_side_info+0x75>
    if (stereo == 1)
        si->private_bits = getbits(bs, 5);
    else
        si->private_bits = getbits(bs, 3);

    for (ch = 0; ch < stereo; ch++)
    7bf0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7bf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7bf7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    7bfa:	7c bb                	jl     7bb7 <III_get_side_info+0x6c>
        for (i = 0; i < 4; i++)
            si->ch[ch].scfsi[i] = get1bit(bs);

    for (gr = 0; gr < 2; gr++) {
    7bfc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    7c03:	e9 c5 05 00 00       	jmp    81cd <III_get_side_info+0x682>
        for (ch = 0; ch < stereo; ch++) {
    7c08:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    7c0f:	e9 a9 05 00 00       	jmp    81bd <III_get_side_info+0x672>
            si->ch[ch].gr[gr].part2_3_length = getbits(bs, 12);
    7c14:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
    7c1b:	00 
    7c1c:	8b 45 08             	mov    0x8(%ebp),%eax
    7c1f:	89 04 24             	mov    %eax,(%esp)
    7c22:	e8 89 de ff ff       	call   5ab0 <getbits>
    7c27:	89 c3                	mov    %eax,%ebx
    7c29:	8b 75 0c             	mov    0xc(%ebp),%esi
    7c2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7c2f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7c32:	89 c2                	mov    %eax,%edx
    7c34:	c1 e2 03             	shl    $0x3,%edx
    7c37:	01 c2                	add    %eax,%edx
    7c39:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7c40:	89 c2                	mov    %eax,%edx
    7c42:	89 c8                	mov    %ecx,%eax
    7c44:	c1 e0 02             	shl    $0x2,%eax
    7c47:	01 c8                	add    %ecx,%eax
    7c49:	c1 e0 05             	shl    $0x5,%eax
    7c4c:	01 d0                	add    %edx,%eax
    7c4e:	01 f0                	add    %esi,%eax
    7c50:	83 c0 18             	add    $0x18,%eax
    7c53:	89 18                	mov    %ebx,(%eax)
            si->ch[ch].gr[gr].big_values = getbits(bs, 9);
    7c55:	c7 44 24 04 09 00 00 	movl   $0x9,0x4(%esp)
    7c5c:	00 
    7c5d:	8b 45 08             	mov    0x8(%ebp),%eax
    7c60:	89 04 24             	mov    %eax,(%esp)
    7c63:	e8 48 de ff ff       	call   5ab0 <getbits>
    7c68:	89 c3                	mov    %eax,%ebx
    7c6a:	8b 75 0c             	mov    0xc(%ebp),%esi
    7c6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7c70:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7c73:	89 c2                	mov    %eax,%edx
    7c75:	c1 e2 03             	shl    $0x3,%edx
    7c78:	01 c2                	add    %eax,%edx
    7c7a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7c81:	89 c2                	mov    %eax,%edx
    7c83:	89 c8                	mov    %ecx,%eax
    7c85:	c1 e0 02             	shl    $0x2,%eax
    7c88:	01 c8                	add    %ecx,%eax
    7c8a:	c1 e0 05             	shl    $0x5,%eax
    7c8d:	01 d0                	add    %edx,%eax
    7c8f:	01 f0                	add    %esi,%eax
    7c91:	83 c0 1c             	add    $0x1c,%eax
    7c94:	89 18                	mov    %ebx,(%eax)
            si->ch[ch].gr[gr].global_gain = getbits(bs, 8);
    7c96:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
    7c9d:	00 
    7c9e:	8b 45 08             	mov    0x8(%ebp),%eax
    7ca1:	89 04 24             	mov    %eax,(%esp)
    7ca4:	e8 07 de ff ff       	call   5ab0 <getbits>
    7ca9:	89 c3                	mov    %eax,%ebx
    7cab:	8b 75 0c             	mov    0xc(%ebp),%esi
    7cae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7cb1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7cb4:	89 c2                	mov    %eax,%edx
    7cb6:	c1 e2 03             	shl    $0x3,%edx
    7cb9:	01 c2                	add    %eax,%edx
    7cbb:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7cc2:	89 c2                	mov    %eax,%edx
    7cc4:	89 c8                	mov    %ecx,%eax
    7cc6:	c1 e0 02             	shl    $0x2,%eax
    7cc9:	01 c8                	add    %ecx,%eax
    7ccb:	c1 e0 05             	shl    $0x5,%eax
    7cce:	01 d0                	add    %edx,%eax
    7cd0:	01 f0                	add    %esi,%eax
    7cd2:	83 c0 20             	add    $0x20,%eax
    7cd5:	89 18                	mov    %ebx,(%eax)
            si->ch[ch].gr[gr].scalefac_compress = getbits(bs, 4);
    7cd7:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
    7cde:	00 
    7cdf:	8b 45 08             	mov    0x8(%ebp),%eax
    7ce2:	89 04 24             	mov    %eax,(%esp)
    7ce5:	e8 c6 dd ff ff       	call   5ab0 <getbits>
    7cea:	89 c3                	mov    %eax,%ebx
    7cec:	8b 75 0c             	mov    0xc(%ebp),%esi
    7cef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7cf2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7cf5:	89 c2                	mov    %eax,%edx
    7cf7:	c1 e2 03             	shl    $0x3,%edx
    7cfa:	01 c2                	add    %eax,%edx
    7cfc:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7d03:	89 c2                	mov    %eax,%edx
    7d05:	89 c8                	mov    %ecx,%eax
    7d07:	c1 e0 02             	shl    $0x2,%eax
    7d0a:	01 c8                	add    %ecx,%eax
    7d0c:	c1 e0 05             	shl    $0x5,%eax
    7d0f:	01 d0                	add    %edx,%eax
    7d11:	01 f0                	add    %esi,%eax
    7d13:	83 c0 24             	add    $0x24,%eax
    7d16:	89 18                	mov    %ebx,(%eax)
            si->ch[ch].gr[gr].window_switching_flag = get1bit(bs);
    7d18:	8b 45 08             	mov    0x8(%ebp),%eax
    7d1b:	89 04 24             	mov    %eax,(%esp)
    7d1e:	e8 7b dc ff ff       	call   599e <get1bit>
    7d23:	89 c3                	mov    %eax,%ebx
    7d25:	8b 75 0c             	mov    0xc(%ebp),%esi
    7d28:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7d2b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7d2e:	89 c2                	mov    %eax,%edx
    7d30:	c1 e2 03             	shl    $0x3,%edx
    7d33:	01 c2                	add    %eax,%edx
    7d35:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7d3c:	89 c2                	mov    %eax,%edx
    7d3e:	89 c8                	mov    %ecx,%eax
    7d40:	c1 e0 02             	shl    $0x2,%eax
    7d43:	01 c8                	add    %ecx,%eax
    7d45:	c1 e0 05             	shl    $0x5,%eax
    7d48:	01 d0                	add    %edx,%eax
    7d4a:	01 f0                	add    %esi,%eax
    7d4c:	83 c0 28             	add    $0x28,%eax
    7d4f:	89 18                	mov    %ebx,(%eax)
            if (si->ch[ch].gr[gr].window_switching_flag) {
    7d51:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7d54:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7d57:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7d5a:	89 c2                	mov    %eax,%edx
    7d5c:	c1 e2 03             	shl    $0x3,%edx
    7d5f:	01 c2                	add    %eax,%edx
    7d61:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7d68:	89 c2                	mov    %eax,%edx
    7d6a:	89 c8                	mov    %ecx,%eax
    7d6c:	c1 e0 02             	shl    $0x2,%eax
    7d6f:	01 c8                	add    %ecx,%eax
    7d71:	c1 e0 05             	shl    $0x5,%eax
    7d74:	01 d0                	add    %edx,%eax
    7d76:	01 d8                	add    %ebx,%eax
    7d78:	83 c0 28             	add    $0x28,%eax
    7d7b:	8b 00                	mov    (%eax),%eax
    7d7d:	85 c0                	test   %eax,%eax
    7d7f:	0f 84 82 02 00 00    	je     8007 <III_get_side_info+0x4bc>
                si->ch[ch].gr[gr].block_type = getbits(bs, 2);
    7d85:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7d8c:	00 
    7d8d:	8b 45 08             	mov    0x8(%ebp),%eax
    7d90:	89 04 24             	mov    %eax,(%esp)
    7d93:	e8 18 dd ff ff       	call   5ab0 <getbits>
    7d98:	89 c3                	mov    %eax,%ebx
    7d9a:	8b 75 0c             	mov    0xc(%ebp),%esi
    7d9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7da0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7da3:	89 c2                	mov    %eax,%edx
    7da5:	c1 e2 03             	shl    $0x3,%edx
    7da8:	01 c2                	add    %eax,%edx
    7daa:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7db1:	89 c2                	mov    %eax,%edx
    7db3:	89 c8                	mov    %ecx,%eax
    7db5:	c1 e0 02             	shl    $0x2,%eax
    7db8:	01 c8                	add    %ecx,%eax
    7dba:	c1 e0 05             	shl    $0x5,%eax
    7dbd:	01 d0                	add    %edx,%eax
    7dbf:	01 f0                	add    %esi,%eax
    7dc1:	83 c0 2c             	add    $0x2c,%eax
    7dc4:	89 18                	mov    %ebx,(%eax)
                si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
    7dc6:	8b 45 08             	mov    0x8(%ebp),%eax
    7dc9:	89 04 24             	mov    %eax,(%esp)
    7dcc:	e8 cd db ff ff       	call   599e <get1bit>
    7dd1:	89 c3                	mov    %eax,%ebx
    7dd3:	8b 75 0c             	mov    0xc(%ebp),%esi
    7dd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7dd9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7ddc:	89 c2                	mov    %eax,%edx
    7dde:	c1 e2 03             	shl    $0x3,%edx
    7de1:	01 c2                	add    %eax,%edx
    7de3:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7dea:	89 c2                	mov    %eax,%edx
    7dec:	89 c8                	mov    %ecx,%eax
    7dee:	c1 e0 02             	shl    $0x2,%eax
    7df1:	01 c8                	add    %ecx,%eax
    7df3:	c1 e0 05             	shl    $0x5,%eax
    7df6:	01 d0                	add    %edx,%eax
    7df8:	01 f0                	add    %esi,%eax
    7dfa:	83 c0 30             	add    $0x30,%eax
    7dfd:	89 18                	mov    %ebx,(%eax)
                for (i = 0; i < 2; i++)
    7dff:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7e06:	eb 46                	jmp    7e4e <III_get_side_info+0x303>
                    si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
    7e08:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    7e0f:	00 
    7e10:	8b 45 08             	mov    0x8(%ebp),%eax
    7e13:	89 04 24             	mov    %eax,(%esp)
    7e16:	e8 95 dc ff ff       	call   5ab0 <getbits>
    7e1b:	89 c3                	mov    %eax,%ebx
    7e1d:	8b 75 0c             	mov    0xc(%ebp),%esi
    7e20:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7e23:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7e26:	89 c2                	mov    %eax,%edx
    7e28:	c1 e2 03             	shl    $0x3,%edx
    7e2b:	01 c2                	add    %eax,%edx
    7e2d:	8d 04 12             	lea    (%edx,%edx,1),%eax
    7e30:	89 c2                	mov    %eax,%edx
    7e32:	89 c8                	mov    %ecx,%eax
    7e34:	c1 e0 02             	shl    $0x2,%eax
    7e37:	01 c8                	add    %ecx,%eax
    7e39:	c1 e0 03             	shl    $0x3,%eax
    7e3c:	01 c2                	add    %eax,%edx
    7e3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7e41:	01 d0                	add    %edx,%eax
    7e43:	83 c0 08             	add    $0x8,%eax
    7e46:	89 5c 86 14          	mov    %ebx,0x14(%esi,%eax,4)
            si->ch[ch].gr[gr].scalefac_compress = getbits(bs, 4);
            si->ch[ch].gr[gr].window_switching_flag = get1bit(bs);
            if (si->ch[ch].gr[gr].window_switching_flag) {
                si->ch[ch].gr[gr].block_type = getbits(bs, 2);
                si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
                for (i = 0; i < 2; i++)
    7e4a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7e4e:	83 7d ec 01          	cmpl   $0x1,-0x14(%ebp)
    7e52:	7e b4                	jle    7e08 <III_get_side_info+0x2bd>
                    si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
                for (i = 0; i < 3; i++)
    7e54:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7e5b:	eb 46                	jmp    7ea3 <III_get_side_info+0x358>
                    si->ch[ch].gr[gr].subblock_gain[i] = getbits(bs, 3);
    7e5d:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    7e64:	00 
    7e65:	8b 45 08             	mov    0x8(%ebp),%eax
    7e68:	89 04 24             	mov    %eax,(%esp)
    7e6b:	e8 40 dc ff ff       	call   5ab0 <getbits>
    7e70:	89 c3                	mov    %eax,%ebx
    7e72:	8b 75 0c             	mov    0xc(%ebp),%esi
    7e75:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7e78:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7e7b:	89 c2                	mov    %eax,%edx
    7e7d:	c1 e2 03             	shl    $0x3,%edx
    7e80:	01 c2                	add    %eax,%edx
    7e82:	8d 04 12             	lea    (%edx,%edx,1),%eax
    7e85:	89 c2                	mov    %eax,%edx
    7e87:	89 c8                	mov    %ecx,%eax
    7e89:	c1 e0 02             	shl    $0x2,%eax
    7e8c:	01 c8                	add    %ecx,%eax
    7e8e:	c1 e0 03             	shl    $0x3,%eax
    7e91:	01 c2                	add    %eax,%edx
    7e93:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7e96:	01 d0                	add    %edx,%eax
    7e98:	83 c0 0c             	add    $0xc,%eax
    7e9b:	89 5c 86 10          	mov    %ebx,0x10(%esi,%eax,4)
            if (si->ch[ch].gr[gr].window_switching_flag) {
                si->ch[ch].gr[gr].block_type = getbits(bs, 2);
                si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
                for (i = 0; i < 2; i++)
                    si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
                for (i = 0; i < 3; i++)
    7e9f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7ea3:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    7ea7:	7e b4                	jle    7e5d <III_get_side_info+0x312>
                    si->ch[ch].gr[gr].subblock_gain[i] = getbits(bs, 3);

                /* Set region_count parameters since they are implicit in this case. */

                if (si->ch[ch].gr[gr].block_type == 0) {
    7ea9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7eac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7eaf:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7eb2:	89 c2                	mov    %eax,%edx
    7eb4:	c1 e2 03             	shl    $0x3,%edx
    7eb7:	01 c2                	add    %eax,%edx
    7eb9:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7ec0:	89 c2                	mov    %eax,%edx
    7ec2:	89 c8                	mov    %ecx,%eax
    7ec4:	c1 e0 02             	shl    $0x2,%eax
    7ec7:	01 c8                	add    %ecx,%eax
    7ec9:	c1 e0 05             	shl    $0x5,%eax
    7ecc:	01 d0                	add    %edx,%eax
    7ece:	01 d8                	add    %ebx,%eax
    7ed0:	83 c0 2c             	add    $0x2c,%eax
    7ed3:	8b 00                	mov    (%eax),%eax
    7ed5:	85 c0                	test   %eax,%eax
    7ed7:	75 05                	jne    7ede <III_get_side_info+0x393>
                    //printf("Side info bad: block_type == 0 in split block.\n");
                    exit();
    7ed9:	e8 7c cb ff ff       	call   4a5a <exit>
                }
                else if (si->ch[ch].gr[gr].block_type == 2
    7ede:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7ee1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7ee4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7ee7:	89 c2                	mov    %eax,%edx
    7ee9:	c1 e2 03             	shl    $0x3,%edx
    7eec:	01 c2                	add    %eax,%edx
    7eee:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7ef5:	89 c2                	mov    %eax,%edx
    7ef7:	89 c8                	mov    %ecx,%eax
    7ef9:	c1 e0 02             	shl    $0x2,%eax
    7efc:	01 c8                	add    %ecx,%eax
    7efe:	c1 e0 05             	shl    $0x5,%eax
    7f01:	01 d0                	add    %edx,%eax
    7f03:	01 d8                	add    %ebx,%eax
    7f05:	83 c0 2c             	add    $0x2c,%eax
    7f08:	8b 00                	mov    (%eax),%eax
    7f0a:	83 f8 02             	cmp    $0x2,%eax
    7f0d:	75 62                	jne    7f71 <III_get_side_info+0x426>
                         && si->ch[ch].gr[gr].mixed_block_flag == 0)
    7f0f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7f12:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7f15:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7f18:	89 c2                	mov    %eax,%edx
    7f1a:	c1 e2 03             	shl    $0x3,%edx
    7f1d:	01 c2                	add    %eax,%edx
    7f1f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7f26:	89 c2                	mov    %eax,%edx
    7f28:	89 c8                	mov    %ecx,%eax
    7f2a:	c1 e0 02             	shl    $0x2,%eax
    7f2d:	01 c8                	add    %ecx,%eax
    7f2f:	c1 e0 05             	shl    $0x5,%eax
    7f32:	01 d0                	add    %edx,%eax
    7f34:	01 d8                	add    %ebx,%eax
    7f36:	83 c0 30             	add    $0x30,%eax
    7f39:	8b 00                	mov    (%eax),%eax
    7f3b:	85 c0                	test   %eax,%eax
    7f3d:	75 32                	jne    7f71 <III_get_side_info+0x426>
                    si->ch[ch].gr[gr].region0_count = 8; /* MI 9; */
    7f3f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7f42:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7f45:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7f48:	89 c2                	mov    %eax,%edx
    7f4a:	c1 e2 03             	shl    $0x3,%edx
    7f4d:	01 c2                	add    %eax,%edx
    7f4f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7f56:	89 c2                	mov    %eax,%edx
    7f58:	89 c8                	mov    %ecx,%eax
    7f5a:	c1 e0 02             	shl    $0x2,%eax
    7f5d:	01 c8                	add    %ecx,%eax
    7f5f:	c1 e0 05             	shl    $0x5,%eax
    7f62:	01 d0                	add    %edx,%eax
    7f64:	01 d8                	add    %ebx,%eax
    7f66:	83 c0 4c             	add    $0x4c,%eax
    7f69:	c7 00 08 00 00 00    	movl   $0x8,(%eax)
    7f6f:	eb 30                	jmp    7fa1 <III_get_side_info+0x456>
                else si->ch[ch].gr[gr].region0_count = 7; /* MI 8; */
    7f71:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7f74:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7f77:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7f7a:	89 c2                	mov    %eax,%edx
    7f7c:	c1 e2 03             	shl    $0x3,%edx
    7f7f:	01 c2                	add    %eax,%edx
    7f81:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7f88:	89 c2                	mov    %eax,%edx
    7f8a:	89 c8                	mov    %ecx,%eax
    7f8c:	c1 e0 02             	shl    $0x2,%eax
    7f8f:	01 c8                	add    %ecx,%eax
    7f91:	c1 e0 05             	shl    $0x5,%eax
    7f94:	01 d0                	add    %edx,%eax
    7f96:	01 d8                	add    %ebx,%eax
    7f98:	83 c0 4c             	add    $0x4c,%eax
    7f9b:	c7 00 07 00 00 00    	movl   $0x7,(%eax)
                si->ch[ch].gr[gr].region1_count = 20 - si->ch[ch].gr[gr].region0_count;
    7fa1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7fa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7fa7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7faa:	89 c2                	mov    %eax,%edx
    7fac:	c1 e2 03             	shl    $0x3,%edx
    7faf:	01 c2                	add    %eax,%edx
    7fb1:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7fb8:	89 c2                	mov    %eax,%edx
    7fba:	89 c8                	mov    %ecx,%eax
    7fbc:	c1 e0 02             	shl    $0x2,%eax
    7fbf:	01 c8                	add    %ecx,%eax
    7fc1:	c1 e0 05             	shl    $0x5,%eax
    7fc4:	01 d0                	add    %edx,%eax
    7fc6:	01 d8                	add    %ebx,%eax
    7fc8:	83 c0 4c             	add    $0x4c,%eax
    7fcb:	8b 00                	mov    (%eax),%eax
    7fcd:	ba 14 00 00 00       	mov    $0x14,%edx
    7fd2:	89 d3                	mov    %edx,%ebx
    7fd4:	29 c3                	sub    %eax,%ebx
    7fd6:	8b 75 0c             	mov    0xc(%ebp),%esi
    7fd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7fdc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7fdf:	89 c2                	mov    %eax,%edx
    7fe1:	c1 e2 03             	shl    $0x3,%edx
    7fe4:	01 c2                	add    %eax,%edx
    7fe6:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7fed:	89 c2                	mov    %eax,%edx
    7fef:	89 c8                	mov    %ecx,%eax
    7ff1:	c1 e0 02             	shl    $0x2,%eax
    7ff4:	01 c8                	add    %ecx,%eax
    7ff6:	c1 e0 05             	shl    $0x5,%eax
    7ff9:	01 d0                	add    %edx,%eax
    7ffb:	01 f0                	add    %esi,%eax
    7ffd:	83 c0 50             	add    $0x50,%eax
    8000:	89 18                	mov    %ebx,(%eax)
    8002:	e9 07 01 00 00       	jmp    810e <III_get_side_info+0x5c3>
            }
            else {
                for (i = 0; i < 3; i++)
    8007:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    800e:	eb 46                	jmp    8056 <III_get_side_info+0x50b>
                    si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
    8010:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    8017:	00 
    8018:	8b 45 08             	mov    0x8(%ebp),%eax
    801b:	89 04 24             	mov    %eax,(%esp)
    801e:	e8 8d da ff ff       	call   5ab0 <getbits>
    8023:	89 c3                	mov    %eax,%ebx
    8025:	8b 75 0c             	mov    0xc(%ebp),%esi
    8028:	8b 45 f0             	mov    -0x10(%ebp),%eax
    802b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    802e:	89 c2                	mov    %eax,%edx
    8030:	c1 e2 03             	shl    $0x3,%edx
    8033:	01 c2                	add    %eax,%edx
    8035:	8d 04 12             	lea    (%edx,%edx,1),%eax
    8038:	89 c2                	mov    %eax,%edx
    803a:	89 c8                	mov    %ecx,%eax
    803c:	c1 e0 02             	shl    $0x2,%eax
    803f:	01 c8                	add    %ecx,%eax
    8041:	c1 e0 03             	shl    $0x3,%eax
    8044:	01 c2                	add    %eax,%edx
    8046:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8049:	01 d0                	add    %edx,%eax
    804b:	83 c0 08             	add    $0x8,%eax
    804e:	89 5c 86 14          	mov    %ebx,0x14(%esi,%eax,4)
                    si->ch[ch].gr[gr].region0_count = 8; /* MI 9; */
                else si->ch[ch].gr[gr].region0_count = 7; /* MI 8; */
                si->ch[ch].gr[gr].region1_count = 20 - si->ch[ch].gr[gr].region0_count;
            }
            else {
                for (i = 0; i < 3; i++)
    8052:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8056:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    805a:	7e b4                	jle    8010 <III_get_side_info+0x4c5>
                    si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
                si->ch[ch].gr[gr].region0_count = getbits(bs, 4);
    805c:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
    8063:	00 
    8064:	8b 45 08             	mov    0x8(%ebp),%eax
    8067:	89 04 24             	mov    %eax,(%esp)
    806a:	e8 41 da ff ff       	call   5ab0 <getbits>
    806f:	89 c3                	mov    %eax,%ebx
    8071:	8b 75 0c             	mov    0xc(%ebp),%esi
    8074:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8077:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    807a:	89 c2                	mov    %eax,%edx
    807c:	c1 e2 03             	shl    $0x3,%edx
    807f:	01 c2                	add    %eax,%edx
    8081:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8088:	89 c2                	mov    %eax,%edx
    808a:	89 c8                	mov    %ecx,%eax
    808c:	c1 e0 02             	shl    $0x2,%eax
    808f:	01 c8                	add    %ecx,%eax
    8091:	c1 e0 05             	shl    $0x5,%eax
    8094:	01 d0                	add    %edx,%eax
    8096:	01 f0                	add    %esi,%eax
    8098:	83 c0 4c             	add    $0x4c,%eax
    809b:	89 18                	mov    %ebx,(%eax)
                si->ch[ch].gr[gr].region1_count = getbits(bs, 3);
    809d:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    80a4:	00 
    80a5:	8b 45 08             	mov    0x8(%ebp),%eax
    80a8:	89 04 24             	mov    %eax,(%esp)
    80ab:	e8 00 da ff ff       	call   5ab0 <getbits>
    80b0:	89 c3                	mov    %eax,%ebx
    80b2:	8b 75 0c             	mov    0xc(%ebp),%esi
    80b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    80b8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    80bb:	89 c2                	mov    %eax,%edx
    80bd:	c1 e2 03             	shl    $0x3,%edx
    80c0:	01 c2                	add    %eax,%edx
    80c2:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    80c9:	89 c2                	mov    %eax,%edx
    80cb:	89 c8                	mov    %ecx,%eax
    80cd:	c1 e0 02             	shl    $0x2,%eax
    80d0:	01 c8                	add    %ecx,%eax
    80d2:	c1 e0 05             	shl    $0x5,%eax
    80d5:	01 d0                	add    %edx,%eax
    80d7:	01 f0                	add    %esi,%eax
    80d9:	83 c0 50             	add    $0x50,%eax
    80dc:	89 18                	mov    %ebx,(%eax)
                si->ch[ch].gr[gr].block_type = 0;
    80de:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    80e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    80e4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    80e7:	89 c2                	mov    %eax,%edx
    80e9:	c1 e2 03             	shl    $0x3,%edx
    80ec:	01 c2                	add    %eax,%edx
    80ee:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    80f5:	89 c2                	mov    %eax,%edx
    80f7:	89 c8                	mov    %ecx,%eax
    80f9:	c1 e0 02             	shl    $0x2,%eax
    80fc:	01 c8                	add    %ecx,%eax
    80fe:	c1 e0 05             	shl    $0x5,%eax
    8101:	01 d0                	add    %edx,%eax
    8103:	01 d8                	add    %ebx,%eax
    8105:	83 c0 2c             	add    $0x2c,%eax
    8108:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
            }
            si->ch[ch].gr[gr].preflag = get1bit(bs);
    810e:	8b 45 08             	mov    0x8(%ebp),%eax
    8111:	89 04 24             	mov    %eax,(%esp)
    8114:	e8 85 d8 ff ff       	call   599e <get1bit>
    8119:	89 c3                	mov    %eax,%ebx
    811b:	8b 75 0c             	mov    0xc(%ebp),%esi
    811e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8121:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    8124:	89 c2                	mov    %eax,%edx
    8126:	c1 e2 03             	shl    $0x3,%edx
    8129:	01 c2                	add    %eax,%edx
    812b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8132:	89 c2                	mov    %eax,%edx
    8134:	89 c8                	mov    %ecx,%eax
    8136:	c1 e0 02             	shl    $0x2,%eax
    8139:	01 c8                	add    %ecx,%eax
    813b:	c1 e0 05             	shl    $0x5,%eax
    813e:	01 d0                	add    %edx,%eax
    8140:	01 f0                	add    %esi,%eax
    8142:	83 c0 54             	add    $0x54,%eax
    8145:	89 18                	mov    %ebx,(%eax)
            si->ch[ch].gr[gr].scalefac_scale = get1bit(bs);
    8147:	8b 45 08             	mov    0x8(%ebp),%eax
    814a:	89 04 24             	mov    %eax,(%esp)
    814d:	e8 4c d8 ff ff       	call   599e <get1bit>
    8152:	89 c3                	mov    %eax,%ebx
    8154:	8b 75 0c             	mov    0xc(%ebp),%esi
    8157:	8b 45 f0             	mov    -0x10(%ebp),%eax
    815a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    815d:	89 c2                	mov    %eax,%edx
    815f:	c1 e2 03             	shl    $0x3,%edx
    8162:	01 c2                	add    %eax,%edx
    8164:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    816b:	89 c2                	mov    %eax,%edx
    816d:	89 c8                	mov    %ecx,%eax
    816f:	c1 e0 02             	shl    $0x2,%eax
    8172:	01 c8                	add    %ecx,%eax
    8174:	c1 e0 05             	shl    $0x5,%eax
    8177:	01 d0                	add    %edx,%eax
    8179:	01 f0                	add    %esi,%eax
    817b:	83 c0 58             	add    $0x58,%eax
    817e:	89 18                	mov    %ebx,(%eax)
            si->ch[ch].gr[gr].count1table_select = get1bit(bs);
    8180:	8b 45 08             	mov    0x8(%ebp),%eax
    8183:	89 04 24             	mov    %eax,(%esp)
    8186:	e8 13 d8 ff ff       	call   599e <get1bit>
    818b:	89 c3                	mov    %eax,%ebx
    818d:	8b 75 0c             	mov    0xc(%ebp),%esi
    8190:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8193:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    8196:	89 c2                	mov    %eax,%edx
    8198:	c1 e2 03             	shl    $0x3,%edx
    819b:	01 c2                	add    %eax,%edx
    819d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    81a4:	89 c2                	mov    %eax,%edx
    81a6:	89 c8                	mov    %ecx,%eax
    81a8:	c1 e0 02             	shl    $0x2,%eax
    81ab:	01 c8                	add    %ecx,%eax
    81ad:	c1 e0 05             	shl    $0x5,%eax
    81b0:	01 d0                	add    %edx,%eax
    81b2:	01 f0                	add    %esi,%eax
    81b4:	83 c0 5c             	add    $0x5c,%eax
    81b7:	89 18                	mov    %ebx,(%eax)
    for (ch = 0; ch < stereo; ch++)
        for (i = 0; i < 4; i++)
            si->ch[ch].scfsi[i] = get1bit(bs);

    for (gr = 0; gr < 2; gr++) {
        for (ch = 0; ch < stereo; ch++) {
    81b9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    81bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    81c0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    81c3:	0f 8c 4b fa ff ff    	jl     7c14 <III_get_side_info+0xc9>

    for (ch = 0; ch < stereo; ch++)
        for (i = 0; i < 4; i++)
            si->ch[ch].scfsi[i] = get1bit(bs);

    for (gr = 0; gr < 2; gr++) {
    81c9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    81cd:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    81d1:	0f 8e 31 fa ff ff    	jle    7c08 <III_get_side_info+0xbd>
            si->ch[ch].gr[gr].preflag = get1bit(bs);
            si->ch[ch].gr[gr].scalefac_scale = get1bit(bs);
            si->ch[ch].gr[gr].count1table_select = get1bit(bs);
        }
    }
}
    81d7:	83 c4 20             	add    $0x20,%esp
    81da:	5b                   	pop    %ebx
    81db:	5e                   	pop    %esi
    81dc:	5d                   	pop    %ebp
    81dd:	c3                   	ret    

000081de <III_get_scale_factors>:
        {{0, 4, 8, 12, 16, 20, 24, 30, 36, 44, 54, 66, 82, 102, 126, 156, 194, 240, 296, 364, 448, 550, 576},
                {0, 4, 8, 12, 16, 22, 30, 42, 58, 78, 104, 138, 180, 192}}
};

void III_get_scale_factors(III_scalefac_t *scalefac, struct III_side_info_t *si, int gr, int ch,
                           struct frame_params *fr_ps) {
    81de:	55                   	push   %ebp
    81df:	89 e5                	mov    %esp,%ebp
    81e1:	56                   	push   %esi
    81e2:	53                   	push   %ebx
    81e3:	83 ec 20             	sub    $0x20,%esp
    int sfb, i, window;
    struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);
    81e6:	8b 45 10             	mov    0x10(%ebp),%eax
    81e9:	89 c2                	mov    %eax,%edx
    81eb:	c1 e2 03             	shl    $0x3,%edx
    81ee:	01 c2                	add    %eax,%edx
    81f0:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    81f7:	89 c2                	mov    %eax,%edx
    81f9:	8b 4d 14             	mov    0x14(%ebp),%ecx
    81fc:	89 c8                	mov    %ecx,%eax
    81fe:	c1 e0 02             	shl    $0x2,%eax
    8201:	01 c8                	add    %ecx,%eax
    8203:	c1 e0 05             	shl    $0x5,%eax
    8206:	01 d0                	add    %edx,%eax
    8208:	8d 50 10             	lea    0x10(%eax),%edx
    820b:	8b 45 0c             	mov    0xc(%ebp),%eax
    820e:	01 d0                	add    %edx,%eax
    8210:	83 c0 08             	add    $0x8,%eax
    8213:	89 45 e8             	mov    %eax,-0x18(%ebp)

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    8216:	8b 45 e8             	mov    -0x18(%ebp),%eax
    8219:	8b 40 10             	mov    0x10(%eax),%eax
    821c:	85 c0                	test   %eax,%eax
    821e:	0f 84 7e 02 00 00    	je     84a2 <III_get_scale_factors+0x2c4>
    8224:	8b 45 e8             	mov    -0x18(%ebp),%eax
    8227:	8b 40 14             	mov    0x14(%eax),%eax
    822a:	83 f8 02             	cmp    $0x2,%eax
    822d:	0f 85 6f 02 00 00    	jne    84a2 <III_get_scale_factors+0x2c4>
        if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    8233:	8b 45 e8             	mov    -0x18(%ebp),%eax
    8236:	8b 40 18             	mov    0x18(%eax),%eax
    8239:	85 c0                	test   %eax,%eax
    823b:	0f 84 6b 01 00 00    	je     83ac <III_get_scale_factors+0x1ce>
            for (sfb = 0; sfb < 8; sfb++)
    8241:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8248:	eb 32                	jmp    827c <III_get_scale_factors+0x9e>
                (*scalefac)[ch].l[sfb] = hgetbits(
                        slen[0][gr_info->scalefac_compress]);
    824a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    824d:	8b 40 0c             	mov    0xc(%eax),%eax
    struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
        if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
            for (sfb = 0; sfb < 8; sfb++)
                (*scalefac)[ch].l[sfb] = hgetbits(
    8250:	8b 04 85 20 f4 00 00 	mov    0xf420(,%eax,4),%eax
    8257:	89 04 24             	mov    %eax,(%esp)
    825a:	e8 b9 db ff ff       	call   5e18 <hgetbits>
    825f:	89 c3                	mov    %eax,%ebx
    8261:	8b 4d 08             	mov    0x8(%ebp),%ecx
    8264:	8b 45 14             	mov    0x14(%ebp),%eax
    8267:	01 c0                	add    %eax,%eax
    8269:	89 c2                	mov    %eax,%edx
    826b:	c1 e2 05             	shl    $0x5,%edx
    826e:	29 c2                	sub    %eax,%edx
    8270:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8273:	01 d0                	add    %edx,%eax
    8275:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
    int sfb, i, window;
    struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
        if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
            for (sfb = 0; sfb < 8; sfb++)
    8278:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    827c:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    8280:	7e c8                	jle    824a <III_get_scale_factors+0x6c>
                (*scalefac)[ch].l[sfb] = hgetbits(
                        slen[0][gr_info->scalefac_compress]);
            for (sfb = 3; sfb < 6; sfb++)
    8282:	c7 45 f4 03 00 00 00 	movl   $0x3,-0xc(%ebp)
    8289:	eb 5c                	jmp    82e7 <III_get_scale_factors+0x109>
                for (window = 0; window < 3; window++)
    828b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    8292:	eb 49                	jmp    82dd <III_get_scale_factors+0xff>
                    (*scalefac)[ch].s[window][sfb] = hgetbits(
                            slen[0][gr_info->scalefac_compress]);
    8294:	8b 45 e8             	mov    -0x18(%ebp),%eax
    8297:	8b 40 0c             	mov    0xc(%eax),%eax
            for (sfb = 0; sfb < 8; sfb++)
                (*scalefac)[ch].l[sfb] = hgetbits(
                        slen[0][gr_info->scalefac_compress]);
            for (sfb = 3; sfb < 6; sfb++)
                for (window = 0; window < 3; window++)
                    (*scalefac)[ch].s[window][sfb] = hgetbits(
    829a:	8b 04 85 20 f4 00 00 	mov    0xf420(,%eax,4),%eax
    82a1:	89 04 24             	mov    %eax,(%esp)
    82a4:	e8 6f db ff ff       	call   5e18 <hgetbits>
    82a9:	89 c6                	mov    %eax,%esi
    82ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
    82ae:	8b 55 ec             	mov    -0x14(%ebp),%edx
    82b1:	8b 4d 14             	mov    0x14(%ebp),%ecx
    82b4:	89 d0                	mov    %edx,%eax
    82b6:	01 c0                	add    %eax,%eax
    82b8:	01 d0                	add    %edx,%eax
    82ba:	c1 e0 02             	shl    $0x2,%eax
    82bd:	01 d0                	add    %edx,%eax
    82bf:	89 ca                	mov    %ecx,%edx
    82c1:	01 d2                	add    %edx,%edx
    82c3:	89 d1                	mov    %edx,%ecx
    82c5:	c1 e1 05             	shl    $0x5,%ecx
    82c8:	29 d1                	sub    %edx,%ecx
    82ca:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    82cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    82d0:	01 d0                	add    %edx,%eax
    82d2:	83 c0 14             	add    $0x14,%eax
    82d5:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
        if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
            for (sfb = 0; sfb < 8; sfb++)
                (*scalefac)[ch].l[sfb] = hgetbits(
                        slen[0][gr_info->scalefac_compress]);
            for (sfb = 3; sfb < 6; sfb++)
                for (window = 0; window < 3; window++)
    82d9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    82dd:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    82e1:	7e b1                	jle    8294 <III_get_scale_factors+0xb6>
    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
        if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
            for (sfb = 0; sfb < 8; sfb++)
                (*scalefac)[ch].l[sfb] = hgetbits(
                        slen[0][gr_info->scalefac_compress]);
            for (sfb = 3; sfb < 6; sfb++)
    82e3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    82e7:	83 7d f4 05          	cmpl   $0x5,-0xc(%ebp)
    82eb:	7e 9e                	jle    828b <III_get_scale_factors+0xad>
                for (window = 0; window < 3; window++)
                    (*scalefac)[ch].s[window][sfb] = hgetbits(
                            slen[0][gr_info->scalefac_compress]);
            for (sfb = 6; sfb < 12; sfb++)
    82ed:	c7 45 f4 06 00 00 00 	movl   $0x6,-0xc(%ebp)
    82f4:	eb 5f                	jmp    8355 <III_get_scale_factors+0x177>
                for (window = 0; window < 3; window++)
    82f6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    82fd:	eb 4c                	jmp    834b <III_get_scale_factors+0x16d>
                    (*scalefac)[ch].s[window][sfb] = hgetbits(
                            slen[1][gr_info->scalefac_compress]);
    82ff:	8b 45 e8             	mov    -0x18(%ebp),%eax
    8302:	8b 40 0c             	mov    0xc(%eax),%eax
                for (window = 0; window < 3; window++)
                    (*scalefac)[ch].s[window][sfb] = hgetbits(
                            slen[0][gr_info->scalefac_compress]);
            for (sfb = 6; sfb < 12; sfb++)
                for (window = 0; window < 3; window++)
                    (*scalefac)[ch].s[window][sfb] = hgetbits(
    8305:	83 c0 10             	add    $0x10,%eax
    8308:	8b 04 85 20 f4 00 00 	mov    0xf420(,%eax,4),%eax
    830f:	89 04 24             	mov    %eax,(%esp)
    8312:	e8 01 db ff ff       	call   5e18 <hgetbits>
    8317:	89 c6                	mov    %eax,%esi
    8319:	8b 5d 08             	mov    0x8(%ebp),%ebx
    831c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    831f:	8b 4d 14             	mov    0x14(%ebp),%ecx
    8322:	89 d0                	mov    %edx,%eax
    8324:	01 c0                	add    %eax,%eax
    8326:	01 d0                	add    %edx,%eax
    8328:	c1 e0 02             	shl    $0x2,%eax
    832b:	01 d0                	add    %edx,%eax
    832d:	89 ca                	mov    %ecx,%edx
    832f:	01 d2                	add    %edx,%edx
    8331:	89 d1                	mov    %edx,%ecx
    8333:	c1 e1 05             	shl    $0x5,%ecx
    8336:	29 d1                	sub    %edx,%ecx
    8338:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    833b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    833e:	01 d0                	add    %edx,%eax
    8340:	83 c0 14             	add    $0x14,%eax
    8343:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
            for (sfb = 3; sfb < 6; sfb++)
                for (window = 0; window < 3; window++)
                    (*scalefac)[ch].s[window][sfb] = hgetbits(
                            slen[0][gr_info->scalefac_compress]);
            for (sfb = 6; sfb < 12; sfb++)
                for (window = 0; window < 3; window++)
    8347:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    834b:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    834f:	7e ae                	jle    82ff <III_get_scale_factors+0x121>
                        slen[0][gr_info->scalefac_compress]);
            for (sfb = 3; sfb < 6; sfb++)
                for (window = 0; window < 3; window++)
                    (*scalefac)[ch].s[window][sfb] = hgetbits(
                            slen[0][gr_info->scalefac_compress]);
            for (sfb = 6; sfb < 12; sfb++)
    8351:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8355:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    8359:	7e 9b                	jle    82f6 <III_get_scale_factors+0x118>
                for (window = 0; window < 3; window++)
                    (*scalefac)[ch].s[window][sfb] = hgetbits(
                            slen[1][gr_info->scalefac_compress]);
            for (sfb = 12, window = 0; window < 3; window++)
    835b:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    8362:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    8369:	eb 36                	jmp    83a1 <III_get_scale_factors+0x1c3>
                (*scalefac)[ch].s[window][sfb] = 0;
    836b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    836e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8371:	8b 4d 14             	mov    0x14(%ebp),%ecx
    8374:	89 d0                	mov    %edx,%eax
    8376:	01 c0                	add    %eax,%eax
    8378:	01 d0                	add    %edx,%eax
    837a:	c1 e0 02             	shl    $0x2,%eax
    837d:	01 d0                	add    %edx,%eax
    837f:	89 ca                	mov    %ecx,%edx
    8381:	01 d2                	add    %edx,%edx
    8383:	89 d1                	mov    %edx,%ecx
    8385:	c1 e1 05             	shl    $0x5,%ecx
    8388:	29 d1                	sub    %edx,%ecx
    838a:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    838d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8390:	01 d0                	add    %edx,%eax
    8392:	83 c0 14             	add    $0x14,%eax
    8395:	c7 44 83 0c 00 00 00 	movl   $0x0,0xc(%ebx,%eax,4)
    839c:	00 
                            slen[0][gr_info->scalefac_compress]);
            for (sfb = 6; sfb < 12; sfb++)
                for (window = 0; window < 3; window++)
                    (*scalefac)[ch].s[window][sfb] = hgetbits(
                            slen[1][gr_info->scalefac_compress]);
            for (sfb = 12, window = 0; window < 3; window++)
    839d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    83a1:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    83a5:	7e c4                	jle    836b <III_get_scale_factors+0x18d>
                           struct frame_params *fr_ps) {
    int sfb, i, window;
    struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
        if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    83a7:	e9 b1 01 00 00       	jmp    855d <III_get_scale_factors+0x37f>
                            slen[1][gr_info->scalefac_compress]);
            for (sfb = 12, window = 0; window < 3; window++)
                (*scalefac)[ch].s[window][sfb] = 0;
        }
        else {  /* SHORT*/
            for (i = 0; i < 2; i++)
    83ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    83b3:	e9 8f 00 00 00       	jmp    8447 <III_get_scale_factors+0x269>
                for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i + 1]; sfb++)
    83b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    83bb:	83 c0 04             	add    $0x4,%eax
    83be:	8b 04 85 04 f4 00 00 	mov    0xf404(,%eax,4),%eax
    83c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    83c8:	eb 64                	jmp    842e <III_get_scale_factors+0x250>
                    for (window = 0; window < 3; window++)
    83ca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    83d1:	eb 51                	jmp    8424 <III_get_scale_factors+0x246>
                        (*scalefac)[ch].s[window][sfb] = hgetbits(
                                slen[i][gr_info->scalefac_compress]);
    83d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    83d6:	8b 40 0c             	mov    0xc(%eax),%eax
        }
        else {  /* SHORT*/
            for (i = 0; i < 2; i++)
                for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i + 1]; sfb++)
                    for (window = 0; window < 3; window++)
                        (*scalefac)[ch].s[window][sfb] = hgetbits(
    83d9:	8b 55 f0             	mov    -0x10(%ebp),%edx
    83dc:	c1 e2 04             	shl    $0x4,%edx
    83df:	01 d0                	add    %edx,%eax
    83e1:	8b 04 85 20 f4 00 00 	mov    0xf420(,%eax,4),%eax
    83e8:	89 04 24             	mov    %eax,(%esp)
    83eb:	e8 28 da ff ff       	call   5e18 <hgetbits>
    83f0:	89 c6                	mov    %eax,%esi
    83f2:	8b 5d 08             	mov    0x8(%ebp),%ebx
    83f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
    83f8:	8b 4d 14             	mov    0x14(%ebp),%ecx
    83fb:	89 d0                	mov    %edx,%eax
    83fd:	01 c0                	add    %eax,%eax
    83ff:	01 d0                	add    %edx,%eax
    8401:	c1 e0 02             	shl    $0x2,%eax
    8404:	01 d0                	add    %edx,%eax
    8406:	89 ca                	mov    %ecx,%edx
    8408:	01 d2                	add    %edx,%edx
    840a:	89 d1                	mov    %edx,%ecx
    840c:	c1 e1 05             	shl    $0x5,%ecx
    840f:	29 d1                	sub    %edx,%ecx
    8411:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    8414:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8417:	01 d0                	add    %edx,%eax
    8419:	83 c0 14             	add    $0x14,%eax
    841c:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
                (*scalefac)[ch].s[window][sfb] = 0;
        }
        else {  /* SHORT*/
            for (i = 0; i < 2; i++)
                for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i + 1]; sfb++)
                    for (window = 0; window < 3; window++)
    8420:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8424:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    8428:	7e a9                	jle    83d3 <III_get_scale_factors+0x1f5>
            for (sfb = 12, window = 0; window < 3; window++)
                (*scalefac)[ch].s[window][sfb] = 0;
        }
        else {  /* SHORT*/
            for (i = 0; i < 2; i++)
                for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i + 1]; sfb++)
    842a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    842e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8431:	83 c0 01             	add    $0x1,%eax
    8434:	83 c0 04             	add    $0x4,%eax
    8437:	8b 04 85 04 f4 00 00 	mov    0xf404(,%eax,4),%eax
    843e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    8441:	7f 87                	jg     83ca <III_get_scale_factors+0x1ec>
                            slen[1][gr_info->scalefac_compress]);
            for (sfb = 12, window = 0; window < 3; window++)
                (*scalefac)[ch].s[window][sfb] = 0;
        }
        else {  /* SHORT*/
            for (i = 0; i < 2; i++)
    8443:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    8447:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    844b:	0f 8e 67 ff ff ff    	jle    83b8 <III_get_scale_factors+0x1da>
                for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i + 1]; sfb++)
                    for (window = 0; window < 3; window++)
                        (*scalefac)[ch].s[window][sfb] = hgetbits(
                                slen[i][gr_info->scalefac_compress]);
            for (sfb = 12, window = 0; window < 3; window++)
    8451:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    8458:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    845f:	eb 36                	jmp    8497 <III_get_scale_factors+0x2b9>
                (*scalefac)[ch].s[window][sfb] = 0;
    8461:	8b 5d 08             	mov    0x8(%ebp),%ebx
    8464:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8467:	8b 4d 14             	mov    0x14(%ebp),%ecx
    846a:	89 d0                	mov    %edx,%eax
    846c:	01 c0                	add    %eax,%eax
    846e:	01 d0                	add    %edx,%eax
    8470:	c1 e0 02             	shl    $0x2,%eax
    8473:	01 d0                	add    %edx,%eax
    8475:	89 ca                	mov    %ecx,%edx
    8477:	01 d2                	add    %edx,%edx
    8479:	89 d1                	mov    %edx,%ecx
    847b:	c1 e1 05             	shl    $0x5,%ecx
    847e:	29 d1                	sub    %edx,%ecx
    8480:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    8483:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8486:	01 d0                	add    %edx,%eax
    8488:	83 c0 14             	add    $0x14,%eax
    848b:	c7 44 83 0c 00 00 00 	movl   $0x0,0xc(%ebx,%eax,4)
    8492:	00 
            for (i = 0; i < 2; i++)
                for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i + 1]; sfb++)
                    for (window = 0; window < 3; window++)
                        (*scalefac)[ch].s[window][sfb] = hgetbits(
                                slen[i][gr_info->scalefac_compress]);
            for (sfb = 12, window = 0; window < 3; window++)
    8493:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8497:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    849b:	7e c4                	jle    8461 <III_get_scale_factors+0x283>
                           struct frame_params *fr_ps) {
    int sfb, i, window;
    struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
        if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    849d:	e9 bb 00 00 00       	jmp    855d <III_get_scale_factors+0x37f>
            for (sfb = 12, window = 0; window < 3; window++)
                (*scalefac)[ch].s[window][sfb] = 0;
        }
    }
    else {   /* LONG types 0,1,3 */
        for (i = 0; i < 4; i++) {
    84a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    84a9:	e9 89 00 00 00       	jmp    8537 <III_get_scale_factors+0x359>
            if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
    84ae:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    84b1:	8b 55 14             	mov    0x14(%ebp),%edx
    84b4:	89 d0                	mov    %edx,%eax
    84b6:	c1 e0 02             	shl    $0x2,%eax
    84b9:	01 d0                	add    %edx,%eax
    84bb:	c1 e0 03             	shl    $0x3,%eax
    84be:	8b 55 f0             	mov    -0x10(%ebp),%edx
    84c1:	01 d0                	add    %edx,%eax
    84c3:	8b 44 81 08          	mov    0x8(%ecx,%eax,4),%eax
    84c7:	85 c0                	test   %eax,%eax
    84c9:	74 06                	je     84d1 <III_get_scale_factors+0x2f3>
    84cb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    84cf:	75 62                	jne    8533 <III_get_scale_factors+0x355>
                for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i + 1]; sfb++)
    84d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    84d4:	8b 04 85 00 f4 00 00 	mov    0xf400(,%eax,4),%eax
    84db:	89 45 f4             	mov    %eax,-0xc(%ebp)
    84de:	eb 41                	jmp    8521 <III_get_scale_factors+0x343>
                    (*scalefac)[ch].l[sfb] = hgetbits(
                            slen[(i < 2) ? 0 : 1][gr_info->scalefac_compress]);
    84e0:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    84e4:	0f 9f c0             	setg   %al
    84e7:	0f b6 d0             	movzbl %al,%edx
    84ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
    84ed:	8b 40 0c             	mov    0xc(%eax),%eax
    }
    else {   /* LONG types 0,1,3 */
        for (i = 0; i < 4; i++) {
            if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
                for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i + 1]; sfb++)
                    (*scalefac)[ch].l[sfb] = hgetbits(
    84f0:	c1 e2 04             	shl    $0x4,%edx
    84f3:	01 d0                	add    %edx,%eax
    84f5:	8b 04 85 20 f4 00 00 	mov    0xf420(,%eax,4),%eax
    84fc:	89 04 24             	mov    %eax,(%esp)
    84ff:	e8 14 d9 ff ff       	call   5e18 <hgetbits>
    8504:	89 c3                	mov    %eax,%ebx
    8506:	8b 4d 08             	mov    0x8(%ebp),%ecx
    8509:	8b 45 14             	mov    0x14(%ebp),%eax
    850c:	01 c0                	add    %eax,%eax
    850e:	89 c2                	mov    %eax,%edx
    8510:	c1 e2 05             	shl    $0x5,%edx
    8513:	29 c2                	sub    %eax,%edx
    8515:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8518:	01 d0                	add    %edx,%eax
    851a:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
        }
    }
    else {   /* LONG types 0,1,3 */
        for (i = 0; i < 4; i++) {
            if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
                for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i + 1]; sfb++)
    851d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8521:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8524:	83 c0 01             	add    $0x1,%eax
    8527:	8b 04 85 00 f4 00 00 	mov    0xf400(,%eax,4),%eax
    852e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    8531:	7f ad                	jg     84e0 <III_get_scale_factors+0x302>
            for (sfb = 12, window = 0; window < 3; window++)
                (*scalefac)[ch].s[window][sfb] = 0;
        }
    }
    else {   /* LONG types 0,1,3 */
        for (i = 0; i < 4; i++) {
    8533:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    8537:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    853b:	0f 8e 6d ff ff ff    	jle    84ae <III_get_scale_factors+0x2d0>
            if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
                for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i + 1]; sfb++)
                    (*scalefac)[ch].l[sfb] = hgetbits(
                            slen[(i < 2) ? 0 : 1][gr_info->scalefac_compress]);
        }
        (*scalefac)[ch].l[22] = 0;
    8541:	8b 4d 08             	mov    0x8(%ebp),%ecx
    8544:	8b 45 14             	mov    0x14(%ebp),%eax
    8547:	c1 e0 03             	shl    $0x3,%eax
    854a:	89 c2                	mov    %eax,%edx
    854c:	c1 e2 05             	shl    $0x5,%edx
    854f:	29 c2                	sub    %eax,%edx
    8551:	8d 04 11             	lea    (%ecx,%edx,1),%eax
    8554:	83 c0 58             	add    $0x58,%eax
    8557:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    }
}
    855d:	83 c4 20             	add    $0x20,%esp
    8560:	5b                   	pop    %ebx
    8561:	5e                   	pop    %esi
    8562:	5d                   	pop    %ebp
    8563:	c3                   	ret    

00008564 <initialize_huffman>:
/* �Ѿ��� huffman.c������
struct huffcodetab ht[HTN];
*/
int huffman_initialized = FALSE;

void initialize_huffman() {
    8564:	55                   	push   %ebp
    8565:	89 e5                	mov    %esp,%ebp
    8567:	83 ec 08             	sub    $0x8,%esp
    if (huffman_initialized) return;
    856a:	a1 60 f7 00 00       	mov    0xf760,%eax
    856f:	85 c0                	test   %eax,%eax
    8571:	74 02                	je     8575 <initialize_huffman+0x11>
    8573:	eb 0f                	jmp    8584 <initialize_huffman+0x20>
    read_decoder_table();
    8575:	e8 03 d9 ff ff       	call   5e7d <read_decoder_table>
    huffman_initialized = TRUE;
    857a:	c7 05 60 f7 00 00 01 	movl   $0x1,0xf760
    8581:	00 00 00 
}
    8584:	c9                   	leave  
    8585:	c3                   	ret    

00008586 <III_hufman_decode>:


void III_hufman_decode(long int is[SBLIMIT][SSLIMIT], struct III_side_info_t *si, int ch, int gr, int part2_start,
                       struct frame_params *fr_ps) {
    8586:	55                   	push   %ebp
    8587:	89 e5                	mov    %esp,%ebp
    8589:	57                   	push   %edi
    858a:	56                   	push   %esi
    858b:	53                   	push   %ebx
    858c:	83 ec 4c             	sub    $0x4c,%esp
    struct huffcodetab *h;
    int region1Start;
    int region2Start;
    //int bt = (*si).ch[ch].gr[gr].window_switching_flag && ((*si).ch[ch].gr[gr].block_type == 2);

    initialize_huffman();
    858f:	e8 d0 ff ff ff       	call   8564 <initialize_huffman>

    /* ��������߽� */

    if (((*si).ch[ch].gr[gr].window_switching_flag) &&
    8594:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8597:	8b 45 14             	mov    0x14(%ebp),%eax
    859a:	8b 4d 10             	mov    0x10(%ebp),%ecx
    859d:	89 c2                	mov    %eax,%edx
    859f:	c1 e2 03             	shl    $0x3,%edx
    85a2:	01 c2                	add    %eax,%edx
    85a4:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    85ab:	89 c2                	mov    %eax,%edx
    85ad:	89 c8                	mov    %ecx,%eax
    85af:	c1 e0 02             	shl    $0x2,%eax
    85b2:	01 c8                	add    %ecx,%eax
    85b4:	c1 e0 05             	shl    $0x5,%eax
    85b7:	01 d0                	add    %edx,%eax
    85b9:	01 d8                	add    %ebx,%eax
    85bb:	83 c0 28             	add    $0x28,%eax
    85be:	8b 00                	mov    (%eax),%eax
    85c0:	85 c0                	test   %eax,%eax
    85c2:	74 44                	je     8608 <III_hufman_decode+0x82>
        ((*si).ch[ch].gr[gr].block_type == 2)) {
    85c4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    85c7:	8b 45 14             	mov    0x14(%ebp),%eax
    85ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
    85cd:	89 c2                	mov    %eax,%edx
    85cf:	c1 e2 03             	shl    $0x3,%edx
    85d2:	01 c2                	add    %eax,%edx
    85d4:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    85db:	89 c2                	mov    %eax,%edx
    85dd:	89 c8                	mov    %ecx,%eax
    85df:	c1 e0 02             	shl    $0x2,%eax
    85e2:	01 c8                	add    %ecx,%eax
    85e4:	c1 e0 05             	shl    $0x5,%eax
    85e7:	01 d0                	add    %edx,%eax
    85e9:	01 d8                	add    %ebx,%eax
    85eb:	83 c0 2c             	add    $0x2c,%eax
    85ee:	8b 00                	mov    (%eax),%eax

    initialize_huffman();

    /* ��������߽� */

    if (((*si).ch[ch].gr[gr].window_switching_flag) &&
    85f0:	83 f8 02             	cmp    $0x2,%eax
    85f3:	75 13                	jne    8608 <III_hufman_decode+0x82>
        ((*si).ch[ch].gr[gr].block_type == 2)) {

        /* Region2. */

        region1Start = 36;  /* sfb[9/3]*3=36 */
    85f5:	c7 45 dc 24 00 00 00 	movl   $0x24,-0x24(%ebp)
        region2Start = 576; /* No Region2 for short block case. */
    85fc:	c7 45 d8 40 02 00 00 	movl   $0x240,-0x28(%ebp)
    8603:	e9 cc 00 00 00       	jmp    86d4 <III_hufman_decode+0x14e>
    }


    else {          /* ���ҳ�������µ�����߽�. */

        region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
    8608:	8b 45 1c             	mov    0x1c(%ebp),%eax
    860b:	8b 00                	mov    (%eax),%eax
    860d:	8b 48 10             	mov    0x10(%eax),%ecx
                .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
    8610:	8b 75 0c             	mov    0xc(%ebp),%esi
    8613:	8b 45 14             	mov    0x14(%ebp),%eax
    8616:	8b 5d 10             	mov    0x10(%ebp),%ebx
    8619:	89 c2                	mov    %eax,%edx
    861b:	c1 e2 03             	shl    $0x3,%edx
    861e:	01 c2                	add    %eax,%edx
    8620:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8627:	89 c2                	mov    %eax,%edx
    8629:	89 d8                	mov    %ebx,%eax
    862b:	c1 e0 02             	shl    $0x2,%eax
    862e:	01 d8                	add    %ebx,%eax
    8630:	c1 e0 05             	shl    $0x5,%eax
    8633:	01 d0                	add    %edx,%eax
    8635:	01 f0                	add    %esi,%eax
    8637:	83 c0 4c             	add    $0x4c,%eax
    863a:	8b 00                	mov    (%eax),%eax
    863c:	8d 50 01             	lea    0x1(%eax),%edx
    }


    else {          /* ���ҳ�������µ�����߽�. */

        region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
    863f:	89 c8                	mov    %ecx,%eax
    8641:	c1 e0 03             	shl    $0x3,%eax
    8644:	01 c8                	add    %ecx,%eax
    8646:	c1 e0 02             	shl    $0x2,%eax
    8649:	01 c8                	add    %ecx,%eax
    864b:	01 d0                	add    %edx,%eax
    864d:	8b 04 85 a0 f4 00 00 	mov    0xf4a0(,%eax,4),%eax
    8654:	89 45 dc             	mov    %eax,-0x24(%ebp)
                .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
        region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
    8657:	8b 45 1c             	mov    0x1c(%ebp),%eax
    865a:	8b 00                	mov    (%eax),%eax
    865c:	8b 48 10             	mov    0x10(%eax),%ecx
                .l[(*si).ch[ch].gr[gr].region0_count +
    865f:	8b 75 0c             	mov    0xc(%ebp),%esi
    8662:	8b 45 14             	mov    0x14(%ebp),%eax
    8665:	8b 5d 10             	mov    0x10(%ebp),%ebx
    8668:	89 c2                	mov    %eax,%edx
    866a:	c1 e2 03             	shl    $0x3,%edx
    866d:	01 c2                	add    %eax,%edx
    866f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8676:	89 c2                	mov    %eax,%edx
    8678:	89 d8                	mov    %ebx,%eax
    867a:	c1 e0 02             	shl    $0x2,%eax
    867d:	01 d8                	add    %ebx,%eax
    867f:	c1 e0 05             	shl    $0x5,%eax
    8682:	01 d0                	add    %edx,%eax
    8684:	01 f0                	add    %esi,%eax
    8686:	83 c0 4c             	add    $0x4c,%eax
    8689:	8b 30                	mov    (%eax),%esi
                   (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
    868b:	8b 7d 0c             	mov    0xc(%ebp),%edi
    868e:	8b 45 14             	mov    0x14(%ebp),%eax
    8691:	8b 5d 10             	mov    0x10(%ebp),%ebx
    8694:	89 c2                	mov    %eax,%edx
    8696:	c1 e2 03             	shl    $0x3,%edx
    8699:	01 c2                	add    %eax,%edx
    869b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    86a2:	89 c2                	mov    %eax,%edx
    86a4:	89 d8                	mov    %ebx,%eax
    86a6:	c1 e0 02             	shl    $0x2,%eax
    86a9:	01 d8                	add    %ebx,%eax
    86ab:	c1 e0 05             	shl    $0x5,%eax
    86ae:	01 d0                	add    %edx,%eax
    86b0:	01 f8                	add    %edi,%eax
    86b2:	83 c0 50             	add    $0x50,%eax
    86b5:	8b 00                	mov    (%eax),%eax
    else {          /* ���ҳ�������µ�����߽�. */

        region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
                .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
        region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
                .l[(*si).ch[ch].gr[gr].region0_count +
    86b7:	01 f0                	add    %esi,%eax
                   (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
    86b9:	8d 50 02             	lea    0x2(%eax),%edx

    else {          /* ���ҳ�������µ�����߽�. */

        region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
                .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
        region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
    86bc:	89 c8                	mov    %ecx,%eax
    86be:	c1 e0 03             	shl    $0x3,%eax
    86c1:	01 c8                	add    %ecx,%eax
    86c3:	c1 e0 02             	shl    $0x2,%eax
    86c6:	01 c8                	add    %ecx,%eax
    86c8:	01 d0                	add    %edx,%eax
    86ca:	8b 04 85 a0 f4 00 00 	mov    0xf4a0(,%eax,4),%eax
    86d1:	89 45 d8             	mov    %eax,-0x28(%ebp)
                   (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
    }


    /* ��ȡ��ֵ����Read bigvalues area. */
    for (i = 0; i < (*si).ch[ch].gr[gr].big_values * 2; i += 2) {
    86d4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    86db:	e9 ac 01 00 00       	jmp    888c <III_hufman_decode+0x306>
        if (i < region1Start) h = &ht[(*si).ch[ch].gr[gr].table_select[0]];
    86e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    86e3:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    86e6:	7d 43                	jge    872b <III_hufman_decode+0x1a5>
    86e8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    86eb:	8b 45 14             	mov    0x14(%ebp),%eax
    86ee:	8b 4d 10             	mov    0x10(%ebp),%ecx
    86f1:	89 c2                	mov    %eax,%edx
    86f3:	c1 e2 03             	shl    $0x3,%edx
    86f6:	01 c2                	add    %eax,%edx
    86f8:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    86ff:	89 c2                	mov    %eax,%edx
    8701:	89 c8                	mov    %ecx,%eax
    8703:	c1 e0 02             	shl    $0x2,%eax
    8706:	01 c8                	add    %ecx,%eax
    8708:	c1 e0 05             	shl    $0x5,%eax
    870b:	01 d0                	add    %edx,%eax
    870d:	01 d8                	add    %ebx,%eax
    870f:	83 c0 34             	add    $0x34,%eax
    8712:	8b 10                	mov    (%eax),%edx
    8714:	89 d0                	mov    %edx,%eax
    8716:	c1 e0 02             	shl    $0x2,%eax
    8719:	01 d0                	add    %edx,%eax
    871b:	c1 e0 03             	shl    $0x3,%eax
    871e:	05 40 29 01 00       	add    $0x12940,%eax
    8723:	89 45 e0             	mov    %eax,-0x20(%ebp)
    8726:	e9 86 00 00 00       	jmp    87b1 <III_hufman_decode+0x22b>
        else if (i < region2Start) h = &ht[(*si).ch[ch].gr[gr].table_select[1]];
    872b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    872e:	3b 45 d8             	cmp    -0x28(%ebp),%eax
    8731:	7d 40                	jge    8773 <III_hufman_decode+0x1ed>
    8733:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8736:	8b 45 14             	mov    0x14(%ebp),%eax
    8739:	8b 4d 10             	mov    0x10(%ebp),%ecx
    873c:	89 c2                	mov    %eax,%edx
    873e:	c1 e2 03             	shl    $0x3,%edx
    8741:	01 c2                	add    %eax,%edx
    8743:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    874a:	89 c2                	mov    %eax,%edx
    874c:	89 c8                	mov    %ecx,%eax
    874e:	c1 e0 02             	shl    $0x2,%eax
    8751:	01 c8                	add    %ecx,%eax
    8753:	c1 e0 05             	shl    $0x5,%eax
    8756:	01 d0                	add    %edx,%eax
    8758:	01 d8                	add    %ebx,%eax
    875a:	83 c0 38             	add    $0x38,%eax
    875d:	8b 10                	mov    (%eax),%edx
    875f:	89 d0                	mov    %edx,%eax
    8761:	c1 e0 02             	shl    $0x2,%eax
    8764:	01 d0                	add    %edx,%eax
    8766:	c1 e0 03             	shl    $0x3,%eax
    8769:	05 40 29 01 00       	add    $0x12940,%eax
    876e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    8771:	eb 3e                	jmp    87b1 <III_hufman_decode+0x22b>
        else h = &ht[(*si).ch[ch].gr[gr].table_select[2]];
    8773:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8776:	8b 45 14             	mov    0x14(%ebp),%eax
    8779:	8b 4d 10             	mov    0x10(%ebp),%ecx
    877c:	89 c2                	mov    %eax,%edx
    877e:	c1 e2 03             	shl    $0x3,%edx
    8781:	01 c2                	add    %eax,%edx
    8783:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    878a:	89 c2                	mov    %eax,%edx
    878c:	89 c8                	mov    %ecx,%eax
    878e:	c1 e0 02             	shl    $0x2,%eax
    8791:	01 c8                	add    %ecx,%eax
    8793:	c1 e0 05             	shl    $0x5,%eax
    8796:	01 d0                	add    %edx,%eax
    8798:	01 d8                	add    %ebx,%eax
    879a:	83 c0 3c             	add    $0x3c,%eax
    879d:	8b 10                	mov    (%eax),%edx
    879f:	89 d0                	mov    %edx,%eax
    87a1:	c1 e0 02             	shl    $0x2,%eax
    87a4:	01 d0                	add    %edx,%eax
    87a6:	c1 e0 03             	shl    $0x3,%eax
    87a9:	05 40 29 01 00       	add    $0x12940,%eax
    87ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
        huffman_decoder(h, &x, &y, &v, &w);
    87b1:	8d 45 c8             	lea    -0x38(%ebp),%eax
    87b4:	89 44 24 10          	mov    %eax,0x10(%esp)
    87b8:	8d 45 cc             	lea    -0x34(%ebp),%eax
    87bb:	89 44 24 0c          	mov    %eax,0xc(%esp)
    87bf:	8d 45 d0             	lea    -0x30(%ebp),%eax
    87c2:	89 44 24 08          	mov    %eax,0x8(%esp)
    87c6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    87c9:	89 44 24 04          	mov    %eax,0x4(%esp)
    87cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    87d0:	89 04 24             	mov    %eax,(%esp)
    87d3:	e8 fd ee ff ff       	call   76d5 <huffman_decoder>
        is[i / SSLIMIT][i % SSLIMIT] = x;
    87d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    87db:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    87e0:	89 c8                	mov    %ecx,%eax
    87e2:	f7 ea                	imul   %edx
    87e4:	c1 fa 02             	sar    $0x2,%edx
    87e7:	89 c8                	mov    %ecx,%eax
    87e9:	c1 f8 1f             	sar    $0x1f,%eax
    87ec:	29 c2                	sub    %eax,%edx
    87ee:	89 d0                	mov    %edx,%eax
    87f0:	89 c2                	mov    %eax,%edx
    87f2:	89 d0                	mov    %edx,%eax
    87f4:	c1 e0 03             	shl    $0x3,%eax
    87f7:	01 d0                	add    %edx,%eax
    87f9:	c1 e0 03             	shl    $0x3,%eax
    87fc:	89 c2                	mov    %eax,%edx
    87fe:	8b 45 08             	mov    0x8(%ebp),%eax
    8801:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8804:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    8807:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    880c:	89 c8                	mov    %ecx,%eax
    880e:	f7 ea                	imul   %edx
    8810:	c1 fa 02             	sar    $0x2,%edx
    8813:	89 c8                	mov    %ecx,%eax
    8815:	c1 f8 1f             	sar    $0x1f,%eax
    8818:	29 c2                	sub    %eax,%edx
    881a:	89 d0                	mov    %edx,%eax
    881c:	c1 e0 03             	shl    $0x3,%eax
    881f:	01 d0                	add    %edx,%eax
    8821:	01 c0                	add    %eax,%eax
    8823:	29 c1                	sub    %eax,%ecx
    8825:	89 ca                	mov    %ecx,%edx
    8827:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    882a:	89 04 93             	mov    %eax,(%ebx,%edx,4)
        is[(i + 1) / SSLIMIT][(i + 1) % SSLIMIT] = y;
    882d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    8830:	8d 48 01             	lea    0x1(%eax),%ecx
    8833:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8838:	89 c8                	mov    %ecx,%eax
    883a:	f7 ea                	imul   %edx
    883c:	c1 fa 02             	sar    $0x2,%edx
    883f:	89 c8                	mov    %ecx,%eax
    8841:	c1 f8 1f             	sar    $0x1f,%eax
    8844:	29 c2                	sub    %eax,%edx
    8846:	89 d0                	mov    %edx,%eax
    8848:	89 c2                	mov    %eax,%edx
    884a:	89 d0                	mov    %edx,%eax
    884c:	c1 e0 03             	shl    $0x3,%eax
    884f:	01 d0                	add    %edx,%eax
    8851:	c1 e0 03             	shl    $0x3,%eax
    8854:	89 c2                	mov    %eax,%edx
    8856:	8b 45 08             	mov    0x8(%ebp),%eax
    8859:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    885c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    885f:	8d 48 01             	lea    0x1(%eax),%ecx
    8862:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8867:	89 c8                	mov    %ecx,%eax
    8869:	f7 ea                	imul   %edx
    886b:	c1 fa 02             	sar    $0x2,%edx
    886e:	89 c8                	mov    %ecx,%eax
    8870:	c1 f8 1f             	sar    $0x1f,%eax
    8873:	29 c2                	sub    %eax,%edx
    8875:	89 d0                	mov    %edx,%eax
    8877:	c1 e0 03             	shl    $0x3,%eax
    887a:	01 d0                	add    %edx,%eax
    887c:	01 c0                	add    %eax,%eax
    887e:	29 c1                	sub    %eax,%ecx
    8880:	89 ca                	mov    %ecx,%edx
    8882:	8b 45 d0             	mov    -0x30(%ebp),%eax
    8885:	89 04 93             	mov    %eax,(%ebx,%edx,4)
                   (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
    }


    /* ��ȡ��ֵ����Read bigvalues area. */
    for (i = 0; i < (*si).ch[ch].gr[gr].big_values * 2; i += 2) {
    8888:	83 45 e4 02          	addl   $0x2,-0x1c(%ebp)
    888c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    888f:	8b 75 0c             	mov    0xc(%ebp),%esi
    8892:	8b 45 14             	mov    0x14(%ebp),%eax
    8895:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8898:	89 c2                	mov    %eax,%edx
    889a:	c1 e2 03             	shl    $0x3,%edx
    889d:	01 c2                	add    %eax,%edx
    889f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    88a6:	89 c2                	mov    %eax,%edx
    88a8:	89 c8                	mov    %ecx,%eax
    88aa:	c1 e0 02             	shl    $0x2,%eax
    88ad:	01 c8                	add    %ecx,%eax
    88af:	c1 e0 05             	shl    $0x5,%eax
    88b2:	01 d0                	add    %edx,%eax
    88b4:	01 f0                	add    %esi,%eax
    88b6:	83 c0 1c             	add    $0x1c,%eax
    88b9:	8b 00                	mov    (%eax),%eax
    88bb:	01 c0                	add    %eax,%eax
    88bd:	39 c3                	cmp    %eax,%ebx
    88bf:	0f 82 1b fe ff ff    	jb     86e0 <III_hufman_decode+0x15a>
        is[i / SSLIMIT][i % SSLIMIT] = x;
        is[(i + 1) / SSLIMIT][(i + 1) % SSLIMIT] = y;
    }

    /* Read count1 area. */
    h = &ht[(*si).ch[ch].gr[gr].count1table_select + 32];
    88c5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    88c8:	8b 45 14             	mov    0x14(%ebp),%eax
    88cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
    88ce:	89 c2                	mov    %eax,%edx
    88d0:	c1 e2 03             	shl    $0x3,%edx
    88d3:	01 c2                	add    %eax,%edx
    88d5:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    88dc:	89 c2                	mov    %eax,%edx
    88de:	89 c8                	mov    %ecx,%eax
    88e0:	c1 e0 02             	shl    $0x2,%eax
    88e3:	01 c8                	add    %ecx,%eax
    88e5:	c1 e0 05             	shl    $0x5,%eax
    88e8:	01 d0                	add    %edx,%eax
    88ea:	01 d8                	add    %ebx,%eax
    88ec:	83 c0 5c             	add    $0x5c,%eax
    88ef:	8b 00                	mov    (%eax),%eax
    88f1:	8d 50 20             	lea    0x20(%eax),%edx
    88f4:	89 d0                	mov    %edx,%eax
    88f6:	c1 e0 02             	shl    $0x2,%eax
    88f9:	01 d0                	add    %edx,%eax
    88fb:	c1 e0 03             	shl    $0x3,%eax
    88fe:	05 40 29 01 00       	add    $0x12940,%eax
    8903:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while ((hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length) &&
    8906:	e9 91 01 00 00       	jmp    8a9c <III_hufman_decode+0x516>
           (i < SSLIMIT * SBLIMIT)) {
        huffman_decoder(h, &x, &y, &v, &w);
    890b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    890e:	89 44 24 10          	mov    %eax,0x10(%esp)
    8912:	8d 45 cc             	lea    -0x34(%ebp),%eax
    8915:	89 44 24 0c          	mov    %eax,0xc(%esp)
    8919:	8d 45 d0             	lea    -0x30(%ebp),%eax
    891c:	89 44 24 08          	mov    %eax,0x8(%esp)
    8920:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    8923:	89 44 24 04          	mov    %eax,0x4(%esp)
    8927:	8b 45 e0             	mov    -0x20(%ebp),%eax
    892a:	89 04 24             	mov    %eax,(%esp)
    892d:	e8 a3 ed ff ff       	call   76d5 <huffman_decoder>
        is[i / SSLIMIT][i % SSLIMIT] = v;
    8932:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    8935:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    893a:	89 c8                	mov    %ecx,%eax
    893c:	f7 ea                	imul   %edx
    893e:	c1 fa 02             	sar    $0x2,%edx
    8941:	89 c8                	mov    %ecx,%eax
    8943:	c1 f8 1f             	sar    $0x1f,%eax
    8946:	29 c2                	sub    %eax,%edx
    8948:	89 d0                	mov    %edx,%eax
    894a:	89 c2                	mov    %eax,%edx
    894c:	89 d0                	mov    %edx,%eax
    894e:	c1 e0 03             	shl    $0x3,%eax
    8951:	01 d0                	add    %edx,%eax
    8953:	c1 e0 03             	shl    $0x3,%eax
    8956:	89 c2                	mov    %eax,%edx
    8958:	8b 45 08             	mov    0x8(%ebp),%eax
    895b:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    895e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    8961:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8966:	89 c8                	mov    %ecx,%eax
    8968:	f7 ea                	imul   %edx
    896a:	c1 fa 02             	sar    $0x2,%edx
    896d:	89 c8                	mov    %ecx,%eax
    896f:	c1 f8 1f             	sar    $0x1f,%eax
    8972:	29 c2                	sub    %eax,%edx
    8974:	89 d0                	mov    %edx,%eax
    8976:	c1 e0 03             	shl    $0x3,%eax
    8979:	01 d0                	add    %edx,%eax
    897b:	01 c0                	add    %eax,%eax
    897d:	29 c1                	sub    %eax,%ecx
    897f:	89 ca                	mov    %ecx,%edx
    8981:	8b 45 cc             	mov    -0x34(%ebp),%eax
    8984:	89 04 93             	mov    %eax,(%ebx,%edx,4)
        is[(i + 1) / SSLIMIT][(i + 1) % SSLIMIT] = w;
    8987:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    898a:	8d 48 01             	lea    0x1(%eax),%ecx
    898d:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8992:	89 c8                	mov    %ecx,%eax
    8994:	f7 ea                	imul   %edx
    8996:	c1 fa 02             	sar    $0x2,%edx
    8999:	89 c8                	mov    %ecx,%eax
    899b:	c1 f8 1f             	sar    $0x1f,%eax
    899e:	29 c2                	sub    %eax,%edx
    89a0:	89 d0                	mov    %edx,%eax
    89a2:	89 c2                	mov    %eax,%edx
    89a4:	89 d0                	mov    %edx,%eax
    89a6:	c1 e0 03             	shl    $0x3,%eax
    89a9:	01 d0                	add    %edx,%eax
    89ab:	c1 e0 03             	shl    $0x3,%eax
    89ae:	89 c2                	mov    %eax,%edx
    89b0:	8b 45 08             	mov    0x8(%ebp),%eax
    89b3:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    89b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    89b9:	8d 48 01             	lea    0x1(%eax),%ecx
    89bc:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    89c1:	89 c8                	mov    %ecx,%eax
    89c3:	f7 ea                	imul   %edx
    89c5:	c1 fa 02             	sar    $0x2,%edx
    89c8:	89 c8                	mov    %ecx,%eax
    89ca:	c1 f8 1f             	sar    $0x1f,%eax
    89cd:	29 c2                	sub    %eax,%edx
    89cf:	89 d0                	mov    %edx,%eax
    89d1:	c1 e0 03             	shl    $0x3,%eax
    89d4:	01 d0                	add    %edx,%eax
    89d6:	01 c0                	add    %eax,%eax
    89d8:	29 c1                	sub    %eax,%ecx
    89da:	89 ca                	mov    %ecx,%edx
    89dc:	8b 45 c8             	mov    -0x38(%ebp),%eax
    89df:	89 04 93             	mov    %eax,(%ebx,%edx,4)
        is[(i + 2) / SSLIMIT][(i + 2) % SSLIMIT] = x;
    89e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    89e5:	8d 48 02             	lea    0x2(%eax),%ecx
    89e8:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    89ed:	89 c8                	mov    %ecx,%eax
    89ef:	f7 ea                	imul   %edx
    89f1:	c1 fa 02             	sar    $0x2,%edx
    89f4:	89 c8                	mov    %ecx,%eax
    89f6:	c1 f8 1f             	sar    $0x1f,%eax
    89f9:	29 c2                	sub    %eax,%edx
    89fb:	89 d0                	mov    %edx,%eax
    89fd:	89 c2                	mov    %eax,%edx
    89ff:	89 d0                	mov    %edx,%eax
    8a01:	c1 e0 03             	shl    $0x3,%eax
    8a04:	01 d0                	add    %edx,%eax
    8a06:	c1 e0 03             	shl    $0x3,%eax
    8a09:	89 c2                	mov    %eax,%edx
    8a0b:	8b 45 08             	mov    0x8(%ebp),%eax
    8a0e:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8a11:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    8a14:	8d 48 02             	lea    0x2(%eax),%ecx
    8a17:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8a1c:	89 c8                	mov    %ecx,%eax
    8a1e:	f7 ea                	imul   %edx
    8a20:	c1 fa 02             	sar    $0x2,%edx
    8a23:	89 c8                	mov    %ecx,%eax
    8a25:	c1 f8 1f             	sar    $0x1f,%eax
    8a28:	29 c2                	sub    %eax,%edx
    8a2a:	89 d0                	mov    %edx,%eax
    8a2c:	c1 e0 03             	shl    $0x3,%eax
    8a2f:	01 d0                	add    %edx,%eax
    8a31:	01 c0                	add    %eax,%eax
    8a33:	29 c1                	sub    %eax,%ecx
    8a35:	89 ca                	mov    %ecx,%edx
    8a37:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    8a3a:	89 04 93             	mov    %eax,(%ebx,%edx,4)
        is[(i + 3) / SSLIMIT][(i + 3) % SSLIMIT] = y;
    8a3d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    8a40:	8d 48 03             	lea    0x3(%eax),%ecx
    8a43:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8a48:	89 c8                	mov    %ecx,%eax
    8a4a:	f7 ea                	imul   %edx
    8a4c:	c1 fa 02             	sar    $0x2,%edx
    8a4f:	89 c8                	mov    %ecx,%eax
    8a51:	c1 f8 1f             	sar    $0x1f,%eax
    8a54:	29 c2                	sub    %eax,%edx
    8a56:	89 d0                	mov    %edx,%eax
    8a58:	89 c2                	mov    %eax,%edx
    8a5a:	89 d0                	mov    %edx,%eax
    8a5c:	c1 e0 03             	shl    $0x3,%eax
    8a5f:	01 d0                	add    %edx,%eax
    8a61:	c1 e0 03             	shl    $0x3,%eax
    8a64:	89 c2                	mov    %eax,%edx
    8a66:	8b 45 08             	mov    0x8(%ebp),%eax
    8a69:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8a6c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    8a6f:	8d 48 03             	lea    0x3(%eax),%ecx
    8a72:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8a77:	89 c8                	mov    %ecx,%eax
    8a79:	f7 ea                	imul   %edx
    8a7b:	c1 fa 02             	sar    $0x2,%edx
    8a7e:	89 c8                	mov    %ecx,%eax
    8a80:	c1 f8 1f             	sar    $0x1f,%eax
    8a83:	29 c2                	sub    %eax,%edx
    8a85:	89 d0                	mov    %edx,%eax
    8a87:	c1 e0 03             	shl    $0x3,%eax
    8a8a:	01 d0                	add    %edx,%eax
    8a8c:	01 c0                	add    %eax,%eax
    8a8e:	29 c1                	sub    %eax,%ecx
    8a90:	89 ca                	mov    %ecx,%edx
    8a92:	8b 45 d0             	mov    -0x30(%ebp),%eax
    8a95:	89 04 93             	mov    %eax,(%ebx,%edx,4)
        i += 4;
    8a98:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
        is[(i + 1) / SSLIMIT][(i + 1) % SSLIMIT] = y;
    }

    /* Read count1 area. */
    h = &ht[(*si).ch[ch].gr[gr].count1table_select + 32];
    while ((hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length) &&
    8a9c:	e8 5b d3 ff ff       	call   5dfc <hsstell>
    8aa1:	89 c3                	mov    %eax,%ebx
    8aa3:	8b 75 0c             	mov    0xc(%ebp),%esi
    8aa6:	8b 45 14             	mov    0x14(%ebp),%eax
    8aa9:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8aac:	89 c2                	mov    %eax,%edx
    8aae:	c1 e2 03             	shl    $0x3,%edx
    8ab1:	01 c2                	add    %eax,%edx
    8ab3:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8aba:	89 c2                	mov    %eax,%edx
    8abc:	89 c8                	mov    %ecx,%eax
    8abe:	c1 e0 02             	shl    $0x2,%eax
    8ac1:	01 c8                	add    %ecx,%eax
    8ac3:	c1 e0 05             	shl    $0x5,%eax
    8ac6:	01 d0                	add    %edx,%eax
    8ac8:	01 f0                	add    %esi,%eax
    8aca:	83 c0 18             	add    $0x18,%eax
    8acd:	8b 10                	mov    (%eax),%edx
    8acf:	8b 45 18             	mov    0x18(%ebp),%eax
    8ad2:	01 d0                	add    %edx,%eax
    8ad4:	39 c3                	cmp    %eax,%ebx
    8ad6:	73 0d                	jae    8ae5 <III_hufman_decode+0x55f>
    8ad8:	81 7d e4 3f 02 00 00 	cmpl   $0x23f,-0x1c(%ebp)
    8adf:	0f 8e 26 fe ff ff    	jle    890b <III_hufman_decode+0x385>
        is[(i + 2) / SSLIMIT][(i + 2) % SSLIMIT] = x;
        is[(i + 3) / SSLIMIT][(i + 3) % SSLIMIT] = y;
        i += 4;
    }

    if (hsstell() > part2_start + (*si).ch[ch].gr[gr].part2_3_length) {
    8ae5:	e8 12 d3 ff ff       	call   5dfc <hsstell>
    8aea:	89 c3                	mov    %eax,%ebx
    8aec:	8b 75 0c             	mov    0xc(%ebp),%esi
    8aef:	8b 45 14             	mov    0x14(%ebp),%eax
    8af2:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8af5:	89 c2                	mov    %eax,%edx
    8af7:	c1 e2 03             	shl    $0x3,%edx
    8afa:	01 c2                	add    %eax,%edx
    8afc:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8b03:	89 c2                	mov    %eax,%edx
    8b05:	89 c8                	mov    %ecx,%eax
    8b07:	c1 e0 02             	shl    $0x2,%eax
    8b0a:	01 c8                	add    %ecx,%eax
    8b0c:	c1 e0 05             	shl    $0x5,%eax
    8b0f:	01 d0                	add    %edx,%eax
    8b11:	01 f0                	add    %esi,%eax
    8b13:	83 c0 18             	add    $0x18,%eax
    8b16:	8b 10                	mov    (%eax),%edx
    8b18:	8b 45 18             	mov    0x18(%ebp),%eax
    8b1b:	01 d0                	add    %edx,%eax
    8b1d:	39 c3                	cmp    %eax,%ebx
    8b1f:	76 48                	jbe    8b69 <III_hufman_decode+0x5e3>
        i -= 4;
    8b21:	83 6d e4 04          	subl   $0x4,-0x1c(%ebp)
        rewindNbits(hsstell() - part2_start - (*si).ch[ch].gr[gr].part2_3_length);
    8b25:	e8 d2 d2 ff ff       	call   5dfc <hsstell>
    8b2a:	8b 55 18             	mov    0x18(%ebp),%edx
    8b2d:	29 d0                	sub    %edx,%eax
    8b2f:	89 c6                	mov    %eax,%esi
    8b31:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8b34:	8b 45 14             	mov    0x14(%ebp),%eax
    8b37:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8b3a:	89 c2                	mov    %eax,%edx
    8b3c:	c1 e2 03             	shl    $0x3,%edx
    8b3f:	01 c2                	add    %eax,%edx
    8b41:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8b48:	89 c2                	mov    %eax,%edx
    8b4a:	89 c8                	mov    %ecx,%eax
    8b4c:	c1 e0 02             	shl    $0x2,%eax
    8b4f:	01 c8                	add    %ecx,%eax
    8b51:	c1 e0 05             	shl    $0x5,%eax
    8b54:	01 d0                	add    %edx,%eax
    8b56:	01 d8                	add    %ebx,%eax
    8b58:	83 c0 18             	add    $0x18,%eax
    8b5b:	8b 00                	mov    (%eax),%eax
    8b5d:	29 c6                	sub    %eax,%esi
    8b5f:	89 f0                	mov    %esi,%eax
    8b61:	89 04 24             	mov    %eax,(%esp)
    8b64:	e8 de d2 ff ff       	call   5e47 <rewindNbits>
    }

    /* Dismiss stuffing Bits */
    if (hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length)
    8b69:	e8 8e d2 ff ff       	call   5dfc <hsstell>
    8b6e:	89 c3                	mov    %eax,%ebx
    8b70:	8b 75 0c             	mov    0xc(%ebp),%esi
    8b73:	8b 45 14             	mov    0x14(%ebp),%eax
    8b76:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8b79:	89 c2                	mov    %eax,%edx
    8b7b:	c1 e2 03             	shl    $0x3,%edx
    8b7e:	01 c2                	add    %eax,%edx
    8b80:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8b87:	89 c2                	mov    %eax,%edx
    8b89:	89 c8                	mov    %ecx,%eax
    8b8b:	c1 e0 02             	shl    $0x2,%eax
    8b8e:	01 c8                	add    %ecx,%eax
    8b90:	c1 e0 05             	shl    $0x5,%eax
    8b93:	01 d0                	add    %edx,%eax
    8b95:	01 f0                	add    %esi,%eax
    8b97:	83 c0 18             	add    $0x18,%eax
    8b9a:	8b 10                	mov    (%eax),%edx
    8b9c:	8b 45 18             	mov    0x18(%ebp),%eax
    8b9f:	01 d0                	add    %edx,%eax
    8ba1:	39 c3                	cmp    %eax,%ebx
    8ba3:	73 45                	jae    8bea <III_hufman_decode+0x664>
        hgetbits(part2_start + (*si).ch[ch].gr[gr].part2_3_length - hsstell());
    8ba5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8ba8:	8b 45 14             	mov    0x14(%ebp),%eax
    8bab:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8bae:	89 c2                	mov    %eax,%edx
    8bb0:	c1 e2 03             	shl    $0x3,%edx
    8bb3:	01 c2                	add    %eax,%edx
    8bb5:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8bbc:	89 c2                	mov    %eax,%edx
    8bbe:	89 c8                	mov    %ecx,%eax
    8bc0:	c1 e0 02             	shl    $0x2,%eax
    8bc3:	01 c8                	add    %ecx,%eax
    8bc5:	c1 e0 05             	shl    $0x5,%eax
    8bc8:	01 d0                	add    %edx,%eax
    8bca:	01 d8                	add    %ebx,%eax
    8bcc:	83 c0 18             	add    $0x18,%eax
    8bcf:	8b 10                	mov    (%eax),%edx
    8bd1:	8b 45 18             	mov    0x18(%ebp),%eax
    8bd4:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8bd7:	e8 20 d2 ff ff       	call   5dfc <hsstell>
    8bdc:	29 c3                	sub    %eax,%ebx
    8bde:	89 d8                	mov    %ebx,%eax
    8be0:	89 04 24             	mov    %eax,(%esp)
    8be3:	e8 30 d2 ff ff       	call   5e18 <hgetbits>

    /* Zero out rest. */
    for (; i < SSLIMIT * SBLIMIT; i++)
    8be8:	eb 5c                	jmp    8c46 <III_hufman_decode+0x6c0>
    8bea:	eb 5a                	jmp    8c46 <III_hufman_decode+0x6c0>
        is[i / SSLIMIT][i % SSLIMIT] = 0;
    8bec:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    8bef:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8bf4:	89 c8                	mov    %ecx,%eax
    8bf6:	f7 ea                	imul   %edx
    8bf8:	c1 fa 02             	sar    $0x2,%edx
    8bfb:	89 c8                	mov    %ecx,%eax
    8bfd:	c1 f8 1f             	sar    $0x1f,%eax
    8c00:	29 c2                	sub    %eax,%edx
    8c02:	89 d0                	mov    %edx,%eax
    8c04:	89 c2                	mov    %eax,%edx
    8c06:	89 d0                	mov    %edx,%eax
    8c08:	c1 e0 03             	shl    $0x3,%eax
    8c0b:	01 d0                	add    %edx,%eax
    8c0d:	c1 e0 03             	shl    $0x3,%eax
    8c10:	89 c2                	mov    %eax,%edx
    8c12:	8b 45 08             	mov    0x8(%ebp),%eax
    8c15:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8c18:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    8c1b:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8c20:	89 c8                	mov    %ecx,%eax
    8c22:	f7 ea                	imul   %edx
    8c24:	c1 fa 02             	sar    $0x2,%edx
    8c27:	89 c8                	mov    %ecx,%eax
    8c29:	c1 f8 1f             	sar    $0x1f,%eax
    8c2c:	29 c2                	sub    %eax,%edx
    8c2e:	89 d0                	mov    %edx,%eax
    8c30:	c1 e0 03             	shl    $0x3,%eax
    8c33:	01 d0                	add    %edx,%eax
    8c35:	01 c0                	add    %eax,%eax
    8c37:	29 c1                	sub    %eax,%ecx
    8c39:	89 ca                	mov    %ecx,%edx
    8c3b:	c7 04 93 00 00 00 00 	movl   $0x0,(%ebx,%edx,4)
    /* Dismiss stuffing Bits */
    if (hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length)
        hgetbits(part2_start + (*si).ch[ch].gr[gr].part2_3_length - hsstell());

    /* Zero out rest. */
    for (; i < SSLIMIT * SBLIMIT; i++)
    8c42:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    8c46:	81 7d e4 3f 02 00 00 	cmpl   $0x23f,-0x1c(%ebp)
    8c4d:	7e 9d                	jle    8bec <III_hufman_decode+0x666>
        is[i / SSLIMIT][i % SSLIMIT] = 0;
}
    8c4f:	83 c4 4c             	add    $0x4c,%esp
    8c52:	5b                   	pop    %ebx
    8c53:	5e                   	pop    %esi
    8c54:	5f                   	pop    %edi
    8c55:	5d                   	pop    %ebp
    8c56:	c3                   	ret    

00008c57 <III_dequantize_sample>:


int pretab[22] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 3, 3, 3, 2, 0};

void III_dequantize_sample(long int is[SBLIMIT][SSLIMIT], double xr[SBLIMIT][SSLIMIT], III_scalefac_t *scalefac,
                           struct gr_info_s *gr_info, int ch, struct frame_params *fr_ps) {
    8c57:	55                   	push   %ebp
    8c58:	89 e5                	mov    %esp,%ebp
    8c5a:	56                   	push   %esi
    8c5b:	53                   	push   %ebx
    8c5c:	83 ec 50             	sub    $0x50,%esp
    int ss, sb, cb = 0, sfreq = fr_ps->header->sampling_frequency;
    8c5f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    8c66:	8b 45 1c             	mov    0x1c(%ebp),%eax
    8c69:	8b 00                	mov    (%eax),%eax
    8c6b:	8b 40 10             	mov    0x10(%eax),%eax
    8c6e:	89 45 dc             	mov    %eax,-0x24(%ebp)
    //int stereo = fr_ps->stereo;
    int next_cb_boundary, cb_begin, cb_width = 0, sign;
    8c71:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)

    /* choose correct scalefactor band per block type, initalize boundary */

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) if (gr_info->mixed_block_flag)
    8c78:	8b 45 14             	mov    0x14(%ebp),%eax
    8c7b:	8b 40 10             	mov    0x10(%eax),%eax
    8c7e:	85 c0                	test   %eax,%eax
    8c80:	74 61                	je     8ce3 <III_dequantize_sample+0x8c>
    8c82:	8b 45 14             	mov    0x14(%ebp),%eax
    8c85:	8b 40 14             	mov    0x14(%eax),%eax
    8c88:	83 f8 02             	cmp    $0x2,%eax
    8c8b:	75 56                	jne    8ce3 <III_dequantize_sample+0x8c>
    8c8d:	8b 45 14             	mov    0x14(%ebp),%eax
    8c90:	8b 40 18             	mov    0x18(%eax),%eax
    8c93:	85 c0                	test   %eax,%eax
    8c95:	74 15                	je     8cac <III_dequantize_sample+0x55>
        next_cb_boundary = sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
    8c97:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8c9a:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8ca0:	05 a4 f4 00 00       	add    $0xf4a4,%eax
    8ca5:	8b 00                	mov    (%eax),%eax
    8ca7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    //int stereo = fr_ps->stereo;
    int next_cb_boundary, cb_begin, cb_width = 0, sign;

    /* choose correct scalefactor band per block type, initalize boundary */

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) if (gr_info->mixed_block_flag)
    8caa:	eb 4a                	jmp    8cf6 <III_dequantize_sample+0x9f>
        next_cb_boundary = sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
    else {
        next_cb_boundary = sfBandIndex[sfreq].s[1] * 3; /* pure SHORT block */
    8cac:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8caf:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8cb5:	05 f4 f4 00 00       	add    $0xf4f4,%eax
    8cba:	8b 50 0c             	mov    0xc(%eax),%edx
    8cbd:	89 d0                	mov    %edx,%eax
    8cbf:	01 c0                	add    %eax,%eax
    8cc1:	01 d0                	add    %edx,%eax
    8cc3:	89 45 e8             	mov    %eax,-0x18(%ebp)
        cb_width = sfBandIndex[sfreq].s[1];
    8cc6:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8cc9:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8ccf:	05 f4 f4 00 00       	add    $0xf4f4,%eax
    8cd4:	8b 40 0c             	mov    0xc(%eax),%eax
    8cd7:	89 45 e0             	mov    %eax,-0x20(%ebp)
        cb_begin = 0;
    8cda:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    //int stereo = fr_ps->stereo;
    int next_cb_boundary, cb_begin, cb_width = 0, sign;

    /* choose correct scalefactor band per block type, initalize boundary */

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) if (gr_info->mixed_block_flag)
    8ce1:	eb 13                	jmp    8cf6 <III_dequantize_sample+0x9f>
        next_cb_boundary = sfBandIndex[sfreq].s[1] * 3; /* pure SHORT block */
        cb_width = sfBandIndex[sfreq].s[1];
        cb_begin = 0;
    }
    else
        next_cb_boundary = sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
    8ce3:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8ce6:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8cec:	05 a4 f4 00 00       	add    $0xf4a4,%eax
    8cf1:	8b 00                	mov    (%eax),%eax
    8cf3:	89 45 e8             	mov    %eax,-0x18(%ebp)

    /* apply formula per block type */
    for (sb = 0; sb < SBLIMIT; sb++) {
    8cf6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    8cfd:	e9 3d 06 00 00       	jmp    933f <III_dequantize_sample+0x6e8>
        for (ss = 0; ss < SSLIMIT; ss++) {
    8d02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8d09:	e9 23 06 00 00       	jmp    9331 <III_dequantize_sample+0x6da>
            if ((sb * 18) + ss == next_cb_boundary) { /* Adjust critical band boundary */
    8d0e:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8d11:	89 d0                	mov    %edx,%eax
    8d13:	c1 e0 03             	shl    $0x3,%eax
    8d16:	01 d0                	add    %edx,%eax
    8d18:	01 c0                	add    %eax,%eax
    8d1a:	89 c2                	mov    %eax,%edx
    8d1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8d1f:	01 d0                	add    %edx,%eax
    8d21:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    8d24:	0f 85 9e 02 00 00    	jne    8fc8 <III_dequantize_sample+0x371>
                if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    8d2a:	8b 45 14             	mov    0x14(%ebp),%eax
    8d2d:	8b 40 10             	mov    0x10(%eax),%eax
    8d30:	85 c0                	test   %eax,%eax
    8d32:	0f 84 6b 02 00 00    	je     8fa3 <III_dequantize_sample+0x34c>
    8d38:	8b 45 14             	mov    0x14(%ebp),%eax
    8d3b:	8b 40 14             	mov    0x14(%eax),%eax
    8d3e:	83 f8 02             	cmp    $0x2,%eax
    8d41:	0f 85 5c 02 00 00    	jne    8fa3 <III_dequantize_sample+0x34c>
                    if (gr_info->mixed_block_flag) {
    8d47:	8b 45 14             	mov    0x14(%ebp),%eax
    8d4a:	8b 40 18             	mov    0x18(%eax),%eax
    8d4d:	85 c0                	test   %eax,%eax
    8d4f:	0f 84 af 01 00 00    	je     8f04 <III_dequantize_sample+0x2ad>
                        if (((sb * 18) + ss) == sfBandIndex[sfreq].l[8]) {
    8d55:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8d58:	89 d0                	mov    %edx,%eax
    8d5a:	c1 e0 03             	shl    $0x3,%eax
    8d5d:	01 d0                	add    %edx,%eax
    8d5f:	01 c0                	add    %eax,%eax
    8d61:	89 c2                	mov    %eax,%edx
    8d63:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8d66:	01 c2                	add    %eax,%edx
    8d68:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8d6b:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8d71:	05 c0 f4 00 00       	add    $0xf4c0,%eax
    8d76:	8b 00                	mov    (%eax),%eax
    8d78:	39 c2                	cmp    %eax,%edx
    8d7a:	0f 85 93 00 00 00    	jne    8e13 <III_dequantize_sample+0x1bc>
                            next_cb_boundary = sfBandIndex[sfreq].s[4] * 3;
    8d80:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8d83:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8d89:	05 00 f5 00 00       	add    $0xf500,%eax
    8d8e:	8b 50 0c             	mov    0xc(%eax),%edx
    8d91:	89 d0                	mov    %edx,%eax
    8d93:	01 c0                	add    %eax,%eax
    8d95:	01 d0                	add    %edx,%eax
    8d97:	89 45 e8             	mov    %eax,-0x18(%ebp)
                            cb = 3;
    8d9a:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
                            cb_width = sfBandIndex[sfreq].s[cb + 1] -
    8da1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8da4:	8d 48 01             	lea    0x1(%eax),%ecx
    8da7:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8daa:	89 d0                	mov    %edx,%eax
    8dac:	c1 e0 03             	shl    $0x3,%eax
    8daf:	01 d0                	add    %edx,%eax
    8db1:	c1 e0 02             	shl    $0x2,%eax
    8db4:	01 d0                	add    %edx,%eax
    8db6:	01 c8                	add    %ecx,%eax
    8db8:	83 c0 14             	add    $0x14,%eax
    8dbb:	8b 0c 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%ecx
                                       sfBandIndex[sfreq].s[cb];
    8dc2:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8dc5:	89 d0                	mov    %edx,%eax
    8dc7:	c1 e0 03             	shl    $0x3,%eax
    8dca:	01 d0                	add    %edx,%eax
    8dcc:	c1 e0 02             	shl    $0x2,%eax
    8dcf:	01 d0                	add    %edx,%eax
    8dd1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8dd4:	01 d0                	add    %edx,%eax
    8dd6:	83 c0 14             	add    $0x14,%eax
    8dd9:	8b 04 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%eax
                if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
                    if (gr_info->mixed_block_flag) {
                        if (((sb * 18) + ss) == sfBandIndex[sfreq].l[8]) {
                            next_cb_boundary = sfBandIndex[sfreq].s[4] * 3;
                            cb = 3;
                            cb_width = sfBandIndex[sfreq].s[cb + 1] -
    8de0:	29 c1                	sub    %eax,%ecx
    8de2:	89 c8                	mov    %ecx,%eax
    8de4:	89 45 e0             	mov    %eax,-0x20(%ebp)
                                       sfBandIndex[sfreq].s[cb];
                            cb_begin = sfBandIndex[sfreq].s[cb] * 3;
    8de7:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8dea:	89 d0                	mov    %edx,%eax
    8dec:	c1 e0 03             	shl    $0x3,%eax
    8def:	01 d0                	add    %edx,%eax
    8df1:	c1 e0 02             	shl    $0x2,%eax
    8df4:	01 d0                	add    %edx,%eax
    8df6:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8df9:	01 d0                	add    %edx,%eax
    8dfb:	83 c0 14             	add    $0x14,%eax
    8dfe:	8b 14 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%edx
    8e05:	89 d0                	mov    %edx,%eax
    8e07:	01 c0                	add    %eax,%eax
    8e09:	01 d0                	add    %edx,%eax
    8e0b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    8e0e:	e9 8e 01 00 00       	jmp    8fa1 <III_dequantize_sample+0x34a>
                        }
                        else if (((sb * 18) + ss) < sfBandIndex[sfreq].l[8])
    8e13:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8e16:	89 d0                	mov    %edx,%eax
    8e18:	c1 e0 03             	shl    $0x3,%eax
    8e1b:	01 d0                	add    %edx,%eax
    8e1d:	01 c0                	add    %eax,%eax
    8e1f:	89 c2                	mov    %eax,%edx
    8e21:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8e24:	01 c2                	add    %eax,%edx
    8e26:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8e29:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8e2f:	05 c0 f4 00 00       	add    $0xf4c0,%eax
    8e34:	8b 00                	mov    (%eax),%eax
    8e36:	39 c2                	cmp    %eax,%edx
    8e38:	7d 2a                	jge    8e64 <III_dequantize_sample+0x20d>
                            next_cb_boundary = sfBandIndex[sfreq].l[(++cb) + 1];
    8e3a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8e3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8e41:	8d 48 01             	lea    0x1(%eax),%ecx
    8e44:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8e47:	89 d0                	mov    %edx,%eax
    8e49:	c1 e0 03             	shl    $0x3,%eax
    8e4c:	01 d0                	add    %edx,%eax
    8e4e:	c1 e0 02             	shl    $0x2,%eax
    8e51:	01 d0                	add    %edx,%eax
    8e53:	01 c8                	add    %ecx,%eax
    8e55:	8b 04 85 a0 f4 00 00 	mov    0xf4a0(,%eax,4),%eax
    8e5c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    8e5f:	e9 3d 01 00 00       	jmp    8fa1 <III_dequantize_sample+0x34a>
                        else {
                            next_cb_boundary = sfBandIndex[sfreq].s[(++cb) + 1] * 3;
    8e64:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8e68:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8e6b:	8d 48 01             	lea    0x1(%eax),%ecx
    8e6e:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8e71:	89 d0                	mov    %edx,%eax
    8e73:	c1 e0 03             	shl    $0x3,%eax
    8e76:	01 d0                	add    %edx,%eax
    8e78:	c1 e0 02             	shl    $0x2,%eax
    8e7b:	01 d0                	add    %edx,%eax
    8e7d:	01 c8                	add    %ecx,%eax
    8e7f:	83 c0 14             	add    $0x14,%eax
    8e82:	8b 14 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%edx
    8e89:	89 d0                	mov    %edx,%eax
    8e8b:	01 c0                	add    %eax,%eax
    8e8d:	01 d0                	add    %edx,%eax
    8e8f:	89 45 e8             	mov    %eax,-0x18(%ebp)
                            cb_width = sfBandIndex[sfreq].s[cb + 1] -
    8e92:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8e95:	8d 48 01             	lea    0x1(%eax),%ecx
    8e98:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8e9b:	89 d0                	mov    %edx,%eax
    8e9d:	c1 e0 03             	shl    $0x3,%eax
    8ea0:	01 d0                	add    %edx,%eax
    8ea2:	c1 e0 02             	shl    $0x2,%eax
    8ea5:	01 d0                	add    %edx,%eax
    8ea7:	01 c8                	add    %ecx,%eax
    8ea9:	83 c0 14             	add    $0x14,%eax
    8eac:	8b 0c 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%ecx
                                       sfBandIndex[sfreq].s[cb];
    8eb3:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8eb6:	89 d0                	mov    %edx,%eax
    8eb8:	c1 e0 03             	shl    $0x3,%eax
    8ebb:	01 d0                	add    %edx,%eax
    8ebd:	c1 e0 02             	shl    $0x2,%eax
    8ec0:	01 d0                	add    %edx,%eax
    8ec2:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8ec5:	01 d0                	add    %edx,%eax
    8ec7:	83 c0 14             	add    $0x14,%eax
    8eca:	8b 04 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%eax
                        }
                        else if (((sb * 18) + ss) < sfBandIndex[sfreq].l[8])
                            next_cb_boundary = sfBandIndex[sfreq].l[(++cb) + 1];
                        else {
                            next_cb_boundary = sfBandIndex[sfreq].s[(++cb) + 1] * 3;
                            cb_width = sfBandIndex[sfreq].s[cb + 1] -
    8ed1:	29 c1                	sub    %eax,%ecx
    8ed3:	89 c8                	mov    %ecx,%eax
    8ed5:	89 45 e0             	mov    %eax,-0x20(%ebp)
                                       sfBandIndex[sfreq].s[cb];
                            cb_begin = sfBandIndex[sfreq].s[cb] * 3;
    8ed8:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8edb:	89 d0                	mov    %edx,%eax
    8edd:	c1 e0 03             	shl    $0x3,%eax
    8ee0:	01 d0                	add    %edx,%eax
    8ee2:	c1 e0 02             	shl    $0x2,%eax
    8ee5:	01 d0                	add    %edx,%eax
    8ee7:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8eea:	01 d0                	add    %edx,%eax
    8eec:	83 c0 14             	add    $0x14,%eax
    8eef:	8b 14 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%edx
    8ef6:	89 d0                	mov    %edx,%eax
    8ef8:	01 c0                	add    %eax,%eax
    8efa:	01 d0                	add    %edx,%eax
    8efc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    /* apply formula per block type */
    for (sb = 0; sb < SBLIMIT; sb++) {
        for (ss = 0; ss < SSLIMIT; ss++) {
            if ((sb * 18) + ss == next_cb_boundary) { /* Adjust critical band boundary */
                if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
                    if (gr_info->mixed_block_flag) {
    8eff:	e9 c4 00 00 00       	jmp    8fc8 <III_dequantize_sample+0x371>
                                       sfBandIndex[sfreq].s[cb];
                            cb_begin = sfBandIndex[sfreq].s[cb] * 3;
                        }
                    }
                    else {
                        next_cb_boundary = sfBandIndex[sfreq].s[(++cb) + 1] * 3;
    8f04:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8f08:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8f0b:	8d 48 01             	lea    0x1(%eax),%ecx
    8f0e:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8f11:	89 d0                	mov    %edx,%eax
    8f13:	c1 e0 03             	shl    $0x3,%eax
    8f16:	01 d0                	add    %edx,%eax
    8f18:	c1 e0 02             	shl    $0x2,%eax
    8f1b:	01 d0                	add    %edx,%eax
    8f1d:	01 c8                	add    %ecx,%eax
    8f1f:	83 c0 14             	add    $0x14,%eax
    8f22:	8b 14 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%edx
    8f29:	89 d0                	mov    %edx,%eax
    8f2b:	01 c0                	add    %eax,%eax
    8f2d:	01 d0                	add    %edx,%eax
    8f2f:	89 45 e8             	mov    %eax,-0x18(%ebp)
                        cb_width = sfBandIndex[sfreq].s[cb + 1] -
    8f32:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8f35:	8d 48 01             	lea    0x1(%eax),%ecx
    8f38:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8f3b:	89 d0                	mov    %edx,%eax
    8f3d:	c1 e0 03             	shl    $0x3,%eax
    8f40:	01 d0                	add    %edx,%eax
    8f42:	c1 e0 02             	shl    $0x2,%eax
    8f45:	01 d0                	add    %edx,%eax
    8f47:	01 c8                	add    %ecx,%eax
    8f49:	83 c0 14             	add    $0x14,%eax
    8f4c:	8b 0c 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%ecx
                                   sfBandIndex[sfreq].s[cb];
    8f53:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8f56:	89 d0                	mov    %edx,%eax
    8f58:	c1 e0 03             	shl    $0x3,%eax
    8f5b:	01 d0                	add    %edx,%eax
    8f5d:	c1 e0 02             	shl    $0x2,%eax
    8f60:	01 d0                	add    %edx,%eax
    8f62:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8f65:	01 d0                	add    %edx,%eax
    8f67:	83 c0 14             	add    $0x14,%eax
    8f6a:	8b 04 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%eax
                            cb_begin = sfBandIndex[sfreq].s[cb] * 3;
                        }
                    }
                    else {
                        next_cb_boundary = sfBandIndex[sfreq].s[(++cb) + 1] * 3;
                        cb_width = sfBandIndex[sfreq].s[cb + 1] -
    8f71:	29 c1                	sub    %eax,%ecx
    8f73:	89 c8                	mov    %ecx,%eax
    8f75:	89 45 e0             	mov    %eax,-0x20(%ebp)
                                   sfBandIndex[sfreq].s[cb];
                        cb_begin = sfBandIndex[sfreq].s[cb] * 3;
    8f78:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8f7b:	89 d0                	mov    %edx,%eax
    8f7d:	c1 e0 03             	shl    $0x3,%eax
    8f80:	01 d0                	add    %edx,%eax
    8f82:	c1 e0 02             	shl    $0x2,%eax
    8f85:	01 d0                	add    %edx,%eax
    8f87:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8f8a:	01 d0                	add    %edx,%eax
    8f8c:	83 c0 14             	add    $0x14,%eax
    8f8f:	8b 14 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%edx
    8f96:	89 d0                	mov    %edx,%eax
    8f98:	01 c0                	add    %eax,%eax
    8f9a:	01 d0                	add    %edx,%eax
    8f9c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    /* apply formula per block type */
    for (sb = 0; sb < SBLIMIT; sb++) {
        for (ss = 0; ss < SSLIMIT; ss++) {
            if ((sb * 18) + ss == next_cb_boundary) { /* Adjust critical band boundary */
                if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
                    if (gr_info->mixed_block_flag) {
    8f9f:	eb 27                	jmp    8fc8 <III_dequantize_sample+0x371>
    8fa1:	eb 25                	jmp    8fc8 <III_dequantize_sample+0x371>
                                   sfBandIndex[sfreq].s[cb];
                        cb_begin = sfBandIndex[sfreq].s[cb] * 3;
                    }
                }
                else /* long blocks */
                    next_cb_boundary = sfBandIndex[sfreq].l[(++cb) + 1];
    8fa3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8fa7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8faa:	8d 48 01             	lea    0x1(%eax),%ecx
    8fad:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8fb0:	89 d0                	mov    %edx,%eax
    8fb2:	c1 e0 03             	shl    $0x3,%eax
    8fb5:	01 d0                	add    %edx,%eax
    8fb7:	c1 e0 02             	shl    $0x2,%eax
    8fba:	01 d0                	add    %edx,%eax
    8fbc:	01 c8                	add    %ecx,%eax
    8fbe:	8b 04 85 a0 f4 00 00 	mov    0xf4a0(,%eax,4),%eax
    8fc5:	89 45 e8             	mov    %eax,-0x18(%ebp)
            }

            /* Compute overall (global) scaling. */
            xr[sb][ss] = pow(2.0, (0.25 * (gr_info->global_gain - 210.0)));
    8fc8:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8fcb:	89 d0                	mov    %edx,%eax
    8fcd:	c1 e0 03             	shl    $0x3,%eax
    8fd0:	01 d0                	add    %edx,%eax
    8fd2:	c1 e0 04             	shl    $0x4,%eax
    8fd5:	89 c2                	mov    %eax,%edx
    8fd7:	8b 45 0c             	mov    0xc(%ebp),%eax
    8fda:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8fdd:	8b 45 14             	mov    0x14(%ebp),%eax
    8fe0:	8b 40 08             	mov    0x8(%eax),%eax
    8fe3:	ba 00 00 00 00       	mov    $0x0,%edx
    8fe8:	89 45 c8             	mov    %eax,-0x38(%ebp)
    8feb:	89 55 cc             	mov    %edx,-0x34(%ebp)
    8fee:	df 6d c8             	fildll -0x38(%ebp)
    8ff1:	dd 05 30 e0 00 00    	fldl   0xe030
    8ff7:	de e9                	fsubrp %st,%st(1)
    8ff9:	dd 05 38 e0 00 00    	fldl   0xe038
    8fff:	de c9                	fmulp  %st,%st(1)
    9001:	dd 5c 24 08          	fstpl  0x8(%esp)
    9005:	dd 05 40 e0 00 00    	fldl   0xe040
    900b:	dd 1c 24             	fstpl  (%esp)
    900e:	e8 0c c1 ff ff       	call   511f <pow>
    9013:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9016:	dd 1c c3             	fstpl  (%ebx,%eax,8)

            /* Do long/short dependent scaling operations. */

            if (gr_info->window_switching_flag && (
    9019:	8b 45 14             	mov    0x14(%ebp),%eax
    901c:	8b 40 10             	mov    0x10(%eax),%eax
    901f:	85 c0                	test   %eax,%eax
    9021:	0f 84 86 01 00 00    	je     91ad <III_dequantize_sample+0x556>
                    ((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    9027:	8b 45 14             	mov    0x14(%ebp),%eax
    902a:	8b 40 14             	mov    0x14(%eax),%eax
            /* Compute overall (global) scaling. */
            xr[sb][ss] = pow(2.0, (0.25 * (gr_info->global_gain - 210.0)));

            /* Do long/short dependent scaling operations. */

            if (gr_info->window_switching_flag && (
    902d:	83 f8 02             	cmp    $0x2,%eax
    9030:	75 0a                	jne    903c <III_dequantize_sample+0x3e5>
                    ((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    9032:	8b 45 14             	mov    0x14(%ebp),%eax
    9035:	8b 40 18             	mov    0x18(%eax),%eax
    9038:	85 c0                	test   %eax,%eax
    903a:	74 27                	je     9063 <III_dequantize_sample+0x40c>
                    ((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)))) {
    903c:	8b 45 14             	mov    0x14(%ebp),%eax
    903f:	8b 40 14             	mov    0x14(%eax),%eax
            xr[sb][ss] = pow(2.0, (0.25 * (gr_info->global_gain - 210.0)));

            /* Do long/short dependent scaling operations. */

            if (gr_info->window_switching_flag && (
                    ((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    9042:	83 f8 02             	cmp    $0x2,%eax
    9045:	0f 85 62 01 00 00    	jne    91ad <III_dequantize_sample+0x556>
                    ((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)))) {
    904b:	8b 45 14             	mov    0x14(%ebp),%eax
    904e:	8b 40 18             	mov    0x18(%eax),%eax
    9051:	85 c0                	test   %eax,%eax
    9053:	0f 84 54 01 00 00    	je     91ad <III_dequantize_sample+0x556>
    9059:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    905d:	0f 8e 4a 01 00 00    	jle    91ad <III_dequantize_sample+0x556>

                xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
    9063:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9066:	89 d0                	mov    %edx,%eax
    9068:	c1 e0 03             	shl    $0x3,%eax
    906b:	01 d0                	add    %edx,%eax
    906d:	c1 e0 04             	shl    $0x4,%eax
    9070:	89 c2                	mov    %eax,%edx
    9072:	8b 45 0c             	mov    0xc(%ebp),%eax
    9075:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    9078:	8b 55 f0             	mov    -0x10(%ebp),%edx
    907b:	89 d0                	mov    %edx,%eax
    907d:	c1 e0 03             	shl    $0x3,%eax
    9080:	01 d0                	add    %edx,%eax
    9082:	c1 e0 04             	shl    $0x4,%eax
    9085:	89 c2                	mov    %eax,%edx
    9087:	8b 45 0c             	mov    0xc(%ebp),%eax
    908a:	01 c2                	add    %eax,%edx
    908c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    908f:	dd 04 c2             	fldl   (%edx,%eax,8)
    9092:	dd 5d c0             	fstpl  -0x40(%ebp)
                                       gr_info->subblock_gain[(((sb * 18) + ss) - cb_begin) / cb_width]);
    9095:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9098:	89 d0                	mov    %edx,%eax
    909a:	c1 e0 03             	shl    $0x3,%eax
    909d:	01 d0                	add    %edx,%eax
    909f:	01 c0                	add    %eax,%eax
    90a1:	89 c2                	mov    %eax,%edx
    90a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    90a6:	01 d0                	add    %edx,%eax
    90a8:	2b 45 e4             	sub    -0x1c(%ebp),%eax
    90ab:	99                   	cltd   
    90ac:	f7 7d e0             	idivl  -0x20(%ebp)
    90af:	89 c2                	mov    %eax,%edx
    90b1:	8b 45 14             	mov    0x14(%ebp),%eax
    90b4:	83 c2 08             	add    $0x8,%edx
    90b7:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax

            if (gr_info->window_switching_flag && (
                    ((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
                    ((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)))) {

                xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
    90bb:	ba 00 00 00 00       	mov    $0x0,%edx
    90c0:	89 45 c8             	mov    %eax,-0x38(%ebp)
    90c3:	89 55 cc             	mov    %edx,-0x34(%ebp)
    90c6:	df 6d c8             	fildll -0x38(%ebp)
    90c9:	dd 05 48 e0 00 00    	fldl   0xe048
    90cf:	de c9                	fmulp  %st,%st(1)
    90d1:	dd 5c 24 08          	fstpl  0x8(%esp)
    90d5:	dd 05 40 e0 00 00    	fldl   0xe040
    90db:	dd 1c 24             	fstpl  (%esp)
    90de:	e8 3c c0 ff ff       	call   511f <pow>
    90e3:	dc 4d c0             	fmull  -0x40(%ebp)
    90e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    90e9:	dd 1c c3             	fstpl  (%ebx,%eax,8)
                                       gr_info->subblock_gain[(((sb * 18) + ss) - cb_begin) / cb_width]);
                xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0 + gr_info->scalefac_scale)
    90ec:	8b 55 f0             	mov    -0x10(%ebp),%edx
    90ef:	89 d0                	mov    %edx,%eax
    90f1:	c1 e0 03             	shl    $0x3,%eax
    90f4:	01 d0                	add    %edx,%eax
    90f6:	c1 e0 04             	shl    $0x4,%eax
    90f9:	89 c2                	mov    %eax,%edx
    90fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    90fe:	8d 34 02             	lea    (%edx,%eax,1),%esi
    9101:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9104:	89 d0                	mov    %edx,%eax
    9106:	c1 e0 03             	shl    $0x3,%eax
    9109:	01 d0                	add    %edx,%eax
    910b:	c1 e0 04             	shl    $0x4,%eax
    910e:	89 c2                	mov    %eax,%edx
    9110:	8b 45 0c             	mov    0xc(%ebp),%eax
    9113:	01 c2                	add    %eax,%edx
    9115:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9118:	dd 04 c2             	fldl   (%edx,%eax,8)
    911b:	dd 5d c0             	fstpl  -0x40(%ebp)
    911e:	8b 45 14             	mov    0x14(%ebp),%eax
    9121:	8b 40 40             	mov    0x40(%eax),%eax
    9124:	ba 00 00 00 00       	mov    $0x0,%edx
    9129:	89 45 c8             	mov    %eax,-0x38(%ebp)
    912c:	89 55 cc             	mov    %edx,-0x34(%ebp)
    912f:	df 6d c8             	fildll -0x38(%ebp)
    9132:	d9 e8                	fld1   
    9134:	de c1                	faddp  %st,%st(1)
    9136:	dd 05 50 e0 00 00    	fldl   0xe050
    913c:	de c9                	fmulp  %st,%st(1)
                                       * (*scalefac)[ch].s[(((sb * 18) + ss) - cb_begin) / cb_width][cb]);
    913e:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9141:	89 d0                	mov    %edx,%eax
    9143:	c1 e0 03             	shl    $0x3,%eax
    9146:	01 d0                	add    %edx,%eax
    9148:	01 c0                	add    %eax,%eax
    914a:	89 c2                	mov    %eax,%edx
    914c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    914f:	01 d0                	add    %edx,%eax
    9151:	2b 45 e4             	sub    -0x1c(%ebp),%eax
    9154:	99                   	cltd   
    9155:	f7 7d e0             	idivl  -0x20(%ebp)
    9158:	89 c2                	mov    %eax,%edx
    915a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    915d:	8b 4d 18             	mov    0x18(%ebp),%ecx
    9160:	89 d0                	mov    %edx,%eax
    9162:	01 c0                	add    %eax,%eax
    9164:	01 d0                	add    %edx,%eax
    9166:	c1 e0 02             	shl    $0x2,%eax
    9169:	01 d0                	add    %edx,%eax
    916b:	89 ca                	mov    %ecx,%edx
    916d:	01 d2                	add    %edx,%edx
    916f:	89 d1                	mov    %edx,%ecx
    9171:	c1 e1 05             	shl    $0x5,%ecx
    9174:	29 d1                	sub    %edx,%ecx
    9176:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    9179:	8b 45 ec             	mov    -0x14(%ebp),%eax
    917c:	01 d0                	add    %edx,%eax
    917e:	83 c0 14             	add    $0x14,%eax
    9181:	8b 44 83 0c          	mov    0xc(%ebx,%eax,4),%eax
                    ((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
                    ((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)))) {

                xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
                                       gr_info->subblock_gain[(((sb * 18) + ss) - cb_begin) / cb_width]);
                xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0 + gr_info->scalefac_scale)
    9185:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    9188:	db 45 d4             	fildl  -0x2c(%ebp)
    918b:	de c9                	fmulp  %st,%st(1)
    918d:	dd 5c 24 08          	fstpl  0x8(%esp)
    9191:	dd 05 40 e0 00 00    	fldl   0xe040
    9197:	dd 1c 24             	fstpl  (%esp)
    919a:	e8 80 bf ff ff       	call   511f <pow>
    919f:	dc 4d c0             	fmull  -0x40(%ebp)
    91a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    91a5:	dd 1c c6             	fstpl  (%esi,%eax,8)
    91a8:	e9 ab 00 00 00       	jmp    9258 <III_dequantize_sample+0x601>
                                       * (*scalefac)[ch].s[(((sb * 18) + ss) - cb_begin) / cb_width][cb]);
            }
            else {   /* LONG block types 0,1,3 & 1st 2 subbands of switched blocks */
                xr[sb][ss] *= pow(2.0, -0.5 * (1.0 + gr_info->scalefac_scale)
    91ad:	8b 55 f0             	mov    -0x10(%ebp),%edx
    91b0:	89 d0                	mov    %edx,%eax
    91b2:	c1 e0 03             	shl    $0x3,%eax
    91b5:	01 d0                	add    %edx,%eax
    91b7:	c1 e0 04             	shl    $0x4,%eax
    91ba:	89 c2                	mov    %eax,%edx
    91bc:	8b 45 0c             	mov    0xc(%ebp),%eax
    91bf:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    91c2:	8b 55 f0             	mov    -0x10(%ebp),%edx
    91c5:	89 d0                	mov    %edx,%eax
    91c7:	c1 e0 03             	shl    $0x3,%eax
    91ca:	01 d0                	add    %edx,%eax
    91cc:	c1 e0 04             	shl    $0x4,%eax
    91cf:	89 c2                	mov    %eax,%edx
    91d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    91d4:	01 c2                	add    %eax,%edx
    91d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    91d9:	dd 04 c2             	fldl   (%edx,%eax,8)
    91dc:	dd 5d c0             	fstpl  -0x40(%ebp)
    91df:	8b 45 14             	mov    0x14(%ebp),%eax
    91e2:	8b 40 40             	mov    0x40(%eax),%eax
    91e5:	ba 00 00 00 00       	mov    $0x0,%edx
    91ea:	89 45 c8             	mov    %eax,-0x38(%ebp)
    91ed:	89 55 cc             	mov    %edx,-0x34(%ebp)
    91f0:	df 6d c8             	fildll -0x38(%ebp)
    91f3:	d9 e8                	fld1   
    91f5:	de c1                	faddp  %st,%st(1)
    91f7:	dd 05 50 e0 00 00    	fldl   0xe050
    91fd:	de c9                	fmulp  %st,%st(1)
                                       * ((*scalefac)[ch].l[cb]
    91ff:	8b 4d 10             	mov    0x10(%ebp),%ecx
    9202:	8b 45 18             	mov    0x18(%ebp),%eax
    9205:	01 c0                	add    %eax,%eax
    9207:	89 c2                	mov    %eax,%edx
    9209:	c1 e2 05             	shl    $0x5,%edx
    920c:	29 c2                	sub    %eax,%edx
    920e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9211:	01 d0                	add    %edx,%eax
    9213:	8b 04 81             	mov    (%ecx,%eax,4),%eax
                                          + gr_info->preflag * pretab[cb]));
    9216:	89 c2                	mov    %eax,%edx
    9218:	8b 45 14             	mov    0x14(%ebp),%eax
    921b:	8b 48 3c             	mov    0x3c(%eax),%ecx
    921e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9221:	8b 04 85 60 f6 00 00 	mov    0xf660(,%eax,4),%eax
    9228:	0f af c1             	imul   %ecx,%eax
    922b:	01 d0                	add    %edx,%eax
                                       gr_info->subblock_gain[(((sb * 18) + ss) - cb_begin) / cb_width]);
                xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0 + gr_info->scalefac_scale)
                                       * (*scalefac)[ch].s[(((sb * 18) + ss) - cb_begin) / cb_width][cb]);
            }
            else {   /* LONG block types 0,1,3 & 1st 2 subbands of switched blocks */
                xr[sb][ss] *= pow(2.0, -0.5 * (1.0 + gr_info->scalefac_scale)
    922d:	ba 00 00 00 00       	mov    $0x0,%edx
    9232:	89 45 c8             	mov    %eax,-0x38(%ebp)
    9235:	89 55 cc             	mov    %edx,-0x34(%ebp)
    9238:	df 6d c8             	fildll -0x38(%ebp)
    923b:	de c9                	fmulp  %st,%st(1)
    923d:	dd 5c 24 08          	fstpl  0x8(%esp)
    9241:	dd 05 40 e0 00 00    	fldl   0xe040
    9247:	dd 1c 24             	fstpl  (%esp)
    924a:	e8 d0 be ff ff       	call   511f <pow>
    924f:	dc 4d c0             	fmull  -0x40(%ebp)
    9252:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9255:	dd 1c c3             	fstpl  (%ebx,%eax,8)
                                          + gr_info->preflag * pretab[cb]));
            }

            /* Scale quantized value. */

            sign = (is[sb][ss] < 0) ? 1 : 0;
    9258:	8b 55 f0             	mov    -0x10(%ebp),%edx
    925b:	89 d0                	mov    %edx,%eax
    925d:	c1 e0 03             	shl    $0x3,%eax
    9260:	01 d0                	add    %edx,%eax
    9262:	c1 e0 03             	shl    $0x3,%eax
    9265:	89 c2                	mov    %eax,%edx
    9267:	8b 45 08             	mov    0x8(%ebp),%eax
    926a:	01 c2                	add    %eax,%edx
    926c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    926f:	8b 04 82             	mov    (%edx,%eax,4),%eax
    9272:	c1 e8 1f             	shr    $0x1f,%eax
    9275:	0f b6 c0             	movzbl %al,%eax
    9278:	89 45 d8             	mov    %eax,-0x28(%ebp)
            xr[sb][ss] *= pow((double) abs(is[sb][ss]), ((double) 4.0 / 3.0));
    927b:	8b 55 f0             	mov    -0x10(%ebp),%edx
    927e:	89 d0                	mov    %edx,%eax
    9280:	c1 e0 03             	shl    $0x3,%eax
    9283:	01 d0                	add    %edx,%eax
    9285:	c1 e0 04             	shl    $0x4,%eax
    9288:	89 c2                	mov    %eax,%edx
    928a:	8b 45 0c             	mov    0xc(%ebp),%eax
    928d:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    9290:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9293:	89 d0                	mov    %edx,%eax
    9295:	c1 e0 03             	shl    $0x3,%eax
    9298:	01 d0                	add    %edx,%eax
    929a:	c1 e0 04             	shl    $0x4,%eax
    929d:	89 c2                	mov    %eax,%edx
    929f:	8b 45 0c             	mov    0xc(%ebp),%eax
    92a2:	01 c2                	add    %eax,%edx
    92a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    92a7:	dd 04 c2             	fldl   (%edx,%eax,8)
    92aa:	dd 5d c0             	fstpl  -0x40(%ebp)
    92ad:	8b 55 f0             	mov    -0x10(%ebp),%edx
    92b0:	89 d0                	mov    %edx,%eax
    92b2:	c1 e0 03             	shl    $0x3,%eax
    92b5:	01 d0                	add    %edx,%eax
    92b7:	c1 e0 03             	shl    $0x3,%eax
    92ba:	89 c2                	mov    %eax,%edx
    92bc:	8b 45 08             	mov    0x8(%ebp),%eax
    92bf:	01 c2                	add    %eax,%edx
    92c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    92c4:	8b 04 82             	mov    (%edx,%eax,4),%eax
    92c7:	89 04 24             	mov    %eax,(%esp)
    92ca:	e8 47 bd ff ff       	call   5016 <abs>
    92cf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    92d2:	db 45 d4             	fildl  -0x2c(%ebp)
    92d5:	dd 05 58 e0 00 00    	fldl   0xe058
    92db:	dd 5c 24 08          	fstpl  0x8(%esp)
    92df:	dd 1c 24             	fstpl  (%esp)
    92e2:	e8 38 be ff ff       	call   511f <pow>
    92e7:	dc 4d c0             	fmull  -0x40(%ebp)
    92ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    92ed:	dd 1c c3             	fstpl  (%ebx,%eax,8)
            if (sign) xr[sb][ss] = -xr[sb][ss];
    92f0:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    92f4:	74 37                	je     932d <III_dequantize_sample+0x6d6>
    92f6:	8b 55 f0             	mov    -0x10(%ebp),%edx
    92f9:	89 d0                	mov    %edx,%eax
    92fb:	c1 e0 03             	shl    $0x3,%eax
    92fe:	01 d0                	add    %edx,%eax
    9300:	c1 e0 04             	shl    $0x4,%eax
    9303:	89 c2                	mov    %eax,%edx
    9305:	8b 45 0c             	mov    0xc(%ebp),%eax
    9308:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    930b:	8b 55 f0             	mov    -0x10(%ebp),%edx
    930e:	89 d0                	mov    %edx,%eax
    9310:	c1 e0 03             	shl    $0x3,%eax
    9313:	01 d0                	add    %edx,%eax
    9315:	c1 e0 04             	shl    $0x4,%eax
    9318:	89 c2                	mov    %eax,%edx
    931a:	8b 45 0c             	mov    0xc(%ebp),%eax
    931d:	01 c2                	add    %eax,%edx
    931f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9322:	dd 04 c2             	fldl   (%edx,%eax,8)
    9325:	d9 e0                	fchs   
    9327:	8b 45 f4             	mov    -0xc(%ebp),%eax
    932a:	dd 1c c1             	fstpl  (%ecx,%eax,8)
    else
        next_cb_boundary = sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */

    /* apply formula per block type */
    for (sb = 0; sb < SBLIMIT; sb++) {
        for (ss = 0; ss < SSLIMIT; ss++) {
    932d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    9331:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    9335:	0f 8e d3 f9 ff ff    	jle    8d0e <III_dequantize_sample+0xb7>
    }
    else
        next_cb_boundary = sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */

    /* apply formula per block type */
    for (sb = 0; sb < SBLIMIT; sb++) {
    933b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    933f:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    9343:	0f 8e b9 f9 ff ff    	jle    8d02 <III_dequantize_sample+0xab>
            sign = (is[sb][ss] < 0) ? 1 : 0;
            xr[sb][ss] *= pow((double) abs(is[sb][ss]), ((double) 4.0 / 3.0));
            if (sign) xr[sb][ss] = -xr[sb][ss];
        }
    }
}
    9349:	83 c4 50             	add    $0x50,%esp
    934c:	5b                   	pop    %ebx
    934d:	5e                   	pop    %esi
    934e:	5d                   	pop    %ebp
    934f:	c3                   	ret    

00009350 <III_reorder>:


void III_reorder(double xr[SBLIMIT][SSLIMIT], double ro[SBLIMIT][SSLIMIT], struct gr_info_s *gr_info,
                 struct frame_params *fr_ps) {
    9350:	55                   	push   %ebp
    9351:	89 e5                	mov    %esp,%ebp
    9353:	57                   	push   %edi
    9354:	56                   	push   %esi
    9355:	53                   	push   %ebx
    9356:	83 ec 34             	sub    $0x34,%esp
    int sfreq = fr_ps->header->sampling_frequency;
    9359:	8b 45 14             	mov    0x14(%ebp),%eax
    935c:	8b 00                	mov    (%eax),%eax
    935e:	8b 40 10             	mov    0x10(%eax),%eax
    9361:	89 45 d0             	mov    %eax,-0x30(%ebp)
    int sfb, sfb_start, sfb_lines;
    int sb, ss, window, freq, src_line, des_line;

    for (sb = 0; sb < SBLIMIT; sb++)
    9364:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    936b:	eb 33                	jmp    93a0 <III_reorder+0x50>
        for (ss = 0; ss < SSLIMIT; ss++)
    936d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    9374:	eb 20                	jmp    9396 <III_reorder+0x46>
            ro[sb][ss] = 0;
    9376:	8b 55 e0             	mov    -0x20(%ebp),%edx
    9379:	89 d0                	mov    %edx,%eax
    937b:	c1 e0 03             	shl    $0x3,%eax
    937e:	01 d0                	add    %edx,%eax
    9380:	c1 e0 04             	shl    $0x4,%eax
    9383:	89 c2                	mov    %eax,%edx
    9385:	8b 45 0c             	mov    0xc(%ebp),%eax
    9388:	01 c2                	add    %eax,%edx
    938a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    938d:	d9 ee                	fldz   
    938f:	dd 1c c2             	fstpl  (%edx,%eax,8)
    int sfreq = fr_ps->header->sampling_frequency;
    int sfb, sfb_start, sfb_lines;
    int sb, ss, window, freq, src_line, des_line;

    for (sb = 0; sb < SBLIMIT; sb++)
        for (ss = 0; ss < SSLIMIT; ss++)
    9392:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    9396:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    939a:	7e da                	jle    9376 <III_reorder+0x26>
                 struct frame_params *fr_ps) {
    int sfreq = fr_ps->header->sampling_frequency;
    int sfb, sfb_start, sfb_lines;
    int sb, ss, window, freq, src_line, des_line;

    for (sb = 0; sb < SBLIMIT; sb++)
    939c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    93a0:	83 7d e0 1f          	cmpl   $0x1f,-0x20(%ebp)
    93a4:	7e c7                	jle    936d <III_reorder+0x1d>
        for (ss = 0; ss < SSLIMIT; ss++)
            ro[sb][ss] = 0;

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    93a6:	8b 45 10             	mov    0x10(%ebp),%eax
    93a9:	8b 40 10             	mov    0x10(%eax),%eax
    93ac:	85 c0                	test   %eax,%eax
    93ae:	0f 84 af 03 00 00    	je     9763 <III_reorder+0x413>
    93b4:	8b 45 10             	mov    0x10(%ebp),%eax
    93b7:	8b 40 14             	mov    0x14(%eax),%eax
    93ba:	83 f8 02             	cmp    $0x2,%eax
    93bd:	0f 85 a0 03 00 00    	jne    9763 <III_reorder+0x413>
        if (gr_info->mixed_block_flag) {
    93c3:	8b 45 10             	mov    0x10(%ebp),%eax
    93c6:	8b 40 18             	mov    0x18(%eax),%eax
    93c9:	85 c0                	test   %eax,%eax
    93cb:	0f 84 00 02 00 00    	je     95d1 <III_reorder+0x281>
            for (sb = 0; sb < 2; sb++)
    93d1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    93d8:	eb 4c                	jmp    9426 <III_reorder+0xd6>
                for (ss = 0; ss < SSLIMIT; ss++) {
    93da:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    93e1:	eb 39                	jmp    941c <III_reorder+0xcc>
                    ro[sb][ss] = xr[sb][ss];
    93e3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    93e6:	89 d0                	mov    %edx,%eax
    93e8:	c1 e0 03             	shl    $0x3,%eax
    93eb:	01 d0                	add    %edx,%eax
    93ed:	c1 e0 04             	shl    $0x4,%eax
    93f0:	89 c2                	mov    %eax,%edx
    93f2:	8b 45 0c             	mov    0xc(%ebp),%eax
    93f5:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    93f8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    93fb:	89 d0                	mov    %edx,%eax
    93fd:	c1 e0 03             	shl    $0x3,%eax
    9400:	01 d0                	add    %edx,%eax
    9402:	c1 e0 04             	shl    $0x4,%eax
    9405:	89 c2                	mov    %eax,%edx
    9407:	8b 45 08             	mov    0x8(%ebp),%eax
    940a:	01 c2                	add    %eax,%edx
    940c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    940f:	dd 04 c2             	fldl   (%edx,%eax,8)
    9412:	8b 45 dc             	mov    -0x24(%ebp),%eax
    9415:	dd 1c c1             	fstpl  (%ecx,%eax,8)
            ro[sb][ss] = 0;

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
        if (gr_info->mixed_block_flag) {
            for (sb = 0; sb < 2; sb++)
                for (ss = 0; ss < SSLIMIT; ss++) {
    9418:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    941c:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    9420:	7e c1                	jle    93e3 <III_reorder+0x93>
        for (ss = 0; ss < SSLIMIT; ss++)
            ro[sb][ss] = 0;

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
        if (gr_info->mixed_block_flag) {
            for (sb = 0; sb < 2; sb++)
    9422:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    9426:	83 7d e0 01          	cmpl   $0x1,-0x20(%ebp)
    942a:	7e ae                	jle    93da <III_reorder+0x8a>
                for (ss = 0; ss < SSLIMIT; ss++) {
                    ro[sb][ss] = xr[sb][ss];
                }
            for (sfb = 3, sfb_start = sfBandIndex[sfreq].s[3],
    942c:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
    9433:	8b 45 d0             	mov    -0x30(%ebp),%eax
    9436:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    943c:	05 fc f4 00 00       	add    $0xf4fc,%eax
    9441:	8b 40 0c             	mov    0xc(%eax),%eax
    9444:	89 45 e8             	mov    %eax,-0x18(%ebp)
                 sfb_lines = sfBandIndex[sfreq].s[4] - sfb_start;
    9447:	8b 45 d0             	mov    -0x30(%ebp),%eax
    944a:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9450:	05 00 f5 00 00       	add    $0xf500,%eax
    9455:	8b 40 0c             	mov    0xc(%eax),%eax
    9458:	2b 45 e8             	sub    -0x18(%ebp),%eax
    945b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if (gr_info->mixed_block_flag) {
            for (sb = 0; sb < 2; sb++)
                for (ss = 0; ss < SSLIMIT; ss++) {
                    ro[sb][ss] = xr[sb][ss];
                }
            for (sfb = 3, sfb_start = sfBandIndex[sfreq].s[3],
    945e:	e9 5f 01 00 00       	jmp    95c2 <III_reorder+0x272>
                 sfb_lines = sfBandIndex[sfreq].s[4] - sfb_start;
                 sfb < 13; sfb++, sfb_start = sfBandIndex[sfreq].s[sfb],
                         (sfb_lines = sfBandIndex[sfreq].s[sfb + 1] - sfb_start))
                for (window = 0; window < 3; window++)
    9463:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    946a:	e9 fd 00 00 00       	jmp    956c <III_reorder+0x21c>
                    for (freq = 0; freq < sfb_lines; freq++) {
    946f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    9476:	e9 e1 00 00 00       	jmp    955c <III_reorder+0x20c>
                        src_line = sfb_start * 3 + window * sfb_lines + freq;
    947b:	8b 55 e8             	mov    -0x18(%ebp),%edx
    947e:	89 d0                	mov    %edx,%eax
    9480:	01 c0                	add    %eax,%eax
    9482:	01 c2                	add    %eax,%edx
    9484:	8b 45 d8             	mov    -0x28(%ebp),%eax
    9487:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    948b:	01 c2                	add    %eax,%edx
    948d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    9490:	01 d0                	add    %edx,%eax
    9492:	89 45 cc             	mov    %eax,-0x34(%ebp)
                        des_line = (sfb_start * 3) + window + (freq * 3);
    9495:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9498:	89 d0                	mov    %edx,%eax
    949a:	01 c0                	add    %eax,%eax
    949c:	01 c2                	add    %eax,%edx
    949e:	8b 45 d8             	mov    -0x28(%ebp),%eax
    94a1:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    94a4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    94a7:	89 d0                	mov    %edx,%eax
    94a9:	01 c0                	add    %eax,%eax
    94ab:	01 d0                	add    %edx,%eax
    94ad:	01 c8                	add    %ecx,%eax
    94af:	89 45 c8             	mov    %eax,-0x38(%ebp)
                        ro[des_line / SSLIMIT][des_line % SSLIMIT] =
    94b2:	8b 4d c8             	mov    -0x38(%ebp),%ecx
    94b5:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    94ba:	89 c8                	mov    %ecx,%eax
    94bc:	f7 ea                	imul   %edx
    94be:	c1 fa 02             	sar    $0x2,%edx
    94c1:	89 c8                	mov    %ecx,%eax
    94c3:	c1 f8 1f             	sar    $0x1f,%eax
    94c6:	29 c2                	sub    %eax,%edx
    94c8:	89 d0                	mov    %edx,%eax
    94ca:	89 c2                	mov    %eax,%edx
    94cc:	89 d0                	mov    %edx,%eax
    94ce:	c1 e0 03             	shl    $0x3,%eax
    94d1:	01 d0                	add    %edx,%eax
    94d3:	c1 e0 04             	shl    $0x4,%eax
    94d6:	89 c2                	mov    %eax,%edx
    94d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    94db:	8d 34 02             	lea    (%edx,%eax,1),%esi
    94de:	8b 5d c8             	mov    -0x38(%ebp),%ebx
    94e1:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    94e6:	89 d8                	mov    %ebx,%eax
    94e8:	f7 ea                	imul   %edx
    94ea:	c1 fa 02             	sar    $0x2,%edx
    94ed:	89 d8                	mov    %ebx,%eax
    94ef:	c1 f8 1f             	sar    $0x1f,%eax
    94f2:	89 d1                	mov    %edx,%ecx
    94f4:	29 c1                	sub    %eax,%ecx
    94f6:	89 c8                	mov    %ecx,%eax
    94f8:	c1 e0 03             	shl    $0x3,%eax
    94fb:	01 c8                	add    %ecx,%eax
    94fd:	01 c0                	add    %eax,%eax
    94ff:	29 c3                	sub    %eax,%ebx
    9501:	89 d9                	mov    %ebx,%ecx
                                xr[src_line / SSLIMIT][src_line % SSLIMIT];
    9503:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    9506:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    950b:	89 d8                	mov    %ebx,%eax
    950d:	f7 ea                	imul   %edx
    950f:	c1 fa 02             	sar    $0x2,%edx
    9512:	89 d8                	mov    %ebx,%eax
    9514:	c1 f8 1f             	sar    $0x1f,%eax
    9517:	29 c2                	sub    %eax,%edx
    9519:	89 d0                	mov    %edx,%eax
    951b:	89 c2                	mov    %eax,%edx
    951d:	89 d0                	mov    %edx,%eax
    951f:	c1 e0 03             	shl    $0x3,%eax
    9522:	01 d0                	add    %edx,%eax
    9524:	c1 e0 04             	shl    $0x4,%eax
    9527:	89 c2                	mov    %eax,%edx
    9529:	8b 45 08             	mov    0x8(%ebp),%eax
    952c:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    952f:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    9532:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    9537:	89 d8                	mov    %ebx,%eax
    9539:	f7 ea                	imul   %edx
    953b:	c1 fa 02             	sar    $0x2,%edx
    953e:	89 d8                	mov    %ebx,%eax
    9540:	c1 f8 1f             	sar    $0x1f,%eax
    9543:	29 c2                	sub    %eax,%edx
    9545:	89 d0                	mov    %edx,%eax
    9547:	c1 e0 03             	shl    $0x3,%eax
    954a:	01 d0                	add    %edx,%eax
    954c:	01 c0                	add    %eax,%eax
    954e:	29 c3                	sub    %eax,%ebx
    9550:	89 da                	mov    %ebx,%edx
    9552:	dd 04 d7             	fldl   (%edi,%edx,8)
                         (sfb_lines = sfBandIndex[sfreq].s[sfb + 1] - sfb_start))
                for (window = 0; window < 3; window++)
                    for (freq = 0; freq < sfb_lines; freq++) {
                        src_line = sfb_start * 3 + window * sfb_lines + freq;
                        des_line = (sfb_start * 3) + window + (freq * 3);
                        ro[des_line / SSLIMIT][des_line % SSLIMIT] =
    9555:	dd 1c ce             	fstpl  (%esi,%ecx,8)
            for (sfb = 3, sfb_start = sfBandIndex[sfreq].s[3],
                 sfb_lines = sfBandIndex[sfreq].s[4] - sfb_start;
                 sfb < 13; sfb++, sfb_start = sfBandIndex[sfreq].s[sfb],
                         (sfb_lines = sfBandIndex[sfreq].s[sfb + 1] - sfb_start))
                for (window = 0; window < 3; window++)
                    for (freq = 0; freq < sfb_lines; freq++) {
    9558:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    955c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    955f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    9562:	0f 8c 13 ff ff ff    	jl     947b <III_reorder+0x12b>
                }
            for (sfb = 3, sfb_start = sfBandIndex[sfreq].s[3],
                 sfb_lines = sfBandIndex[sfreq].s[4] - sfb_start;
                 sfb < 13; sfb++, sfb_start = sfBandIndex[sfreq].s[sfb],
                         (sfb_lines = sfBandIndex[sfreq].s[sfb + 1] - sfb_start))
                for (window = 0; window < 3; window++)
    9568:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    956c:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
    9570:	0f 8e f9 fe ff ff    	jle    946f <III_reorder+0x11f>
                for (ss = 0; ss < SSLIMIT; ss++) {
                    ro[sb][ss] = xr[sb][ss];
                }
            for (sfb = 3, sfb_start = sfBandIndex[sfreq].s[3],
                 sfb_lines = sfBandIndex[sfreq].s[4] - sfb_start;
                 sfb < 13; sfb++, sfb_start = sfBandIndex[sfreq].s[sfb],
    9576:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    957a:	8b 55 d0             	mov    -0x30(%ebp),%edx
    957d:	89 d0                	mov    %edx,%eax
    957f:	c1 e0 03             	shl    $0x3,%eax
    9582:	01 d0                	add    %edx,%eax
    9584:	c1 e0 02             	shl    $0x2,%eax
    9587:	01 d0                	add    %edx,%eax
    9589:	8b 55 ec             	mov    -0x14(%ebp),%edx
    958c:	01 d0                	add    %edx,%eax
    958e:	83 c0 14             	add    $0x14,%eax
    9591:	8b 04 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%eax
    9598:	89 45 e8             	mov    %eax,-0x18(%ebp)
                         (sfb_lines = sfBandIndex[sfreq].s[sfb + 1] - sfb_start))
    959b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    959e:	8d 48 01             	lea    0x1(%eax),%ecx
    95a1:	8b 55 d0             	mov    -0x30(%ebp),%edx
    95a4:	89 d0                	mov    %edx,%eax
    95a6:	c1 e0 03             	shl    $0x3,%eax
    95a9:	01 d0                	add    %edx,%eax
    95ab:	c1 e0 02             	shl    $0x2,%eax
    95ae:	01 d0                	add    %edx,%eax
    95b0:	01 c8                	add    %ecx,%eax
    95b2:	83 c0 14             	add    $0x14,%eax
    95b5:	8b 04 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%eax
    95bc:	2b 45 e8             	sub    -0x18(%ebp),%eax
    95bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if (gr_info->mixed_block_flag) {
            for (sb = 0; sb < 2; sb++)
                for (ss = 0; ss < SSLIMIT; ss++) {
                    ro[sb][ss] = xr[sb][ss];
                }
            for (sfb = 3, sfb_start = sfBandIndex[sfreq].s[3],
    95c2:	83 7d ec 0c          	cmpl   $0xc,-0x14(%ebp)
    95c6:	0f 8e 97 fe ff ff    	jle    9463 <III_reorder+0x113>
    for (sb = 0; sb < SBLIMIT; sb++)
        for (ss = 0; ss < SSLIMIT; ss++)
            ro[sb][ss] = 0;

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
        if (gr_info->mixed_block_flag) {
    95cc:	e9 ed 01 00 00       	jmp    97be <III_reorder+0x46e>
                        ro[des_line / SSLIMIT][des_line % SSLIMIT] =
                                xr[src_line / SSLIMIT][src_line % SSLIMIT];
                    }
        }
        else {
            for (sfb = 0, sfb_start = 0, sfb_lines = sfBandIndex[sfreq].s[1];
    95d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    95d8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    95df:	8b 45 d0             	mov    -0x30(%ebp),%eax
    95e2:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    95e8:	05 f4 f4 00 00       	add    $0xf4f4,%eax
    95ed:	8b 40 0c             	mov    0xc(%eax),%eax
    95f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    95f3:	e9 5f 01 00 00       	jmp    9757 <III_reorder+0x407>
                 sfb < 13; sfb++, sfb_start = sfBandIndex[sfreq].s[sfb],
                         (sfb_lines = sfBandIndex[sfreq].s[sfb + 1] - sfb_start))
                for (window = 0; window < 3; window++)
    95f8:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    95ff:	e9 fd 00 00 00       	jmp    9701 <III_reorder+0x3b1>
                    for (freq = 0; freq < sfb_lines; freq++) {
    9604:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    960b:	e9 e1 00 00 00       	jmp    96f1 <III_reorder+0x3a1>
                        src_line = sfb_start * 3 + window * sfb_lines + freq;
    9610:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9613:	89 d0                	mov    %edx,%eax
    9615:	01 c0                	add    %eax,%eax
    9617:	01 c2                	add    %eax,%edx
    9619:	8b 45 d8             	mov    -0x28(%ebp),%eax
    961c:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    9620:	01 c2                	add    %eax,%edx
    9622:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    9625:	01 d0                	add    %edx,%eax
    9627:	89 45 cc             	mov    %eax,-0x34(%ebp)
                        des_line = (sfb_start * 3) + window + (freq * 3);
    962a:	8b 55 e8             	mov    -0x18(%ebp),%edx
    962d:	89 d0                	mov    %edx,%eax
    962f:	01 c0                	add    %eax,%eax
    9631:	01 c2                	add    %eax,%edx
    9633:	8b 45 d8             	mov    -0x28(%ebp),%eax
    9636:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    9639:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    963c:	89 d0                	mov    %edx,%eax
    963e:	01 c0                	add    %eax,%eax
    9640:	01 d0                	add    %edx,%eax
    9642:	01 c8                	add    %ecx,%eax
    9644:	89 45 c8             	mov    %eax,-0x38(%ebp)
                        ro[des_line / SSLIMIT][des_line % SSLIMIT] =
    9647:	8b 4d c8             	mov    -0x38(%ebp),%ecx
    964a:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    964f:	89 c8                	mov    %ecx,%eax
    9651:	f7 ea                	imul   %edx
    9653:	c1 fa 02             	sar    $0x2,%edx
    9656:	89 c8                	mov    %ecx,%eax
    9658:	c1 f8 1f             	sar    $0x1f,%eax
    965b:	29 c2                	sub    %eax,%edx
    965d:	89 d0                	mov    %edx,%eax
    965f:	89 c2                	mov    %eax,%edx
    9661:	89 d0                	mov    %edx,%eax
    9663:	c1 e0 03             	shl    $0x3,%eax
    9666:	01 d0                	add    %edx,%eax
    9668:	c1 e0 04             	shl    $0x4,%eax
    966b:	89 c2                	mov    %eax,%edx
    966d:	8b 45 0c             	mov    0xc(%ebp),%eax
    9670:	8d 34 02             	lea    (%edx,%eax,1),%esi
    9673:	8b 5d c8             	mov    -0x38(%ebp),%ebx
    9676:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    967b:	89 d8                	mov    %ebx,%eax
    967d:	f7 ea                	imul   %edx
    967f:	c1 fa 02             	sar    $0x2,%edx
    9682:	89 d8                	mov    %ebx,%eax
    9684:	c1 f8 1f             	sar    $0x1f,%eax
    9687:	89 d1                	mov    %edx,%ecx
    9689:	29 c1                	sub    %eax,%ecx
    968b:	89 c8                	mov    %ecx,%eax
    968d:	c1 e0 03             	shl    $0x3,%eax
    9690:	01 c8                	add    %ecx,%eax
    9692:	01 c0                	add    %eax,%eax
    9694:	29 c3                	sub    %eax,%ebx
    9696:	89 d9                	mov    %ebx,%ecx
                                xr[src_line / SSLIMIT][src_line % SSLIMIT];
    9698:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    969b:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    96a0:	89 d8                	mov    %ebx,%eax
    96a2:	f7 ea                	imul   %edx
    96a4:	c1 fa 02             	sar    $0x2,%edx
    96a7:	89 d8                	mov    %ebx,%eax
    96a9:	c1 f8 1f             	sar    $0x1f,%eax
    96ac:	29 c2                	sub    %eax,%edx
    96ae:	89 d0                	mov    %edx,%eax
    96b0:	89 c2                	mov    %eax,%edx
    96b2:	89 d0                	mov    %edx,%eax
    96b4:	c1 e0 03             	shl    $0x3,%eax
    96b7:	01 d0                	add    %edx,%eax
    96b9:	c1 e0 04             	shl    $0x4,%eax
    96bc:	89 c2                	mov    %eax,%edx
    96be:	8b 45 08             	mov    0x8(%ebp),%eax
    96c1:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    96c4:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    96c7:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    96cc:	89 d8                	mov    %ebx,%eax
    96ce:	f7 ea                	imul   %edx
    96d0:	c1 fa 02             	sar    $0x2,%edx
    96d3:	89 d8                	mov    %ebx,%eax
    96d5:	c1 f8 1f             	sar    $0x1f,%eax
    96d8:	29 c2                	sub    %eax,%edx
    96da:	89 d0                	mov    %edx,%eax
    96dc:	c1 e0 03             	shl    $0x3,%eax
    96df:	01 d0                	add    %edx,%eax
    96e1:	01 c0                	add    %eax,%eax
    96e3:	29 c3                	sub    %eax,%ebx
    96e5:	89 da                	mov    %ebx,%edx
    96e7:	dd 04 d7             	fldl   (%edi,%edx,8)
                         (sfb_lines = sfBandIndex[sfreq].s[sfb + 1] - sfb_start))
                for (window = 0; window < 3; window++)
                    for (freq = 0; freq < sfb_lines; freq++) {
                        src_line = sfb_start * 3 + window * sfb_lines + freq;
                        des_line = (sfb_start * 3) + window + (freq * 3);
                        ro[des_line / SSLIMIT][des_line % SSLIMIT] =
    96ea:	dd 1c ce             	fstpl  (%esi,%ecx,8)
        else {
            for (sfb = 0, sfb_start = 0, sfb_lines = sfBandIndex[sfreq].s[1];
                 sfb < 13; sfb++, sfb_start = sfBandIndex[sfreq].s[sfb],
                         (sfb_lines = sfBandIndex[sfreq].s[sfb + 1] - sfb_start))
                for (window = 0; window < 3; window++)
                    for (freq = 0; freq < sfb_lines; freq++) {
    96ed:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    96f1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    96f4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    96f7:	0f 8c 13 ff ff ff    	jl     9610 <III_reorder+0x2c0>
        }
        else {
            for (sfb = 0, sfb_start = 0, sfb_lines = sfBandIndex[sfreq].s[1];
                 sfb < 13; sfb++, sfb_start = sfBandIndex[sfreq].s[sfb],
                         (sfb_lines = sfBandIndex[sfreq].s[sfb + 1] - sfb_start))
                for (window = 0; window < 3; window++)
    96fd:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    9701:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
    9705:	0f 8e f9 fe ff ff    	jle    9604 <III_reorder+0x2b4>
                                xr[src_line / SSLIMIT][src_line % SSLIMIT];
                    }
        }
        else {
            for (sfb = 0, sfb_start = 0, sfb_lines = sfBandIndex[sfreq].s[1];
                 sfb < 13; sfb++, sfb_start = sfBandIndex[sfreq].s[sfb],
    970b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    970f:	8b 55 d0             	mov    -0x30(%ebp),%edx
    9712:	89 d0                	mov    %edx,%eax
    9714:	c1 e0 03             	shl    $0x3,%eax
    9717:	01 d0                	add    %edx,%eax
    9719:	c1 e0 02             	shl    $0x2,%eax
    971c:	01 d0                	add    %edx,%eax
    971e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    9721:	01 d0                	add    %edx,%eax
    9723:	83 c0 14             	add    $0x14,%eax
    9726:	8b 04 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%eax
    972d:	89 45 e8             	mov    %eax,-0x18(%ebp)
                         (sfb_lines = sfBandIndex[sfreq].s[sfb + 1] - sfb_start))
    9730:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9733:	8d 48 01             	lea    0x1(%eax),%ecx
    9736:	8b 55 d0             	mov    -0x30(%ebp),%edx
    9739:	89 d0                	mov    %edx,%eax
    973b:	c1 e0 03             	shl    $0x3,%eax
    973e:	01 d0                	add    %edx,%eax
    9740:	c1 e0 02             	shl    $0x2,%eax
    9743:	01 d0                	add    %edx,%eax
    9745:	01 c8                	add    %ecx,%eax
    9747:	83 c0 14             	add    $0x14,%eax
    974a:	8b 04 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%eax
    9751:	2b 45 e8             	sub    -0x18(%ebp),%eax
    9754:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                        ro[des_line / SSLIMIT][des_line % SSLIMIT] =
                                xr[src_line / SSLIMIT][src_line % SSLIMIT];
                    }
        }
        else {
            for (sfb = 0, sfb_start = 0, sfb_lines = sfBandIndex[sfreq].s[1];
    9757:	83 7d ec 0c          	cmpl   $0xc,-0x14(%ebp)
    975b:	0f 8e 97 fe ff ff    	jle    95f8 <III_reorder+0x2a8>
    for (sb = 0; sb < SBLIMIT; sb++)
        for (ss = 0; ss < SSLIMIT; ss++)
            ro[sb][ss] = 0;

    if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
        if (gr_info->mixed_block_flag) {
    9761:	eb 5b                	jmp    97be <III_reorder+0x46e>
                                xr[src_line / SSLIMIT][src_line % SSLIMIT];
                    }
        }
    }
    else {   /*long blocks */
        for (sb = 0; sb < SBLIMIT; sb++)
    9763:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    976a:	eb 4c                	jmp    97b8 <III_reorder+0x468>
            for (ss = 0; ss < SSLIMIT; ss++)
    976c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    9773:	eb 39                	jmp    97ae <III_reorder+0x45e>
                ro[sb][ss] = xr[sb][ss];
    9775:	8b 55 e0             	mov    -0x20(%ebp),%edx
    9778:	89 d0                	mov    %edx,%eax
    977a:	c1 e0 03             	shl    $0x3,%eax
    977d:	01 d0                	add    %edx,%eax
    977f:	c1 e0 04             	shl    $0x4,%eax
    9782:	89 c2                	mov    %eax,%edx
    9784:	8b 45 0c             	mov    0xc(%ebp),%eax
    9787:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    978a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    978d:	89 d0                	mov    %edx,%eax
    978f:	c1 e0 03             	shl    $0x3,%eax
    9792:	01 d0                	add    %edx,%eax
    9794:	c1 e0 04             	shl    $0x4,%eax
    9797:	89 c2                	mov    %eax,%edx
    9799:	8b 45 08             	mov    0x8(%ebp),%eax
    979c:	01 c2                	add    %eax,%edx
    979e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    97a1:	dd 04 c2             	fldl   (%edx,%eax,8)
    97a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
    97a7:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                    }
        }
    }
    else {   /*long blocks */
        for (sb = 0; sb < SBLIMIT; sb++)
            for (ss = 0; ss < SSLIMIT; ss++)
    97aa:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    97ae:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    97b2:	7e c1                	jle    9775 <III_reorder+0x425>
                                xr[src_line / SSLIMIT][src_line % SSLIMIT];
                    }
        }
    }
    else {   /*long blocks */
        for (sb = 0; sb < SBLIMIT; sb++)
    97b4:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    97b8:	83 7d e0 1f          	cmpl   $0x1f,-0x20(%ebp)
    97bc:	7e ae                	jle    976c <III_reorder+0x41c>
            for (ss = 0; ss < SSLIMIT; ss++)
                ro[sb][ss] = xr[sb][ss];
    }
}
    97be:	83 c4 34             	add    $0x34,%esp
    97c1:	5b                   	pop    %ebx
    97c2:	5e                   	pop    %esi
    97c3:	5f                   	pop    %edi
    97c4:	5d                   	pop    %ebp
    97c5:	c3                   	ret    

000097c6 <III_stereo>:


void III_stereo(double xr[2][SBLIMIT][SSLIMIT], double lr[2][SBLIMIT][SSLIMIT], III_scalefac_t *scalefac,
                struct gr_info_s *gr_info, struct frame_params *fr_ps) {
    97c6:	55                   	push   %ebp
    97c7:	89 e5                	mov    %esp,%ebp
    97c9:	56                   	push   %esi
    97ca:	53                   	push   %ebx
    97cb:	81 ec 50 1b 00 00    	sub    $0x1b50,%esp
    int sfreq = fr_ps->header->sampling_frequency;
    97d1:	8b 45 18             	mov    0x18(%ebp),%eax
    97d4:	8b 00                	mov    (%eax),%eax
    97d6:	8b 40 10             	mov    0x10(%eax),%eax
    97d9:	89 45 c8             	mov    %eax,-0x38(%ebp)
    int stereo = fr_ps->stereo;
    97dc:	8b 45 18             	mov    0x18(%ebp),%eax
    97df:	8b 40 08             	mov    0x8(%eax),%eax
    97e2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    97e5:	8b 45 18             	mov    0x18(%ebp),%eax
    97e8:	8b 00                	mov    (%eax),%eax
    97ea:	8b 40 1c             	mov    0x1c(%eax),%eax
    97ed:	83 f8 01             	cmp    $0x1,%eax
    97f0:	75 16                	jne    9808 <III_stereo+0x42>
                    (fr_ps->header->mode_ext & 0x2);
    97f2:	8b 45 18             	mov    0x18(%ebp),%eax
    97f5:	8b 00                	mov    (%eax),%eax
    97f7:	8b 40 20             	mov    0x20(%eax),%eax
    97fa:	83 e0 02             	and    $0x2,%eax

void III_stereo(double xr[2][SBLIMIT][SSLIMIT], double lr[2][SBLIMIT][SSLIMIT], III_scalefac_t *scalefac,
                struct gr_info_s *gr_info, struct frame_params *fr_ps) {
    int sfreq = fr_ps->header->sampling_frequency;
    int stereo = fr_ps->stereo;
    int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    97fd:	85 c0                	test   %eax,%eax
    97ff:	74 07                	je     9808 <III_stereo+0x42>
    9801:	b8 01 00 00 00       	mov    $0x1,%eax
    9806:	eb 05                	jmp    980d <III_stereo+0x47>
    9808:	b8 00 00 00 00       	mov    $0x0,%eax
    980d:	89 45 c0             	mov    %eax,-0x40(%ebp)
                    (fr_ps->header->mode_ext & 0x2);
    int i_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    9810:	8b 45 18             	mov    0x18(%ebp),%eax
    9813:	8b 00                	mov    (%eax),%eax
    9815:	8b 40 1c             	mov    0x1c(%eax),%eax
    9818:	83 f8 01             	cmp    $0x1,%eax
    981b:	75 16                	jne    9833 <III_stereo+0x6d>
                   (fr_ps->header->mode_ext & 0x1);
    981d:	8b 45 18             	mov    0x18(%ebp),%eax
    9820:	8b 00                	mov    (%eax),%eax
    9822:	8b 40 20             	mov    0x20(%eax),%eax
    9825:	83 e0 01             	and    $0x1,%eax
                struct gr_info_s *gr_info, struct frame_params *fr_ps) {
    int sfreq = fr_ps->header->sampling_frequency;
    int stereo = fr_ps->stereo;
    int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
                    (fr_ps->header->mode_ext & 0x2);
    int i_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    9828:	85 c0                	test   %eax,%eax
    982a:	74 07                	je     9833 <III_stereo+0x6d>
    982c:	b8 01 00 00 00       	mov    $0x1,%eax
    9831:	eb 05                	jmp    9838 <III_stereo+0x72>
    9833:	b8 00 00 00 00       	mov    $0x0,%eax
    9838:	89 45 bc             	mov    %eax,-0x44(%ebp)
    int sfb;
    int i, j, sb, ss, ch, is_pos[576];
    double is_ratio[576];

    /* intialization */
    for (i = 0; i < 576; i++)
    983b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    9842:	eb 12                	jmp    9856 <III_stereo+0x90>
        is_pos[i] = 7;
    9844:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9847:	c7 84 85 bc f6 ff ff 	movl   $0x7,-0x944(%ebp,%eax,4)
    984e:	07 00 00 00 
    int sfb;
    int i, j, sb, ss, ch, is_pos[576];
    double is_ratio[576];

    /* intialization */
    for (i = 0; i < 576; i++)
    9852:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    9856:	81 7d f0 3f 02 00 00 	cmpl   $0x23f,-0x10(%ebp)
    985d:	7e e5                	jle    9844 <III_stereo+0x7e>
        is_pos[i] = 7;

    if ((stereo == 2) && i_stereo) {
    985f:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
    9863:	0f 85 18 0a 00 00    	jne    a281 <III_stereo+0xabb>
    9869:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
    986d:	0f 84 0e 0a 00 00    	je     a281 <III_stereo+0xabb>
        if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    9873:	8b 45 14             	mov    0x14(%ebp),%eax
    9876:	8b 40 10             	mov    0x10(%eax),%eax
    9879:	85 c0                	test   %eax,%eax
    987b:	0f 84 10 08 00 00    	je     a091 <III_stereo+0x8cb>
    9881:	8b 45 14             	mov    0x14(%ebp),%eax
    9884:	8b 40 14             	mov    0x14(%eax),%eax
    9887:	83 f8 02             	cmp    $0x2,%eax
    988a:	0f 85 01 08 00 00    	jne    a091 <III_stereo+0x8cb>
            if (gr_info->mixed_block_flag) {
    9890:	8b 45 14             	mov    0x14(%ebp),%eax
    9893:	8b 40 18             	mov    0x18(%eax),%eax
    9896:	85 c0                	test   %eax,%eax
    9898:	0f 84 d0 04 00 00    	je     9d6e <III_stereo+0x5a8>
                int max_sfb = 0;
    989e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)

                for (j = 0; j < 3; j++) {
    98a5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    98ac:	e9 1b 03 00 00       	jmp    9bcc <III_stereo+0x406>
                    int sfbcnt;
                    sfbcnt = 2;
    98b1:	c7 45 d8 02 00 00 00 	movl   $0x2,-0x28(%ebp)
                    for (sfb = 12; sfb >= 3; sfb--) {
    98b8:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    98bf:	e9 0f 01 00 00       	jmp    99d3 <III_stereo+0x20d>
                        int lines;
                        lines = sfBandIndex[sfreq].s[sfb + 1] - sfBandIndex[sfreq].s[sfb];
    98c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    98c7:	8d 48 01             	lea    0x1(%eax),%ecx
    98ca:	8b 55 c8             	mov    -0x38(%ebp),%edx
    98cd:	89 d0                	mov    %edx,%eax
    98cf:	c1 e0 03             	shl    $0x3,%eax
    98d2:	01 d0                	add    %edx,%eax
    98d4:	c1 e0 02             	shl    $0x2,%eax
    98d7:	01 d0                	add    %edx,%eax
    98d9:	01 c8                	add    %ecx,%eax
    98db:	83 c0 14             	add    $0x14,%eax
    98de:	8b 0c 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%ecx
    98e5:	8b 55 c8             	mov    -0x38(%ebp),%edx
    98e8:	89 d0                	mov    %edx,%eax
    98ea:	c1 e0 03             	shl    $0x3,%eax
    98ed:	01 d0                	add    %edx,%eax
    98ef:	c1 e0 02             	shl    $0x2,%eax
    98f2:	01 d0                	add    %edx,%eax
    98f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    98f7:	01 d0                	add    %edx,%eax
    98f9:	83 c0 14             	add    $0x14,%eax
    98fc:	8b 04 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%eax
    9903:	29 c1                	sub    %eax,%ecx
    9905:	89 c8                	mov    %ecx,%eax
    9907:	89 45 d4             	mov    %eax,-0x2c(%ebp)
                        i = 3 * sfBandIndex[sfreq].s[sfb] + (j + 1) * lines - 1;
    990a:	8b 55 c8             	mov    -0x38(%ebp),%edx
    990d:	89 d0                	mov    %edx,%eax
    990f:	c1 e0 03             	shl    $0x3,%eax
    9912:	01 d0                	add    %edx,%eax
    9914:	c1 e0 02             	shl    $0x2,%eax
    9917:	01 d0                	add    %edx,%eax
    9919:	8b 55 f4             	mov    -0xc(%ebp),%edx
    991c:	01 d0                	add    %edx,%eax
    991e:	83 c0 14             	add    $0x14,%eax
    9921:	8b 14 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%edx
    9928:	89 d0                	mov    %edx,%eax
    992a:	01 c0                	add    %eax,%eax
    992c:	01 c2                	add    %eax,%edx
    992e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9931:	83 c0 01             	add    $0x1,%eax
    9934:	0f af 45 d4          	imul   -0x2c(%ebp),%eax
    9938:	01 d0                	add    %edx,%eax
    993a:	83 e8 01             	sub    $0x1,%eax
    993d:	89 45 f0             	mov    %eax,-0x10(%ebp)
                        while (lines > 0) {
    9940:	e9 80 00 00 00       	jmp    99c5 <III_stereo+0x1ff>
                            if (xr[1][i / SSLIMIT][i % SSLIMIT] != 0.0) {
    9945:	8b 45 08             	mov    0x8(%ebp),%eax
    9948:	8d b0 00 12 00 00    	lea    0x1200(%eax),%esi
    994e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    9951:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    9956:	89 c8                	mov    %ecx,%eax
    9958:	f7 ea                	imul   %edx
    995a:	c1 fa 02             	sar    $0x2,%edx
    995d:	89 c8                	mov    %ecx,%eax
    995f:	c1 f8 1f             	sar    $0x1f,%eax
    9962:	89 d3                	mov    %edx,%ebx
    9964:	29 c3                	sub    %eax,%ebx
    9966:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    9969:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    996e:	89 c8                	mov    %ecx,%eax
    9970:	f7 ea                	imul   %edx
    9972:	c1 fa 02             	sar    $0x2,%edx
    9975:	89 c8                	mov    %ecx,%eax
    9977:	c1 f8 1f             	sar    $0x1f,%eax
    997a:	29 c2                	sub    %eax,%edx
    997c:	89 d0                	mov    %edx,%eax
    997e:	c1 e0 03             	shl    $0x3,%eax
    9981:	01 d0                	add    %edx,%eax
    9983:	01 c0                	add    %eax,%eax
    9985:	29 c1                	sub    %eax,%ecx
    9987:	89 ca                	mov    %ecx,%edx
    9989:	89 d8                	mov    %ebx,%eax
    998b:	c1 e0 03             	shl    $0x3,%eax
    998e:	01 d8                	add    %ebx,%eax
    9990:	01 c0                	add    %eax,%eax
    9992:	01 d0                	add    %edx,%eax
    9994:	dd 04 c6             	fldl   (%esi,%eax,8)
    9997:	d9 ee                	fldz   
    9999:	df e9                	fucomip %st(1),%st
    999b:	7a 0a                	jp     99a7 <III_stereo+0x1e1>
    999d:	d9 ee                	fldz   
    999f:	df e9                	fucomip %st(1),%st
    99a1:	dd d8                	fstp   %st(0)
    99a3:	74 18                	je     99bd <III_stereo+0x1f7>
    99a5:	eb 02                	jmp    99a9 <III_stereo+0x1e3>
    99a7:	dd d8                	fstp   %st(0)
                                sfbcnt = sfb;
    99a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    99ac:	89 45 d8             	mov    %eax,-0x28(%ebp)
                                sfb = -10;
    99af:	c7 45 f4 f6 ff ff ff 	movl   $0xfffffff6,-0xc(%ebp)
                                lines = -10;
    99b6:	c7 45 d4 f6 ff ff ff 	movl   $0xfffffff6,-0x2c(%ebp)
                            }
                            lines--;
    99bd:	83 6d d4 01          	subl   $0x1,-0x2c(%ebp)
                            i--;
    99c1:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
                    sfbcnt = 2;
                    for (sfb = 12; sfb >= 3; sfb--) {
                        int lines;
                        lines = sfBandIndex[sfreq].s[sfb + 1] - sfBandIndex[sfreq].s[sfb];
                        i = 3 * sfBandIndex[sfreq].s[sfb] + (j + 1) * lines - 1;
                        while (lines > 0) {
    99c5:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    99c9:	0f 8f 76 ff ff ff    	jg     9945 <III_stereo+0x17f>
                int max_sfb = 0;

                for (j = 0; j < 3; j++) {
                    int sfbcnt;
                    sfbcnt = 2;
                    for (sfb = 12; sfb >= 3; sfb--) {
    99cf:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    99d3:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
    99d7:	0f 8f e7 fe ff ff    	jg     98c4 <III_stereo+0xfe>
                            }
                            lines--;
                            i--;
                        }
                    }
                    sfb = sfbcnt + 1;
    99dd:	8b 45 d8             	mov    -0x28(%ebp),%eax
    99e0:	83 c0 01             	add    $0x1,%eax
    99e3:	89 45 f4             	mov    %eax,-0xc(%ebp)

                    if (sfb > max_sfb)
    99e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    99e9:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    99ec:	7e 0b                	jle    99f9 <III_stereo+0x233>
                        max_sfb = sfb;
    99ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    99f1:	89 45 dc             	mov    %eax,-0x24(%ebp)

                    while (sfb < 12) {
    99f4:	e9 f5 00 00 00       	jmp    9aee <III_stereo+0x328>
    99f9:	e9 f0 00 00 00       	jmp    9aee <III_stereo+0x328>
                        sb = sfBandIndex[sfreq].s[sfb + 1] - sfBandIndex[sfreq].s[sfb];
    99fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9a01:	8d 48 01             	lea    0x1(%eax),%ecx
    9a04:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9a07:	89 d0                	mov    %edx,%eax
    9a09:	c1 e0 03             	shl    $0x3,%eax
    9a0c:	01 d0                	add    %edx,%eax
    9a0e:	c1 e0 02             	shl    $0x2,%eax
    9a11:	01 d0                	add    %edx,%eax
    9a13:	01 c8                	add    %ecx,%eax
    9a15:	83 c0 14             	add    $0x14,%eax
    9a18:	8b 0c 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%ecx
    9a1f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9a22:	89 d0                	mov    %edx,%eax
    9a24:	c1 e0 03             	shl    $0x3,%eax
    9a27:	01 d0                	add    %edx,%eax
    9a29:	c1 e0 02             	shl    $0x2,%eax
    9a2c:	01 d0                	add    %edx,%eax
    9a2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9a31:	01 d0                	add    %edx,%eax
    9a33:	83 c0 14             	add    $0x14,%eax
    9a36:	8b 04 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%eax
    9a3d:	29 c1                	sub    %eax,%ecx
    9a3f:	89 c8                	mov    %ecx,%eax
    9a41:	89 45 e8             	mov    %eax,-0x18(%ebp)
                        i = 3 * sfBandIndex[sfreq].s[sfb] + j * sb;
    9a44:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9a47:	89 d0                	mov    %edx,%eax
    9a49:	c1 e0 03             	shl    $0x3,%eax
    9a4c:	01 d0                	add    %edx,%eax
    9a4e:	c1 e0 02             	shl    $0x2,%eax
    9a51:	01 d0                	add    %edx,%eax
    9a53:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9a56:	01 d0                	add    %edx,%eax
    9a58:	83 c0 14             	add    $0x14,%eax
    9a5b:	8b 14 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%edx
    9a62:	89 d0                	mov    %edx,%eax
    9a64:	01 c0                	add    %eax,%eax
    9a66:	01 c2                	add    %eax,%edx
    9a68:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9a6b:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    9a6f:	01 d0                	add    %edx,%eax
    9a71:	89 45 f0             	mov    %eax,-0x10(%ebp)
                        for (; sb > 0; sb--) {
    9a74:	eb 6e                	jmp    9ae4 <III_stereo+0x31e>
                            is_pos[i] = (*scalefac)[1].s[j][sfb];
    9a76:	8b 4d 10             	mov    0x10(%ebp),%ecx
    9a79:	8b 55 ec             	mov    -0x14(%ebp),%edx
    9a7c:	89 d0                	mov    %edx,%eax
    9a7e:	01 c0                	add    %eax,%eax
    9a80:	01 d0                	add    %edx,%eax
    9a82:	c1 e0 02             	shl    $0x2,%eax
    9a85:	01 d0                	add    %edx,%eax
    9a87:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9a8a:	01 d0                	add    %edx,%eax
    9a8c:	83 c0 52             	add    $0x52,%eax
    9a8f:	8b 54 81 0c          	mov    0xc(%ecx,%eax,4),%edx
    9a93:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9a96:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                            if (is_pos[i] != 7)
    9a9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9aa0:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9aa7:	83 f8 07             	cmp    $0x7,%eax
    9aaa:	74 30                	je     9adc <III_stereo+0x316>
                                is_ratio[i] = tan(is_pos[i] * (PI / 12));
    9aac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9aaf:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9ab6:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    9abc:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    9ac2:	dd 05 60 e0 00 00    	fldl   0xe060
    9ac8:	de c9                	fmulp  %st,%st(1)
    9aca:	dd 1c 24             	fstpl  (%esp)
    9acd:	e8 1d b6 ff ff       	call   50ef <tan>
    9ad2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9ad5:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                            i++;
    9adc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                        max_sfb = sfb;

                    while (sfb < 12) {
                        sb = sfBandIndex[sfreq].s[sfb + 1] - sfBandIndex[sfreq].s[sfb];
                        i = 3 * sfBandIndex[sfreq].s[sfb] + j * sb;
                        for (; sb > 0; sb--) {
    9ae0:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9ae4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9ae8:	7f 8c                	jg     9a76 <III_stereo+0x2b0>
                            is_pos[i] = (*scalefac)[1].s[j][sfb];
                            if (is_pos[i] != 7)
                                is_ratio[i] = tan(is_pos[i] * (PI / 12));
                            i++;
                        }
                        sfb++;
    9aea:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                    sfb = sfbcnt + 1;

                    if (sfb > max_sfb)
                        max_sfb = sfb;

                    while (sfb < 12) {
    9aee:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    9af2:	0f 8e 06 ff ff ff    	jle    99fe <III_stereo+0x238>
                                is_ratio[i] = tan(is_pos[i] * (PI / 12));
                            i++;
                        }
                        sfb++;
                    }
                    sb = sfBandIndex[sfreq].s[11] - sfBandIndex[sfreq].s[10];
    9af8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9afb:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9b01:	05 1c f5 00 00       	add    $0xf51c,%eax
    9b06:	8b 50 0c             	mov    0xc(%eax),%edx
    9b09:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9b0c:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9b12:	05 18 f5 00 00       	add    $0xf518,%eax
    9b17:	8b 40 0c             	mov    0xc(%eax),%eax
    9b1a:	29 c2                	sub    %eax,%edx
    9b1c:	89 d0                	mov    %edx,%eax
    9b1e:	89 45 e8             	mov    %eax,-0x18(%ebp)
                    sfb = 3 * sfBandIndex[sfreq].s[10] + j * sb;
    9b21:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9b24:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9b2a:	05 18 f5 00 00       	add    $0xf518,%eax
    9b2f:	8b 50 0c             	mov    0xc(%eax),%edx
    9b32:	89 d0                	mov    %edx,%eax
    9b34:	01 c0                	add    %eax,%eax
    9b36:	01 c2                	add    %eax,%edx
    9b38:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9b3b:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    9b3f:	01 d0                	add    %edx,%eax
    9b41:	89 45 f4             	mov    %eax,-0xc(%ebp)
                    sb = sfBandIndex[sfreq].s[12] - sfBandIndex[sfreq].s[11];
    9b44:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9b47:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9b4d:	05 20 f5 00 00       	add    $0xf520,%eax
    9b52:	8b 50 0c             	mov    0xc(%eax),%edx
    9b55:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9b58:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9b5e:	05 1c f5 00 00       	add    $0xf51c,%eax
    9b63:	8b 40 0c             	mov    0xc(%eax),%eax
    9b66:	29 c2                	sub    %eax,%edx
    9b68:	89 d0                	mov    %edx,%eax
    9b6a:	89 45 e8             	mov    %eax,-0x18(%ebp)
                    i = 3 * sfBandIndex[sfreq].s[11] + j * sb;
    9b6d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9b70:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9b76:	05 1c f5 00 00       	add    $0xf51c,%eax
    9b7b:	8b 50 0c             	mov    0xc(%eax),%edx
    9b7e:	89 d0                	mov    %edx,%eax
    9b80:	01 c0                	add    %eax,%eax
    9b82:	01 c2                	add    %eax,%edx
    9b84:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9b87:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    9b8b:	01 d0                	add    %edx,%eax
    9b8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
                    for (; sb > 0; sb--) {
    9b90:	eb 30                	jmp    9bc2 <III_stereo+0x3fc>
                        is_pos[i] = is_pos[sfb];
    9b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9b95:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    9b9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9b9f:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                        is_ratio[i] = is_ratio[sfb];
    9ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9ba9:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    9bb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9bb3:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                        i++;
    9bba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                    }
                    sb = sfBandIndex[sfreq].s[11] - sfBandIndex[sfreq].s[10];
                    sfb = 3 * sfBandIndex[sfreq].s[10] + j * sb;
                    sb = sfBandIndex[sfreq].s[12] - sfBandIndex[sfreq].s[11];
                    i = 3 * sfBandIndex[sfreq].s[11] + j * sb;
                    for (; sb > 0; sb--) {
    9bbe:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9bc2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9bc6:	7f ca                	jg     9b92 <III_stereo+0x3cc>
    if ((stereo == 2) && i_stereo) {
        if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
            if (gr_info->mixed_block_flag) {
                int max_sfb = 0;

                for (j = 0; j < 3; j++) {
    9bc8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    9bcc:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    9bd0:	0f 8e db fc ff ff    	jle    98b1 <III_stereo+0xeb>
                        is_pos[i] = is_pos[sfb];
                        is_ratio[i] = is_ratio[sfb];
                        i++;
                    }
                }
                if (max_sfb <= 3) {
    9bd6:	83 7d dc 03          	cmpl   $0x3,-0x24(%ebp)
    9bda:	0f 8f 89 01 00 00    	jg     9d69 <III_stereo+0x5a3>
                    i = 2;
    9be0:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
                    ss = 17;
    9be7:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
                    sb = -1;
    9bee:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
                    while (i >= 0) {
    9bf5:	eb 63                	jmp    9c5a <III_stereo+0x494>
                        if (xr[1][i][ss] != 0.0) {
    9bf7:	8b 45 08             	mov    0x8(%ebp),%eax
    9bfa:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    9c00:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9c03:	89 d0                	mov    %edx,%eax
    9c05:	c1 e0 03             	shl    $0x3,%eax
    9c08:	01 d0                	add    %edx,%eax
    9c0a:	01 c0                	add    %eax,%eax
    9c0c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9c0f:	01 d0                	add    %edx,%eax
    9c11:	dd 04 c1             	fldl   (%ecx,%eax,8)
    9c14:	d9 ee                	fldz   
    9c16:	df e9                	fucomip %st(1),%st
    9c18:	7a 0a                	jp     9c24 <III_stereo+0x45e>
    9c1a:	d9 ee                	fldz   
    9c1c:	df e9                	fucomip %st(1),%st
    9c1e:	dd d8                	fstp   %st(0)
    9c20:	74 23                	je     9c45 <III_stereo+0x47f>
    9c22:	eb 02                	jmp    9c26 <III_stereo+0x460>
    9c24:	dd d8                	fstp   %st(0)
                            sb = i * 18 + ss;
    9c26:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9c29:	89 d0                	mov    %edx,%eax
    9c2b:	c1 e0 03             	shl    $0x3,%eax
    9c2e:	01 d0                	add    %edx,%eax
    9c30:	01 c0                	add    %eax,%eax
    9c32:	89 c2                	mov    %eax,%edx
    9c34:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    9c37:	01 d0                	add    %edx,%eax
    9c39:	89 45 e8             	mov    %eax,-0x18(%ebp)
                            i = -1;
    9c3c:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    9c43:	eb 15                	jmp    9c5a <III_stereo+0x494>
                        } else {
                            ss--;
    9c45:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
                            if (ss < 0) {
    9c49:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    9c4d:	79 0b                	jns    9c5a <III_stereo+0x494>
                                i--;
    9c4f:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
                                ss = 17;
    9c53:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
                }
                if (max_sfb <= 3) {
                    i = 2;
                    ss = 17;
                    sb = -1;
                    while (i >= 0) {
    9c5a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    9c5e:	79 97                	jns    9bf7 <III_stereo+0x431>
                                i--;
                                ss = 17;
                            }
                        }
                    }
                    i = 0;
    9c60:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                    while (sfBandIndex[sfreq].l[i] <= sb)
    9c67:	eb 04                	jmp    9c6d <III_stereo+0x4a7>
                        i++;
    9c69:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                                ss = 17;
                            }
                        }
                    }
                    i = 0;
                    while (sfBandIndex[sfreq].l[i] <= sb)
    9c6d:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9c70:	89 d0                	mov    %edx,%eax
    9c72:	c1 e0 03             	shl    $0x3,%eax
    9c75:	01 d0                	add    %edx,%eax
    9c77:	c1 e0 02             	shl    $0x2,%eax
    9c7a:	01 d0                	add    %edx,%eax
    9c7c:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9c7f:	01 d0                	add    %edx,%eax
    9c81:	8b 04 85 a0 f4 00 00 	mov    0xf4a0(,%eax,4),%eax
    9c88:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    9c8b:	7e dc                	jle    9c69 <III_stereo+0x4a3>
                        i++;
                    sfb = i;
    9c8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9c90:	89 45 f4             	mov    %eax,-0xc(%ebp)
                    i = sfBandIndex[sfreq].l[i];
    9c93:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9c96:	89 d0                	mov    %edx,%eax
    9c98:	c1 e0 03             	shl    $0x3,%eax
    9c9b:	01 d0                	add    %edx,%eax
    9c9d:	c1 e0 02             	shl    $0x2,%eax
    9ca0:	01 d0                	add    %edx,%eax
    9ca2:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9ca5:	01 d0                	add    %edx,%eax
    9ca7:	8b 04 85 a0 f4 00 00 	mov    0xf4a0(,%eax,4),%eax
    9cae:	89 45 f0             	mov    %eax,-0x10(%ebp)
                    for (; sfb < 8; sfb++) {
    9cb1:	e9 a9 00 00 00       	jmp    9d5f <III_stereo+0x599>
                        sb = sfBandIndex[sfreq].l[sfb + 1] - sfBandIndex[sfreq].l[sfb];
    9cb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9cb9:	8d 48 01             	lea    0x1(%eax),%ecx
    9cbc:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9cbf:	89 d0                	mov    %edx,%eax
    9cc1:	c1 e0 03             	shl    $0x3,%eax
    9cc4:	01 d0                	add    %edx,%eax
    9cc6:	c1 e0 02             	shl    $0x2,%eax
    9cc9:	01 d0                	add    %edx,%eax
    9ccb:	01 c8                	add    %ecx,%eax
    9ccd:	8b 0c 85 a0 f4 00 00 	mov    0xf4a0(,%eax,4),%ecx
    9cd4:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9cd7:	89 d0                	mov    %edx,%eax
    9cd9:	c1 e0 03             	shl    $0x3,%eax
    9cdc:	01 d0                	add    %edx,%eax
    9cde:	c1 e0 02             	shl    $0x2,%eax
    9ce1:	01 d0                	add    %edx,%eax
    9ce3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9ce6:	01 d0                	add    %edx,%eax
    9ce8:	8b 04 85 a0 f4 00 00 	mov    0xf4a0(,%eax,4),%eax
    9cef:	29 c1                	sub    %eax,%ecx
    9cf1:	89 c8                	mov    %ecx,%eax
    9cf3:	89 45 e8             	mov    %eax,-0x18(%ebp)
                        for (; sb > 0; sb--) {
    9cf6:	eb 5d                	jmp    9d55 <III_stereo+0x58f>
                            is_pos[i] = (*scalefac)[1].l[sfb];
    9cf8:	8b 45 10             	mov    0x10(%ebp),%eax
    9cfb:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9cfe:	83 c2 3e             	add    $0x3e,%edx
    9d01:	8b 14 90             	mov    (%eax,%edx,4),%edx
    9d04:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9d07:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                            if (is_pos[i] != 7)
    9d0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9d11:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9d18:	83 f8 07             	cmp    $0x7,%eax
    9d1b:	74 30                	je     9d4d <III_stereo+0x587>
                                is_ratio[i] = tan(is_pos[i] * (PI / 12));
    9d1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9d20:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9d27:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    9d2d:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    9d33:	dd 05 60 e0 00 00    	fldl   0xe060
    9d39:	de c9                	fmulp  %st,%st(1)
    9d3b:	dd 1c 24             	fstpl  (%esp)
    9d3e:	e8 ac b3 ff ff       	call   50ef <tan>
    9d43:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9d46:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                            i++;
    9d4d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                        i++;
                    sfb = i;
                    i = sfBandIndex[sfreq].l[i];
                    for (; sfb < 8; sfb++) {
                        sb = sfBandIndex[sfreq].l[sfb + 1] - sfBandIndex[sfreq].l[sfb];
                        for (; sb > 0; sb--) {
    9d51:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9d55:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9d59:	7f 9d                	jg     9cf8 <III_stereo+0x532>
                    i = 0;
                    while (sfBandIndex[sfreq].l[i] <= sb)
                        i++;
                    sfb = i;
                    i = sfBandIndex[sfreq].l[i];
                    for (; sfb < 8; sfb++) {
    9d5b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    9d5f:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    9d63:	0f 8e 4d ff ff ff    	jle    9cb6 <III_stereo+0x4f0>
    9d69:	e9 1e 03 00 00       	jmp    a08c <III_stereo+0x8c6>
                            i++;
                        }
                    }
                }
            } else {
                for (j = 0; j < 3; j++) {
    9d6e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    9d75:	e9 08 03 00 00       	jmp    a082 <III_stereo+0x8bc>
                    int sfbcnt;
                    sfbcnt = -1;
    9d7a:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%ebp)
                    for (sfb = 12; sfb >= 0; sfb--) {
    9d81:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    9d88:	e9 0f 01 00 00       	jmp    9e9c <III_stereo+0x6d6>
                        int lines;
                        lines = sfBandIndex[sfreq].s[sfb + 1] - sfBandIndex[sfreq].s[sfb];
    9d8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9d90:	8d 48 01             	lea    0x1(%eax),%ecx
    9d93:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9d96:	89 d0                	mov    %edx,%eax
    9d98:	c1 e0 03             	shl    $0x3,%eax
    9d9b:	01 d0                	add    %edx,%eax
    9d9d:	c1 e0 02             	shl    $0x2,%eax
    9da0:	01 d0                	add    %edx,%eax
    9da2:	01 c8                	add    %ecx,%eax
    9da4:	83 c0 14             	add    $0x14,%eax
    9da7:	8b 0c 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%ecx
    9dae:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9db1:	89 d0                	mov    %edx,%eax
    9db3:	c1 e0 03             	shl    $0x3,%eax
    9db6:	01 d0                	add    %edx,%eax
    9db8:	c1 e0 02             	shl    $0x2,%eax
    9dbb:	01 d0                	add    %edx,%eax
    9dbd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9dc0:	01 d0                	add    %edx,%eax
    9dc2:	83 c0 14             	add    $0x14,%eax
    9dc5:	8b 04 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%eax
    9dcc:	29 c1                	sub    %eax,%ecx
    9dce:	89 c8                	mov    %ecx,%eax
    9dd0:	89 45 cc             	mov    %eax,-0x34(%ebp)
                        i = 3 * sfBandIndex[sfreq].s[sfb] + (j + 1) * lines - 1;
    9dd3:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9dd6:	89 d0                	mov    %edx,%eax
    9dd8:	c1 e0 03             	shl    $0x3,%eax
    9ddb:	01 d0                	add    %edx,%eax
    9ddd:	c1 e0 02             	shl    $0x2,%eax
    9de0:	01 d0                	add    %edx,%eax
    9de2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9de5:	01 d0                	add    %edx,%eax
    9de7:	83 c0 14             	add    $0x14,%eax
    9dea:	8b 14 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%edx
    9df1:	89 d0                	mov    %edx,%eax
    9df3:	01 c0                	add    %eax,%eax
    9df5:	01 c2                	add    %eax,%edx
    9df7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9dfa:	83 c0 01             	add    $0x1,%eax
    9dfd:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    9e01:	01 d0                	add    %edx,%eax
    9e03:	83 e8 01             	sub    $0x1,%eax
    9e06:	89 45 f0             	mov    %eax,-0x10(%ebp)
                        while (lines > 0) {
    9e09:	e9 80 00 00 00       	jmp    9e8e <III_stereo+0x6c8>
                            if (xr[1][i / SSLIMIT][i % SSLIMIT] != 0.0) {
    9e0e:	8b 45 08             	mov    0x8(%ebp),%eax
    9e11:	8d b0 00 12 00 00    	lea    0x1200(%eax),%esi
    9e17:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    9e1a:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    9e1f:	89 c8                	mov    %ecx,%eax
    9e21:	f7 ea                	imul   %edx
    9e23:	c1 fa 02             	sar    $0x2,%edx
    9e26:	89 c8                	mov    %ecx,%eax
    9e28:	c1 f8 1f             	sar    $0x1f,%eax
    9e2b:	89 d3                	mov    %edx,%ebx
    9e2d:	29 c3                	sub    %eax,%ebx
    9e2f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    9e32:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    9e37:	89 c8                	mov    %ecx,%eax
    9e39:	f7 ea                	imul   %edx
    9e3b:	c1 fa 02             	sar    $0x2,%edx
    9e3e:	89 c8                	mov    %ecx,%eax
    9e40:	c1 f8 1f             	sar    $0x1f,%eax
    9e43:	29 c2                	sub    %eax,%edx
    9e45:	89 d0                	mov    %edx,%eax
    9e47:	c1 e0 03             	shl    $0x3,%eax
    9e4a:	01 d0                	add    %edx,%eax
    9e4c:	01 c0                	add    %eax,%eax
    9e4e:	29 c1                	sub    %eax,%ecx
    9e50:	89 ca                	mov    %ecx,%edx
    9e52:	89 d8                	mov    %ebx,%eax
    9e54:	c1 e0 03             	shl    $0x3,%eax
    9e57:	01 d8                	add    %ebx,%eax
    9e59:	01 c0                	add    %eax,%eax
    9e5b:	01 d0                	add    %edx,%eax
    9e5d:	dd 04 c6             	fldl   (%esi,%eax,8)
    9e60:	d9 ee                	fldz   
    9e62:	df e9                	fucomip %st(1),%st
    9e64:	7a 0a                	jp     9e70 <III_stereo+0x6aa>
    9e66:	d9 ee                	fldz   
    9e68:	df e9                	fucomip %st(1),%st
    9e6a:	dd d8                	fstp   %st(0)
    9e6c:	74 18                	je     9e86 <III_stereo+0x6c0>
    9e6e:	eb 02                	jmp    9e72 <III_stereo+0x6ac>
    9e70:	dd d8                	fstp   %st(0)
                                sfbcnt = sfb;
    9e72:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9e75:	89 45 d0             	mov    %eax,-0x30(%ebp)
                                sfb = -10;
    9e78:	c7 45 f4 f6 ff ff ff 	movl   $0xfffffff6,-0xc(%ebp)
                                lines = -10;
    9e7f:	c7 45 cc f6 ff ff ff 	movl   $0xfffffff6,-0x34(%ebp)
                            }
                            lines--;
    9e86:	83 6d cc 01          	subl   $0x1,-0x34(%ebp)
                            i--;
    9e8a:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
                    sfbcnt = -1;
                    for (sfb = 12; sfb >= 0; sfb--) {
                        int lines;
                        lines = sfBandIndex[sfreq].s[sfb + 1] - sfBandIndex[sfreq].s[sfb];
                        i = 3 * sfBandIndex[sfreq].s[sfb] + (j + 1) * lines - 1;
                        while (lines > 0) {
    9e8e:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
    9e92:	0f 8f 76 ff ff ff    	jg     9e0e <III_stereo+0x648>
                }
            } else {
                for (j = 0; j < 3; j++) {
                    int sfbcnt;
                    sfbcnt = -1;
                    for (sfb = 12; sfb >= 0; sfb--) {
    9e98:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    9e9c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    9ea0:	0f 89 e7 fe ff ff    	jns    9d8d <III_stereo+0x5c7>
                            }
                            lines--;
                            i--;
                        }
                    }
                    sfb = sfbcnt + 1;
    9ea6:	8b 45 d0             	mov    -0x30(%ebp),%eax
    9ea9:	83 c0 01             	add    $0x1,%eax
    9eac:	89 45 f4             	mov    %eax,-0xc(%ebp)
                    while (sfb < 12) {
    9eaf:	e9 f0 00 00 00       	jmp    9fa4 <III_stereo+0x7de>
                        sb = sfBandIndex[sfreq].s[sfb + 1] - sfBandIndex[sfreq].s[sfb];
    9eb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9eb7:	8d 48 01             	lea    0x1(%eax),%ecx
    9eba:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9ebd:	89 d0                	mov    %edx,%eax
    9ebf:	c1 e0 03             	shl    $0x3,%eax
    9ec2:	01 d0                	add    %edx,%eax
    9ec4:	c1 e0 02             	shl    $0x2,%eax
    9ec7:	01 d0                	add    %edx,%eax
    9ec9:	01 c8                	add    %ecx,%eax
    9ecb:	83 c0 14             	add    $0x14,%eax
    9ece:	8b 0c 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%ecx
    9ed5:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9ed8:	89 d0                	mov    %edx,%eax
    9eda:	c1 e0 03             	shl    $0x3,%eax
    9edd:	01 d0                	add    %edx,%eax
    9edf:	c1 e0 02             	shl    $0x2,%eax
    9ee2:	01 d0                	add    %edx,%eax
    9ee4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9ee7:	01 d0                	add    %edx,%eax
    9ee9:	83 c0 14             	add    $0x14,%eax
    9eec:	8b 04 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%eax
    9ef3:	29 c1                	sub    %eax,%ecx
    9ef5:	89 c8                	mov    %ecx,%eax
    9ef7:	89 45 e8             	mov    %eax,-0x18(%ebp)
                        i = 3 * sfBandIndex[sfreq].s[sfb] + j * sb;
    9efa:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9efd:	89 d0                	mov    %edx,%eax
    9eff:	c1 e0 03             	shl    $0x3,%eax
    9f02:	01 d0                	add    %edx,%eax
    9f04:	c1 e0 02             	shl    $0x2,%eax
    9f07:	01 d0                	add    %edx,%eax
    9f09:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9f0c:	01 d0                	add    %edx,%eax
    9f0e:	83 c0 14             	add    $0x14,%eax
    9f11:	8b 14 85 ac f4 00 00 	mov    0xf4ac(,%eax,4),%edx
    9f18:	89 d0                	mov    %edx,%eax
    9f1a:	01 c0                	add    %eax,%eax
    9f1c:	01 c2                	add    %eax,%edx
    9f1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9f21:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    9f25:	01 d0                	add    %edx,%eax
    9f27:	89 45 f0             	mov    %eax,-0x10(%ebp)
                        for (; sb > 0; sb--) {
    9f2a:	eb 6e                	jmp    9f9a <III_stereo+0x7d4>
                            is_pos[i] = (*scalefac)[1].s[j][sfb];
    9f2c:	8b 4d 10             	mov    0x10(%ebp),%ecx
    9f2f:	8b 55 ec             	mov    -0x14(%ebp),%edx
    9f32:	89 d0                	mov    %edx,%eax
    9f34:	01 c0                	add    %eax,%eax
    9f36:	01 d0                	add    %edx,%eax
    9f38:	c1 e0 02             	shl    $0x2,%eax
    9f3b:	01 d0                	add    %edx,%eax
    9f3d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9f40:	01 d0                	add    %edx,%eax
    9f42:	83 c0 52             	add    $0x52,%eax
    9f45:	8b 54 81 0c          	mov    0xc(%ecx,%eax,4),%edx
    9f49:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9f4c:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                            if (is_pos[i] != 7)
    9f53:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9f56:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9f5d:	83 f8 07             	cmp    $0x7,%eax
    9f60:	74 30                	je     9f92 <III_stereo+0x7cc>
                                is_ratio[i] = tan(is_pos[i] * (PI / 12));
    9f62:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9f65:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9f6c:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    9f72:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    9f78:	dd 05 60 e0 00 00    	fldl   0xe060
    9f7e:	de c9                	fmulp  %st,%st(1)
    9f80:	dd 1c 24             	fstpl  (%esp)
    9f83:	e8 67 b1 ff ff       	call   50ef <tan>
    9f88:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9f8b:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                            i++;
    9f92:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                    }
                    sfb = sfbcnt + 1;
                    while (sfb < 12) {
                        sb = sfBandIndex[sfreq].s[sfb + 1] - sfBandIndex[sfreq].s[sfb];
                        i = 3 * sfBandIndex[sfreq].s[sfb] + j * sb;
                        for (; sb > 0; sb--) {
    9f96:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9f9a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9f9e:	7f 8c                	jg     9f2c <III_stereo+0x766>
                            is_pos[i] = (*scalefac)[1].s[j][sfb];
                            if (is_pos[i] != 7)
                                is_ratio[i] = tan(is_pos[i] * (PI / 12));
                            i++;
                        }
                        sfb++;
    9fa0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                            lines--;
                            i--;
                        }
                    }
                    sfb = sfbcnt + 1;
                    while (sfb < 12) {
    9fa4:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    9fa8:	0f 8e 06 ff ff ff    	jle    9eb4 <III_stereo+0x6ee>
                            i++;
                        }
                        sfb++;
                    }

                    sb = sfBandIndex[sfreq].s[11] - sfBandIndex[sfreq].s[10];
    9fae:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9fb1:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9fb7:	05 1c f5 00 00       	add    $0xf51c,%eax
    9fbc:	8b 50 0c             	mov    0xc(%eax),%edx
    9fbf:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9fc2:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9fc8:	05 18 f5 00 00       	add    $0xf518,%eax
    9fcd:	8b 40 0c             	mov    0xc(%eax),%eax
    9fd0:	29 c2                	sub    %eax,%edx
    9fd2:	89 d0                	mov    %edx,%eax
    9fd4:	89 45 e8             	mov    %eax,-0x18(%ebp)
                    sfb = 3 * sfBandIndex[sfreq].s[10] + j * sb;
    9fd7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9fda:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9fe0:	05 18 f5 00 00       	add    $0xf518,%eax
    9fe5:	8b 50 0c             	mov    0xc(%eax),%edx
    9fe8:	89 d0                	mov    %edx,%eax
    9fea:	01 c0                	add    %eax,%eax
    9fec:	01 c2                	add    %eax,%edx
    9fee:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9ff1:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    9ff5:	01 d0                	add    %edx,%eax
    9ff7:	89 45 f4             	mov    %eax,-0xc(%ebp)
                    sb = sfBandIndex[sfreq].s[12] - sfBandIndex[sfreq].s[11];
    9ffa:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9ffd:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    a003:	05 20 f5 00 00       	add    $0xf520,%eax
    a008:	8b 50 0c             	mov    0xc(%eax),%edx
    a00b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    a00e:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    a014:	05 1c f5 00 00       	add    $0xf51c,%eax
    a019:	8b 40 0c             	mov    0xc(%eax),%eax
    a01c:	29 c2                	sub    %eax,%edx
    a01e:	89 d0                	mov    %edx,%eax
    a020:	89 45 e8             	mov    %eax,-0x18(%ebp)
                    i = 3 * sfBandIndex[sfreq].s[11] + j * sb;
    a023:	8b 45 c8             	mov    -0x38(%ebp),%eax
    a026:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    a02c:	05 1c f5 00 00       	add    $0xf51c,%eax
    a031:	8b 50 0c             	mov    0xc(%eax),%edx
    a034:	89 d0                	mov    %edx,%eax
    a036:	01 c0                	add    %eax,%eax
    a038:	01 c2                	add    %eax,%edx
    a03a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a03d:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    a041:	01 d0                	add    %edx,%eax
    a043:	89 45 f0             	mov    %eax,-0x10(%ebp)
                    for (; sb > 0; sb--) {
    a046:	eb 30                	jmp    a078 <III_stereo+0x8b2>
                        is_pos[i] = is_pos[sfb];
    a048:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a04b:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    a052:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a055:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                        is_ratio[i] = is_ratio[sfb];
    a05c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a05f:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    a066:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a069:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                        i++;
    a070:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)

                    sb = sfBandIndex[sfreq].s[11] - sfBandIndex[sfreq].s[10];
                    sfb = 3 * sfBandIndex[sfreq].s[10] + j * sb;
                    sb = sfBandIndex[sfreq].s[12] - sfBandIndex[sfreq].s[11];
                    i = 3 * sfBandIndex[sfreq].s[11] + j * sb;
                    for (; sb > 0; sb--) {
    a074:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    a078:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    a07c:	7f ca                	jg     a048 <III_stereo+0x882>
                            i++;
                        }
                    }
                }
            } else {
                for (j = 0; j < 3; j++) {
    a07e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    a082:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    a086:	0f 8e ee fc ff ff    	jle    9d7a <III_stereo+0x5b4>
    for (i = 0; i < 576; i++)
        is_pos[i] = 7;

    if ((stereo == 2) && i_stereo) {
        if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
            if (gr_info->mixed_block_flag) {
    a08c:	e9 f0 01 00 00       	jmp    a281 <III_stereo+0xabb>
                        i++;
                    }
                }
            }
        } else {
            i = 31;
    a091:	c7 45 f0 1f 00 00 00 	movl   $0x1f,-0x10(%ebp)
            ss = 17;
    a098:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
            sb = 0;
    a09f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            while (i >= 0) {
    a0a6:	eb 63                	jmp    a10b <III_stereo+0x945>
                if (xr[1][i][ss] != 0.0) {
    a0a8:	8b 45 08             	mov    0x8(%ebp),%eax
    a0ab:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    a0b1:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a0b4:	89 d0                	mov    %edx,%eax
    a0b6:	c1 e0 03             	shl    $0x3,%eax
    a0b9:	01 d0                	add    %edx,%eax
    a0bb:	01 c0                	add    %eax,%eax
    a0bd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a0c0:	01 d0                	add    %edx,%eax
    a0c2:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a0c5:	d9 ee                	fldz   
    a0c7:	df e9                	fucomip %st(1),%st
    a0c9:	7a 0a                	jp     a0d5 <III_stereo+0x90f>
    a0cb:	d9 ee                	fldz   
    a0cd:	df e9                	fucomip %st(1),%st
    a0cf:	dd d8                	fstp   %st(0)
    a0d1:	74 23                	je     a0f6 <III_stereo+0x930>
    a0d3:	eb 02                	jmp    a0d7 <III_stereo+0x911>
    a0d5:	dd d8                	fstp   %st(0)
                    sb = i * 18 + ss;
    a0d7:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a0da:	89 d0                	mov    %edx,%eax
    a0dc:	c1 e0 03             	shl    $0x3,%eax
    a0df:	01 d0                	add    %edx,%eax
    a0e1:	01 c0                	add    %eax,%eax
    a0e3:	89 c2                	mov    %eax,%edx
    a0e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    a0e8:	01 d0                	add    %edx,%eax
    a0ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
                    i = -1;
    a0ed:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    a0f4:	eb 15                	jmp    a10b <III_stereo+0x945>
                } else {
                    ss--;
    a0f6:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
                    if (ss < 0) {
    a0fa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    a0fe:	79 0b                	jns    a10b <III_stereo+0x945>
                        i--;
    a100:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
                        ss = 17;
    a104:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
            }
        } else {
            i = 31;
            ss = 17;
            sb = 0;
            while (i >= 0) {
    a10b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    a10f:	79 97                	jns    a0a8 <III_stereo+0x8e2>
                        i--;
                        ss = 17;
                    }
                }
            }
            i = 0;
    a111:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
            while (sfBandIndex[sfreq].l[i] <= sb)
    a118:	eb 04                	jmp    a11e <III_stereo+0x958>
                i++;
    a11a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                        ss = 17;
                    }
                }
            }
            i = 0;
            while (sfBandIndex[sfreq].l[i] <= sb)
    a11e:	8b 55 c8             	mov    -0x38(%ebp),%edx
    a121:	89 d0                	mov    %edx,%eax
    a123:	c1 e0 03             	shl    $0x3,%eax
    a126:	01 d0                	add    %edx,%eax
    a128:	c1 e0 02             	shl    $0x2,%eax
    a12b:	01 d0                	add    %edx,%eax
    a12d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a130:	01 d0                	add    %edx,%eax
    a132:	8b 04 85 a0 f4 00 00 	mov    0xf4a0(,%eax,4),%eax
    a139:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    a13c:	7e dc                	jle    a11a <III_stereo+0x954>
                i++;
            sfb = i;
    a13e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a141:	89 45 f4             	mov    %eax,-0xc(%ebp)
            i = sfBandIndex[sfreq].l[i];
    a144:	8b 55 c8             	mov    -0x38(%ebp),%edx
    a147:	89 d0                	mov    %edx,%eax
    a149:	c1 e0 03             	shl    $0x3,%eax
    a14c:	01 d0                	add    %edx,%eax
    a14e:	c1 e0 02             	shl    $0x2,%eax
    a151:	01 d0                	add    %edx,%eax
    a153:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a156:	01 d0                	add    %edx,%eax
    a158:	8b 04 85 a0 f4 00 00 	mov    0xf4a0(,%eax,4),%eax
    a15f:	89 45 f0             	mov    %eax,-0x10(%ebp)
            for (; sfb < 21; sfb++) {
    a162:	e9 a9 00 00 00       	jmp    a210 <III_stereo+0xa4a>
                sb = sfBandIndex[sfreq].l[sfb + 1] - sfBandIndex[sfreq].l[sfb];
    a167:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a16a:	8d 48 01             	lea    0x1(%eax),%ecx
    a16d:	8b 55 c8             	mov    -0x38(%ebp),%edx
    a170:	89 d0                	mov    %edx,%eax
    a172:	c1 e0 03             	shl    $0x3,%eax
    a175:	01 d0                	add    %edx,%eax
    a177:	c1 e0 02             	shl    $0x2,%eax
    a17a:	01 d0                	add    %edx,%eax
    a17c:	01 c8                	add    %ecx,%eax
    a17e:	8b 0c 85 a0 f4 00 00 	mov    0xf4a0(,%eax,4),%ecx
    a185:	8b 55 c8             	mov    -0x38(%ebp),%edx
    a188:	89 d0                	mov    %edx,%eax
    a18a:	c1 e0 03             	shl    $0x3,%eax
    a18d:	01 d0                	add    %edx,%eax
    a18f:	c1 e0 02             	shl    $0x2,%eax
    a192:	01 d0                	add    %edx,%eax
    a194:	8b 55 f4             	mov    -0xc(%ebp),%edx
    a197:	01 d0                	add    %edx,%eax
    a199:	8b 04 85 a0 f4 00 00 	mov    0xf4a0(,%eax,4),%eax
    a1a0:	29 c1                	sub    %eax,%ecx
    a1a2:	89 c8                	mov    %ecx,%eax
    a1a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
                for (; sb > 0; sb--) {
    a1a7:	eb 5d                	jmp    a206 <III_stereo+0xa40>
                    is_pos[i] = (*scalefac)[1].l[sfb];
    a1a9:	8b 45 10             	mov    0x10(%ebp),%eax
    a1ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
    a1af:	83 c2 3e             	add    $0x3e,%edx
    a1b2:	8b 14 90             	mov    (%eax,%edx,4),%edx
    a1b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a1b8:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                    if (is_pos[i] != 7)
    a1bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a1c2:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    a1c9:	83 f8 07             	cmp    $0x7,%eax
    a1cc:	74 30                	je     a1fe <III_stereo+0xa38>
                        is_ratio[i] = tan(is_pos[i] * (PI / 12));
    a1ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a1d1:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    a1d8:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    a1de:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    a1e4:	dd 05 60 e0 00 00    	fldl   0xe060
    a1ea:	de c9                	fmulp  %st,%st(1)
    a1ec:	dd 1c 24             	fstpl  (%esp)
    a1ef:	e8 fb ae ff ff       	call   50ef <tan>
    a1f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a1f7:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                    i++;
    a1fe:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                i++;
            sfb = i;
            i = sfBandIndex[sfreq].l[i];
            for (; sfb < 21; sfb++) {
                sb = sfBandIndex[sfreq].l[sfb + 1] - sfBandIndex[sfreq].l[sfb];
                for (; sb > 0; sb--) {
    a202:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    a206:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    a20a:	7f 9d                	jg     a1a9 <III_stereo+0x9e3>
            i = 0;
            while (sfBandIndex[sfreq].l[i] <= sb)
                i++;
            sfb = i;
            i = sfBandIndex[sfreq].l[i];
            for (; sfb < 21; sfb++) {
    a20c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a210:	83 7d f4 14          	cmpl   $0x14,-0xc(%ebp)
    a214:	0f 8e 4d ff ff ff    	jle    a167 <III_stereo+0x9a1>
                    if (is_pos[i] != 7)
                        is_ratio[i] = tan(is_pos[i] * (PI / 12));
                    i++;
                }
            }
            sfb = sfBandIndex[sfreq].l[20];
    a21a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    a21d:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    a223:	05 f0 f4 00 00       	add    $0xf4f0,%eax
    a228:	8b 00                	mov    (%eax),%eax
    a22a:	89 45 f4             	mov    %eax,-0xc(%ebp)
            for (sb = 576 - sfBandIndex[sfreq].l[21]; sb > 0; sb--) {
    a22d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    a230:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    a236:	05 f4 f4 00 00       	add    $0xf4f4,%eax
    a23b:	8b 00                	mov    (%eax),%eax
    a23d:	ba 40 02 00 00       	mov    $0x240,%edx
    a242:	29 c2                	sub    %eax,%edx
    a244:	89 d0                	mov    %edx,%eax
    a246:	89 45 e8             	mov    %eax,-0x18(%ebp)
    a249:	eb 30                	jmp    a27b <III_stereo+0xab5>
                is_pos[i] = is_pos[sfb];
    a24b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a24e:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    a255:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a258:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                is_ratio[i] = is_ratio[sfb];
    a25f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a262:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    a269:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a26c:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                i++;
    a273:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                        is_ratio[i] = tan(is_pos[i] * (PI / 12));
                    i++;
                }
            }
            sfb = sfBandIndex[sfreq].l[20];
            for (sb = 576 - sfBandIndex[sfreq].l[21]; sb > 0; sb--) {
    a277:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    a27b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    a27f:	7f ca                	jg     a24b <III_stereo+0xa85>
                i++;
            }
        }
    }

    for (ch = 0; ch < 2; ch++)
    a281:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    a288:	eb 55                	jmp    a2df <III_stereo+0xb19>
        for (sb = 0; sb < SBLIMIT; sb++)
    a28a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    a291:	eb 42                	jmp    a2d5 <III_stereo+0xb0f>
            for (ss = 0; ss < SSLIMIT; ss++)
    a293:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    a29a:	eb 2f                	jmp    a2cb <III_stereo+0xb05>
                lr[ch][sb][ss] = 0;
    a29c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    a29f:	89 d0                	mov    %edx,%eax
    a2a1:	c1 e0 03             	shl    $0x3,%eax
    a2a4:	01 d0                	add    %edx,%eax
    a2a6:	c1 e0 09             	shl    $0x9,%eax
    a2a9:	89 c2                	mov    %eax,%edx
    a2ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    a2ae:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    a2b1:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a2b4:	89 d0                	mov    %edx,%eax
    a2b6:	c1 e0 03             	shl    $0x3,%eax
    a2b9:	01 d0                	add    %edx,%eax
    a2bb:	01 c0                	add    %eax,%eax
    a2bd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a2c0:	01 d0                	add    %edx,%eax
    a2c2:	d9 ee                	fldz   
    a2c4:	dd 1c c1             	fstpl  (%ecx,%eax,8)
        }
    }

    for (ch = 0; ch < 2; ch++)
        for (sb = 0; sb < SBLIMIT; sb++)
            for (ss = 0; ss < SSLIMIT; ss++)
    a2c7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    a2cb:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    a2cf:	7e cb                	jle    a29c <III_stereo+0xad6>
            }
        }
    }

    for (ch = 0; ch < 2; ch++)
        for (sb = 0; sb < SBLIMIT; sb++)
    a2d1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    a2d5:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    a2d9:	7e b8                	jle    a293 <III_stereo+0xacd>
                i++;
            }
        }
    }

    for (ch = 0; ch < 2; ch++)
    a2db:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    a2df:	83 7d e0 01          	cmpl   $0x1,-0x20(%ebp)
    a2e3:	7e a5                	jle    a28a <III_stereo+0xac4>
        for (sb = 0; sb < SBLIMIT; sb++)
            for (ss = 0; ss < SSLIMIT; ss++)
                lr[ch][sb][ss] = 0;

    if (stereo == 2)
    a2e5:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
    a2e9:	0f 85 3d 02 00 00    	jne    a52c <III_stereo+0xd66>
        for (sb = 0; sb < SBLIMIT; sb++)
    a2ef:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    a2f6:	e9 25 02 00 00       	jmp    a520 <III_stereo+0xd5a>
            for (ss = 0; ss < SSLIMIT; ss++) {
    a2fb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    a302:	e9 0b 02 00 00       	jmp    a512 <III_stereo+0xd4c>
                i = (sb * 18) + ss;
    a307:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a30a:	89 d0                	mov    %edx,%eax
    a30c:	c1 e0 03             	shl    $0x3,%eax
    a30f:	01 d0                	add    %edx,%eax
    a311:	01 c0                	add    %eax,%eax
    a313:	89 c2                	mov    %eax,%edx
    a315:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    a318:	01 d0                	add    %edx,%eax
    a31a:	89 45 f0             	mov    %eax,-0x10(%ebp)
                if (is_pos[i] == 7) {
    a31d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a320:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    a327:	83 f8 07             	cmp    $0x7,%eax
    a32a:	0f 85 2c 01 00 00    	jne    a45c <III_stereo+0xc96>
                    if (ms_stereo) {
    a330:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
    a334:	0f 84 b5 00 00 00    	je     a3ef <III_stereo+0xc29>
                        lr[0][sb][ss] = (xr[0][sb][ss] + xr[1][sb][ss]) / 1.41421356;
    a33a:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a33d:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a340:	89 d0                	mov    %edx,%eax
    a342:	c1 e0 03             	shl    $0x3,%eax
    a345:	01 d0                	add    %edx,%eax
    a347:	01 c0                	add    %eax,%eax
    a349:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a34c:	01 d0                	add    %edx,%eax
    a34e:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a351:	8b 45 08             	mov    0x8(%ebp),%eax
    a354:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    a35a:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a35d:	89 d0                	mov    %edx,%eax
    a35f:	c1 e0 03             	shl    $0x3,%eax
    a362:	01 d0                	add    %edx,%eax
    a364:	01 c0                	add    %eax,%eax
    a366:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a369:	01 d0                	add    %edx,%eax
    a36b:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a36e:	de c1                	faddp  %st,%st(1)
    a370:	dd 05 68 e0 00 00    	fldl   0xe068
    a376:	de f9                	fdivrp %st,%st(1)
    a378:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    a37b:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a37e:	89 d0                	mov    %edx,%eax
    a380:	c1 e0 03             	shl    $0x3,%eax
    a383:	01 d0                	add    %edx,%eax
    a385:	01 c0                	add    %eax,%eax
    a387:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a38a:	01 d0                	add    %edx,%eax
    a38c:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                        lr[1][sb][ss] = (xr[0][sb][ss] - xr[1][sb][ss]) / 1.41421356;
    a38f:	8b 45 0c             	mov    0xc(%ebp),%eax
    a392:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    a398:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a39b:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a39e:	89 d0                	mov    %edx,%eax
    a3a0:	c1 e0 03             	shl    $0x3,%eax
    a3a3:	01 d0                	add    %edx,%eax
    a3a5:	01 c0                	add    %eax,%eax
    a3a7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a3aa:	01 d0                	add    %edx,%eax
    a3ac:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a3af:	8b 45 08             	mov    0x8(%ebp),%eax
    a3b2:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    a3b8:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a3bb:	89 d0                	mov    %edx,%eax
    a3bd:	c1 e0 03             	shl    $0x3,%eax
    a3c0:	01 d0                	add    %edx,%eax
    a3c2:	01 c0                	add    %eax,%eax
    a3c4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a3c7:	01 d0                	add    %edx,%eax
    a3c9:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a3cc:	de e9                	fsubrp %st,%st(1)
    a3ce:	dd 05 68 e0 00 00    	fldl   0xe068
    a3d4:	de f9                	fdivrp %st,%st(1)
    a3d6:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a3d9:	89 d0                	mov    %edx,%eax
    a3db:	c1 e0 03             	shl    $0x3,%eax
    a3de:	01 d0                	add    %edx,%eax
    a3e0:	01 c0                	add    %eax,%eax
    a3e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a3e5:	01 d0                	add    %edx,%eax
    a3e7:	dd 1c c3             	fstpl  (%ebx,%eax,8)
    a3ea:	e9 1f 01 00 00       	jmp    a50e <III_stereo+0xd48>
                    }
                    else {
                        lr[0][sb][ss] = xr[0][sb][ss];
    a3ef:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a3f2:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a3f5:	89 d0                	mov    %edx,%eax
    a3f7:	c1 e0 03             	shl    $0x3,%eax
    a3fa:	01 d0                	add    %edx,%eax
    a3fc:	01 c0                	add    %eax,%eax
    a3fe:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a401:	01 d0                	add    %edx,%eax
    a403:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a406:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    a409:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a40c:	89 d0                	mov    %edx,%eax
    a40e:	c1 e0 03             	shl    $0x3,%eax
    a411:	01 d0                	add    %edx,%eax
    a413:	01 c0                	add    %eax,%eax
    a415:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a418:	01 d0                	add    %edx,%eax
    a41a:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                        lr[1][sb][ss] = xr[1][sb][ss];
    a41d:	8b 45 0c             	mov    0xc(%ebp),%eax
    a420:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    a426:	8b 45 08             	mov    0x8(%ebp),%eax
    a429:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    a42f:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a432:	89 d0                	mov    %edx,%eax
    a434:	c1 e0 03             	shl    $0x3,%eax
    a437:	01 d0                	add    %edx,%eax
    a439:	01 c0                	add    %eax,%eax
    a43b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a43e:	01 d0                	add    %edx,%eax
    a440:	dd 04 c3             	fldl   (%ebx,%eax,8)
    a443:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a446:	89 d0                	mov    %edx,%eax
    a448:	c1 e0 03             	shl    $0x3,%eax
    a44b:	01 d0                	add    %edx,%eax
    a44d:	01 c0                	add    %eax,%eax
    a44f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a452:	01 d0                	add    %edx,%eax
    a454:	dd 1c c1             	fstpl  (%ecx,%eax,8)
    a457:	e9 b2 00 00 00       	jmp    a50e <III_stereo+0xd48>
                    }
                }
                else if (i_stereo) {
    a45c:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
    a460:	0f 84 94 00 00 00    	je     a4fa <III_stereo+0xd34>
                    lr[0][sb][ss] = xr[0][sb][ss] * (is_ratio[i] / (1 + is_ratio[i]));
    a466:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a469:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a46c:	89 d0                	mov    %edx,%eax
    a46e:	c1 e0 03             	shl    $0x3,%eax
    a471:	01 d0                	add    %edx,%eax
    a473:	01 c0                	add    %eax,%eax
    a475:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a478:	01 d0                	add    %edx,%eax
    a47a:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a47d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a480:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    a487:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a48a:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    a491:	d9 e8                	fld1   
    a493:	de c1                	faddp  %st,%st(1)
    a495:	de f9                	fdivrp %st,%st(1)
    a497:	de c9                	fmulp  %st,%st(1)
    a499:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    a49c:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a49f:	89 d0                	mov    %edx,%eax
    a4a1:	c1 e0 03             	shl    $0x3,%eax
    a4a4:	01 d0                	add    %edx,%eax
    a4a6:	01 c0                	add    %eax,%eax
    a4a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a4ab:	01 d0                	add    %edx,%eax
    a4ad:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                    lr[1][sb][ss] = xr[0][sb][ss] * (1 / (1 + is_ratio[i]));
    a4b0:	8b 45 0c             	mov    0xc(%ebp),%eax
    a4b3:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    a4b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a4bc:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a4bf:	89 d0                	mov    %edx,%eax
    a4c1:	c1 e0 03             	shl    $0x3,%eax
    a4c4:	01 d0                	add    %edx,%eax
    a4c6:	01 c0                	add    %eax,%eax
    a4c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a4cb:	01 d0                	add    %edx,%eax
    a4cd:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a4d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a4d3:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    a4da:	d9 e8                	fld1   
    a4dc:	de c1                	faddp  %st,%st(1)
    a4de:	d9 e8                	fld1   
    a4e0:	de f1                	fdivp  %st,%st(1)
    a4e2:	de c9                	fmulp  %st,%st(1)
    a4e4:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a4e7:	89 d0                	mov    %edx,%eax
    a4e9:	c1 e0 03             	shl    $0x3,%eax
    a4ec:	01 d0                	add    %edx,%eax
    a4ee:	01 c0                	add    %eax,%eax
    a4f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a4f3:	01 d0                	add    %edx,%eax
    a4f5:	dd 1c c3             	fstpl  (%ebx,%eax,8)
    a4f8:	eb 14                	jmp    a50e <III_stereo+0xd48>
                }
                else {
                    printf(0, "Error in streo processing\n");
    a4fa:	c7 44 24 04 00 d0 00 	movl   $0xd000,0x4(%esp)
    a501:	00 
    a502:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    a509:	e8 3c a7 ff ff       	call   4c4a <printf>
            for (ss = 0; ss < SSLIMIT; ss++)
                lr[ch][sb][ss] = 0;

    if (stereo == 2)
        for (sb = 0; sb < SBLIMIT; sb++)
            for (ss = 0; ss < SSLIMIT; ss++) {
    a50e:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    a512:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    a516:	0f 8e eb fd ff ff    	jle    a307 <III_stereo+0xb41>
        for (sb = 0; sb < SBLIMIT; sb++)
            for (ss = 0; ss < SSLIMIT; ss++)
                lr[ch][sb][ss] = 0;

    if (stereo == 2)
        for (sb = 0; sb < SBLIMIT; sb++)
    a51c:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    a520:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    a524:	0f 8e d1 fd ff ff    	jle    a2fb <III_stereo+0xb35>
    a52a:	eb 54                	jmp    a580 <III_stereo+0xdba>
                else {
                    printf(0, "Error in streo processing\n");
                }
            }
    else  /* mono , bypass xr[0][][] to lr[0][][]*/
        for (sb = 0; sb < SBLIMIT; sb++)
    a52c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    a533:	eb 45                	jmp    a57a <III_stereo+0xdb4>
            for (ss = 0; ss < SSLIMIT; ss++)
    a535:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    a53c:	eb 32                	jmp    a570 <III_stereo+0xdaa>
                lr[0][sb][ss] = xr[0][sb][ss];
    a53e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a541:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a544:	89 d0                	mov    %edx,%eax
    a546:	c1 e0 03             	shl    $0x3,%eax
    a549:	01 d0                	add    %edx,%eax
    a54b:	01 c0                	add    %eax,%eax
    a54d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a550:	01 d0                	add    %edx,%eax
    a552:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a555:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    a558:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a55b:	89 d0                	mov    %edx,%eax
    a55d:	c1 e0 03             	shl    $0x3,%eax
    a560:	01 d0                	add    %edx,%eax
    a562:	01 c0                	add    %eax,%eax
    a564:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a567:	01 d0                	add    %edx,%eax
    a569:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                    printf(0, "Error in streo processing\n");
                }
            }
    else  /* mono , bypass xr[0][][] to lr[0][][]*/
        for (sb = 0; sb < SBLIMIT; sb++)
            for (ss = 0; ss < SSLIMIT; ss++)
    a56c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    a570:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    a574:	7e c8                	jle    a53e <III_stereo+0xd78>
                else {
                    printf(0, "Error in streo processing\n");
                }
            }
    else  /* mono , bypass xr[0][][] to lr[0][][]*/
        for (sb = 0; sb < SBLIMIT; sb++)
    a576:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    a57a:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    a57e:	7e b5                	jle    a535 <III_stereo+0xd6f>
            for (ss = 0; ss < SSLIMIT; ss++)
                lr[0][sb][ss] = xr[0][sb][ss];

}
    a580:	81 c4 50 1b 00 00    	add    $0x1b50,%esp
    a586:	5b                   	pop    %ebx
    a587:	5e                   	pop    %esi
    a588:	5d                   	pop    %ebp
    a589:	c3                   	ret    

0000a58a <III_antialias>:


double Ci[8] = {-0.6, -0.535, -0.33, -0.185, -0.095, -0.041, -0.0142, -0.0037};

void III_antialias(double xr[SBLIMIT][SSLIMIT], double hybridIn[SBLIMIT][SSLIMIT], struct gr_info_s *gr_info,
                   struct frame_params *fr_ps) {
    a58a:	55                   	push   %ebp
    a58b:	89 e5                	mov    %esp,%ebp
    a58d:	83 ec 48             	sub    $0x48,%esp
    static int init = 1;
    static double ca[8], cs[8];
    double bu, bd;  /* upper and lower butterfly inputs */
    int ss, sb, sblim;

    if (init) {
    a590:	a1 00 f7 00 00       	mov    0xf700,%eax
    a595:	85 c0                	test   %eax,%eax
    a597:	74 68                	je     a601 <III_antialias+0x77>
        int i;
        double sq;
        for (i = 0; i < 8; i++) {
    a599:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    a5a0:	eb 4f                	jmp    a5f1 <III_antialias+0x67>
            sq = sqrt(1.0 + Ci[i] * Ci[i]);
    a5a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a5a5:	dd 04 c5 c0 f6 00 00 	fldl   0xf6c0(,%eax,8)
    a5ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a5af:	dd 04 c5 c0 f6 00 00 	fldl   0xf6c0(,%eax,8)
    a5b6:	de c9                	fmulp  %st,%st(1)
    a5b8:	d9 e8                	fld1   
    a5ba:	de c1                	faddp  %st,%st(1)
    a5bc:	dd 1c 24             	fstpl  (%esp)
    a5bf:	e8 de ac ff ff       	call   52a2 <sqrt>
    a5c4:	dd 5d e0             	fstpl  -0x20(%ebp)
            cs[i] = 1.0 / sq;
    a5c7:	d9 e8                	fld1   
    a5c9:	dc 75 e0             	fdivl  -0x20(%ebp)
    a5cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a5cf:	dd 1c c5 80 f7 00 00 	fstpl  0xf780(,%eax,8)
            ca[i] = Ci[i] / sq;
    a5d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a5d9:	dd 04 c5 c0 f6 00 00 	fldl   0xf6c0(,%eax,8)
    a5e0:	dc 75 e0             	fdivl  -0x20(%ebp)
    a5e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a5e6:	dd 1c c5 c0 f7 00 00 	fstpl  0xf7c0(,%eax,8)
    int ss, sb, sblim;

    if (init) {
        int i;
        double sq;
        for (i = 0; i < 8; i++) {
    a5ed:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    a5f1:	83 7d e8 07          	cmpl   $0x7,-0x18(%ebp)
    a5f5:	7e ab                	jle    a5a2 <III_antialias+0x18>
            sq = sqrt(1.0 + Ci[i] * Ci[i]);
            cs[i] = 1.0 / sq;
            ca[i] = Ci[i] / sq;
        }
        init = 0;
    a5f7:	c7 05 00 f7 00 00 00 	movl   $0x0,0xf700
    a5fe:	00 00 00 
    }

    /* clear all inputs */

    for (sb = 0; sb < SBLIMIT; sb++)
    a601:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    a608:	eb 4c                	jmp    a656 <III_antialias+0xcc>
        for (ss = 0; ss < SSLIMIT; ss++)
    a60a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a611:	eb 39                	jmp    a64c <III_antialias+0xc2>
            hybridIn[sb][ss] = xr[sb][ss];
    a613:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a616:	89 d0                	mov    %edx,%eax
    a618:	c1 e0 03             	shl    $0x3,%eax
    a61b:	01 d0                	add    %edx,%eax
    a61d:	c1 e0 04             	shl    $0x4,%eax
    a620:	89 c2                	mov    %eax,%edx
    a622:	8b 45 0c             	mov    0xc(%ebp),%eax
    a625:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    a628:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a62b:	89 d0                	mov    %edx,%eax
    a62d:	c1 e0 03             	shl    $0x3,%eax
    a630:	01 d0                	add    %edx,%eax
    a632:	c1 e0 04             	shl    $0x4,%eax
    a635:	89 c2                	mov    %eax,%edx
    a637:	8b 45 08             	mov    0x8(%ebp),%eax
    a63a:	01 c2                	add    %eax,%edx
    a63c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a63f:	dd 04 c2             	fldl   (%edx,%eax,8)
    a642:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a645:	dd 1c c1             	fstpl  (%ecx,%eax,8)
    }

    /* clear all inputs */

    for (sb = 0; sb < SBLIMIT; sb++)
        for (ss = 0; ss < SSLIMIT; ss++)
    a648:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a64c:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    a650:	7e c1                	jle    a613 <III_antialias+0x89>
        init = 0;
    }

    /* clear all inputs */

    for (sb = 0; sb < SBLIMIT; sb++)
    a652:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    a656:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    a65a:	7e ae                	jle    a60a <III_antialias+0x80>
        for (ss = 0; ss < SSLIMIT; ss++)
            hybridIn[sb][ss] = xr[sb][ss];

    if (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
    a65c:	8b 45 10             	mov    0x10(%ebp),%eax
    a65f:	8b 40 10             	mov    0x10(%eax),%eax
    a662:	85 c0                	test   %eax,%eax
    a664:	74 1a                	je     a680 <III_antialias+0xf6>
    a666:	8b 45 10             	mov    0x10(%ebp),%eax
    a669:	8b 40 14             	mov    0x14(%eax),%eax
    a66c:	83 f8 02             	cmp    $0x2,%eax
    a66f:	75 0f                	jne    a680 <III_antialias+0xf6>
        !gr_info->mixed_block_flag)
    a671:	8b 45 10             	mov    0x10(%ebp),%eax
    a674:	8b 40 18             	mov    0x18(%eax),%eax

    for (sb = 0; sb < SBLIMIT; sb++)
        for (ss = 0; ss < SSLIMIT; ss++)
            hybridIn[sb][ss] = xr[sb][ss];

    if (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
    a677:	85 c0                	test   %eax,%eax
    a679:	75 05                	jne    a680 <III_antialias+0xf6>
        !gr_info->mixed_block_flag)
        return;
    a67b:	e9 1c 01 00 00       	jmp    a79c <III_antialias+0x212>

    if (gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    a680:	8b 45 10             	mov    0x10(%ebp),%eax
    a683:	8b 40 10             	mov    0x10(%eax),%eax
    a686:	85 c0                	test   %eax,%eax
    a688:	74 1e                	je     a6a8 <III_antialias+0x11e>
    a68a:	8b 45 10             	mov    0x10(%ebp),%eax
    a68d:	8b 40 18             	mov    0x18(%eax),%eax
    a690:	85 c0                	test   %eax,%eax
    a692:	74 14                	je     a6a8 <III_antialias+0x11e>
        (gr_info->block_type == 2))
    a694:	8b 45 10             	mov    0x10(%ebp),%eax
    a697:	8b 40 14             	mov    0x14(%eax),%eax

    if (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
        !gr_info->mixed_block_flag)
        return;

    if (gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    a69a:	83 f8 02             	cmp    $0x2,%eax
    a69d:	75 09                	jne    a6a8 <III_antialias+0x11e>
        (gr_info->block_type == 2))
        sblim = 1;
    a69f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    a6a6:	eb 07                	jmp    a6af <III_antialias+0x125>
    else
        sblim = SBLIMIT - 1;
    a6a8:	c7 45 ec 1f 00 00 00 	movl   $0x1f,-0x14(%ebp)

    /* 31 alias-reduction operations between each pair of sub-bands */
    /* with 8 butterflies between each pair                         */

    for (sb = 0; sb < sblim; sb++)
    a6af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    a6b6:	e9 d5 00 00 00       	jmp    a790 <III_antialias+0x206>
        for (ss = 0; ss < 8; ss++) {
    a6bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a6c2:	e9 bb 00 00 00       	jmp    a782 <III_antialias+0x1f8>
            bu = xr[sb][17 - ss];
    a6c7:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a6ca:	89 d0                	mov    %edx,%eax
    a6cc:	c1 e0 03             	shl    $0x3,%eax
    a6cf:	01 d0                	add    %edx,%eax
    a6d1:	c1 e0 04             	shl    $0x4,%eax
    a6d4:	89 c2                	mov    %eax,%edx
    a6d6:	8b 45 08             	mov    0x8(%ebp),%eax
    a6d9:	01 c2                	add    %eax,%edx
    a6db:	b8 11 00 00 00       	mov    $0x11,%eax
    a6e0:	2b 45 f4             	sub    -0xc(%ebp),%eax
    a6e3:	dd 04 c2             	fldl   (%edx,%eax,8)
    a6e6:	dd 5d d8             	fstpl  -0x28(%ebp)
            bd = xr[sb + 1][ss];
    a6e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a6ec:	8d 50 01             	lea    0x1(%eax),%edx
    a6ef:	89 d0                	mov    %edx,%eax
    a6f1:	c1 e0 03             	shl    $0x3,%eax
    a6f4:	01 d0                	add    %edx,%eax
    a6f6:	c1 e0 04             	shl    $0x4,%eax
    a6f9:	89 c2                	mov    %eax,%edx
    a6fb:	8b 45 08             	mov    0x8(%ebp),%eax
    a6fe:	01 c2                	add    %eax,%edx
    a700:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a703:	dd 04 c2             	fldl   (%edx,%eax,8)
    a706:	dd 5d d0             	fstpl  -0x30(%ebp)
            hybridIn[sb][17 - ss] = (bu * cs[ss]) - (bd * ca[ss]);
    a709:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a70c:	89 d0                	mov    %edx,%eax
    a70e:	c1 e0 03             	shl    $0x3,%eax
    a711:	01 d0                	add    %edx,%eax
    a713:	c1 e0 04             	shl    $0x4,%eax
    a716:	89 c2                	mov    %eax,%edx
    a718:	8b 45 0c             	mov    0xc(%ebp),%eax
    a71b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    a71e:	b8 11 00 00 00       	mov    $0x11,%eax
    a723:	2b 45 f4             	sub    -0xc(%ebp),%eax
    a726:	8b 55 f4             	mov    -0xc(%ebp),%edx
    a729:	dd 04 d5 80 f7 00 00 	fldl   0xf780(,%edx,8)
    a730:	dc 4d d8             	fmull  -0x28(%ebp)
    a733:	8b 55 f4             	mov    -0xc(%ebp),%edx
    a736:	dd 04 d5 c0 f7 00 00 	fldl   0xf7c0(,%edx,8)
    a73d:	dc 4d d0             	fmull  -0x30(%ebp)
    a740:	de e9                	fsubrp %st,%st(1)
    a742:	dd 1c c1             	fstpl  (%ecx,%eax,8)
            hybridIn[sb + 1][ss] = (bd * cs[ss]) + (bu * ca[ss]);
    a745:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a748:	8d 50 01             	lea    0x1(%eax),%edx
    a74b:	89 d0                	mov    %edx,%eax
    a74d:	c1 e0 03             	shl    $0x3,%eax
    a750:	01 d0                	add    %edx,%eax
    a752:	c1 e0 04             	shl    $0x4,%eax
    a755:	89 c2                	mov    %eax,%edx
    a757:	8b 45 0c             	mov    0xc(%ebp),%eax
    a75a:	01 c2                	add    %eax,%edx
    a75c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a75f:	dd 04 c5 80 f7 00 00 	fldl   0xf780(,%eax,8)
    a766:	dc 4d d0             	fmull  -0x30(%ebp)
    a769:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a76c:	dd 04 c5 c0 f7 00 00 	fldl   0xf7c0(,%eax,8)
    a773:	dc 4d d8             	fmull  -0x28(%ebp)
    a776:	de c1                	faddp  %st,%st(1)
    a778:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a77b:	dd 1c c2             	fstpl  (%edx,%eax,8)

    /* 31 alias-reduction operations between each pair of sub-bands */
    /* with 8 butterflies between each pair                         */

    for (sb = 0; sb < sblim; sb++)
        for (ss = 0; ss < 8; ss++) {
    a77e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a782:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    a786:	0f 8e 3b ff ff ff    	jle    a6c7 <III_antialias+0x13d>
        sblim = SBLIMIT - 1;

    /* 31 alias-reduction operations between each pair of sub-bands */
    /* with 8 butterflies between each pair                         */

    for (sb = 0; sb < sblim; sb++)
    a78c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    a790:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a793:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    a796:	0f 8c 1f ff ff ff    	jl     a6bb <III_antialias+0x131>
            bu = xr[sb][17 - ss];
            bd = xr[sb + 1][ss];
            hybridIn[sb][17 - ss] = (bu * cs[ss]) - (bd * ca[ss]);
            hybridIn[sb + 1][ss] = (bd * cs[ss]) + (bu * ca[ss]);
        }
}
    a79c:	c9                   	leave  
    a79d:	c3                   	ret    

0000a79e <inv_mdct>:


void inv_mdct(double in[18], double out[36], int block_type) {
    a79e:	55                   	push   %ebp
    a79f:	89 e5                	mov    %esp,%ebp
    a7a1:	81 ec a8 00 00 00    	sub    $0xa8,%esp
    double tmp[12], sum;
    static double win[4][36];
    static int init = 0;
    static double COS[4 * 36];

    if (init == 0) {
    a7a7:	a1 00 f8 00 00       	mov    0xf800,%eax
    a7ac:	85 c0                	test   %eax,%eax
    a7ae:	0f 85 59 02 00 00    	jne    aa0d <inv_mdct+0x26f>

        /* type 0 */
        for (i = 0; i < 36; i++)
    a7b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a7bb:	eb 29                	jmp    a7e6 <inv_mdct+0x48>
            win[0][i] = sin(PI / 36 * (i + 0.5));
    a7bd:	db 45 f4             	fildl  -0xc(%ebp)
    a7c0:	dd 05 70 e0 00 00    	fldl   0xe070
    a7c6:	de c1                	faddp  %st,%st(1)
    a7c8:	dd 05 78 e0 00 00    	fldl   0xe078
    a7ce:	de c9                	fmulp  %st,%st(1)
    a7d0:	dd 1c 24             	fstpl  (%esp)
    a7d3:	e8 53 a8 ff ff       	call   502b <sin>
    a7d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a7db:	dd 1c c5 20 f8 00 00 	fstpl  0xf820(,%eax,8)
    static double COS[4 * 36];

    if (init == 0) {

        /* type 0 */
        for (i = 0; i < 36; i++)
    a7e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a7e6:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a7ea:	7e d1                	jle    a7bd <inv_mdct+0x1f>
            win[0][i] = sin(PI / 36 * (i + 0.5));

        /* type 1*/
        for (i = 0; i < 18; i++)
    a7ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a7f3:	eb 2c                	jmp    a821 <inv_mdct+0x83>
            win[1][i] = sin(PI / 36 * (i + 0.5));
    a7f5:	db 45 f4             	fildl  -0xc(%ebp)
    a7f8:	dd 05 70 e0 00 00    	fldl   0xe070
    a7fe:	de c1                	faddp  %st,%st(1)
    a800:	dd 05 78 e0 00 00    	fldl   0xe078
    a806:	de c9                	fmulp  %st,%st(1)
    a808:	dd 1c 24             	fstpl  (%esp)
    a80b:	e8 1b a8 ff ff       	call   502b <sin>
    a810:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a813:	83 c0 24             	add    $0x24,%eax
    a816:	dd 1c c5 20 f8 00 00 	fstpl  0xf820(,%eax,8)
        /* type 0 */
        for (i = 0; i < 36; i++)
            win[0][i] = sin(PI / 36 * (i + 0.5));

        /* type 1*/
        for (i = 0; i < 18; i++)
    a81d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a821:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    a825:	7e ce                	jle    a7f5 <inv_mdct+0x57>
            win[1][i] = sin(PI / 36 * (i + 0.5));
        for (i = 18; i < 24; i++)
    a827:	c7 45 f4 12 00 00 00 	movl   $0x12,-0xc(%ebp)
    a82e:	eb 13                	jmp    a843 <inv_mdct+0xa5>
            win[1][i] = 1.0;
    a830:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a833:	83 c0 24             	add    $0x24,%eax
    a836:	d9 e8                	fld1   
    a838:	dd 1c c5 20 f8 00 00 	fstpl  0xf820(,%eax,8)
            win[0][i] = sin(PI / 36 * (i + 0.5));

        /* type 1*/
        for (i = 0; i < 18; i++)
            win[1][i] = sin(PI / 36 * (i + 0.5));
        for (i = 18; i < 24; i++)
    a83f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a843:	83 7d f4 17          	cmpl   $0x17,-0xc(%ebp)
    a847:	7e e7                	jle    a830 <inv_mdct+0x92>
            win[1][i] = 1.0;
        for (i = 24; i < 30; i++)
    a849:	c7 45 f4 18 00 00 00 	movl   $0x18,-0xc(%ebp)
    a850:	eb 34                	jmp    a886 <inv_mdct+0xe8>
            win[1][i] = sin(PI / 12 * (i + 0.5 - 18));
    a852:	db 45 f4             	fildl  -0xc(%ebp)
    a855:	dd 05 70 e0 00 00    	fldl   0xe070
    a85b:	de c1                	faddp  %st,%st(1)
    a85d:	dd 05 80 e0 00 00    	fldl   0xe080
    a863:	de e9                	fsubrp %st,%st(1)
    a865:	dd 05 60 e0 00 00    	fldl   0xe060
    a86b:	de c9                	fmulp  %st,%st(1)
    a86d:	dd 1c 24             	fstpl  (%esp)
    a870:	e8 b6 a7 ff ff       	call   502b <sin>
    a875:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a878:	83 c0 24             	add    $0x24,%eax
    a87b:	dd 1c c5 20 f8 00 00 	fstpl  0xf820(,%eax,8)
        /* type 1*/
        for (i = 0; i < 18; i++)
            win[1][i] = sin(PI / 36 * (i + 0.5));
        for (i = 18; i < 24; i++)
            win[1][i] = 1.0;
        for (i = 24; i < 30; i++)
    a882:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a886:	83 7d f4 1d          	cmpl   $0x1d,-0xc(%ebp)
    a88a:	7e c6                	jle    a852 <inv_mdct+0xb4>
            win[1][i] = sin(PI / 12 * (i + 0.5 - 18));
        for (i = 30; i < 36; i++)
    a88c:	c7 45 f4 1e 00 00 00 	movl   $0x1e,-0xc(%ebp)
    a893:	eb 13                	jmp    a8a8 <inv_mdct+0x10a>
            win[1][i] = 0.0;
    a895:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a898:	83 c0 24             	add    $0x24,%eax
    a89b:	d9 ee                	fldz   
    a89d:	dd 1c c5 20 f8 00 00 	fstpl  0xf820(,%eax,8)
            win[1][i] = sin(PI / 36 * (i + 0.5));
        for (i = 18; i < 24; i++)
            win[1][i] = 1.0;
        for (i = 24; i < 30; i++)
            win[1][i] = sin(PI / 12 * (i + 0.5 - 18));
        for (i = 30; i < 36; i++)
    a8a4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a8a8:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a8ac:	7e e7                	jle    a895 <inv_mdct+0xf7>
            win[1][i] = 0.0;

        /* type 3*/
        for (i = 0; i < 6; i++)
    a8ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a8b5:	eb 13                	jmp    a8ca <inv_mdct+0x12c>
            win[3][i] = 0.0;
    a8b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a8ba:	83 c0 6c             	add    $0x6c,%eax
    a8bd:	d9 ee                	fldz   
    a8bf:	dd 1c c5 20 f8 00 00 	fstpl  0xf820(,%eax,8)
            win[1][i] = sin(PI / 12 * (i + 0.5 - 18));
        for (i = 30; i < 36; i++)
            win[1][i] = 0.0;

        /* type 3*/
        for (i = 0; i < 6; i++)
    a8c6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a8ca:	83 7d f4 05          	cmpl   $0x5,-0xc(%ebp)
    a8ce:	7e e7                	jle    a8b7 <inv_mdct+0x119>
            win[3][i] = 0.0;
        for (i = 6; i < 12; i++)
    a8d0:	c7 45 f4 06 00 00 00 	movl   $0x6,-0xc(%ebp)
    a8d7:	eb 34                	jmp    a90d <inv_mdct+0x16f>
            win[3][i] = sin(PI / 12 * (i + 0.5 - 6));
    a8d9:	db 45 f4             	fildl  -0xc(%ebp)
    a8dc:	dd 05 70 e0 00 00    	fldl   0xe070
    a8e2:	de c1                	faddp  %st,%st(1)
    a8e4:	dd 05 88 e0 00 00    	fldl   0xe088
    a8ea:	de e9                	fsubrp %st,%st(1)
    a8ec:	dd 05 60 e0 00 00    	fldl   0xe060
    a8f2:	de c9                	fmulp  %st,%st(1)
    a8f4:	dd 1c 24             	fstpl  (%esp)
    a8f7:	e8 2f a7 ff ff       	call   502b <sin>
    a8fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a8ff:	83 c0 6c             	add    $0x6c,%eax
    a902:	dd 1c c5 20 f8 00 00 	fstpl  0xf820(,%eax,8)
            win[1][i] = 0.0;

        /* type 3*/
        for (i = 0; i < 6; i++)
            win[3][i] = 0.0;
        for (i = 6; i < 12; i++)
    a909:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a90d:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    a911:	7e c6                	jle    a8d9 <inv_mdct+0x13b>
            win[3][i] = sin(PI / 12 * (i + 0.5 - 6));
        for (i = 12; i < 18; i++)
    a913:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    a91a:	eb 13                	jmp    a92f <inv_mdct+0x191>
            win[3][i] = 1.0;
    a91c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a91f:	83 c0 6c             	add    $0x6c,%eax
    a922:	d9 e8                	fld1   
    a924:	dd 1c c5 20 f8 00 00 	fstpl  0xf820(,%eax,8)
        /* type 3*/
        for (i = 0; i < 6; i++)
            win[3][i] = 0.0;
        for (i = 6; i < 12; i++)
            win[3][i] = sin(PI / 12 * (i + 0.5 - 6));
        for (i = 12; i < 18; i++)
    a92b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a92f:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    a933:	7e e7                	jle    a91c <inv_mdct+0x17e>
            win[3][i] = 1.0;
        for (i = 18; i < 36; i++)
    a935:	c7 45 f4 12 00 00 00 	movl   $0x12,-0xc(%ebp)
    a93c:	eb 2c                	jmp    a96a <inv_mdct+0x1cc>
            win[3][i] = sin(PI / 36 * (i + 0.5));
    a93e:	db 45 f4             	fildl  -0xc(%ebp)
    a941:	dd 05 70 e0 00 00    	fldl   0xe070
    a947:	de c1                	faddp  %st,%st(1)
    a949:	dd 05 78 e0 00 00    	fldl   0xe078
    a94f:	de c9                	fmulp  %st,%st(1)
    a951:	dd 1c 24             	fstpl  (%esp)
    a954:	e8 d2 a6 ff ff       	call   502b <sin>
    a959:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a95c:	83 c0 6c             	add    $0x6c,%eax
    a95f:	dd 1c c5 20 f8 00 00 	fstpl  0xf820(,%eax,8)
            win[3][i] = 0.0;
        for (i = 6; i < 12; i++)
            win[3][i] = sin(PI / 12 * (i + 0.5 - 6));
        for (i = 12; i < 18; i++)
            win[3][i] = 1.0;
        for (i = 18; i < 36; i++)
    a966:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a96a:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a96e:	7e ce                	jle    a93e <inv_mdct+0x1a0>
            win[3][i] = sin(PI / 36 * (i + 0.5));

        /* type 2*/
        for (i = 0; i < 12; i++)
    a970:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a977:	eb 2c                	jmp    a9a5 <inv_mdct+0x207>
            win[2][i] = sin(PI / 12 * (i + 0.5));
    a979:	db 45 f4             	fildl  -0xc(%ebp)
    a97c:	dd 05 70 e0 00 00    	fldl   0xe070
    a982:	de c1                	faddp  %st,%st(1)
    a984:	dd 05 60 e0 00 00    	fldl   0xe060
    a98a:	de c9                	fmulp  %st,%st(1)
    a98c:	dd 1c 24             	fstpl  (%esp)
    a98f:	e8 97 a6 ff ff       	call   502b <sin>
    a994:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a997:	83 c0 48             	add    $0x48,%eax
    a99a:	dd 1c c5 20 f8 00 00 	fstpl  0xf820(,%eax,8)
            win[3][i] = 1.0;
        for (i = 18; i < 36; i++)
            win[3][i] = sin(PI / 36 * (i + 0.5));

        /* type 2*/
        for (i = 0; i < 12; i++)
    a9a1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a9a5:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    a9a9:	7e ce                	jle    a979 <inv_mdct+0x1db>
            win[2][i] = sin(PI / 12 * (i + 0.5));
        for (i = 12; i < 36; i++)
    a9ab:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    a9b2:	eb 13                	jmp    a9c7 <inv_mdct+0x229>
            win[2][i] = 0.0;
    a9b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a9b7:	83 c0 48             	add    $0x48,%eax
    a9ba:	d9 ee                	fldz   
    a9bc:	dd 1c c5 20 f8 00 00 	fstpl  0xf820(,%eax,8)
            win[3][i] = sin(PI / 36 * (i + 0.5));

        /* type 2*/
        for (i = 0; i < 12; i++)
            win[2][i] = sin(PI / 12 * (i + 0.5));
        for (i = 12; i < 36; i++)
    a9c3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a9c7:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a9cb:	7e e7                	jle    a9b4 <inv_mdct+0x216>
            win[2][i] = 0.0;

        for (i = 0; i < 4 * 36; i++)
    a9cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a9d4:	eb 21                	jmp    a9f7 <inv_mdct+0x259>
            COS[i] = cos(PI / (2 * 36) * i);
    a9d6:	db 45 f4             	fildl  -0xc(%ebp)
    a9d9:	dd 05 90 e0 00 00    	fldl   0xe090
    a9df:	de c9                	fmulp  %st,%st(1)
    a9e1:	dd 1c 24             	fstpl  (%esp)
    a9e4:	e8 e1 a6 ff ff       	call   50ca <cos>
    a9e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a9ec:	dd 1c c5 a0 fc 00 00 	fstpl  0xfca0(,%eax,8)
        for (i = 0; i < 12; i++)
            win[2][i] = sin(PI / 12 * (i + 0.5));
        for (i = 12; i < 36; i++)
            win[2][i] = 0.0;

        for (i = 0; i < 4 * 36; i++)
    a9f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a9f7:	81 7d f4 8f 00 00 00 	cmpl   $0x8f,-0xc(%ebp)
    a9fe:	7e d6                	jle    a9d6 <inv_mdct+0x238>
            COS[i] = cos(PI / (2 * 36) * i);

        init++;
    aa00:	a1 00 f8 00 00       	mov    0xf800,%eax
    aa05:	83 c0 01             	add    $0x1,%eax
    aa08:	a3 00 f8 00 00       	mov    %eax,0xf800
    }

    for (i = 0; i < 36; i++)
    aa0d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    aa14:	eb 17                	jmp    aa2d <inv_mdct+0x28f>
        out[i] = 0;
    aa16:	8b 45 f4             	mov    -0xc(%ebp),%eax
    aa19:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    aa20:	8b 45 0c             	mov    0xc(%ebp),%eax
    aa23:	01 d0                	add    %edx,%eax
    aa25:	d9 ee                	fldz   
    aa27:	dd 18                	fstpl  (%eax)
            COS[i] = cos(PI / (2 * 36) * i);

        init++;
    }

    for (i = 0; i < 36; i++)
    aa29:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    aa2d:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    aa31:	7e e3                	jle    aa16 <inv_mdct+0x278>
        out[i] = 0;

    if (block_type == 2) {
    aa33:	83 7d 10 02          	cmpl   $0x2,0x10(%ebp)
    aa37:	0f 85 85 01 00 00    	jne    abc2 <inv_mdct+0x424>
        N = 12;
    aa3d:	c7 45 dc 0c 00 00 00 	movl   $0xc,-0x24(%ebp)
        for (i = 0; i < 3; i++) {
    aa44:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    aa4b:	e9 63 01 00 00       	jmp    abb3 <inv_mdct+0x415>
            for (p = 0; p < N; p++) {
    aa50:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    aa57:	e9 df 00 00 00       	jmp    ab3b <inv_mdct+0x39d>
                sum = 0.0;
    aa5c:	d9 ee                	fldz   
    aa5e:	dd 5d e0             	fstpl  -0x20(%ebp)
                for (m = 0; m < N / 2; m++)
    aa61:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    aa68:	e9 8f 00 00 00       	jmp    aafc <inv_mdct+0x35e>
                    sum += in[i + 3 * m] * cos(PI / (2 * N) * (2 * p + 1 + N / 2) * (2 * m + 1));
    aa6d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    aa70:	89 d0                	mov    %edx,%eax
    aa72:	01 c0                	add    %eax,%eax
    aa74:	01 c2                	add    %eax,%edx
    aa76:	8b 45 f4             	mov    -0xc(%ebp),%eax
    aa79:	01 d0                	add    %edx,%eax
    aa7b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    aa82:	8b 45 08             	mov    0x8(%ebp),%eax
    aa85:	01 d0                	add    %edx,%eax
    aa87:	dd 00                	fldl   (%eax)
    aa89:	dd 9d 68 ff ff ff    	fstpl  -0x98(%ebp)
    aa8f:	8b 45 dc             	mov    -0x24(%ebp),%eax
    aa92:	01 c0                	add    %eax,%eax
    aa94:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    aa9a:	db 85 74 ff ff ff    	fildl  -0x8c(%ebp)
    aaa0:	dd 05 98 e0 00 00    	fldl   0xe098
    aaa6:	de f1                	fdivp  %st,%st(1)
    aaa8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    aaab:	01 c0                	add    %eax,%eax
    aaad:	8d 50 01             	lea    0x1(%eax),%edx
    aab0:	8b 45 dc             	mov    -0x24(%ebp),%eax
    aab3:	89 c1                	mov    %eax,%ecx
    aab5:	c1 e9 1f             	shr    $0x1f,%ecx
    aab8:	01 c8                	add    %ecx,%eax
    aaba:	d1 f8                	sar    %eax
    aabc:	01 d0                	add    %edx,%eax
    aabe:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    aac4:	db 85 74 ff ff ff    	fildl  -0x8c(%ebp)
    aaca:	de c9                	fmulp  %st,%st(1)
    aacc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    aacf:	01 c0                	add    %eax,%eax
    aad1:	83 c0 01             	add    $0x1,%eax
    aad4:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    aada:	db 85 74 ff ff ff    	fildl  -0x8c(%ebp)
    aae0:	de c9                	fmulp  %st,%st(1)
    aae2:	dd 1c 24             	fstpl  (%esp)
    aae5:	e8 e0 a5 ff ff       	call   50ca <cos>
    aaea:	dc 8d 68 ff ff ff    	fmull  -0x98(%ebp)
    aaf0:	dd 45 e0             	fldl   -0x20(%ebp)
    aaf3:	de c1                	faddp  %st,%st(1)
    aaf5:	dd 5d e0             	fstpl  -0x20(%ebp)
    if (block_type == 2) {
        N = 12;
        for (i = 0; i < 3; i++) {
            for (p = 0; p < N; p++) {
                sum = 0.0;
                for (m = 0; m < N / 2; m++)
    aaf8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    aafc:	8b 45 dc             	mov    -0x24(%ebp),%eax
    aaff:	89 c2                	mov    %eax,%edx
    ab01:	c1 ea 1f             	shr    $0x1f,%edx
    ab04:	01 d0                	add    %edx,%eax
    ab06:	d1 f8                	sar    %eax
    ab08:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    ab0b:	0f 8f 5c ff ff ff    	jg     aa6d <inv_mdct+0x2cf>
                    sum += in[i + 3 * m] * cos(PI / (2 * N) * (2 * p + 1 + N / 2) * (2 * m + 1));
                tmp[p] = sum * win[block_type][p];
    ab11:	8b 55 10             	mov    0x10(%ebp),%edx
    ab14:	89 d0                	mov    %edx,%eax
    ab16:	c1 e0 03             	shl    $0x3,%eax
    ab19:	01 d0                	add    %edx,%eax
    ab1b:	c1 e0 02             	shl    $0x2,%eax
    ab1e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    ab21:	01 d0                	add    %edx,%eax
    ab23:	dd 04 c5 20 f8 00 00 	fldl   0xf820(,%eax,8)
    ab2a:	dc 4d e0             	fmull  -0x20(%ebp)
    ab2d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    ab30:	dd 9c c5 78 ff ff ff 	fstpl  -0x88(%ebp,%eax,8)
        out[i] = 0;

    if (block_type == 2) {
        N = 12;
        for (i = 0; i < 3; i++) {
            for (p = 0; p < N; p++) {
    ab37:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    ab3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    ab3e:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    ab41:	0f 8c 15 ff ff ff    	jl     aa5c <inv_mdct+0x2be>
                sum = 0.0;
                for (m = 0; m < N / 2; m++)
                    sum += in[i + 3 * m] * cos(PI / (2 * N) * (2 * p + 1 + N / 2) * (2 * m + 1));
                tmp[p] = sum * win[block_type][p];
            }
            for (p = 0; p < N; p++)
    ab47:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    ab4e:	eb 57                	jmp    aba7 <inv_mdct+0x409>
                out[6 * i + p + 6] += tmp[p];
    ab50:	8b 55 f4             	mov    -0xc(%ebp),%edx
    ab53:	89 d0                	mov    %edx,%eax
    ab55:	01 c0                	add    %eax,%eax
    ab57:	01 d0                	add    %edx,%eax
    ab59:	01 c0                	add    %eax,%eax
    ab5b:	89 c2                	mov    %eax,%edx
    ab5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    ab60:	01 d0                	add    %edx,%eax
    ab62:	83 c0 06             	add    $0x6,%eax
    ab65:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    ab6c:	8b 45 0c             	mov    0xc(%ebp),%eax
    ab6f:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    ab72:	8b 55 f4             	mov    -0xc(%ebp),%edx
    ab75:	89 d0                	mov    %edx,%eax
    ab77:	01 c0                	add    %eax,%eax
    ab79:	01 d0                	add    %edx,%eax
    ab7b:	01 c0                	add    %eax,%eax
    ab7d:	89 c2                	mov    %eax,%edx
    ab7f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    ab82:	01 d0                	add    %edx,%eax
    ab84:	83 c0 06             	add    $0x6,%eax
    ab87:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    ab8e:	8b 45 0c             	mov    0xc(%ebp),%eax
    ab91:	01 d0                	add    %edx,%eax
    ab93:	dd 00                	fldl   (%eax)
    ab95:	8b 45 ec             	mov    -0x14(%ebp),%eax
    ab98:	dd 84 c5 78 ff ff ff 	fldl   -0x88(%ebp,%eax,8)
    ab9f:	de c1                	faddp  %st,%st(1)
    aba1:	dd 19                	fstpl  (%ecx)
                sum = 0.0;
                for (m = 0; m < N / 2; m++)
                    sum += in[i + 3 * m] * cos(PI / (2 * N) * (2 * p + 1 + N / 2) * (2 * m + 1));
                tmp[p] = sum * win[block_type][p];
            }
            for (p = 0; p < N; p++)
    aba3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    aba7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    abaa:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    abad:	7c a1                	jl     ab50 <inv_mdct+0x3b2>
    for (i = 0; i < 36; i++)
        out[i] = 0;

    if (block_type == 2) {
        N = 12;
        for (i = 0; i < 3; i++) {
    abaf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    abb3:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
    abb7:	0f 8e 93 fe ff ff    	jle    aa50 <inv_mdct+0x2b2>
    abbd:	e9 da 00 00 00       	jmp    ac9c <inv_mdct+0x4fe>
            for (p = 0; p < N; p++)
                out[6 * i + p + 6] += tmp[p];
        }
    }
    else {
        N = 36;
    abc2:	c7 45 dc 24 00 00 00 	movl   $0x24,-0x24(%ebp)
        for (p = 0; p < N; p++) {
    abc9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    abd0:	e9 bb 00 00 00       	jmp    ac90 <inv_mdct+0x4f2>
            sum = 0.0;
    abd5:	d9 ee                	fldz   
    abd7:	dd 5d e0             	fstpl  -0x20(%ebp)
            for (m = 0; m < N / 2; m++)
    abda:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    abe1:	eb 6a                	jmp    ac4d <inv_mdct+0x4af>
                sum += in[m] * COS[((2 * p + 1 + N / 2) * (2 * m + 1)) % (4 * 36)];
    abe3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    abe6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    abed:	8b 45 08             	mov    0x8(%ebp),%eax
    abf0:	01 d0                	add    %edx,%eax
    abf2:	dd 00                	fldl   (%eax)
    abf4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    abf7:	01 c0                	add    %eax,%eax
    abf9:	8d 50 01             	lea    0x1(%eax),%edx
    abfc:	8b 45 dc             	mov    -0x24(%ebp),%eax
    abff:	89 c1                	mov    %eax,%ecx
    ac01:	c1 e9 1f             	shr    $0x1f,%ecx
    ac04:	01 c8                	add    %ecx,%eax
    ac06:	d1 f8                	sar    %eax
    ac08:	01 c2                	add    %eax,%edx
    ac0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    ac0d:	01 c0                	add    %eax,%eax
    ac0f:	83 c0 01             	add    $0x1,%eax
    ac12:	89 d1                	mov    %edx,%ecx
    ac14:	0f af c8             	imul   %eax,%ecx
    ac17:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    ac1c:	89 c8                	mov    %ecx,%eax
    ac1e:	f7 ea                	imul   %edx
    ac20:	c1 fa 05             	sar    $0x5,%edx
    ac23:	89 c8                	mov    %ecx,%eax
    ac25:	c1 f8 1f             	sar    $0x1f,%eax
    ac28:	29 c2                	sub    %eax,%edx
    ac2a:	89 d0                	mov    %edx,%eax
    ac2c:	c1 e0 03             	shl    $0x3,%eax
    ac2f:	01 d0                	add    %edx,%eax
    ac31:	c1 e0 04             	shl    $0x4,%eax
    ac34:	29 c1                	sub    %eax,%ecx
    ac36:	89 ca                	mov    %ecx,%edx
    ac38:	dd 04 d5 a0 fc 00 00 	fldl   0xfca0(,%edx,8)
    ac3f:	de c9                	fmulp  %st,%st(1)
    ac41:	dd 45 e0             	fldl   -0x20(%ebp)
    ac44:	de c1                	faddp  %st,%st(1)
    ac46:	dd 5d e0             	fstpl  -0x20(%ebp)
    }
    else {
        N = 36;
        for (p = 0; p < N; p++) {
            sum = 0.0;
            for (m = 0; m < N / 2; m++)
    ac49:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    ac4d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    ac50:	89 c2                	mov    %eax,%edx
    ac52:	c1 ea 1f             	shr    $0x1f,%edx
    ac55:	01 d0                	add    %edx,%eax
    ac57:	d1 f8                	sar    %eax
    ac59:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    ac5c:	7f 85                	jg     abe3 <inv_mdct+0x445>
                sum += in[m] * COS[((2 * p + 1 + N / 2) * (2 * m + 1)) % (4 * 36)];
            out[p] = sum * win[block_type][p];
    ac5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    ac61:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    ac68:	8b 45 0c             	mov    0xc(%ebp),%eax
    ac6b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    ac6e:	8b 55 10             	mov    0x10(%ebp),%edx
    ac71:	89 d0                	mov    %edx,%eax
    ac73:	c1 e0 03             	shl    $0x3,%eax
    ac76:	01 d0                	add    %edx,%eax
    ac78:	c1 e0 02             	shl    $0x2,%eax
    ac7b:	8b 55 ec             	mov    -0x14(%ebp),%edx
    ac7e:	01 d0                	add    %edx,%eax
    ac80:	dd 04 c5 20 f8 00 00 	fldl   0xf820(,%eax,8)
    ac87:	dc 4d e0             	fmull  -0x20(%ebp)
    ac8a:	dd 19                	fstpl  (%ecx)
                out[6 * i + p + 6] += tmp[p];
        }
    }
    else {
        N = 36;
        for (p = 0; p < N; p++) {
    ac8c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    ac90:	8b 45 ec             	mov    -0x14(%ebp),%eax
    ac93:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    ac96:	0f 8c 39 ff ff ff    	jl     abd5 <inv_mdct+0x437>
            for (m = 0; m < N / 2; m++)
                sum += in[m] * COS[((2 * p + 1 + N / 2) * (2 * m + 1)) % (4 * 36)];
            out[p] = sum * win[block_type][p];
        }
    }
}
    ac9c:	c9                   	leave  
    ac9d:	c3                   	ret    

0000ac9e <III_hybrid>:

void III_hybrid(double fsIn[SSLIMIT], double tsOut[SSLIMIT], int sb, int ch, struct gr_info_s *gr_info,
                struct frame_params *fr_ps)
/* fsIn:freq samples per subband in */
/* tsOut:time samples per subband out */
{
    ac9e:	55                   	push   %ebp
    ac9f:	89 e5                	mov    %esp,%ebp
    aca1:	53                   	push   %ebx
    aca2:	81 ec 54 01 00 00    	sub    $0x154,%esp
    double rawout[36];
    static double prevblck[2][SBLIMIT][SSLIMIT];
    static int init = 1;
    int bt;

    if (init) {
    aca8:	a1 04 f7 00 00       	mov    0xf704,%eax
    acad:	85 c0                	test   %eax,%eax
    acaf:	74 6f                	je     ad20 <III_hybrid+0x82>
        int i, j, k;

        for (i = 0; i < 2; i++)
    acb1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    acb8:	eb 56                	jmp    ad10 <III_hybrid+0x72>
            for (j = 0; j < SBLIMIT; j++)
    acba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    acc1:	eb 43                	jmp    ad06 <III_hybrid+0x68>
                for (k = 0; k < SSLIMIT; k++)
    acc3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    acca:	eb 30                	jmp    acfc <III_hybrid+0x5e>
                    prevblck[i][j][k] = 0.0;
    accc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    accf:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    acd2:	89 c2                	mov    %eax,%edx
    acd4:	c1 e2 03             	shl    $0x3,%edx
    acd7:	01 c2                	add    %eax,%edx
    acd9:	8d 04 12             	lea    (%edx,%edx,1),%eax
    acdc:	89 c2                	mov    %eax,%edx
    acde:	89 c8                	mov    %ecx,%eax
    ace0:	c1 e0 03             	shl    $0x3,%eax
    ace3:	01 c8                	add    %ecx,%eax
    ace5:	c1 e0 06             	shl    $0x6,%eax
    ace8:	01 c2                	add    %eax,%edx
    acea:	8b 45 e8             	mov    -0x18(%ebp),%eax
    aced:	01 d0                	add    %edx,%eax
    acef:	d9 ee                	fldz   
    acf1:	dd 1c c5 20 01 01 00 	fstpl  0x10120(,%eax,8)
    if (init) {
        int i, j, k;

        for (i = 0; i < 2; i++)
            for (j = 0; j < SBLIMIT; j++)
                for (k = 0; k < SSLIMIT; k++)
    acf8:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    acfc:	83 7d e8 11          	cmpl   $0x11,-0x18(%ebp)
    ad00:	7e ca                	jle    accc <III_hybrid+0x2e>

    if (init) {
        int i, j, k;

        for (i = 0; i < 2; i++)
            for (j = 0; j < SBLIMIT; j++)
    ad02:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    ad06:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
    ad0a:	7e b7                	jle    acc3 <III_hybrid+0x25>
    int bt;

    if (init) {
        int i, j, k;

        for (i = 0; i < 2; i++)
    ad0c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    ad10:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    ad14:	7e a4                	jle    acba <III_hybrid+0x1c>
            for (j = 0; j < SBLIMIT; j++)
                for (k = 0; k < SSLIMIT; k++)
                    prevblck[i][j][k] = 0.0;
        init = 0;
    ad16:	c7 05 04 f7 00 00 00 	movl   $0x0,0xf704
    ad1d:	00 00 00 
    }

    bt = (gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    ad20:	8b 45 18             	mov    0x18(%ebp),%eax
    ad23:	8b 40 10             	mov    0x10(%eax),%eax
    ad26:	85 c0                	test   %eax,%eax
    ad28:	74 10                	je     ad3a <III_hybrid+0x9c>
    ad2a:	8b 45 18             	mov    0x18(%ebp),%eax
    ad2d:	8b 40 18             	mov    0x18(%eax),%eax
    ad30:	85 c0                	test   %eax,%eax
    ad32:	74 06                	je     ad3a <III_hybrid+0x9c>
    ad34:	83 7d 10 01          	cmpl   $0x1,0x10(%ebp)
    ad38:	7e 08                	jle    ad42 <III_hybrid+0xa4>
          (sb < 2)) ? 0 : gr_info->block_type;
    ad3a:	8b 45 18             	mov    0x18(%ebp),%eax
    ad3d:	8b 40 14             	mov    0x14(%eax),%eax
                for (k = 0; k < SSLIMIT; k++)
                    prevblck[i][j][k] = 0.0;
        init = 0;
    }

    bt = (gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    ad40:	eb 05                	jmp    ad47 <III_hybrid+0xa9>
    ad42:	b8 00 00 00 00       	mov    $0x0,%eax
    ad47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
          (sb < 2)) ? 0 : gr_info->block_type;

    inv_mdct(fsIn, rawout, bt);
    ad4a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    ad4d:	89 44 24 08          	mov    %eax,0x8(%esp)
    ad51:	8d 85 c0 fe ff ff    	lea    -0x140(%ebp),%eax
    ad57:	89 44 24 04          	mov    %eax,0x4(%esp)
    ad5b:	8b 45 08             	mov    0x8(%ebp),%eax
    ad5e:	89 04 24             	mov    %eax,(%esp)
    ad61:	e8 38 fa ff ff       	call   a79e <inv_mdct>

    /* overlap addition */
    for (ss = 0; ss < SSLIMIT; ss++) {
    ad66:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    ad6d:	e9 83 00 00 00       	jmp    adf5 <III_hybrid+0x157>
        tsOut[ss] = rawout[ss] + prevblck[ch][sb][ss];
    ad72:	8b 45 f4             	mov    -0xc(%ebp),%eax
    ad75:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    ad7c:	8b 45 0c             	mov    0xc(%ebp),%eax
    ad7f:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    ad82:	8b 45 f4             	mov    -0xc(%ebp),%eax
    ad85:	dd 84 c5 c0 fe ff ff 	fldl   -0x140(%ebp,%eax,8)
    ad8c:	8b 45 10             	mov    0x10(%ebp),%eax
    ad8f:	8b 4d 14             	mov    0x14(%ebp),%ecx
    ad92:	89 c2                	mov    %eax,%edx
    ad94:	c1 e2 03             	shl    $0x3,%edx
    ad97:	01 c2                	add    %eax,%edx
    ad99:	8d 04 12             	lea    (%edx,%edx,1),%eax
    ad9c:	89 c2                	mov    %eax,%edx
    ad9e:	89 c8                	mov    %ecx,%eax
    ada0:	c1 e0 03             	shl    $0x3,%eax
    ada3:	01 c8                	add    %ecx,%eax
    ada5:	c1 e0 06             	shl    $0x6,%eax
    ada8:	01 c2                	add    %eax,%edx
    adaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    adad:	01 d0                	add    %edx,%eax
    adaf:	dd 04 c5 20 01 01 00 	fldl   0x10120(,%eax,8)
    adb6:	de c1                	faddp  %st,%st(1)
    adb8:	dd 1b                	fstpl  (%ebx)
        prevblck[ch][sb][ss] = rawout[ss + 18];
    adba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    adbd:	83 c0 12             	add    $0x12,%eax
    adc0:	dd 84 c5 c0 fe ff ff 	fldl   -0x140(%ebp,%eax,8)
    adc7:	8b 45 10             	mov    0x10(%ebp),%eax
    adca:	8b 4d 14             	mov    0x14(%ebp),%ecx
    adcd:	89 c2                	mov    %eax,%edx
    adcf:	c1 e2 03             	shl    $0x3,%edx
    add2:	01 c2                	add    %eax,%edx
    add4:	8d 04 12             	lea    (%edx,%edx,1),%eax
    add7:	89 c2                	mov    %eax,%edx
    add9:	89 c8                	mov    %ecx,%eax
    addb:	c1 e0 03             	shl    $0x3,%eax
    adde:	01 c8                	add    %ecx,%eax
    ade0:	c1 e0 06             	shl    $0x6,%eax
    ade3:	01 c2                	add    %eax,%edx
    ade5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    ade8:	01 d0                	add    %edx,%eax
    adea:	dd 1c c5 20 01 01 00 	fstpl  0x10120(,%eax,8)
          (sb < 2)) ? 0 : gr_info->block_type;

    inv_mdct(fsIn, rawout, bt);

    /* overlap addition */
    for (ss = 0; ss < SSLIMIT; ss++) {
    adf1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    adf5:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    adf9:	0f 8e 73 ff ff ff    	jle    ad72 <III_hybrid+0xd4>
        tsOut[ss] = rawout[ss] + prevblck[ch][sb][ss];
        prevblck[ch][sb][ss] = rawout[ss + 18];
    }
}
    adff:	81 c4 54 01 00 00    	add    $0x154,%esp
    ae05:	5b                   	pop    %ebx
    ae06:	5d                   	pop    %ebp
    ae07:	c3                   	ret    

0000ae08 <create_syn_filter>:


/* create in synthesis filter */
void create_syn_filter(double filter[64][SBLIMIT]) {
    ae08:	55                   	push   %ebp
    ae09:	89 e5                	mov    %esp,%ebp
    ae0b:	57                   	push   %edi
    ae0c:	56                   	push   %esi
    ae0d:	53                   	push   %ebx
    ae0e:	83 ec 1c             	sub    $0x1c,%esp
    register int i, k;

    for (i = 0; i < 64; i++)
    ae11:	be 00 00 00 00       	mov    $0x0,%esi
    ae16:	e9 1c 01 00 00       	jmp    af37 <create_syn_filter+0x12f>
        for (k = 0; k < 32; k++) {
    ae1b:	bb 00 00 00 00       	mov    $0x0,%ebx
    ae20:	e9 06 01 00 00       	jmp    af2b <create_syn_filter+0x123>
            if ((filter[i][k] = 1e9 * cos((double) ((PI64 * i + PI4) * (2 * k + 1)))) >= 0)
    ae25:	89 f0                	mov    %esi,%eax
    ae27:	c1 e0 08             	shl    $0x8,%eax
    ae2a:	89 c2                	mov    %eax,%edx
    ae2c:	8b 45 08             	mov    0x8(%ebp),%eax
    ae2f:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    ae32:	89 75 e0             	mov    %esi,-0x20(%ebp)
    ae35:	db 45 e0             	fildl  -0x20(%ebp)
    ae38:	dd 05 a0 e0 00 00    	fldl   0xe0a0
    ae3e:	de c9                	fmulp  %st,%st(1)
    ae40:	dd 05 a8 e0 00 00    	fldl   0xe0a8
    ae46:	de c1                	faddp  %st,%st(1)
    ae48:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
    ae4b:	83 c0 01             	add    $0x1,%eax
    ae4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    ae51:	db 45 e0             	fildl  -0x20(%ebp)
    ae54:	de c9                	fmulp  %st,%st(1)
    ae56:	dd 1c 24             	fstpl  (%esp)
    ae59:	e8 6c a2 ff ff       	call   50ca <cos>
    ae5e:	dd 05 b0 e0 00 00    	fldl   0xe0b0
    ae64:	de c9                	fmulp  %st,%st(1)
    ae66:	dd 1c df             	fstpl  (%edi,%ebx,8)
    ae69:	dd 04 df             	fldl   (%edi,%ebx,8)
    ae6c:	d9 ee                	fldz   
    ae6e:	d9 c9                	fxch   %st(1)
    ae70:	df e9                	fucomip %st(1),%st
    ae72:	dd d8                	fstp   %st(0)
    ae74:	72 47                	jb     aebd <create_syn_filter+0xb5>
                filter[i][k] = (int) (filter[i][k] + 0.5);
    ae76:	89 f0                	mov    %esi,%eax
    ae78:	c1 e0 08             	shl    $0x8,%eax
    ae7b:	89 c2                	mov    %eax,%edx
    ae7d:	8b 45 08             	mov    0x8(%ebp),%eax
    ae80:	01 c2                	add    %eax,%edx
    ae82:	89 f0                	mov    %esi,%eax
    ae84:	c1 e0 08             	shl    $0x8,%eax
    ae87:	89 c1                	mov    %eax,%ecx
    ae89:	8b 45 08             	mov    0x8(%ebp),%eax
    ae8c:	01 c8                	add    %ecx,%eax
    ae8e:	dd 04 d8             	fldl   (%eax,%ebx,8)
    ae91:	dd 05 70 e0 00 00    	fldl   0xe070
    ae97:	de c1                	faddp  %st,%st(1)
    ae99:	d9 7d e6             	fnstcw -0x1a(%ebp)
    ae9c:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    aea0:	b4 0c                	mov    $0xc,%ah
    aea2:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    aea6:	d9 6d e4             	fldcw  -0x1c(%ebp)
    aea9:	db 5d e0             	fistpl -0x20(%ebp)
    aeac:	d9 6d e6             	fldcw  -0x1a(%ebp)
    aeaf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    aeb2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    aeb5:	db 45 e0             	fildl  -0x20(%ebp)
    aeb8:	dd 1c da             	fstpl  (%edx,%ebx,8)
    aebb:	eb 45                	jmp    af02 <create_syn_filter+0xfa>
                //modf(filter[i][k]+0.5, &filter[i][k]);
            else
                filter[i][k] = (int) (filter[i][k] - 0.5);
    aebd:	89 f0                	mov    %esi,%eax
    aebf:	c1 e0 08             	shl    $0x8,%eax
    aec2:	89 c2                	mov    %eax,%edx
    aec4:	8b 45 08             	mov    0x8(%ebp),%eax
    aec7:	01 c2                	add    %eax,%edx
    aec9:	89 f0                	mov    %esi,%eax
    aecb:	c1 e0 08             	shl    $0x8,%eax
    aece:	89 c1                	mov    %eax,%ecx
    aed0:	8b 45 08             	mov    0x8(%ebp),%eax
    aed3:	01 c8                	add    %ecx,%eax
    aed5:	dd 04 d8             	fldl   (%eax,%ebx,8)
    aed8:	dd 05 70 e0 00 00    	fldl   0xe070
    aede:	de e9                	fsubrp %st,%st(1)
    aee0:	d9 7d e6             	fnstcw -0x1a(%ebp)
    aee3:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    aee7:	b4 0c                	mov    $0xc,%ah
    aee9:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    aeed:	d9 6d e4             	fldcw  -0x1c(%ebp)
    aef0:	db 5d e0             	fistpl -0x20(%ebp)
    aef3:	d9 6d e6             	fldcw  -0x1a(%ebp)
    aef6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    aef9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    aefc:	db 45 e0             	fildl  -0x20(%ebp)
    aeff:	dd 1c da             	fstpl  (%edx,%ebx,8)
            //modf(filter[i][k]-0.5, &filter[i][k]);
            filter[i][k] *= 1e-9;
    af02:	89 f0                	mov    %esi,%eax
    af04:	c1 e0 08             	shl    $0x8,%eax
    af07:	89 c2                	mov    %eax,%edx
    af09:	8b 45 08             	mov    0x8(%ebp),%eax
    af0c:	01 d0                	add    %edx,%eax
    af0e:	89 f2                	mov    %esi,%edx
    af10:	89 d1                	mov    %edx,%ecx
    af12:	c1 e1 08             	shl    $0x8,%ecx
    af15:	8b 55 08             	mov    0x8(%ebp),%edx
    af18:	01 ca                	add    %ecx,%edx
    af1a:	dd 04 da             	fldl   (%edx,%ebx,8)
    af1d:	dd 05 b8 e0 00 00    	fldl   0xe0b8
    af23:	de c9                	fmulp  %st,%st(1)
    af25:	dd 1c d8             	fstpl  (%eax,%ebx,8)
/* create in synthesis filter */
void create_syn_filter(double filter[64][SBLIMIT]) {
    register int i, k;

    for (i = 0; i < 64; i++)
        for (k = 0; k < 32; k++) {
    af28:	83 c3 01             	add    $0x1,%ebx
    af2b:	83 fb 1f             	cmp    $0x1f,%ebx
    af2e:	0f 8e f1 fe ff ff    	jle    ae25 <create_syn_filter+0x1d>

/* create in synthesis filter */
void create_syn_filter(double filter[64][SBLIMIT]) {
    register int i, k;

    for (i = 0; i < 64; i++)
    af34:	83 c6 01             	add    $0x1,%esi
    af37:	83 fe 3f             	cmp    $0x3f,%esi
    af3a:	0f 8e db fe ff ff    	jle    ae1b <create_syn_filter+0x13>
            else
                filter[i][k] = (int) (filter[i][k] - 0.5);
            //modf(filter[i][k]-0.5, &filter[i][k]);
            filter[i][k] *= 1e-9;
        }
}
    af40:	83 c4 1c             	add    $0x1c,%esp
    af43:	5b                   	pop    %ebx
    af44:	5e                   	pop    %esi
    af45:	5f                   	pop    %edi
    af46:	5d                   	pop    %ebp
    af47:	c3                   	ret    

0000af48 <read_syn_window>:


/* read in synthesis window */
void read_syn_window(double window[HAN_SIZE]) {
    af48:	55                   	push   %ebp
    af49:	89 e5                	mov    %esp,%ebp
    af4b:	57                   	push   %edi
    af4c:	56                   	push   %esi
    af4d:	53                   	push   %ebx
    af4e:	81 ec 14 10 00 00    	sub    $0x1014,%esp
    double gb_window[HAN_SIZE] = {0.0000000000, -0.0000152590, -0.0000152590, -0.0000152590,
    af54:	8d 95 e8 ef ff ff    	lea    -0x1018(%ebp),%edx
    af5a:	bb 20 d0 00 00       	mov    $0xd020,%ebx
    af5f:	b8 00 04 00 00       	mov    $0x400,%eax
    af64:	89 d7                	mov    %edx,%edi
    af66:	89 de                	mov    %ebx,%esi
    af68:	89 c1                	mov    %eax,%ecx
    af6a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
                                  0.0000762940, 0.0000762940, 0.0000610350, 0.0000610350,
                                  0.0000457760, 0.0000457760, 0.0000305180, 0.0000305180,
                                  0.0000305180, 0.0000305180, 0.0000152590, 0.0000152590,
                                  0.0000152590, 0.0000152590, 0.0000152590, 0.0000152590,
    };
    window = gb_window;
    af6c:	8d 85 e8 ef ff ff    	lea    -0x1018(%ebp),%eax
    af72:	89 45 ec             	mov    %eax,-0x14(%ebp)
}
    af75:	81 c4 14 10 00 00    	add    $0x1014,%esp
    af7b:	5b                   	pop    %ebx
    af7c:	5e                   	pop    %esi
    af7d:	5f                   	pop    %edi
    af7e:	5d                   	pop    %ebp
    af7f:	c3                   	ret    

0000af80 <SubBandSynthesis>:

int SubBandSynthesis(double *bandPtr, int channel, short *samples) {
    af80:	55                   	push   %ebp
    af81:	89 e5                	mov    %esp,%ebp
    af83:	57                   	push   %edi
    af84:	56                   	push   %esi
    af85:	53                   	push   %ebx
    af86:	83 ec 2c             	sub    $0x2c,%esp
    static NN *filter;
    typedef double BB[2][2 * HAN_SIZE];
    static BB *buf;
    static int bufOffset[2] = {64, 64};
    static double *window;
    int clip = 0;               /* count & return how many samples clipped */
    af89:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

    if (init) {
    af90:	a1 08 f7 00 00       	mov    0xf708,%eax
    af95:	85 c0                	test   %eax,%eax
    af97:	74 6f                	je     b008 <SubBandSynthesis+0x88>
        buf = (BB *) mem_alloc(sizeof(BB), "BB");
    af99:	c7 44 24 04 20 e0 00 	movl   $0xe020,0x4(%esp)
    afa0:	00 
    afa1:	c7 04 24 00 40 00 00 	movl   $0x4000,(%esp)
    afa8:	e8 15 a8 ff ff       	call   57c2 <mem_alloc>
    afad:	a3 20 25 01 00       	mov    %eax,0x12520
        filter = (NN *) mem_alloc(sizeof(NN), "NN");
    afb2:	c7 44 24 04 23 e0 00 	movl   $0xe023,0x4(%esp)
    afb9:	00 
    afba:	c7 04 24 00 40 00 00 	movl   $0x4000,(%esp)
    afc1:	e8 fc a7 ff ff       	call   57c2 <mem_alloc>
    afc6:	a3 24 25 01 00       	mov    %eax,0x12524
        create_syn_filter(*filter);
    afcb:	a1 24 25 01 00       	mov    0x12524,%eax
    afd0:	89 04 24             	mov    %eax,(%esp)
    afd3:	e8 30 fe ff ff       	call   ae08 <create_syn_filter>
        window = (double *) mem_alloc(sizeof(double) * HAN_SIZE, "WIN");
    afd8:	c7 44 24 04 26 e0 00 	movl   $0xe026,0x4(%esp)
    afdf:	00 
    afe0:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    afe7:	e8 d6 a7 ff ff       	call   57c2 <mem_alloc>
    afec:	a3 28 25 01 00       	mov    %eax,0x12528
        read_syn_window(window);
    aff1:	a1 28 25 01 00       	mov    0x12528,%eax
    aff6:	89 04 24             	mov    %eax,(%esp)
    aff9:	e8 4a ff ff ff       	call   af48 <read_syn_window>
        init = 0;
    affe:	c7 05 08 f7 00 00 00 	movl   $0x0,0xf708
    b005:	00 00 00 
    }
/*    if (channel == 0) */
    bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
    b008:	8b 45 0c             	mov    0xc(%ebp),%eax
    b00b:	8b 04 85 0c f7 00 00 	mov    0xf70c(,%eax,4),%eax
    b012:	83 e8 40             	sub    $0x40,%eax
    b015:	25 ff 03 00 00       	and    $0x3ff,%eax
    b01a:	89 c2                	mov    %eax,%edx
    b01c:	8b 45 0c             	mov    0xc(%ebp),%eax
    b01f:	89 14 85 0c f7 00 00 	mov    %edx,0xf70c(,%eax,4)
    bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);
    b026:	8b 15 20 25 01 00    	mov    0x12520,%edx
    b02c:	8b 45 0c             	mov    0xc(%ebp),%eax
    b02f:	8b 04 85 0c f7 00 00 	mov    0xf70c(,%eax,4),%eax
    b036:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    b039:	c1 e1 0a             	shl    $0xa,%ecx
    b03c:	01 c8                	add    %ecx,%eax
    b03e:	c1 e0 03             	shl    $0x3,%eax
    b041:	8d 3c 02             	lea    (%edx,%eax,1),%edi

    for (i = 0; i < 64; i++) {
    b044:	bb 00 00 00 00       	mov    $0x0,%ebx
    b049:	eb 40                	jmp    b08b <SubBandSynthesis+0x10b>
        sum = 0;
    b04b:	d9 ee                	fldz   
        for (k = 0; k < 32; k++)
    b04d:	be 00 00 00 00       	mov    $0x0,%esi
    b052:	eb 26                	jmp    b07a <SubBandSynthesis+0xfa>
            sum += bandPtr[k] * (*filter)[i][k];
    b054:	89 f0                	mov    %esi,%eax
    b056:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    b05d:	8b 45 08             	mov    0x8(%ebp),%eax
    b060:	01 d0                	add    %edx,%eax
    b062:	dd 00                	fldl   (%eax)
    b064:	a1 24 25 01 00       	mov    0x12524,%eax
    b069:	89 da                	mov    %ebx,%edx
    b06b:	c1 e2 05             	shl    $0x5,%edx
    b06e:	01 f2                	add    %esi,%edx
    b070:	dd 04 d0             	fldl   (%eax,%edx,8)
    b073:	de c9                	fmulp  %st,%st(1)
    b075:	de c1                	faddp  %st,%st(1)
    bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
    bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);

    for (i = 0; i < 64; i++) {
        sum = 0;
        for (k = 0; k < 32; k++)
    b077:	83 c6 01             	add    $0x1,%esi
    b07a:	83 fe 1f             	cmp    $0x1f,%esi
    b07d:	7e d5                	jle    b054 <SubBandSynthesis+0xd4>
            sum += bandPtr[k] * (*filter)[i][k];
        bufOffsetPtr[i] = sum;
    b07f:	89 d8                	mov    %ebx,%eax
    b081:	c1 e0 03             	shl    $0x3,%eax
    b084:	01 f8                	add    %edi,%eax
    b086:	dd 18                	fstpl  (%eax)
    }
/*    if (channel == 0) */
    bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
    bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);

    for (i = 0; i < 64; i++) {
    b088:	83 c3 01             	add    $0x1,%ebx
    b08b:	83 fb 3f             	cmp    $0x3f,%ebx
    b08e:	7e bb                	jle    b04b <SubBandSynthesis+0xcb>
            sum += bandPtr[k] * (*filter)[i][k];
        bufOffsetPtr[i] = sum;
    }
    /*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
    /*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
    for (j = 0; j < 32; j++) {
    b090:	bf 00 00 00 00       	mov    $0x0,%edi
    b095:	e9 c7 00 00 00       	jmp    b161 <SubBandSynthesis+0x1e1>
        sum = 0;
    b09a:	d9 ee                	fldz   
        for (i = 0; i < 16; i++) {
    b09c:	bb 00 00 00 00       	mov    $0x0,%ebx
    b0a1:	eb 4c                	jmp    b0ef <SubBandSynthesis+0x16f>
            k = j + (i << 5);
    b0a3:	89 d8                	mov    %ebx,%eax
    b0a5:	c1 e0 05             	shl    $0x5,%eax
    b0a8:	8d 34 38             	lea    (%eax,%edi,1),%esi
            sum += window[k] * (*buf)[channel][((k + (((i + 1) >> 1) << 6)) +
    b0ab:	a1 28 25 01 00       	mov    0x12528,%eax
    b0b0:	89 f2                	mov    %esi,%edx
    b0b2:	c1 e2 03             	shl    $0x3,%edx
    b0b5:	01 d0                	add    %edx,%eax
    b0b7:	dd 00                	fldl   (%eax)
    b0b9:	a1 20 25 01 00       	mov    0x12520,%eax
    b0be:	8d 53 01             	lea    0x1(%ebx),%edx
    b0c1:	d1 fa                	sar    %edx
    b0c3:	c1 e2 06             	shl    $0x6,%edx
    b0c6:	8d 0c 32             	lea    (%edx,%esi,1),%ecx
                                                bufOffset[channel]) & 0x3ff];
    b0c9:	8b 55 0c             	mov    0xc(%ebp),%edx
    b0cc:	8b 14 95 0c f7 00 00 	mov    0xf70c(,%edx,4),%edx
    /*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
    for (j = 0; j < 32; j++) {
        sum = 0;
        for (i = 0; i < 16; i++) {
            k = j + (i << 5);
            sum += window[k] * (*buf)[channel][((k + (((i + 1) >> 1) << 6)) +
    b0d3:	01 ca                	add    %ecx,%edx
                                                bufOffset[channel]) & 0x3ff];
    b0d5:	89 d1                	mov    %edx,%ecx
    b0d7:	81 e1 ff 03 00 00    	and    $0x3ff,%ecx
    /*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
    for (j = 0; j < 32; j++) {
        sum = 0;
        for (i = 0; i < 16; i++) {
            k = j + (i << 5);
            sum += window[k] * (*buf)[channel][((k + (((i + 1) >> 1) << 6)) +
    b0dd:	8b 55 0c             	mov    0xc(%ebp),%edx
    b0e0:	c1 e2 0a             	shl    $0xa,%edx
    b0e3:	01 ca                	add    %ecx,%edx
    b0e5:	dd 04 d0             	fldl   (%eax,%edx,8)
    b0e8:	de c9                	fmulp  %st,%st(1)
    b0ea:	de c1                	faddp  %st,%st(1)
    }
    /*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
    /*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
    for (j = 0; j < 32; j++) {
        sum = 0;
        for (i = 0; i < 16; i++) {
    b0ec:	83 c3 01             	add    $0x1,%ebx
    b0ef:	83 fb 0f             	cmp    $0xf,%ebx
    b0f2:	7e af                	jle    b0a3 <SubBandSynthesis+0x123>
            sum += window[k] * (*buf)[channel][((k + (((i + 1) >> 1) << 6)) +
                                                bufOffset[channel]) & 0x3ff];
        }
        {
            /*long foo = (sum > 0) ? sum * SCALE + 0.5 : sum * SCALE - 0.5; */
            long foo = sum * SCALE;
    b0f4:	dd 05 c0 e0 00 00    	fldl   0xe0c0
    b0fa:	de c9                	fmulp  %st,%st(1)
    b0fc:	d9 7d d6             	fnstcw -0x2a(%ebp)
    b0ff:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    b103:	b4 0c                	mov    $0xc,%ah
    b105:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    b109:	d9 6d d4             	fldcw  -0x2c(%ebp)
    b10c:	db 5d e0             	fistpl -0x20(%ebp)
    b10f:	d9 6d d6             	fldcw  -0x2a(%ebp)
            if (foo >= (long) SCALE) {
    b112:	81 7d e0 ff 7f 00 00 	cmpl   $0x7fff,-0x20(%ebp)
    b119:	7e 15                	jle    b130 <SubBandSynthesis+0x1b0>
                samples[j] = SCALE - 1;
    b11b:	89 f8                	mov    %edi,%eax
    b11d:	8d 14 00             	lea    (%eax,%eax,1),%edx
    b120:	8b 45 10             	mov    0x10(%ebp),%eax
    b123:	01 d0                	add    %edx,%eax
    b125:	66 c7 00 ff 7f       	movw   $0x7fff,(%eax)
                ++clip;
    b12a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    b12e:	eb 2e                	jmp    b15e <SubBandSynthesis+0x1de>
            }
            else if (foo < (long) -SCALE) {
    b130:	81 7d e0 00 80 ff ff 	cmpl   $0xffff8000,-0x20(%ebp)
    b137:	7d 15                	jge    b14e <SubBandSynthesis+0x1ce>
                samples[j] = -SCALE;
    b139:	89 f8                	mov    %edi,%eax
    b13b:	8d 14 00             	lea    (%eax,%eax,1),%edx
    b13e:	8b 45 10             	mov    0x10(%ebp),%eax
    b141:	01 d0                	add    %edx,%eax
    b143:	66 c7 00 00 80       	movw   $0x8000,(%eax)
                ++clip;
    b148:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    b14c:	eb 10                	jmp    b15e <SubBandSynthesis+0x1de>
            }
            else samples[j] = foo;
    b14e:	89 f8                	mov    %edi,%eax
    b150:	8d 14 00             	lea    (%eax,%eax,1),%edx
    b153:	8b 45 10             	mov    0x10(%ebp),%eax
    b156:	01 c2                	add    %eax,%edx
    b158:	8b 45 e0             	mov    -0x20(%ebp),%eax
    b15b:	66 89 02             	mov    %ax,(%edx)
            sum += bandPtr[k] * (*filter)[i][k];
        bufOffsetPtr[i] = sum;
    }
    /*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
    /*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
    for (j = 0; j < 32; j++) {
    b15e:	83 c7 01             	add    $0x1,%edi
    b161:	83 ff 1f             	cmp    $0x1f,%edi
    b164:	0f 8e 30 ff ff ff    	jle    b09a <SubBandSynthesis+0x11a>
                ++clip;
            }
            else samples[j] = foo;
        }
    }
    return (clip);
    b16a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
    b16d:	83 c4 2c             	add    $0x2c,%esp
    b170:	5b                   	pop    %ebx
    b171:	5e                   	pop    %esi
    b172:	5f                   	pop    %edi
    b173:	5d                   	pop    %ebp
    b174:	c3                   	ret    

0000b175 <out_fifo>:

void out_fifo(short pcm_sample[2][SSLIMIT][SBLIMIT], int num, struct frame_params *fr_ps, unsigned long *psampFrames) {
    b175:	55                   	push   %ebp
    b176:	89 e5                	mov    %esp,%ebp
    b178:	83 ec 10             	sub    $0x10,%esp
    int i, j, l;
    int stereo = fr_ps->stereo;
    b17b:	8b 45 10             	mov    0x10(%ebp),%eax
    b17e:	8b 40 08             	mov    0x8(%eax),%eax
    b181:	89 45 f0             	mov    %eax,-0x10(%ebp)
    //int sblimit = fr_ps->sblimit;
    static long k = 0;

    for (i = 0; i < num; i++)
    b184:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    b18b:	eb 75                	jmp    b202 <out_fifo+0x8d>
        for (j = 0; j < SBLIMIT; j++) {
    b18d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    b194:	eb 62                	jmp    b1f8 <out_fifo+0x83>
            (*psampFrames)++;
    b196:	8b 45 14             	mov    0x14(%ebp),%eax
    b199:	8b 00                	mov    (%eax),%eax
    b19b:	8d 50 01             	lea    0x1(%eax),%edx
    b19e:	8b 45 14             	mov    0x14(%ebp),%eax
    b1a1:	89 10                	mov    %edx,(%eax)
            for (l = 0; l < stereo; l++) {
    b1a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    b1aa:	eb 40                	jmp    b1ec <out_fifo+0x77>
                if (!(k % 1600) && k) {
    b1ac:	8b 0d 2c 25 01 00    	mov    0x1252c,%ecx
    b1b2:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    b1b7:	89 c8                	mov    %ecx,%eax
    b1b9:	f7 ea                	imul   %edx
    b1bb:	c1 fa 09             	sar    $0x9,%edx
    b1be:	89 c8                	mov    %ecx,%eax
    b1c0:	c1 f8 1f             	sar    $0x1f,%eax
    b1c3:	29 c2                	sub    %eax,%edx
    b1c5:	89 d0                	mov    %edx,%eax
    b1c7:	69 c0 40 06 00 00    	imul   $0x640,%eax,%eax
    b1cd:	29 c1                	sub    %eax,%ecx
    b1cf:	89 c8                	mov    %ecx,%eax
    b1d1:	85 c0                	test   %eax,%eax
    b1d3:	75 13                	jne    b1e8 <out_fifo+0x73>
    b1d5:	a1 2c 25 01 00       	mov    0x1252c,%eax
    b1da:	85 c0                	test   %eax,%eax
    b1dc:	74 0a                	je     b1e8 <out_fifo+0x73>
                    //fwrite(outsamp,2,1600,outFile);
                    k = 0;
    b1de:	c7 05 2c 25 01 00 00 	movl   $0x0,0x1252c
    b1e5:	00 00 00 
    static long k = 0;

    for (i = 0; i < num; i++)
        for (j = 0; j < SBLIMIT; j++) {
            (*psampFrames)++;
            for (l = 0; l < stereo; l++) {
    b1e8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    b1ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    b1ef:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    b1f2:	7c b8                	jl     b1ac <out_fifo+0x37>
    int stereo = fr_ps->stereo;
    //int sblimit = fr_ps->sblimit;
    static long k = 0;

    for (i = 0; i < num; i++)
        for (j = 0; j < SBLIMIT; j++) {
    b1f4:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    b1f8:	83 7d f8 1f          	cmpl   $0x1f,-0x8(%ebp)
    b1fc:	7e 98                	jle    b196 <out_fifo+0x21>
    int i, j, l;
    int stereo = fr_ps->stereo;
    //int sblimit = fr_ps->sblimit;
    static long k = 0;

    for (i = 0; i < num; i++)
    b1fe:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    b202:	8b 45 fc             	mov    -0x4(%ebp),%eax
    b205:	3b 45 0c             	cmp    0xc(%ebp),%eax
    b208:	7c 83                	jl     b18d <out_fifo+0x18>
                    k = 0;
                }
                //outsamp[k++] = pcm_sample[l][i][j];
            }
        }
}
    b20a:	c9                   	leave  
    b20b:	c3                   	ret    

0000b20c <buffer_CRC>:


void buffer_CRC(Bit_stream_struc *bs, unsigned int *old_crc) {
    b20c:	55                   	push   %ebp
    b20d:	89 e5                	mov    %esp,%ebp
    b20f:	83 ec 18             	sub    $0x18,%esp
    *old_crc = getbits(bs, 16);
    b212:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
    b219:	00 
    b21a:	8b 45 08             	mov    0x8(%ebp),%eax
    b21d:	89 04 24             	mov    %eax,(%esp)
    b220:	e8 8b a8 ff ff       	call   5ab0 <getbits>
    b225:	8b 55 0c             	mov    0xc(%ebp),%edx
    b228:	89 02                	mov    %eax,(%edx)
}
    b22a:	c9                   	leave  
    b22b:	c3                   	ret    

0000b22c <main_data_slots>:

extern int bitrate[3][15];
extern double s_freq[4];

/* Return the number of slots for main data of current frame, */
int main_data_slots(struct frame_params fr_ps) {
    b22c:	55                   	push   %ebp
    b22d:	89 e5                	mov    %esp,%ebp
    b22f:	83 ec 18             	sub    $0x18,%esp
    int nSlots;

    nSlots = (144 * bitrate[2][fr_ps.header->bitrate_index])
    b232:	8b 45 08             	mov    0x8(%ebp),%eax
    b235:	8b 40 0c             	mov    0xc(%eax),%eax
    b238:	83 c0 1e             	add    $0x1e,%eax
    b23b:	8b 14 85 60 f2 00 00 	mov    0xf260(,%eax,4),%edx
    b242:	89 d0                	mov    %edx,%eax
    b244:	c1 e0 03             	shl    $0x3,%eax
    b247:	01 d0                	add    %edx,%eax
    b249:	c1 e0 04             	shl    $0x4,%eax
             / s_freq[fr_ps.header->sampling_frequency];
    b24c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    b24f:	db 45 ec             	fildl  -0x14(%ebp)
    b252:	8b 45 08             	mov    0x8(%ebp),%eax
    b255:	8b 40 10             	mov    0x10(%eax),%eax
    b258:	dd 04 c5 20 f3 00 00 	fldl   0xf320(,%eax,8)
    b25f:	de f9                	fdivrp %st,%st(1)

/* Return the number of slots for main data of current frame, */
int main_data_slots(struct frame_params fr_ps) {
    int nSlots;

    nSlots = (144 * bitrate[2][fr_ps.header->bitrate_index])
    b261:	d9 7d ea             	fnstcw -0x16(%ebp)
    b264:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
    b268:	b4 0c                	mov    $0xc,%ah
    b26a:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
    b26e:	d9 6d e8             	fldcw  -0x18(%ebp)
    b271:	db 5d fc             	fistpl -0x4(%ebp)
    b274:	d9 6d ea             	fldcw  -0x16(%ebp)
             / s_freq[fr_ps.header->sampling_frequency];
    if (fr_ps.header->padding) nSlots++;
    b277:	8b 45 08             	mov    0x8(%ebp),%eax
    b27a:	8b 40 14             	mov    0x14(%eax),%eax
    b27d:	85 c0                	test   %eax,%eax
    b27f:	74 04                	je     b285 <main_data_slots+0x59>
    b281:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    nSlots -= 4;
    b285:	83 6d fc 04          	subl   $0x4,-0x4(%ebp)
    if (fr_ps.header->error_protection)
    b289:	8b 45 08             	mov    0x8(%ebp),%eax
    b28c:	8b 40 08             	mov    0x8(%eax),%eax
    b28f:	85 c0                	test   %eax,%eax
    b291:	74 04                	je     b297 <main_data_slots+0x6b>
        nSlots -= 2;
    b293:	83 6d fc 02          	subl   $0x2,-0x4(%ebp)
    if (fr_ps.stereo == 1)
    b297:	8b 45 10             	mov    0x10(%ebp),%eax
    b29a:	83 f8 01             	cmp    $0x1,%eax
    b29d:	75 06                	jne    b2a5 <main_data_slots+0x79>
        nSlots -= 17;
    b29f:	83 6d fc 11          	subl   $0x11,-0x4(%ebp)
    b2a3:	eb 04                	jmp    b2a9 <main_data_slots+0x7d>
    else
        nSlots -= 32;
    b2a5:	83 6d fc 20          	subl   $0x20,-0x4(%ebp)
    return (nSlots);
    b2a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    b2ac:	c9                   	leave  
    b2ad:	c3                   	ret    
