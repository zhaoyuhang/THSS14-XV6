
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
       6:	a1 04 22 01 00       	mov    0x12204,%eax
       b:	29 c2                	sub    %eax,%edx
       d:	89 d0                	mov    %edx,%eax
       f:	d1 f8                	sar    %eax
      11:	a3 e4 f3 00 00       	mov    %eax,0xf3e4
	startYsave = TOPBAR_HEIGHT + ((context.height-pic.height) >> 1);
      16:	8b 55 10             	mov    0x10(%ebp),%edx
      19:	a1 08 22 01 00       	mov    0x12208,%eax
      1e:	29 c2                	sub    %eax,%edx
      20:	89 d0                	mov    %edx,%eax
      22:	d1 f8                	sar    %eax
      24:	83 c0 14             	add    $0x14,%eax
      27:	a3 e8 f3 00 00       	mov    %eax,0xf3e8
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
      37:	a1 04 22 01 00       	mov    0x12204,%eax
      3c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    h0 = pic.height;//图高
      3f:	a1 08 22 01 00       	mov    0x12208,%eax
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
      7d:	e8 b4 4b 00 00       	call   4c36 <malloc>
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
      a3:	e8 05 45 00 00       	call   45ad <memset>
    
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
     198:	8b 15 00 22 01 00    	mov    0x12200,%edx
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
     1b6:	8b 15 00 22 01 00    	mov    0x12200,%edx
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
     1d4:	8b 15 00 22 01 00    	mov    0x12200,%edx
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
     1f2:	8b 15 00 22 01 00    	mov    0x12200,%edx
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
     3c7:	c7 04 24 00 22 01 00 	movl   $0x12200,(%esp)
     3ce:	e8 9b 32 00 00       	call   366e <freepic>
    pic.data = data;
     3d3:	8b 45 d0             	mov    -0x30(%ebp),%eax
     3d6:	a3 00 22 01 00       	mov    %eax,0x12200
    pic.width = width;
     3db:	8b 45 08             	mov    0x8(%ebp),%eax
     3de:	a3 04 22 01 00       	mov    %eax,0x12204
    pic.height = height;
     3e3:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e6:	a3 08 22 01 00       	mov    %eax,0x12208
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
     43e:	e8 f3 47 00 00       	call   4c36 <malloc>
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
     464:	e8 44 41 00 00       	call   45ad <memset>
    
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
     78a:	e8 df 2e 00 00       	call   366e <freepic>
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
     7bd:	a1 04 22 01 00       	mov    0x12204,%eax
     7c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    pic_height = pic.height;
     7c5:	a1 08 22 01 00       	mov    0x12208,%eax
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
     872:	c7 44 24 04 c0 af 00 	movl   $0xafc0,0x4(%esp)
     879:	00 
     87a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     881:	e8 c4 40 00 00       	call   494a <printf>

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
     8c3:	a1 04 22 01 00       	mov    0x12204,%eax
     8c8:	0f af 45 14          	imul   0x14(%ebp),%eax
     8cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int height = pic.height*enlargeRate;
     8cf:	a1 08 22 01 00       	mov    0x12208,%eax
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
     937:	a1 f0 f3 00 00       	mov    0xf3f0,%eax
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
     964:	a1 ec f3 00 00       	mov    0xf3ec,%eax
     969:	0f af 45 14          	imul   0x14(%ebp),%eax
     96d:	01 d0                	add    %edx,%eax
     96f:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
     973:	89 44 24 18          	mov    %eax,0x18(%esp)
     977:	a1 00 22 01 00       	mov    0x12200,%eax
     97c:	89 44 24 0c          	mov    %eax,0xc(%esp)
     980:	a1 04 22 01 00       	mov    0x12204,%eax
     985:	89 44 24 10          	mov    %eax,0x10(%esp)
     989:	a1 08 22 01 00       	mov    0x12208,%eax
     98e:	89 44 24 14          	mov    %eax,0x14(%esp)
     992:	8b 45 08             	mov    0x8(%ebp),%eax
     995:	89 04 24             	mov    %eax,(%esp)
     998:	8b 45 0c             	mov    0xc(%ebp),%eax
     99b:	89 44 24 04          	mov    %eax,0x4(%esp)
     99f:	8b 45 10             	mov    0x10(%ebp),%eax
     9a2:	89 44 24 08          	mov    %eax,0x8(%esp)
     9a6:	e8 e7 21 00 00       	call   2b92 <draw_picture>
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
     9cc:	a1 ec f3 00 00       	mov    0xf3ec,%eax
     9d1:	0f af 45 14          	imul   0x14(%ebp),%eax
     9d5:	01 d0                	add    %edx,%eax
     9d7:	a3 e4 f3 00 00       	mov    %eax,0xf3e4
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
     a0d:	a1 f0 f3 00 00       	mov    0xf3f0,%eax
     a12:	0f af 45 14          	imul   0x14(%ebp),%eax
     a16:	01 d0                	add    %edx,%eax
     a18:	a3 e8 f3 00 00       	mov    %eax,0xf3e8

	printf(0,"Enlarge: context_width: %d, context_height: %d\n", context.width, context.height);
     a1d:	8b 55 10             	mov    0x10(%ebp),%edx
     a20:	8b 45 0c             	mov    0xc(%ebp),%eax
     a23:	89 54 24 0c          	mov    %edx,0xc(%esp)
     a27:	89 44 24 08          	mov    %eax,0x8(%esp)
     a2b:	c7 44 24 04 ec af 00 	movl   $0xafec,0x4(%esp)
     a32:	00 
     a33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     a3a:	e8 0b 3f 00 00       	call   494a <printf>
	printf(0,"Enlarge: width: %d, height: %d\n", width, height);
     a3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a42:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a49:	89 44 24 08          	mov    %eax,0x8(%esp)
     a4d:	c7 44 24 04 1c b0 00 	movl   $0xb01c,0x4(%esp)
     a54:	00 
     a55:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     a5c:	e8 e9 3e 00 00       	call   494a <printf>
        printf(0,"Enlarge: centerX: %d, centerY: %d\n", centerX, centerY);
     a61:	8b 45 1c             	mov    0x1c(%ebp),%eax
     a64:	89 44 24 0c          	mov    %eax,0xc(%esp)
     a68:	8b 45 18             	mov    0x18(%ebp),%eax
     a6b:	89 44 24 08          	mov    %eax,0x8(%esp)
     a6f:	c7 44 24 04 3c b0 00 	movl   $0xb03c,0x4(%esp)
     a76:	00 
     a77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     a7e:	e8 c7 3e 00 00       	call   494a <printf>
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
     aae:	a1 ec f3 00 00       	mov    0xf3ec,%eax
     ab3:	0f af 45 14          	imul   0x14(%ebp),%eax
     ab7:	01 c2                	add    %eax,%edx
     ab9:	a1 ec f3 00 00       	mov    0xf3ec,%eax
     abe:	0f af c2             	imul   %edx,%eax
     ac1:	a3 ec f3 00 00       	mov    %eax,0xf3ec
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
     adb:	a1 f0 f3 00 00       	mov    0xf3f0,%eax
     ae0:	0f af 45 14          	imul   0x14(%ebp),%eax
     ae4:	01 c2                	add    %eax,%edx
     ae6:	a1 f0 f3 00 00       	mov    0xf3f0,%eax
     aeb:	0f af c2             	imul   %edx,%eax
     aee:	a3 f0 f3 00 00       	mov    %eax,0xf3f0
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
     b00:	a1 04 22 01 00       	mov    0x12204,%eax
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
     b26:	a1 08 22 01 00       	mov    0x12208,%eax
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
     b85:	a1 00 22 01 00       	mov    0x12200,%eax
     b8a:	89 44 24 0c          	mov    %eax,0xc(%esp)
     b8e:	a1 04 22 01 00       	mov    0x12204,%eax
     b93:	89 44 24 10          	mov    %eax,0x10(%esp)
     b97:	a1 08 22 01 00       	mov    0x12208,%eax
     b9c:	89 44 24 14          	mov    %eax,0x14(%esp)
     ba0:	8b 45 08             	mov    0x8(%ebp),%eax
     ba3:	89 04 24             	mov    %eax,(%esp)
     ba6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ba9:	89 44 24 04          	mov    %eax,0x4(%esp)
     bad:	8b 45 10             	mov    0x10(%ebp),%eax
     bb0:	89 44 24 08          	mov    %eax,0x8(%esp)
     bb4:	e8 d9 1f 00 00       	call   2b92 <draw_picture>
    startXsave = (context.width-width) >> 1;
     bb9:	8b 45 0c             	mov    0xc(%ebp),%eax
     bbc:	2b 45 f4             	sub    -0xc(%ebp),%eax
     bbf:	d1 f8                	sar    %eax
     bc1:	a3 e4 f3 00 00       	mov    %eax,0xf3e4
    startYsave = TOPBAR_HEIGHT + ((context.height-height) >> 1);
     bc6:	8b 45 10             	mov    0x10(%ebp),%eax
     bc9:	2b 45 f0             	sub    -0x10(%ebp),%eax
     bcc:	d1 f8                	sar    %eax
     bce:	83 c0 14             	add    $0x14,%eax
     bd1:	a3 e8 f3 00 00       	mov    %eax,0xf3e8
    X_shift = 0;
     bd6:	c7 05 ec f3 00 00 00 	movl   $0x0,0xf3ec
     bdd:	00 00 00 
    Y_shift = 0;
     be0:	c7 05 f0 f3 00 00 00 	movl   $0x0,0xf3f0
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
     c0e:	a1 dc ee 00 00       	mov    0xeedc,%eax
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
     c4d:	c7 05 dc ee 00 00 02 	movl   $0x2,0xeedc
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
     c87:	c7 05 dc ee 00 00 01 	movl   $0x1,0xeedc
     c8e:	00 00 00 
            break;
     c91:	eb 0b                	jmp    c9e <zoomingPic+0xb2>
        default:
            isZooming = 1;
     c93:	c7 05 dc ee 00 00 01 	movl   $0x1,0xeedc
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
     ca7:	8b 15 04 22 01 00    	mov    0x12204,%edx
     cad:	a1 08 22 01 00       	mov    0x12208,%eax
     cb2:	0f af c2             	imul   %edx,%eax
     cb5:	c1 e0 02             	shl    $0x2,%eax
     cb8:	89 04 24             	mov    %eax,(%esp)
     cbb:	e8 76 3f 00 00       	call   4c36 <malloc>
     cc0:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int i,j;
	for (i = 0; i < pic.height; i++){
     cc3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     cca:	eb 60                	jmp    d2c <rollingPic+0x8c>
		for(j = 0; j < pic.width;j++){
     ccc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     cd3:	eb 49                	jmp    d1e <rollingPic+0x7e>
			cache[(pic.width - 1 - j)*pic.height + i] = pic.data[i*pic.width + j];
     cd5:	a1 04 22 01 00       	mov    0x12204,%eax
     cda:	83 e8 01             	sub    $0x1,%eax
     cdd:	2b 45 f0             	sub    -0x10(%ebp),%eax
     ce0:	89 c2                	mov    %eax,%edx
     ce2:	a1 08 22 01 00       	mov    0x12208,%eax
     ce7:	0f af d0             	imul   %eax,%edx
     cea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ced:	01 d0                	add    %edx,%eax
     cef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     cf6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cf9:	01 c2                	add    %eax,%edx
     cfb:	8b 0d 00 22 01 00    	mov    0x12200,%ecx
     d01:	a1 04 22 01 00       	mov    0x12204,%eax
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
     d1e:	a1 04 22 01 00       	mov    0x12204,%eax
     d23:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d26:	7f ad                	jg     cd5 <rollingPic+0x35>
//Picture Rolling
void rollingPic(Context context)
{
	RGBQUAD* cache = (RGBQUAD *) malloc(pic.width * pic.height * sizeof(RGBQUAD));
	int i,j;
	for (i = 0; i < pic.height; i++){
     d28:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d2c:	a1 08 22 01 00       	mov    0x12208,%eax
     d31:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     d34:	7f 96                	jg     ccc <rollingPic+0x2c>
		for(j = 0; j < pic.width;j++){
			cache[(pic.width - 1 - j)*pic.height + i] = pic.data[i*pic.width + j];
		}	
	}
	free(pic.data);
     d36:	a1 00 22 01 00       	mov    0x12200,%eax
     d3b:	89 04 24             	mov    %eax,(%esp)
     d3e:	e8 ba 3d 00 00       	call   4afd <free>
	i = pic.width;
     d43:	a1 04 22 01 00       	mov    0x12204,%eax
     d48:	89 45 f4             	mov    %eax,-0xc(%ebp)
	pic.width = pic.height;
     d4b:	a1 08 22 01 00       	mov    0x12208,%eax
     d50:	a3 04 22 01 00       	mov    %eax,0x12204
	pic.height = i;
     d55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d58:	a3 08 22 01 00       	mov    %eax,0x12208
	pic.data = cache;	
     d5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d60:	a3 00 22 01 00       	mov    %eax,0x12200
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
     d81:	a1 08 22 01 00       	mov    0x12208,%eax
     d86:	29 c2                	sub    %eax,%edx
     d88:	89 d0                	mov    %edx,%eax
     d8a:	d1 f8                	sar    %eax
     d8c:	8d 50 14             	lea    0x14(%eax),%edx
     d8f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     d92:	a1 04 22 01 00       	mov    0x12204,%eax
     d97:	29 c1                	sub    %eax,%ecx
     d99:	89 c8                	mov    %ecx,%eax
     d9b:	d1 f8                	sar    %eax
     d9d:	89 54 24 1c          	mov    %edx,0x1c(%esp)
     da1:	89 44 24 18          	mov    %eax,0x18(%esp)
     da5:	a1 00 22 01 00       	mov    0x12200,%eax
     daa:	89 44 24 0c          	mov    %eax,0xc(%esp)
     dae:	a1 04 22 01 00       	mov    0x12204,%eax
     db3:	89 44 24 10          	mov    %eax,0x10(%esp)
     db7:	a1 08 22 01 00       	mov    0x12208,%eax
     dbc:	89 44 24 14          	mov    %eax,0x14(%esp)
     dc0:	8b 45 08             	mov    0x8(%ebp),%eax
     dc3:	89 04 24             	mov    %eax,(%esp)
     dc6:	8b 45 0c             	mov    0xc(%ebp),%eax
     dc9:	89 44 24 04          	mov    %eax,0x4(%esp)
     dcd:	8b 45 10             	mov    0x10(%ebp),%eax
     dd0:	89 44 24 08          	mov    %eax,0x8(%esp)
     dd4:	e8 b9 1d 00 00       	call   2b92 <draw_picture>
	startXsave = (context.width-pic.width) >> 1;
     dd9:	8b 55 0c             	mov    0xc(%ebp),%edx
     ddc:	a1 04 22 01 00       	mov    0x12204,%eax
     de1:	29 c2                	sub    %eax,%edx
     de3:	89 d0                	mov    %edx,%eax
     de5:	d1 f8                	sar    %eax
     de7:	a3 e4 f3 00 00       	mov    %eax,0xf3e4
        startYsave = TOPBAR_HEIGHT + ((context.height-pic.height) >> 1);
     dec:	8b 55 10             	mov    0x10(%ebp),%edx
     def:	a1 08 22 01 00       	mov    0x12208,%eax
     df4:	29 c2                	sub    %eax,%edx
     df6:	89 d0                	mov    %edx,%eax
     df8:	d1 f8                	sar    %eax
     dfa:	83 c0 14             	add    $0x14,%eax
     dfd:	a3 e8 f3 00 00       	mov    %eax,0xf3e8
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
     e27:	c7 05 ec f3 00 00 00 	movl   $0x0,0xf3ec
     e2e:	00 00 00 
	Y_shift = 0;
     e31:	c7 05 f0 f3 00 00 00 	movl   $0x0,0xf3f0
     e38:	00 00 00 
	isZooming = 1;
     e3b:	c7 05 dc ee 00 00 01 	movl   $0x1,0xeedc
     e42:	00 00 00 
	pos = (pos+1) % len;	
     e45:	a1 0c 22 01 00       	mov    0x1220c,%eax
     e4a:	83 c0 01             	add    $0x1,%eax
     e4d:	8b 0d b0 23 01 00    	mov    0x123b0,%ecx
     e53:	99                   	cltd   
     e54:	f7 f9                	idiv   %ecx
     e56:	89 d0                	mov    %edx,%eax
     e58:	a3 0c 22 01 00       	mov    %eax,0x1220c
	if(pos==0)pos++;
     e5d:	a1 0c 22 01 00       	mov    0x1220c,%eax
     e62:	85 c0                	test   %eax,%eax
     e64:	75 0d                	jne    e73 <nextPic+0x52>
     e66:	a1 0c 22 01 00       	mov    0x1220c,%eax
     e6b:	83 c0 01             	add    $0x1,%eax
     e6e:	a3 0c 22 01 00       	mov    %eax,0x1220c
	printf(0,"%d\n",pos);
     e73:	a1 0c 22 01 00       	mov    0x1220c,%eax
     e78:	89 44 24 08          	mov    %eax,0x8(%esp)
     e7c:	c7 44 24 04 5f b0 00 	movl   $0xb05f,0x4(%esp)
     e83:	00 
     e84:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e8b:	e8 ba 3a 00 00       	call   494a <printf>
	loadBitmap(&pic, file[pos]);
     e90:	a1 0c 22 01 00       	mov    0x1220c,%eax
     e95:	8b 04 85 20 22 01 00 	mov    0x12220(,%eax,4),%eax
     e9c:	89 44 24 04          	mov    %eax,0x4(%esp)
     ea0:	c7 04 24 00 22 01 00 	movl   $0x12200,(%esp)
     ea7:	e8 16 22 00 00       	call   30c2 <loadBitmap>
	drawPicViewerWnd(context);
     eac:	8b 45 08             	mov    0x8(%ebp),%eax
     eaf:	89 04 24             	mov    %eax,(%esp)
     eb2:	8b 45 0c             	mov    0xc(%ebp),%eax
     eb5:	89 44 24 04          	mov    %eax,0x4(%esp)
     eb9:	8b 45 10             	mov    0x10(%ebp),%eax
     ebc:	89 44 24 08          	mov    %eax,0x8(%esp)
     ec0:	e8 58 00 00 00       	call   f1d <drawPicViewerWnd>
	drawPicViewerContent(context, file[pos]);
     ec5:	a1 0c 22 01 00       	mov    0x1220c,%eax
     eca:	8b 04 85 20 22 01 00 	mov    0x12220(,%eax,4),%eax
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
     f07:	c7 44 24 04 63 b0 00 	movl   $0xb063,0x4(%esp)
     f0e:	00 
     f0f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f16:	e8 2f 3a 00 00       	call   494a <printf>
	
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
     fac:	e8 b7 1c 00 00       	call   2c68 <draw_line>
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
     ff3:	e8 70 1c 00 00       	call   2c68 <draw_line>
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
    103a:	e8 29 1c 00 00       	call   2c68 <draw_line>
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
    107d:	e8 e6 1b 00 00       	call   2c68 <draw_line>

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
    10dd:	c7 44 24 0c 6a b0 00 	movl   $0xb06a,0xc(%esp)
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
    1106:	c7 44 24 0c a0 ee 00 	movl   $0xeea0,0xc(%esp)
    110d:	00 
    110e:	8b 45 08             	mov    0x8(%ebp),%eax
    1111:	89 04 24             	mov    %eax,(%esp)
    1114:	8b 45 0c             	mov    0xc(%ebp),%eax
    1117:	89 44 24 04          	mov    %eax,0x4(%esp)
    111b:	8b 45 10             	mov    0x10(%ebp),%eax
    111e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1122:	e8 1c 1f 00 00       	call   3043 <draw_iconlist>
    PICNODE rolling;
    loadBitmap(&rolling, "rolling.bmp");
    1127:	c7 44 24 04 78 b0 00 	movl   $0xb078,0x4(%esp)
    112e:	00 
    112f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1132:	89 04 24             	mov    %eax,(%esp)
    1135:	e8 88 1f 00 00       	call   30c2 <loadBitmap>
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
    118e:	e8 ff 19 00 00       	call   2b92 <draw_picture>
    freepic(&rolling);
    1193:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1196:	89 04 24             	mov    %eax,(%esp)
    1199:	e8 d0 24 00 00       	call   366e <freepic>

    PICNODE next;
    loadBitmap(&next, "next.bmp");
    119e:	c7 44 24 04 84 b0 00 	movl   $0xb084,0x4(%esp)
    11a5:	00 
    11a6:	8d 45 d8             	lea    -0x28(%ebp),%eax
    11a9:	89 04 24             	mov    %eax,(%esp)
    11ac:	e8 11 1f 00 00       	call   30c2 <loadBitmap>
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
    1205:	e8 88 19 00 00       	call   2b92 <draw_picture>
    freepic(&next);
    120a:	8d 45 d8             	lea    -0x28(%ebp),%eax
    120d:	89 04 24             	mov    %eax,(%esp)
    1210:	e8 59 24 00 00       	call   366e <freepic>
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
    125b:	e8 08 1a 00 00       	call   2c68 <draw_line>
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
    12a2:	e8 c1 19 00 00       	call   2c68 <draw_line>
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
    12e9:	e8 7a 19 00 00       	call   2c68 <draw_line>
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
    132c:	e8 37 19 00 00       	call   2c68 <draw_line>
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
    1374:	c7 44 24 04 8d b0 00 	movl   $0xb08d,0x4(%esp)
    137b:	00 
    137c:	8d 45 ec             	lea    -0x14(%ebp),%eax
    137f:	89 04 24             	mov    %eax,(%esp)
    1382:	e8 3b 1d 00 00       	call   30c2 <loadBitmap>
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
    13c0:	e8 cd 17 00 00       	call   2b92 <draw_picture>
  	puts_str(context, "PictureViewer", 0, WINDOW_WIDTH/2 - 53, 3);
    13c5:	c7 44 24 18 03 00 00 	movl   $0x3,0x18(%esp)
    13cc:	00 
    13cd:	c7 44 24 14 c5 00 00 	movl   $0xc5,0x14(%esp)
    13d4:	00 
    13d5:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    13dc:	00 
    13dd:	c7 44 24 0c 6a b0 00 	movl   $0xb06a,0xc(%esp)
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
    1404:	e8 65 22 00 00       	call   366e <freepic>
	PICNODE rolling;
    	loadBitmap(&rolling, "rolling.bmp");
    1409:	c7 44 24 04 78 b0 00 	movl   $0xb078,0x4(%esp)
    1410:	00 
    1411:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1414:	89 04 24             	mov    %eax,(%esp)
    1417:	e8 a6 1c 00 00       	call   30c2 <loadBitmap>
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
    1470:	e8 1d 17 00 00       	call   2b92 <draw_picture>
    	freepic(&rolling);
    1475:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1478:	89 04 24             	mov    %eax,(%esp)
    147b:	e8 ee 21 00 00       	call   366e <freepic>

	PICNODE next;
        loadBitmap(&next, "next.bmp");
    1480:	c7 44 24 04 84 b0 00 	movl   $0xb084,0x4(%esp)
    1487:	00 
    1488:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    148b:	89 04 24             	mov    %eax,(%esp)
    148e:	e8 2f 1c 00 00       	call   30c2 <loadBitmap>
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
    14e7:	e8 a6 16 00 00       	call   2b92 <draw_picture>
        freepic(&next);
    14ec:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    14ef:	89 04 24             	mov    %eax,(%esp)
    14f2:	e8 77 21 00 00       	call   366e <freepic>
	
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
    150b:	a1 04 22 01 00       	mov    0x12204,%eax
    1510:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pic_height = pic.height;
    1513:	a1 08 22 01 00       	mov    0x12208,%eax
    1518:	89 45 e8             	mov    %eax,-0x18(%ebp)

    printf(0, "drawPicViewerContent: pic_width: %d, pic_height: %d\n", pic_width, pic_height);
    151b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    151e:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1522:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1525:	89 44 24 08          	mov    %eax,0x8(%esp)
    1529:	c7 44 24 04 98 b0 00 	movl   $0xb098,0x4(%esp)
    1530:	00 
    1531:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1538:	e8 0d 34 00 00       	call   494a <printf>
    draw_picture(context, pic, ((c_width-pic_width) >> 1) + X_shift, TOPBAR_HEIGHT + ((c_height-pic_height) >> 1) + Y_shift);
    153d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1540:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1543:	29 c2                	sub    %eax,%edx
    1545:	89 d0                	mov    %edx,%eax
    1547:	d1 f8                	sar    %eax
    1549:	8d 50 14             	lea    0x14(%eax),%edx
    154c:	a1 f0 f3 00 00       	mov    0xf3f0,%eax
    1551:	01 c2                	add    %eax,%edx
    1553:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1556:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1559:	29 c1                	sub    %eax,%ecx
    155b:	89 c8                	mov    %ecx,%eax
    155d:	d1 f8                	sar    %eax
    155f:	89 c1                	mov    %eax,%ecx
    1561:	a1 ec f3 00 00       	mov    0xf3ec,%eax
    1566:	01 c8                	add    %ecx,%eax
    1568:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    156c:	89 44 24 18          	mov    %eax,0x18(%esp)
    1570:	a1 00 22 01 00       	mov    0x12200,%eax
    1575:	89 44 24 0c          	mov    %eax,0xc(%esp)
    1579:	a1 04 22 01 00       	mov    0x12204,%eax
    157e:	89 44 24 10          	mov    %eax,0x10(%esp)
    1582:	a1 08 22 01 00       	mov    0x12208,%eax
    1587:	89 44 24 14          	mov    %eax,0x14(%esp)
    158b:	8b 45 08             	mov    0x8(%ebp),%eax
    158e:	89 04 24             	mov    %eax,(%esp)
    1591:	8b 45 0c             	mov    0xc(%ebp),%eax
    1594:	89 44 24 04          	mov    %eax,0x4(%esp)
    1598:	8b 45 10             	mov    0x10(%ebp),%eax
    159b:	89 44 24 08          	mov    %eax,0x8(%esp)
    159f:	e8 ee 15 00 00       	call   2b92 <draw_picture>
    startXsave = ((c_width-pic_width) >> 1) + X_shift;
    15a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    15aa:	29 c2                	sub    %eax,%edx
    15ac:	89 d0                	mov    %edx,%eax
    15ae:	d1 f8                	sar    %eax
    15b0:	89 c2                	mov    %eax,%edx
    15b2:	a1 ec f3 00 00       	mov    0xf3ec,%eax
    15b7:	01 d0                	add    %edx,%eax
    15b9:	a3 e4 f3 00 00       	mov    %eax,0xf3e4
    startYsave = TOPBAR_HEIGHT + ((c_height-pic_height) >> 1) + Y_shift;
    15be:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15c1:	8b 55 f0             	mov    -0x10(%ebp),%edx
    15c4:	29 c2                	sub    %eax,%edx
    15c6:	89 d0                	mov    %edx,%eax
    15c8:	d1 f8                	sar    %eax
    15ca:	8d 50 14             	lea    0x14(%eax),%edx
    15cd:	a1 f0 f3 00 00       	mov    0xf3f0,%eax
    15d2:	01 d0                	add    %edx,%eax
    15d4:	a3 e8 f3 00 00       	mov    %eax,0xf3e8
}
    15d9:	c9                   	leave  
    15da:	c3                   	ret    

000015db <drawPicViewerContentForProper>:

void drawPicViewerContentForProper(Context context, char* fileName) {
    15db:	55                   	push   %ebp
    15dc:	89 e5                	mov    %esp,%ebp
    15de:	83 ec 28             	sub    $0x28,%esp
    
    draw_picture(context, pic, startXsave, startYsave);
    15e1:	8b 15 e8 f3 00 00    	mov    0xf3e8,%edx
    15e7:	a1 e4 f3 00 00       	mov    0xf3e4,%eax
    15ec:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    15f0:	89 44 24 18          	mov    %eax,0x18(%esp)
    15f4:	a1 00 22 01 00       	mov    0x12200,%eax
    15f9:	89 44 24 0c          	mov    %eax,0xc(%esp)
    15fd:	a1 04 22 01 00       	mov    0x12204,%eax
    1602:	89 44 24 10          	mov    %eax,0x10(%esp)
    1606:	a1 08 22 01 00       	mov    0x12208,%eax
    160b:	89 44 24 14          	mov    %eax,0x14(%esp)
    160f:	8b 45 08             	mov    0x8(%ebp),%eax
    1612:	89 04 24             	mov    %eax,(%esp)
    1615:	8b 45 0c             	mov    0xc(%ebp),%eax
    1618:	89 44 24 04          	mov    %eax,0x4(%esp)
    161c:	8b 45 10             	mov    0x10(%ebp),%eax
    161f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1623:	e8 6a 15 00 00       	call   2b92 <draw_picture>
}
    1628:	c9                   	leave  
    1629:	c3                   	ret    

0000162a <h_closeWnd>:

void h_closeWnd(Point p) {
    162a:	55                   	push   %ebp
    162b:	89 e5                	mov    %esp,%ebp
    isRun = 0;
    162d:	c7 05 d8 ee 00 00 00 	movl   $0x0,0xeed8
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
    1658:	8b 1c 85 d4 ee 00 00 	mov    0xeed4(,%eax,4),%ebx
    165f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1662:	6b c0 34             	imul   $0x34,%eax,%eax
    1665:	05 c0 ee 00 00       	add    $0xeec0,%eax
    166a:	8b 78 10             	mov    0x10(%eax),%edi
    166d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1670:	6b c0 34             	imul   $0x34,%eax,%eax
    1673:	05 c0 ee 00 00       	add    $0xeec0,%eax
    1678:	8b 70 0c             	mov    0xc(%eax),%esi
    167b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    167e:	6b c0 34             	imul   $0x34,%eax,%eax
    1681:	05 c0 ee 00 00       	add    $0xeec0,%eax
    1686:	8b 48 04             	mov    0x4(%eax),%ecx
    1689:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    168c:	6b c0 34             	imul   $0x34,%eax,%eax
    168f:	05 c0 ee 00 00       	add    $0xeec0,%eax
    1694:	8b 10                	mov    (%eax),%edx
    1696:	8d 45 d0             	lea    -0x30(%ebp),%eax
    1699:	89 7c 24 10          	mov    %edi,0x10(%esp)
    169d:	89 74 24 0c          	mov    %esi,0xc(%esp)
    16a1:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    16a5:	89 54 24 04          	mov    %edx,0x4(%esp)
    16a9:	89 04 24             	mov    %eax,(%esp)
    16ac:	e8 8c 22 00 00       	call   393d <initRect>
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
    16e2:	e8 42 23 00 00       	call   3a29 <createClickable>

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
    1714:	c7 44 24 04 d0 b0 00 	movl   $0xb0d0,0x4(%esp)
    171b:	00 
    171c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1723:	e8 22 32 00 00       	call   494a <printf>
	printf(0, "Right Clicked: pic.width:%d, pic.height:%d\n",pic.width,pic.height);
    1728:	8b 15 08 22 01 00    	mov    0x12208,%edx
    172e:	a1 04 22 01 00       	mov    0x12204,%eax
    1733:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1737:	89 44 24 08          	mov    %eax,0x8(%esp)
    173b:	c7 44 24 04 f0 b0 00 	movl   $0xb0f0,0x4(%esp)
    1742:	00 
    1743:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    174a:	e8 fb 31 00 00       	call   494a <printf>
	//int lengthX = 100;
	//int lengthY = 200;
	int width = pic.width;
    174f:	a1 04 22 01 00       	mov    0x12204,%eax
    1754:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int height = pic.height;
    1757:	a1 08 22 01 00       	mov    0x12208,%eax
    175c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	
	char*strw = (char*)malloc(10*sizeof(char));
    175f:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    1766:	e8 cb 34 00 00       	call   4c36 <malloc>
    176b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	char*strh = (char*)malloc(10*sizeof(char));
    176e:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    1775:	e8 bc 34 00 00       	call   4c36 <malloc>
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
    1804:	e8 2d 34 00 00       	call   4c36 <malloc>
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
    1865:	e8 93 32 00 00       	call   4afd <free>
	
	printf(0,"In itoa w:");
    186a:	c7 44 24 04 1c b1 00 	movl   $0xb11c,0x4(%esp)
    1871:	00 
    1872:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1879:	e8 cc 30 00 00       	call   494a <printf>
	printf(0,strwt);
    187e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1881:	89 44 24 04          	mov    %eax,0x4(%esp)
    1885:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    188c:	e8 b9 30 00 00       	call   494a <printf>
	printf(0,"\n");
    1891:	c7 44 24 04 27 b1 00 	movl   $0xb127,0x4(%esp)
    1898:	00 
    1899:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    18a0:	e8 a5 30 00 00       	call   494a <printf>

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
    192c:	e8 05 33 00 00       	call   4c36 <malloc>
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
    198d:	e8 6b 31 00 00       	call   4afd <free>
	
	printf(0,"In itoa h:");
    1992:	c7 44 24 04 29 b1 00 	movl   $0xb129,0x4(%esp)
    1999:	00 
    199a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19a1:	e8 a4 2f 00 00       	call   494a <printf>
	printf(0,strht);
    19a6:	8b 45 c0             	mov    -0x40(%ebp),%eax
    19a9:	89 44 24 04          	mov    %eax,0x4(%esp)
    19ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19b4:	e8 91 2f 00 00       	call   494a <printf>
	printf(0,"\n");
    19b9:	c7 44 24 04 27 b1 00 	movl   $0xb127,0x4(%esp)
    19c0:	00 
    19c1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    19c8:	e8 7d 2f 00 00       	call   494a <printf>

	
	puts_str(context, "Width:", 0, startX+10, startY+10);
    19cd:	8b 45 18             	mov    0x18(%ebp),%eax
    19d0:	8d 50 0a             	lea    0xa(%eax),%edx
    19d3:	8b 45 14             	mov    0x14(%ebp),%eax
    19d6:	83 c0 0a             	add    $0xa,%eax
    19d9:	89 54 24 18          	mov    %edx,0x18(%esp)
    19dd:	89 44 24 14          	mov    %eax,0x14(%esp)
    19e1:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    19e8:	00 
    19e9:	c7 44 24 0c 34 b1 00 	movl   $0xb134,0xc(%esp)
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
    1a62:	c7 44 24 0c 3b b1 00 	movl   $0xb13b,0xc(%esp)
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
    1b01:	e8 c2 2b 00 00       	call   46c8 <atoi>
    1b06:	a3 b0 23 01 00       	mov    %eax,0x123b0
    pos = atoi(argv[3]) - 1;
    1b0b:	8b 43 04             	mov    0x4(%ebx),%eax
    1b0e:	83 c0 0c             	add    $0xc,%eax
    1b11:	8b 00                	mov    (%eax),%eax
    1b13:	89 04 24             	mov    %eax,(%esp)
    1b16:	e8 ad 2b 00 00       	call   46c8 <atoi>
    1b1b:	83 e8 01             	sub    $0x1,%eax
    1b1e:	a3 0c 22 01 00       	mov    %eax,0x1220c
printf(0,"%d",pos);
    1b23:	a1 0c 22 01 00       	mov    0x1220c,%eax
    1b28:	89 44 24 08          	mov    %eax,0x8(%esp)
    1b2c:	c7 44 24 04 43 b1 00 	movl   $0xb143,0x4(%esp)
    1b33:	00 
    1b34:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b3b:	e8 0a 2e 00 00       	call   494a <printf>
printf(0,"   %d   ",len);
    1b40:	a1 b0 23 01 00       	mov    0x123b0,%eax
    1b45:	89 44 24 08          	mov    %eax,0x8(%esp)
    1b49:	c7 44 24 04 46 b1 00 	movl   $0xb146,0x4(%esp)
    1b50:	00 
    1b51:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1b58:	e8 ed 2d 00 00       	call   494a <printf>
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
    1ba3:	e8 8e 30 00 00       	call   4c36 <malloc>
    1ba8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    1bab:	89 04 95 20 22 01 00 	mov    %eax,0x12220(,%edx,4)
	    for(k = 0;k < (i-end);k++)
    1bb2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    1bb9:	eb 2d                	jmp    1be8 <main+0x10a>
		file[j][k] = argv[2][end+1+k];
    1bbb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1bbe:	8b 14 85 20 22 01 00 	mov    0x12220(,%eax,4),%edx
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
    1bfa:	8b 04 85 20 22 01 00 	mov    0x12220(,%eax,4),%eax
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
    1c1a:	a1 b0 23 01 00       	mov    0x123b0,%eax
    1c1f:	83 c0 03             	add    $0x3,%eax
    1c22:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    1c25:	0f 8d 53 ff ff ff    	jge    1b7e <main+0xa0>
	    
	}
	i++;
    }

	len = j;
    1c2b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1c2e:	a3 b0 23 01 00       	mov    %eax,0x123b0
	
	



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
    1c6f:	e8 67 1d 00 00       	call   39db <initClickManager>
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
    1ca4:	a1 0c 22 01 00       	mov    0x1220c,%eax
    1ca9:	8b 04 85 20 22 01 00 	mov    0x12220(,%eax,4),%eax
    1cb0:	89 44 24 04          	mov    %eax,0x4(%esp)
    1cb4:	c7 04 24 00 22 01 00 	movl   $0x12200,(%esp)
    1cbb:	e8 02 14 00 00       	call   30c2 <loadBitmap>
    load_iconlist(wndRes, sizeof(wndRes) / sizeof(ICON));//载入图标数组
    1cc0:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1cc7:	00 
    1cc8:	c7 04 24 a0 ee 00 00 	movl   $0xeea0,(%esp)
    1ccf:	e8 2d 13 00 00       	call   3001 <load_iconlist>

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
    1d13:	e8 25 1c 00 00       	call   393d <initRect>
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
    1d3d:	e8 25 1e 00 00       	call   3b67 <deleteClickable>
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
    1d74:	e8 81 2a 00 00       	call   47fa <getMsg>
        switch (msg.msg_type) {//判断消息类型
    1d79:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
    1d7f:	83 f8 08             	cmp    $0x8,%eax
    1d82:	0f 87 20 05 00 00    	ja     22a8 <main+0x7ca>
    1d88:	8b 04 85 ac b1 00 00 	mov    0xb1ac(,%eax,4),%eax
    1d8f:	ff e0                	jmp    *%eax
		case MSG_DOUBLECLICK://双击消息
			p = initPoint(msg.concrete_msg.msg_mouse.x,msg.concrete_msg.msg_mouse.y);//获取到鼠标现在的点
    1d91:	8b 8d 74 ff ff ff    	mov    -0x8c(%ebp),%ecx
    1d97:	8b 95 70 ff ff ff    	mov    -0x90(%ebp),%edx
    1d9d:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
    1da3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1da7:	89 54 24 04          	mov    %edx,0x4(%esp)
    1dab:	89 04 24             	mov    %eax,(%esp)
    1dae:	e8 63 1b 00 00       	call   3916 <initPoint>
    1db3:	83 ec 04             	sub    $0x4,%esp
			if (executeHandler(cm.double_click, p))//（暂时不懂）
    1db6:	8b 4d 88             	mov    -0x78(%ebp),%ecx
    1db9:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    1dbf:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
    1dc5:	89 44 24 04          	mov    %eax,0x4(%esp)
    1dc9:	89 54 24 08          	mov    %edx,0x8(%esp)
    1dcd:	89 0c 24             	mov    %ecx,(%esp)
    1dd0:	e8 72 1e 00 00       	call   3c47 <executeHandler>
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
    1df0:	e8 1d 2a 00 00       	call   4812 <updateWindow>
			}
            		printf(0,"DoubleClick: context_width: %d, context_height: %d\n", context.width, context.height);
    1df5:	8b 55 a0             	mov    -0x60(%ebp),%edx
    1df8:	8b 45 9c             	mov    -0x64(%ebp),%eax
    1dfb:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1dff:	89 44 24 08          	mov    %eax,0x8(%esp)
    1e03:	c7 44 24 04 50 b1 00 	movl   $0xb150,0x4(%esp)
    1e0a:	00 
    1e0b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1e12:	e8 33 2b 00 00       	call   494a <printf>
			printf(0,"DoubleClick: mouseX: %d, mouseY: %d\n", p.x, p.y);
    1e17:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
    1e1d:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    1e23:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1e27:	89 44 24 08          	mov    %eax,0x8(%esp)
    1e2b:	c7 44 24 04 84 b1 00 	movl   $0xb184,0x4(%esp)
    1e32:	00 
    1e33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1e3a:	e8 0b 2b 00 00       	call   494a <printf>
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
    1e83:	e8 8a 29 00 00       	call   4812 <updateWindow>
                
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
    1ea6:	a1 0c 22 01 00       	mov    0x1220c,%eax
    1eab:	8b 04 85 20 22 01 00 	mov    0x12220(,%eax,4),%eax
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
    1ee6:	e8 27 29 00 00       	call   4812 <updateWindow>
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
    1f25:	e8 f0 28 00 00       	call   481a <updatePartialWindow>
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
    1f4c:	e8 c5 19 00 00       	call   3916 <initPoint>
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
    2045:	e8 c8 27 00 00       	call   4812 <updateWindow>

			if (executeHandler(cm.left_click, p)) {//（暂时不懂）
    204a:	8b 4d 84             	mov    -0x7c(%ebp),%ecx
    204d:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    2053:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
    2059:	89 44 24 04          	mov    %eax,0x4(%esp)
    205d:	89 54 24 08          	mov    %edx,0x8(%esp)
    2061:	89 0c 24             	mov    %ecx,(%esp)
    2064:	e8 de 1b 00 00       	call   3c47 <executeHandler>
    2069:	85 c0                	test   %eax,%eax
    206b:	74 21                	je     208e <main+0x5b0>

				updateWindow(winid, context.addr, msg.msg_detail);
    206d:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
    2073:	8b 45 98             	mov    -0x68(%ebp),%eax
    2076:	89 54 24 08          	mov    %edx,0x8(%esp)
    207a:	89 44 24 04          	mov    %eax,0x4(%esp)
    207e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2081:	89 04 24             	mov    %eax,(%esp)
    2084:	e8 89 27 00 00       	call   4812 <updateWindow>
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
    20b0:	e8 61 18 00 00       	call   3916 <initPoint>
    20b5:	83 ec 04             	sub    $0x4,%esp
    20b8:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
    20be:	8b 95 34 ff ff ff    	mov    -0xcc(%ebp),%edx
    20c4:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
    20ca:	89 95 64 ff ff ff    	mov    %edx,-0x9c(%ebp)
					msg.concrete_msg.msg_mouse.y);
			if(isShowing == 0)
    20d0:	a1 e0 f3 00 00       	mov    0xf3e0,%eax
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
    2106:	c7 05 e0 f3 00 00 01 	movl   $0x1,0xf3e0
    210d:	00 00 00 
    2110:	eb 56                	jmp    2168 <main+0x68a>
			}
			else if(isShowing == 1)
    2112:	a1 e0 f3 00 00       	mov    0xf3e0,%eax
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
    2135:	a1 0c 22 01 00       	mov    0x1220c,%eax
    213a:	8b 04 85 20 22 01 00 	mov    0x12220(,%eax,4),%eax
    2141:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2145:	8b 45 98             	mov    -0x68(%ebp),%eax
    2148:	89 04 24             	mov    %eax,(%esp)
    214b:	8b 45 9c             	mov    -0x64(%ebp),%eax
    214e:	89 44 24 04          	mov    %eax,0x4(%esp)
    2152:	8b 45 a0             	mov    -0x60(%ebp),%eax
    2155:	89 44 24 08          	mov    %eax,0x8(%esp)
    2159:	e8 7d f4 ff ff       	call   15db <drawPicViewerContentForProper>
				isShowing = 0;
    215e:	c7 05 e0 f3 00 00 00 	movl   $0x0,0xf3e0
    2165:	00 00 00 
			}
			updateWindow(winid, context.addr, msg.msg_detail);//更新窗口
    2168:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
    216e:	8b 45 98             	mov    -0x68(%ebp),%eax
    2171:	89 54 24 08          	mov    %edx,0x8(%esp)
    2175:	89 44 24 04          	mov    %eax,0x4(%esp)
    2179:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    217c:	89 04 24             	mov    %eax,(%esp)
    217f:	e8 8e 26 00 00       	call   4812 <updateWindow>
			if (executeHandler(cm.right_click, p)) {
    2184:	8b 4d 8c             	mov    -0x74(%ebp),%ecx
    2187:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
    218d:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
    2193:	89 44 24 04          	mov    %eax,0x4(%esp)
    2197:	89 54 24 08          	mov    %edx,0x8(%esp)
    219b:	89 0c 24             	mov    %ecx,(%esp)
    219e:	e8 a4 1a 00 00       	call   3c47 <executeHandler>
    21a3:	85 c0                	test   %eax,%eax
    21a5:	74 21                	je     21c8 <main+0x6ea>
				updateWindow(winid, context.addr, msg.msg_detail);
    21a7:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
    21ad:	8b 45 98             	mov    -0x68(%ebp),%eax
    21b0:	89 54 24 08          	mov    %edx,0x8(%esp)
    21b4:	89 44 24 04          	mov    %eax,0x4(%esp)
    21b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    21bb:	89 04 24             	mov    %eax,(%esp)
    21be:	e8 4f 26 00 00       	call   4812 <updateWindow>
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
    21f4:	a1 ec f3 00 00       	mov    0xf3ec,%eax
    21f9:	83 e8 05             	sub    $0x5,%eax
    21fc:	a3 ec f3 00 00       	mov    %eax,0xf3ec
					break;
    2201:	eb 2c                	jmp    222f <main+0x751>
				case 54:
					X_shift += shift_at_once;
    2203:	a1 ec f3 00 00       	mov    0xf3ec,%eax
    2208:	83 c0 05             	add    $0x5,%eax
    220b:	a3 ec f3 00 00       	mov    %eax,0xf3ec
					break;
    2210:	eb 1d                	jmp    222f <main+0x751>
				case 56:
					Y_shift -= shift_at_once;
    2212:	a1 f0 f3 00 00       	mov    0xf3f0,%eax
    2217:	83 e8 05             	sub    $0x5,%eax
    221a:	a3 f0 f3 00 00       	mov    %eax,0xf3f0
					break;
    221f:	eb 0e                	jmp    222f <main+0x751>
				case 50:
					Y_shift += shift_at_once;
    2221:	a1 f0 f3 00 00       	mov    0xf3f0,%eax
    2226:	83 c0 05             	add    $0x5,%eax
    2229:	a3 f0 f3 00 00       	mov    %eax,0xf3f0
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
    2248:	a1 0c 22 01 00       	mov    0x1220c,%eax
    224d:	8b 04 85 20 22 01 00 	mov    0x12220(,%eax,4),%eax
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
    22a1:	e8 6c 25 00 00       	call   4812 <updateWindow>
			break;
    22a6:	eb 01                	jmp    22a9 <main+0x7cb>
		default:
			break;
    22a8:	90                   	nop
    deleteClickable(&cm.left_click, initRect(0, 0, 800, 600));
    addWndEvent(&cm);//添加cm到窗口事件

    Initialize(context);

    while (isRun) {
    22a9:	a1 d8 ee 00 00       	mov    0xeed8,%eax
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
    22c8:	e8 8d 24 00 00       	call   475a <exit>

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
    22f3:	e8 3e 29 00 00       	call   4c36 <malloc>
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
    231d:	e8 8b 22 00 00       	call   45ad <memset>
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
    2349:	e8 b4 24 00 00       	call   4802 <createWindow>
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
    235e:	e8 9a 27 00 00       	call   4afd <free>
    freeASCII();
    2363:	e8 00 04 00 00       	call   2768 <freeASCII>
    freeGBK();
    2368:	e8 b8 04 00 00       	call   2825 <freeGBK>
    destroyWindow(winid);
    236d:	8b 45 0c             	mov    0xc(%ebp),%eax
    2370:	89 04 24             	mov    %eax,(%esp)
    2373:	e8 92 24 00 00       	call   480a <destroyWindow>
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
    252e:	e8 23 06 00 00       	call   2b56 <_RGB16BIT565>
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
    25aa:	c7 44 24 04 d0 b1 00 	movl   $0xb1d0,0x4(%esp)
    25b1:	00 
    25b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25b9:	e8 8c 23 00 00       	call   494a <printf>
    25be:	eb 14                	jmp    25d4 <printBinary+0x55>
		}
		else
		{
			printf(0, "0");
    25c0:	c7 44 24 04 d2 b1 00 	movl   $0xb1d2,0x4(%esp)
    25c7:	00 
    25c8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25cf:	e8 76 23 00 00       	call   494a <printf>
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
    25de:	c7 44 24 04 d4 b1 00 	movl   $0xb1d4,0x4(%esp)
    25e5:	00 
    25e6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    25ed:	e8 58 23 00 00       	call   494a <printf>
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
    25fc:	c7 44 24 04 d6 b1 00 	movl   $0xb1d6,0x4(%esp)
    2603:	00 
    2604:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    260b:	e8 3a 23 00 00       	call   494a <printf>
	//打开hankaku.txt文件
	if((fd = open(HANKAKU, 0)) < 0){
    2610:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2617:	00 
    2618:	c7 04 24 e9 b1 00 00 	movl   $0xb1e9,(%esp)
    261f:	e8 76 21 00 00       	call   479a <open>
    2624:	89 45 e8             	mov    %eax,-0x18(%ebp)
    2627:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    262b:	79 21                	jns    264e <initializeASCII+0x5a>
	  printf(0,"cannot open %s\n", HANKAKU);
    262d:	c7 44 24 08 e9 b1 00 	movl   $0xb1e9,0x8(%esp)
    2634:	00 
    2635:	c7 44 24 04 f5 b1 00 	movl   $0xb1f5,0x4(%esp)
    263c:	00 
    263d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2644:	e8 01 23 00 00       	call   494a <printf>
	  return;
    2649:	e9 13 01 00 00       	jmp    2761 <initializeASCII+0x16d>
	}
	//申请hankaku数组
	hankaku = malloc(ASCII_NUM*ASCII_HEIGHT);
    264e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2655:	e8 dc 25 00 00       	call   4c36 <malloc>
    265a:	a3 c0 23 01 00       	mov    %eax,0x123c0
	for (i = 0; i < ASCII_NUM; i++)
    265f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2666:	eb 12                	jmp    267a <initializeASCII+0x86>
	{
		hankaku[i] = 0;
    2668:	8b 15 c0 23 01 00    	mov    0x123c0,%edx
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
    26a2:	05 e0 23 01 00       	add    $0x123e0,%eax
    26a7:	0f b6 00             	movzbl (%eax),%eax
    26aa:	3c 2a                	cmp    $0x2a,%al
    26ac:	74 0f                	je     26bd <initializeASCII+0xc9>
    26ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26b1:	05 e0 23 01 00       	add    $0x123e0,%eax
    26b6:	0f b6 00             	movzbl (%eax),%eax
    26b9:	3c 2e                	cmp    $0x2e,%al
    26bb:	75 51                	jne    270e <initializeASCII+0x11a>
			{
				if (buf[i] == '*')
    26bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26c0:	05 e0 23 01 00       	add    $0x123e0,%eax
    26c5:	0f b6 00             	movzbl (%eax),%eax
    26c8:	3c 2a                	cmp    $0x2a,%al
    26ca:	75 2d                	jne    26f9 <initializeASCII+0x105>
				{
					hankaku[y] |= (0x80 >> x);
    26cc:	8b 15 c0 23 01 00    	mov    0x123c0,%edx
    26d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    26d5:	01 c2                	add    %eax,%edx
    26d7:	8b 0d c0 23 01 00    	mov    0x123c0,%ecx
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
    2722:	c7 44 24 04 e0 23 01 	movl   $0x123e0,0x4(%esp)
    2729:	00 
    272a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    272d:	89 04 24             	mov    %eax,(%esp)
    2730:	e8 3d 20 00 00       	call   4772 <read>
    2735:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    2738:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    273c:	0f 8f 54 ff ff ff    	jg     2696 <initializeASCII+0xa2>

//	for (i = 0; i < ASCII_NUM * ASCII_HEIGHT; i++)
//	{
//		printBinary(hankaku[i]);
//	}
	printf(0,"initialzing ASCII complete!\n");
    2742:	c7 44 24 04 05 b2 00 	movl   $0xb205,0x4(%esp)
    2749:	00 
    274a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2751:	e8 f4 21 00 00       	call   494a <printf>
	close(fd);
    2756:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2759:	89 04 24             	mov    %eax,(%esp)
    275c:	e8 21 20 00 00       	call   4782 <close>
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
    276e:	a1 c0 23 01 00       	mov    0x123c0,%eax
    2773:	89 04 24             	mov    %eax,(%esp)
    2776:	e8 82 23 00 00       	call   4afd <free>
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
    2783:	c7 44 24 04 22 b2 00 	movl   $0xb222,0x4(%esp)
    278a:	00 
    278b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2792:	e8 b3 21 00 00       	call   494a <printf>
	if((fd = open(HZK16, 0)) < 0){
    2797:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    279e:	00 
    279f:	c7 04 24 33 b2 00 00 	movl   $0xb233,(%esp)
    27a6:	e8 ef 1f 00 00       	call   479a <open>
    27ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
    27ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    27b2:	79 1e                	jns    27d2 <initializeGBK+0x55>
		printf(0,"cannot open %s\n", HZK16);
    27b4:	c7 44 24 08 33 b2 00 	movl   $0xb233,0x8(%esp)
    27bb:	00 
    27bc:	c7 44 24 04 f5 b1 00 	movl   $0xb1f5,0x4(%esp)
    27c3:	00 
    27c4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    27cb:	e8 7a 21 00 00       	call   494a <printf>
		return;
    27d0:	eb 51                	jmp    2823 <initializeGBK+0xa6>
	}
	fontFile.buf = malloc(27000*sizeof(unsigned char));
    27d2:	c7 04 24 78 69 00 00 	movl   $0x6978,(%esp)
    27d9:	e8 58 24 00 00       	call   4c36 <malloc>
    27de:	a3 c4 23 01 00       	mov    %eax,0x123c4
	fontFile.size = read(fd, fontFile.buf, 27000);
    27e3:	a1 c4 23 01 00       	mov    0x123c4,%eax
    27e8:	c7 44 24 08 78 69 00 	movl   $0x6978,0x8(%esp)
    27ef:	00 
    27f0:	89 44 24 04          	mov    %eax,0x4(%esp)
    27f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    27f7:	89 04 24             	mov    %eax,(%esp)
    27fa:	e8 73 1f 00 00       	call   4772 <read>
    27ff:	a3 c8 23 01 00       	mov    %eax,0x123c8
	printf(0,"initialzing gbk complete!\n");
    2804:	c7 44 24 04 3d b2 00 	movl   $0xb23d,0x4(%esp)
    280b:	00 
    280c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2813:	e8 32 21 00 00       	call   494a <printf>
	close(fd);
    2818:	8b 45 f4             	mov    -0xc(%ebp),%eax
    281b:	89 04 24             	mov    %eax,(%esp)
    281e:	e8 5f 1f 00 00       	call   4782 <close>
}
    2823:	c9                   	leave  
    2824:	c3                   	ret    

00002825 <freeGBK>:

void freeGBK(){
    2825:	55                   	push   %ebp
    2826:	89 e5                	mov    %esp,%ebp
    2828:	83 ec 18             	sub    $0x18,%esp
	free(fontFile.buf);
    282b:	a1 c4 23 01 00       	mov    0x123c4,%eax
    2830:	89 04 24             	mov    %eax,(%esp)
    2833:	e8 c5 22 00 00       	call   4afd <free>
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
    285f:	a1 c0 23 01 00       	mov    0x123c0,%eax
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
    2928:	a1 c4 23 01 00       	mov    0x123c4,%eax
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
    2aec:	e8 95 1a 00 00       	call   4586 <strlen>
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

00002b56 <_RGB16BIT565>:

int _RGB16BIT565(int r,int g,int b){
    2b56:	55                   	push   %ebp
    2b57:	89 e5                	mov    %esp,%ebp
	return ((b / 8)+((g / 4)<<5)+((r / 8)<<11));
    2b59:	8b 45 10             	mov    0x10(%ebp),%eax
    2b5c:	8d 50 07             	lea    0x7(%eax),%edx
    2b5f:	85 c0                	test   %eax,%eax
    2b61:	0f 48 c2             	cmovs  %edx,%eax
    2b64:	c1 f8 03             	sar    $0x3,%eax
    2b67:	89 c2                	mov    %eax,%edx
    2b69:	8b 45 0c             	mov    0xc(%ebp),%eax
    2b6c:	8d 48 03             	lea    0x3(%eax),%ecx
    2b6f:	85 c0                	test   %eax,%eax
    2b71:	0f 48 c1             	cmovs  %ecx,%eax
    2b74:	c1 f8 02             	sar    $0x2,%eax
    2b77:	c1 e0 05             	shl    $0x5,%eax
    2b7a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    2b7d:	8b 45 08             	mov    0x8(%ebp),%eax
    2b80:	8d 50 07             	lea    0x7(%eax),%edx
    2b83:	85 c0                	test   %eax,%eax
    2b85:	0f 48 c2             	cmovs  %edx,%eax
    2b88:	c1 f8 03             	sar    $0x3,%eax
    2b8b:	c1 e0 0b             	shl    $0xb,%eax
    2b8e:	01 c8                	add    %ecx,%eax
}
    2b90:	5d                   	pop    %ebp
    2b91:	c3                   	ret    

00002b92 <draw_picture>:

void draw_picture(Context c, PICNODE pic, int x, int y)
{
    2b92:	55                   	push   %ebp
    2b93:	89 e5                	mov    %esp,%ebp
    2b95:	53                   	push   %ebx
    2b96:	83 ec 28             	sub    $0x28,%esp
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
    2b99:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    2ba0:	e9 b1 00 00 00       	jmp    2c56 <draw_picture+0xc4>
	{
		for (j = 0; j < pic.width; j++)
    2ba5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2bac:	e9 95 00 00 00       	jmp    2c46 <draw_picture+0xb4>
		{
			rgb = pic.data[i*pic.width+j];
    2bb1:	8b 55 14             	mov    0x14(%ebp),%edx
    2bb4:	8b 45 18             	mov    0x18(%ebp),%eax
    2bb7:	0f af 45 f8          	imul   -0x8(%ebp),%eax
    2bbb:	89 c1                	mov    %eax,%ecx
    2bbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2bc0:	01 c8                	add    %ecx,%eax
    2bc2:	c1 e0 02             	shl    $0x2,%eax
    2bc5:	01 d0                	add    %edx,%eax
    2bc7:	8b 00                	mov    (%eax),%eax
    2bc9:	89 45 ee             	mov    %eax,-0x12(%ebp)
			if (rgb.rgbReserved == 1) continue;
    2bcc:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
    2bd0:	3c 01                	cmp    $0x1,%al
    2bd2:	75 02                	jne    2bd6 <draw_picture+0x44>
    2bd4:	eb 6c                	jmp    2c42 <draw_picture+0xb0>
			color = (unsigned short)_RGB16BIT565(rgb.rgbRed, rgb.rgbGreen, rgb.rgbBlue);
    2bd6:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
    2bda:	0f b6 c8             	movzbl %al,%ecx
    2bdd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    2be1:	0f b6 d0             	movzbl %al,%edx
    2be4:	0f b6 45 f0          	movzbl -0x10(%ebp),%eax
    2be8:	0f b6 c0             	movzbl %al,%eax
    2beb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    2bef:	89 54 24 04          	mov    %edx,0x4(%esp)
    2bf3:	89 04 24             	mov    %eax,(%esp)
    2bf6:	e8 5b ff ff ff       	call   2b56 <_RGB16BIT565>
    2bfb:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
			draw_point(c, j + x, pic.height - 1 - i + y, color);
    2bff:	0f b7 4d f2          	movzwl -0xe(%ebp),%ecx
    2c03:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2c06:	83 e8 01             	sub    $0x1,%eax
    2c09:	2b 45 f8             	sub    -0x8(%ebp),%eax
    2c0c:	89 c2                	mov    %eax,%edx
    2c0e:	8b 45 24             	mov    0x24(%ebp),%eax
    2c11:	01 d0                	add    %edx,%eax
    2c13:	89 c2                	mov    %eax,%edx
    2c15:	8b 45 20             	mov    0x20(%ebp),%eax
    2c18:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    2c1b:	01 d8                	add    %ebx,%eax
    2c1d:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2c21:	89 54 24 10          	mov    %edx,0x10(%esp)
    2c25:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2c29:	8b 45 08             	mov    0x8(%ebp),%eax
    2c2c:	89 04 24             	mov    %eax,(%esp)
    2c2f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2c32:	89 44 24 04          	mov    %eax,0x4(%esp)
    2c36:	8b 45 10             	mov    0x10(%ebp),%eax
    2c39:	89 44 24 08          	mov    %eax,0x8(%esp)
    2c3d:	e8 38 f7 ff ff       	call   237a <draw_point>
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
	{
		for (j = 0; j < pic.width; j++)
    2c42:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2c46:	8b 45 18             	mov    0x18(%ebp),%eax
    2c49:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2c4c:	0f 8f 5f ff ff ff    	jg     2bb1 <draw_picture+0x1f>
void draw_picture(Context c, PICNODE pic, int x, int y)
{
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
    2c52:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    2c56:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2c59:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2c5c:	0f 8f 43 ff ff ff    	jg     2ba5 <draw_picture+0x13>
			if (rgb.rgbReserved == 1) continue;
			color = (unsigned short)_RGB16BIT565(rgb.rgbRed, rgb.rgbGreen, rgb.rgbBlue);
			draw_point(c, j + x, pic.height - 1 - i + y, color);
		}
	}
}
    2c62:	83 c4 28             	add    $0x28,%esp
    2c65:	5b                   	pop    %ebx
    2c66:	5d                   	pop    %ebp
    2c67:	c3                   	ret    

00002c68 <draw_line>:

void draw_line(Context c, int x0, int y0, int x1, int y1, unsigned short color)
{
    2c68:	55                   	push   %ebp
    2c69:	89 e5                	mov    %esp,%ebp
    2c6b:	83 ec 3c             	sub    $0x3c,%esp
    2c6e:	8b 45 24             	mov    0x24(%ebp),%eax
    2c71:	66 89 45 dc          	mov    %ax,-0x24(%ebp)
	int dx, dy, x, y, len, i;
	dx = x1 - x0;
    2c75:	8b 45 14             	mov    0x14(%ebp),%eax
    2c78:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2c7b:	29 c2                	sub    %eax,%edx
    2c7d:	89 d0                	mov    %edx,%eax
    2c7f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	dy = y1 - y0;
    2c82:	8b 45 18             	mov    0x18(%ebp),%eax
    2c85:	8b 55 20             	mov    0x20(%ebp),%edx
    2c88:	29 c2                	sub    %eax,%edx
    2c8a:	89 d0                	mov    %edx,%eax
    2c8c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	x = x0 << 10;
    2c8f:	8b 45 14             	mov    0x14(%ebp),%eax
    2c92:	c1 e0 0a             	shl    $0xa,%eax
    2c95:	89 45 f4             	mov    %eax,-0xc(%ebp)
	y = y0 << 10;
    2c98:	8b 45 18             	mov    0x18(%ebp),%eax
    2c9b:	c1 e0 0a             	shl    $0xa,%eax
    2c9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	dx = (dx < 0) ? -dx : dx;
    2ca1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2ca4:	c1 f8 1f             	sar    $0x1f,%eax
    2ca7:	31 45 fc             	xor    %eax,-0x4(%ebp)
    2caa:	29 45 fc             	sub    %eax,-0x4(%ebp)
	dy = (dy < 0) ? -dy : dy;
    2cad:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2cb0:	c1 f8 1f             	sar    $0x1f,%eax
    2cb3:	31 45 f8             	xor    %eax,-0x8(%ebp)
    2cb6:	29 45 f8             	sub    %eax,-0x8(%ebp)
	if(dx >= dy) {
    2cb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2cbc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2cbf:	7c 57                	jl     2d18 <draw_line+0xb0>
		len = dx + 1;
    2cc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2cc4:	83 c0 01             	add    $0x1,%eax
    2cc7:	89 45 ec             	mov    %eax,-0x14(%ebp)
		dx = (x1 > x0) ? 1024 : -1024;
    2cca:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2ccd:	3b 45 14             	cmp    0x14(%ebp),%eax
    2cd0:	7e 07                	jle    2cd9 <draw_line+0x71>
    2cd2:	b8 00 04 00 00       	mov    $0x400,%eax
    2cd7:	eb 05                	jmp    2cde <draw_line+0x76>
    2cd9:	b8 00 fc ff ff       	mov    $0xfffffc00,%eax
    2cde:	89 45 fc             	mov    %eax,-0x4(%ebp)
		dy = (y1 >= y0) ? (((y1 - y0 + 1) << 10) / len) : (((y1 - y0 - 1) << 10) / len);
    2ce1:	8b 45 20             	mov    0x20(%ebp),%eax
    2ce4:	3b 45 18             	cmp    0x18(%ebp),%eax
    2ce7:	7c 16                	jl     2cff <draw_line+0x97>
    2ce9:	8b 45 18             	mov    0x18(%ebp),%eax
    2cec:	8b 55 20             	mov    0x20(%ebp),%edx
    2cef:	29 c2                	sub    %eax,%edx
    2cf1:	89 d0                	mov    %edx,%eax
    2cf3:	83 c0 01             	add    $0x1,%eax
    2cf6:	c1 e0 0a             	shl    $0xa,%eax
    2cf9:	99                   	cltd   
    2cfa:	f7 7d ec             	idivl  -0x14(%ebp)
    2cfd:	eb 14                	jmp    2d13 <draw_line+0xab>
    2cff:	8b 45 18             	mov    0x18(%ebp),%eax
    2d02:	8b 55 20             	mov    0x20(%ebp),%edx
    2d05:	29 c2                	sub    %eax,%edx
    2d07:	89 d0                	mov    %edx,%eax
    2d09:	83 e8 01             	sub    $0x1,%eax
    2d0c:	c1 e0 0a             	shl    $0xa,%eax
    2d0f:	99                   	cltd   
    2d10:	f7 7d ec             	idivl  -0x14(%ebp)
    2d13:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2d16:	eb 55                	jmp    2d6d <draw_line+0x105>
	}
	else {
		len = dy + 1;
    2d18:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2d1b:	83 c0 01             	add    $0x1,%eax
    2d1e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		dy = (y1 > y0) ? 1024 : -1024;
    2d21:	8b 45 20             	mov    0x20(%ebp),%eax
    2d24:	3b 45 18             	cmp    0x18(%ebp),%eax
    2d27:	7e 07                	jle    2d30 <draw_line+0xc8>
    2d29:	b8 00 04 00 00       	mov    $0x400,%eax
    2d2e:	eb 05                	jmp    2d35 <draw_line+0xcd>
    2d30:	b8 00 fc ff ff       	mov    $0xfffffc00,%eax
    2d35:	89 45 f8             	mov    %eax,-0x8(%ebp)
		dx = (x1 >= x0) ? (((x1 - x0 + 1) << 10) / len) : (((x1 - x0 - 1) << 10) / len);
    2d38:	8b 45 1c             	mov    0x1c(%ebp),%eax
    2d3b:	3b 45 14             	cmp    0x14(%ebp),%eax
    2d3e:	7c 16                	jl     2d56 <draw_line+0xee>
    2d40:	8b 45 14             	mov    0x14(%ebp),%eax
    2d43:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2d46:	29 c2                	sub    %eax,%edx
    2d48:	89 d0                	mov    %edx,%eax
    2d4a:	83 c0 01             	add    $0x1,%eax
    2d4d:	c1 e0 0a             	shl    $0xa,%eax
    2d50:	99                   	cltd   
    2d51:	f7 7d ec             	idivl  -0x14(%ebp)
    2d54:	eb 14                	jmp    2d6a <draw_line+0x102>
    2d56:	8b 45 14             	mov    0x14(%ebp),%eax
    2d59:	8b 55 1c             	mov    0x1c(%ebp),%edx
    2d5c:	29 c2                	sub    %eax,%edx
    2d5e:	89 d0                	mov    %edx,%eax
    2d60:	83 e8 01             	sub    $0x1,%eax
    2d63:	c1 e0 0a             	shl    $0xa,%eax
    2d66:	99                   	cltd   
    2d67:	f7 7d ec             	idivl  -0x14(%ebp)
    2d6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	}
	for(i = 0; i < len; i++) {
    2d6d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    2d74:	eb 47                	jmp    2dbd <draw_line+0x155>
		//printf(0, "draw line point: x=%d, y=%d\n", (x >> 10), (y >> 10));
		draw_point(c, (x >> 10), (y >> 10), color);
    2d76:	0f b7 4d dc          	movzwl -0x24(%ebp),%ecx
    2d7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2d7d:	c1 f8 0a             	sar    $0xa,%eax
    2d80:	89 c2                	mov    %eax,%edx
    2d82:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2d85:	c1 f8 0a             	sar    $0xa,%eax
    2d88:	89 4c 24 14          	mov    %ecx,0x14(%esp)
    2d8c:	89 54 24 10          	mov    %edx,0x10(%esp)
    2d90:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2d94:	8b 45 08             	mov    0x8(%ebp),%eax
    2d97:	89 04 24             	mov    %eax,(%esp)
    2d9a:	8b 45 0c             	mov    0xc(%ebp),%eax
    2d9d:	89 44 24 04          	mov    %eax,0x4(%esp)
    2da1:	8b 45 10             	mov    0x10(%ebp),%eax
    2da4:	89 44 24 08          	mov    %eax,0x8(%esp)
    2da8:	e8 cd f5 ff ff       	call   237a <draw_point>
		y += dy;
    2dad:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2db0:	01 45 f0             	add    %eax,-0x10(%ebp)
		x += dx;
    2db3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2db6:	01 45 f4             	add    %eax,-0xc(%ebp)
	else {
		len = dy + 1;
		dy = (y1 > y0) ? 1024 : -1024;
		dx = (x1 >= x0) ? (((x1 - x0 + 1) << 10) / len) : (((x1 - x0 - 1) << 10) / len);
	}
	for(i = 0; i < len; i++) {
    2db9:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    2dbd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2dc0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2dc3:	7c b1                	jl     2d76 <draw_line+0x10e>
		//printf(0, "draw line point: x=%d, y=%d\n", (x >> 10), (y >> 10));
		draw_point(c, (x >> 10), (y >> 10), color);
		y += dy;
		x += dx;
	}
}
    2dc5:	c9                   	leave  
    2dc6:	c3                   	ret    

00002dc7 <draw_window>:

void
draw_window(Context c, char *title)
{
    2dc7:	55                   	push   %ebp
    2dc8:	89 e5                	mov    %esp,%ebp
    2dca:	83 ec 38             	sub    $0x38,%esp
  PICNODE pic;
  draw_line(c, 0, 0, c.width - 1, 0, BORDERLINE_COLOR);
    2dcd:	8b 45 0c             	mov    0xc(%ebp),%eax
    2dd0:	83 e8 01             	sub    $0x1,%eax
    2dd3:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2dda:	00 
    2ddb:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    2de2:	00 
    2de3:	89 44 24 14          	mov    %eax,0x14(%esp)
    2de7:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    2dee:	00 
    2def:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    2df6:	00 
    2df7:	8b 45 08             	mov    0x8(%ebp),%eax
    2dfa:	89 04 24             	mov    %eax,(%esp)
    2dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e00:	89 44 24 04          	mov    %eax,0x4(%esp)
    2e04:	8b 45 10             	mov    0x10(%ebp),%eax
    2e07:	89 44 24 08          	mov    %eax,0x8(%esp)
    2e0b:	e8 58 fe ff ff       	call   2c68 <draw_line>
  draw_line(c, c.width - 1, 0, c.width - 1, c.height - 1, BORDERLINE_COLOR);
    2e10:	8b 45 10             	mov    0x10(%ebp),%eax
    2e13:	8d 48 ff             	lea    -0x1(%eax),%ecx
    2e16:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e19:	8d 50 ff             	lea    -0x1(%eax),%edx
    2e1c:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e1f:	83 e8 01             	sub    $0x1,%eax
    2e22:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2e29:	00 
    2e2a:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2e2e:	89 54 24 14          	mov    %edx,0x14(%esp)
    2e32:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
    2e39:	00 
    2e3a:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2e3e:	8b 45 08             	mov    0x8(%ebp),%eax
    2e41:	89 04 24             	mov    %eax,(%esp)
    2e44:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e47:	89 44 24 04          	mov    %eax,0x4(%esp)
    2e4b:	8b 45 10             	mov    0x10(%ebp),%eax
    2e4e:	89 44 24 08          	mov    %eax,0x8(%esp)
    2e52:	e8 11 fe ff ff       	call   2c68 <draw_line>
  draw_line(c, c.width - 1, c.height - 1, 0, c.height - 1, BORDERLINE_COLOR);
    2e57:	8b 45 10             	mov    0x10(%ebp),%eax
    2e5a:	8d 48 ff             	lea    -0x1(%eax),%ecx
    2e5d:	8b 45 10             	mov    0x10(%ebp),%eax
    2e60:	8d 50 ff             	lea    -0x1(%eax),%edx
    2e63:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e66:	83 e8 01             	sub    $0x1,%eax
    2e69:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2e70:	00 
    2e71:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    2e75:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    2e7c:	00 
    2e7d:	89 54 24 10          	mov    %edx,0x10(%esp)
    2e81:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2e85:	8b 45 08             	mov    0x8(%ebp),%eax
    2e88:	89 04 24             	mov    %eax,(%esp)
    2e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e8e:	89 44 24 04          	mov    %eax,0x4(%esp)
    2e92:	8b 45 10             	mov    0x10(%ebp),%eax
    2e95:	89 44 24 08          	mov    %eax,0x8(%esp)
    2e99:	e8 ca fd ff ff       	call   2c68 <draw_line>
  draw_line(c, 0, c.height - 1, 0, 0, BORDERLINE_COLOR);
    2e9e:	8b 45 10             	mov    0x10(%ebp),%eax
    2ea1:	83 e8 01             	sub    $0x1,%eax
    2ea4:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
    2eab:	00 
    2eac:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    2eb3:	00 
    2eb4:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
    2ebb:	00 
    2ebc:	89 44 24 10          	mov    %eax,0x10(%esp)
    2ec0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    2ec7:	00 
    2ec8:	8b 45 08             	mov    0x8(%ebp),%eax
    2ecb:	89 04 24             	mov    %eax,(%esp)
    2ece:	8b 45 0c             	mov    0xc(%ebp),%eax
    2ed1:	89 44 24 04          	mov    %eax,0x4(%esp)
    2ed5:	8b 45 10             	mov    0x10(%ebp),%eax
    2ed8:	89 44 24 08          	mov    %eax,0x8(%esp)
    2edc:	e8 87 fd ff ff       	call   2c68 <draw_line>
  fill_rect(c, 1, 1, c.width - 2, BOTTOMBAR_HEIGHT, TOPBAR_COLOR);
    2ee1:	8b 45 0c             	mov    0xc(%ebp),%eax
    2ee4:	83 e8 02             	sub    $0x2,%eax
    2ee7:	c7 44 24 1c cb 5a 00 	movl   $0x5acb,0x1c(%esp)
    2eee:	00 
    2eef:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    2ef6:	00 
    2ef7:	89 44 24 14          	mov    %eax,0x14(%esp)
    2efb:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
    2f02:	00 
    2f03:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    2f0a:	00 
    2f0b:	8b 45 08             	mov    0x8(%ebp),%eax
    2f0e:	89 04 24             	mov    %eax,(%esp)
    2f11:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f14:	89 44 24 04          	mov    %eax,0x4(%esp)
    2f18:	8b 45 10             	mov    0x10(%ebp),%eax
    2f1b:	89 44 24 08          	mov    %eax,0x8(%esp)
    2f1f:	e8 95 f4 ff ff       	call   23b9 <fill_rect>
  fill_rect(c, 1, c.height - 1 - BOTTOMBAR_HEIGHT, c.width - 2, BOTTOMBAR_HEIGHT, BOTTOMBAR_COLOR);
    2f24:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f27:	83 e8 02             	sub    $0x2,%eax
    2f2a:	89 c2                	mov    %eax,%edx
    2f2c:	8b 45 10             	mov    0x10(%ebp),%eax
    2f2f:	83 e8 15             	sub    $0x15,%eax
    2f32:	c7 44 24 1c cb 5a 00 	movl   $0x5acb,0x1c(%esp)
    2f39:	00 
    2f3a:	c7 44 24 18 14 00 00 	movl   $0x14,0x18(%esp)
    2f41:	00 
    2f42:	89 54 24 14          	mov    %edx,0x14(%esp)
    2f46:	89 44 24 10          	mov    %eax,0x10(%esp)
    2f4a:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    2f51:	00 
    2f52:	8b 45 08             	mov    0x8(%ebp),%eax
    2f55:	89 04 24             	mov    %eax,(%esp)
    2f58:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f5b:	89 44 24 04          	mov    %eax,0x4(%esp)
    2f5f:	8b 45 10             	mov    0x10(%ebp),%eax
    2f62:	89 44 24 08          	mov    %eax,0x8(%esp)
    2f66:	e8 4e f4 ff ff       	call   23b9 <fill_rect>

  loadBitmap(&pic, "close.bmp");
    2f6b:	c7 44 24 04 58 b2 00 	movl   $0xb258,0x4(%esp)
    2f72:	00 
    2f73:	8d 45 ec             	lea    -0x14(%ebp),%eax
    2f76:	89 04 24             	mov    %eax,(%esp)
    2f79:	e8 44 01 00 00       	call   30c2 <loadBitmap>
  draw_picture(c, pic, 3, 3);
    2f7e:	c7 44 24 1c 03 00 00 	movl   $0x3,0x1c(%esp)
    2f85:	00 
    2f86:	c7 44 24 18 03 00 00 	movl   $0x3,0x18(%esp)
    2f8d:	00 
    2f8e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2f91:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2f95:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2f98:	89 44 24 10          	mov    %eax,0x10(%esp)
    2f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f9f:	89 44 24 14          	mov    %eax,0x14(%esp)
    2fa3:	8b 45 08             	mov    0x8(%ebp),%eax
    2fa6:	89 04 24             	mov    %eax,(%esp)
    2fa9:	8b 45 0c             	mov    0xc(%ebp),%eax
    2fac:	89 44 24 04          	mov    %eax,0x4(%esp)
    2fb0:	8b 45 10             	mov    0x10(%ebp),%eax
    2fb3:	89 44 24 08          	mov    %eax,0x8(%esp)
    2fb7:	e8 d6 fb ff ff       	call   2b92 <draw_picture>
  puts_str(c, title, TITLE_COLOR, TITLE_OFFSET_X, TITLE_OFFSET_Y);
    2fbc:	c7 44 24 18 02 00 00 	movl   $0x2,0x18(%esp)
    2fc3:	00 
    2fc4:	c7 44 24 14 19 00 00 	movl   $0x19,0x14(%esp)
    2fcb:	00 
    2fcc:	c7 44 24 10 ff ff 00 	movl   $0xffff,0x10(%esp)
    2fd3:	00 
    2fd4:	8b 45 14             	mov    0x14(%ebp),%eax
    2fd7:	89 44 24 0c          	mov    %eax,0xc(%esp)
    2fdb:	8b 45 08             	mov    0x8(%ebp),%eax
    2fde:	89 04 24             	mov    %eax,(%esp)
    2fe1:	8b 45 0c             	mov    0xc(%ebp),%eax
    2fe4:	89 44 24 04          	mov    %eax,0x4(%esp)
    2fe8:	8b 45 10             	mov    0x10(%ebp),%eax
    2feb:	89 44 24 08          	mov    %eax,0x8(%esp)
    2fef:	e8 de fa ff ff       	call   2ad2 <puts_str>
  freepic(&pic);
    2ff4:	8d 45 ec             	lea    -0x14(%ebp),%eax
    2ff7:	89 04 24             	mov    %eax,(%esp)
    2ffa:	e8 6f 06 00 00       	call   366e <freepic>
}
    2fff:	c9                   	leave  
    3000:	c3                   	ret    

00003001 <load_iconlist>:

void load_iconlist(ICON* iconlist, int len)
{
    3001:	55                   	push   %ebp
    3002:	89 e5                	mov    %esp,%ebp
    3004:	83 ec 28             	sub    $0x28,%esp
	int i;
	for (i = 0; i < len; i++)
    3007:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    300e:	eb 29                	jmp    3039 <load_iconlist+0x38>
	{
	    loadBitmap(&(iconlist[i].pic), iconlist[i].name);
    3010:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3013:	6b d0 34             	imul   $0x34,%eax,%edx
    3016:	8b 45 08             	mov    0x8(%ebp),%eax
    3019:	01 d0                	add    %edx,%eax
    301b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    301e:	6b ca 34             	imul   $0x34,%edx,%ecx
    3021:	8b 55 08             	mov    0x8(%ebp),%edx
    3024:	01 ca                	add    %ecx,%edx
    3026:	83 c2 28             	add    $0x28,%edx
    3029:	89 44 24 04          	mov    %eax,0x4(%esp)
    302d:	89 14 24             	mov    %edx,(%esp)
    3030:	e8 8d 00 00 00       	call   30c2 <loadBitmap>
}

void load_iconlist(ICON* iconlist, int len)
{
	int i;
	for (i = 0; i < len; i++)
    3035:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3039:	8b 45 f4             	mov    -0xc(%ebp),%eax
    303c:	3b 45 0c             	cmp    0xc(%ebp),%eax
    303f:	7c cf                	jl     3010 <load_iconlist+0xf>
	{
	    loadBitmap(&(iconlist[i].pic), iconlist[i].name);
	}
}
    3041:	c9                   	leave  
    3042:	c3                   	ret    

00003043 <draw_iconlist>:
void draw_iconlist(Context c, ICON* iconlist, int len)
{
    3043:	55                   	push   %ebp
    3044:	89 e5                	mov    %esp,%ebp
    3046:	53                   	push   %ebx
    3047:	83 ec 30             	sub    $0x30,%esp
    int i;
    for (i = 0; i < len; i++)
    304a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    3051:	eb 61                	jmp    30b4 <draw_iconlist+0x71>
    {
        draw_picture(c, iconlist[i].pic, iconlist[i].position_x, iconlist[i].position_y);
    3053:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3056:	6b d0 34             	imul   $0x34,%eax,%edx
    3059:	8b 45 14             	mov    0x14(%ebp),%eax
    305c:	01 d0                	add    %edx,%eax
    305e:	8b 48 24             	mov    0x24(%eax),%ecx
    3061:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3064:	6b d0 34             	imul   $0x34,%eax,%edx
    3067:	8b 45 14             	mov    0x14(%ebp),%eax
    306a:	01 d0                	add    %edx,%eax
    306c:	8b 50 20             	mov    0x20(%eax),%edx
    306f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3072:	6b d8 34             	imul   $0x34,%eax,%ebx
    3075:	8b 45 14             	mov    0x14(%ebp),%eax
    3078:	01 d8                	add    %ebx,%eax
    307a:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    307e:	89 54 24 18          	mov    %edx,0x18(%esp)
    3082:	8b 50 28             	mov    0x28(%eax),%edx
    3085:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3089:	8b 50 2c             	mov    0x2c(%eax),%edx
    308c:	89 54 24 10          	mov    %edx,0x10(%esp)
    3090:	8b 40 30             	mov    0x30(%eax),%eax
    3093:	89 44 24 14          	mov    %eax,0x14(%esp)
    3097:	8b 45 08             	mov    0x8(%ebp),%eax
    309a:	89 04 24             	mov    %eax,(%esp)
    309d:	8b 45 0c             	mov    0xc(%ebp),%eax
    30a0:	89 44 24 04          	mov    %eax,0x4(%esp)
    30a4:	8b 45 10             	mov    0x10(%ebp),%eax
    30a7:	89 44 24 08          	mov    %eax,0x8(%esp)
    30ab:	e8 e2 fa ff ff       	call   2b92 <draw_picture>
	}
}
void draw_iconlist(Context c, ICON* iconlist, int len)
{
    int i;
    for (i = 0; i < len; i++)
    30b0:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    30b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    30b7:	3b 45 18             	cmp    0x18(%ebp),%eax
    30ba:	7c 97                	jl     3053 <draw_iconlist+0x10>
    {
        draw_picture(c, iconlist[i].pic, iconlist[i].position_x, iconlist[i].position_y);
    }
}
    30bc:	83 c4 30             	add    $0x30,%esp
    30bf:	5b                   	pop    %ebx
    30c0:	5d                   	pop    %ebp
    30c1:	c3                   	ret    

000030c2 <loadBitmap>:
#include "clickable.h"

void showRgbQuan(RGBQUAD* pRGB);
void showBmpHead(BITMAPFILEHEADER* pBmpHead);
void showBmpInforHead(BITMAPINFOHEADER* pBmpInforHead);
void loadBitmap(PICNODE *pic, char pic_name[]) {
    30c2:	55                   	push   %ebp
    30c3:	89 e5                	mov    %esp,%ebp
    30c5:	81 ec a8 00 00 00    	sub    $0xa8,%esp
	BITMAPFILEHEADER bitHead;
	BITMAPINFOHEADER bitInfoHead;
	char *BmpFileHeader;
	WORD *temp_WORD;
	DWORD *temp_DWORD;
	int fd, n, i, j, k, index = 0;
    30cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int width;
	int height;

	if ((fd = open(pic_name, 0)) < 0) {
    30d2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    30d9:	00 
    30da:	8b 45 0c             	mov    0xc(%ebp),%eax
    30dd:	89 04 24             	mov    %eax,(%esp)
    30e0:	e8 b5 16 00 00       	call   479a <open>
    30e5:	89 45 e8             	mov    %eax,-0x18(%ebp)
    30e8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    30ec:	79 20                	jns    310e <loadBitmap+0x4c>
		printf(0, "cannot open %s\n", pic_name);
    30ee:	8b 45 0c             	mov    0xc(%ebp),%eax
    30f1:	89 44 24 08          	mov    %eax,0x8(%esp)
    30f5:	c7 44 24 04 64 b2 00 	movl   $0xb264,0x4(%esp)
    30fc:	00 
    30fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3104:	e8 41 18 00 00       	call   494a <printf>
		return;
    3109:	e9 ef 02 00 00       	jmp    33fd <loadBitmap+0x33b>
	}
	printf(0, "reading bitmap: %s\n", pic_name);
    310e:	8b 45 0c             	mov    0xc(%ebp),%eax
    3111:	89 44 24 08          	mov    %eax,0x8(%esp)
    3115:	c7 44 24 04 74 b2 00 	movl   $0xb274,0x4(%esp)
    311c:	00 
    311d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3124:	e8 21 18 00 00       	call   494a <printf>
	//pfile = fopen(strFile,"rb");//打开文件
	BmpFileHeader = (char *) malloc(14 * sizeof(char));
    3129:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
    3130:	e8 01 1b 00 00       	call   4c36 <malloc>
    3135:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//printf(0, "file bmp open success.\n");
	//读取位图文件头信息
	//printf(0, "reading BmpFileHeader.\n");
	n = read(fd, BmpFileHeader, 14);
    3138:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
    313f:	00 
    3140:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3143:	89 44 24 04          	mov    %eax,0x4(%esp)
    3147:	8b 45 e8             	mov    -0x18(%ebp),%eax
    314a:	89 04 24             	mov    %eax,(%esp)
    314d:	e8 20 16 00 00       	call   4772 <read>
    3152:	89 45 e0             	mov    %eax,-0x20(%ebp)
	//fread(BmpFileHeader,1,14,pfile);
	temp_WORD = (WORD*) (BmpFileHeader);
    3155:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3158:	89 45 dc             	mov    %eax,-0x24(%ebp)
	bitHead.bfType = *temp_WORD;
    315b:	8b 45 dc             	mov    -0x24(%ebp),%eax
    315e:	0f b7 00             	movzwl (%eax),%eax
    3161:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
	if (bitHead.bfType != 0x4d42) {
    3165:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    3169:	66 3d 42 4d          	cmp    $0x4d42,%ax
    316d:	74 19                	je     3188 <loadBitmap+0xc6>
		printf(0, "file is not .bmp file!");
    316f:	c7 44 24 04 88 b2 00 	movl   $0xb288,0x4(%esp)
    3176:	00 
    3177:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    317e:	e8 c7 17 00 00       	call   494a <printf>
		return;
    3183:	e9 75 02 00 00       	jmp    33fd <loadBitmap+0x33b>
	}
	temp_DWORD = (DWORD *) (BmpFileHeader + sizeof(bitHead.bfType));
    3188:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    318b:	83 c0 02             	add    $0x2,%eax
    318e:	89 45 d8             	mov    %eax,-0x28(%ebp)
	bitHead.bfSize = *temp_DWORD;
    3191:	8b 45 d8             	mov    -0x28(%ebp),%eax
    3194:	8b 00                	mov    (%eax),%eax
    3196:	89 45 b0             	mov    %eax,-0x50(%ebp)
	temp_WORD = (WORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    3199:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    319c:	83 c0 06             	add    $0x6,%eax
    319f:	89 45 dc             	mov    %eax,-0x24(%ebp)
			+ sizeof(bitHead.bfSize));
	bitHead.bfReserved1 = *temp_WORD;
    31a2:	8b 45 dc             	mov    -0x24(%ebp),%eax
    31a5:	0f b7 00             	movzwl (%eax),%eax
    31a8:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
	temp_WORD = (WORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    31ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    31af:	83 c0 08             	add    $0x8,%eax
    31b2:	89 45 dc             	mov    %eax,-0x24(%ebp)
			+ sizeof(bitHead.bfSize) + sizeof(bitHead.bfReserved1));
	bitHead.bfReserved2 = *temp_WORD;
    31b5:	8b 45 dc             	mov    -0x24(%ebp),%eax
    31b8:	0f b7 00             	movzwl (%eax),%eax
    31bb:	66 89 45 b6          	mov    %ax,-0x4a(%ebp)
	temp_DWORD = (DWORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    31bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    31c2:	83 c0 0a             	add    $0xa,%eax
    31c5:	89 45 d8             	mov    %eax,-0x28(%ebp)
			+ sizeof(bitHead.bfSize) + sizeof(bitHead.bfReserved1)
			+ sizeof(bitHead.bfReserved2));
	bitHead.bfOffBits = *temp_DWORD;
    31c8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    31cb:	8b 00                	mov    (%eax),%eax
    31cd:	89 45 b8             	mov    %eax,-0x48(%ebp)
	//printf(0, "reading BmpFileHeader success!\n");
	//showBmpHead(&bitHead);
	//printf(0, "\n\n");
//
//	//读取位图信息头信息
	read(fd, &bitInfoHead, sizeof(BITMAPINFOHEADER));
    31d0:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    31d7:	00 
    31d8:	8d 45 84             	lea    -0x7c(%ebp),%eax
    31db:	89 44 24 04          	mov    %eax,0x4(%esp)
    31df:	8b 45 e8             	mov    -0x18(%ebp),%eax
    31e2:	89 04 24             	mov    %eax,(%esp)
    31e5:	e8 88 15 00 00       	call   4772 <read>
	width = bitInfoHead.biWidth;
    31ea:	8b 45 88             	mov    -0x78(%ebp),%eax
    31ed:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	height = bitInfoHead.biHeight;
    31f0:	8b 45 8c             	mov    -0x74(%ebp),%eax
    31f3:	89 45 d0             	mov    %eax,-0x30(%ebp)
	printf(0, "bmp width: %d, height: %d, size: %d\n", width, height,
			width * height * sizeof(RGBQUAD));
    31f6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    31f9:	0f af 45 d0          	imul   -0x30(%ebp),%eax
//
//	//读取位图信息头信息
	read(fd, &bitInfoHead, sizeof(BITMAPINFOHEADER));
	width = bitInfoHead.biWidth;
	height = bitInfoHead.biHeight;
	printf(0, "bmp width: %d, height: %d, size: %d\n", width, height,
    31fd:	c1 e0 02             	shl    $0x2,%eax
    3200:	89 44 24 10          	mov    %eax,0x10(%esp)
    3204:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3207:	89 44 24 0c          	mov    %eax,0xc(%esp)
    320b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    320e:	89 44 24 08          	mov    %eax,0x8(%esp)
    3212:	c7 44 24 04 a0 b2 00 	movl   $0xb2a0,0x4(%esp)
    3219:	00 
    321a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3221:	e8 24 17 00 00       	call   494a <printf>
			width * height * sizeof(RGBQUAD));
	//fread(&bitInfoHead,1,sizeof(BITMAPINFOHEADER),pfile);
	//showBmpInforHead(&bitInfoHead);
	//printf(0, "\n");
	if (n == 0) {
    3226:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    322a:	75 14                	jne    3240 <loadBitmap+0x17e>
		printf(0, "0");
    322c:	c7 44 24 04 c5 b2 00 	movl   $0xb2c5,0x4(%esp)
    3233:	00 
    3234:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    323b:	e8 0a 17 00 00       	call   494a <printf>
	}

	//分配内存空间把源图存入内存
	int l_width = WIDTHBYTES(width * bitInfoHead.biBitCount);//计算位图的实际宽度并确保它为32的倍数
    3240:	0f b7 45 92          	movzwl -0x6e(%ebp),%eax
    3244:	0f b7 c0             	movzwl %ax,%eax
    3247:	0f af 45 d4          	imul   -0x2c(%ebp),%eax
    324b:	83 c0 1f             	add    $0x1f,%eax
    324e:	8d 50 1f             	lea    0x1f(%eax),%edx
    3251:	85 c0                	test   %eax,%eax
    3253:	0f 48 c2             	cmovs  %edx,%eax
    3256:	c1 f8 05             	sar    $0x5,%eax
    3259:	c1 e0 02             	shl    $0x2,%eax
    325c:	89 45 cc             	mov    %eax,-0x34(%ebp)
	BYTE *pColorData = (BYTE *) malloc(height * l_width);
    325f:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3262:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    3266:	89 04 24             	mov    %eax,(%esp)
    3269:	e8 c8 19 00 00       	call   4c36 <malloc>
    326e:	89 45 c8             	mov    %eax,-0x38(%ebp)
	memset(pColorData, 0, (uint) height * l_width);
    3271:	8b 55 d0             	mov    -0x30(%ebp),%edx
    3274:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3277:	0f af c2             	imul   %edx,%eax
    327a:	89 44 24 08          	mov    %eax,0x8(%esp)
    327e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3285:	00 
    3286:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3289:	89 04 24             	mov    %eax,(%esp)
    328c:	e8 1c 13 00 00       	call   45ad <memset>
	long nData = height * l_width;
    3291:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3294:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    3298:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	//把位图数据信息读到数组里
	read(fd, pColorData, nData);
    329b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    329e:	89 44 24 08          	mov    %eax,0x8(%esp)
    32a2:	8b 45 c8             	mov    -0x38(%ebp),%eax
    32a5:	89 44 24 04          	mov    %eax,0x4(%esp)
    32a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    32ac:	89 04 24             	mov    %eax,(%esp)
    32af:	e8 be 14 00 00       	call   4772 <read>

	//printf(0, "reading bmp data.\n");
	//将位图数据转化为RGB数据
	RGBQUAD* dataOfBmp;

	dataOfBmp = (RGBQUAD *) malloc(width * height * sizeof(RGBQUAD));//用于保存各像素对应的RGB数据
    32b4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    32b7:	0f af 45 d0          	imul   -0x30(%ebp),%eax
    32bb:	c1 e0 02             	shl    $0x2,%eax
    32be:	89 04 24             	mov    %eax,(%esp)
    32c1:	e8 70 19 00 00       	call   4c36 <malloc>
    32c6:	89 45 c0             	mov    %eax,-0x40(%ebp)
	memset(dataOfBmp, 0, (uint) width * height * sizeof(RGBQUAD));
    32c9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    32cc:	8b 45 d0             	mov    -0x30(%ebp),%eax
    32cf:	0f af c2             	imul   %edx,%eax
    32d2:	c1 e0 02             	shl    $0x2,%eax
    32d5:	89 44 24 08          	mov    %eax,0x8(%esp)
    32d9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    32e0:	00 
    32e1:	8b 45 c0             	mov    -0x40(%ebp),%eax
    32e4:	89 04 24             	mov    %eax,(%esp)
    32e7:	e8 c1 12 00 00       	call   45ad <memset>
	if (bitInfoHead.biBitCount < 24)	//有调色板，即位图为非真彩色
    32ec:	0f b7 45 92          	movzwl -0x6e(%ebp),%eax
    32f0:	66 83 f8 17          	cmp    $0x17,%ax
    32f4:	77 19                	ja     330f <loadBitmap+0x24d>
			{
		printf(0, "%s is not a 24 bit bmp! return.");
    32f6:	c7 44 24 04 c8 b2 00 	movl   $0xb2c8,0x4(%esp)
    32fd:	00 
    32fe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3305:	e8 40 16 00 00       	call   494a <printf>
		return;
    330a:	e9 ee 00 00 00       	jmp    33fd <loadBitmap+0x33b>
	} else	//位图为24位真彩色
	{
		index = 0;
    330f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (i = 0; i < height; i++)
    3316:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    331d:	e9 94 00 00 00       	jmp    33b6 <loadBitmap+0x2f4>
			for (j = 0; j < width; j++) {
    3322:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3329:	eb 7b                	jmp    33a6 <loadBitmap+0x2e4>
				k = i * l_width + j * 3;
    332b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    332e:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    3332:	89 c1                	mov    %eax,%ecx
    3334:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3337:	89 d0                	mov    %edx,%eax
    3339:	01 c0                	add    %eax,%eax
    333b:	01 d0                	add    %edx,%eax
    333d:	01 c8                	add    %ecx,%eax
    333f:	89 45 bc             	mov    %eax,-0x44(%ebp)
				dataOfBmp[index].rgbRed = pColorData[k + 2];
    3342:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3345:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    334c:	8b 45 c0             	mov    -0x40(%ebp),%eax
    334f:	01 c2                	add    %eax,%edx
    3351:	8b 45 bc             	mov    -0x44(%ebp),%eax
    3354:	8d 48 02             	lea    0x2(%eax),%ecx
    3357:	8b 45 c8             	mov    -0x38(%ebp),%eax
    335a:	01 c8                	add    %ecx,%eax
    335c:	0f b6 00             	movzbl (%eax),%eax
    335f:	88 42 02             	mov    %al,0x2(%edx)
				dataOfBmp[index].rgbGreen = pColorData[k + 1];
    3362:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3365:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    336c:	8b 45 c0             	mov    -0x40(%ebp),%eax
    336f:	01 c2                	add    %eax,%edx
    3371:	8b 45 bc             	mov    -0x44(%ebp),%eax
    3374:	8d 48 01             	lea    0x1(%eax),%ecx
    3377:	8b 45 c8             	mov    -0x38(%ebp),%eax
    337a:	01 c8                	add    %ecx,%eax
    337c:	0f b6 00             	movzbl (%eax),%eax
    337f:	88 42 01             	mov    %al,0x1(%edx)
				dataOfBmp[index].rgbBlue = pColorData[k];
    3382:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3385:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    338c:	8b 45 c0             	mov    -0x40(%ebp),%eax
    338f:	01 c2                	add    %eax,%edx
    3391:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3394:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3397:	01 c8                	add    %ecx,%eax
    3399:	0f b6 00             	movzbl (%eax),%eax
    339c:	88 02                	mov    %al,(%edx)
				index++;
    339e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
		return;
	} else	//位图为24位真彩色
	{
		index = 0;
		for (i = 0; i < height; i++)
			for (j = 0; j < width; j++) {
    33a2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    33a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    33a9:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
    33ac:	0f 8c 79 ff ff ff    	jl     332b <loadBitmap+0x269>
		printf(0, "%s is not a 24 bit bmp! return.");
		return;
	} else	//位图为24位真彩色
	{
		index = 0;
		for (i = 0; i < height; i++)
    33b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    33b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    33b9:	3b 45 d0             	cmp    -0x30(%ebp),%eax
    33bc:	0f 8c 60 ff ff ff    	jl     3322 <loadBitmap+0x260>
//			printf(0, "\n");
//		}
//		showRgbQuan(&dataOfBmp[i]);
//	}

	close(fd);
    33c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    33c5:	89 04 24             	mov    %eax,(%esp)
    33c8:	e8 b5 13 00 00       	call   4782 <close>

	//free(dataOfBmp);
	pic->data = dataOfBmp;
    33cd:	8b 45 08             	mov    0x8(%ebp),%eax
    33d0:	8b 55 c0             	mov    -0x40(%ebp),%edx
    33d3:	89 10                	mov    %edx,(%eax)
	pic->width = width;
    33d5:	8b 45 08             	mov    0x8(%ebp),%eax
    33d8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    33db:	89 50 04             	mov    %edx,0x4(%eax)
	pic->height = height;
    33de:	8b 45 08             	mov    0x8(%ebp),%eax
    33e1:	8b 55 d0             	mov    -0x30(%ebp),%edx
    33e4:	89 50 08             	mov    %edx,0x8(%eax)
	free(pColorData);
    33e7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    33ea:	89 04 24             	mov    %eax,(%esp)
    33ed:	e8 0b 17 00 00       	call   4afd <free>
	free(BmpFileHeader);
    33f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    33f5:	89 04 24             	mov    %eax,(%esp)
    33f8:	e8 00 17 00 00       	call   4afd <free>
	//printf("\n");
}
    33fd:	c9                   	leave  
    33fe:	c3                   	ret    

000033ff <showBmpHead>:

void showBmpHead(BITMAPFILEHEADER* pBmpHead) {
    33ff:	55                   	push   %ebp
    3400:	89 e5                	mov    %esp,%ebp
    3402:	83 ec 18             	sub    $0x18,%esp
	printf(0, "位图文件头:\n");
    3405:	c7 44 24 04 e8 b2 00 	movl   $0xb2e8,0x4(%esp)
    340c:	00 
    340d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3414:	e8 31 15 00 00       	call   494a <printf>
	printf(0, "bmp格式标志bftype：0x%x\n", pBmpHead->bfType);
    3419:	8b 45 08             	mov    0x8(%ebp),%eax
    341c:	0f b7 00             	movzwl (%eax),%eax
    341f:	0f b7 c0             	movzwl %ax,%eax
    3422:	89 44 24 08          	mov    %eax,0x8(%esp)
    3426:	c7 44 24 04 fa b2 00 	movl   $0xb2fa,0x4(%esp)
    342d:	00 
    342e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3435:	e8 10 15 00 00       	call   494a <printf>
	printf(0, "文件大小:%d\n", pBmpHead->bfSize);
    343a:	8b 45 08             	mov    0x8(%ebp),%eax
    343d:	8b 40 04             	mov    0x4(%eax),%eax
    3440:	89 44 24 08          	mov    %eax,0x8(%esp)
    3444:	c7 44 24 04 18 b3 00 	movl   $0xb318,0x4(%esp)
    344b:	00 
    344c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3453:	e8 f2 14 00 00       	call   494a <printf>
	printf(0, "保留字:%d\n", pBmpHead->bfReserved1);
    3458:	8b 45 08             	mov    0x8(%ebp),%eax
    345b:	0f b7 40 08          	movzwl 0x8(%eax),%eax
    345f:	0f b7 c0             	movzwl %ax,%eax
    3462:	89 44 24 08          	mov    %eax,0x8(%esp)
    3466:	c7 44 24 04 29 b3 00 	movl   $0xb329,0x4(%esp)
    346d:	00 
    346e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3475:	e8 d0 14 00 00       	call   494a <printf>
	printf(0, "保留字:%d\n", pBmpHead->bfReserved2);
    347a:	8b 45 08             	mov    0x8(%ebp),%eax
    347d:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    3481:	0f b7 c0             	movzwl %ax,%eax
    3484:	89 44 24 08          	mov    %eax,0x8(%esp)
    3488:	c7 44 24 04 29 b3 00 	movl   $0xb329,0x4(%esp)
    348f:	00 
    3490:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3497:	e8 ae 14 00 00       	call   494a <printf>
	printf(0, "实际位图数据的偏移字节数:%d\n", pBmpHead->bfOffBits);
    349c:	8b 45 08             	mov    0x8(%ebp),%eax
    349f:	8b 40 0c             	mov    0xc(%eax),%eax
    34a2:	89 44 24 08          	mov    %eax,0x8(%esp)
    34a6:	c7 44 24 04 38 b3 00 	movl   $0xb338,0x4(%esp)
    34ad:	00 
    34ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    34b5:	e8 90 14 00 00       	call   494a <printf>
}
    34ba:	c9                   	leave  
    34bb:	c3                   	ret    

000034bc <showBmpInforHead>:

void showBmpInforHead(BITMAPINFOHEADER* pBmpInforHead) {
    34bc:	55                   	push   %ebp
    34bd:	89 e5                	mov    %esp,%ebp
    34bf:	83 ec 18             	sub    $0x18,%esp
	printf(0, "位图信息头:\n");
    34c2:	c7 44 24 04 61 b3 00 	movl   $0xb361,0x4(%esp)
    34c9:	00 
    34ca:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    34d1:	e8 74 14 00 00       	call   494a <printf>
	printf(0, "结构体的长度:%d\n", pBmpInforHead->biSize);
    34d6:	8b 45 08             	mov    0x8(%ebp),%eax
    34d9:	8b 00                	mov    (%eax),%eax
    34db:	89 44 24 08          	mov    %eax,0x8(%esp)
    34df:	c7 44 24 04 73 b3 00 	movl   $0xb373,0x4(%esp)
    34e6:	00 
    34e7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    34ee:	e8 57 14 00 00       	call   494a <printf>
	printf(0, "位图宽:%d\n", pBmpInforHead->biWidth);
    34f3:	8b 45 08             	mov    0x8(%ebp),%eax
    34f6:	8b 40 04             	mov    0x4(%eax),%eax
    34f9:	89 44 24 08          	mov    %eax,0x8(%esp)
    34fd:	c7 44 24 04 8a b3 00 	movl   $0xb38a,0x4(%esp)
    3504:	00 
    3505:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    350c:	e8 39 14 00 00       	call   494a <printf>
	printf(0, "位图高:%d\n", pBmpInforHead->biHeight);
    3511:	8b 45 08             	mov    0x8(%ebp),%eax
    3514:	8b 40 08             	mov    0x8(%eax),%eax
    3517:	89 44 24 08          	mov    %eax,0x8(%esp)
    351b:	c7 44 24 04 98 b3 00 	movl   $0xb398,0x4(%esp)
    3522:	00 
    3523:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    352a:	e8 1b 14 00 00       	call   494a <printf>
	printf(0, "biPlanes平面数:%d\n", pBmpInforHead->biPlanes);
    352f:	8b 45 08             	mov    0x8(%ebp),%eax
    3532:	0f b7 40 0c          	movzwl 0xc(%eax),%eax
    3536:	0f b7 c0             	movzwl %ax,%eax
    3539:	89 44 24 08          	mov    %eax,0x8(%esp)
    353d:	c7 44 24 04 a6 b3 00 	movl   $0xb3a6,0x4(%esp)
    3544:	00 
    3545:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    354c:	e8 f9 13 00 00       	call   494a <printf>
	printf(0, "biBitCount采用颜色位数:%d\n", pBmpInforHead->biBitCount);
    3551:	8b 45 08             	mov    0x8(%ebp),%eax
    3554:	0f b7 40 0e          	movzwl 0xe(%eax),%eax
    3558:	0f b7 c0             	movzwl %ax,%eax
    355b:	89 44 24 08          	mov    %eax,0x8(%esp)
    355f:	c7 44 24 04 bc b3 00 	movl   $0xb3bc,0x4(%esp)
    3566:	00 
    3567:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    356e:	e8 d7 13 00 00       	call   494a <printf>
	printf(0, "压缩方式:%d\n", pBmpInforHead->biCompression);
    3573:	8b 45 08             	mov    0x8(%ebp),%eax
    3576:	8b 40 10             	mov    0x10(%eax),%eax
    3579:	89 44 24 08          	mov    %eax,0x8(%esp)
    357d:	c7 44 24 04 dd b3 00 	movl   $0xb3dd,0x4(%esp)
    3584:	00 
    3585:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    358c:	e8 b9 13 00 00       	call   494a <printf>
	printf(0, "biSizeImage实际位图数据占用的字节数:%d\n", pBmpInforHead->biSizeImage);
    3591:	8b 45 08             	mov    0x8(%ebp),%eax
    3594:	8b 40 14             	mov    0x14(%eax),%eax
    3597:	89 44 24 08          	mov    %eax,0x8(%esp)
    359b:	c7 44 24 04 f0 b3 00 	movl   $0xb3f0,0x4(%esp)
    35a2:	00 
    35a3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35aa:	e8 9b 13 00 00       	call   494a <printf>
	printf(0, "X方向分辨率:%d\n", pBmpInforHead->biXPelsPerMeter);
    35af:	8b 45 08             	mov    0x8(%ebp),%eax
    35b2:	8b 40 18             	mov    0x18(%eax),%eax
    35b5:	89 44 24 08          	mov    %eax,0x8(%esp)
    35b9:	c7 44 24 04 24 b4 00 	movl   $0xb424,0x4(%esp)
    35c0:	00 
    35c1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35c8:	e8 7d 13 00 00       	call   494a <printf>
	printf(0, "Y方向分辨率:%d\n", pBmpInforHead->biYPelsPerMeter);
    35cd:	8b 45 08             	mov    0x8(%ebp),%eax
    35d0:	8b 40 1c             	mov    0x1c(%eax),%eax
    35d3:	89 44 24 08          	mov    %eax,0x8(%esp)
    35d7:	c7 44 24 04 39 b4 00 	movl   $0xb439,0x4(%esp)
    35de:	00 
    35df:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35e6:	e8 5f 13 00 00       	call   494a <printf>
	printf(0, "使用的颜色数:%d\n", pBmpInforHead->biClrUsed);
    35eb:	8b 45 08             	mov    0x8(%ebp),%eax
    35ee:	8b 40 20             	mov    0x20(%eax),%eax
    35f1:	89 44 24 08          	mov    %eax,0x8(%esp)
    35f5:	c7 44 24 04 4e b4 00 	movl   $0xb44e,0x4(%esp)
    35fc:	00 
    35fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3604:	e8 41 13 00 00       	call   494a <printf>
	printf(0, "重要颜色数:%d\n", pBmpInforHead->biClrImportant);
    3609:	8b 45 08             	mov    0x8(%ebp),%eax
    360c:	8b 40 24             	mov    0x24(%eax),%eax
    360f:	89 44 24 08          	mov    %eax,0x8(%esp)
    3613:	c7 44 24 04 65 b4 00 	movl   $0xb465,0x4(%esp)
    361a:	00 
    361b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3622:	e8 23 13 00 00       	call   494a <printf>
}
    3627:	c9                   	leave  
    3628:	c3                   	ret    

00003629 <showRgbQuan>:
void showRgbQuan(RGBQUAD* pRGB) {
    3629:	55                   	push   %ebp
    362a:	89 e5                	mov    %esp,%ebp
    362c:	83 ec 28             	sub    $0x28,%esp
	printf(0, "(%d,%d,%d) ", pRGB->rgbRed, pRGB->rgbGreen, pRGB->rgbBlue);
    362f:	8b 45 08             	mov    0x8(%ebp),%eax
    3632:	0f b6 00             	movzbl (%eax),%eax
    3635:	0f b6 c8             	movzbl %al,%ecx
    3638:	8b 45 08             	mov    0x8(%ebp),%eax
    363b:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    363f:	0f b6 d0             	movzbl %al,%edx
    3642:	8b 45 08             	mov    0x8(%ebp),%eax
    3645:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    3649:	0f b6 c0             	movzbl %al,%eax
    364c:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    3650:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3654:	89 44 24 08          	mov    %eax,0x8(%esp)
    3658:	c7 44 24 04 79 b4 00 	movl   $0xb479,0x4(%esp)
    365f:	00 
    3660:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3667:	e8 de 12 00 00       	call   494a <printf>
}
    366c:	c9                   	leave  
    366d:	c3                   	ret    

0000366e <freepic>:

void freepic(PICNODE *pic) {
    366e:	55                   	push   %ebp
    366f:	89 e5                	mov    %esp,%ebp
    3671:	83 ec 18             	sub    $0x18,%esp
	free(pic->data);
    3674:	8b 45 08             	mov    0x8(%ebp),%eax
    3677:	8b 00                	mov    (%eax),%eax
    3679:	89 04 24             	mov    %eax,(%esp)
    367c:	e8 7c 14 00 00       	call   4afd <free>
}
    3681:	c9                   	leave  
    3682:	c3                   	ret    

00003683 <set_icon_alpha>:

void set_icon_alpha(PICNODE *pic) {
    3683:	55                   	push   %ebp
    3684:	89 e5                	mov    %esp,%ebp
    3686:	53                   	push   %ebx
    3687:	81 ec 84 00 00 00    	sub    $0x84,%esp
	int W = 15;
    368d:	c7 45 ec 0f 00 00 00 	movl   $0xf,-0x14(%ebp)
	Rect r1 = initRect(0, 0, W, W);
    3694:	8d 45 dc             	lea    -0x24(%ebp),%eax
    3697:	8b 55 ec             	mov    -0x14(%ebp),%edx
    369a:	89 54 24 10          	mov    %edx,0x10(%esp)
    369e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    36a1:	89 54 24 0c          	mov    %edx,0xc(%esp)
    36a5:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    36ac:	00 
    36ad:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    36b4:	00 
    36b5:	89 04 24             	mov    %eax,(%esp)
    36b8:	e8 80 02 00 00       	call   393d <initRect>
    36bd:	83 ec 04             	sub    $0x4,%esp
	Rect r2 = initRect(pic->width - W, 0, W, W);
    36c0:	8b 45 08             	mov    0x8(%ebp),%eax
    36c3:	8b 40 04             	mov    0x4(%eax),%eax
    36c6:	2b 45 ec             	sub    -0x14(%ebp),%eax
    36c9:	89 c2                	mov    %eax,%edx
    36cb:	8d 45 cc             	lea    -0x34(%ebp),%eax
    36ce:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    36d1:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    36d5:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    36d8:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    36dc:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    36e3:	00 
    36e4:	89 54 24 04          	mov    %edx,0x4(%esp)
    36e8:	89 04 24             	mov    %eax,(%esp)
    36eb:	e8 4d 02 00 00       	call   393d <initRect>
    36f0:	83 ec 04             	sub    $0x4,%esp
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
    36f3:	8b 45 08             	mov    0x8(%ebp),%eax
    36f6:	8b 40 08             	mov    0x8(%eax),%eax
    36f9:	2b 45 ec             	sub    -0x14(%ebp),%eax
    36fc:	89 c1                	mov    %eax,%ecx
    36fe:	8b 45 08             	mov    0x8(%ebp),%eax
    3701:	8b 40 04             	mov    0x4(%eax),%eax
    3704:	2b 45 ec             	sub    -0x14(%ebp),%eax
    3707:	89 c2                	mov    %eax,%edx
    3709:	8d 45 bc             	lea    -0x44(%ebp),%eax
    370c:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    370f:	89 5c 24 10          	mov    %ebx,0x10(%esp)
    3713:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    3716:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    371a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    371e:	89 54 24 04          	mov    %edx,0x4(%esp)
    3722:	89 04 24             	mov    %eax,(%esp)
    3725:	e8 13 02 00 00       	call   393d <initRect>
    372a:	83 ec 04             	sub    $0x4,%esp
	Rect r4 = initRect(0, pic->height - W, W, W);
    372d:	8b 45 08             	mov    0x8(%ebp),%eax
    3730:	8b 40 08             	mov    0x8(%eax),%eax
    3733:	2b 45 ec             	sub    -0x14(%ebp),%eax
    3736:	89 c2                	mov    %eax,%edx
    3738:	8d 45 ac             	lea    -0x54(%ebp),%eax
    373b:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    373e:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    3742:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    3745:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    3749:	89 54 24 08          	mov    %edx,0x8(%esp)
    374d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3754:	00 
    3755:	89 04 24             	mov    %eax,(%esp)
    3758:	e8 e0 01 00 00       	call   393d <initRect>
    375d:	83 ec 04             	sub    $0x4,%esp
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
    3760:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3767:	e9 96 01 00 00       	jmp    3902 <set_icon_alpha+0x27f>
		for (j = 0; j < pic->height; j++) {
    376c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3773:	e9 77 01 00 00       	jmp    38ef <set_icon_alpha+0x26c>
			p = initPoint(i, j);
    3778:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    377b:	8b 55 f0             	mov    -0x10(%ebp),%edx
    377e:	89 54 24 08          	mov    %edx,0x8(%esp)
    3782:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3785:	89 54 24 04          	mov    %edx,0x4(%esp)
    3789:	89 04 24             	mov    %eax,(%esp)
    378c:	e8 85 01 00 00       	call   3916 <initPoint>
    3791:	83 ec 04             	sub    $0x4,%esp
			if (isIn(p, r1) || isIn(p, r2) || isIn(p, r3) || isIn(p, r4)) {
    3794:	8b 45 dc             	mov    -0x24(%ebp),%eax
    3797:	89 44 24 08          	mov    %eax,0x8(%esp)
    379b:	8b 45 e0             	mov    -0x20(%ebp),%eax
    379e:	89 44 24 0c          	mov    %eax,0xc(%esp)
    37a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    37a5:	89 44 24 10          	mov    %eax,0x10(%esp)
    37a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    37ac:	89 44 24 14          	mov    %eax,0x14(%esp)
    37b0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    37b3:	8b 55 a8             	mov    -0x58(%ebp),%edx
    37b6:	89 04 24             	mov    %eax,(%esp)
    37b9:	89 54 24 04          	mov    %edx,0x4(%esp)
    37bd:	e8 d6 01 00 00       	call   3998 <isIn>
    37c2:	85 c0                	test   %eax,%eax
    37c4:	0f 85 9a 00 00 00    	jne    3864 <set_icon_alpha+0x1e1>
    37ca:	8b 45 cc             	mov    -0x34(%ebp),%eax
    37cd:	89 44 24 08          	mov    %eax,0x8(%esp)
    37d1:	8b 45 d0             	mov    -0x30(%ebp),%eax
    37d4:	89 44 24 0c          	mov    %eax,0xc(%esp)
    37d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    37db:	89 44 24 10          	mov    %eax,0x10(%esp)
    37df:	8b 45 d8             	mov    -0x28(%ebp),%eax
    37e2:	89 44 24 14          	mov    %eax,0x14(%esp)
    37e6:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    37e9:	8b 55 a8             	mov    -0x58(%ebp),%edx
    37ec:	89 04 24             	mov    %eax,(%esp)
    37ef:	89 54 24 04          	mov    %edx,0x4(%esp)
    37f3:	e8 a0 01 00 00       	call   3998 <isIn>
    37f8:	85 c0                	test   %eax,%eax
    37fa:	75 68                	jne    3864 <set_icon_alpha+0x1e1>
    37fc:	8b 45 bc             	mov    -0x44(%ebp),%eax
    37ff:	89 44 24 08          	mov    %eax,0x8(%esp)
    3803:	8b 45 c0             	mov    -0x40(%ebp),%eax
    3806:	89 44 24 0c          	mov    %eax,0xc(%esp)
    380a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    380d:	89 44 24 10          	mov    %eax,0x10(%esp)
    3811:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3814:	89 44 24 14          	mov    %eax,0x14(%esp)
    3818:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    381b:	8b 55 a8             	mov    -0x58(%ebp),%edx
    381e:	89 04 24             	mov    %eax,(%esp)
    3821:	89 54 24 04          	mov    %edx,0x4(%esp)
    3825:	e8 6e 01 00 00       	call   3998 <isIn>
    382a:	85 c0                	test   %eax,%eax
    382c:	75 36                	jne    3864 <set_icon_alpha+0x1e1>
    382e:	8b 45 ac             	mov    -0x54(%ebp),%eax
    3831:	89 44 24 08          	mov    %eax,0x8(%esp)
    3835:	8b 45 b0             	mov    -0x50(%ebp),%eax
    3838:	89 44 24 0c          	mov    %eax,0xc(%esp)
    383c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    383f:	89 44 24 10          	mov    %eax,0x10(%esp)
    3843:	8b 45 b8             	mov    -0x48(%ebp),%eax
    3846:	89 44 24 14          	mov    %eax,0x14(%esp)
    384a:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    384d:	8b 55 a8             	mov    -0x58(%ebp),%edx
    3850:	89 04 24             	mov    %eax,(%esp)
    3853:	89 54 24 04          	mov    %edx,0x4(%esp)
    3857:	e8 3c 01 00 00       	call   3998 <isIn>
    385c:	85 c0                	test   %eax,%eax
    385e:	0f 84 87 00 00 00    	je     38eb <set_icon_alpha+0x268>
				if (pic->data[j * pic->width + i].rgbBlue == 0xff
    3864:	8b 45 08             	mov    0x8(%ebp),%eax
    3867:	8b 10                	mov    (%eax),%edx
    3869:	8b 45 08             	mov    0x8(%ebp),%eax
    386c:	8b 40 04             	mov    0x4(%eax),%eax
    386f:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    3873:	89 c1                	mov    %eax,%ecx
    3875:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3878:	01 c8                	add    %ecx,%eax
    387a:	c1 e0 02             	shl    $0x2,%eax
    387d:	01 d0                	add    %edx,%eax
    387f:	0f b6 00             	movzbl (%eax),%eax
    3882:	3c ff                	cmp    $0xff,%al
    3884:	75 65                	jne    38eb <set_icon_alpha+0x268>
						&& pic->data[j * pic->width + i].rgbGreen == 0xff
    3886:	8b 45 08             	mov    0x8(%ebp),%eax
    3889:	8b 10                	mov    (%eax),%edx
    388b:	8b 45 08             	mov    0x8(%ebp),%eax
    388e:	8b 40 04             	mov    0x4(%eax),%eax
    3891:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    3895:	89 c1                	mov    %eax,%ecx
    3897:	8b 45 f4             	mov    -0xc(%ebp),%eax
    389a:	01 c8                	add    %ecx,%eax
    389c:	c1 e0 02             	shl    $0x2,%eax
    389f:	01 d0                	add    %edx,%eax
    38a1:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    38a5:	3c ff                	cmp    $0xff,%al
    38a7:	75 42                	jne    38eb <set_icon_alpha+0x268>
						&& pic->data[j * pic->width + i].rgbRed == 0xff) {
    38a9:	8b 45 08             	mov    0x8(%ebp),%eax
    38ac:	8b 10                	mov    (%eax),%edx
    38ae:	8b 45 08             	mov    0x8(%ebp),%eax
    38b1:	8b 40 04             	mov    0x4(%eax),%eax
    38b4:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    38b8:	89 c1                	mov    %eax,%ecx
    38ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    38bd:	01 c8                	add    %ecx,%eax
    38bf:	c1 e0 02             	shl    $0x2,%eax
    38c2:	01 d0                	add    %edx,%eax
    38c4:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    38c8:	3c ff                	cmp    $0xff,%al
    38ca:	75 1f                	jne    38eb <set_icon_alpha+0x268>
					pic->data[j * pic->width + i].rgbReserved = 1;
    38cc:	8b 45 08             	mov    0x8(%ebp),%eax
    38cf:	8b 10                	mov    (%eax),%edx
    38d1:	8b 45 08             	mov    0x8(%ebp),%eax
    38d4:	8b 40 04             	mov    0x4(%eax),%eax
    38d7:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    38db:	89 c1                	mov    %eax,%ecx
    38dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    38e0:	01 c8                	add    %ecx,%eax
    38e2:	c1 e0 02             	shl    $0x2,%eax
    38e5:	01 d0                	add    %edx,%eax
    38e7:	c6 40 03 01          	movb   $0x1,0x3(%eax)
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
	Rect r4 = initRect(0, pic->height - W, W, W);
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
		for (j = 0; j < pic->height; j++) {
    38eb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    38ef:	8b 45 08             	mov    0x8(%ebp),%eax
    38f2:	8b 40 08             	mov    0x8(%eax),%eax
    38f5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    38f8:	0f 8f 7a fe ff ff    	jg     3778 <set_icon_alpha+0xf5>
	Rect r2 = initRect(pic->width - W, 0, W, W);
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
	Rect r4 = initRect(0, pic->height - W, W, W);
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
    38fe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3902:	8b 45 08             	mov    0x8(%ebp),%eax
    3905:	8b 40 04             	mov    0x4(%eax),%eax
    3908:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    390b:	0f 8f 5b fe ff ff    	jg     376c <set_icon_alpha+0xe9>
					pic->data[j * pic->width + i].rgbReserved = 1;
				}
			}
		}
	}
}
    3911:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3914:	c9                   	leave  
    3915:	c3                   	ret    

00003916 <initPoint>:
#include "message.h"
#include "types.h"
#include "user.h"
#include "finder.h"
Point initPoint(int x, int y)
{
    3916:	55                   	push   %ebp
    3917:	89 e5                	mov    %esp,%ebp
    3919:	83 ec 10             	sub    $0x10,%esp
	Point p;
	p.x = x;
    391c:	8b 45 0c             	mov    0xc(%ebp),%eax
    391f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	p.y = y;
    3922:	8b 45 10             	mov    0x10(%ebp),%eax
    3925:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return p;
    3928:	8b 4d 08             	mov    0x8(%ebp),%ecx
    392b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    392e:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3931:	89 01                	mov    %eax,(%ecx)
    3933:	89 51 04             	mov    %edx,0x4(%ecx)
}
    3936:	8b 45 08             	mov    0x8(%ebp),%eax
    3939:	c9                   	leave  
    393a:	c2 04 00             	ret    $0x4

0000393d <initRect>:

Rect initRect(int x, int y, int w, int h)
{
    393d:	55                   	push   %ebp
    393e:	89 e5                	mov    %esp,%ebp
    3940:	83 ec 24             	sub    $0x24,%esp
	Rect r;
	r.start = initPoint(x, y);
    3943:	8d 45 e8             	lea    -0x18(%ebp),%eax
    3946:	8b 55 10             	mov    0x10(%ebp),%edx
    3949:	89 54 24 08          	mov    %edx,0x8(%esp)
    394d:	8b 55 0c             	mov    0xc(%ebp),%edx
    3950:	89 54 24 04          	mov    %edx,0x4(%esp)
    3954:	89 04 24             	mov    %eax,(%esp)
    3957:	e8 ba ff ff ff       	call   3916 <initPoint>
    395c:	83 ec 04             	sub    $0x4,%esp
    395f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3962:	8b 55 ec             	mov    -0x14(%ebp),%edx
    3965:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3968:	89 55 f4             	mov    %edx,-0xc(%ebp)
	r.width = w;
    396b:	8b 45 14             	mov    0x14(%ebp),%eax
    396e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	r.height = h;
    3971:	8b 45 18             	mov    0x18(%ebp),%eax
    3974:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return r;
    3977:	8b 45 08             	mov    0x8(%ebp),%eax
    397a:	8b 55 f0             	mov    -0x10(%ebp),%edx
    397d:	89 10                	mov    %edx,(%eax)
    397f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3982:	89 50 04             	mov    %edx,0x4(%eax)
    3985:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3988:	89 50 08             	mov    %edx,0x8(%eax)
    398b:	8b 55 fc             	mov    -0x4(%ebp),%edx
    398e:	89 50 0c             	mov    %edx,0xc(%eax)
}
    3991:	8b 45 08             	mov    0x8(%ebp),%eax
    3994:	c9                   	leave  
    3995:	c2 04 00             	ret    $0x4

00003998 <isIn>:

int isIn(Point p, Rect r)
{
    3998:	55                   	push   %ebp
    3999:	89 e5                	mov    %esp,%ebp
	return (p.x >= r.start.x) && (p.x < r.start.x+r.width)
    399b:	8b 55 08             	mov    0x8(%ebp),%edx
    399e:	8b 45 10             	mov    0x10(%ebp),%eax
			&& (p.y >= r.start.y) && (p.y < r.start.y+r.height);
    39a1:	39 c2                	cmp    %eax,%edx
    39a3:	7c 2f                	jl     39d4 <isIn+0x3c>
	return r;
}

int isIn(Point p, Rect r)
{
	return (p.x >= r.start.x) && (p.x < r.start.x+r.width)
    39a5:	8b 45 08             	mov    0x8(%ebp),%eax
    39a8:	8b 4d 10             	mov    0x10(%ebp),%ecx
    39ab:	8b 55 18             	mov    0x18(%ebp),%edx
    39ae:	01 ca                	add    %ecx,%edx
    39b0:	39 d0                	cmp    %edx,%eax
    39b2:	7d 20                	jge    39d4 <isIn+0x3c>
			&& (p.y >= r.start.y) && (p.y < r.start.y+r.height);
    39b4:	8b 55 0c             	mov    0xc(%ebp),%edx
    39b7:	8b 45 14             	mov    0x14(%ebp),%eax
    39ba:	39 c2                	cmp    %eax,%edx
    39bc:	7c 16                	jl     39d4 <isIn+0x3c>
    39be:	8b 45 0c             	mov    0xc(%ebp),%eax
    39c1:	8b 4d 14             	mov    0x14(%ebp),%ecx
    39c4:	8b 55 1c             	mov    0x1c(%ebp),%edx
    39c7:	01 ca                	add    %ecx,%edx
    39c9:	39 d0                	cmp    %edx,%eax
    39cb:	7d 07                	jge    39d4 <isIn+0x3c>
    39cd:	b8 01 00 00 00       	mov    $0x1,%eax
    39d2:	eb 05                	jmp    39d9 <isIn+0x41>
    39d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
    39d9:	5d                   	pop    %ebp
    39da:	c3                   	ret    

000039db <initClickManager>:

ClickableManager initClickManager(struct Context c)
{
    39db:	55                   	push   %ebp
    39dc:	89 e5                	mov    %esp,%ebp
    39de:	83 ec 20             	sub    $0x20,%esp
	ClickableManager cm;
	cm.left_click = 0;
    39e1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	cm.double_click = 0;
    39e8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	cm.right_click = 0;
    39ef:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	cm.wndWidth = c.width;
    39f6:	8b 45 10             	mov    0x10(%ebp),%eax
    39f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	cm.wndHeight = c.height;
    39fc:	8b 45 14             	mov    0x14(%ebp),%eax
    39ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return cm;
    3a02:	8b 45 08             	mov    0x8(%ebp),%eax
    3a05:	8b 55 ec             	mov    -0x14(%ebp),%edx
    3a08:	89 10                	mov    %edx,(%eax)
    3a0a:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3a0d:	89 50 04             	mov    %edx,0x4(%eax)
    3a10:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3a13:	89 50 08             	mov    %edx,0x8(%eax)
    3a16:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3a19:	89 50 0c             	mov    %edx,0xc(%eax)
    3a1c:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3a1f:	89 50 10             	mov    %edx,0x10(%eax)
}
    3a22:	8b 45 08             	mov    0x8(%ebp),%eax
    3a25:	c9                   	leave  
    3a26:	c2 04 00             	ret    $0x4

00003a29 <createClickable>:

void createClickable(ClickableManager *c, Rect r, int MsgType, Handler h)
{
    3a29:	55                   	push   %ebp
    3a2a:	89 e5                	mov    %esp,%ebp
    3a2c:	83 ec 28             	sub    $0x28,%esp
	switch (MsgType)
    3a2f:	8b 45 1c             	mov    0x1c(%ebp),%eax
    3a32:	83 f8 03             	cmp    $0x3,%eax
    3a35:	74 72                	je     3aa9 <createClickable+0x80>
    3a37:	83 f8 04             	cmp    $0x4,%eax
    3a3a:	74 0a                	je     3a46 <createClickable+0x1d>
    3a3c:	83 f8 02             	cmp    $0x2,%eax
    3a3f:	74 38                	je     3a79 <createClickable+0x50>
    3a41:	e9 96 00 00 00       	jmp    3adc <createClickable+0xb3>
	{
	    case MSG_DOUBLECLICK:
		addClickable(&c->double_click, r, h);
    3a46:	8b 45 08             	mov    0x8(%ebp),%eax
    3a49:	8d 50 04             	lea    0x4(%eax),%edx
    3a4c:	8b 45 20             	mov    0x20(%ebp),%eax
    3a4f:	89 44 24 14          	mov    %eax,0x14(%esp)
    3a53:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a56:	89 44 24 04          	mov    %eax,0x4(%esp)
    3a5a:	8b 45 10             	mov    0x10(%ebp),%eax
    3a5d:	89 44 24 08          	mov    %eax,0x8(%esp)
    3a61:	8b 45 14             	mov    0x14(%ebp),%eax
    3a64:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3a68:	8b 45 18             	mov    0x18(%ebp),%eax
    3a6b:	89 44 24 10          	mov    %eax,0x10(%esp)
    3a6f:	89 14 24             	mov    %edx,(%esp)
    3a72:	e8 7c 00 00 00       	call   3af3 <addClickable>
	        break;
    3a77:	eb 78                	jmp    3af1 <createClickable+0xc8>
	    case MSG_LPRESS:
	    	addClickable(&c->left_click, r, h);
    3a79:	8b 45 08             	mov    0x8(%ebp),%eax
    3a7c:	8b 55 20             	mov    0x20(%ebp),%edx
    3a7f:	89 54 24 14          	mov    %edx,0x14(%esp)
    3a83:	8b 55 0c             	mov    0xc(%ebp),%edx
    3a86:	89 54 24 04          	mov    %edx,0x4(%esp)
    3a8a:	8b 55 10             	mov    0x10(%ebp),%edx
    3a8d:	89 54 24 08          	mov    %edx,0x8(%esp)
    3a91:	8b 55 14             	mov    0x14(%ebp),%edx
    3a94:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3a98:	8b 55 18             	mov    0x18(%ebp),%edx
    3a9b:	89 54 24 10          	mov    %edx,0x10(%esp)
    3a9f:	89 04 24             	mov    %eax,(%esp)
    3aa2:	e8 4c 00 00 00       	call   3af3 <addClickable>
	    	break;
    3aa7:	eb 48                	jmp    3af1 <createClickable+0xc8>
	    case MSG_RPRESS:
	    	addClickable(&c->right_click, r, h);
    3aa9:	8b 45 08             	mov    0x8(%ebp),%eax
    3aac:	8d 50 08             	lea    0x8(%eax),%edx
    3aaf:	8b 45 20             	mov    0x20(%ebp),%eax
    3ab2:	89 44 24 14          	mov    %eax,0x14(%esp)
    3ab6:	8b 45 0c             	mov    0xc(%ebp),%eax
    3ab9:	89 44 24 04          	mov    %eax,0x4(%esp)
    3abd:	8b 45 10             	mov    0x10(%ebp),%eax
    3ac0:	89 44 24 08          	mov    %eax,0x8(%esp)
    3ac4:	8b 45 14             	mov    0x14(%ebp),%eax
    3ac7:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3acb:	8b 45 18             	mov    0x18(%ebp),%eax
    3ace:	89 44 24 10          	mov    %eax,0x10(%esp)
    3ad2:	89 14 24             	mov    %edx,(%esp)
    3ad5:	e8 19 00 00 00       	call   3af3 <addClickable>
	    	break;
    3ada:	eb 15                	jmp    3af1 <createClickable+0xc8>
	    default:
	    	printf(0, "向clickable传递了非鼠标点击事件！");
    3adc:	c7 44 24 04 88 b4 00 	movl   $0xb488,0x4(%esp)
    3ae3:	00 
    3ae4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3aeb:	e8 5a 0e 00 00       	call   494a <printf>
	    	break;
    3af0:	90                   	nop
	}
}
    3af1:	c9                   	leave  
    3af2:	c3                   	ret    

00003af3 <addClickable>:

void addClickable(Clickable **head, Rect r, Handler h)
{
    3af3:	55                   	push   %ebp
    3af4:	89 e5                	mov    %esp,%ebp
    3af6:	83 ec 28             	sub    $0x28,%esp
	//printf(0, "adding clickable\n");
	Clickable *c = (Clickable *)malloc(sizeof(Clickable));
    3af9:	c7 04 24 1c 00 00 00 	movl   $0x1c,(%esp)
    3b00:	e8 31 11 00 00       	call   4c36 <malloc>
    3b05:	89 45 f4             	mov    %eax,-0xc(%ebp)
	c->area = r;
    3b08:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b0b:	8b 55 0c             	mov    0xc(%ebp),%edx
    3b0e:	89 10                	mov    %edx,(%eax)
    3b10:	8b 55 10             	mov    0x10(%ebp),%edx
    3b13:	89 50 04             	mov    %edx,0x4(%eax)
    3b16:	8b 55 14             	mov    0x14(%ebp),%edx
    3b19:	89 50 08             	mov    %edx,0x8(%eax)
    3b1c:	8b 55 18             	mov    0x18(%ebp),%edx
    3b1f:	89 50 0c             	mov    %edx,0xc(%eax)
	c->handler = h;
    3b22:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b25:	8b 55 1c             	mov    0x1c(%ebp),%edx
    3b28:	89 50 10             	mov    %edx,0x10(%eax)
	c->next = *head;
    3b2b:	8b 45 08             	mov    0x8(%ebp),%eax
    3b2e:	8b 10                	mov    (%eax),%edx
    3b30:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b33:	89 50 18             	mov    %edx,0x18(%eax)
        if (*head == 0)
    3b36:	8b 45 08             	mov    0x8(%ebp),%eax
    3b39:	8b 00                	mov    (%eax),%eax
    3b3b:	85 c0                	test   %eax,%eax
    3b3d:	75 0c                	jne    3b4b <addClickable+0x58>
        {
            c->ID = 1;
    3b3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b42:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    3b49:	eb 12                	jmp    3b5d <addClickable+0x6a>
        }
        else
        {
            c->ID = c->next->ID + 1;
    3b4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b4e:	8b 40 18             	mov    0x18(%eax),%eax
    3b51:	8b 40 14             	mov    0x14(%eax),%eax
    3b54:	8d 50 01             	lea    0x1(%eax),%edx
    3b57:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b5a:	89 50 14             	mov    %edx,0x14(%eax)
        }
	*head = c;
    3b5d:	8b 45 08             	mov    0x8(%ebp),%eax
    3b60:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3b63:	89 10                	mov    %edx,(%eax)
}
    3b65:	c9                   	leave  
    3b66:	c3                   	ret    

00003b67 <deleteClickable>:

void deleteClickable(Clickable **head, Rect region)
{
    3b67:	55                   	push   %ebp
    3b68:	89 e5                	mov    %esp,%ebp
    3b6a:	83 ec 38             	sub    $0x38,%esp
	Clickable *prev, *cur, *temp;
	prev = cur = *head;
    3b6d:	8b 45 08             	mov    0x8(%ebp),%eax
    3b70:	8b 00                	mov    (%eax),%eax
    3b72:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3b75:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3b78:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (cur != 0)
    3b7b:	e9 bb 00 00 00       	jmp    3c3b <deleteClickable+0xd4>
	{
		if (isIn(cur->area.start, region))
    3b80:	8b 45 0c             	mov    0xc(%ebp),%eax
    3b83:	89 44 24 08          	mov    %eax,0x8(%esp)
    3b87:	8b 45 10             	mov    0x10(%ebp),%eax
    3b8a:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3b8e:	8b 45 14             	mov    0x14(%ebp),%eax
    3b91:	89 44 24 10          	mov    %eax,0x10(%esp)
    3b95:	8b 45 18             	mov    0x18(%ebp),%eax
    3b98:	89 44 24 14          	mov    %eax,0x14(%esp)
    3b9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3b9f:	8b 50 04             	mov    0x4(%eax),%edx
    3ba2:	8b 00                	mov    (%eax),%eax
    3ba4:	89 04 24             	mov    %eax,(%esp)
    3ba7:	89 54 24 04          	mov    %edx,0x4(%esp)
    3bab:	e8 e8 fd ff ff       	call   3998 <isIn>
    3bb0:	85 c0                	test   %eax,%eax
    3bb2:	74 60                	je     3c14 <deleteClickable+0xad>
		{
			//如果当前指针指向头部
			if (cur == *head)
    3bb4:	8b 45 08             	mov    0x8(%ebp),%eax
    3bb7:	8b 00                	mov    (%eax),%eax
    3bb9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    3bbc:	75 2e                	jne    3bec <deleteClickable+0x85>
			{
				//删除头节点
				temp = *head;
    3bbe:	8b 45 08             	mov    0x8(%ebp),%eax
    3bc1:	8b 00                	mov    (%eax),%eax
    3bc3:	89 45 ec             	mov    %eax,-0x14(%ebp)
				*head = cur->next;
    3bc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3bc9:	8b 50 18             	mov    0x18(%eax),%edx
    3bcc:	8b 45 08             	mov    0x8(%ebp),%eax
    3bcf:	89 10                	mov    %edx,(%eax)
				cur = prev = *head;
    3bd1:	8b 45 08             	mov    0x8(%ebp),%eax
    3bd4:	8b 00                	mov    (%eax),%eax
    3bd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3bd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3bdc:	89 45 f0             	mov    %eax,-0x10(%ebp)
				free(temp);
    3bdf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3be2:	89 04 24             	mov    %eax,(%esp)
    3be5:	e8 13 0f 00 00       	call   4afd <free>
    3bea:	eb 4f                	jmp    3c3b <deleteClickable+0xd4>
			}
			else
			{
				//删除当前节点
				prev->next = cur->next;
    3bec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3bef:	8b 50 18             	mov    0x18(%eax),%edx
    3bf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3bf5:	89 50 18             	mov    %edx,0x18(%eax)
				temp = cur;
    3bf8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3bfb:	89 45 ec             	mov    %eax,-0x14(%ebp)
				cur = cur->next;
    3bfe:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3c01:	8b 40 18             	mov    0x18(%eax),%eax
    3c04:	89 45 f0             	mov    %eax,-0x10(%ebp)
				free(temp);
    3c07:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3c0a:	89 04 24             	mov    %eax,(%esp)
    3c0d:	e8 eb 0e 00 00       	call   4afd <free>
    3c12:	eb 27                	jmp    3c3b <deleteClickable+0xd4>
			}
		}
		else
		{
			//如果当前节点是头节点，
			if (cur == *head)
    3c14:	8b 45 08             	mov    0x8(%ebp),%eax
    3c17:	8b 00                	mov    (%eax),%eax
    3c19:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    3c1c:	75 0b                	jne    3c29 <deleteClickable+0xc2>
			{
				cur = cur->next;
    3c1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3c21:	8b 40 18             	mov    0x18(%eax),%eax
    3c24:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3c27:	eb 12                	jmp    3c3b <deleteClickable+0xd4>
			}
			else
			{
				cur = cur->next;
    3c29:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3c2c:	8b 40 18             	mov    0x18(%eax),%eax
    3c2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
				prev = prev->next;
    3c32:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3c35:	8b 40 18             	mov    0x18(%eax),%eax
    3c38:	89 45 f4             	mov    %eax,-0xc(%ebp)

void deleteClickable(Clickable **head, Rect region)
{
	Clickable *prev, *cur, *temp;
	prev = cur = *head;
	while (cur != 0)
    3c3b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3c3f:	0f 85 3b ff ff ff    	jne    3b80 <deleteClickable+0x19>
				cur = cur->next;
				prev = prev->next;
			}
		}
	}
}
    3c45:	c9                   	leave  
    3c46:	c3                   	ret    

00003c47 <executeHandler>:

int executeHandler(Clickable *head, Point click)
{
    3c47:	55                   	push   %ebp
    3c48:	89 e5                	mov    %esp,%ebp
    3c4a:	83 ec 38             	sub    $0x38,%esp
	Clickable *cur = head;
    3c4d:	8b 45 08             	mov    0x8(%ebp),%eax
    3c50:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (cur != 0)
    3c53:	eb 6e                	jmp    3cc3 <executeHandler+0x7c>
	{
		if (isIn(click, cur->area))
    3c55:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3c58:	8b 10                	mov    (%eax),%edx
    3c5a:	89 54 24 08          	mov    %edx,0x8(%esp)
    3c5e:	8b 50 04             	mov    0x4(%eax),%edx
    3c61:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3c65:	8b 50 08             	mov    0x8(%eax),%edx
    3c68:	89 54 24 10          	mov    %edx,0x10(%esp)
    3c6c:	8b 40 0c             	mov    0xc(%eax),%eax
    3c6f:	89 44 24 14          	mov    %eax,0x14(%esp)
    3c73:	8b 45 0c             	mov    0xc(%ebp),%eax
    3c76:	8b 55 10             	mov    0x10(%ebp),%edx
    3c79:	89 04 24             	mov    %eax,(%esp)
    3c7c:	89 54 24 04          	mov    %edx,0x4(%esp)
    3c80:	e8 13 fd ff ff       	call   3998 <isIn>
    3c85:	85 c0                	test   %eax,%eax
    3c87:	74 31                	je     3cba <executeHandler+0x73>
		{
			renaming = 0;
    3c89:	c7 05 e4 25 01 00 00 	movl   $0x0,0x125e4
    3c90:	00 00 00 
			isSearching = 0;
    3c93:	c7 05 e0 25 01 00 00 	movl   $0x0,0x125e0
    3c9a:	00 00 00 
			cur->handler(click);
    3c9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ca0:	8b 48 10             	mov    0x10(%eax),%ecx
    3ca3:	8b 45 0c             	mov    0xc(%ebp),%eax
    3ca6:	8b 55 10             	mov    0x10(%ebp),%edx
    3ca9:	89 04 24             	mov    %eax,(%esp)
    3cac:	89 54 24 04          	mov    %edx,0x4(%esp)
    3cb0:	ff d1                	call   *%ecx
			return cur->ID;
    3cb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3cb5:	8b 40 14             	mov    0x14(%eax),%eax
    3cb8:	eb 4d                	jmp    3d07 <executeHandler+0xc0>
		}
		cur = cur->next;
    3cba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3cbd:	8b 40 18             	mov    0x18(%eax),%eax
    3cc0:	89 45 f4             	mov    %eax,-0xc(%ebp)
}

int executeHandler(Clickable *head, Point click)
{
	Clickable *cur = head;
	while (cur != 0)
    3cc3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3cc7:	75 8c                	jne    3c55 <executeHandler+0xe>
			cur->handler(click);
			return cur->ID;
		}
		cur = cur->next;
	}
	isSearching = 0;
    3cc9:	c7 05 e0 25 01 00 00 	movl   $0x0,0x125e0
    3cd0:	00 00 00 
	if (renaming == 1){
    3cd3:	a1 e4 25 01 00       	mov    0x125e4,%eax
    3cd8:	83 f8 01             	cmp    $0x1,%eax
    3cdb:	75 11                	jne    3cee <executeHandler+0xa7>
		renaming = 0;
    3cdd:	c7 05 e4 25 01 00 00 	movl   $0x0,0x125e4
    3ce4:	00 00 00 
		return -1;
    3ce7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3cec:	eb 19                	jmp    3d07 <executeHandler+0xc0>
	}
	printf(0, "execute: none!\n");
    3cee:	c7 44 24 04 b6 b4 00 	movl   $0xb4b6,0x4(%esp)
    3cf5:	00 
    3cf6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3cfd:	e8 48 0c 00 00       	call   494a <printf>
	return 0;
    3d02:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3d07:	c9                   	leave  
    3d08:	c3                   	ret    

00003d09 <printClickable>:

void printClickable(Clickable *c)
{
    3d09:	55                   	push   %ebp
    3d0a:	89 e5                	mov    %esp,%ebp
    3d0c:	53                   	push   %ebx
    3d0d:	83 ec 24             	sub    $0x24,%esp
	printf(0, "(%d, %d, %d, %d)\n", c->area.start.x, c->area.start.y, c->area.width, c->area.height);
    3d10:	8b 45 08             	mov    0x8(%ebp),%eax
    3d13:	8b 58 0c             	mov    0xc(%eax),%ebx
    3d16:	8b 45 08             	mov    0x8(%ebp),%eax
    3d19:	8b 48 08             	mov    0x8(%eax),%ecx
    3d1c:	8b 45 08             	mov    0x8(%ebp),%eax
    3d1f:	8b 50 04             	mov    0x4(%eax),%edx
    3d22:	8b 45 08             	mov    0x8(%ebp),%eax
    3d25:	8b 00                	mov    (%eax),%eax
    3d27:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    3d2b:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    3d2f:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3d33:	89 44 24 08          	mov    %eax,0x8(%esp)
    3d37:	c7 44 24 04 c6 b4 00 	movl   $0xb4c6,0x4(%esp)
    3d3e:	00 
    3d3f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d46:	e8 ff 0b 00 00       	call   494a <printf>
}
    3d4b:	83 c4 24             	add    $0x24,%esp
    3d4e:	5b                   	pop    %ebx
    3d4f:	5d                   	pop    %ebp
    3d50:	c3                   	ret    

00003d51 <printClickableList>:

void printClickableList(Clickable *head)
{
    3d51:	55                   	push   %ebp
    3d52:	89 e5                	mov    %esp,%ebp
    3d54:	83 ec 28             	sub    $0x28,%esp
	Clickable *cur = head;
    3d57:	8b 45 08             	mov    0x8(%ebp),%eax
    3d5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(0, "Clickable List:\n");
    3d5d:	c7 44 24 04 d8 b4 00 	movl   $0xb4d8,0x4(%esp)
    3d64:	00 
    3d65:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d6c:	e8 d9 0b 00 00       	call   494a <printf>
	while(cur != 0)
    3d71:	eb 14                	jmp    3d87 <printClickableList+0x36>
	{
		printClickable(cur);
    3d73:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d76:	89 04 24             	mov    %eax,(%esp)
    3d79:	e8 8b ff ff ff       	call   3d09 <printClickable>
		cur = cur->next;
    3d7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d81:	8b 40 18             	mov    0x18(%eax),%eax
    3d84:	89 45 f4             	mov    %eax,-0xc(%ebp)

void printClickableList(Clickable *head)
{
	Clickable *cur = head;
	printf(0, "Clickable List:\n");
	while(cur != 0)
    3d87:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3d8b:	75 e6                	jne    3d73 <printClickableList+0x22>
	{
		printClickable(cur);
		cur = cur->next;
	}
	printf(0, "\n");
    3d8d:	c7 44 24 04 e9 b4 00 	movl   $0xb4e9,0x4(%esp)
    3d94:	00 
    3d95:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3d9c:	e8 a9 0b 00 00       	call   494a <printf>
}
    3da1:	c9                   	leave  
    3da2:	c3                   	ret    

00003da3 <testHanler>:

void testHanler(struct Point p)
{
    3da3:	55                   	push   %ebp
    3da4:	89 e5                	mov    %esp,%ebp
    3da6:	83 ec 18             	sub    $0x18,%esp
	printf(0, "execute: (%d, %d)!\n", p.x, p.y);
    3da9:	8b 55 0c             	mov    0xc(%ebp),%edx
    3dac:	8b 45 08             	mov    0x8(%ebp),%eax
    3daf:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3db3:	89 44 24 08          	mov    %eax,0x8(%esp)
    3db7:	c7 44 24 04 eb b4 00 	movl   $0xb4eb,0x4(%esp)
    3dbe:	00 
    3dbf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3dc6:	e8 7f 0b 00 00       	call   494a <printf>
}
    3dcb:	c9                   	leave  
    3dcc:	c3                   	ret    

00003dcd <testClickable>:
void testClickable(struct Context c)
{
    3dcd:	55                   	push   %ebp
    3dce:	89 e5                	mov    %esp,%ebp
    3dd0:	81 ec 98 00 00 00    	sub    $0x98,%esp
	ClickableManager cm = initClickManager(c);
    3dd6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3dd9:	8b 55 08             	mov    0x8(%ebp),%edx
    3ddc:	89 54 24 04          	mov    %edx,0x4(%esp)
    3de0:	8b 55 0c             	mov    0xc(%ebp),%edx
    3de3:	89 54 24 08          	mov    %edx,0x8(%esp)
    3de7:	8b 55 10             	mov    0x10(%ebp),%edx
    3dea:	89 54 24 0c          	mov    %edx,0xc(%esp)
    3dee:	89 04 24             	mov    %eax,(%esp)
    3df1:	e8 e5 fb ff ff       	call   39db <initClickManager>
    3df6:	83 ec 04             	sub    $0x4,%esp

	Rect r1 = initRect(5,5,20,20);
    3df9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    3dfc:	c7 44 24 10 14 00 00 	movl   $0x14,0x10(%esp)
    3e03:	00 
    3e04:	c7 44 24 0c 14 00 00 	movl   $0x14,0xc(%esp)
    3e0b:	00 
    3e0c:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    3e13:	00 
    3e14:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    3e1b:	00 
    3e1c:	89 04 24             	mov    %eax,(%esp)
    3e1f:	e8 19 fb ff ff       	call   393d <initRect>
    3e24:	83 ec 04             	sub    $0x4,%esp
	Rect r2 = initRect(20,20,20,20);
    3e27:	8d 45 c4             	lea    -0x3c(%ebp),%eax
    3e2a:	c7 44 24 10 14 00 00 	movl   $0x14,0x10(%esp)
    3e31:	00 
    3e32:	c7 44 24 0c 14 00 00 	movl   $0x14,0xc(%esp)
    3e39:	00 
    3e3a:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
    3e41:	00 
    3e42:	c7 44 24 04 14 00 00 	movl   $0x14,0x4(%esp)
    3e49:	00 
    3e4a:	89 04 24             	mov    %eax,(%esp)
    3e4d:	e8 eb fa ff ff       	call   393d <initRect>
    3e52:	83 ec 04             	sub    $0x4,%esp
	Rect r3 = initRect(50,50,15,15);
    3e55:	8d 45 b4             	lea    -0x4c(%ebp),%eax
    3e58:	c7 44 24 10 0f 00 00 	movl   $0xf,0x10(%esp)
    3e5f:	00 
    3e60:	c7 44 24 0c 0f 00 00 	movl   $0xf,0xc(%esp)
    3e67:	00 
    3e68:	c7 44 24 08 32 00 00 	movl   $0x32,0x8(%esp)
    3e6f:	00 
    3e70:	c7 44 24 04 32 00 00 	movl   $0x32,0x4(%esp)
    3e77:	00 
    3e78:	89 04 24             	mov    %eax,(%esp)
    3e7b:	e8 bd fa ff ff       	call   393d <initRect>
    3e80:	83 ec 04             	sub    $0x4,%esp
	Rect r4 = initRect(0,0,30,30);
    3e83:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3e86:	c7 44 24 10 1e 00 00 	movl   $0x1e,0x10(%esp)
    3e8d:	00 
    3e8e:	c7 44 24 0c 1e 00 00 	movl   $0x1e,0xc(%esp)
    3e95:	00 
    3e96:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    3e9d:	00 
    3e9e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3ea5:	00 
    3ea6:	89 04 24             	mov    %eax,(%esp)
    3ea9:	e8 8f fa ff ff       	call   393d <initRect>
    3eae:	83 ec 04             	sub    $0x4,%esp
	Point p1 = initPoint(23, 23);
    3eb1:	8d 45 9c             	lea    -0x64(%ebp),%eax
    3eb4:	c7 44 24 08 17 00 00 	movl   $0x17,0x8(%esp)
    3ebb:	00 
    3ebc:	c7 44 24 04 17 00 00 	movl   $0x17,0x4(%esp)
    3ec3:	00 
    3ec4:	89 04 24             	mov    %eax,(%esp)
    3ec7:	e8 4a fa ff ff       	call   3916 <initPoint>
    3ecc:	83 ec 04             	sub    $0x4,%esp
	Point p2 = initPoint(70, 70);
    3ecf:	8d 45 94             	lea    -0x6c(%ebp),%eax
    3ed2:	c7 44 24 08 46 00 00 	movl   $0x46,0x8(%esp)
    3ed9:	00 
    3eda:	c7 44 24 04 46 00 00 	movl   $0x46,0x4(%esp)
    3ee1:	00 
    3ee2:	89 04 24             	mov    %eax,(%esp)
    3ee5:	e8 2c fa ff ff       	call   3916 <initPoint>
    3eea:	83 ec 04             	sub    $0x4,%esp
	createClickable(&cm, r1, MSG_LPRESS, &testHanler);
    3eed:	c7 44 24 18 a3 3d 00 	movl   $0x3da3,0x18(%esp)
    3ef4:	00 
    3ef5:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    3efc:	00 
    3efd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3f00:	89 44 24 04          	mov    %eax,0x4(%esp)
    3f04:	8b 45 d8             	mov    -0x28(%ebp),%eax
    3f07:	89 44 24 08          	mov    %eax,0x8(%esp)
    3f0b:	8b 45 dc             	mov    -0x24(%ebp),%eax
    3f0e:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3f12:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3f15:	89 44 24 10          	mov    %eax,0x10(%esp)
    3f19:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3f1c:	89 04 24             	mov    %eax,(%esp)
    3f1f:	e8 05 fb ff ff       	call   3a29 <createClickable>
	printf(0, "left_click: %d\n", cm.left_click);
    3f24:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3f27:	89 44 24 08          	mov    %eax,0x8(%esp)
    3f2b:	c7 44 24 04 ff b4 00 	movl   $0xb4ff,0x4(%esp)
    3f32:	00 
    3f33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3f3a:	e8 0b 0a 00 00       	call   494a <printf>
	createClickable(&cm, r2, MSG_LPRESS, &testHanler);
    3f3f:	c7 44 24 18 a3 3d 00 	movl   $0x3da3,0x18(%esp)
    3f46:	00 
    3f47:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    3f4e:	00 
    3f4f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    3f52:	89 44 24 04          	mov    %eax,0x4(%esp)
    3f56:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3f59:	89 44 24 08          	mov    %eax,0x8(%esp)
    3f5d:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3f60:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3f64:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3f67:	89 44 24 10          	mov    %eax,0x10(%esp)
    3f6b:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3f6e:	89 04 24             	mov    %eax,(%esp)
    3f71:	e8 b3 fa ff ff       	call   3a29 <createClickable>
	printf(0, "left_click: %d\n", cm.left_click);
    3f76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3f79:	89 44 24 08          	mov    %eax,0x8(%esp)
    3f7d:	c7 44 24 04 ff b4 00 	movl   $0xb4ff,0x4(%esp)
    3f84:	00 
    3f85:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3f8c:	e8 b9 09 00 00       	call   494a <printf>
	createClickable(&cm, r3, MSG_LPRESS, &testHanler);
    3f91:	c7 44 24 18 a3 3d 00 	movl   $0x3da3,0x18(%esp)
    3f98:	00 
    3f99:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
    3fa0:	00 
    3fa1:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    3fa4:	89 44 24 04          	mov    %eax,0x4(%esp)
    3fa8:	8b 45 b8             	mov    -0x48(%ebp),%eax
    3fab:	89 44 24 08          	mov    %eax,0x8(%esp)
    3faf:	8b 45 bc             	mov    -0x44(%ebp),%eax
    3fb2:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3fb6:	8b 45 c0             	mov    -0x40(%ebp),%eax
    3fb9:	89 44 24 10          	mov    %eax,0x10(%esp)
    3fbd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3fc0:	89 04 24             	mov    %eax,(%esp)
    3fc3:	e8 61 fa ff ff       	call   3a29 <createClickable>
	printf(0, "left_click: %d\n", cm.left_click);
    3fc8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3fcb:	89 44 24 08          	mov    %eax,0x8(%esp)
    3fcf:	c7 44 24 04 ff b4 00 	movl   $0xb4ff,0x4(%esp)
    3fd6:	00 
    3fd7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3fde:	e8 67 09 00 00       	call   494a <printf>
	printClickableList(cm.left_click);
    3fe3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3fe6:	89 04 24             	mov    %eax,(%esp)
    3fe9:	e8 63 fd ff ff       	call   3d51 <printClickableList>
	executeHandler(cm.left_click, p1);
    3fee:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    3ff1:	8b 45 9c             	mov    -0x64(%ebp),%eax
    3ff4:	8b 55 a0             	mov    -0x60(%ebp),%edx
    3ff7:	89 44 24 04          	mov    %eax,0x4(%esp)
    3ffb:	89 54 24 08          	mov    %edx,0x8(%esp)
    3fff:	89 0c 24             	mov    %ecx,(%esp)
    4002:	e8 40 fc ff ff       	call   3c47 <executeHandler>
	executeHandler(cm.left_click, p2);
    4007:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    400a:	8b 45 94             	mov    -0x6c(%ebp),%eax
    400d:	8b 55 98             	mov    -0x68(%ebp),%edx
    4010:	89 44 24 04          	mov    %eax,0x4(%esp)
    4014:	89 54 24 08          	mov    %edx,0x8(%esp)
    4018:	89 0c 24             	mov    %ecx,(%esp)
    401b:	e8 27 fc ff ff       	call   3c47 <executeHandler>
	deleteClickable(&cm.left_click, r4);
    4020:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    4023:	89 44 24 04          	mov    %eax,0x4(%esp)
    4027:	8b 45 a8             	mov    -0x58(%ebp),%eax
    402a:	89 44 24 08          	mov    %eax,0x8(%esp)
    402e:	8b 45 ac             	mov    -0x54(%ebp),%eax
    4031:	89 44 24 0c          	mov    %eax,0xc(%esp)
    4035:	8b 45 b0             	mov    -0x50(%ebp),%eax
    4038:	89 44 24 10          	mov    %eax,0x10(%esp)
    403c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    403f:	89 04 24             	mov    %eax,(%esp)
    4042:	e8 20 fb ff ff       	call   3b67 <deleteClickable>
	printClickableList(cm.left_click);
    4047:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    404a:	89 04 24             	mov    %eax,(%esp)
    404d:	e8 ff fc ff ff       	call   3d51 <printClickableList>
}
    4052:	c9                   	leave  
    4053:	c3                   	ret    

00004054 <init_tasklist>:

struct taskNode* taskLinkHead = 0;
struct taskNode* taskLinkTail = 0;

int init_tasklist()
{
    4054:	55                   	push   %ebp
    4055:	89 e5                	mov    %esp,%ebp
    4057:	83 ec 68             	sub    $0x68,%esp
    int fd;
    char nodeInfo[64];
    struct taskNode* tasknode;
    fd = open("tasklist.txt", O_RDONLY);
    405a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    4061:	00 
    4062:	c7 04 24 10 b5 00 00 	movl   $0xb510,(%esp)
    4069:	e8 2c 07 00 00       	call   479a <open>
    406e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (fd < 0)
    4071:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4075:	79 08                	jns    407f <init_tasklist+0x2b>
    {
        return fd;
    4077:	8b 45 f0             	mov    -0x10(%ebp),%eax
    407a:	e9 e8 00 00 00       	jmp    4167 <init_tasklist+0x113>
    }  
    read(fd, nodeInfo, 64);
    407f:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
    4086:	00 
    4087:	8d 45 ac             	lea    -0x54(%ebp),%eax
    408a:	89 44 24 04          	mov    %eax,0x4(%esp)
    408e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4091:	89 04 24             	mov    %eax,(%esp)
    4094:	e8 d9 06 00 00       	call   4772 <read>
    if (nodeInfo[1] == ' ')
    4099:	0f b6 45 ad          	movzbl -0x53(%ebp),%eax
    409d:	3c 20                	cmp    $0x20,%al
    409f:	75 1e                	jne    40bf <init_tasklist+0x6b>
    {
        taskLinkHead = 0;
    40a1:	c7 05 f4 f3 00 00 00 	movl   $0x0,0xf3f4
    40a8:	00 00 00 
        taskLinkTail = 0;
    40ab:	c7 05 f8 f3 00 00 00 	movl   $0x0,0xf3f8
    40b2:	00 00 00 
        return 0;
    40b5:	b8 00 00 00 00       	mov    $0x0,%eax
    40ba:	e9 a8 00 00 00       	jmp    4167 <init_tasklist+0x113>
    }
    int i = 0;
    40bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (nodeInfo[i] != '\0')
    40c6:	eb 7e                	jmp    4146 <init_tasklist+0xf2>
    {
        tasknode = (TASKNODE*)malloc(sizeof(TASKNODE));
    40c8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    40cf:	e8 62 0b 00 00       	call   4c36 <malloc>
    40d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if (i == 0)
    40d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    40db:	75 32                	jne    410f <init_tasklist+0xbb>
        {
            tasknode->next = 0;
    40dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    40e0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            tasknode->appID = nodeInfo[i] - '0';
    40e7:	8d 55 ac             	lea    -0x54(%ebp),%edx
    40ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40ed:	01 d0                	add    %edx,%eax
    40ef:	0f b6 00             	movzbl (%eax),%eax
    40f2:	0f be c0             	movsbl %al,%eax
    40f5:	8d 50 d0             	lea    -0x30(%eax),%edx
    40f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    40fb:	89 10                	mov    %edx,(%eax)
            taskLinkHead = tasknode;
    40fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4100:	a3 f4 f3 00 00       	mov    %eax,0xf3f4
            taskLinkTail = tasknode;
    4105:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4108:	a3 f8 f3 00 00       	mov    %eax,0xf3f8
    410d:	eb 33                	jmp    4142 <init_tasklist+0xee>
        }
        else
        {
            tasknode->next = 0;
    410f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4112:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            tasknode->appID = nodeInfo[i] - '0';
    4119:	8d 55 ac             	lea    -0x54(%ebp),%edx
    411c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    411f:	01 d0                	add    %edx,%eax
    4121:	0f b6 00             	movzbl (%eax),%eax
    4124:	0f be c0             	movsbl %al,%eax
    4127:	8d 50 d0             	lea    -0x30(%eax),%edx
    412a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    412d:	89 10                	mov    %edx,(%eax)
            taskLinkTail->next = tasknode;
    412f:	a1 f8 f3 00 00       	mov    0xf3f8,%eax
    4134:	8b 55 ec             	mov    -0x14(%ebp),%edx
    4137:	89 50 04             	mov    %edx,0x4(%eax)
            taskLinkTail = tasknode;
    413a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    413d:	a3 f8 f3 00 00       	mov    %eax,0xf3f8
        }
        i++;
    4142:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        taskLinkHead = 0;
        taskLinkTail = 0;
        return 0;
    }
    int i = 0;
    while (nodeInfo[i] != '\0')
    4146:	8d 55 ac             	lea    -0x54(%ebp),%edx
    4149:	8b 45 f4             	mov    -0xc(%ebp),%eax
    414c:	01 d0                	add    %edx,%eax
    414e:	0f b6 00             	movzbl (%eax),%eax
    4151:	84 c0                	test   %al,%al
    4153:	0f 85 6f ff ff ff    	jne    40c8 <init_tasklist+0x74>
            taskLinkTail->next = tasknode;
            taskLinkTail = tasknode;
        }
        i++;
    }
    close(fd);
    4159:	8b 45 f0             	mov    -0x10(%ebp),%eax
    415c:	89 04 24             	mov    %eax,(%esp)
    415f:	e8 1e 06 00 00       	call   4782 <close>
    return i;
    4164:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    4167:	c9                   	leave  
    4168:	c3                   	ret    

00004169 <add_tasknodeToTail>:

void add_tasknodeToTail(int appID)
{
    4169:	55                   	push   %ebp
    416a:	89 e5                	mov    %esp,%ebp
    416c:	83 ec 28             	sub    $0x28,%esp
    printf(0, "add_tasknode called\n");
    416f:	c7 44 24 04 1d b5 00 	movl   $0xb51d,0x4(%esp)
    4176:	00 
    4177:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    417e:	e8 c7 07 00 00       	call   494a <printf>
    struct taskNode* tasknode = (TASKNODE*)malloc(sizeof(TASKNODE));
    4183:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    418a:	e8 a7 0a 00 00       	call   4c36 <malloc>
    418f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (taskLinkHead == 0)
    4192:	a1 f4 f3 00 00       	mov    0xf3f4,%eax
    4197:	85 c0                	test   %eax,%eax
    4199:	75 3f                	jne    41da <add_tasknodeToTail+0x71>
    {
        printf(0, "inserting into list %d\n", (int)tasknode);
    419b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    419e:	89 44 24 08          	mov    %eax,0x8(%esp)
    41a2:	c7 44 24 04 32 b5 00 	movl   $0xb532,0x4(%esp)
    41a9:	00 
    41aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    41b1:	e8 94 07 00 00       	call   494a <printf>
        tasknode->next = 0;
    41b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41b9:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
        tasknode->appID = appID;
    41c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41c3:	8b 55 08             	mov    0x8(%ebp),%edx
    41c6:	89 10                	mov    %edx,(%eax)
        taskLinkHead = tasknode;
    41c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41cb:	a3 f4 f3 00 00       	mov    %eax,0xf3f4
        taskLinkTail = tasknode;
    41d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41d3:	a3 f8 f3 00 00       	mov    %eax,0xf3f8
    41d8:	eb 25                	jmp    41ff <add_tasknodeToTail+0x96>
    }
    else
    {
        tasknode->next = 0;
    41da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41dd:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
        tasknode->appID = appID;
    41e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41e7:	8b 55 08             	mov    0x8(%ebp),%edx
    41ea:	89 10                	mov    %edx,(%eax)
        taskLinkTail->next = tasknode;
    41ec:	a1 f8 f3 00 00       	mov    0xf3f8,%eax
    41f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    41f4:	89 50 04             	mov    %edx,0x4(%eax)
        taskLinkTail = tasknode;
    41f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41fa:	a3 f8 f3 00 00       	mov    %eax,0xf3f8
    }
    printf(0, "task added\n");
    41ff:	c7 44 24 04 4a b5 00 	movl   $0xb54a,0x4(%esp)
    4206:	00 
    4207:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    420e:	e8 37 07 00 00       	call   494a <printf>
    save_tasklist();
    4213:	e8 1d 02 00 00       	call   4435 <save_tasklist>
}
    4218:	c9                   	leave  
    4219:	c3                   	ret    

0000421a <add_tasknode>:

void add_tasknode(int appID)
{
    421a:	55                   	push   %ebp
    421b:	89 e5                	mov    %esp,%ebp
    421d:	83 ec 28             	sub    $0x28,%esp
    struct taskNode* tasknode = (TASKNODE*)malloc(sizeof(TASKNODE));
    4220:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    4227:	e8 0a 0a 00 00       	call   4c36 <malloc>
    422c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    tasknode->next = taskLinkHead;
    422f:	8b 15 f4 f3 00 00    	mov    0xf3f4,%edx
    4235:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4238:	89 50 04             	mov    %edx,0x4(%eax)
    tasknode->appID = appID;
    423b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    423e:	8b 55 08             	mov    0x8(%ebp),%edx
    4241:	89 10                	mov    %edx,(%eax)
    if (taskLinkHead == 0)
    4243:	a1 f4 f3 00 00       	mov    0xf3f4,%eax
    4248:	85 c0                	test   %eax,%eax
    424a:	75 08                	jne    4254 <add_tasknode+0x3a>
    {
        taskLinkTail = tasknode;
    424c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    424f:	a3 f8 f3 00 00       	mov    %eax,0xf3f8
    }
    taskLinkHead = tasknode;
    4254:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4257:	a3 f4 f3 00 00       	mov    %eax,0xf3f4
    save_tasklist();
    425c:	e8 d4 01 00 00       	call   4435 <save_tasklist>
}
    4261:	c9                   	leave  
    4262:	c3                   	ret    

00004263 <delete_tasknode>:

void delete_tasknode(int appID)
{
    4263:	55                   	push   %ebp
    4264:	89 e5                	mov    %esp,%ebp
    4266:	83 ec 28             	sub    $0x28,%esp
    printf(0, "delete_tasknode called\n");
    4269:	c7 44 24 04 56 b5 00 	movl   $0xb556,0x4(%esp)
    4270:	00 
    4271:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4278:	e8 cd 06 00 00       	call   494a <printf>
    if (taskLinkHead == 0)
    427d:	a1 f4 f3 00 00       	mov    0xf3f4,%eax
    4282:	85 c0                	test   %eax,%eax
    4284:	75 19                	jne    429f <delete_tasknode+0x3c>
    {
        printf(0, "delete error: nothing to delete\n");
    4286:	c7 44 24 04 70 b5 00 	movl   $0xb570,0x4(%esp)
    428d:	00 
    428e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4295:	e8 b0 06 00 00       	call   494a <printf>
        return;
    429a:	e9 bf 00 00 00       	jmp    435e <delete_tasknode+0xfb>
    }
    struct taskNode* tasknode = taskLinkHead;
    429f:	a1 f4 f3 00 00       	mov    0xf3f4,%eax
    42a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    struct taskNode* previousTasknode = 0;
    42a7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    while (tasknode != 0)
    42ae:	eb 1b                	jmp    42cb <delete_tasknode+0x68>
    {
        if (tasknode->appID == appID)
    42b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    42b3:	8b 00                	mov    (%eax),%eax
    42b5:	3b 45 08             	cmp    0x8(%ebp),%eax
    42b8:	75 02                	jne    42bc <delete_tasknode+0x59>
        {
            break;
    42ba:	eb 15                	jmp    42d1 <delete_tasknode+0x6e>
        }
        previousTasknode = tasknode;
    42bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    42bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
        tasknode = tasknode->next;
    42c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    42c5:	8b 40 04             	mov    0x4(%eax),%eax
    42c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        printf(0, "delete error: nothing to delete\n");
        return;
    }
    struct taskNode* tasknode = taskLinkHead;
    struct taskNode* previousTasknode = 0;
    while (tasknode != 0)
    42cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    42cf:	75 df                	jne    42b0 <delete_tasknode+0x4d>
            break;
        }
        previousTasknode = tasknode;
        tasknode = tasknode->next;
    }
    if (tasknode == 0)
    42d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    42d5:	75 16                	jne    42ed <delete_tasknode+0x8a>
    {
        printf(0, "delete error: no such app to delete\n");
    42d7:	c7 44 24 04 94 b5 00 	movl   $0xb594,0x4(%esp)
    42de:	00 
    42df:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    42e6:	e8 5f 06 00 00       	call   494a <printf>
        return;
    42eb:	eb 71                	jmp    435e <delete_tasknode+0xfb>
    }
    if (previousTasknode == 0)
    42ed:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    42f1:	75 2c                	jne    431f <delete_tasknode+0xbc>
    {
        taskLinkHead = tasknode->next;
    42f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    42f6:	8b 40 04             	mov    0x4(%eax),%eax
    42f9:	a3 f4 f3 00 00       	mov    %eax,0xf3f4
        if (tasknode->next == 0)
    42fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4301:	8b 40 04             	mov    0x4(%eax),%eax
    4304:	85 c0                	test   %eax,%eax
    4306:	75 0a                	jne    4312 <delete_tasknode+0xaf>
        {
            taskLinkTail = 0;
    4308:	c7 05 f8 f3 00 00 00 	movl   $0x0,0xf3f8
    430f:	00 00 00 
        }
        free(tasknode);
    4312:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4315:	89 04 24             	mov    %eax,(%esp)
    4318:	e8 e0 07 00 00       	call   4afd <free>
    431d:	eb 2b                	jmp    434a <delete_tasknode+0xe7>
    }
    else
    {
        previousTasknode->next = tasknode->next;
    431f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4322:	8b 50 04             	mov    0x4(%eax),%edx
    4325:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4328:	89 50 04             	mov    %edx,0x4(%eax)
        if (tasknode->next == 0)
    432b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    432e:	8b 40 04             	mov    0x4(%eax),%eax
    4331:	85 c0                	test   %eax,%eax
    4333:	75 0a                	jne    433f <delete_tasknode+0xdc>
        {
            taskLinkTail = 0;
    4335:	c7 05 f8 f3 00 00 00 	movl   $0x0,0xf3f8
    433c:	00 00 00 
        }
        free(tasknode);
    433f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4342:	89 04 24             	mov    %eax,(%esp)
    4345:	e8 b3 07 00 00       	call   4afd <free>
    }
    printf(0, "delete finished\n");
    434a:	c7 44 24 04 b9 b5 00 	movl   $0xb5b9,0x4(%esp)
    4351:	00 
    4352:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4359:	e8 ec 05 00 00       	call   494a <printf>
//    save_tasklist();
}
    435e:	c9                   	leave  
    435f:	c3                   	ret    

00004360 <draw_tasklist>:

void draw_tasklist(struct Context context, PICNODE pic[])
{
    4360:	55                   	push   %ebp
    4361:	89 e5                	mov    %esp,%ebp
    4363:	83 ec 38             	sub    $0x38,%esp
    printf(0, "draw_tasknode called\n");
    4366:	c7 44 24 04 ca b5 00 	movl   $0xb5ca,0x4(%esp)
    436d:	00 
    436e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4375:	e8 d0 05 00 00       	call   494a <printf>
    struct taskNode* tasknode = taskLinkHead;
    437a:	a1 f4 f3 00 00       	mov    0xf3f4,%eax
    437f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (taskLinkHead == 0)
    4382:	a1 f4 f3 00 00       	mov    0xf3f4,%eax
    4387:	85 c0                	test   %eax,%eax
    4389:	75 19                	jne    43a4 <draw_tasklist+0x44>
    {
        printf(0, "task draw error: nothing to draw\n");
    438b:	c7 44 24 04 e0 b5 00 	movl   $0xb5e0,0x4(%esp)
    4392:	00 
    4393:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    439a:	e8 ab 05 00 00       	call   494a <printf>
        return;
    439f:	e9 8f 00 00 00       	jmp    4433 <draw_tasklist+0xd3>
    }
    int i = 1;
    43a4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    while (tasknode != 0)
    43ab:	eb 6c                	jmp    4419 <draw_tasklist+0xb9>
    {
        draw_picture(context, pic[tasknode->appID - 1], 75*i, 550);
    43ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    43b0:	6b c8 4b             	imul   $0x4b,%eax,%ecx
    43b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43b6:	8b 00                	mov    (%eax),%eax
    43b8:	89 c2                	mov    %eax,%edx
    43ba:	89 d0                	mov    %edx,%eax
    43bc:	01 c0                	add    %eax,%eax
    43be:	01 d0                	add    %edx,%eax
    43c0:	c1 e0 02             	shl    $0x2,%eax
    43c3:	8d 50 f4             	lea    -0xc(%eax),%edx
    43c6:	8b 45 14             	mov    0x14(%ebp),%eax
    43c9:	01 d0                	add    %edx,%eax
    43cb:	c7 44 24 1c 26 02 00 	movl   $0x226,0x1c(%esp)
    43d2:	00 
    43d3:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    43d7:	8b 10                	mov    (%eax),%edx
    43d9:	89 54 24 0c          	mov    %edx,0xc(%esp)
    43dd:	8b 50 04             	mov    0x4(%eax),%edx
    43e0:	89 54 24 10          	mov    %edx,0x10(%esp)
    43e4:	8b 40 08             	mov    0x8(%eax),%eax
    43e7:	89 44 24 14          	mov    %eax,0x14(%esp)
    43eb:	8b 45 08             	mov    0x8(%ebp),%eax
    43ee:	89 04 24             	mov    %eax,(%esp)
    43f1:	8b 45 0c             	mov    0xc(%ebp),%eax
    43f4:	89 44 24 04          	mov    %eax,0x4(%esp)
    43f8:	8b 45 10             	mov    0x10(%ebp),%eax
    43fb:	89 44 24 08          	mov    %eax,0x8(%esp)
    43ff:	e8 8e e7 ff ff       	call   2b92 <draw_picture>
        tasknode = tasknode->next;
    4404:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4407:	8b 40 04             	mov    0x4(%eax),%eax
    440a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        i++;
    440d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
        if (i == 11)
    4411:	83 7d f0 0b          	cmpl   $0xb,-0x10(%ebp)
    4415:	75 02                	jne    4419 <draw_tasklist+0xb9>
        {
            break;
    4417:	eb 06                	jmp    441f <draw_tasklist+0xbf>
    {
        printf(0, "task draw error: nothing to draw\n");
        return;
    }
    int i = 1;
    while (tasknode != 0)
    4419:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    441d:	75 8e                	jne    43ad <draw_tasklist+0x4d>
        if (i == 11)
        {
            break;
        }
    }
    printf(0, "draw finished\n");   
    441f:	c7 44 24 04 02 b6 00 	movl   $0xb602,0x4(%esp)
    4426:	00 
    4427:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    442e:	e8 17 05 00 00       	call   494a <printf>
}
    4433:	c9                   	leave  
    4434:	c3                   	ret    

00004435 <save_tasklist>:

int save_tasklist()
{
    4435:	55                   	push   %ebp
    4436:	89 e5                	mov    %esp,%ebp
    4438:	81 ec 88 00 00 00    	sub    $0x88,%esp
    int fd;
    fd = open("tasklist.txt", O_WRONLY | O_CREATE);
    443e:	c7 44 24 04 01 02 00 	movl   $0x201,0x4(%esp)
    4445:	00 
    4446:	c7 04 24 10 b5 00 00 	movl   $0xb510,(%esp)
    444d:	e8 48 03 00 00       	call   479a <open>
    4452:	89 45 ec             	mov    %eax,-0x14(%ebp)
    struct taskNode* tasknode = taskLinkHead;
    4455:	a1 f4 f3 00 00       	mov    0xf3f4,%eax
    445a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    char nodeInfo[100];
    if (taskLinkHead == 0)
    445d:	a1 f4 f3 00 00       	mov    0xf3f4,%eax
    4462:	85 c0                	test   %eax,%eax
    4464:	75 30                	jne    4496 <save_tasklist+0x61>
    {
        nodeInfo[0] = ' ';
    4466:	c6 45 88 20          	movb   $0x20,-0x78(%ebp)
        nodeInfo[1] = '\0';
    446a:	c6 45 89 00          	movb   $0x0,-0x77(%ebp)
        write(fd, nodeInfo, strlen(nodeInfo));
    446e:	8d 45 88             	lea    -0x78(%ebp),%eax
    4471:	89 04 24             	mov    %eax,(%esp)
    4474:	e8 0d 01 00 00       	call   4586 <strlen>
    4479:	89 44 24 08          	mov    %eax,0x8(%esp)
    447d:	8d 45 88             	lea    -0x78(%ebp),%eax
    4480:	89 44 24 04          	mov    %eax,0x4(%esp)
    4484:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4487:	89 04 24             	mov    %eax,(%esp)
    448a:	e8 eb 02 00 00       	call   477a <write>
        return 0;
    448f:	b8 00 00 00 00       	mov    $0x0,%eax
    4494:	eb 5a                	jmp    44f0 <save_tasklist+0xbb>
    }
    int i = 0;
    4496:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    while (tasknode != 0)
    449d:	eb 27                	jmp    44c6 <save_tasklist+0x91>
    {
        nodeInfo[i] = tasknode->appID + '0';
    449f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44a2:	8b 00                	mov    (%eax),%eax
    44a4:	83 c0 30             	add    $0x30,%eax
    44a7:	8d 4d 88             	lea    -0x78(%ebp),%ecx
    44aa:	8b 55 f0             	mov    -0x10(%ebp),%edx
    44ad:	01 ca                	add    %ecx,%edx
    44af:	88 02                	mov    %al,(%edx)
        tasknode = tasknode->next;
    44b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44b4:	8b 40 04             	mov    0x4(%eax),%eax
    44b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        i++;
    44ba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
        if (i == 100)
    44be:	83 7d f0 64          	cmpl   $0x64,-0x10(%ebp)
    44c2:	75 02                	jne    44c6 <save_tasklist+0x91>
        {
            break;
    44c4:	eb 06                	jmp    44cc <save_tasklist+0x97>
        nodeInfo[1] = '\0';
        write(fd, nodeInfo, strlen(nodeInfo));
        return 0;
    }
    int i = 0;
    while (tasknode != 0)
    44c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    44ca:	75 d3                	jne    449f <save_tasklist+0x6a>
        if (i == 100)
        {
            break;
        }
    }
    write(fd, nodeInfo, strlen(nodeInfo));
    44cc:	8d 45 88             	lea    -0x78(%ebp),%eax
    44cf:	89 04 24             	mov    %eax,(%esp)
    44d2:	e8 af 00 00 00       	call   4586 <strlen>
    44d7:	89 44 24 08          	mov    %eax,0x8(%esp)
    44db:	8d 45 88             	lea    -0x78(%ebp),%eax
    44de:	89 44 24 04          	mov    %eax,0x4(%esp)
    44e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    44e5:	89 04 24             	mov    %eax,(%esp)
    44e8:	e8 8d 02 00 00       	call   477a <write>
    return i;
    44ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    44f0:	c9                   	leave  
    44f1:	c3                   	ret    

000044f2 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    44f2:	55                   	push   %ebp
    44f3:	89 e5                	mov    %esp,%ebp
    44f5:	57                   	push   %edi
    44f6:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    44f7:	8b 4d 08             	mov    0x8(%ebp),%ecx
    44fa:	8b 55 10             	mov    0x10(%ebp),%edx
    44fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    4500:	89 cb                	mov    %ecx,%ebx
    4502:	89 df                	mov    %ebx,%edi
    4504:	89 d1                	mov    %edx,%ecx
    4506:	fc                   	cld    
    4507:	f3 aa                	rep stos %al,%es:(%edi)
    4509:	89 ca                	mov    %ecx,%edx
    450b:	89 fb                	mov    %edi,%ebx
    450d:	89 5d 08             	mov    %ebx,0x8(%ebp)
    4510:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    4513:	5b                   	pop    %ebx
    4514:	5f                   	pop    %edi
    4515:	5d                   	pop    %ebp
    4516:	c3                   	ret    

00004517 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    4517:	55                   	push   %ebp
    4518:	89 e5                	mov    %esp,%ebp
    451a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    451d:	8b 45 08             	mov    0x8(%ebp),%eax
    4520:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    4523:	90                   	nop
    4524:	8b 45 08             	mov    0x8(%ebp),%eax
    4527:	8d 50 01             	lea    0x1(%eax),%edx
    452a:	89 55 08             	mov    %edx,0x8(%ebp)
    452d:	8b 55 0c             	mov    0xc(%ebp),%edx
    4530:	8d 4a 01             	lea    0x1(%edx),%ecx
    4533:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    4536:	0f b6 12             	movzbl (%edx),%edx
    4539:	88 10                	mov    %dl,(%eax)
    453b:	0f b6 00             	movzbl (%eax),%eax
    453e:	84 c0                	test   %al,%al
    4540:	75 e2                	jne    4524 <strcpy+0xd>
    ;
  return os;
    4542:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    4545:	c9                   	leave  
    4546:	c3                   	ret    

00004547 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4547:	55                   	push   %ebp
    4548:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    454a:	eb 08                	jmp    4554 <strcmp+0xd>
    p++, q++;
    454c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    4550:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    4554:	8b 45 08             	mov    0x8(%ebp),%eax
    4557:	0f b6 00             	movzbl (%eax),%eax
    455a:	84 c0                	test   %al,%al
    455c:	74 10                	je     456e <strcmp+0x27>
    455e:	8b 45 08             	mov    0x8(%ebp),%eax
    4561:	0f b6 10             	movzbl (%eax),%edx
    4564:	8b 45 0c             	mov    0xc(%ebp),%eax
    4567:	0f b6 00             	movzbl (%eax),%eax
    456a:	38 c2                	cmp    %al,%dl
    456c:	74 de                	je     454c <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    456e:	8b 45 08             	mov    0x8(%ebp),%eax
    4571:	0f b6 00             	movzbl (%eax),%eax
    4574:	0f b6 d0             	movzbl %al,%edx
    4577:	8b 45 0c             	mov    0xc(%ebp),%eax
    457a:	0f b6 00             	movzbl (%eax),%eax
    457d:	0f b6 c0             	movzbl %al,%eax
    4580:	29 c2                	sub    %eax,%edx
    4582:	89 d0                	mov    %edx,%eax
}
    4584:	5d                   	pop    %ebp
    4585:	c3                   	ret    

00004586 <strlen>:

uint
strlen(char *s)
{
    4586:	55                   	push   %ebp
    4587:	89 e5                	mov    %esp,%ebp
    4589:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    458c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    4593:	eb 04                	jmp    4599 <strlen+0x13>
    4595:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    4599:	8b 55 fc             	mov    -0x4(%ebp),%edx
    459c:	8b 45 08             	mov    0x8(%ebp),%eax
    459f:	01 d0                	add    %edx,%eax
    45a1:	0f b6 00             	movzbl (%eax),%eax
    45a4:	84 c0                	test   %al,%al
    45a6:	75 ed                	jne    4595 <strlen+0xf>
    ;
  return n;
    45a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    45ab:	c9                   	leave  
    45ac:	c3                   	ret    

000045ad <memset>:

void*
memset(void *dst, int c, uint n)
{
    45ad:	55                   	push   %ebp
    45ae:	89 e5                	mov    %esp,%ebp
    45b0:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    45b3:	8b 45 10             	mov    0x10(%ebp),%eax
    45b6:	89 44 24 08          	mov    %eax,0x8(%esp)
    45ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    45bd:	89 44 24 04          	mov    %eax,0x4(%esp)
    45c1:	8b 45 08             	mov    0x8(%ebp),%eax
    45c4:	89 04 24             	mov    %eax,(%esp)
    45c7:	e8 26 ff ff ff       	call   44f2 <stosb>
  return dst;
    45cc:	8b 45 08             	mov    0x8(%ebp),%eax
}
    45cf:	c9                   	leave  
    45d0:	c3                   	ret    

000045d1 <strchr>:

char*
strchr(const char *s, char c)
{
    45d1:	55                   	push   %ebp
    45d2:	89 e5                	mov    %esp,%ebp
    45d4:	83 ec 04             	sub    $0x4,%esp
    45d7:	8b 45 0c             	mov    0xc(%ebp),%eax
    45da:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    45dd:	eb 14                	jmp    45f3 <strchr+0x22>
    if(*s == c)
    45df:	8b 45 08             	mov    0x8(%ebp),%eax
    45e2:	0f b6 00             	movzbl (%eax),%eax
    45e5:	3a 45 fc             	cmp    -0x4(%ebp),%al
    45e8:	75 05                	jne    45ef <strchr+0x1e>
      return (char*)s;
    45ea:	8b 45 08             	mov    0x8(%ebp),%eax
    45ed:	eb 13                	jmp    4602 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    45ef:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    45f3:	8b 45 08             	mov    0x8(%ebp),%eax
    45f6:	0f b6 00             	movzbl (%eax),%eax
    45f9:	84 c0                	test   %al,%al
    45fb:	75 e2                	jne    45df <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    45fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
    4602:	c9                   	leave  
    4603:	c3                   	ret    

00004604 <gets>:

char*
gets(char *buf, int max)
{
    4604:	55                   	push   %ebp
    4605:	89 e5                	mov    %esp,%ebp
    4607:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    460a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    4611:	eb 4c                	jmp    465f <gets+0x5b>
    cc = read(0, &c, 1);
    4613:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    461a:	00 
    461b:	8d 45 ef             	lea    -0x11(%ebp),%eax
    461e:	89 44 24 04          	mov    %eax,0x4(%esp)
    4622:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    4629:	e8 44 01 00 00       	call   4772 <read>
    462e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    4631:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4635:	7f 02                	jg     4639 <gets+0x35>
      break;
    4637:	eb 31                	jmp    466a <gets+0x66>
    buf[i++] = c;
    4639:	8b 45 f4             	mov    -0xc(%ebp),%eax
    463c:	8d 50 01             	lea    0x1(%eax),%edx
    463f:	89 55 f4             	mov    %edx,-0xc(%ebp)
    4642:	89 c2                	mov    %eax,%edx
    4644:	8b 45 08             	mov    0x8(%ebp),%eax
    4647:	01 c2                	add    %eax,%edx
    4649:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    464d:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    464f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    4653:	3c 0a                	cmp    $0xa,%al
    4655:	74 13                	je     466a <gets+0x66>
    4657:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    465b:	3c 0d                	cmp    $0xd,%al
    465d:	74 0b                	je     466a <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    465f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4662:	83 c0 01             	add    $0x1,%eax
    4665:	3b 45 0c             	cmp    0xc(%ebp),%eax
    4668:	7c a9                	jl     4613 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    466a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    466d:	8b 45 08             	mov    0x8(%ebp),%eax
    4670:	01 d0                	add    %edx,%eax
    4672:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    4675:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4678:	c9                   	leave  
    4679:	c3                   	ret    

0000467a <stat>:

int
stat(char *n, struct stat *st)
{
    467a:	55                   	push   %ebp
    467b:	89 e5                	mov    %esp,%ebp
    467d:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4680:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    4687:	00 
    4688:	8b 45 08             	mov    0x8(%ebp),%eax
    468b:	89 04 24             	mov    %eax,(%esp)
    468e:	e8 07 01 00 00       	call   479a <open>
    4693:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    4696:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    469a:	79 07                	jns    46a3 <stat+0x29>
    return -1;
    469c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    46a1:	eb 23                	jmp    46c6 <stat+0x4c>
  r = fstat(fd, st);
    46a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    46a6:	89 44 24 04          	mov    %eax,0x4(%esp)
    46aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    46ad:	89 04 24             	mov    %eax,(%esp)
    46b0:	e8 fd 00 00 00       	call   47b2 <fstat>
    46b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    46b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    46bb:	89 04 24             	mov    %eax,(%esp)
    46be:	e8 bf 00 00 00       	call   4782 <close>
  return r;
    46c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    46c6:	c9                   	leave  
    46c7:	c3                   	ret    

000046c8 <atoi>:

int
atoi(const char *s)
{
    46c8:	55                   	push   %ebp
    46c9:	89 e5                	mov    %esp,%ebp
    46cb:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    46ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    46d5:	eb 25                	jmp    46fc <atoi+0x34>
    n = n*10 + *s++ - '0';
    46d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
    46da:	89 d0                	mov    %edx,%eax
    46dc:	c1 e0 02             	shl    $0x2,%eax
    46df:	01 d0                	add    %edx,%eax
    46e1:	01 c0                	add    %eax,%eax
    46e3:	89 c1                	mov    %eax,%ecx
    46e5:	8b 45 08             	mov    0x8(%ebp),%eax
    46e8:	8d 50 01             	lea    0x1(%eax),%edx
    46eb:	89 55 08             	mov    %edx,0x8(%ebp)
    46ee:	0f b6 00             	movzbl (%eax),%eax
    46f1:	0f be c0             	movsbl %al,%eax
    46f4:	01 c8                	add    %ecx,%eax
    46f6:	83 e8 30             	sub    $0x30,%eax
    46f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    46fc:	8b 45 08             	mov    0x8(%ebp),%eax
    46ff:	0f b6 00             	movzbl (%eax),%eax
    4702:	3c 2f                	cmp    $0x2f,%al
    4704:	7e 0a                	jle    4710 <atoi+0x48>
    4706:	8b 45 08             	mov    0x8(%ebp),%eax
    4709:	0f b6 00             	movzbl (%eax),%eax
    470c:	3c 39                	cmp    $0x39,%al
    470e:	7e c7                	jle    46d7 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    4710:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    4713:	c9                   	leave  
    4714:	c3                   	ret    

00004715 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    4715:	55                   	push   %ebp
    4716:	89 e5                	mov    %esp,%ebp
    4718:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    471b:	8b 45 08             	mov    0x8(%ebp),%eax
    471e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    4721:	8b 45 0c             	mov    0xc(%ebp),%eax
    4724:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    4727:	eb 17                	jmp    4740 <memmove+0x2b>
    *dst++ = *src++;
    4729:	8b 45 fc             	mov    -0x4(%ebp),%eax
    472c:	8d 50 01             	lea    0x1(%eax),%edx
    472f:	89 55 fc             	mov    %edx,-0x4(%ebp)
    4732:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4735:	8d 4a 01             	lea    0x1(%edx),%ecx
    4738:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    473b:	0f b6 12             	movzbl (%edx),%edx
    473e:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    4740:	8b 45 10             	mov    0x10(%ebp),%eax
    4743:	8d 50 ff             	lea    -0x1(%eax),%edx
    4746:	89 55 10             	mov    %edx,0x10(%ebp)
    4749:	85 c0                	test   %eax,%eax
    474b:	7f dc                	jg     4729 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    474d:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4750:	c9                   	leave  
    4751:	c3                   	ret    

00004752 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    4752:	b8 01 00 00 00       	mov    $0x1,%eax
    4757:	cd 40                	int    $0x40
    4759:	c3                   	ret    

0000475a <exit>:
SYSCALL(exit)
    475a:	b8 02 00 00 00       	mov    $0x2,%eax
    475f:	cd 40                	int    $0x40
    4761:	c3                   	ret    

00004762 <wait>:
SYSCALL(wait)
    4762:	b8 03 00 00 00       	mov    $0x3,%eax
    4767:	cd 40                	int    $0x40
    4769:	c3                   	ret    

0000476a <pipe>:
SYSCALL(pipe)
    476a:	b8 04 00 00 00       	mov    $0x4,%eax
    476f:	cd 40                	int    $0x40
    4771:	c3                   	ret    

00004772 <read>:
SYSCALL(read)
    4772:	b8 05 00 00 00       	mov    $0x5,%eax
    4777:	cd 40                	int    $0x40
    4779:	c3                   	ret    

0000477a <write>:
SYSCALL(write)
    477a:	b8 10 00 00 00       	mov    $0x10,%eax
    477f:	cd 40                	int    $0x40
    4781:	c3                   	ret    

00004782 <close>:
SYSCALL(close)
    4782:	b8 15 00 00 00       	mov    $0x15,%eax
    4787:	cd 40                	int    $0x40
    4789:	c3                   	ret    

0000478a <kill>:
SYSCALL(kill)
    478a:	b8 06 00 00 00       	mov    $0x6,%eax
    478f:	cd 40                	int    $0x40
    4791:	c3                   	ret    

00004792 <exec>:
SYSCALL(exec)
    4792:	b8 07 00 00 00       	mov    $0x7,%eax
    4797:	cd 40                	int    $0x40
    4799:	c3                   	ret    

0000479a <open>:
SYSCALL(open)
    479a:	b8 0f 00 00 00       	mov    $0xf,%eax
    479f:	cd 40                	int    $0x40
    47a1:	c3                   	ret    

000047a2 <mknod>:
SYSCALL(mknod)
    47a2:	b8 11 00 00 00       	mov    $0x11,%eax
    47a7:	cd 40                	int    $0x40
    47a9:	c3                   	ret    

000047aa <unlink>:
SYSCALL(unlink)
    47aa:	b8 12 00 00 00       	mov    $0x12,%eax
    47af:	cd 40                	int    $0x40
    47b1:	c3                   	ret    

000047b2 <fstat>:
SYSCALL(fstat)
    47b2:	b8 08 00 00 00       	mov    $0x8,%eax
    47b7:	cd 40                	int    $0x40
    47b9:	c3                   	ret    

000047ba <link>:
SYSCALL(link)
    47ba:	b8 13 00 00 00       	mov    $0x13,%eax
    47bf:	cd 40                	int    $0x40
    47c1:	c3                   	ret    

000047c2 <mkdir>:
SYSCALL(mkdir)
    47c2:	b8 14 00 00 00       	mov    $0x14,%eax
    47c7:	cd 40                	int    $0x40
    47c9:	c3                   	ret    

000047ca <chdir>:
SYSCALL(chdir)
    47ca:	b8 09 00 00 00       	mov    $0x9,%eax
    47cf:	cd 40                	int    $0x40
    47d1:	c3                   	ret    

000047d2 <dup>:
SYSCALL(dup)
    47d2:	b8 0a 00 00 00       	mov    $0xa,%eax
    47d7:	cd 40                	int    $0x40
    47d9:	c3                   	ret    

000047da <getpid>:
SYSCALL(getpid)
    47da:	b8 0b 00 00 00       	mov    $0xb,%eax
    47df:	cd 40                	int    $0x40
    47e1:	c3                   	ret    

000047e2 <sbrk>:
SYSCALL(sbrk)
    47e2:	b8 0c 00 00 00       	mov    $0xc,%eax
    47e7:	cd 40                	int    $0x40
    47e9:	c3                   	ret    

000047ea <sleep>:
SYSCALL(sleep)
    47ea:	b8 0d 00 00 00       	mov    $0xd,%eax
    47ef:	cd 40                	int    $0x40
    47f1:	c3                   	ret    

000047f2 <uptime>:
SYSCALL(uptime)
    47f2:	b8 0e 00 00 00       	mov    $0xe,%eax
    47f7:	cd 40                	int    $0x40
    47f9:	c3                   	ret    

000047fa <getMsg>:
SYSCALL(getMsg)
    47fa:	b8 16 00 00 00       	mov    $0x16,%eax
    47ff:	cd 40                	int    $0x40
    4801:	c3                   	ret    

00004802 <createWindow>:
SYSCALL(createWindow)
    4802:	b8 17 00 00 00       	mov    $0x17,%eax
    4807:	cd 40                	int    $0x40
    4809:	c3                   	ret    

0000480a <destroyWindow>:
SYSCALL(destroyWindow)
    480a:	b8 18 00 00 00       	mov    $0x18,%eax
    480f:	cd 40                	int    $0x40
    4811:	c3                   	ret    

00004812 <updateWindow>:
SYSCALL(updateWindow)
    4812:	b8 19 00 00 00       	mov    $0x19,%eax
    4817:	cd 40                	int    $0x40
    4819:	c3                   	ret    

0000481a <updatePartialWindow>:
SYSCALL(updatePartialWindow)
    481a:	b8 1a 00 00 00       	mov    $0x1a,%eax
    481f:	cd 40                	int    $0x40
    4821:	c3                   	ret    

00004822 <kwrite>:
SYSCALL(kwrite)
    4822:	b8 1c 00 00 00       	mov    $0x1c,%eax
    4827:	cd 40                	int    $0x40
    4829:	c3                   	ret    

0000482a <setSampleRate>:
SYSCALL(setSampleRate)
    482a:	b8 1b 00 00 00       	mov    $0x1b,%eax
    482f:	cd 40                	int    $0x40
    4831:	c3                   	ret    

00004832 <pause>:
SYSCALL(pause)
    4832:	b8 1d 00 00 00       	mov    $0x1d,%eax
    4837:	cd 40                	int    $0x40
    4839:	c3                   	ret    

0000483a <wavdecode>:
SYSCALL(wavdecode)
    483a:	b8 1e 00 00 00       	mov    $0x1e,%eax
    483f:	cd 40                	int    $0x40
    4841:	c3                   	ret    

00004842 <beginDecode>:
SYSCALL(beginDecode)
    4842:	b8 1f 00 00 00       	mov    $0x1f,%eax
    4847:	cd 40                	int    $0x40
    4849:	c3                   	ret    

0000484a <waitForDecode>:
SYSCALL(waitForDecode)
    484a:	b8 20 00 00 00       	mov    $0x20,%eax
    484f:	cd 40                	int    $0x40
    4851:	c3                   	ret    

00004852 <endDecode>:
SYSCALL(endDecode)
    4852:	b8 21 00 00 00       	mov    $0x21,%eax
    4857:	cd 40                	int    $0x40
    4859:	c3                   	ret    

0000485a <getCoreBuf>:
SYSCALL(getCoreBuf)
    485a:	b8 22 00 00 00       	mov    $0x22,%eax
    485f:	cd 40                	int    $0x40
    4861:	c3                   	ret    

00004862 <halt>:
SYSCALL(halt)
    4862:	b8 23 00 00 00       	mov    $0x23,%eax
    4867:	cd 40                	int    $0x40
    4869:	c3                   	ret    

0000486a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    486a:	55                   	push   %ebp
    486b:	89 e5                	mov    %esp,%ebp
    486d:	83 ec 18             	sub    $0x18,%esp
    4870:	8b 45 0c             	mov    0xc(%ebp),%eax
    4873:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    4876:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    487d:	00 
    487e:	8d 45 f4             	lea    -0xc(%ebp),%eax
    4881:	89 44 24 04          	mov    %eax,0x4(%esp)
    4885:	8b 45 08             	mov    0x8(%ebp),%eax
    4888:	89 04 24             	mov    %eax,(%esp)
    488b:	e8 ea fe ff ff       	call   477a <write>
}
    4890:	c9                   	leave  
    4891:	c3                   	ret    

00004892 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    4892:	55                   	push   %ebp
    4893:	89 e5                	mov    %esp,%ebp
    4895:	56                   	push   %esi
    4896:	53                   	push   %ebx
    4897:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    489a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    48a1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    48a5:	74 17                	je     48be <printint+0x2c>
    48a7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    48ab:	79 11                	jns    48be <printint+0x2c>
    neg = 1;
    48ad:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    48b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    48b7:	f7 d8                	neg    %eax
    48b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    48bc:	eb 06                	jmp    48c4 <printint+0x32>
  } else {
    x = xx;
    48be:	8b 45 0c             	mov    0xc(%ebp),%eax
    48c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    48c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    48cb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    48ce:	8d 41 01             	lea    0x1(%ecx),%eax
    48d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    48d4:	8b 5d 10             	mov    0x10(%ebp),%ebx
    48d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    48da:	ba 00 00 00 00       	mov    $0x0,%edx
    48df:	f7 f3                	div    %ebx
    48e1:	89 d0                	mov    %edx,%eax
    48e3:	0f b6 80 e0 ee 00 00 	movzbl 0xeee0(%eax),%eax
    48ea:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    48ee:	8b 75 10             	mov    0x10(%ebp),%esi
    48f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    48f4:	ba 00 00 00 00       	mov    $0x0,%edx
    48f9:	f7 f6                	div    %esi
    48fb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    48fe:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4902:	75 c7                	jne    48cb <printint+0x39>
  if(neg)
    4904:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4908:	74 10                	je     491a <printint+0x88>
    buf[i++] = '-';
    490a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    490d:	8d 50 01             	lea    0x1(%eax),%edx
    4910:	89 55 f4             	mov    %edx,-0xc(%ebp)
    4913:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    4918:	eb 1f                	jmp    4939 <printint+0xa7>
    491a:	eb 1d                	jmp    4939 <printint+0xa7>
    putc(fd, buf[i]);
    491c:	8d 55 dc             	lea    -0x24(%ebp),%edx
    491f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4922:	01 d0                	add    %edx,%eax
    4924:	0f b6 00             	movzbl (%eax),%eax
    4927:	0f be c0             	movsbl %al,%eax
    492a:	89 44 24 04          	mov    %eax,0x4(%esp)
    492e:	8b 45 08             	mov    0x8(%ebp),%eax
    4931:	89 04 24             	mov    %eax,(%esp)
    4934:	e8 31 ff ff ff       	call   486a <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    4939:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    493d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4941:	79 d9                	jns    491c <printint+0x8a>
    putc(fd, buf[i]);
}
    4943:	83 c4 30             	add    $0x30,%esp
    4946:	5b                   	pop    %ebx
    4947:	5e                   	pop    %esi
    4948:	5d                   	pop    %ebp
    4949:	c3                   	ret    

0000494a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    494a:	55                   	push   %ebp
    494b:	89 e5                	mov    %esp,%ebp
    494d:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    4950:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    4957:	8d 45 0c             	lea    0xc(%ebp),%eax
    495a:	83 c0 04             	add    $0x4,%eax
    495d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    4960:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    4967:	e9 7c 01 00 00       	jmp    4ae8 <printf+0x19e>
    c = fmt[i] & 0xff;
    496c:	8b 55 0c             	mov    0xc(%ebp),%edx
    496f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4972:	01 d0                	add    %edx,%eax
    4974:	0f b6 00             	movzbl (%eax),%eax
    4977:	0f be c0             	movsbl %al,%eax
    497a:	25 ff 00 00 00       	and    $0xff,%eax
    497f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    4982:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4986:	75 2c                	jne    49b4 <printf+0x6a>
      if(c == '%'){
    4988:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    498c:	75 0c                	jne    499a <printf+0x50>
        state = '%';
    498e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    4995:	e9 4a 01 00 00       	jmp    4ae4 <printf+0x19a>
      } else {
        putc(fd, c);
    499a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    499d:	0f be c0             	movsbl %al,%eax
    49a0:	89 44 24 04          	mov    %eax,0x4(%esp)
    49a4:	8b 45 08             	mov    0x8(%ebp),%eax
    49a7:	89 04 24             	mov    %eax,(%esp)
    49aa:	e8 bb fe ff ff       	call   486a <putc>
    49af:	e9 30 01 00 00       	jmp    4ae4 <printf+0x19a>
      }
    } else if(state == '%'){
    49b4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    49b8:	0f 85 26 01 00 00    	jne    4ae4 <printf+0x19a>
      if(c == 'd'){
    49be:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    49c2:	75 2d                	jne    49f1 <printf+0xa7>
        printint(fd, *ap, 10, 1);
    49c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    49c7:	8b 00                	mov    (%eax),%eax
    49c9:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    49d0:	00 
    49d1:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    49d8:	00 
    49d9:	89 44 24 04          	mov    %eax,0x4(%esp)
    49dd:	8b 45 08             	mov    0x8(%ebp),%eax
    49e0:	89 04 24             	mov    %eax,(%esp)
    49e3:	e8 aa fe ff ff       	call   4892 <printint>
        ap++;
    49e8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    49ec:	e9 ec 00 00 00       	jmp    4add <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    49f1:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    49f5:	74 06                	je     49fd <printf+0xb3>
    49f7:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    49fb:	75 2d                	jne    4a2a <printf+0xe0>
        printint(fd, *ap, 16, 0);
    49fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4a00:	8b 00                	mov    (%eax),%eax
    4a02:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    4a09:	00 
    4a0a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    4a11:	00 
    4a12:	89 44 24 04          	mov    %eax,0x4(%esp)
    4a16:	8b 45 08             	mov    0x8(%ebp),%eax
    4a19:	89 04 24             	mov    %eax,(%esp)
    4a1c:	e8 71 fe ff ff       	call   4892 <printint>
        ap++;
    4a21:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4a25:	e9 b3 00 00 00       	jmp    4add <printf+0x193>
      } else if(c == 's'){
    4a2a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    4a2e:	75 45                	jne    4a75 <printf+0x12b>
        s = (char*)*ap;
    4a30:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4a33:	8b 00                	mov    (%eax),%eax
    4a35:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    4a38:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    4a3c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4a40:	75 09                	jne    4a4b <printf+0x101>
          s = "(null)";
    4a42:	c7 45 f4 11 b6 00 00 	movl   $0xb611,-0xc(%ebp)
        while(*s != 0){
    4a49:	eb 1e                	jmp    4a69 <printf+0x11f>
    4a4b:	eb 1c                	jmp    4a69 <printf+0x11f>
          putc(fd, *s);
    4a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4a50:	0f b6 00             	movzbl (%eax),%eax
    4a53:	0f be c0             	movsbl %al,%eax
    4a56:	89 44 24 04          	mov    %eax,0x4(%esp)
    4a5a:	8b 45 08             	mov    0x8(%ebp),%eax
    4a5d:	89 04 24             	mov    %eax,(%esp)
    4a60:	e8 05 fe ff ff       	call   486a <putc>
          s++;
    4a65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    4a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4a6c:	0f b6 00             	movzbl (%eax),%eax
    4a6f:	84 c0                	test   %al,%al
    4a71:	75 da                	jne    4a4d <printf+0x103>
    4a73:	eb 68                	jmp    4add <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    4a75:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    4a79:	75 1d                	jne    4a98 <printf+0x14e>
        putc(fd, *ap);
    4a7b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4a7e:	8b 00                	mov    (%eax),%eax
    4a80:	0f be c0             	movsbl %al,%eax
    4a83:	89 44 24 04          	mov    %eax,0x4(%esp)
    4a87:	8b 45 08             	mov    0x8(%ebp),%eax
    4a8a:	89 04 24             	mov    %eax,(%esp)
    4a8d:	e8 d8 fd ff ff       	call   486a <putc>
        ap++;
    4a92:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4a96:	eb 45                	jmp    4add <printf+0x193>
      } else if(c == '%'){
    4a98:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4a9c:	75 17                	jne    4ab5 <printf+0x16b>
        putc(fd, c);
    4a9e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4aa1:	0f be c0             	movsbl %al,%eax
    4aa4:	89 44 24 04          	mov    %eax,0x4(%esp)
    4aa8:	8b 45 08             	mov    0x8(%ebp),%eax
    4aab:	89 04 24             	mov    %eax,(%esp)
    4aae:	e8 b7 fd ff ff       	call   486a <putc>
    4ab3:	eb 28                	jmp    4add <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    4ab5:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    4abc:	00 
    4abd:	8b 45 08             	mov    0x8(%ebp),%eax
    4ac0:	89 04 24             	mov    %eax,(%esp)
    4ac3:	e8 a2 fd ff ff       	call   486a <putc>
        putc(fd, c);
    4ac8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4acb:	0f be c0             	movsbl %al,%eax
    4ace:	89 44 24 04          	mov    %eax,0x4(%esp)
    4ad2:	8b 45 08             	mov    0x8(%ebp),%eax
    4ad5:	89 04 24             	mov    %eax,(%esp)
    4ad8:	e8 8d fd ff ff       	call   486a <putc>
      }
      state = 0;
    4add:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    4ae4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    4ae8:	8b 55 0c             	mov    0xc(%ebp),%edx
    4aeb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4aee:	01 d0                	add    %edx,%eax
    4af0:	0f b6 00             	movzbl (%eax),%eax
    4af3:	84 c0                	test   %al,%al
    4af5:	0f 85 71 fe ff ff    	jne    496c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    4afb:	c9                   	leave  
    4afc:	c3                   	ret    

00004afd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4afd:	55                   	push   %ebp
    4afe:	89 e5                	mov    %esp,%ebp
    4b00:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    4b03:	8b 45 08             	mov    0x8(%ebp),%eax
    4b06:	83 e8 08             	sub    $0x8,%eax
    4b09:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4b0c:	a1 04 f4 00 00       	mov    0xf404,%eax
    4b11:	89 45 fc             	mov    %eax,-0x4(%ebp)
    4b14:	eb 24                	jmp    4b3a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4b16:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4b19:	8b 00                	mov    (%eax),%eax
    4b1b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4b1e:	77 12                	ja     4b32 <free+0x35>
    4b20:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4b23:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4b26:	77 24                	ja     4b4c <free+0x4f>
    4b28:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4b2b:	8b 00                	mov    (%eax),%eax
    4b2d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4b30:	77 1a                	ja     4b4c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4b32:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4b35:	8b 00                	mov    (%eax),%eax
    4b37:	89 45 fc             	mov    %eax,-0x4(%ebp)
    4b3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4b3d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    4b40:	76 d4                	jbe    4b16 <free+0x19>
    4b42:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4b45:	8b 00                	mov    (%eax),%eax
    4b47:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4b4a:	76 ca                	jbe    4b16 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    4b4c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4b4f:	8b 40 04             	mov    0x4(%eax),%eax
    4b52:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    4b59:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4b5c:	01 c2                	add    %eax,%edx
    4b5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4b61:	8b 00                	mov    (%eax),%eax
    4b63:	39 c2                	cmp    %eax,%edx
    4b65:	75 24                	jne    4b8b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    4b67:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4b6a:	8b 50 04             	mov    0x4(%eax),%edx
    4b6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4b70:	8b 00                	mov    (%eax),%eax
    4b72:	8b 40 04             	mov    0x4(%eax),%eax
    4b75:	01 c2                	add    %eax,%edx
    4b77:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4b7a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    4b7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4b80:	8b 00                	mov    (%eax),%eax
    4b82:	8b 10                	mov    (%eax),%edx
    4b84:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4b87:	89 10                	mov    %edx,(%eax)
    4b89:	eb 0a                	jmp    4b95 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    4b8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4b8e:	8b 10                	mov    (%eax),%edx
    4b90:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4b93:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    4b95:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4b98:	8b 40 04             	mov    0x4(%eax),%eax
    4b9b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    4ba2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4ba5:	01 d0                	add    %edx,%eax
    4ba7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4baa:	75 20                	jne    4bcc <free+0xcf>
    p->s.size += bp->s.size;
    4bac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4baf:	8b 50 04             	mov    0x4(%eax),%edx
    4bb2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4bb5:	8b 40 04             	mov    0x4(%eax),%eax
    4bb8:	01 c2                	add    %eax,%edx
    4bba:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4bbd:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    4bc0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4bc3:	8b 10                	mov    (%eax),%edx
    4bc5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4bc8:	89 10                	mov    %edx,(%eax)
    4bca:	eb 08                	jmp    4bd4 <free+0xd7>
  } else
    p->s.ptr = bp;
    4bcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4bcf:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4bd2:	89 10                	mov    %edx,(%eax)
  freep = p;
    4bd4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4bd7:	a3 04 f4 00 00       	mov    %eax,0xf404
}
    4bdc:	c9                   	leave  
    4bdd:	c3                   	ret    

00004bde <morecore>:

static Header*
morecore(uint nu)
{
    4bde:	55                   	push   %ebp
    4bdf:	89 e5                	mov    %esp,%ebp
    4be1:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    4be4:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    4beb:	77 07                	ja     4bf4 <morecore+0x16>
    nu = 4096;
    4bed:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    4bf4:	8b 45 08             	mov    0x8(%ebp),%eax
    4bf7:	c1 e0 03             	shl    $0x3,%eax
    4bfa:	89 04 24             	mov    %eax,(%esp)
    4bfd:	e8 e0 fb ff ff       	call   47e2 <sbrk>
    4c02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    4c05:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    4c09:	75 07                	jne    4c12 <morecore+0x34>
    return 0;
    4c0b:	b8 00 00 00 00       	mov    $0x0,%eax
    4c10:	eb 22                	jmp    4c34 <morecore+0x56>
  hp = (Header*)p;
    4c12:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4c15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    4c18:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4c1b:	8b 55 08             	mov    0x8(%ebp),%edx
    4c1e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    4c21:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4c24:	83 c0 08             	add    $0x8,%eax
    4c27:	89 04 24             	mov    %eax,(%esp)
    4c2a:	e8 ce fe ff ff       	call   4afd <free>
  return freep;
    4c2f:	a1 04 f4 00 00       	mov    0xf404,%eax
}
    4c34:	c9                   	leave  
    4c35:	c3                   	ret    

00004c36 <malloc>:

void*
malloc(uint nbytes)
{
    4c36:	55                   	push   %ebp
    4c37:	89 e5                	mov    %esp,%ebp
    4c39:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4c3c:	8b 45 08             	mov    0x8(%ebp),%eax
    4c3f:	83 c0 07             	add    $0x7,%eax
    4c42:	c1 e8 03             	shr    $0x3,%eax
    4c45:	83 c0 01             	add    $0x1,%eax
    4c48:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    4c4b:	a1 04 f4 00 00       	mov    0xf404,%eax
    4c50:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4c53:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    4c57:	75 23                	jne    4c7c <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    4c59:	c7 45 f0 fc f3 00 00 	movl   $0xf3fc,-0x10(%ebp)
    4c60:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4c63:	a3 04 f4 00 00       	mov    %eax,0xf404
    4c68:	a1 04 f4 00 00       	mov    0xf404,%eax
    4c6d:	a3 fc f3 00 00       	mov    %eax,0xf3fc
    base.s.size = 0;
    4c72:	c7 05 00 f4 00 00 00 	movl   $0x0,0xf400
    4c79:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4c7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4c7f:	8b 00                	mov    (%eax),%eax
    4c81:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4c84:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4c87:	8b 40 04             	mov    0x4(%eax),%eax
    4c8a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4c8d:	72 4d                	jb     4cdc <malloc+0xa6>
      if(p->s.size == nunits)
    4c8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4c92:	8b 40 04             	mov    0x4(%eax),%eax
    4c95:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4c98:	75 0c                	jne    4ca6 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    4c9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4c9d:	8b 10                	mov    (%eax),%edx
    4c9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4ca2:	89 10                	mov    %edx,(%eax)
    4ca4:	eb 26                	jmp    4ccc <malloc+0x96>
      else {
        p->s.size -= nunits;
    4ca6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4ca9:	8b 40 04             	mov    0x4(%eax),%eax
    4cac:	2b 45 ec             	sub    -0x14(%ebp),%eax
    4caf:	89 c2                	mov    %eax,%edx
    4cb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4cb4:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    4cb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4cba:	8b 40 04             	mov    0x4(%eax),%eax
    4cbd:	c1 e0 03             	shl    $0x3,%eax
    4cc0:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    4cc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4cc6:	8b 55 ec             	mov    -0x14(%ebp),%edx
    4cc9:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    4ccc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4ccf:	a3 04 f4 00 00       	mov    %eax,0xf404
      return (void*)(p + 1);
    4cd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4cd7:	83 c0 08             	add    $0x8,%eax
    4cda:	eb 38                	jmp    4d14 <malloc+0xde>
    }
    if(p == freep)
    4cdc:	a1 04 f4 00 00       	mov    0xf404,%eax
    4ce1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    4ce4:	75 1b                	jne    4d01 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    4ce6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4ce9:	89 04 24             	mov    %eax,(%esp)
    4cec:	e8 ed fe ff ff       	call   4bde <morecore>
    4cf1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4cf4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4cf8:	75 07                	jne    4d01 <malloc+0xcb>
        return 0;
    4cfa:	b8 00 00 00 00       	mov    $0x0,%eax
    4cff:	eb 13                	jmp    4d14 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4d01:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4d04:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4d07:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4d0a:	8b 00                	mov    (%eax),%eax
    4d0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    4d0f:	e9 70 ff ff ff       	jmp    4c84 <malloc+0x4e>
}
    4d14:	c9                   	leave  
    4d15:	c3                   	ret    

00004d16 <abs>:
#include "math.h"
#define pi 3.1415926535898 
int abs(int x)
{
    4d16:	55                   	push   %ebp
    4d17:	89 e5                	mov    %esp,%ebp
	if (x < 0)
    4d19:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    4d1d:	79 07                	jns    4d26 <abs+0x10>
		return x * -1;
    4d1f:	8b 45 08             	mov    0x8(%ebp),%eax
    4d22:	f7 d8                	neg    %eax
    4d24:	eb 03                	jmp    4d29 <abs+0x13>
	else
		return x;
    4d26:	8b 45 08             	mov    0x8(%ebp),%eax
}
    4d29:	5d                   	pop    %ebp
    4d2a:	c3                   	ret    

00004d2b <sin>:
double sin(double x)  
{  
    4d2b:	55                   	push   %ebp
    4d2c:	89 e5                	mov    %esp,%ebp
    4d2e:	83 ec 3c             	sub    $0x3c,%esp
    4d31:	8b 45 08             	mov    0x8(%ebp),%eax
    4d34:	89 45 c8             	mov    %eax,-0x38(%ebp)
    4d37:	8b 45 0c             	mov    0xc(%ebp),%eax
    4d3a:	89 45 cc             	mov    %eax,-0x34(%ebp)
	double Result=x,Fac=1.0,Xn=x,Precious=x;  
    4d3d:	dd 45 c8             	fldl   -0x38(%ebp)
    4d40:	dd 5d f8             	fstpl  -0x8(%ebp)
    4d43:	d9 e8                	fld1   
    4d45:	dd 5d f0             	fstpl  -0x10(%ebp)
    4d48:	dd 45 c8             	fldl   -0x38(%ebp)
    4d4b:	dd 5d e8             	fstpl  -0x18(%ebp)
    4d4e:	dd 45 c8             	fldl   -0x38(%ebp)
    4d51:	dd 5d e0             	fstpl  -0x20(%ebp)
	int n=1,sign=1;  
    4d54:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
    4d5b:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
	while(Precious>1e-6)  
    4d62:	eb 50                	jmp    4db4 <sin+0x89>
	{  
		n = n+1;  
    4d64:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
		Fac=Fac*n*(n + 1);
    4d68:	db 45 dc             	fildl  -0x24(%ebp)
    4d6b:	dc 4d f0             	fmull  -0x10(%ebp)
    4d6e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    4d71:	83 c0 01             	add    $0x1,%eax
    4d74:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    4d77:	db 45 c4             	fildl  -0x3c(%ebp)
    4d7a:	de c9                	fmulp  %st,%st(1)
    4d7c:	dd 5d f0             	fstpl  -0x10(%ebp)
		n = n + 1;  
    4d7f:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
		Xn*=x*x;  
    4d83:	dd 45 c8             	fldl   -0x38(%ebp)
    4d86:	dc 4d c8             	fmull  -0x38(%ebp)
    4d89:	dd 45 e8             	fldl   -0x18(%ebp)
    4d8c:	de c9                	fmulp  %st,%st(1)
    4d8e:	dd 5d e8             	fstpl  -0x18(%ebp)
		sign=-sign;  
    4d91:	f7 5d d8             	negl   -0x28(%ebp)
		Precious=Xn/Fac;  
    4d94:	dd 45 e8             	fldl   -0x18(%ebp)
    4d97:	dc 75 f0             	fdivl  -0x10(%ebp)
    4d9a:	dd 5d e0             	fstpl  -0x20(%ebp)
		Result=sign>0?Result+Precious:Result-Precious;  
    4d9d:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    4da1:	7e 08                	jle    4dab <sin+0x80>
    4da3:	dd 45 f8             	fldl   -0x8(%ebp)
    4da6:	dc 45 e0             	faddl  -0x20(%ebp)
    4da9:	eb 06                	jmp    4db1 <sin+0x86>
    4dab:	dd 45 f8             	fldl   -0x8(%ebp)
    4dae:	dc 65 e0             	fsubl  -0x20(%ebp)
    4db1:	dd 5d f8             	fstpl  -0x8(%ebp)
}
double sin(double x)  
{  
	double Result=x,Fac=1.0,Xn=x,Precious=x;  
	int n=1,sign=1;  
	while(Precious>1e-6)  
    4db4:	dd 45 e0             	fldl   -0x20(%ebp)
    4db7:	dd 05 18 b6 00 00    	fldl   0xb618
    4dbd:	d9 c9                	fxch   %st(1)
    4dbf:	df e9                	fucomip %st(1),%st
    4dc1:	dd d8                	fstp   %st(0)
    4dc3:	77 9f                	ja     4d64 <sin+0x39>
		Xn*=x*x;  
		sign=-sign;  
		Precious=Xn/Fac;  
		Result=sign>0?Result+Precious:Result-Precious;  
	}  
	return Result;  
    4dc5:	dd 45 f8             	fldl   -0x8(%ebp)
}  
    4dc8:	c9                   	leave  
    4dc9:	c3                   	ret    

00004dca <cos>:
double cos(double x)  
{  
    4dca:	55                   	push   %ebp
    4dcb:	89 e5                	mov    %esp,%ebp
    4dcd:	83 ec 10             	sub    $0x10,%esp
    4dd0:	8b 45 08             	mov    0x8(%ebp),%eax
    4dd3:	89 45 f8             	mov    %eax,-0x8(%ebp)
    4dd6:	8b 45 0c             	mov    0xc(%ebp),%eax
    4dd9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return sin(pi/2-x);  
    4ddc:	dd 05 20 b6 00 00    	fldl   0xb620
    4de2:	dc 65 f8             	fsubl  -0x8(%ebp)
    4de5:	dd 1c 24             	fstpl  (%esp)
    4de8:	e8 3e ff ff ff       	call   4d2b <sin>
}  
    4ded:	c9                   	leave  
    4dee:	c3                   	ret    

00004def <tan>:
double tan(double x)  
{  
    4def:	55                   	push   %ebp
    4df0:	89 e5                	mov    %esp,%ebp
    4df2:	83 ec 18             	sub    $0x18,%esp
    4df5:	8b 45 08             	mov    0x8(%ebp),%eax
    4df8:	89 45 f8             	mov    %eax,-0x8(%ebp)
    4dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
    4dfe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return sin(x)/cos(x);  
    4e01:	dd 45 f8             	fldl   -0x8(%ebp)
    4e04:	dd 1c 24             	fstpl  (%esp)
    4e07:	e8 1f ff ff ff       	call   4d2b <sin>
    4e0c:	dd 5d f0             	fstpl  -0x10(%ebp)
    4e0f:	dd 45 f8             	fldl   -0x8(%ebp)
    4e12:	dd 1c 24             	fstpl  (%esp)
    4e15:	e8 b0 ff ff ff       	call   4dca <cos>
    4e1a:	dc 7d f0             	fdivrl -0x10(%ebp)
}  
    4e1d:	c9                   	leave  
    4e1e:	c3                   	ret    

00004e1f <pow>:

double pow(double x, double y)
{
    4e1f:	55                   	push   %ebp
    4e20:	89 e5                	mov    %esp,%ebp
    4e22:	83 ec 48             	sub    $0x48,%esp
    4e25:	8b 45 08             	mov    0x8(%ebp),%eax
    4e28:	89 45 e0             	mov    %eax,-0x20(%ebp)
    4e2b:	8b 45 0c             	mov    0xc(%ebp),%eax
    4e2e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    4e31:	8b 45 10             	mov    0x10(%ebp),%eax
    4e34:	89 45 d8             	mov    %eax,-0x28(%ebp)
    4e37:	8b 45 14             	mov    0x14(%ebp),%eax
    4e3a:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if(x==0 && y!=0) return 0;
    4e3d:	dd 45 e0             	fldl   -0x20(%ebp)
    4e40:	d9 ee                	fldz   
    4e42:	df e9                	fucomip %st(1),%st
    4e44:	dd d8                	fstp   %st(0)
    4e46:	7a 28                	jp     4e70 <pow+0x51>
    4e48:	dd 45 e0             	fldl   -0x20(%ebp)
    4e4b:	d9 ee                	fldz   
    4e4d:	df e9                	fucomip %st(1),%st
    4e4f:	dd d8                	fstp   %st(0)
    4e51:	75 1d                	jne    4e70 <pow+0x51>
    4e53:	dd 45 d8             	fldl   -0x28(%ebp)
    4e56:	d9 ee                	fldz   
    4e58:	df e9                	fucomip %st(1),%st
    4e5a:	dd d8                	fstp   %st(0)
    4e5c:	7a 0b                	jp     4e69 <pow+0x4a>
    4e5e:	dd 45 d8             	fldl   -0x28(%ebp)
    4e61:	d9 ee                	fldz   
    4e63:	df e9                	fucomip %st(1),%st
    4e65:	dd d8                	fstp   %st(0)
    4e67:	74 07                	je     4e70 <pow+0x51>
    4e69:	d9 ee                	fldz   
    4e6b:	e9 30 01 00 00       	jmp    4fa0 <pow+0x181>
	else if(x==0 && y==0) return 1;
    4e70:	dd 45 e0             	fldl   -0x20(%ebp)
    4e73:	d9 ee                	fldz   
    4e75:	df e9                	fucomip %st(1),%st
    4e77:	dd d8                	fstp   %st(0)
    4e79:	7a 28                	jp     4ea3 <pow+0x84>
    4e7b:	dd 45 e0             	fldl   -0x20(%ebp)
    4e7e:	d9 ee                	fldz   
    4e80:	df e9                	fucomip %st(1),%st
    4e82:	dd d8                	fstp   %st(0)
    4e84:	75 1d                	jne    4ea3 <pow+0x84>
    4e86:	dd 45 d8             	fldl   -0x28(%ebp)
    4e89:	d9 ee                	fldz   
    4e8b:	df e9                	fucomip %st(1),%st
    4e8d:	dd d8                	fstp   %st(0)
    4e8f:	7a 12                	jp     4ea3 <pow+0x84>
    4e91:	dd 45 d8             	fldl   -0x28(%ebp)
    4e94:	d9 ee                	fldz   
    4e96:	df e9                	fucomip %st(1),%st
    4e98:	dd d8                	fstp   %st(0)
    4e9a:	75 07                	jne    4ea3 <pow+0x84>
    4e9c:	d9 e8                	fld1   
    4e9e:	e9 fd 00 00 00       	jmp    4fa0 <pow+0x181>
	else if(y<0) return 1/pow(x,-y);//把指数小于0的情况转为1/x^-y计算
    4ea3:	d9 ee                	fldz   
    4ea5:	dd 45 d8             	fldl   -0x28(%ebp)
    4ea8:	d9 c9                	fxch   %st(1)
    4eaa:	df e9                	fucomip %st(1),%st
    4eac:	dd d8                	fstp   %st(0)
    4eae:	76 1d                	jbe    4ecd <pow+0xae>
    4eb0:	dd 45 d8             	fldl   -0x28(%ebp)
    4eb3:	d9 e0                	fchs   
    4eb5:	dd 5c 24 08          	fstpl  0x8(%esp)
    4eb9:	dd 45 e0             	fldl   -0x20(%ebp)
    4ebc:	dd 1c 24             	fstpl  (%esp)
    4ebf:	e8 5b ff ff ff       	call   4e1f <pow>
    4ec4:	d9 e8                	fld1   
    4ec6:	de f1                	fdivp  %st,%st(1)
    4ec8:	e9 d3 00 00 00       	jmp    4fa0 <pow+0x181>
	else if(x<0 && y-(int)y!=0) return 0;//若x为负，且y不为整数数，则出错，返回0  
    4ecd:	d9 ee                	fldz   
    4ecf:	dd 45 e0             	fldl   -0x20(%ebp)
    4ed2:	d9 c9                	fxch   %st(1)
    4ed4:	df e9                	fucomip %st(1),%st
    4ed6:	dd d8                	fstp   %st(0)
    4ed8:	76 40                	jbe    4f1a <pow+0xfb>
    4eda:	dd 45 d8             	fldl   -0x28(%ebp)
    4edd:	d9 7d d6             	fnstcw -0x2a(%ebp)
    4ee0:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    4ee4:	b4 0c                	mov    $0xc,%ah
    4ee6:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    4eea:	d9 6d d4             	fldcw  -0x2c(%ebp)
    4eed:	db 5d d0             	fistpl -0x30(%ebp)
    4ef0:	d9 6d d6             	fldcw  -0x2a(%ebp)
    4ef3:	8b 45 d0             	mov    -0x30(%ebp),%eax
    4ef6:	89 45 d0             	mov    %eax,-0x30(%ebp)
    4ef9:	db 45 d0             	fildl  -0x30(%ebp)
    4efc:	dd 45 d8             	fldl   -0x28(%ebp)
    4eff:	de e1                	fsubp  %st,%st(1)
    4f01:	d9 ee                	fldz   
    4f03:	df e9                	fucomip %st(1),%st
    4f05:	7a 0a                	jp     4f11 <pow+0xf2>
    4f07:	d9 ee                	fldz   
    4f09:	df e9                	fucomip %st(1),%st
    4f0b:	dd d8                	fstp   %st(0)
    4f0d:	74 0b                	je     4f1a <pow+0xfb>
    4f0f:	eb 02                	jmp    4f13 <pow+0xf4>
    4f11:	dd d8                	fstp   %st(0)
    4f13:	d9 ee                	fldz   
    4f15:	e9 86 00 00 00       	jmp    4fa0 <pow+0x181>
	else if(x<0 && y-(int)y==0)//若x为负，且y为整数数，则用循环计算 
    4f1a:	d9 ee                	fldz   
    4f1c:	dd 45 e0             	fldl   -0x20(%ebp)
    4f1f:	d9 c9                	fxch   %st(1)
    4f21:	df e9                	fucomip %st(1),%st
    4f23:	dd d8                	fstp   %st(0)
    4f25:	76 63                	jbe    4f8a <pow+0x16b>
    4f27:	dd 45 d8             	fldl   -0x28(%ebp)
    4f2a:	d9 7d d6             	fnstcw -0x2a(%ebp)
    4f2d:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    4f31:	b4 0c                	mov    $0xc,%ah
    4f33:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    4f37:	d9 6d d4             	fldcw  -0x2c(%ebp)
    4f3a:	db 5d d0             	fistpl -0x30(%ebp)
    4f3d:	d9 6d d6             	fldcw  -0x2a(%ebp)
    4f40:	8b 45 d0             	mov    -0x30(%ebp),%eax
    4f43:	89 45 d0             	mov    %eax,-0x30(%ebp)
    4f46:	db 45 d0             	fildl  -0x30(%ebp)
    4f49:	dd 45 d8             	fldl   -0x28(%ebp)
    4f4c:	de e1                	fsubp  %st,%st(1)
    4f4e:	d9 ee                	fldz   
    4f50:	df e9                	fucomip %st(1),%st
    4f52:	7a 34                	jp     4f88 <pow+0x169>
    4f54:	d9 ee                	fldz   
    4f56:	df e9                	fucomip %st(1),%st
    4f58:	dd d8                	fstp   %st(0)
    4f5a:	75 2e                	jne    4f8a <pow+0x16b>
	{
		double powint=1;
    4f5c:	d9 e8                	fld1   
    4f5e:	dd 5d f0             	fstpl  -0x10(%ebp)
		int i;
		for(i=1;i<=y;i++) powint*=x;
    4f61:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    4f68:	eb 0d                	jmp    4f77 <pow+0x158>
    4f6a:	dd 45 f0             	fldl   -0x10(%ebp)
    4f6d:	dc 4d e0             	fmull  -0x20(%ebp)
    4f70:	dd 5d f0             	fstpl  -0x10(%ebp)
    4f73:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    4f77:	db 45 ec             	fildl  -0x14(%ebp)
    4f7a:	dd 45 d8             	fldl   -0x28(%ebp)
    4f7d:	df e9                	fucomip %st(1),%st
    4f7f:	dd d8                	fstp   %st(0)
    4f81:	73 e7                	jae    4f6a <pow+0x14b>
		return powint;
    4f83:	dd 45 f0             	fldl   -0x10(%ebp)
    4f86:	eb 18                	jmp    4fa0 <pow+0x181>
    4f88:	dd d8                	fstp   %st(0)
	}
	return exp(y*ln(x));
    4f8a:	dd 45 e0             	fldl   -0x20(%ebp)
    4f8d:	dd 1c 24             	fstpl  (%esp)
    4f90:	e8 36 00 00 00       	call   4fcb <ln>
    4f95:	dc 4d d8             	fmull  -0x28(%ebp)
    4f98:	dd 1c 24             	fstpl  (%esp)
    4f9b:	e8 0e 02 00 00       	call   51ae <exp>
}
    4fa0:	c9                   	leave  
    4fa1:	c3                   	ret    

00004fa2 <sqrt>:
// 求根
double sqrt(double x)
{
    4fa2:	55                   	push   %ebp
    4fa3:	89 e5                	mov    %esp,%ebp
    4fa5:	83 ec 28             	sub    $0x28,%esp
    4fa8:	8b 45 08             	mov    0x8(%ebp),%eax
    4fab:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4fae:	8b 45 0c             	mov    0xc(%ebp),%eax
    4fb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	return pow(x,0.5);
    4fb4:	dd 05 28 b6 00 00    	fldl   0xb628
    4fba:	dd 5c 24 08          	fstpl  0x8(%esp)
    4fbe:	dd 45 f0             	fldl   -0x10(%ebp)
    4fc1:	dd 1c 24             	fstpl  (%esp)
    4fc4:	e8 56 fe ff ff       	call   4e1f <pow>
}
    4fc9:	c9                   	leave  
    4fca:	c3                   	ret    

00004fcb <ln>:

// ln(x) = 2 arctanh((x-1)/(x+1))
// 调用了Arctanh(double) 方法
double ln(double x)
{
    4fcb:	55                   	push   %ebp
    4fcc:	89 e5                	mov    %esp,%ebp
    4fce:	81 ec 88 00 00 00    	sub    $0x88,%esp
    4fd4:	8b 45 08             	mov    0x8(%ebp),%eax
    4fd7:	89 45 90             	mov    %eax,-0x70(%ebp)
    4fda:	8b 45 0c             	mov    0xc(%ebp),%eax
    4fdd:	89 45 94             	mov    %eax,-0x6c(%ebp)
	double y=x-1,ln_p1=0,ln_p2=0,ln_p3=0,ln_px=0,ln_tmp=1,dln_px=1,tmp;
    4fe0:	dd 45 90             	fldl   -0x70(%ebp)
    4fe3:	d9 e8                	fld1   
    4fe5:	de e9                	fsubrp %st,%st(1)
    4fe7:	dd 5d c0             	fstpl  -0x40(%ebp)
    4fea:	d9 ee                	fldz   
    4fec:	dd 5d f0             	fstpl  -0x10(%ebp)
    4fef:	d9 ee                	fldz   
    4ff1:	dd 5d b8             	fstpl  -0x48(%ebp)
    4ff4:	d9 ee                	fldz   
    4ff6:	dd 5d b0             	fstpl  -0x50(%ebp)
    4ff9:	d9 ee                	fldz   
    4ffb:	dd 5d e8             	fstpl  -0x18(%ebp)
    4ffe:	d9 e8                	fld1   
    5000:	dd 5d e0             	fstpl  -0x20(%ebp)
    5003:	d9 e8                	fld1   
    5005:	dd 5d a8             	fstpl  -0x58(%ebp)
	int l;
	if(x==1) return 0;
    5008:	dd 45 90             	fldl   -0x70(%ebp)
    500b:	d9 e8                	fld1   
    500d:	df e9                	fucomip %st(1),%st
    500f:	dd d8                	fstp   %st(0)
    5011:	7a 12                	jp     5025 <ln+0x5a>
    5013:	dd 45 90             	fldl   -0x70(%ebp)
    5016:	d9 e8                	fld1   
    5018:	df e9                	fucomip %st(1),%st
    501a:	dd d8                	fstp   %st(0)
    501c:	75 07                	jne    5025 <ln+0x5a>
    501e:	d9 ee                	fldz   
    5020:	e9 87 01 00 00       	jmp    51ac <ln+0x1e1>
	else if(x>2) return -ln(1/x);
    5025:	dd 45 90             	fldl   -0x70(%ebp)
    5028:	dd 05 30 b6 00 00    	fldl   0xb630
    502e:	d9 c9                	fxch   %st(1)
    5030:	df e9                	fucomip %st(1),%st
    5032:	dd d8                	fstp   %st(0)
    5034:	76 14                	jbe    504a <ln+0x7f>
    5036:	d9 e8                	fld1   
    5038:	dc 75 90             	fdivl  -0x70(%ebp)
    503b:	dd 1c 24             	fstpl  (%esp)
    503e:	e8 88 ff ff ff       	call   4fcb <ln>
    5043:	d9 e0                	fchs   
    5045:	e9 62 01 00 00       	jmp    51ac <ln+0x1e1>
	else if(x<.1)
    504a:	dd 05 38 b6 00 00    	fldl   0xb638
    5050:	dd 45 90             	fldl   -0x70(%ebp)
    5053:	d9 c9                	fxch   %st(1)
    5055:	df e9                	fucomip %st(1),%st
    5057:	dd d8                	fstp   %st(0)
    5059:	76 59                	jbe    50b4 <ln+0xe9>
	{
		double n=-1;
    505b:	d9 e8                	fld1   
    505d:	d9 e0                	fchs   
    505f:	dd 5d c8             	fstpl  -0x38(%ebp)
		double a;
		do
		{
			n=n-.6;
    5062:	dd 45 c8             	fldl   -0x38(%ebp)
    5065:	dd 05 40 b6 00 00    	fldl   0xb640
    506b:	de e9                	fsubrp %st,%st(1)
    506d:	dd 5d c8             	fstpl  -0x38(%ebp)
			a=x/exp(n);
    5070:	dd 45 c8             	fldl   -0x38(%ebp)
    5073:	dd 1c 24             	fstpl  (%esp)
    5076:	e8 33 01 00 00       	call   51ae <exp>
    507b:	dd 45 90             	fldl   -0x70(%ebp)
    507e:	de f1                	fdivp  %st,%st(1)
    5080:	dd 5d a0             	fstpl  -0x60(%ebp)
		}
		while(a>2 || a<1);
    5083:	dd 45 a0             	fldl   -0x60(%ebp)
    5086:	dd 05 30 b6 00 00    	fldl   0xb630
    508c:	d9 c9                	fxch   %st(1)
    508e:	df e9                	fucomip %st(1),%st
    5090:	dd d8                	fstp   %st(0)
    5092:	77 ce                	ja     5062 <ln+0x97>
    5094:	d9 e8                	fld1   
    5096:	dd 45 a0             	fldl   -0x60(%ebp)
    5099:	d9 c9                	fxch   %st(1)
    509b:	df e9                	fucomip %st(1),%st
    509d:	dd d8                	fstp   %st(0)
    509f:	77 c1                	ja     5062 <ln+0x97>
		return ln(a)+n;
    50a1:	dd 45 a0             	fldl   -0x60(%ebp)
    50a4:	dd 1c 24             	fstpl  (%esp)
    50a7:	e8 1f ff ff ff       	call   4fcb <ln>
    50ac:	dc 45 c8             	faddl  -0x38(%ebp)
    50af:	e9 f8 00 00 00       	jmp    51ac <ln+0x1e1>
	}
	for(l=1,tmp=1;(ln_px-ln_tmp)>1e-9 || (ln_px-ln_tmp)<-1e-9;l++)
    50b4:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    50bb:	d9 e8                	fld1   
    50bd:	dd 5d d8             	fstpl  -0x28(%ebp)
    50c0:	e9 b6 00 00 00       	jmp    517b <ln+0x1b0>
	{
		ln_tmp=ln_px;
    50c5:	dd 45 e8             	fldl   -0x18(%ebp)
    50c8:	dd 5d e0             	fstpl  -0x20(%ebp)
		tmp*=y;
    50cb:	dd 45 d8             	fldl   -0x28(%ebp)
    50ce:	dc 4d c0             	fmull  -0x40(%ebp)
    50d1:	dd 5d d8             	fstpl  -0x28(%ebp)
		if(l==1) tmp=tmp/l;
    50d4:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
    50d8:	75 0d                	jne    50e7 <ln+0x11c>
    50da:	db 45 d4             	fildl  -0x2c(%ebp)
    50dd:	dd 45 d8             	fldl   -0x28(%ebp)
    50e0:	de f1                	fdivp  %st,%st(1)
    50e2:	dd 5d d8             	fstpl  -0x28(%ebp)
    50e5:	eb 13                	jmp    50fa <ln+0x12f>
		else tmp=tmp/-l;
    50e7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    50ea:	f7 d8                	neg    %eax
    50ec:	89 45 8c             	mov    %eax,-0x74(%ebp)
    50ef:	db 45 8c             	fildl  -0x74(%ebp)
    50f2:	dd 45 d8             	fldl   -0x28(%ebp)
    50f5:	de f1                	fdivp  %st,%st(1)
    50f7:	dd 5d d8             	fstpl  -0x28(%ebp)
		ln_p1+=tmp;
    50fa:	dd 45 f0             	fldl   -0x10(%ebp)
    50fd:	dc 45 d8             	faddl  -0x28(%ebp)
    5100:	dd 5d f0             	fstpl  -0x10(%ebp)
		ln_p2=ln_p1+-1*tmp*y*l/(l+1);
    5103:	dd 45 d8             	fldl   -0x28(%ebp)
    5106:	d9 e0                	fchs   
    5108:	dc 4d c0             	fmull  -0x40(%ebp)
    510b:	db 45 d4             	fildl  -0x2c(%ebp)
    510e:	de c9                	fmulp  %st,%st(1)
    5110:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    5113:	83 c0 01             	add    $0x1,%eax
    5116:	89 45 8c             	mov    %eax,-0x74(%ebp)
    5119:	db 45 8c             	fildl  -0x74(%ebp)
    511c:	de f9                	fdivrp %st,%st(1)
    511e:	dc 45 f0             	faddl  -0x10(%ebp)
    5121:	dd 5d b8             	fstpl  -0x48(%ebp)
		ln_p3=ln_p2+tmp*y*y*l/(l+2);
    5124:	dd 45 d8             	fldl   -0x28(%ebp)
    5127:	dc 4d c0             	fmull  -0x40(%ebp)
    512a:	dc 4d c0             	fmull  -0x40(%ebp)
    512d:	db 45 d4             	fildl  -0x2c(%ebp)
    5130:	de c9                	fmulp  %st,%st(1)
    5132:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    5135:	83 c0 02             	add    $0x2,%eax
    5138:	89 45 8c             	mov    %eax,-0x74(%ebp)
    513b:	db 45 8c             	fildl  -0x74(%ebp)
    513e:	de f9                	fdivrp %st,%st(1)
    5140:	dc 45 b8             	faddl  -0x48(%ebp)
    5143:	dd 5d b0             	fstpl  -0x50(%ebp)
		dln_px=ln_p3-ln_p2;
    5146:	dd 45 b0             	fldl   -0x50(%ebp)
    5149:	dc 65 b8             	fsubl  -0x48(%ebp)
    514c:	dd 5d a8             	fstpl  -0x58(%ebp)
		ln_px=ln_p3-dln_px*dln_px/(ln_p3-2*ln_p2+ln_p1);
    514f:	dd 45 a8             	fldl   -0x58(%ebp)
    5152:	dc 4d a8             	fmull  -0x58(%ebp)
    5155:	dd 45 b8             	fldl   -0x48(%ebp)
    5158:	d8 c0                	fadd   %st(0),%st
    515a:	dd 45 b0             	fldl   -0x50(%ebp)
    515d:	de e1                	fsubp  %st,%st(1)
    515f:	dc 45 f0             	faddl  -0x10(%ebp)
    5162:	de f9                	fdivrp %st,%st(1)
    5164:	dd 45 b0             	fldl   -0x50(%ebp)
    5167:	de e1                	fsubp  %st,%st(1)
    5169:	dd 5d e8             	fstpl  -0x18(%ebp)
		tmp*=l;
    516c:	db 45 d4             	fildl  -0x2c(%ebp)
    516f:	dd 45 d8             	fldl   -0x28(%ebp)
    5172:	de c9                	fmulp  %st,%st(1)
    5174:	dd 5d d8             	fstpl  -0x28(%ebp)
			a=x/exp(n);
		}
		while(a>2 || a<1);
		return ln(a)+n;
	}
	for(l=1,tmp=1;(ln_px-ln_tmp)>1e-9 || (ln_px-ln_tmp)<-1e-9;l++)
    5177:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    517b:	dd 45 e8             	fldl   -0x18(%ebp)
    517e:	dc 65 e0             	fsubl  -0x20(%ebp)
    5181:	dd 05 48 b6 00 00    	fldl   0xb648
    5187:	d9 c9                	fxch   %st(1)
    5189:	df e9                	fucomip %st(1),%st
    518b:	dd d8                	fstp   %st(0)
    518d:	0f 87 32 ff ff ff    	ja     50c5 <ln+0xfa>
    5193:	dd 45 e8             	fldl   -0x18(%ebp)
    5196:	dc 65 e0             	fsubl  -0x20(%ebp)
    5199:	dd 05 50 b6 00 00    	fldl   0xb650
    519f:	df e9                	fucomip %st(1),%st
    51a1:	dd d8                	fstp   %st(0)
    51a3:	0f 87 1c ff ff ff    	ja     50c5 <ln+0xfa>
		ln_p3=ln_p2+tmp*y*y*l/(l+2);
		dln_px=ln_p3-ln_p2;
		ln_px=ln_p3-dln_px*dln_px/(ln_p3-2*ln_p2+ln_p1);
		tmp*=l;
	}
	return ln_px;
    51a9:	dd 45 e8             	fldl   -0x18(%ebp)
}
    51ac:	c9                   	leave  
    51ad:	c3                   	ret    

000051ae <exp>:

// 求e^x 用于Pow( double, double )调用
// e^x = 1+x+(x^2)/2!+(x^3)/3!+...
// 精度为7位
double exp( double x )
{
    51ae:	55                   	push   %ebp
    51af:	89 e5                	mov    %esp,%ebp
    51b1:	83 ec 78             	sub    $0x78,%esp
    51b4:	8b 45 08             	mov    0x8(%ebp),%eax
    51b7:	89 45 a0             	mov    %eax,-0x60(%ebp)
    51ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    51bd:	89 45 a4             	mov    %eax,-0x5c(%ebp)
	double y=x,ex_p1=0,ex_p2=0,ex_p3=0,ex_px=0,ex_tmp=1,dex_px=1,tmp;
    51c0:	dd 45 a0             	fldl   -0x60(%ebp)
    51c3:	dd 5d c0             	fstpl  -0x40(%ebp)
    51c6:	d9 ee                	fldz   
    51c8:	dd 5d f0             	fstpl  -0x10(%ebp)
    51cb:	d9 ee                	fldz   
    51cd:	dd 5d b8             	fstpl  -0x48(%ebp)
    51d0:	d9 ee                	fldz   
    51d2:	dd 5d b0             	fstpl  -0x50(%ebp)
    51d5:	d9 ee                	fldz   
    51d7:	dd 5d e8             	fstpl  -0x18(%ebp)
    51da:	d9 e8                	fld1   
    51dc:	dd 5d e0             	fstpl  -0x20(%ebp)
    51df:	d9 e8                	fld1   
    51e1:	dd 5d d8             	fstpl  -0x28(%ebp)
	int l;
	if(x==0) return 1;
    51e4:	dd 45 a0             	fldl   -0x60(%ebp)
    51e7:	d9 ee                	fldz   
    51e9:	df e9                	fucomip %st(1),%st
    51eb:	dd d8                	fstp   %st(0)
    51ed:	7a 12                	jp     5201 <exp+0x53>
    51ef:	dd 45 a0             	fldl   -0x60(%ebp)
    51f2:	d9 ee                	fldz   
    51f4:	df e9                	fucomip %st(1),%st
    51f6:	dd d8                	fstp   %st(0)
    51f8:	75 07                	jne    5201 <exp+0x53>
    51fa:	d9 e8                	fld1   
    51fc:	e9 08 01 00 00       	jmp    5309 <exp+0x15b>
	if(x<0) return 1/exp(-x); 
    5201:	d9 ee                	fldz   
    5203:	dd 45 a0             	fldl   -0x60(%ebp)
    5206:	d9 c9                	fxch   %st(1)
    5208:	df e9                	fucomip %st(1),%st
    520a:	dd d8                	fstp   %st(0)
    520c:	76 16                	jbe    5224 <exp+0x76>
    520e:	dd 45 a0             	fldl   -0x60(%ebp)
    5211:	d9 e0                	fchs   
    5213:	dd 1c 24             	fstpl  (%esp)
    5216:	e8 93 ff ff ff       	call   51ae <exp>
    521b:	d9 e8                	fld1   
    521d:	de f1                	fdivp  %st,%st(1)
    521f:	e9 e5 00 00 00       	jmp    5309 <exp+0x15b>
	for(l=1,tmp=1;((ex_px-ex_tmp)>1e-10 || (ex_px-ex_tmp)<-1e-10) && dex_px>1e-10;l++)
    5224:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
    522b:	d9 e8                	fld1   
    522d:	dd 5d d0             	fstpl  -0x30(%ebp)
    5230:	e9 92 00 00 00       	jmp    52c7 <exp+0x119>
	{
		ex_tmp=ex_px;
    5235:	dd 45 e8             	fldl   -0x18(%ebp)
    5238:	dd 5d e0             	fstpl  -0x20(%ebp)
		tmp*=y;
    523b:	dd 45 d0             	fldl   -0x30(%ebp)
    523e:	dc 4d c0             	fmull  -0x40(%ebp)
    5241:	dd 5d d0             	fstpl  -0x30(%ebp)
		tmp=tmp/l;
    5244:	db 45 cc             	fildl  -0x34(%ebp)
    5247:	dd 45 d0             	fldl   -0x30(%ebp)
    524a:	de f1                	fdivp  %st,%st(1)
    524c:	dd 5d d0             	fstpl  -0x30(%ebp)
		ex_p1+=tmp;
    524f:	dd 45 f0             	fldl   -0x10(%ebp)
    5252:	dc 45 d0             	faddl  -0x30(%ebp)
    5255:	dd 5d f0             	fstpl  -0x10(%ebp)
		ex_p2=ex_p1+tmp*y/(l+1);
    5258:	dd 45 d0             	fldl   -0x30(%ebp)
    525b:	dc 4d c0             	fmull  -0x40(%ebp)
    525e:	8b 45 cc             	mov    -0x34(%ebp),%eax
    5261:	83 c0 01             	add    $0x1,%eax
    5264:	89 45 9c             	mov    %eax,-0x64(%ebp)
    5267:	db 45 9c             	fildl  -0x64(%ebp)
    526a:	de f9                	fdivrp %st,%st(1)
    526c:	dc 45 f0             	faddl  -0x10(%ebp)
    526f:	dd 5d b8             	fstpl  -0x48(%ebp)
		ex_p3=ex_p2+tmp*y*y/(l+1)/(l+2);
    5272:	dd 45 d0             	fldl   -0x30(%ebp)
    5275:	dc 4d c0             	fmull  -0x40(%ebp)
    5278:	dc 4d c0             	fmull  -0x40(%ebp)
    527b:	8b 45 cc             	mov    -0x34(%ebp),%eax
    527e:	83 c0 01             	add    $0x1,%eax
    5281:	89 45 9c             	mov    %eax,-0x64(%ebp)
    5284:	db 45 9c             	fildl  -0x64(%ebp)
    5287:	de f9                	fdivrp %st,%st(1)
    5289:	8b 45 cc             	mov    -0x34(%ebp),%eax
    528c:	83 c0 02             	add    $0x2,%eax
    528f:	89 45 9c             	mov    %eax,-0x64(%ebp)
    5292:	db 45 9c             	fildl  -0x64(%ebp)
    5295:	de f9                	fdivrp %st,%st(1)
    5297:	dc 45 b8             	faddl  -0x48(%ebp)
    529a:	dd 5d b0             	fstpl  -0x50(%ebp)
		dex_px=ex_p3-ex_p2;
    529d:	dd 45 b0             	fldl   -0x50(%ebp)
    52a0:	dc 65 b8             	fsubl  -0x48(%ebp)
    52a3:	dd 5d d8             	fstpl  -0x28(%ebp)
		ex_px=ex_p3-dex_px*dex_px/(ex_p3-2*ex_p2+ex_p1);
    52a6:	dd 45 d8             	fldl   -0x28(%ebp)
    52a9:	dc 4d d8             	fmull  -0x28(%ebp)
    52ac:	dd 45 b8             	fldl   -0x48(%ebp)
    52af:	d8 c0                	fadd   %st(0),%st
    52b1:	dd 45 b0             	fldl   -0x50(%ebp)
    52b4:	de e1                	fsubp  %st,%st(1)
    52b6:	dc 45 f0             	faddl  -0x10(%ebp)
    52b9:	de f9                	fdivrp %st,%st(1)
    52bb:	dd 45 b0             	fldl   -0x50(%ebp)
    52be:	de e1                	fsubp  %st,%st(1)
    52c0:	dd 5d e8             	fstpl  -0x18(%ebp)
{
	double y=x,ex_p1=0,ex_p2=0,ex_p3=0,ex_px=0,ex_tmp=1,dex_px=1,tmp;
	int l;
	if(x==0) return 1;
	if(x<0) return 1/exp(-x); 
	for(l=1,tmp=1;((ex_px-ex_tmp)>1e-10 || (ex_px-ex_tmp)<-1e-10) && dex_px>1e-10;l++)
    52c3:	83 45 cc 01          	addl   $0x1,-0x34(%ebp)
    52c7:	dd 45 e8             	fldl   -0x18(%ebp)
    52ca:	dc 65 e0             	fsubl  -0x20(%ebp)
    52cd:	dd 05 58 b6 00 00    	fldl   0xb658
    52d3:	d9 c9                	fxch   %st(1)
    52d5:	df e9                	fucomip %st(1),%st
    52d7:	dd d8                	fstp   %st(0)
    52d9:	77 12                	ja     52ed <exp+0x13f>
    52db:	dd 45 e8             	fldl   -0x18(%ebp)
    52de:	dc 65 e0             	fsubl  -0x20(%ebp)
    52e1:	dd 05 60 b6 00 00    	fldl   0xb660
    52e7:	df e9                	fucomip %st(1),%st
    52e9:	dd d8                	fstp   %st(0)
    52eb:	76 15                	jbe    5302 <exp+0x154>
    52ed:	dd 45 d8             	fldl   -0x28(%ebp)
    52f0:	dd 05 58 b6 00 00    	fldl   0xb658
    52f6:	d9 c9                	fxch   %st(1)
    52f8:	df e9                	fucomip %st(1),%st
    52fa:	dd d8                	fstp   %st(0)
    52fc:	0f 87 33 ff ff ff    	ja     5235 <exp+0x87>
		ex_p2=ex_p1+tmp*y/(l+1);
		ex_p3=ex_p2+tmp*y*y/(l+1)/(l+2);
		dex_px=ex_p3-ex_p2;
		ex_px=ex_p3-dex_px*dex_px/(ex_p3-2*ex_p2+ex_p1);
	}
	return ex_px+1;
    5302:	dd 45 e8             	fldl   -0x18(%ebp)
    5305:	d9 e8                	fld1   
    5307:	de c1                	faddp  %st,%st(1)
    5309:	c9                   	leave  
    530a:	c3                   	ret    

0000530b <OpenTableFile>:
};
double  s_freq[4] = {44.1, 48, 32, 0};
char *mode_names[4] = { "stereo", "j-stereo", "dual-ch", "single-ch" };

int OpenTableFile(char *name)
{
    530b:	55                   	push   %ebp
    530c:	89 e5                	mov    %esp,%ebp
    530e:	83 ec 78             	sub    $0x78,%esp
	char fulname[80];
	int f;

	fulname[0] = '\0';
    5311:	c6 45 a4 00          	movb   $0x0,-0x5c(%ebp)
	strcpy(fulname, name);
    5315:	8b 45 08             	mov    0x8(%ebp),%eax
    5318:	89 44 24 04          	mov    %eax,0x4(%esp)
    531c:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    531f:	89 04 24             	mov    %eax,(%esp)
    5322:	e8 f0 f1 ff ff       	call   4517 <strcpy>
	//-1 ?
	if( (f=open(fulname,O_RDWR))==-1 ) {
    5327:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    532e:	00 
    532f:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    5332:	89 04 24             	mov    %eax,(%esp)
    5335:	e8 60 f4 ff ff       	call   479a <open>
    533a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    533d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    5341:	75 1b                	jne    535e <OpenTableFile+0x53>
		printf(0,"\nOpenTable: could not find %s\n", fulname);
    5343:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    5346:	89 44 24 08          	mov    %eax,0x8(%esp)
    534a:	c7 44 24 04 94 b6 00 	movl   $0xb694,0x4(%esp)
    5351:	00 
    5352:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5359:	e8 ec f5 ff ff       	call   494a <printf>
    }
    return f;
    535e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    5361:	c9                   	leave  
    5362:	c3                   	ret    

00005363 <WriteHdr>:


void WriteHdr(struct frame_params *fr_ps)
{
    5363:	55                   	push   %ebp
    5364:	89 e5                	mov    %esp,%ebp
    5366:	57                   	push   %edi
    5367:	56                   	push   %esi
    5368:	53                   	push   %ebx
    5369:	83 ec 3c             	sub    $0x3c,%esp
	layer *info = fr_ps->header;
    536c:	8b 45 08             	mov    0x8(%ebp),%eax
    536f:	8b 00                	mov    (%eax),%eax
    5371:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	printf(0, "HDR:  sync=FFF, id=%X, layer=%X, ep=%X, br=%X, sf=%X, pd=%X, ",
    5374:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5377:	8b 78 14             	mov    0x14(%eax),%edi
    537a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    537d:	8b 70 10             	mov    0x10(%eax),%esi
    5380:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5383:	8b 58 0c             	mov    0xc(%eax),%ebx
		info->version, info->lay, !info->error_protection,
    5386:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5389:	8b 40 08             	mov    0x8(%eax),%eax

void WriteHdr(struct frame_params *fr_ps)
{
	layer *info = fr_ps->header;

	printf(0, "HDR:  sync=FFF, id=%X, layer=%X, ep=%X, br=%X, sf=%X, pd=%X, ",
    538c:	85 c0                	test   %eax,%eax
    538e:	0f 94 c0             	sete   %al
    5391:	0f b6 c8             	movzbl %al,%ecx
    5394:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5397:	8b 50 04             	mov    0x4(%eax),%edx
    539a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    539d:	8b 00                	mov    (%eax),%eax
    539f:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
    53a3:	89 74 24 18          	mov    %esi,0x18(%esp)
    53a7:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    53ab:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    53af:	89 54 24 0c          	mov    %edx,0xc(%esp)
    53b3:	89 44 24 08          	mov    %eax,0x8(%esp)
    53b7:	c7 44 24 04 b4 b6 00 	movl   $0xb6b4,0x4(%esp)
    53be:	00 
    53bf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    53c6:	e8 7f f5 ff ff       	call   494a <printf>
		info->version, info->lay, !info->error_protection,
		info->bitrate_index, info->sampling_frequency, info->padding);

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
    53cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    53ce:	8b 78 2c             	mov    0x2c(%eax),%edi
    53d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    53d4:	8b 70 28             	mov    0x28(%eax),%esi
    53d7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    53da:	8b 58 24             	mov    0x24(%eax),%ebx
    53dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    53e0:	8b 48 20             	mov    0x20(%eax),%ecx
    53e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    53e6:	8b 50 1c             	mov    0x1c(%eax),%edx
    53e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    53ec:	8b 40 18             	mov    0x18(%eax),%eax
    53ef:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
    53f3:	89 74 24 18          	mov    %esi,0x18(%esp)
    53f7:	89 5c 24 14          	mov    %ebx,0x14(%esp)
    53fb:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    53ff:	89 54 24 0c          	mov    %edx,0xc(%esp)
    5403:	89 44 24 08          	mov    %eax,0x8(%esp)
    5407:	c7 44 24 04 f4 b6 00 	movl   $0xb6f4,0x4(%esp)
    540e:	00 
    540f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5416:	e8 2f f5 ff ff       	call   494a <printf>
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);
    541b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    541e:	8b 40 1c             	mov    0x1c(%eax),%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    5421:	8b 0c 85 00 f0 00 00 	mov    0xf000(,%eax,4),%ecx
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);
    5428:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    542b:	8b 40 10             	mov    0x10(%eax),%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    542e:	dd 04 c5 e0 ef 00 00 	fldl   0xefe0(,%eax,8)
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
    5435:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5438:	8b 40 04             	mov    0x4(%eax),%eax
    543b:	8d 50 ff             	lea    -0x1(%eax),%edx
    543e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5441:	8b 58 0c             	mov    0xc(%eax),%ebx

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    5444:	89 d0                	mov    %edx,%eax
    5446:	c1 e0 04             	shl    $0x4,%eax
    5449:	29 d0                	sub    %edx,%eax
    544b:	01 d8                	add    %ebx,%eax
    544d:	8b 14 85 20 ef 00 00 	mov    0xef20(,%eax,4),%edx
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
    5454:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5457:	8b 40 04             	mov    0x4(%eax),%eax
    545a:	83 e8 01             	sub    $0x1,%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    545d:	8b 04 85 00 ef 00 00 	mov    0xef00(,%eax,4),%eax
    5464:	89 4c 24 18          	mov    %ecx,0x18(%esp)
    5468:	dd 5c 24 10          	fstpl  0x10(%esp)
    546c:	89 54 24 0c          	mov    %edx,0xc(%esp)
    5470:	89 44 24 08          	mov    %eax,0x8(%esp)
    5474:	c7 44 24 04 1c b7 00 	movl   $0xb71c,0x4(%esp)
    547b:	00 
    547c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5483:	e8 c2 f4 ff ff       	call   494a <printf>
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);

	printf(0, "sblim=%d, jsbd=%d, ch=%d\n",
    5488:	8b 45 08             	mov    0x8(%ebp),%eax
    548b:	8b 48 08             	mov    0x8(%eax),%ecx
    548e:	8b 45 08             	mov    0x8(%ebp),%eax
    5491:	8b 50 0c             	mov    0xc(%eax),%edx
    5494:	8b 45 08             	mov    0x8(%ebp),%eax
    5497:	8b 40 10             	mov    0x10(%eax),%eax
    549a:	89 4c 24 10          	mov    %ecx,0x10(%esp)
    549e:	89 54 24 0c          	mov    %edx,0xc(%esp)
    54a2:	89 44 24 08          	mov    %eax,0x8(%esp)
    54a6:	c7 44 24 04 4b b7 00 	movl   $0xb74b,0x4(%esp)
    54ad:	00 
    54ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    54b5:	e8 90 f4 ff ff       	call   494a <printf>
		fr_ps->sblimit, fr_ps->jsbound, fr_ps->stereo);
}
    54ba:	83 c4 3c             	add    $0x3c,%esp
    54bd:	5b                   	pop    %ebx
    54be:	5e                   	pop    %esi
    54bf:	5f                   	pop    %edi
    54c0:	5d                   	pop    %ebp
    54c1:	c3                   	ret    

000054c2 <mem_alloc>:

void *mem_alloc(unsigned long block, char *item)
{
    54c2:	55                   	push   %ebp
    54c3:	89 e5                	mov    %esp,%ebp
    54c5:	83 ec 28             	sub    $0x28,%esp
	void *ptr;
	ptr = (void *)malloc((unsigned long)block);
    54c8:	8b 45 08             	mov    0x8(%ebp),%eax
    54cb:	89 04 24             	mov    %eax,(%esp)
    54ce:	e8 63 f7 ff ff       	call   4c36 <malloc>
    54d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if (ptr != 0)
    54d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    54da:	74 1c                	je     54f8 <mem_alloc+0x36>
		memset(ptr, 0, block);
    54dc:	8b 45 08             	mov    0x8(%ebp),%eax
    54df:	89 44 24 08          	mov    %eax,0x8(%esp)
    54e3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    54ea:	00 
    54eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    54ee:	89 04 24             	mov    %eax,(%esp)
    54f1:	e8 b7 f0 ff ff       	call   45ad <memset>
    54f6:	eb 20                	jmp    5518 <mem_alloc+0x56>
	else{
		printf(0, "Unable to allocate %s\n", item);
    54f8:	8b 45 0c             	mov    0xc(%ebp),%eax
    54fb:	89 44 24 08          	mov    %eax,0x8(%esp)
    54ff:	c7 44 24 04 65 b7 00 	movl   $0xb765,0x4(%esp)
    5506:	00 
    5507:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    550e:	e8 37 f4 ff ff       	call   494a <printf>
		exit();
    5513:	e8 42 f2 ff ff       	call   475a <exit>
	}
	return ptr;
    5518:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    551b:	c9                   	leave  
    551c:	c3                   	ret    

0000551d <alloc_buffer>:

void alloc_buffer(Bit_stream_struc *bs, int size)
{
    551d:	55                   	push   %ebp
    551e:	89 e5                	mov    %esp,%ebp
    5520:	83 ec 18             	sub    $0x18,%esp
	bs->buf = (unsigned char *) mem_alloc(size*sizeof(unsigned char), "buffer");
    5523:	8b 45 0c             	mov    0xc(%ebp),%eax
    5526:	c7 44 24 04 7c b7 00 	movl   $0xb77c,0x4(%esp)
    552d:	00 
    552e:	89 04 24             	mov    %eax,(%esp)
    5531:	e8 8c ff ff ff       	call   54c2 <mem_alloc>
    5536:	8b 55 08             	mov    0x8(%ebp),%edx
    5539:	89 42 04             	mov    %eax,0x4(%edx)
	bs->buf_size = size;
    553c:	8b 45 08             	mov    0x8(%ebp),%eax
    553f:	8b 55 0c             	mov    0xc(%ebp),%edx
    5542:	89 50 08             	mov    %edx,0x8(%eax)
}
    5545:	c9                   	leave  
    5546:	c3                   	ret    

00005547 <desalloc_buffer>:

void desalloc_buffer(Bit_stream_struc *bs)
{
    5547:	55                   	push   %ebp
    5548:	89 e5                	mov    %esp,%ebp
    554a:	83 ec 18             	sub    $0x18,%esp
	free(bs->buf);
    554d:	8b 45 08             	mov    0x8(%ebp),%eax
    5550:	8b 40 04             	mov    0x4(%eax),%eax
    5553:	89 04 24             	mov    %eax,(%esp)
    5556:	e8 a2 f5 ff ff       	call   4afd <free>
}
    555b:	c9                   	leave  
    555c:	c3                   	ret    

0000555d <open_bit_stream_r>:

void open_bit_stream_r(Bit_stream_struc *bs, char *bs_filenam, int size)
{
    555d:	55                   	push   %ebp
    555e:	89 e5                	mov    %esp,%ebp
    5560:	83 ec 18             	sub    $0x18,%esp
	//register unsigned char flag = 1;

	if ((bs->pt = open(bs_filenam, O_RDWR)) == -1) {
    5563:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    556a:	00 
    556b:	8b 45 0c             	mov    0xc(%ebp),%eax
    556e:	89 04 24             	mov    %eax,(%esp)
    5571:	e8 24 f2 ff ff       	call   479a <open>
    5576:	8b 55 08             	mov    0x8(%ebp),%edx
    5579:	89 02                	mov    %eax,(%edx)
    557b:	8b 45 08             	mov    0x8(%ebp),%eax
    557e:	8b 00                	mov    (%eax),%eax
    5580:	83 f8 ff             	cmp    $0xffffffff,%eax
    5583:	75 20                	jne    55a5 <open_bit_stream_r+0x48>
		printf(0, "Could not find \"%s\".\n", bs_filenam);
    5585:	8b 45 0c             	mov    0xc(%ebp),%eax
    5588:	89 44 24 08          	mov    %eax,0x8(%esp)
    558c:	c7 44 24 04 83 b7 00 	movl   $0xb783,0x4(%esp)
    5593:	00 
    5594:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    559b:	e8 aa f3 ff ff       	call   494a <printf>
		exit();
    55a0:	e8 b5 f1 ff ff       	call   475a <exit>
	}

	bs->format = BINARY;
    55a5:	8b 45 08             	mov    0x8(%ebp),%eax
    55a8:	c6 40 24 00          	movb   $0x0,0x24(%eax)
	alloc_buffer(bs, size);
    55ac:	8b 45 10             	mov    0x10(%ebp),%eax
    55af:	89 44 24 04          	mov    %eax,0x4(%esp)
    55b3:	8b 45 08             	mov    0x8(%ebp),%eax
    55b6:	89 04 24             	mov    %eax,(%esp)
    55b9:	e8 5f ff ff ff       	call   551d <alloc_buffer>
	bs->buf_byte_idx=0;
    55be:	8b 45 08             	mov    0x8(%ebp),%eax
    55c1:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
	bs->buf_bit_idx=0;
    55c8:	8b 45 08             	mov    0x8(%ebp),%eax
    55cb:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
	bs->totbit=0;
    55d2:	8b 45 08             	mov    0x8(%ebp),%eax
    55d5:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	bs->mode = READ_MODE;
    55dc:	8b 45 08             	mov    0x8(%ebp),%eax
    55df:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
	bs->eob = FALSE;
    55e6:	8b 45 08             	mov    0x8(%ebp),%eax
    55e9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
	bs->eobs = FALSE;
    55f0:	8b 45 08             	mov    0x8(%ebp),%eax
    55f3:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
    55fa:	c9                   	leave  
    55fb:	c3                   	ret    

000055fc <close_bit_stream_r>:

void close_bit_stream_r(Bit_stream_struc *bs)
{
    55fc:	55                   	push   %ebp
    55fd:	89 e5                	mov    %esp,%ebp
    55ff:	83 ec 18             	sub    $0x18,%esp
	close(bs->pt);
    5602:	8b 45 08             	mov    0x8(%ebp),%eax
    5605:	8b 00                	mov    (%eax),%eax
    5607:	89 04 24             	mov    %eax,(%esp)
    560a:	e8 73 f1 ff ff       	call   4782 <close>
	desalloc_buffer(bs);
    560f:	8b 45 08             	mov    0x8(%ebp),%eax
    5612:	89 04 24             	mov    %eax,(%esp)
    5615:	e8 2d ff ff ff       	call   5547 <desalloc_buffer>
}
    561a:	c9                   	leave  
    561b:	c3                   	ret    

0000561c <end_bs>:

int end_bs(Bit_stream_struc *bs)
{
    561c:	55                   	push   %ebp
    561d:	89 e5                	mov    %esp,%ebp
  return(bs->eobs);
    561f:	8b 45 08             	mov    0x8(%ebp),%eax
    5622:	8b 40 20             	mov    0x20(%eax),%eax
}
    5625:	5d                   	pop    %ebp
    5626:	c3                   	ret    

00005627 <sstell>:


unsigned long sstell(Bit_stream_struc *bs)
{
    5627:	55                   	push   %ebp
    5628:	89 e5                	mov    %esp,%ebp
  return(bs->totbit);
    562a:	8b 45 08             	mov    0x8(%ebp),%eax
    562d:	8b 40 0c             	mov    0xc(%eax),%eax
}
    5630:	5d                   	pop    %ebp
    5631:	c3                   	ret    

00005632 <refill_buffer>:


void refill_buffer(Bit_stream_struc *bs)
{
    5632:	55                   	push   %ebp
    5633:	89 e5                	mov    %esp,%ebp
    5635:	56                   	push   %esi
    5636:	53                   	push   %ebx
    5637:	83 ec 10             	sub    $0x10,%esp
	register int i=bs->buf_size-2-bs->buf_byte_idx;
    563a:	8b 45 08             	mov    0x8(%ebp),%eax
    563d:	8b 40 08             	mov    0x8(%eax),%eax
    5640:	8d 50 fe             	lea    -0x2(%eax),%edx
    5643:	8b 45 08             	mov    0x8(%ebp),%eax
    5646:	8b 40 10             	mov    0x10(%eax),%eax
    5649:	89 d3                	mov    %edx,%ebx
    564b:	29 c3                	sub    %eax,%ebx
	register unsigned long n=1;
    564d:	be 01 00 00 00       	mov    $0x1,%esi

	while ((i>=0) && (!bs->eob)) {
    5652:	eb 35                	jmp    5689 <refill_buffer+0x57>
			n=read(bs->pt, &bs->buf[i--], sizeof(unsigned char));
    5654:	8b 45 08             	mov    0x8(%ebp),%eax
    5657:	8b 50 04             	mov    0x4(%eax),%edx
    565a:	89 d8                	mov    %ebx,%eax
    565c:	8d 58 ff             	lea    -0x1(%eax),%ebx
    565f:	01 c2                	add    %eax,%edx
    5661:	8b 45 08             	mov    0x8(%ebp),%eax
    5664:	8b 00                	mov    (%eax),%eax
    5666:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    566d:	00 
    566e:	89 54 24 04          	mov    %edx,0x4(%esp)
    5672:	89 04 24             	mov    %eax,(%esp)
    5675:	e8 f8 f0 ff ff       	call   4772 <read>
    567a:	89 c6                	mov    %eax,%esi
		if (!n)
    567c:	85 f6                	test   %esi,%esi
    567e:	75 09                	jne    5689 <refill_buffer+0x57>
		bs->eob= i+1;
    5680:	8d 53 01             	lea    0x1(%ebx),%edx
    5683:	8b 45 08             	mov    0x8(%ebp),%eax
    5686:	89 50 1c             	mov    %edx,0x1c(%eax)
void refill_buffer(Bit_stream_struc *bs)
{
	register int i=bs->buf_size-2-bs->buf_byte_idx;
	register unsigned long n=1;

	while ((i>=0) && (!bs->eob)) {
    5689:	85 db                	test   %ebx,%ebx
    568b:	78 0a                	js     5697 <refill_buffer+0x65>
    568d:	8b 45 08             	mov    0x8(%ebp),%eax
    5690:	8b 40 1c             	mov    0x1c(%eax),%eax
    5693:	85 c0                	test   %eax,%eax
    5695:	74 bd                	je     5654 <refill_buffer+0x22>
			n=read(bs->pt, &bs->buf[i--], sizeof(unsigned char));
		if (!n)
		bs->eob= i+1;
	}
}
    5697:	83 c4 10             	add    $0x10,%esp
    569a:	5b                   	pop    %ebx
    569b:	5e                   	pop    %esi
    569c:	5d                   	pop    %ebp
    569d:	c3                   	ret    

0000569e <get1bit>:


int mask[8]={0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80};

unsigned int get1bit(Bit_stream_struc *bs)
{
    569e:	55                   	push   %ebp
    569f:	89 e5                	mov    %esp,%ebp
    56a1:	53                   	push   %ebx
    56a2:	83 ec 24             	sub    $0x24,%esp
   unsigned int bit;
   register int i;

   bs->totbit++;
    56a5:	8b 45 08             	mov    0x8(%ebp),%eax
    56a8:	8b 40 0c             	mov    0xc(%eax),%eax
    56ab:	8d 50 01             	lea    0x1(%eax),%edx
    56ae:	8b 45 08             	mov    0x8(%ebp),%eax
    56b1:	89 50 0c             	mov    %edx,0xc(%eax)

   if (!bs->buf_bit_idx) {
    56b4:	8b 45 08             	mov    0x8(%ebp),%eax
    56b7:	8b 40 14             	mov    0x14(%eax),%eax
    56ba:	85 c0                	test   %eax,%eax
    56bc:	0f 85 9f 00 00 00    	jne    5761 <get1bit+0xc3>
        bs->buf_bit_idx = 8;
    56c2:	8b 45 08             	mov    0x8(%ebp),%eax
    56c5:	c7 40 14 08 00 00 00 	movl   $0x8,0x14(%eax)
        bs->buf_byte_idx--;
    56cc:	8b 45 08             	mov    0x8(%ebp),%eax
    56cf:	8b 40 10             	mov    0x10(%eax),%eax
    56d2:	8d 50 ff             	lea    -0x1(%eax),%edx
    56d5:	8b 45 08             	mov    0x8(%ebp),%eax
    56d8:	89 50 10             	mov    %edx,0x10(%eax)
        if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
    56db:	8b 45 08             	mov    0x8(%ebp),%eax
    56de:	8b 40 10             	mov    0x10(%eax),%eax
    56e1:	83 f8 03             	cmp    $0x3,%eax
    56e4:	7e 10                	jle    56f6 <get1bit+0x58>
    56e6:	8b 45 08             	mov    0x8(%ebp),%eax
    56e9:	8b 50 10             	mov    0x10(%eax),%edx
    56ec:	8b 45 08             	mov    0x8(%ebp),%eax
    56ef:	8b 40 1c             	mov    0x1c(%eax),%eax
    56f2:	39 c2                	cmp    %eax,%edx
    56f4:	7d 6b                	jge    5761 <get1bit+0xc3>
             if (bs->eob)
    56f6:	8b 45 08             	mov    0x8(%ebp),%eax
    56f9:	8b 40 1c             	mov    0x1c(%eax),%eax
    56fc:	85 c0                	test   %eax,%eax
    56fe:	74 0c                	je     570c <get1bit+0x6e>
                bs->eobs = TRUE;
    5700:	8b 45 08             	mov    0x8(%ebp),%eax
    5703:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
    570a:	eb 55                	jmp    5761 <get1bit+0xc3>
             else {
                for (i=bs->buf_byte_idx; i>=0;i--)
    570c:	8b 45 08             	mov    0x8(%ebp),%eax
    570f:	8b 58 10             	mov    0x10(%eax),%ebx
    5712:	eb 2f                	jmp    5743 <get1bit+0xa5>
                  bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
    5714:	8b 45 08             	mov    0x8(%ebp),%eax
    5717:	8b 50 04             	mov    0x4(%eax),%edx
    571a:	8b 45 08             	mov    0x8(%ebp),%eax
    571d:	8b 40 08             	mov    0x8(%eax),%eax
    5720:	8d 48 ff             	lea    -0x1(%eax),%ecx
    5723:	8b 45 08             	mov    0x8(%ebp),%eax
    5726:	8b 40 10             	mov    0x10(%eax),%eax
    5729:	29 c1                	sub    %eax,%ecx
    572b:	89 c8                	mov    %ecx,%eax
    572d:	01 d8                	add    %ebx,%eax
    572f:	01 c2                	add    %eax,%edx
    5731:	8b 45 08             	mov    0x8(%ebp),%eax
    5734:	8b 48 04             	mov    0x4(%eax),%ecx
    5737:	89 d8                	mov    %ebx,%eax
    5739:	01 c8                	add    %ecx,%eax
    573b:	0f b6 00             	movzbl (%eax),%eax
    573e:	88 02                	mov    %al,(%edx)
        bs->buf_byte_idx--;
        if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
             if (bs->eob)
                bs->eobs = TRUE;
             else {
                for (i=bs->buf_byte_idx; i>=0;i--)
    5740:	83 eb 01             	sub    $0x1,%ebx
    5743:	85 db                	test   %ebx,%ebx
    5745:	79 cd                	jns    5714 <get1bit+0x76>
                  bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
                refill_buffer(bs);
    5747:	8b 45 08             	mov    0x8(%ebp),%eax
    574a:	89 04 24             	mov    %eax,(%esp)
    574d:	e8 e0 fe ff ff       	call   5632 <refill_buffer>
                bs->buf_byte_idx = bs->buf_size-1;
    5752:	8b 45 08             	mov    0x8(%ebp),%eax
    5755:	8b 40 08             	mov    0x8(%eax),%eax
    5758:	8d 50 ff             	lea    -0x1(%eax),%edx
    575b:	8b 45 08             	mov    0x8(%ebp),%eax
    575e:	89 50 10             	mov    %edx,0x10(%eax)
             }
        }
   }
   bit = bs->buf[bs->buf_byte_idx]&mask[bs->buf_bit_idx-1];
    5761:	8b 45 08             	mov    0x8(%ebp),%eax
    5764:	8b 50 04             	mov    0x4(%eax),%edx
    5767:	8b 45 08             	mov    0x8(%ebp),%eax
    576a:	8b 40 10             	mov    0x10(%eax),%eax
    576d:	01 d0                	add    %edx,%eax
    576f:	0f b6 00             	movzbl (%eax),%eax
    5772:	0f b6 d0             	movzbl %al,%edx
    5775:	8b 45 08             	mov    0x8(%ebp),%eax
    5778:	8b 40 14             	mov    0x14(%eax),%eax
    577b:	83 e8 01             	sub    $0x1,%eax
    577e:	8b 04 85 20 f0 00 00 	mov    0xf020(,%eax,4),%eax
    5785:	21 d0                	and    %edx,%eax
    5787:	89 45 f4             	mov    %eax,-0xc(%ebp)
   bit = bit >> (bs->buf_bit_idx-1);
    578a:	8b 45 08             	mov    0x8(%ebp),%eax
    578d:	8b 40 14             	mov    0x14(%eax),%eax
    5790:	83 e8 01             	sub    $0x1,%eax
    5793:	89 c1                	mov    %eax,%ecx
    5795:	d3 6d f4             	shrl   %cl,-0xc(%ebp)
   bs->buf_bit_idx--;
    5798:	8b 45 08             	mov    0x8(%ebp),%eax
    579b:	8b 40 14             	mov    0x14(%eax),%eax
    579e:	8d 50 ff             	lea    -0x1(%eax),%edx
    57a1:	8b 45 08             	mov    0x8(%ebp),%eax
    57a4:	89 50 14             	mov    %edx,0x14(%eax)
   return(bit);
    57a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    57aa:	83 c4 24             	add    $0x24,%esp
    57ad:	5b                   	pop    %ebx
    57ae:	5d                   	pop    %ebp
    57af:	c3                   	ret    

000057b0 <getbits>:

int putmask[9]={0x0, 0x1, 0x3, 0x7, 0xf, 0x1f, 0x3f, 0x7f, 0xff};

unsigned long getbits(Bit_stream_struc *bs, int N)
{
    57b0:	55                   	push   %ebp
    57b1:	89 e5                	mov    %esp,%ebp
    57b3:	57                   	push   %edi
    57b4:	56                   	push   %esi
    57b5:	53                   	push   %ebx
    57b6:	83 ec 2c             	sub    $0x2c,%esp
	unsigned long val=0;
    57b9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	register int i;
	register int j = N;
    57c0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	register int k, tmp;

	if (N > MAX_LENGTH)
    57c3:	83 7d 0c 20          	cmpl   $0x20,0xc(%ebp)
    57c7:	7e 1c                	jle    57e5 <getbits+0x35>
		printf(0,"Cannot read or write more than %d bits at a time.\n", MAX_LENGTH);
    57c9:	c7 44 24 08 20 00 00 	movl   $0x20,0x8(%esp)
    57d0:	00 
    57d1:	c7 44 24 04 9c b7 00 	movl   $0xb79c,0x4(%esp)
    57d8:	00 
    57d9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    57e0:	e8 65 f1 ff ff       	call   494a <printf>

	bs->totbit += N;
    57e5:	8b 45 08             	mov    0x8(%ebp),%eax
    57e8:	8b 50 0c             	mov    0xc(%eax),%edx
    57eb:	8b 45 0c             	mov    0xc(%ebp),%eax
    57ee:	01 c2                	add    %eax,%edx
    57f0:	8b 45 08             	mov    0x8(%ebp),%eax
    57f3:	89 50 0c             	mov    %edx,0xc(%eax)
	while (j > 0) {
    57f6:	e9 0a 01 00 00       	jmp    5905 <getbits+0x155>
		if (!bs->buf_bit_idx) {
    57fb:	8b 45 08             	mov    0x8(%ebp),%eax
    57fe:	8b 40 14             	mov    0x14(%eax),%eax
    5801:	85 c0                	test   %eax,%eax
    5803:	0f 85 9f 00 00 00    	jne    58a8 <getbits+0xf8>
			bs->buf_bit_idx = 8;
    5809:	8b 45 08             	mov    0x8(%ebp),%eax
    580c:	c7 40 14 08 00 00 00 	movl   $0x8,0x14(%eax)
			bs->buf_byte_idx--;
    5813:	8b 45 08             	mov    0x8(%ebp),%eax
    5816:	8b 40 10             	mov    0x10(%eax),%eax
    5819:	8d 50 ff             	lea    -0x1(%eax),%edx
    581c:	8b 45 08             	mov    0x8(%ebp),%eax
    581f:	89 50 10             	mov    %edx,0x10(%eax)
			if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
    5822:	8b 45 08             	mov    0x8(%ebp),%eax
    5825:	8b 40 10             	mov    0x10(%eax),%eax
    5828:	83 f8 03             	cmp    $0x3,%eax
    582b:	7e 10                	jle    583d <getbits+0x8d>
    582d:	8b 45 08             	mov    0x8(%ebp),%eax
    5830:	8b 50 10             	mov    0x10(%eax),%edx
    5833:	8b 45 08             	mov    0x8(%ebp),%eax
    5836:	8b 40 1c             	mov    0x1c(%eax),%eax
    5839:	39 c2                	cmp    %eax,%edx
    583b:	7d 6b                	jge    58a8 <getbits+0xf8>
				if (bs->eob)
    583d:	8b 45 08             	mov    0x8(%ebp),%eax
    5840:	8b 40 1c             	mov    0x1c(%eax),%eax
    5843:	85 c0                	test   %eax,%eax
    5845:	74 0c                	je     5853 <getbits+0xa3>
					bs->eobs = TRUE;
    5847:	8b 45 08             	mov    0x8(%ebp),%eax
    584a:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
    5851:	eb 55                	jmp    58a8 <getbits+0xf8>
				else {
					for (i=bs->buf_byte_idx; i>=0;i--)
    5853:	8b 45 08             	mov    0x8(%ebp),%eax
    5856:	8b 70 10             	mov    0x10(%eax),%esi
    5859:	eb 2f                	jmp    588a <getbits+0xda>
						bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
    585b:	8b 45 08             	mov    0x8(%ebp),%eax
    585e:	8b 50 04             	mov    0x4(%eax),%edx
    5861:	8b 45 08             	mov    0x8(%ebp),%eax
    5864:	8b 40 08             	mov    0x8(%eax),%eax
    5867:	8d 48 ff             	lea    -0x1(%eax),%ecx
    586a:	8b 45 08             	mov    0x8(%ebp),%eax
    586d:	8b 40 10             	mov    0x10(%eax),%eax
    5870:	29 c1                	sub    %eax,%ecx
    5872:	89 c8                	mov    %ecx,%eax
    5874:	01 f0                	add    %esi,%eax
    5876:	01 c2                	add    %eax,%edx
    5878:	8b 45 08             	mov    0x8(%ebp),%eax
    587b:	8b 48 04             	mov    0x4(%eax),%ecx
    587e:	89 f0                	mov    %esi,%eax
    5880:	01 c8                	add    %ecx,%eax
    5882:	0f b6 00             	movzbl (%eax),%eax
    5885:	88 02                	mov    %al,(%edx)
			bs->buf_byte_idx--;
			if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
				if (bs->eob)
					bs->eobs = TRUE;
				else {
					for (i=bs->buf_byte_idx; i>=0;i--)
    5887:	83 ee 01             	sub    $0x1,%esi
    588a:	85 f6                	test   %esi,%esi
    588c:	79 cd                	jns    585b <getbits+0xab>
						bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
						refill_buffer(bs);
    588e:	8b 45 08             	mov    0x8(%ebp),%eax
    5891:	89 04 24             	mov    %eax,(%esp)
    5894:	e8 99 fd ff ff       	call   5632 <refill_buffer>
					bs->buf_byte_idx = bs->buf_size-1;
    5899:	8b 45 08             	mov    0x8(%ebp),%eax
    589c:	8b 40 08             	mov    0x8(%eax),%eax
    589f:	8d 50 ff             	lea    -0x1(%eax),%edx
    58a2:	8b 45 08             	mov    0x8(%ebp),%eax
    58a5:	89 50 10             	mov    %edx,0x10(%eax)
				}
			}
		}
		k = MIN(j, bs->buf_bit_idx);
    58a8:	8b 45 08             	mov    0x8(%ebp),%eax
    58ab:	8b 40 14             	mov    0x14(%eax),%eax
    58ae:	39 d8                	cmp    %ebx,%eax
    58b0:	0f 4f c3             	cmovg  %ebx,%eax
    58b3:	89 c6                	mov    %eax,%esi
		tmp = bs->buf[bs->buf_byte_idx]&putmask[bs->buf_bit_idx];
    58b5:	8b 45 08             	mov    0x8(%ebp),%eax
    58b8:	8b 50 04             	mov    0x4(%eax),%edx
    58bb:	8b 45 08             	mov    0x8(%ebp),%eax
    58be:	8b 40 10             	mov    0x10(%eax),%eax
    58c1:	01 d0                	add    %edx,%eax
    58c3:	0f b6 00             	movzbl (%eax),%eax
    58c6:	0f b6 d0             	movzbl %al,%edx
    58c9:	8b 45 08             	mov    0x8(%ebp),%eax
    58cc:	8b 40 14             	mov    0x14(%eax),%eax
    58cf:	8b 04 85 40 f0 00 00 	mov    0xf040(,%eax,4),%eax
    58d6:	89 d7                	mov    %edx,%edi
    58d8:	21 c7                	and    %eax,%edi
		tmp = tmp >> (bs->buf_bit_idx-k);
    58da:	8b 45 08             	mov    0x8(%ebp),%eax
    58dd:	8b 40 14             	mov    0x14(%eax),%eax
    58e0:	29 f0                	sub    %esi,%eax
    58e2:	89 c1                	mov    %eax,%ecx
    58e4:	d3 ff                	sar    %cl,%edi
		val |= tmp << (j-k);
    58e6:	89 d8                	mov    %ebx,%eax
    58e8:	29 f0                	sub    %esi,%eax
    58ea:	89 c1                	mov    %eax,%ecx
    58ec:	d3 e7                	shl    %cl,%edi
    58ee:	89 f8                	mov    %edi,%eax
    58f0:	09 45 e4             	or     %eax,-0x1c(%ebp)
		bs->buf_bit_idx -= k;
    58f3:	8b 45 08             	mov    0x8(%ebp),%eax
    58f6:	8b 40 14             	mov    0x14(%eax),%eax
    58f9:	29 f0                	sub    %esi,%eax
    58fb:	89 c2                	mov    %eax,%edx
    58fd:	8b 45 08             	mov    0x8(%ebp),%eax
    5900:	89 50 14             	mov    %edx,0x14(%eax)
		j -= k;
    5903:	29 f3                	sub    %esi,%ebx

	if (N > MAX_LENGTH)
		printf(0,"Cannot read or write more than %d bits at a time.\n", MAX_LENGTH);

	bs->totbit += N;
	while (j > 0) {
    5905:	85 db                	test   %ebx,%ebx
    5907:	0f 8f ee fe ff ff    	jg     57fb <getbits+0x4b>
		tmp = tmp >> (bs->buf_bit_idx-k);
		val |= tmp << (j-k);
		bs->buf_bit_idx -= k;
		j -= k;
	}
	return val;
    590d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
    5910:	83 c4 2c             	add    $0x2c,%esp
    5913:	5b                   	pop    %ebx
    5914:	5e                   	pop    %esi
    5915:	5f                   	pop    %edi
    5916:	5d                   	pop    %ebp
    5917:	c3                   	ret    

00005918 <seek_sync>:


int seek_sync(Bit_stream_struc *bs, unsigned long sync, int N)
{
    5918:	55                   	push   %ebp
    5919:	89 e5                	mov    %esp,%ebp
    591b:	83 ec 38             	sub    $0x38,%esp
	unsigned long aligning;
	unsigned long val;
	long maxi = (int)pow(2.0, (double)N) - 1;
    591e:	db 45 10             	fildl  0x10(%ebp)
    5921:	dd 5c 24 08          	fstpl  0x8(%esp)
    5925:	dd 05 08 b8 00 00    	fldl   0xb808
    592b:	dd 1c 24             	fstpl  (%esp)
    592e:	e8 ec f4 ff ff       	call   4e1f <pow>
    5933:	d9 7d e6             	fnstcw -0x1a(%ebp)
    5936:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    593a:	b4 0c                	mov    $0xc,%ah
    593c:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    5940:	d9 6d e4             	fldcw  -0x1c(%ebp)
    5943:	db 5d e0             	fistpl -0x20(%ebp)
    5946:	d9 6d e6             	fldcw  -0x1a(%ebp)
    5949:	8b 45 e0             	mov    -0x20(%ebp),%eax
    594c:	83 e8 01             	sub    $0x1,%eax
    594f:	89 45 f0             	mov    %eax,-0x10(%ebp)

	aligning = sstell(bs)%ALIGNING;
    5952:	8b 45 08             	mov    0x8(%ebp),%eax
    5955:	89 04 24             	mov    %eax,(%esp)
    5958:	e8 ca fc ff ff       	call   5627 <sstell>
    595d:	83 e0 07             	and    $0x7,%eax
    5960:	89 45 ec             	mov    %eax,-0x14(%ebp)
	if (aligning)
    5963:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    5967:	74 17                	je     5980 <seek_sync+0x68>
		getbits(bs, (int)(ALIGNING-aligning));
    5969:	b8 08 00 00 00       	mov    $0x8,%eax
    596e:	2b 45 ec             	sub    -0x14(%ebp),%eax
    5971:	89 44 24 04          	mov    %eax,0x4(%esp)
    5975:	8b 45 08             	mov    0x8(%ebp),%eax
    5978:	89 04 24             	mov    %eax,(%esp)
    597b:	e8 30 fe ff ff       	call   57b0 <getbits>

	val = getbits(bs, N);
    5980:	8b 45 10             	mov    0x10(%ebp),%eax
    5983:	89 44 24 04          	mov    %eax,0x4(%esp)
    5987:	8b 45 08             	mov    0x8(%ebp),%eax
    598a:	89 04 24             	mov    %eax,(%esp)
    598d:	e8 1e fe ff ff       	call   57b0 <getbits>
    5992:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (((val&maxi) != sync) && (!end_bs(bs))) {
    5995:	eb 1a                	jmp    59b1 <seek_sync+0x99>
		val <<= ALIGNING;
    5997:	c1 65 f4 08          	shll   $0x8,-0xc(%ebp)
		val |= getbits(bs, ALIGNING);
    599b:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
    59a2:	00 
    59a3:	8b 45 08             	mov    0x8(%ebp),%eax
    59a6:	89 04 24             	mov    %eax,(%esp)
    59a9:	e8 02 fe ff ff       	call   57b0 <getbits>
    59ae:	09 45 f4             	or     %eax,-0xc(%ebp)
	aligning = sstell(bs)%ALIGNING;
	if (aligning)
		getbits(bs, (int)(ALIGNING-aligning));

	val = getbits(bs, N);
	while (((val&maxi) != sync) && (!end_bs(bs))) {
    59b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    59b4:	23 45 f4             	and    -0xc(%ebp),%eax
    59b7:	3b 45 0c             	cmp    0xc(%ebp),%eax
    59ba:	74 0f                	je     59cb <seek_sync+0xb3>
    59bc:	8b 45 08             	mov    0x8(%ebp),%eax
    59bf:	89 04 24             	mov    %eax,(%esp)
    59c2:	e8 55 fc ff ff       	call   561c <end_bs>
    59c7:	85 c0                	test   %eax,%eax
    59c9:	74 cc                	je     5997 <seek_sync+0x7f>
		val <<= ALIGNING;
		val |= getbits(bs, ALIGNING);
	}

	if (end_bs(bs))
    59cb:	8b 45 08             	mov    0x8(%ebp),%eax
    59ce:	89 04 24             	mov    %eax,(%esp)
    59d1:	e8 46 fc ff ff       	call   561c <end_bs>
    59d6:	85 c0                	test   %eax,%eax
    59d8:	74 07                	je     59e1 <seek_sync+0xc9>
		return(0);
    59da:	b8 00 00 00 00       	mov    $0x0,%eax
    59df:	eb 05                	jmp    59e6 <seek_sync+0xce>
	else
		return(1);
    59e1:	b8 01 00 00 00       	mov    $0x1,%eax
}
    59e6:	c9                   	leave  
    59e7:	c3                   	ret    

000059e8 <js_bound>:

int js_bound(int lay, int m_ext)
{
    59e8:	55                   	push   %ebp
    59e9:	89 e5                	mov    %esp,%ebp
    59eb:	83 ec 18             	sub    $0x18,%esp
		{ 4, 8, 12, 16 },
		{ 4, 8, 12, 16},
		{ 0, 4, 8, 16}
	};  /* lay+m_e -> jsbound */

    if(lay<1 || lay >3 || m_ext<0 || m_ext>3) {
    59ee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    59f2:	7e 12                	jle    5a06 <js_bound+0x1e>
    59f4:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
    59f8:	7f 0c                	jg     5a06 <js_bound+0x1e>
    59fa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    59fe:	78 06                	js     5a06 <js_bound+0x1e>
    5a00:	83 7d 0c 03          	cmpl   $0x3,0xc(%ebp)
    5a04:	7e 27                	jle    5a2d <js_bound+0x45>
        printf(0, "js_bound bad layer/modext (%d/%d)\n", lay, m_ext);
    5a06:	8b 45 0c             	mov    0xc(%ebp),%eax
    5a09:	89 44 24 0c          	mov    %eax,0xc(%esp)
    5a0d:	8b 45 08             	mov    0x8(%ebp),%eax
    5a10:	89 44 24 08          	mov    %eax,0x8(%esp)
    5a14:	c7 44 24 04 d0 b7 00 	movl   $0xb7d0,0x4(%esp)
    5a1b:	00 
    5a1c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5a23:	e8 22 ef ff ff       	call   494a <printf>
        exit();
    5a28:	e8 2d ed ff ff       	call   475a <exit>
    }
	return(jsb_table[lay-1][m_ext]);
    5a2d:	8b 45 08             	mov    0x8(%ebp),%eax
    5a30:	83 e8 01             	sub    $0x1,%eax
    5a33:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    5a3a:	8b 45 0c             	mov    0xc(%ebp),%eax
    5a3d:	01 d0                	add    %edx,%eax
    5a3f:	8b 04 85 80 f0 00 00 	mov    0xf080(,%eax,4),%eax
}
    5a46:	c9                   	leave  
    5a47:	c3                   	ret    

00005a48 <hdr_to_frps>:

void hdr_to_frps(struct frame_params *fr_ps)
{
    5a48:	55                   	push   %ebp
    5a49:	89 e5                	mov    %esp,%ebp
    5a4b:	83 ec 28             	sub    $0x28,%esp
	layer *hdr = fr_ps->header;     /* (or pass in as arg?) */
    5a4e:	8b 45 08             	mov    0x8(%ebp),%eax
    5a51:	8b 00                	mov    (%eax),%eax
    5a53:	89 45 f4             	mov    %eax,-0xc(%ebp)

	fr_ps->actual_mode = hdr->mode;
    5a56:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a59:	8b 50 1c             	mov    0x1c(%eax),%edx
    5a5c:	8b 45 08             	mov    0x8(%ebp),%eax
    5a5f:	89 50 04             	mov    %edx,0x4(%eax)
	fr_ps->stereo = (hdr->mode == MPG_MD_MONO) ? 1 : 2;
    5a62:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a65:	8b 40 1c             	mov    0x1c(%eax),%eax
    5a68:	83 f8 03             	cmp    $0x3,%eax
    5a6b:	75 07                	jne    5a74 <hdr_to_frps+0x2c>
    5a6d:	b8 01 00 00 00       	mov    $0x1,%eax
    5a72:	eb 05                	jmp    5a79 <hdr_to_frps+0x31>
    5a74:	b8 02 00 00 00       	mov    $0x2,%eax
    5a79:	8b 55 08             	mov    0x8(%ebp),%edx
    5a7c:	89 42 08             	mov    %eax,0x8(%edx)
	fr_ps->sblimit = SBLIMIT;
    5a7f:	8b 45 08             	mov    0x8(%ebp),%eax
    5a82:	c7 40 10 20 00 00 00 	movl   $0x20,0x10(%eax)
	if(hdr->mode == MPG_MD_JOINT_STEREO)
    5a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a8c:	8b 40 1c             	mov    0x1c(%eax),%eax
    5a8f:	83 f8 01             	cmp    $0x1,%eax
    5a92:	75 20                	jne    5ab4 <hdr_to_frps+0x6c>
		fr_ps->jsbound = js_bound(hdr->lay, hdr->mode_ext);
    5a94:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a97:	8b 50 20             	mov    0x20(%eax),%edx
    5a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a9d:	8b 40 04             	mov    0x4(%eax),%eax
    5aa0:	89 54 24 04          	mov    %edx,0x4(%esp)
    5aa4:	89 04 24             	mov    %eax,(%esp)
    5aa7:	e8 3c ff ff ff       	call   59e8 <js_bound>
    5aac:	8b 55 08             	mov    0x8(%ebp),%edx
    5aaf:	89 42 0c             	mov    %eax,0xc(%edx)
    5ab2:	eb 0c                	jmp    5ac0 <hdr_to_frps+0x78>
	else
		fr_ps->jsbound = fr_ps->sblimit;
    5ab4:	8b 45 08             	mov    0x8(%ebp),%eax
    5ab7:	8b 50 10             	mov    0x10(%eax),%edx
    5aba:	8b 45 08             	mov    0x8(%ebp),%eax
    5abd:	89 50 0c             	mov    %edx,0xc(%eax)
}
    5ac0:	c9                   	leave  
    5ac1:	c3                   	ret    

00005ac2 <hputbuf>:

void hputbuf(unsigned int val, int N)
{
    5ac2:	55                   	push   %ebp
    5ac3:	89 e5                	mov    %esp,%ebp
    5ac5:	83 ec 18             	sub    $0x18,%esp
	if (N != 8) {
    5ac8:	83 7d 0c 08          	cmpl   $0x8,0xc(%ebp)
    5acc:	74 19                	je     5ae7 <hputbuf+0x25>
		printf(0,"Not Supported yet!!\n");
    5ace:	c7 44 24 04 f3 b7 00 	movl   $0xb7f3,0x4(%esp)
    5ad5:	00 
    5ad6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    5add:	e8 68 ee ff ff       	call   494a <printf>
		exit();
    5ae2:	e8 73 ec ff ff       	call   475a <exit>
	}
	getCoreBuf(1, val);
    5ae7:	8b 45 08             	mov    0x8(%ebp),%eax
    5aea:	89 44 24 04          	mov    %eax,0x4(%esp)
    5aee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    5af5:	e8 60 ed ff ff       	call   485a <getCoreBuf>
//	buf[offset % BUFSIZE] = val;
//	offset++;
}
    5afa:	c9                   	leave  
    5afb:	c3                   	ret    

00005afc <hsstell>:

unsigned long hsstell()
{
    5afc:	55                   	push   %ebp
    5afd:	89 e5                	mov    %esp,%ebp
    5aff:	83 ec 18             	sub    $0x18,%esp
	return getCoreBuf(2, 0);
    5b02:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    5b09:	00 
    5b0a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    5b11:	e8 44 ed ff ff       	call   485a <getCoreBuf>
//	return(totbit);
}
    5b16:	c9                   	leave  
    5b17:	c3                   	ret    

00005b18 <hgetbits>:

unsigned long hgetbits(int N)
{
    5b18:	55                   	push   %ebp
    5b19:	89 e5                	mov    %esp,%ebp
    5b1b:	83 ec 18             	sub    $0x18,%esp

	return getCoreBuf(3, N);
    5b1e:	8b 45 08             	mov    0x8(%ebp),%eax
    5b21:	89 44 24 04          	mov    %eax,0x4(%esp)
    5b25:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
    5b2c:	e8 29 ed ff ff       	call   485a <getCoreBuf>
}
    5b31:	c9                   	leave  
    5b32:	c3                   	ret    

00005b33 <hget1bit>:


unsigned int hget1bit()
{
    5b33:	55                   	push   %ebp
    5b34:	89 e5                	mov    %esp,%ebp
    5b36:	83 ec 18             	sub    $0x18,%esp
	return(hgetbits(1));
    5b39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    5b40:	e8 d3 ff ff ff       	call   5b18 <hgetbits>
}
    5b45:	c9                   	leave  
    5b46:	c3                   	ret    

00005b47 <rewindNbits>:


void rewindNbits(int N)
{
    5b47:	55                   	push   %ebp
    5b48:	89 e5                	mov    %esp,%ebp
    5b4a:	83 ec 18             	sub    $0x18,%esp
	getCoreBuf(4, N);
    5b4d:	8b 45 08             	mov    0x8(%ebp),%eax
    5b50:	89 44 24 04          	mov    %eax,0x4(%esp)
    5b54:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
    5b5b:	e8 fa ec ff ff       	call   485a <getCoreBuf>
}
    5b60:	c9                   	leave  
    5b61:	c3                   	ret    

00005b62 <rewindNbytes>:


void rewindNbytes(int N)
{
    5b62:	55                   	push   %ebp
    5b63:	89 e5                	mov    %esp,%ebp
    5b65:	83 ec 18             	sub    $0x18,%esp
	getCoreBuf(5, N);
    5b68:	8b 45 08             	mov    0x8(%ebp),%eax
    5b6b:	89 44 24 04          	mov    %eax,0x4(%esp)
    5b6f:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
    5b76:	e8 df ec ff ff       	call   485a <getCoreBuf>
}
    5b7b:	c9                   	leave  
    5b7c:	c3                   	ret    

00005b7d <read_decoder_table>:
				/* 0..31 Huffman code table 0..31	*/
				/* 32,33 count1-tables			*/

/* ��ȡ huffman ����� */
void read_decoder_table() 
{
    5b7d:	55                   	push   %ebp
    5b7e:	89 e5                	mov    %esp,%ebp
    5b80:	57                   	push   %edi
    5b81:	56                   	push   %esi
    5b82:	53                   	push   %ebx
    5b83:	81 ec 40 1b 00 00    	sub    $0x1b40,%esp
	unsigned char h1[7][2] = {{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11}};
    5b89:	c6 45 e6 02          	movb   $0x2,-0x1a(%ebp)
    5b8d:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
    5b91:	c6 45 e8 00          	movb   $0x0,-0x18(%ebp)
    5b95:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    5b99:	c6 45 ea 02          	movb   $0x2,-0x16(%ebp)
    5b9d:	c6 45 eb 01          	movb   $0x1,-0x15(%ebp)
    5ba1:	c6 45 ec 00          	movb   $0x0,-0x14(%ebp)
    5ba5:	c6 45 ed 10          	movb   $0x10,-0x13(%ebp)
    5ba9:	c6 45 ee 02          	movb   $0x2,-0x12(%ebp)
    5bad:	c6 45 ef 01          	movb   $0x1,-0x11(%ebp)
    5bb1:	c6 45 f0 00          	movb   $0x0,-0x10(%ebp)
    5bb5:	c6 45 f1 01          	movb   $0x1,-0xf(%ebp)
    5bb9:	c6 45 f2 00          	movb   $0x0,-0xe(%ebp)
    5bbd:	c6 45 f3 11          	movb   $0x11,-0xd(%ebp)

	unsigned char h2[17][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22}};
    5bc1:	c6 45 c4 02          	movb   $0x2,-0x3c(%ebp)
    5bc5:	c6 45 c5 01          	movb   $0x1,-0x3b(%ebp)
    5bc9:	c6 45 c6 00          	movb   $0x0,-0x3a(%ebp)
    5bcd:	c6 45 c7 00          	movb   $0x0,-0x39(%ebp)
    5bd1:	c6 45 c8 04          	movb   $0x4,-0x38(%ebp)
    5bd5:	c6 45 c9 01          	movb   $0x1,-0x37(%ebp)
    5bd9:	c6 45 ca 02          	movb   $0x2,-0x36(%ebp)
    5bdd:	c6 45 cb 01          	movb   $0x1,-0x35(%ebp)
    5be1:	c6 45 cc 00          	movb   $0x0,-0x34(%ebp)
    5be5:	c6 45 cd 10          	movb   $0x10,-0x33(%ebp)
    5be9:	c6 45 ce 00          	movb   $0x0,-0x32(%ebp)
    5bed:	c6 45 cf 01          	movb   $0x1,-0x31(%ebp)
    5bf1:	c6 45 d0 02          	movb   $0x2,-0x30(%ebp)
    5bf5:	c6 45 d1 01          	movb   $0x1,-0x2f(%ebp)
    5bf9:	c6 45 d2 00          	movb   $0x0,-0x2e(%ebp)
    5bfd:	c6 45 d3 11          	movb   $0x11,-0x2d(%ebp)
    5c01:	c6 45 d4 04          	movb   $0x4,-0x2c(%ebp)
    5c05:	c6 45 d5 01          	movb   $0x1,-0x2b(%ebp)
    5c09:	c6 45 d6 02          	movb   $0x2,-0x2a(%ebp)
    5c0d:	c6 45 d7 01          	movb   $0x1,-0x29(%ebp)
    5c11:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
    5c15:	c6 45 d9 20          	movb   $0x20,-0x27(%ebp)
    5c19:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
    5c1d:	c6 45 db 21          	movb   $0x21,-0x25(%ebp)
    5c21:	c6 45 dc 02          	movb   $0x2,-0x24(%ebp)
    5c25:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
    5c29:	c6 45 de 00          	movb   $0x0,-0x22(%ebp)
    5c2d:	c6 45 df 12          	movb   $0x12,-0x21(%ebp)
    5c31:	c6 45 e0 02          	movb   $0x2,-0x20(%ebp)
    5c35:	c6 45 e1 01          	movb   $0x1,-0x1f(%ebp)
    5c39:	c6 45 e2 00          	movb   $0x0,-0x1e(%ebp)
    5c3d:	c6 45 e3 02          	movb   $0x2,-0x1d(%ebp)
    5c41:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
    5c45:	c6 45 e5 22          	movb   $0x22,-0x1b(%ebp)

	unsigned char h3[17][2] = {{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x2,0x1},{0x0,0x10},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22}};
    5c49:	c6 45 a2 04          	movb   $0x4,-0x5e(%ebp)
    5c4d:	c6 45 a3 01          	movb   $0x1,-0x5d(%ebp)
    5c51:	c6 45 a4 02          	movb   $0x2,-0x5c(%ebp)
    5c55:	c6 45 a5 01          	movb   $0x1,-0x5b(%ebp)
    5c59:	c6 45 a6 00          	movb   $0x0,-0x5a(%ebp)
    5c5d:	c6 45 a7 00          	movb   $0x0,-0x59(%ebp)
    5c61:	c6 45 a8 00          	movb   $0x0,-0x58(%ebp)
    5c65:	c6 45 a9 01          	movb   $0x1,-0x57(%ebp)
    5c69:	c6 45 aa 02          	movb   $0x2,-0x56(%ebp)
    5c6d:	c6 45 ab 01          	movb   $0x1,-0x55(%ebp)
    5c71:	c6 45 ac 00          	movb   $0x0,-0x54(%ebp)
    5c75:	c6 45 ad 11          	movb   $0x11,-0x53(%ebp)
    5c79:	c6 45 ae 02          	movb   $0x2,-0x52(%ebp)
    5c7d:	c6 45 af 01          	movb   $0x1,-0x51(%ebp)
    5c81:	c6 45 b0 00          	movb   $0x0,-0x50(%ebp)
    5c85:	c6 45 b1 10          	movb   $0x10,-0x4f(%ebp)
    5c89:	c6 45 b2 04          	movb   $0x4,-0x4e(%ebp)
    5c8d:	c6 45 b3 01          	movb   $0x1,-0x4d(%ebp)
    5c91:	c6 45 b4 02          	movb   $0x2,-0x4c(%ebp)
    5c95:	c6 45 b5 01          	movb   $0x1,-0x4b(%ebp)
    5c99:	c6 45 b6 00          	movb   $0x0,-0x4a(%ebp)
    5c9d:	c6 45 b7 20          	movb   $0x20,-0x49(%ebp)
    5ca1:	c6 45 b8 00          	movb   $0x0,-0x48(%ebp)
    5ca5:	c6 45 b9 21          	movb   $0x21,-0x47(%ebp)
    5ca9:	c6 45 ba 02          	movb   $0x2,-0x46(%ebp)
    5cad:	c6 45 bb 01          	movb   $0x1,-0x45(%ebp)
    5cb1:	c6 45 bc 00          	movb   $0x0,-0x44(%ebp)
    5cb5:	c6 45 bd 12          	movb   $0x12,-0x43(%ebp)
    5cb9:	c6 45 be 02          	movb   $0x2,-0x42(%ebp)
    5cbd:	c6 45 bf 01          	movb   $0x1,-0x41(%ebp)
    5cc1:	c6 45 c0 00          	movb   $0x0,-0x40(%ebp)
    5cc5:	c6 45 c1 02          	movb   $0x2,-0x3f(%ebp)
    5cc9:	c6 45 c2 00          	movb   $0x0,-0x3e(%ebp)
    5ccd:	c6 45 c3 22          	movb   $0x22,-0x3d(%ebp)

	unsigned char h5[31][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x13},{0x2,0x1},{0x0,0x31},{0x2,0x1},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x33}};
    5cd1:	c6 85 64 ff ff ff 02 	movb   $0x2,-0x9c(%ebp)
    5cd8:	c6 85 65 ff ff ff 01 	movb   $0x1,-0x9b(%ebp)
    5cdf:	c6 85 66 ff ff ff 00 	movb   $0x0,-0x9a(%ebp)
    5ce6:	c6 85 67 ff ff ff 00 	movb   $0x0,-0x99(%ebp)
    5ced:	c6 85 68 ff ff ff 04 	movb   $0x4,-0x98(%ebp)
    5cf4:	c6 85 69 ff ff ff 01 	movb   $0x1,-0x97(%ebp)
    5cfb:	c6 85 6a ff ff ff 02 	movb   $0x2,-0x96(%ebp)
    5d02:	c6 85 6b ff ff ff 01 	movb   $0x1,-0x95(%ebp)
    5d09:	c6 85 6c ff ff ff 00 	movb   $0x0,-0x94(%ebp)
    5d10:	c6 85 6d ff ff ff 10 	movb   $0x10,-0x93(%ebp)
    5d17:	c6 85 6e ff ff ff 00 	movb   $0x0,-0x92(%ebp)
    5d1e:	c6 85 6f ff ff ff 01 	movb   $0x1,-0x91(%ebp)
    5d25:	c6 85 70 ff ff ff 02 	movb   $0x2,-0x90(%ebp)
    5d2c:	c6 85 71 ff ff ff 01 	movb   $0x1,-0x8f(%ebp)
    5d33:	c6 85 72 ff ff ff 00 	movb   $0x0,-0x8e(%ebp)
    5d3a:	c6 85 73 ff ff ff 11 	movb   $0x11,-0x8d(%ebp)
    5d41:	c6 85 74 ff ff ff 08 	movb   $0x8,-0x8c(%ebp)
    5d48:	c6 85 75 ff ff ff 01 	movb   $0x1,-0x8b(%ebp)
    5d4f:	c6 85 76 ff ff ff 04 	movb   $0x4,-0x8a(%ebp)
    5d56:	c6 85 77 ff ff ff 01 	movb   $0x1,-0x89(%ebp)
    5d5d:	c6 85 78 ff ff ff 02 	movb   $0x2,-0x88(%ebp)
    5d64:	c6 85 79 ff ff ff 01 	movb   $0x1,-0x87(%ebp)
    5d6b:	c6 85 7a ff ff ff 00 	movb   $0x0,-0x86(%ebp)
    5d72:	c6 85 7b ff ff ff 20 	movb   $0x20,-0x85(%ebp)
    5d79:	c6 85 7c ff ff ff 00 	movb   $0x0,-0x84(%ebp)
    5d80:	c6 85 7d ff ff ff 02 	movb   $0x2,-0x83(%ebp)
    5d87:	c6 85 7e ff ff ff 02 	movb   $0x2,-0x82(%ebp)
    5d8e:	c6 85 7f ff ff ff 01 	movb   $0x1,-0x81(%ebp)
    5d95:	c6 45 80 00          	movb   $0x0,-0x80(%ebp)
    5d99:	c6 45 81 21          	movb   $0x21,-0x7f(%ebp)
    5d9d:	c6 45 82 00          	movb   $0x0,-0x7e(%ebp)
    5da1:	c6 45 83 12          	movb   $0x12,-0x7d(%ebp)
    5da5:	c6 45 84 08          	movb   $0x8,-0x7c(%ebp)
    5da9:	c6 45 85 01          	movb   $0x1,-0x7b(%ebp)
    5dad:	c6 45 86 04          	movb   $0x4,-0x7a(%ebp)
    5db1:	c6 45 87 01          	movb   $0x1,-0x79(%ebp)
    5db5:	c6 45 88 02          	movb   $0x2,-0x78(%ebp)
    5db9:	c6 45 89 01          	movb   $0x1,-0x77(%ebp)
    5dbd:	c6 45 8a 00          	movb   $0x0,-0x76(%ebp)
    5dc1:	c6 45 8b 22          	movb   $0x22,-0x75(%ebp)
    5dc5:	c6 45 8c 00          	movb   $0x0,-0x74(%ebp)
    5dc9:	c6 45 8d 30          	movb   $0x30,-0x73(%ebp)
    5dcd:	c6 45 8e 02          	movb   $0x2,-0x72(%ebp)
    5dd1:	c6 45 8f 01          	movb   $0x1,-0x71(%ebp)
    5dd5:	c6 45 90 00          	movb   $0x0,-0x70(%ebp)
    5dd9:	c6 45 91 03          	movb   $0x3,-0x6f(%ebp)
    5ddd:	c6 45 92 00          	movb   $0x0,-0x6e(%ebp)
    5de1:	c6 45 93 13          	movb   $0x13,-0x6d(%ebp)
    5de5:	c6 45 94 02          	movb   $0x2,-0x6c(%ebp)
    5de9:	c6 45 95 01          	movb   $0x1,-0x6b(%ebp)
    5ded:	c6 45 96 00          	movb   $0x0,-0x6a(%ebp)
    5df1:	c6 45 97 31          	movb   $0x31,-0x69(%ebp)
    5df5:	c6 45 98 02          	movb   $0x2,-0x68(%ebp)
    5df9:	c6 45 99 01          	movb   $0x1,-0x67(%ebp)
    5dfd:	c6 45 9a 00          	movb   $0x0,-0x66(%ebp)
    5e01:	c6 45 9b 32          	movb   $0x32,-0x65(%ebp)
    5e05:	c6 45 9c 02          	movb   $0x2,-0x64(%ebp)
    5e09:	c6 45 9d 01          	movb   $0x1,-0x63(%ebp)
    5e0d:	c6 45 9e 00          	movb   $0x0,-0x62(%ebp)
    5e11:	c6 45 9f 23          	movb   $0x23,-0x61(%ebp)
    5e15:	c6 45 a0 00          	movb   $0x0,-0x60(%ebp)
    5e19:	c6 45 a1 33          	movb   $0x33,-0x5f(%ebp)

	unsigned char h6[31][2] = {{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x0,0x11},{0x6,0x1},{0x2,0x1},{0x0,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x6,0x1},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x2,0x1},{0x0,0x3},{0x0,0x33}};
    5e1d:	c6 85 26 ff ff ff 06 	movb   $0x6,-0xda(%ebp)
    5e24:	c6 85 27 ff ff ff 01 	movb   $0x1,-0xd9(%ebp)
    5e2b:	c6 85 28 ff ff ff 04 	movb   $0x4,-0xd8(%ebp)
    5e32:	c6 85 29 ff ff ff 01 	movb   $0x1,-0xd7(%ebp)
    5e39:	c6 85 2a ff ff ff 02 	movb   $0x2,-0xd6(%ebp)
    5e40:	c6 85 2b ff ff ff 01 	movb   $0x1,-0xd5(%ebp)
    5e47:	c6 85 2c ff ff ff 00 	movb   $0x0,-0xd4(%ebp)
    5e4e:	c6 85 2d ff ff ff 00 	movb   $0x0,-0xd3(%ebp)
    5e55:	c6 85 2e ff ff ff 00 	movb   $0x0,-0xd2(%ebp)
    5e5c:	c6 85 2f ff ff ff 10 	movb   $0x10,-0xd1(%ebp)
    5e63:	c6 85 30 ff ff ff 00 	movb   $0x0,-0xd0(%ebp)
    5e6a:	c6 85 31 ff ff ff 11 	movb   $0x11,-0xcf(%ebp)
    5e71:	c6 85 32 ff ff ff 06 	movb   $0x6,-0xce(%ebp)
    5e78:	c6 85 33 ff ff ff 01 	movb   $0x1,-0xcd(%ebp)
    5e7f:	c6 85 34 ff ff ff 02 	movb   $0x2,-0xcc(%ebp)
    5e86:	c6 85 35 ff ff ff 01 	movb   $0x1,-0xcb(%ebp)
    5e8d:	c6 85 36 ff ff ff 00 	movb   $0x0,-0xca(%ebp)
    5e94:	c6 85 37 ff ff ff 01 	movb   $0x1,-0xc9(%ebp)
    5e9b:	c6 85 38 ff ff ff 02 	movb   $0x2,-0xc8(%ebp)
    5ea2:	c6 85 39 ff ff ff 01 	movb   $0x1,-0xc7(%ebp)
    5ea9:	c6 85 3a ff ff ff 00 	movb   $0x0,-0xc6(%ebp)
    5eb0:	c6 85 3b ff ff ff 20 	movb   $0x20,-0xc5(%ebp)
    5eb7:	c6 85 3c ff ff ff 00 	movb   $0x0,-0xc4(%ebp)
    5ebe:	c6 85 3d ff ff ff 21 	movb   $0x21,-0xc3(%ebp)
    5ec5:	c6 85 3e ff ff ff 06 	movb   $0x6,-0xc2(%ebp)
    5ecc:	c6 85 3f ff ff ff 01 	movb   $0x1,-0xc1(%ebp)
    5ed3:	c6 85 40 ff ff ff 02 	movb   $0x2,-0xc0(%ebp)
    5eda:	c6 85 41 ff ff ff 01 	movb   $0x1,-0xbf(%ebp)
    5ee1:	c6 85 42 ff ff ff 00 	movb   $0x0,-0xbe(%ebp)
    5ee8:	c6 85 43 ff ff ff 12 	movb   $0x12,-0xbd(%ebp)
    5eef:	c6 85 44 ff ff ff 02 	movb   $0x2,-0xbc(%ebp)
    5ef6:	c6 85 45 ff ff ff 01 	movb   $0x1,-0xbb(%ebp)
    5efd:	c6 85 46 ff ff ff 00 	movb   $0x0,-0xba(%ebp)
    5f04:	c6 85 47 ff ff ff 02 	movb   $0x2,-0xb9(%ebp)
    5f0b:	c6 85 48 ff ff ff 00 	movb   $0x0,-0xb8(%ebp)
    5f12:	c6 85 49 ff ff ff 22 	movb   $0x22,-0xb7(%ebp)
    5f19:	c6 85 4a ff ff ff 04 	movb   $0x4,-0xb6(%ebp)
    5f20:	c6 85 4b ff ff ff 01 	movb   $0x1,-0xb5(%ebp)
    5f27:	c6 85 4c ff ff ff 02 	movb   $0x2,-0xb4(%ebp)
    5f2e:	c6 85 4d ff ff ff 01 	movb   $0x1,-0xb3(%ebp)
    5f35:	c6 85 4e ff ff ff 00 	movb   $0x0,-0xb2(%ebp)
    5f3c:	c6 85 4f ff ff ff 31 	movb   $0x31,-0xb1(%ebp)
    5f43:	c6 85 50 ff ff ff 00 	movb   $0x0,-0xb0(%ebp)
    5f4a:	c6 85 51 ff ff ff 13 	movb   $0x13,-0xaf(%ebp)
    5f51:	c6 85 52 ff ff ff 04 	movb   $0x4,-0xae(%ebp)
    5f58:	c6 85 53 ff ff ff 01 	movb   $0x1,-0xad(%ebp)
    5f5f:	c6 85 54 ff ff ff 02 	movb   $0x2,-0xac(%ebp)
    5f66:	c6 85 55 ff ff ff 01 	movb   $0x1,-0xab(%ebp)
    5f6d:	c6 85 56 ff ff ff 00 	movb   $0x0,-0xaa(%ebp)
    5f74:	c6 85 57 ff ff ff 30 	movb   $0x30,-0xa9(%ebp)
    5f7b:	c6 85 58 ff ff ff 00 	movb   $0x0,-0xa8(%ebp)
    5f82:	c6 85 59 ff ff ff 32 	movb   $0x32,-0xa7(%ebp)
    5f89:	c6 85 5a ff ff ff 02 	movb   $0x2,-0xa6(%ebp)
    5f90:	c6 85 5b ff ff ff 01 	movb   $0x1,-0xa5(%ebp)
    5f97:	c6 85 5c ff ff ff 00 	movb   $0x0,-0xa4(%ebp)
    5f9e:	c6 85 5d ff ff ff 23 	movb   $0x23,-0xa3(%ebp)
    5fa5:	c6 85 5e ff ff ff 02 	movb   $0x2,-0xa2(%ebp)
    5fac:	c6 85 5f ff ff ff 01 	movb   $0x1,-0xa1(%ebp)
    5fb3:	c6 85 60 ff ff ff 00 	movb   $0x0,-0xa0(%ebp)
    5fba:	c6 85 61 ff ff ff 03 	movb   $0x3,-0x9f(%ebp)
    5fc1:	c6 85 62 ff ff ff 00 	movb   $0x0,-0x9e(%ebp)
    5fc8:	c6 85 63 ff ff ff 33 	movb   $0x33,-0x9d(%ebp)

	unsigned char h7[71][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x21},{0x12,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x3},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x4},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x41},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x43},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x34},{0x0,0x5},{0x0,0x51},{0x6,0x1},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x4,0x1},{0x2,0x1},{0x0,0x53},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x55}};
    5fcf:	8d 95 98 fe ff ff    	lea    -0x168(%ebp),%edx
    5fd5:	b8 20 b8 00 00       	mov    $0xb820,%eax
    5fda:	b9 23 00 00 00       	mov    $0x23,%ecx
    5fdf:	89 d7                	mov    %edx,%edi
    5fe1:	89 c6                	mov    %eax,%esi
    5fe3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    5fe5:	89 f0                	mov    %esi,%eax
    5fe7:	89 fa                	mov    %edi,%edx
    5fe9:	0f b7 08             	movzwl (%eax),%ecx
    5fec:	66 89 0a             	mov    %cx,(%edx)
    5fef:	83 c2 02             	add    $0x2,%edx
    5ff2:	83 c0 02             	add    $0x2,%eax

	unsigned char h8[71][2] = {{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x22},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x2,0x1},{0x0,0x41},{0x2,0x1},{0x0,0x14},{0x0,0x42},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x24},{0x2,0x1},{0x0,0x33},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x6,0x1},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x6,0x1},{0x2,0x1},{0x0,0x25},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x2,0x1},{0x0,0x53},{0x2,0x1},{0x0,0x45},{0x2,0x1},{0x0,0x54},{0x0,0x55}};
    5ff5:	8d 85 0a fe ff ff    	lea    -0x1f6(%ebp),%eax
    5ffb:	ba c0 b8 00 00       	mov    $0xb8c0,%edx
    6000:	bb 8e 00 00 00       	mov    $0x8e,%ebx
    6005:	89 c1                	mov    %eax,%ecx
    6007:	83 e1 02             	and    $0x2,%ecx
    600a:	85 c9                	test   %ecx,%ecx
    600c:	74 0f                	je     601d <read_decoder_table+0x4a0>
    600e:	0f b7 0a             	movzwl (%edx),%ecx
    6011:	66 89 08             	mov    %cx,(%eax)
    6014:	83 c0 02             	add    $0x2,%eax
    6017:	83 c2 02             	add    $0x2,%edx
    601a:	83 eb 02             	sub    $0x2,%ebx
    601d:	89 d9                	mov    %ebx,%ecx
    601f:	c1 e9 02             	shr    $0x2,%ecx
    6022:	89 c7                	mov    %eax,%edi
    6024:	89 d6                	mov    %edx,%esi
    6026:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    6028:	89 f2                	mov    %esi,%edx
    602a:	89 f8                	mov    %edi,%eax
    602c:	b9 00 00 00 00       	mov    $0x0,%ecx
    6031:	89 de                	mov    %ebx,%esi
    6033:	83 e6 02             	and    $0x2,%esi
    6036:	85 f6                	test   %esi,%esi
    6038:	74 0b                	je     6045 <read_decoder_table+0x4c8>
    603a:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    603e:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    6042:	83 c1 02             	add    $0x2,%ecx
    6045:	83 e3 01             	and    $0x1,%ebx
    6048:	85 db                	test   %ebx,%ebx
    604a:	74 07                	je     6053 <read_decoder_table+0x4d6>
    604c:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    6050:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h9[71][2] = {{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x0,0x31},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x50},{0x0,0x43},{0x2,0x1},{0x0,0x34},{0x0,0x51},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x15},{0x0,0x52},{0x2,0x1},{0x0,0x25},{0x0,0x44},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x54},{0x0,0x53},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x45},{0x0,0x55}};
    6053:	8d 95 7c fd ff ff    	lea    -0x284(%ebp),%edx
    6059:	b8 60 b9 00 00       	mov    $0xb960,%eax
    605e:	b9 23 00 00 00       	mov    $0x23,%ecx
    6063:	89 d7                	mov    %edx,%edi
    6065:	89 c6                	mov    %eax,%esi
    6067:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    6069:	89 f0                	mov    %esi,%eax
    606b:	89 fa                	mov    %edi,%edx
    606d:	0f b7 08             	movzwl (%eax),%ecx
    6070:	66 89 0a             	mov    %cx,(%edx)
    6073:	83 c2 02             	add    $0x2,%edx
    6076:	83 c0 02             	add    $0x2,%eax

	unsigned char h10[127][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0xa,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x1c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x3},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x40},{0x4,0x1},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x1c,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x0,0x60},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x36},{0x0,0x71},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x17},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x0,0x6},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x35},{0x0,0x45},{0x0,0x62},{0x2,0x1},{0x0,0x70},{0x2,0x1},{0x0,0x7},{0x0,0x64},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x6,0x1},{0x2,0x1},{0x0,0x63},{0x2,0x1},{0x0,0x54},{0x0,0x55},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x37},{0x0,0x65},{0x2,0x1},{0x0,0x56},{0x0,0x74},{0x6,0x1},{0x2,0x1},{0x0,0x47},{0x2,0x1},{0x0,0x66},{0x0,0x75},{0x4,0x1},{0x2,0x1},{0x0,0x57},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    6079:	8d 85 7e fc ff ff    	lea    -0x382(%ebp),%eax
    607f:	ba 00 ba 00 00       	mov    $0xba00,%edx
    6084:	bb fe 00 00 00       	mov    $0xfe,%ebx
    6089:	89 c1                	mov    %eax,%ecx
    608b:	83 e1 02             	and    $0x2,%ecx
    608e:	85 c9                	test   %ecx,%ecx
    6090:	74 0f                	je     60a1 <read_decoder_table+0x524>
    6092:	0f b7 0a             	movzwl (%edx),%ecx
    6095:	66 89 08             	mov    %cx,(%eax)
    6098:	83 c0 02             	add    $0x2,%eax
    609b:	83 c2 02             	add    $0x2,%edx
    609e:	83 eb 02             	sub    $0x2,%ebx
    60a1:	89 d9                	mov    %ebx,%ecx
    60a3:	c1 e9 02             	shr    $0x2,%ecx
    60a6:	89 c7                	mov    %eax,%edi
    60a8:	89 d6                	mov    %edx,%esi
    60aa:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    60ac:	89 f2                	mov    %esi,%edx
    60ae:	89 f8                	mov    %edi,%eax
    60b0:	b9 00 00 00 00       	mov    $0x0,%ecx
    60b5:	89 de                	mov    %ebx,%esi
    60b7:	83 e6 02             	and    $0x2,%esi
    60ba:	85 f6                	test   %esi,%esi
    60bc:	74 0b                	je     60c9 <read_decoder_table+0x54c>
    60be:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    60c2:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    60c6:	83 c1 02             	add    $0x2,%ecx
    60c9:	83 e3 01             	and    $0x1,%ebx
    60cc:	85 db                	test   %ebx,%ebx
    60ce:	74 07                	je     60d7 <read_decoder_table+0x55a>
    60d0:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    60d4:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h11[127][2] = {{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x12},{0x18,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x21},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x1e,0x1},{0x10,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x43},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x34},{0x0,0x51},{0x0,0x61},{0x6,0x1},{0x2,0x1},{0x0,0x16},{0x2,0x1},{0x0,0x6},{0x0,0x26},{0x2,0x1},{0x0,0x62},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x10,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x25},{0x0,0x44},{0x0,0x60},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x17},{0x0,0x71},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x7},{0x0,0x64},{0x0,0x72},{0x2,0x1},{0x0,0x27},{0x4,0x1},{0x2,0x1},{0x0,0x53},{0x0,0x35},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x2,0x1},{0x0,0x65},{0x0,0x56},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x55},{0x0,0x57},{0x0,0x74},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    60d7:	8d 95 80 fb ff ff    	lea    -0x480(%ebp),%edx
    60dd:	b8 00 bb 00 00       	mov    $0xbb00,%eax
    60e2:	b9 3f 00 00 00       	mov    $0x3f,%ecx
    60e7:	89 d7                	mov    %edx,%edi
    60e9:	89 c6                	mov    %eax,%esi
    60eb:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    60ed:	89 f0                	mov    %esi,%eax
    60ef:	89 fa                	mov    %edi,%edx
    60f1:	0f b7 08             	movzwl (%eax),%ecx
    60f4:	66 89 0a             	mov    %cx,(%edx)
    60f7:	83 c2 02             	add    $0x2,%edx
    60fa:	83 c0 02             	add    $0x2,%eax

	unsigned char h12[127][2] = {{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x10,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x31},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x40},{0x1a,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x2,0x1},{0x0,0x41},{0x0,0x33},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x14},{0x0,0x42},{0x2,0x1},{0x0,0x24},{0x2,0x1},{0x0,0x4},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x1c,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x2,0x1},{0x0,0x53},{0x0,0x35},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x16},{0x0,0x61},{0x4,0x1},{0x2,0x1},{0x0,0x62},{0x0,0x26},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x6},{0x0,0x44},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x0,0x71},{0x4,0x1},{0x2,0x1},{0x0,0x17},{0x0,0x64},{0x2,0x1},{0x0,0x46},{0x0,0x72},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x27},{0x2,0x1},{0x0,0x55},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x0,0x56},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x65},{0x0,0x74},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    60fd:	8d 85 82 fa ff ff    	lea    -0x57e(%ebp),%eax
    6103:	ba 00 bc 00 00       	mov    $0xbc00,%edx
    6108:	bb fe 00 00 00       	mov    $0xfe,%ebx
    610d:	89 c1                	mov    %eax,%ecx
    610f:	83 e1 02             	and    $0x2,%ecx
    6112:	85 c9                	test   %ecx,%ecx
    6114:	74 0f                	je     6125 <read_decoder_table+0x5a8>
    6116:	0f b7 0a             	movzwl (%edx),%ecx
    6119:	66 89 08             	mov    %cx,(%eax)
    611c:	83 c0 02             	add    $0x2,%eax
    611f:	83 c2 02             	add    $0x2,%edx
    6122:	83 eb 02             	sub    $0x2,%ebx
    6125:	89 d9                	mov    %ebx,%ecx
    6127:	c1 e9 02             	shr    $0x2,%ecx
    612a:	89 c7                	mov    %eax,%edi
    612c:	89 d6                	mov    %edx,%esi
    612e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    6130:	89 f2                	mov    %esi,%edx
    6132:	89 f8                	mov    %edi,%eax
    6134:	b9 00 00 00 00       	mov    $0x0,%ecx
    6139:	89 de                	mov    %ebx,%esi
    613b:	83 e6 02             	and    $0x2,%esi
    613e:	85 f6                	test   %esi,%esi
    6140:	74 0b                	je     614d <read_decoder_table+0x5d0>
    6142:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    6146:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    614a:	83 c1 02             	add    $0x2,%ecx
    614d:	83 e3 01             	and    $0x1,%ebx
    6150:	85 db                	test   %ebx,%ebx
    6152:	74 07                	je     615b <read_decoder_table+0x5de>
    6154:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    6158:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h13[511][2] = {{0x2,0x1},{0x0,0x0},{0x6,0x1},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0x1c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x31},{0x6,0x1},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x46,0x1},{0x1c,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x4,0x1},{0x2,0x1},{0x0,0x24},{0x0,0x50},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x4,0x1},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x2,0x1},{0x0,0x25},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0x4,0x1},{0x2,0x1},{0x0,0x80},{0x0,0x8},{0x0,0x81},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x35},{0x0,0x62},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x4,0x1},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0x2,0x1},{0x0,0x36},{0x0,0x70},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x7},{0x0,0x55},{0x0,0x71},{0x2,0x1},{0x0,0x17},{0x2,0x1},{0x0,0x27},{0x0,0x37},{0x48,0x1},{0x18,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x18},{0x0,0x82},{0x2,0x1},{0x0,0x28},{0x4,0x1},{0x2,0x1},{0x0,0x64},{0x0,0x46},{0x0,0x72},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x2,0x1},{0x0,0x90},{0x0,0x9},{0x2,0x1},{0x0,0x91},{0x0,0x19},{0x18,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x73},{0x0,0x65},{0x2,0x1},{0x0,0x56},{0x0,0x74},{0x4,0x1},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x0,0x83},{0x6,0x1},{0x2,0x1},{0x0,0x38},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x92},{0x0,0x29},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x67},{0x0,0x85},{0x2,0x1},{0x0,0x58},{0x0,0x39},{0x2,0x1},{0x0,0x93},{0x2,0x1},{0x0,0x49},{0x0,0x86},{0x6,0x1},{0x2,0x1},{0x0,0xa0},{0x2,0x1},{0x0,0x68},{0x0,0xa},{0x2,0x1},{0x0,0xa1},{0x0,0x1a},{0x44,0x1},{0x18,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x4,0x1},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x2,0x1},{0x0,0xa3},{0x0,0x3a},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4a},{0x0,0x96},{0x2,0x1},{0x0,0xb0},{0x0,0xb},{0x2,0x1},{0x0,0xb1},{0x0,0x1b},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0xb2},{0x4,0x1},{0x2,0x1},{0x0,0x76},{0x0,0x77},{0x0,0x94},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x87},{0x0,0x78},{0x0,0xa4},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xa5},{0x0,0x2b},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5a},{0x0,0x88},{0x0,0xb3},{0x2,0x1},{0x0,0x3b},{0x2,0x1},{0x0,0x79},{0x0,0xa6},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x6a},{0x0,0xb4},{0x0,0xc0},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0x98},{0x0,0xc1},{0x3c,0x1},{0x16,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x1c},{0x2,0x1},{0x0,0x89},{0x0,0xb5},{0x2,0x1},{0x0,0x5b},{0x0,0xc2},{0x4,0x1},{0x2,0x1},{0x0,0x2c},{0x0,0x3c},{0x4,0x1},{0x2,0x1},{0x0,0xb6},{0x0,0x6b},{0x2,0x1},{0x0,0xc4},{0x0,0x4c},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa8},{0x0,0x8a},{0x2,0x1},{0x0,0xd0},{0x0,0xd},{0x2,0x1},{0x0,0xd1},{0x2,0x1},{0x0,0x4b},{0x2,0x1},{0x0,0x97},{0x0,0xa7},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xc3},{0x2,0x1},{0x0,0x7a},{0x0,0x99},{0x4,0x1},{0x2,0x1},{0x0,0xc5},{0x0,0x5c},{0x0,0xb7},{0x4,0x1},{0x2,0x1},{0x0,0x1d},{0x0,0xd2},{0x2,0x1},{0x0,0x2d},{0x2,0x1},{0x0,0x7b},{0x0,0xd3},{0x34,0x1},{0x1c,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x4,0x1},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x2,0x1},{0x0,0x9a},{0x0,0xd4},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb8},{0x0,0x8b},{0x2,0x1},{0x0,0x4d},{0x0,0xc7},{0x4,0x1},{0x2,0x1},{0x0,0x7c},{0x0,0xd5},{0x2,0x1},{0x0,0x5d},{0x0,0xe0},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe1},{0x0,0x1e},{0x4,0x1},{0x2,0x1},{0x0,0xe},{0x0,0x2e},{0x0,0xe2},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe3},{0x0,0x6d},{0x2,0x1},{0x0,0x8c},{0x0,0xe4},{0x4,0x1},{0x2,0x1},{0x0,0xe5},{0x0,0xba},{0x0,0xf0},{0x26,0x1},{0x10,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf1},{0x0,0x1f},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xaa},{0x0,0x9b},{0x0,0xb9},{0x2,0x1},{0x0,0x3e},{0x2,0x1},{0x0,0xd6},{0x0,0xc8},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x4e},{0x2,0x1},{0x0,0xd7},{0x0,0x7d},{0x2,0x1},{0x0,0xab},{0x2,0x1},{0x0,0x5e},{0x0,0xc9},{0x6,0x1},{0x2,0x1},{0x0,0xf},{0x2,0x1},{0x0,0x9c},{0x0,0x6e},{0x2,0x1},{0x0,0xf2},{0x0,0x2f},{0x20,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0x8d},{0x0,0x3f},{0x6,0x1},{0x2,0x1},{0x0,0xf3},{0x2,0x1},{0x0,0xe6},{0x0,0xca},{0x2,0x1},{0x0,0xf4},{0x0,0x4f},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbb},{0x0,0xac},{0x2,0x1},{0x0,0xe7},{0x0,0xf5},{0x4,0x1},{0x2,0x1},{0x0,0xd9},{0x0,0x9d},{0x2,0x1},{0x0,0x5f},{0x0,0xe8},{0x1e,0x1},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x6f},{0x2,0x1},{0x0,0xf6},{0x0,0xcb},{0x4,0x1},{0x2,0x1},{0x0,0xbc},{0x0,0xad},{0x0,0xda},{0x8,0x1},{0x2,0x1},{0x0,0xf7},{0x4,0x1},{0x2,0x1},{0x0,0x7e},{0x0,0x7f},{0x0,0x8e},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xae},{0x0,0xcc},{0x2,0x1},{0x0,0xf8},{0x0,0x8f},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x2,0x1},{0x0,0xea},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xeb},{0x2,0x1},{0x0,0xbe},{0x2,0x1},{0x0,0xcd},{0x0,0xfa},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe9},{0x0,0xaf},{0x0,0xdc},{0x2,0x1},{0x0,0xce},{0x0,0xfb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbf},{0x0,0xde},{0x2,0x1},{0x0,0xcf},{0x0,0xee},{0x4,0x1},{0x2,0x1},{0x0,0xdf},{0x0,0xef},{0x2,0x1},{0x0,0xff},{0x2,0x1},{0x0,0xed},{0x2,0x1},{0x0,0xfd},{0x2,0x1},{0x0,0xfc},{0x0,0xfe}};
    615b:	8d 95 84 f6 ff ff    	lea    -0x97c(%ebp),%edx
    6161:	b8 00 bd 00 00       	mov    $0xbd00,%eax
    6166:	b9 ff 00 00 00       	mov    $0xff,%ecx
    616b:	89 d7                	mov    %edx,%edi
    616d:	89 c6                	mov    %eax,%esi
    616f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    6171:	89 f0                	mov    %esi,%eax
    6173:	89 fa                	mov    %edi,%edx
    6175:	0f b7 08             	movzwl (%eax),%ecx
    6178:	66 89 0a             	mov    %cx,(%edx)
    617b:	83 c2 02             	add    $0x2,%edx
    617e:	83 c0 02             	add    $0x2,%eax

	unsigned char h15[511][2] = {{0x10,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x32,0x1},{0x10,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x31},{0x6,0x1},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x3},{0x0,0x40},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x14},{0x0,0x41},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x2,0x1},{0x0,0x24},{0x0,0x43},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x34},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x0,0x61},{0x5a,0x1},{0x24,0x1},{0x12,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x2,0x1},{0x0,0x16},{0x0,0x62},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x36},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x2,0x1},{0x0,0x71},{0x0,0x55},{0x4,0x1},{0x2,0x1},{0x0,0x17},{0x0,0x64},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x18,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x0,0x65},{0x4,0x1},{0x2,0x1},{0x0,0x56},{0x0,0x80},{0x2,0x1},{0x0,0x8},{0x0,0x74},{0x4,0x1},{0x2,0x1},{0x0,0x81},{0x0,0x18},{0x2,0x1},{0x0,0x82},{0x0,0x28},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x90},{0x0,0x19},{0x0,0x91},{0x4,0x1},{0x2,0x1},{0x0,0x92},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x29},{0x5c,0x1},{0x24,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x4,0x1},{0x2,0x1},{0x0,0x9},{0x0,0x77},{0x0,0x93},{0x4,0x1},{0x2,0x1},{0x0,0x39},{0x0,0x94},{0x2,0x1},{0x0,0x49},{0x0,0x86},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x68},{0x2,0x1},{0x0,0xa0},{0x0,0xa},{0x2,0x1},{0x0,0xa1},{0x0,0x1a},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x1a,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xa3},{0x2,0x1},{0x0,0x3a},{0x0,0x87},{0x4,0x1},{0x2,0x1},{0x0,0x78},{0x0,0xa4},{0x2,0x1},{0x0,0x4a},{0x0,0x96},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xb0},{0x0,0xb1},{0x4,0x1},{0x2,0x1},{0x0,0x1b},{0x0,0xa5},{0x0,0xb2},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5a},{0x0,0x2b},{0x2,0x1},{0x0,0x88},{0x0,0x97},{0x2,0x1},{0x0,0xb3},{0x2,0x1},{0x0,0x79},{0x0,0x3b},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x6a},{0x0,0xb4},{0x2,0x1},{0x0,0x4b},{0x0,0xc1},{0x4,0x1},{0x2,0x1},{0x0,0x98},{0x0,0x89},{0x2,0x1},{0x0,0x1c},{0x0,0xb5},{0x50,0x1},{0x22,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5b},{0x0,0x2c},{0x0,0xc2},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb},{0x0,0xc0},{0x0,0xa6},{0x2,0x1},{0x0,0xa7},{0x0,0x7a},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc3},{0x0,0x3c},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0x99},{0x0,0xb6},{0x4,0x1},{0x2,0x1},{0x0,0x6b},{0x0,0xc4},{0x2,0x1},{0x0,0x4c},{0x0,0xa8},{0x14,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8a},{0x0,0xc5},{0x4,0x1},{0x2,0x1},{0x0,0xd0},{0x0,0x5c},{0x0,0xd1},{0x4,0x1},{0x2,0x1},{0x0,0xb7},{0x0,0x7b},{0x2,0x1},{0x0,0x1d},{0x2,0x1},{0x0,0xd},{0x0,0x2d},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd2},{0x0,0xd3},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9a},{0x0,0xb8},{0x0,0xd4},{0x4,0x1},{0x2,0x1},{0x0,0x8b},{0x0,0x4d},{0x2,0x1},{0x0,0xc7},{0x0,0x7c},{0x44,0x1},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd5},{0x0,0x5d},{0x4,0x1},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x0,0xe1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0xe2},{0x2,0x1},{0x0,0xaa},{0x0,0x2e},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb9},{0x0,0x9b},{0x2,0x1},{0x0,0xe3},{0x0,0xd6},{0x4,0x1},{0x2,0x1},{0x0,0x6d},{0x0,0x3e},{0x2,0x1},{0x0,0xc8},{0x0,0x8c},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe4},{0x0,0x4e},{0x2,0x1},{0x0,0xd7},{0x0,0x7d},{0x4,0x1},{0x2,0x1},{0x0,0xe5},{0x0,0xba},{0x2,0x1},{0x0,0xab},{0x0,0x5e},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc9},{0x0,0x9c},{0x2,0x1},{0x0,0xf1},{0x0,0x1f},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf0},{0x0,0x6e},{0x0,0xf2},{0x2,0x1},{0x0,0x2f},{0x0,0xe6},{0x26,0x1},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0xf3},{0x2,0x1},{0x0,0x3f},{0x0,0xf4},{0x6,0x1},{0x2,0x1},{0x0,0x4f},{0x2,0x1},{0x0,0x8d},{0x0,0xd9},{0x2,0x1},{0x0,0xbb},{0x0,0xca},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xac},{0x0,0xe7},{0x2,0x1},{0x0,0x7e},{0x0,0xf5},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9d},{0x0,0x5f},{0x2,0x1},{0x0,0xe8},{0x0,0x8e},{0x2,0x1},{0x0,0xf6},{0x0,0xcb},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf},{0x0,0xae},{0x0,0x6f},{0x2,0x1},{0x0,0xbc},{0x0,0xda},{0x4,0x1},{0x2,0x1},{0x0,0xad},{0x0,0xf7},{0x2,0x1},{0x0,0x7f},{0x0,0xe9},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xcc},{0x2,0x1},{0x0,0xf8},{0x0,0x8f},{0x4,0x1},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x2,0x1},{0x0,0xea},{0x0,0xf9},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xdc},{0x2,0x1},{0x0,0xcd},{0x0,0xeb},{0x4,0x1},{0x2,0x1},{0x0,0xbe},{0x0,0xfa},{0x2,0x1},{0x0,0xaf},{0x0,0xdd},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xec},{0x0,0xce},{0x0,0xfb},{0x4,0x1},{0x2,0x1},{0x0,0xbf},{0x0,0xed},{0x2,0x1},{0x0,0xde},{0x0,0xfc},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xcf},{0x0,0xfd},{0x0,0xee},{0x4,0x1},{0x2,0x1},{0x0,0xdf},{0x0,0xfe},{0x2,0x1},{0x0,0xef},{0x0,0xff}};
    6181:	8d 85 86 f2 ff ff    	lea    -0xd7a(%ebp),%eax
    6187:	ba 00 c1 00 00       	mov    $0xc100,%edx
    618c:	bb fe 03 00 00       	mov    $0x3fe,%ebx
    6191:	89 c1                	mov    %eax,%ecx
    6193:	83 e1 02             	and    $0x2,%ecx
    6196:	85 c9                	test   %ecx,%ecx
    6198:	74 0f                	je     61a9 <read_decoder_table+0x62c>
    619a:	0f b7 0a             	movzwl (%edx),%ecx
    619d:	66 89 08             	mov    %cx,(%eax)
    61a0:	83 c0 02             	add    $0x2,%eax
    61a3:	83 c2 02             	add    $0x2,%edx
    61a6:	83 eb 02             	sub    $0x2,%ebx
    61a9:	89 d9                	mov    %ebx,%ecx
    61ab:	c1 e9 02             	shr    $0x2,%ecx
    61ae:	89 c7                	mov    %eax,%edi
    61b0:	89 d6                	mov    %edx,%esi
    61b2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    61b4:	89 f2                	mov    %esi,%edx
    61b6:	89 f8                	mov    %edi,%eax
    61b8:	b9 00 00 00 00       	mov    $0x0,%ecx
    61bd:	89 de                	mov    %ebx,%esi
    61bf:	83 e6 02             	and    $0x2,%esi
    61c2:	85 f6                	test   %esi,%esi
    61c4:	74 0b                	je     61d1 <read_decoder_table+0x654>
    61c6:	0f b7 34 0a          	movzwl (%edx,%ecx,1),%esi
    61ca:	66 89 34 08          	mov    %si,(%eax,%ecx,1)
    61ce:	83 c1 02             	add    $0x2,%ecx
    61d1:	83 e3 01             	and    $0x1,%ebx
    61d4:	85 db                	test   %ebx,%ebx
    61d6:	74 07                	je     61df <read_decoder_table+0x662>
    61d8:	0f b6 14 0a          	movzbl (%edx,%ecx,1),%edx
    61dc:	88 14 08             	mov    %dl,(%eax,%ecx,1)

	unsigned char h16[511][2] = {{0x2,0x1},{0x0,0x0},{0x6,0x1},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0x2a,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x6,0x1},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x4,0x1},{0x2,0x1},{0x0,0x24},{0x0,0x50},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x8a,0x1},{0x28,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x15},{0x0,0x51},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x0,0x53},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x0,0x61},{0x2,0x1},{0x0,0x16},{0x0,0x62},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0x4,0x1},{0x2,0x1},{0x0,0x36},{0x0,0x70},{0x0,0x71},{0x28,0x1},{0x12,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x17},{0x2,0x1},{0x0,0x7},{0x2,0x1},{0x0,0x55},{0x0,0x64},{0x4,0x1},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x65},{0x0,0x73},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x37},{0x2,0x1},{0x0,0x56},{0x0,0x8},{0x2,0x1},{0x0,0x80},{0x0,0x81},{0x6,0x1},{0x2,0x1},{0x0,0x18},{0x2,0x1},{0x0,0x74},{0x0,0x47},{0x2,0x1},{0x0,0x82},{0x2,0x1},{0x0,0x28},{0x0,0x66},{0x18,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x2,0x1},{0x0,0x75},{0x0,0x84},{0x4,0x1},{0x2,0x1},{0x0,0x48},{0x0,0x90},{0x0,0x91},{0x6,0x1},{0x2,0x1},{0x0,0x19},{0x2,0x1},{0x0,0x9},{0x0,0x76},{0x2,0x1},{0x0,0x92},{0x0,0x29},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x2,0x1},{0x0,0x93},{0x0,0x39},{0x4,0x1},{0x2,0x1},{0x0,0xa0},{0x0,0xa},{0x0,0x1a},{0x8,0x1},{0x2,0x1},{0x0,0xa2},{0x2,0x1},{0x0,0x67},{0x2,0x1},{0x0,0x57},{0x0,0x49},{0x6,0x1},{0x2,0x1},{0x0,0x94},{0x2,0x1},{0x0,0x77},{0x0,0x86},{0x2,0x1},{0x0,0xa1},{0x2,0x1},{0x0,0x68},{0x0,0x95},{0xdc,0x1},{0x7e,0x1},{0x32,0x1},{0x1a,0x1},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x2a},{0x2,0x1},{0x0,0x59},{0x0,0x3a},{0x2,0x1},{0x0,0xa3},{0x2,0x1},{0x0,0x87},{0x0,0x78},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa4},{0x0,0x4a},{0x2,0x1},{0x0,0x96},{0x0,0x69},{0x4,0x1},{0x2,0x1},{0x0,0xb0},{0x0,0xb},{0x0,0xb1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1b},{0x0,0xb2},{0x2,0x1},{0x0,0x2b},{0x2,0x1},{0x0,0xa5},{0x0,0x5a},{0x6,0x1},{0x2,0x1},{0x0,0xb3},{0x2,0x1},{0x0,0xa6},{0x0,0x6a},{0x4,0x1},{0x2,0x1},{0x0,0xb4},{0x0,0x4b},{0x2,0x1},{0x0,0xc},{0x0,0xc1},{0x1e,0x1},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb5},{0x0,0xc2},{0x0,0x2c},{0x4,0x1},{0x2,0x1},{0x0,0xa7},{0x0,0xc3},{0x2,0x1},{0x0,0x6b},{0x0,0xc4},{0x8,0x1},{0x2,0x1},{0x0,0x1d},{0x4,0x1},{0x2,0x1},{0x0,0x88},{0x0,0x97},{0x0,0x3b},{0x4,0x1},{0x2,0x1},{0x0,0xd1},{0x0,0xd2},{0x2,0x1},{0x0,0x2d},{0x0,0xd3},{0x12,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0x2e},{0x0,0xe2},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x79},{0x0,0x98},{0x0,0xc0},{0x2,0x1},{0x0,0x1c},{0x2,0x1},{0x0,0x89},{0x0,0x5b},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3c},{0x2,0x1},{0x0,0x7a},{0x0,0xb6},{0x4,0x1},{0x2,0x1},{0x0,0x4c},{0x0,0x99},{0x2,0x1},{0x0,0xa8},{0x0,0x8a},{0x6,0x1},{0x2,0x1},{0x0,0xd},{0x2,0x1},{0x0,0xc5},{0x0,0x5c},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x2,0x1},{0x0,0x6c},{0x0,0x9a},{0x58,0x1},{0x56,0x1},{0x24,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8b},{0x0,0x4d},{0x2,0x1},{0x0,0xc7},{0x0,0x7c},{0x4,0x1},{0x2,0x1},{0x0,0xd5},{0x0,0x5d},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x8,0x1},{0x2,0x1},{0x0,0xe3},{0x4,0x1},{0x2,0x1},{0x0,0xd0},{0x0,0xb7},{0x0,0x7b},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa9},{0x0,0xb8},{0x0,0xd4},{0x2,0x1},{0x0,0xe1},{0x2,0x1},{0x0,0xaa},{0x0,0xb9},{0x18,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9b},{0x0,0xd6},{0x0,0x6d},{0x2,0x1},{0x0,0x3e},{0x0,0xc8},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8c},{0x0,0xe4},{0x0,0x4e},{0x4,0x1},{0x2,0x1},{0x0,0xd7},{0x0,0xe5},{0x2,0x1},{0x0,0xba},{0x0,0xab},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9c},{0x0,0xe6},{0x4,0x1},{0x2,0x1},{0x0,0x6e},{0x0,0xd8},{0x2,0x1},{0x0,0x8d},{0x0,0xbb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe7},{0x0,0x9d},{0x2,0x1},{0x0,0xe8},{0x0,0x8e},{0x4,0x1},{0x2,0x1},{0x0,0xcb},{0x0,0xbc},{0x0,0x9e},{0x0,0xf1},{0x2,0x1},{0x0,0x1f},{0x2,0x1},{0x0,0xf},{0x0,0x2f},{0x42,0x1},{0x38,0x1},{0x2,0x1},{0x0,0xf2},{0x34,0x1},{0x32,0x1},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0xbd},{0x2,0x1},{0x0,0x5e},{0x2,0x1},{0x0,0x7d},{0x0,0xc9},{0x6,0x1},{0x2,0x1},{0x0,0xca},{0x2,0x1},{0x0,0xac},{0x0,0x7e},{0x4,0x1},{0x2,0x1},{0x0,0xda},{0x0,0xad},{0x0,0xcc},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xae},{0x2,0x1},{0x0,0xdb},{0x0,0xdc},{0x2,0x1},{0x0,0xcd},{0x0,0xbe},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xeb},{0x0,0xed},{0x0,0xee},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd9},{0x0,0xea},{0x0,0xe9},{0x2,0x1},{0x0,0xde},{0x4,0x1},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x0,0xce},{0x0,0x3f},{0x0,0xf0},{0x4,0x1},{0x2,0x1},{0x0,0xf3},{0x0,0xf4},{0x2,0x1},{0x0,0x4f},{0x2,0x1},{0x0,0xf5},{0x0,0x5f},{0xa,0x1},{0x2,0x1},{0x0,0xff},{0x4,0x1},{0x2,0x1},{0x0,0xf6},{0x0,0x6f},{0x2,0x1},{0x0,0xf7},{0x0,0x7f},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x8f},{0x2,0x1},{0x0,0xf8},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xfa},{0x0,0xaf},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xfb},{0x0,0xbf},{0x2,0x1},{0x0,0xfc},{0x0,0xcf},{0x4,0x1},{0x2,0x1},{0x0,0xfd},{0x0,0xdf},{0x2,0x1},{0x0,0xfe},{0x0,0xef}};
    61df:	8d 95 88 ee ff ff    	lea    -0x1178(%ebp),%edx
    61e5:	b8 00 c5 00 00       	mov    $0xc500,%eax
    61ea:	b9 ff 00 00 00       	mov    $0xff,%ecx
    61ef:	89 d7                	mov    %edx,%edi
    61f1:	89 c6                	mov    %eax,%esi
    61f3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    61f5:	89 f0                	mov    %esi,%eax
    61f7:	89 fa                	mov    %edi,%edx
    61f9:	0f b7 08             	movzwl (%eax),%ecx
    61fc:	66 89 0a             	mov    %cx,(%edx)
    61ff:	83 c2 02             	add    $0x2,%edx
    6202:	83 c0 02             	add    $0x2,%eax

	unsigned char h24[512][2] = {{0x3c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x14},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0xfa,0x1},{0x62,0x1},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x4,0x1},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0x2,0x1},{0x0,0x62},{0x0,0x26},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x71},{0x0,0x55},{0x2,0x1},{0x0,0x64},{0x0,0x46},{0x20,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x72},{0x2,0x1},{0x0,0x27},{0x0,0x37},{0x2,0x1},{0x0,0x73},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x0,0x17},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x65},{0x0,0x56},{0x4,0x1},{0x2,0x1},{0x0,0x80},{0x0,0x8},{0x0,0x81},{0x4,0x1},{0x2,0x1},{0x0,0x74},{0x0,0x47},{0x2,0x1},{0x0,0x18},{0x0,0x82},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x28},{0x0,0x66},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x91},{0x0,0x19},{0x2,0x1},{0x0,0x92},{0x0,0x76},{0x4,0x1},{0x2,0x1},{0x0,0x67},{0x0,0x29},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x5c,0x1},{0x22,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x93},{0x0,0x39},{0x2,0x1},{0x0,0x94},{0x0,0x49},{0x4,0x1},{0x2,0x1},{0x0,0x77},{0x0,0x86},{0x2,0x1},{0x0,0x68},{0x0,0xa1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x4,0x1},{0x2,0x1},{0x0,0xa3},{0x0,0x3a},{0x2,0x1},{0x0,0x87},{0x2,0x1},{0x0,0x78},{0x0,0x4a},{0x16,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa4},{0x0,0x96},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xb1},{0x2,0x1},{0x0,0x1b},{0x0,0xa5},{0x6,0x1},{0x2,0x1},{0x0,0xb2},{0x2,0x1},{0x0,0x5a},{0x0,0x2b},{0x2,0x1},{0x0,0x88},{0x0,0xb3},{0x10,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x90},{0x2,0x1},{0x0,0x9},{0x0,0xa0},{0x2,0x1},{0x0,0x97},{0x0,0x79},{0x4,0x1},{0x2,0x1},{0x0,0xa6},{0x0,0x6a},{0x0,0xb4},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x1a},{0x2,0x1},{0x0,0xa},{0x0,0xb0},{0x2,0x1},{0x0,0x3b},{0x2,0x1},{0x0,0xb},{0x0,0xc0},{0x4,0x1},{0x2,0x1},{0x0,0x4b},{0x0,0xc1},{0x2,0x1},{0x0,0x98},{0x0,0x89},{0x43,0x1},{0x22,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1c},{0x0,0xb5},{0x2,0x1},{0x0,0x5b},{0x0,0xc2},{0x4,0x1},{0x2,0x1},{0x0,0x2c},{0x0,0xa7},{0x2,0x1},{0x0,0x7a},{0x0,0xc3},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3c},{0x2,0x1},{0x0,0xc},{0x0,0xd0},{0x2,0x1},{0x0,0xb6},{0x0,0x6b},{0x4,0x1},{0x2,0x1},{0x0,0xc4},{0x0,0x4c},{0x2,0x1},{0x0,0x99},{0x0,0xa8},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8a},{0x0,0xc5},{0x2,0x1},{0x0,0x5c},{0x0,0xd1},{0x4,0x1},{0x2,0x1},{0x0,0xb7},{0x0,0x7b},{0x2,0x1},{0x0,0x1d},{0x0,0xd2},{0x9,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x2d},{0x0,0xd3},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x55,0xfa},{0x4,0x1},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x2,0x1},{0x0,0x9a},{0x0,0xd4},{0x20,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb8},{0x0,0x8b},{0x2,0x1},{0x0,0x4d},{0x0,0xc7},{0x4,0x1},{0x2,0x1},{0x0,0x7c},{0x0,0xd5},{0x2,0x1},{0x0,0x5d},{0x0,0xe1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0xe2},{0x2,0x1},{0x0,0xaa},{0x0,0xb9},{0x4,0x1},{0x2,0x1},{0x0,0x9b},{0x0,0xe3},{0x2,0x1},{0x0,0xd6},{0x0,0x6d},{0x14,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3e},{0x2,0x1},{0x0,0x2e},{0x0,0x4e},{0x2,0x1},{0x0,0xc8},{0x0,0x8c},{0x4,0x1},{0x2,0x1},{0x0,0xe4},{0x0,0xd7},{0x4,0x1},{0x2,0x1},{0x0,0x7d},{0x0,0xab},{0x0,0xe5},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xba},{0x0,0x5e},{0x2,0x1},{0x0,0xc9},{0x2,0x1},{0x0,0x9c},{0x0,0x6e},{0x8,0x1},{0x2,0x1},{0x0,0xe6},{0x2,0x1},{0x0,0xd},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0x8d},{0x2,0x1},{0x0,0xbb},{0x0,0xca},{0x4a,0x1},{0x2,0x1},{0x0,0xff},{0x40,0x1},{0x3a,0x1},{0x20,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xac},{0x0,0xe7},{0x2,0x1},{0x0,0x7e},{0x0,0xd9},{0x4,0x1},{0x2,0x1},{0x0,0x9d},{0x0,0xe8},{0x2,0x1},{0x0,0x8e},{0x0,0xcb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbc},{0x0,0xda},{0x2,0x1},{0x0,0xad},{0x0,0xe9},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xcc},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xea},{0x0,0xae},{0x2,0x1},{0x0,0xdc},{0x0,0xcd},{0x4,0x1},{0x2,0x1},{0x0,0xeb},{0x0,0xbe},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xce},{0x0,0xed},{0x2,0x1},{0x0,0xde},{0x0,0xee},{0x0,0xf},{0x4,0x1},{0x2,0x1},{0x0,0xf0},{0x0,0x1f},{0x0,0xf1},{0x4,0x1},{0x2,0x1},{0x0,0xf2},{0x0,0x2f},{0x2,0x1},{0x0,0xf3},{0x0,0x3f},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf4},{0x0,0x4f},{0x2,0x1},{0x0,0xf5},{0x0,0x5f},{0x4,0x1},{0x2,0x1},{0x0,0xf6},{0x0,0x6f},{0x2,0x1},{0x0,0xf7},{0x2,0x1},{0x0,0x7f},{0x0,0x8f},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf8},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xaf},{0x0,0xfa},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xfb},{0x0,0xbf},{0x2,0x1},{0x0,0xfc},{0x0,0xcf},{0x4,0x1},{0x2,0x1},{0x0,0xfd},{0x0,0xdf},{0x2,0x1},{0x0,0xfe},{0x0,0xef}};
    6205:	8d 95 88 ea ff ff    	lea    -0x1578(%ebp),%edx
    620b:	bb 00 c9 00 00       	mov    $0xc900,%ebx
    6210:	b8 00 01 00 00       	mov    $0x100,%eax
    6215:	89 d7                	mov    %edx,%edi
    6217:	89 de                	mov    %ebx,%esi
    6219:	89 c1                	mov    %eax,%ecx
    621b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	unsigned char hA[31][2] = {{0x2,0x1},{0x0,0x0},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8},{0x0,0x4},{0x2,0x1},{0x0,0x1},{0x0,0x2},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0xa},{0x2,0x1},{0x0,0x3},{0x0,0x6},{0x6,0x1},{0x2,0x1},{0x0,0x9},{0x2,0x1},{0x0,0x5},{0x0,0x7},{0x4,0x1},{0x2,0x1},{0x0,0xe},{0x0,0xd},{0x2,0x1},{0x0,0xf},{0x0,0xb}};
    621d:	c6 85 4a ea ff ff 02 	movb   $0x2,-0x15b6(%ebp)
    6224:	c6 85 4b ea ff ff 01 	movb   $0x1,-0x15b5(%ebp)
    622b:	c6 85 4c ea ff ff 00 	movb   $0x0,-0x15b4(%ebp)
    6232:	c6 85 4d ea ff ff 00 	movb   $0x0,-0x15b3(%ebp)
    6239:	c6 85 4e ea ff ff 08 	movb   $0x8,-0x15b2(%ebp)
    6240:	c6 85 4f ea ff ff 01 	movb   $0x1,-0x15b1(%ebp)
    6247:	c6 85 50 ea ff ff 04 	movb   $0x4,-0x15b0(%ebp)
    624e:	c6 85 51 ea ff ff 01 	movb   $0x1,-0x15af(%ebp)
    6255:	c6 85 52 ea ff ff 02 	movb   $0x2,-0x15ae(%ebp)
    625c:	c6 85 53 ea ff ff 01 	movb   $0x1,-0x15ad(%ebp)
    6263:	c6 85 54 ea ff ff 00 	movb   $0x0,-0x15ac(%ebp)
    626a:	c6 85 55 ea ff ff 08 	movb   $0x8,-0x15ab(%ebp)
    6271:	c6 85 56 ea ff ff 00 	movb   $0x0,-0x15aa(%ebp)
    6278:	c6 85 57 ea ff ff 04 	movb   $0x4,-0x15a9(%ebp)
    627f:	c6 85 58 ea ff ff 02 	movb   $0x2,-0x15a8(%ebp)
    6286:	c6 85 59 ea ff ff 01 	movb   $0x1,-0x15a7(%ebp)
    628d:	c6 85 5a ea ff ff 00 	movb   $0x0,-0x15a6(%ebp)
    6294:	c6 85 5b ea ff ff 01 	movb   $0x1,-0x15a5(%ebp)
    629b:	c6 85 5c ea ff ff 00 	movb   $0x0,-0x15a4(%ebp)
    62a2:	c6 85 5d ea ff ff 02 	movb   $0x2,-0x15a3(%ebp)
    62a9:	c6 85 5e ea ff ff 08 	movb   $0x8,-0x15a2(%ebp)
    62b0:	c6 85 5f ea ff ff 01 	movb   $0x1,-0x15a1(%ebp)
    62b7:	c6 85 60 ea ff ff 04 	movb   $0x4,-0x15a0(%ebp)
    62be:	c6 85 61 ea ff ff 01 	movb   $0x1,-0x159f(%ebp)
    62c5:	c6 85 62 ea ff ff 02 	movb   $0x2,-0x159e(%ebp)
    62cc:	c6 85 63 ea ff ff 01 	movb   $0x1,-0x159d(%ebp)
    62d3:	c6 85 64 ea ff ff 00 	movb   $0x0,-0x159c(%ebp)
    62da:	c6 85 65 ea ff ff 0c 	movb   $0xc,-0x159b(%ebp)
    62e1:	c6 85 66 ea ff ff 00 	movb   $0x0,-0x159a(%ebp)
    62e8:	c6 85 67 ea ff ff 0a 	movb   $0xa,-0x1599(%ebp)
    62ef:	c6 85 68 ea ff ff 02 	movb   $0x2,-0x1598(%ebp)
    62f6:	c6 85 69 ea ff ff 01 	movb   $0x1,-0x1597(%ebp)
    62fd:	c6 85 6a ea ff ff 00 	movb   $0x0,-0x1596(%ebp)
    6304:	c6 85 6b ea ff ff 03 	movb   $0x3,-0x1595(%ebp)
    630b:	c6 85 6c ea ff ff 00 	movb   $0x0,-0x1594(%ebp)
    6312:	c6 85 6d ea ff ff 06 	movb   $0x6,-0x1593(%ebp)
    6319:	c6 85 6e ea ff ff 06 	movb   $0x6,-0x1592(%ebp)
    6320:	c6 85 6f ea ff ff 01 	movb   $0x1,-0x1591(%ebp)
    6327:	c6 85 70 ea ff ff 02 	movb   $0x2,-0x1590(%ebp)
    632e:	c6 85 71 ea ff ff 01 	movb   $0x1,-0x158f(%ebp)
    6335:	c6 85 72 ea ff ff 00 	movb   $0x0,-0x158e(%ebp)
    633c:	c6 85 73 ea ff ff 09 	movb   $0x9,-0x158d(%ebp)
    6343:	c6 85 74 ea ff ff 02 	movb   $0x2,-0x158c(%ebp)
    634a:	c6 85 75 ea ff ff 01 	movb   $0x1,-0x158b(%ebp)
    6351:	c6 85 76 ea ff ff 00 	movb   $0x0,-0x158a(%ebp)
    6358:	c6 85 77 ea ff ff 05 	movb   $0x5,-0x1589(%ebp)
    635f:	c6 85 78 ea ff ff 00 	movb   $0x0,-0x1588(%ebp)
    6366:	c6 85 79 ea ff ff 07 	movb   $0x7,-0x1587(%ebp)
    636d:	c6 85 7a ea ff ff 04 	movb   $0x4,-0x1586(%ebp)
    6374:	c6 85 7b ea ff ff 01 	movb   $0x1,-0x1585(%ebp)
    637b:	c6 85 7c ea ff ff 02 	movb   $0x2,-0x1584(%ebp)
    6382:	c6 85 7d ea ff ff 01 	movb   $0x1,-0x1583(%ebp)
    6389:	c6 85 7e ea ff ff 00 	movb   $0x0,-0x1582(%ebp)
    6390:	c6 85 7f ea ff ff 0e 	movb   $0xe,-0x1581(%ebp)
    6397:	c6 85 80 ea ff ff 00 	movb   $0x0,-0x1580(%ebp)
    639e:	c6 85 81 ea ff ff 0d 	movb   $0xd,-0x157f(%ebp)
    63a5:	c6 85 82 ea ff ff 02 	movb   $0x2,-0x157e(%ebp)
    63ac:	c6 85 83 ea ff ff 01 	movb   $0x1,-0x157d(%ebp)
    63b3:	c6 85 84 ea ff ff 00 	movb   $0x0,-0x157c(%ebp)
    63ba:	c6 85 85 ea ff ff 0f 	movb   $0xf,-0x157b(%ebp)
    63c1:	c6 85 86 ea ff ff 00 	movb   $0x0,-0x157a(%ebp)
    63c8:	c6 85 87 ea ff ff 0b 	movb   $0xb,-0x1579(%ebp)

	unsigned char hB[31][2] = {{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x1},{0x2,0x1},{0x0,0x2},{0x0,0x3},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x5},{0x2,0x1},{0x0,0x6},{0x0,0x7},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8},{0x0,0x9},{0x2,0x1},{0x0,0xa},{0x0,0xb},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0xd},{0x2,0x1},{0x0,0xe},{0x0,0xf}};
    63cf:	c6 85 0c ea ff ff 10 	movb   $0x10,-0x15f4(%ebp)
    63d6:	c6 85 0d ea ff ff 01 	movb   $0x1,-0x15f3(%ebp)
    63dd:	c6 85 0e ea ff ff 08 	movb   $0x8,-0x15f2(%ebp)
    63e4:	c6 85 0f ea ff ff 01 	movb   $0x1,-0x15f1(%ebp)
    63eb:	c6 85 10 ea ff ff 04 	movb   $0x4,-0x15f0(%ebp)
    63f2:	c6 85 11 ea ff ff 01 	movb   $0x1,-0x15ef(%ebp)
    63f9:	c6 85 12 ea ff ff 02 	movb   $0x2,-0x15ee(%ebp)
    6400:	c6 85 13 ea ff ff 01 	movb   $0x1,-0x15ed(%ebp)
    6407:	c6 85 14 ea ff ff 00 	movb   $0x0,-0x15ec(%ebp)
    640e:	c6 85 15 ea ff ff 00 	movb   $0x0,-0x15eb(%ebp)
    6415:	c6 85 16 ea ff ff 00 	movb   $0x0,-0x15ea(%ebp)
    641c:	c6 85 17 ea ff ff 01 	movb   $0x1,-0x15e9(%ebp)
    6423:	c6 85 18 ea ff ff 02 	movb   $0x2,-0x15e8(%ebp)
    642a:	c6 85 19 ea ff ff 01 	movb   $0x1,-0x15e7(%ebp)
    6431:	c6 85 1a ea ff ff 00 	movb   $0x0,-0x15e6(%ebp)
    6438:	c6 85 1b ea ff ff 02 	movb   $0x2,-0x15e5(%ebp)
    643f:	c6 85 1c ea ff ff 00 	movb   $0x0,-0x15e4(%ebp)
    6446:	c6 85 1d ea ff ff 03 	movb   $0x3,-0x15e3(%ebp)
    644d:	c6 85 1e ea ff ff 04 	movb   $0x4,-0x15e2(%ebp)
    6454:	c6 85 1f ea ff ff 01 	movb   $0x1,-0x15e1(%ebp)
    645b:	c6 85 20 ea ff ff 02 	movb   $0x2,-0x15e0(%ebp)
    6462:	c6 85 21 ea ff ff 01 	movb   $0x1,-0x15df(%ebp)
    6469:	c6 85 22 ea ff ff 00 	movb   $0x0,-0x15de(%ebp)
    6470:	c6 85 23 ea ff ff 04 	movb   $0x4,-0x15dd(%ebp)
    6477:	c6 85 24 ea ff ff 00 	movb   $0x0,-0x15dc(%ebp)
    647e:	c6 85 25 ea ff ff 05 	movb   $0x5,-0x15db(%ebp)
    6485:	c6 85 26 ea ff ff 02 	movb   $0x2,-0x15da(%ebp)
    648c:	c6 85 27 ea ff ff 01 	movb   $0x1,-0x15d9(%ebp)
    6493:	c6 85 28 ea ff ff 00 	movb   $0x0,-0x15d8(%ebp)
    649a:	c6 85 29 ea ff ff 06 	movb   $0x6,-0x15d7(%ebp)
    64a1:	c6 85 2a ea ff ff 00 	movb   $0x0,-0x15d6(%ebp)
    64a8:	c6 85 2b ea ff ff 07 	movb   $0x7,-0x15d5(%ebp)
    64af:	c6 85 2c ea ff ff 08 	movb   $0x8,-0x15d4(%ebp)
    64b6:	c6 85 2d ea ff ff 01 	movb   $0x1,-0x15d3(%ebp)
    64bd:	c6 85 2e ea ff ff 04 	movb   $0x4,-0x15d2(%ebp)
    64c4:	c6 85 2f ea ff ff 01 	movb   $0x1,-0x15d1(%ebp)
    64cb:	c6 85 30 ea ff ff 02 	movb   $0x2,-0x15d0(%ebp)
    64d2:	c6 85 31 ea ff ff 01 	movb   $0x1,-0x15cf(%ebp)
    64d9:	c6 85 32 ea ff ff 00 	movb   $0x0,-0x15ce(%ebp)
    64e0:	c6 85 33 ea ff ff 08 	movb   $0x8,-0x15cd(%ebp)
    64e7:	c6 85 34 ea ff ff 00 	movb   $0x0,-0x15cc(%ebp)
    64ee:	c6 85 35 ea ff ff 09 	movb   $0x9,-0x15cb(%ebp)
    64f5:	c6 85 36 ea ff ff 02 	movb   $0x2,-0x15ca(%ebp)
    64fc:	c6 85 37 ea ff ff 01 	movb   $0x1,-0x15c9(%ebp)
    6503:	c6 85 38 ea ff ff 00 	movb   $0x0,-0x15c8(%ebp)
    650a:	c6 85 39 ea ff ff 0a 	movb   $0xa,-0x15c7(%ebp)
    6511:	c6 85 3a ea ff ff 00 	movb   $0x0,-0x15c6(%ebp)
    6518:	c6 85 3b ea ff ff 0b 	movb   $0xb,-0x15c5(%ebp)
    651f:	c6 85 3c ea ff ff 04 	movb   $0x4,-0x15c4(%ebp)
    6526:	c6 85 3d ea ff ff 01 	movb   $0x1,-0x15c3(%ebp)
    652d:	c6 85 3e ea ff ff 02 	movb   $0x2,-0x15c2(%ebp)
    6534:	c6 85 3f ea ff ff 01 	movb   $0x1,-0x15c1(%ebp)
    653b:	c6 85 40 ea ff ff 00 	movb   $0x0,-0x15c0(%ebp)
    6542:	c6 85 41 ea ff ff 0c 	movb   $0xc,-0x15bf(%ebp)
    6549:	c6 85 42 ea ff ff 00 	movb   $0x0,-0x15be(%ebp)
    6550:	c6 85 43 ea ff ff 0d 	movb   $0xd,-0x15bd(%ebp)
    6557:	c6 85 44 ea ff ff 02 	movb   $0x2,-0x15bc(%ebp)
    655e:	c6 85 45 ea ff ff 01 	movb   $0x1,-0x15bb(%ebp)
    6565:	c6 85 46 ea ff ff 00 	movb   $0x0,-0x15ba(%ebp)
    656c:	c6 85 47 ea ff ff 0e 	movb   $0xe,-0x15b9(%ebp)
    6573:	c6 85 48 ea ff ff 00 	movb   $0x0,-0x15b8(%ebp)
    657a:	c6 85 49 ea ff ff 0f 	movb   $0xf,-0x15b7(%ebp)
	
	struct huffcodetab ht[HTN] = {
    6581:	66 c7 85 bc e4 ff ff 	movw   $0x30,-0x1b44(%ebp)
    6588:	30 00 
    658a:	c6 85 be e4 ff ff 00 	movb   $0x0,-0x1b42(%ebp)
    6591:	c7 85 c0 e4 ff ff 00 	movl   $0x0,-0x1b40(%ebp)
    6598:	00 00 00 
    659b:	c7 85 c4 e4 ff ff 00 	movl   $0x0,-0x1b3c(%ebp)
    65a2:	00 00 00 
    65a5:	c7 85 c8 e4 ff ff 00 	movl   $0x0,-0x1b38(%ebp)
    65ac:	00 00 00 
    65af:	c7 85 cc e4 ff ff 00 	movl   $0x0,-0x1b34(%ebp)
    65b6:	00 00 00 
    65b9:	c7 85 d0 e4 ff ff ff 	movl   $0xffffffff,-0x1b30(%ebp)
    65c0:	ff ff ff 
    65c3:	c7 85 d4 e4 ff ff 00 	movl   $0x0,-0x1b2c(%ebp)
    65ca:	00 00 00 
    65cd:	c7 85 d8 e4 ff ff 00 	movl   $0x0,-0x1b28(%ebp)
    65d4:	00 00 00 
    65d7:	c7 85 dc e4 ff ff 00 	movl   $0x0,-0x1b24(%ebp)
    65de:	00 00 00 
    65e1:	c7 85 e0 e4 ff ff 00 	movl   $0x0,-0x1b20(%ebp)
    65e8:	00 00 00 
    65eb:	66 c7 85 e4 e4 ff ff 	movw   $0x31,-0x1b1c(%ebp)
    65f2:	31 00 
    65f4:	c6 85 e6 e4 ff ff 00 	movb   $0x0,-0x1b1a(%ebp)
    65fb:	c7 85 e8 e4 ff ff 02 	movl   $0x2,-0x1b18(%ebp)
    6602:	00 00 00 
    6605:	c7 85 ec e4 ff ff 02 	movl   $0x2,-0x1b14(%ebp)
    660c:	00 00 00 
    660f:	c7 85 f0 e4 ff ff 00 	movl   $0x0,-0x1b10(%ebp)
    6616:	00 00 00 
    6619:	c7 85 f4 e4 ff ff 00 	movl   $0x0,-0x1b0c(%ebp)
    6620:	00 00 00 
    6623:	c7 85 f8 e4 ff ff ff 	movl   $0xffffffff,-0x1b08(%ebp)
    662a:	ff ff ff 
    662d:	c7 85 fc e4 ff ff 00 	movl   $0x0,-0x1b04(%ebp)
    6634:	00 00 00 
    6637:	c7 85 00 e5 ff ff 00 	movl   $0x0,-0x1b00(%ebp)
    663e:	00 00 00 
    6641:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    6644:	89 85 04 e5 ff ff    	mov    %eax,-0x1afc(%ebp)
    664a:	c7 85 08 e5 ff ff 07 	movl   $0x7,-0x1af8(%ebp)
    6651:	00 00 00 
    6654:	66 c7 85 0c e5 ff ff 	movw   $0x32,-0x1af4(%ebp)
    665b:	32 00 
    665d:	c6 85 0e e5 ff ff 00 	movb   $0x0,-0x1af2(%ebp)
    6664:	c7 85 10 e5 ff ff 03 	movl   $0x3,-0x1af0(%ebp)
    666b:	00 00 00 
    666e:	c7 85 14 e5 ff ff 03 	movl   $0x3,-0x1aec(%ebp)
    6675:	00 00 00 
    6678:	c7 85 18 e5 ff ff 00 	movl   $0x0,-0x1ae8(%ebp)
    667f:	00 00 00 
    6682:	c7 85 1c e5 ff ff 00 	movl   $0x0,-0x1ae4(%ebp)
    6689:	00 00 00 
    668c:	c7 85 20 e5 ff ff ff 	movl   $0xffffffff,-0x1ae0(%ebp)
    6693:	ff ff ff 
    6696:	c7 85 24 e5 ff ff 00 	movl   $0x0,-0x1adc(%ebp)
    669d:	00 00 00 
    66a0:	c7 85 28 e5 ff ff 00 	movl   $0x0,-0x1ad8(%ebp)
    66a7:	00 00 00 
    66aa:	8d 45 c4             	lea    -0x3c(%ebp),%eax
    66ad:	89 85 2c e5 ff ff    	mov    %eax,-0x1ad4(%ebp)
    66b3:	c7 85 30 e5 ff ff 11 	movl   $0x11,-0x1ad0(%ebp)
    66ba:	00 00 00 
    66bd:	66 c7 85 34 e5 ff ff 	movw   $0x33,-0x1acc(%ebp)
    66c4:	33 00 
    66c6:	c6 85 36 e5 ff ff 00 	movb   $0x0,-0x1aca(%ebp)
    66cd:	c7 85 38 e5 ff ff 03 	movl   $0x3,-0x1ac8(%ebp)
    66d4:	00 00 00 
    66d7:	c7 85 3c e5 ff ff 03 	movl   $0x3,-0x1ac4(%ebp)
    66de:	00 00 00 
    66e1:	c7 85 40 e5 ff ff 00 	movl   $0x0,-0x1ac0(%ebp)
    66e8:	00 00 00 
    66eb:	c7 85 44 e5 ff ff 00 	movl   $0x0,-0x1abc(%ebp)
    66f2:	00 00 00 
    66f5:	c7 85 48 e5 ff ff ff 	movl   $0xffffffff,-0x1ab8(%ebp)
    66fc:	ff ff ff 
    66ff:	c7 85 4c e5 ff ff 00 	movl   $0x0,-0x1ab4(%ebp)
    6706:	00 00 00 
    6709:	c7 85 50 e5 ff ff 00 	movl   $0x0,-0x1ab0(%ebp)
    6710:	00 00 00 
    6713:	8d 45 a2             	lea    -0x5e(%ebp),%eax
    6716:	89 85 54 e5 ff ff    	mov    %eax,-0x1aac(%ebp)
    671c:	c7 85 58 e5 ff ff 11 	movl   $0x11,-0x1aa8(%ebp)
    6723:	00 00 00 
    6726:	66 c7 85 5c e5 ff ff 	movw   $0x34,-0x1aa4(%ebp)
    672d:	34 00 
    672f:	c6 85 5e e5 ff ff 00 	movb   $0x0,-0x1aa2(%ebp)
    6736:	c7 85 60 e5 ff ff 00 	movl   $0x0,-0x1aa0(%ebp)
    673d:	00 00 00 
    6740:	c7 85 64 e5 ff ff 00 	movl   $0x0,-0x1a9c(%ebp)
    6747:	00 00 00 
    674a:	c7 85 68 e5 ff ff 00 	movl   $0x0,-0x1a98(%ebp)
    6751:	00 00 00 
    6754:	c7 85 6c e5 ff ff 00 	movl   $0x0,-0x1a94(%ebp)
    675b:	00 00 00 
    675e:	c7 85 70 e5 ff ff ff 	movl   $0xffffffff,-0x1a90(%ebp)
    6765:	ff ff ff 
    6768:	c7 85 74 e5 ff ff 00 	movl   $0x0,-0x1a8c(%ebp)
    676f:	00 00 00 
    6772:	c7 85 78 e5 ff ff 00 	movl   $0x0,-0x1a88(%ebp)
    6779:	00 00 00 
    677c:	c7 85 7c e5 ff ff 00 	movl   $0x0,-0x1a84(%ebp)
    6783:	00 00 00 
    6786:	c7 85 80 e5 ff ff 00 	movl   $0x0,-0x1a80(%ebp)
    678d:	00 00 00 
    6790:	66 c7 85 84 e5 ff ff 	movw   $0x35,-0x1a7c(%ebp)
    6797:	35 00 
    6799:	c6 85 86 e5 ff ff 00 	movb   $0x0,-0x1a7a(%ebp)
    67a0:	c7 85 88 e5 ff ff 04 	movl   $0x4,-0x1a78(%ebp)
    67a7:	00 00 00 
    67aa:	c7 85 8c e5 ff ff 04 	movl   $0x4,-0x1a74(%ebp)
    67b1:	00 00 00 
    67b4:	c7 85 90 e5 ff ff 00 	movl   $0x0,-0x1a70(%ebp)
    67bb:	00 00 00 
    67be:	c7 85 94 e5 ff ff 00 	movl   $0x0,-0x1a6c(%ebp)
    67c5:	00 00 00 
    67c8:	c7 85 98 e5 ff ff ff 	movl   $0xffffffff,-0x1a68(%ebp)
    67cf:	ff ff ff 
    67d2:	c7 85 9c e5 ff ff 00 	movl   $0x0,-0x1a64(%ebp)
    67d9:	00 00 00 
    67dc:	c7 85 a0 e5 ff ff 00 	movl   $0x0,-0x1a60(%ebp)
    67e3:	00 00 00 
    67e6:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
    67ec:	89 85 a4 e5 ff ff    	mov    %eax,-0x1a5c(%ebp)
    67f2:	c7 85 a8 e5 ff ff 1f 	movl   $0x1f,-0x1a58(%ebp)
    67f9:	00 00 00 
    67fc:	66 c7 85 ac e5 ff ff 	movw   $0x36,-0x1a54(%ebp)
    6803:	36 00 
    6805:	c6 85 ae e5 ff ff 00 	movb   $0x0,-0x1a52(%ebp)
    680c:	c7 85 b0 e5 ff ff 04 	movl   $0x4,-0x1a50(%ebp)
    6813:	00 00 00 
    6816:	c7 85 b4 e5 ff ff 04 	movl   $0x4,-0x1a4c(%ebp)
    681d:	00 00 00 
    6820:	c7 85 b8 e5 ff ff 00 	movl   $0x0,-0x1a48(%ebp)
    6827:	00 00 00 
    682a:	c7 85 bc e5 ff ff 00 	movl   $0x0,-0x1a44(%ebp)
    6831:	00 00 00 
    6834:	c7 85 c0 e5 ff ff ff 	movl   $0xffffffff,-0x1a40(%ebp)
    683b:	ff ff ff 
    683e:	c7 85 c4 e5 ff ff 00 	movl   $0x0,-0x1a3c(%ebp)
    6845:	00 00 00 
    6848:	c7 85 c8 e5 ff ff 00 	movl   $0x0,-0x1a38(%ebp)
    684f:	00 00 00 
    6852:	8d 85 26 ff ff ff    	lea    -0xda(%ebp),%eax
    6858:	89 85 cc e5 ff ff    	mov    %eax,-0x1a34(%ebp)
    685e:	c7 85 d0 e5 ff ff 1f 	movl   $0x1f,-0x1a30(%ebp)
    6865:	00 00 00 
    6868:	66 c7 85 d4 e5 ff ff 	movw   $0x37,-0x1a2c(%ebp)
    686f:	37 00 
    6871:	c6 85 d6 e5 ff ff 00 	movb   $0x0,-0x1a2a(%ebp)
    6878:	c7 85 d8 e5 ff ff 06 	movl   $0x6,-0x1a28(%ebp)
    687f:	00 00 00 
    6882:	c7 85 dc e5 ff ff 06 	movl   $0x6,-0x1a24(%ebp)
    6889:	00 00 00 
    688c:	c7 85 e0 e5 ff ff 00 	movl   $0x0,-0x1a20(%ebp)
    6893:	00 00 00 
    6896:	c7 85 e4 e5 ff ff 00 	movl   $0x0,-0x1a1c(%ebp)
    689d:	00 00 00 
    68a0:	c7 85 e8 e5 ff ff ff 	movl   $0xffffffff,-0x1a18(%ebp)
    68a7:	ff ff ff 
    68aa:	c7 85 ec e5 ff ff 00 	movl   $0x0,-0x1a14(%ebp)
    68b1:	00 00 00 
    68b4:	c7 85 f0 e5 ff ff 00 	movl   $0x0,-0x1a10(%ebp)
    68bb:	00 00 00 
    68be:	8d 85 98 fe ff ff    	lea    -0x168(%ebp),%eax
    68c4:	89 85 f4 e5 ff ff    	mov    %eax,-0x1a0c(%ebp)
    68ca:	c7 85 f8 e5 ff ff 47 	movl   $0x47,-0x1a08(%ebp)
    68d1:	00 00 00 
    68d4:	66 c7 85 fc e5 ff ff 	movw   $0x38,-0x1a04(%ebp)
    68db:	38 00 
    68dd:	c6 85 fe e5 ff ff 00 	movb   $0x0,-0x1a02(%ebp)
    68e4:	c7 85 00 e6 ff ff 06 	movl   $0x6,-0x1a00(%ebp)
    68eb:	00 00 00 
    68ee:	c7 85 04 e6 ff ff 06 	movl   $0x6,-0x19fc(%ebp)
    68f5:	00 00 00 
    68f8:	c7 85 08 e6 ff ff 00 	movl   $0x0,-0x19f8(%ebp)
    68ff:	00 00 00 
    6902:	c7 85 0c e6 ff ff 00 	movl   $0x0,-0x19f4(%ebp)
    6909:	00 00 00 
    690c:	c7 85 10 e6 ff ff ff 	movl   $0xffffffff,-0x19f0(%ebp)
    6913:	ff ff ff 
    6916:	c7 85 14 e6 ff ff 00 	movl   $0x0,-0x19ec(%ebp)
    691d:	00 00 00 
    6920:	c7 85 18 e6 ff ff 00 	movl   $0x0,-0x19e8(%ebp)
    6927:	00 00 00 
    692a:	8d 85 0a fe ff ff    	lea    -0x1f6(%ebp),%eax
    6930:	89 85 1c e6 ff ff    	mov    %eax,-0x19e4(%ebp)
    6936:	c7 85 20 e6 ff ff 47 	movl   $0x47,-0x19e0(%ebp)
    693d:	00 00 00 
    6940:	66 c7 85 24 e6 ff ff 	movw   $0x39,-0x19dc(%ebp)
    6947:	39 00 
    6949:	c6 85 26 e6 ff ff 00 	movb   $0x0,-0x19da(%ebp)
    6950:	c7 85 28 e6 ff ff 06 	movl   $0x6,-0x19d8(%ebp)
    6957:	00 00 00 
    695a:	c7 85 2c e6 ff ff 06 	movl   $0x6,-0x19d4(%ebp)
    6961:	00 00 00 
    6964:	c7 85 30 e6 ff ff 00 	movl   $0x0,-0x19d0(%ebp)
    696b:	00 00 00 
    696e:	c7 85 34 e6 ff ff 00 	movl   $0x0,-0x19cc(%ebp)
    6975:	00 00 00 
    6978:	c7 85 38 e6 ff ff ff 	movl   $0xffffffff,-0x19c8(%ebp)
    697f:	ff ff ff 
    6982:	c7 85 3c e6 ff ff 00 	movl   $0x0,-0x19c4(%ebp)
    6989:	00 00 00 
    698c:	c7 85 40 e6 ff ff 00 	movl   $0x0,-0x19c0(%ebp)
    6993:	00 00 00 
    6996:	8d 85 7c fd ff ff    	lea    -0x284(%ebp),%eax
    699c:	89 85 44 e6 ff ff    	mov    %eax,-0x19bc(%ebp)
    69a2:	c7 85 48 e6 ff ff 47 	movl   $0x47,-0x19b8(%ebp)
    69a9:	00 00 00 
    69ac:	66 c7 85 4c e6 ff ff 	movw   $0x3031,-0x19b4(%ebp)
    69b3:	31 30 
    69b5:	c6 85 4e e6 ff ff 00 	movb   $0x0,-0x19b2(%ebp)
    69bc:	c7 85 50 e6 ff ff 08 	movl   $0x8,-0x19b0(%ebp)
    69c3:	00 00 00 
    69c6:	c7 85 54 e6 ff ff 08 	movl   $0x8,-0x19ac(%ebp)
    69cd:	00 00 00 
    69d0:	c7 85 58 e6 ff ff 00 	movl   $0x0,-0x19a8(%ebp)
    69d7:	00 00 00 
    69da:	c7 85 5c e6 ff ff 00 	movl   $0x0,-0x19a4(%ebp)
    69e1:	00 00 00 
    69e4:	c7 85 60 e6 ff ff ff 	movl   $0xffffffff,-0x19a0(%ebp)
    69eb:	ff ff ff 
    69ee:	c7 85 64 e6 ff ff 00 	movl   $0x0,-0x199c(%ebp)
    69f5:	00 00 00 
    69f8:	c7 85 68 e6 ff ff 00 	movl   $0x0,-0x1998(%ebp)
    69ff:	00 00 00 
    6a02:	8d 85 7e fc ff ff    	lea    -0x382(%ebp),%eax
    6a08:	89 85 6c e6 ff ff    	mov    %eax,-0x1994(%ebp)
    6a0e:	c7 85 70 e6 ff ff 7f 	movl   $0x7f,-0x1990(%ebp)
    6a15:	00 00 00 
    6a18:	66 c7 85 74 e6 ff ff 	movw   $0x3131,-0x198c(%ebp)
    6a1f:	31 31 
    6a21:	c6 85 76 e6 ff ff 00 	movb   $0x0,-0x198a(%ebp)
    6a28:	c7 85 78 e6 ff ff 08 	movl   $0x8,-0x1988(%ebp)
    6a2f:	00 00 00 
    6a32:	c7 85 7c e6 ff ff 08 	movl   $0x8,-0x1984(%ebp)
    6a39:	00 00 00 
    6a3c:	c7 85 80 e6 ff ff 00 	movl   $0x0,-0x1980(%ebp)
    6a43:	00 00 00 
    6a46:	c7 85 84 e6 ff ff 00 	movl   $0x0,-0x197c(%ebp)
    6a4d:	00 00 00 
    6a50:	c7 85 88 e6 ff ff ff 	movl   $0xffffffff,-0x1978(%ebp)
    6a57:	ff ff ff 
    6a5a:	c7 85 8c e6 ff ff 00 	movl   $0x0,-0x1974(%ebp)
    6a61:	00 00 00 
    6a64:	c7 85 90 e6 ff ff 00 	movl   $0x0,-0x1970(%ebp)
    6a6b:	00 00 00 
    6a6e:	8d 85 80 fb ff ff    	lea    -0x480(%ebp),%eax
    6a74:	89 85 94 e6 ff ff    	mov    %eax,-0x196c(%ebp)
    6a7a:	c7 85 98 e6 ff ff 7f 	movl   $0x7f,-0x1968(%ebp)
    6a81:	00 00 00 
    6a84:	66 c7 85 9c e6 ff ff 	movw   $0x3231,-0x1964(%ebp)
    6a8b:	31 32 
    6a8d:	c6 85 9e e6 ff ff 00 	movb   $0x0,-0x1962(%ebp)
    6a94:	c7 85 a0 e6 ff ff 08 	movl   $0x8,-0x1960(%ebp)
    6a9b:	00 00 00 
    6a9e:	c7 85 a4 e6 ff ff 08 	movl   $0x8,-0x195c(%ebp)
    6aa5:	00 00 00 
    6aa8:	c7 85 a8 e6 ff ff 00 	movl   $0x0,-0x1958(%ebp)
    6aaf:	00 00 00 
    6ab2:	c7 85 ac e6 ff ff 00 	movl   $0x0,-0x1954(%ebp)
    6ab9:	00 00 00 
    6abc:	c7 85 b0 e6 ff ff ff 	movl   $0xffffffff,-0x1950(%ebp)
    6ac3:	ff ff ff 
    6ac6:	c7 85 b4 e6 ff ff 00 	movl   $0x0,-0x194c(%ebp)
    6acd:	00 00 00 
    6ad0:	c7 85 b8 e6 ff ff 00 	movl   $0x0,-0x1948(%ebp)
    6ad7:	00 00 00 
    6ada:	8d 85 82 fa ff ff    	lea    -0x57e(%ebp),%eax
    6ae0:	89 85 bc e6 ff ff    	mov    %eax,-0x1944(%ebp)
    6ae6:	c7 85 c0 e6 ff ff 7f 	movl   $0x7f,-0x1940(%ebp)
    6aed:	00 00 00 
    6af0:	66 c7 85 c4 e6 ff ff 	movw   $0x3331,-0x193c(%ebp)
    6af7:	31 33 
    6af9:	c6 85 c6 e6 ff ff 00 	movb   $0x0,-0x193a(%ebp)
    6b00:	c7 85 c8 e6 ff ff 10 	movl   $0x10,-0x1938(%ebp)
    6b07:	00 00 00 
    6b0a:	c7 85 cc e6 ff ff 10 	movl   $0x10,-0x1934(%ebp)
    6b11:	00 00 00 
    6b14:	c7 85 d0 e6 ff ff 00 	movl   $0x0,-0x1930(%ebp)
    6b1b:	00 00 00 
    6b1e:	c7 85 d4 e6 ff ff 00 	movl   $0x0,-0x192c(%ebp)
    6b25:	00 00 00 
    6b28:	c7 85 d8 e6 ff ff ff 	movl   $0xffffffff,-0x1928(%ebp)
    6b2f:	ff ff ff 
    6b32:	c7 85 dc e6 ff ff 00 	movl   $0x0,-0x1924(%ebp)
    6b39:	00 00 00 
    6b3c:	c7 85 e0 e6 ff ff 00 	movl   $0x0,-0x1920(%ebp)
    6b43:	00 00 00 
    6b46:	8d 85 84 f6 ff ff    	lea    -0x97c(%ebp),%eax
    6b4c:	89 85 e4 e6 ff ff    	mov    %eax,-0x191c(%ebp)
    6b52:	c7 85 e8 e6 ff ff ff 	movl   $0x1ff,-0x1918(%ebp)
    6b59:	01 00 00 
    6b5c:	66 c7 85 ec e6 ff ff 	movw   $0x3431,-0x1914(%ebp)
    6b63:	31 34 
    6b65:	c6 85 ee e6 ff ff 00 	movb   $0x0,-0x1912(%ebp)
    6b6c:	c7 85 f0 e6 ff ff 00 	movl   $0x0,-0x1910(%ebp)
    6b73:	00 00 00 
    6b76:	c7 85 f4 e6 ff ff 00 	movl   $0x0,-0x190c(%ebp)
    6b7d:	00 00 00 
    6b80:	c7 85 f8 e6 ff ff 00 	movl   $0x0,-0x1908(%ebp)
    6b87:	00 00 00 
    6b8a:	c7 85 fc e6 ff ff 00 	movl   $0x0,-0x1904(%ebp)
    6b91:	00 00 00 
    6b94:	c7 85 00 e7 ff ff ff 	movl   $0xffffffff,-0x1900(%ebp)
    6b9b:	ff ff ff 
    6b9e:	c7 85 04 e7 ff ff 00 	movl   $0x0,-0x18fc(%ebp)
    6ba5:	00 00 00 
    6ba8:	c7 85 08 e7 ff ff 00 	movl   $0x0,-0x18f8(%ebp)
    6baf:	00 00 00 
    6bb2:	c7 85 0c e7 ff ff 00 	movl   $0x0,-0x18f4(%ebp)
    6bb9:	00 00 00 
    6bbc:	c7 85 10 e7 ff ff 00 	movl   $0x0,-0x18f0(%ebp)
    6bc3:	00 00 00 
    6bc6:	66 c7 85 14 e7 ff ff 	movw   $0x3531,-0x18ec(%ebp)
    6bcd:	31 35 
    6bcf:	c6 85 16 e7 ff ff 00 	movb   $0x0,-0x18ea(%ebp)
    6bd6:	c7 85 18 e7 ff ff 10 	movl   $0x10,-0x18e8(%ebp)
    6bdd:	00 00 00 
    6be0:	c7 85 1c e7 ff ff 10 	movl   $0x10,-0x18e4(%ebp)
    6be7:	00 00 00 
    6bea:	c7 85 20 e7 ff ff 00 	movl   $0x0,-0x18e0(%ebp)
    6bf1:	00 00 00 
    6bf4:	c7 85 24 e7 ff ff 00 	movl   $0x0,-0x18dc(%ebp)
    6bfb:	00 00 00 
    6bfe:	c7 85 28 e7 ff ff ff 	movl   $0xffffffff,-0x18d8(%ebp)
    6c05:	ff ff ff 
    6c08:	c7 85 2c e7 ff ff 00 	movl   $0x0,-0x18d4(%ebp)
    6c0f:	00 00 00 
    6c12:	c7 85 30 e7 ff ff 00 	movl   $0x0,-0x18d0(%ebp)
    6c19:	00 00 00 
    6c1c:	8d 85 86 f2 ff ff    	lea    -0xd7a(%ebp),%eax
    6c22:	89 85 34 e7 ff ff    	mov    %eax,-0x18cc(%ebp)
    6c28:	c7 85 38 e7 ff ff ff 	movl   $0x1ff,-0x18c8(%ebp)
    6c2f:	01 00 00 
    6c32:	66 c7 85 3c e7 ff ff 	movw   $0x3631,-0x18c4(%ebp)
    6c39:	31 36 
    6c3b:	c6 85 3e e7 ff ff 00 	movb   $0x0,-0x18c2(%ebp)
    6c42:	c7 85 40 e7 ff ff 10 	movl   $0x10,-0x18c0(%ebp)
    6c49:	00 00 00 
    6c4c:	c7 85 44 e7 ff ff 10 	movl   $0x10,-0x18bc(%ebp)
    6c53:	00 00 00 
    6c56:	c7 85 48 e7 ff ff 01 	movl   $0x1,-0x18b8(%ebp)
    6c5d:	00 00 00 
    6c60:	c7 85 4c e7 ff ff 01 	movl   $0x1,-0x18b4(%ebp)
    6c67:	00 00 00 
    6c6a:	c7 85 50 e7 ff ff ff 	movl   $0xffffffff,-0x18b0(%ebp)
    6c71:	ff ff ff 
    6c74:	c7 85 54 e7 ff ff 00 	movl   $0x0,-0x18ac(%ebp)
    6c7b:	00 00 00 
    6c7e:	c7 85 58 e7 ff ff 00 	movl   $0x0,-0x18a8(%ebp)
    6c85:	00 00 00 
    6c88:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6c8e:	89 85 5c e7 ff ff    	mov    %eax,-0x18a4(%ebp)
    6c94:	c7 85 60 e7 ff ff ff 	movl   $0x1ff,-0x18a0(%ebp)
    6c9b:	01 00 00 
    6c9e:	66 c7 85 64 e7 ff ff 	movw   $0x3731,-0x189c(%ebp)
    6ca5:	31 37 
    6ca7:	c6 85 66 e7 ff ff 00 	movb   $0x0,-0x189a(%ebp)
    6cae:	c7 85 68 e7 ff ff 10 	movl   $0x10,-0x1898(%ebp)
    6cb5:	00 00 00 
    6cb8:	c7 85 6c e7 ff ff 10 	movl   $0x10,-0x1894(%ebp)
    6cbf:	00 00 00 
    6cc2:	c7 85 70 e7 ff ff 02 	movl   $0x2,-0x1890(%ebp)
    6cc9:	00 00 00 
    6ccc:	c7 85 74 e7 ff ff 03 	movl   $0x3,-0x188c(%ebp)
    6cd3:	00 00 00 
    6cd6:	c7 85 78 e7 ff ff 10 	movl   $0x10,-0x1888(%ebp)
    6cdd:	00 00 00 
    6ce0:	c7 85 7c e7 ff ff 00 	movl   $0x0,-0x1884(%ebp)
    6ce7:	00 00 00 
    6cea:	c7 85 80 e7 ff ff 00 	movl   $0x0,-0x1880(%ebp)
    6cf1:	00 00 00 
    6cf4:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6cfa:	89 85 84 e7 ff ff    	mov    %eax,-0x187c(%ebp)
    6d00:	c7 85 88 e7 ff ff ff 	movl   $0x1ff,-0x1878(%ebp)
    6d07:	01 00 00 
    6d0a:	66 c7 85 8c e7 ff ff 	movw   $0x3831,-0x1874(%ebp)
    6d11:	31 38 
    6d13:	c6 85 8e e7 ff ff 00 	movb   $0x0,-0x1872(%ebp)
    6d1a:	c7 85 90 e7 ff ff 10 	movl   $0x10,-0x1870(%ebp)
    6d21:	00 00 00 
    6d24:	c7 85 94 e7 ff ff 10 	movl   $0x10,-0x186c(%ebp)
    6d2b:	00 00 00 
    6d2e:	c7 85 98 e7 ff ff 03 	movl   $0x3,-0x1868(%ebp)
    6d35:	00 00 00 
    6d38:	c7 85 9c e7 ff ff 07 	movl   $0x7,-0x1864(%ebp)
    6d3f:	00 00 00 
    6d42:	c7 85 a0 e7 ff ff 10 	movl   $0x10,-0x1860(%ebp)
    6d49:	00 00 00 
    6d4c:	c7 85 a4 e7 ff ff 00 	movl   $0x0,-0x185c(%ebp)
    6d53:	00 00 00 
    6d56:	c7 85 a8 e7 ff ff 00 	movl   $0x0,-0x1858(%ebp)
    6d5d:	00 00 00 
    6d60:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6d66:	89 85 ac e7 ff ff    	mov    %eax,-0x1854(%ebp)
    6d6c:	c7 85 b0 e7 ff ff ff 	movl   $0x1ff,-0x1850(%ebp)
    6d73:	01 00 00 
    6d76:	66 c7 85 b4 e7 ff ff 	movw   $0x3931,-0x184c(%ebp)
    6d7d:	31 39 
    6d7f:	c6 85 b6 e7 ff ff 00 	movb   $0x0,-0x184a(%ebp)
    6d86:	c7 85 b8 e7 ff ff 10 	movl   $0x10,-0x1848(%ebp)
    6d8d:	00 00 00 
    6d90:	c7 85 bc e7 ff ff 10 	movl   $0x10,-0x1844(%ebp)
    6d97:	00 00 00 
    6d9a:	c7 85 c0 e7 ff ff 04 	movl   $0x4,-0x1840(%ebp)
    6da1:	00 00 00 
    6da4:	c7 85 c4 e7 ff ff 0f 	movl   $0xf,-0x183c(%ebp)
    6dab:	00 00 00 
    6dae:	c7 85 c8 e7 ff ff 10 	movl   $0x10,-0x1838(%ebp)
    6db5:	00 00 00 
    6db8:	c7 85 cc e7 ff ff 00 	movl   $0x0,-0x1834(%ebp)
    6dbf:	00 00 00 
    6dc2:	c7 85 d0 e7 ff ff 00 	movl   $0x0,-0x1830(%ebp)
    6dc9:	00 00 00 
    6dcc:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6dd2:	89 85 d4 e7 ff ff    	mov    %eax,-0x182c(%ebp)
    6dd8:	c7 85 d8 e7 ff ff ff 	movl   $0x1ff,-0x1828(%ebp)
    6ddf:	01 00 00 
    6de2:	66 c7 85 dc e7 ff ff 	movw   $0x3032,-0x1824(%ebp)
    6de9:	32 30 
    6deb:	c6 85 de e7 ff ff 00 	movb   $0x0,-0x1822(%ebp)
    6df2:	c7 85 e0 e7 ff ff 10 	movl   $0x10,-0x1820(%ebp)
    6df9:	00 00 00 
    6dfc:	c7 85 e4 e7 ff ff 10 	movl   $0x10,-0x181c(%ebp)
    6e03:	00 00 00 
    6e06:	c7 85 e8 e7 ff ff 06 	movl   $0x6,-0x1818(%ebp)
    6e0d:	00 00 00 
    6e10:	c7 85 ec e7 ff ff 3f 	movl   $0x3f,-0x1814(%ebp)
    6e17:	00 00 00 
    6e1a:	c7 85 f0 e7 ff ff 10 	movl   $0x10,-0x1810(%ebp)
    6e21:	00 00 00 
    6e24:	c7 85 f4 e7 ff ff 00 	movl   $0x0,-0x180c(%ebp)
    6e2b:	00 00 00 
    6e2e:	c7 85 f8 e7 ff ff 00 	movl   $0x0,-0x1808(%ebp)
    6e35:	00 00 00 
    6e38:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6e3e:	89 85 fc e7 ff ff    	mov    %eax,-0x1804(%ebp)
    6e44:	c7 85 00 e8 ff ff ff 	movl   $0x1ff,-0x1800(%ebp)
    6e4b:	01 00 00 
    6e4e:	66 c7 85 04 e8 ff ff 	movw   $0x3132,-0x17fc(%ebp)
    6e55:	32 31 
    6e57:	c6 85 06 e8 ff ff 00 	movb   $0x0,-0x17fa(%ebp)
    6e5e:	c7 85 08 e8 ff ff 10 	movl   $0x10,-0x17f8(%ebp)
    6e65:	00 00 00 
    6e68:	c7 85 0c e8 ff ff 10 	movl   $0x10,-0x17f4(%ebp)
    6e6f:	00 00 00 
    6e72:	c7 85 10 e8 ff ff 08 	movl   $0x8,-0x17f0(%ebp)
    6e79:	00 00 00 
    6e7c:	c7 85 14 e8 ff ff ff 	movl   $0xff,-0x17ec(%ebp)
    6e83:	00 00 00 
    6e86:	c7 85 18 e8 ff ff 10 	movl   $0x10,-0x17e8(%ebp)
    6e8d:	00 00 00 
    6e90:	c7 85 1c e8 ff ff 00 	movl   $0x0,-0x17e4(%ebp)
    6e97:	00 00 00 
    6e9a:	c7 85 20 e8 ff ff 00 	movl   $0x0,-0x17e0(%ebp)
    6ea1:	00 00 00 
    6ea4:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6eaa:	89 85 24 e8 ff ff    	mov    %eax,-0x17dc(%ebp)
    6eb0:	c7 85 28 e8 ff ff ff 	movl   $0x1ff,-0x17d8(%ebp)
    6eb7:	01 00 00 
    6eba:	66 c7 85 2c e8 ff ff 	movw   $0x3232,-0x17d4(%ebp)
    6ec1:	32 32 
    6ec3:	c6 85 2e e8 ff ff 00 	movb   $0x0,-0x17d2(%ebp)
    6eca:	c7 85 30 e8 ff ff 10 	movl   $0x10,-0x17d0(%ebp)
    6ed1:	00 00 00 
    6ed4:	c7 85 34 e8 ff ff 10 	movl   $0x10,-0x17cc(%ebp)
    6edb:	00 00 00 
    6ede:	c7 85 38 e8 ff ff 0a 	movl   $0xa,-0x17c8(%ebp)
    6ee5:	00 00 00 
    6ee8:	c7 85 3c e8 ff ff ff 	movl   $0x3ff,-0x17c4(%ebp)
    6eef:	03 00 00 
    6ef2:	c7 85 40 e8 ff ff 10 	movl   $0x10,-0x17c0(%ebp)
    6ef9:	00 00 00 
    6efc:	c7 85 44 e8 ff ff 00 	movl   $0x0,-0x17bc(%ebp)
    6f03:	00 00 00 
    6f06:	c7 85 48 e8 ff ff 00 	movl   $0x0,-0x17b8(%ebp)
    6f0d:	00 00 00 
    6f10:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6f16:	89 85 4c e8 ff ff    	mov    %eax,-0x17b4(%ebp)
    6f1c:	c7 85 50 e8 ff ff ff 	movl   $0x1ff,-0x17b0(%ebp)
    6f23:	01 00 00 
    6f26:	66 c7 85 54 e8 ff ff 	movw   $0x3332,-0x17ac(%ebp)
    6f2d:	32 33 
    6f2f:	c6 85 56 e8 ff ff 00 	movb   $0x0,-0x17aa(%ebp)
    6f36:	c7 85 58 e8 ff ff 10 	movl   $0x10,-0x17a8(%ebp)
    6f3d:	00 00 00 
    6f40:	c7 85 5c e8 ff ff 10 	movl   $0x10,-0x17a4(%ebp)
    6f47:	00 00 00 
    6f4a:	c7 85 60 e8 ff ff 0d 	movl   $0xd,-0x17a0(%ebp)
    6f51:	00 00 00 
    6f54:	c7 85 64 e8 ff ff ff 	movl   $0x1fff,-0x179c(%ebp)
    6f5b:	1f 00 00 
    6f5e:	c7 85 68 e8 ff ff 10 	movl   $0x10,-0x1798(%ebp)
    6f65:	00 00 00 
    6f68:	c7 85 6c e8 ff ff 00 	movl   $0x0,-0x1794(%ebp)
    6f6f:	00 00 00 
    6f72:	c7 85 70 e8 ff ff 00 	movl   $0x0,-0x1790(%ebp)
    6f79:	00 00 00 
    6f7c:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    6f82:	89 85 74 e8 ff ff    	mov    %eax,-0x178c(%ebp)
    6f88:	c7 85 78 e8 ff ff ff 	movl   $0x1ff,-0x1788(%ebp)
    6f8f:	01 00 00 
    6f92:	66 c7 85 7c e8 ff ff 	movw   $0x3432,-0x1784(%ebp)
    6f99:	32 34 
    6f9b:	c6 85 7e e8 ff ff 00 	movb   $0x0,-0x1782(%ebp)
    6fa2:	c7 85 80 e8 ff ff 10 	movl   $0x10,-0x1780(%ebp)
    6fa9:	00 00 00 
    6fac:	c7 85 84 e8 ff ff 10 	movl   $0x10,-0x177c(%ebp)
    6fb3:	00 00 00 
    6fb6:	c7 85 88 e8 ff ff 04 	movl   $0x4,-0x1778(%ebp)
    6fbd:	00 00 00 
    6fc0:	c7 85 8c e8 ff ff 0f 	movl   $0xf,-0x1774(%ebp)
    6fc7:	00 00 00 
    6fca:	c7 85 90 e8 ff ff ff 	movl   $0xffffffff,-0x1770(%ebp)
    6fd1:	ff ff ff 
    6fd4:	c7 85 94 e8 ff ff 00 	movl   $0x0,-0x176c(%ebp)
    6fdb:	00 00 00 
    6fde:	c7 85 98 e8 ff ff 00 	movl   $0x0,-0x1768(%ebp)
    6fe5:	00 00 00 
    6fe8:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    6fee:	89 85 9c e8 ff ff    	mov    %eax,-0x1764(%ebp)
    6ff4:	c7 85 a0 e8 ff ff 00 	movl   $0x200,-0x1760(%ebp)
    6ffb:	02 00 00 
    6ffe:	66 c7 85 a4 e8 ff ff 	movw   $0x3532,-0x175c(%ebp)
    7005:	32 35 
    7007:	c6 85 a6 e8 ff ff 00 	movb   $0x0,-0x175a(%ebp)
    700e:	c7 85 a8 e8 ff ff 10 	movl   $0x10,-0x1758(%ebp)
    7015:	00 00 00 
    7018:	c7 85 ac e8 ff ff 10 	movl   $0x10,-0x1754(%ebp)
    701f:	00 00 00 
    7022:	c7 85 b0 e8 ff ff 05 	movl   $0x5,-0x1750(%ebp)
    7029:	00 00 00 
    702c:	c7 85 b4 e8 ff ff 1f 	movl   $0x1f,-0x174c(%ebp)
    7033:	00 00 00 
    7036:	c7 85 b8 e8 ff ff 18 	movl   $0x18,-0x1748(%ebp)
    703d:	00 00 00 
    7040:	c7 85 bc e8 ff ff 00 	movl   $0x0,-0x1744(%ebp)
    7047:	00 00 00 
    704a:	c7 85 c0 e8 ff ff 00 	movl   $0x0,-0x1740(%ebp)
    7051:	00 00 00 
    7054:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    705a:	89 85 c4 e8 ff ff    	mov    %eax,-0x173c(%ebp)
    7060:	c7 85 c8 e8 ff ff 00 	movl   $0x200,-0x1738(%ebp)
    7067:	02 00 00 
    706a:	66 c7 85 cc e8 ff ff 	movw   $0x3632,-0x1734(%ebp)
    7071:	32 36 
    7073:	c6 85 ce e8 ff ff 00 	movb   $0x0,-0x1732(%ebp)
    707a:	c7 85 d0 e8 ff ff 10 	movl   $0x10,-0x1730(%ebp)
    7081:	00 00 00 
    7084:	c7 85 d4 e8 ff ff 10 	movl   $0x10,-0x172c(%ebp)
    708b:	00 00 00 
    708e:	c7 85 d8 e8 ff ff 06 	movl   $0x6,-0x1728(%ebp)
    7095:	00 00 00 
    7098:	c7 85 dc e8 ff ff 3f 	movl   $0x3f,-0x1724(%ebp)
    709f:	00 00 00 
    70a2:	c7 85 e0 e8 ff ff 18 	movl   $0x18,-0x1720(%ebp)
    70a9:	00 00 00 
    70ac:	c7 85 e4 e8 ff ff 00 	movl   $0x0,-0x171c(%ebp)
    70b3:	00 00 00 
    70b6:	c7 85 e8 e8 ff ff 00 	movl   $0x0,-0x1718(%ebp)
    70bd:	00 00 00 
    70c0:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    70c6:	89 85 ec e8 ff ff    	mov    %eax,-0x1714(%ebp)
    70cc:	c7 85 f0 e8 ff ff 00 	movl   $0x200,-0x1710(%ebp)
    70d3:	02 00 00 
    70d6:	66 c7 85 f4 e8 ff ff 	movw   $0x3732,-0x170c(%ebp)
    70dd:	32 37 
    70df:	c6 85 f6 e8 ff ff 00 	movb   $0x0,-0x170a(%ebp)
    70e6:	c7 85 f8 e8 ff ff 10 	movl   $0x10,-0x1708(%ebp)
    70ed:	00 00 00 
    70f0:	c7 85 fc e8 ff ff 10 	movl   $0x10,-0x1704(%ebp)
    70f7:	00 00 00 
    70fa:	c7 85 00 e9 ff ff 07 	movl   $0x7,-0x1700(%ebp)
    7101:	00 00 00 
    7104:	c7 85 04 e9 ff ff 7f 	movl   $0x7f,-0x16fc(%ebp)
    710b:	00 00 00 
    710e:	c7 85 08 e9 ff ff 18 	movl   $0x18,-0x16f8(%ebp)
    7115:	00 00 00 
    7118:	c7 85 0c e9 ff ff 00 	movl   $0x0,-0x16f4(%ebp)
    711f:	00 00 00 
    7122:	c7 85 10 e9 ff ff 00 	movl   $0x0,-0x16f0(%ebp)
    7129:	00 00 00 
    712c:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    7132:	89 85 14 e9 ff ff    	mov    %eax,-0x16ec(%ebp)
    7138:	c7 85 18 e9 ff ff 00 	movl   $0x200,-0x16e8(%ebp)
    713f:	02 00 00 
    7142:	66 c7 85 1c e9 ff ff 	movw   $0x3832,-0x16e4(%ebp)
    7149:	32 38 
    714b:	c6 85 1e e9 ff ff 00 	movb   $0x0,-0x16e2(%ebp)
    7152:	c7 85 20 e9 ff ff 10 	movl   $0x10,-0x16e0(%ebp)
    7159:	00 00 00 
    715c:	c7 85 24 e9 ff ff 10 	movl   $0x10,-0x16dc(%ebp)
    7163:	00 00 00 
    7166:	c7 85 28 e9 ff ff 08 	movl   $0x8,-0x16d8(%ebp)
    716d:	00 00 00 
    7170:	c7 85 2c e9 ff ff ff 	movl   $0xff,-0x16d4(%ebp)
    7177:	00 00 00 
    717a:	c7 85 30 e9 ff ff 18 	movl   $0x18,-0x16d0(%ebp)
    7181:	00 00 00 
    7184:	c7 85 34 e9 ff ff 00 	movl   $0x0,-0x16cc(%ebp)
    718b:	00 00 00 
    718e:	c7 85 38 e9 ff ff 00 	movl   $0x0,-0x16c8(%ebp)
    7195:	00 00 00 
    7198:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    719e:	89 85 3c e9 ff ff    	mov    %eax,-0x16c4(%ebp)
    71a4:	c7 85 40 e9 ff ff 00 	movl   $0x200,-0x16c0(%ebp)
    71ab:	02 00 00 
    71ae:	66 c7 85 44 e9 ff ff 	movw   $0x3932,-0x16bc(%ebp)
    71b5:	32 39 
    71b7:	c6 85 46 e9 ff ff 00 	movb   $0x0,-0x16ba(%ebp)
    71be:	c7 85 48 e9 ff ff 10 	movl   $0x10,-0x16b8(%ebp)
    71c5:	00 00 00 
    71c8:	c7 85 4c e9 ff ff 10 	movl   $0x10,-0x16b4(%ebp)
    71cf:	00 00 00 
    71d2:	c7 85 50 e9 ff ff 09 	movl   $0x9,-0x16b0(%ebp)
    71d9:	00 00 00 
    71dc:	c7 85 54 e9 ff ff ff 	movl   $0x1ff,-0x16ac(%ebp)
    71e3:	01 00 00 
    71e6:	c7 85 58 e9 ff ff 18 	movl   $0x18,-0x16a8(%ebp)
    71ed:	00 00 00 
    71f0:	c7 85 5c e9 ff ff 00 	movl   $0x0,-0x16a4(%ebp)
    71f7:	00 00 00 
    71fa:	c7 85 60 e9 ff ff 00 	movl   $0x0,-0x16a0(%ebp)
    7201:	00 00 00 
    7204:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    720a:	89 85 64 e9 ff ff    	mov    %eax,-0x169c(%ebp)
    7210:	c7 85 68 e9 ff ff 00 	movl   $0x200,-0x1698(%ebp)
    7217:	02 00 00 
    721a:	66 c7 85 6c e9 ff ff 	movw   $0x3033,-0x1694(%ebp)
    7221:	33 30 
    7223:	c6 85 6e e9 ff ff 00 	movb   $0x0,-0x1692(%ebp)
    722a:	c7 85 70 e9 ff ff 10 	movl   $0x10,-0x1690(%ebp)
    7231:	00 00 00 
    7234:	c7 85 74 e9 ff ff 10 	movl   $0x10,-0x168c(%ebp)
    723b:	00 00 00 
    723e:	c7 85 78 e9 ff ff 0b 	movl   $0xb,-0x1688(%ebp)
    7245:	00 00 00 
    7248:	c7 85 7c e9 ff ff ff 	movl   $0x7ff,-0x1684(%ebp)
    724f:	07 00 00 
    7252:	c7 85 80 e9 ff ff 18 	movl   $0x18,-0x1680(%ebp)
    7259:	00 00 00 
    725c:	c7 85 84 e9 ff ff 00 	movl   $0x0,-0x167c(%ebp)
    7263:	00 00 00 
    7266:	c7 85 88 e9 ff ff 00 	movl   $0x0,-0x1678(%ebp)
    726d:	00 00 00 
    7270:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    7276:	89 85 8c e9 ff ff    	mov    %eax,-0x1674(%ebp)
    727c:	c7 85 90 e9 ff ff 00 	movl   $0x200,-0x1670(%ebp)
    7283:	02 00 00 
    7286:	66 c7 85 94 e9 ff ff 	movw   $0x3133,-0x166c(%ebp)
    728d:	33 31 
    728f:	c6 85 96 e9 ff ff 00 	movb   $0x0,-0x166a(%ebp)
    7296:	c7 85 98 e9 ff ff 10 	movl   $0x10,-0x1668(%ebp)
    729d:	00 00 00 
    72a0:	c7 85 9c e9 ff ff 10 	movl   $0x10,-0x1664(%ebp)
    72a7:	00 00 00 
    72aa:	c7 85 a0 e9 ff ff 0d 	movl   $0xd,-0x1660(%ebp)
    72b1:	00 00 00 
    72b4:	c7 85 a4 e9 ff ff ff 	movl   $0x1fff,-0x165c(%ebp)
    72bb:	1f 00 00 
    72be:	c7 85 a8 e9 ff ff 18 	movl   $0x18,-0x1658(%ebp)
    72c5:	00 00 00 
    72c8:	c7 85 ac e9 ff ff 00 	movl   $0x0,-0x1654(%ebp)
    72cf:	00 00 00 
    72d2:	c7 85 b0 e9 ff ff 00 	movl   $0x0,-0x1650(%ebp)
    72d9:	00 00 00 
    72dc:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    72e2:	89 85 b4 e9 ff ff    	mov    %eax,-0x164c(%ebp)
    72e8:	c7 85 b8 e9 ff ff 00 	movl   $0x200,-0x1648(%ebp)
    72ef:	02 00 00 
    72f2:	66 c7 85 bc e9 ff ff 	movw   $0x3233,-0x1644(%ebp)
    72f9:	33 32 
    72fb:	c6 85 be e9 ff ff 00 	movb   $0x0,-0x1642(%ebp)
    7302:	c7 85 c0 e9 ff ff 01 	movl   $0x1,-0x1640(%ebp)
    7309:	00 00 00 
    730c:	c7 85 c4 e9 ff ff 10 	movl   $0x10,-0x163c(%ebp)
    7313:	00 00 00 
    7316:	c7 85 c8 e9 ff ff 00 	movl   $0x0,-0x1638(%ebp)
    731d:	00 00 00 
    7320:	c7 85 cc e9 ff ff 00 	movl   $0x0,-0x1634(%ebp)
    7327:	00 00 00 
    732a:	c7 85 d0 e9 ff ff ff 	movl   $0xffffffff,-0x1630(%ebp)
    7331:	ff ff ff 
    7334:	c7 85 d4 e9 ff ff 00 	movl   $0x0,-0x162c(%ebp)
    733b:	00 00 00 
    733e:	c7 85 d8 e9 ff ff 00 	movl   $0x0,-0x1628(%ebp)
    7345:	00 00 00 
    7348:	8d 85 4a ea ff ff    	lea    -0x15b6(%ebp),%eax
    734e:	89 85 dc e9 ff ff    	mov    %eax,-0x1624(%ebp)
    7354:	c7 85 e0 e9 ff ff 1f 	movl   $0x1f,-0x1620(%ebp)
    735b:	00 00 00 
    735e:	66 c7 85 e4 e9 ff ff 	movw   $0x3333,-0x161c(%ebp)
    7365:	33 33 
    7367:	c6 85 e6 e9 ff ff 00 	movb   $0x0,-0x161a(%ebp)
    736e:	c7 85 e8 e9 ff ff 01 	movl   $0x1,-0x1618(%ebp)
    7375:	00 00 00 
    7378:	c7 85 ec e9 ff ff 10 	movl   $0x10,-0x1614(%ebp)
    737f:	00 00 00 
    7382:	c7 85 f0 e9 ff ff 00 	movl   $0x0,-0x1610(%ebp)
    7389:	00 00 00 
    738c:	c7 85 f4 e9 ff ff 00 	movl   $0x0,-0x160c(%ebp)
    7393:	00 00 00 
    7396:	c7 85 f8 e9 ff ff ff 	movl   $0xffffffff,-0x1608(%ebp)
    739d:	ff ff ff 
    73a0:	c7 85 fc e9 ff ff 00 	movl   $0x0,-0x1604(%ebp)
    73a7:	00 00 00 
    73aa:	c7 85 00 ea ff ff 00 	movl   $0x0,-0x1600(%ebp)
    73b1:	00 00 00 
    73b4:	8d 85 0c ea ff ff    	lea    -0x15f4(%ebp),%eax
    73ba:	89 85 04 ea ff ff    	mov    %eax,-0x15fc(%ebp)
    73c0:	c7 85 08 ea ff ff 1f 	movl   $0x1f,-0x15f8(%ebp)
    73c7:	00 00 00 
		{"31", 16, 16, 13, 8191, 24, 0, 0, h24, 512},
		{"32", 1, 16, 0, 0, -1, 0, 0, hA, 31},
		{"33", 1, 16, 0, 0, -1, 0, 0, hB, 31}
	};
	ht[0] = ht[0];
}
    73ca:	81 c4 40 1b 00 00    	add    $0x1b40,%esp
    73d0:	5b                   	pop    %ebx
    73d1:	5e                   	pop    %esi
    73d2:	5f                   	pop    %edi
    73d3:	5d                   	pop    %ebp
    73d4:	c3                   	ret    

000073d5 <huffman_decoder>:


/* ����huffman����	*/
/* ע��! ��counta,countb - 4 bit ֵ �� y����, discard x */
int huffman_decoder(struct huffcodetab *h, int *x, int *y, int *v, int *w)
{  
    73d5:	55                   	push   %ebp
    73d6:	89 e5                	mov    %esp,%ebp
    73d8:	53                   	push   %ebx
    73d9:	83 ec 24             	sub    $0x24,%esp
  HUFFBITS level;
  int point = 0;
    73dc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int error = 1;
    73e3:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
  level     = dmask;
    73ea:	a1 b0 f0 00 00       	mov    0xf0b0,%eax
    73ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (h->val == 0) return 2;
    73f2:	8b 45 08             	mov    0x8(%ebp),%eax
    73f5:	8b 40 20             	mov    0x20(%eax),%eax
    73f8:	85 c0                	test   %eax,%eax
    73fa:	75 0a                	jne    7406 <huffman_decoder+0x31>
    73fc:	b8 02 00 00 00       	mov    $0x2,%eax
    7401:	e9 0d 03 00 00       	jmp    7713 <huffman_decoder+0x33e>

  /* table 0 ����Ҫ bits */
  if ( h->treelen == 0)
    7406:	8b 45 08             	mov    0x8(%ebp),%eax
    7409:	8b 40 24             	mov    0x24(%eax),%eax
    740c:	85 c0                	test   %eax,%eax
    740e:	75 1d                	jne    742d <huffman_decoder+0x58>
  {  *x = *y = 0;
    7410:	8b 45 10             	mov    0x10(%ebp),%eax
    7413:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    7419:	8b 45 10             	mov    0x10(%ebp),%eax
    741c:	8b 10                	mov    (%eax),%edx
    741e:	8b 45 0c             	mov    0xc(%ebp),%eax
    7421:	89 10                	mov    %edx,(%eax)
     return 0;
    7423:	b8 00 00 00 00       	mov    $0x0,%eax
    7428:	e9 e6 02 00 00       	jmp    7713 <huffman_decoder+0x33e>


  /* ���� Huffman table. */

  do {
    if (h->val[point][0]==0) {   /*���Ľ�β*/
    742d:	8b 45 08             	mov    0x8(%ebp),%eax
    7430:	8b 40 20             	mov    0x20(%eax),%eax
    7433:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7436:	01 d2                	add    %edx,%edx
    7438:	01 d0                	add    %edx,%eax
    743a:	0f b6 00             	movzbl (%eax),%eax
    743d:	84 c0                	test   %al,%al
    743f:	75 46                	jne    7487 <huffman_decoder+0xb2>
      *x = h->val[point][1] >> 4;
    7441:	8b 45 08             	mov    0x8(%ebp),%eax
    7444:	8b 40 20             	mov    0x20(%eax),%eax
    7447:	8b 55 f0             	mov    -0x10(%ebp),%edx
    744a:	01 d2                	add    %edx,%edx
    744c:	01 d0                	add    %edx,%eax
    744e:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    7452:	c0 e8 04             	shr    $0x4,%al
    7455:	0f b6 d0             	movzbl %al,%edx
    7458:	8b 45 0c             	mov    0xc(%ebp),%eax
    745b:	89 10                	mov    %edx,(%eax)
      *y = h->val[point][1] & 0xf;
    745d:	8b 45 08             	mov    0x8(%ebp),%eax
    7460:	8b 40 20             	mov    0x20(%eax),%eax
    7463:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7466:	01 d2                	add    %edx,%edx
    7468:	01 d0                	add    %edx,%eax
    746a:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    746e:	0f b6 c0             	movzbl %al,%eax
    7471:	83 e0 0f             	and    $0xf,%eax
    7474:	89 c2                	mov    %eax,%edx
    7476:	8b 45 10             	mov    0x10(%ebp),%eax
    7479:	89 10                	mov    %edx,(%eax)

      error = 0;
    747b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
      break;
    7482:	e9 af 00 00 00       	jmp    7536 <huffman_decoder+0x161>
    } 
    if (hget1bit()) {
    7487:	e8 a7 e6 ff ff       	call   5b33 <hget1bit>
    748c:	85 c0                	test   %eax,%eax
    748e:	74 47                	je     74d7 <huffman_decoder+0x102>
      while (h->val[point][1] >= MXOFF) point += h->val[point][1]; 
    7490:	eb 17                	jmp    74a9 <huffman_decoder+0xd4>
    7492:	8b 45 08             	mov    0x8(%ebp),%eax
    7495:	8b 40 20             	mov    0x20(%eax),%eax
    7498:	8b 55 f0             	mov    -0x10(%ebp),%edx
    749b:	01 d2                	add    %edx,%edx
    749d:	01 d0                	add    %edx,%eax
    749f:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    74a3:	0f b6 c0             	movzbl %al,%eax
    74a6:	01 45 f0             	add    %eax,-0x10(%ebp)
    74a9:	8b 45 08             	mov    0x8(%ebp),%eax
    74ac:	8b 40 20             	mov    0x20(%eax),%eax
    74af:	8b 55 f0             	mov    -0x10(%ebp),%edx
    74b2:	01 d2                	add    %edx,%edx
    74b4:	01 d0                	add    %edx,%eax
    74b6:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    74ba:	3c f9                	cmp    $0xf9,%al
    74bc:	77 d4                	ja     7492 <huffman_decoder+0xbd>
      point += h->val[point][1];
    74be:	8b 45 08             	mov    0x8(%ebp),%eax
    74c1:	8b 40 20             	mov    0x20(%eax),%eax
    74c4:	8b 55 f0             	mov    -0x10(%ebp),%edx
    74c7:	01 d2                	add    %edx,%edx
    74c9:	01 d0                	add    %edx,%eax
    74cb:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    74cf:	0f b6 c0             	movzbl %al,%eax
    74d2:	01 45 f0             	add    %eax,-0x10(%ebp)
    74d5:	eb 42                	jmp    7519 <huffman_decoder+0x144>
    }
    else {
      while (h->val[point][0] >= MXOFF) point += h->val[point][0]; 
    74d7:	eb 16                	jmp    74ef <huffman_decoder+0x11a>
    74d9:	8b 45 08             	mov    0x8(%ebp),%eax
    74dc:	8b 40 20             	mov    0x20(%eax),%eax
    74df:	8b 55 f0             	mov    -0x10(%ebp),%edx
    74e2:	01 d2                	add    %edx,%edx
    74e4:	01 d0                	add    %edx,%eax
    74e6:	0f b6 00             	movzbl (%eax),%eax
    74e9:	0f b6 c0             	movzbl %al,%eax
    74ec:	01 45 f0             	add    %eax,-0x10(%ebp)
    74ef:	8b 45 08             	mov    0x8(%ebp),%eax
    74f2:	8b 40 20             	mov    0x20(%eax),%eax
    74f5:	8b 55 f0             	mov    -0x10(%ebp),%edx
    74f8:	01 d2                	add    %edx,%edx
    74fa:	01 d0                	add    %edx,%eax
    74fc:	0f b6 00             	movzbl (%eax),%eax
    74ff:	3c f9                	cmp    $0xf9,%al
    7501:	77 d6                	ja     74d9 <huffman_decoder+0x104>
      point += h->val[point][0];
    7503:	8b 45 08             	mov    0x8(%ebp),%eax
    7506:	8b 40 20             	mov    0x20(%eax),%eax
    7509:	8b 55 f0             	mov    -0x10(%ebp),%edx
    750c:	01 d2                	add    %edx,%edx
    750e:	01 d0                	add    %edx,%eax
    7510:	0f b6 00             	movzbl (%eax),%eax
    7513:	0f b6 c0             	movzbl %al,%eax
    7516:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    level >>= 1;
    7519:	d1 6d f4             	shrl   -0xc(%ebp)
  } while (level  || (point < ht->treelen) );
    751c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    7520:	0f 85 07 ff ff ff    	jne    742d <huffman_decoder+0x58>
    7526:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7529:	a1 24 26 01 00       	mov    0x12624,%eax
    752e:	39 c2                	cmp    %eax,%edx
    7530:	0f 82 f7 fe ff ff    	jb     742d <huffman_decoder+0x58>
  
  /* ������ */
  
  if (error) { /* ���� x �� y Ϊһ�м�ֵ */
    7536:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    753a:	74 24                	je     7560 <huffman_decoder+0x18b>
    //print(0, "Illegal Huffman code in data.\n");
    *x = ((h->xlen-1) << 1);
    753c:	8b 45 08             	mov    0x8(%ebp),%eax
    753f:	8b 40 04             	mov    0x4(%eax),%eax
    7542:	83 e8 01             	sub    $0x1,%eax
    7545:	01 c0                	add    %eax,%eax
    7547:	89 c2                	mov    %eax,%edx
    7549:	8b 45 0c             	mov    0xc(%ebp),%eax
    754c:	89 10                	mov    %edx,(%eax)
    *y = ((h->ylen-1) << 1);
    754e:	8b 45 08             	mov    0x8(%ebp),%eax
    7551:	8b 40 08             	mov    0x8(%eax),%eax
    7554:	83 e8 01             	sub    $0x1,%eax
    7557:	01 c0                	add    %eax,%eax
    7559:	89 c2                	mov    %eax,%edx
    755b:	8b 45 10             	mov    0x10(%ebp),%eax
    755e:	89 10                	mov    %edx,(%eax)
  }

  /* �����źű��� */

  if (h->tablename[0] == '3'
    7560:	8b 45 08             	mov    0x8(%ebp),%eax
    7563:	0f b6 00             	movzbl (%eax),%eax
    7566:	3c 33                	cmp    $0x33,%al
    7568:	0f 85 ec 00 00 00    	jne    765a <huffman_decoder+0x285>
      && (h->tablename[1] == '2' || h->tablename[1] == '3')) {
    756e:	8b 45 08             	mov    0x8(%ebp),%eax
    7571:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    7575:	3c 32                	cmp    $0x32,%al
    7577:	74 0f                	je     7588 <huffman_decoder+0x1b3>
    7579:	8b 45 08             	mov    0x8(%ebp),%eax
    757c:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    7580:	3c 33                	cmp    $0x33,%al
    7582:	0f 85 d2 00 00 00    	jne    765a <huffman_decoder+0x285>
     *v = (*y>>3) & 1;
    7588:	8b 45 10             	mov    0x10(%ebp),%eax
    758b:	8b 00                	mov    (%eax),%eax
    758d:	c1 f8 03             	sar    $0x3,%eax
    7590:	83 e0 01             	and    $0x1,%eax
    7593:	89 c2                	mov    %eax,%edx
    7595:	8b 45 14             	mov    0x14(%ebp),%eax
    7598:	89 10                	mov    %edx,(%eax)
     *w = (*y>>2) & 1;
    759a:	8b 45 10             	mov    0x10(%ebp),%eax
    759d:	8b 00                	mov    (%eax),%eax
    759f:	c1 f8 02             	sar    $0x2,%eax
    75a2:	83 e0 01             	and    $0x1,%eax
    75a5:	89 c2                	mov    %eax,%edx
    75a7:	8b 45 18             	mov    0x18(%ebp),%eax
    75aa:	89 10                	mov    %edx,(%eax)
     *x = (*y>>1) & 1;
    75ac:	8b 45 10             	mov    0x10(%ebp),%eax
    75af:	8b 00                	mov    (%eax),%eax
    75b1:	d1 f8                	sar    %eax
    75b3:	83 e0 01             	and    $0x1,%eax
    75b6:	89 c2                	mov    %eax,%edx
    75b8:	8b 45 0c             	mov    0xc(%ebp),%eax
    75bb:	89 10                	mov    %edx,(%eax)
     *y = *y & 1;
    75bd:	8b 45 10             	mov    0x10(%ebp),%eax
    75c0:	8b 00                	mov    (%eax),%eax
    75c2:	83 e0 01             	and    $0x1,%eax
    75c5:	89 c2                	mov    %eax,%edx
    75c7:	8b 45 10             	mov    0x10(%ebp),%eax
    75ca:	89 10                	mov    %edx,(%eax)
     /* v, w, x �� y �ڱ��������ǵߵ��ģ��������� 
         */
     
/*   {int i=*v; *v=*y; *y=i; i=*w; *w=*x; *x=i;}  MI */

     if (*v)
    75cc:	8b 45 14             	mov    0x14(%ebp),%eax
    75cf:	8b 00                	mov    (%eax),%eax
    75d1:	85 c0                	test   %eax,%eax
    75d3:	74 18                	je     75ed <huffman_decoder+0x218>
        if (hget1bit() == 1) *v = -*v;
    75d5:	e8 59 e5 ff ff       	call   5b33 <hget1bit>
    75da:	83 f8 01             	cmp    $0x1,%eax
    75dd:	75 0e                	jne    75ed <huffman_decoder+0x218>
    75df:	8b 45 14             	mov    0x14(%ebp),%eax
    75e2:	8b 00                	mov    (%eax),%eax
    75e4:	f7 d8                	neg    %eax
    75e6:	89 c2                	mov    %eax,%edx
    75e8:	8b 45 14             	mov    0x14(%ebp),%eax
    75eb:	89 10                	mov    %edx,(%eax)
     if (*w)
    75ed:	8b 45 18             	mov    0x18(%ebp),%eax
    75f0:	8b 00                	mov    (%eax),%eax
    75f2:	85 c0                	test   %eax,%eax
    75f4:	74 18                	je     760e <huffman_decoder+0x239>
        if (hget1bit() == 1) *w = -*w;
    75f6:	e8 38 e5 ff ff       	call   5b33 <hget1bit>
    75fb:	83 f8 01             	cmp    $0x1,%eax
    75fe:	75 0e                	jne    760e <huffman_decoder+0x239>
    7600:	8b 45 18             	mov    0x18(%ebp),%eax
    7603:	8b 00                	mov    (%eax),%eax
    7605:	f7 d8                	neg    %eax
    7607:	89 c2                	mov    %eax,%edx
    7609:	8b 45 18             	mov    0x18(%ebp),%eax
    760c:	89 10                	mov    %edx,(%eax)
     if (*x)
    760e:	8b 45 0c             	mov    0xc(%ebp),%eax
    7611:	8b 00                	mov    (%eax),%eax
    7613:	85 c0                	test   %eax,%eax
    7615:	74 18                	je     762f <huffman_decoder+0x25a>
        if (hget1bit() == 1) *x = -*x;
    7617:	e8 17 e5 ff ff       	call   5b33 <hget1bit>
    761c:	83 f8 01             	cmp    $0x1,%eax
    761f:	75 0e                	jne    762f <huffman_decoder+0x25a>
    7621:	8b 45 0c             	mov    0xc(%ebp),%eax
    7624:	8b 00                	mov    (%eax),%eax
    7626:	f7 d8                	neg    %eax
    7628:	89 c2                	mov    %eax,%edx
    762a:	8b 45 0c             	mov    0xc(%ebp),%eax
    762d:	89 10                	mov    %edx,(%eax)
     if (*y)
    762f:	8b 45 10             	mov    0x10(%ebp),%eax
    7632:	8b 00                	mov    (%eax),%eax
    7634:	85 c0                	test   %eax,%eax
    7636:	74 1d                	je     7655 <huffman_decoder+0x280>
        if (hget1bit() == 1) *y = -*y;
    7638:	e8 f6 e4 ff ff       	call   5b33 <hget1bit>
    763d:	83 f8 01             	cmp    $0x1,%eax
    7640:	75 13                	jne    7655 <huffman_decoder+0x280>
    7642:	8b 45 10             	mov    0x10(%ebp),%eax
    7645:	8b 00                	mov    (%eax),%eax
    7647:	f7 d8                	neg    %eax
    7649:	89 c2                	mov    %eax,%edx
    764b:	8b 45 10             	mov    0x10(%ebp),%eax
    764e:	89 10                	mov    %edx,(%eax)
        if (hget1bit() == 1) *v = -*v;
     if (*w)
        if (hget1bit() == 1) *w = -*w;
     if (*x)
        if (hget1bit() == 1) *x = -*x;
     if (*y)
    7650:	e9 bb 00 00 00       	jmp    7710 <huffman_decoder+0x33b>
    7655:	e9 b6 00 00 00       	jmp    7710 <huffman_decoder+0x33b>
  else {
  
      /* �ڲ��Ա�������x �� y�ǵߵ��� 
         ����ߵ� x �� y ʹ���Ա��������� */
    
     if (h->linbits)
    765a:	8b 45 08             	mov    0x8(%ebp),%eax
    765d:	8b 40 0c             	mov    0xc(%eax),%eax
    7660:	85 c0                	test   %eax,%eax
    7662:	74 30                	je     7694 <huffman_decoder+0x2bf>
       if ((h->xlen-1) == *x) 
    7664:	8b 45 08             	mov    0x8(%ebp),%eax
    7667:	8b 40 04             	mov    0x4(%eax),%eax
    766a:	8d 50 ff             	lea    -0x1(%eax),%edx
    766d:	8b 45 0c             	mov    0xc(%ebp),%eax
    7670:	8b 00                	mov    (%eax),%eax
    7672:	39 c2                	cmp    %eax,%edx
    7674:	75 1e                	jne    7694 <huffman_decoder+0x2bf>
         *x += hgetbits(h->linbits);
    7676:	8b 45 0c             	mov    0xc(%ebp),%eax
    7679:	8b 00                	mov    (%eax),%eax
    767b:	89 c3                	mov    %eax,%ebx
    767d:	8b 45 08             	mov    0x8(%ebp),%eax
    7680:	8b 40 0c             	mov    0xc(%eax),%eax
    7683:	89 04 24             	mov    %eax,(%esp)
    7686:	e8 8d e4 ff ff       	call   5b18 <hgetbits>
    768b:	01 d8                	add    %ebx,%eax
    768d:	89 c2                	mov    %eax,%edx
    768f:	8b 45 0c             	mov    0xc(%ebp),%eax
    7692:	89 10                	mov    %edx,(%eax)
     if (*x)
    7694:	8b 45 0c             	mov    0xc(%ebp),%eax
    7697:	8b 00                	mov    (%eax),%eax
    7699:	85 c0                	test   %eax,%eax
    769b:	74 18                	je     76b5 <huffman_decoder+0x2e0>
        if (hget1bit() == 1) *x = -*x;
    769d:	e8 91 e4 ff ff       	call   5b33 <hget1bit>
    76a2:	83 f8 01             	cmp    $0x1,%eax
    76a5:	75 0e                	jne    76b5 <huffman_decoder+0x2e0>
    76a7:	8b 45 0c             	mov    0xc(%ebp),%eax
    76aa:	8b 00                	mov    (%eax),%eax
    76ac:	f7 d8                	neg    %eax
    76ae:	89 c2                	mov    %eax,%edx
    76b0:	8b 45 0c             	mov    0xc(%ebp),%eax
    76b3:	89 10                	mov    %edx,(%eax)
     if (h->linbits)	  
    76b5:	8b 45 08             	mov    0x8(%ebp),%eax
    76b8:	8b 40 0c             	mov    0xc(%eax),%eax
    76bb:	85 c0                	test   %eax,%eax
    76bd:	74 30                	je     76ef <huffman_decoder+0x31a>
       if ((h->ylen-1) == *y)
    76bf:	8b 45 08             	mov    0x8(%ebp),%eax
    76c2:	8b 40 08             	mov    0x8(%eax),%eax
    76c5:	8d 50 ff             	lea    -0x1(%eax),%edx
    76c8:	8b 45 10             	mov    0x10(%ebp),%eax
    76cb:	8b 00                	mov    (%eax),%eax
    76cd:	39 c2                	cmp    %eax,%edx
    76cf:	75 1e                	jne    76ef <huffman_decoder+0x31a>
         *y += hgetbits(h->linbits);
    76d1:	8b 45 10             	mov    0x10(%ebp),%eax
    76d4:	8b 00                	mov    (%eax),%eax
    76d6:	89 c3                	mov    %eax,%ebx
    76d8:	8b 45 08             	mov    0x8(%ebp),%eax
    76db:	8b 40 0c             	mov    0xc(%eax),%eax
    76de:	89 04 24             	mov    %eax,(%esp)
    76e1:	e8 32 e4 ff ff       	call   5b18 <hgetbits>
    76e6:	01 d8                	add    %ebx,%eax
    76e8:	89 c2                	mov    %eax,%edx
    76ea:	8b 45 10             	mov    0x10(%ebp),%eax
    76ed:	89 10                	mov    %edx,(%eax)
     if (*y)
    76ef:	8b 45 10             	mov    0x10(%ebp),%eax
    76f2:	8b 00                	mov    (%eax),%eax
    76f4:	85 c0                	test   %eax,%eax
    76f6:	74 18                	je     7710 <huffman_decoder+0x33b>
        if (hget1bit() == 1) *y = -*y;
    76f8:	e8 36 e4 ff ff       	call   5b33 <hget1bit>
    76fd:	83 f8 01             	cmp    $0x1,%eax
    7700:	75 0e                	jne    7710 <huffman_decoder+0x33b>
    7702:	8b 45 10             	mov    0x10(%ebp),%eax
    7705:	8b 00                	mov    (%eax),%eax
    7707:	f7 d8                	neg    %eax
    7709:	89 c2                	mov    %eax,%edx
    770b:	8b 45 10             	mov    0x10(%ebp),%eax
    770e:	89 10                	mov    %edx,(%eax)
     }
	  
  return error;  
    7710:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
    7713:	83 c4 24             	add    $0x24,%esp
    7716:	5b                   	pop    %ebx
    7717:	5d                   	pop    %ebp
    7718:	c3                   	ret    

00007719 <decode_info>:
#include "common.h"
#include "decode.h"
#include "huffman.h"

void decode_info(Bit_stream_struc *bs, struct frame_params *fr_ps)
{
    7719:	55                   	push   %ebp
    771a:	89 e5                	mov    %esp,%ebp
    771c:	83 ec 28             	sub    $0x28,%esp
    layer *hdr = fr_ps->header;
    771f:	8b 45 0c             	mov    0xc(%ebp),%eax
    7722:	8b 00                	mov    (%eax),%eax
    7724:	89 45 f4             	mov    %eax,-0xc(%ebp)

    hdr->version = get1bit(bs);
    7727:	8b 45 08             	mov    0x8(%ebp),%eax
    772a:	89 04 24             	mov    %eax,(%esp)
    772d:	e8 6c df ff ff       	call   569e <get1bit>
    7732:	89 c2                	mov    %eax,%edx
    7734:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7737:	89 10                	mov    %edx,(%eax)
    hdr->lay = 4-getbits(bs,2);
    7739:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7740:	00 
    7741:	8b 45 08             	mov    0x8(%ebp),%eax
    7744:	89 04 24             	mov    %eax,(%esp)
    7747:	e8 64 e0 ff ff       	call   57b0 <getbits>
    774c:	ba 04 00 00 00       	mov    $0x4,%edx
    7751:	29 c2                	sub    %eax,%edx
    7753:	89 d0                	mov    %edx,%eax
    7755:	89 c2                	mov    %eax,%edx
    7757:	8b 45 f4             	mov    -0xc(%ebp),%eax
    775a:	89 50 04             	mov    %edx,0x4(%eax)
    hdr->error_protection = !get1bit(bs); /* ���󱣻�. TRUE/FALSE */
    775d:	8b 45 08             	mov    0x8(%ebp),%eax
    7760:	89 04 24             	mov    %eax,(%esp)
    7763:	e8 36 df ff ff       	call   569e <get1bit>
    7768:	85 c0                	test   %eax,%eax
    776a:	0f 94 c0             	sete   %al
    776d:	0f b6 d0             	movzbl %al,%edx
    7770:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7773:	89 50 08             	mov    %edx,0x8(%eax)
    hdr->bitrate_index = getbits(bs,4);
    7776:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
    777d:	00 
    777e:	8b 45 08             	mov    0x8(%ebp),%eax
    7781:	89 04 24             	mov    %eax,(%esp)
    7784:	e8 27 e0 ff ff       	call   57b0 <getbits>
    7789:	89 c2                	mov    %eax,%edx
    778b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    778e:	89 50 0c             	mov    %edx,0xc(%eax)
    hdr->sampling_frequency = getbits(bs,2);
    7791:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7798:	00 
    7799:	8b 45 08             	mov    0x8(%ebp),%eax
    779c:	89 04 24             	mov    %eax,(%esp)
    779f:	e8 0c e0 ff ff       	call   57b0 <getbits>
    77a4:	89 c2                	mov    %eax,%edx
    77a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    77a9:	89 50 10             	mov    %edx,0x10(%eax)
    hdr->padding = get1bit(bs);
    77ac:	8b 45 08             	mov    0x8(%ebp),%eax
    77af:	89 04 24             	mov    %eax,(%esp)
    77b2:	e8 e7 de ff ff       	call   569e <get1bit>
    77b7:	89 c2                	mov    %eax,%edx
    77b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    77bc:	89 50 14             	mov    %edx,0x14(%eax)
    hdr->extension = get1bit(bs);
    77bf:	8b 45 08             	mov    0x8(%ebp),%eax
    77c2:	89 04 24             	mov    %eax,(%esp)
    77c5:	e8 d4 de ff ff       	call   569e <get1bit>
    77ca:	89 c2                	mov    %eax,%edx
    77cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    77cf:	89 50 18             	mov    %edx,0x18(%eax)
    hdr->mode = getbits(bs,2);
    77d2:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    77d9:	00 
    77da:	8b 45 08             	mov    0x8(%ebp),%eax
    77dd:	89 04 24             	mov    %eax,(%esp)
    77e0:	e8 cb df ff ff       	call   57b0 <getbits>
    77e5:	89 c2                	mov    %eax,%edx
    77e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    77ea:	89 50 1c             	mov    %edx,0x1c(%eax)
    hdr->mode_ext = getbits(bs,2);
    77ed:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    77f4:	00 
    77f5:	8b 45 08             	mov    0x8(%ebp),%eax
    77f8:	89 04 24             	mov    %eax,(%esp)
    77fb:	e8 b0 df ff ff       	call   57b0 <getbits>
    7800:	89 c2                	mov    %eax,%edx
    7802:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7805:	89 50 20             	mov    %edx,0x20(%eax)
    hdr->copyright = get1bit(bs);
    7808:	8b 45 08             	mov    0x8(%ebp),%eax
    780b:	89 04 24             	mov    %eax,(%esp)
    780e:	e8 8b de ff ff       	call   569e <get1bit>
    7813:	89 c2                	mov    %eax,%edx
    7815:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7818:	89 50 24             	mov    %edx,0x24(%eax)
    hdr->original = get1bit(bs);
    781b:	8b 45 08             	mov    0x8(%ebp),%eax
    781e:	89 04 24             	mov    %eax,(%esp)
    7821:	e8 78 de ff ff       	call   569e <get1bit>
    7826:	89 c2                	mov    %eax,%edx
    7828:	8b 45 f4             	mov    -0xc(%ebp),%eax
    782b:	89 50 28             	mov    %edx,0x28(%eax)
    hdr->emphasis = getbits(bs,2);
    782e:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7835:	00 
    7836:	8b 45 08             	mov    0x8(%ebp),%eax
    7839:	89 04 24             	mov    %eax,(%esp)
    783c:	e8 6f df ff ff       	call   57b0 <getbits>
    7841:	89 c2                	mov    %eax,%edx
    7843:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7846:	89 50 2c             	mov    %edx,0x2c(%eax)
}
    7849:	c9                   	leave  
    784a:	c3                   	ret    

0000784b <III_get_side_info>:

void III_get_side_info(Bit_stream_struc *bs, struct III_side_info_t *si, struct frame_params *fr_ps)
{
    784b:	55                   	push   %ebp
    784c:	89 e5                	mov    %esp,%ebp
    784e:	56                   	push   %esi
    784f:	53                   	push   %ebx
    7850:	83 ec 20             	sub    $0x20,%esp
	int ch, gr, i;
	int stereo = fr_ps->stereo;
    7853:	8b 45 10             	mov    0x10(%ebp),%eax
    7856:	8b 40 08             	mov    0x8(%eax),%eax
    7859:	89 45 e8             	mov    %eax,-0x18(%ebp)

	si->main_data_begin = getbits(bs, 9);
    785c:	c7 44 24 04 09 00 00 	movl   $0x9,0x4(%esp)
    7863:	00 
    7864:	8b 45 08             	mov    0x8(%ebp),%eax
    7867:	89 04 24             	mov    %eax,(%esp)
    786a:	e8 41 df ff ff       	call   57b0 <getbits>
    786f:	8b 55 0c             	mov    0xc(%ebp),%edx
    7872:	89 02                	mov    %eax,(%edx)
	if (stereo == 1)
    7874:	83 7d e8 01          	cmpl   $0x1,-0x18(%ebp)
    7878:	75 1b                	jne    7895 <III_get_side_info+0x4a>
		si->private_bits = getbits(bs,5);
    787a:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    7881:	00 
    7882:	8b 45 08             	mov    0x8(%ebp),%eax
    7885:	89 04 24             	mov    %eax,(%esp)
    7888:	e8 23 df ff ff       	call   57b0 <getbits>
    788d:	8b 55 0c             	mov    0xc(%ebp),%edx
    7890:	89 42 04             	mov    %eax,0x4(%edx)
    7893:	eb 19                	jmp    78ae <III_get_side_info+0x63>
	else
		si->private_bits = getbits(bs,3);
    7895:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    789c:	00 
    789d:	8b 45 08             	mov    0x8(%ebp),%eax
    78a0:	89 04 24             	mov    %eax,(%esp)
    78a3:	e8 08 df ff ff       	call   57b0 <getbits>
    78a8:	8b 55 0c             	mov    0xc(%ebp),%edx
    78ab:	89 42 04             	mov    %eax,0x4(%edx)

	for (ch=0; ch<stereo; ch++)
    78ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    78b5:	eb 3d                	jmp    78f4 <III_get_side_info+0xa9>
		for (i=0; i<4; i++)
    78b7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    78be:	eb 2a                	jmp    78ea <III_get_side_info+0x9f>
			si->ch[ch].scfsi[i] = get1bit(bs);
    78c0:	8b 45 08             	mov    0x8(%ebp),%eax
    78c3:	89 04 24             	mov    %eax,(%esp)
    78c6:	e8 d3 dd ff ff       	call   569e <get1bit>
    78cb:	89 c1                	mov    %eax,%ecx
    78cd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    78d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    78d3:	89 d0                	mov    %edx,%eax
    78d5:	c1 e0 02             	shl    $0x2,%eax
    78d8:	01 d0                	add    %edx,%eax
    78da:	c1 e0 03             	shl    $0x3,%eax
    78dd:	8b 55 ec             	mov    -0x14(%ebp),%edx
    78e0:	01 d0                	add    %edx,%eax
    78e2:	89 4c 83 08          	mov    %ecx,0x8(%ebx,%eax,4)
		si->private_bits = getbits(bs,5);
	else
		si->private_bits = getbits(bs,3);

	for (ch=0; ch<stereo; ch++)
		for (i=0; i<4; i++)
    78e6:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    78ea:	83 7d ec 03          	cmpl   $0x3,-0x14(%ebp)
    78ee:	7e d0                	jle    78c0 <III_get_side_info+0x75>
	if (stereo == 1)
		si->private_bits = getbits(bs,5);
	else
		si->private_bits = getbits(bs,3);

	for (ch=0; ch<stereo; ch++)
    78f0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    78f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    78f7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    78fa:	7c bb                	jl     78b7 <III_get_side_info+0x6c>
		for (i=0; i<4; i++)
			si->ch[ch].scfsi[i] = get1bit(bs);

	for (gr=0; gr<2; gr++) {
    78fc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    7903:	e9 c5 05 00 00       	jmp    7ecd <III_get_side_info+0x682>
		for (ch=0; ch<stereo; ch++) {
    7908:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    790f:	e9 a9 05 00 00       	jmp    7ebd <III_get_side_info+0x672>
			si->ch[ch].gr[gr].part2_3_length = getbits(bs, 12);
    7914:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
    791b:	00 
    791c:	8b 45 08             	mov    0x8(%ebp),%eax
    791f:	89 04 24             	mov    %eax,(%esp)
    7922:	e8 89 de ff ff       	call   57b0 <getbits>
    7927:	89 c3                	mov    %eax,%ebx
    7929:	8b 75 0c             	mov    0xc(%ebp),%esi
    792c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    792f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7932:	89 c2                	mov    %eax,%edx
    7934:	c1 e2 03             	shl    $0x3,%edx
    7937:	01 c2                	add    %eax,%edx
    7939:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7940:	89 c2                	mov    %eax,%edx
    7942:	89 c8                	mov    %ecx,%eax
    7944:	c1 e0 02             	shl    $0x2,%eax
    7947:	01 c8                	add    %ecx,%eax
    7949:	c1 e0 05             	shl    $0x5,%eax
    794c:	01 d0                	add    %edx,%eax
    794e:	01 f0                	add    %esi,%eax
    7950:	83 c0 18             	add    $0x18,%eax
    7953:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].big_values = getbits(bs, 9);
    7955:	c7 44 24 04 09 00 00 	movl   $0x9,0x4(%esp)
    795c:	00 
    795d:	8b 45 08             	mov    0x8(%ebp),%eax
    7960:	89 04 24             	mov    %eax,(%esp)
    7963:	e8 48 de ff ff       	call   57b0 <getbits>
    7968:	89 c3                	mov    %eax,%ebx
    796a:	8b 75 0c             	mov    0xc(%ebp),%esi
    796d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7970:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7973:	89 c2                	mov    %eax,%edx
    7975:	c1 e2 03             	shl    $0x3,%edx
    7978:	01 c2                	add    %eax,%edx
    797a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7981:	89 c2                	mov    %eax,%edx
    7983:	89 c8                	mov    %ecx,%eax
    7985:	c1 e0 02             	shl    $0x2,%eax
    7988:	01 c8                	add    %ecx,%eax
    798a:	c1 e0 05             	shl    $0x5,%eax
    798d:	01 d0                	add    %edx,%eax
    798f:	01 f0                	add    %esi,%eax
    7991:	83 c0 1c             	add    $0x1c,%eax
    7994:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].global_gain = getbits(bs, 8);
    7996:	c7 44 24 04 08 00 00 	movl   $0x8,0x4(%esp)
    799d:	00 
    799e:	8b 45 08             	mov    0x8(%ebp),%eax
    79a1:	89 04 24             	mov    %eax,(%esp)
    79a4:	e8 07 de ff ff       	call   57b0 <getbits>
    79a9:	89 c3                	mov    %eax,%ebx
    79ab:	8b 75 0c             	mov    0xc(%ebp),%esi
    79ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    79b1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    79b4:	89 c2                	mov    %eax,%edx
    79b6:	c1 e2 03             	shl    $0x3,%edx
    79b9:	01 c2                	add    %eax,%edx
    79bb:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    79c2:	89 c2                	mov    %eax,%edx
    79c4:	89 c8                	mov    %ecx,%eax
    79c6:	c1 e0 02             	shl    $0x2,%eax
    79c9:	01 c8                	add    %ecx,%eax
    79cb:	c1 e0 05             	shl    $0x5,%eax
    79ce:	01 d0                	add    %edx,%eax
    79d0:	01 f0                	add    %esi,%eax
    79d2:	83 c0 20             	add    $0x20,%eax
    79d5:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].scalefac_compress = getbits(bs, 4);
    79d7:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
    79de:	00 
    79df:	8b 45 08             	mov    0x8(%ebp),%eax
    79e2:	89 04 24             	mov    %eax,(%esp)
    79e5:	e8 c6 dd ff ff       	call   57b0 <getbits>
    79ea:	89 c3                	mov    %eax,%ebx
    79ec:	8b 75 0c             	mov    0xc(%ebp),%esi
    79ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    79f2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    79f5:	89 c2                	mov    %eax,%edx
    79f7:	c1 e2 03             	shl    $0x3,%edx
    79fa:	01 c2                	add    %eax,%edx
    79fc:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7a03:	89 c2                	mov    %eax,%edx
    7a05:	89 c8                	mov    %ecx,%eax
    7a07:	c1 e0 02             	shl    $0x2,%eax
    7a0a:	01 c8                	add    %ecx,%eax
    7a0c:	c1 e0 05             	shl    $0x5,%eax
    7a0f:	01 d0                	add    %edx,%eax
    7a11:	01 f0                	add    %esi,%eax
    7a13:	83 c0 24             	add    $0x24,%eax
    7a16:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].window_switching_flag = get1bit(bs);
    7a18:	8b 45 08             	mov    0x8(%ebp),%eax
    7a1b:	89 04 24             	mov    %eax,(%esp)
    7a1e:	e8 7b dc ff ff       	call   569e <get1bit>
    7a23:	89 c3                	mov    %eax,%ebx
    7a25:	8b 75 0c             	mov    0xc(%ebp),%esi
    7a28:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7a2b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7a2e:	89 c2                	mov    %eax,%edx
    7a30:	c1 e2 03             	shl    $0x3,%edx
    7a33:	01 c2                	add    %eax,%edx
    7a35:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7a3c:	89 c2                	mov    %eax,%edx
    7a3e:	89 c8                	mov    %ecx,%eax
    7a40:	c1 e0 02             	shl    $0x2,%eax
    7a43:	01 c8                	add    %ecx,%eax
    7a45:	c1 e0 05             	shl    $0x5,%eax
    7a48:	01 d0                	add    %edx,%eax
    7a4a:	01 f0                	add    %esi,%eax
    7a4c:	83 c0 28             	add    $0x28,%eax
    7a4f:	89 18                	mov    %ebx,(%eax)
			if (si->ch[ch].gr[gr].window_switching_flag) {
    7a51:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7a54:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7a57:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7a5a:	89 c2                	mov    %eax,%edx
    7a5c:	c1 e2 03             	shl    $0x3,%edx
    7a5f:	01 c2                	add    %eax,%edx
    7a61:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7a68:	89 c2                	mov    %eax,%edx
    7a6a:	89 c8                	mov    %ecx,%eax
    7a6c:	c1 e0 02             	shl    $0x2,%eax
    7a6f:	01 c8                	add    %ecx,%eax
    7a71:	c1 e0 05             	shl    $0x5,%eax
    7a74:	01 d0                	add    %edx,%eax
    7a76:	01 d8                	add    %ebx,%eax
    7a78:	83 c0 28             	add    $0x28,%eax
    7a7b:	8b 00                	mov    (%eax),%eax
    7a7d:	85 c0                	test   %eax,%eax
    7a7f:	0f 84 82 02 00 00    	je     7d07 <III_get_side_info+0x4bc>
				si->ch[ch].gr[gr].block_type = getbits(bs, 2);
    7a85:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    7a8c:	00 
    7a8d:	8b 45 08             	mov    0x8(%ebp),%eax
    7a90:	89 04 24             	mov    %eax,(%esp)
    7a93:	e8 18 dd ff ff       	call   57b0 <getbits>
    7a98:	89 c3                	mov    %eax,%ebx
    7a9a:	8b 75 0c             	mov    0xc(%ebp),%esi
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
    7abf:	01 f0                	add    %esi,%eax
    7ac1:	83 c0 2c             	add    $0x2c,%eax
    7ac4:	89 18                	mov    %ebx,(%eax)
				si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
    7ac6:	8b 45 08             	mov    0x8(%ebp),%eax
    7ac9:	89 04 24             	mov    %eax,(%esp)
    7acc:	e8 cd db ff ff       	call   569e <get1bit>
    7ad1:	89 c3                	mov    %eax,%ebx
    7ad3:	8b 75 0c             	mov    0xc(%ebp),%esi
    7ad6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7ad9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7adc:	89 c2                	mov    %eax,%edx
    7ade:	c1 e2 03             	shl    $0x3,%edx
    7ae1:	01 c2                	add    %eax,%edx
    7ae3:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7aea:	89 c2                	mov    %eax,%edx
    7aec:	89 c8                	mov    %ecx,%eax
    7aee:	c1 e0 02             	shl    $0x2,%eax
    7af1:	01 c8                	add    %ecx,%eax
    7af3:	c1 e0 05             	shl    $0x5,%eax
    7af6:	01 d0                	add    %edx,%eax
    7af8:	01 f0                	add    %esi,%eax
    7afa:	83 c0 30             	add    $0x30,%eax
    7afd:	89 18                	mov    %ebx,(%eax)
				for (i=0; i<2; i++)
    7aff:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7b06:	eb 46                	jmp    7b4e <III_get_side_info+0x303>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
    7b08:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    7b0f:	00 
    7b10:	8b 45 08             	mov    0x8(%ebp),%eax
    7b13:	89 04 24             	mov    %eax,(%esp)
    7b16:	e8 95 dc ff ff       	call   57b0 <getbits>
    7b1b:	89 c3                	mov    %eax,%ebx
    7b1d:	8b 75 0c             	mov    0xc(%ebp),%esi
    7b20:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7b23:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7b26:	89 c2                	mov    %eax,%edx
    7b28:	c1 e2 03             	shl    $0x3,%edx
    7b2b:	01 c2                	add    %eax,%edx
    7b2d:	8d 04 12             	lea    (%edx,%edx,1),%eax
    7b30:	89 c2                	mov    %eax,%edx
    7b32:	89 c8                	mov    %ecx,%eax
    7b34:	c1 e0 02             	shl    $0x2,%eax
    7b37:	01 c8                	add    %ecx,%eax
    7b39:	c1 e0 03             	shl    $0x3,%eax
    7b3c:	01 c2                	add    %eax,%edx
    7b3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7b41:	01 d0                	add    %edx,%eax
    7b43:	83 c0 08             	add    $0x8,%eax
    7b46:	89 5c 86 14          	mov    %ebx,0x14(%esi,%eax,4)
			si->ch[ch].gr[gr].scalefac_compress = getbits(bs, 4);
			si->ch[ch].gr[gr].window_switching_flag = get1bit(bs);
			if (si->ch[ch].gr[gr].window_switching_flag) {
				si->ch[ch].gr[gr].block_type = getbits(bs, 2);
				si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
				for (i=0; i<2; i++)
    7b4a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7b4e:	83 7d ec 01          	cmpl   $0x1,-0x14(%ebp)
    7b52:	7e b4                	jle    7b08 <III_get_side_info+0x2bd>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
				for (i=0; i<3; i++)
    7b54:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7b5b:	eb 46                	jmp    7ba3 <III_get_side_info+0x358>
					si->ch[ch].gr[gr].subblock_gain[i] = getbits(bs, 3);
    7b5d:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    7b64:	00 
    7b65:	8b 45 08             	mov    0x8(%ebp),%eax
    7b68:	89 04 24             	mov    %eax,(%esp)
    7b6b:	e8 40 dc ff ff       	call   57b0 <getbits>
    7b70:	89 c3                	mov    %eax,%ebx
    7b72:	8b 75 0c             	mov    0xc(%ebp),%esi
    7b75:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7b78:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7b7b:	89 c2                	mov    %eax,%edx
    7b7d:	c1 e2 03             	shl    $0x3,%edx
    7b80:	01 c2                	add    %eax,%edx
    7b82:	8d 04 12             	lea    (%edx,%edx,1),%eax
    7b85:	89 c2                	mov    %eax,%edx
    7b87:	89 c8                	mov    %ecx,%eax
    7b89:	c1 e0 02             	shl    $0x2,%eax
    7b8c:	01 c8                	add    %ecx,%eax
    7b8e:	c1 e0 03             	shl    $0x3,%eax
    7b91:	01 c2                	add    %eax,%edx
    7b93:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7b96:	01 d0                	add    %edx,%eax
    7b98:	83 c0 0c             	add    $0xc,%eax
    7b9b:	89 5c 86 10          	mov    %ebx,0x10(%esi,%eax,4)
			if (si->ch[ch].gr[gr].window_switching_flag) {
				si->ch[ch].gr[gr].block_type = getbits(bs, 2);
				si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
				for (i=0; i<2; i++)
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
				for (i=0; i<3; i++)
    7b9f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7ba3:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    7ba7:	7e b4                	jle    7b5d <III_get_side_info+0x312>
					si->ch[ch].gr[gr].subblock_gain[i] = getbits(bs, 3);

				/* Set region_count parameters since they are implicit in this case. */

				if (si->ch[ch].gr[gr].block_type == 0) {
    7ba9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7bac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7baf:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7bb2:	89 c2                	mov    %eax,%edx
    7bb4:	c1 e2 03             	shl    $0x3,%edx
    7bb7:	01 c2                	add    %eax,%edx
    7bb9:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7bc0:	89 c2                	mov    %eax,%edx
    7bc2:	89 c8                	mov    %ecx,%eax
    7bc4:	c1 e0 02             	shl    $0x2,%eax
    7bc7:	01 c8                	add    %ecx,%eax
    7bc9:	c1 e0 05             	shl    $0x5,%eax
    7bcc:	01 d0                	add    %edx,%eax
    7bce:	01 d8                	add    %ebx,%eax
    7bd0:	83 c0 2c             	add    $0x2c,%eax
    7bd3:	8b 00                	mov    (%eax),%eax
    7bd5:	85 c0                	test   %eax,%eax
    7bd7:	75 05                	jne    7bde <III_get_side_info+0x393>
					//printf("Side info bad: block_type == 0 in split block.\n");
					exit();
    7bd9:	e8 7c cb ff ff       	call   475a <exit>
				}
				else if (si->ch[ch].gr[gr].block_type == 2
    7bde:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7be1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7be4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7be7:	89 c2                	mov    %eax,%edx
    7be9:	c1 e2 03             	shl    $0x3,%edx
    7bec:	01 c2                	add    %eax,%edx
    7bee:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7bf5:	89 c2                	mov    %eax,%edx
    7bf7:	89 c8                	mov    %ecx,%eax
    7bf9:	c1 e0 02             	shl    $0x2,%eax
    7bfc:	01 c8                	add    %ecx,%eax
    7bfe:	c1 e0 05             	shl    $0x5,%eax
    7c01:	01 d0                	add    %edx,%eax
    7c03:	01 d8                	add    %ebx,%eax
    7c05:	83 c0 2c             	add    $0x2c,%eax
    7c08:	8b 00                	mov    (%eax),%eax
    7c0a:	83 f8 02             	cmp    $0x2,%eax
    7c0d:	75 62                	jne    7c71 <III_get_side_info+0x426>
						&& si->ch[ch].gr[gr].mixed_block_flag == 0)
    7c0f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7c12:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7c15:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7c18:	89 c2                	mov    %eax,%edx
    7c1a:	c1 e2 03             	shl    $0x3,%edx
    7c1d:	01 c2                	add    %eax,%edx
    7c1f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7c26:	89 c2                	mov    %eax,%edx
    7c28:	89 c8                	mov    %ecx,%eax
    7c2a:	c1 e0 02             	shl    $0x2,%eax
    7c2d:	01 c8                	add    %ecx,%eax
    7c2f:	c1 e0 05             	shl    $0x5,%eax
    7c32:	01 d0                	add    %edx,%eax
    7c34:	01 d8                	add    %ebx,%eax
    7c36:	83 c0 30             	add    $0x30,%eax
    7c39:	8b 00                	mov    (%eax),%eax
    7c3b:	85 c0                	test   %eax,%eax
    7c3d:	75 32                	jne    7c71 <III_get_side_info+0x426>
					si->ch[ch].gr[gr].region0_count = 8; /* MI 9; */
    7c3f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7c42:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7c45:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7c48:	89 c2                	mov    %eax,%edx
    7c4a:	c1 e2 03             	shl    $0x3,%edx
    7c4d:	01 c2                	add    %eax,%edx
    7c4f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7c56:	89 c2                	mov    %eax,%edx
    7c58:	89 c8                	mov    %ecx,%eax
    7c5a:	c1 e0 02             	shl    $0x2,%eax
    7c5d:	01 c8                	add    %ecx,%eax
    7c5f:	c1 e0 05             	shl    $0x5,%eax
    7c62:	01 d0                	add    %edx,%eax
    7c64:	01 d8                	add    %ebx,%eax
    7c66:	83 c0 4c             	add    $0x4c,%eax
    7c69:	c7 00 08 00 00 00    	movl   $0x8,(%eax)
    7c6f:	eb 30                	jmp    7ca1 <III_get_side_info+0x456>
				else si->ch[ch].gr[gr].region0_count = 7; /* MI 8; */
    7c71:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7c74:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7c77:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7c7a:	89 c2                	mov    %eax,%edx
    7c7c:	c1 e2 03             	shl    $0x3,%edx
    7c7f:	01 c2                	add    %eax,%edx
    7c81:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7c88:	89 c2                	mov    %eax,%edx
    7c8a:	89 c8                	mov    %ecx,%eax
    7c8c:	c1 e0 02             	shl    $0x2,%eax
    7c8f:	01 c8                	add    %ecx,%eax
    7c91:	c1 e0 05             	shl    $0x5,%eax
    7c94:	01 d0                	add    %edx,%eax
    7c96:	01 d8                	add    %ebx,%eax
    7c98:	83 c0 4c             	add    $0x4c,%eax
    7c9b:	c7 00 07 00 00 00    	movl   $0x7,(%eax)
					si->ch[ch].gr[gr].region1_count = 20 - si->ch[ch].gr[gr].region0_count;
    7ca1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7ca4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7ca7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7caa:	89 c2                	mov    %eax,%edx
    7cac:	c1 e2 03             	shl    $0x3,%edx
    7caf:	01 c2                	add    %eax,%edx
    7cb1:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7cb8:	89 c2                	mov    %eax,%edx
    7cba:	89 c8                	mov    %ecx,%eax
    7cbc:	c1 e0 02             	shl    $0x2,%eax
    7cbf:	01 c8                	add    %ecx,%eax
    7cc1:	c1 e0 05             	shl    $0x5,%eax
    7cc4:	01 d0                	add    %edx,%eax
    7cc6:	01 d8                	add    %ebx,%eax
    7cc8:	83 c0 4c             	add    $0x4c,%eax
    7ccb:	8b 00                	mov    (%eax),%eax
    7ccd:	ba 14 00 00 00       	mov    $0x14,%edx
    7cd2:	89 d3                	mov    %edx,%ebx
    7cd4:	29 c3                	sub    %eax,%ebx
    7cd6:	8b 75 0c             	mov    0xc(%ebp),%esi
    7cd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7cdc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7cdf:	89 c2                	mov    %eax,%edx
    7ce1:	c1 e2 03             	shl    $0x3,%edx
    7ce4:	01 c2                	add    %eax,%edx
    7ce6:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7ced:	89 c2                	mov    %eax,%edx
    7cef:	89 c8                	mov    %ecx,%eax
    7cf1:	c1 e0 02             	shl    $0x2,%eax
    7cf4:	01 c8                	add    %ecx,%eax
    7cf6:	c1 e0 05             	shl    $0x5,%eax
    7cf9:	01 d0                	add    %edx,%eax
    7cfb:	01 f0                	add    %esi,%eax
    7cfd:	83 c0 50             	add    $0x50,%eax
    7d00:	89 18                	mov    %ebx,(%eax)
    7d02:	e9 07 01 00 00       	jmp    7e0e <III_get_side_info+0x5c3>
			}
			else {
				for (i=0; i<3; i++)
    7d07:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7d0e:	eb 46                	jmp    7d56 <III_get_side_info+0x50b>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
    7d10:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
    7d17:	00 
    7d18:	8b 45 08             	mov    0x8(%ebp),%eax
    7d1b:	89 04 24             	mov    %eax,(%esp)
    7d1e:	e8 8d da ff ff       	call   57b0 <getbits>
    7d23:	89 c3                	mov    %eax,%ebx
    7d25:	8b 75 0c             	mov    0xc(%ebp),%esi
    7d28:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7d2b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7d2e:	89 c2                	mov    %eax,%edx
    7d30:	c1 e2 03             	shl    $0x3,%edx
    7d33:	01 c2                	add    %eax,%edx
    7d35:	8d 04 12             	lea    (%edx,%edx,1),%eax
    7d38:	89 c2                	mov    %eax,%edx
    7d3a:	89 c8                	mov    %ecx,%eax
    7d3c:	c1 e0 02             	shl    $0x2,%eax
    7d3f:	01 c8                	add    %ecx,%eax
    7d41:	c1 e0 03             	shl    $0x3,%eax
    7d44:	01 c2                	add    %eax,%edx
    7d46:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7d49:	01 d0                	add    %edx,%eax
    7d4b:	83 c0 08             	add    $0x8,%eax
    7d4e:	89 5c 86 14          	mov    %ebx,0x14(%esi,%eax,4)
					si->ch[ch].gr[gr].region0_count = 8; /* MI 9; */
				else si->ch[ch].gr[gr].region0_count = 7; /* MI 8; */
					si->ch[ch].gr[gr].region1_count = 20 - si->ch[ch].gr[gr].region0_count;
			}
			else {
				for (i=0; i<3; i++)
    7d52:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7d56:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    7d5a:	7e b4                	jle    7d10 <III_get_side_info+0x4c5>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
				si->ch[ch].gr[gr].region0_count = getbits(bs, 4);
    7d5c:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
    7d63:	00 
    7d64:	8b 45 08             	mov    0x8(%ebp),%eax
    7d67:	89 04 24             	mov    %eax,(%esp)
    7d6a:	e8 41 da ff ff       	call   57b0 <getbits>
    7d6f:	89 c3                	mov    %eax,%ebx
    7d71:	8b 75 0c             	mov    0xc(%ebp),%esi
    7d74:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7d77:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7d7a:	89 c2                	mov    %eax,%edx
    7d7c:	c1 e2 03             	shl    $0x3,%edx
    7d7f:	01 c2                	add    %eax,%edx
    7d81:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7d88:	89 c2                	mov    %eax,%edx
    7d8a:	89 c8                	mov    %ecx,%eax
    7d8c:	c1 e0 02             	shl    $0x2,%eax
    7d8f:	01 c8                	add    %ecx,%eax
    7d91:	c1 e0 05             	shl    $0x5,%eax
    7d94:	01 d0                	add    %edx,%eax
    7d96:	01 f0                	add    %esi,%eax
    7d98:	83 c0 4c             	add    $0x4c,%eax
    7d9b:	89 18                	mov    %ebx,(%eax)
				si->ch[ch].gr[gr].region1_count = getbits(bs, 3);
    7d9d:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    7da4:	00 
    7da5:	8b 45 08             	mov    0x8(%ebp),%eax
    7da8:	89 04 24             	mov    %eax,(%esp)
    7dab:	e8 00 da ff ff       	call   57b0 <getbits>
    7db0:	89 c3                	mov    %eax,%ebx
    7db2:	8b 75 0c             	mov    0xc(%ebp),%esi
    7db5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7db8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7dbb:	89 c2                	mov    %eax,%edx
    7dbd:	c1 e2 03             	shl    $0x3,%edx
    7dc0:	01 c2                	add    %eax,%edx
    7dc2:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7dc9:	89 c2                	mov    %eax,%edx
    7dcb:	89 c8                	mov    %ecx,%eax
    7dcd:	c1 e0 02             	shl    $0x2,%eax
    7dd0:	01 c8                	add    %ecx,%eax
    7dd2:	c1 e0 05             	shl    $0x5,%eax
    7dd5:	01 d0                	add    %edx,%eax
    7dd7:	01 f0                	add    %esi,%eax
    7dd9:	83 c0 50             	add    $0x50,%eax
    7ddc:	89 18                	mov    %ebx,(%eax)
				si->ch[ch].gr[gr].block_type = 0;
    7dde:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    7de1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7de4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7de7:	89 c2                	mov    %eax,%edx
    7de9:	c1 e2 03             	shl    $0x3,%edx
    7dec:	01 c2                	add    %eax,%edx
    7dee:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7df5:	89 c2                	mov    %eax,%edx
    7df7:	89 c8                	mov    %ecx,%eax
    7df9:	c1 e0 02             	shl    $0x2,%eax
    7dfc:	01 c8                	add    %ecx,%eax
    7dfe:	c1 e0 05             	shl    $0x5,%eax
    7e01:	01 d0                	add    %edx,%eax
    7e03:	01 d8                	add    %ebx,%eax
    7e05:	83 c0 2c             	add    $0x2c,%eax
    7e08:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
			}
			si->ch[ch].gr[gr].preflag = get1bit(bs);
    7e0e:	8b 45 08             	mov    0x8(%ebp),%eax
    7e11:	89 04 24             	mov    %eax,(%esp)
    7e14:	e8 85 d8 ff ff       	call   569e <get1bit>
    7e19:	89 c3                	mov    %eax,%ebx
    7e1b:	8b 75 0c             	mov    0xc(%ebp),%esi
    7e1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7e21:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7e24:	89 c2                	mov    %eax,%edx
    7e26:	c1 e2 03             	shl    $0x3,%edx
    7e29:	01 c2                	add    %eax,%edx
    7e2b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7e32:	89 c2                	mov    %eax,%edx
    7e34:	89 c8                	mov    %ecx,%eax
    7e36:	c1 e0 02             	shl    $0x2,%eax
    7e39:	01 c8                	add    %ecx,%eax
    7e3b:	c1 e0 05             	shl    $0x5,%eax
    7e3e:	01 d0                	add    %edx,%eax
    7e40:	01 f0                	add    %esi,%eax
    7e42:	83 c0 54             	add    $0x54,%eax
    7e45:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].scalefac_scale = get1bit(bs);
    7e47:	8b 45 08             	mov    0x8(%ebp),%eax
    7e4a:	89 04 24             	mov    %eax,(%esp)
    7e4d:	e8 4c d8 ff ff       	call   569e <get1bit>
    7e52:	89 c3                	mov    %eax,%ebx
    7e54:	8b 75 0c             	mov    0xc(%ebp),%esi
    7e57:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7e5a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7e5d:	89 c2                	mov    %eax,%edx
    7e5f:	c1 e2 03             	shl    $0x3,%edx
    7e62:	01 c2                	add    %eax,%edx
    7e64:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7e6b:	89 c2                	mov    %eax,%edx
    7e6d:	89 c8                	mov    %ecx,%eax
    7e6f:	c1 e0 02             	shl    $0x2,%eax
    7e72:	01 c8                	add    %ecx,%eax
    7e74:	c1 e0 05             	shl    $0x5,%eax
    7e77:	01 d0                	add    %edx,%eax
    7e79:	01 f0                	add    %esi,%eax
    7e7b:	83 c0 58             	add    $0x58,%eax
    7e7e:	89 18                	mov    %ebx,(%eax)
			si->ch[ch].gr[gr].count1table_select = get1bit(bs);
    7e80:	8b 45 08             	mov    0x8(%ebp),%eax
    7e83:	89 04 24             	mov    %eax,(%esp)
    7e86:	e8 13 d8 ff ff       	call   569e <get1bit>
    7e8b:	89 c3                	mov    %eax,%ebx
    7e8d:	8b 75 0c             	mov    0xc(%ebp),%esi
    7e90:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7e93:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    7e96:	89 c2                	mov    %eax,%edx
    7e98:	c1 e2 03             	shl    $0x3,%edx
    7e9b:	01 c2                	add    %eax,%edx
    7e9d:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7ea4:	89 c2                	mov    %eax,%edx
    7ea6:	89 c8                	mov    %ecx,%eax
    7ea8:	c1 e0 02             	shl    $0x2,%eax
    7eab:	01 c8                	add    %ecx,%eax
    7ead:	c1 e0 05             	shl    $0x5,%eax
    7eb0:	01 d0                	add    %edx,%eax
    7eb2:	01 f0                	add    %esi,%eax
    7eb4:	83 c0 5c             	add    $0x5c,%eax
    7eb7:	89 18                	mov    %ebx,(%eax)
	for (ch=0; ch<stereo; ch++)
		for (i=0; i<4; i++)
			si->ch[ch].scfsi[i] = get1bit(bs);

	for (gr=0; gr<2; gr++) {
		for (ch=0; ch<stereo; ch++) {
    7eb9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7ebd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7ec0:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    7ec3:	0f 8c 4b fa ff ff    	jl     7914 <III_get_side_info+0xc9>

	for (ch=0; ch<stereo; ch++)
		for (i=0; i<4; i++)
			si->ch[ch].scfsi[i] = get1bit(bs);

	for (gr=0; gr<2; gr++) {
    7ec9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    7ecd:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    7ed1:	0f 8e 31 fa ff ff    	jle    7908 <III_get_side_info+0xbd>
			si->ch[ch].gr[gr].preflag = get1bit(bs);
			si->ch[ch].gr[gr].scalefac_scale = get1bit(bs);
			si->ch[ch].gr[gr].count1table_select = get1bit(bs);
         }
	}
}
    7ed7:	83 c4 20             	add    $0x20,%esp
    7eda:	5b                   	pop    %ebx
    7edb:	5e                   	pop    %esi
    7edc:	5d                   	pop    %ebp
    7edd:	c3                   	ret    

00007ede <III_get_scale_factors>:
	{{0,4,8,12,16,20,24,30,36,44,54,66,82,102,126,156,194,240,296,364,448,550,576},
		{0,4,8,12,16,22,30,42,58,78,104,138,180,192}}
};

void III_get_scale_factors(III_scalefac_t *scalefac, struct III_side_info_t *si, int gr, int ch, struct frame_params *fr_ps)
{
    7ede:	55                   	push   %ebp
    7edf:	89 e5                	mov    %esp,%ebp
    7ee1:	56                   	push   %esi
    7ee2:	53                   	push   %ebx
    7ee3:	83 ec 20             	sub    $0x20,%esp
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);
    7ee6:	8b 45 10             	mov    0x10(%ebp),%eax
    7ee9:	89 c2                	mov    %eax,%edx
    7eeb:	c1 e2 03             	shl    $0x3,%edx
    7eee:	01 c2                	add    %eax,%edx
    7ef0:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    7ef7:	89 c2                	mov    %eax,%edx
    7ef9:	8b 4d 14             	mov    0x14(%ebp),%ecx
    7efc:	89 c8                	mov    %ecx,%eax
    7efe:	c1 e0 02             	shl    $0x2,%eax
    7f01:	01 c8                	add    %ecx,%eax
    7f03:	c1 e0 05             	shl    $0x5,%eax
    7f06:	01 d0                	add    %edx,%eax
    7f08:	8d 50 10             	lea    0x10(%eax),%edx
    7f0b:	8b 45 0c             	mov    0xc(%ebp),%eax
    7f0e:	01 d0                	add    %edx,%eax
    7f10:	83 c0 08             	add    $0x8,%eax
    7f13:	89 45 e8             	mov    %eax,-0x18(%ebp)

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    7f16:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7f19:	8b 40 10             	mov    0x10(%eax),%eax
    7f1c:	85 c0                	test   %eax,%eax
    7f1e:	0f 84 7e 02 00 00    	je     81a2 <III_get_scale_factors+0x2c4>
    7f24:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7f27:	8b 40 14             	mov    0x14(%eax),%eax
    7f2a:	83 f8 02             	cmp    $0x2,%eax
    7f2d:	0f 85 6f 02 00 00    	jne    81a2 <III_get_scale_factors+0x2c4>
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    7f33:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7f36:	8b 40 18             	mov    0x18(%eax),%eax
    7f39:	85 c0                	test   %eax,%eax
    7f3b:	0f 84 6b 01 00 00    	je     80ac <III_get_scale_factors+0x1ce>
			for (sfb = 0; sfb < 8; sfb++)
    7f41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    7f48:	eb 32                	jmp    7f7c <III_get_scale_factors+0x9e>
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
    7f4a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7f4d:	8b 40 0c             	mov    0xc(%eax),%eax
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
    7f50:	8b 04 85 e0 f0 00 00 	mov    0xf0e0(,%eax,4),%eax
    7f57:	89 04 24             	mov    %eax,(%esp)
    7f5a:	e8 b9 db ff ff       	call   5b18 <hgetbits>
    7f5f:	89 c3                	mov    %eax,%ebx
    7f61:	8b 4d 08             	mov    0x8(%ebp),%ecx
    7f64:	8b 45 14             	mov    0x14(%ebp),%eax
    7f67:	01 c0                	add    %eax,%eax
    7f69:	89 c2                	mov    %eax,%edx
    7f6b:	c1 e2 05             	shl    $0x5,%edx
    7f6e:	29 c2                	sub    %eax,%edx
    7f70:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7f73:	01 d0                	add    %edx,%eax
    7f75:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
    7f78:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7f7c:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    7f80:	7e c8                	jle    7f4a <III_get_scale_factors+0x6c>
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
    7f82:	c7 45 f4 03 00 00 00 	movl   $0x3,-0xc(%ebp)
    7f89:	eb 5c                	jmp    7fe7 <III_get_scale_factors+0x109>
				for (window=0; window<3; window++)
    7f8b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7f92:	eb 49                	jmp    7fdd <III_get_scale_factors+0xff>
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
    7f94:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7f97:	8b 40 0c             	mov    0xc(%eax),%eax
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
    7f9a:	8b 04 85 e0 f0 00 00 	mov    0xf0e0(,%eax,4),%eax
    7fa1:	89 04 24             	mov    %eax,(%esp)
    7fa4:	e8 6f db ff ff       	call   5b18 <hgetbits>
    7fa9:	89 c6                	mov    %eax,%esi
    7fab:	8b 5d 08             	mov    0x8(%ebp),%ebx
    7fae:	8b 55 ec             	mov    -0x14(%ebp),%edx
    7fb1:	8b 4d 14             	mov    0x14(%ebp),%ecx
    7fb4:	89 d0                	mov    %edx,%eax
    7fb6:	01 c0                	add    %eax,%eax
    7fb8:	01 d0                	add    %edx,%eax
    7fba:	c1 e0 02             	shl    $0x2,%eax
    7fbd:	01 d0                	add    %edx,%eax
    7fbf:	89 ca                	mov    %ecx,%edx
    7fc1:	01 d2                	add    %edx,%edx
    7fc3:	89 d1                	mov    %edx,%ecx
    7fc5:	c1 e1 05             	shl    $0x5,%ecx
    7fc8:	29 d1                	sub    %edx,%ecx
    7fca:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    7fcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7fd0:	01 d0                	add    %edx,%eax
    7fd2:	83 c0 14             	add    $0x14,%eax
    7fd5:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
    7fd9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    7fdd:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    7fe1:	7e b1                	jle    7f94 <III_get_scale_factors+0xb6>
	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
    7fe3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7fe7:	83 7d f4 05          	cmpl   $0x5,-0xc(%ebp)
    7feb:	7e 9e                	jle    7f8b <III_get_scale_factors+0xad>
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
    7fed:	c7 45 f4 06 00 00 00 	movl   $0x6,-0xc(%ebp)
    7ff4:	eb 5f                	jmp    8055 <III_get_scale_factors+0x177>
				for (window=0; window<3; window++)
    7ff6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    7ffd:	eb 4c                	jmp    804b <III_get_scale_factors+0x16d>
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[1][gr_info->scalefac_compress]);
    7fff:	8b 45 e8             	mov    -0x18(%ebp),%eax
    8002:	8b 40 0c             	mov    0xc(%eax),%eax
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
    8005:	83 c0 10             	add    $0x10,%eax
    8008:	8b 04 85 e0 f0 00 00 	mov    0xf0e0(,%eax,4),%eax
    800f:	89 04 24             	mov    %eax,(%esp)
    8012:	e8 01 db ff ff       	call   5b18 <hgetbits>
    8017:	89 c6                	mov    %eax,%esi
    8019:	8b 5d 08             	mov    0x8(%ebp),%ebx
    801c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    801f:	8b 4d 14             	mov    0x14(%ebp),%ecx
    8022:	89 d0                	mov    %edx,%eax
    8024:	01 c0                	add    %eax,%eax
    8026:	01 d0                	add    %edx,%eax
    8028:	c1 e0 02             	shl    $0x2,%eax
    802b:	01 d0                	add    %edx,%eax
    802d:	89 ca                	mov    %ecx,%edx
    802f:	01 d2                	add    %edx,%edx
    8031:	89 d1                	mov    %edx,%ecx
    8033:	c1 e1 05             	shl    $0x5,%ecx
    8036:	29 d1                	sub    %edx,%ecx
    8038:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    803b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    803e:	01 d0                	add    %edx,%eax
    8040:	83 c0 14             	add    $0x14,%eax
    8043:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
				for (window=0; window<3; window++)
    8047:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    804b:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    804f:	7e ae                	jle    7fff <III_get_scale_factors+0x121>
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
    8051:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8055:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    8059:	7e 9b                	jle    7ff6 <III_get_scale_factors+0x118>
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
    805b:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    8062:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    8069:	eb 36                	jmp    80a1 <III_get_scale_factors+0x1c3>
				(*scalefac)[ch].s[window][sfb] = 0;
    806b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    806e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8071:	8b 4d 14             	mov    0x14(%ebp),%ecx
    8074:	89 d0                	mov    %edx,%eax
    8076:	01 c0                	add    %eax,%eax
    8078:	01 d0                	add    %edx,%eax
    807a:	c1 e0 02             	shl    $0x2,%eax
    807d:	01 d0                	add    %edx,%eax
    807f:	89 ca                	mov    %ecx,%edx
    8081:	01 d2                	add    %edx,%edx
    8083:	89 d1                	mov    %edx,%ecx
    8085:	c1 e1 05             	shl    $0x5,%ecx
    8088:	29 d1                	sub    %edx,%ecx
    808a:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    808d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8090:	01 d0                	add    %edx,%eax
    8092:	83 c0 14             	add    $0x14,%eax
    8095:	c7 44 83 0c 00 00 00 	movl   $0x0,0xc(%ebx,%eax,4)
    809c:	00 
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
    809d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    80a1:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    80a5:	7e c4                	jle    806b <III_get_scale_factors+0x18d>
{
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    80a7:	e9 b1 01 00 00       	jmp    825d <III_get_scale_factors+0x37f>
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
    80ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    80b3:	e9 8f 00 00 00       	jmp    8147 <III_get_scale_factors+0x269>
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
    80b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    80bb:	83 c0 04             	add    $0x4,%eax
    80be:	8b 04 85 c4 f0 00 00 	mov    0xf0c4(,%eax,4),%eax
    80c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    80c8:	eb 64                	jmp    812e <III_get_scale_factors+0x250>
					for (window=0; window<3; window++)
    80ca:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    80d1:	eb 51                	jmp    8124 <III_get_scale_factors+0x246>
						(*scalefac)[ch].s[window][sfb] = hgetbits(
							slen[i][gr_info->scalefac_compress]);
    80d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    80d6:	8b 40 0c             	mov    0xc(%eax),%eax
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
						(*scalefac)[ch].s[window][sfb] = hgetbits(
    80d9:	8b 55 f0             	mov    -0x10(%ebp),%edx
    80dc:	c1 e2 04             	shl    $0x4,%edx
    80df:	01 d0                	add    %edx,%eax
    80e1:	8b 04 85 e0 f0 00 00 	mov    0xf0e0(,%eax,4),%eax
    80e8:	89 04 24             	mov    %eax,(%esp)
    80eb:	e8 28 da ff ff       	call   5b18 <hgetbits>
    80f0:	89 c6                	mov    %eax,%esi
    80f2:	8b 5d 08             	mov    0x8(%ebp),%ebx
    80f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
    80f8:	8b 4d 14             	mov    0x14(%ebp),%ecx
    80fb:	89 d0                	mov    %edx,%eax
    80fd:	01 c0                	add    %eax,%eax
    80ff:	01 d0                	add    %edx,%eax
    8101:	c1 e0 02             	shl    $0x2,%eax
    8104:	01 d0                	add    %edx,%eax
    8106:	89 ca                	mov    %ecx,%edx
    8108:	01 d2                	add    %edx,%edx
    810a:	89 d1                	mov    %edx,%ecx
    810c:	c1 e1 05             	shl    $0x5,%ecx
    810f:	29 d1                	sub    %edx,%ecx
    8111:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    8114:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8117:	01 d0                	add    %edx,%eax
    8119:	83 c0 14             	add    $0x14,%eax
    811c:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
    8120:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8124:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    8128:	7e a9                	jle    80d3 <III_get_scale_factors+0x1f5>
			for (sfb=12,window=0; window<3; window++)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
    812a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    812e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8131:	83 c0 01             	add    $0x1,%eax
    8134:	83 c0 04             	add    $0x4,%eax
    8137:	8b 04 85 c4 f0 00 00 	mov    0xf0c4(,%eax,4),%eax
    813e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    8141:	7f 87                	jg     80ca <III_get_scale_factors+0x1ec>
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
    8143:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    8147:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    814b:	0f 8e 67 ff ff ff    	jle    80b8 <III_get_scale_factors+0x1da>
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
						(*scalefac)[ch].s[window][sfb] = hgetbits(
							slen[i][gr_info->scalefac_compress]);
				for (sfb=12,window=0; window<3; window++)
    8151:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    8158:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    815f:	eb 36                	jmp    8197 <III_get_scale_factors+0x2b9>
					(*scalefac)[ch].s[window][sfb] = 0;
    8161:	8b 5d 08             	mov    0x8(%ebp),%ebx
    8164:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8167:	8b 4d 14             	mov    0x14(%ebp),%ecx
    816a:	89 d0                	mov    %edx,%eax
    816c:	01 c0                	add    %eax,%eax
    816e:	01 d0                	add    %edx,%eax
    8170:	c1 e0 02             	shl    $0x2,%eax
    8173:	01 d0                	add    %edx,%eax
    8175:	89 ca                	mov    %ecx,%edx
    8177:	01 d2                	add    %edx,%edx
    8179:	89 d1                	mov    %edx,%ecx
    817b:	c1 e1 05             	shl    $0x5,%ecx
    817e:	29 d1                	sub    %edx,%ecx
    8180:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    8183:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8186:	01 d0                	add    %edx,%eax
    8188:	83 c0 14             	add    $0x14,%eax
    818b:	c7 44 83 0c 00 00 00 	movl   $0x0,0xc(%ebx,%eax,4)
    8192:	00 
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
						(*scalefac)[ch].s[window][sfb] = hgetbits(
							slen[i][gr_info->scalefac_compress]);
				for (sfb=12,window=0; window<3; window++)
    8193:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8197:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    819b:	7e c4                	jle    8161 <III_get_scale_factors+0x283>
{
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    819d:	e9 bb 00 00 00       	jmp    825d <III_get_scale_factors+0x37f>
				for (sfb=12,window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = 0;
		}
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
    81a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    81a9:	e9 89 00 00 00       	jmp    8237 <III_get_scale_factors+0x359>
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
    81ae:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    81b1:	8b 55 14             	mov    0x14(%ebp),%edx
    81b4:	89 d0                	mov    %edx,%eax
    81b6:	c1 e0 02             	shl    $0x2,%eax
    81b9:	01 d0                	add    %edx,%eax
    81bb:	c1 e0 03             	shl    $0x3,%eax
    81be:	8b 55 f0             	mov    -0x10(%ebp),%edx
    81c1:	01 d0                	add    %edx,%eax
    81c3:	8b 44 81 08          	mov    0x8(%ecx,%eax,4),%eax
    81c7:	85 c0                	test   %eax,%eax
    81c9:	74 06                	je     81d1 <III_get_scale_factors+0x2f3>
    81cb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    81cf:	75 62                	jne    8233 <III_get_scale_factors+0x355>
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
    81d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    81d4:	8b 04 85 c0 f0 00 00 	mov    0xf0c0(,%eax,4),%eax
    81db:	89 45 f4             	mov    %eax,-0xc(%ebp)
    81de:	eb 41                	jmp    8221 <III_get_scale_factors+0x343>
					(*scalefac)[ch].l[sfb] = hgetbits(
						slen[(i<2)?0:1][gr_info->scalefac_compress]);
    81e0:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    81e4:	0f 9f c0             	setg   %al
    81e7:	0f b6 d0             	movzbl %al,%edx
    81ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
    81ed:	8b 40 0c             	mov    0xc(%eax),%eax
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
					(*scalefac)[ch].l[sfb] = hgetbits(
    81f0:	c1 e2 04             	shl    $0x4,%edx
    81f3:	01 d0                	add    %edx,%eax
    81f5:	8b 04 85 e0 f0 00 00 	mov    0xf0e0(,%eax,4),%eax
    81fc:	89 04 24             	mov    %eax,(%esp)
    81ff:	e8 14 d9 ff ff       	call   5b18 <hgetbits>
    8204:	89 c3                	mov    %eax,%ebx
    8206:	8b 4d 08             	mov    0x8(%ebp),%ecx
    8209:	8b 45 14             	mov    0x14(%ebp),%eax
    820c:	01 c0                	add    %eax,%eax
    820e:	89 c2                	mov    %eax,%edx
    8210:	c1 e2 05             	shl    $0x5,%edx
    8213:	29 c2                	sub    %eax,%edx
    8215:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8218:	01 d0                	add    %edx,%eax
    821a:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
		}
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
    821d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8221:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8224:	83 c0 01             	add    $0x1,%eax
    8227:	8b 04 85 c0 f0 00 00 	mov    0xf0c0(,%eax,4),%eax
    822e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    8231:	7f ad                	jg     81e0 <III_get_scale_factors+0x302>
				for (sfb=12,window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = 0;
		}
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
    8233:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    8237:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    823b:	0f 8e 6d ff ff ff    	jle    81ae <III_get_scale_factors+0x2d0>
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
					(*scalefac)[ch].l[sfb] = hgetbits(
						slen[(i<2)?0:1][gr_info->scalefac_compress]);
		}
		(*scalefac)[ch].l[22] = 0;
    8241:	8b 4d 08             	mov    0x8(%ebp),%ecx
    8244:	8b 45 14             	mov    0x14(%ebp),%eax
    8247:	c1 e0 03             	shl    $0x3,%eax
    824a:	89 c2                	mov    %eax,%edx
    824c:	c1 e2 05             	shl    $0x5,%edx
    824f:	29 c2                	sub    %eax,%edx
    8251:	8d 04 11             	lea    (%ecx,%edx,1),%eax
    8254:	83 c0 58             	add    $0x58,%eax
    8257:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
}
    825d:	83 c4 20             	add    $0x20,%esp
    8260:	5b                   	pop    %ebx
    8261:	5e                   	pop    %esi
    8262:	5d                   	pop    %ebp
    8263:	c3                   	ret    

00008264 <initialize_huffman>:
struct huffcodetab ht[HTN];
*/
int huffman_initialized = FALSE;

void initialize_huffman()
{
    8264:	55                   	push   %ebp
    8265:	89 e5                	mov    %esp,%ebp
    8267:	83 ec 08             	sub    $0x8,%esp
	if (huffman_initialized) return;
    826a:	a1 20 f4 00 00       	mov    0xf420,%eax
    826f:	85 c0                	test   %eax,%eax
    8271:	74 02                	je     8275 <initialize_huffman+0x11>
    8273:	eb 0f                	jmp    8284 <initialize_huffman+0x20>
	read_decoder_table();
    8275:	e8 03 d9 ff ff       	call   5b7d <read_decoder_table>
	huffman_initialized = TRUE;
    827a:	c7 05 20 f4 00 00 01 	movl   $0x1,0xf420
    8281:	00 00 00 
}
    8284:	c9                   	leave  
    8285:	c3                   	ret    

00008286 <III_hufman_decode>:


void III_hufman_decode(long int is[SBLIMIT][SSLIMIT], struct III_side_info_t *si, int ch, int gr, int part2_start, struct frame_params *fr_ps)
{
    8286:	55                   	push   %ebp
    8287:	89 e5                	mov    %esp,%ebp
    8289:	57                   	push   %edi
    828a:	56                   	push   %esi
    828b:	53                   	push   %ebx
    828c:	83 ec 4c             	sub    $0x4c,%esp
   struct huffcodetab *h;
   int region1Start;
   int region2Start;
   //int bt = (*si).ch[ch].gr[gr].window_switching_flag && ((*si).ch[ch].gr[gr].block_type == 2);

   initialize_huffman();
    828f:	e8 d0 ff ff ff       	call   8264 <initialize_huffman>

   /* ��������߽� */

   if ( ((*si).ch[ch].gr[gr].window_switching_flag) &&
    8294:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8297:	8b 45 14             	mov    0x14(%ebp),%eax
    829a:	8b 4d 10             	mov    0x10(%ebp),%ecx
    829d:	89 c2                	mov    %eax,%edx
    829f:	c1 e2 03             	shl    $0x3,%edx
    82a2:	01 c2                	add    %eax,%edx
    82a4:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    82ab:	89 c2                	mov    %eax,%edx
    82ad:	89 c8                	mov    %ecx,%eax
    82af:	c1 e0 02             	shl    $0x2,%eax
    82b2:	01 c8                	add    %ecx,%eax
    82b4:	c1 e0 05             	shl    $0x5,%eax
    82b7:	01 d0                	add    %edx,%eax
    82b9:	01 d8                	add    %ebx,%eax
    82bb:	83 c0 28             	add    $0x28,%eax
    82be:	8b 00                	mov    (%eax),%eax
    82c0:	85 c0                	test   %eax,%eax
    82c2:	74 44                	je     8308 <III_hufman_decode+0x82>
        ((*si).ch[ch].gr[gr].block_type == 2) ) {
    82c4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    82c7:	8b 45 14             	mov    0x14(%ebp),%eax
    82ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
    82cd:	89 c2                	mov    %eax,%edx
    82cf:	c1 e2 03             	shl    $0x3,%edx
    82d2:	01 c2                	add    %eax,%edx
    82d4:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    82db:	89 c2                	mov    %eax,%edx
    82dd:	89 c8                	mov    %ecx,%eax
    82df:	c1 e0 02             	shl    $0x2,%eax
    82e2:	01 c8                	add    %ecx,%eax
    82e4:	c1 e0 05             	shl    $0x5,%eax
    82e7:	01 d0                	add    %edx,%eax
    82e9:	01 d8                	add    %ebx,%eax
    82eb:	83 c0 2c             	add    $0x2c,%eax
    82ee:	8b 00                	mov    (%eax),%eax

   initialize_huffman();

   /* ��������߽� */

   if ( ((*si).ch[ch].gr[gr].window_switching_flag) &&
    82f0:	83 f8 02             	cmp    $0x2,%eax
    82f3:	75 13                	jne    8308 <III_hufman_decode+0x82>
        ((*si).ch[ch].gr[gr].block_type == 2) ) {

      /* Region2. */

      region1Start = 36;  /* sfb[9/3]*3=36 */
    82f5:	c7 45 dc 24 00 00 00 	movl   $0x24,-0x24(%ebp)
      region2Start = 576; /* No Region2 for short block case. */
    82fc:	c7 45 d8 40 02 00 00 	movl   $0x240,-0x28(%ebp)
    8303:	e9 cc 00 00 00       	jmp    83d4 <III_hufman_decode+0x14e>
   }


   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
    8308:	8b 45 1c             	mov    0x1c(%ebp),%eax
    830b:	8b 00                	mov    (%eax),%eax
    830d:	8b 48 10             	mov    0x10(%eax),%ecx
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
    8310:	8b 75 0c             	mov    0xc(%ebp),%esi
    8313:	8b 45 14             	mov    0x14(%ebp),%eax
    8316:	8b 5d 10             	mov    0x10(%ebp),%ebx
    8319:	89 c2                	mov    %eax,%edx
    831b:	c1 e2 03             	shl    $0x3,%edx
    831e:	01 c2                	add    %eax,%edx
    8320:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8327:	89 c2                	mov    %eax,%edx
    8329:	89 d8                	mov    %ebx,%eax
    832b:	c1 e0 02             	shl    $0x2,%eax
    832e:	01 d8                	add    %ebx,%eax
    8330:	c1 e0 05             	shl    $0x5,%eax
    8333:	01 d0                	add    %edx,%eax
    8335:	01 f0                	add    %esi,%eax
    8337:	83 c0 4c             	add    $0x4c,%eax
    833a:	8b 00                	mov    (%eax),%eax
    833c:	8d 50 01             	lea    0x1(%eax),%edx
   }


   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
    833f:	89 c8                	mov    %ecx,%eax
    8341:	c1 e0 03             	shl    $0x3,%eax
    8344:	01 c8                	add    %ecx,%eax
    8346:	c1 e0 02             	shl    $0x2,%eax
    8349:	01 c8                	add    %ecx,%eax
    834b:	01 d0                	add    %edx,%eax
    834d:	8b 04 85 60 f1 00 00 	mov    0xf160(,%eax,4),%eax
    8354:	89 45 dc             	mov    %eax,-0x24(%ebp)
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
      region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
    8357:	8b 45 1c             	mov    0x1c(%ebp),%eax
    835a:	8b 00                	mov    (%eax),%eax
    835c:	8b 48 10             	mov    0x10(%eax),%ecx
                              .l[(*si).ch[ch].gr[gr].region0_count +
    835f:	8b 75 0c             	mov    0xc(%ebp),%esi
    8362:	8b 45 14             	mov    0x14(%ebp),%eax
    8365:	8b 5d 10             	mov    0x10(%ebp),%ebx
    8368:	89 c2                	mov    %eax,%edx
    836a:	c1 e2 03             	shl    $0x3,%edx
    836d:	01 c2                	add    %eax,%edx
    836f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8376:	89 c2                	mov    %eax,%edx
    8378:	89 d8                	mov    %ebx,%eax
    837a:	c1 e0 02             	shl    $0x2,%eax
    837d:	01 d8                	add    %ebx,%eax
    837f:	c1 e0 05             	shl    $0x5,%eax
    8382:	01 d0                	add    %edx,%eax
    8384:	01 f0                	add    %esi,%eax
    8386:	83 c0 4c             	add    $0x4c,%eax
    8389:	8b 30                	mov    (%eax),%esi
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
    838b:	8b 7d 0c             	mov    0xc(%ebp),%edi
    838e:	8b 45 14             	mov    0x14(%ebp),%eax
    8391:	8b 5d 10             	mov    0x10(%ebp),%ebx
    8394:	89 c2                	mov    %eax,%edx
    8396:	c1 e2 03             	shl    $0x3,%edx
    8399:	01 c2                	add    %eax,%edx
    839b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    83a2:	89 c2                	mov    %eax,%edx
    83a4:	89 d8                	mov    %ebx,%eax
    83a6:	c1 e0 02             	shl    $0x2,%eax
    83a9:	01 d8                	add    %ebx,%eax
    83ab:	c1 e0 05             	shl    $0x5,%eax
    83ae:	01 d0                	add    %edx,%eax
    83b0:	01 f8                	add    %edi,%eax
    83b2:	83 c0 50             	add    $0x50,%eax
    83b5:	8b 00                	mov    (%eax),%eax
   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
      region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
                              .l[(*si).ch[ch].gr[gr].region0_count +
    83b7:	01 f0                	add    %esi,%eax
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
    83b9:	8d 50 02             	lea    0x2(%eax),%edx

   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
      region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
    83bc:	89 c8                	mov    %ecx,%eax
    83be:	c1 e0 03             	shl    $0x3,%eax
    83c1:	01 c8                	add    %ecx,%eax
    83c3:	c1 e0 02             	shl    $0x2,%eax
    83c6:	01 c8                	add    %ecx,%eax
    83c8:	01 d0                	add    %edx,%eax
    83ca:	8b 04 85 60 f1 00 00 	mov    0xf160(,%eax,4),%eax
    83d1:	89 45 d8             	mov    %eax,-0x28(%ebp)
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
      }


   /* ��ȡ��ֵ����Read bigvalues area. */
   for (i=0; i<(*si).ch[ch].gr[gr].big_values*2; i+=2) {
    83d4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    83db:	e9 ac 01 00 00       	jmp    858c <III_hufman_decode+0x306>
      if      (i<region1Start) h = &ht[(*si).ch[ch].gr[gr].table_select[0]];
    83e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    83e3:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    83e6:	7d 43                	jge    842b <III_hufman_decode+0x1a5>
    83e8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    83eb:	8b 45 14             	mov    0x14(%ebp),%eax
    83ee:	8b 4d 10             	mov    0x10(%ebp),%ecx
    83f1:	89 c2                	mov    %eax,%edx
    83f3:	c1 e2 03             	shl    $0x3,%edx
    83f6:	01 c2                	add    %eax,%edx
    83f8:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    83ff:	89 c2                	mov    %eax,%edx
    8401:	89 c8                	mov    %ecx,%eax
    8403:	c1 e0 02             	shl    $0x2,%eax
    8406:	01 c8                	add    %ecx,%eax
    8408:	c1 e0 05             	shl    $0x5,%eax
    840b:	01 d0                	add    %edx,%eax
    840d:	01 d8                	add    %ebx,%eax
    840f:	83 c0 34             	add    $0x34,%eax
    8412:	8b 10                	mov    (%eax),%edx
    8414:	89 d0                	mov    %edx,%eax
    8416:	c1 e0 02             	shl    $0x2,%eax
    8419:	01 d0                	add    %edx,%eax
    841b:	c1 e0 03             	shl    $0x3,%eax
    841e:	05 00 26 01 00       	add    $0x12600,%eax
    8423:	89 45 e0             	mov    %eax,-0x20(%ebp)
    8426:	e9 86 00 00 00       	jmp    84b1 <III_hufman_decode+0x22b>
      else if (i<region2Start) h = &ht[(*si).ch[ch].gr[gr].table_select[1]];
    842b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    842e:	3b 45 d8             	cmp    -0x28(%ebp),%eax
    8431:	7d 40                	jge    8473 <III_hufman_decode+0x1ed>
    8433:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8436:	8b 45 14             	mov    0x14(%ebp),%eax
    8439:	8b 4d 10             	mov    0x10(%ebp),%ecx
    843c:	89 c2                	mov    %eax,%edx
    843e:	c1 e2 03             	shl    $0x3,%edx
    8441:	01 c2                	add    %eax,%edx
    8443:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    844a:	89 c2                	mov    %eax,%edx
    844c:	89 c8                	mov    %ecx,%eax
    844e:	c1 e0 02             	shl    $0x2,%eax
    8451:	01 c8                	add    %ecx,%eax
    8453:	c1 e0 05             	shl    $0x5,%eax
    8456:	01 d0                	add    %edx,%eax
    8458:	01 d8                	add    %ebx,%eax
    845a:	83 c0 38             	add    $0x38,%eax
    845d:	8b 10                	mov    (%eax),%edx
    845f:	89 d0                	mov    %edx,%eax
    8461:	c1 e0 02             	shl    $0x2,%eax
    8464:	01 d0                	add    %edx,%eax
    8466:	c1 e0 03             	shl    $0x3,%eax
    8469:	05 00 26 01 00       	add    $0x12600,%eax
    846e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    8471:	eb 3e                	jmp    84b1 <III_hufman_decode+0x22b>
           else                h = &ht[(*si).ch[ch].gr[gr].table_select[2]];
    8473:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8476:	8b 45 14             	mov    0x14(%ebp),%eax
    8479:	8b 4d 10             	mov    0x10(%ebp),%ecx
    847c:	89 c2                	mov    %eax,%edx
    847e:	c1 e2 03             	shl    $0x3,%edx
    8481:	01 c2                	add    %eax,%edx
    8483:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    848a:	89 c2                	mov    %eax,%edx
    848c:	89 c8                	mov    %ecx,%eax
    848e:	c1 e0 02             	shl    $0x2,%eax
    8491:	01 c8                	add    %ecx,%eax
    8493:	c1 e0 05             	shl    $0x5,%eax
    8496:	01 d0                	add    %edx,%eax
    8498:	01 d8                	add    %ebx,%eax
    849a:	83 c0 3c             	add    $0x3c,%eax
    849d:	8b 10                	mov    (%eax),%edx
    849f:	89 d0                	mov    %edx,%eax
    84a1:	c1 e0 02             	shl    $0x2,%eax
    84a4:	01 d0                	add    %edx,%eax
    84a6:	c1 e0 03             	shl    $0x3,%eax
    84a9:	05 00 26 01 00       	add    $0x12600,%eax
    84ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
      huffman_decoder(h, &x, &y, &v, &w);
    84b1:	8d 45 c8             	lea    -0x38(%ebp),%eax
    84b4:	89 44 24 10          	mov    %eax,0x10(%esp)
    84b8:	8d 45 cc             	lea    -0x34(%ebp),%eax
    84bb:	89 44 24 0c          	mov    %eax,0xc(%esp)
    84bf:	8d 45 d0             	lea    -0x30(%ebp),%eax
    84c2:	89 44 24 08          	mov    %eax,0x8(%esp)
    84c6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    84c9:	89 44 24 04          	mov    %eax,0x4(%esp)
    84cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    84d0:	89 04 24             	mov    %eax,(%esp)
    84d3:	e8 fd ee ff ff       	call   73d5 <huffman_decoder>
      is[i/SSLIMIT][i%SSLIMIT] = x;
    84d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    84db:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    84e0:	89 c8                	mov    %ecx,%eax
    84e2:	f7 ea                	imul   %edx
    84e4:	c1 fa 02             	sar    $0x2,%edx
    84e7:	89 c8                	mov    %ecx,%eax
    84e9:	c1 f8 1f             	sar    $0x1f,%eax
    84ec:	29 c2                	sub    %eax,%edx
    84ee:	89 d0                	mov    %edx,%eax
    84f0:	89 c2                	mov    %eax,%edx
    84f2:	89 d0                	mov    %edx,%eax
    84f4:	c1 e0 03             	shl    $0x3,%eax
    84f7:	01 d0                	add    %edx,%eax
    84f9:	c1 e0 03             	shl    $0x3,%eax
    84fc:	89 c2                	mov    %eax,%edx
    84fe:	8b 45 08             	mov    0x8(%ebp),%eax
    8501:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8504:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    8507:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    850c:	89 c8                	mov    %ecx,%eax
    850e:	f7 ea                	imul   %edx
    8510:	c1 fa 02             	sar    $0x2,%edx
    8513:	89 c8                	mov    %ecx,%eax
    8515:	c1 f8 1f             	sar    $0x1f,%eax
    8518:	29 c2                	sub    %eax,%edx
    851a:	89 d0                	mov    %edx,%eax
    851c:	c1 e0 03             	shl    $0x3,%eax
    851f:	01 d0                	add    %edx,%eax
    8521:	01 c0                	add    %eax,%eax
    8523:	29 c1                	sub    %eax,%ecx
    8525:	89 ca                	mov    %ecx,%edx
    8527:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    852a:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = y;
    852d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    8530:	8d 48 01             	lea    0x1(%eax),%ecx
    8533:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8538:	89 c8                	mov    %ecx,%eax
    853a:	f7 ea                	imul   %edx
    853c:	c1 fa 02             	sar    $0x2,%edx
    853f:	89 c8                	mov    %ecx,%eax
    8541:	c1 f8 1f             	sar    $0x1f,%eax
    8544:	29 c2                	sub    %eax,%edx
    8546:	89 d0                	mov    %edx,%eax
    8548:	89 c2                	mov    %eax,%edx
    854a:	89 d0                	mov    %edx,%eax
    854c:	c1 e0 03             	shl    $0x3,%eax
    854f:	01 d0                	add    %edx,%eax
    8551:	c1 e0 03             	shl    $0x3,%eax
    8554:	89 c2                	mov    %eax,%edx
    8556:	8b 45 08             	mov    0x8(%ebp),%eax
    8559:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    855c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    855f:	8d 48 01             	lea    0x1(%eax),%ecx
    8562:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8567:	89 c8                	mov    %ecx,%eax
    8569:	f7 ea                	imul   %edx
    856b:	c1 fa 02             	sar    $0x2,%edx
    856e:	89 c8                	mov    %ecx,%eax
    8570:	c1 f8 1f             	sar    $0x1f,%eax
    8573:	29 c2                	sub    %eax,%edx
    8575:	89 d0                	mov    %edx,%eax
    8577:	c1 e0 03             	shl    $0x3,%eax
    857a:	01 d0                	add    %edx,%eax
    857c:	01 c0                	add    %eax,%eax
    857e:	29 c1                	sub    %eax,%ecx
    8580:	89 ca                	mov    %ecx,%edx
    8582:	8b 45 d0             	mov    -0x30(%ebp),%eax
    8585:	89 04 93             	mov    %eax,(%ebx,%edx,4)
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
      }


   /* ��ȡ��ֵ����Read bigvalues area. */
   for (i=0; i<(*si).ch[ch].gr[gr].big_values*2; i+=2) {
    8588:	83 45 e4 02          	addl   $0x2,-0x1c(%ebp)
    858c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    858f:	8b 75 0c             	mov    0xc(%ebp),%esi
    8592:	8b 45 14             	mov    0x14(%ebp),%eax
    8595:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8598:	89 c2                	mov    %eax,%edx
    859a:	c1 e2 03             	shl    $0x3,%edx
    859d:	01 c2                	add    %eax,%edx
    859f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    85a6:	89 c2                	mov    %eax,%edx
    85a8:	89 c8                	mov    %ecx,%eax
    85aa:	c1 e0 02             	shl    $0x2,%eax
    85ad:	01 c8                	add    %ecx,%eax
    85af:	c1 e0 05             	shl    $0x5,%eax
    85b2:	01 d0                	add    %edx,%eax
    85b4:	01 f0                	add    %esi,%eax
    85b6:	83 c0 1c             	add    $0x1c,%eax
    85b9:	8b 00                	mov    (%eax),%eax
    85bb:	01 c0                	add    %eax,%eax
    85bd:	39 c3                	cmp    %eax,%ebx
    85bf:	0f 82 1b fe ff ff    	jb     83e0 <III_hufman_decode+0x15a>
      is[i/SSLIMIT][i%SSLIMIT] = x;
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = y;
      }

   /* Read count1 area. */
   h = &ht[(*si).ch[ch].gr[gr].count1table_select+32];
    85c5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    85c8:	8b 45 14             	mov    0x14(%ebp),%eax
    85cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
    85ce:	89 c2                	mov    %eax,%edx
    85d0:	c1 e2 03             	shl    $0x3,%edx
    85d3:	01 c2                	add    %eax,%edx
    85d5:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    85dc:	89 c2                	mov    %eax,%edx
    85de:	89 c8                	mov    %ecx,%eax
    85e0:	c1 e0 02             	shl    $0x2,%eax
    85e3:	01 c8                	add    %ecx,%eax
    85e5:	c1 e0 05             	shl    $0x5,%eax
    85e8:	01 d0                	add    %edx,%eax
    85ea:	01 d8                	add    %ebx,%eax
    85ec:	83 c0 5c             	add    $0x5c,%eax
    85ef:	8b 00                	mov    (%eax),%eax
    85f1:	8d 50 20             	lea    0x20(%eax),%edx
    85f4:	89 d0                	mov    %edx,%eax
    85f6:	c1 e0 02             	shl    $0x2,%eax
    85f9:	01 d0                	add    %edx,%eax
    85fb:	c1 e0 03             	shl    $0x3,%eax
    85fe:	05 00 26 01 00       	add    $0x12600,%eax
    8603:	89 45 e0             	mov    %eax,-0x20(%ebp)
   while ((hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length ) &&
    8606:	e9 91 01 00 00       	jmp    879c <III_hufman_decode+0x516>
     ( i < SSLIMIT*SBLIMIT )) {
      huffman_decoder(h, &x, &y, &v, &w);
    860b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    860e:	89 44 24 10          	mov    %eax,0x10(%esp)
    8612:	8d 45 cc             	lea    -0x34(%ebp),%eax
    8615:	89 44 24 0c          	mov    %eax,0xc(%esp)
    8619:	8d 45 d0             	lea    -0x30(%ebp),%eax
    861c:	89 44 24 08          	mov    %eax,0x8(%esp)
    8620:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    8623:	89 44 24 04          	mov    %eax,0x4(%esp)
    8627:	8b 45 e0             	mov    -0x20(%ebp),%eax
    862a:	89 04 24             	mov    %eax,(%esp)
    862d:	e8 a3 ed ff ff       	call   73d5 <huffman_decoder>
      is[i/SSLIMIT][i%SSLIMIT] = v;
    8632:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    8635:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    863a:	89 c8                	mov    %ecx,%eax
    863c:	f7 ea                	imul   %edx
    863e:	c1 fa 02             	sar    $0x2,%edx
    8641:	89 c8                	mov    %ecx,%eax
    8643:	c1 f8 1f             	sar    $0x1f,%eax
    8646:	29 c2                	sub    %eax,%edx
    8648:	89 d0                	mov    %edx,%eax
    864a:	89 c2                	mov    %eax,%edx
    864c:	89 d0                	mov    %edx,%eax
    864e:	c1 e0 03             	shl    $0x3,%eax
    8651:	01 d0                	add    %edx,%eax
    8653:	c1 e0 03             	shl    $0x3,%eax
    8656:	89 c2                	mov    %eax,%edx
    8658:	8b 45 08             	mov    0x8(%ebp),%eax
    865b:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    865e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    8661:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8666:	89 c8                	mov    %ecx,%eax
    8668:	f7 ea                	imul   %edx
    866a:	c1 fa 02             	sar    $0x2,%edx
    866d:	89 c8                	mov    %ecx,%eax
    866f:	c1 f8 1f             	sar    $0x1f,%eax
    8672:	29 c2                	sub    %eax,%edx
    8674:	89 d0                	mov    %edx,%eax
    8676:	c1 e0 03             	shl    $0x3,%eax
    8679:	01 d0                	add    %edx,%eax
    867b:	01 c0                	add    %eax,%eax
    867d:	29 c1                	sub    %eax,%ecx
    867f:	89 ca                	mov    %ecx,%edx
    8681:	8b 45 cc             	mov    -0x34(%ebp),%eax
    8684:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = w;
    8687:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    868a:	8d 48 01             	lea    0x1(%eax),%ecx
    868d:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8692:	89 c8                	mov    %ecx,%eax
    8694:	f7 ea                	imul   %edx
    8696:	c1 fa 02             	sar    $0x2,%edx
    8699:	89 c8                	mov    %ecx,%eax
    869b:	c1 f8 1f             	sar    $0x1f,%eax
    869e:	29 c2                	sub    %eax,%edx
    86a0:	89 d0                	mov    %edx,%eax
    86a2:	89 c2                	mov    %eax,%edx
    86a4:	89 d0                	mov    %edx,%eax
    86a6:	c1 e0 03             	shl    $0x3,%eax
    86a9:	01 d0                	add    %edx,%eax
    86ab:	c1 e0 03             	shl    $0x3,%eax
    86ae:	89 c2                	mov    %eax,%edx
    86b0:	8b 45 08             	mov    0x8(%ebp),%eax
    86b3:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    86b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    86b9:	8d 48 01             	lea    0x1(%eax),%ecx
    86bc:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    86c1:	89 c8                	mov    %ecx,%eax
    86c3:	f7 ea                	imul   %edx
    86c5:	c1 fa 02             	sar    $0x2,%edx
    86c8:	89 c8                	mov    %ecx,%eax
    86ca:	c1 f8 1f             	sar    $0x1f,%eax
    86cd:	29 c2                	sub    %eax,%edx
    86cf:	89 d0                	mov    %edx,%eax
    86d1:	c1 e0 03             	shl    $0x3,%eax
    86d4:	01 d0                	add    %edx,%eax
    86d6:	01 c0                	add    %eax,%eax
    86d8:	29 c1                	sub    %eax,%ecx
    86da:	89 ca                	mov    %ecx,%edx
    86dc:	8b 45 c8             	mov    -0x38(%ebp),%eax
    86df:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+2)/SSLIMIT][(i+2)%SSLIMIT] = x;
    86e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    86e5:	8d 48 02             	lea    0x2(%eax),%ecx
    86e8:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    86ed:	89 c8                	mov    %ecx,%eax
    86ef:	f7 ea                	imul   %edx
    86f1:	c1 fa 02             	sar    $0x2,%edx
    86f4:	89 c8                	mov    %ecx,%eax
    86f6:	c1 f8 1f             	sar    $0x1f,%eax
    86f9:	29 c2                	sub    %eax,%edx
    86fb:	89 d0                	mov    %edx,%eax
    86fd:	89 c2                	mov    %eax,%edx
    86ff:	89 d0                	mov    %edx,%eax
    8701:	c1 e0 03             	shl    $0x3,%eax
    8704:	01 d0                	add    %edx,%eax
    8706:	c1 e0 03             	shl    $0x3,%eax
    8709:	89 c2                	mov    %eax,%edx
    870b:	8b 45 08             	mov    0x8(%ebp),%eax
    870e:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8711:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    8714:	8d 48 02             	lea    0x2(%eax),%ecx
    8717:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    871c:	89 c8                	mov    %ecx,%eax
    871e:	f7 ea                	imul   %edx
    8720:	c1 fa 02             	sar    $0x2,%edx
    8723:	89 c8                	mov    %ecx,%eax
    8725:	c1 f8 1f             	sar    $0x1f,%eax
    8728:	29 c2                	sub    %eax,%edx
    872a:	89 d0                	mov    %edx,%eax
    872c:	c1 e0 03             	shl    $0x3,%eax
    872f:	01 d0                	add    %edx,%eax
    8731:	01 c0                	add    %eax,%eax
    8733:	29 c1                	sub    %eax,%ecx
    8735:	89 ca                	mov    %ecx,%edx
    8737:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    873a:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+3)/SSLIMIT][(i+3)%SSLIMIT] = y;
    873d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    8740:	8d 48 03             	lea    0x3(%eax),%ecx
    8743:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8748:	89 c8                	mov    %ecx,%eax
    874a:	f7 ea                	imul   %edx
    874c:	c1 fa 02             	sar    $0x2,%edx
    874f:	89 c8                	mov    %ecx,%eax
    8751:	c1 f8 1f             	sar    $0x1f,%eax
    8754:	29 c2                	sub    %eax,%edx
    8756:	89 d0                	mov    %edx,%eax
    8758:	89 c2                	mov    %eax,%edx
    875a:	89 d0                	mov    %edx,%eax
    875c:	c1 e0 03             	shl    $0x3,%eax
    875f:	01 d0                	add    %edx,%eax
    8761:	c1 e0 03             	shl    $0x3,%eax
    8764:	89 c2                	mov    %eax,%edx
    8766:	8b 45 08             	mov    0x8(%ebp),%eax
    8769:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    876c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    876f:	8d 48 03             	lea    0x3(%eax),%ecx
    8772:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8777:	89 c8                	mov    %ecx,%eax
    8779:	f7 ea                	imul   %edx
    877b:	c1 fa 02             	sar    $0x2,%edx
    877e:	89 c8                	mov    %ecx,%eax
    8780:	c1 f8 1f             	sar    $0x1f,%eax
    8783:	29 c2                	sub    %eax,%edx
    8785:	89 d0                	mov    %edx,%eax
    8787:	c1 e0 03             	shl    $0x3,%eax
    878a:	01 d0                	add    %edx,%eax
    878c:	01 c0                	add    %eax,%eax
    878e:	29 c1                	sub    %eax,%ecx
    8790:	89 ca                	mov    %ecx,%edx
    8792:	8b 45 d0             	mov    -0x30(%ebp),%eax
    8795:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      i += 4;
    8798:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = y;
      }

   /* Read count1 area. */
   h = &ht[(*si).ch[ch].gr[gr].count1table_select+32];
   while ((hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length ) &&
    879c:	e8 5b d3 ff ff       	call   5afc <hsstell>
    87a1:	89 c3                	mov    %eax,%ebx
    87a3:	8b 75 0c             	mov    0xc(%ebp),%esi
    87a6:	8b 45 14             	mov    0x14(%ebp),%eax
    87a9:	8b 4d 10             	mov    0x10(%ebp),%ecx
    87ac:	89 c2                	mov    %eax,%edx
    87ae:	c1 e2 03             	shl    $0x3,%edx
    87b1:	01 c2                	add    %eax,%edx
    87b3:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    87ba:	89 c2                	mov    %eax,%edx
    87bc:	89 c8                	mov    %ecx,%eax
    87be:	c1 e0 02             	shl    $0x2,%eax
    87c1:	01 c8                	add    %ecx,%eax
    87c3:	c1 e0 05             	shl    $0x5,%eax
    87c6:	01 d0                	add    %edx,%eax
    87c8:	01 f0                	add    %esi,%eax
    87ca:	83 c0 18             	add    $0x18,%eax
    87cd:	8b 10                	mov    (%eax),%edx
    87cf:	8b 45 18             	mov    0x18(%ebp),%eax
    87d2:	01 d0                	add    %edx,%eax
    87d4:	39 c3                	cmp    %eax,%ebx
    87d6:	73 0d                	jae    87e5 <III_hufman_decode+0x55f>
    87d8:	81 7d e4 3f 02 00 00 	cmpl   $0x23f,-0x1c(%ebp)
    87df:	0f 8e 26 fe ff ff    	jle    860b <III_hufman_decode+0x385>
      is[(i+2)/SSLIMIT][(i+2)%SSLIMIT] = x;
      is[(i+3)/SSLIMIT][(i+3)%SSLIMIT] = y;
      i += 4;
      }

   if (hsstell() > part2_start + (*si).ch[ch].gr[gr].part2_3_length)
    87e5:	e8 12 d3 ff ff       	call   5afc <hsstell>
    87ea:	89 c3                	mov    %eax,%ebx
    87ec:	8b 75 0c             	mov    0xc(%ebp),%esi
    87ef:	8b 45 14             	mov    0x14(%ebp),%eax
    87f2:	8b 4d 10             	mov    0x10(%ebp),%ecx
    87f5:	89 c2                	mov    %eax,%edx
    87f7:	c1 e2 03             	shl    $0x3,%edx
    87fa:	01 c2                	add    %eax,%edx
    87fc:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8803:	89 c2                	mov    %eax,%edx
    8805:	89 c8                	mov    %ecx,%eax
    8807:	c1 e0 02             	shl    $0x2,%eax
    880a:	01 c8                	add    %ecx,%eax
    880c:	c1 e0 05             	shl    $0x5,%eax
    880f:	01 d0                	add    %edx,%eax
    8811:	01 f0                	add    %esi,%eax
    8813:	83 c0 18             	add    $0x18,%eax
    8816:	8b 10                	mov    (%eax),%edx
    8818:	8b 45 18             	mov    0x18(%ebp),%eax
    881b:	01 d0                	add    %edx,%eax
    881d:	39 c3                	cmp    %eax,%ebx
    881f:	76 48                	jbe    8869 <III_hufman_decode+0x5e3>
   {  i -=4;
    8821:	83 6d e4 04          	subl   $0x4,-0x1c(%ebp)
      rewindNbits(hsstell()-part2_start - (*si).ch[ch].gr[gr].part2_3_length);
    8825:	e8 d2 d2 ff ff       	call   5afc <hsstell>
    882a:	8b 55 18             	mov    0x18(%ebp),%edx
    882d:	29 d0                	sub    %edx,%eax
    882f:	89 c6                	mov    %eax,%esi
    8831:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    8834:	8b 45 14             	mov    0x14(%ebp),%eax
    8837:	8b 4d 10             	mov    0x10(%ebp),%ecx
    883a:	89 c2                	mov    %eax,%edx
    883c:	c1 e2 03             	shl    $0x3,%edx
    883f:	01 c2                	add    %eax,%edx
    8841:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8848:	89 c2                	mov    %eax,%edx
    884a:	89 c8                	mov    %ecx,%eax
    884c:	c1 e0 02             	shl    $0x2,%eax
    884f:	01 c8                	add    %ecx,%eax
    8851:	c1 e0 05             	shl    $0x5,%eax
    8854:	01 d0                	add    %edx,%eax
    8856:	01 d8                	add    %ebx,%eax
    8858:	83 c0 18             	add    $0x18,%eax
    885b:	8b 00                	mov    (%eax),%eax
    885d:	29 c6                	sub    %eax,%esi
    885f:	89 f0                	mov    %esi,%eax
    8861:	89 04 24             	mov    %eax,(%esp)
    8864:	e8 de d2 ff ff       	call   5b47 <rewindNbits>
   }

   /* Dismiss stuffing Bits */
   if ( hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length )
    8869:	e8 8e d2 ff ff       	call   5afc <hsstell>
    886e:	89 c3                	mov    %eax,%ebx
    8870:	8b 75 0c             	mov    0xc(%ebp),%esi
    8873:	8b 45 14             	mov    0x14(%ebp),%eax
    8876:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8879:	89 c2                	mov    %eax,%edx
    887b:	c1 e2 03             	shl    $0x3,%edx
    887e:	01 c2                	add    %eax,%edx
    8880:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    8887:	89 c2                	mov    %eax,%edx
    8889:	89 c8                	mov    %ecx,%eax
    888b:	c1 e0 02             	shl    $0x2,%eax
    888e:	01 c8                	add    %ecx,%eax
    8890:	c1 e0 05             	shl    $0x5,%eax
    8893:	01 d0                	add    %edx,%eax
    8895:	01 f0                	add    %esi,%eax
    8897:	83 c0 18             	add    $0x18,%eax
    889a:	8b 10                	mov    (%eax),%edx
    889c:	8b 45 18             	mov    0x18(%ebp),%eax
    889f:	01 d0                	add    %edx,%eax
    88a1:	39 c3                	cmp    %eax,%ebx
    88a3:	73 45                	jae    88ea <III_hufman_decode+0x664>
      hgetbits( part2_start + (*si).ch[ch].gr[gr].part2_3_length - hsstell());
    88a5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    88a8:	8b 45 14             	mov    0x14(%ebp),%eax
    88ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
    88ae:	89 c2                	mov    %eax,%edx
    88b0:	c1 e2 03             	shl    $0x3,%edx
    88b3:	01 c2                	add    %eax,%edx
    88b5:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    88bc:	89 c2                	mov    %eax,%edx
    88be:	89 c8                	mov    %ecx,%eax
    88c0:	c1 e0 02             	shl    $0x2,%eax
    88c3:	01 c8                	add    %ecx,%eax
    88c5:	c1 e0 05             	shl    $0x5,%eax
    88c8:	01 d0                	add    %edx,%eax
    88ca:	01 d8                	add    %ebx,%eax
    88cc:	83 c0 18             	add    $0x18,%eax
    88cf:	8b 10                	mov    (%eax),%edx
    88d1:	8b 45 18             	mov    0x18(%ebp),%eax
    88d4:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    88d7:	e8 20 d2 ff ff       	call   5afc <hsstell>
    88dc:	29 c3                	sub    %eax,%ebx
    88de:	89 d8                	mov    %ebx,%eax
    88e0:	89 04 24             	mov    %eax,(%esp)
    88e3:	e8 30 d2 ff ff       	call   5b18 <hgetbits>

   /* Zero out rest. */
   for (; i<SSLIMIT*SBLIMIT; i++)
    88e8:	eb 5c                	jmp    8946 <III_hufman_decode+0x6c0>
    88ea:	eb 5a                	jmp    8946 <III_hufman_decode+0x6c0>
      is[i/SSLIMIT][i%SSLIMIT] = 0;
    88ec:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    88ef:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    88f4:	89 c8                	mov    %ecx,%eax
    88f6:	f7 ea                	imul   %edx
    88f8:	c1 fa 02             	sar    $0x2,%edx
    88fb:	89 c8                	mov    %ecx,%eax
    88fd:	c1 f8 1f             	sar    $0x1f,%eax
    8900:	29 c2                	sub    %eax,%edx
    8902:	89 d0                	mov    %edx,%eax
    8904:	89 c2                	mov    %eax,%edx
    8906:	89 d0                	mov    %edx,%eax
    8908:	c1 e0 03             	shl    $0x3,%eax
    890b:	01 d0                	add    %edx,%eax
    890d:	c1 e0 03             	shl    $0x3,%eax
    8910:	89 c2                	mov    %eax,%edx
    8912:	8b 45 08             	mov    0x8(%ebp),%eax
    8915:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8918:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    891b:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    8920:	89 c8                	mov    %ecx,%eax
    8922:	f7 ea                	imul   %edx
    8924:	c1 fa 02             	sar    $0x2,%edx
    8927:	89 c8                	mov    %ecx,%eax
    8929:	c1 f8 1f             	sar    $0x1f,%eax
    892c:	29 c2                	sub    %eax,%edx
    892e:	89 d0                	mov    %edx,%eax
    8930:	c1 e0 03             	shl    $0x3,%eax
    8933:	01 d0                	add    %edx,%eax
    8935:	01 c0                	add    %eax,%eax
    8937:	29 c1                	sub    %eax,%ecx
    8939:	89 ca                	mov    %ecx,%edx
    893b:	c7 04 93 00 00 00 00 	movl   $0x0,(%ebx,%edx,4)
   /* Dismiss stuffing Bits */
   if ( hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length )
      hgetbits( part2_start + (*si).ch[ch].gr[gr].part2_3_length - hsstell());

   /* Zero out rest. */
   for (; i<SSLIMIT*SBLIMIT; i++)
    8942:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    8946:	81 7d e4 3f 02 00 00 	cmpl   $0x23f,-0x1c(%ebp)
    894d:	7e 9d                	jle    88ec <III_hufman_decode+0x666>
      is[i/SSLIMIT][i%SSLIMIT] = 0;
}
    894f:	83 c4 4c             	add    $0x4c,%esp
    8952:	5b                   	pop    %ebx
    8953:	5e                   	pop    %esi
    8954:	5f                   	pop    %edi
    8955:	5d                   	pop    %ebp
    8956:	c3                   	ret    

00008957 <III_dequantize_sample>:


int pretab[22] = {0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,2,2,3,3,3,2,0};

void III_dequantize_sample(long int is[SBLIMIT][SSLIMIT], double xr[SBLIMIT][SSLIMIT], III_scalefac_t *scalefac, struct gr_info_s *gr_info, int ch, struct frame_params *fr_ps)
{
    8957:	55                   	push   %ebp
    8958:	89 e5                	mov    %esp,%ebp
    895a:	56                   	push   %esi
    895b:	53                   	push   %ebx
    895c:	83 ec 50             	sub    $0x50,%esp
	int ss,sb,cb=0,sfreq=fr_ps->header->sampling_frequency;
    895f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    8966:	8b 45 1c             	mov    0x1c(%ebp),%eax
    8969:	8b 00                	mov    (%eax),%eax
    896b:	8b 40 10             	mov    0x10(%eax),%eax
    896e:	89 45 dc             	mov    %eax,-0x24(%ebp)
	//int stereo = fr_ps->stereo;
	int next_cb_boundary, cb_begin, cb_width = 0, sign;
    8971:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)

	/* choose correct scalefactor band per block type, initalize boundary */

	if (gr_info->window_switching_flag && (gr_info->block_type == 2) )
    8978:	8b 45 14             	mov    0x14(%ebp),%eax
    897b:	8b 40 10             	mov    0x10(%eax),%eax
    897e:	85 c0                	test   %eax,%eax
    8980:	74 61                	je     89e3 <III_dequantize_sample+0x8c>
    8982:	8b 45 14             	mov    0x14(%ebp),%eax
    8985:	8b 40 14             	mov    0x14(%eax),%eax
    8988:	83 f8 02             	cmp    $0x2,%eax
    898b:	75 56                	jne    89e3 <III_dequantize_sample+0x8c>
		if (gr_info->mixed_block_flag)
    898d:	8b 45 14             	mov    0x14(%ebp),%eax
    8990:	8b 40 18             	mov    0x18(%eax),%eax
    8993:	85 c0                	test   %eax,%eax
    8995:	74 15                	je     89ac <III_dequantize_sample+0x55>
			next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
    8997:	8b 45 dc             	mov    -0x24(%ebp),%eax
    899a:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    89a0:	05 64 f1 00 00       	add    $0xf164,%eax
    89a5:	8b 00                	mov    (%eax),%eax
    89a7:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int next_cb_boundary, cb_begin, cb_width = 0, sign;

	/* choose correct scalefactor band per block type, initalize boundary */

	if (gr_info->window_switching_flag && (gr_info->block_type == 2) )
		if (gr_info->mixed_block_flag)
    89aa:	eb 4a                	jmp    89f6 <III_dequantize_sample+0x9f>
			next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
		else {
			next_cb_boundary=sfBandIndex[sfreq].s[1]*3; /* pure SHORT block */
    89ac:	8b 45 dc             	mov    -0x24(%ebp),%eax
    89af:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    89b5:	05 b4 f1 00 00       	add    $0xf1b4,%eax
    89ba:	8b 50 0c             	mov    0xc(%eax),%edx
    89bd:	89 d0                	mov    %edx,%eax
    89bf:	01 c0                	add    %eax,%eax
    89c1:	01 d0                	add    %edx,%eax
    89c3:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cb_width = sfBandIndex[sfreq].s[1];
    89c6:	8b 45 dc             	mov    -0x24(%ebp),%eax
    89c9:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    89cf:	05 b4 f1 00 00       	add    $0xf1b4,%eax
    89d4:	8b 40 0c             	mov    0xc(%eax),%eax
    89d7:	89 45 e0             	mov    %eax,-0x20(%ebp)
			cb_begin = 0;
    89da:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	int next_cb_boundary, cb_begin, cb_width = 0, sign;

	/* choose correct scalefactor band per block type, initalize boundary */

	if (gr_info->window_switching_flag && (gr_info->block_type == 2) )
		if (gr_info->mixed_block_flag)
    89e1:	eb 13                	jmp    89f6 <III_dequantize_sample+0x9f>
			next_cb_boundary=sfBandIndex[sfreq].s[1]*3; /* pure SHORT block */
			cb_width = sfBandIndex[sfreq].s[1];
			cb_begin = 0;
		}
	else
		next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
    89e3:	8b 45 dc             	mov    -0x24(%ebp),%eax
    89e6:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    89ec:	05 64 f1 00 00       	add    $0xf164,%eax
    89f1:	8b 00                	mov    (%eax),%eax
    89f3:	89 45 e8             	mov    %eax,-0x18(%ebp)

	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
    89f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    89fd:	e9 3d 06 00 00       	jmp    903f <III_dequantize_sample+0x6e8>
		for (ss=0 ; ss < SSLIMIT ; ss++) {
    8a02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8a09:	e9 23 06 00 00       	jmp    9031 <III_dequantize_sample+0x6da>
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
    8a0e:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8a11:	89 d0                	mov    %edx,%eax
    8a13:	c1 e0 03             	shl    $0x3,%eax
    8a16:	01 d0                	add    %edx,%eax
    8a18:	01 c0                	add    %eax,%eax
    8a1a:	89 c2                	mov    %eax,%edx
    8a1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8a1f:	01 d0                	add    %edx,%eax
    8a21:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    8a24:	0f 85 9e 02 00 00    	jne    8cc8 <III_dequantize_sample+0x371>
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    8a2a:	8b 45 14             	mov    0x14(%ebp),%eax
    8a2d:	8b 40 10             	mov    0x10(%eax),%eax
    8a30:	85 c0                	test   %eax,%eax
    8a32:	0f 84 6b 02 00 00    	je     8ca3 <III_dequantize_sample+0x34c>
    8a38:	8b 45 14             	mov    0x14(%ebp),%eax
    8a3b:	8b 40 14             	mov    0x14(%eax),%eax
    8a3e:	83 f8 02             	cmp    $0x2,%eax
    8a41:	0f 85 5c 02 00 00    	jne    8ca3 <III_dequantize_sample+0x34c>
					if (gr_info->mixed_block_flag) {
    8a47:	8b 45 14             	mov    0x14(%ebp),%eax
    8a4a:	8b 40 18             	mov    0x18(%eax),%eax
    8a4d:	85 c0                	test   %eax,%eax
    8a4f:	0f 84 af 01 00 00    	je     8c04 <III_dequantize_sample+0x2ad>
						if (((sb*18)+ss) == sfBandIndex[sfreq].l[8])  {
    8a55:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8a58:	89 d0                	mov    %edx,%eax
    8a5a:	c1 e0 03             	shl    $0x3,%eax
    8a5d:	01 d0                	add    %edx,%eax
    8a5f:	01 c0                	add    %eax,%eax
    8a61:	89 c2                	mov    %eax,%edx
    8a63:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8a66:	01 c2                	add    %eax,%edx
    8a68:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8a6b:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8a71:	05 80 f1 00 00       	add    $0xf180,%eax
    8a76:	8b 00                	mov    (%eax),%eax
    8a78:	39 c2                	cmp    %eax,%edx
    8a7a:	0f 85 93 00 00 00    	jne    8b13 <III_dequantize_sample+0x1bc>
							next_cb_boundary=sfBandIndex[sfreq].s[4]*3;
    8a80:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8a83:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8a89:	05 c0 f1 00 00       	add    $0xf1c0,%eax
    8a8e:	8b 50 0c             	mov    0xc(%eax),%edx
    8a91:	89 d0                	mov    %edx,%eax
    8a93:	01 c0                	add    %eax,%eax
    8a95:	01 d0                	add    %edx,%eax
    8a97:	89 45 e8             	mov    %eax,-0x18(%ebp)
							cb = 3;
    8a9a:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    8aa1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8aa4:	8d 48 01             	lea    0x1(%eax),%ecx
    8aa7:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8aaa:	89 d0                	mov    %edx,%eax
    8aac:	c1 e0 03             	shl    $0x3,%eax
    8aaf:	01 d0                	add    %edx,%eax
    8ab1:	c1 e0 02             	shl    $0x2,%eax
    8ab4:	01 d0                	add    %edx,%eax
    8ab6:	01 c8                	add    %ecx,%eax
    8ab8:	83 c0 14             	add    $0x14,%eax
    8abb:	8b 0c 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%ecx
										sfBandIndex[sfreq].s[cb];
    8ac2:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8ac5:	89 d0                	mov    %edx,%eax
    8ac7:	c1 e0 03             	shl    $0x3,%eax
    8aca:	01 d0                	add    %edx,%eax
    8acc:	c1 e0 02             	shl    $0x2,%eax
    8acf:	01 d0                	add    %edx,%eax
    8ad1:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8ad4:	01 d0                	add    %edx,%eax
    8ad6:	83 c0 14             	add    $0x14,%eax
    8ad9:	8b 04 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%eax
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
						if (((sb*18)+ss) == sfBandIndex[sfreq].l[8])  {
							next_cb_boundary=sfBandIndex[sfreq].s[4]*3;
							cb = 3;
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    8ae0:	29 c1                	sub    %eax,%ecx
    8ae2:	89 c8                	mov    %ecx,%eax
    8ae4:	89 45 e0             	mov    %eax,-0x20(%ebp)
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
    8ae7:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8aea:	89 d0                	mov    %edx,%eax
    8aec:	c1 e0 03             	shl    $0x3,%eax
    8aef:	01 d0                	add    %edx,%eax
    8af1:	c1 e0 02             	shl    $0x2,%eax
    8af4:	01 d0                	add    %edx,%eax
    8af6:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8af9:	01 d0                	add    %edx,%eax
    8afb:	83 c0 14             	add    $0x14,%eax
    8afe:	8b 14 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%edx
    8b05:	89 d0                	mov    %edx,%eax
    8b07:	01 c0                	add    %eax,%eax
    8b09:	01 d0                	add    %edx,%eax
    8b0b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    8b0e:	e9 8e 01 00 00       	jmp    8ca1 <III_dequantize_sample+0x34a>
						}
						else if (((sb*18)+ss) < sfBandIndex[sfreq].l[8])
    8b13:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8b16:	89 d0                	mov    %edx,%eax
    8b18:	c1 e0 03             	shl    $0x3,%eax
    8b1b:	01 d0                	add    %edx,%eax
    8b1d:	01 c0                	add    %eax,%eax
    8b1f:	89 c2                	mov    %eax,%edx
    8b21:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8b24:	01 c2                	add    %eax,%edx
    8b26:	8b 45 dc             	mov    -0x24(%ebp),%eax
    8b29:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    8b2f:	05 80 f1 00 00       	add    $0xf180,%eax
    8b34:	8b 00                	mov    (%eax),%eax
    8b36:	39 c2                	cmp    %eax,%edx
    8b38:	7d 2a                	jge    8b64 <III_dequantize_sample+0x20d>
							next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
    8b3a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8b3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8b41:	8d 48 01             	lea    0x1(%eax),%ecx
    8b44:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8b47:	89 d0                	mov    %edx,%eax
    8b49:	c1 e0 03             	shl    $0x3,%eax
    8b4c:	01 d0                	add    %edx,%eax
    8b4e:	c1 e0 02             	shl    $0x2,%eax
    8b51:	01 d0                	add    %edx,%eax
    8b53:	01 c8                	add    %ecx,%eax
    8b55:	8b 04 85 60 f1 00 00 	mov    0xf160(,%eax,4),%eax
    8b5c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    8b5f:	e9 3d 01 00 00       	jmp    8ca1 <III_dequantize_sample+0x34a>
						else {
							next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
    8b64:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8b68:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8b6b:	8d 48 01             	lea    0x1(%eax),%ecx
    8b6e:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8b71:	89 d0                	mov    %edx,%eax
    8b73:	c1 e0 03             	shl    $0x3,%eax
    8b76:	01 d0                	add    %edx,%eax
    8b78:	c1 e0 02             	shl    $0x2,%eax
    8b7b:	01 d0                	add    %edx,%eax
    8b7d:	01 c8                	add    %ecx,%eax
    8b7f:	83 c0 14             	add    $0x14,%eax
    8b82:	8b 14 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%edx
    8b89:	89 d0                	mov    %edx,%eax
    8b8b:	01 c0                	add    %eax,%eax
    8b8d:	01 d0                	add    %edx,%eax
    8b8f:	89 45 e8             	mov    %eax,-0x18(%ebp)
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    8b92:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8b95:	8d 48 01             	lea    0x1(%eax),%ecx
    8b98:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8b9b:	89 d0                	mov    %edx,%eax
    8b9d:	c1 e0 03             	shl    $0x3,%eax
    8ba0:	01 d0                	add    %edx,%eax
    8ba2:	c1 e0 02             	shl    $0x2,%eax
    8ba5:	01 d0                	add    %edx,%eax
    8ba7:	01 c8                	add    %ecx,%eax
    8ba9:	83 c0 14             	add    $0x14,%eax
    8bac:	8b 0c 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%ecx
										sfBandIndex[sfreq].s[cb];
    8bb3:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8bb6:	89 d0                	mov    %edx,%eax
    8bb8:	c1 e0 03             	shl    $0x3,%eax
    8bbb:	01 d0                	add    %edx,%eax
    8bbd:	c1 e0 02             	shl    $0x2,%eax
    8bc0:	01 d0                	add    %edx,%eax
    8bc2:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8bc5:	01 d0                	add    %edx,%eax
    8bc7:	83 c0 14             	add    $0x14,%eax
    8bca:	8b 04 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%eax
						}
						else if (((sb*18)+ss) < sfBandIndex[sfreq].l[8])
							next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
						else {
							next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    8bd1:	29 c1                	sub    %eax,%ecx
    8bd3:	89 c8                	mov    %ecx,%eax
    8bd5:	89 45 e0             	mov    %eax,-0x20(%ebp)
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
    8bd8:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8bdb:	89 d0                	mov    %edx,%eax
    8bdd:	c1 e0 03             	shl    $0x3,%eax
    8be0:	01 d0                	add    %edx,%eax
    8be2:	c1 e0 02             	shl    $0x2,%eax
    8be5:	01 d0                	add    %edx,%eax
    8be7:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8bea:	01 d0                	add    %edx,%eax
    8bec:	83 c0 14             	add    $0x14,%eax
    8bef:	8b 14 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%edx
    8bf6:	89 d0                	mov    %edx,%eax
    8bf8:	01 c0                	add    %eax,%eax
    8bfa:	01 d0                	add    %edx,%eax
    8bfc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
    8bff:	e9 c4 00 00 00       	jmp    8cc8 <III_dequantize_sample+0x371>
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
						}
					}
					else {
						next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
    8c04:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8c08:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8c0b:	8d 48 01             	lea    0x1(%eax),%ecx
    8c0e:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8c11:	89 d0                	mov    %edx,%eax
    8c13:	c1 e0 03             	shl    $0x3,%eax
    8c16:	01 d0                	add    %edx,%eax
    8c18:	c1 e0 02             	shl    $0x2,%eax
    8c1b:	01 d0                	add    %edx,%eax
    8c1d:	01 c8                	add    %ecx,%eax
    8c1f:	83 c0 14             	add    $0x14,%eax
    8c22:	8b 14 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%edx
    8c29:	89 d0                	mov    %edx,%eax
    8c2b:	01 c0                	add    %eax,%eax
    8c2d:	01 d0                	add    %edx,%eax
    8c2f:	89 45 e8             	mov    %eax,-0x18(%ebp)
						cb_width = sfBandIndex[sfreq].s[cb+1] -
    8c32:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8c35:	8d 48 01             	lea    0x1(%eax),%ecx
    8c38:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8c3b:	89 d0                	mov    %edx,%eax
    8c3d:	c1 e0 03             	shl    $0x3,%eax
    8c40:	01 d0                	add    %edx,%eax
    8c42:	c1 e0 02             	shl    $0x2,%eax
    8c45:	01 d0                	add    %edx,%eax
    8c47:	01 c8                	add    %ecx,%eax
    8c49:	83 c0 14             	add    $0x14,%eax
    8c4c:	8b 0c 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%ecx
									sfBandIndex[sfreq].s[cb];
    8c53:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8c56:	89 d0                	mov    %edx,%eax
    8c58:	c1 e0 03             	shl    $0x3,%eax
    8c5b:	01 d0                	add    %edx,%eax
    8c5d:	c1 e0 02             	shl    $0x2,%eax
    8c60:	01 d0                	add    %edx,%eax
    8c62:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8c65:	01 d0                	add    %edx,%eax
    8c67:	83 c0 14             	add    $0x14,%eax
    8c6a:	8b 04 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%eax
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
						}
					}
					else {
						next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
						cb_width = sfBandIndex[sfreq].s[cb+1] -
    8c71:	29 c1                	sub    %eax,%ecx
    8c73:	89 c8                	mov    %ecx,%eax
    8c75:	89 45 e0             	mov    %eax,-0x20(%ebp)
									sfBandIndex[sfreq].s[cb];
						cb_begin = sfBandIndex[sfreq].s[cb]*3;
    8c78:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8c7b:	89 d0                	mov    %edx,%eax
    8c7d:	c1 e0 03             	shl    $0x3,%eax
    8c80:	01 d0                	add    %edx,%eax
    8c82:	c1 e0 02             	shl    $0x2,%eax
    8c85:	01 d0                	add    %edx,%eax
    8c87:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8c8a:	01 d0                	add    %edx,%eax
    8c8c:	83 c0 14             	add    $0x14,%eax
    8c8f:	8b 14 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%edx
    8c96:	89 d0                	mov    %edx,%eax
    8c98:	01 c0                	add    %eax,%eax
    8c9a:	01 d0                	add    %edx,%eax
    8c9c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
    8c9f:	eb 27                	jmp    8cc8 <III_dequantize_sample+0x371>
    8ca1:	eb 25                	jmp    8cc8 <III_dequantize_sample+0x371>
									sfBandIndex[sfreq].s[cb];
						cb_begin = sfBandIndex[sfreq].s[cb]*3;
					}
				}
	            else /* long blocks */
		           next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
    8ca3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8ca7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8caa:	8d 48 01             	lea    0x1(%eax),%ecx
    8cad:	8b 55 dc             	mov    -0x24(%ebp),%edx
    8cb0:	89 d0                	mov    %edx,%eax
    8cb2:	c1 e0 03             	shl    $0x3,%eax
    8cb5:	01 d0                	add    %edx,%eax
    8cb7:	c1 e0 02             	shl    $0x2,%eax
    8cba:	01 d0                	add    %edx,%eax
    8cbc:	01 c8                	add    %ecx,%eax
    8cbe:	8b 04 85 60 f1 00 00 	mov    0xf160(,%eax,4),%eax
    8cc5:	89 45 e8             	mov    %eax,-0x18(%ebp)
			}

			/* Compute overall (global) scaling. */
			xr[sb][ss] = pow( 2.0 , (0.25 * (gr_info->global_gain - 210.0)));
    8cc8:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8ccb:	89 d0                	mov    %edx,%eax
    8ccd:	c1 e0 03             	shl    $0x3,%eax
    8cd0:	01 d0                	add    %edx,%eax
    8cd2:	c1 e0 04             	shl    $0x4,%eax
    8cd5:	89 c2                	mov    %eax,%edx
    8cd7:	8b 45 0c             	mov    0xc(%ebp),%eax
    8cda:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8cdd:	8b 45 14             	mov    0x14(%ebp),%eax
    8ce0:	8b 40 08             	mov    0x8(%eax),%eax
    8ce3:	ba 00 00 00 00       	mov    $0x0,%edx
    8ce8:	89 45 c8             	mov    %eax,-0x38(%ebp)
    8ceb:	89 55 cc             	mov    %edx,-0x34(%ebp)
    8cee:	df 6d c8             	fildll -0x38(%ebp)
    8cf1:	dd 05 30 dd 00 00    	fldl   0xdd30
    8cf7:	de e9                	fsubrp %st,%st(1)
    8cf9:	dd 05 38 dd 00 00    	fldl   0xdd38
    8cff:	de c9                	fmulp  %st,%st(1)
    8d01:	dd 5c 24 08          	fstpl  0x8(%esp)
    8d05:	dd 05 40 dd 00 00    	fldl   0xdd40
    8d0b:	dd 1c 24             	fstpl  (%esp)
    8d0e:	e8 0c c1 ff ff       	call   4e1f <pow>
    8d13:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8d16:	dd 1c c3             	fstpl  (%ebx,%eax,8)

			/* Do long/short dependent scaling operations. */

			if (gr_info->window_switching_flag && (
    8d19:	8b 45 14             	mov    0x14(%ebp),%eax
    8d1c:	8b 40 10             	mov    0x10(%eax),%eax
    8d1f:	85 c0                	test   %eax,%eax
    8d21:	0f 84 86 01 00 00    	je     8ead <III_dequantize_sample+0x556>
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    8d27:	8b 45 14             	mov    0x14(%ebp),%eax
    8d2a:	8b 40 14             	mov    0x14(%eax),%eax
			/* Compute overall (global) scaling. */
			xr[sb][ss] = pow( 2.0 , (0.25 * (gr_info->global_gain - 210.0)));

			/* Do long/short dependent scaling operations. */

			if (gr_info->window_switching_flag && (
    8d2d:	83 f8 02             	cmp    $0x2,%eax
    8d30:	75 0a                	jne    8d3c <III_dequantize_sample+0x3e5>
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    8d32:	8b 45 14             	mov    0x14(%ebp),%eax
    8d35:	8b 40 18             	mov    0x18(%eax),%eax
    8d38:	85 c0                	test   %eax,%eax
    8d3a:	74 27                	je     8d63 <III_dequantize_sample+0x40c>
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {
    8d3c:	8b 45 14             	mov    0x14(%ebp),%eax
    8d3f:	8b 40 14             	mov    0x14(%eax),%eax
			xr[sb][ss] = pow( 2.0 , (0.25 * (gr_info->global_gain - 210.0)));

			/* Do long/short dependent scaling operations. */

			if (gr_info->window_switching_flag && (
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    8d42:	83 f8 02             	cmp    $0x2,%eax
    8d45:	0f 85 62 01 00 00    	jne    8ead <III_dequantize_sample+0x556>
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {
    8d4b:	8b 45 14             	mov    0x14(%ebp),%eax
    8d4e:	8b 40 18             	mov    0x18(%eax),%eax
    8d51:	85 c0                	test   %eax,%eax
    8d53:	0f 84 54 01 00 00    	je     8ead <III_dequantize_sample+0x556>
    8d59:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    8d5d:	0f 8e 4a 01 00 00    	jle    8ead <III_dequantize_sample+0x556>

				xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
    8d63:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8d66:	89 d0                	mov    %edx,%eax
    8d68:	c1 e0 03             	shl    $0x3,%eax
    8d6b:	01 d0                	add    %edx,%eax
    8d6d:	c1 e0 04             	shl    $0x4,%eax
    8d70:	89 c2                	mov    %eax,%edx
    8d72:	8b 45 0c             	mov    0xc(%ebp),%eax
    8d75:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8d78:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8d7b:	89 d0                	mov    %edx,%eax
    8d7d:	c1 e0 03             	shl    $0x3,%eax
    8d80:	01 d0                	add    %edx,%eax
    8d82:	c1 e0 04             	shl    $0x4,%eax
    8d85:	89 c2                	mov    %eax,%edx
    8d87:	8b 45 0c             	mov    0xc(%ebp),%eax
    8d8a:	01 c2                	add    %eax,%edx
    8d8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8d8f:	dd 04 c2             	fldl   (%edx,%eax,8)
    8d92:	dd 5d c0             	fstpl  -0x40(%ebp)
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
    8d95:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8d98:	89 d0                	mov    %edx,%eax
    8d9a:	c1 e0 03             	shl    $0x3,%eax
    8d9d:	01 d0                	add    %edx,%eax
    8d9f:	01 c0                	add    %eax,%eax
    8da1:	89 c2                	mov    %eax,%edx
    8da3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8da6:	01 d0                	add    %edx,%eax
    8da8:	2b 45 e4             	sub    -0x1c(%ebp),%eax
    8dab:	99                   	cltd   
    8dac:	f7 7d e0             	idivl  -0x20(%ebp)
    8daf:	89 c2                	mov    %eax,%edx
    8db1:	8b 45 14             	mov    0x14(%ebp),%eax
    8db4:	83 c2 08             	add    $0x8,%edx
    8db7:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax

			if (gr_info->window_switching_flag && (
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {

				xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
    8dbb:	ba 00 00 00 00       	mov    $0x0,%edx
    8dc0:	89 45 c8             	mov    %eax,-0x38(%ebp)
    8dc3:	89 55 cc             	mov    %edx,-0x34(%ebp)
    8dc6:	df 6d c8             	fildll -0x38(%ebp)
    8dc9:	dd 05 48 dd 00 00    	fldl   0xdd48
    8dcf:	de c9                	fmulp  %st,%st(1)
    8dd1:	dd 5c 24 08          	fstpl  0x8(%esp)
    8dd5:	dd 05 40 dd 00 00    	fldl   0xdd40
    8ddb:	dd 1c 24             	fstpl  (%esp)
    8dde:	e8 3c c0 ff ff       	call   4e1f <pow>
    8de3:	dc 4d c0             	fmull  -0x40(%ebp)
    8de6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8de9:	dd 1c c3             	fstpl  (%ebx,%eax,8)
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
				xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0+gr_info->scalefac_scale)
    8dec:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8def:	89 d0                	mov    %edx,%eax
    8df1:	c1 e0 03             	shl    $0x3,%eax
    8df4:	01 d0                	add    %edx,%eax
    8df6:	c1 e0 04             	shl    $0x4,%eax
    8df9:	89 c2                	mov    %eax,%edx
    8dfb:	8b 45 0c             	mov    0xc(%ebp),%eax
    8dfe:	8d 34 02             	lea    (%edx,%eax,1),%esi
    8e01:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8e04:	89 d0                	mov    %edx,%eax
    8e06:	c1 e0 03             	shl    $0x3,%eax
    8e09:	01 d0                	add    %edx,%eax
    8e0b:	c1 e0 04             	shl    $0x4,%eax
    8e0e:	89 c2                	mov    %eax,%edx
    8e10:	8b 45 0c             	mov    0xc(%ebp),%eax
    8e13:	01 c2                	add    %eax,%edx
    8e15:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8e18:	dd 04 c2             	fldl   (%edx,%eax,8)
    8e1b:	dd 5d c0             	fstpl  -0x40(%ebp)
    8e1e:	8b 45 14             	mov    0x14(%ebp),%eax
    8e21:	8b 40 40             	mov    0x40(%eax),%eax
    8e24:	ba 00 00 00 00       	mov    $0x0,%edx
    8e29:	89 45 c8             	mov    %eax,-0x38(%ebp)
    8e2c:	89 55 cc             	mov    %edx,-0x34(%ebp)
    8e2f:	df 6d c8             	fildll -0x38(%ebp)
    8e32:	d9 e8                	fld1   
    8e34:	de c1                	faddp  %st,%st(1)
    8e36:	dd 05 50 dd 00 00    	fldl   0xdd50
    8e3c:	de c9                	fmulp  %st,%st(1)
						* (*scalefac)[ch].s[(((sb*18)+ss) - cb_begin)/cb_width][cb]);
    8e3e:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8e41:	89 d0                	mov    %edx,%eax
    8e43:	c1 e0 03             	shl    $0x3,%eax
    8e46:	01 d0                	add    %edx,%eax
    8e48:	01 c0                	add    %eax,%eax
    8e4a:	89 c2                	mov    %eax,%edx
    8e4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8e4f:	01 d0                	add    %edx,%eax
    8e51:	2b 45 e4             	sub    -0x1c(%ebp),%eax
    8e54:	99                   	cltd   
    8e55:	f7 7d e0             	idivl  -0x20(%ebp)
    8e58:	89 c2                	mov    %eax,%edx
    8e5a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    8e5d:	8b 4d 18             	mov    0x18(%ebp),%ecx
    8e60:	89 d0                	mov    %edx,%eax
    8e62:	01 c0                	add    %eax,%eax
    8e64:	01 d0                	add    %edx,%eax
    8e66:	c1 e0 02             	shl    $0x2,%eax
    8e69:	01 d0                	add    %edx,%eax
    8e6b:	89 ca                	mov    %ecx,%edx
    8e6d:	01 d2                	add    %edx,%edx
    8e6f:	89 d1                	mov    %edx,%ecx
    8e71:	c1 e1 05             	shl    $0x5,%ecx
    8e74:	29 d1                	sub    %edx,%ecx
    8e76:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    8e79:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8e7c:	01 d0                	add    %edx,%eax
    8e7e:	83 c0 14             	add    $0x14,%eax
    8e81:	8b 44 83 0c          	mov    0xc(%ebx,%eax,4),%eax
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {

				xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
				xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0+gr_info->scalefac_scale)
    8e85:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    8e88:	db 45 d4             	fildl  -0x2c(%ebp)
    8e8b:	de c9                	fmulp  %st,%st(1)
    8e8d:	dd 5c 24 08          	fstpl  0x8(%esp)
    8e91:	dd 05 40 dd 00 00    	fldl   0xdd40
    8e97:	dd 1c 24             	fstpl  (%esp)
    8e9a:	e8 80 bf ff ff       	call   4e1f <pow>
    8e9f:	dc 4d c0             	fmull  -0x40(%ebp)
    8ea2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8ea5:	dd 1c c6             	fstpl  (%esi,%eax,8)
    8ea8:	e9 ab 00 00 00       	jmp    8f58 <III_dequantize_sample+0x601>
						* (*scalefac)[ch].s[(((sb*18)+ss) - cb_begin)/cb_width][cb]);
			}
			else {   /* LONG block types 0,1,3 & 1st 2 subbands of switched blocks */
				xr[sb][ss] *= pow(2.0, -0.5 * (1.0+gr_info->scalefac_scale)
    8ead:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8eb0:	89 d0                	mov    %edx,%eax
    8eb2:	c1 e0 03             	shl    $0x3,%eax
    8eb5:	01 d0                	add    %edx,%eax
    8eb7:	c1 e0 04             	shl    $0x4,%eax
    8eba:	89 c2                	mov    %eax,%edx
    8ebc:	8b 45 0c             	mov    0xc(%ebp),%eax
    8ebf:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8ec2:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8ec5:	89 d0                	mov    %edx,%eax
    8ec7:	c1 e0 03             	shl    $0x3,%eax
    8eca:	01 d0                	add    %edx,%eax
    8ecc:	c1 e0 04             	shl    $0x4,%eax
    8ecf:	89 c2                	mov    %eax,%edx
    8ed1:	8b 45 0c             	mov    0xc(%ebp),%eax
    8ed4:	01 c2                	add    %eax,%edx
    8ed6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8ed9:	dd 04 c2             	fldl   (%edx,%eax,8)
    8edc:	dd 5d c0             	fstpl  -0x40(%ebp)
    8edf:	8b 45 14             	mov    0x14(%ebp),%eax
    8ee2:	8b 40 40             	mov    0x40(%eax),%eax
    8ee5:	ba 00 00 00 00       	mov    $0x0,%edx
    8eea:	89 45 c8             	mov    %eax,-0x38(%ebp)
    8eed:	89 55 cc             	mov    %edx,-0x34(%ebp)
    8ef0:	df 6d c8             	fildll -0x38(%ebp)
    8ef3:	d9 e8                	fld1   
    8ef5:	de c1                	faddp  %st,%st(1)
    8ef7:	dd 05 50 dd 00 00    	fldl   0xdd50
    8efd:	de c9                	fmulp  %st,%st(1)
								* ((*scalefac)[ch].l[cb]
    8eff:	8b 4d 10             	mov    0x10(%ebp),%ecx
    8f02:	8b 45 18             	mov    0x18(%ebp),%eax
    8f05:	01 c0                	add    %eax,%eax
    8f07:	89 c2                	mov    %eax,%edx
    8f09:	c1 e2 05             	shl    $0x5,%edx
    8f0c:	29 c2                	sub    %eax,%edx
    8f0e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8f11:	01 d0                	add    %edx,%eax
    8f13:	8b 04 81             	mov    (%ecx,%eax,4),%eax
								+ gr_info->preflag * pretab[cb]));
    8f16:	89 c2                	mov    %eax,%edx
    8f18:	8b 45 14             	mov    0x14(%ebp),%eax
    8f1b:	8b 48 3c             	mov    0x3c(%eax),%ecx
    8f1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8f21:	8b 04 85 20 f3 00 00 	mov    0xf320(,%eax,4),%eax
    8f28:	0f af c1             	imul   %ecx,%eax
    8f2b:	01 d0                	add    %edx,%eax
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
				xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0+gr_info->scalefac_scale)
						* (*scalefac)[ch].s[(((sb*18)+ss) - cb_begin)/cb_width][cb]);
			}
			else {   /* LONG block types 0,1,3 & 1st 2 subbands of switched blocks */
				xr[sb][ss] *= pow(2.0, -0.5 * (1.0+gr_info->scalefac_scale)
    8f2d:	ba 00 00 00 00       	mov    $0x0,%edx
    8f32:	89 45 c8             	mov    %eax,-0x38(%ebp)
    8f35:	89 55 cc             	mov    %edx,-0x34(%ebp)
    8f38:	df 6d c8             	fildll -0x38(%ebp)
    8f3b:	de c9                	fmulp  %st,%st(1)
    8f3d:	dd 5c 24 08          	fstpl  0x8(%esp)
    8f41:	dd 05 40 dd 00 00    	fldl   0xdd40
    8f47:	dd 1c 24             	fstpl  (%esp)
    8f4a:	e8 d0 be ff ff       	call   4e1f <pow>
    8f4f:	dc 4d c0             	fmull  -0x40(%ebp)
    8f52:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8f55:	dd 1c c3             	fstpl  (%ebx,%eax,8)
								+ gr_info->preflag * pretab[cb]));
			}

			/* Scale quantized value. */

			sign = (is[sb][ss]<0) ? 1 : 0;
    8f58:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8f5b:	89 d0                	mov    %edx,%eax
    8f5d:	c1 e0 03             	shl    $0x3,%eax
    8f60:	01 d0                	add    %edx,%eax
    8f62:	c1 e0 03             	shl    $0x3,%eax
    8f65:	89 c2                	mov    %eax,%edx
    8f67:	8b 45 08             	mov    0x8(%ebp),%eax
    8f6a:	01 c2                	add    %eax,%edx
    8f6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8f6f:	8b 04 82             	mov    (%edx,%eax,4),%eax
    8f72:	c1 e8 1f             	shr    $0x1f,%eax
    8f75:	0f b6 c0             	movzbl %al,%eax
    8f78:	89 45 d8             	mov    %eax,-0x28(%ebp)
			xr[sb][ss] *= pow( (double) abs(is[sb][ss]), ((double)4.0/3.0) );
    8f7b:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8f7e:	89 d0                	mov    %edx,%eax
    8f80:	c1 e0 03             	shl    $0x3,%eax
    8f83:	01 d0                	add    %edx,%eax
    8f85:	c1 e0 04             	shl    $0x4,%eax
    8f88:	89 c2                	mov    %eax,%edx
    8f8a:	8b 45 0c             	mov    0xc(%ebp),%eax
    8f8d:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8f90:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8f93:	89 d0                	mov    %edx,%eax
    8f95:	c1 e0 03             	shl    $0x3,%eax
    8f98:	01 d0                	add    %edx,%eax
    8f9a:	c1 e0 04             	shl    $0x4,%eax
    8f9d:	89 c2                	mov    %eax,%edx
    8f9f:	8b 45 0c             	mov    0xc(%ebp),%eax
    8fa2:	01 c2                	add    %eax,%edx
    8fa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8fa7:	dd 04 c2             	fldl   (%edx,%eax,8)
    8faa:	dd 5d c0             	fstpl  -0x40(%ebp)
    8fad:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8fb0:	89 d0                	mov    %edx,%eax
    8fb2:	c1 e0 03             	shl    $0x3,%eax
    8fb5:	01 d0                	add    %edx,%eax
    8fb7:	c1 e0 03             	shl    $0x3,%eax
    8fba:	89 c2                	mov    %eax,%edx
    8fbc:	8b 45 08             	mov    0x8(%ebp),%eax
    8fbf:	01 c2                	add    %eax,%edx
    8fc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8fc4:	8b 04 82             	mov    (%edx,%eax,4),%eax
    8fc7:	89 04 24             	mov    %eax,(%esp)
    8fca:	e8 47 bd ff ff       	call   4d16 <abs>
    8fcf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    8fd2:	db 45 d4             	fildl  -0x2c(%ebp)
    8fd5:	dd 05 58 dd 00 00    	fldl   0xdd58
    8fdb:	dd 5c 24 08          	fstpl  0x8(%esp)
    8fdf:	dd 1c 24             	fstpl  (%esp)
    8fe2:	e8 38 be ff ff       	call   4e1f <pow>
    8fe7:	dc 4d c0             	fmull  -0x40(%ebp)
    8fea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8fed:	dd 1c c3             	fstpl  (%ebx,%eax,8)
			if (sign) xr[sb][ss] = -xr[sb][ss];
    8ff0:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    8ff4:	74 37                	je     902d <III_dequantize_sample+0x6d6>
    8ff6:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8ff9:	89 d0                	mov    %edx,%eax
    8ffb:	c1 e0 03             	shl    $0x3,%eax
    8ffe:	01 d0                	add    %edx,%eax
    9000:	c1 e0 04             	shl    $0x4,%eax
    9003:	89 c2                	mov    %eax,%edx
    9005:	8b 45 0c             	mov    0xc(%ebp),%eax
    9008:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    900b:	8b 55 f0             	mov    -0x10(%ebp),%edx
    900e:	89 d0                	mov    %edx,%eax
    9010:	c1 e0 03             	shl    $0x3,%eax
    9013:	01 d0                	add    %edx,%eax
    9015:	c1 e0 04             	shl    $0x4,%eax
    9018:	89 c2                	mov    %eax,%edx
    901a:	8b 45 0c             	mov    0xc(%ebp),%eax
    901d:	01 c2                	add    %eax,%edx
    901f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9022:	dd 04 c2             	fldl   (%edx,%eax,8)
    9025:	d9 e0                	fchs   
    9027:	8b 45 f4             	mov    -0xc(%ebp),%eax
    902a:	dd 1c c1             	fstpl  (%ecx,%eax,8)
	else
		next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */

	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
    902d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    9031:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    9035:	0f 8e d3 f9 ff ff    	jle    8a0e <III_dequantize_sample+0xb7>
		}
	else
		next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */

	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
    903b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    903f:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    9043:	0f 8e b9 f9 ff ff    	jle    8a02 <III_dequantize_sample+0xab>
			sign = (is[sb][ss]<0) ? 1 : 0;
			xr[sb][ss] *= pow( (double) abs(is[sb][ss]), ((double)4.0/3.0) );
			if (sign) xr[sb][ss] = -xr[sb][ss];
		}
	}
}
    9049:	83 c4 50             	add    $0x50,%esp
    904c:	5b                   	pop    %ebx
    904d:	5e                   	pop    %esi
    904e:	5d                   	pop    %ebp
    904f:	c3                   	ret    

00009050 <III_reorder>:


void III_reorder(double xr[SBLIMIT][SSLIMIT], double ro[SBLIMIT][SSLIMIT], struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
    9050:	55                   	push   %ebp
    9051:	89 e5                	mov    %esp,%ebp
    9053:	57                   	push   %edi
    9054:	56                   	push   %esi
    9055:	53                   	push   %ebx
    9056:	83 ec 34             	sub    $0x34,%esp
   int sfreq=fr_ps->header->sampling_frequency;
    9059:	8b 45 14             	mov    0x14(%ebp),%eax
    905c:	8b 00                	mov    (%eax),%eax
    905e:	8b 40 10             	mov    0x10(%eax),%eax
    9061:	89 45 d0             	mov    %eax,-0x30(%ebp)
   int sfb, sfb_start, sfb_lines;
   int sb, ss, window, freq, src_line, des_line;

   for(sb=0;sb<SBLIMIT;sb++)
    9064:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    906b:	eb 33                	jmp    90a0 <III_reorder+0x50>
      for(ss=0;ss<SSLIMIT;ss++)
    906d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    9074:	eb 20                	jmp    9096 <III_reorder+0x46>
         ro[sb][ss] = 0;
    9076:	8b 55 e0             	mov    -0x20(%ebp),%edx
    9079:	89 d0                	mov    %edx,%eax
    907b:	c1 e0 03             	shl    $0x3,%eax
    907e:	01 d0                	add    %edx,%eax
    9080:	c1 e0 04             	shl    $0x4,%eax
    9083:	89 c2                	mov    %eax,%edx
    9085:	8b 45 0c             	mov    0xc(%ebp),%eax
    9088:	01 c2                	add    %eax,%edx
    908a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    908d:	d9 ee                	fldz   
    908f:	dd 1c c2             	fstpl  (%edx,%eax,8)
   int sfreq=fr_ps->header->sampling_frequency;
   int sfb, sfb_start, sfb_lines;
   int sb, ss, window, freq, src_line, des_line;

   for(sb=0;sb<SBLIMIT;sb++)
      for(ss=0;ss<SSLIMIT;ss++)
    9092:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    9096:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    909a:	7e da                	jle    9076 <III_reorder+0x26>
{
   int sfreq=fr_ps->header->sampling_frequency;
   int sfb, sfb_start, sfb_lines;
   int sb, ss, window, freq, src_line, des_line;

   for(sb=0;sb<SBLIMIT;sb++)
    909c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    90a0:	83 7d e0 1f          	cmpl   $0x1f,-0x20(%ebp)
    90a4:	7e c7                	jle    906d <III_reorder+0x1d>
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    90a6:	8b 45 10             	mov    0x10(%ebp),%eax
    90a9:	8b 40 10             	mov    0x10(%eax),%eax
    90ac:	85 c0                	test   %eax,%eax
    90ae:	0f 84 af 03 00 00    	je     9463 <III_reorder+0x413>
    90b4:	8b 45 10             	mov    0x10(%ebp),%eax
    90b7:	8b 40 14             	mov    0x14(%eax),%eax
    90ba:	83 f8 02             	cmp    $0x2,%eax
    90bd:	0f 85 a0 03 00 00    	jne    9463 <III_reorder+0x413>
      if (gr_info->mixed_block_flag) {
    90c3:	8b 45 10             	mov    0x10(%ebp),%eax
    90c6:	8b 40 18             	mov    0x18(%eax),%eax
    90c9:	85 c0                	test   %eax,%eax
    90cb:	0f 84 00 02 00 00    	je     92d1 <III_reorder+0x281>
         for (sb=0 ; sb < 2 ; sb++)
    90d1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    90d8:	eb 4c                	jmp    9126 <III_reorder+0xd6>
            for (ss=0 ; ss < SSLIMIT ; ss++) {
    90da:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    90e1:	eb 39                	jmp    911c <III_reorder+0xcc>
               ro[sb][ss] = xr[sb][ss];
    90e3:	8b 55 e0             	mov    -0x20(%ebp),%edx
    90e6:	89 d0                	mov    %edx,%eax
    90e8:	c1 e0 03             	shl    $0x3,%eax
    90eb:	01 d0                	add    %edx,%eax
    90ed:	c1 e0 04             	shl    $0x4,%eax
    90f0:	89 c2                	mov    %eax,%edx
    90f2:	8b 45 0c             	mov    0xc(%ebp),%eax
    90f5:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    90f8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    90fb:	89 d0                	mov    %edx,%eax
    90fd:	c1 e0 03             	shl    $0x3,%eax
    9100:	01 d0                	add    %edx,%eax
    9102:	c1 e0 04             	shl    $0x4,%eax
    9105:	89 c2                	mov    %eax,%edx
    9107:	8b 45 08             	mov    0x8(%ebp),%eax
    910a:	01 c2                	add    %eax,%edx
    910c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    910f:	dd 04 c2             	fldl   (%edx,%eax,8)
    9112:	8b 45 dc             	mov    -0x24(%ebp),%eax
    9115:	dd 1c c1             	fstpl  (%ecx,%eax,8)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
            for (ss=0 ; ss < SSLIMIT ; ss++) {
    9118:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    911c:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    9120:	7e c1                	jle    90e3 <III_reorder+0x93>
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
    9122:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    9126:	83 7d e0 01          	cmpl   $0x1,-0x20(%ebp)
    912a:	7e ae                	jle    90da <III_reorder+0x8a>
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
    912c:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
    9133:	8b 45 d0             	mov    -0x30(%ebp),%eax
    9136:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    913c:	05 bc f1 00 00       	add    $0xf1bc,%eax
    9141:	8b 40 0c             	mov    0xc(%eax),%eax
    9144:	89 45 e8             	mov    %eax,-0x18(%ebp)
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
    9147:	8b 45 d0             	mov    -0x30(%ebp),%eax
    914a:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9150:	05 c0 f1 00 00       	add    $0xf1c0,%eax
    9155:	8b 40 0c             	mov    0xc(%eax),%eax
    9158:	2b 45 e8             	sub    -0x18(%ebp),%eax
    915b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
    915e:	e9 5f 01 00 00       	jmp    92c2 <III_reorder+0x272>
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    9163:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    916a:	e9 fd 00 00 00       	jmp    926c <III_reorder+0x21c>
                  for(freq=0;freq<sfb_lines;freq++) {
    916f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    9176:	e9 e1 00 00 00       	jmp    925c <III_reorder+0x20c>
                     src_line = sfb_start*3 + window*sfb_lines + freq;
    917b:	8b 55 e8             	mov    -0x18(%ebp),%edx
    917e:	89 d0                	mov    %edx,%eax
    9180:	01 c0                	add    %eax,%eax
    9182:	01 c2                	add    %eax,%edx
    9184:	8b 45 d8             	mov    -0x28(%ebp),%eax
    9187:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    918b:	01 c2                	add    %eax,%edx
    918d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    9190:	01 d0                	add    %edx,%eax
    9192:	89 45 cc             	mov    %eax,-0x34(%ebp)
                     des_line = (sfb_start*3) + window + (freq*3);
    9195:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9198:	89 d0                	mov    %edx,%eax
    919a:	01 c0                	add    %eax,%eax
    919c:	01 c2                	add    %eax,%edx
    919e:	8b 45 d8             	mov    -0x28(%ebp),%eax
    91a1:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    91a4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    91a7:	89 d0                	mov    %edx,%eax
    91a9:	01 c0                	add    %eax,%eax
    91ab:	01 d0                	add    %edx,%eax
    91ad:	01 c8                	add    %ecx,%eax
    91af:	89 45 c8             	mov    %eax,-0x38(%ebp)
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    91b2:	8b 4d c8             	mov    -0x38(%ebp),%ecx
    91b5:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    91ba:	89 c8                	mov    %ecx,%eax
    91bc:	f7 ea                	imul   %edx
    91be:	c1 fa 02             	sar    $0x2,%edx
    91c1:	89 c8                	mov    %ecx,%eax
    91c3:	c1 f8 1f             	sar    $0x1f,%eax
    91c6:	29 c2                	sub    %eax,%edx
    91c8:	89 d0                	mov    %edx,%eax
    91ca:	89 c2                	mov    %eax,%edx
    91cc:	89 d0                	mov    %edx,%eax
    91ce:	c1 e0 03             	shl    $0x3,%eax
    91d1:	01 d0                	add    %edx,%eax
    91d3:	c1 e0 04             	shl    $0x4,%eax
    91d6:	89 c2                	mov    %eax,%edx
    91d8:	8b 45 0c             	mov    0xc(%ebp),%eax
    91db:	8d 34 02             	lea    (%edx,%eax,1),%esi
    91de:	8b 5d c8             	mov    -0x38(%ebp),%ebx
    91e1:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    91e6:	89 d8                	mov    %ebx,%eax
    91e8:	f7 ea                	imul   %edx
    91ea:	c1 fa 02             	sar    $0x2,%edx
    91ed:	89 d8                	mov    %ebx,%eax
    91ef:	c1 f8 1f             	sar    $0x1f,%eax
    91f2:	89 d1                	mov    %edx,%ecx
    91f4:	29 c1                	sub    %eax,%ecx
    91f6:	89 c8                	mov    %ecx,%eax
    91f8:	c1 e0 03             	shl    $0x3,%eax
    91fb:	01 c8                	add    %ecx,%eax
    91fd:	01 c0                	add    %eax,%eax
    91ff:	29 c3                	sub    %eax,%ebx
    9201:	89 d9                	mov    %ebx,%ecx
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
    9203:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    9206:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    920b:	89 d8                	mov    %ebx,%eax
    920d:	f7 ea                	imul   %edx
    920f:	c1 fa 02             	sar    $0x2,%edx
    9212:	89 d8                	mov    %ebx,%eax
    9214:	c1 f8 1f             	sar    $0x1f,%eax
    9217:	29 c2                	sub    %eax,%edx
    9219:	89 d0                	mov    %edx,%eax
    921b:	89 c2                	mov    %eax,%edx
    921d:	89 d0                	mov    %edx,%eax
    921f:	c1 e0 03             	shl    $0x3,%eax
    9222:	01 d0                	add    %edx,%eax
    9224:	c1 e0 04             	shl    $0x4,%eax
    9227:	89 c2                	mov    %eax,%edx
    9229:	8b 45 08             	mov    0x8(%ebp),%eax
    922c:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    922f:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    9232:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    9237:	89 d8                	mov    %ebx,%eax
    9239:	f7 ea                	imul   %edx
    923b:	c1 fa 02             	sar    $0x2,%edx
    923e:	89 d8                	mov    %ebx,%eax
    9240:	c1 f8 1f             	sar    $0x1f,%eax
    9243:	29 c2                	sub    %eax,%edx
    9245:	89 d0                	mov    %edx,%eax
    9247:	c1 e0 03             	shl    $0x3,%eax
    924a:	01 d0                	add    %edx,%eax
    924c:	01 c0                	add    %eax,%eax
    924e:	29 c3                	sub    %eax,%ebx
    9250:	89 da                	mov    %ebx,%edx
    9252:	dd 04 d7             	fldl   (%edi,%edx,8)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
                     src_line = sfb_start*3 + window*sfb_lines + freq;
                     des_line = (sfb_start*3) + window + (freq*3);
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    9255:	dd 1c ce             	fstpl  (%esi,%ecx,8)
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
    9258:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    925c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    925f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    9262:	0f 8c 13 ff ff ff    	jl     917b <III_reorder+0x12b>
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    9268:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    926c:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
    9270:	0f 8e f9 fe ff ff    	jle    916f <III_reorder+0x11f>
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
    9276:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    927a:	8b 55 d0             	mov    -0x30(%ebp),%edx
    927d:	89 d0                	mov    %edx,%eax
    927f:	c1 e0 03             	shl    $0x3,%eax
    9282:	01 d0                	add    %edx,%eax
    9284:	c1 e0 02             	shl    $0x2,%eax
    9287:	01 d0                	add    %edx,%eax
    9289:	8b 55 ec             	mov    -0x14(%ebp),%edx
    928c:	01 d0                	add    %edx,%eax
    928e:	83 c0 14             	add    $0x14,%eax
    9291:	8b 04 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%eax
    9298:	89 45 e8             	mov    %eax,-0x18(%ebp)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
    929b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    929e:	8d 48 01             	lea    0x1(%eax),%ecx
    92a1:	8b 55 d0             	mov    -0x30(%ebp),%edx
    92a4:	89 d0                	mov    %edx,%eax
    92a6:	c1 e0 03             	shl    $0x3,%eax
    92a9:	01 d0                	add    %edx,%eax
    92ab:	c1 e0 02             	shl    $0x2,%eax
    92ae:	01 d0                	add    %edx,%eax
    92b0:	01 c8                	add    %ecx,%eax
    92b2:	83 c0 14             	add    $0x14,%eax
    92b5:	8b 04 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%eax
    92bc:	2b 45 e8             	sub    -0x18(%ebp),%eax
    92bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
    92c2:	83 7d ec 0c          	cmpl   $0xc,-0x14(%ebp)
    92c6:	0f 8e 97 fe ff ff    	jle    9163 <III_reorder+0x113>
   for(sb=0;sb<SBLIMIT;sb++)
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
    92cc:	e9 ed 01 00 00       	jmp    94be <III_reorder+0x46e>
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
    92d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    92d8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    92df:	8b 45 d0             	mov    -0x30(%ebp),%eax
    92e2:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    92e8:	05 b4 f1 00 00       	add    $0xf1b4,%eax
    92ed:	8b 40 0c             	mov    0xc(%eax),%eax
    92f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    92f3:	e9 5f 01 00 00       	jmp    9457 <III_reorder+0x407>
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    92f8:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    92ff:	e9 fd 00 00 00       	jmp    9401 <III_reorder+0x3b1>
                  for(freq=0;freq<sfb_lines;freq++) {
    9304:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    930b:	e9 e1 00 00 00       	jmp    93f1 <III_reorder+0x3a1>
                     src_line = sfb_start*3 + window*sfb_lines + freq;
    9310:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9313:	89 d0                	mov    %edx,%eax
    9315:	01 c0                	add    %eax,%eax
    9317:	01 c2                	add    %eax,%edx
    9319:	8b 45 d8             	mov    -0x28(%ebp),%eax
    931c:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    9320:	01 c2                	add    %eax,%edx
    9322:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    9325:	01 d0                	add    %edx,%eax
    9327:	89 45 cc             	mov    %eax,-0x34(%ebp)
                     des_line = (sfb_start*3) + window + (freq*3);
    932a:	8b 55 e8             	mov    -0x18(%ebp),%edx
    932d:	89 d0                	mov    %edx,%eax
    932f:	01 c0                	add    %eax,%eax
    9331:	01 c2                	add    %eax,%edx
    9333:	8b 45 d8             	mov    -0x28(%ebp),%eax
    9336:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    9339:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    933c:	89 d0                	mov    %edx,%eax
    933e:	01 c0                	add    %eax,%eax
    9340:	01 d0                	add    %edx,%eax
    9342:	01 c8                	add    %ecx,%eax
    9344:	89 45 c8             	mov    %eax,-0x38(%ebp)
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    9347:	8b 4d c8             	mov    -0x38(%ebp),%ecx
    934a:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    934f:	89 c8                	mov    %ecx,%eax
    9351:	f7 ea                	imul   %edx
    9353:	c1 fa 02             	sar    $0x2,%edx
    9356:	89 c8                	mov    %ecx,%eax
    9358:	c1 f8 1f             	sar    $0x1f,%eax
    935b:	29 c2                	sub    %eax,%edx
    935d:	89 d0                	mov    %edx,%eax
    935f:	89 c2                	mov    %eax,%edx
    9361:	89 d0                	mov    %edx,%eax
    9363:	c1 e0 03             	shl    $0x3,%eax
    9366:	01 d0                	add    %edx,%eax
    9368:	c1 e0 04             	shl    $0x4,%eax
    936b:	89 c2                	mov    %eax,%edx
    936d:	8b 45 0c             	mov    0xc(%ebp),%eax
    9370:	8d 34 02             	lea    (%edx,%eax,1),%esi
    9373:	8b 5d c8             	mov    -0x38(%ebp),%ebx
    9376:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    937b:	89 d8                	mov    %ebx,%eax
    937d:	f7 ea                	imul   %edx
    937f:	c1 fa 02             	sar    $0x2,%edx
    9382:	89 d8                	mov    %ebx,%eax
    9384:	c1 f8 1f             	sar    $0x1f,%eax
    9387:	89 d1                	mov    %edx,%ecx
    9389:	29 c1                	sub    %eax,%ecx
    938b:	89 c8                	mov    %ecx,%eax
    938d:	c1 e0 03             	shl    $0x3,%eax
    9390:	01 c8                	add    %ecx,%eax
    9392:	01 c0                	add    %eax,%eax
    9394:	29 c3                	sub    %eax,%ebx
    9396:	89 d9                	mov    %ebx,%ecx
                       xr[src_line/SSLIMIT][src_line%SSLIMIT];
    9398:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    939b:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    93a0:	89 d8                	mov    %ebx,%eax
    93a2:	f7 ea                	imul   %edx
    93a4:	c1 fa 02             	sar    $0x2,%edx
    93a7:	89 d8                	mov    %ebx,%eax
    93a9:	c1 f8 1f             	sar    $0x1f,%eax
    93ac:	29 c2                	sub    %eax,%edx
    93ae:	89 d0                	mov    %edx,%eax
    93b0:	89 c2                	mov    %eax,%edx
    93b2:	89 d0                	mov    %edx,%eax
    93b4:	c1 e0 03             	shl    $0x3,%eax
    93b7:	01 d0                	add    %edx,%eax
    93b9:	c1 e0 04             	shl    $0x4,%eax
    93bc:	89 c2                	mov    %eax,%edx
    93be:	8b 45 08             	mov    0x8(%ebp),%eax
    93c1:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    93c4:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    93c7:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    93cc:	89 d8                	mov    %ebx,%eax
    93ce:	f7 ea                	imul   %edx
    93d0:	c1 fa 02             	sar    $0x2,%edx
    93d3:	89 d8                	mov    %ebx,%eax
    93d5:	c1 f8 1f             	sar    $0x1f,%eax
    93d8:	29 c2                	sub    %eax,%edx
    93da:	89 d0                	mov    %edx,%eax
    93dc:	c1 e0 03             	shl    $0x3,%eax
    93df:	01 d0                	add    %edx,%eax
    93e1:	01 c0                	add    %eax,%eax
    93e3:	29 c3                	sub    %eax,%ebx
    93e5:	89 da                	mov    %ebx,%edx
    93e7:	dd 04 d7             	fldl   (%edi,%edx,8)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
                     src_line = sfb_start*3 + window*sfb_lines + freq;
                     des_line = (sfb_start*3) + window + (freq*3);
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    93ea:	dd 1c ce             	fstpl  (%esi,%ecx,8)
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
    93ed:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    93f1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    93f4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    93f7:	0f 8c 13 ff ff ff    	jl     9310 <III_reorder+0x2c0>
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    93fd:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    9401:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
    9405:	0f 8e f9 fe ff ff    	jle    9304 <III_reorder+0x2b4>
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
    940b:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    940f:	8b 55 d0             	mov    -0x30(%ebp),%edx
    9412:	89 d0                	mov    %edx,%eax
    9414:	c1 e0 03             	shl    $0x3,%eax
    9417:	01 d0                	add    %edx,%eax
    9419:	c1 e0 02             	shl    $0x2,%eax
    941c:	01 d0                	add    %edx,%eax
    941e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    9421:	01 d0                	add    %edx,%eax
    9423:	83 c0 14             	add    $0x14,%eax
    9426:	8b 04 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%eax
    942d:	89 45 e8             	mov    %eax,-0x18(%ebp)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
    9430:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9433:	8d 48 01             	lea    0x1(%eax),%ecx
    9436:	8b 55 d0             	mov    -0x30(%ebp),%edx
    9439:	89 d0                	mov    %edx,%eax
    943b:	c1 e0 03             	shl    $0x3,%eax
    943e:	01 d0                	add    %edx,%eax
    9440:	c1 e0 02             	shl    $0x2,%eax
    9443:	01 d0                	add    %edx,%eax
    9445:	01 c8                	add    %ecx,%eax
    9447:	83 c0 14             	add    $0x14,%eax
    944a:	8b 04 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%eax
    9451:	2b 45 e8             	sub    -0x18(%ebp),%eax
    9454:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
    9457:	83 7d ec 0c          	cmpl   $0xc,-0x14(%ebp)
    945b:	0f 8e 97 fe ff ff    	jle    92f8 <III_reorder+0x2a8>
   for(sb=0;sb<SBLIMIT;sb++)
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
    9461:	eb 5b                	jmp    94be <III_reorder+0x46e>
                       xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
   }
   else {   /*long blocks */
      for (sb=0 ; sb < SBLIMIT ; sb++)
    9463:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    946a:	eb 4c                	jmp    94b8 <III_reorder+0x468>
         for (ss=0 ; ss < SSLIMIT ; ss++)
    946c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    9473:	eb 39                	jmp    94ae <III_reorder+0x45e>
            ro[sb][ss] = xr[sb][ss];
    9475:	8b 55 e0             	mov    -0x20(%ebp),%edx
    9478:	89 d0                	mov    %edx,%eax
    947a:	c1 e0 03             	shl    $0x3,%eax
    947d:	01 d0                	add    %edx,%eax
    947f:	c1 e0 04             	shl    $0x4,%eax
    9482:	89 c2                	mov    %eax,%edx
    9484:	8b 45 0c             	mov    0xc(%ebp),%eax
    9487:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    948a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    948d:	89 d0                	mov    %edx,%eax
    948f:	c1 e0 03             	shl    $0x3,%eax
    9492:	01 d0                	add    %edx,%eax
    9494:	c1 e0 04             	shl    $0x4,%eax
    9497:	89 c2                	mov    %eax,%edx
    9499:	8b 45 08             	mov    0x8(%ebp),%eax
    949c:	01 c2                	add    %eax,%edx
    949e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    94a1:	dd 04 c2             	fldl   (%edx,%eax,8)
    94a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
    94a7:	dd 1c c1             	fstpl  (%ecx,%eax,8)
               }
      }
   }
   else {   /*long blocks */
      for (sb=0 ; sb < SBLIMIT ; sb++)
         for (ss=0 ; ss < SSLIMIT ; ss++)
    94aa:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    94ae:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    94b2:	7e c1                	jle    9475 <III_reorder+0x425>
                       xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
   }
   else {   /*long blocks */
      for (sb=0 ; sb < SBLIMIT ; sb++)
    94b4:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    94b8:	83 7d e0 1f          	cmpl   $0x1f,-0x20(%ebp)
    94bc:	7e ae                	jle    946c <III_reorder+0x41c>
         for (ss=0 ; ss < SSLIMIT ; ss++)
            ro[sb][ss] = xr[sb][ss];
   }
}
    94be:	83 c4 34             	add    $0x34,%esp
    94c1:	5b                   	pop    %ebx
    94c2:	5e                   	pop    %esi
    94c3:	5f                   	pop    %edi
    94c4:	5d                   	pop    %ebp
    94c5:	c3                   	ret    

000094c6 <III_stereo>:


void III_stereo(double xr[2][SBLIMIT][SSLIMIT], double lr[2][SBLIMIT][SSLIMIT], III_scalefac_t *scalefac, struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
    94c6:	55                   	push   %ebp
    94c7:	89 e5                	mov    %esp,%ebp
    94c9:	56                   	push   %esi
    94ca:	53                   	push   %ebx
    94cb:	81 ec 50 1b 00 00    	sub    $0x1b50,%esp
   int sfreq = fr_ps->header->sampling_frequency;
    94d1:	8b 45 18             	mov    0x18(%ebp),%eax
    94d4:	8b 00                	mov    (%eax),%eax
    94d6:	8b 40 10             	mov    0x10(%eax),%eax
    94d9:	89 45 c8             	mov    %eax,-0x38(%ebp)
   int stereo = fr_ps->stereo;
    94dc:	8b 45 18             	mov    0x18(%ebp),%eax
    94df:	8b 40 08             	mov    0x8(%eax),%eax
    94e2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
   int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    94e5:	8b 45 18             	mov    0x18(%ebp),%eax
    94e8:	8b 00                	mov    (%eax),%eax
    94ea:	8b 40 1c             	mov    0x1c(%eax),%eax
    94ed:	83 f8 01             	cmp    $0x1,%eax
    94f0:	75 16                	jne    9508 <III_stereo+0x42>
                   (fr_ps->header->mode_ext & 0x2);
    94f2:	8b 45 18             	mov    0x18(%ebp),%eax
    94f5:	8b 00                	mov    (%eax),%eax
    94f7:	8b 40 20             	mov    0x20(%eax),%eax
    94fa:	83 e0 02             	and    $0x2,%eax

void III_stereo(double xr[2][SBLIMIT][SSLIMIT], double lr[2][SBLIMIT][SSLIMIT], III_scalefac_t *scalefac, struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
   int sfreq = fr_ps->header->sampling_frequency;
   int stereo = fr_ps->stereo;
   int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    94fd:	85 c0                	test   %eax,%eax
    94ff:	74 07                	je     9508 <III_stereo+0x42>
    9501:	b8 01 00 00 00       	mov    $0x1,%eax
    9506:	eb 05                	jmp    950d <III_stereo+0x47>
    9508:	b8 00 00 00 00       	mov    $0x0,%eax
    950d:	89 45 c0             	mov    %eax,-0x40(%ebp)
                   (fr_ps->header->mode_ext & 0x2);
   int i_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    9510:	8b 45 18             	mov    0x18(%ebp),%eax
    9513:	8b 00                	mov    (%eax),%eax
    9515:	8b 40 1c             	mov    0x1c(%eax),%eax
    9518:	83 f8 01             	cmp    $0x1,%eax
    951b:	75 16                	jne    9533 <III_stereo+0x6d>
                  (fr_ps->header->mode_ext & 0x1);
    951d:	8b 45 18             	mov    0x18(%ebp),%eax
    9520:	8b 00                	mov    (%eax),%eax
    9522:	8b 40 20             	mov    0x20(%eax),%eax
    9525:	83 e0 01             	and    $0x1,%eax
{
   int sfreq = fr_ps->header->sampling_frequency;
   int stereo = fr_ps->stereo;
   int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
                   (fr_ps->header->mode_ext & 0x2);
   int i_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    9528:	85 c0                	test   %eax,%eax
    952a:	74 07                	je     9533 <III_stereo+0x6d>
    952c:	b8 01 00 00 00       	mov    $0x1,%eax
    9531:	eb 05                	jmp    9538 <III_stereo+0x72>
    9533:	b8 00 00 00 00       	mov    $0x0,%eax
    9538:	89 45 bc             	mov    %eax,-0x44(%ebp)
   int sfb;
   int i,j,sb,ss,ch,is_pos[576];
   double is_ratio[576];

   /* intialization */
   for ( i=0; i<576; i++ )
    953b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    9542:	eb 12                	jmp    9556 <III_stereo+0x90>
      is_pos[i] = 7;
    9544:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9547:	c7 84 85 bc f6 ff ff 	movl   $0x7,-0x944(%ebp,%eax,4)
    954e:	07 00 00 00 
   int sfb;
   int i,j,sb,ss,ch,is_pos[576];
   double is_ratio[576];

   /* intialization */
   for ( i=0; i<576; i++ )
    9552:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    9556:	81 7d f0 3f 02 00 00 	cmpl   $0x23f,-0x10(%ebp)
    955d:	7e e5                	jle    9544 <III_stereo+0x7e>
      is_pos[i] = 7;

   if ((stereo == 2) && i_stereo )
    955f:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
    9563:	0f 85 18 0a 00 00    	jne    9f81 <III_stereo+0xabb>
    9569:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
    956d:	0f 84 0e 0a 00 00    	je     9f81 <III_stereo+0xabb>
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
    9573:	8b 45 14             	mov    0x14(%ebp),%eax
    9576:	8b 40 10             	mov    0x10(%eax),%eax
    9579:	85 c0                	test   %eax,%eax
    957b:	0f 84 10 08 00 00    	je     9d91 <III_stereo+0x8cb>
    9581:	8b 45 14             	mov    0x14(%ebp),%eax
    9584:	8b 40 14             	mov    0x14(%eax),%eax
    9587:	83 f8 02             	cmp    $0x2,%eax
    958a:	0f 85 01 08 00 00    	jne    9d91 <III_stereo+0x8cb>
      {  if( gr_info->mixed_block_flag )
    9590:	8b 45 14             	mov    0x14(%ebp),%eax
    9593:	8b 40 18             	mov    0x18(%eax),%eax
    9596:	85 c0                	test   %eax,%eax
    9598:	0f 84 d0 04 00 00    	je     9a6e <III_stereo+0x5a8>
         {  int max_sfb = 0;
    959e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)

            for ( j=0; j<3; j++ )
    95a5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    95ac:	e9 1b 03 00 00       	jmp    98cc <III_stereo+0x406>
            {  int sfbcnt;
               sfbcnt = 2;
    95b1:	c7 45 d8 02 00 00 00 	movl   $0x2,-0x28(%ebp)
               for( sfb=12; sfb >=3; sfb-- )
    95b8:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    95bf:	e9 0f 01 00 00       	jmp    96d3 <III_stereo+0x20d>
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    95c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    95c7:	8d 48 01             	lea    0x1(%eax),%ecx
    95ca:	8b 55 c8             	mov    -0x38(%ebp),%edx
    95cd:	89 d0                	mov    %edx,%eax
    95cf:	c1 e0 03             	shl    $0x3,%eax
    95d2:	01 d0                	add    %edx,%eax
    95d4:	c1 e0 02             	shl    $0x2,%eax
    95d7:	01 d0                	add    %edx,%eax
    95d9:	01 c8                	add    %ecx,%eax
    95db:	83 c0 14             	add    $0x14,%eax
    95de:	8b 0c 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%ecx
    95e5:	8b 55 c8             	mov    -0x38(%ebp),%edx
    95e8:	89 d0                	mov    %edx,%eax
    95ea:	c1 e0 03             	shl    $0x3,%eax
    95ed:	01 d0                	add    %edx,%eax
    95ef:	c1 e0 02             	shl    $0x2,%eax
    95f2:	01 d0                	add    %edx,%eax
    95f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    95f7:	01 d0                	add    %edx,%eax
    95f9:	83 c0 14             	add    $0x14,%eax
    95fc:	8b 04 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%eax
    9603:	29 c1                	sub    %eax,%ecx
    9605:	89 c8                	mov    %ecx,%eax
    9607:	89 45 d4             	mov    %eax,-0x2c(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
    960a:	8b 55 c8             	mov    -0x38(%ebp),%edx
    960d:	89 d0                	mov    %edx,%eax
    960f:	c1 e0 03             	shl    $0x3,%eax
    9612:	01 d0                	add    %edx,%eax
    9614:	c1 e0 02             	shl    $0x2,%eax
    9617:	01 d0                	add    %edx,%eax
    9619:	8b 55 f4             	mov    -0xc(%ebp),%edx
    961c:	01 d0                	add    %edx,%eax
    961e:	83 c0 14             	add    $0x14,%eax
    9621:	8b 14 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%edx
    9628:	89 d0                	mov    %edx,%eax
    962a:	01 c0                	add    %eax,%eax
    962c:	01 c2                	add    %eax,%edx
    962e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9631:	83 c0 01             	add    $0x1,%eax
    9634:	0f af 45 d4          	imul   -0x2c(%ebp),%eax
    9638:	01 d0                	add    %edx,%eax
    963a:	83 e8 01             	sub    $0x1,%eax
    963d:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  while ( lines > 0 )
    9640:	e9 80 00 00 00       	jmp    96c5 <III_stereo+0x1ff>
                  {  if ( xr[1][i/SSLIMIT][i%SSLIMIT] != 0.0 )
    9645:	8b 45 08             	mov    0x8(%ebp),%eax
    9648:	8d b0 00 12 00 00    	lea    0x1200(%eax),%esi
    964e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    9651:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    9656:	89 c8                	mov    %ecx,%eax
    9658:	f7 ea                	imul   %edx
    965a:	c1 fa 02             	sar    $0x2,%edx
    965d:	89 c8                	mov    %ecx,%eax
    965f:	c1 f8 1f             	sar    $0x1f,%eax
    9662:	89 d3                	mov    %edx,%ebx
    9664:	29 c3                	sub    %eax,%ebx
    9666:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    9669:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    966e:	89 c8                	mov    %ecx,%eax
    9670:	f7 ea                	imul   %edx
    9672:	c1 fa 02             	sar    $0x2,%edx
    9675:	89 c8                	mov    %ecx,%eax
    9677:	c1 f8 1f             	sar    $0x1f,%eax
    967a:	29 c2                	sub    %eax,%edx
    967c:	89 d0                	mov    %edx,%eax
    967e:	c1 e0 03             	shl    $0x3,%eax
    9681:	01 d0                	add    %edx,%eax
    9683:	01 c0                	add    %eax,%eax
    9685:	29 c1                	sub    %eax,%ecx
    9687:	89 ca                	mov    %ecx,%edx
    9689:	89 d8                	mov    %ebx,%eax
    968b:	c1 e0 03             	shl    $0x3,%eax
    968e:	01 d8                	add    %ebx,%eax
    9690:	01 c0                	add    %eax,%eax
    9692:	01 d0                	add    %edx,%eax
    9694:	dd 04 c6             	fldl   (%esi,%eax,8)
    9697:	d9 ee                	fldz   
    9699:	df e9                	fucomip %st(1),%st
    969b:	7a 0a                	jp     96a7 <III_stereo+0x1e1>
    969d:	d9 ee                	fldz   
    969f:	df e9                	fucomip %st(1),%st
    96a1:	dd d8                	fstp   %st(0)
    96a3:	74 18                	je     96bd <III_stereo+0x1f7>
    96a5:	eb 02                	jmp    96a9 <III_stereo+0x1e3>
    96a7:	dd d8                	fstp   %st(0)
                     {  sfbcnt = sfb;
    96a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    96ac:	89 45 d8             	mov    %eax,-0x28(%ebp)
                        sfb = -10;
    96af:	c7 45 f4 f6 ff ff ff 	movl   $0xfffffff6,-0xc(%ebp)
                        lines = -10;
    96b6:	c7 45 d4 f6 ff ff ff 	movl   $0xfffffff6,-0x2c(%ebp)
                     }
                     lines--;
    96bd:	83 6d d4 01          	subl   $0x1,-0x2c(%ebp)
                     i--;
    96c1:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
               sfbcnt = 2;
               for( sfb=12; sfb >=3; sfb-- )
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
                  while ( lines > 0 )
    96c5:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    96c9:	0f 8f 76 ff ff ff    	jg     9645 <III_stereo+0x17f>
         {  int max_sfb = 0;

            for ( j=0; j<3; j++ )
            {  int sfbcnt;
               sfbcnt = 2;
               for( sfb=12; sfb >=3; sfb-- )
    96cf:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    96d3:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
    96d7:	0f 8f e7 fe ff ff    	jg     95c4 <III_stereo+0xfe>
                     }
                     lines--;
                     i--;
                  }
               }
               sfb = sfbcnt + 1;
    96dd:	8b 45 d8             	mov    -0x28(%ebp),%eax
    96e0:	83 c0 01             	add    $0x1,%eax
    96e3:	89 45 f4             	mov    %eax,-0xc(%ebp)

               if ( sfb > max_sfb )
    96e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    96e9:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    96ec:	7e 0b                	jle    96f9 <III_stereo+0x233>
                  max_sfb = sfb;
    96ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    96f1:	89 45 dc             	mov    %eax,-0x24(%ebp)

               while( sfb<12 )
    96f4:	e9 f5 00 00 00       	jmp    97ee <III_stereo+0x328>
    96f9:	e9 f0 00 00 00       	jmp    97ee <III_stereo+0x328>
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    96fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9701:	8d 48 01             	lea    0x1(%eax),%ecx
    9704:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9707:	89 d0                	mov    %edx,%eax
    9709:	c1 e0 03             	shl    $0x3,%eax
    970c:	01 d0                	add    %edx,%eax
    970e:	c1 e0 02             	shl    $0x2,%eax
    9711:	01 d0                	add    %edx,%eax
    9713:	01 c8                	add    %ecx,%eax
    9715:	83 c0 14             	add    $0x14,%eax
    9718:	8b 0c 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%ecx
    971f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9722:	89 d0                	mov    %edx,%eax
    9724:	c1 e0 03             	shl    $0x3,%eax
    9727:	01 d0                	add    %edx,%eax
    9729:	c1 e0 02             	shl    $0x2,%eax
    972c:	01 d0                	add    %edx,%eax
    972e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9731:	01 d0                	add    %edx,%eax
    9733:	83 c0 14             	add    $0x14,%eax
    9736:	8b 04 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%eax
    973d:	29 c1                	sub    %eax,%ecx
    973f:	89 c8                	mov    %ecx,%eax
    9741:	89 45 e8             	mov    %eax,-0x18(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
    9744:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9747:	89 d0                	mov    %edx,%eax
    9749:	c1 e0 03             	shl    $0x3,%eax
    974c:	01 d0                	add    %edx,%eax
    974e:	c1 e0 02             	shl    $0x2,%eax
    9751:	01 d0                	add    %edx,%eax
    9753:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9756:	01 d0                	add    %edx,%eax
    9758:	83 c0 14             	add    $0x14,%eax
    975b:	8b 14 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%edx
    9762:	89 d0                	mov    %edx,%eax
    9764:	01 c0                	add    %eax,%eax
    9766:	01 c2                	add    %eax,%edx
    9768:	8b 45 ec             	mov    -0x14(%ebp),%eax
    976b:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    976f:	01 d0                	add    %edx,%eax
    9771:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  for ( ; sb > 0; sb--)
    9774:	eb 6e                	jmp    97e4 <III_stereo+0x31e>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
    9776:	8b 4d 10             	mov    0x10(%ebp),%ecx
    9779:	8b 55 ec             	mov    -0x14(%ebp),%edx
    977c:	89 d0                	mov    %edx,%eax
    977e:	01 c0                	add    %eax,%eax
    9780:	01 d0                	add    %edx,%eax
    9782:	c1 e0 02             	shl    $0x2,%eax
    9785:	01 d0                	add    %edx,%eax
    9787:	8b 55 f4             	mov    -0xc(%ebp),%edx
    978a:	01 d0                	add    %edx,%eax
    978c:	83 c0 52             	add    $0x52,%eax
    978f:	8b 54 81 0c          	mov    0xc(%ecx,%eax,4),%edx
    9793:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9796:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                     if ( is_pos[i] != 7 )
    979d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    97a0:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    97a7:	83 f8 07             	cmp    $0x7,%eax
    97aa:	74 30                	je     97dc <III_stereo+0x316>
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
    97ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    97af:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    97b6:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    97bc:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    97c2:	dd 05 60 dd 00 00    	fldl   0xdd60
    97c8:	de c9                	fmulp  %st,%st(1)
    97ca:	dd 1c 24             	fstpl  (%esp)
    97cd:	e8 1d b6 ff ff       	call   4def <tan>
    97d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    97d5:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                     i++;
    97dc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                  max_sfb = sfb;

               while( sfb<12 )
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
                  for ( ; sb > 0; sb--)
    97e0:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    97e4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    97e8:	7f 8c                	jg     9776 <III_stereo+0x2b0>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
                     if ( is_pos[i] != 7 )
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
                     i++;
                  }
                  sfb++;
    97ea:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
               sfb = sfbcnt + 1;

               if ( sfb > max_sfb )
                  max_sfb = sfb;

               while( sfb<12 )
    97ee:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    97f2:	0f 8e 06 ff ff ff    	jle    96fe <III_stereo+0x238>
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
                     i++;
                  }
                  sfb++;
               }
               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
    97f8:	8b 45 c8             	mov    -0x38(%ebp),%eax
    97fb:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9801:	05 dc f1 00 00       	add    $0xf1dc,%eax
    9806:	8b 50 0c             	mov    0xc(%eax),%edx
    9809:	8b 45 c8             	mov    -0x38(%ebp),%eax
    980c:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9812:	05 d8 f1 00 00       	add    $0xf1d8,%eax
    9817:	8b 40 0c             	mov    0xc(%eax),%eax
    981a:	29 c2                	sub    %eax,%edx
    981c:	89 d0                	mov    %edx,%eax
    981e:	89 45 e8             	mov    %eax,-0x18(%ebp)
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
    9821:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9824:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    982a:	05 d8 f1 00 00       	add    $0xf1d8,%eax
    982f:	8b 50 0c             	mov    0xc(%eax),%edx
    9832:	89 d0                	mov    %edx,%eax
    9834:	01 c0                	add    %eax,%eax
    9836:	01 c2                	add    %eax,%edx
    9838:	8b 45 ec             	mov    -0x14(%ebp),%eax
    983b:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    983f:	01 d0                	add    %edx,%eax
    9841:	89 45 f4             	mov    %eax,-0xc(%ebp)
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
    9844:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9847:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    984d:	05 e0 f1 00 00       	add    $0xf1e0,%eax
    9852:	8b 50 0c             	mov    0xc(%eax),%edx
    9855:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9858:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    985e:	05 dc f1 00 00       	add    $0xf1dc,%eax
    9863:	8b 40 0c             	mov    0xc(%eax),%eax
    9866:	29 c2                	sub    %eax,%edx
    9868:	89 d0                	mov    %edx,%eax
    986a:	89 45 e8             	mov    %eax,-0x18(%ebp)
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
    986d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9870:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9876:	05 dc f1 00 00       	add    $0xf1dc,%eax
    987b:	8b 50 0c             	mov    0xc(%eax),%edx
    987e:	89 d0                	mov    %edx,%eax
    9880:	01 c0                	add    %eax,%eax
    9882:	01 c2                	add    %eax,%edx
    9884:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9887:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    988b:	01 d0                	add    %edx,%eax
    988d:	89 45 f0             	mov    %eax,-0x10(%ebp)
               for ( ; sb > 0; sb-- )
    9890:	eb 30                	jmp    98c2 <III_stereo+0x3fc>
               {  is_pos[i] = is_pos[sfb];
    9892:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9895:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    989c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    989f:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                  is_ratio[i] = is_ratio[sfb];
    98a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    98a9:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    98b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    98b3:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                  i++;
    98ba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
               }
               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
               for ( ; sb > 0; sb-- )
    98be:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    98c2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    98c6:	7f ca                	jg     9892 <III_stereo+0x3cc>
   if ((stereo == 2) && i_stereo )
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
      {  if( gr_info->mixed_block_flag )
         {  int max_sfb = 0;

            for ( j=0; j<3; j++ )
    98c8:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    98cc:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    98d0:	0f 8e db fc ff ff    	jle    95b1 <III_stereo+0xeb>
               {  is_pos[i] = is_pos[sfb];
                  is_ratio[i] = is_ratio[sfb];
                  i++;
               }
             }
             if ( max_sfb <= 3 )
    98d6:	83 7d dc 03          	cmpl   $0x3,-0x24(%ebp)
    98da:	0f 8f 89 01 00 00    	jg     9a69 <III_stereo+0x5a3>
             {  i = 2;
    98e0:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
                ss = 17;
    98e7:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
                sb = -1;
    98ee:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
                while ( i >= 0 )
    98f5:	eb 63                	jmp    995a <III_stereo+0x494>
                {  if ( xr[1][i][ss] != 0.0 )
    98f7:	8b 45 08             	mov    0x8(%ebp),%eax
    98fa:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    9900:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9903:	89 d0                	mov    %edx,%eax
    9905:	c1 e0 03             	shl    $0x3,%eax
    9908:	01 d0                	add    %edx,%eax
    990a:	01 c0                	add    %eax,%eax
    990c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    990f:	01 d0                	add    %edx,%eax
    9911:	dd 04 c1             	fldl   (%ecx,%eax,8)
    9914:	d9 ee                	fldz   
    9916:	df e9                	fucomip %st(1),%st
    9918:	7a 0a                	jp     9924 <III_stereo+0x45e>
    991a:	d9 ee                	fldz   
    991c:	df e9                	fucomip %st(1),%st
    991e:	dd d8                	fstp   %st(0)
    9920:	74 23                	je     9945 <III_stereo+0x47f>
    9922:	eb 02                	jmp    9926 <III_stereo+0x460>
    9924:	dd d8                	fstp   %st(0)
                   {  sb = i*18+ss;
    9926:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9929:	89 d0                	mov    %edx,%eax
    992b:	c1 e0 03             	shl    $0x3,%eax
    992e:	01 d0                	add    %edx,%eax
    9930:	01 c0                	add    %eax,%eax
    9932:	89 c2                	mov    %eax,%edx
    9934:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    9937:	01 d0                	add    %edx,%eax
    9939:	89 45 e8             	mov    %eax,-0x18(%ebp)
                      i = -1;
    993c:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    9943:	eb 15                	jmp    995a <III_stereo+0x494>
                   } else
                   {  ss--;
    9945:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
                      if ( ss < 0 )
    9949:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    994d:	79 0b                	jns    995a <III_stereo+0x494>
                      {  i--;
    994f:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
                         ss = 17;
    9953:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
             }
             if ( max_sfb <= 3 )
             {  i = 2;
                ss = 17;
                sb = -1;
                while ( i >= 0 )
    995a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    995e:	79 97                	jns    98f7 <III_stereo+0x431>
                      {  i--;
                         ss = 17;
                      }
                   }
                }
                i = 0;
    9960:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                while ( sfBandIndex[sfreq].l[i] <= sb )
    9967:	eb 04                	jmp    996d <III_stereo+0x4a7>
                   i++;
    9969:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                         ss = 17;
                      }
                   }
                }
                i = 0;
                while ( sfBandIndex[sfreq].l[i] <= sb )
    996d:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9970:	89 d0                	mov    %edx,%eax
    9972:	c1 e0 03             	shl    $0x3,%eax
    9975:	01 d0                	add    %edx,%eax
    9977:	c1 e0 02             	shl    $0x2,%eax
    997a:	01 d0                	add    %edx,%eax
    997c:	8b 55 f0             	mov    -0x10(%ebp),%edx
    997f:	01 d0                	add    %edx,%eax
    9981:	8b 04 85 60 f1 00 00 	mov    0xf160(,%eax,4),%eax
    9988:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    998b:	7e dc                	jle    9969 <III_stereo+0x4a3>
                   i++;
                sfb = i;
    998d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9990:	89 45 f4             	mov    %eax,-0xc(%ebp)
                i = sfBandIndex[sfreq].l[i];
    9993:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9996:	89 d0                	mov    %edx,%eax
    9998:	c1 e0 03             	shl    $0x3,%eax
    999b:	01 d0                	add    %edx,%eax
    999d:	c1 e0 02             	shl    $0x2,%eax
    99a0:	01 d0                	add    %edx,%eax
    99a2:	8b 55 f0             	mov    -0x10(%ebp),%edx
    99a5:	01 d0                	add    %edx,%eax
    99a7:	8b 04 85 60 f1 00 00 	mov    0xf160(,%eax,4),%eax
    99ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
                for ( ; sfb<8; sfb++ )
    99b1:	e9 a9 00 00 00       	jmp    9a5f <III_stereo+0x599>
                {  sb = sfBandIndex[sfreq].l[sfb+1]-sfBandIndex[sfreq].l[sfb];
    99b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    99b9:	8d 48 01             	lea    0x1(%eax),%ecx
    99bc:	8b 55 c8             	mov    -0x38(%ebp),%edx
    99bf:	89 d0                	mov    %edx,%eax
    99c1:	c1 e0 03             	shl    $0x3,%eax
    99c4:	01 d0                	add    %edx,%eax
    99c6:	c1 e0 02             	shl    $0x2,%eax
    99c9:	01 d0                	add    %edx,%eax
    99cb:	01 c8                	add    %ecx,%eax
    99cd:	8b 0c 85 60 f1 00 00 	mov    0xf160(,%eax,4),%ecx
    99d4:	8b 55 c8             	mov    -0x38(%ebp),%edx
    99d7:	89 d0                	mov    %edx,%eax
    99d9:	c1 e0 03             	shl    $0x3,%eax
    99dc:	01 d0                	add    %edx,%eax
    99de:	c1 e0 02             	shl    $0x2,%eax
    99e1:	01 d0                	add    %edx,%eax
    99e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
    99e6:	01 d0                	add    %edx,%eax
    99e8:	8b 04 85 60 f1 00 00 	mov    0xf160(,%eax,4),%eax
    99ef:	29 c1                	sub    %eax,%ecx
    99f1:	89 c8                	mov    %ecx,%eax
    99f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
                   for ( ; sb > 0; sb--)
    99f6:	eb 5d                	jmp    9a55 <III_stereo+0x58f>
                   {  is_pos[i] = (*scalefac)[1].l[sfb];
    99f8:	8b 45 10             	mov    0x10(%ebp),%eax
    99fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
    99fe:	83 c2 3e             	add    $0x3e,%edx
    9a01:	8b 14 90             	mov    (%eax,%edx,4),%edx
    9a04:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9a07:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                      if ( is_pos[i] != 7 )
    9a0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9a11:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9a18:	83 f8 07             	cmp    $0x7,%eax
    9a1b:	74 30                	je     9a4d <III_stereo+0x587>
                         is_ratio[i] = tan( is_pos[i] * (PI / 12));
    9a1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9a20:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9a27:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    9a2d:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    9a33:	dd 05 60 dd 00 00    	fldl   0xdd60
    9a39:	de c9                	fmulp  %st,%st(1)
    9a3b:	dd 1c 24             	fstpl  (%esp)
    9a3e:	e8 ac b3 ff ff       	call   4def <tan>
    9a43:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9a46:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                      i++;
    9a4d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                   i++;
                sfb = i;
                i = sfBandIndex[sfreq].l[i];
                for ( ; sfb<8; sfb++ )
                {  sb = sfBandIndex[sfreq].l[sfb+1]-sfBandIndex[sfreq].l[sfb];
                   for ( ; sb > 0; sb--)
    9a51:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9a55:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9a59:	7f 9d                	jg     99f8 <III_stereo+0x532>
                i = 0;
                while ( sfBandIndex[sfreq].l[i] <= sb )
                   i++;
                sfb = i;
                i = sfBandIndex[sfreq].l[i];
                for ( ; sfb<8; sfb++ )
    9a5b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    9a5f:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    9a63:	0f 8e 4d ff ff ff    	jle    99b6 <III_stereo+0x4f0>
    9a69:	e9 1e 03 00 00       	jmp    9d8c <III_stereo+0x8c6>
                      i++;
                   }
                }
            }
         } else
         {  for ( j=0; j<3; j++ )
    9a6e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    9a75:	e9 08 03 00 00       	jmp    9d82 <III_stereo+0x8bc>
            {  int sfbcnt;
               sfbcnt = -1;
    9a7a:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%ebp)
               for( sfb=12; sfb >=0; sfb-- )
    9a81:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    9a88:	e9 0f 01 00 00       	jmp    9b9c <III_stereo+0x6d6>
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    9a8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9a90:	8d 48 01             	lea    0x1(%eax),%ecx
    9a93:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9a96:	89 d0                	mov    %edx,%eax
    9a98:	c1 e0 03             	shl    $0x3,%eax
    9a9b:	01 d0                	add    %edx,%eax
    9a9d:	c1 e0 02             	shl    $0x2,%eax
    9aa0:	01 d0                	add    %edx,%eax
    9aa2:	01 c8                	add    %ecx,%eax
    9aa4:	83 c0 14             	add    $0x14,%eax
    9aa7:	8b 0c 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%ecx
    9aae:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9ab1:	89 d0                	mov    %edx,%eax
    9ab3:	c1 e0 03             	shl    $0x3,%eax
    9ab6:	01 d0                	add    %edx,%eax
    9ab8:	c1 e0 02             	shl    $0x2,%eax
    9abb:	01 d0                	add    %edx,%eax
    9abd:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9ac0:	01 d0                	add    %edx,%eax
    9ac2:	83 c0 14             	add    $0x14,%eax
    9ac5:	8b 04 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%eax
    9acc:	29 c1                	sub    %eax,%ecx
    9ace:	89 c8                	mov    %ecx,%eax
    9ad0:	89 45 cc             	mov    %eax,-0x34(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
    9ad3:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9ad6:	89 d0                	mov    %edx,%eax
    9ad8:	c1 e0 03             	shl    $0x3,%eax
    9adb:	01 d0                	add    %edx,%eax
    9add:	c1 e0 02             	shl    $0x2,%eax
    9ae0:	01 d0                	add    %edx,%eax
    9ae2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9ae5:	01 d0                	add    %edx,%eax
    9ae7:	83 c0 14             	add    $0x14,%eax
    9aea:	8b 14 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%edx
    9af1:	89 d0                	mov    %edx,%eax
    9af3:	01 c0                	add    %eax,%eax
    9af5:	01 c2                	add    %eax,%edx
    9af7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9afa:	83 c0 01             	add    $0x1,%eax
    9afd:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    9b01:	01 d0                	add    %edx,%eax
    9b03:	83 e8 01             	sub    $0x1,%eax
    9b06:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  while ( lines > 0 )
    9b09:	e9 80 00 00 00       	jmp    9b8e <III_stereo+0x6c8>
                  {  if ( xr[1][i/SSLIMIT][i%SSLIMIT] != 0.0 )
    9b0e:	8b 45 08             	mov    0x8(%ebp),%eax
    9b11:	8d b0 00 12 00 00    	lea    0x1200(%eax),%esi
    9b17:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    9b1a:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    9b1f:	89 c8                	mov    %ecx,%eax
    9b21:	f7 ea                	imul   %edx
    9b23:	c1 fa 02             	sar    $0x2,%edx
    9b26:	89 c8                	mov    %ecx,%eax
    9b28:	c1 f8 1f             	sar    $0x1f,%eax
    9b2b:	89 d3                	mov    %edx,%ebx
    9b2d:	29 c3                	sub    %eax,%ebx
    9b2f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    9b32:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    9b37:	89 c8                	mov    %ecx,%eax
    9b39:	f7 ea                	imul   %edx
    9b3b:	c1 fa 02             	sar    $0x2,%edx
    9b3e:	89 c8                	mov    %ecx,%eax
    9b40:	c1 f8 1f             	sar    $0x1f,%eax
    9b43:	29 c2                	sub    %eax,%edx
    9b45:	89 d0                	mov    %edx,%eax
    9b47:	c1 e0 03             	shl    $0x3,%eax
    9b4a:	01 d0                	add    %edx,%eax
    9b4c:	01 c0                	add    %eax,%eax
    9b4e:	29 c1                	sub    %eax,%ecx
    9b50:	89 ca                	mov    %ecx,%edx
    9b52:	89 d8                	mov    %ebx,%eax
    9b54:	c1 e0 03             	shl    $0x3,%eax
    9b57:	01 d8                	add    %ebx,%eax
    9b59:	01 c0                	add    %eax,%eax
    9b5b:	01 d0                	add    %edx,%eax
    9b5d:	dd 04 c6             	fldl   (%esi,%eax,8)
    9b60:	d9 ee                	fldz   
    9b62:	df e9                	fucomip %st(1),%st
    9b64:	7a 0a                	jp     9b70 <III_stereo+0x6aa>
    9b66:	d9 ee                	fldz   
    9b68:	df e9                	fucomip %st(1),%st
    9b6a:	dd d8                	fstp   %st(0)
    9b6c:	74 18                	je     9b86 <III_stereo+0x6c0>
    9b6e:	eb 02                	jmp    9b72 <III_stereo+0x6ac>
    9b70:	dd d8                	fstp   %st(0)
                     {  sfbcnt = sfb;
    9b72:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9b75:	89 45 d0             	mov    %eax,-0x30(%ebp)
                        sfb = -10;
    9b78:	c7 45 f4 f6 ff ff ff 	movl   $0xfffffff6,-0xc(%ebp)
                        lines = -10;
    9b7f:	c7 45 cc f6 ff ff ff 	movl   $0xfffffff6,-0x34(%ebp)
                     }
                     lines--;
    9b86:	83 6d cc 01          	subl   $0x1,-0x34(%ebp)
                     i--;
    9b8a:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
               sfbcnt = -1;
               for( sfb=12; sfb >=0; sfb-- )
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
                  while ( lines > 0 )
    9b8e:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
    9b92:	0f 8f 76 ff ff ff    	jg     9b0e <III_stereo+0x648>
            }
         } else
         {  for ( j=0; j<3; j++ )
            {  int sfbcnt;
               sfbcnt = -1;
               for( sfb=12; sfb >=0; sfb-- )
    9b98:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    9b9c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    9ba0:	0f 89 e7 fe ff ff    	jns    9a8d <III_stereo+0x5c7>
                     }
                     lines--;
                     i--;
                  }
               }
               sfb = sfbcnt + 1;
    9ba6:	8b 45 d0             	mov    -0x30(%ebp),%eax
    9ba9:	83 c0 01             	add    $0x1,%eax
    9bac:	89 45 f4             	mov    %eax,-0xc(%ebp)
               while( sfb<12 )
    9baf:	e9 f0 00 00 00       	jmp    9ca4 <III_stereo+0x7de>
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    9bb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9bb7:	8d 48 01             	lea    0x1(%eax),%ecx
    9bba:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9bbd:	89 d0                	mov    %edx,%eax
    9bbf:	c1 e0 03             	shl    $0x3,%eax
    9bc2:	01 d0                	add    %edx,%eax
    9bc4:	c1 e0 02             	shl    $0x2,%eax
    9bc7:	01 d0                	add    %edx,%eax
    9bc9:	01 c8                	add    %ecx,%eax
    9bcb:	83 c0 14             	add    $0x14,%eax
    9bce:	8b 0c 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%ecx
    9bd5:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9bd8:	89 d0                	mov    %edx,%eax
    9bda:	c1 e0 03             	shl    $0x3,%eax
    9bdd:	01 d0                	add    %edx,%eax
    9bdf:	c1 e0 02             	shl    $0x2,%eax
    9be2:	01 d0                	add    %edx,%eax
    9be4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9be7:	01 d0                	add    %edx,%eax
    9be9:	83 c0 14             	add    $0x14,%eax
    9bec:	8b 04 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%eax
    9bf3:	29 c1                	sub    %eax,%ecx
    9bf5:	89 c8                	mov    %ecx,%eax
    9bf7:	89 45 e8             	mov    %eax,-0x18(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
    9bfa:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9bfd:	89 d0                	mov    %edx,%eax
    9bff:	c1 e0 03             	shl    $0x3,%eax
    9c02:	01 d0                	add    %edx,%eax
    9c04:	c1 e0 02             	shl    $0x2,%eax
    9c07:	01 d0                	add    %edx,%eax
    9c09:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9c0c:	01 d0                	add    %edx,%eax
    9c0e:	83 c0 14             	add    $0x14,%eax
    9c11:	8b 14 85 6c f1 00 00 	mov    0xf16c(,%eax,4),%edx
    9c18:	89 d0                	mov    %edx,%eax
    9c1a:	01 c0                	add    %eax,%eax
    9c1c:	01 c2                	add    %eax,%edx
    9c1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9c21:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    9c25:	01 d0                	add    %edx,%eax
    9c27:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  for ( ; sb > 0; sb--)
    9c2a:	eb 6e                	jmp    9c9a <III_stereo+0x7d4>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
    9c2c:	8b 4d 10             	mov    0x10(%ebp),%ecx
    9c2f:	8b 55 ec             	mov    -0x14(%ebp),%edx
    9c32:	89 d0                	mov    %edx,%eax
    9c34:	01 c0                	add    %eax,%eax
    9c36:	01 d0                	add    %edx,%eax
    9c38:	c1 e0 02             	shl    $0x2,%eax
    9c3b:	01 d0                	add    %edx,%eax
    9c3d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9c40:	01 d0                	add    %edx,%eax
    9c42:	83 c0 52             	add    $0x52,%eax
    9c45:	8b 54 81 0c          	mov    0xc(%ecx,%eax,4),%edx
    9c49:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9c4c:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                     if ( is_pos[i] != 7 )
    9c53:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9c56:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9c5d:	83 f8 07             	cmp    $0x7,%eax
    9c60:	74 30                	je     9c92 <III_stereo+0x7cc>
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
    9c62:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9c65:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9c6c:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    9c72:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    9c78:	dd 05 60 dd 00 00    	fldl   0xdd60
    9c7e:	de c9                	fmulp  %st,%st(1)
    9c80:	dd 1c 24             	fstpl  (%esp)
    9c83:	e8 67 b1 ff ff       	call   4def <tan>
    9c88:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9c8b:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                     i++;
    9c92:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
               }
               sfb = sfbcnt + 1;
               while( sfb<12 )
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
                  for ( ; sb > 0; sb--)
    9c96:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9c9a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9c9e:	7f 8c                	jg     9c2c <III_stereo+0x766>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
                     if ( is_pos[i] != 7 )
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
                     i++;
                  }
                  sfb++;
    9ca0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                     lines--;
                     i--;
                  }
               }
               sfb = sfbcnt + 1;
               while( sfb<12 )
    9ca4:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    9ca8:	0f 8e 06 ff ff ff    	jle    9bb4 <III_stereo+0x6ee>
                     i++;
                  }
                  sfb++;
               }

               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
    9cae:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9cb1:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9cb7:	05 dc f1 00 00       	add    $0xf1dc,%eax
    9cbc:	8b 50 0c             	mov    0xc(%eax),%edx
    9cbf:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9cc2:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9cc8:	05 d8 f1 00 00       	add    $0xf1d8,%eax
    9ccd:	8b 40 0c             	mov    0xc(%eax),%eax
    9cd0:	29 c2                	sub    %eax,%edx
    9cd2:	89 d0                	mov    %edx,%eax
    9cd4:	89 45 e8             	mov    %eax,-0x18(%ebp)
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
    9cd7:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9cda:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9ce0:	05 d8 f1 00 00       	add    $0xf1d8,%eax
    9ce5:	8b 50 0c             	mov    0xc(%eax),%edx
    9ce8:	89 d0                	mov    %edx,%eax
    9cea:	01 c0                	add    %eax,%eax
    9cec:	01 c2                	add    %eax,%edx
    9cee:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9cf1:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    9cf5:	01 d0                	add    %edx,%eax
    9cf7:	89 45 f4             	mov    %eax,-0xc(%ebp)
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
    9cfa:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9cfd:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9d03:	05 e0 f1 00 00       	add    $0xf1e0,%eax
    9d08:	8b 50 0c             	mov    0xc(%eax),%edx
    9d0b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9d0e:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9d14:	05 dc f1 00 00       	add    $0xf1dc,%eax
    9d19:	8b 40 0c             	mov    0xc(%eax),%eax
    9d1c:	29 c2                	sub    %eax,%edx
    9d1e:	89 d0                	mov    %edx,%eax
    9d20:	89 45 e8             	mov    %eax,-0x18(%ebp)
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
    9d23:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9d26:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9d2c:	05 dc f1 00 00       	add    $0xf1dc,%eax
    9d31:	8b 50 0c             	mov    0xc(%eax),%edx
    9d34:	89 d0                	mov    %edx,%eax
    9d36:	01 c0                	add    %eax,%eax
    9d38:	01 c2                	add    %eax,%edx
    9d3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    9d3d:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    9d41:	01 d0                	add    %edx,%eax
    9d43:	89 45 f0             	mov    %eax,-0x10(%ebp)
               for ( ; sb > 0; sb-- )
    9d46:	eb 30                	jmp    9d78 <III_stereo+0x8b2>
               {  is_pos[i] = is_pos[sfb];
    9d48:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9d4b:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    9d52:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9d55:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                  is_ratio[i] = is_ratio[sfb];
    9d5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9d5f:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    9d66:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9d69:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                  i++;
    9d70:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)

               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
               for ( ; sb > 0; sb-- )
    9d74:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9d78:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9d7c:	7f ca                	jg     9d48 <III_stereo+0x882>
                      i++;
                   }
                }
            }
         } else
         {  for ( j=0; j<3; j++ )
    9d7e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    9d82:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    9d86:	0f 8e ee fc ff ff    	jle    9a7a <III_stereo+0x5b4>
   for ( i=0; i<576; i++ )
      is_pos[i] = 7;

   if ((stereo == 2) && i_stereo )
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
      {  if( gr_info->mixed_block_flag )
    9d8c:	e9 f0 01 00 00       	jmp    9f81 <III_stereo+0xabb>
                  i++;
               }
            }
         }
      } else
      {  i = 31;
    9d91:	c7 45 f0 1f 00 00 00 	movl   $0x1f,-0x10(%ebp)
         ss = 17;
    9d98:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
         sb = 0;
    9d9f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
         while ( i >= 0 )
    9da6:	eb 63                	jmp    9e0b <III_stereo+0x945>
         {  if ( xr[1][i][ss] != 0.0 )
    9da8:	8b 45 08             	mov    0x8(%ebp),%eax
    9dab:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    9db1:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9db4:	89 d0                	mov    %edx,%eax
    9db6:	c1 e0 03             	shl    $0x3,%eax
    9db9:	01 d0                	add    %edx,%eax
    9dbb:	01 c0                	add    %eax,%eax
    9dbd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9dc0:	01 d0                	add    %edx,%eax
    9dc2:	dd 04 c1             	fldl   (%ecx,%eax,8)
    9dc5:	d9 ee                	fldz   
    9dc7:	df e9                	fucomip %st(1),%st
    9dc9:	7a 0a                	jp     9dd5 <III_stereo+0x90f>
    9dcb:	d9 ee                	fldz   
    9dcd:	df e9                	fucomip %st(1),%st
    9dcf:	dd d8                	fstp   %st(0)
    9dd1:	74 23                	je     9df6 <III_stereo+0x930>
    9dd3:	eb 02                	jmp    9dd7 <III_stereo+0x911>
    9dd5:	dd d8                	fstp   %st(0)
            {  sb = i*18+ss;
    9dd7:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9dda:	89 d0                	mov    %edx,%eax
    9ddc:	c1 e0 03             	shl    $0x3,%eax
    9ddf:	01 d0                	add    %edx,%eax
    9de1:	01 c0                	add    %eax,%eax
    9de3:	89 c2                	mov    %eax,%edx
    9de5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    9de8:	01 d0                	add    %edx,%eax
    9dea:	89 45 e8             	mov    %eax,-0x18(%ebp)
               i = -1;
    9ded:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    9df4:	eb 15                	jmp    9e0b <III_stereo+0x945>
            } else
            {  ss--;
    9df6:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
               if ( ss < 0 )
    9dfa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    9dfe:	79 0b                	jns    9e0b <III_stereo+0x945>
               {  i--;
    9e00:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
                  ss = 17;
    9e04:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
         }
      } else
      {  i = 31;
         ss = 17;
         sb = 0;
         while ( i >= 0 )
    9e0b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    9e0f:	79 97                	jns    9da8 <III_stereo+0x8e2>
               {  i--;
                  ss = 17;
               }
            }
         }
         i = 0;
    9e11:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
         while ( sfBandIndex[sfreq].l[i] <= sb )
    9e18:	eb 04                	jmp    9e1e <III_stereo+0x958>
            i++;
    9e1a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                  ss = 17;
               }
            }
         }
         i = 0;
         while ( sfBandIndex[sfreq].l[i] <= sb )
    9e1e:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9e21:	89 d0                	mov    %edx,%eax
    9e23:	c1 e0 03             	shl    $0x3,%eax
    9e26:	01 d0                	add    %edx,%eax
    9e28:	c1 e0 02             	shl    $0x2,%eax
    9e2b:	01 d0                	add    %edx,%eax
    9e2d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9e30:	01 d0                	add    %edx,%eax
    9e32:	8b 04 85 60 f1 00 00 	mov    0xf160(,%eax,4),%eax
    9e39:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    9e3c:	7e dc                	jle    9e1a <III_stereo+0x954>
            i++;
         sfb = i;
    9e3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9e41:	89 45 f4             	mov    %eax,-0xc(%ebp)
         i = sfBandIndex[sfreq].l[i];
    9e44:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9e47:	89 d0                	mov    %edx,%eax
    9e49:	c1 e0 03             	shl    $0x3,%eax
    9e4c:	01 d0                	add    %edx,%eax
    9e4e:	c1 e0 02             	shl    $0x2,%eax
    9e51:	01 d0                	add    %edx,%eax
    9e53:	8b 55 f0             	mov    -0x10(%ebp),%edx
    9e56:	01 d0                	add    %edx,%eax
    9e58:	8b 04 85 60 f1 00 00 	mov    0xf160(,%eax,4),%eax
    9e5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
         for ( ; sfb<21; sfb++ )
    9e62:	e9 a9 00 00 00       	jmp    9f10 <III_stereo+0xa4a>
         {  sb = sfBandIndex[sfreq].l[sfb+1] - sfBandIndex[sfreq].l[sfb];
    9e67:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9e6a:	8d 48 01             	lea    0x1(%eax),%ecx
    9e6d:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9e70:	89 d0                	mov    %edx,%eax
    9e72:	c1 e0 03             	shl    $0x3,%eax
    9e75:	01 d0                	add    %edx,%eax
    9e77:	c1 e0 02             	shl    $0x2,%eax
    9e7a:	01 d0                	add    %edx,%eax
    9e7c:	01 c8                	add    %ecx,%eax
    9e7e:	8b 0c 85 60 f1 00 00 	mov    0xf160(,%eax,4),%ecx
    9e85:	8b 55 c8             	mov    -0x38(%ebp),%edx
    9e88:	89 d0                	mov    %edx,%eax
    9e8a:	c1 e0 03             	shl    $0x3,%eax
    9e8d:	01 d0                	add    %edx,%eax
    9e8f:	c1 e0 02             	shl    $0x2,%eax
    9e92:	01 d0                	add    %edx,%eax
    9e94:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9e97:	01 d0                	add    %edx,%eax
    9e99:	8b 04 85 60 f1 00 00 	mov    0xf160(,%eax,4),%eax
    9ea0:	29 c1                	sub    %eax,%ecx
    9ea2:	89 c8                	mov    %ecx,%eax
    9ea4:	89 45 e8             	mov    %eax,-0x18(%ebp)
            for ( ; sb > 0; sb--)
    9ea7:	eb 5d                	jmp    9f06 <III_stereo+0xa40>
            {  is_pos[i] = (*scalefac)[1].l[sfb];
    9ea9:	8b 45 10             	mov    0x10(%ebp),%eax
    9eac:	8b 55 f4             	mov    -0xc(%ebp),%edx
    9eaf:	83 c2 3e             	add    $0x3e,%edx
    9eb2:	8b 14 90             	mov    (%eax,%edx,4),%edx
    9eb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9eb8:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
               if ( is_pos[i] != 7 )
    9ebf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9ec2:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9ec9:	83 f8 07             	cmp    $0x7,%eax
    9ecc:	74 30                	je     9efe <III_stereo+0xa38>
                  is_ratio[i] = tan( is_pos[i] * (PI / 12));
    9ece:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9ed1:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    9ed8:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    9ede:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    9ee4:	dd 05 60 dd 00 00    	fldl   0xdd60
    9eea:	de c9                	fmulp  %st,%st(1)
    9eec:	dd 1c 24             	fstpl  (%esp)
    9eef:	e8 fb ae ff ff       	call   4def <tan>
    9ef4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9ef7:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
               i++;
    9efe:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
            i++;
         sfb = i;
         i = sfBandIndex[sfreq].l[i];
         for ( ; sfb<21; sfb++ )
         {  sb = sfBandIndex[sfreq].l[sfb+1] - sfBandIndex[sfreq].l[sfb];
            for ( ; sb > 0; sb--)
    9f02:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9f06:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9f0a:	7f 9d                	jg     9ea9 <III_stereo+0x9e3>
         i = 0;
         while ( sfBandIndex[sfreq].l[i] <= sb )
            i++;
         sfb = i;
         i = sfBandIndex[sfreq].l[i];
         for ( ; sfb<21; sfb++ )
    9f0c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    9f10:	83 7d f4 14          	cmpl   $0x14,-0xc(%ebp)
    9f14:	0f 8e 4d ff ff ff    	jle    9e67 <III_stereo+0x9a1>
               if ( is_pos[i] != 7 )
                  is_ratio[i] = tan( is_pos[i] * (PI / 12));
               i++;
            }
         }
         sfb = sfBandIndex[sfreq].l[20];
    9f1a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9f1d:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9f23:	05 b0 f1 00 00       	add    $0xf1b0,%eax
    9f28:	8b 00                	mov    (%eax),%eax
    9f2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
         for ( sb = 576 - sfBandIndex[sfreq].l[21]; sb > 0; sb-- )
    9f2d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    9f30:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    9f36:	05 b4 f1 00 00       	add    $0xf1b4,%eax
    9f3b:	8b 00                	mov    (%eax),%eax
    9f3d:	ba 40 02 00 00       	mov    $0x240,%edx
    9f42:	29 c2                	sub    %eax,%edx
    9f44:	89 d0                	mov    %edx,%eax
    9f46:	89 45 e8             	mov    %eax,-0x18(%ebp)
    9f49:	eb 30                	jmp    9f7b <III_stereo+0xab5>
         {  is_pos[i] = is_pos[sfb];
    9f4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9f4e:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    9f55:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9f58:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
            is_ratio[i] = is_ratio[sfb];
    9f5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    9f62:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    9f69:	8b 45 f0             	mov    -0x10(%ebp),%eax
    9f6c:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
            i++;
    9f73:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                  is_ratio[i] = tan( is_pos[i] * (PI / 12));
               i++;
            }
         }
         sfb = sfBandIndex[sfreq].l[20];
         for ( sb = 576 - sfBandIndex[sfreq].l[21]; sb > 0; sb-- )
    9f77:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    9f7b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    9f7f:	7f ca                	jg     9f4b <III_stereo+0xa85>
            i++;
         }
      }
   }

   for(ch=0;ch<2;ch++)
    9f81:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    9f88:	eb 55                	jmp    9fdf <III_stereo+0xb19>
      for(sb=0;sb<SBLIMIT;sb++)
    9f8a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    9f91:	eb 42                	jmp    9fd5 <III_stereo+0xb0f>
         for(ss=0;ss<SSLIMIT;ss++)
    9f93:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    9f9a:	eb 2f                	jmp    9fcb <III_stereo+0xb05>
            lr[ch][sb][ss] = 0;
    9f9c:	8b 55 e0             	mov    -0x20(%ebp),%edx
    9f9f:	89 d0                	mov    %edx,%eax
    9fa1:	c1 e0 03             	shl    $0x3,%eax
    9fa4:	01 d0                	add    %edx,%eax
    9fa6:	c1 e0 09             	shl    $0x9,%eax
    9fa9:	89 c2                	mov    %eax,%edx
    9fab:	8b 45 0c             	mov    0xc(%ebp),%eax
    9fae:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    9fb1:	8b 55 e8             	mov    -0x18(%ebp),%edx
    9fb4:	89 d0                	mov    %edx,%eax
    9fb6:	c1 e0 03             	shl    $0x3,%eax
    9fb9:	01 d0                	add    %edx,%eax
    9fbb:	01 c0                	add    %eax,%eax
    9fbd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    9fc0:	01 d0                	add    %edx,%eax
    9fc2:	d9 ee                	fldz   
    9fc4:	dd 1c c1             	fstpl  (%ecx,%eax,8)
      }
   }

   for(ch=0;ch<2;ch++)
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
    9fc7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    9fcb:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    9fcf:	7e cb                	jle    9f9c <III_stereo+0xad6>
         }
      }
   }

   for(ch=0;ch<2;ch++)
      for(sb=0;sb<SBLIMIT;sb++)
    9fd1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    9fd5:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    9fd9:	7e b8                	jle    9f93 <III_stereo+0xacd>
            i++;
         }
      }
   }

   for(ch=0;ch<2;ch++)
    9fdb:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    9fdf:	83 7d e0 01          	cmpl   $0x1,-0x20(%ebp)
    9fe3:	7e a5                	jle    9f8a <III_stereo+0xac4>
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
            lr[ch][sb][ss] = 0;

   if (stereo==2)
    9fe5:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
    9fe9:	0f 85 3d 02 00 00    	jne    a22c <III_stereo+0xd66>
      for(sb=0;sb<SBLIMIT;sb++)
    9fef:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    9ff6:	e9 25 02 00 00       	jmp    a220 <III_stereo+0xd5a>
         for(ss=0;ss<SSLIMIT;ss++) {
    9ffb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    a002:	e9 0b 02 00 00       	jmp    a212 <III_stereo+0xd4c>
            i = (sb*18)+ss;
    a007:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a00a:	89 d0                	mov    %edx,%eax
    a00c:	c1 e0 03             	shl    $0x3,%eax
    a00f:	01 d0                	add    %edx,%eax
    a011:	01 c0                	add    %eax,%eax
    a013:	89 c2                	mov    %eax,%edx
    a015:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    a018:	01 d0                	add    %edx,%eax
    a01a:	89 45 f0             	mov    %eax,-0x10(%ebp)
            if ( is_pos[i] == 7 ) {
    a01d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a020:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    a027:	83 f8 07             	cmp    $0x7,%eax
    a02a:	0f 85 2c 01 00 00    	jne    a15c <III_stereo+0xc96>
               if ( ms_stereo ) {
    a030:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
    a034:	0f 84 b5 00 00 00    	je     a0ef <III_stereo+0xc29>
                  lr[0][sb][ss] = (xr[0][sb][ss]+xr[1][sb][ss])/1.41421356;
    a03a:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a03d:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a040:	89 d0                	mov    %edx,%eax
    a042:	c1 e0 03             	shl    $0x3,%eax
    a045:	01 d0                	add    %edx,%eax
    a047:	01 c0                	add    %eax,%eax
    a049:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a04c:	01 d0                	add    %edx,%eax
    a04e:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a051:	8b 45 08             	mov    0x8(%ebp),%eax
    a054:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    a05a:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a05d:	89 d0                	mov    %edx,%eax
    a05f:	c1 e0 03             	shl    $0x3,%eax
    a062:	01 d0                	add    %edx,%eax
    a064:	01 c0                	add    %eax,%eax
    a066:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a069:	01 d0                	add    %edx,%eax
    a06b:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a06e:	de c1                	faddp  %st,%st(1)
    a070:	dd 05 68 dd 00 00    	fldl   0xdd68
    a076:	de f9                	fdivrp %st,%st(1)
    a078:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    a07b:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a07e:	89 d0                	mov    %edx,%eax
    a080:	c1 e0 03             	shl    $0x3,%eax
    a083:	01 d0                	add    %edx,%eax
    a085:	01 c0                	add    %eax,%eax
    a087:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a08a:	01 d0                	add    %edx,%eax
    a08c:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                  lr[1][sb][ss] = (xr[0][sb][ss]-xr[1][sb][ss])/1.41421356;
    a08f:	8b 45 0c             	mov    0xc(%ebp),%eax
    a092:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    a098:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a09b:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a09e:	89 d0                	mov    %edx,%eax
    a0a0:	c1 e0 03             	shl    $0x3,%eax
    a0a3:	01 d0                	add    %edx,%eax
    a0a5:	01 c0                	add    %eax,%eax
    a0a7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a0aa:	01 d0                	add    %edx,%eax
    a0ac:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a0af:	8b 45 08             	mov    0x8(%ebp),%eax
    a0b2:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    a0b8:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a0bb:	89 d0                	mov    %edx,%eax
    a0bd:	c1 e0 03             	shl    $0x3,%eax
    a0c0:	01 d0                	add    %edx,%eax
    a0c2:	01 c0                	add    %eax,%eax
    a0c4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a0c7:	01 d0                	add    %edx,%eax
    a0c9:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a0cc:	de e9                	fsubrp %st,%st(1)
    a0ce:	dd 05 68 dd 00 00    	fldl   0xdd68
    a0d4:	de f9                	fdivrp %st,%st(1)
    a0d6:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a0d9:	89 d0                	mov    %edx,%eax
    a0db:	c1 e0 03             	shl    $0x3,%eax
    a0de:	01 d0                	add    %edx,%eax
    a0e0:	01 c0                	add    %eax,%eax
    a0e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a0e5:	01 d0                	add    %edx,%eax
    a0e7:	dd 1c c3             	fstpl  (%ebx,%eax,8)
    a0ea:	e9 1f 01 00 00       	jmp    a20e <III_stereo+0xd48>
               }
               else {
                  lr[0][sb][ss] = xr[0][sb][ss];
    a0ef:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a0f2:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a0f5:	89 d0                	mov    %edx,%eax
    a0f7:	c1 e0 03             	shl    $0x3,%eax
    a0fa:	01 d0                	add    %edx,%eax
    a0fc:	01 c0                	add    %eax,%eax
    a0fe:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a101:	01 d0                	add    %edx,%eax
    a103:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a106:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    a109:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a10c:	89 d0                	mov    %edx,%eax
    a10e:	c1 e0 03             	shl    $0x3,%eax
    a111:	01 d0                	add    %edx,%eax
    a113:	01 c0                	add    %eax,%eax
    a115:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a118:	01 d0                	add    %edx,%eax
    a11a:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                  lr[1][sb][ss] = xr[1][sb][ss];
    a11d:	8b 45 0c             	mov    0xc(%ebp),%eax
    a120:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    a126:	8b 45 08             	mov    0x8(%ebp),%eax
    a129:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    a12f:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a132:	89 d0                	mov    %edx,%eax
    a134:	c1 e0 03             	shl    $0x3,%eax
    a137:	01 d0                	add    %edx,%eax
    a139:	01 c0                	add    %eax,%eax
    a13b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a13e:	01 d0                	add    %edx,%eax
    a140:	dd 04 c3             	fldl   (%ebx,%eax,8)
    a143:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a146:	89 d0                	mov    %edx,%eax
    a148:	c1 e0 03             	shl    $0x3,%eax
    a14b:	01 d0                	add    %edx,%eax
    a14d:	01 c0                	add    %eax,%eax
    a14f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a152:	01 d0                	add    %edx,%eax
    a154:	dd 1c c1             	fstpl  (%ecx,%eax,8)
    a157:	e9 b2 00 00 00       	jmp    a20e <III_stereo+0xd48>
               }
            }
            else if (i_stereo ) {
    a15c:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
    a160:	0f 84 94 00 00 00    	je     a1fa <III_stereo+0xd34>
               lr[0][sb][ss] = xr[0][sb][ss] * (is_ratio[i]/(1+is_ratio[i]));
    a166:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a169:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a16c:	89 d0                	mov    %edx,%eax
    a16e:	c1 e0 03             	shl    $0x3,%eax
    a171:	01 d0                	add    %edx,%eax
    a173:	01 c0                	add    %eax,%eax
    a175:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a178:	01 d0                	add    %edx,%eax
    a17a:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a17d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a180:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    a187:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a18a:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    a191:	d9 e8                	fld1   
    a193:	de c1                	faddp  %st,%st(1)
    a195:	de f9                	fdivrp %st,%st(1)
    a197:	de c9                	fmulp  %st,%st(1)
    a199:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    a19c:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a19f:	89 d0                	mov    %edx,%eax
    a1a1:	c1 e0 03             	shl    $0x3,%eax
    a1a4:	01 d0                	add    %edx,%eax
    a1a6:	01 c0                	add    %eax,%eax
    a1a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a1ab:	01 d0                	add    %edx,%eax
    a1ad:	dd 1c c1             	fstpl  (%ecx,%eax,8)
               lr[1][sb][ss] = xr[0][sb][ss] * (1/(1+is_ratio[i]));
    a1b0:	8b 45 0c             	mov    0xc(%ebp),%eax
    a1b3:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    a1b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a1bc:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a1bf:	89 d0                	mov    %edx,%eax
    a1c1:	c1 e0 03             	shl    $0x3,%eax
    a1c4:	01 d0                	add    %edx,%eax
    a1c6:	01 c0                	add    %eax,%eax
    a1c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a1cb:	01 d0                	add    %edx,%eax
    a1cd:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a1d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a1d3:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    a1da:	d9 e8                	fld1   
    a1dc:	de c1                	faddp  %st,%st(1)
    a1de:	d9 e8                	fld1   
    a1e0:	de f1                	fdivp  %st,%st(1)
    a1e2:	de c9                	fmulp  %st,%st(1)
    a1e4:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a1e7:	89 d0                	mov    %edx,%eax
    a1e9:	c1 e0 03             	shl    $0x3,%eax
    a1ec:	01 d0                	add    %edx,%eax
    a1ee:	01 c0                	add    %eax,%eax
    a1f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a1f3:	01 d0                	add    %edx,%eax
    a1f5:	dd 1c c3             	fstpl  (%ebx,%eax,8)
    a1f8:	eb 14                	jmp    a20e <III_stereo+0xd48>
            }
            else {
               printf(0,"Error in streo processing\n");
    a1fa:	c7 44 24 04 00 cd 00 	movl   $0xcd00,0x4(%esp)
    a201:	00 
    a202:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    a209:	e8 3c a7 ff ff       	call   494a <printf>
         for(ss=0;ss<SSLIMIT;ss++)
            lr[ch][sb][ss] = 0;

   if (stereo==2)
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++) {
    a20e:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    a212:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    a216:	0f 8e eb fd ff ff    	jle    a007 <III_stereo+0xb41>
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
            lr[ch][sb][ss] = 0;

   if (stereo==2)
      for(sb=0;sb<SBLIMIT;sb++)
    a21c:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    a220:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    a224:	0f 8e d1 fd ff ff    	jle    9ffb <III_stereo+0xb35>
    a22a:	eb 54                	jmp    a280 <III_stereo+0xdba>
            else {
               printf(0,"Error in streo processing\n");
            }
         }
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
    a22c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    a233:	eb 45                	jmp    a27a <III_stereo+0xdb4>
         for(ss=0;ss<SSLIMIT;ss++)
    a235:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    a23c:	eb 32                	jmp    a270 <III_stereo+0xdaa>
            lr[0][sb][ss] = xr[0][sb][ss];
    a23e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    a241:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a244:	89 d0                	mov    %edx,%eax
    a246:	c1 e0 03             	shl    $0x3,%eax
    a249:	01 d0                	add    %edx,%eax
    a24b:	01 c0                	add    %eax,%eax
    a24d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a250:	01 d0                	add    %edx,%eax
    a252:	dd 04 c1             	fldl   (%ecx,%eax,8)
    a255:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    a258:	8b 55 e8             	mov    -0x18(%ebp),%edx
    a25b:	89 d0                	mov    %edx,%eax
    a25d:	c1 e0 03             	shl    $0x3,%eax
    a260:	01 d0                	add    %edx,%eax
    a262:	01 c0                	add    %eax,%eax
    a264:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    a267:	01 d0                	add    %edx,%eax
    a269:	dd 1c c1             	fstpl  (%ecx,%eax,8)
               printf(0,"Error in streo processing\n");
            }
         }
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
    a26c:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    a270:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    a274:	7e c8                	jle    a23e <III_stereo+0xd78>
            else {
               printf(0,"Error in streo processing\n");
            }
         }
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
    a276:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    a27a:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    a27e:	7e b5                	jle    a235 <III_stereo+0xd6f>
         for(ss=0;ss<SSLIMIT;ss++)
            lr[0][sb][ss] = xr[0][sb][ss];

}
    a280:	81 c4 50 1b 00 00    	add    $0x1b50,%esp
    a286:	5b                   	pop    %ebx
    a287:	5e                   	pop    %esi
    a288:	5d                   	pop    %ebp
    a289:	c3                   	ret    

0000a28a <III_antialias>:


double Ci[8]={-0.6,-0.535,-0.33,-0.185,-0.095,-0.041,-0.0142,-0.0037};
void III_antialias(double xr[SBLIMIT][SSLIMIT], double hybridIn[SBLIMIT][SSLIMIT], struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
    a28a:	55                   	push   %ebp
    a28b:	89 e5                	mov    %esp,%ebp
    a28d:	83 ec 48             	sub    $0x48,%esp
   static int    init = 1;
   static double ca[8],cs[8];
   double        bu,bd;  /* upper and lower butterfly inputs */
   int           ss,sb,sblim;

   if (init) {
    a290:	a1 c0 f3 00 00       	mov    0xf3c0,%eax
    a295:	85 c0                	test   %eax,%eax
    a297:	74 68                	je     a301 <III_antialias+0x77>
      int i;
      double    sq;
      for (i=0;i<8;i++) {
    a299:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    a2a0:	eb 4f                	jmp    a2f1 <III_antialias+0x67>
         sq=sqrt(1.0+Ci[i]*Ci[i]);
    a2a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a2a5:	dd 04 c5 80 f3 00 00 	fldl   0xf380(,%eax,8)
    a2ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a2af:	dd 04 c5 80 f3 00 00 	fldl   0xf380(,%eax,8)
    a2b6:	de c9                	fmulp  %st,%st(1)
    a2b8:	d9 e8                	fld1   
    a2ba:	de c1                	faddp  %st,%st(1)
    a2bc:	dd 1c 24             	fstpl  (%esp)
    a2bf:	e8 de ac ff ff       	call   4fa2 <sqrt>
    a2c4:	dd 5d e0             	fstpl  -0x20(%ebp)
         cs[i] = 1.0/sq;
    a2c7:	d9 e8                	fld1   
    a2c9:	dc 75 e0             	fdivl  -0x20(%ebp)
    a2cc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a2cf:	dd 1c c5 40 f4 00 00 	fstpl  0xf440(,%eax,8)
         ca[i] = Ci[i]/sq;
    a2d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a2d9:	dd 04 c5 80 f3 00 00 	fldl   0xf380(,%eax,8)
    a2e0:	dc 75 e0             	fdivl  -0x20(%ebp)
    a2e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a2e6:	dd 1c c5 80 f4 00 00 	fstpl  0xf480(,%eax,8)
   int           ss,sb,sblim;

   if (init) {
      int i;
      double    sq;
      for (i=0;i<8;i++) {
    a2ed:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    a2f1:	83 7d e8 07          	cmpl   $0x7,-0x18(%ebp)
    a2f5:	7e ab                	jle    a2a2 <III_antialias+0x18>
         sq=sqrt(1.0+Ci[i]*Ci[i]);
         cs[i] = 1.0/sq;
         ca[i] = Ci[i]/sq;
      }
      init = 0;
    a2f7:	c7 05 c0 f3 00 00 00 	movl   $0x0,0xf3c0
    a2fe:	00 00 00 
   }

   /* clear all inputs */

    for(sb=0;sb<SBLIMIT;sb++)
    a301:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    a308:	eb 4c                	jmp    a356 <III_antialias+0xcc>
       for(ss=0;ss<SSLIMIT;ss++)
    a30a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a311:	eb 39                	jmp    a34c <III_antialias+0xc2>
          hybridIn[sb][ss] = xr[sb][ss];
    a313:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a316:	89 d0                	mov    %edx,%eax
    a318:	c1 e0 03             	shl    $0x3,%eax
    a31b:	01 d0                	add    %edx,%eax
    a31d:	c1 e0 04             	shl    $0x4,%eax
    a320:	89 c2                	mov    %eax,%edx
    a322:	8b 45 0c             	mov    0xc(%ebp),%eax
    a325:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    a328:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a32b:	89 d0                	mov    %edx,%eax
    a32d:	c1 e0 03             	shl    $0x3,%eax
    a330:	01 d0                	add    %edx,%eax
    a332:	c1 e0 04             	shl    $0x4,%eax
    a335:	89 c2                	mov    %eax,%edx
    a337:	8b 45 08             	mov    0x8(%ebp),%eax
    a33a:	01 c2                	add    %eax,%edx
    a33c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a33f:	dd 04 c2             	fldl   (%edx,%eax,8)
    a342:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a345:	dd 1c c1             	fstpl  (%ecx,%eax,8)
   }

   /* clear all inputs */

    for(sb=0;sb<SBLIMIT;sb++)
       for(ss=0;ss<SSLIMIT;ss++)
    a348:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a34c:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    a350:	7e c1                	jle    a313 <III_antialias+0x89>
      init = 0;
   }

   /* clear all inputs */

    for(sb=0;sb<SBLIMIT;sb++)
    a352:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    a356:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    a35a:	7e ae                	jle    a30a <III_antialias+0x80>
       for(ss=0;ss<SSLIMIT;ss++)
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
    a35c:	8b 45 10             	mov    0x10(%ebp),%eax
    a35f:	8b 40 10             	mov    0x10(%eax),%eax
    a362:	85 c0                	test   %eax,%eax
    a364:	74 1a                	je     a380 <III_antialias+0xf6>
    a366:	8b 45 10             	mov    0x10(%ebp),%eax
    a369:	8b 40 14             	mov    0x14(%eax),%eax
    a36c:	83 f8 02             	cmp    $0x2,%eax
    a36f:	75 0f                	jne    a380 <III_antialias+0xf6>
       !gr_info->mixed_block_flag ) return;
    a371:	8b 45 10             	mov    0x10(%ebp),%eax
    a374:	8b 40 18             	mov    0x18(%eax),%eax

    for(sb=0;sb<SBLIMIT;sb++)
       for(ss=0;ss<SSLIMIT;ss++)
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
    a377:	85 c0                	test   %eax,%eax
    a379:	75 05                	jne    a380 <III_antialias+0xf6>
       !gr_info->mixed_block_flag ) return;
    a37b:	e9 1c 01 00 00       	jmp    a49c <III_antialias+0x212>

   if ( gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    a380:	8b 45 10             	mov    0x10(%ebp),%eax
    a383:	8b 40 10             	mov    0x10(%eax),%eax
    a386:	85 c0                	test   %eax,%eax
    a388:	74 1e                	je     a3a8 <III_antialias+0x11e>
    a38a:	8b 45 10             	mov    0x10(%ebp),%eax
    a38d:	8b 40 18             	mov    0x18(%eax),%eax
    a390:	85 c0                	test   %eax,%eax
    a392:	74 14                	je     a3a8 <III_antialias+0x11e>
     (gr_info->block_type == 2))
    a394:	8b 45 10             	mov    0x10(%ebp),%eax
    a397:	8b 40 14             	mov    0x14(%eax),%eax
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
       !gr_info->mixed_block_flag ) return;

   if ( gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    a39a:	83 f8 02             	cmp    $0x2,%eax
    a39d:	75 09                	jne    a3a8 <III_antialias+0x11e>
     (gr_info->block_type == 2))
      sblim = 1;
    a39f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    a3a6:	eb 07                	jmp    a3af <III_antialias+0x125>
   else
      sblim = SBLIMIT-1;
    a3a8:	c7 45 ec 1f 00 00 00 	movl   $0x1f,-0x14(%ebp)

   /* 31 alias-reduction operations between each pair of sub-bands */
   /* with 8 butterflies between each pair                         */

   for(sb=0;sb<sblim;sb++)
    a3af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    a3b6:	e9 d5 00 00 00       	jmp    a490 <III_antialias+0x206>
      for(ss=0;ss<8;ss++) {
    a3bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a3c2:	e9 bb 00 00 00       	jmp    a482 <III_antialias+0x1f8>
         bu = xr[sb][17-ss];
    a3c7:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a3ca:	89 d0                	mov    %edx,%eax
    a3cc:	c1 e0 03             	shl    $0x3,%eax
    a3cf:	01 d0                	add    %edx,%eax
    a3d1:	c1 e0 04             	shl    $0x4,%eax
    a3d4:	89 c2                	mov    %eax,%edx
    a3d6:	8b 45 08             	mov    0x8(%ebp),%eax
    a3d9:	01 c2                	add    %eax,%edx
    a3db:	b8 11 00 00 00       	mov    $0x11,%eax
    a3e0:	2b 45 f4             	sub    -0xc(%ebp),%eax
    a3e3:	dd 04 c2             	fldl   (%edx,%eax,8)
    a3e6:	dd 5d d8             	fstpl  -0x28(%ebp)
         bd = xr[sb+1][ss];
    a3e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a3ec:	8d 50 01             	lea    0x1(%eax),%edx
    a3ef:	89 d0                	mov    %edx,%eax
    a3f1:	c1 e0 03             	shl    $0x3,%eax
    a3f4:	01 d0                	add    %edx,%eax
    a3f6:	c1 e0 04             	shl    $0x4,%eax
    a3f9:	89 c2                	mov    %eax,%edx
    a3fb:	8b 45 08             	mov    0x8(%ebp),%eax
    a3fe:	01 c2                	add    %eax,%edx
    a400:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a403:	dd 04 c2             	fldl   (%edx,%eax,8)
    a406:	dd 5d d0             	fstpl  -0x30(%ebp)
         hybridIn[sb][17-ss] = (bu * cs[ss]) - (bd * ca[ss]);
    a409:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a40c:	89 d0                	mov    %edx,%eax
    a40e:	c1 e0 03             	shl    $0x3,%eax
    a411:	01 d0                	add    %edx,%eax
    a413:	c1 e0 04             	shl    $0x4,%eax
    a416:	89 c2                	mov    %eax,%edx
    a418:	8b 45 0c             	mov    0xc(%ebp),%eax
    a41b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    a41e:	b8 11 00 00 00       	mov    $0x11,%eax
    a423:	2b 45 f4             	sub    -0xc(%ebp),%eax
    a426:	8b 55 f4             	mov    -0xc(%ebp),%edx
    a429:	dd 04 d5 40 f4 00 00 	fldl   0xf440(,%edx,8)
    a430:	dc 4d d8             	fmull  -0x28(%ebp)
    a433:	8b 55 f4             	mov    -0xc(%ebp),%edx
    a436:	dd 04 d5 80 f4 00 00 	fldl   0xf480(,%edx,8)
    a43d:	dc 4d d0             	fmull  -0x30(%ebp)
    a440:	de e9                	fsubrp %st,%st(1)
    a442:	dd 1c c1             	fstpl  (%ecx,%eax,8)
         hybridIn[sb+1][ss] = (bd * cs[ss]) + (bu * ca[ss]);
    a445:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a448:	8d 50 01             	lea    0x1(%eax),%edx
    a44b:	89 d0                	mov    %edx,%eax
    a44d:	c1 e0 03             	shl    $0x3,%eax
    a450:	01 d0                	add    %edx,%eax
    a452:	c1 e0 04             	shl    $0x4,%eax
    a455:	89 c2                	mov    %eax,%edx
    a457:	8b 45 0c             	mov    0xc(%ebp),%eax
    a45a:	01 c2                	add    %eax,%edx
    a45c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a45f:	dd 04 c5 40 f4 00 00 	fldl   0xf440(,%eax,8)
    a466:	dc 4d d0             	fmull  -0x30(%ebp)
    a469:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a46c:	dd 04 c5 80 f4 00 00 	fldl   0xf480(,%eax,8)
    a473:	dc 4d d8             	fmull  -0x28(%ebp)
    a476:	de c1                	faddp  %st,%st(1)
    a478:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a47b:	dd 1c c2             	fstpl  (%edx,%eax,8)

   /* 31 alias-reduction operations between each pair of sub-bands */
   /* with 8 butterflies between each pair                         */

   for(sb=0;sb<sblim;sb++)
      for(ss=0;ss<8;ss++) {
    a47e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a482:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    a486:	0f 8e 3b ff ff ff    	jle    a3c7 <III_antialias+0x13d>
      sblim = SBLIMIT-1;

   /* 31 alias-reduction operations between each pair of sub-bands */
   /* with 8 butterflies between each pair                         */

   for(sb=0;sb<sblim;sb++)
    a48c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    a490:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a493:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    a496:	0f 8c 1f ff ff ff    	jl     a3bb <III_antialias+0x131>
         bu = xr[sb][17-ss];
         bd = xr[sb+1][ss];
         hybridIn[sb][17-ss] = (bu * cs[ss]) - (bd * ca[ss]);
         hybridIn[sb+1][ss] = (bd * cs[ss]) + (bu * ca[ss]);
         }
}
    a49c:	c9                   	leave  
    a49d:	c3                   	ret    

0000a49e <inv_mdct>:


void inv_mdct(double in[18], double out[36], int block_type)
{
    a49e:	55                   	push   %ebp
    a49f:	89 e5                	mov    %esp,%ebp
    a4a1:	81 ec a8 00 00 00    	sub    $0xa8,%esp
	double  tmp[12],sum;
	static  double  win[4][36];
	static  int init=0;
	static  double COS[4*36];

    if(init==0){
    a4a7:	a1 c0 f4 00 00       	mov    0xf4c0,%eax
    a4ac:	85 c0                	test   %eax,%eax
    a4ae:	0f 85 59 02 00 00    	jne    a70d <inv_mdct+0x26f>

    /* type 0 */
      for(i=0;i<36;i++)
    a4b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a4bb:	eb 29                	jmp    a4e6 <inv_mdct+0x48>
         win[0][i] = sin( PI/36 *(i+0.5) );
    a4bd:	db 45 f4             	fildl  -0xc(%ebp)
    a4c0:	dd 05 70 dd 00 00    	fldl   0xdd70
    a4c6:	de c1                	faddp  %st,%st(1)
    a4c8:	dd 05 78 dd 00 00    	fldl   0xdd78
    a4ce:	de c9                	fmulp  %st,%st(1)
    a4d0:	dd 1c 24             	fstpl  (%esp)
    a4d3:	e8 53 a8 ff ff       	call   4d2b <sin>
    a4d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a4db:	dd 1c c5 e0 f4 00 00 	fstpl  0xf4e0(,%eax,8)
	static  double COS[4*36];

    if(init==0){

    /* type 0 */
      for(i=0;i<36;i++)
    a4e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a4e6:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a4ea:	7e d1                	jle    a4bd <inv_mdct+0x1f>
         win[0][i] = sin( PI/36 *(i+0.5) );

    /* type 1*/
      for(i=0;i<18;i++)
    a4ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a4f3:	eb 2c                	jmp    a521 <inv_mdct+0x83>
         win[1][i] = sin( PI/36 *(i+0.5) );
    a4f5:	db 45 f4             	fildl  -0xc(%ebp)
    a4f8:	dd 05 70 dd 00 00    	fldl   0xdd70
    a4fe:	de c1                	faddp  %st,%st(1)
    a500:	dd 05 78 dd 00 00    	fldl   0xdd78
    a506:	de c9                	fmulp  %st,%st(1)
    a508:	dd 1c 24             	fstpl  (%esp)
    a50b:	e8 1b a8 ff ff       	call   4d2b <sin>
    a510:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a513:	83 c0 24             	add    $0x24,%eax
    a516:	dd 1c c5 e0 f4 00 00 	fstpl  0xf4e0(,%eax,8)
    /* type 0 */
      for(i=0;i<36;i++)
         win[0][i] = sin( PI/36 *(i+0.5) );

    /* type 1*/
      for(i=0;i<18;i++)
    a51d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a521:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    a525:	7e ce                	jle    a4f5 <inv_mdct+0x57>
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
    a527:	c7 45 f4 12 00 00 00 	movl   $0x12,-0xc(%ebp)
    a52e:	eb 13                	jmp    a543 <inv_mdct+0xa5>
         win[1][i] = 1.0;
    a530:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a533:	83 c0 24             	add    $0x24,%eax
    a536:	d9 e8                	fld1   
    a538:	dd 1c c5 e0 f4 00 00 	fstpl  0xf4e0(,%eax,8)
         win[0][i] = sin( PI/36 *(i+0.5) );

    /* type 1*/
      for(i=0;i<18;i++)
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
    a53f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a543:	83 7d f4 17          	cmpl   $0x17,-0xc(%ebp)
    a547:	7e e7                	jle    a530 <inv_mdct+0x92>
         win[1][i] = 1.0;
      for(i=24;i<30;i++)
    a549:	c7 45 f4 18 00 00 00 	movl   $0x18,-0xc(%ebp)
    a550:	eb 34                	jmp    a586 <inv_mdct+0xe8>
         win[1][i] = sin( PI/12 *(i+0.5-18) );
    a552:	db 45 f4             	fildl  -0xc(%ebp)
    a555:	dd 05 70 dd 00 00    	fldl   0xdd70
    a55b:	de c1                	faddp  %st,%st(1)
    a55d:	dd 05 80 dd 00 00    	fldl   0xdd80
    a563:	de e9                	fsubrp %st,%st(1)
    a565:	dd 05 60 dd 00 00    	fldl   0xdd60
    a56b:	de c9                	fmulp  %st,%st(1)
    a56d:	dd 1c 24             	fstpl  (%esp)
    a570:	e8 b6 a7 ff ff       	call   4d2b <sin>
    a575:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a578:	83 c0 24             	add    $0x24,%eax
    a57b:	dd 1c c5 e0 f4 00 00 	fstpl  0xf4e0(,%eax,8)
    /* type 1*/
      for(i=0;i<18;i++)
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
         win[1][i] = 1.0;
      for(i=24;i<30;i++)
    a582:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a586:	83 7d f4 1d          	cmpl   $0x1d,-0xc(%ebp)
    a58a:	7e c6                	jle    a552 <inv_mdct+0xb4>
         win[1][i] = sin( PI/12 *(i+0.5-18) );
      for(i=30;i<36;i++)
    a58c:	c7 45 f4 1e 00 00 00 	movl   $0x1e,-0xc(%ebp)
    a593:	eb 13                	jmp    a5a8 <inv_mdct+0x10a>
         win[1][i] = 0.0;
    a595:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a598:	83 c0 24             	add    $0x24,%eax
    a59b:	d9 ee                	fldz   
    a59d:	dd 1c c5 e0 f4 00 00 	fstpl  0xf4e0(,%eax,8)
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
         win[1][i] = 1.0;
      for(i=24;i<30;i++)
         win[1][i] = sin( PI/12 *(i+0.5-18) );
      for(i=30;i<36;i++)
    a5a4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a5a8:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a5ac:	7e e7                	jle    a595 <inv_mdct+0xf7>
         win[1][i] = 0.0;

    /* type 3*/
      for(i=0;i<6;i++)
    a5ae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a5b5:	eb 13                	jmp    a5ca <inv_mdct+0x12c>
         win[3][i] = 0.0;
    a5b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a5ba:	83 c0 6c             	add    $0x6c,%eax
    a5bd:	d9 ee                	fldz   
    a5bf:	dd 1c c5 e0 f4 00 00 	fstpl  0xf4e0(,%eax,8)
         win[1][i] = sin( PI/12 *(i+0.5-18) );
      for(i=30;i<36;i++)
         win[1][i] = 0.0;

    /* type 3*/
      for(i=0;i<6;i++)
    a5c6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a5ca:	83 7d f4 05          	cmpl   $0x5,-0xc(%ebp)
    a5ce:	7e e7                	jle    a5b7 <inv_mdct+0x119>
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
    a5d0:	c7 45 f4 06 00 00 00 	movl   $0x6,-0xc(%ebp)
    a5d7:	eb 34                	jmp    a60d <inv_mdct+0x16f>
         win[3][i] = sin( PI/12 *(i+0.5-6) );
    a5d9:	db 45 f4             	fildl  -0xc(%ebp)
    a5dc:	dd 05 70 dd 00 00    	fldl   0xdd70
    a5e2:	de c1                	faddp  %st,%st(1)
    a5e4:	dd 05 88 dd 00 00    	fldl   0xdd88
    a5ea:	de e9                	fsubrp %st,%st(1)
    a5ec:	dd 05 60 dd 00 00    	fldl   0xdd60
    a5f2:	de c9                	fmulp  %st,%st(1)
    a5f4:	dd 1c 24             	fstpl  (%esp)
    a5f7:	e8 2f a7 ff ff       	call   4d2b <sin>
    a5fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a5ff:	83 c0 6c             	add    $0x6c,%eax
    a602:	dd 1c c5 e0 f4 00 00 	fstpl  0xf4e0(,%eax,8)
         win[1][i] = 0.0;

    /* type 3*/
      for(i=0;i<6;i++)
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
    a609:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a60d:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    a611:	7e c6                	jle    a5d9 <inv_mdct+0x13b>
         win[3][i] = sin( PI/12 *(i+0.5-6) );
      for(i=12;i<18;i++)
    a613:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    a61a:	eb 13                	jmp    a62f <inv_mdct+0x191>
         win[3][i] =1.0;
    a61c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a61f:	83 c0 6c             	add    $0x6c,%eax
    a622:	d9 e8                	fld1   
    a624:	dd 1c c5 e0 f4 00 00 	fstpl  0xf4e0(,%eax,8)
    /* type 3*/
      for(i=0;i<6;i++)
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
         win[3][i] = sin( PI/12 *(i+0.5-6) );
      for(i=12;i<18;i++)
    a62b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a62f:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    a633:	7e e7                	jle    a61c <inv_mdct+0x17e>
         win[3][i] =1.0;
      for(i=18;i<36;i++)
    a635:	c7 45 f4 12 00 00 00 	movl   $0x12,-0xc(%ebp)
    a63c:	eb 2c                	jmp    a66a <inv_mdct+0x1cc>
         win[3][i] = sin( PI/36*(i+0.5) );
    a63e:	db 45 f4             	fildl  -0xc(%ebp)
    a641:	dd 05 70 dd 00 00    	fldl   0xdd70
    a647:	de c1                	faddp  %st,%st(1)
    a649:	dd 05 78 dd 00 00    	fldl   0xdd78
    a64f:	de c9                	fmulp  %st,%st(1)
    a651:	dd 1c 24             	fstpl  (%esp)
    a654:	e8 d2 a6 ff ff       	call   4d2b <sin>
    a659:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a65c:	83 c0 6c             	add    $0x6c,%eax
    a65f:	dd 1c c5 e0 f4 00 00 	fstpl  0xf4e0(,%eax,8)
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
         win[3][i] = sin( PI/12 *(i+0.5-6) );
      for(i=12;i<18;i++)
         win[3][i] =1.0;
      for(i=18;i<36;i++)
    a666:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a66a:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a66e:	7e ce                	jle    a63e <inv_mdct+0x1a0>
         win[3][i] = sin( PI/36*(i+0.5) );

    /* type 2*/
      for(i=0;i<12;i++)
    a670:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a677:	eb 2c                	jmp    a6a5 <inv_mdct+0x207>
         win[2][i] = sin( PI/12*(i+0.5) ) ;
    a679:	db 45 f4             	fildl  -0xc(%ebp)
    a67c:	dd 05 70 dd 00 00    	fldl   0xdd70
    a682:	de c1                	faddp  %st,%st(1)
    a684:	dd 05 60 dd 00 00    	fldl   0xdd60
    a68a:	de c9                	fmulp  %st,%st(1)
    a68c:	dd 1c 24             	fstpl  (%esp)
    a68f:	e8 97 a6 ff ff       	call   4d2b <sin>
    a694:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a697:	83 c0 48             	add    $0x48,%eax
    a69a:	dd 1c c5 e0 f4 00 00 	fstpl  0xf4e0(,%eax,8)
         win[3][i] =1.0;
      for(i=18;i<36;i++)
         win[3][i] = sin( PI/36*(i+0.5) );

    /* type 2*/
      for(i=0;i<12;i++)
    a6a1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a6a5:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    a6a9:	7e ce                	jle    a679 <inv_mdct+0x1db>
         win[2][i] = sin( PI/12*(i+0.5) ) ;
      for(i=12;i<36;i++)
    a6ab:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    a6b2:	eb 13                	jmp    a6c7 <inv_mdct+0x229>
         win[2][i] = 0.0 ;
    a6b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a6b7:	83 c0 48             	add    $0x48,%eax
    a6ba:	d9 ee                	fldz   
    a6bc:	dd 1c c5 e0 f4 00 00 	fstpl  0xf4e0(,%eax,8)
         win[3][i] = sin( PI/36*(i+0.5) );

    /* type 2*/
      for(i=0;i<12;i++)
         win[2][i] = sin( PI/12*(i+0.5) ) ;
      for(i=12;i<36;i++)
    a6c3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a6c7:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a6cb:	7e e7                	jle    a6b4 <inv_mdct+0x216>
         win[2][i] = 0.0 ;

      for (i=0; i<4*36; i++)
    a6cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a6d4:	eb 21                	jmp    a6f7 <inv_mdct+0x259>
         COS[i] = cos(PI/(2*36) * i);
    a6d6:	db 45 f4             	fildl  -0xc(%ebp)
    a6d9:	dd 05 90 dd 00 00    	fldl   0xdd90
    a6df:	de c9                	fmulp  %st,%st(1)
    a6e1:	dd 1c 24             	fstpl  (%esp)
    a6e4:	e8 e1 a6 ff ff       	call   4dca <cos>
    a6e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a6ec:	dd 1c c5 60 f9 00 00 	fstpl  0xf960(,%eax,8)
      for(i=0;i<12;i++)
         win[2][i] = sin( PI/12*(i+0.5) ) ;
      for(i=12;i<36;i++)
         win[2][i] = 0.0 ;

      for (i=0; i<4*36; i++)
    a6f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a6f7:	81 7d f4 8f 00 00 00 	cmpl   $0x8f,-0xc(%ebp)
    a6fe:	7e d6                	jle    a6d6 <inv_mdct+0x238>
         COS[i] = cos(PI/(2*36) * i);

      init++;
    a700:	a1 c0 f4 00 00       	mov    0xf4c0,%eax
    a705:	83 c0 01             	add    $0x1,%eax
    a708:	a3 c0 f4 00 00       	mov    %eax,0xf4c0
    }

    for(i=0;i<36;i++)
    a70d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a714:	eb 17                	jmp    a72d <inv_mdct+0x28f>
       out[i]=0;
    a716:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a719:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a720:	8b 45 0c             	mov    0xc(%ebp),%eax
    a723:	01 d0                	add    %edx,%eax
    a725:	d9 ee                	fldz   
    a727:	dd 18                	fstpl  (%eax)
         COS[i] = cos(PI/(2*36) * i);

      init++;
    }

    for(i=0;i<36;i++)
    a729:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a72d:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    a731:	7e e3                	jle    a716 <inv_mdct+0x278>
       out[i]=0;

    if(block_type == 2){
    a733:	83 7d 10 02          	cmpl   $0x2,0x10(%ebp)
    a737:	0f 85 85 01 00 00    	jne    a8c2 <inv_mdct+0x424>
       N=12;
    a73d:	c7 45 dc 0c 00 00 00 	movl   $0xc,-0x24(%ebp)
       for(i=0;i<3;i++){
    a744:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    a74b:	e9 63 01 00 00       	jmp    a8b3 <inv_mdct+0x415>
          for(p= 0;p<N;p++){
    a750:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    a757:	e9 df 00 00 00       	jmp    a83b <inv_mdct+0x39d>
             sum = 0.0;
    a75c:	d9 ee                	fldz   
    a75e:	dd 5d e0             	fstpl  -0x20(%ebp)
             for(m=0;m<N/2;m++)
    a761:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    a768:	e9 8f 00 00 00       	jmp    a7fc <inv_mdct+0x35e>
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
    a76d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    a770:	89 d0                	mov    %edx,%eax
    a772:	01 c0                	add    %eax,%eax
    a774:	01 c2                	add    %eax,%edx
    a776:	8b 45 f4             	mov    -0xc(%ebp),%eax
    a779:	01 d0                	add    %edx,%eax
    a77b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a782:	8b 45 08             	mov    0x8(%ebp),%eax
    a785:	01 d0                	add    %edx,%eax
    a787:	dd 00                	fldl   (%eax)
    a789:	dd 9d 68 ff ff ff    	fstpl  -0x98(%ebp)
    a78f:	8b 45 dc             	mov    -0x24(%ebp),%eax
    a792:	01 c0                	add    %eax,%eax
    a794:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    a79a:	db 85 74 ff ff ff    	fildl  -0x8c(%ebp)
    a7a0:	dd 05 98 dd 00 00    	fldl   0xdd98
    a7a6:	de f1                	fdivp  %st,%st(1)
    a7a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a7ab:	01 c0                	add    %eax,%eax
    a7ad:	8d 50 01             	lea    0x1(%eax),%edx
    a7b0:	8b 45 dc             	mov    -0x24(%ebp),%eax
    a7b3:	89 c1                	mov    %eax,%ecx
    a7b5:	c1 e9 1f             	shr    $0x1f,%ecx
    a7b8:	01 c8                	add    %ecx,%eax
    a7ba:	d1 f8                	sar    %eax
    a7bc:	01 d0                	add    %edx,%eax
    a7be:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    a7c4:	db 85 74 ff ff ff    	fildl  -0x8c(%ebp)
    a7ca:	de c9                	fmulp  %st,%st(1)
    a7cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a7cf:	01 c0                	add    %eax,%eax
    a7d1:	83 c0 01             	add    $0x1,%eax
    a7d4:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    a7da:	db 85 74 ff ff ff    	fildl  -0x8c(%ebp)
    a7e0:	de c9                	fmulp  %st,%st(1)
    a7e2:	dd 1c 24             	fstpl  (%esp)
    a7e5:	e8 e0 a5 ff ff       	call   4dca <cos>
    a7ea:	dc 8d 68 ff ff ff    	fmull  -0x98(%ebp)
    a7f0:	dd 45 e0             	fldl   -0x20(%ebp)
    a7f3:	de c1                	faddp  %st,%st(1)
    a7f5:	dd 5d e0             	fstpl  -0x20(%ebp)
    if(block_type == 2){
       N=12;
       for(i=0;i<3;i++){
          for(p= 0;p<N;p++){
             sum = 0.0;
             for(m=0;m<N/2;m++)
    a7f8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    a7fc:	8b 45 dc             	mov    -0x24(%ebp),%eax
    a7ff:	89 c2                	mov    %eax,%edx
    a801:	c1 ea 1f             	shr    $0x1f,%edx
    a804:	01 d0                	add    %edx,%eax
    a806:	d1 f8                	sar    %eax
    a808:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    a80b:	0f 8f 5c ff ff ff    	jg     a76d <inv_mdct+0x2cf>
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
             tmp[p] = sum * win[block_type][p] ;
    a811:	8b 55 10             	mov    0x10(%ebp),%edx
    a814:	89 d0                	mov    %edx,%eax
    a816:	c1 e0 03             	shl    $0x3,%eax
    a819:	01 d0                	add    %edx,%eax
    a81b:	c1 e0 02             	shl    $0x2,%eax
    a81e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    a821:	01 d0                	add    %edx,%eax
    a823:	dd 04 c5 e0 f4 00 00 	fldl   0xf4e0(,%eax,8)
    a82a:	dc 4d e0             	fmull  -0x20(%ebp)
    a82d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a830:	dd 9c c5 78 ff ff ff 	fstpl  -0x88(%ebp,%eax,8)
       out[i]=0;

    if(block_type == 2){
       N=12;
       for(i=0;i<3;i++){
          for(p= 0;p<N;p++){
    a837:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    a83b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a83e:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    a841:	0f 8c 15 ff ff ff    	jl     a75c <inv_mdct+0x2be>
             sum = 0.0;
             for(m=0;m<N/2;m++)
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
             tmp[p] = sum * win[block_type][p] ;
          }
          for(p=0;p<N;p++)
    a847:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    a84e:	eb 57                	jmp    a8a7 <inv_mdct+0x409>
             out[6*i+p+6] += tmp[p];
    a850:	8b 55 f4             	mov    -0xc(%ebp),%edx
    a853:	89 d0                	mov    %edx,%eax
    a855:	01 c0                	add    %eax,%eax
    a857:	01 d0                	add    %edx,%eax
    a859:	01 c0                	add    %eax,%eax
    a85b:	89 c2                	mov    %eax,%edx
    a85d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a860:	01 d0                	add    %edx,%eax
    a862:	83 c0 06             	add    $0x6,%eax
    a865:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a86c:	8b 45 0c             	mov    0xc(%ebp),%eax
    a86f:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    a872:	8b 55 f4             	mov    -0xc(%ebp),%edx
    a875:	89 d0                	mov    %edx,%eax
    a877:	01 c0                	add    %eax,%eax
    a879:	01 d0                	add    %edx,%eax
    a87b:	01 c0                	add    %eax,%eax
    a87d:	89 c2                	mov    %eax,%edx
    a87f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a882:	01 d0                	add    %edx,%eax
    a884:	83 c0 06             	add    $0x6,%eax
    a887:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a88e:	8b 45 0c             	mov    0xc(%ebp),%eax
    a891:	01 d0                	add    %edx,%eax
    a893:	dd 00                	fldl   (%eax)
    a895:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a898:	dd 84 c5 78 ff ff ff 	fldl   -0x88(%ebp,%eax,8)
    a89f:	de c1                	faddp  %st,%st(1)
    a8a1:	dd 19                	fstpl  (%ecx)
             sum = 0.0;
             for(m=0;m<N/2;m++)
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
             tmp[p] = sum * win[block_type][p] ;
          }
          for(p=0;p<N;p++)
    a8a3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    a8a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a8aa:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    a8ad:	7c a1                	jl     a850 <inv_mdct+0x3b2>
    for(i=0;i<36;i++)
       out[i]=0;

    if(block_type == 2){
       N=12;
       for(i=0;i<3;i++){
    a8af:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    a8b3:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
    a8b7:	0f 8e 93 fe ff ff    	jle    a750 <inv_mdct+0x2b2>
    a8bd:	e9 da 00 00 00       	jmp    a99c <inv_mdct+0x4fe>
          for(p=0;p<N;p++)
             out[6*i+p+6] += tmp[p];
       }
    }
    else{
      N=36;
    a8c2:	c7 45 dc 24 00 00 00 	movl   $0x24,-0x24(%ebp)
      for(p= 0;p<N;p++){
    a8c9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    a8d0:	e9 bb 00 00 00       	jmp    a990 <inv_mdct+0x4f2>
         sum = 0.0;
    a8d5:	d9 ee                	fldz   
    a8d7:	dd 5d e0             	fstpl  -0x20(%ebp)
         for(m=0;m<N/2;m++)
    a8da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    a8e1:	eb 6a                	jmp    a94d <inv_mdct+0x4af>
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
    a8e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a8e6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a8ed:	8b 45 08             	mov    0x8(%ebp),%eax
    a8f0:	01 d0                	add    %edx,%eax
    a8f2:	dd 00                	fldl   (%eax)
    a8f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a8f7:	01 c0                	add    %eax,%eax
    a8f9:	8d 50 01             	lea    0x1(%eax),%edx
    a8fc:	8b 45 dc             	mov    -0x24(%ebp),%eax
    a8ff:	89 c1                	mov    %eax,%ecx
    a901:	c1 e9 1f             	shr    $0x1f,%ecx
    a904:	01 c8                	add    %ecx,%eax
    a906:	d1 f8                	sar    %eax
    a908:	01 c2                	add    %eax,%edx
    a90a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    a90d:	01 c0                	add    %eax,%eax
    a90f:	83 c0 01             	add    $0x1,%eax
    a912:	89 d1                	mov    %edx,%ecx
    a914:	0f af c8             	imul   %eax,%ecx
    a917:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    a91c:	89 c8                	mov    %ecx,%eax
    a91e:	f7 ea                	imul   %edx
    a920:	c1 fa 05             	sar    $0x5,%edx
    a923:	89 c8                	mov    %ecx,%eax
    a925:	c1 f8 1f             	sar    $0x1f,%eax
    a928:	29 c2                	sub    %eax,%edx
    a92a:	89 d0                	mov    %edx,%eax
    a92c:	c1 e0 03             	shl    $0x3,%eax
    a92f:	01 d0                	add    %edx,%eax
    a931:	c1 e0 04             	shl    $0x4,%eax
    a934:	29 c1                	sub    %eax,%ecx
    a936:	89 ca                	mov    %ecx,%edx
    a938:	dd 04 d5 60 f9 00 00 	fldl   0xf960(,%edx,8)
    a93f:	de c9                	fmulp  %st,%st(1)
    a941:	dd 45 e0             	fldl   -0x20(%ebp)
    a944:	de c1                	faddp  %st,%st(1)
    a946:	dd 5d e0             	fstpl  -0x20(%ebp)
    }
    else{
      N=36;
      for(p= 0;p<N;p++){
         sum = 0.0;
         for(m=0;m<N/2;m++)
    a949:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    a94d:	8b 45 dc             	mov    -0x24(%ebp),%eax
    a950:	89 c2                	mov    %eax,%edx
    a952:	c1 ea 1f             	shr    $0x1f,%edx
    a955:	01 d0                	add    %edx,%eax
    a957:	d1 f8                	sar    %eax
    a959:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    a95c:	7f 85                	jg     a8e3 <inv_mdct+0x445>
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
         out[p] = sum * win[block_type][p];
    a95e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a961:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    a968:	8b 45 0c             	mov    0xc(%ebp),%eax
    a96b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    a96e:	8b 55 10             	mov    0x10(%ebp),%edx
    a971:	89 d0                	mov    %edx,%eax
    a973:	c1 e0 03             	shl    $0x3,%eax
    a976:	01 d0                	add    %edx,%eax
    a978:	c1 e0 02             	shl    $0x2,%eax
    a97b:	8b 55 ec             	mov    -0x14(%ebp),%edx
    a97e:	01 d0                	add    %edx,%eax
    a980:	dd 04 c5 e0 f4 00 00 	fldl   0xf4e0(,%eax,8)
    a987:	dc 4d e0             	fmull  -0x20(%ebp)
    a98a:	dd 19                	fstpl  (%ecx)
             out[6*i+p+6] += tmp[p];
       }
    }
    else{
      N=36;
      for(p= 0;p<N;p++){
    a98c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    a990:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a993:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    a996:	0f 8c 39 ff ff ff    	jl     a8d5 <inv_mdct+0x437>
         for(m=0;m<N/2;m++)
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
         out[p] = sum * win[block_type][p];
      }
    }
}
    a99c:	c9                   	leave  
    a99d:	c3                   	ret    

0000a99e <III_hybrid>:


void III_hybrid(double fsIn[SSLIMIT], double tsOut[SSLIMIT], int sb, int ch, struct gr_info_s *gr_info, struct frame_params *fr_ps)
/* fsIn:freq samples per subband in */
/* tsOut:time samples per subband out */
{
    a99e:	55                   	push   %ebp
    a99f:	89 e5                	mov    %esp,%ebp
    a9a1:	53                   	push   %ebx
    a9a2:	81 ec 54 01 00 00    	sub    $0x154,%esp
   double rawout[36];
   static double prevblck[2][SBLIMIT][SSLIMIT];
   static int init = 1;
   int bt;

   if (init) {
    a9a8:	a1 c4 f3 00 00       	mov    0xf3c4,%eax
    a9ad:	85 c0                	test   %eax,%eax
    a9af:	74 6f                	je     aa20 <III_hybrid+0x82>
      int i,j,k;

      for(i=0;i<2;i++)
    a9b1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    a9b8:	eb 56                	jmp    aa10 <III_hybrid+0x72>
         for(j=0;j<SBLIMIT;j++)
    a9ba:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    a9c1:	eb 43                	jmp    aa06 <III_hybrid+0x68>
            for(k=0;k<SSLIMIT;k++)
    a9c3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    a9ca:	eb 30                	jmp    a9fc <III_hybrid+0x5e>
               prevblck[i][j][k]=0.0;
    a9cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    a9cf:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    a9d2:	89 c2                	mov    %eax,%edx
    a9d4:	c1 e2 03             	shl    $0x3,%edx
    a9d7:	01 c2                	add    %eax,%edx
    a9d9:	8d 04 12             	lea    (%edx,%edx,1),%eax
    a9dc:	89 c2                	mov    %eax,%edx
    a9de:	89 c8                	mov    %ecx,%eax
    a9e0:	c1 e0 03             	shl    $0x3,%eax
    a9e3:	01 c8                	add    %ecx,%eax
    a9e5:	c1 e0 06             	shl    $0x6,%eax
    a9e8:	01 c2                	add    %eax,%edx
    a9ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
    a9ed:	01 d0                	add    %edx,%eax
    a9ef:	d9 ee                	fldz   
    a9f1:	dd 1c c5 e0 fd 00 00 	fstpl  0xfde0(,%eax,8)
   if (init) {
      int i,j,k;

      for(i=0;i<2;i++)
         for(j=0;j<SBLIMIT;j++)
            for(k=0;k<SSLIMIT;k++)
    a9f8:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    a9fc:	83 7d e8 11          	cmpl   $0x11,-0x18(%ebp)
    aa00:	7e ca                	jle    a9cc <III_hybrid+0x2e>

   if (init) {
      int i,j,k;

      for(i=0;i<2;i++)
         for(j=0;j<SBLIMIT;j++)
    aa02:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    aa06:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
    aa0a:	7e b7                	jle    a9c3 <III_hybrid+0x25>
   int bt;

   if (init) {
      int i,j,k;

      for(i=0;i<2;i++)
    aa0c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    aa10:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    aa14:	7e a4                	jle    a9ba <III_hybrid+0x1c>
         for(j=0;j<SBLIMIT;j++)
            for(k=0;k<SSLIMIT;k++)
               prevblck[i][j][k]=0.0;
      init = 0;
    aa16:	c7 05 c4 f3 00 00 00 	movl   $0x0,0xf3c4
    aa1d:	00 00 00 
   }

   bt = (gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    aa20:	8b 45 18             	mov    0x18(%ebp),%eax
    aa23:	8b 40 10             	mov    0x10(%eax),%eax
    aa26:	85 c0                	test   %eax,%eax
    aa28:	74 10                	je     aa3a <III_hybrid+0x9c>
    aa2a:	8b 45 18             	mov    0x18(%ebp),%eax
    aa2d:	8b 40 18             	mov    0x18(%eax),%eax
    aa30:	85 c0                	test   %eax,%eax
    aa32:	74 06                	je     aa3a <III_hybrid+0x9c>
    aa34:	83 7d 10 01          	cmpl   $0x1,0x10(%ebp)
    aa38:	7e 08                	jle    aa42 <III_hybrid+0xa4>
          (sb < 2)) ? 0 : gr_info->block_type;
    aa3a:	8b 45 18             	mov    0x18(%ebp),%eax
    aa3d:	8b 40 14             	mov    0x14(%eax),%eax
            for(k=0;k<SSLIMIT;k++)
               prevblck[i][j][k]=0.0;
      init = 0;
   }

   bt = (gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    aa40:	eb 05                	jmp    aa47 <III_hybrid+0xa9>
    aa42:	b8 00 00 00 00       	mov    $0x0,%eax
    aa47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
          (sb < 2)) ? 0 : gr_info->block_type;

   inv_mdct( fsIn, rawout, bt);
    aa4a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    aa4d:	89 44 24 08          	mov    %eax,0x8(%esp)
    aa51:	8d 85 c0 fe ff ff    	lea    -0x140(%ebp),%eax
    aa57:	89 44 24 04          	mov    %eax,0x4(%esp)
    aa5b:	8b 45 08             	mov    0x8(%ebp),%eax
    aa5e:	89 04 24             	mov    %eax,(%esp)
    aa61:	e8 38 fa ff ff       	call   a49e <inv_mdct>

   /* overlap addition */
   for(ss=0; ss<SSLIMIT; ss++) {
    aa66:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    aa6d:	e9 83 00 00 00       	jmp    aaf5 <III_hybrid+0x157>
      tsOut[ss] = rawout[ss] + prevblck[ch][sb][ss];
    aa72:	8b 45 f4             	mov    -0xc(%ebp),%eax
    aa75:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    aa7c:	8b 45 0c             	mov    0xc(%ebp),%eax
    aa7f:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    aa82:	8b 45 f4             	mov    -0xc(%ebp),%eax
    aa85:	dd 84 c5 c0 fe ff ff 	fldl   -0x140(%ebp,%eax,8)
    aa8c:	8b 45 10             	mov    0x10(%ebp),%eax
    aa8f:	8b 4d 14             	mov    0x14(%ebp),%ecx
    aa92:	89 c2                	mov    %eax,%edx
    aa94:	c1 e2 03             	shl    $0x3,%edx
    aa97:	01 c2                	add    %eax,%edx
    aa99:	8d 04 12             	lea    (%edx,%edx,1),%eax
    aa9c:	89 c2                	mov    %eax,%edx
    aa9e:	89 c8                	mov    %ecx,%eax
    aaa0:	c1 e0 03             	shl    $0x3,%eax
    aaa3:	01 c8                	add    %ecx,%eax
    aaa5:	c1 e0 06             	shl    $0x6,%eax
    aaa8:	01 c2                	add    %eax,%edx
    aaaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    aaad:	01 d0                	add    %edx,%eax
    aaaf:	dd 04 c5 e0 fd 00 00 	fldl   0xfde0(,%eax,8)
    aab6:	de c1                	faddp  %st,%st(1)
    aab8:	dd 1b                	fstpl  (%ebx)
      prevblck[ch][sb][ss] = rawout[ss+18];
    aaba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    aabd:	83 c0 12             	add    $0x12,%eax
    aac0:	dd 84 c5 c0 fe ff ff 	fldl   -0x140(%ebp,%eax,8)
    aac7:	8b 45 10             	mov    0x10(%ebp),%eax
    aaca:	8b 4d 14             	mov    0x14(%ebp),%ecx
    aacd:	89 c2                	mov    %eax,%edx
    aacf:	c1 e2 03             	shl    $0x3,%edx
    aad2:	01 c2                	add    %eax,%edx
    aad4:	8d 04 12             	lea    (%edx,%edx,1),%eax
    aad7:	89 c2                	mov    %eax,%edx
    aad9:	89 c8                	mov    %ecx,%eax
    aadb:	c1 e0 03             	shl    $0x3,%eax
    aade:	01 c8                	add    %ecx,%eax
    aae0:	c1 e0 06             	shl    $0x6,%eax
    aae3:	01 c2                	add    %eax,%edx
    aae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    aae8:	01 d0                	add    %edx,%eax
    aaea:	dd 1c c5 e0 fd 00 00 	fstpl  0xfde0(,%eax,8)
          (sb < 2)) ? 0 : gr_info->block_type;

   inv_mdct( fsIn, rawout, bt);

   /* overlap addition */
   for(ss=0; ss<SSLIMIT; ss++) {
    aaf1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    aaf5:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    aaf9:	0f 8e 73 ff ff ff    	jle    aa72 <III_hybrid+0xd4>
      tsOut[ss] = rawout[ss] + prevblck[ch][sb][ss];
      prevblck[ch][sb][ss] = rawout[ss+18];
   }
}
    aaff:	81 c4 54 01 00 00    	add    $0x154,%esp
    ab05:	5b                   	pop    %ebx
    ab06:	5d                   	pop    %ebp
    ab07:	c3                   	ret    

0000ab08 <create_syn_filter>:


/* create in synthesis filter */
void create_syn_filter(double filter[64][SBLIMIT])
{
    ab08:	55                   	push   %ebp
    ab09:	89 e5                	mov    %esp,%ebp
    ab0b:	57                   	push   %edi
    ab0c:	56                   	push   %esi
    ab0d:	53                   	push   %ebx
    ab0e:	83 ec 1c             	sub    $0x1c,%esp
	register int i,k;

	for (i=0; i<64; i++)
    ab11:	be 00 00 00 00       	mov    $0x0,%esi
    ab16:	e9 1c 01 00 00       	jmp    ac37 <create_syn_filter+0x12f>
		for (k=0; k<32; k++) {
    ab1b:	bb 00 00 00 00       	mov    $0x0,%ebx
    ab20:	e9 06 01 00 00       	jmp    ac2b <create_syn_filter+0x123>
			if ((filter[i][k] = 1e9*cos((double)((PI64*i+PI4)*(2*k+1)))) >= 0)
    ab25:	89 f0                	mov    %esi,%eax
    ab27:	c1 e0 08             	shl    $0x8,%eax
    ab2a:	89 c2                	mov    %eax,%edx
    ab2c:	8b 45 08             	mov    0x8(%ebp),%eax
    ab2f:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    ab32:	89 75 e0             	mov    %esi,-0x20(%ebp)
    ab35:	db 45 e0             	fildl  -0x20(%ebp)
    ab38:	dd 05 a0 dd 00 00    	fldl   0xdda0
    ab3e:	de c9                	fmulp  %st,%st(1)
    ab40:	dd 05 a8 dd 00 00    	fldl   0xdda8
    ab46:	de c1                	faddp  %st,%st(1)
    ab48:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
    ab4b:	83 c0 01             	add    $0x1,%eax
    ab4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    ab51:	db 45 e0             	fildl  -0x20(%ebp)
    ab54:	de c9                	fmulp  %st,%st(1)
    ab56:	dd 1c 24             	fstpl  (%esp)
    ab59:	e8 6c a2 ff ff       	call   4dca <cos>
    ab5e:	dd 05 b0 dd 00 00    	fldl   0xddb0
    ab64:	de c9                	fmulp  %st,%st(1)
    ab66:	dd 1c df             	fstpl  (%edi,%ebx,8)
    ab69:	dd 04 df             	fldl   (%edi,%ebx,8)
    ab6c:	d9 ee                	fldz   
    ab6e:	d9 c9                	fxch   %st(1)
    ab70:	df e9                	fucomip %st(1),%st
    ab72:	dd d8                	fstp   %st(0)
    ab74:	72 47                	jb     abbd <create_syn_filter+0xb5>
				filter[i][k] = (int)(filter[i][k]+0.5);
    ab76:	89 f0                	mov    %esi,%eax
    ab78:	c1 e0 08             	shl    $0x8,%eax
    ab7b:	89 c2                	mov    %eax,%edx
    ab7d:	8b 45 08             	mov    0x8(%ebp),%eax
    ab80:	01 c2                	add    %eax,%edx
    ab82:	89 f0                	mov    %esi,%eax
    ab84:	c1 e0 08             	shl    $0x8,%eax
    ab87:	89 c1                	mov    %eax,%ecx
    ab89:	8b 45 08             	mov    0x8(%ebp),%eax
    ab8c:	01 c8                	add    %ecx,%eax
    ab8e:	dd 04 d8             	fldl   (%eax,%ebx,8)
    ab91:	dd 05 70 dd 00 00    	fldl   0xdd70
    ab97:	de c1                	faddp  %st,%st(1)
    ab99:	d9 7d e6             	fnstcw -0x1a(%ebp)
    ab9c:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    aba0:	b4 0c                	mov    $0xc,%ah
    aba2:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    aba6:	d9 6d e4             	fldcw  -0x1c(%ebp)
    aba9:	db 5d e0             	fistpl -0x20(%ebp)
    abac:	d9 6d e6             	fldcw  -0x1a(%ebp)
    abaf:	8b 45 e0             	mov    -0x20(%ebp),%eax
    abb2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    abb5:	db 45 e0             	fildl  -0x20(%ebp)
    abb8:	dd 1c da             	fstpl  (%edx,%ebx,8)
    abbb:	eb 45                	jmp    ac02 <create_syn_filter+0xfa>
				//modf(filter[i][k]+0.5, &filter[i][k]);
			else
				filter[i][k] = (int)(filter[i][k]-0.5);
    abbd:	89 f0                	mov    %esi,%eax
    abbf:	c1 e0 08             	shl    $0x8,%eax
    abc2:	89 c2                	mov    %eax,%edx
    abc4:	8b 45 08             	mov    0x8(%ebp),%eax
    abc7:	01 c2                	add    %eax,%edx
    abc9:	89 f0                	mov    %esi,%eax
    abcb:	c1 e0 08             	shl    $0x8,%eax
    abce:	89 c1                	mov    %eax,%ecx
    abd0:	8b 45 08             	mov    0x8(%ebp),%eax
    abd3:	01 c8                	add    %ecx,%eax
    abd5:	dd 04 d8             	fldl   (%eax,%ebx,8)
    abd8:	dd 05 70 dd 00 00    	fldl   0xdd70
    abde:	de e9                	fsubrp %st,%st(1)
    abe0:	d9 7d e6             	fnstcw -0x1a(%ebp)
    abe3:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    abe7:	b4 0c                	mov    $0xc,%ah
    abe9:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    abed:	d9 6d e4             	fldcw  -0x1c(%ebp)
    abf0:	db 5d e0             	fistpl -0x20(%ebp)
    abf3:	d9 6d e6             	fldcw  -0x1a(%ebp)
    abf6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    abf9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    abfc:	db 45 e0             	fildl  -0x20(%ebp)
    abff:	dd 1c da             	fstpl  (%edx,%ebx,8)
				//modf(filter[i][k]-0.5, &filter[i][k]);
			filter[i][k] *= 1e-9;
    ac02:	89 f0                	mov    %esi,%eax
    ac04:	c1 e0 08             	shl    $0x8,%eax
    ac07:	89 c2                	mov    %eax,%edx
    ac09:	8b 45 08             	mov    0x8(%ebp),%eax
    ac0c:	01 d0                	add    %edx,%eax
    ac0e:	89 f2                	mov    %esi,%edx
    ac10:	89 d1                	mov    %edx,%ecx
    ac12:	c1 e1 08             	shl    $0x8,%ecx
    ac15:	8b 55 08             	mov    0x8(%ebp),%edx
    ac18:	01 ca                	add    %ecx,%edx
    ac1a:	dd 04 da             	fldl   (%edx,%ebx,8)
    ac1d:	dd 05 b8 dd 00 00    	fldl   0xddb8
    ac23:	de c9                	fmulp  %st,%st(1)
    ac25:	dd 1c d8             	fstpl  (%eax,%ebx,8)
void create_syn_filter(double filter[64][SBLIMIT])
{
	register int i,k;

	for (i=0; i<64; i++)
		for (k=0; k<32; k++) {
    ac28:	83 c3 01             	add    $0x1,%ebx
    ac2b:	83 fb 1f             	cmp    $0x1f,%ebx
    ac2e:	0f 8e f1 fe ff ff    	jle    ab25 <create_syn_filter+0x1d>
/* create in synthesis filter */
void create_syn_filter(double filter[64][SBLIMIT])
{
	register int i,k;

	for (i=0; i<64; i++)
    ac34:	83 c6 01             	add    $0x1,%esi
    ac37:	83 fe 3f             	cmp    $0x3f,%esi
    ac3a:	0f 8e db fe ff ff    	jle    ab1b <create_syn_filter+0x13>
			else
				filter[i][k] = (int)(filter[i][k]-0.5);
				//modf(filter[i][k]-0.5, &filter[i][k]);
			filter[i][k] *= 1e-9;
		}
}
    ac40:	83 c4 1c             	add    $0x1c,%esp
    ac43:	5b                   	pop    %ebx
    ac44:	5e                   	pop    %esi
    ac45:	5f                   	pop    %edi
    ac46:	5d                   	pop    %ebp
    ac47:	c3                   	ret    

0000ac48 <read_syn_window>:



/* read in synthesis window */
void read_syn_window(double window[HAN_SIZE])
{
    ac48:	55                   	push   %ebp
    ac49:	89 e5                	mov    %esp,%ebp
    ac4b:	57                   	push   %edi
    ac4c:	56                   	push   %esi
    ac4d:	53                   	push   %ebx
    ac4e:	81 ec 14 10 00 00    	sub    $0x1014,%esp
	double gb_window[HAN_SIZE] = {0.0000000000, -0.0000152590, -0.0000152590, -0.0000152590,
    ac54:	8d 95 e8 ef ff ff    	lea    -0x1018(%ebp),%edx
    ac5a:	bb 20 cd 00 00       	mov    $0xcd20,%ebx
    ac5f:	b8 00 04 00 00       	mov    $0x400,%eax
    ac64:	89 d7                	mov    %edx,%edi
    ac66:	89 de                	mov    %ebx,%esi
    ac68:	89 c1                	mov    %eax,%ecx
    ac6a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		0.0000762940, 0.0000762940, 0.0000610350, 0.0000610350,
		0.0000457760, 0.0000457760, 0.0000305180, 0.0000305180,
		0.0000305180, 0.0000305180, 0.0000152590, 0.0000152590,
		0.0000152590, 0.0000152590, 0.0000152590, 0.0000152590,
	};
	window = gb_window;
    ac6c:	8d 85 e8 ef ff ff    	lea    -0x1018(%ebp),%eax
    ac72:	89 45 ec             	mov    %eax,-0x14(%ebp)
}
    ac75:	81 c4 14 10 00 00    	add    $0x1014,%esp
    ac7b:	5b                   	pop    %ebx
    ac7c:	5e                   	pop    %esi
    ac7d:	5f                   	pop    %edi
    ac7e:	5d                   	pop    %ebp
    ac7f:	c3                   	ret    

0000ac80 <SubBandSynthesis>:

int SubBandSynthesis (double *bandPtr, int channel, short *samples)
{
    ac80:	55                   	push   %ebp
    ac81:	89 e5                	mov    %esp,%ebp
    ac83:	57                   	push   %edi
    ac84:	56                   	push   %esi
    ac85:	53                   	push   %ebx
    ac86:	83 ec 2c             	sub    $0x2c,%esp
	static NN *filter;
	typedef double BB[2][2*HAN_SIZE];
	static BB *buf;
	static int bufOffset[2] = {64,64};
	static double *window;
	int clip = 0;               /* count & return how many samples clipped */
    ac89:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	if (init) {
    ac90:	a1 c8 f3 00 00       	mov    0xf3c8,%eax
    ac95:	85 c0                	test   %eax,%eax
    ac97:	74 6f                	je     ad08 <SubBandSynthesis+0x88>
		buf = (BB *) mem_alloc(sizeof(BB),"BB");
    ac99:	c7 44 24 04 20 dd 00 	movl   $0xdd20,0x4(%esp)
    aca0:	00 
    aca1:	c7 04 24 00 40 00 00 	movl   $0x4000,(%esp)
    aca8:	e8 15 a8 ff ff       	call   54c2 <mem_alloc>
    acad:	a3 e0 21 01 00       	mov    %eax,0x121e0
		filter = (NN *) mem_alloc(sizeof(NN), "NN");
    acb2:	c7 44 24 04 23 dd 00 	movl   $0xdd23,0x4(%esp)
    acb9:	00 
    acba:	c7 04 24 00 40 00 00 	movl   $0x4000,(%esp)
    acc1:	e8 fc a7 ff ff       	call   54c2 <mem_alloc>
    acc6:	a3 e4 21 01 00       	mov    %eax,0x121e4
		create_syn_filter(*filter);
    accb:	a1 e4 21 01 00       	mov    0x121e4,%eax
    acd0:	89 04 24             	mov    %eax,(%esp)
    acd3:	e8 30 fe ff ff       	call   ab08 <create_syn_filter>
		window = (double *) mem_alloc(sizeof(double) * HAN_SIZE, "WIN");
    acd8:	c7 44 24 04 26 dd 00 	movl   $0xdd26,0x4(%esp)
    acdf:	00 
    ace0:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    ace7:	e8 d6 a7 ff ff       	call   54c2 <mem_alloc>
    acec:	a3 e8 21 01 00       	mov    %eax,0x121e8
		read_syn_window(window);
    acf1:	a1 e8 21 01 00       	mov    0x121e8,%eax
    acf6:	89 04 24             	mov    %eax,(%esp)
    acf9:	e8 4a ff ff ff       	call   ac48 <read_syn_window>
		init = 0;
    acfe:	c7 05 c8 f3 00 00 00 	movl   $0x0,0xf3c8
    ad05:	00 00 00 
	}
/*    if (channel == 0) */
	bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
    ad08:	8b 45 0c             	mov    0xc(%ebp),%eax
    ad0b:	8b 04 85 cc f3 00 00 	mov    0xf3cc(,%eax,4),%eax
    ad12:	83 e8 40             	sub    $0x40,%eax
    ad15:	25 ff 03 00 00       	and    $0x3ff,%eax
    ad1a:	89 c2                	mov    %eax,%edx
    ad1c:	8b 45 0c             	mov    0xc(%ebp),%eax
    ad1f:	89 14 85 cc f3 00 00 	mov    %edx,0xf3cc(,%eax,4)
	bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);
    ad26:	8b 15 e0 21 01 00    	mov    0x121e0,%edx
    ad2c:	8b 45 0c             	mov    0xc(%ebp),%eax
    ad2f:	8b 04 85 cc f3 00 00 	mov    0xf3cc(,%eax,4),%eax
    ad36:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    ad39:	c1 e1 0a             	shl    $0xa,%ecx
    ad3c:	01 c8                	add    %ecx,%eax
    ad3e:	c1 e0 03             	shl    $0x3,%eax
    ad41:	8d 3c 02             	lea    (%edx,%eax,1),%edi

	for (i=0; i<64; i++) {
    ad44:	bb 00 00 00 00       	mov    $0x0,%ebx
    ad49:	eb 40                	jmp    ad8b <SubBandSynthesis+0x10b>
		sum = 0;
    ad4b:	d9 ee                	fldz   
		for (k=0; k<32; k++)
    ad4d:	be 00 00 00 00       	mov    $0x0,%esi
    ad52:	eb 26                	jmp    ad7a <SubBandSynthesis+0xfa>
			sum += bandPtr[k] * (*filter)[i][k];
    ad54:	89 f0                	mov    %esi,%eax
    ad56:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    ad5d:	8b 45 08             	mov    0x8(%ebp),%eax
    ad60:	01 d0                	add    %edx,%eax
    ad62:	dd 00                	fldl   (%eax)
    ad64:	a1 e4 21 01 00       	mov    0x121e4,%eax
    ad69:	89 da                	mov    %ebx,%edx
    ad6b:	c1 e2 05             	shl    $0x5,%edx
    ad6e:	01 f2                	add    %esi,%edx
    ad70:	dd 04 d0             	fldl   (%eax,%edx,8)
    ad73:	de c9                	fmulp  %st,%st(1)
    ad75:	de c1                	faddp  %st,%st(1)
	bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
	bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);

	for (i=0; i<64; i++) {
		sum = 0;
		for (k=0; k<32; k++)
    ad77:	83 c6 01             	add    $0x1,%esi
    ad7a:	83 fe 1f             	cmp    $0x1f,%esi
    ad7d:	7e d5                	jle    ad54 <SubBandSynthesis+0xd4>
			sum += bandPtr[k] * (*filter)[i][k];
		bufOffsetPtr[i] = sum;
    ad7f:	89 d8                	mov    %ebx,%eax
    ad81:	c1 e0 03             	shl    $0x3,%eax
    ad84:	01 f8                	add    %edi,%eax
    ad86:	dd 18                	fstpl  (%eax)
	}
/*    if (channel == 0) */
	bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
	bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);

	for (i=0; i<64; i++) {
    ad88:	83 c3 01             	add    $0x1,%ebx
    ad8b:	83 fb 3f             	cmp    $0x3f,%ebx
    ad8e:	7e bb                	jle    ad4b <SubBandSynthesis+0xcb>
			sum += bandPtr[k] * (*filter)[i][k];
		bufOffsetPtr[i] = sum;
	}
	/*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
    ad90:	bf 00 00 00 00       	mov    $0x0,%edi
    ad95:	e9 c7 00 00 00       	jmp    ae61 <SubBandSynthesis+0x1e1>
		sum = 0;
    ad9a:	d9 ee                	fldz   
		for (i=0; i<16; i++) {
    ad9c:	bb 00 00 00 00       	mov    $0x0,%ebx
    ada1:	eb 4c                	jmp    adef <SubBandSynthesis+0x16f>
			k = j + (i<<5);
    ada3:	89 d8                	mov    %ebx,%eax
    ada5:	c1 e0 05             	shl    $0x5,%eax
    ada8:	8d 34 38             	lea    (%eax,%edi,1),%esi
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
    adab:	a1 e8 21 01 00       	mov    0x121e8,%eax
    adb0:	89 f2                	mov    %esi,%edx
    adb2:	c1 e2 03             	shl    $0x3,%edx
    adb5:	01 d0                	add    %edx,%eax
    adb7:	dd 00                	fldl   (%eax)
    adb9:	a1 e0 21 01 00       	mov    0x121e0,%eax
    adbe:	8d 53 01             	lea    0x1(%ebx),%edx
    adc1:	d1 fa                	sar    %edx
    adc3:	c1 e2 06             	shl    $0x6,%edx
    adc6:	8d 0c 32             	lea    (%edx,%esi,1),%ecx
												bufOffset[channel]) & 0x3ff];
    adc9:	8b 55 0c             	mov    0xc(%ebp),%edx
    adcc:	8b 14 95 cc f3 00 00 	mov    0xf3cc(,%edx,4),%edx
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
		sum = 0;
		for (i=0; i<16; i++) {
			k = j + (i<<5);
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
    add3:	01 ca                	add    %ecx,%edx
												bufOffset[channel]) & 0x3ff];
    add5:	89 d1                	mov    %edx,%ecx
    add7:	81 e1 ff 03 00 00    	and    $0x3ff,%ecx
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
		sum = 0;
		for (i=0; i<16; i++) {
			k = j + (i<<5);
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
    addd:	8b 55 0c             	mov    0xc(%ebp),%edx
    ade0:	c1 e2 0a             	shl    $0xa,%edx
    ade3:	01 ca                	add    %ecx,%edx
    ade5:	dd 04 d0             	fldl   (%eax,%edx,8)
    ade8:	de c9                	fmulp  %st,%st(1)
    adea:	de c1                	faddp  %st,%st(1)
	}
	/*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
		sum = 0;
		for (i=0; i<16; i++) {
    adec:	83 c3 01             	add    $0x1,%ebx
    adef:	83 fb 0f             	cmp    $0xf,%ebx
    adf2:	7e af                	jle    ada3 <SubBandSynthesis+0x123>
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
												bufOffset[channel]) & 0x3ff];
		}
		{
			/*long foo = (sum > 0) ? sum * SCALE + 0.5 : sum * SCALE - 0.5; */
			long foo = sum * SCALE;
    adf4:	dd 05 c0 dd 00 00    	fldl   0xddc0
    adfa:	de c9                	fmulp  %st,%st(1)
    adfc:	d9 7d d6             	fnstcw -0x2a(%ebp)
    adff:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    ae03:	b4 0c                	mov    $0xc,%ah
    ae05:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    ae09:	d9 6d d4             	fldcw  -0x2c(%ebp)
    ae0c:	db 5d e0             	fistpl -0x20(%ebp)
    ae0f:	d9 6d d6             	fldcw  -0x2a(%ebp)
			if (foo >= (long) SCALE)      {samples[j] = SCALE-1; ++clip;}
    ae12:	81 7d e0 ff 7f 00 00 	cmpl   $0x7fff,-0x20(%ebp)
    ae19:	7e 15                	jle    ae30 <SubBandSynthesis+0x1b0>
    ae1b:	89 f8                	mov    %edi,%eax
    ae1d:	8d 14 00             	lea    (%eax,%eax,1),%edx
    ae20:	8b 45 10             	mov    0x10(%ebp),%eax
    ae23:	01 d0                	add    %edx,%eax
    ae25:	66 c7 00 ff 7f       	movw   $0x7fff,(%eax)
    ae2a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    ae2e:	eb 2e                	jmp    ae5e <SubBandSynthesis+0x1de>
			else if (foo < (long) -SCALE) {samples[j] = -SCALE;  ++clip;}
    ae30:	81 7d e0 00 80 ff ff 	cmpl   $0xffff8000,-0x20(%ebp)
    ae37:	7d 15                	jge    ae4e <SubBandSynthesis+0x1ce>
    ae39:	89 f8                	mov    %edi,%eax
    ae3b:	8d 14 00             	lea    (%eax,%eax,1),%edx
    ae3e:	8b 45 10             	mov    0x10(%ebp),%eax
    ae41:	01 d0                	add    %edx,%eax
    ae43:	66 c7 00 00 80       	movw   $0x8000,(%eax)
    ae48:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    ae4c:	eb 10                	jmp    ae5e <SubBandSynthesis+0x1de>
			else                           samples[j] = foo;
    ae4e:	89 f8                	mov    %edi,%eax
    ae50:	8d 14 00             	lea    (%eax,%eax,1),%edx
    ae53:	8b 45 10             	mov    0x10(%ebp),%eax
    ae56:	01 c2                	add    %eax,%edx
    ae58:	8b 45 e0             	mov    -0x20(%ebp),%eax
    ae5b:	66 89 02             	mov    %ax,(%edx)
			sum += bandPtr[k] * (*filter)[i][k];
		bufOffsetPtr[i] = sum;
	}
	/*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
    ae5e:	83 c7 01             	add    $0x1,%edi
    ae61:	83 ff 1f             	cmp    $0x1f,%edi
    ae64:	0f 8e 30 ff ff ff    	jle    ad9a <SubBandSynthesis+0x11a>
			if (foo >= (long) SCALE)      {samples[j] = SCALE-1; ++clip;}
			else if (foo < (long) -SCALE) {samples[j] = -SCALE;  ++clip;}
			else                           samples[j] = foo;
		}
	}
    return(clip);
    ae6a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
    ae6d:	83 c4 2c             	add    $0x2c,%esp
    ae70:	5b                   	pop    %ebx
    ae71:	5e                   	pop    %esi
    ae72:	5f                   	pop    %edi
    ae73:	5d                   	pop    %ebp
    ae74:	c3                   	ret    

0000ae75 <out_fifo>:

void out_fifo(short pcm_sample[2][SSLIMIT][SBLIMIT], int num, struct frame_params *fr_ps, unsigned long *psampFrames)
{
    ae75:	55                   	push   %ebp
    ae76:	89 e5                	mov    %esp,%ebp
    ae78:	83 ec 10             	sub    $0x10,%esp
	int i,j,l;
	int stereo = fr_ps->stereo;
    ae7b:	8b 45 10             	mov    0x10(%ebp),%eax
    ae7e:	8b 40 08             	mov    0x8(%eax),%eax
    ae81:	89 45 f0             	mov    %eax,-0x10(%ebp)
	//int sblimit = fr_ps->sblimit;
	static long k = 0;

        for (i=0;i<num;i++) for (j=0;j<SBLIMIT;j++) {
    ae84:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    ae8b:	eb 75                	jmp    af02 <out_fifo+0x8d>
    ae8d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    ae94:	eb 62                	jmp    aef8 <out_fifo+0x83>
            (*psampFrames)++;
    ae96:	8b 45 14             	mov    0x14(%ebp),%eax
    ae99:	8b 00                	mov    (%eax),%eax
    ae9b:	8d 50 01             	lea    0x1(%eax),%edx
    ae9e:	8b 45 14             	mov    0x14(%ebp),%eax
    aea1:	89 10                	mov    %edx,(%eax)
            for (l=0;l<stereo;l++) {
    aea3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    aeaa:	eb 40                	jmp    aeec <out_fifo+0x77>
                if (!(k%1600) && k) {
    aeac:	8b 0d ec 21 01 00    	mov    0x121ec,%ecx
    aeb2:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    aeb7:	89 c8                	mov    %ecx,%eax
    aeb9:	f7 ea                	imul   %edx
    aebb:	c1 fa 09             	sar    $0x9,%edx
    aebe:	89 c8                	mov    %ecx,%eax
    aec0:	c1 f8 1f             	sar    $0x1f,%eax
    aec3:	29 c2                	sub    %eax,%edx
    aec5:	89 d0                	mov    %edx,%eax
    aec7:	69 c0 40 06 00 00    	imul   $0x640,%eax,%eax
    aecd:	29 c1                	sub    %eax,%ecx
    aecf:	89 c8                	mov    %ecx,%eax
    aed1:	85 c0                	test   %eax,%eax
    aed3:	75 13                	jne    aee8 <out_fifo+0x73>
    aed5:	a1 ec 21 01 00       	mov    0x121ec,%eax
    aeda:	85 c0                	test   %eax,%eax
    aedc:	74 0a                	je     aee8 <out_fifo+0x73>
                    //fwrite(outsamp,2,1600,outFile);
                    k = 0;
    aede:	c7 05 ec 21 01 00 00 	movl   $0x0,0x121ec
    aee5:	00 00 00 
	//int sblimit = fr_ps->sblimit;
	static long k = 0;

        for (i=0;i<num;i++) for (j=0;j<SBLIMIT;j++) {
            (*psampFrames)++;
            for (l=0;l<stereo;l++) {
    aee8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    aeec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    aeef:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    aef2:	7c b8                	jl     aeac <out_fifo+0x37>
	int i,j,l;
	int stereo = fr_ps->stereo;
	//int sblimit = fr_ps->sblimit;
	static long k = 0;

        for (i=0;i<num;i++) for (j=0;j<SBLIMIT;j++) {
    aef4:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    aef8:	83 7d f8 1f          	cmpl   $0x1f,-0x8(%ebp)
    aefc:	7e 98                	jle    ae96 <out_fifo+0x21>
    aefe:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    af02:	8b 45 fc             	mov    -0x4(%ebp),%eax
    af05:	3b 45 0c             	cmp    0xc(%ebp),%eax
    af08:	7c 83                	jl     ae8d <out_fifo+0x18>
                    k = 0;
                }
                //outsamp[k++] = pcm_sample[l][i][j];
            }
        }
}
    af0a:	c9                   	leave  
    af0b:	c3                   	ret    

0000af0c <buffer_CRC>:


void  buffer_CRC(Bit_stream_struc *bs, unsigned int *old_crc)
{
    af0c:	55                   	push   %ebp
    af0d:	89 e5                	mov    %esp,%ebp
    af0f:	83 ec 18             	sub    $0x18,%esp
    *old_crc = getbits(bs, 16);
    af12:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
    af19:	00 
    af1a:	8b 45 08             	mov    0x8(%ebp),%eax
    af1d:	89 04 24             	mov    %eax,(%esp)
    af20:	e8 8b a8 ff ff       	call   57b0 <getbits>
    af25:	8b 55 0c             	mov    0xc(%ebp),%edx
    af28:	89 02                	mov    %eax,(%edx)
}
    af2a:	c9                   	leave  
    af2b:	c3                   	ret    

0000af2c <main_data_slots>:

extern int bitrate[3][15];
extern double s_freq[4];
/* Return the number of slots for main data of current frame, */
int main_data_slots(struct frame_params fr_ps)
{
    af2c:	55                   	push   %ebp
    af2d:	89 e5                	mov    %esp,%ebp
    af2f:	83 ec 18             	sub    $0x18,%esp
	int nSlots;

	nSlots = (144 * bitrate[2][fr_ps.header->bitrate_index])
    af32:	8b 45 08             	mov    0x8(%ebp),%eax
    af35:	8b 40 0c             	mov    0xc(%eax),%eax
    af38:	83 c0 1e             	add    $0x1e,%eax
    af3b:	8b 14 85 20 ef 00 00 	mov    0xef20(,%eax,4),%edx
    af42:	89 d0                	mov    %edx,%eax
    af44:	c1 e0 03             	shl    $0x3,%eax
    af47:	01 d0                	add    %edx,%eax
    af49:	c1 e0 04             	shl    $0x4,%eax
			/ s_freq[fr_ps.header->sampling_frequency];
    af4c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    af4f:	db 45 ec             	fildl  -0x14(%ebp)
    af52:	8b 45 08             	mov    0x8(%ebp),%eax
    af55:	8b 40 10             	mov    0x10(%eax),%eax
    af58:	dd 04 c5 e0 ef 00 00 	fldl   0xefe0(,%eax,8)
    af5f:	de f9                	fdivrp %st,%st(1)
/* Return the number of slots for main data of current frame, */
int main_data_slots(struct frame_params fr_ps)
{
	int nSlots;

	nSlots = (144 * bitrate[2][fr_ps.header->bitrate_index])
    af61:	d9 7d ea             	fnstcw -0x16(%ebp)
    af64:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
    af68:	b4 0c                	mov    $0xc,%ah
    af6a:	66 89 45 e8          	mov    %ax,-0x18(%ebp)
    af6e:	d9 6d e8             	fldcw  -0x18(%ebp)
    af71:	db 5d fc             	fistpl -0x4(%ebp)
    af74:	d9 6d ea             	fldcw  -0x16(%ebp)
			/ s_freq[fr_ps.header->sampling_frequency];
	if (fr_ps.header->padding) nSlots++;
    af77:	8b 45 08             	mov    0x8(%ebp),%eax
    af7a:	8b 40 14             	mov    0x14(%eax),%eax
    af7d:	85 c0                	test   %eax,%eax
    af7f:	74 04                	je     af85 <main_data_slots+0x59>
    af81:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
	nSlots -= 4;
    af85:	83 6d fc 04          	subl   $0x4,-0x4(%ebp)
	if (fr_ps.header->error_protection)
    af89:	8b 45 08             	mov    0x8(%ebp),%eax
    af8c:	8b 40 08             	mov    0x8(%eax),%eax
    af8f:	85 c0                	test   %eax,%eax
    af91:	74 04                	je     af97 <main_data_slots+0x6b>
		nSlots -= 2;
    af93:	83 6d fc 02          	subl   $0x2,-0x4(%ebp)
	if (fr_ps.stereo == 1)
    af97:	8b 45 10             	mov    0x10(%ebp),%eax
    af9a:	83 f8 01             	cmp    $0x1,%eax
    af9d:	75 06                	jne    afa5 <main_data_slots+0x79>
		nSlots -= 17;
    af9f:	83 6d fc 11          	subl   $0x11,-0x4(%ebp)
    afa3:	eb 04                	jmp    afa9 <main_data_slots+0x7d>
	else
		nSlots -=32;
    afa5:	83 6d fc 20          	subl   $0x20,-0x4(%ebp)
	return(nSlots);
    afa9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    afac:	c9                   	leave  
    afad:	c3                   	ret    
