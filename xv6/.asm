
_picviewer:     file format elf32-i386


Disassembly of section .text:

00000000 <compressPic>:

PICNODE pic;
int isRun = 1;

// 压缩图片
void compressPic(int width, int height) {
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	81 ec 88 00 00 00    	sub    $0x88,%esp
    int x0, y0, x1, x2, y1, y2;
    float fx1, fx2, fy1, fy2;
    int x, y, index;
    RGBQUAD* data;

    w0 = pic.width;
       9:	a1 94 f9 00 00       	mov    0xf994,%eax
       e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    h0 = pic.height;
      11:	a1 98 f9 00 00       	mov    0xf998,%eax
      16:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    w1 = width;
      19:	8b 45 08             	mov    0x8(%ebp),%eax
      1c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    h1 = height;
      1f:	8b 45 0c             	mov    0xc(%ebp),%eax
      22:	89 45 dc             	mov    %eax,-0x24(%ebp)

    fw = w0 * 1.0 / w1;
      25:	db 45 e8             	fildl  -0x18(%ebp)
      28:	db 45 e0             	fildl  -0x20(%ebp)
      2b:	de f9                	fdivrp %st,%st(1)
      2d:	d9 5d d8             	fstps  -0x28(%ebp)
    fh = h0 * 1.0 / h1;
      30:	db 45 e4             	fildl  -0x1c(%ebp)
      33:	db 45 dc             	fildl  -0x24(%ebp)
      36:	de f9                	fdivrp %st,%st(1)
      38:	d9 5d d4             	fstps  -0x2c(%ebp)

    index = 0;
      3b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    data = (RGBQUAD*)malloc(w1*h1*sizeof(RGBQUAD));
      42:	8b 45 e0             	mov    -0x20(%ebp),%eax
      45:	0f af 45 dc          	imul   -0x24(%ebp),%eax
      49:	c1 e0 02             	shl    $0x2,%eax
      4c:	83 ec 0c             	sub    $0xc,%esp
      4f:	50                   	push   %eax
      50:	e8 70 28 00 00       	call   28c5 <malloc>
      55:	83 c4 10             	add    $0x10,%esp
      58:	89 45 d0             	mov    %eax,-0x30(%ebp)
    memset(data, 0, (uint)w1*h1*sizeof(RGBQUAD));
      5b:	8b 55 e0             	mov    -0x20(%ebp),%edx
      5e:	8b 45 dc             	mov    -0x24(%ebp),%eax
      61:	0f af c2             	imul   %edx,%eax
      64:	c1 e0 02             	shl    $0x2,%eax
      67:	83 ec 04             	sub    $0x4,%esp
      6a:	50                   	push   %eax
      6b:	6a 00                	push   $0x0
      6d:	ff 75 d0             	pushl  -0x30(%ebp)
      70:	e8 03 22 00 00       	call   2278 <memset>
      75:	83 c4 10             	add    $0x10,%esp
    for (y = 0; y < h1; ++y) {
      78:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      7f:	e9 2c 03 00 00       	jmp    3b0 <compressPic+0x3b0>
        y0 = y*fh;
      84:	db 45 f0             	fildl  -0x10(%ebp)
      87:	d8 4d d4             	fmuls  -0x2c(%ebp)
      8a:	d9 7d 82             	fnstcw -0x7e(%ebp)
      8d:	0f b7 45 82          	movzwl -0x7e(%ebp),%eax
      91:	b4 0c                	mov    $0xc,%ah
      93:	66 89 45 80          	mov    %ax,-0x80(%ebp)
      97:	d9 6d 80             	fldcw  -0x80(%ebp)
      9a:	db 5d cc             	fistpl -0x34(%ebp)
      9d:	d9 6d 82             	fldcw  -0x7e(%ebp)
        y1 = (int)y0;
      a0:	8b 45 cc             	mov    -0x34(%ebp),%eax
      a3:	89 45 c8             	mov    %eax,-0x38(%ebp)
        y2 = (y1 == h0-1) ? y1 : y1 + 1;
      a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      a9:	83 e8 01             	sub    $0x1,%eax
      ac:	3b 45 c8             	cmp    -0x38(%ebp),%eax
      af:	74 08                	je     b9 <compressPic+0xb9>
      b1:	8b 45 c8             	mov    -0x38(%ebp),%eax
      b4:	83 c0 01             	add    $0x1,%eax
      b7:	eb 03                	jmp    bc <compressPic+0xbc>
      b9:	8b 45 c8             	mov    -0x38(%ebp),%eax
      bc:	89 45 c4             	mov    %eax,-0x3c(%ebp)

        fy1 = y1-y0;
      bf:	8b 45 c8             	mov    -0x38(%ebp),%eax
      c2:	2b 45 cc             	sub    -0x34(%ebp),%eax
      c5:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
      cb:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
      d1:	d9 5d c0             	fstps  -0x40(%ebp)
        fy2 = 1.0f-fy1;
      d4:	d9 e8                	fld1   
      d6:	d8 65 c0             	fsubs  -0x40(%ebp)
      d9:	d9 5d bc             	fstps  -0x44(%ebp)

        for (x = 0; x < w1; ++x) {
      dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      e3:	e9 b8 02 00 00       	jmp    3a0 <compressPic+0x3a0>
            x0 = x*fw;
      e8:	db 45 f4             	fildl  -0xc(%ebp)
      eb:	d8 4d d8             	fmuls  -0x28(%ebp)
      ee:	d9 6d 80             	fldcw  -0x80(%ebp)
      f1:	db 5d b8             	fistpl -0x48(%ebp)
      f4:	d9 6d 82             	fldcw  -0x7e(%ebp)
            x1 = (int)x0;
      f7:	8b 45 b8             	mov    -0x48(%ebp),%eax
      fa:	89 45 b4             	mov    %eax,-0x4c(%ebp)
            x2 = (x1 == w0-1) ? x1 : x1 + 1;
      fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     100:	83 e8 01             	sub    $0x1,%eax
     103:	3b 45 b4             	cmp    -0x4c(%ebp),%eax
     106:	74 08                	je     110 <compressPic+0x110>
     108:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     10b:	83 c0 01             	add    $0x1,%eax
     10e:	eb 03                	jmp    113 <compressPic+0x113>
     110:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     113:	89 45 b0             	mov    %eax,-0x50(%ebp)

            fx1 = y1-y0;
     116:	8b 45 c8             	mov    -0x38(%ebp),%eax
     119:	2b 45 cc             	sub    -0x34(%ebp),%eax
     11c:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
     122:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     128:	d9 5d ac             	fstps  -0x54(%ebp)
            fx2 = 1.0f-fx1;
     12b:	d9 e8                	fld1   
     12d:	d8 65 ac             	fsubs  -0x54(%ebp)
     130:	d9 5d a8             	fstps  -0x58(%ebp)

            float s1 = fx1*fy1;
     133:	d9 45 ac             	flds   -0x54(%ebp)
     136:	d8 4d c0             	fmuls  -0x40(%ebp)
     139:	d9 5d a4             	fstps  -0x5c(%ebp)
            float s2 = fx2*fy1;
     13c:	d9 45 a8             	flds   -0x58(%ebp)
     13f:	d8 4d c0             	fmuls  -0x40(%ebp)
     142:	d9 5d a0             	fstps  -0x60(%ebp)
            float s3 = fx2*fy2;
     145:	d9 45 a8             	flds   -0x58(%ebp)
     148:	d8 4d bc             	fmuls  -0x44(%ebp)
     14b:	d9 5d 9c             	fstps  -0x64(%ebp)
            float s4 = fx1*fy2;
     14e:	d9 45 ac             	flds   -0x54(%ebp)
     151:	d8 4d bc             	fmuls  -0x44(%ebp)
     154:	d9 5d 98             	fstps  -0x68(%ebp)

            RGBQUAD p1, p2, p3, p4;
            p1 = pic.data[x1+y1*w0];
     157:	8b 15 90 f9 00 00    	mov    0xf990,%edx
     15d:	8b 45 c8             	mov    -0x38(%ebp),%eax
     160:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     164:	89 c1                	mov    %eax,%ecx
     166:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     169:	01 c8                	add    %ecx,%eax
     16b:	c1 e0 02             	shl    $0x2,%eax
     16e:	01 d0                	add    %edx,%eax
     170:	8b 00                	mov    (%eax),%eax
     172:	89 45 94             	mov    %eax,-0x6c(%ebp)
            p2 = pic.data[x2+y1*w0];
     175:	8b 15 90 f9 00 00    	mov    0xf990,%edx
     17b:	8b 45 c8             	mov    -0x38(%ebp),%eax
     17e:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     182:	89 c1                	mov    %eax,%ecx
     184:	8b 45 b0             	mov    -0x50(%ebp),%eax
     187:	01 c8                	add    %ecx,%eax
     189:	c1 e0 02             	shl    $0x2,%eax
     18c:	01 d0                	add    %edx,%eax
     18e:	8b 00                	mov    (%eax),%eax
     190:	89 45 90             	mov    %eax,-0x70(%ebp)
            p3 = pic.data[x1+y2*w0];
     193:	8b 15 90 f9 00 00    	mov    0xf990,%edx
     199:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     19c:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     1a0:	89 c1                	mov    %eax,%ecx
     1a2:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     1a5:	01 c8                	add    %ecx,%eax
     1a7:	c1 e0 02             	shl    $0x2,%eax
     1aa:	01 d0                	add    %edx,%eax
     1ac:	8b 00                	mov    (%eax),%eax
     1ae:	89 45 8c             	mov    %eax,-0x74(%ebp)
            p4 = pic.data[x2+y2*w0];
     1b1:	8b 15 90 f9 00 00    	mov    0xf990,%edx
     1b7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     1ba:	0f af 45 e8          	imul   -0x18(%ebp),%eax
     1be:	89 c1                	mov    %eax,%ecx
     1c0:	8b 45 b0             	mov    -0x50(%ebp),%eax
     1c3:	01 c8                	add    %ecx,%eax
     1c5:	c1 e0 02             	shl    $0x2,%eax
     1c8:	01 d0                	add    %edx,%eax
     1ca:	8b 00                	mov    (%eax),%eax
     1cc:	89 45 88             	mov    %eax,-0x78(%ebp)

            data[index].rgbRed = (BYTE)(p1.rgbRed*s3 + p2.rgbRed*s4 + p3.rgbRed*s2 + p4.rgbRed*s1);
     1cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     1d2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     1d9:	8b 45 d0             	mov    -0x30(%ebp),%eax
     1dc:	01 d0                	add    %edx,%eax
     1de:	0f b6 55 96          	movzbl -0x6a(%ebp),%edx
     1e2:	0f b6 d2             	movzbl %dl,%edx
     1e5:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
     1eb:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     1f1:	d8 4d 9c             	fmuls  -0x64(%ebp)
     1f4:	0f b6 55 92          	movzbl -0x6e(%ebp),%edx
     1f8:	0f b6 d2             	movzbl %dl,%edx
     1fb:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
     201:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     207:	d8 4d 98             	fmuls  -0x68(%ebp)
     20a:	de c1                	faddp  %st,%st(1)
     20c:	0f b6 55 8e          	movzbl -0x72(%ebp),%edx
     210:	0f b6 d2             	movzbl %dl,%edx
     213:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
     219:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     21f:	d8 4d a0             	fmuls  -0x60(%ebp)
     222:	de c1                	faddp  %st,%st(1)
     224:	0f b6 55 8a          	movzbl -0x76(%ebp),%edx
     228:	0f b6 d2             	movzbl %dl,%edx
     22b:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
     231:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     237:	d8 4d a4             	fmuls  -0x5c(%ebp)
     23a:	de c1                	faddp  %st,%st(1)
     23c:	d9 6d 80             	fldcw  -0x80(%ebp)
     23f:	df 9d 7e ff ff ff    	fistp  -0x82(%ebp)
     245:	d9 6d 82             	fldcw  -0x7e(%ebp)
     248:	0f b7 95 7e ff ff ff 	movzwl -0x82(%ebp),%edx
     24f:	88 50 02             	mov    %dl,0x2(%eax)
            data[index].rgbGreen = (BYTE)(p1.rgbGreen*s3 + p2.rgbGreen*s4 + p3.rgbGreen*s2 + p4.rgbGreen*s1);
     252:	8b 45 ec             	mov    -0x14(%ebp),%eax
     255:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     25c:	8b 45 d0             	mov    -0x30(%ebp),%eax
     25f:	01 d0                	add    %edx,%eax
     261:	0f b6 55 95          	movzbl -0x6b(%ebp),%edx
     265:	0f b6 d2             	movzbl %dl,%edx
     268:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
     26e:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     274:	d8 4d 9c             	fmuls  -0x64(%ebp)
     277:	0f b6 55 91          	movzbl -0x6f(%ebp),%edx
     27b:	0f b6 d2             	movzbl %dl,%edx
     27e:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
     284:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     28a:	d8 4d 98             	fmuls  -0x68(%ebp)
     28d:	de c1                	faddp  %st,%st(1)
     28f:	0f b6 55 8d          	movzbl -0x73(%ebp),%edx
     293:	0f b6 d2             	movzbl %dl,%edx
     296:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
     29c:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     2a2:	d8 4d a0             	fmuls  -0x60(%ebp)
     2a5:	de c1                	faddp  %st,%st(1)
     2a7:	0f b6 55 89          	movzbl -0x77(%ebp),%edx
     2ab:	0f b6 d2             	movzbl %dl,%edx
     2ae:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
     2b4:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     2ba:	d8 4d a4             	fmuls  -0x5c(%ebp)
     2bd:	de c1                	faddp  %st,%st(1)
     2bf:	d9 6d 80             	fldcw  -0x80(%ebp)
     2c2:	df 9d 7e ff ff ff    	fistp  -0x82(%ebp)
     2c8:	d9 6d 82             	fldcw  -0x7e(%ebp)
     2cb:	0f b7 95 7e ff ff ff 	movzwl -0x82(%ebp),%edx
     2d2:	88 50 01             	mov    %dl,0x1(%eax)
            data[index].rgbBlue = (BYTE)(p1.rgbBlue*s3 + p2.rgbBlue*s4 + p3.rgbBlue*s2 + p4.rgbBlue*s1);
     2d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     2d8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     2df:	8b 45 d0             	mov    -0x30(%ebp),%eax
     2e2:	01 d0                	add    %edx,%eax
     2e4:	0f b6 55 94          	movzbl -0x6c(%ebp),%edx
     2e8:	0f b6 d2             	movzbl %dl,%edx
     2eb:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
     2f1:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     2f7:	d8 4d 9c             	fmuls  -0x64(%ebp)
     2fa:	0f b6 55 90          	movzbl -0x70(%ebp),%edx
     2fe:	0f b6 d2             	movzbl %dl,%edx
     301:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
     307:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     30d:	d8 4d 98             	fmuls  -0x68(%ebp)
     310:	de c1                	faddp  %st,%st(1)
     312:	0f b6 55 8c          	movzbl -0x74(%ebp),%edx
     316:	0f b6 d2             	movzbl %dl,%edx
     319:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
     31f:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     325:	d8 4d a0             	fmuls  -0x60(%ebp)
     328:	de c1                	faddp  %st,%st(1)
     32a:	0f b6 55 88          	movzbl -0x78(%ebp),%edx
     32e:	0f b6 d2             	movzbl %dl,%edx
     331:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
     337:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     33d:	d8 4d a4             	fmuls  -0x5c(%ebp)
     340:	de c1                	faddp  %st,%st(1)
     342:	d9 6d 80             	fldcw  -0x80(%ebp)
     345:	df 9d 7e ff ff ff    	fistp  -0x82(%ebp)
     34b:	d9 6d 82             	fldcw  -0x7e(%ebp)
     34e:	0f b7 95 7e ff ff ff 	movzwl -0x82(%ebp),%edx
     355:	88 10                	mov    %dl,(%eax)

            data[index].rgbRed = p1.rgbRed;
     357:	8b 45 ec             	mov    -0x14(%ebp),%eax
     35a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     361:	8b 45 d0             	mov    -0x30(%ebp),%eax
     364:	01 c2                	add    %eax,%edx
     366:	0f b6 45 96          	movzbl -0x6a(%ebp),%eax
     36a:	88 42 02             	mov    %al,0x2(%edx)
            data[index].rgbGreen = p1.rgbGreen;
     36d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     370:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     377:	8b 45 d0             	mov    -0x30(%ebp),%eax
     37a:	01 c2                	add    %eax,%edx
     37c:	0f b6 45 95          	movzbl -0x6b(%ebp),%eax
     380:	88 42 01             	mov    %al,0x1(%edx)
            data[index].rgbBlue = p1.rgbBlue;
     383:	8b 45 ec             	mov    -0x14(%ebp),%eax
     386:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     38d:	8b 45 d0             	mov    -0x30(%ebp),%eax
     390:	01 c2                	add    %eax,%edx
     392:	0f b6 45 94          	movzbl -0x6c(%ebp),%eax
     396:	88 02                	mov    %al,(%edx)

            ++index;
     398:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        y2 = (y1 == h0-1) ? y1 : y1 + 1;

        fy1 = y1-y0;
        fy2 = 1.0f-fy1;

        for (x = 0; x < w1; ++x) {
     39c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     3a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3a3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
     3a6:	0f 8c 3c fd ff ff    	jl     e8 <compressPic+0xe8>
    fh = h0 * 1.0 / h1;

    index = 0;
    data = (RGBQUAD*)malloc(w1*h1*sizeof(RGBQUAD));
    memset(data, 0, (uint)w1*h1*sizeof(RGBQUAD));
    for (y = 0; y < h1; ++y) {
     3ac:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     3b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     3b3:	3b 45 dc             	cmp    -0x24(%ebp),%eax
     3b6:	0f 8c c8 fc ff ff    	jl     84 <compressPic+0x84>

            ++index;
        }
    }

    freepic(&pic);
     3bc:	83 ec 0c             	sub    $0xc,%esp
     3bf:	68 90 f9 00 00       	push   $0xf990
     3c4:	e8 19 16 00 00       	call   19e2 <freepic>
     3c9:	83 c4 10             	add    $0x10,%esp
    pic.data = data;
     3cc:	8b 45 d0             	mov    -0x30(%ebp),%eax
     3cf:	a3 90 f9 00 00       	mov    %eax,0xf990
    pic.width = width;
     3d4:	8b 45 08             	mov    0x8(%ebp),%eax
     3d7:	a3 94 f9 00 00       	mov    %eax,0xf994
    pic.height = height;
     3dc:	8b 45 0c             	mov    0xc(%ebp),%eax
     3df:	a3 98 f9 00 00       	mov    %eax,0xf998
}
     3e4:	90                   	nop
     3e5:	c9                   	leave  
     3e6:	c3                   	ret    

000003e7 <modifyPic>:

void modifyPic(Context context) {
     3e7:	55                   	push   %ebp
     3e8:	89 e5                	mov    %esp,%ebp
     3ea:	83 ec 38             	sub    $0x38,%esp
    int c_width, c_height;
    int pic_width, pic_height;

    c_width = context.width;
     3ed:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    c_height = context.height;
     3f3:	8b 45 10             	mov    0x10(%ebp),%eax
     3f6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    pic_width = pic.width;
     3f9:	a1 94 f9 00 00       	mov    0xf994,%eax
     3fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    pic_height = pic.height;
     401:	a1 98 f9 00 00       	mov    0xf998,%eax
     406:	89 45 f0             	mov    %eax,-0x10(%ebp)

    if (pic_width < c_width && pic_height < c_height) {
     409:	8b 45 f4             	mov    -0xc(%ebp),%eax
     40c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     40f:	7d 0c                	jge    41d <modifyPic+0x36>
     411:	8b 45 f0             	mov    -0x10(%ebp),%eax
     414:	3b 45 e8             	cmp    -0x18(%ebp),%eax
     417:	0f 8c aa 00 00 00    	jl     4c7 <modifyPic+0xe0>
        return;
    }

    float scale_p, scale_c;
    scale_p = pic_width * 1.0 / pic_height;
     41d:	db 45 f4             	fildl  -0xc(%ebp)
     420:	db 45 f0             	fildl  -0x10(%ebp)
     423:	de f9                	fdivrp %st,%st(1)
     425:	d9 5d e4             	fstps  -0x1c(%ebp)
    scale_c = c_width * 1.0 / c_height;
     428:	db 45 ec             	fildl  -0x14(%ebp)
     42b:	db 45 e8             	fildl  -0x18(%ebp)
     42e:	de f9                	fdivrp %st,%st(1)
     430:	d9 5d e0             	fstps  -0x20(%ebp)

    if (scale_p <= scale_c) {
     433:	d9 45 e0             	flds   -0x20(%ebp)
     436:	d9 45 e4             	flds   -0x1c(%ebp)
     439:	d9 c9                	fxch   %st(1)
     43b:	df e9                	fucomip %st(1),%st
     43d:	dd d8                	fstp   %st(0)
     43f:	72 30                	jb     471 <modifyPic+0x8a>
        pic_width = scale_p * (c_height-10);
     441:	8b 45 e8             	mov    -0x18(%ebp),%eax
     444:	83 e8 0a             	sub    $0xa,%eax
     447:	89 45 cc             	mov    %eax,-0x34(%ebp)
     44a:	db 45 cc             	fildl  -0x34(%ebp)
     44d:	d8 4d e4             	fmuls  -0x1c(%ebp)
     450:	d9 7d d2             	fnstcw -0x2e(%ebp)
     453:	0f b7 45 d2          	movzwl -0x2e(%ebp),%eax
     457:	b4 0c                	mov    $0xc,%ah
     459:	66 89 45 d0          	mov    %ax,-0x30(%ebp)
     45d:	d9 6d d0             	fldcw  -0x30(%ebp)
     460:	db 5d f4             	fistpl -0xc(%ebp)
     463:	d9 6d d2             	fldcw  -0x2e(%ebp)
        pic_height = c_height-10;
     466:	8b 45 e8             	mov    -0x18(%ebp),%eax
     469:	83 e8 0a             	sub    $0xa,%eax
     46c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     46f:	eb 2e                	jmp    49f <modifyPic+0xb8>
    } else {
        pic_height = (c_width-5) / scale_p;
     471:	8b 45 ec             	mov    -0x14(%ebp),%eax
     474:	83 e8 05             	sub    $0x5,%eax
     477:	89 45 cc             	mov    %eax,-0x34(%ebp)
     47a:	db 45 cc             	fildl  -0x34(%ebp)
     47d:	d8 75 e4             	fdivs  -0x1c(%ebp)
     480:	d9 7d d2             	fnstcw -0x2e(%ebp)
     483:	0f b7 45 d2          	movzwl -0x2e(%ebp),%eax
     487:	b4 0c                	mov    $0xc,%ah
     489:	66 89 45 d0          	mov    %ax,-0x30(%ebp)
     48d:	d9 6d d0             	fldcw  -0x30(%ebp)
     490:	db 5d f0             	fistpl -0x10(%ebp)
     493:	d9 6d d2             	fldcw  -0x2e(%ebp)
        pic_width = c_width-5;
     496:	8b 45 ec             	mov    -0x14(%ebp),%eax
     499:	83 e8 05             	sub    $0x5,%eax
     49c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    printf(0, "modifyPic: pic_width: %d, pic_height: %d\n", pic_width, pic_height);
     49f:	ff 75 f0             	pushl  -0x10(%ebp)
     4a2:	ff 75 f4             	pushl  -0xc(%ebp)
     4a5:	68 60 8c 00 00       	push   $0x8c60
     4aa:	6a 00                	push   $0x0
     4ac:	e8 41 21 00 00       	call   25f2 <printf>
     4b1:	83 c4 10             	add    $0x10,%esp

    compressPic(pic_width, pic_height);
     4b4:	83 ec 08             	sub    $0x8,%esp
     4b7:	ff 75 f0             	pushl  -0x10(%ebp)
     4ba:	ff 75 f4             	pushl  -0xc(%ebp)
     4bd:	e8 3e fb ff ff       	call   0 <compressPic>
     4c2:	83 c4 10             	add    $0x10,%esp
     4c5:	eb 01                	jmp    4c8 <modifyPic+0xe1>
    c_height = context.height;
    pic_width = pic.width;
    pic_height = pic.height;

    if (pic_width < c_width && pic_height < c_height) {
        return;
     4c7:	90                   	nop
        pic_width = c_width-5;
    }
    printf(0, "modifyPic: pic_width: %d, pic_height: %d\n", pic_width, pic_height);

    compressPic(pic_width, pic_height);
}
     4c8:	c9                   	leave  
     4c9:	c3                   	ret    

000004ca <drawPicViewerWnd>:

// 绘制窗口
void drawPicViewerWnd(Context context) {
     4ca:	55                   	push   %ebp
     4cb:	89 e5                	mov    %esp,%ebp
     4cd:	83 ec 18             	sub    $0x18,%esp
    int width, height;

    width = context.width;
     4d0:	8b 45 0c             	mov    0xc(%ebp),%eax
     4d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    height = context.height;
     4d6:	8b 45 10             	mov    0x10(%ebp),%eax
     4d9:	89 45 f0             	mov    %eax,-0x10(%ebp)

    fill_rect(context, 0, 0, width, height, 0xFFFF);
     4dc:	8b 55 f0             	mov    -0x10(%ebp),%edx
     4df:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4e2:	68 ff ff 00 00       	push   $0xffff
     4e7:	52                   	push   %edx
     4e8:	50                   	push   %eax
     4e9:	6a 00                	push   $0x0
     4eb:	6a 00                	push   $0x0
     4ed:	ff 75 10             	pushl  0x10(%ebp)
     4f0:	ff 75 0c             	pushl  0xc(%ebp)
     4f3:	ff 75 08             	pushl  0x8(%ebp)
     4f6:	e8 c6 05 00 00       	call   ac1 <fill_rect>
     4fb:	83 c4 20             	add    $0x20,%esp

    draw_line(context, 0, 0, width-1, 0, BORDERLINE_COLOR);
     4fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     501:	83 e8 01             	sub    $0x1,%eax
     504:	6a 00                	push   $0x0
     506:	6a 00                	push   $0x0
     508:	50                   	push   %eax
     509:	6a 00                	push   $0x0
     50b:	6a 00                	push   $0x0
     50d:	ff 75 10             	pushl  0x10(%ebp)
     510:	ff 75 0c             	pushl  0xc(%ebp)
     513:	ff 75 08             	pushl  0x8(%ebp)
     516:	e8 78 0c 00 00       	call   1193 <draw_line>
     51b:	83 c4 20             	add    $0x20,%esp
    draw_line(context, width-1, 0, width-1, height-1, BORDERLINE_COLOR);
     51e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     521:	8d 48 ff             	lea    -0x1(%eax),%ecx
     524:	8b 45 f4             	mov    -0xc(%ebp),%eax
     527:	8d 50 ff             	lea    -0x1(%eax),%edx
     52a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     52d:	83 e8 01             	sub    $0x1,%eax
     530:	6a 00                	push   $0x0
     532:	51                   	push   %ecx
     533:	52                   	push   %edx
     534:	6a 00                	push   $0x0
     536:	50                   	push   %eax
     537:	ff 75 10             	pushl  0x10(%ebp)
     53a:	ff 75 0c             	pushl  0xc(%ebp)
     53d:	ff 75 08             	pushl  0x8(%ebp)
     540:	e8 4e 0c 00 00       	call   1193 <draw_line>
     545:	83 c4 20             	add    $0x20,%esp
    draw_line(context, 0, height-1, width-1, height-1, BORDERLINE_COLOR);
     548:	8b 45 f0             	mov    -0x10(%ebp),%eax
     54b:	8d 48 ff             	lea    -0x1(%eax),%ecx
     54e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     551:	8d 50 ff             	lea    -0x1(%eax),%edx
     554:	8b 45 f0             	mov    -0x10(%ebp),%eax
     557:	83 e8 01             	sub    $0x1,%eax
     55a:	6a 00                	push   $0x0
     55c:	51                   	push   %ecx
     55d:	52                   	push   %edx
     55e:	50                   	push   %eax
     55f:	6a 00                	push   $0x0
     561:	ff 75 10             	pushl  0x10(%ebp)
     564:	ff 75 0c             	pushl  0xc(%ebp)
     567:	ff 75 08             	pushl  0x8(%ebp)
     56a:	e8 24 0c 00 00       	call   1193 <draw_line>
     56f:	83 c4 20             	add    $0x20,%esp
    draw_line(context, 0, height-1, 0, 0, BORDERLINE_COLOR);
     572:	8b 45 f0             	mov    -0x10(%ebp),%eax
     575:	83 e8 01             	sub    $0x1,%eax
     578:	6a 00                	push   $0x0
     57a:	6a 00                	push   $0x0
     57c:	6a 00                	push   $0x0
     57e:	50                   	push   %eax
     57f:	6a 00                	push   $0x0
     581:	ff 75 10             	pushl  0x10(%ebp)
     584:	ff 75 0c             	pushl  0xc(%ebp)
     587:	ff 75 08             	pushl  0x8(%ebp)
     58a:	e8 04 0c 00 00       	call   1193 <draw_line>
     58f:	83 c4 20             	add    $0x20,%esp

    fill_rect(context, 1, 1, width-2, TOPBAR_HEIGHT, TOPBAR_COLOR);
     592:	8b 45 f4             	mov    -0xc(%ebp),%eax
     595:	83 e8 02             	sub    $0x2,%eax
     598:	68 cb 5a 00 00       	push   $0x5acb
     59d:	6a 14                	push   $0x14
     59f:	50                   	push   %eax
     5a0:	6a 01                	push   $0x1
     5a2:	6a 01                	push   $0x1
     5a4:	ff 75 10             	pushl  0x10(%ebp)
     5a7:	ff 75 0c             	pushl  0xc(%ebp)
     5aa:	ff 75 08             	pushl  0x8(%ebp)
     5ad:	e8 0f 05 00 00       	call   ac1 <fill_rect>
     5b2:	83 c4 20             	add    $0x20,%esp
    puts_str(context, "PictureViewer", 0, WINDOW_WIDTH/2 - 53, 3);
     5b5:	83 ec 04             	sub    $0x4,%esp
     5b8:	6a 03                	push   $0x3
     5ba:	68 c5 00 00 00       	push   $0xc5
     5bf:	6a 00                	push   $0x0
     5c1:	68 8a 8c 00 00       	push   $0x8c8a
     5c6:	ff 75 10             	pushl  0x10(%ebp)
     5c9:	ff 75 0c             	pushl  0xc(%ebp)
     5cc:	ff 75 08             	pushl  0x8(%ebp)
     5cf:	e8 4e 0a 00 00       	call   1022 <puts_str>
     5d4:	83 c4 20             	add    $0x20,%esp

    draw_iconlist(context, wndRes, sizeof(wndRes) / sizeof(ICON));
     5d7:	83 ec 0c             	sub    $0xc,%esp
     5da:	6a 01                	push   $0x1
     5dc:	68 60 c6 00 00       	push   $0xc660
     5e1:	ff 75 10             	pushl  0x10(%ebp)
     5e4:	ff 75 0c             	pushl  0xc(%ebp)
     5e7:	ff 75 08             	pushl  0x8(%ebp)
     5ea:	e8 6c 0e 00 00       	call   145b <draw_iconlist>
     5ef:	83 c4 20             	add    $0x20,%esp
}
     5f2:	90                   	nop
     5f3:	c9                   	leave  
     5f4:	c3                   	ret    

000005f5 <drawPicViewerContent>:

void drawPicViewerContent(Context context, char* fileName) {
     5f5:	55                   	push   %ebp
     5f6:	89 e5                	mov    %esp,%ebp
     5f8:	83 ec 18             	sub    $0x18,%esp
    int c_width, c_height;
    int pic_width, pic_height;

    c_width = context.width;
     5fb:	8b 45 0c             	mov    0xc(%ebp),%eax
     5fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    c_height = context.height;
     601:	8b 45 10             	mov    0x10(%ebp),%eax
     604:	89 45 f0             	mov    %eax,-0x10(%ebp)
    pic_width = pic.width;
     607:	a1 94 f9 00 00       	mov    0xf994,%eax
     60c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pic_height = pic.height;
     60f:	a1 98 f9 00 00       	mov    0xf998,%eax
     614:	89 45 e8             	mov    %eax,-0x18(%ebp)

    printf(0, "drawPicViewerContent: pic_width: %d, pic_height: %d\n", pic_width, pic_height);
     617:	ff 75 e8             	pushl  -0x18(%ebp)
     61a:	ff 75 ec             	pushl  -0x14(%ebp)
     61d:	68 98 8c 00 00       	push   $0x8c98
     622:	6a 00                	push   $0x0
     624:	e8 c9 1f 00 00       	call   25f2 <printf>
     629:	83 c4 10             	add    $0x10,%esp
    draw_picture(context, pic, (c_width-pic_width) >> 1, TOPBAR_HEIGHT + ((c_height-pic_height) >> 1));
     62c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     62f:	2b 45 e8             	sub    -0x18(%ebp),%eax
     632:	d1 f8                	sar    %eax
     634:	8d 50 14             	lea    0x14(%eax),%edx
     637:	8b 45 f4             	mov    -0xc(%ebp),%eax
     63a:	2b 45 ec             	sub    -0x14(%ebp),%eax
     63d:	d1 f8                	sar    %eax
     63f:	52                   	push   %edx
     640:	50                   	push   %eax
     641:	ff 35 98 f9 00 00    	pushl  0xf998
     647:	ff 35 94 f9 00 00    	pushl  0xf994
     64d:	ff 35 90 f9 00 00    	pushl  0xf990
     653:	ff 75 10             	pushl  0x10(%ebp)
     656:	ff 75 0c             	pushl  0xc(%ebp)
     659:	ff 75 08             	pushl  0x8(%ebp)
     65c:	e8 71 0a 00 00       	call   10d2 <draw_picture>
     661:	83 c4 20             	add    $0x20,%esp
}
     664:	90                   	nop
     665:	c9                   	leave  
     666:	c3                   	ret    

00000667 <h_closeWnd>:

void h_closeWnd(Point p) {
     667:	55                   	push   %ebp
     668:	89 e5                	mov    %esp,%ebp
    isRun = 0;
     66a:	c7 05 98 c6 00 00 00 	movl   $0x0,0xc698
     671:	00 00 00 
}
     674:	90                   	nop
     675:	5d                   	pop    %ebp
     676:	c3                   	ret    

00000677 <addWndEvent>:

void addWndEvent(ClickableManager *cm) {
     677:	55                   	push   %ebp
     678:	89 e5                	mov    %esp,%ebp
     67a:	57                   	push   %edi
     67b:	56                   	push   %esi
     67c:	53                   	push   %ebx
     67d:	83 ec 2c             	sub    $0x2c,%esp
    int i;
	int n = sizeof(wndEvents) / sizeof(Handler);
     680:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)

	for (i = 0; i < n; i++) {
     687:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
     68e:	eb 72                	jmp    702 <addWndEvent+0x8b>
		createClickable(cm,
     690:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     693:	8b 1c 85 94 c6 00 00 	mov    0xc694(,%eax,4),%ebx
     69a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     69d:	6b c0 34             	imul   $0x34,%eax,%eax
     6a0:	05 90 c6 00 00       	add    $0xc690,%eax
     6a5:	8b 38                	mov    (%eax),%edi
     6a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6aa:	6b c0 34             	imul   $0x34,%eax,%eax
     6ad:	05 8c c6 00 00       	add    $0xc68c,%eax
     6b2:	8b 30                	mov    (%eax),%esi
     6b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6b7:	6b c0 34             	imul   $0x34,%eax,%eax
     6ba:	05 84 c6 00 00       	add    $0xc684,%eax
     6bf:	8b 08                	mov    (%eax),%ecx
     6c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6c4:	6b c0 34             	imul   $0x34,%eax,%eax
     6c7:	05 80 c6 00 00       	add    $0xc680,%eax
     6cc:	8b 10                	mov    (%eax),%edx
     6ce:	8d 45 d0             	lea    -0x30(%ebp),%eax
     6d1:	83 ec 0c             	sub    $0xc,%esp
     6d4:	57                   	push   %edi
     6d5:	56                   	push   %esi
     6d6:	51                   	push   %ecx
     6d7:	52                   	push   %edx
     6d8:	50                   	push   %eax
     6d9:	e8 43 15 00 00       	call   1c21 <initRect>
     6de:	83 c4 1c             	add    $0x1c,%esp
     6e1:	83 ec 04             	sub    $0x4,%esp
     6e4:	53                   	push   %ebx
     6e5:	6a 02                	push   $0x2
     6e7:	ff 75 dc             	pushl  -0x24(%ebp)
     6ea:	ff 75 d8             	pushl  -0x28(%ebp)
     6ed:	ff 75 d4             	pushl  -0x2c(%ebp)
     6f0:	ff 75 d0             	pushl  -0x30(%ebp)
     6f3:	ff 75 08             	pushl  0x8(%ebp)
     6f6:	e8 08 16 00 00       	call   1d03 <createClickable>
     6fb:	83 c4 20             	add    $0x20,%esp

void addWndEvent(ClickableManager *cm) {
    int i;
	int n = sizeof(wndEvents) / sizeof(Handler);

	for (i = 0; i < n; i++) {
     6fe:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     702:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     705:	3b 45 e0             	cmp    -0x20(%ebp),%eax
     708:	7c 86                	jl     690 <addWndEvent+0x19>
		createClickable(cm,
				initRect(wndRes[i].position_x, wndRes[i].position_y,
						wndRes[i].pic.width, wndRes[i].pic.height), MSG_LPRESS,
				wndEvents[i]);
	}
}
     70a:	90                   	nop
     70b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     70e:	5b                   	pop    %ebx
     70f:	5e                   	pop    %esi
     710:	5f                   	pop    %edi
     711:	5d                   	pop    %ebp
     712:	c3                   	ret    

00000713 <main>:

int main(int argc, char *argv[]) {
     713:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     717:	83 e4 f0             	and    $0xfffffff0,%esp
     71a:	ff 71 fc             	pushl  -0x4(%ecx)
     71d:	55                   	push   %ebp
     71e:	89 e5                	mov    %esp,%ebp
     720:	57                   	push   %edi
     721:	56                   	push   %esi
     722:	53                   	push   %ebx
     723:	51                   	push   %ecx
     724:	81 ec 98 00 00 00    	sub    $0x98,%esp
     72a:	89 cb                	mov    %ecx,%ebx
    ClickableManager cm;
    int winid;
    struct Msg msg;
    Point p;

    winid = init_context(&context, WINDOW_WIDTH, WINDOW_HEIGHT);
     72c:	83 ec 04             	sub    $0x4,%esp
     72f:	68 36 01 00 00       	push   $0x136
     734:	68 f4 01 00 00       	push   $0x1f4
     739:	8d 45 c8             	lea    -0x38(%ebp),%eax
     73c:	50                   	push   %eax
     73d:	e8 98 02 00 00       	call   9da <init_context>
     742:	83 c4 10             	add    $0x10,%esp
     745:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    cm = initClickManager(context);
     748:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
     74e:	ff 75 d0             	pushl  -0x30(%ebp)
     751:	ff 75 cc             	pushl  -0x34(%ebp)
     754:	ff 75 c8             	pushl  -0x38(%ebp)
     757:	50                   	push   %eax
     758:	e8 58 15 00 00       	call   1cb5 <initClickManager>
     75d:	83 c4 0c             	add    $0xc,%esp
     760:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
     766:	89 45 b4             	mov    %eax,-0x4c(%ebp)
     769:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
     76f:	89 45 b8             	mov    %eax,-0x48(%ebp)
     772:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
     778:	89 45 bc             	mov    %eax,-0x44(%ebp)
     77b:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
     781:	89 45 c0             	mov    %eax,-0x40(%ebp)
     784:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
     78a:	89 45 c4             	mov    %eax,-0x3c(%ebp)

    loadBitmap(&pic, argv[1]);
     78d:	8b 43 04             	mov    0x4(%ebx),%eax
     790:	83 c0 04             	add    $0x4,%eax
     793:	8b 00                	mov    (%eax),%eax
     795:	83 ec 08             	sub    $0x8,%esp
     798:	50                   	push   %eax
     799:	68 90 f9 00 00       	push   $0xf990
     79e:	e8 1d 0d 00 00       	call   14c0 <loadBitmap>
     7a3:	83 c4 10             	add    $0x10,%esp
    load_iconlist(wndRes, sizeof(wndRes) / sizeof(ICON));
     7a6:	83 ec 08             	sub    $0x8,%esp
     7a9:	6a 01                	push   $0x1
     7ab:	68 60 c6 00 00       	push   $0xc660
     7b0:	e8 60 0c 00 00       	call   1415 <load_iconlist>
     7b5:	83 c4 10             	add    $0x10,%esp

    modifyPic(context);
     7b8:	83 ec 04             	sub    $0x4,%esp
     7bb:	ff 75 d0             	pushl  -0x30(%ebp)
     7be:	ff 75 cc             	pushl  -0x34(%ebp)
     7c1:	ff 75 c8             	pushl  -0x38(%ebp)
     7c4:	e8 1e fc ff ff       	call   3e7 <modifyPic>
     7c9:	83 c4 10             	add    $0x10,%esp
    deleteClickable(&cm.left_click, initRect(0, 0, 800, 600));
     7cc:	8d 45 d4             	lea    -0x2c(%ebp),%eax
     7cf:	83 ec 0c             	sub    $0xc,%esp
     7d2:	68 58 02 00 00       	push   $0x258
     7d7:	68 20 03 00 00       	push   $0x320
     7dc:	6a 00                	push   $0x0
     7de:	6a 00                	push   $0x0
     7e0:	50                   	push   %eax
     7e1:	e8 3b 14 00 00       	call   1c21 <initRect>
     7e6:	83 c4 1c             	add    $0x1c,%esp
     7e9:	83 ec 0c             	sub    $0xc,%esp
     7ec:	ff 75 e0             	pushl  -0x20(%ebp)
     7ef:	ff 75 dc             	pushl  -0x24(%ebp)
     7f2:	ff 75 d8             	pushl  -0x28(%ebp)
     7f5:	ff 75 d4             	pushl  -0x2c(%ebp)
     7f8:	8d 45 b4             	lea    -0x4c(%ebp),%eax
     7fb:	50                   	push   %eax
     7fc:	e8 e7 15 00 00       	call   1de8 <deleteClickable>
     801:	83 c4 20             	add    $0x20,%esp
    addWndEvent(&cm);
     804:	83 ec 0c             	sub    $0xc,%esp
     807:	8d 45 b4             	lea    -0x4c(%ebp),%eax
     80a:	50                   	push   %eax
     80b:	e8 67 fe ff ff       	call   677 <addWndEvent>
     810:	83 c4 10             	add    $0x10,%esp

    while (isRun) {
     813:	e9 9e 01 00 00       	jmp    9b6 <main+0x2a3>
        getMsg(&msg);
     818:	83 ec 0c             	sub    $0xc,%esp
     81b:	8d 45 98             	lea    -0x68(%ebp),%eax
     81e:	50                   	push   %eax
     81f:	e8 8f 1c 00 00       	call   24b3 <getMsg>
     824:	83 c4 10             	add    $0x10,%esp
        switch (msg.msg_type) {
     827:	8b 45 98             	mov    -0x68(%ebp),%eax
     82a:	83 f8 08             	cmp    $0x8,%eax
     82d:	0f 87 82 01 00 00    	ja     9b5 <main+0x2a2>
     833:	8b 04 85 d0 8c 00 00 	mov    0x8cd0(,%eax,4),%eax
     83a:	ff e0                	jmp    *%eax
		case MSG_DOUBLECLICK:
			p = initPoint(msg.concrete_msg.msg_mouse.x,
     83c:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
     83f:	8b 55 a0             	mov    -0x60(%ebp),%edx
     842:	8d 45 90             	lea    -0x70(%ebp),%eax
     845:	83 ec 04             	sub    $0x4,%esp
     848:	51                   	push   %ecx
     849:	52                   	push   %edx
     84a:	50                   	push   %eax
     84b:	e8 aa 13 00 00       	call   1bfa <initPoint>
     850:	83 c4 0c             	add    $0xc,%esp
					msg.concrete_msg.msg_mouse.y);
			if (executeHandler(cm.double_click, p)) {
     853:	8b 45 b8             	mov    -0x48(%ebp),%eax
     856:	83 ec 04             	sub    $0x4,%esp
     859:	ff 75 94             	pushl  -0x6c(%ebp)
     85c:	ff 75 90             	pushl  -0x70(%ebp)
     85f:	50                   	push   %eax
     860:	e8 56 16 00 00       	call   1ebb <executeHandler>
     865:	83 c4 10             	add    $0x10,%esp
     868:	85 c0                	test   %eax,%eax
     86a:	0f 84 46 01 00 00    	je     9b6 <main+0x2a3>
				updateWindow(winid, context.addr, msg.msg_detail);
     870:	8b 55 9c             	mov    -0x64(%ebp),%edx
     873:	8b 45 c8             	mov    -0x38(%ebp),%eax
     876:	83 ec 04             	sub    $0x4,%esp
     879:	52                   	push   %edx
     87a:	50                   	push   %eax
     87b:	ff 75 e4             	pushl  -0x1c(%ebp)
     87e:	e8 48 1c 00 00       	call   24cb <updateWindow>
     883:	83 c4 10             	add    $0x10,%esp
			}
			break;
     886:	e9 2b 01 00 00       	jmp    9b6 <main+0x2a3>
		case MSG_UPDATE:
			drawPicViewerWnd(context);
     88b:	83 ec 04             	sub    $0x4,%esp
     88e:	ff 75 d0             	pushl  -0x30(%ebp)
     891:	ff 75 cc             	pushl  -0x34(%ebp)
     894:	ff 75 c8             	pushl  -0x38(%ebp)
     897:	e8 2e fc ff ff       	call   4ca <drawPicViewerWnd>
     89c:	83 c4 10             	add    $0x10,%esp
			drawPicViewerContent(context, argv[1]);
     89f:	8b 43 04             	mov    0x4(%ebx),%eax
     8a2:	83 c0 04             	add    $0x4,%eax
     8a5:	8b 00                	mov    (%eax),%eax
     8a7:	50                   	push   %eax
     8a8:	ff 75 d0             	pushl  -0x30(%ebp)
     8ab:	ff 75 cc             	pushl  -0x34(%ebp)
     8ae:	ff 75 c8             	pushl  -0x38(%ebp)
     8b1:	e8 3f fd ff ff       	call   5f5 <drawPicViewerContent>
     8b6:	83 c4 10             	add    $0x10,%esp
			updateWindow(winid, context.addr, msg.msg_detail);
     8b9:	8b 55 9c             	mov    -0x64(%ebp),%edx
     8bc:	8b 45 c8             	mov    -0x38(%ebp),%eax
     8bf:	83 ec 04             	sub    $0x4,%esp
     8c2:	52                   	push   %edx
     8c3:	50                   	push   %eax
     8c4:	ff 75 e4             	pushl  -0x1c(%ebp)
     8c7:	e8 ff 1b 00 00       	call   24cb <updateWindow>
     8cc:	83 c4 10             	add    $0x10,%esp
			break;
     8cf:	e9 e2 00 00 00       	jmp    9b6 <main+0x2a3>
		case MSG_PARTIAL_UPDATE:
			updatePartialWindow(winid, context.addr,
     8d4:	8b 7d ac             	mov    -0x54(%ebp),%edi
     8d7:	8b 75 a8             	mov    -0x58(%ebp),%esi
     8da:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
     8dd:	8b 55 a0             	mov    -0x60(%ebp),%edx
     8e0:	8b 45 c8             	mov    -0x38(%ebp),%eax
     8e3:	83 ec 08             	sub    $0x8,%esp
     8e6:	57                   	push   %edi
     8e7:	56                   	push   %esi
     8e8:	51                   	push   %ecx
     8e9:	52                   	push   %edx
     8ea:	50                   	push   %eax
     8eb:	ff 75 e4             	pushl  -0x1c(%ebp)
     8ee:	e8 e0 1b 00 00       	call   24d3 <updatePartialWindow>
     8f3:	83 c4 20             	add    $0x20,%esp
					msg.concrete_msg.msg_partial_update.x1,
					msg.concrete_msg.msg_partial_update.y1,
					msg.concrete_msg.msg_partial_update.x2,
					msg.concrete_msg.msg_partial_update.y2);
			break;
     8f6:	e9 bb 00 00 00       	jmp    9b6 <main+0x2a3>
		case MSG_LPRESS:
			p = initPoint(msg.concrete_msg.msg_mouse.x,
     8fb:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
     8fe:	8b 55 a0             	mov    -0x60(%ebp),%edx
     901:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
     907:	83 ec 04             	sub    $0x4,%esp
     90a:	51                   	push   %ecx
     90b:	52                   	push   %edx
     90c:	50                   	push   %eax
     90d:	e8 e8 12 00 00       	call   1bfa <initPoint>
     912:	83 c4 0c             	add    $0xc,%esp
     915:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
     91b:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
     921:	89 45 90             	mov    %eax,-0x70(%ebp)
     924:	89 55 94             	mov    %edx,-0x6c(%ebp)
					msg.concrete_msg.msg_mouse.y);
			if (executeHandler(cm.left_click, p)) {
     927:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     92a:	83 ec 04             	sub    $0x4,%esp
     92d:	ff 75 94             	pushl  -0x6c(%ebp)
     930:	ff 75 90             	pushl  -0x70(%ebp)
     933:	50                   	push   %eax
     934:	e8 82 15 00 00       	call   1ebb <executeHandler>
     939:	83 c4 10             	add    $0x10,%esp
     93c:	85 c0                	test   %eax,%eax
     93e:	74 76                	je     9b6 <main+0x2a3>

				updateWindow(winid, context.addr, msg.msg_detail);
     940:	8b 55 9c             	mov    -0x64(%ebp),%edx
     943:	8b 45 c8             	mov    -0x38(%ebp),%eax
     946:	83 ec 04             	sub    $0x4,%esp
     949:	52                   	push   %edx
     94a:	50                   	push   %eax
     94b:	ff 75 e4             	pushl  -0x1c(%ebp)
     94e:	e8 78 1b 00 00       	call   24cb <updateWindow>
     953:	83 c4 10             	add    $0x10,%esp
			}
			break;
     956:	eb 5e                	jmp    9b6 <main+0x2a3>
		case MSG_RPRESS:
			p = initPoint(msg.concrete_msg.msg_mouse.x,
     958:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
     95b:	8b 55 a0             	mov    -0x60(%ebp),%edx
     95e:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
     964:	83 ec 04             	sub    $0x4,%esp
     967:	51                   	push   %ecx
     968:	52                   	push   %edx
     969:	50                   	push   %eax
     96a:	e8 8b 12 00 00       	call   1bfa <initPoint>
     96f:	83 c4 0c             	add    $0xc,%esp
     972:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
     978:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
     97e:	89 45 90             	mov    %eax,-0x70(%ebp)
     981:	89 55 94             	mov    %edx,-0x6c(%ebp)
					msg.concrete_msg.msg_mouse.y);
			if (executeHandler(cm.right_click, p)) {
     984:	8b 45 bc             	mov    -0x44(%ebp),%eax
     987:	83 ec 04             	sub    $0x4,%esp
     98a:	ff 75 94             	pushl  -0x6c(%ebp)
     98d:	ff 75 90             	pushl  -0x70(%ebp)
     990:	50                   	push   %eax
     991:	e8 25 15 00 00       	call   1ebb <executeHandler>
     996:	83 c4 10             	add    $0x10,%esp
     999:	85 c0                	test   %eax,%eax
     99b:	74 19                	je     9b6 <main+0x2a3>
				updateWindow(winid, context.addr, msg.msg_detail);
     99d:	8b 55 9c             	mov    -0x64(%ebp),%edx
     9a0:	8b 45 c8             	mov    -0x38(%ebp),%eax
     9a3:	83 ec 04             	sub    $0x4,%esp
     9a6:	52                   	push   %edx
     9a7:	50                   	push   %eax
     9a8:	ff 75 e4             	pushl  -0x1c(%ebp)
     9ab:	e8 1b 1b 00 00       	call   24cb <updateWindow>
     9b0:	83 c4 10             	add    $0x10,%esp
			}
			break;
     9b3:	eb 01                	jmp    9b6 <main+0x2a3>
		default:
			break;
     9b5:	90                   	nop

    modifyPic(context);
    deleteClickable(&cm.left_click, initRect(0, 0, 800, 600));
    addWndEvent(&cm);

    while (isRun) {
     9b6:	a1 98 c6 00 00       	mov    0xc698,%eax
     9bb:	85 c0                	test   %eax,%eax
     9bd:	0f 85 55 fe ff ff    	jne    818 <main+0x105>
			break;
		default:
			break;
		}
    }
    free_context(&context, winid);
     9c3:	83 ec 08             	sub    $0x8,%esp
     9c6:	ff 75 e4             	pushl  -0x1c(%ebp)
     9c9:	8d 45 c8             	lea    -0x38(%ebp),%eax
     9cc:	50                   	push   %eax
     9cd:	e8 7c 00 00 00       	call   a4e <free_context>
     9d2:	83 c4 10             	add    $0x10,%esp
    exit();
     9d5:	e8 39 1a 00 00       	call   2413 <exit>

000009da <init_context>:
#include "stat.h"
#include "user.h"
#include "drawingAPI.h"

int init_context(struct Context* context_ptr, int width, int height)
{
     9da:	55                   	push   %ebp
     9db:	89 e5                	mov    %esp,%ebp
     9dd:	83 ec 08             	sub    $0x8,%esp
    context_ptr->width = width;
     9e0:	8b 45 08             	mov    0x8(%ebp),%eax
     9e3:	8b 55 0c             	mov    0xc(%ebp),%edx
     9e6:	89 50 04             	mov    %edx,0x4(%eax)
    context_ptr->height = height;
     9e9:	8b 45 08             	mov    0x8(%ebp),%eax
     9ec:	8b 55 10             	mov    0x10(%ebp),%edx
     9ef:	89 50 08             	mov    %edx,0x8(%eax)
    context_ptr->addr = (unsigned short*)malloc(sizeof(unsigned short) * width * height);
     9f2:	8b 55 0c             	mov    0xc(%ebp),%edx
     9f5:	8b 45 10             	mov    0x10(%ebp),%eax
     9f8:	0f af c2             	imul   %edx,%eax
     9fb:	01 c0                	add    %eax,%eax
     9fd:	83 ec 0c             	sub    $0xc,%esp
     a00:	50                   	push   %eax
     a01:	e8 bf 1e 00 00       	call   28c5 <malloc>
     a06:	83 c4 10             	add    $0x10,%esp
     a09:	89 c2                	mov    %eax,%edx
     a0b:	8b 45 08             	mov    0x8(%ebp),%eax
     a0e:	89 10                	mov    %edx,(%eax)
    memset(context_ptr->addr, 0, sizeof(unsigned short) * width * height);
     a10:	8b 55 0c             	mov    0xc(%ebp),%edx
     a13:	8b 45 10             	mov    0x10(%ebp),%eax
     a16:	0f af c2             	imul   %edx,%eax
     a19:	8d 14 00             	lea    (%eax,%eax,1),%edx
     a1c:	8b 45 08             	mov    0x8(%ebp),%eax
     a1f:	8b 00                	mov    (%eax),%eax
     a21:	83 ec 04             	sub    $0x4,%esp
     a24:	52                   	push   %edx
     a25:	6a 00                	push   $0x0
     a27:	50                   	push   %eax
     a28:	e8 4b 18 00 00       	call   2278 <memset>
     a2d:	83 c4 10             	add    $0x10,%esp
    initializeASCII();
     a30:	e8 78 01 00 00       	call   bad <initializeASCII>
    initializeGBK();
     a35:	e8 fa 02 00 00       	call   d34 <initializeGBK>
    return createWindow(0, 0, width, height);
     a3a:	ff 75 10             	pushl  0x10(%ebp)
     a3d:	ff 75 0c             	pushl  0xc(%ebp)
     a40:	6a 00                	push   $0x0
     a42:	6a 00                	push   $0x0
     a44:	e8 72 1a 00 00       	call   24bb <createWindow>
     a49:	83 c4 10             	add    $0x10,%esp
}
     a4c:	c9                   	leave  
     a4d:	c3                   	ret    

00000a4e <free_context>:

void free_context(struct Context* context_ptr, int winid)
{
     a4e:	55                   	push   %ebp
     a4f:	89 e5                	mov    %esp,%ebp
     a51:	83 ec 08             	sub    $0x8,%esp
    free(context_ptr->addr);
     a54:	8b 45 08             	mov    0x8(%ebp),%eax
     a57:	8b 00                	mov    (%eax),%eax
     a59:	83 ec 0c             	sub    $0xc,%esp
     a5c:	50                   	push   %eax
     a5d:	e8 21 1d 00 00       	call   2783 <free>
     a62:	83 c4 10             	add    $0x10,%esp
    freeASCII();
     a65:	e8 b0 02 00 00       	call   d1a <freeASCII>
    freeGBK();
     a6a:	e8 66 03 00 00       	call   dd5 <freeGBK>
    destroyWindow(winid);
     a6f:	83 ec 0c             	sub    $0xc,%esp
     a72:	ff 75 0c             	pushl  0xc(%ebp)
     a75:	e8 49 1a 00 00       	call   24c3 <destroyWindow>
     a7a:	83 c4 10             	add    $0x10,%esp
}
     a7d:	90                   	nop
     a7e:	c9                   	leave  
     a7f:	c3                   	ret    

00000a80 <draw_point>:
*             then do nothing!
*/

void
draw_point(struct Context c, unsigned int x, unsigned int y, unsigned short color)
{
     a80:	55                   	push   %ebp
     a81:	89 e5                	mov    %esp,%ebp
     a83:	83 ec 04             	sub    $0x4,%esp
     a86:	8b 45 1c             	mov    0x1c(%ebp),%eax
     a89:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  if(x >= c.width)
     a8d:	8b 45 0c             	mov    0xc(%ebp),%eax
     a90:	3b 45 14             	cmp    0x14(%ebp),%eax
     a93:	76 26                	jbe    abb <draw_point+0x3b>
    return;
  if(y >= c.height)
     a95:	8b 45 10             	mov    0x10(%ebp),%eax
     a98:	3b 45 18             	cmp    0x18(%ebp),%eax
     a9b:	76 21                	jbe    abe <draw_point+0x3e>
    return;
  c.addr[y*c.width+x] = color;
     a9d:	8b 45 08             	mov    0x8(%ebp),%eax
     aa0:	8b 55 0c             	mov    0xc(%ebp),%edx
     aa3:	89 d1                	mov    %edx,%ecx
     aa5:	0f af 4d 18          	imul   0x18(%ebp),%ecx
     aa9:	8b 55 14             	mov    0x14(%ebp),%edx
     aac:	01 ca                	add    %ecx,%edx
     aae:	01 d2                	add    %edx,%edx
     ab0:	01 c2                	add    %eax,%edx
     ab2:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
     ab6:	66 89 02             	mov    %ax,(%edx)
     ab9:	eb 04                	jmp    abf <draw_point+0x3f>

void
draw_point(struct Context c, unsigned int x, unsigned int y, unsigned short color)
{
  if(x >= c.width)
    return;
     abb:	90                   	nop
     abc:	eb 01                	jmp    abf <draw_point+0x3f>
  if(y >= c.height)
    return;
     abe:	90                   	nop
  c.addr[y*c.width+x] = color;
}
     abf:	c9                   	leave  
     ac0:	c3                   	ret    

00000ac1 <fill_rect>:
/*
*fill_rect: set a rect area with a certain color
*/
void
fill_rect(struct Context c, unsigned int bx, unsigned int by, unsigned int width, unsigned int height, unsigned short color)
{
     ac1:	55                   	push   %ebp
     ac2:	89 e5                	mov    %esp,%ebp
     ac4:	83 ec 14             	sub    $0x14,%esp
     ac7:	8b 45 24             	mov    0x24(%ebp),%eax
     aca:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
     ace:	8b 55 14             	mov    0x14(%ebp),%edx
     ad1:	8b 45 1c             	mov    0x1c(%ebp),%eax
     ad4:	01 d0                	add    %edx,%eax
     ad6:	8b 55 0c             	mov    0xc(%ebp),%edx
     ad9:	39 d0                	cmp    %edx,%eax
     adb:	0f 47 c2             	cmova  %edx,%eax
     ade:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int my = c.height < by + height ? c.height : by + height;
     ae1:	8b 55 18             	mov    0x18(%ebp),%edx
     ae4:	8b 45 20             	mov    0x20(%ebp),%eax
     ae7:	01 d0                	add    %edx,%eax
     ae9:	8b 55 10             	mov    0x10(%ebp),%edx
     aec:	39 d0                	cmp    %edx,%eax
     aee:	0f 47 c2             	cmova  %edx,%eax
     af1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	for (y = by; y < my; y++)
     af4:	8b 45 18             	mov    0x18(%ebp),%eax
     af7:	89 45 f8             	mov    %eax,-0x8(%ebp)
     afa:	eb 36                	jmp    b32 <fill_rect+0x71>
	{
		for (x = bx; x < mx; x++)
     afc:	8b 45 14             	mov    0x14(%ebp),%eax
     aff:	89 45 fc             	mov    %eax,-0x4(%ebp)
     b02:	eb 22                	jmp    b26 <fill_rect+0x65>
		{
			draw_point(c, x, y, color);
     b04:	0f b7 4d ec          	movzwl -0x14(%ebp),%ecx
     b08:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b0b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b0e:	51                   	push   %ecx
     b0f:	52                   	push   %edx
     b10:	50                   	push   %eax
     b11:	ff 75 10             	pushl  0x10(%ebp)
     b14:	ff 75 0c             	pushl  0xc(%ebp)
     b17:	ff 75 08             	pushl  0x8(%ebp)
     b1a:	e8 61 ff ff ff       	call   a80 <draw_point>
     b1f:	83 c4 18             	add    $0x18,%esp
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
	int my = c.height < by + height ? c.height : by + height;
	for (y = by; y < my; y++)
	{
		for (x = bx; x < mx; x++)
     b22:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     b26:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b29:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     b2c:	7c d6                	jl     b04 <fill_rect+0x43>
fill_rect(struct Context c, unsigned int bx, unsigned int by, unsigned int width, unsigned int height, unsigned short color)
{
	int x, y;
	int mx = c.width < bx + width ? c.width : bx + width;
	int my = c.height < by + height ? c.height : by + height;
	for (y = by; y < my; y++)
     b2e:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     b32:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b35:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     b38:	7c c2                	jl     afc <fill_rect+0x3b>
		for (x = bx; x < mx; x++)
		{
			draw_point(c, x, y, color);
		}
	}
}
     b3a:	90                   	nop
     b3b:	c9                   	leave  
     b3c:	c3                   	ret    

00000b3d <printBinary>:

void printBinary(char c)
{
     b3d:	55                   	push   %ebp
     b3e:	89 e5                	mov    %esp,%ebp
     b40:	83 ec 28             	sub    $0x28,%esp
     b43:	8b 45 08             	mov    0x8(%ebp),%eax
     b46:	88 45 e4             	mov    %al,-0x1c(%ebp)
	int i;
	for (i = 0; i < 8; i++)
     b49:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b50:	eb 40                	jmp    b92 <printBinary+0x55>
	{
		if(((c << i) & 0x80) != 0)
     b52:	0f be 55 e4          	movsbl -0x1c(%ebp),%edx
     b56:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b59:	89 c1                	mov    %eax,%ecx
     b5b:	d3 e2                	shl    %cl,%edx
     b5d:	89 d0                	mov    %edx,%eax
     b5f:	25 80 00 00 00       	and    $0x80,%eax
     b64:	85 c0                	test   %eax,%eax
     b66:	74 14                	je     b7c <printBinary+0x3f>
		{
			printf(0, "1");
     b68:	83 ec 08             	sub    $0x8,%esp
     b6b:	68 f4 8c 00 00       	push   $0x8cf4
     b70:	6a 00                	push   $0x0
     b72:	e8 7b 1a 00 00       	call   25f2 <printf>
     b77:	83 c4 10             	add    $0x10,%esp
     b7a:	eb 12                	jmp    b8e <printBinary+0x51>
		}
		else
		{
			printf(0, "0");
     b7c:	83 ec 08             	sub    $0x8,%esp
     b7f:	68 f6 8c 00 00       	push   $0x8cf6
     b84:	6a 00                	push   $0x0
     b86:	e8 67 1a 00 00       	call   25f2 <printf>
     b8b:	83 c4 10             	add    $0x10,%esp
}

void printBinary(char c)
{
	int i;
	for (i = 0; i < 8; i++)
     b8e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b92:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
     b96:	7e ba                	jle    b52 <printBinary+0x15>
		{
			printf(0, "0");
		}
	}

	printf(0, "\n");
     b98:	83 ec 08             	sub    $0x8,%esp
     b9b:	68 f8 8c 00 00       	push   $0x8cf8
     ba0:	6a 00                	push   $0x0
     ba2:	e8 4b 1a 00 00       	call   25f2 <printf>
     ba7:	83 c4 10             	add    $0x10,%esp
}
     baa:	90                   	nop
     bab:	c9                   	leave  
     bac:	c3                   	ret    

00000bad <initializeASCII>:
char buf[512];
//hankaku是一个数组，将hankaku.txt文件中的每一行转化成一个8位整数（unsigned short）
//每16个整数可以代表一个字符
unsigned char *hankaku;
void initializeASCII()
{
     bad:	55                   	push   %ebp
     bae:	89 e5                	mov    %esp,%ebp
     bb0:	56                   	push   %esi
     bb1:	53                   	push   %ebx
     bb2:	83 ec 20             	sub    $0x20,%esp

	int fd, n, i;
	int x, y;
	printf(0,"initialzing ASCII\n");
     bb5:	83 ec 08             	sub    $0x8,%esp
     bb8:	68 fa 8c 00 00       	push   $0x8cfa
     bbd:	6a 00                	push   $0x0
     bbf:	e8 2e 1a 00 00       	call   25f2 <printf>
     bc4:	83 c4 10             	add    $0x10,%esp
	//打开hankaku.txt文件
	if((fd = open(HANKAKU, 0)) < 0){
     bc7:	83 ec 08             	sub    $0x8,%esp
     bca:	6a 00                	push   $0x0
     bcc:	68 0d 8d 00 00       	push   $0x8d0d
     bd1:	e8 7d 18 00 00       	call   2453 <open>
     bd6:	83 c4 10             	add    $0x10,%esp
     bd9:	89 45 e8             	mov    %eax,-0x18(%ebp)
     bdc:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     be0:	79 1c                	jns    bfe <initializeASCII+0x51>
	  printf(0,"cannot open %s\n", HANKAKU);
     be2:	83 ec 04             	sub    $0x4,%esp
     be5:	68 0d 8d 00 00       	push   $0x8d0d
     bea:	68 19 8d 00 00       	push   $0x8d19
     bef:	6a 00                	push   $0x0
     bf1:	e8 fc 19 00 00       	call   25f2 <printf>
     bf6:	83 c4 10             	add    $0x10,%esp
	  return;
     bf9:	e9 15 01 00 00       	jmp    d13 <initializeASCII+0x166>
	}
	//申请hankaku数组
	hankaku = malloc(ASCII_NUM*ASCII_HEIGHT);
     bfe:	83 ec 0c             	sub    $0xc,%esp
     c01:	68 00 10 00 00       	push   $0x1000
     c06:	e8 ba 1c 00 00       	call   28c5 <malloc>
     c0b:	83 c4 10             	add    $0x10,%esp
     c0e:	a3 a0 f9 00 00       	mov    %eax,0xf9a0
	for (i = 0; i < ASCII_NUM; i++)
     c13:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c1a:	eb 12                	jmp    c2e <initializeASCII+0x81>
	{
		hankaku[i] = 0;
     c1c:	8b 15 a0 f9 00 00    	mov    0xf9a0,%edx
     c22:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c25:	01 d0                	add    %edx,%eax
     c27:	c6 00 00             	movb   $0x0,(%eax)
	  printf(0,"cannot open %s\n", HANKAKU);
	  return;
	}
	//申请hankaku数组
	hankaku = malloc(ASCII_NUM*ASCII_HEIGHT);
	for (i = 0; i < ASCII_NUM; i++)
     c2a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c2e:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
     c35:	7e e5                	jle    c1c <initializeASCII+0x6f>

	//不断读取文件，如果读到的字符是“*/."，就按顺序记录到hankaku数组中
	//y表示当前记录到第几行（对应于hankaku数组里的第几个数），x表示当前记录到第几列
	//如果当前字符是"*",则对应第y个数第x位置为1
	//每当x == ASCII_WIDTH，x重新置为0, y++
	x = 0;
     c37:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	y = 0;
     c3e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	while((n = read(fd, buf, sizeof(buf))) > 0)
     c45:	e9 84 00 00 00       	jmp    cce <initializeASCII+0x121>
	{
		for (i = 0; i < n; i++){
     c4a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c51:	eb 73                	jmp    cc6 <initializeASCII+0x119>
			//printf(0,"%c, %d", buf[i], i);
			if (buf[i] == '*' || buf[i] == '.')
     c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c56:	05 c0 f9 00 00       	add    $0xf9c0,%eax
     c5b:	0f b6 00             	movzbl (%eax),%eax
     c5e:	3c 2a                	cmp    $0x2a,%al
     c60:	74 0f                	je     c71 <initializeASCII+0xc4>
     c62:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c65:	05 c0 f9 00 00       	add    $0xf9c0,%eax
     c6a:	0f b6 00             	movzbl (%eax),%eax
     c6d:	3c 2e                	cmp    $0x2e,%al
     c6f:	75 51                	jne    cc2 <initializeASCII+0x115>
			{
				if (buf[i] == '*')
     c71:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c74:	05 c0 f9 00 00       	add    $0xf9c0,%eax
     c79:	0f b6 00             	movzbl (%eax),%eax
     c7c:	3c 2a                	cmp    $0x2a,%al
     c7e:	75 2d                	jne    cad <initializeASCII+0x100>
				{
					hankaku[y] |= (0x80 >> x);
     c80:	8b 15 a0 f9 00 00    	mov    0xf9a0,%edx
     c86:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c89:	01 c2                	add    %eax,%edx
     c8b:	8b 0d a0 f9 00 00    	mov    0xf9a0,%ecx
     c91:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c94:	01 c8                	add    %ecx,%eax
     c96:	0f b6 00             	movzbl (%eax),%eax
     c99:	89 c6                	mov    %eax,%esi
     c9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c9e:	bb 80 00 00 00       	mov    $0x80,%ebx
     ca3:	89 c1                	mov    %eax,%ecx
     ca5:	d3 fb                	sar    %cl,%ebx
     ca7:	89 d8                	mov    %ebx,%eax
     ca9:	09 f0                	or     %esi,%eax
     cab:	88 02                	mov    %al,(%edx)
				}
				x ++;
     cad:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
				if (x >= ASCII_WIDTH)
     cb1:	83 7d f0 07          	cmpl   $0x7,-0x10(%ebp)
     cb5:	7e 0b                	jle    cc2 <initializeASCII+0x115>
				{
					x = 0;
     cb7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
					y ++;
     cbe:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
	//每当x == ASCII_WIDTH，x重新置为0, y++
	x = 0;
	y = 0;
	while((n = read(fd, buf, sizeof(buf))) > 0)
	{
		for (i = 0; i < n; i++){
     cc2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     cc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
     ccc:	7c 85                	jl     c53 <initializeASCII+0xa6>
	//y表示当前记录到第几行（对应于hankaku数组里的第几个数），x表示当前记录到第几列
	//如果当前字符是"*",则对应第y个数第x位置为1
	//每当x == ASCII_WIDTH，x重新置为0, y++
	x = 0;
	y = 0;
	while((n = read(fd, buf, sizeof(buf))) > 0)
     cce:	83 ec 04             	sub    $0x4,%esp
     cd1:	68 00 02 00 00       	push   $0x200
     cd6:	68 c0 f9 00 00       	push   $0xf9c0
     cdb:	ff 75 e8             	pushl  -0x18(%ebp)
     cde:	e8 48 17 00 00       	call   242b <read>
     ce3:	83 c4 10             	add    $0x10,%esp
     ce6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ce9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     ced:	0f 8f 57 ff ff ff    	jg     c4a <initializeASCII+0x9d>

//	for (i = 0; i < ASCII_NUM * ASCII_HEIGHT; i++)
//	{
//		printBinary(hankaku[i]);
//	}
	printf(0,"initialzing ASCII complete!\n");
     cf3:	83 ec 08             	sub    $0x8,%esp
     cf6:	68 29 8d 00 00       	push   $0x8d29
     cfb:	6a 00                	push   $0x0
     cfd:	e8 f0 18 00 00       	call   25f2 <printf>
     d02:	83 c4 10             	add    $0x10,%esp
	close(fd);
     d05:	83 ec 0c             	sub    $0xc,%esp
     d08:	ff 75 e8             	pushl  -0x18(%ebp)
     d0b:	e8 2b 17 00 00       	call   243b <close>
     d10:	83 c4 10             	add    $0x10,%esp
}
     d13:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d16:	5b                   	pop    %ebx
     d17:	5e                   	pop    %esi
     d18:	5d                   	pop    %ebp
     d19:	c3                   	ret    

00000d1a <freeASCII>:

void freeASCII(){
     d1a:	55                   	push   %ebp
     d1b:	89 e5                	mov    %esp,%ebp
     d1d:	83 ec 08             	sub    $0x8,%esp
	free(hankaku);
     d20:	a1 a0 f9 00 00       	mov    0xf9a0,%eax
     d25:	83 ec 0c             	sub    $0xc,%esp
     d28:	50                   	push   %eax
     d29:	e8 55 1a 00 00       	call   2783 <free>
     d2e:	83 c4 10             	add    $0x10,%esp
}
     d31:	90                   	nop
     d32:	c9                   	leave  
     d33:	c3                   	ret    

00000d34 <initializeGBK>:

struct File_Node fontFile;
void initializeGBK(){
     d34:	55                   	push   %ebp
     d35:	89 e5                	mov    %esp,%ebp
     d37:	83 ec 18             	sub    $0x18,%esp
	int fd;
	printf(0,"initialzing gbk\n");
     d3a:	83 ec 08             	sub    $0x8,%esp
     d3d:	68 46 8d 00 00       	push   $0x8d46
     d42:	6a 00                	push   $0x0
     d44:	e8 a9 18 00 00       	call   25f2 <printf>
     d49:	83 c4 10             	add    $0x10,%esp
	if((fd = open(HZK16, 0)) < 0){
     d4c:	83 ec 08             	sub    $0x8,%esp
     d4f:	6a 00                	push   $0x0
     d51:	68 57 8d 00 00       	push   $0x8d57
     d56:	e8 f8 16 00 00       	call   2453 <open>
     d5b:	83 c4 10             	add    $0x10,%esp
     d5e:	89 45 f4             	mov    %eax,-0xc(%ebp)
     d61:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     d65:	79 19                	jns    d80 <initializeGBK+0x4c>
		printf(0,"cannot open %s\n", HZK16);
     d67:	83 ec 04             	sub    $0x4,%esp
     d6a:	68 57 8d 00 00       	push   $0x8d57
     d6f:	68 19 8d 00 00       	push   $0x8d19
     d74:	6a 00                	push   $0x0
     d76:	e8 77 18 00 00       	call   25f2 <printf>
     d7b:	83 c4 10             	add    $0x10,%esp
		return;
     d7e:	eb 53                	jmp    dd3 <initializeGBK+0x9f>
	}
	fontFile.buf = malloc(27000*sizeof(unsigned char));
     d80:	83 ec 0c             	sub    $0xc,%esp
     d83:	68 78 69 00 00       	push   $0x6978
     d88:	e8 38 1b 00 00       	call   28c5 <malloc>
     d8d:	83 c4 10             	add    $0x10,%esp
     d90:	a3 a4 f9 00 00       	mov    %eax,0xf9a4
	fontFile.size = read(fd, fontFile.buf, 27000);
     d95:	a1 a4 f9 00 00       	mov    0xf9a4,%eax
     d9a:	83 ec 04             	sub    $0x4,%esp
     d9d:	68 78 69 00 00       	push   $0x6978
     da2:	50                   	push   %eax
     da3:	ff 75 f4             	pushl  -0xc(%ebp)
     da6:	e8 80 16 00 00       	call   242b <read>
     dab:	83 c4 10             	add    $0x10,%esp
     dae:	a3 a8 f9 00 00       	mov    %eax,0xf9a8
	printf(0,"initialzing gbk complete!\n");
     db3:	83 ec 08             	sub    $0x8,%esp
     db6:	68 61 8d 00 00       	push   $0x8d61
     dbb:	6a 00                	push   $0x0
     dbd:	e8 30 18 00 00       	call   25f2 <printf>
     dc2:	83 c4 10             	add    $0x10,%esp
	close(fd);
     dc5:	83 ec 0c             	sub    $0xc,%esp
     dc8:	ff 75 f4             	pushl  -0xc(%ebp)
     dcb:	e8 6b 16 00 00       	call   243b <close>
     dd0:	83 c4 10             	add    $0x10,%esp
}
     dd3:	c9                   	leave  
     dd4:	c3                   	ret    

00000dd5 <freeGBK>:

void freeGBK(){
     dd5:	55                   	push   %ebp
     dd6:	89 e5                	mov    %esp,%ebp
     dd8:	83 ec 08             	sub    $0x8,%esp
	free(fontFile.buf);
     ddb:	a1 a4 f9 00 00       	mov    0xf9a4,%eax
     de0:	83 ec 0c             	sub    $0xc,%esp
     de3:	50                   	push   %eax
     de4:	e8 9a 19 00 00       	call   2783 <free>
     de9:	83 c4 10             	add    $0x10,%esp
}
     dec:	90                   	nop
     ded:	c9                   	leave  
     dee:	c3                   	ret    

00000def <put_ascii>:

void put_ascii(struct Context c, unsigned char ascii, unsigned short colorNum, int x, int y)
{
     def:	55                   	push   %ebp
     df0:	89 e5                	mov    %esp,%ebp
     df2:	53                   	push   %ebx
     df3:	83 ec 18             	sub    $0x18,%esp
     df6:	8b 55 14             	mov    0x14(%ebp),%edx
     df9:	8b 45 18             	mov    0x18(%ebp),%eax
     dfc:	88 55 e8             	mov    %dl,-0x18(%ebp)
     dff:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
	int tmpX, tmpY;
	//printf(0, "put ascii: %c, color: %d\n", ascii, colorNum);
	for(tmpY = y; tmpY < y + 16; tmpY++) {
     e03:	8b 45 20             	mov    0x20(%ebp),%eax
     e06:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e09:	eb 6b                	jmp    e76 <put_ascii+0x87>
		for(tmpX = 0; tmpX < 8; tmpX++) {
     e0b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
     e12:	eb 58                	jmp    e6c <put_ascii+0x7d>
			if((((hankaku + (ascii * 16))[tmpY - y] << tmpX) & 0x80) == 0x80) {
     e14:	8b 15 a0 f9 00 00    	mov    0xf9a0,%edx
     e1a:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
     e1e:	c1 e0 04             	shl    $0x4,%eax
     e21:	89 c1                	mov    %eax,%ecx
     e23:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e26:	2b 45 20             	sub    0x20(%ebp),%eax
     e29:	01 c8                	add    %ecx,%eax
     e2b:	01 d0                	add    %edx,%eax
     e2d:	0f b6 00             	movzbl (%eax),%eax
     e30:	0f b6 d0             	movzbl %al,%edx
     e33:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e36:	89 c1                	mov    %eax,%ecx
     e38:	d3 e2                	shl    %cl,%edx
     e3a:	89 d0                	mov    %edx,%eax
     e3c:	25 80 00 00 00       	and    $0x80,%eax
     e41:	85 c0                	test   %eax,%eax
     e43:	74 23                	je     e68 <put_ascii+0x79>
				//printf(0, "x: %d, y: %d\n", x + tmpX, tmpY);
				draw_point(c, x + tmpX, tmpY, colorNum);
     e45:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
     e49:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e4c:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
     e4f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     e52:	01 d9                	add    %ebx,%ecx
     e54:	52                   	push   %edx
     e55:	50                   	push   %eax
     e56:	51                   	push   %ecx
     e57:	ff 75 10             	pushl  0x10(%ebp)
     e5a:	ff 75 0c             	pushl  0xc(%ebp)
     e5d:	ff 75 08             	pushl  0x8(%ebp)
     e60:	e8 1b fc ff ff       	call   a80 <draw_point>
     e65:	83 c4 18             	add    $0x18,%esp
void put_ascii(struct Context c, unsigned char ascii, unsigned short colorNum, int x, int y)
{
	int tmpX, tmpY;
	//printf(0, "put ascii: %c, color: %d\n", ascii, colorNum);
	for(tmpY = y; tmpY < y + 16; tmpY++) {
		for(tmpX = 0; tmpX < 8; tmpX++) {
     e68:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     e6c:	83 7d f8 07          	cmpl   $0x7,-0x8(%ebp)
     e70:	7e a2                	jle    e14 <put_ascii+0x25>

void put_ascii(struct Context c, unsigned char ascii, unsigned short colorNum, int x, int y)
{
	int tmpX, tmpY;
	//printf(0, "put ascii: %c, color: %d\n", ascii, colorNum);
	for(tmpY = y; tmpY < y + 16; tmpY++) {
     e72:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e76:	8b 45 20             	mov    0x20(%ebp),%eax
     e79:	83 c0 10             	add    $0x10,%eax
     e7c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     e7f:	7f 8a                	jg     e0b <put_ascii+0x1c>
				draw_point(c, x + tmpX, tmpY, colorNum);
				//sheet->buf[tmpY * sheet->width + x + tmpX] = colorNum;
			}
		}
	}
}
     e81:	90                   	nop
     e82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e85:	c9                   	leave  
     e86:	c3                   	ret    

00000e87 <put_gbk>:

void put_gbk(struct Context c, short gbk, unsigned short colorNum, int x, int y)
{
     e87:	55                   	push   %ebp
     e88:	89 e5                	mov    %esp,%ebp
     e8a:	53                   	push   %ebx
     e8b:	83 ec 18             	sub    $0x18,%esp
     e8e:	8b 55 14             	mov    0x14(%ebp),%edx
     e91:	8b 45 18             	mov    0x18(%ebp),%eax
     e94:	66 89 55 e8          	mov    %dx,-0x18(%ebp)
     e98:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
	int tmpX, tmpY;
	unsigned int offset;
	unsigned char *hzk16Base;
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
     e9c:	0f bf 45 e8          	movswl -0x18(%ebp),%eax
     ea0:	0f b6 c0             	movzbl %al,%eax
     ea3:	3d a0 00 00 00       	cmp    $0xa0,%eax
     ea8:	0f 8e 1e 01 00 00    	jle    fcc <put_gbk+0x145>
     eae:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
     eb2:	66 c1 f8 08          	sar    $0x8,%ax
     eb6:	98                   	cwtl   
     eb7:	0f b6 c0             	movzbl %al,%eax
     eba:	3d a0 00 00 00       	cmp    $0xa0,%eax
     ebf:	0f 8e 07 01 00 00    	jle    fcc <put_gbk+0x145>
		hzk16Base = fontFile.buf;
     ec5:	a1 a4 f9 00 00       	mov    0xf9a4,%eax
     eca:	89 45 ec             	mov    %eax,-0x14(%ebp)
		offset = (((gbk & 0x00FF) - 0xa1) * 94 + (((gbk >> 8) & 0x00FF) - 0xa1)) * 32;
     ecd:	0f bf 45 e8          	movswl -0x18(%ebp),%eax
     ed1:	0f b6 c0             	movzbl %al,%eax
     ed4:	2d a1 00 00 00       	sub    $0xa1,%eax
     ed9:	6b c0 5e             	imul   $0x5e,%eax,%eax
     edc:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
     ee0:	66 c1 fa 08          	sar    $0x8,%dx
     ee4:	0f bf d2             	movswl %dx,%edx
     ee7:	0f b6 d2             	movzbl %dl,%edx
     eea:	81 ea a1 00 00 00    	sub    $0xa1,%edx
     ef0:	01 d0                	add    %edx,%eax
     ef2:	c1 e0 05             	shl    $0x5,%eax
     ef5:	89 45 f0             	mov    %eax,-0x10(%ebp)

		for(tmpY = y; tmpY < 16 + y; tmpY++) {
     ef8:	8b 45 20             	mov    0x20(%ebp),%eax
     efb:	89 45 f4             	mov    %eax,-0xc(%ebp)
     efe:	e9 b8 00 00 00       	jmp    fbb <put_gbk+0x134>
			for(tmpX = 0; tmpX < 8; tmpX++) {
     f03:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
     f0a:	eb 47                	jmp    f53 <put_gbk+0xcc>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
     f0c:	8b 55 ec             	mov    -0x14(%ebp),%edx
     f0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f12:	01 d0                	add    %edx,%eax
     f14:	0f b6 00             	movzbl (%eax),%eax
     f17:	0f b6 d0             	movzbl %al,%edx
     f1a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f1d:	89 c1                	mov    %eax,%ecx
     f1f:	d3 e2                	shl    %cl,%edx
     f21:	89 d0                	mov    %edx,%eax
     f23:	25 80 00 00 00       	and    $0x80,%eax
     f28:	85 c0                	test   %eax,%eax
     f2a:	74 23                	je     f4f <put_gbk+0xc8>
					draw_point(c, x + tmpX, tmpY, colorNum);
     f2c:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
     f30:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f33:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
     f36:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     f39:	01 d9                	add    %ebx,%ecx
     f3b:	52                   	push   %edx
     f3c:	50                   	push   %eax
     f3d:	51                   	push   %ecx
     f3e:	ff 75 10             	pushl  0x10(%ebp)
     f41:	ff 75 0c             	pushl  0xc(%ebp)
     f44:	ff 75 08             	pushl  0x8(%ebp)
     f47:	e8 34 fb ff ff       	call   a80 <draw_point>
     f4c:	83 c4 18             	add    $0x18,%esp
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
		hzk16Base = fontFile.buf;
		offset = (((gbk & 0x00FF) - 0xa1) * 94 + (((gbk >> 8) & 0x00FF) - 0xa1)) * 32;

		for(tmpY = y; tmpY < 16 + y; tmpY++) {
			for(tmpX = 0; tmpX < 8; tmpX++) {
     f4f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     f53:	83 7d f8 07          	cmpl   $0x7,-0x8(%ebp)
     f57:	7e b3                	jle    f0c <put_gbk+0x85>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
					draw_point(c, x + tmpX, tmpY, colorNum);
					//sheet->buf[tmpY * sheet->width + x + tmpX] = colorNum;
				}
			}
			offset++;
     f59:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
			for(tmpX = 0; tmpX < 8; tmpX++) {
     f5d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
     f64:	eb 47                	jmp    fad <put_gbk+0x126>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
     f66:	8b 55 ec             	mov    -0x14(%ebp),%edx
     f69:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f6c:	01 d0                	add    %edx,%eax
     f6e:	0f b6 00             	movzbl (%eax),%eax
     f71:	0f b6 d0             	movzbl %al,%edx
     f74:	8b 45 f8             	mov    -0x8(%ebp),%eax
     f77:	89 c1                	mov    %eax,%ecx
     f79:	d3 e2                	shl    %cl,%edx
     f7b:	89 d0                	mov    %edx,%eax
     f7d:	25 80 00 00 00       	and    $0x80,%eax
     f82:	85 c0                	test   %eax,%eax
     f84:	74 23                	je     fa9 <put_gbk+0x122>
					draw_point(c, x + tmpX, tmpY, colorNum);
     f86:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
     f8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f8d:	8b 5d 1c             	mov    0x1c(%ebp),%ebx
     f90:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     f93:	01 d9                	add    %ebx,%ecx
     f95:	52                   	push   %edx
     f96:	50                   	push   %eax
     f97:	51                   	push   %ecx
     f98:	ff 75 10             	pushl  0x10(%ebp)
     f9b:	ff 75 0c             	pushl  0xc(%ebp)
     f9e:	ff 75 08             	pushl  0x8(%ebp)
     fa1:	e8 da fa ff ff       	call   a80 <draw_point>
     fa6:	83 c4 18             	add    $0x18,%esp
					draw_point(c, x + tmpX, tmpY, colorNum);
					//sheet->buf[tmpY * sheet->width + x + tmpX] = colorNum;
				}
			}
			offset++;
			for(tmpX = 0; tmpX < 8; tmpX++) {
     fa9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
     fad:	83 7d f8 07          	cmpl   $0x7,-0x8(%ebp)
     fb1:	7e b3                	jle    f66 <put_gbk+0xdf>
				if(((hzk16Base[offset] << tmpX) & 0x80) == 0x80) {
					draw_point(c, x + tmpX, tmpY, colorNum);
					//sheet->buf[tmpY * sheet->width + x + tmpX + 8] = colorNum;
				}
			}
			offset++;
     fb3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
	unsigned char *hzk16Base;
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
		hzk16Base = fontFile.buf;
		offset = (((gbk & 0x00FF) - 0xa1) * 94 + (((gbk >> 8) & 0x00FF) - 0xa1)) * 32;

		for(tmpY = y; tmpY < 16 + y; tmpY++) {
     fb7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     fbb:	8b 45 20             	mov    0x20(%ebp),%eax
     fbe:	83 c0 10             	add    $0x10,%eax
     fc1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     fc4:	0f 8f 39 ff ff ff    	jg     f03 <put_gbk+0x7c>
void put_gbk(struct Context c, short gbk, unsigned short colorNum, int x, int y)
{
	int tmpX, tmpY;
	unsigned int offset;
	unsigned char *hzk16Base;
	if((gbk & 0x00FF) >= 0xA1 && ((gbk >> 8) & 0x00FF) >= 0xA1) {
     fca:	eb 50                	jmp    101c <put_gbk+0x195>
			}
			offset++;
		}
	}
	else {
		put_ascii(c, (gbk & 0x00FF), colorNum, x, y);
     fcc:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
     fd0:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
     fd4:	0f b6 c0             	movzbl %al,%eax
     fd7:	ff 75 20             	pushl  0x20(%ebp)
     fda:	ff 75 1c             	pushl  0x1c(%ebp)
     fdd:	52                   	push   %edx
     fde:	50                   	push   %eax
     fdf:	ff 75 10             	pushl  0x10(%ebp)
     fe2:	ff 75 0c             	pushl  0xc(%ebp)
     fe5:	ff 75 08             	pushl  0x8(%ebp)
     fe8:	e8 02 fe ff ff       	call   def <put_ascii>
     fed:	83 c4 1c             	add    $0x1c,%esp
		put_ascii(c, ((gbk >> 8) & 0x00FF), colorNum, x + 8, y);
     ff0:	8b 45 1c             	mov    0x1c(%ebp),%eax
     ff3:	8d 48 08             	lea    0x8(%eax),%ecx
     ff6:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
     ffa:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
     ffe:	66 c1 f8 08          	sar    $0x8,%ax
    1002:	0f b6 c0             	movzbl %al,%eax
    1005:	ff 75 20             	pushl  0x20(%ebp)
    1008:	51                   	push   %ecx
    1009:	52                   	push   %edx
    100a:	50                   	push   %eax
    100b:	ff 75 10             	pushl  0x10(%ebp)
    100e:	ff 75 0c             	pushl  0xc(%ebp)
    1011:	ff 75 08             	pushl  0x8(%ebp)
    1014:	e8 d6 fd ff ff       	call   def <put_ascii>
    1019:	83 c4 1c             	add    $0x1c,%esp
	}
}
    101c:	90                   	nop
    101d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1020:	c9                   	leave  
    1021:	c3                   	ret    

00001022 <puts_str>:

void puts_str(struct Context c, char *str, unsigned short colorNum, int x, int y)
{
    1022:	55                   	push   %ebp
    1023:	89 e5                	mov    %esp,%ebp
    1025:	83 ec 28             	sub    $0x28,%esp
    1028:	8b 45 18             	mov    0x18(%ebp),%eax
    102b:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
	//printf(0,"puts string : %s\n", str);
	int i = 0, xTmp;
    102f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	short wStr;
	uint rowLetterCnt;

	rowLetterCnt = strlen(str);
    1036:	83 ec 0c             	sub    $0xc,%esp
    1039:	ff 75 14             	pushl  0x14(%ebp)
    103c:	e8 10 12 00 00       	call   2251 <strlen>
    1041:	83 c4 10             	add    $0x10,%esp
    1044:	89 45 ec             	mov    %eax,-0x14(%ebp)
	for(i = 0, xTmp = x; i < rowLetterCnt;) {
    1047:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    104e:	8b 45 1c             	mov    0x1c(%ebp),%eax
    1051:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1054:	eb 36                	jmp    108c <puts_str+0x6a>
		if(str[i] < 0xA1) {
			put_ascii(c, str[i], colorNum, xTmp, y);
    1056:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
    105a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    105d:	8b 45 14             	mov    0x14(%ebp),%eax
    1060:	01 c8                	add    %ecx,%eax
    1062:	0f b6 00             	movzbl (%eax),%eax
    1065:	0f b6 c0             	movzbl %al,%eax
    1068:	83 ec 04             	sub    $0x4,%esp
    106b:	ff 75 20             	pushl  0x20(%ebp)
    106e:	ff 75 f0             	pushl  -0x10(%ebp)
    1071:	52                   	push   %edx
    1072:	50                   	push   %eax
    1073:	ff 75 10             	pushl  0x10(%ebp)
    1076:	ff 75 0c             	pushl  0xc(%ebp)
    1079:	ff 75 08             	pushl  0x8(%ebp)
    107c:	e8 6e fd ff ff       	call   def <put_ascii>
    1081:	83 c4 20             	add    $0x20,%esp
			xTmp += 8;
    1084:	83 45 f0 08          	addl   $0x8,-0x10(%ebp)
			i++;
    1088:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	int i = 0, xTmp;
	short wStr;
	uint rowLetterCnt;

	rowLetterCnt = strlen(str);
	for(i = 0, xTmp = x; i < rowLetterCnt;) {
    108c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    108f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1092:	72 c2                	jb     1056 <puts_str+0x34>
			put_gbk(c, wStr, colorNum, xTmp, y);
			xTmp += 16;
			i += 2;
		}
	}
}
    1094:	90                   	nop
    1095:	c9                   	leave  
    1096:	c3                   	ret    

00001097 <_RGB16BIT565>:

int _RGB16BIT565(int r,int g,int b){
    1097:	55                   	push   %ebp
    1098:	89 e5                	mov    %esp,%ebp
	return ((b / 8)+((g / 4)<<5)+((r / 8)<<11));
    109a:	8b 45 10             	mov    0x10(%ebp),%eax
    109d:	8d 50 07             	lea    0x7(%eax),%edx
    10a0:	85 c0                	test   %eax,%eax
    10a2:	0f 48 c2             	cmovs  %edx,%eax
    10a5:	c1 f8 03             	sar    $0x3,%eax
    10a8:	89 c1                	mov    %eax,%ecx
    10aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ad:	8d 50 03             	lea    0x3(%eax),%edx
    10b0:	85 c0                	test   %eax,%eax
    10b2:	0f 48 c2             	cmovs  %edx,%eax
    10b5:	c1 f8 02             	sar    $0x2,%eax
    10b8:	c1 e0 05             	shl    $0x5,%eax
    10bb:	01 c1                	add    %eax,%ecx
    10bd:	8b 45 08             	mov    0x8(%ebp),%eax
    10c0:	8d 50 07             	lea    0x7(%eax),%edx
    10c3:	85 c0                	test   %eax,%eax
    10c5:	0f 48 c2             	cmovs  %edx,%eax
    10c8:	c1 f8 03             	sar    $0x3,%eax
    10cb:	c1 e0 0b             	shl    $0xb,%eax
    10ce:	01 c8                	add    %ecx,%eax
}
    10d0:	5d                   	pop    %ebp
    10d1:	c3                   	ret    

000010d2 <draw_picture>:

void draw_picture(Context c, PICNODE pic, int x, int y)
{
    10d2:	55                   	push   %ebp
    10d3:	89 e5                	mov    %esp,%ebp
    10d5:	53                   	push   %ebx
    10d6:	83 ec 10             	sub    $0x10,%esp
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
    10d9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    10e0:	e9 9c 00 00 00       	jmp    1181 <draw_picture+0xaf>
	{
		for (j = 0; j < pic.width; j++)
    10e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    10ec:	e9 80 00 00 00       	jmp    1171 <draw_picture+0x9f>
		{
			rgb = pic.data[i*pic.width+j];
    10f1:	8b 55 14             	mov    0x14(%ebp),%edx
    10f4:	8b 45 18             	mov    0x18(%ebp),%eax
    10f7:	0f af 45 f8          	imul   -0x8(%ebp),%eax
    10fb:	89 c1                	mov    %eax,%ecx
    10fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1100:	01 c8                	add    %ecx,%eax
    1102:	c1 e0 02             	shl    $0x2,%eax
    1105:	01 d0                	add    %edx,%eax
    1107:	8b 00                	mov    (%eax),%eax
    1109:	89 45 ee             	mov    %eax,-0x12(%ebp)
			if (rgb.rgbReserved == 1) continue;
    110c:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
    1110:	3c 01                	cmp    $0x1,%al
    1112:	74 58                	je     116c <draw_picture+0x9a>
			color = (unsigned short)_RGB16BIT565(rgb.rgbRed, rgb.rgbGreen, rgb.rgbBlue);
    1114:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
    1118:	0f b6 c8             	movzbl %al,%ecx
    111b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    111f:	0f b6 d0             	movzbl %al,%edx
    1122:	0f b6 45 f0          	movzbl -0x10(%ebp),%eax
    1126:	0f b6 c0             	movzbl %al,%eax
    1129:	51                   	push   %ecx
    112a:	52                   	push   %edx
    112b:	50                   	push   %eax
    112c:	e8 66 ff ff ff       	call   1097 <_RGB16BIT565>
    1131:	83 c4 0c             	add    $0xc,%esp
    1134:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
			draw_point(c, j + x, pic.height - 1 - i + y, color);
    1138:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
    113c:	8b 55 1c             	mov    0x1c(%ebp),%edx
    113f:	83 ea 01             	sub    $0x1,%edx
    1142:	89 d1                	mov    %edx,%ecx
    1144:	2b 4d f8             	sub    -0x8(%ebp),%ecx
    1147:	8b 55 24             	mov    0x24(%ebp),%edx
    114a:	01 ca                	add    %ecx,%edx
    114c:	89 d3                	mov    %edx,%ebx
    114e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1151:	8b 55 20             	mov    0x20(%ebp),%edx
    1154:	01 ca                	add    %ecx,%edx
    1156:	50                   	push   %eax
    1157:	53                   	push   %ebx
    1158:	52                   	push   %edx
    1159:	ff 75 10             	pushl  0x10(%ebp)
    115c:	ff 75 0c             	pushl  0xc(%ebp)
    115f:	ff 75 08             	pushl  0x8(%ebp)
    1162:	e8 19 f9 ff ff       	call   a80 <draw_point>
    1167:	83 c4 18             	add    $0x18,%esp
    116a:	eb 01                	jmp    116d <draw_picture+0x9b>
	for (i = 0; i < pic.height; i++)
	{
		for (j = 0; j < pic.width; j++)
		{
			rgb = pic.data[i*pic.width+j];
			if (rgb.rgbReserved == 1) continue;
    116c:	90                   	nop
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
	{
		for (j = 0; j < pic.width; j++)
    116d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1171:	8b 45 18             	mov    0x18(%ebp),%eax
    1174:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1177:	0f 8f 74 ff ff ff    	jg     10f1 <draw_picture+0x1f>
void draw_picture(Context c, PICNODE pic, int x, int y)
{
	int i, j;
	unsigned short color;
	RGBQUAD rgb;
	for (i = 0; i < pic.height; i++)
    117d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1181:	8b 45 1c             	mov    0x1c(%ebp),%eax
    1184:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1187:	0f 8f 58 ff ff ff    	jg     10e5 <draw_picture+0x13>
			if (rgb.rgbReserved == 1) continue;
			color = (unsigned short)_RGB16BIT565(rgb.rgbRed, rgb.rgbGreen, rgb.rgbBlue);
			draw_point(c, j + x, pic.height - 1 - i + y, color);
		}
	}
}
    118d:	90                   	nop
    118e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1191:	c9                   	leave  
    1192:	c3                   	ret    

00001193 <draw_line>:

void draw_line(Context c, int x0, int y0, int x1, int y1, unsigned short color)
{
    1193:	55                   	push   %ebp
    1194:	89 e5                	mov    %esp,%ebp
    1196:	83 ec 24             	sub    $0x24,%esp
    1199:	8b 45 24             	mov    0x24(%ebp),%eax
    119c:	66 89 45 dc          	mov    %ax,-0x24(%ebp)
	int dx, dy, x, y, len, i;
	dx = x1 - x0;
    11a0:	8b 45 1c             	mov    0x1c(%ebp),%eax
    11a3:	2b 45 14             	sub    0x14(%ebp),%eax
    11a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	dy = y1 - y0;
    11a9:	8b 45 20             	mov    0x20(%ebp),%eax
    11ac:	2b 45 18             	sub    0x18(%ebp),%eax
    11af:	89 45 f8             	mov    %eax,-0x8(%ebp)
	x = x0 << 10;
    11b2:	8b 45 14             	mov    0x14(%ebp),%eax
    11b5:	c1 e0 0a             	shl    $0xa,%eax
    11b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	y = y0 << 10;
    11bb:	8b 45 18             	mov    0x18(%ebp),%eax
    11be:	c1 e0 0a             	shl    $0xa,%eax
    11c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	dx = (dx < 0) ? -dx : dx;
    11c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11c7:	c1 f8 1f             	sar    $0x1f,%eax
    11ca:	31 45 fc             	xor    %eax,-0x4(%ebp)
    11cd:	29 45 fc             	sub    %eax,-0x4(%ebp)
	dy = (dy < 0) ? -dy : dy;
    11d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11d3:	c1 f8 1f             	sar    $0x1f,%eax
    11d6:	31 45 f8             	xor    %eax,-0x8(%ebp)
    11d9:	29 45 f8             	sub    %eax,-0x8(%ebp)
	if(dx >= dy) {
    11dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11df:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    11e2:	7c 4f                	jl     1233 <draw_line+0xa0>
		len = dx + 1;
    11e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11e7:	83 c0 01             	add    $0x1,%eax
    11ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
		dx = (x1 > x0) ? 1024 : -1024;
    11ed:	8b 45 1c             	mov    0x1c(%ebp),%eax
    11f0:	3b 45 14             	cmp    0x14(%ebp),%eax
    11f3:	7e 07                	jle    11fc <draw_line+0x69>
    11f5:	b8 00 04 00 00       	mov    $0x400,%eax
    11fa:	eb 05                	jmp    1201 <draw_line+0x6e>
    11fc:	b8 00 fc ff ff       	mov    $0xfffffc00,%eax
    1201:	89 45 fc             	mov    %eax,-0x4(%ebp)
		dy = (y1 >= y0) ? (((y1 - y0 + 1) << 10) / len) : (((y1 - y0 - 1) << 10) / len);
    1204:	8b 45 20             	mov    0x20(%ebp),%eax
    1207:	3b 45 18             	cmp    0x18(%ebp),%eax
    120a:	7c 12                	jl     121e <draw_line+0x8b>
    120c:	8b 45 20             	mov    0x20(%ebp),%eax
    120f:	2b 45 18             	sub    0x18(%ebp),%eax
    1212:	83 c0 01             	add    $0x1,%eax
    1215:	c1 e0 0a             	shl    $0xa,%eax
    1218:	99                   	cltd   
    1219:	f7 7d ec             	idivl  -0x14(%ebp)
    121c:	eb 10                	jmp    122e <draw_line+0x9b>
    121e:	8b 45 20             	mov    0x20(%ebp),%eax
    1221:	2b 45 18             	sub    0x18(%ebp),%eax
    1224:	83 e8 01             	sub    $0x1,%eax
    1227:	c1 e0 0a             	shl    $0xa,%eax
    122a:	99                   	cltd   
    122b:	f7 7d ec             	idivl  -0x14(%ebp)
    122e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1231:	eb 4d                	jmp    1280 <draw_line+0xed>
	}
	else {
		len = dy + 1;
    1233:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1236:	83 c0 01             	add    $0x1,%eax
    1239:	89 45 ec             	mov    %eax,-0x14(%ebp)
		dy = (y1 > y0) ? 1024 : -1024;
    123c:	8b 45 20             	mov    0x20(%ebp),%eax
    123f:	3b 45 18             	cmp    0x18(%ebp),%eax
    1242:	7e 07                	jle    124b <draw_line+0xb8>
    1244:	b8 00 04 00 00       	mov    $0x400,%eax
    1249:	eb 05                	jmp    1250 <draw_line+0xbd>
    124b:	b8 00 fc ff ff       	mov    $0xfffffc00,%eax
    1250:	89 45 f8             	mov    %eax,-0x8(%ebp)
		dx = (x1 >= x0) ? (((x1 - x0 + 1) << 10) / len) : (((x1 - x0 - 1) << 10) / len);
    1253:	8b 45 1c             	mov    0x1c(%ebp),%eax
    1256:	3b 45 14             	cmp    0x14(%ebp),%eax
    1259:	7c 12                	jl     126d <draw_line+0xda>
    125b:	8b 45 1c             	mov    0x1c(%ebp),%eax
    125e:	2b 45 14             	sub    0x14(%ebp),%eax
    1261:	83 c0 01             	add    $0x1,%eax
    1264:	c1 e0 0a             	shl    $0xa,%eax
    1267:	99                   	cltd   
    1268:	f7 7d ec             	idivl  -0x14(%ebp)
    126b:	eb 10                	jmp    127d <draw_line+0xea>
    126d:	8b 45 1c             	mov    0x1c(%ebp),%eax
    1270:	2b 45 14             	sub    0x14(%ebp),%eax
    1273:	83 e8 01             	sub    $0x1,%eax
    1276:	c1 e0 0a             	shl    $0xa,%eax
    1279:	99                   	cltd   
    127a:	f7 7d ec             	idivl  -0x14(%ebp)
    127d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	}
	for(i = 0; i < len; i++) {
    1280:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1287:	eb 36                	jmp    12bf <draw_line+0x12c>
		//printf(0, "draw line point: x=%d, y=%d\n", (x >> 10), (y >> 10));
		draw_point(c, (x >> 10), (y >> 10), color);
    1289:	0f b7 45 dc          	movzwl -0x24(%ebp),%eax
    128d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1290:	c1 fa 0a             	sar    $0xa,%edx
    1293:	89 d1                	mov    %edx,%ecx
    1295:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1298:	c1 fa 0a             	sar    $0xa,%edx
    129b:	50                   	push   %eax
    129c:	51                   	push   %ecx
    129d:	52                   	push   %edx
    129e:	ff 75 10             	pushl  0x10(%ebp)
    12a1:	ff 75 0c             	pushl  0xc(%ebp)
    12a4:	ff 75 08             	pushl  0x8(%ebp)
    12a7:	e8 d4 f7 ff ff       	call   a80 <draw_point>
    12ac:	83 c4 18             	add    $0x18,%esp
		y += dy;
    12af:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12b2:	01 45 f0             	add    %eax,-0x10(%ebp)
		x += dx;
    12b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12b8:	01 45 f4             	add    %eax,-0xc(%ebp)
	else {
		len = dy + 1;
		dy = (y1 > y0) ? 1024 : -1024;
		dx = (x1 >= x0) ? (((x1 - x0 + 1) << 10) / len) : (((x1 - x0 - 1) << 10) / len);
	}
	for(i = 0; i < len; i++) {
    12bb:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    12bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12c2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    12c5:	7c c2                	jl     1289 <draw_line+0xf6>
		//printf(0, "draw line point: x=%d, y=%d\n", (x >> 10), (y >> 10));
		draw_point(c, (x >> 10), (y >> 10), color);
		y += dy;
		x += dx;
	}
}
    12c7:	90                   	nop
    12c8:	c9                   	leave  
    12c9:	c3                   	ret    

000012ca <draw_window>:

void
draw_window(Context c, char *title)
{
    12ca:	55                   	push   %ebp
    12cb:	89 e5                	mov    %esp,%ebp
    12cd:	83 ec 18             	sub    $0x18,%esp
  PICNODE pic;
  draw_line(c, 0, 0, c.width - 1, 0, BORDERLINE_COLOR);
    12d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    12d3:	83 e8 01             	sub    $0x1,%eax
    12d6:	6a 00                	push   $0x0
    12d8:	6a 00                	push   $0x0
    12da:	50                   	push   %eax
    12db:	6a 00                	push   $0x0
    12dd:	6a 00                	push   $0x0
    12df:	ff 75 10             	pushl  0x10(%ebp)
    12e2:	ff 75 0c             	pushl  0xc(%ebp)
    12e5:	ff 75 08             	pushl  0x8(%ebp)
    12e8:	e8 a6 fe ff ff       	call   1193 <draw_line>
    12ed:	83 c4 20             	add    $0x20,%esp
  draw_line(c, c.width - 1, 0, c.width - 1, c.height - 1, BORDERLINE_COLOR);
    12f0:	8b 45 10             	mov    0x10(%ebp),%eax
    12f3:	8d 48 ff             	lea    -0x1(%eax),%ecx
    12f6:	8b 45 0c             	mov    0xc(%ebp),%eax
    12f9:	8d 50 ff             	lea    -0x1(%eax),%edx
    12fc:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ff:	83 e8 01             	sub    $0x1,%eax
    1302:	6a 00                	push   $0x0
    1304:	51                   	push   %ecx
    1305:	52                   	push   %edx
    1306:	6a 00                	push   $0x0
    1308:	50                   	push   %eax
    1309:	ff 75 10             	pushl  0x10(%ebp)
    130c:	ff 75 0c             	pushl  0xc(%ebp)
    130f:	ff 75 08             	pushl  0x8(%ebp)
    1312:	e8 7c fe ff ff       	call   1193 <draw_line>
    1317:	83 c4 20             	add    $0x20,%esp
  draw_line(c, c.width - 1, c.height - 1, 0, c.height - 1, BORDERLINE_COLOR);
    131a:	8b 45 10             	mov    0x10(%ebp),%eax
    131d:	8d 48 ff             	lea    -0x1(%eax),%ecx
    1320:	8b 45 10             	mov    0x10(%ebp),%eax
    1323:	8d 50 ff             	lea    -0x1(%eax),%edx
    1326:	8b 45 0c             	mov    0xc(%ebp),%eax
    1329:	83 e8 01             	sub    $0x1,%eax
    132c:	6a 00                	push   $0x0
    132e:	51                   	push   %ecx
    132f:	6a 00                	push   $0x0
    1331:	52                   	push   %edx
    1332:	50                   	push   %eax
    1333:	ff 75 10             	pushl  0x10(%ebp)
    1336:	ff 75 0c             	pushl  0xc(%ebp)
    1339:	ff 75 08             	pushl  0x8(%ebp)
    133c:	e8 52 fe ff ff       	call   1193 <draw_line>
    1341:	83 c4 20             	add    $0x20,%esp
  draw_line(c, 0, c.height - 1, 0, 0, BORDERLINE_COLOR);
    1344:	8b 45 10             	mov    0x10(%ebp),%eax
    1347:	83 e8 01             	sub    $0x1,%eax
    134a:	6a 00                	push   $0x0
    134c:	6a 00                	push   $0x0
    134e:	6a 00                	push   $0x0
    1350:	50                   	push   %eax
    1351:	6a 00                	push   $0x0
    1353:	ff 75 10             	pushl  0x10(%ebp)
    1356:	ff 75 0c             	pushl  0xc(%ebp)
    1359:	ff 75 08             	pushl  0x8(%ebp)
    135c:	e8 32 fe ff ff       	call   1193 <draw_line>
    1361:	83 c4 20             	add    $0x20,%esp
  fill_rect(c, 1, 1, c.width - 2, BOTTOMBAR_HEIGHT, TOPBAR_COLOR);
    1364:	8b 45 0c             	mov    0xc(%ebp),%eax
    1367:	83 e8 02             	sub    $0x2,%eax
    136a:	68 cb 5a 00 00       	push   $0x5acb
    136f:	6a 14                	push   $0x14
    1371:	50                   	push   %eax
    1372:	6a 01                	push   $0x1
    1374:	6a 01                	push   $0x1
    1376:	ff 75 10             	pushl  0x10(%ebp)
    1379:	ff 75 0c             	pushl  0xc(%ebp)
    137c:	ff 75 08             	pushl  0x8(%ebp)
    137f:	e8 3d f7 ff ff       	call   ac1 <fill_rect>
    1384:	83 c4 20             	add    $0x20,%esp
  fill_rect(c, 1, c.height - 1 - BOTTOMBAR_HEIGHT, c.width - 2, BOTTOMBAR_HEIGHT, BOTTOMBAR_COLOR);
    1387:	8b 45 0c             	mov    0xc(%ebp),%eax
    138a:	83 e8 02             	sub    $0x2,%eax
    138d:	89 c2                	mov    %eax,%edx
    138f:	8b 45 10             	mov    0x10(%ebp),%eax
    1392:	83 e8 15             	sub    $0x15,%eax
    1395:	68 cb 5a 00 00       	push   $0x5acb
    139a:	6a 14                	push   $0x14
    139c:	52                   	push   %edx
    139d:	50                   	push   %eax
    139e:	6a 01                	push   $0x1
    13a0:	ff 75 10             	pushl  0x10(%ebp)
    13a3:	ff 75 0c             	pushl  0xc(%ebp)
    13a6:	ff 75 08             	pushl  0x8(%ebp)
    13a9:	e8 13 f7 ff ff       	call   ac1 <fill_rect>
    13ae:	83 c4 20             	add    $0x20,%esp

  loadBitmap(&pic, "close.bmp");
    13b1:	83 ec 08             	sub    $0x8,%esp
    13b4:	68 7c 8d 00 00       	push   $0x8d7c
    13b9:	8d 45 ec             	lea    -0x14(%ebp),%eax
    13bc:	50                   	push   %eax
    13bd:	e8 fe 00 00 00       	call   14c0 <loadBitmap>
    13c2:	83 c4 10             	add    $0x10,%esp
  draw_picture(c, pic, 3, 3);
    13c5:	6a 03                	push   $0x3
    13c7:	6a 03                	push   $0x3
    13c9:	ff 75 f4             	pushl  -0xc(%ebp)
    13cc:	ff 75 f0             	pushl  -0x10(%ebp)
    13cf:	ff 75 ec             	pushl  -0x14(%ebp)
    13d2:	ff 75 10             	pushl  0x10(%ebp)
    13d5:	ff 75 0c             	pushl  0xc(%ebp)
    13d8:	ff 75 08             	pushl  0x8(%ebp)
    13db:	e8 f2 fc ff ff       	call   10d2 <draw_picture>
    13e0:	83 c4 20             	add    $0x20,%esp
  puts_str(c, title, TITLE_COLOR, TITLE_OFFSET_X, TITLE_OFFSET_Y);
    13e3:	83 ec 04             	sub    $0x4,%esp
    13e6:	6a 02                	push   $0x2
    13e8:	6a 19                	push   $0x19
    13ea:	68 ff ff 00 00       	push   $0xffff
    13ef:	ff 75 14             	pushl  0x14(%ebp)
    13f2:	ff 75 10             	pushl  0x10(%ebp)
    13f5:	ff 75 0c             	pushl  0xc(%ebp)
    13f8:	ff 75 08             	pushl  0x8(%ebp)
    13fb:	e8 22 fc ff ff       	call   1022 <puts_str>
    1400:	83 c4 20             	add    $0x20,%esp
  freepic(&pic);
    1403:	83 ec 0c             	sub    $0xc,%esp
    1406:	8d 45 ec             	lea    -0x14(%ebp),%eax
    1409:	50                   	push   %eax
    140a:	e8 d3 05 00 00       	call   19e2 <freepic>
    140f:	83 c4 10             	add    $0x10,%esp
}
    1412:	90                   	nop
    1413:	c9                   	leave  
    1414:	c3                   	ret    

00001415 <load_iconlist>:

void load_iconlist(ICON* iconlist, int len)
{
    1415:	55                   	push   %ebp
    1416:	89 e5                	mov    %esp,%ebp
    1418:	83 ec 18             	sub    $0x18,%esp
	int i;
	for (i = 0; i < len; i++)
    141b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1422:	eb 2c                	jmp    1450 <load_iconlist+0x3b>
	{
	    loadBitmap(&(iconlist[i].pic), iconlist[i].name);
    1424:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1427:	6b d0 34             	imul   $0x34,%eax,%edx
    142a:	8b 45 08             	mov    0x8(%ebp),%eax
    142d:	01 d0                	add    %edx,%eax
    142f:	89 c1                	mov    %eax,%ecx
    1431:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1434:	6b d0 34             	imul   $0x34,%eax,%edx
    1437:	8b 45 08             	mov    0x8(%ebp),%eax
    143a:	01 d0                	add    %edx,%eax
    143c:	83 c0 28             	add    $0x28,%eax
    143f:	83 ec 08             	sub    $0x8,%esp
    1442:	51                   	push   %ecx
    1443:	50                   	push   %eax
    1444:	e8 77 00 00 00       	call   14c0 <loadBitmap>
    1449:	83 c4 10             	add    $0x10,%esp
}

void load_iconlist(ICON* iconlist, int len)
{
	int i;
	for (i = 0; i < len; i++)
    144c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1450:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1453:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1456:	7c cc                	jl     1424 <load_iconlist+0xf>
	{
	    loadBitmap(&(iconlist[i].pic), iconlist[i].name);
	}
}
    1458:	90                   	nop
    1459:	c9                   	leave  
    145a:	c3                   	ret    

0000145b <draw_iconlist>:
void draw_iconlist(Context c, ICON* iconlist, int len)
{
    145b:	55                   	push   %ebp
    145c:	89 e5                	mov    %esp,%ebp
    145e:	53                   	push   %ebx
    145f:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; i < len; i++)
    1462:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    1469:	eb 47                	jmp    14b2 <draw_iconlist+0x57>
    {
        draw_picture(c, iconlist[i].pic, iconlist[i].position_x, iconlist[i].position_y);
    146b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    146e:	6b d0 34             	imul   $0x34,%eax,%edx
    1471:	8b 45 14             	mov    0x14(%ebp),%eax
    1474:	01 d0                	add    %edx,%eax
    1476:	8b 48 24             	mov    0x24(%eax),%ecx
    1479:	8b 45 f8             	mov    -0x8(%ebp),%eax
    147c:	6b d0 34             	imul   $0x34,%eax,%edx
    147f:	8b 45 14             	mov    0x14(%ebp),%eax
    1482:	01 d0                	add    %edx,%eax
    1484:	8b 50 20             	mov    0x20(%eax),%edx
    1487:	8b 45 f8             	mov    -0x8(%ebp),%eax
    148a:	6b d8 34             	imul   $0x34,%eax,%ebx
    148d:	8b 45 14             	mov    0x14(%ebp),%eax
    1490:	01 d8                	add    %ebx,%eax
    1492:	51                   	push   %ecx
    1493:	52                   	push   %edx
    1494:	ff 70 30             	pushl  0x30(%eax)
    1497:	ff 70 2c             	pushl  0x2c(%eax)
    149a:	ff 70 28             	pushl  0x28(%eax)
    149d:	ff 75 10             	pushl  0x10(%ebp)
    14a0:	ff 75 0c             	pushl  0xc(%ebp)
    14a3:	ff 75 08             	pushl  0x8(%ebp)
    14a6:	e8 27 fc ff ff       	call   10d2 <draw_picture>
    14ab:	83 c4 20             	add    $0x20,%esp
	}
}
void draw_iconlist(Context c, ICON* iconlist, int len)
{
    int i;
    for (i = 0; i < len; i++)
    14ae:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    14b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    14b5:	3b 45 18             	cmp    0x18(%ebp),%eax
    14b8:	7c b1                	jl     146b <draw_iconlist+0x10>
    {
        draw_picture(c, iconlist[i].pic, iconlist[i].position_x, iconlist[i].position_y);
    }
}
    14ba:	90                   	nop
    14bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    14be:	c9                   	leave  
    14bf:	c3                   	ret    

000014c0 <loadBitmap>:
#include "clickable.h"

void showRgbQuan(RGBQUAD* pRGB);
void showBmpHead(BITMAPFILEHEADER* pBmpHead);
void showBmpInforHead(BITMAPINFOHEADER* pBmpInforHead);
void loadBitmap(PICNODE *pic, char pic_name[]) {
    14c0:	55                   	push   %ebp
    14c1:	89 e5                	mov    %esp,%ebp
    14c3:	81 ec 88 00 00 00    	sub    $0x88,%esp
	BITMAPFILEHEADER bitHead;
	BITMAPINFOHEADER bitInfoHead;
	char *BmpFileHeader;
	WORD *temp_WORD;
	DWORD *temp_DWORD;
	int fd, n, i, j, k, index = 0;
    14c9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int width;
	int height;

	if ((fd = open(pic_name, 0)) < 0) {
    14d0:	83 ec 08             	sub    $0x8,%esp
    14d3:	6a 00                	push   $0x0
    14d5:	ff 75 0c             	pushl  0xc(%ebp)
    14d8:	e8 76 0f 00 00       	call   2453 <open>
    14dd:	83 c4 10             	add    $0x10,%esp
    14e0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    14e3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    14e7:	79 1a                	jns    1503 <loadBitmap+0x43>
		printf(0, "cannot open %s\n", pic_name);
    14e9:	83 ec 04             	sub    $0x4,%esp
    14ec:	ff 75 0c             	pushl  0xc(%ebp)
    14ef:	68 88 8d 00 00       	push   $0x8d88
    14f4:	6a 00                	push   $0x0
    14f6:	e8 f7 10 00 00       	call   25f2 <printf>
    14fb:	83 c4 10             	add    $0x10,%esp
		return;
    14fe:	e9 ca 02 00 00       	jmp    17cd <loadBitmap+0x30d>
	}
	printf(0, "reading bitmap: %s\n", pic_name);
    1503:	83 ec 04             	sub    $0x4,%esp
    1506:	ff 75 0c             	pushl  0xc(%ebp)
    1509:	68 98 8d 00 00       	push   $0x8d98
    150e:	6a 00                	push   $0x0
    1510:	e8 dd 10 00 00       	call   25f2 <printf>
    1515:	83 c4 10             	add    $0x10,%esp
	//pfile = fopen(strFile,"rb");//打开文件
	BmpFileHeader = (char *) malloc(14 * sizeof(char));
    1518:	83 ec 0c             	sub    $0xc,%esp
    151b:	6a 0e                	push   $0xe
    151d:	e8 a3 13 00 00       	call   28c5 <malloc>
    1522:	83 c4 10             	add    $0x10,%esp
    1525:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//printf(0, "file bmp open success.\n");
	//读取位图文件头信息
	//printf(0, "reading BmpFileHeader.\n");
	n = read(fd, BmpFileHeader, 14);
    1528:	83 ec 04             	sub    $0x4,%esp
    152b:	6a 0e                	push   $0xe
    152d:	ff 75 e4             	pushl  -0x1c(%ebp)
    1530:	ff 75 e8             	pushl  -0x18(%ebp)
    1533:	e8 f3 0e 00 00       	call   242b <read>
    1538:	83 c4 10             	add    $0x10,%esp
    153b:	89 45 e0             	mov    %eax,-0x20(%ebp)
	//fread(BmpFileHeader,1,14,pfile);
	temp_WORD = (WORD*) (BmpFileHeader);
    153e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1541:	89 45 dc             	mov    %eax,-0x24(%ebp)
	bitHead.bfType = *temp_WORD;
    1544:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1547:	0f b7 00             	movzwl (%eax),%eax
    154a:	66 89 45 ac          	mov    %ax,-0x54(%ebp)
	if (bitHead.bfType != 0x4d42) {
    154e:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    1552:	66 3d 42 4d          	cmp    $0x4d42,%ax
    1556:	74 17                	je     156f <loadBitmap+0xaf>
		printf(0, "file is not .bmp file!");
    1558:	83 ec 08             	sub    $0x8,%esp
    155b:	68 ac 8d 00 00       	push   $0x8dac
    1560:	6a 00                	push   $0x0
    1562:	e8 8b 10 00 00       	call   25f2 <printf>
    1567:	83 c4 10             	add    $0x10,%esp
		return;
    156a:	e9 5e 02 00 00       	jmp    17cd <loadBitmap+0x30d>
	}
	temp_DWORD = (DWORD *) (BmpFileHeader + sizeof(bitHead.bfType));
    156f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1572:	83 c0 02             	add    $0x2,%eax
    1575:	89 45 d8             	mov    %eax,-0x28(%ebp)
	bitHead.bfSize = *temp_DWORD;
    1578:	8b 45 d8             	mov    -0x28(%ebp),%eax
    157b:	8b 00                	mov    (%eax),%eax
    157d:	89 45 b0             	mov    %eax,-0x50(%ebp)
	temp_WORD = (WORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    1580:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1583:	83 c0 06             	add    $0x6,%eax
    1586:	89 45 dc             	mov    %eax,-0x24(%ebp)
			+ sizeof(bitHead.bfSize));
	bitHead.bfReserved1 = *temp_WORD;
    1589:	8b 45 dc             	mov    -0x24(%ebp),%eax
    158c:	0f b7 00             	movzwl (%eax),%eax
    158f:	66 89 45 b4          	mov    %ax,-0x4c(%ebp)
	temp_WORD = (WORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    1593:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1596:	83 c0 08             	add    $0x8,%eax
    1599:	89 45 dc             	mov    %eax,-0x24(%ebp)
			+ sizeof(bitHead.bfSize) + sizeof(bitHead.bfReserved1));
	bitHead.bfReserved2 = *temp_WORD;
    159c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    159f:	0f b7 00             	movzwl (%eax),%eax
    15a2:	66 89 45 b6          	mov    %ax,-0x4a(%ebp)
	temp_DWORD = (DWORD*) (BmpFileHeader + sizeof(bitHead.bfType)
    15a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15a9:	83 c0 0a             	add    $0xa,%eax
    15ac:	89 45 d8             	mov    %eax,-0x28(%ebp)
			+ sizeof(bitHead.bfSize) + sizeof(bitHead.bfReserved1)
			+ sizeof(bitHead.bfReserved2));
	bitHead.bfOffBits = *temp_DWORD;
    15af:	8b 45 d8             	mov    -0x28(%ebp),%eax
    15b2:	8b 00                	mov    (%eax),%eax
    15b4:	89 45 b8             	mov    %eax,-0x48(%ebp)
	//printf(0, "reading BmpFileHeader success!\n");
	//showBmpHead(&bitHead);
	//printf(0, "\n\n");
//
//	//读取位图信息头信息
	read(fd, &bitInfoHead, sizeof(BITMAPINFOHEADER));
    15b7:	83 ec 04             	sub    $0x4,%esp
    15ba:	6a 28                	push   $0x28
    15bc:	8d 45 84             	lea    -0x7c(%ebp),%eax
    15bf:	50                   	push   %eax
    15c0:	ff 75 e8             	pushl  -0x18(%ebp)
    15c3:	e8 63 0e 00 00       	call   242b <read>
    15c8:	83 c4 10             	add    $0x10,%esp
	width = bitInfoHead.biWidth;
    15cb:	8b 45 88             	mov    -0x78(%ebp),%eax
    15ce:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	height = bitInfoHead.biHeight;
    15d1:	8b 45 8c             	mov    -0x74(%ebp),%eax
    15d4:	89 45 d0             	mov    %eax,-0x30(%ebp)
	printf(0, "bmp width: %d, height: %d, size: %d\n", width, height,
			width * height * sizeof(RGBQUAD));
    15d7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    15da:	0f af 45 d0          	imul   -0x30(%ebp),%eax
//
//	//读取位图信息头信息
	read(fd, &bitInfoHead, sizeof(BITMAPINFOHEADER));
	width = bitInfoHead.biWidth;
	height = bitInfoHead.biHeight;
	printf(0, "bmp width: %d, height: %d, size: %d\n", width, height,
    15de:	c1 e0 02             	shl    $0x2,%eax
    15e1:	83 ec 0c             	sub    $0xc,%esp
    15e4:	50                   	push   %eax
    15e5:	ff 75 d0             	pushl  -0x30(%ebp)
    15e8:	ff 75 d4             	pushl  -0x2c(%ebp)
    15eb:	68 c4 8d 00 00       	push   $0x8dc4
    15f0:	6a 00                	push   $0x0
    15f2:	e8 fb 0f 00 00       	call   25f2 <printf>
    15f7:	83 c4 20             	add    $0x20,%esp
			width * height * sizeof(RGBQUAD));
	//fread(&bitInfoHead,1,sizeof(BITMAPINFOHEADER),pfile);
	//showBmpInforHead(&bitInfoHead);
	//printf(0, "\n");
	if (n == 0) {
    15fa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    15fe:	75 12                	jne    1612 <loadBitmap+0x152>
		printf(0, "0");
    1600:	83 ec 08             	sub    $0x8,%esp
    1603:	68 e9 8d 00 00       	push   $0x8de9
    1608:	6a 00                	push   $0x0
    160a:	e8 e3 0f 00 00       	call   25f2 <printf>
    160f:	83 c4 10             	add    $0x10,%esp
	}

	//分配内存空间把源图存入内存
	int l_width = WIDTHBYTES(width * bitInfoHead.biBitCount);//计算位图的实际宽度并确保它为32的倍数
    1612:	0f b7 45 92          	movzwl -0x6e(%ebp),%eax
    1616:	0f b7 c0             	movzwl %ax,%eax
    1619:	0f af 45 d4          	imul   -0x2c(%ebp),%eax
    161d:	83 c0 1f             	add    $0x1f,%eax
    1620:	8d 50 1f             	lea    0x1f(%eax),%edx
    1623:	85 c0                	test   %eax,%eax
    1625:	0f 48 c2             	cmovs  %edx,%eax
    1628:	c1 f8 05             	sar    $0x5,%eax
    162b:	c1 e0 02             	shl    $0x2,%eax
    162e:	89 45 cc             	mov    %eax,-0x34(%ebp)
	BYTE *pColorData = (BYTE *) malloc(height * l_width);
    1631:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1634:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    1638:	83 ec 0c             	sub    $0xc,%esp
    163b:	50                   	push   %eax
    163c:	e8 84 12 00 00       	call   28c5 <malloc>
    1641:	83 c4 10             	add    $0x10,%esp
    1644:	89 45 c8             	mov    %eax,-0x38(%ebp)
	memset(pColorData, 0, (uint) height * l_width);
    1647:	8b 55 d0             	mov    -0x30(%ebp),%edx
    164a:	8b 45 cc             	mov    -0x34(%ebp),%eax
    164d:	0f af c2             	imul   %edx,%eax
    1650:	83 ec 04             	sub    $0x4,%esp
    1653:	50                   	push   %eax
    1654:	6a 00                	push   $0x0
    1656:	ff 75 c8             	pushl  -0x38(%ebp)
    1659:	e8 1a 0c 00 00       	call   2278 <memset>
    165e:	83 c4 10             	add    $0x10,%esp
	long nData = height * l_width;
    1661:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1664:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    1668:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	//把位图数据信息读到数组里
	read(fd, pColorData, nData);
    166b:	83 ec 04             	sub    $0x4,%esp
    166e:	ff 75 c4             	pushl  -0x3c(%ebp)
    1671:	ff 75 c8             	pushl  -0x38(%ebp)
    1674:	ff 75 e8             	pushl  -0x18(%ebp)
    1677:	e8 af 0d 00 00       	call   242b <read>
    167c:	83 c4 10             	add    $0x10,%esp

	//printf(0, "reading bmp data.\n");
	//将位图数据转化为RGB数据
	RGBQUAD* dataOfBmp;

	dataOfBmp = (RGBQUAD *) malloc(width * height * sizeof(RGBQUAD));//用于保存各像素对应的RGB数据
    167f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1682:	0f af 45 d0          	imul   -0x30(%ebp),%eax
    1686:	c1 e0 02             	shl    $0x2,%eax
    1689:	83 ec 0c             	sub    $0xc,%esp
    168c:	50                   	push   %eax
    168d:	e8 33 12 00 00       	call   28c5 <malloc>
    1692:	83 c4 10             	add    $0x10,%esp
    1695:	89 45 c0             	mov    %eax,-0x40(%ebp)
	memset(dataOfBmp, 0, (uint) width * height * sizeof(RGBQUAD));
    1698:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    169b:	8b 45 d0             	mov    -0x30(%ebp),%eax
    169e:	0f af c2             	imul   %edx,%eax
    16a1:	c1 e0 02             	shl    $0x2,%eax
    16a4:	83 ec 04             	sub    $0x4,%esp
    16a7:	50                   	push   %eax
    16a8:	6a 00                	push   $0x0
    16aa:	ff 75 c0             	pushl  -0x40(%ebp)
    16ad:	e8 c6 0b 00 00       	call   2278 <memset>
    16b2:	83 c4 10             	add    $0x10,%esp
	if (bitInfoHead.biBitCount < 24)	//有调色板，即位图为非真彩色
    16b5:	0f b7 45 92          	movzwl -0x6e(%ebp),%eax
    16b9:	66 83 f8 17          	cmp    $0x17,%ax
    16bd:	77 17                	ja     16d6 <loadBitmap+0x216>
			{
		printf(0, "%s is not a 24 bit bmp! return.");
    16bf:	83 ec 08             	sub    $0x8,%esp
    16c2:	68 ec 8d 00 00       	push   $0x8dec
    16c7:	6a 00                	push   $0x0
    16c9:	e8 24 0f 00 00       	call   25f2 <printf>
    16ce:	83 c4 10             	add    $0x10,%esp
		return;
    16d1:	e9 f7 00 00 00       	jmp    17cd <loadBitmap+0x30d>
	} else	//位图为24位真彩色
	{
		index = 0;
    16d6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (i = 0; i < height; i++)
    16dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    16e4:	e9 94 00 00 00       	jmp    177d <loadBitmap+0x2bd>
			for (j = 0; j < width; j++) {
    16e9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    16f0:	eb 7b                	jmp    176d <loadBitmap+0x2ad>
				k = i * l_width + j * 3;
    16f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16f5:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    16f9:	89 c1                	mov    %eax,%ecx
    16fb:	8b 55 f0             	mov    -0x10(%ebp),%edx
    16fe:	89 d0                	mov    %edx,%eax
    1700:	01 c0                	add    %eax,%eax
    1702:	01 d0                	add    %edx,%eax
    1704:	01 c8                	add    %ecx,%eax
    1706:	89 45 bc             	mov    %eax,-0x44(%ebp)
				dataOfBmp[index].rgbRed = pColorData[k + 2];
    1709:	8b 45 ec             	mov    -0x14(%ebp),%eax
    170c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1713:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1716:	01 c2                	add    %eax,%edx
    1718:	8b 45 bc             	mov    -0x44(%ebp),%eax
    171b:	8d 48 02             	lea    0x2(%eax),%ecx
    171e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1721:	01 c8                	add    %ecx,%eax
    1723:	0f b6 00             	movzbl (%eax),%eax
    1726:	88 42 02             	mov    %al,0x2(%edx)
				dataOfBmp[index].rgbGreen = pColorData[k + 1];
    1729:	8b 45 ec             	mov    -0x14(%ebp),%eax
    172c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1733:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1736:	01 c2                	add    %eax,%edx
    1738:	8b 45 bc             	mov    -0x44(%ebp),%eax
    173b:	8d 48 01             	lea    0x1(%eax),%ecx
    173e:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1741:	01 c8                	add    %ecx,%eax
    1743:	0f b6 00             	movzbl (%eax),%eax
    1746:	88 42 01             	mov    %al,0x1(%edx)
				dataOfBmp[index].rgbBlue = pColorData[k];
    1749:	8b 45 ec             	mov    -0x14(%ebp),%eax
    174c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    1753:	8b 45 c0             	mov    -0x40(%ebp),%eax
    1756:	01 c2                	add    %eax,%edx
    1758:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    175b:	8b 45 c8             	mov    -0x38(%ebp),%eax
    175e:	01 c8                	add    %ecx,%eax
    1760:	0f b6 00             	movzbl (%eax),%eax
    1763:	88 02                	mov    %al,(%edx)
				index++;
    1765:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
		return;
	} else	//位图为24位真彩色
	{
		index = 0;
		for (i = 0; i < height; i++)
			for (j = 0; j < width; j++) {
    1769:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    176d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1770:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
    1773:	0f 8c 79 ff ff ff    	jl     16f2 <loadBitmap+0x232>
		printf(0, "%s is not a 24 bit bmp! return.");
		return;
	} else	//位图为24位真彩色
	{
		index = 0;
		for (i = 0; i < height; i++)
    1779:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    177d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1780:	3b 45 d0             	cmp    -0x30(%ebp),%eax
    1783:	0f 8c 60 ff ff ff    	jl     16e9 <loadBitmap+0x229>
//			printf(0, "\n");
//		}
//		showRgbQuan(&dataOfBmp[i]);
//	}

	close(fd);
    1789:	83 ec 0c             	sub    $0xc,%esp
    178c:	ff 75 e8             	pushl  -0x18(%ebp)
    178f:	e8 a7 0c 00 00       	call   243b <close>
    1794:	83 c4 10             	add    $0x10,%esp

	//free(dataOfBmp);
	pic->data = dataOfBmp;
    1797:	8b 45 08             	mov    0x8(%ebp),%eax
    179a:	8b 55 c0             	mov    -0x40(%ebp),%edx
    179d:	89 10                	mov    %edx,(%eax)
	pic->width = width;
    179f:	8b 45 08             	mov    0x8(%ebp),%eax
    17a2:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    17a5:	89 50 04             	mov    %edx,0x4(%eax)
	pic->height = height;
    17a8:	8b 45 08             	mov    0x8(%ebp),%eax
    17ab:	8b 55 d0             	mov    -0x30(%ebp),%edx
    17ae:	89 50 08             	mov    %edx,0x8(%eax)
	free(pColorData);
    17b1:	83 ec 0c             	sub    $0xc,%esp
    17b4:	ff 75 c8             	pushl  -0x38(%ebp)
    17b7:	e8 c7 0f 00 00       	call   2783 <free>
    17bc:	83 c4 10             	add    $0x10,%esp
	free(BmpFileHeader);
    17bf:	83 ec 0c             	sub    $0xc,%esp
    17c2:	ff 75 e4             	pushl  -0x1c(%ebp)
    17c5:	e8 b9 0f 00 00       	call   2783 <free>
    17ca:	83 c4 10             	add    $0x10,%esp
	//printf("\n");
}
    17cd:	c9                   	leave  
    17ce:	c3                   	ret    

000017cf <showBmpHead>:

void showBmpHead(BITMAPFILEHEADER* pBmpHead) {
    17cf:	55                   	push   %ebp
    17d0:	89 e5                	mov    %esp,%ebp
    17d2:	83 ec 08             	sub    $0x8,%esp
	printf(0, "位图文件头:\n");
    17d5:	83 ec 08             	sub    $0x8,%esp
    17d8:	68 0c 8e 00 00       	push   $0x8e0c
    17dd:	6a 00                	push   $0x0
    17df:	e8 0e 0e 00 00       	call   25f2 <printf>
    17e4:	83 c4 10             	add    $0x10,%esp
	printf(0, "bmp格式标志bftype：0x%x\n", pBmpHead->bfType);
    17e7:	8b 45 08             	mov    0x8(%ebp),%eax
    17ea:	0f b7 00             	movzwl (%eax),%eax
    17ed:	0f b7 c0             	movzwl %ax,%eax
    17f0:	83 ec 04             	sub    $0x4,%esp
    17f3:	50                   	push   %eax
    17f4:	68 1e 8e 00 00       	push   $0x8e1e
    17f9:	6a 00                	push   $0x0
    17fb:	e8 f2 0d 00 00       	call   25f2 <printf>
    1800:	83 c4 10             	add    $0x10,%esp
	printf(0, "文件大小:%d\n", pBmpHead->bfSize);
    1803:	8b 45 08             	mov    0x8(%ebp),%eax
    1806:	8b 40 04             	mov    0x4(%eax),%eax
    1809:	83 ec 04             	sub    $0x4,%esp
    180c:	50                   	push   %eax
    180d:	68 3c 8e 00 00       	push   $0x8e3c
    1812:	6a 00                	push   $0x0
    1814:	e8 d9 0d 00 00       	call   25f2 <printf>
    1819:	83 c4 10             	add    $0x10,%esp
	printf(0, "保留字:%d\n", pBmpHead->bfReserved1);
    181c:	8b 45 08             	mov    0x8(%ebp),%eax
    181f:	0f b7 40 08          	movzwl 0x8(%eax),%eax
    1823:	0f b7 c0             	movzwl %ax,%eax
    1826:	83 ec 04             	sub    $0x4,%esp
    1829:	50                   	push   %eax
    182a:	68 4d 8e 00 00       	push   $0x8e4d
    182f:	6a 00                	push   $0x0
    1831:	e8 bc 0d 00 00       	call   25f2 <printf>
    1836:	83 c4 10             	add    $0x10,%esp
	printf(0, "保留字:%d\n", pBmpHead->bfReserved2);
    1839:	8b 45 08             	mov    0x8(%ebp),%eax
    183c:	0f b7 40 0a          	movzwl 0xa(%eax),%eax
    1840:	0f b7 c0             	movzwl %ax,%eax
    1843:	83 ec 04             	sub    $0x4,%esp
    1846:	50                   	push   %eax
    1847:	68 4d 8e 00 00       	push   $0x8e4d
    184c:	6a 00                	push   $0x0
    184e:	e8 9f 0d 00 00       	call   25f2 <printf>
    1853:	83 c4 10             	add    $0x10,%esp
	printf(0, "实际位图数据的偏移字节数:%d\n", pBmpHead->bfOffBits);
    1856:	8b 45 08             	mov    0x8(%ebp),%eax
    1859:	8b 40 0c             	mov    0xc(%eax),%eax
    185c:	83 ec 04             	sub    $0x4,%esp
    185f:	50                   	push   %eax
    1860:	68 5c 8e 00 00       	push   $0x8e5c
    1865:	6a 00                	push   $0x0
    1867:	e8 86 0d 00 00       	call   25f2 <printf>
    186c:	83 c4 10             	add    $0x10,%esp
}
    186f:	90                   	nop
    1870:	c9                   	leave  
    1871:	c3                   	ret    

00001872 <showBmpInforHead>:

void showBmpInforHead(BITMAPINFOHEADER* pBmpInforHead) {
    1872:	55                   	push   %ebp
    1873:	89 e5                	mov    %esp,%ebp
    1875:	83 ec 08             	sub    $0x8,%esp
	printf(0, "位图信息头:\n");
    1878:	83 ec 08             	sub    $0x8,%esp
    187b:	68 85 8e 00 00       	push   $0x8e85
    1880:	6a 00                	push   $0x0
    1882:	e8 6b 0d 00 00       	call   25f2 <printf>
    1887:	83 c4 10             	add    $0x10,%esp
	printf(0, "结构体的长度:%d\n", pBmpInforHead->biSize);
    188a:	8b 45 08             	mov    0x8(%ebp),%eax
    188d:	8b 00                	mov    (%eax),%eax
    188f:	83 ec 04             	sub    $0x4,%esp
    1892:	50                   	push   %eax
    1893:	68 97 8e 00 00       	push   $0x8e97
    1898:	6a 00                	push   $0x0
    189a:	e8 53 0d 00 00       	call   25f2 <printf>
    189f:	83 c4 10             	add    $0x10,%esp
	printf(0, "位图宽:%d\n", pBmpInforHead->biWidth);
    18a2:	8b 45 08             	mov    0x8(%ebp),%eax
    18a5:	8b 40 04             	mov    0x4(%eax),%eax
    18a8:	83 ec 04             	sub    $0x4,%esp
    18ab:	50                   	push   %eax
    18ac:	68 ae 8e 00 00       	push   $0x8eae
    18b1:	6a 00                	push   $0x0
    18b3:	e8 3a 0d 00 00       	call   25f2 <printf>
    18b8:	83 c4 10             	add    $0x10,%esp
	printf(0, "位图高:%d\n", pBmpInforHead->biHeight);
    18bb:	8b 45 08             	mov    0x8(%ebp),%eax
    18be:	8b 40 08             	mov    0x8(%eax),%eax
    18c1:	83 ec 04             	sub    $0x4,%esp
    18c4:	50                   	push   %eax
    18c5:	68 bc 8e 00 00       	push   $0x8ebc
    18ca:	6a 00                	push   $0x0
    18cc:	e8 21 0d 00 00       	call   25f2 <printf>
    18d1:	83 c4 10             	add    $0x10,%esp
	printf(0, "biPlanes平面数:%d\n", pBmpInforHead->biPlanes);
    18d4:	8b 45 08             	mov    0x8(%ebp),%eax
    18d7:	0f b7 40 0c          	movzwl 0xc(%eax),%eax
    18db:	0f b7 c0             	movzwl %ax,%eax
    18de:	83 ec 04             	sub    $0x4,%esp
    18e1:	50                   	push   %eax
    18e2:	68 ca 8e 00 00       	push   $0x8eca
    18e7:	6a 00                	push   $0x0
    18e9:	e8 04 0d 00 00       	call   25f2 <printf>
    18ee:	83 c4 10             	add    $0x10,%esp
	printf(0, "biBitCount采用颜色位数:%d\n", pBmpInforHead->biBitCount);
    18f1:	8b 45 08             	mov    0x8(%ebp),%eax
    18f4:	0f b7 40 0e          	movzwl 0xe(%eax),%eax
    18f8:	0f b7 c0             	movzwl %ax,%eax
    18fb:	83 ec 04             	sub    $0x4,%esp
    18fe:	50                   	push   %eax
    18ff:	68 e0 8e 00 00       	push   $0x8ee0
    1904:	6a 00                	push   $0x0
    1906:	e8 e7 0c 00 00       	call   25f2 <printf>
    190b:	83 c4 10             	add    $0x10,%esp
	printf(0, "压缩方式:%d\n", pBmpInforHead->biCompression);
    190e:	8b 45 08             	mov    0x8(%ebp),%eax
    1911:	8b 40 10             	mov    0x10(%eax),%eax
    1914:	83 ec 04             	sub    $0x4,%esp
    1917:	50                   	push   %eax
    1918:	68 01 8f 00 00       	push   $0x8f01
    191d:	6a 00                	push   $0x0
    191f:	e8 ce 0c 00 00       	call   25f2 <printf>
    1924:	83 c4 10             	add    $0x10,%esp
	printf(0, "biSizeImage实际位图数据占用的字节数:%d\n", pBmpInforHead->biSizeImage);
    1927:	8b 45 08             	mov    0x8(%ebp),%eax
    192a:	8b 40 14             	mov    0x14(%eax),%eax
    192d:	83 ec 04             	sub    $0x4,%esp
    1930:	50                   	push   %eax
    1931:	68 14 8f 00 00       	push   $0x8f14
    1936:	6a 00                	push   $0x0
    1938:	e8 b5 0c 00 00       	call   25f2 <printf>
    193d:	83 c4 10             	add    $0x10,%esp
	printf(0, "X方向分辨率:%d\n", pBmpInforHead->biXPelsPerMeter);
    1940:	8b 45 08             	mov    0x8(%ebp),%eax
    1943:	8b 40 18             	mov    0x18(%eax),%eax
    1946:	83 ec 04             	sub    $0x4,%esp
    1949:	50                   	push   %eax
    194a:	68 48 8f 00 00       	push   $0x8f48
    194f:	6a 00                	push   $0x0
    1951:	e8 9c 0c 00 00       	call   25f2 <printf>
    1956:	83 c4 10             	add    $0x10,%esp
	printf(0, "Y方向分辨率:%d\n", pBmpInforHead->biYPelsPerMeter);
    1959:	8b 45 08             	mov    0x8(%ebp),%eax
    195c:	8b 40 1c             	mov    0x1c(%eax),%eax
    195f:	83 ec 04             	sub    $0x4,%esp
    1962:	50                   	push   %eax
    1963:	68 5d 8f 00 00       	push   $0x8f5d
    1968:	6a 00                	push   $0x0
    196a:	e8 83 0c 00 00       	call   25f2 <printf>
    196f:	83 c4 10             	add    $0x10,%esp
	printf(0, "使用的颜色数:%d\n", pBmpInforHead->biClrUsed);
    1972:	8b 45 08             	mov    0x8(%ebp),%eax
    1975:	8b 40 20             	mov    0x20(%eax),%eax
    1978:	83 ec 04             	sub    $0x4,%esp
    197b:	50                   	push   %eax
    197c:	68 72 8f 00 00       	push   $0x8f72
    1981:	6a 00                	push   $0x0
    1983:	e8 6a 0c 00 00       	call   25f2 <printf>
    1988:	83 c4 10             	add    $0x10,%esp
	printf(0, "重要颜色数:%d\n", pBmpInforHead->biClrImportant);
    198b:	8b 45 08             	mov    0x8(%ebp),%eax
    198e:	8b 40 24             	mov    0x24(%eax),%eax
    1991:	83 ec 04             	sub    $0x4,%esp
    1994:	50                   	push   %eax
    1995:	68 89 8f 00 00       	push   $0x8f89
    199a:	6a 00                	push   $0x0
    199c:	e8 51 0c 00 00       	call   25f2 <printf>
    19a1:	83 c4 10             	add    $0x10,%esp
}
    19a4:	90                   	nop
    19a5:	c9                   	leave  
    19a6:	c3                   	ret    

000019a7 <showRgbQuan>:
void showRgbQuan(RGBQUAD* pRGB) {
    19a7:	55                   	push   %ebp
    19a8:	89 e5                	mov    %esp,%ebp
    19aa:	83 ec 08             	sub    $0x8,%esp
	printf(0, "(%d,%d,%d) ", pRGB->rgbRed, pRGB->rgbGreen, pRGB->rgbBlue);
    19ad:	8b 45 08             	mov    0x8(%ebp),%eax
    19b0:	0f b6 00             	movzbl (%eax),%eax
    19b3:	0f b6 c8             	movzbl %al,%ecx
    19b6:	8b 45 08             	mov    0x8(%ebp),%eax
    19b9:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    19bd:	0f b6 d0             	movzbl %al,%edx
    19c0:	8b 45 08             	mov    0x8(%ebp),%eax
    19c3:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    19c7:	0f b6 c0             	movzbl %al,%eax
    19ca:	83 ec 0c             	sub    $0xc,%esp
    19cd:	51                   	push   %ecx
    19ce:	52                   	push   %edx
    19cf:	50                   	push   %eax
    19d0:	68 9d 8f 00 00       	push   $0x8f9d
    19d5:	6a 00                	push   $0x0
    19d7:	e8 16 0c 00 00       	call   25f2 <printf>
    19dc:	83 c4 20             	add    $0x20,%esp
}
    19df:	90                   	nop
    19e0:	c9                   	leave  
    19e1:	c3                   	ret    

000019e2 <freepic>:

void freepic(PICNODE *pic) {
    19e2:	55                   	push   %ebp
    19e3:	89 e5                	mov    %esp,%ebp
    19e5:	83 ec 08             	sub    $0x8,%esp
	free(pic->data);
    19e8:	8b 45 08             	mov    0x8(%ebp),%eax
    19eb:	8b 00                	mov    (%eax),%eax
    19ed:	83 ec 0c             	sub    $0xc,%esp
    19f0:	50                   	push   %eax
    19f1:	e8 8d 0d 00 00       	call   2783 <free>
    19f6:	83 c4 10             	add    $0x10,%esp
}
    19f9:	90                   	nop
    19fa:	c9                   	leave  
    19fb:	c3                   	ret    

000019fc <set_icon_alpha>:

void set_icon_alpha(PICNODE *pic) {
    19fc:	55                   	push   %ebp
    19fd:	89 e5                	mov    %esp,%ebp
    19ff:	83 ec 68             	sub    $0x68,%esp
	int W = 15;
    1a02:	c7 45 ec 0f 00 00 00 	movl   $0xf,-0x14(%ebp)
	Rect r1 = initRect(0, 0, W, W);
    1a09:	8d 45 dc             	lea    -0x24(%ebp),%eax
    1a0c:	83 ec 0c             	sub    $0xc,%esp
    1a0f:	ff 75 ec             	pushl  -0x14(%ebp)
    1a12:	ff 75 ec             	pushl  -0x14(%ebp)
    1a15:	6a 00                	push   $0x0
    1a17:	6a 00                	push   $0x0
    1a19:	50                   	push   %eax
    1a1a:	e8 02 02 00 00       	call   1c21 <initRect>
    1a1f:	83 c4 1c             	add    $0x1c,%esp
	Rect r2 = initRect(pic->width - W, 0, W, W);
    1a22:	8b 45 08             	mov    0x8(%ebp),%eax
    1a25:	8b 40 04             	mov    0x4(%eax),%eax
    1a28:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1a2b:	89 c2                	mov    %eax,%edx
    1a2d:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1a30:	83 ec 0c             	sub    $0xc,%esp
    1a33:	ff 75 ec             	pushl  -0x14(%ebp)
    1a36:	ff 75 ec             	pushl  -0x14(%ebp)
    1a39:	6a 00                	push   $0x0
    1a3b:	52                   	push   %edx
    1a3c:	50                   	push   %eax
    1a3d:	e8 df 01 00 00       	call   1c21 <initRect>
    1a42:	83 c4 1c             	add    $0x1c,%esp
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
    1a45:	8b 45 08             	mov    0x8(%ebp),%eax
    1a48:	8b 40 08             	mov    0x8(%eax),%eax
    1a4b:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1a4e:	89 c1                	mov    %eax,%ecx
    1a50:	8b 45 08             	mov    0x8(%ebp),%eax
    1a53:	8b 40 04             	mov    0x4(%eax),%eax
    1a56:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1a59:	89 c2                	mov    %eax,%edx
    1a5b:	8d 45 bc             	lea    -0x44(%ebp),%eax
    1a5e:	83 ec 0c             	sub    $0xc,%esp
    1a61:	ff 75 ec             	pushl  -0x14(%ebp)
    1a64:	ff 75 ec             	pushl  -0x14(%ebp)
    1a67:	51                   	push   %ecx
    1a68:	52                   	push   %edx
    1a69:	50                   	push   %eax
    1a6a:	e8 b2 01 00 00       	call   1c21 <initRect>
    1a6f:	83 c4 1c             	add    $0x1c,%esp
	Rect r4 = initRect(0, pic->height - W, W, W);
    1a72:	8b 45 08             	mov    0x8(%ebp),%eax
    1a75:	8b 40 08             	mov    0x8(%eax),%eax
    1a78:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1a7b:	89 c2                	mov    %eax,%edx
    1a7d:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1a80:	83 ec 0c             	sub    $0xc,%esp
    1a83:	ff 75 ec             	pushl  -0x14(%ebp)
    1a86:	ff 75 ec             	pushl  -0x14(%ebp)
    1a89:	52                   	push   %edx
    1a8a:	6a 00                	push   $0x0
    1a8c:	50                   	push   %eax
    1a8d:	e8 8f 01 00 00       	call   1c21 <initRect>
    1a92:	83 c4 1c             	add    $0x1c,%esp
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
    1a95:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a9c:	e9 47 01 00 00       	jmp    1be8 <set_icon_alpha+0x1ec>
		for (j = 0; j < pic->height; j++) {
    1aa1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1aa8:	e9 28 01 00 00       	jmp    1bd5 <set_icon_alpha+0x1d9>
			p = initPoint(i, j);
    1aad:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    1ab0:	83 ec 04             	sub    $0x4,%esp
    1ab3:	ff 75 f0             	pushl  -0x10(%ebp)
    1ab6:	ff 75 f4             	pushl  -0xc(%ebp)
    1ab9:	50                   	push   %eax
    1aba:	e8 3b 01 00 00       	call   1bfa <initPoint>
    1abf:	83 c4 0c             	add    $0xc,%esp
			if (isIn(p, r1) || isIn(p, r2) || isIn(p, r3) || isIn(p, r4)) {
    1ac2:	83 ec 08             	sub    $0x8,%esp
    1ac5:	ff 75 e8             	pushl  -0x18(%ebp)
    1ac8:	ff 75 e4             	pushl  -0x1c(%ebp)
    1acb:	ff 75 e0             	pushl  -0x20(%ebp)
    1ace:	ff 75 dc             	pushl  -0x24(%ebp)
    1ad1:	ff 75 a8             	pushl  -0x58(%ebp)
    1ad4:	ff 75 a4             	pushl  -0x5c(%ebp)
    1ad7:	e8 96 01 00 00       	call   1c72 <isIn>
    1adc:	83 c4 20             	add    $0x20,%esp
    1adf:	85 c0                	test   %eax,%eax
    1ae1:	75 67                	jne    1b4a <set_icon_alpha+0x14e>
    1ae3:	83 ec 08             	sub    $0x8,%esp
    1ae6:	ff 75 d8             	pushl  -0x28(%ebp)
    1ae9:	ff 75 d4             	pushl  -0x2c(%ebp)
    1aec:	ff 75 d0             	pushl  -0x30(%ebp)
    1aef:	ff 75 cc             	pushl  -0x34(%ebp)
    1af2:	ff 75 a8             	pushl  -0x58(%ebp)
    1af5:	ff 75 a4             	pushl  -0x5c(%ebp)
    1af8:	e8 75 01 00 00       	call   1c72 <isIn>
    1afd:	83 c4 20             	add    $0x20,%esp
    1b00:	85 c0                	test   %eax,%eax
    1b02:	75 46                	jne    1b4a <set_icon_alpha+0x14e>
    1b04:	83 ec 08             	sub    $0x8,%esp
    1b07:	ff 75 c8             	pushl  -0x38(%ebp)
    1b0a:	ff 75 c4             	pushl  -0x3c(%ebp)
    1b0d:	ff 75 c0             	pushl  -0x40(%ebp)
    1b10:	ff 75 bc             	pushl  -0x44(%ebp)
    1b13:	ff 75 a8             	pushl  -0x58(%ebp)
    1b16:	ff 75 a4             	pushl  -0x5c(%ebp)
    1b19:	e8 54 01 00 00       	call   1c72 <isIn>
    1b1e:	83 c4 20             	add    $0x20,%esp
    1b21:	85 c0                	test   %eax,%eax
    1b23:	75 25                	jne    1b4a <set_icon_alpha+0x14e>
    1b25:	83 ec 08             	sub    $0x8,%esp
    1b28:	ff 75 b8             	pushl  -0x48(%ebp)
    1b2b:	ff 75 b4             	pushl  -0x4c(%ebp)
    1b2e:	ff 75 b0             	pushl  -0x50(%ebp)
    1b31:	ff 75 ac             	pushl  -0x54(%ebp)
    1b34:	ff 75 a8             	pushl  -0x58(%ebp)
    1b37:	ff 75 a4             	pushl  -0x5c(%ebp)
    1b3a:	e8 33 01 00 00       	call   1c72 <isIn>
    1b3f:	83 c4 20             	add    $0x20,%esp
    1b42:	85 c0                	test   %eax,%eax
    1b44:	0f 84 87 00 00 00    	je     1bd1 <set_icon_alpha+0x1d5>
				if (pic->data[j * pic->width + i].rgbBlue == 0xff
    1b4a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b4d:	8b 10                	mov    (%eax),%edx
    1b4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b52:	8b 40 04             	mov    0x4(%eax),%eax
    1b55:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1b59:	89 c1                	mov    %eax,%ecx
    1b5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b5e:	01 c8                	add    %ecx,%eax
    1b60:	c1 e0 02             	shl    $0x2,%eax
    1b63:	01 d0                	add    %edx,%eax
    1b65:	0f b6 00             	movzbl (%eax),%eax
    1b68:	3c ff                	cmp    $0xff,%al
    1b6a:	75 65                	jne    1bd1 <set_icon_alpha+0x1d5>
						&& pic->data[j * pic->width + i].rgbGreen == 0xff
    1b6c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b6f:	8b 10                	mov    (%eax),%edx
    1b71:	8b 45 08             	mov    0x8(%ebp),%eax
    1b74:	8b 40 04             	mov    0x4(%eax),%eax
    1b77:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1b7b:	89 c1                	mov    %eax,%ecx
    1b7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b80:	01 c8                	add    %ecx,%eax
    1b82:	c1 e0 02             	shl    $0x2,%eax
    1b85:	01 d0                	add    %edx,%eax
    1b87:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    1b8b:	3c ff                	cmp    $0xff,%al
    1b8d:	75 42                	jne    1bd1 <set_icon_alpha+0x1d5>
						&& pic->data[j * pic->width + i].rgbRed == 0xff) {
    1b8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b92:	8b 10                	mov    (%eax),%edx
    1b94:	8b 45 08             	mov    0x8(%ebp),%eax
    1b97:	8b 40 04             	mov    0x4(%eax),%eax
    1b9a:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1b9e:	89 c1                	mov    %eax,%ecx
    1ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ba3:	01 c8                	add    %ecx,%eax
    1ba5:	c1 e0 02             	shl    $0x2,%eax
    1ba8:	01 d0                	add    %edx,%eax
    1baa:	0f b6 40 02          	movzbl 0x2(%eax),%eax
    1bae:	3c ff                	cmp    $0xff,%al
    1bb0:	75 1f                	jne    1bd1 <set_icon_alpha+0x1d5>
					pic->data[j * pic->width + i].rgbReserved = 1;
    1bb2:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb5:	8b 10                	mov    (%eax),%edx
    1bb7:	8b 45 08             	mov    0x8(%ebp),%eax
    1bba:	8b 40 04             	mov    0x4(%eax),%eax
    1bbd:	0f af 45 f0          	imul   -0x10(%ebp),%eax
    1bc1:	89 c1                	mov    %eax,%ecx
    1bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bc6:	01 c8                	add    %ecx,%eax
    1bc8:	c1 e0 02             	shl    $0x2,%eax
    1bcb:	01 d0                	add    %edx,%eax
    1bcd:	c6 40 03 01          	movb   $0x1,0x3(%eax)
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
	Rect r4 = initRect(0, pic->height - W, W, W);
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
		for (j = 0; j < pic->height; j++) {
    1bd1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1bd5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd8:	8b 40 08             	mov    0x8(%eax),%eax
    1bdb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1bde:	0f 8f c9 fe ff ff    	jg     1aad <set_icon_alpha+0xb1>
	Rect r2 = initRect(pic->width - W, 0, W, W);
	Rect r3 = initRect(pic->width - W, pic->height - W, W, W);
	Rect r4 = initRect(0, pic->height - W, W, W);
	Point p;
	int i, j;
	for (i = 0; i < pic->width; i++) {
    1be4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1be8:	8b 45 08             	mov    0x8(%ebp),%eax
    1beb:	8b 40 04             	mov    0x4(%eax),%eax
    1bee:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1bf1:	0f 8f aa fe ff ff    	jg     1aa1 <set_icon_alpha+0xa5>
					pic->data[j * pic->width + i].rgbReserved = 1;
				}
			}
		}
	}
}
    1bf7:	90                   	nop
    1bf8:	c9                   	leave  
    1bf9:	c3                   	ret    

00001bfa <initPoint>:
#include "message.h"
#include "types.h"
#include "user.h"
#include "finder.h"
Point initPoint(int x, int y)
{
    1bfa:	55                   	push   %ebp
    1bfb:	89 e5                	mov    %esp,%ebp
    1bfd:	83 ec 10             	sub    $0x10,%esp
	Point p;
	p.x = x;
    1c00:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c03:	89 45 f8             	mov    %eax,-0x8(%ebp)
	p.y = y;
    1c06:	8b 45 10             	mov    0x10(%ebp),%eax
    1c09:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return p;
    1c0c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c0f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c12:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1c15:	89 01                	mov    %eax,(%ecx)
    1c17:	89 51 04             	mov    %edx,0x4(%ecx)
}
    1c1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c1d:	c9                   	leave  
    1c1e:	c2 04 00             	ret    $0x4

00001c21 <initRect>:

Rect initRect(int x, int y, int w, int h)
{
    1c21:	55                   	push   %ebp
    1c22:	89 e5                	mov    %esp,%ebp
    1c24:	83 ec 18             	sub    $0x18,%esp
	Rect r;
	r.start = initPoint(x, y);
    1c27:	8d 45 e8             	lea    -0x18(%ebp),%eax
    1c2a:	ff 75 10             	pushl  0x10(%ebp)
    1c2d:	ff 75 0c             	pushl  0xc(%ebp)
    1c30:	50                   	push   %eax
    1c31:	e8 c4 ff ff ff       	call   1bfa <initPoint>
    1c36:	83 c4 08             	add    $0x8,%esp
    1c39:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1c3c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1c3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c42:	89 55 f4             	mov    %edx,-0xc(%ebp)
	r.width = w;
    1c45:	8b 45 14             	mov    0x14(%ebp),%eax
    1c48:	89 45 f8             	mov    %eax,-0x8(%ebp)
	r.height = h;
    1c4b:	8b 45 18             	mov    0x18(%ebp),%eax
    1c4e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return r;
    1c51:	8b 45 08             	mov    0x8(%ebp),%eax
    1c54:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1c57:	89 10                	mov    %edx,(%eax)
    1c59:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c5c:	89 50 04             	mov    %edx,0x4(%eax)
    1c5f:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1c62:	89 50 08             	mov    %edx,0x8(%eax)
    1c65:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1c68:	89 50 0c             	mov    %edx,0xc(%eax)
}
    1c6b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c6e:	c9                   	leave  
    1c6f:	c2 04 00             	ret    $0x4

00001c72 <isIn>:

int isIn(Point p, Rect r)
{
    1c72:	55                   	push   %ebp
    1c73:	89 e5                	mov    %esp,%ebp
	return (p.x >= r.start.x) && (p.x < r.start.x+r.width)
    1c75:	8b 55 08             	mov    0x8(%ebp),%edx
    1c78:	8b 45 10             	mov    0x10(%ebp),%eax
			&& (p.y >= r.start.y) && (p.y < r.start.y+r.height);
    1c7b:	39 c2                	cmp    %eax,%edx
    1c7d:	7c 2f                	jl     1cae <isIn+0x3c>
	return r;
}

int isIn(Point p, Rect r)
{
	return (p.x >= r.start.x) && (p.x < r.start.x+r.width)
    1c7f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c82:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1c85:	8b 55 18             	mov    0x18(%ebp),%edx
    1c88:	01 ca                	add    %ecx,%edx
    1c8a:	39 d0                	cmp    %edx,%eax
    1c8c:	7d 20                	jge    1cae <isIn+0x3c>
			&& (p.y >= r.start.y) && (p.y < r.start.y+r.height);
    1c8e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c91:	8b 45 14             	mov    0x14(%ebp),%eax
    1c94:	39 c2                	cmp    %eax,%edx
    1c96:	7c 16                	jl     1cae <isIn+0x3c>
    1c98:	8b 45 0c             	mov    0xc(%ebp),%eax
    1c9b:	8b 4d 14             	mov    0x14(%ebp),%ecx
    1c9e:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1ca1:	01 ca                	add    %ecx,%edx
    1ca3:	39 d0                	cmp    %edx,%eax
    1ca5:	7d 07                	jge    1cae <isIn+0x3c>
    1ca7:	b8 01 00 00 00       	mov    $0x1,%eax
    1cac:	eb 05                	jmp    1cb3 <isIn+0x41>
    1cae:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1cb3:	5d                   	pop    %ebp
    1cb4:	c3                   	ret    

00001cb5 <initClickManager>:

ClickableManager initClickManager(struct Context c)
{
    1cb5:	55                   	push   %ebp
    1cb6:	89 e5                	mov    %esp,%ebp
    1cb8:	83 ec 20             	sub    $0x20,%esp
	ClickableManager cm;
	cm.left_click = 0;
    1cbb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	cm.double_click = 0;
    1cc2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	cm.right_click = 0;
    1cc9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	cm.wndWidth = c.width;
    1cd0:	8b 45 10             	mov    0x10(%ebp),%eax
    1cd3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	cm.wndHeight = c.height;
    1cd6:	8b 45 14             	mov    0x14(%ebp),%eax
    1cd9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return cm;
    1cdc:	8b 45 08             	mov    0x8(%ebp),%eax
    1cdf:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1ce2:	89 10                	mov    %edx,(%eax)
    1ce4:	8b 55 f0             	mov    -0x10(%ebp),%edx
    1ce7:	89 50 04             	mov    %edx,0x4(%eax)
    1cea:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1ced:	89 50 08             	mov    %edx,0x8(%eax)
    1cf0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1cf3:	89 50 0c             	mov    %edx,0xc(%eax)
    1cf6:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1cf9:	89 50 10             	mov    %edx,0x10(%eax)
}
    1cfc:	8b 45 08             	mov    0x8(%ebp),%eax
    1cff:	c9                   	leave  
    1d00:	c2 04 00             	ret    $0x4

00001d03 <createClickable>:

void createClickable(ClickableManager *c, Rect r, int MsgType, Handler h)
{
    1d03:	55                   	push   %ebp
    1d04:	89 e5                	mov    %esp,%ebp
    1d06:	83 ec 08             	sub    $0x8,%esp
	switch (MsgType)
    1d09:	8b 45 1c             	mov    0x1c(%ebp),%eax
    1d0c:	83 f8 03             	cmp    $0x3,%eax
    1d0f:	74 4f                	je     1d60 <createClickable+0x5d>
    1d11:	83 f8 04             	cmp    $0x4,%eax
    1d14:	74 07                	je     1d1d <createClickable+0x1a>
    1d16:	83 f8 02             	cmp    $0x2,%eax
    1d19:	74 25                	je     1d40 <createClickable+0x3d>
    1d1b:	eb 66                	jmp    1d83 <createClickable+0x80>
	{
		case MSG_DOUBLECLICK:
			addClickable(&c->double_click, r, h);
    1d1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d20:	83 c0 04             	add    $0x4,%eax
    1d23:	83 ec 08             	sub    $0x8,%esp
    1d26:	ff 75 20             	pushl  0x20(%ebp)
    1d29:	ff 75 18             	pushl  0x18(%ebp)
    1d2c:	ff 75 14             	pushl  0x14(%ebp)
    1d2f:	ff 75 10             	pushl  0x10(%ebp)
    1d32:	ff 75 0c             	pushl  0xc(%ebp)
    1d35:	50                   	push   %eax
    1d36:	e8 5e 00 00 00       	call   1d99 <addClickable>
    1d3b:	83 c4 20             	add    $0x20,%esp
	        break;
    1d3e:	eb 56                	jmp    1d96 <createClickable+0x93>
	    case MSG_LPRESS:
	    	addClickable(&c->left_click, r, h);
    1d40:	8b 45 08             	mov    0x8(%ebp),%eax
    1d43:	83 ec 08             	sub    $0x8,%esp
    1d46:	ff 75 20             	pushl  0x20(%ebp)
    1d49:	ff 75 18             	pushl  0x18(%ebp)
    1d4c:	ff 75 14             	pushl  0x14(%ebp)
    1d4f:	ff 75 10             	pushl  0x10(%ebp)
    1d52:	ff 75 0c             	pushl  0xc(%ebp)
    1d55:	50                   	push   %eax
    1d56:	e8 3e 00 00 00       	call   1d99 <addClickable>
    1d5b:	83 c4 20             	add    $0x20,%esp
	    	break;
    1d5e:	eb 36                	jmp    1d96 <createClickable+0x93>
	    case MSG_RPRESS:
	    	addClickable(&c->right_click, r, h);
    1d60:	8b 45 08             	mov    0x8(%ebp),%eax
    1d63:	83 c0 08             	add    $0x8,%eax
    1d66:	83 ec 08             	sub    $0x8,%esp
    1d69:	ff 75 20             	pushl  0x20(%ebp)
    1d6c:	ff 75 18             	pushl  0x18(%ebp)
    1d6f:	ff 75 14             	pushl  0x14(%ebp)
    1d72:	ff 75 10             	pushl  0x10(%ebp)
    1d75:	ff 75 0c             	pushl  0xc(%ebp)
    1d78:	50                   	push   %eax
    1d79:	e8 1b 00 00 00       	call   1d99 <addClickable>
    1d7e:	83 c4 20             	add    $0x20,%esp
	    	break;
    1d81:	eb 13                	jmp    1d96 <createClickable+0x93>
	    default:
	    	printf(0, "向clickable传递了非鼠标点击事件！");
    1d83:	83 ec 08             	sub    $0x8,%esp
    1d86:	68 ac 8f 00 00       	push   $0x8fac
    1d8b:	6a 00                	push   $0x0
    1d8d:	e8 60 08 00 00       	call   25f2 <printf>
    1d92:	83 c4 10             	add    $0x10,%esp
	    	break;
    1d95:	90                   	nop
	}
}
    1d96:	90                   	nop
    1d97:	c9                   	leave  
    1d98:	c3                   	ret    

00001d99 <addClickable>:

void addClickable(Clickable **head, Rect r, Handler h)
{
    1d99:	55                   	push   %ebp
    1d9a:	89 e5                	mov    %esp,%ebp
    1d9c:	83 ec 18             	sub    $0x18,%esp
	//printf(0, "adding clickable\n");
	Clickable *c = (Clickable *)malloc(sizeof(Clickable));
    1d9f:	83 ec 0c             	sub    $0xc,%esp
    1da2:	6a 18                	push   $0x18
    1da4:	e8 1c 0b 00 00       	call   28c5 <malloc>
    1da9:	83 c4 10             	add    $0x10,%esp
    1dac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	c->area = r;
    1daf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1db2:	8b 55 0c             	mov    0xc(%ebp),%edx
    1db5:	89 10                	mov    %edx,(%eax)
    1db7:	8b 55 10             	mov    0x10(%ebp),%edx
    1dba:	89 50 04             	mov    %edx,0x4(%eax)
    1dbd:	8b 55 14             	mov    0x14(%ebp),%edx
    1dc0:	89 50 08             	mov    %edx,0x8(%eax)
    1dc3:	8b 55 18             	mov    0x18(%ebp),%edx
    1dc6:	89 50 0c             	mov    %edx,0xc(%eax)
	c->handler = h;
    1dc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dcc:	8b 55 1c             	mov    0x1c(%ebp),%edx
    1dcf:	89 50 10             	mov    %edx,0x10(%eax)
	c->next = *head;
    1dd2:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd5:	8b 10                	mov    (%eax),%edx
    1dd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dda:	89 50 14             	mov    %edx,0x14(%eax)
	*head = c;
    1ddd:	8b 45 08             	mov    0x8(%ebp),%eax
    1de0:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1de3:	89 10                	mov    %edx,(%eax)
}
    1de5:	90                   	nop
    1de6:	c9                   	leave  
    1de7:	c3                   	ret    

00001de8 <deleteClickable>:

void deleteClickable(Clickable **head, Rect region)
{
    1de8:	55                   	push   %ebp
    1de9:	89 e5                	mov    %esp,%ebp
    1deb:	83 ec 18             	sub    $0x18,%esp
	Clickable *prev, *cur, *temp;
	prev = cur = *head;
    1dee:	8b 45 08             	mov    0x8(%ebp),%eax
    1df1:	8b 00                	mov    (%eax),%eax
    1df3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1df6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1df9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (cur != 0)
    1dfc:	e9 ad 00 00 00       	jmp    1eae <deleteClickable+0xc6>
	{
		if (isIn(cur->area.start, region))
    1e01:	ff 75 18             	pushl  0x18(%ebp)
    1e04:	ff 75 14             	pushl  0x14(%ebp)
    1e07:	ff 75 10             	pushl  0x10(%ebp)
    1e0a:	ff 75 0c             	pushl  0xc(%ebp)
    1e0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e10:	ff 70 04             	pushl  0x4(%eax)
    1e13:	ff 30                	pushl  (%eax)
    1e15:	e8 58 fe ff ff       	call   1c72 <isIn>
    1e1a:	83 c4 18             	add    $0x18,%esp
    1e1d:	85 c0                	test   %eax,%eax
    1e1f:	74 66                	je     1e87 <deleteClickable+0x9f>
		{
			//如果当前指针指向头部
			if (cur == *head)
    1e21:	8b 45 08             	mov    0x8(%ebp),%eax
    1e24:	8b 00                	mov    (%eax),%eax
    1e26:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1e29:	75 31                	jne    1e5c <deleteClickable+0x74>
			{
				//删除头节点
				temp = *head;
    1e2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2e:	8b 00                	mov    (%eax),%eax
    1e30:	89 45 ec             	mov    %eax,-0x14(%ebp)
				*head = cur->next;
    1e33:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e36:	8b 50 14             	mov    0x14(%eax),%edx
    1e39:	8b 45 08             	mov    0x8(%ebp),%eax
    1e3c:	89 10                	mov    %edx,(%eax)
				cur = prev = *head;
    1e3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e41:	8b 00                	mov    (%eax),%eax
    1e43:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1e46:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e49:	89 45 f0             	mov    %eax,-0x10(%ebp)
				free(temp);
    1e4c:	83 ec 0c             	sub    $0xc,%esp
    1e4f:	ff 75 ec             	pushl  -0x14(%ebp)
    1e52:	e8 2c 09 00 00       	call   2783 <free>
    1e57:	83 c4 10             	add    $0x10,%esp
    1e5a:	eb 52                	jmp    1eae <deleteClickable+0xc6>
			}
			else
			{
				//删除当前节点
				prev->next = cur->next;
    1e5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e5f:	8b 50 14             	mov    0x14(%eax),%edx
    1e62:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e65:	89 50 14             	mov    %edx,0x14(%eax)
				temp = cur;
    1e68:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e6b:	89 45 ec             	mov    %eax,-0x14(%ebp)
				cur = cur->next;
    1e6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e71:	8b 40 14             	mov    0x14(%eax),%eax
    1e74:	89 45 f0             	mov    %eax,-0x10(%ebp)
				free(temp);
    1e77:	83 ec 0c             	sub    $0xc,%esp
    1e7a:	ff 75 ec             	pushl  -0x14(%ebp)
    1e7d:	e8 01 09 00 00       	call   2783 <free>
    1e82:	83 c4 10             	add    $0x10,%esp
    1e85:	eb 27                	jmp    1eae <deleteClickable+0xc6>
			}
		}
		else
		{
			//如果当前节点是头节点，
			if (cur == *head)
    1e87:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8a:	8b 00                	mov    (%eax),%eax
    1e8c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    1e8f:	75 0b                	jne    1e9c <deleteClickable+0xb4>
			{
				cur = cur->next;
    1e91:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e94:	8b 40 14             	mov    0x14(%eax),%eax
    1e97:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e9a:	eb 12                	jmp    1eae <deleteClickable+0xc6>
			}
			else
			{
				cur = cur->next;
    1e9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e9f:	8b 40 14             	mov    0x14(%eax),%eax
    1ea2:	89 45 f0             	mov    %eax,-0x10(%ebp)
				prev = prev->next;
    1ea5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ea8:	8b 40 14             	mov    0x14(%eax),%eax
    1eab:	89 45 f4             	mov    %eax,-0xc(%ebp)

void deleteClickable(Clickable **head, Rect region)
{
	Clickable *prev, *cur, *temp;
	prev = cur = *head;
	while (cur != 0)
    1eae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1eb2:	0f 85 49 ff ff ff    	jne    1e01 <deleteClickable+0x19>
				cur = cur->next;
				prev = prev->next;
			}
		}
	}
}
    1eb8:	90                   	nop
    1eb9:	c9                   	leave  
    1eba:	c3                   	ret    

00001ebb <executeHandler>:

int executeHandler(Clickable *head, Point click)
{
    1ebb:	55                   	push   %ebp
    1ebc:	89 e5                	mov    %esp,%ebp
    1ebe:	83 ec 18             	sub    $0x18,%esp
	Clickable *cur = head;
    1ec1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (cur != 0)
    1ec7:	eb 58                	jmp    1f21 <executeHandler+0x66>
	{
		if (isIn(click, cur->area))
    1ec9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ecc:	ff 70 0c             	pushl  0xc(%eax)
    1ecf:	ff 70 08             	pushl  0x8(%eax)
    1ed2:	ff 70 04             	pushl  0x4(%eax)
    1ed5:	ff 30                	pushl  (%eax)
    1ed7:	ff 75 10             	pushl  0x10(%ebp)
    1eda:	ff 75 0c             	pushl  0xc(%ebp)
    1edd:	e8 90 fd ff ff       	call   1c72 <isIn>
    1ee2:	83 c4 18             	add    $0x18,%esp
    1ee5:	85 c0                	test   %eax,%eax
    1ee7:	74 2f                	je     1f18 <executeHandler+0x5d>
		{
			renaming = 0;
    1ee9:	c7 05 c4 fb 00 00 00 	movl   $0x0,0xfbc4
    1ef0:	00 00 00 
			isSearching = 0;
    1ef3:	c7 05 c0 fb 00 00 00 	movl   $0x0,0xfbc0
    1efa:	00 00 00 
			cur->handler(click);
    1efd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f00:	8b 40 10             	mov    0x10(%eax),%eax
    1f03:	83 ec 08             	sub    $0x8,%esp
    1f06:	ff 75 10             	pushl  0x10(%ebp)
    1f09:	ff 75 0c             	pushl  0xc(%ebp)
    1f0c:	ff d0                	call   *%eax
    1f0e:	83 c4 10             	add    $0x10,%esp
			return 1;
    1f11:	b8 01 00 00 00       	mov    $0x1,%eax
    1f16:	eb 4b                	jmp    1f63 <executeHandler+0xa8>
		}
		cur = cur->next;
    1f18:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f1b:	8b 40 14             	mov    0x14(%eax),%eax
    1f1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
}

int executeHandler(Clickable *head, Point click)
{
	Clickable *cur = head;
	while (cur != 0)
    1f21:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f25:	75 a2                	jne    1ec9 <executeHandler+0xe>
			cur->handler(click);
			return 1;
		}
		cur = cur->next;
	}
	isSearching = 0;
    1f27:	c7 05 c0 fb 00 00 00 	movl   $0x0,0xfbc0
    1f2e:	00 00 00 
	if (renaming == 1){
    1f31:	a1 c4 fb 00 00       	mov    0xfbc4,%eax
    1f36:	83 f8 01             	cmp    $0x1,%eax
    1f39:	75 11                	jne    1f4c <executeHandler+0x91>
		renaming = 0;
    1f3b:	c7 05 c4 fb 00 00 00 	movl   $0x0,0xfbc4
    1f42:	00 00 00 
		return 1;
    1f45:	b8 01 00 00 00       	mov    $0x1,%eax
    1f4a:	eb 17                	jmp    1f63 <executeHandler+0xa8>
	}
	printf(0, "execute: none!\n");
    1f4c:	83 ec 08             	sub    $0x8,%esp
    1f4f:	68 da 8f 00 00       	push   $0x8fda
    1f54:	6a 00                	push   $0x0
    1f56:	e8 97 06 00 00       	call   25f2 <printf>
    1f5b:	83 c4 10             	add    $0x10,%esp
	return 0;
    1f5e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1f63:	c9                   	leave  
    1f64:	c3                   	ret    

00001f65 <printClickable>:

void printClickable(Clickable *c)
{
    1f65:	55                   	push   %ebp
    1f66:	89 e5                	mov    %esp,%ebp
    1f68:	53                   	push   %ebx
    1f69:	83 ec 04             	sub    $0x4,%esp
	printf(0, "(%d, %d, %d, %d)\n", c->area.start.x, c->area.start.y, c->area.width, c->area.height);
    1f6c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f6f:	8b 58 0c             	mov    0xc(%eax),%ebx
    1f72:	8b 45 08             	mov    0x8(%ebp),%eax
    1f75:	8b 48 08             	mov    0x8(%eax),%ecx
    1f78:	8b 45 08             	mov    0x8(%ebp),%eax
    1f7b:	8b 50 04             	mov    0x4(%eax),%edx
    1f7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f81:	8b 00                	mov    (%eax),%eax
    1f83:	83 ec 08             	sub    $0x8,%esp
    1f86:	53                   	push   %ebx
    1f87:	51                   	push   %ecx
    1f88:	52                   	push   %edx
    1f89:	50                   	push   %eax
    1f8a:	68 ea 8f 00 00       	push   $0x8fea
    1f8f:	6a 00                	push   $0x0
    1f91:	e8 5c 06 00 00       	call   25f2 <printf>
    1f96:	83 c4 20             	add    $0x20,%esp
}
    1f99:	90                   	nop
    1f9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1f9d:	c9                   	leave  
    1f9e:	c3                   	ret    

00001f9f <printClickableList>:

void printClickableList(Clickable *head)
{
    1f9f:	55                   	push   %ebp
    1fa0:	89 e5                	mov    %esp,%ebp
    1fa2:	83 ec 18             	sub    $0x18,%esp
	Clickable *cur = head;
    1fa5:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf(0, "Clickable List:\n");
    1fab:	83 ec 08             	sub    $0x8,%esp
    1fae:	68 fc 8f 00 00       	push   $0x8ffc
    1fb3:	6a 00                	push   $0x0
    1fb5:	e8 38 06 00 00       	call   25f2 <printf>
    1fba:	83 c4 10             	add    $0x10,%esp
	while(cur != 0)
    1fbd:	eb 17                	jmp    1fd6 <printClickableList+0x37>
	{
		printClickable(cur);
    1fbf:	83 ec 0c             	sub    $0xc,%esp
    1fc2:	ff 75 f4             	pushl  -0xc(%ebp)
    1fc5:	e8 9b ff ff ff       	call   1f65 <printClickable>
    1fca:	83 c4 10             	add    $0x10,%esp
		cur = cur->next;
    1fcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fd0:	8b 40 14             	mov    0x14(%eax),%eax
    1fd3:	89 45 f4             	mov    %eax,-0xc(%ebp)

void printClickableList(Clickable *head)
{
	Clickable *cur = head;
	printf(0, "Clickable List:\n");
	while(cur != 0)
    1fd6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fda:	75 e3                	jne    1fbf <printClickableList+0x20>
	{
		printClickable(cur);
		cur = cur->next;
	}
	printf(0, "\n");
    1fdc:	83 ec 08             	sub    $0x8,%esp
    1fdf:	68 0d 90 00 00       	push   $0x900d
    1fe4:	6a 00                	push   $0x0
    1fe6:	e8 07 06 00 00       	call   25f2 <printf>
    1feb:	83 c4 10             	add    $0x10,%esp
}
    1fee:	90                   	nop
    1fef:	c9                   	leave  
    1ff0:	c3                   	ret    

00001ff1 <testHanler>:

void testHanler(struct Point p)
{
    1ff1:	55                   	push   %ebp
    1ff2:	89 e5                	mov    %esp,%ebp
    1ff4:	83 ec 08             	sub    $0x8,%esp
	printf(0, "execute: (%d, %d)!\n", p.x, p.y);
    1ff7:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ffa:	8b 45 08             	mov    0x8(%ebp),%eax
    1ffd:	52                   	push   %edx
    1ffe:	50                   	push   %eax
    1fff:	68 0f 90 00 00       	push   $0x900f
    2004:	6a 00                	push   $0x0
    2006:	e8 e7 05 00 00       	call   25f2 <printf>
    200b:	83 c4 10             	add    $0x10,%esp
}
    200e:	90                   	nop
    200f:	c9                   	leave  
    2010:	c3                   	ret    

00002011 <testClickable>:
void testClickable(struct Context c)
{
    2011:	55                   	push   %ebp
    2012:	89 e5                	mov    %esp,%ebp
    2014:	83 ec 78             	sub    $0x78,%esp
	ClickableManager cm = initClickManager(c);
    2017:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    201a:	ff 75 10             	pushl  0x10(%ebp)
    201d:	ff 75 0c             	pushl  0xc(%ebp)
    2020:	ff 75 08             	pushl  0x8(%ebp)
    2023:	50                   	push   %eax
    2024:	e8 8c fc ff ff       	call   1cb5 <initClickManager>
    2029:	83 c4 0c             	add    $0xc,%esp

	Rect r1 = initRect(5,5,20,20);
    202c:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    202f:	83 ec 04             	sub    $0x4,%esp
    2032:	6a 14                	push   $0x14
    2034:	6a 14                	push   $0x14
    2036:	6a 05                	push   $0x5
    2038:	6a 05                	push   $0x5
    203a:	50                   	push   %eax
    203b:	e8 e1 fb ff ff       	call   1c21 <initRect>
    2040:	83 c4 14             	add    $0x14,%esp
	Rect r2 = initRect(20,20,20,20);
    2043:	8d 45 c4             	lea    -0x3c(%ebp),%eax
    2046:	83 ec 04             	sub    $0x4,%esp
    2049:	6a 14                	push   $0x14
    204b:	6a 14                	push   $0x14
    204d:	6a 14                	push   $0x14
    204f:	6a 14                	push   $0x14
    2051:	50                   	push   %eax
    2052:	e8 ca fb ff ff       	call   1c21 <initRect>
    2057:	83 c4 14             	add    $0x14,%esp
	Rect r3 = initRect(50,50,15,15);
    205a:	8d 45 b4             	lea    -0x4c(%ebp),%eax
    205d:	83 ec 04             	sub    $0x4,%esp
    2060:	6a 0f                	push   $0xf
    2062:	6a 0f                	push   $0xf
    2064:	6a 32                	push   $0x32
    2066:	6a 32                	push   $0x32
    2068:	50                   	push   %eax
    2069:	e8 b3 fb ff ff       	call   1c21 <initRect>
    206e:	83 c4 14             	add    $0x14,%esp
	Rect r4 = initRect(0,0,30,30);
    2071:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    2074:	83 ec 04             	sub    $0x4,%esp
    2077:	6a 1e                	push   $0x1e
    2079:	6a 1e                	push   $0x1e
    207b:	6a 00                	push   $0x0
    207d:	6a 00                	push   $0x0
    207f:	50                   	push   %eax
    2080:	e8 9c fb ff ff       	call   1c21 <initRect>
    2085:	83 c4 14             	add    $0x14,%esp
	Point p1 = initPoint(23, 23);
    2088:	8d 45 9c             	lea    -0x64(%ebp),%eax
    208b:	83 ec 04             	sub    $0x4,%esp
    208e:	6a 17                	push   $0x17
    2090:	6a 17                	push   $0x17
    2092:	50                   	push   %eax
    2093:	e8 62 fb ff ff       	call   1bfa <initPoint>
    2098:	83 c4 0c             	add    $0xc,%esp
	Point p2 = initPoint(70, 70);
    209b:	8d 45 94             	lea    -0x6c(%ebp),%eax
    209e:	83 ec 04             	sub    $0x4,%esp
    20a1:	6a 46                	push   $0x46
    20a3:	6a 46                	push   $0x46
    20a5:	50                   	push   %eax
    20a6:	e8 4f fb ff ff       	call   1bfa <initPoint>
    20ab:	83 c4 0c             	add    $0xc,%esp
	createClickable(&cm, r1, MSG_LPRESS, &testHanler);
    20ae:	83 ec 04             	sub    $0x4,%esp
    20b1:	68 f1 1f 00 00       	push   $0x1ff1
    20b6:	6a 02                	push   $0x2
    20b8:	ff 75 e0             	pushl  -0x20(%ebp)
    20bb:	ff 75 dc             	pushl  -0x24(%ebp)
    20be:	ff 75 d8             	pushl  -0x28(%ebp)
    20c1:	ff 75 d4             	pushl  -0x2c(%ebp)
    20c4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    20c7:	50                   	push   %eax
    20c8:	e8 36 fc ff ff       	call   1d03 <createClickable>
    20cd:	83 c4 20             	add    $0x20,%esp
	printf(0, "left_click: %d\n", cm.left_click);
    20d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    20d3:	83 ec 04             	sub    $0x4,%esp
    20d6:	50                   	push   %eax
    20d7:	68 23 90 00 00       	push   $0x9023
    20dc:	6a 00                	push   $0x0
    20de:	e8 0f 05 00 00       	call   25f2 <printf>
    20e3:	83 c4 10             	add    $0x10,%esp
	createClickable(&cm, r2, MSG_LPRESS, &testHanler);
    20e6:	83 ec 04             	sub    $0x4,%esp
    20e9:	68 f1 1f 00 00       	push   $0x1ff1
    20ee:	6a 02                	push   $0x2
    20f0:	ff 75 d0             	pushl  -0x30(%ebp)
    20f3:	ff 75 cc             	pushl  -0x34(%ebp)
    20f6:	ff 75 c8             	pushl  -0x38(%ebp)
    20f9:	ff 75 c4             	pushl  -0x3c(%ebp)
    20fc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    20ff:	50                   	push   %eax
    2100:	e8 fe fb ff ff       	call   1d03 <createClickable>
    2105:	83 c4 20             	add    $0x20,%esp
	printf(0, "left_click: %d\n", cm.left_click);
    2108:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    210b:	83 ec 04             	sub    $0x4,%esp
    210e:	50                   	push   %eax
    210f:	68 23 90 00 00       	push   $0x9023
    2114:	6a 00                	push   $0x0
    2116:	e8 d7 04 00 00       	call   25f2 <printf>
    211b:	83 c4 10             	add    $0x10,%esp
	createClickable(&cm, r3, MSG_LPRESS, &testHanler);
    211e:	83 ec 04             	sub    $0x4,%esp
    2121:	68 f1 1f 00 00       	push   $0x1ff1
    2126:	6a 02                	push   $0x2
    2128:	ff 75 c0             	pushl  -0x40(%ebp)
    212b:	ff 75 bc             	pushl  -0x44(%ebp)
    212e:	ff 75 b8             	pushl  -0x48(%ebp)
    2131:	ff 75 b4             	pushl  -0x4c(%ebp)
    2134:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    2137:	50                   	push   %eax
    2138:	e8 c6 fb ff ff       	call   1d03 <createClickable>
    213d:	83 c4 20             	add    $0x20,%esp
	printf(0, "left_click: %d\n", cm.left_click);
    2140:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2143:	83 ec 04             	sub    $0x4,%esp
    2146:	50                   	push   %eax
    2147:	68 23 90 00 00       	push   $0x9023
    214c:	6a 00                	push   $0x0
    214e:	e8 9f 04 00 00       	call   25f2 <printf>
    2153:	83 c4 10             	add    $0x10,%esp
	printClickableList(cm.left_click);
    2156:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2159:	83 ec 0c             	sub    $0xc,%esp
    215c:	50                   	push   %eax
    215d:	e8 3d fe ff ff       	call   1f9f <printClickableList>
    2162:	83 c4 10             	add    $0x10,%esp
	executeHandler(cm.left_click, p1);
    2165:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2168:	83 ec 04             	sub    $0x4,%esp
    216b:	ff 75 a0             	pushl  -0x60(%ebp)
    216e:	ff 75 9c             	pushl  -0x64(%ebp)
    2171:	50                   	push   %eax
    2172:	e8 44 fd ff ff       	call   1ebb <executeHandler>
    2177:	83 c4 10             	add    $0x10,%esp
	executeHandler(cm.left_click, p2);
    217a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    217d:	83 ec 04             	sub    $0x4,%esp
    2180:	ff 75 98             	pushl  -0x68(%ebp)
    2183:	ff 75 94             	pushl  -0x6c(%ebp)
    2186:	50                   	push   %eax
    2187:	e8 2f fd ff ff       	call   1ebb <executeHandler>
    218c:	83 c4 10             	add    $0x10,%esp
	deleteClickable(&cm.left_click, r4);
    218f:	83 ec 0c             	sub    $0xc,%esp
    2192:	ff 75 b0             	pushl  -0x50(%ebp)
    2195:	ff 75 ac             	pushl  -0x54(%ebp)
    2198:	ff 75 a8             	pushl  -0x58(%ebp)
    219b:	ff 75 a4             	pushl  -0x5c(%ebp)
    219e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    21a1:	50                   	push   %eax
    21a2:	e8 41 fc ff ff       	call   1de8 <deleteClickable>
    21a7:	83 c4 20             	add    $0x20,%esp
	printClickableList(cm.left_click);
    21aa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    21ad:	83 ec 0c             	sub    $0xc,%esp
    21b0:	50                   	push   %eax
    21b1:	e8 e9 fd ff ff       	call   1f9f <printClickableList>
    21b6:	83 c4 10             	add    $0x10,%esp
}
    21b9:	90                   	nop
    21ba:	c9                   	leave  
    21bb:	c3                   	ret    

000021bc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    21bc:	55                   	push   %ebp
    21bd:	89 e5                	mov    %esp,%ebp
    21bf:	57                   	push   %edi
    21c0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    21c1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    21c4:	8b 55 10             	mov    0x10(%ebp),%edx
    21c7:	8b 45 0c             	mov    0xc(%ebp),%eax
    21ca:	89 cb                	mov    %ecx,%ebx
    21cc:	89 df                	mov    %ebx,%edi
    21ce:	89 d1                	mov    %edx,%ecx
    21d0:	fc                   	cld    
    21d1:	f3 aa                	rep stos %al,%es:(%edi)
    21d3:	89 ca                	mov    %ecx,%edx
    21d5:	89 fb                	mov    %edi,%ebx
    21d7:	89 5d 08             	mov    %ebx,0x8(%ebp)
    21da:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    21dd:	90                   	nop
    21de:	5b                   	pop    %ebx
    21df:	5f                   	pop    %edi
    21e0:	5d                   	pop    %ebp
    21e1:	c3                   	ret    

000021e2 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    21e2:	55                   	push   %ebp
    21e3:	89 e5                	mov    %esp,%ebp
    21e5:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    21e8:	8b 45 08             	mov    0x8(%ebp),%eax
    21eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    21ee:	90                   	nop
    21ef:	8b 45 08             	mov    0x8(%ebp),%eax
    21f2:	8d 50 01             	lea    0x1(%eax),%edx
    21f5:	89 55 08             	mov    %edx,0x8(%ebp)
    21f8:	8b 55 0c             	mov    0xc(%ebp),%edx
    21fb:	8d 4a 01             	lea    0x1(%edx),%ecx
    21fe:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    2201:	0f b6 12             	movzbl (%edx),%edx
    2204:	88 10                	mov    %dl,(%eax)
    2206:	0f b6 00             	movzbl (%eax),%eax
    2209:	84 c0                	test   %al,%al
    220b:	75 e2                	jne    21ef <strcpy+0xd>
    ;
  return os;
    220d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    2210:	c9                   	leave  
    2211:	c3                   	ret    

00002212 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    2212:	55                   	push   %ebp
    2213:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    2215:	eb 08                	jmp    221f <strcmp+0xd>
    p++, q++;
    2217:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    221b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    221f:	8b 45 08             	mov    0x8(%ebp),%eax
    2222:	0f b6 00             	movzbl (%eax),%eax
    2225:	84 c0                	test   %al,%al
    2227:	74 10                	je     2239 <strcmp+0x27>
    2229:	8b 45 08             	mov    0x8(%ebp),%eax
    222c:	0f b6 10             	movzbl (%eax),%edx
    222f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2232:	0f b6 00             	movzbl (%eax),%eax
    2235:	38 c2                	cmp    %al,%dl
    2237:	74 de                	je     2217 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    2239:	8b 45 08             	mov    0x8(%ebp),%eax
    223c:	0f b6 00             	movzbl (%eax),%eax
    223f:	0f b6 d0             	movzbl %al,%edx
    2242:	8b 45 0c             	mov    0xc(%ebp),%eax
    2245:	0f b6 00             	movzbl (%eax),%eax
    2248:	0f b6 c0             	movzbl %al,%eax
    224b:	29 c2                	sub    %eax,%edx
    224d:	89 d0                	mov    %edx,%eax
}
    224f:	5d                   	pop    %ebp
    2250:	c3                   	ret    

00002251 <strlen>:

uint
strlen(char *s)
{
    2251:	55                   	push   %ebp
    2252:	89 e5                	mov    %esp,%ebp
    2254:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    2257:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    225e:	eb 04                	jmp    2264 <strlen+0x13>
    2260:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    2264:	8b 55 fc             	mov    -0x4(%ebp),%edx
    2267:	8b 45 08             	mov    0x8(%ebp),%eax
    226a:	01 d0                	add    %edx,%eax
    226c:	0f b6 00             	movzbl (%eax),%eax
    226f:	84 c0                	test   %al,%al
    2271:	75 ed                	jne    2260 <strlen+0xf>
    ;
  return n;
    2273:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    2276:	c9                   	leave  
    2277:	c3                   	ret    

00002278 <memset>:

void*
memset(void *dst, int c, uint n)
{
    2278:	55                   	push   %ebp
    2279:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    227b:	8b 45 10             	mov    0x10(%ebp),%eax
    227e:	50                   	push   %eax
    227f:	ff 75 0c             	pushl  0xc(%ebp)
    2282:	ff 75 08             	pushl  0x8(%ebp)
    2285:	e8 32 ff ff ff       	call   21bc <stosb>
    228a:	83 c4 0c             	add    $0xc,%esp
  return dst;
    228d:	8b 45 08             	mov    0x8(%ebp),%eax
}
    2290:	c9                   	leave  
    2291:	c3                   	ret    

00002292 <strchr>:

char*
strchr(const char *s, char c)
{
    2292:	55                   	push   %ebp
    2293:	89 e5                	mov    %esp,%ebp
    2295:	83 ec 04             	sub    $0x4,%esp
    2298:	8b 45 0c             	mov    0xc(%ebp),%eax
    229b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    229e:	eb 14                	jmp    22b4 <strchr+0x22>
    if(*s == c)
    22a0:	8b 45 08             	mov    0x8(%ebp),%eax
    22a3:	0f b6 00             	movzbl (%eax),%eax
    22a6:	3a 45 fc             	cmp    -0x4(%ebp),%al
    22a9:	75 05                	jne    22b0 <strchr+0x1e>
      return (char*)s;
    22ab:	8b 45 08             	mov    0x8(%ebp),%eax
    22ae:	eb 13                	jmp    22c3 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    22b0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    22b4:	8b 45 08             	mov    0x8(%ebp),%eax
    22b7:	0f b6 00             	movzbl (%eax),%eax
    22ba:	84 c0                	test   %al,%al
    22bc:	75 e2                	jne    22a0 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    22be:	b8 00 00 00 00       	mov    $0x0,%eax
}
    22c3:	c9                   	leave  
    22c4:	c3                   	ret    

000022c5 <gets>:

char*
gets(char *buf, int max)
{
    22c5:	55                   	push   %ebp
    22c6:	89 e5                	mov    %esp,%ebp
    22c8:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    22cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    22d2:	eb 42                	jmp    2316 <gets+0x51>
    cc = read(0, &c, 1);
    22d4:	83 ec 04             	sub    $0x4,%esp
    22d7:	6a 01                	push   $0x1
    22d9:	8d 45 ef             	lea    -0x11(%ebp),%eax
    22dc:	50                   	push   %eax
    22dd:	6a 00                	push   $0x0
    22df:	e8 47 01 00 00       	call   242b <read>
    22e4:	83 c4 10             	add    $0x10,%esp
    22e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    22ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    22ee:	7e 33                	jle    2323 <gets+0x5e>
      break;
    buf[i++] = c;
    22f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    22f3:	8d 50 01             	lea    0x1(%eax),%edx
    22f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
    22f9:	89 c2                	mov    %eax,%edx
    22fb:	8b 45 08             	mov    0x8(%ebp),%eax
    22fe:	01 c2                	add    %eax,%edx
    2300:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    2304:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    2306:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    230a:	3c 0a                	cmp    $0xa,%al
    230c:	74 16                	je     2324 <gets+0x5f>
    230e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    2312:	3c 0d                	cmp    $0xd,%al
    2314:	74 0e                	je     2324 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    2316:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2319:	83 c0 01             	add    $0x1,%eax
    231c:	3b 45 0c             	cmp    0xc(%ebp),%eax
    231f:	7c b3                	jl     22d4 <gets+0xf>
    2321:	eb 01                	jmp    2324 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    2323:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    2324:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2327:	8b 45 08             	mov    0x8(%ebp),%eax
    232a:	01 d0                	add    %edx,%eax
    232c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    232f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    2332:	c9                   	leave  
    2333:	c3                   	ret    

00002334 <stat>:

int
stat(char *n, struct stat *st)
{
    2334:	55                   	push   %ebp
    2335:	89 e5                	mov    %esp,%ebp
    2337:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    233a:	83 ec 08             	sub    $0x8,%esp
    233d:	6a 00                	push   $0x0
    233f:	ff 75 08             	pushl  0x8(%ebp)
    2342:	e8 0c 01 00 00       	call   2453 <open>
    2347:	83 c4 10             	add    $0x10,%esp
    234a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    234d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2351:	79 07                	jns    235a <stat+0x26>
    return -1;
    2353:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    2358:	eb 25                	jmp    237f <stat+0x4b>
  r = fstat(fd, st);
    235a:	83 ec 08             	sub    $0x8,%esp
    235d:	ff 75 0c             	pushl  0xc(%ebp)
    2360:	ff 75 f4             	pushl  -0xc(%ebp)
    2363:	e8 03 01 00 00       	call   246b <fstat>
    2368:	83 c4 10             	add    $0x10,%esp
    236b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    236e:	83 ec 0c             	sub    $0xc,%esp
    2371:	ff 75 f4             	pushl  -0xc(%ebp)
    2374:	e8 c2 00 00 00       	call   243b <close>
    2379:	83 c4 10             	add    $0x10,%esp
  return r;
    237c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    237f:	c9                   	leave  
    2380:	c3                   	ret    

00002381 <atoi>:

int
atoi(const char *s)
{
    2381:	55                   	push   %ebp
    2382:	89 e5                	mov    %esp,%ebp
    2384:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    2387:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    238e:	eb 25                	jmp    23b5 <atoi+0x34>
    n = n*10 + *s++ - '0';
    2390:	8b 55 fc             	mov    -0x4(%ebp),%edx
    2393:	89 d0                	mov    %edx,%eax
    2395:	c1 e0 02             	shl    $0x2,%eax
    2398:	01 d0                	add    %edx,%eax
    239a:	01 c0                	add    %eax,%eax
    239c:	89 c1                	mov    %eax,%ecx
    239e:	8b 45 08             	mov    0x8(%ebp),%eax
    23a1:	8d 50 01             	lea    0x1(%eax),%edx
    23a4:	89 55 08             	mov    %edx,0x8(%ebp)
    23a7:	0f b6 00             	movzbl (%eax),%eax
    23aa:	0f be c0             	movsbl %al,%eax
    23ad:	01 c8                	add    %ecx,%eax
    23af:	83 e8 30             	sub    $0x30,%eax
    23b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    23b5:	8b 45 08             	mov    0x8(%ebp),%eax
    23b8:	0f b6 00             	movzbl (%eax),%eax
    23bb:	3c 2f                	cmp    $0x2f,%al
    23bd:	7e 0a                	jle    23c9 <atoi+0x48>
    23bf:	8b 45 08             	mov    0x8(%ebp),%eax
    23c2:	0f b6 00             	movzbl (%eax),%eax
    23c5:	3c 39                	cmp    $0x39,%al
    23c7:	7e c7                	jle    2390 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    23c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    23cc:	c9                   	leave  
    23cd:	c3                   	ret    

000023ce <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    23ce:	55                   	push   %ebp
    23cf:	89 e5                	mov    %esp,%ebp
    23d1:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    23d4:	8b 45 08             	mov    0x8(%ebp),%eax
    23d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    23da:	8b 45 0c             	mov    0xc(%ebp),%eax
    23dd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    23e0:	eb 17                	jmp    23f9 <memmove+0x2b>
    *dst++ = *src++;
    23e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    23e5:	8d 50 01             	lea    0x1(%eax),%edx
    23e8:	89 55 fc             	mov    %edx,-0x4(%ebp)
    23eb:	8b 55 f8             	mov    -0x8(%ebp),%edx
    23ee:	8d 4a 01             	lea    0x1(%edx),%ecx
    23f1:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    23f4:	0f b6 12             	movzbl (%edx),%edx
    23f7:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    23f9:	8b 45 10             	mov    0x10(%ebp),%eax
    23fc:	8d 50 ff             	lea    -0x1(%eax),%edx
    23ff:	89 55 10             	mov    %edx,0x10(%ebp)
    2402:	85 c0                	test   %eax,%eax
    2404:	7f dc                	jg     23e2 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    2406:	8b 45 08             	mov    0x8(%ebp),%eax
}
    2409:	c9                   	leave  
    240a:	c3                   	ret    

0000240b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    240b:	b8 01 00 00 00       	mov    $0x1,%eax
    2410:	cd 40                	int    $0x40
    2412:	c3                   	ret    

00002413 <exit>:
SYSCALL(exit)
    2413:	b8 02 00 00 00       	mov    $0x2,%eax
    2418:	cd 40                	int    $0x40
    241a:	c3                   	ret    

0000241b <wait>:
SYSCALL(wait)
    241b:	b8 03 00 00 00       	mov    $0x3,%eax
    2420:	cd 40                	int    $0x40
    2422:	c3                   	ret    

00002423 <pipe>:
SYSCALL(pipe)
    2423:	b8 04 00 00 00       	mov    $0x4,%eax
    2428:	cd 40                	int    $0x40
    242a:	c3                   	ret    

0000242b <read>:
SYSCALL(read)
    242b:	b8 05 00 00 00       	mov    $0x5,%eax
    2430:	cd 40                	int    $0x40
    2432:	c3                   	ret    

00002433 <write>:
SYSCALL(write)
    2433:	b8 10 00 00 00       	mov    $0x10,%eax
    2438:	cd 40                	int    $0x40
    243a:	c3                   	ret    

0000243b <close>:
SYSCALL(close)
    243b:	b8 15 00 00 00       	mov    $0x15,%eax
    2440:	cd 40                	int    $0x40
    2442:	c3                   	ret    

00002443 <kill>:
SYSCALL(kill)
    2443:	b8 06 00 00 00       	mov    $0x6,%eax
    2448:	cd 40                	int    $0x40
    244a:	c3                   	ret    

0000244b <exec>:
SYSCALL(exec)
    244b:	b8 07 00 00 00       	mov    $0x7,%eax
    2450:	cd 40                	int    $0x40
    2452:	c3                   	ret    

00002453 <open>:
SYSCALL(open)
    2453:	b8 0f 00 00 00       	mov    $0xf,%eax
    2458:	cd 40                	int    $0x40
    245a:	c3                   	ret    

0000245b <mknod>:
SYSCALL(mknod)
    245b:	b8 11 00 00 00       	mov    $0x11,%eax
    2460:	cd 40                	int    $0x40
    2462:	c3                   	ret    

00002463 <unlink>:
SYSCALL(unlink)
    2463:	b8 12 00 00 00       	mov    $0x12,%eax
    2468:	cd 40                	int    $0x40
    246a:	c3                   	ret    

0000246b <fstat>:
SYSCALL(fstat)
    246b:	b8 08 00 00 00       	mov    $0x8,%eax
    2470:	cd 40                	int    $0x40
    2472:	c3                   	ret    

00002473 <link>:
SYSCALL(link)
    2473:	b8 13 00 00 00       	mov    $0x13,%eax
    2478:	cd 40                	int    $0x40
    247a:	c3                   	ret    

0000247b <mkdir>:
SYSCALL(mkdir)
    247b:	b8 14 00 00 00       	mov    $0x14,%eax
    2480:	cd 40                	int    $0x40
    2482:	c3                   	ret    

00002483 <chdir>:
SYSCALL(chdir)
    2483:	b8 09 00 00 00       	mov    $0x9,%eax
    2488:	cd 40                	int    $0x40
    248a:	c3                   	ret    

0000248b <dup>:
SYSCALL(dup)
    248b:	b8 0a 00 00 00       	mov    $0xa,%eax
    2490:	cd 40                	int    $0x40
    2492:	c3                   	ret    

00002493 <getpid>:
SYSCALL(getpid)
    2493:	b8 0b 00 00 00       	mov    $0xb,%eax
    2498:	cd 40                	int    $0x40
    249a:	c3                   	ret    

0000249b <sbrk>:
SYSCALL(sbrk)
    249b:	b8 0c 00 00 00       	mov    $0xc,%eax
    24a0:	cd 40                	int    $0x40
    24a2:	c3                   	ret    

000024a3 <sleep>:
SYSCALL(sleep)
    24a3:	b8 0d 00 00 00       	mov    $0xd,%eax
    24a8:	cd 40                	int    $0x40
    24aa:	c3                   	ret    

000024ab <uptime>:
SYSCALL(uptime)
    24ab:	b8 0e 00 00 00       	mov    $0xe,%eax
    24b0:	cd 40                	int    $0x40
    24b2:	c3                   	ret    

000024b3 <getMsg>:
SYSCALL(getMsg)
    24b3:	b8 16 00 00 00       	mov    $0x16,%eax
    24b8:	cd 40                	int    $0x40
    24ba:	c3                   	ret    

000024bb <createWindow>:
SYSCALL(createWindow)
    24bb:	b8 17 00 00 00       	mov    $0x17,%eax
    24c0:	cd 40                	int    $0x40
    24c2:	c3                   	ret    

000024c3 <destroyWindow>:
SYSCALL(destroyWindow)
    24c3:	b8 18 00 00 00       	mov    $0x18,%eax
    24c8:	cd 40                	int    $0x40
    24ca:	c3                   	ret    

000024cb <updateWindow>:
SYSCALL(updateWindow)
    24cb:	b8 19 00 00 00       	mov    $0x19,%eax
    24d0:	cd 40                	int    $0x40
    24d2:	c3                   	ret    

000024d3 <updatePartialWindow>:
SYSCALL(updatePartialWindow)
    24d3:	b8 1a 00 00 00       	mov    $0x1a,%eax
    24d8:	cd 40                	int    $0x40
    24da:	c3                   	ret    

000024db <kwrite>:
SYSCALL(kwrite)
    24db:	b8 1c 00 00 00       	mov    $0x1c,%eax
    24e0:	cd 40                	int    $0x40
    24e2:	c3                   	ret    

000024e3 <setSampleRate>:
SYSCALL(setSampleRate)
    24e3:	b8 1b 00 00 00       	mov    $0x1b,%eax
    24e8:	cd 40                	int    $0x40
    24ea:	c3                   	ret    

000024eb <pause>:
SYSCALL(pause)
    24eb:	b8 1d 00 00 00       	mov    $0x1d,%eax
    24f0:	cd 40                	int    $0x40
    24f2:	c3                   	ret    

000024f3 <wavdecode>:
SYSCALL(wavdecode)
    24f3:	b8 1e 00 00 00       	mov    $0x1e,%eax
    24f8:	cd 40                	int    $0x40
    24fa:	c3                   	ret    

000024fb <beginDecode>:
SYSCALL(beginDecode)
    24fb:	b8 1f 00 00 00       	mov    $0x1f,%eax
    2500:	cd 40                	int    $0x40
    2502:	c3                   	ret    

00002503 <waitForDecode>:
SYSCALL(waitForDecode)
    2503:	b8 20 00 00 00       	mov    $0x20,%eax
    2508:	cd 40                	int    $0x40
    250a:	c3                   	ret    

0000250b <endDecode>:
SYSCALL(endDecode)
    250b:	b8 21 00 00 00       	mov    $0x21,%eax
    2510:	cd 40                	int    $0x40
    2512:	c3                   	ret    

00002513 <getCoreBuf>:
    2513:	b8 22 00 00 00       	mov    $0x22,%eax
    2518:	cd 40                	int    $0x40
    251a:	c3                   	ret    

0000251b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    251b:	55                   	push   %ebp
    251c:	89 e5                	mov    %esp,%ebp
    251e:	83 ec 18             	sub    $0x18,%esp
    2521:	8b 45 0c             	mov    0xc(%ebp),%eax
    2524:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    2527:	83 ec 04             	sub    $0x4,%esp
    252a:	6a 01                	push   $0x1
    252c:	8d 45 f4             	lea    -0xc(%ebp),%eax
    252f:	50                   	push   %eax
    2530:	ff 75 08             	pushl  0x8(%ebp)
    2533:	e8 fb fe ff ff       	call   2433 <write>
    2538:	83 c4 10             	add    $0x10,%esp
}
    253b:	90                   	nop
    253c:	c9                   	leave  
    253d:	c3                   	ret    

0000253e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    253e:	55                   	push   %ebp
    253f:	89 e5                	mov    %esp,%ebp
    2541:	53                   	push   %ebx
    2542:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    2545:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    254c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    2550:	74 17                	je     2569 <printint+0x2b>
    2552:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    2556:	79 11                	jns    2569 <printint+0x2b>
    neg = 1;
    2558:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    255f:	8b 45 0c             	mov    0xc(%ebp),%eax
    2562:	f7 d8                	neg    %eax
    2564:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2567:	eb 06                	jmp    256f <printint+0x31>
  } else {
    x = xx;
    2569:	8b 45 0c             	mov    0xc(%ebp),%eax
    256c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    256f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    2576:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    2579:	8d 41 01             	lea    0x1(%ecx),%eax
    257c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    257f:	8b 5d 10             	mov    0x10(%ebp),%ebx
    2582:	8b 45 ec             	mov    -0x14(%ebp),%eax
    2585:	ba 00 00 00 00       	mov    $0x0,%edx
    258a:	f7 f3                	div    %ebx
    258c:	89 d0                	mov    %edx,%eax
    258e:	0f b6 80 9c c6 00 00 	movzbl 0xc69c(%eax),%eax
    2595:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    2599:	8b 5d 10             	mov    0x10(%ebp),%ebx
    259c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    259f:	ba 00 00 00 00       	mov    $0x0,%edx
    25a4:	f7 f3                	div    %ebx
    25a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    25a9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    25ad:	75 c7                	jne    2576 <printint+0x38>
  if(neg)
    25af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    25b3:	74 2d                	je     25e2 <printint+0xa4>
    buf[i++] = '-';
    25b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25b8:	8d 50 01             	lea    0x1(%eax),%edx
    25bb:	89 55 f4             	mov    %edx,-0xc(%ebp)
    25be:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    25c3:	eb 1d                	jmp    25e2 <printint+0xa4>
    putc(fd, buf[i]);
    25c5:	8d 55 dc             	lea    -0x24(%ebp),%edx
    25c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    25cb:	01 d0                	add    %edx,%eax
    25cd:	0f b6 00             	movzbl (%eax),%eax
    25d0:	0f be c0             	movsbl %al,%eax
    25d3:	83 ec 08             	sub    $0x8,%esp
    25d6:	50                   	push   %eax
    25d7:	ff 75 08             	pushl  0x8(%ebp)
    25da:	e8 3c ff ff ff       	call   251b <putc>
    25df:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    25e2:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    25e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    25ea:	79 d9                	jns    25c5 <printint+0x87>
    putc(fd, buf[i]);
}
    25ec:	90                   	nop
    25ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    25f0:	c9                   	leave  
    25f1:	c3                   	ret    

000025f2 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    25f2:	55                   	push   %ebp
    25f3:	89 e5                	mov    %esp,%ebp
    25f5:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    25f8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    25ff:	8d 45 0c             	lea    0xc(%ebp),%eax
    2602:	83 c0 04             	add    $0x4,%eax
    2605:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    2608:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    260f:	e9 59 01 00 00       	jmp    276d <printf+0x17b>
    c = fmt[i] & 0xff;
    2614:	8b 55 0c             	mov    0xc(%ebp),%edx
    2617:	8b 45 f0             	mov    -0x10(%ebp),%eax
    261a:	01 d0                	add    %edx,%eax
    261c:	0f b6 00             	movzbl (%eax),%eax
    261f:	0f be c0             	movsbl %al,%eax
    2622:	25 ff 00 00 00       	and    $0xff,%eax
    2627:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    262a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    262e:	75 2c                	jne    265c <printf+0x6a>
      if(c == '%'){
    2630:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    2634:	75 0c                	jne    2642 <printf+0x50>
        state = '%';
    2636:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    263d:	e9 27 01 00 00       	jmp    2769 <printf+0x177>
      } else {
        putc(fd, c);
    2642:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2645:	0f be c0             	movsbl %al,%eax
    2648:	83 ec 08             	sub    $0x8,%esp
    264b:	50                   	push   %eax
    264c:	ff 75 08             	pushl  0x8(%ebp)
    264f:	e8 c7 fe ff ff       	call   251b <putc>
    2654:	83 c4 10             	add    $0x10,%esp
    2657:	e9 0d 01 00 00       	jmp    2769 <printf+0x177>
      }
    } else if(state == '%'){
    265c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    2660:	0f 85 03 01 00 00    	jne    2769 <printf+0x177>
      if(c == 'd'){
    2666:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    266a:	75 1e                	jne    268a <printf+0x98>
        printint(fd, *ap, 10, 1);
    266c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    266f:	8b 00                	mov    (%eax),%eax
    2671:	6a 01                	push   $0x1
    2673:	6a 0a                	push   $0xa
    2675:	50                   	push   %eax
    2676:	ff 75 08             	pushl  0x8(%ebp)
    2679:	e8 c0 fe ff ff       	call   253e <printint>
    267e:	83 c4 10             	add    $0x10,%esp
        ap++;
    2681:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    2685:	e9 d8 00 00 00       	jmp    2762 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    268a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    268e:	74 06                	je     2696 <printf+0xa4>
    2690:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    2694:	75 1e                	jne    26b4 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    2696:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2699:	8b 00                	mov    (%eax),%eax
    269b:	6a 00                	push   $0x0
    269d:	6a 10                	push   $0x10
    269f:	50                   	push   %eax
    26a0:	ff 75 08             	pushl  0x8(%ebp)
    26a3:	e8 96 fe ff ff       	call   253e <printint>
    26a8:	83 c4 10             	add    $0x10,%esp
        ap++;
    26ab:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    26af:	e9 ae 00 00 00       	jmp    2762 <printf+0x170>
      } else if(c == 's'){
    26b4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    26b8:	75 43                	jne    26fd <printf+0x10b>
        s = (char*)*ap;
    26ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
    26bd:	8b 00                	mov    (%eax),%eax
    26bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    26c2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    26c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    26ca:	75 25                	jne    26f1 <printf+0xff>
          s = "(null)";
    26cc:	c7 45 f4 33 90 00 00 	movl   $0x9033,-0xc(%ebp)
        while(*s != 0){
    26d3:	eb 1c                	jmp    26f1 <printf+0xff>
          putc(fd, *s);
    26d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26d8:	0f b6 00             	movzbl (%eax),%eax
    26db:	0f be c0             	movsbl %al,%eax
    26de:	83 ec 08             	sub    $0x8,%esp
    26e1:	50                   	push   %eax
    26e2:	ff 75 08             	pushl  0x8(%ebp)
    26e5:	e8 31 fe ff ff       	call   251b <putc>
    26ea:	83 c4 10             	add    $0x10,%esp
          s++;
    26ed:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    26f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    26f4:	0f b6 00             	movzbl (%eax),%eax
    26f7:	84 c0                	test   %al,%al
    26f9:	75 da                	jne    26d5 <printf+0xe3>
    26fb:	eb 65                	jmp    2762 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    26fd:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    2701:	75 1d                	jne    2720 <printf+0x12e>
        putc(fd, *ap);
    2703:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2706:	8b 00                	mov    (%eax),%eax
    2708:	0f be c0             	movsbl %al,%eax
    270b:	83 ec 08             	sub    $0x8,%esp
    270e:	50                   	push   %eax
    270f:	ff 75 08             	pushl  0x8(%ebp)
    2712:	e8 04 fe ff ff       	call   251b <putc>
    2717:	83 c4 10             	add    $0x10,%esp
        ap++;
    271a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    271e:	eb 42                	jmp    2762 <printf+0x170>
      } else if(c == '%'){
    2720:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    2724:	75 17                	jne    273d <printf+0x14b>
        putc(fd, c);
    2726:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2729:	0f be c0             	movsbl %al,%eax
    272c:	83 ec 08             	sub    $0x8,%esp
    272f:	50                   	push   %eax
    2730:	ff 75 08             	pushl  0x8(%ebp)
    2733:	e8 e3 fd ff ff       	call   251b <putc>
    2738:	83 c4 10             	add    $0x10,%esp
    273b:	eb 25                	jmp    2762 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    273d:	83 ec 08             	sub    $0x8,%esp
    2740:	6a 25                	push   $0x25
    2742:	ff 75 08             	pushl  0x8(%ebp)
    2745:	e8 d1 fd ff ff       	call   251b <putc>
    274a:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    274d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2750:	0f be c0             	movsbl %al,%eax
    2753:	83 ec 08             	sub    $0x8,%esp
    2756:	50                   	push   %eax
    2757:	ff 75 08             	pushl  0x8(%ebp)
    275a:	e8 bc fd ff ff       	call   251b <putc>
    275f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    2762:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2769:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    276d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2770:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2773:	01 d0                	add    %edx,%eax
    2775:	0f b6 00             	movzbl (%eax),%eax
    2778:	84 c0                	test   %al,%al
    277a:	0f 85 94 fe ff ff    	jne    2614 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    2780:	90                   	nop
    2781:	c9                   	leave  
    2782:	c3                   	ret    

00002783 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    2783:	55                   	push   %ebp
    2784:	89 e5                	mov    %esp,%ebp
    2786:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    2789:	8b 45 08             	mov    0x8(%ebp),%eax
    278c:	83 e8 08             	sub    $0x8,%eax
    278f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    2792:	a1 a8 cb 00 00       	mov    0xcba8,%eax
    2797:	89 45 fc             	mov    %eax,-0x4(%ebp)
    279a:	eb 24                	jmp    27c0 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    279c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    279f:	8b 00                	mov    (%eax),%eax
    27a1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    27a4:	77 12                	ja     27b8 <free+0x35>
    27a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    27a9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    27ac:	77 24                	ja     27d2 <free+0x4f>
    27ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
    27b1:	8b 00                	mov    (%eax),%eax
    27b3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    27b6:	77 1a                	ja     27d2 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    27b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    27bb:	8b 00                	mov    (%eax),%eax
    27bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
    27c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    27c3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    27c6:	76 d4                	jbe    279c <free+0x19>
    27c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    27cb:	8b 00                	mov    (%eax),%eax
    27cd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    27d0:	76 ca                	jbe    279c <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    27d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    27d5:	8b 40 04             	mov    0x4(%eax),%eax
    27d8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    27df:	8b 45 f8             	mov    -0x8(%ebp),%eax
    27e2:	01 c2                	add    %eax,%edx
    27e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    27e7:	8b 00                	mov    (%eax),%eax
    27e9:	39 c2                	cmp    %eax,%edx
    27eb:	75 24                	jne    2811 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    27ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
    27f0:	8b 50 04             	mov    0x4(%eax),%edx
    27f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    27f6:	8b 00                	mov    (%eax),%eax
    27f8:	8b 40 04             	mov    0x4(%eax),%eax
    27fb:	01 c2                	add    %eax,%edx
    27fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2800:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    2803:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2806:	8b 00                	mov    (%eax),%eax
    2808:	8b 10                	mov    (%eax),%edx
    280a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    280d:	89 10                	mov    %edx,(%eax)
    280f:	eb 0a                	jmp    281b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    2811:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2814:	8b 10                	mov    (%eax),%edx
    2816:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2819:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    281b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    281e:	8b 40 04             	mov    0x4(%eax),%eax
    2821:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    2828:	8b 45 fc             	mov    -0x4(%ebp),%eax
    282b:	01 d0                	add    %edx,%eax
    282d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    2830:	75 20                	jne    2852 <free+0xcf>
    p->s.size += bp->s.size;
    2832:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2835:	8b 50 04             	mov    0x4(%eax),%edx
    2838:	8b 45 f8             	mov    -0x8(%ebp),%eax
    283b:	8b 40 04             	mov    0x4(%eax),%eax
    283e:	01 c2                	add    %eax,%edx
    2840:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2843:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    2846:	8b 45 f8             	mov    -0x8(%ebp),%eax
    2849:	8b 10                	mov    (%eax),%edx
    284b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    284e:	89 10                	mov    %edx,(%eax)
    2850:	eb 08                	jmp    285a <free+0xd7>
  } else
    p->s.ptr = bp;
    2852:	8b 45 fc             	mov    -0x4(%ebp),%eax
    2855:	8b 55 f8             	mov    -0x8(%ebp),%edx
    2858:	89 10                	mov    %edx,(%eax)
  freep = p;
    285a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    285d:	a3 a8 cb 00 00       	mov    %eax,0xcba8
}
    2862:	90                   	nop
    2863:	c9                   	leave  
    2864:	c3                   	ret    

00002865 <morecore>:

static Header*
morecore(uint nu)
{
    2865:	55                   	push   %ebp
    2866:	89 e5                	mov    %esp,%ebp
    2868:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    286b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    2872:	77 07                	ja     287b <morecore+0x16>
    nu = 4096;
    2874:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    287b:	8b 45 08             	mov    0x8(%ebp),%eax
    287e:	c1 e0 03             	shl    $0x3,%eax
    2881:	83 ec 0c             	sub    $0xc,%esp
    2884:	50                   	push   %eax
    2885:	e8 11 fc ff ff       	call   249b <sbrk>
    288a:	83 c4 10             	add    $0x10,%esp
    288d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    2890:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    2894:	75 07                	jne    289d <morecore+0x38>
    return 0;
    2896:	b8 00 00 00 00       	mov    $0x0,%eax
    289b:	eb 26                	jmp    28c3 <morecore+0x5e>
  hp = (Header*)p;
    289d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    28a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    28a6:	8b 55 08             	mov    0x8(%ebp),%edx
    28a9:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    28ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    28af:	83 c0 08             	add    $0x8,%eax
    28b2:	83 ec 0c             	sub    $0xc,%esp
    28b5:	50                   	push   %eax
    28b6:	e8 c8 fe ff ff       	call   2783 <free>
    28bb:	83 c4 10             	add    $0x10,%esp
  return freep;
    28be:	a1 a8 cb 00 00       	mov    0xcba8,%eax
}
    28c3:	c9                   	leave  
    28c4:	c3                   	ret    

000028c5 <malloc>:

void*
malloc(uint nbytes)
{
    28c5:	55                   	push   %ebp
    28c6:	89 e5                	mov    %esp,%ebp
    28c8:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    28cb:	8b 45 08             	mov    0x8(%ebp),%eax
    28ce:	83 c0 07             	add    $0x7,%eax
    28d1:	c1 e8 03             	shr    $0x3,%eax
    28d4:	83 c0 01             	add    $0x1,%eax
    28d7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    28da:	a1 a8 cb 00 00       	mov    0xcba8,%eax
    28df:	89 45 f0             	mov    %eax,-0x10(%ebp)
    28e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    28e6:	75 23                	jne    290b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    28e8:	c7 45 f0 a0 cb 00 00 	movl   $0xcba0,-0x10(%ebp)
    28ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    28f2:	a3 a8 cb 00 00       	mov    %eax,0xcba8
    28f7:	a1 a8 cb 00 00       	mov    0xcba8,%eax
    28fc:	a3 a0 cb 00 00       	mov    %eax,0xcba0
    base.s.size = 0;
    2901:	c7 05 a4 cb 00 00 00 	movl   $0x0,0xcba4
    2908:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    290b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    290e:	8b 00                	mov    (%eax),%eax
    2910:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    2913:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2916:	8b 40 04             	mov    0x4(%eax),%eax
    2919:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    291c:	72 4d                	jb     296b <malloc+0xa6>
      if(p->s.size == nunits)
    291e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2921:	8b 40 04             	mov    0x4(%eax),%eax
    2924:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    2927:	75 0c                	jne    2935 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    2929:	8b 45 f4             	mov    -0xc(%ebp),%eax
    292c:	8b 10                	mov    (%eax),%edx
    292e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    2931:	89 10                	mov    %edx,(%eax)
    2933:	eb 26                	jmp    295b <malloc+0x96>
      else {
        p->s.size -= nunits;
    2935:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2938:	8b 40 04             	mov    0x4(%eax),%eax
    293b:	2b 45 ec             	sub    -0x14(%ebp),%eax
    293e:	89 c2                	mov    %eax,%edx
    2940:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2943:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    2946:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2949:	8b 40 04             	mov    0x4(%eax),%eax
    294c:	c1 e0 03             	shl    $0x3,%eax
    294f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    2952:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2955:	8b 55 ec             	mov    -0x14(%ebp),%edx
    2958:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    295b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    295e:	a3 a8 cb 00 00       	mov    %eax,0xcba8
      return (void*)(p + 1);
    2963:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2966:	83 c0 08             	add    $0x8,%eax
    2969:	eb 3b                	jmp    29a6 <malloc+0xe1>
    }
    if(p == freep)
    296b:	a1 a8 cb 00 00       	mov    0xcba8,%eax
    2970:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    2973:	75 1e                	jne    2993 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    2975:	83 ec 0c             	sub    $0xc,%esp
    2978:	ff 75 ec             	pushl  -0x14(%ebp)
    297b:	e8 e5 fe ff ff       	call   2865 <morecore>
    2980:	83 c4 10             	add    $0x10,%esp
    2983:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2986:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    298a:	75 07                	jne    2993 <malloc+0xce>
        return 0;
    298c:	b8 00 00 00 00       	mov    $0x0,%eax
    2991:	eb 13                	jmp    29a6 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2993:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2996:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2999:	8b 45 f4             	mov    -0xc(%ebp),%eax
    299c:	8b 00                	mov    (%eax),%eax
    299e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    29a1:	e9 6d ff ff ff       	jmp    2913 <malloc+0x4e>
}
    29a6:	c9                   	leave  
    29a7:	c3                   	ret    

000029a8 <abs>:
#include "math.h"
#define pi 3.1415926535898 
int abs(int x)
{
    29a8:	55                   	push   %ebp
    29a9:	89 e5                	mov    %esp,%ebp
	if (x < 0)
    29ab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    29af:	79 07                	jns    29b8 <abs+0x10>
		return x * -1;
    29b1:	8b 45 08             	mov    0x8(%ebp),%eax
    29b4:	f7 d8                	neg    %eax
    29b6:	eb 03                	jmp    29bb <abs+0x13>
	else
		return x;
    29b8:	8b 45 08             	mov    0x8(%ebp),%eax
}
    29bb:	5d                   	pop    %ebp
    29bc:	c3                   	ret    

000029bd <sin>:
double sin(double x)  
{  
    29bd:	55                   	push   %ebp
    29be:	89 e5                	mov    %esp,%ebp
    29c0:	83 ec 40             	sub    $0x40,%esp
    29c3:	8b 45 08             	mov    0x8(%ebp),%eax
    29c6:	89 45 c8             	mov    %eax,-0x38(%ebp)
    29c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    29cc:	89 45 cc             	mov    %eax,-0x34(%ebp)
	double Result=x,Fac=1.0,Xn=x,Precious=x;  
    29cf:	dd 45 c8             	fldl   -0x38(%ebp)
    29d2:	dd 5d f8             	fstpl  -0x8(%ebp)
    29d5:	d9 e8                	fld1   
    29d7:	dd 5d f0             	fstpl  -0x10(%ebp)
    29da:	dd 45 c8             	fldl   -0x38(%ebp)
    29dd:	dd 5d e8             	fstpl  -0x18(%ebp)
    29e0:	dd 45 c8             	fldl   -0x38(%ebp)
    29e3:	dd 5d e0             	fstpl  -0x20(%ebp)
	int n=1,sign=1;  
    29e6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
    29ed:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
	while(Precious>1e-6)  
    29f4:	eb 50                	jmp    2a46 <sin+0x89>
	{  
		n = n+1;  
    29f6:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
		Fac=Fac*n*(n + 1);
    29fa:	db 45 dc             	fildl  -0x24(%ebp)
    29fd:	dc 4d f0             	fmull  -0x10(%ebp)
    2a00:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2a03:	83 c0 01             	add    $0x1,%eax
    2a06:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    2a09:	db 45 c4             	fildl  -0x3c(%ebp)
    2a0c:	de c9                	fmulp  %st,%st(1)
    2a0e:	dd 5d f0             	fstpl  -0x10(%ebp)
		n = n + 1;  
    2a11:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
		Xn*=x*x;  
    2a15:	dd 45 c8             	fldl   -0x38(%ebp)
    2a18:	dc 4d c8             	fmull  -0x38(%ebp)
    2a1b:	dd 45 e8             	fldl   -0x18(%ebp)
    2a1e:	de c9                	fmulp  %st,%st(1)
    2a20:	dd 5d e8             	fstpl  -0x18(%ebp)
		sign=-sign;  
    2a23:	f7 5d d8             	negl   -0x28(%ebp)
		Precious=Xn/Fac;  
    2a26:	dd 45 e8             	fldl   -0x18(%ebp)
    2a29:	dc 75 f0             	fdivl  -0x10(%ebp)
    2a2c:	dd 5d e0             	fstpl  -0x20(%ebp)
		Result=sign>0?Result+Precious:Result-Precious;  
    2a2f:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    2a33:	7e 08                	jle    2a3d <sin+0x80>
    2a35:	dd 45 f8             	fldl   -0x8(%ebp)
    2a38:	dc 45 e0             	faddl  -0x20(%ebp)
    2a3b:	eb 06                	jmp    2a43 <sin+0x86>
    2a3d:	dd 45 f8             	fldl   -0x8(%ebp)
    2a40:	dc 65 e0             	fsubl  -0x20(%ebp)
    2a43:	dd 5d f8             	fstpl  -0x8(%ebp)
}
double sin(double x)  
{  
	double Result=x,Fac=1.0,Xn=x,Precious=x;  
	int n=1,sign=1;  
	while(Precious>1e-6)  
    2a46:	dd 45 e0             	fldl   -0x20(%ebp)
    2a49:	dd 05 40 90 00 00    	fldl   0x9040
    2a4f:	d9 c9                	fxch   %st(1)
    2a51:	df e9                	fucomip %st(1),%st
    2a53:	dd d8                	fstp   %st(0)
    2a55:	77 9f                	ja     29f6 <sin+0x39>
		Xn*=x*x;  
		sign=-sign;  
		Precious=Xn/Fac;  
		Result=sign>0?Result+Precious:Result-Precious;  
	}  
	return Result;  
    2a57:	dd 45 f8             	fldl   -0x8(%ebp)
}  
    2a5a:	c9                   	leave  
    2a5b:	c3                   	ret    

00002a5c <cos>:
double cos(double x)  
{  
    2a5c:	55                   	push   %ebp
    2a5d:	89 e5                	mov    %esp,%ebp
    2a5f:	83 ec 08             	sub    $0x8,%esp
    2a62:	8b 45 08             	mov    0x8(%ebp),%eax
    2a65:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2a68:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return sin(pi/2-x);  
    2a6e:	dd 05 48 90 00 00    	fldl   0x9048
    2a74:	dc 65 f8             	fsubl  -0x8(%ebp)
    2a77:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    2a7b:	dd 1c 24             	fstpl  (%esp)
    2a7e:	e8 3a ff ff ff       	call   29bd <sin>
    2a83:	83 c4 08             	add    $0x8,%esp
}  
    2a86:	c9                   	leave  
    2a87:	c3                   	ret    

00002a88 <tan>:
double tan(double x)  
{  
    2a88:	55                   	push   %ebp
    2a89:	89 e5                	mov    %esp,%ebp
    2a8b:	83 ec 10             	sub    $0x10,%esp
    2a8e:	8b 45 08             	mov    0x8(%ebp),%eax
    2a91:	89 45 f8             	mov    %eax,-0x8(%ebp)
    2a94:	8b 45 0c             	mov    0xc(%ebp),%eax
    2a97:	89 45 fc             	mov    %eax,-0x4(%ebp)
	return sin(x)/cos(x);  
    2a9a:	ff 75 fc             	pushl  -0x4(%ebp)
    2a9d:	ff 75 f8             	pushl  -0x8(%ebp)
    2aa0:	e8 18 ff ff ff       	call   29bd <sin>
    2aa5:	83 c4 08             	add    $0x8,%esp
    2aa8:	dd 5d f0             	fstpl  -0x10(%ebp)
    2aab:	ff 75 fc             	pushl  -0x4(%ebp)
    2aae:	ff 75 f8             	pushl  -0x8(%ebp)
    2ab1:	e8 a6 ff ff ff       	call   2a5c <cos>
    2ab6:	83 c4 08             	add    $0x8,%esp
    2ab9:	dc 7d f0             	fdivrl -0x10(%ebp)
}  
    2abc:	c9                   	leave  
    2abd:	c3                   	ret    

00002abe <pow>:

double pow(double x, double y)
{
    2abe:	55                   	push   %ebp
    2abf:	89 e5                	mov    %esp,%ebp
    2ac1:	83 ec 38             	sub    $0x38,%esp
    2ac4:	8b 45 08             	mov    0x8(%ebp),%eax
    2ac7:	89 45 e0             	mov    %eax,-0x20(%ebp)
    2aca:	8b 45 0c             	mov    0xc(%ebp),%eax
    2acd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    2ad0:	8b 45 10             	mov    0x10(%ebp),%eax
    2ad3:	89 45 d8             	mov    %eax,-0x28(%ebp)
    2ad6:	8b 45 14             	mov    0x14(%ebp),%eax
    2ad9:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if(x==0 && y!=0) return 0;
    2adc:	dd 45 e0             	fldl   -0x20(%ebp)
    2adf:	d9 ee                	fldz   
    2ae1:	df e9                	fucomip %st(1),%st
    2ae3:	dd d8                	fstp   %st(0)
    2ae5:	7a 28                	jp     2b0f <pow+0x51>
    2ae7:	dd 45 e0             	fldl   -0x20(%ebp)
    2aea:	d9 ee                	fldz   
    2aec:	df e9                	fucomip %st(1),%st
    2aee:	dd d8                	fstp   %st(0)
    2af0:	75 1d                	jne    2b0f <pow+0x51>
    2af2:	dd 45 d8             	fldl   -0x28(%ebp)
    2af5:	d9 ee                	fldz   
    2af7:	df e9                	fucomip %st(1),%st
    2af9:	dd d8                	fstp   %st(0)
    2afb:	7a 0b                	jp     2b08 <pow+0x4a>
    2afd:	dd 45 d8             	fldl   -0x28(%ebp)
    2b00:	d9 ee                	fldz   
    2b02:	df e9                	fucomip %st(1),%st
    2b04:	dd d8                	fstp   %st(0)
    2b06:	74 07                	je     2b0f <pow+0x51>
    2b08:	d9 ee                	fldz   
    2b0a:	e9 3a 01 00 00       	jmp    2c49 <pow+0x18b>
	else if(x==0 && y==0) return 1;
    2b0f:	dd 45 e0             	fldl   -0x20(%ebp)
    2b12:	d9 ee                	fldz   
    2b14:	df e9                	fucomip %st(1),%st
    2b16:	dd d8                	fstp   %st(0)
    2b18:	7a 28                	jp     2b42 <pow+0x84>
    2b1a:	dd 45 e0             	fldl   -0x20(%ebp)
    2b1d:	d9 ee                	fldz   
    2b1f:	df e9                	fucomip %st(1),%st
    2b21:	dd d8                	fstp   %st(0)
    2b23:	75 1d                	jne    2b42 <pow+0x84>
    2b25:	dd 45 d8             	fldl   -0x28(%ebp)
    2b28:	d9 ee                	fldz   
    2b2a:	df e9                	fucomip %st(1),%st
    2b2c:	dd d8                	fstp   %st(0)
    2b2e:	7a 12                	jp     2b42 <pow+0x84>
    2b30:	dd 45 d8             	fldl   -0x28(%ebp)
    2b33:	d9 ee                	fldz   
    2b35:	df e9                	fucomip %st(1),%st
    2b37:	dd d8                	fstp   %st(0)
    2b39:	75 07                	jne    2b42 <pow+0x84>
    2b3b:	d9 e8                	fld1   
    2b3d:	e9 07 01 00 00       	jmp    2c49 <pow+0x18b>
	else if(y<0) return 1/pow(x,-y);//把指数小于0的情况转为1/x^-y计算
    2b42:	d9 ee                	fldz   
    2b44:	dd 45 d8             	fldl   -0x28(%ebp)
    2b47:	d9 c9                	fxch   %st(1)
    2b49:	df e9                	fucomip %st(1),%st
    2b4b:	dd d8                	fstp   %st(0)
    2b4d:	76 23                	jbe    2b72 <pow+0xb4>
    2b4f:	dd 45 d8             	fldl   -0x28(%ebp)
    2b52:	d9 e0                	fchs   
    2b54:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    2b58:	dd 1c 24             	fstpl  (%esp)
    2b5b:	ff 75 e4             	pushl  -0x1c(%ebp)
    2b5e:	ff 75 e0             	pushl  -0x20(%ebp)
    2b61:	e8 58 ff ff ff       	call   2abe <pow>
    2b66:	83 c4 10             	add    $0x10,%esp
    2b69:	d9 e8                	fld1   
    2b6b:	de f1                	fdivp  %st,%st(1)
    2b6d:	e9 d7 00 00 00       	jmp    2c49 <pow+0x18b>
	else if(x<0 && y-(int)y!=0) return 0;//若x为负，且y不为整数数，则出错，返回0  
    2b72:	d9 ee                	fldz   
    2b74:	dd 45 e0             	fldl   -0x20(%ebp)
    2b77:	d9 c9                	fxch   %st(1)
    2b79:	df e9                	fucomip %st(1),%st
    2b7b:	dd d8                	fstp   %st(0)
    2b7d:	76 3a                	jbe    2bb9 <pow+0xfb>
    2b7f:	dd 45 d8             	fldl   -0x28(%ebp)
    2b82:	d9 7d d6             	fnstcw -0x2a(%ebp)
    2b85:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    2b89:	b4 0c                	mov    $0xc,%ah
    2b8b:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    2b8f:	d9 6d d4             	fldcw  -0x2c(%ebp)
    2b92:	db 5d cc             	fistpl -0x34(%ebp)
    2b95:	d9 6d d6             	fldcw  -0x2a(%ebp)
    2b98:	db 45 cc             	fildl  -0x34(%ebp)
    2b9b:	dd 45 d8             	fldl   -0x28(%ebp)
    2b9e:	de e1                	fsubp  %st,%st(1)
    2ba0:	d9 ee                	fldz   
    2ba2:	df e9                	fucomip %st(1),%st
    2ba4:	7a 0a                	jp     2bb0 <pow+0xf2>
    2ba6:	d9 ee                	fldz   
    2ba8:	df e9                	fucomip %st(1),%st
    2baa:	dd d8                	fstp   %st(0)
    2bac:	74 0b                	je     2bb9 <pow+0xfb>
    2bae:	eb 02                	jmp    2bb2 <pow+0xf4>
    2bb0:	dd d8                	fstp   %st(0)
    2bb2:	d9 ee                	fldz   
    2bb4:	e9 90 00 00 00       	jmp    2c49 <pow+0x18b>
	else if(x<0 && y-(int)y==0)//若x为负，且y为整数数，则用循环计算 
    2bb9:	d9 ee                	fldz   
    2bbb:	dd 45 e0             	fldl   -0x20(%ebp)
    2bbe:	d9 c9                	fxch   %st(1)
    2bc0:	df e9                	fucomip %st(1),%st
    2bc2:	dd d8                	fstp   %st(0)
    2bc4:	76 5d                	jbe    2c23 <pow+0x165>
    2bc6:	dd 45 d8             	fldl   -0x28(%ebp)
    2bc9:	d9 7d d6             	fnstcw -0x2a(%ebp)
    2bcc:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    2bd0:	b4 0c                	mov    $0xc,%ah
    2bd2:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    2bd6:	d9 6d d4             	fldcw  -0x2c(%ebp)
    2bd9:	db 5d cc             	fistpl -0x34(%ebp)
    2bdc:	d9 6d d6             	fldcw  -0x2a(%ebp)
    2bdf:	db 45 cc             	fildl  -0x34(%ebp)
    2be2:	dd 45 d8             	fldl   -0x28(%ebp)
    2be5:	de e1                	fsubp  %st,%st(1)
    2be7:	d9 ee                	fldz   
    2be9:	df e9                	fucomip %st(1),%st
    2beb:	7a 34                	jp     2c21 <pow+0x163>
    2bed:	d9 ee                	fldz   
    2bef:	df e9                	fucomip %st(1),%st
    2bf1:	dd d8                	fstp   %st(0)
    2bf3:	75 2e                	jne    2c23 <pow+0x165>
	{
		double powint=1;
    2bf5:	d9 e8                	fld1   
    2bf7:	dd 5d f0             	fstpl  -0x10(%ebp)
		int i;
		for(i=1;i<=y;i++) powint*=x;
    2bfa:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    2c01:	eb 0d                	jmp    2c10 <pow+0x152>
    2c03:	dd 45 f0             	fldl   -0x10(%ebp)
    2c06:	dc 4d e0             	fmull  -0x20(%ebp)
    2c09:	dd 5d f0             	fstpl  -0x10(%ebp)
    2c0c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    2c10:	db 45 ec             	fildl  -0x14(%ebp)
    2c13:	dd 45 d8             	fldl   -0x28(%ebp)
    2c16:	df e9                	fucomip %st(1),%st
    2c18:	dd d8                	fstp   %st(0)
    2c1a:	73 e7                	jae    2c03 <pow+0x145>
		return powint;
    2c1c:	dd 45 f0             	fldl   -0x10(%ebp)
    2c1f:	eb 28                	jmp    2c49 <pow+0x18b>
    2c21:	dd d8                	fstp   %st(0)
	}
	return exp(y*ln(x));
    2c23:	83 ec 08             	sub    $0x8,%esp
    2c26:	ff 75 e4             	pushl  -0x1c(%ebp)
    2c29:	ff 75 e0             	pushl  -0x20(%ebp)
    2c2c:	e8 49 00 00 00       	call   2c7a <ln>
    2c31:	83 c4 10             	add    $0x10,%esp
    2c34:	dc 4d d8             	fmull  -0x28(%ebp)
    2c37:	83 ec 08             	sub    $0x8,%esp
    2c3a:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    2c3e:	dd 1c 24             	fstpl  (%esp)
    2c41:	e8 2a 02 00 00       	call   2e70 <exp>
    2c46:	83 c4 10             	add    $0x10,%esp
}
    2c49:	c9                   	leave  
    2c4a:	c3                   	ret    

00002c4b <sqrt>:
// 求根
double sqrt(double x)
{
    2c4b:	55                   	push   %ebp
    2c4c:	89 e5                	mov    %esp,%ebp
    2c4e:	83 ec 18             	sub    $0x18,%esp
    2c51:	8b 45 08             	mov    0x8(%ebp),%eax
    2c54:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2c57:	8b 45 0c             	mov    0xc(%ebp),%eax
    2c5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	return pow(x,0.5);
    2c5d:	dd 05 50 90 00 00    	fldl   0x9050
    2c63:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    2c67:	dd 1c 24             	fstpl  (%esp)
    2c6a:	ff 75 f4             	pushl  -0xc(%ebp)
    2c6d:	ff 75 f0             	pushl  -0x10(%ebp)
    2c70:	e8 49 fe ff ff       	call   2abe <pow>
    2c75:	83 c4 10             	add    $0x10,%esp
}
    2c78:	c9                   	leave  
    2c79:	c3                   	ret    

00002c7a <ln>:

// ln(x) = 2 arctanh((x-1)/(x+1))
// 调用了Arctanh(double) 方法
double ln(double x)
{
    2c7a:	55                   	push   %ebp
    2c7b:	89 e5                	mov    %esp,%ebp
    2c7d:	83 ec 78             	sub    $0x78,%esp
    2c80:	8b 45 08             	mov    0x8(%ebp),%eax
    2c83:	89 45 90             	mov    %eax,-0x70(%ebp)
    2c86:	8b 45 0c             	mov    0xc(%ebp),%eax
    2c89:	89 45 94             	mov    %eax,-0x6c(%ebp)
	double y=x-1,ln_p1=0,ln_p2=0,ln_p3=0,ln_px=0,ln_tmp=1,dln_px=1,tmp;
    2c8c:	dd 45 90             	fldl   -0x70(%ebp)
    2c8f:	d9 e8                	fld1   
    2c91:	de e9                	fsubrp %st,%st(1)
    2c93:	dd 5d c0             	fstpl  -0x40(%ebp)
    2c96:	d9 ee                	fldz   
    2c98:	dd 5d f0             	fstpl  -0x10(%ebp)
    2c9b:	d9 ee                	fldz   
    2c9d:	dd 5d b8             	fstpl  -0x48(%ebp)
    2ca0:	d9 ee                	fldz   
    2ca2:	dd 5d b0             	fstpl  -0x50(%ebp)
    2ca5:	d9 ee                	fldz   
    2ca7:	dd 5d e8             	fstpl  -0x18(%ebp)
    2caa:	d9 e8                	fld1   
    2cac:	dd 5d e0             	fstpl  -0x20(%ebp)
    2caf:	d9 e8                	fld1   
    2cb1:	dd 5d a8             	fstpl  -0x58(%ebp)
	int l;
	if(x==1) return 0;
    2cb4:	dd 45 90             	fldl   -0x70(%ebp)
    2cb7:	d9 e8                	fld1   
    2cb9:	df e9                	fucomip %st(1),%st
    2cbb:	dd d8                	fstp   %st(0)
    2cbd:	7a 12                	jp     2cd1 <ln+0x57>
    2cbf:	dd 45 90             	fldl   -0x70(%ebp)
    2cc2:	d9 e8                	fld1   
    2cc4:	df e9                	fucomip %st(1),%st
    2cc6:	dd d8                	fstp   %st(0)
    2cc8:	75 07                	jne    2cd1 <ln+0x57>
    2cca:	d9 ee                	fldz   
    2ccc:	e9 9d 01 00 00       	jmp    2e6e <ln+0x1f4>
	else if(x>2) return -ln(1/x);
    2cd1:	dd 45 90             	fldl   -0x70(%ebp)
    2cd4:	dd 05 58 90 00 00    	fldl   0x9058
    2cda:	d9 c9                	fxch   %st(1)
    2cdc:	df e9                	fucomip %st(1),%st
    2cde:	dd d8                	fstp   %st(0)
    2ce0:	76 1e                	jbe    2d00 <ln+0x86>
    2ce2:	d9 e8                	fld1   
    2ce4:	dc 75 90             	fdivl  -0x70(%ebp)
    2ce7:	83 ec 08             	sub    $0x8,%esp
    2cea:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    2cee:	dd 1c 24             	fstpl  (%esp)
    2cf1:	e8 84 ff ff ff       	call   2c7a <ln>
    2cf6:	83 c4 10             	add    $0x10,%esp
    2cf9:	d9 e0                	fchs   
    2cfb:	e9 6e 01 00 00       	jmp    2e6e <ln+0x1f4>
	else if(x<.1)
    2d00:	dd 05 60 90 00 00    	fldl   0x9060
    2d06:	dd 45 90             	fldl   -0x70(%ebp)
    2d09:	d9 c9                	fxch   %st(1)
    2d0b:	df e9                	fucomip %st(1),%st
    2d0d:	dd d8                	fstp   %st(0)
    2d0f:	76 65                	jbe    2d76 <ln+0xfc>
	{
		double n=-1;
    2d11:	d9 e8                	fld1   
    2d13:	d9 e0                	fchs   
    2d15:	dd 5d c8             	fstpl  -0x38(%ebp)
		double a;
		do
		{
			n=n-.6;
    2d18:	dd 45 c8             	fldl   -0x38(%ebp)
    2d1b:	dd 05 68 90 00 00    	fldl   0x9068
    2d21:	de e9                	fsubrp %st,%st(1)
    2d23:	dd 5d c8             	fstpl  -0x38(%ebp)
			a=x/exp(n);
    2d26:	83 ec 08             	sub    $0x8,%esp
    2d29:	ff 75 cc             	pushl  -0x34(%ebp)
    2d2c:	ff 75 c8             	pushl  -0x38(%ebp)
    2d2f:	e8 3c 01 00 00       	call   2e70 <exp>
    2d34:	83 c4 10             	add    $0x10,%esp
    2d37:	dd 45 90             	fldl   -0x70(%ebp)
    2d3a:	de f1                	fdivp  %st,%st(1)
    2d3c:	dd 5d a0             	fstpl  -0x60(%ebp)
		}
		while(a>2 || a<1);
    2d3f:	dd 45 a0             	fldl   -0x60(%ebp)
    2d42:	dd 05 58 90 00 00    	fldl   0x9058
    2d48:	d9 c9                	fxch   %st(1)
    2d4a:	df e9                	fucomip %st(1),%st
    2d4c:	dd d8                	fstp   %st(0)
    2d4e:	77 c8                	ja     2d18 <ln+0x9e>
    2d50:	d9 e8                	fld1   
    2d52:	dd 45 a0             	fldl   -0x60(%ebp)
    2d55:	d9 c9                	fxch   %st(1)
    2d57:	df e9                	fucomip %st(1),%st
    2d59:	dd d8                	fstp   %st(0)
    2d5b:	77 bb                	ja     2d18 <ln+0x9e>
		return ln(a)+n;
    2d5d:	83 ec 08             	sub    $0x8,%esp
    2d60:	ff 75 a4             	pushl  -0x5c(%ebp)
    2d63:	ff 75 a0             	pushl  -0x60(%ebp)
    2d66:	e8 0f ff ff ff       	call   2c7a <ln>
    2d6b:	83 c4 10             	add    $0x10,%esp
    2d6e:	dc 45 c8             	faddl  -0x38(%ebp)
    2d71:	e9 f8 00 00 00       	jmp    2e6e <ln+0x1f4>
	}
	for(l=1,tmp=1;(ln_px-ln_tmp)>1e-9 || (ln_px-ln_tmp)<-1e-9;l++)
    2d76:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    2d7d:	d9 e8                	fld1   
    2d7f:	dd 5d d8             	fstpl  -0x28(%ebp)
    2d82:	e9 b6 00 00 00       	jmp    2e3d <ln+0x1c3>
	{
		ln_tmp=ln_px;
    2d87:	dd 45 e8             	fldl   -0x18(%ebp)
    2d8a:	dd 5d e0             	fstpl  -0x20(%ebp)
		tmp*=y;
    2d8d:	dd 45 d8             	fldl   -0x28(%ebp)
    2d90:	dc 4d c0             	fmull  -0x40(%ebp)
    2d93:	dd 5d d8             	fstpl  -0x28(%ebp)
		if(l==1) tmp=tmp/l;
    2d96:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
    2d9a:	75 0d                	jne    2da9 <ln+0x12f>
    2d9c:	db 45 d4             	fildl  -0x2c(%ebp)
    2d9f:	dd 45 d8             	fldl   -0x28(%ebp)
    2da2:	de f1                	fdivp  %st,%st(1)
    2da4:	dd 5d d8             	fstpl  -0x28(%ebp)
    2da7:	eb 13                	jmp    2dbc <ln+0x142>
		else tmp=tmp/-l;
    2da9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2dac:	f7 d8                	neg    %eax
    2dae:	89 45 8c             	mov    %eax,-0x74(%ebp)
    2db1:	db 45 8c             	fildl  -0x74(%ebp)
    2db4:	dd 45 d8             	fldl   -0x28(%ebp)
    2db7:	de f1                	fdivp  %st,%st(1)
    2db9:	dd 5d d8             	fstpl  -0x28(%ebp)
		ln_p1+=tmp;
    2dbc:	dd 45 f0             	fldl   -0x10(%ebp)
    2dbf:	dc 45 d8             	faddl  -0x28(%ebp)
    2dc2:	dd 5d f0             	fstpl  -0x10(%ebp)
		ln_p2=ln_p1+-1*tmp*y*l/(l+1);
    2dc5:	dd 45 d8             	fldl   -0x28(%ebp)
    2dc8:	d9 e0                	fchs   
    2dca:	dc 4d c0             	fmull  -0x40(%ebp)
    2dcd:	db 45 d4             	fildl  -0x2c(%ebp)
    2dd0:	de c9                	fmulp  %st,%st(1)
    2dd2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2dd5:	83 c0 01             	add    $0x1,%eax
    2dd8:	89 45 8c             	mov    %eax,-0x74(%ebp)
    2ddb:	db 45 8c             	fildl  -0x74(%ebp)
    2dde:	de f9                	fdivrp %st,%st(1)
    2de0:	dc 45 f0             	faddl  -0x10(%ebp)
    2de3:	dd 5d b8             	fstpl  -0x48(%ebp)
		ln_p3=ln_p2+tmp*y*y*l/(l+2);
    2de6:	dd 45 d8             	fldl   -0x28(%ebp)
    2de9:	dc 4d c0             	fmull  -0x40(%ebp)
    2dec:	dc 4d c0             	fmull  -0x40(%ebp)
    2def:	db 45 d4             	fildl  -0x2c(%ebp)
    2df2:	de c9                	fmulp  %st,%st(1)
    2df4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2df7:	83 c0 02             	add    $0x2,%eax
    2dfa:	89 45 8c             	mov    %eax,-0x74(%ebp)
    2dfd:	db 45 8c             	fildl  -0x74(%ebp)
    2e00:	de f9                	fdivrp %st,%st(1)
    2e02:	dc 45 b8             	faddl  -0x48(%ebp)
    2e05:	dd 5d b0             	fstpl  -0x50(%ebp)
		dln_px=ln_p3-ln_p2;
    2e08:	dd 45 b0             	fldl   -0x50(%ebp)
    2e0b:	dc 65 b8             	fsubl  -0x48(%ebp)
    2e0e:	dd 5d a8             	fstpl  -0x58(%ebp)
		ln_px=ln_p3-dln_px*dln_px/(ln_p3-2*ln_p2+ln_p1);
    2e11:	dd 45 a8             	fldl   -0x58(%ebp)
    2e14:	dc 4d a8             	fmull  -0x58(%ebp)
    2e17:	dd 45 b8             	fldl   -0x48(%ebp)
    2e1a:	d8 c0                	fadd   %st(0),%st
    2e1c:	dd 45 b0             	fldl   -0x50(%ebp)
    2e1f:	de e1                	fsubp  %st,%st(1)
    2e21:	dc 45 f0             	faddl  -0x10(%ebp)
    2e24:	de f9                	fdivrp %st,%st(1)
    2e26:	dd 45 b0             	fldl   -0x50(%ebp)
    2e29:	de e1                	fsubp  %st,%st(1)
    2e2b:	dd 5d e8             	fstpl  -0x18(%ebp)
		tmp*=l;
    2e2e:	db 45 d4             	fildl  -0x2c(%ebp)
    2e31:	dd 45 d8             	fldl   -0x28(%ebp)
    2e34:	de c9                	fmulp  %st,%st(1)
    2e36:	dd 5d d8             	fstpl  -0x28(%ebp)
			a=x/exp(n);
		}
		while(a>2 || a<1);
		return ln(a)+n;
	}
	for(l=1,tmp=1;(ln_px-ln_tmp)>1e-9 || (ln_px-ln_tmp)<-1e-9;l++)
    2e39:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    2e3d:	dd 45 e8             	fldl   -0x18(%ebp)
    2e40:	dc 65 e0             	fsubl  -0x20(%ebp)
    2e43:	dd 05 70 90 00 00    	fldl   0x9070
    2e49:	d9 c9                	fxch   %st(1)
    2e4b:	df e9                	fucomip %st(1),%st
    2e4d:	dd d8                	fstp   %st(0)
    2e4f:	0f 87 32 ff ff ff    	ja     2d87 <ln+0x10d>
    2e55:	dd 45 e8             	fldl   -0x18(%ebp)
    2e58:	dc 65 e0             	fsubl  -0x20(%ebp)
    2e5b:	dd 05 78 90 00 00    	fldl   0x9078
    2e61:	df e9                	fucomip %st(1),%st
    2e63:	dd d8                	fstp   %st(0)
    2e65:	0f 87 1c ff ff ff    	ja     2d87 <ln+0x10d>
		ln_p3=ln_p2+tmp*y*y*l/(l+2);
		dln_px=ln_p3-ln_p2;
		ln_px=ln_p3-dln_px*dln_px/(ln_p3-2*ln_p2+ln_p1);
		tmp*=l;
	}
	return ln_px;
    2e6b:	dd 45 e8             	fldl   -0x18(%ebp)
}
    2e6e:	c9                   	leave  
    2e6f:	c3                   	ret    

00002e70 <exp>:

// 求e^x 用于Pow( double, double )调用
// e^x = 1+x+(x^2)/2!+(x^3)/3!+...
// 精度为7位
double exp( double x )
{
    2e70:	55                   	push   %ebp
    2e71:	89 e5                	mov    %esp,%ebp
    2e73:	83 ec 68             	sub    $0x68,%esp
    2e76:	8b 45 08             	mov    0x8(%ebp),%eax
    2e79:	89 45 a0             	mov    %eax,-0x60(%ebp)
    2e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
    2e7f:	89 45 a4             	mov    %eax,-0x5c(%ebp)
	double y=x,ex_p1=0,ex_p2=0,ex_p3=0,ex_px=0,ex_tmp=1,dex_px=1,tmp;
    2e82:	dd 45 a0             	fldl   -0x60(%ebp)
    2e85:	dd 5d c0             	fstpl  -0x40(%ebp)
    2e88:	d9 ee                	fldz   
    2e8a:	dd 5d f0             	fstpl  -0x10(%ebp)
    2e8d:	d9 ee                	fldz   
    2e8f:	dd 5d b8             	fstpl  -0x48(%ebp)
    2e92:	d9 ee                	fldz   
    2e94:	dd 5d b0             	fstpl  -0x50(%ebp)
    2e97:	d9 ee                	fldz   
    2e99:	dd 5d e8             	fstpl  -0x18(%ebp)
    2e9c:	d9 e8                	fld1   
    2e9e:	dd 5d e0             	fstpl  -0x20(%ebp)
    2ea1:	d9 e8                	fld1   
    2ea3:	dd 5d d8             	fstpl  -0x28(%ebp)
	int l;
	if(x==0) return 1;
    2ea6:	dd 45 a0             	fldl   -0x60(%ebp)
    2ea9:	d9 ee                	fldz   
    2eab:	df e9                	fucomip %st(1),%st
    2ead:	dd d8                	fstp   %st(0)
    2eaf:	7a 12                	jp     2ec3 <exp+0x53>
    2eb1:	dd 45 a0             	fldl   -0x60(%ebp)
    2eb4:	d9 ee                	fldz   
    2eb6:	df e9                	fucomip %st(1),%st
    2eb8:	dd d8                	fstp   %st(0)
    2eba:	75 07                	jne    2ec3 <exp+0x53>
    2ebc:	d9 e8                	fld1   
    2ebe:	e9 12 01 00 00       	jmp    2fd5 <exp+0x165>
	if(x<0) return 1/exp(-x); 
    2ec3:	d9 ee                	fldz   
    2ec5:	dd 45 a0             	fldl   -0x60(%ebp)
    2ec8:	d9 c9                	fxch   %st(1)
    2eca:	df e9                	fucomip %st(1),%st
    2ecc:	dd d8                	fstp   %st(0)
    2ece:	76 20                	jbe    2ef0 <exp+0x80>
    2ed0:	dd 45 a0             	fldl   -0x60(%ebp)
    2ed3:	d9 e0                	fchs   
    2ed5:	83 ec 08             	sub    $0x8,%esp
    2ed8:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    2edc:	dd 1c 24             	fstpl  (%esp)
    2edf:	e8 8c ff ff ff       	call   2e70 <exp>
    2ee4:	83 c4 10             	add    $0x10,%esp
    2ee7:	d9 e8                	fld1   
    2ee9:	de f1                	fdivp  %st,%st(1)
    2eeb:	e9 e5 00 00 00       	jmp    2fd5 <exp+0x165>
	for(l=1,tmp=1;((ex_px-ex_tmp)>1e-10 || (ex_px-ex_tmp)<-1e-10) && dex_px>1e-10;l++)
    2ef0:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
    2ef7:	d9 e8                	fld1   
    2ef9:	dd 5d d0             	fstpl  -0x30(%ebp)
    2efc:	e9 92 00 00 00       	jmp    2f93 <exp+0x123>
	{
		ex_tmp=ex_px;
    2f01:	dd 45 e8             	fldl   -0x18(%ebp)
    2f04:	dd 5d e0             	fstpl  -0x20(%ebp)
		tmp*=y;
    2f07:	dd 45 d0             	fldl   -0x30(%ebp)
    2f0a:	dc 4d c0             	fmull  -0x40(%ebp)
    2f0d:	dd 5d d0             	fstpl  -0x30(%ebp)
		tmp=tmp/l;
    2f10:	db 45 cc             	fildl  -0x34(%ebp)
    2f13:	dd 45 d0             	fldl   -0x30(%ebp)
    2f16:	de f1                	fdivp  %st,%st(1)
    2f18:	dd 5d d0             	fstpl  -0x30(%ebp)
		ex_p1+=tmp;
    2f1b:	dd 45 f0             	fldl   -0x10(%ebp)
    2f1e:	dc 45 d0             	faddl  -0x30(%ebp)
    2f21:	dd 5d f0             	fstpl  -0x10(%ebp)
		ex_p2=ex_p1+tmp*y/(l+1);
    2f24:	dd 45 d0             	fldl   -0x30(%ebp)
    2f27:	dc 4d c0             	fmull  -0x40(%ebp)
    2f2a:	8b 45 cc             	mov    -0x34(%ebp),%eax
    2f2d:	83 c0 01             	add    $0x1,%eax
    2f30:	89 45 9c             	mov    %eax,-0x64(%ebp)
    2f33:	db 45 9c             	fildl  -0x64(%ebp)
    2f36:	de f9                	fdivrp %st,%st(1)
    2f38:	dc 45 f0             	faddl  -0x10(%ebp)
    2f3b:	dd 5d b8             	fstpl  -0x48(%ebp)
		ex_p3=ex_p2+tmp*y*y/(l+1)/(l+2);
    2f3e:	dd 45 d0             	fldl   -0x30(%ebp)
    2f41:	dc 4d c0             	fmull  -0x40(%ebp)
    2f44:	dc 4d c0             	fmull  -0x40(%ebp)
    2f47:	8b 45 cc             	mov    -0x34(%ebp),%eax
    2f4a:	83 c0 01             	add    $0x1,%eax
    2f4d:	89 45 9c             	mov    %eax,-0x64(%ebp)
    2f50:	db 45 9c             	fildl  -0x64(%ebp)
    2f53:	de f9                	fdivrp %st,%st(1)
    2f55:	8b 45 cc             	mov    -0x34(%ebp),%eax
    2f58:	83 c0 02             	add    $0x2,%eax
    2f5b:	89 45 9c             	mov    %eax,-0x64(%ebp)
    2f5e:	db 45 9c             	fildl  -0x64(%ebp)
    2f61:	de f9                	fdivrp %st,%st(1)
    2f63:	dc 45 b8             	faddl  -0x48(%ebp)
    2f66:	dd 5d b0             	fstpl  -0x50(%ebp)
		dex_px=ex_p3-ex_p2;
    2f69:	dd 45 b0             	fldl   -0x50(%ebp)
    2f6c:	dc 65 b8             	fsubl  -0x48(%ebp)
    2f6f:	dd 5d d8             	fstpl  -0x28(%ebp)
		ex_px=ex_p3-dex_px*dex_px/(ex_p3-2*ex_p2+ex_p1);
    2f72:	dd 45 d8             	fldl   -0x28(%ebp)
    2f75:	dc 4d d8             	fmull  -0x28(%ebp)
    2f78:	dd 45 b8             	fldl   -0x48(%ebp)
    2f7b:	d8 c0                	fadd   %st(0),%st
    2f7d:	dd 45 b0             	fldl   -0x50(%ebp)
    2f80:	de e1                	fsubp  %st,%st(1)
    2f82:	dc 45 f0             	faddl  -0x10(%ebp)
    2f85:	de f9                	fdivrp %st,%st(1)
    2f87:	dd 45 b0             	fldl   -0x50(%ebp)
    2f8a:	de e1                	fsubp  %st,%st(1)
    2f8c:	dd 5d e8             	fstpl  -0x18(%ebp)
{
	double y=x,ex_p1=0,ex_p2=0,ex_p3=0,ex_px=0,ex_tmp=1,dex_px=1,tmp;
	int l;
	if(x==0) return 1;
	if(x<0) return 1/exp(-x); 
	for(l=1,tmp=1;((ex_px-ex_tmp)>1e-10 || (ex_px-ex_tmp)<-1e-10) && dex_px>1e-10;l++)
    2f8f:	83 45 cc 01          	addl   $0x1,-0x34(%ebp)
    2f93:	dd 45 e8             	fldl   -0x18(%ebp)
    2f96:	dc 65 e0             	fsubl  -0x20(%ebp)
    2f99:	dd 05 80 90 00 00    	fldl   0x9080
    2f9f:	d9 c9                	fxch   %st(1)
    2fa1:	df e9                	fucomip %st(1),%st
    2fa3:	dd d8                	fstp   %st(0)
    2fa5:	77 12                	ja     2fb9 <exp+0x149>
    2fa7:	dd 45 e8             	fldl   -0x18(%ebp)
    2faa:	dc 65 e0             	fsubl  -0x20(%ebp)
    2fad:	dd 05 88 90 00 00    	fldl   0x9088
    2fb3:	df e9                	fucomip %st(1),%st
    2fb5:	dd d8                	fstp   %st(0)
    2fb7:	76 15                	jbe    2fce <exp+0x15e>
    2fb9:	dd 45 d8             	fldl   -0x28(%ebp)
    2fbc:	dd 05 80 90 00 00    	fldl   0x9080
    2fc2:	d9 c9                	fxch   %st(1)
    2fc4:	df e9                	fucomip %st(1),%st
    2fc6:	dd d8                	fstp   %st(0)
    2fc8:	0f 87 33 ff ff ff    	ja     2f01 <exp+0x91>
		ex_p2=ex_p1+tmp*y/(l+1);
		ex_p3=ex_p2+tmp*y*y/(l+1)/(l+2);
		dex_px=ex_p3-ex_p2;
		ex_px=ex_p3-dex_px*dex_px/(ex_p3-2*ex_p2+ex_p1);
	}
	return ex_px+1;
    2fce:	dd 45 e8             	fldl   -0x18(%ebp)
    2fd1:	d9 e8                	fld1   
    2fd3:	de c1                	faddp  %st,%st(1)
    2fd5:	c9                   	leave  
    2fd6:	c3                   	ret    

00002fd7 <OpenTableFile>:
};
double  s_freq[4] = {44.1, 48, 32, 0};
char *mode_names[4] = { "stereo", "j-stereo", "dual-ch", "single-ch" };

int OpenTableFile(char *name)
{
    2fd7:	55                   	push   %ebp
    2fd8:	89 e5                	mov    %esp,%ebp
    2fda:	83 ec 68             	sub    $0x68,%esp
	char fulname[80];
	int f;

	fulname[0] = '\0';
    2fdd:	c6 45 a4 00          	movb   $0x0,-0x5c(%ebp)
	strcpy(fulname, name);
    2fe1:	83 ec 08             	sub    $0x8,%esp
    2fe4:	ff 75 08             	pushl  0x8(%ebp)
    2fe7:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    2fea:	50                   	push   %eax
    2feb:	e8 f2 f1 ff ff       	call   21e2 <strcpy>
    2ff0:	83 c4 10             	add    $0x10,%esp
	//-1 ?
	if( (f=open(fulname,O_RDWR))==-1 ) {
    2ff3:	83 ec 08             	sub    $0x8,%esp
    2ff6:	6a 02                	push   $0x2
    2ff8:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    2ffb:	50                   	push   %eax
    2ffc:	e8 52 f4 ff ff       	call   2453 <open>
    3001:	83 c4 10             	add    $0x10,%esp
    3004:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3007:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    300b:	75 16                	jne    3023 <OpenTableFile+0x4c>
		printf(0,"\nOpenTable: could not find %s\n", fulname);
    300d:	83 ec 04             	sub    $0x4,%esp
    3010:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3013:	50                   	push   %eax
    3014:	68 bc 90 00 00       	push   $0x90bc
    3019:	6a 00                	push   $0x0
    301b:	e8 d2 f5 ff ff       	call   25f2 <printf>
    3020:	83 c4 10             	add    $0x10,%esp
    }
    return f;
    3023:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    3026:	c9                   	leave  
    3027:	c3                   	ret    

00003028 <WriteHdr>:


void WriteHdr(struct frame_params *fr_ps)
{
    3028:	55                   	push   %ebp
    3029:	89 e5                	mov    %esp,%ebp
    302b:	57                   	push   %edi
    302c:	56                   	push   %esi
    302d:	53                   	push   %ebx
    302e:	83 ec 1c             	sub    $0x1c,%esp
	layer *info = fr_ps->header;
    3031:	8b 45 08             	mov    0x8(%ebp),%eax
    3034:	8b 00                	mov    (%eax),%eax
    3036:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	printf(0, "HDR:  sync=FFF, id=%X, layer=%X, ep=%X, br=%X, sf=%X, pd=%X, ",
    3039:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    303c:	8b 78 14             	mov    0x14(%eax),%edi
    303f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3042:	8b 70 10             	mov    0x10(%eax),%esi
    3045:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3048:	8b 58 0c             	mov    0xc(%eax),%ebx
		info->version, info->lay, !info->error_protection,
    304b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    304e:	8b 40 08             	mov    0x8(%eax),%eax

void WriteHdr(struct frame_params *fr_ps)
{
	layer *info = fr_ps->header;

	printf(0, "HDR:  sync=FFF, id=%X, layer=%X, ep=%X, br=%X, sf=%X, pd=%X, ",
    3051:	85 c0                	test   %eax,%eax
    3053:	0f 94 c0             	sete   %al
    3056:	0f b6 c8             	movzbl %al,%ecx
    3059:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    305c:	8b 50 04             	mov    0x4(%eax),%edx
    305f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3062:	8b 00                	mov    (%eax),%eax
    3064:	57                   	push   %edi
    3065:	56                   	push   %esi
    3066:	53                   	push   %ebx
    3067:	51                   	push   %ecx
    3068:	52                   	push   %edx
    3069:	50                   	push   %eax
    306a:	68 dc 90 00 00       	push   $0x90dc
    306f:	6a 00                	push   $0x0
    3071:	e8 7c f5 ff ff       	call   25f2 <printf>
    3076:	83 c4 20             	add    $0x20,%esp
		info->version, info->lay, !info->error_protection,
		info->bitrate_index, info->sampling_frequency, info->padding);

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
    3079:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    307c:	8b 78 2c             	mov    0x2c(%eax),%edi
    307f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3082:	8b 70 28             	mov    0x28(%eax),%esi
    3085:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3088:	8b 58 24             	mov    0x24(%eax),%ebx
    308b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    308e:	8b 48 20             	mov    0x20(%eax),%ecx
    3091:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3094:	8b 50 1c             	mov    0x1c(%eax),%edx
    3097:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    309a:	8b 40 18             	mov    0x18(%eax),%eax
    309d:	57                   	push   %edi
    309e:	56                   	push   %esi
    309f:	53                   	push   %ebx
    30a0:	51                   	push   %ecx
    30a1:	52                   	push   %edx
    30a2:	50                   	push   %eax
    30a3:	68 1c 91 00 00       	push   $0x911c
    30a8:	6a 00                	push   $0x0
    30aa:	e8 43 f5 ff ff       	call   25f2 <printf>
    30af:	83 c4 20             	add    $0x20,%esp
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);
    30b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    30b5:	8b 40 1c             	mov    0x1c(%eax),%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    30b8:	8b 0c 85 c0 c7 00 00 	mov    0xc7c0(,%eax,4),%ecx
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);
    30bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    30c2:	8b 40 10             	mov    0x10(%eax),%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    30c5:	dd 04 c5 a0 c7 00 00 	fldl   0xc7a0(,%eax,8)
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
    30cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    30cf:	8b 40 04             	mov    0x4(%eax),%eax
    30d2:	8d 50 ff             	lea    -0x1(%eax),%edx
    30d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    30d8:	8b 58 0c             	mov    0xc(%eax),%ebx

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    30db:	89 d0                	mov    %edx,%eax
    30dd:	c1 e0 04             	shl    $0x4,%eax
    30e0:	29 d0                	sub    %edx,%eax
    30e2:	01 d8                	add    %ebx,%eax
    30e4:	8b 14 85 e0 c6 00 00 	mov    0xc6e0(,%eax,4),%edx
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
    30eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    30ee:	8b 40 04             	mov    0x4(%eax),%eax
    30f1:	83 e8 01             	sub    $0x1,%eax

	printf(0, "pr=%X, m=%X, js=%X, c=%X, o=%X, e=%X\n",
		info->extension, info->mode, info->mode_ext,
		info->copyright, info->original, info->emphasis);

	printf(0, "layer=%s, tot bitrate=%d, sfrq=%.1f, mode=%s, ",
    30f4:	8b 04 85 c0 c6 00 00 	mov    0xc6c0(,%eax,4),%eax
    30fb:	83 ec 04             	sub    $0x4,%esp
    30fe:	51                   	push   %ecx
    30ff:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    3103:	dd 1c 24             	fstpl  (%esp)
    3106:	52                   	push   %edx
    3107:	50                   	push   %eax
    3108:	68 44 91 00 00       	push   $0x9144
    310d:	6a 00                	push   $0x0
    310f:	e8 de f4 ff ff       	call   25f2 <printf>
    3114:	83 c4 20             	add    $0x20,%esp
		layer_names[info->lay-1], bitrate[info->lay-1][info->bitrate_index],
		s_freq[info->sampling_frequency], mode_names[info->mode]);

	printf(0, "sblim=%d, jsbd=%d, ch=%d\n",
    3117:	8b 45 08             	mov    0x8(%ebp),%eax
    311a:	8b 48 08             	mov    0x8(%eax),%ecx
    311d:	8b 45 08             	mov    0x8(%ebp),%eax
    3120:	8b 50 0c             	mov    0xc(%eax),%edx
    3123:	8b 45 08             	mov    0x8(%ebp),%eax
    3126:	8b 40 10             	mov    0x10(%eax),%eax
    3129:	83 ec 0c             	sub    $0xc,%esp
    312c:	51                   	push   %ecx
    312d:	52                   	push   %edx
    312e:	50                   	push   %eax
    312f:	68 73 91 00 00       	push   $0x9173
    3134:	6a 00                	push   $0x0
    3136:	e8 b7 f4 ff ff       	call   25f2 <printf>
    313b:	83 c4 20             	add    $0x20,%esp
		fr_ps->sblimit, fr_ps->jsbound, fr_ps->stereo);
}
    313e:	90                   	nop
    313f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3142:	5b                   	pop    %ebx
    3143:	5e                   	pop    %esi
    3144:	5f                   	pop    %edi
    3145:	5d                   	pop    %ebp
    3146:	c3                   	ret    

00003147 <mem_alloc>:

void *mem_alloc(unsigned long block, char *item)
{
    3147:	55                   	push   %ebp
    3148:	89 e5                	mov    %esp,%ebp
    314a:	83 ec 18             	sub    $0x18,%esp
	void *ptr;
	ptr = (void *)malloc((unsigned long)block);
    314d:	83 ec 0c             	sub    $0xc,%esp
    3150:	ff 75 08             	pushl  0x8(%ebp)
    3153:	e8 6d f7 ff ff       	call   28c5 <malloc>
    3158:	83 c4 10             	add    $0x10,%esp
    315b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	if (ptr != 0)
    315e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3162:	74 15                	je     3179 <mem_alloc+0x32>
		memset(ptr, 0, block);
    3164:	83 ec 04             	sub    $0x4,%esp
    3167:	ff 75 08             	pushl  0x8(%ebp)
    316a:	6a 00                	push   $0x0
    316c:	ff 75 f4             	pushl  -0xc(%ebp)
    316f:	e8 04 f1 ff ff       	call   2278 <memset>
    3174:	83 c4 10             	add    $0x10,%esp
    3177:	eb 1a                	jmp    3193 <mem_alloc+0x4c>
	else{
		printf(0, "Unable to allocate %s\n", item);
    3179:	83 ec 04             	sub    $0x4,%esp
    317c:	ff 75 0c             	pushl  0xc(%ebp)
    317f:	68 8d 91 00 00       	push   $0x918d
    3184:	6a 00                	push   $0x0
    3186:	e8 67 f4 ff ff       	call   25f2 <printf>
    318b:	83 c4 10             	add    $0x10,%esp
		exit();
    318e:	e8 80 f2 ff ff       	call   2413 <exit>
	}
	return ptr;
    3193:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    3196:	c9                   	leave  
    3197:	c3                   	ret    

00003198 <alloc_buffer>:

void alloc_buffer(Bit_stream_struc *bs, int size)
{
    3198:	55                   	push   %ebp
    3199:	89 e5                	mov    %esp,%ebp
    319b:	83 ec 08             	sub    $0x8,%esp
	bs->buf = (unsigned char *) mem_alloc(size*sizeof(unsigned char), "buffer");
    319e:	8b 45 0c             	mov    0xc(%ebp),%eax
    31a1:	83 ec 08             	sub    $0x8,%esp
    31a4:	68 a4 91 00 00       	push   $0x91a4
    31a9:	50                   	push   %eax
    31aa:	e8 98 ff ff ff       	call   3147 <mem_alloc>
    31af:	83 c4 10             	add    $0x10,%esp
    31b2:	89 c2                	mov    %eax,%edx
    31b4:	8b 45 08             	mov    0x8(%ebp),%eax
    31b7:	89 50 04             	mov    %edx,0x4(%eax)
	bs->buf_size = size;
    31ba:	8b 45 08             	mov    0x8(%ebp),%eax
    31bd:	8b 55 0c             	mov    0xc(%ebp),%edx
    31c0:	89 50 08             	mov    %edx,0x8(%eax)
}
    31c3:	90                   	nop
    31c4:	c9                   	leave  
    31c5:	c3                   	ret    

000031c6 <desalloc_buffer>:

void desalloc_buffer(Bit_stream_struc *bs)
{
    31c6:	55                   	push   %ebp
    31c7:	89 e5                	mov    %esp,%ebp
    31c9:	83 ec 08             	sub    $0x8,%esp
	free(bs->buf);
    31cc:	8b 45 08             	mov    0x8(%ebp),%eax
    31cf:	8b 40 04             	mov    0x4(%eax),%eax
    31d2:	83 ec 0c             	sub    $0xc,%esp
    31d5:	50                   	push   %eax
    31d6:	e8 a8 f5 ff ff       	call   2783 <free>
    31db:	83 c4 10             	add    $0x10,%esp
}
    31de:	90                   	nop
    31df:	c9                   	leave  
    31e0:	c3                   	ret    

000031e1 <open_bit_stream_r>:

void open_bit_stream_r(Bit_stream_struc *bs, char *bs_filenam, int size)
{
    31e1:	55                   	push   %ebp
    31e2:	89 e5                	mov    %esp,%ebp
    31e4:	83 ec 08             	sub    $0x8,%esp
	//register unsigned char flag = 1;

	if ((bs->pt = open(bs_filenam, O_RDWR)) == -1) {
    31e7:	83 ec 08             	sub    $0x8,%esp
    31ea:	6a 02                	push   $0x2
    31ec:	ff 75 0c             	pushl  0xc(%ebp)
    31ef:	e8 5f f2 ff ff       	call   2453 <open>
    31f4:	83 c4 10             	add    $0x10,%esp
    31f7:	89 c2                	mov    %eax,%edx
    31f9:	8b 45 08             	mov    0x8(%ebp),%eax
    31fc:	89 10                	mov    %edx,(%eax)
    31fe:	8b 45 08             	mov    0x8(%ebp),%eax
    3201:	8b 00                	mov    (%eax),%eax
    3203:	83 f8 ff             	cmp    $0xffffffff,%eax
    3206:	75 1a                	jne    3222 <open_bit_stream_r+0x41>
		printf(0, "Could not find \"%s\".\n", bs_filenam);
    3208:	83 ec 04             	sub    $0x4,%esp
    320b:	ff 75 0c             	pushl  0xc(%ebp)
    320e:	68 ab 91 00 00       	push   $0x91ab
    3213:	6a 00                	push   $0x0
    3215:	e8 d8 f3 ff ff       	call   25f2 <printf>
    321a:	83 c4 10             	add    $0x10,%esp
		exit();
    321d:	e8 f1 f1 ff ff       	call   2413 <exit>
	}

	bs->format = BINARY;
    3222:	8b 45 08             	mov    0x8(%ebp),%eax
    3225:	c6 40 24 00          	movb   $0x0,0x24(%eax)
	alloc_buffer(bs, size);
    3229:	83 ec 08             	sub    $0x8,%esp
    322c:	ff 75 10             	pushl  0x10(%ebp)
    322f:	ff 75 08             	pushl  0x8(%ebp)
    3232:	e8 61 ff ff ff       	call   3198 <alloc_buffer>
    3237:	83 c4 10             	add    $0x10,%esp
	bs->buf_byte_idx=0;
    323a:	8b 45 08             	mov    0x8(%ebp),%eax
    323d:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
	bs->buf_bit_idx=0;
    3244:	8b 45 08             	mov    0x8(%ebp),%eax
    3247:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
	bs->totbit=0;
    324e:	8b 45 08             	mov    0x8(%ebp),%eax
    3251:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	bs->mode = READ_MODE;
    3258:	8b 45 08             	mov    0x8(%ebp),%eax
    325b:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
	bs->eob = FALSE;
    3262:	8b 45 08             	mov    0x8(%ebp),%eax
    3265:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
	bs->eobs = FALSE;
    326c:	8b 45 08             	mov    0x8(%ebp),%eax
    326f:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
    3276:	90                   	nop
    3277:	c9                   	leave  
    3278:	c3                   	ret    

00003279 <close_bit_stream_r>:

void close_bit_stream_r(Bit_stream_struc *bs)
{
    3279:	55                   	push   %ebp
    327a:	89 e5                	mov    %esp,%ebp
    327c:	83 ec 08             	sub    $0x8,%esp
	close(bs->pt);
    327f:	8b 45 08             	mov    0x8(%ebp),%eax
    3282:	8b 00                	mov    (%eax),%eax
    3284:	83 ec 0c             	sub    $0xc,%esp
    3287:	50                   	push   %eax
    3288:	e8 ae f1 ff ff       	call   243b <close>
    328d:	83 c4 10             	add    $0x10,%esp
	desalloc_buffer(bs);
    3290:	83 ec 0c             	sub    $0xc,%esp
    3293:	ff 75 08             	pushl  0x8(%ebp)
    3296:	e8 2b ff ff ff       	call   31c6 <desalloc_buffer>
    329b:	83 c4 10             	add    $0x10,%esp
}
    329e:	90                   	nop
    329f:	c9                   	leave  
    32a0:	c3                   	ret    

000032a1 <end_bs>:

int end_bs(Bit_stream_struc *bs)
{
    32a1:	55                   	push   %ebp
    32a2:	89 e5                	mov    %esp,%ebp
  return(bs->eobs);
    32a4:	8b 45 08             	mov    0x8(%ebp),%eax
    32a7:	8b 40 20             	mov    0x20(%eax),%eax
}
    32aa:	5d                   	pop    %ebp
    32ab:	c3                   	ret    

000032ac <sstell>:


unsigned long sstell(Bit_stream_struc *bs)
{
    32ac:	55                   	push   %ebp
    32ad:	89 e5                	mov    %esp,%ebp
  return(bs->totbit);
    32af:	8b 45 08             	mov    0x8(%ebp),%eax
    32b2:	8b 40 0c             	mov    0xc(%eax),%eax
}
    32b5:	5d                   	pop    %ebp
    32b6:	c3                   	ret    

000032b7 <refill_buffer>:


void refill_buffer(Bit_stream_struc *bs)
{
    32b7:	55                   	push   %ebp
    32b8:	89 e5                	mov    %esp,%ebp
    32ba:	56                   	push   %esi
    32bb:	53                   	push   %ebx
	register int i=bs->buf_size-2-bs->buf_byte_idx;
    32bc:	8b 45 08             	mov    0x8(%ebp),%eax
    32bf:	8b 40 08             	mov    0x8(%eax),%eax
    32c2:	8d 50 fe             	lea    -0x2(%eax),%edx
    32c5:	8b 45 08             	mov    0x8(%ebp),%eax
    32c8:	8b 40 10             	mov    0x10(%eax),%eax
    32cb:	89 d3                	mov    %edx,%ebx
    32cd:	29 c3                	sub    %eax,%ebx
	register unsigned long n=1;
    32cf:	be 01 00 00 00       	mov    $0x1,%esi

	while ((i>=0) && (!bs->eob)) {
    32d4:	eb 30                	jmp    3306 <refill_buffer+0x4f>
			n=read(bs->pt, &bs->buf[i--], sizeof(unsigned char));
    32d6:	8b 45 08             	mov    0x8(%ebp),%eax
    32d9:	8b 50 04             	mov    0x4(%eax),%edx
    32dc:	89 d8                	mov    %ebx,%eax
    32de:	8d 58 ff             	lea    -0x1(%eax),%ebx
    32e1:	01 c2                	add    %eax,%edx
    32e3:	8b 45 08             	mov    0x8(%ebp),%eax
    32e6:	8b 00                	mov    (%eax),%eax
    32e8:	83 ec 04             	sub    $0x4,%esp
    32eb:	6a 01                	push   $0x1
    32ed:	52                   	push   %edx
    32ee:	50                   	push   %eax
    32ef:	e8 37 f1 ff ff       	call   242b <read>
    32f4:	83 c4 10             	add    $0x10,%esp
    32f7:	89 c6                	mov    %eax,%esi
		if (!n)
    32f9:	85 f6                	test   %esi,%esi
    32fb:	75 09                	jne    3306 <refill_buffer+0x4f>
		bs->eob= i+1;
    32fd:	8d 53 01             	lea    0x1(%ebx),%edx
    3300:	8b 45 08             	mov    0x8(%ebp),%eax
    3303:	89 50 1c             	mov    %edx,0x1c(%eax)
void refill_buffer(Bit_stream_struc *bs)
{
	register int i=bs->buf_size-2-bs->buf_byte_idx;
	register unsigned long n=1;

	while ((i>=0) && (!bs->eob)) {
    3306:	85 db                	test   %ebx,%ebx
    3308:	78 0a                	js     3314 <refill_buffer+0x5d>
    330a:	8b 45 08             	mov    0x8(%ebp),%eax
    330d:	8b 40 1c             	mov    0x1c(%eax),%eax
    3310:	85 c0                	test   %eax,%eax
    3312:	74 c2                	je     32d6 <refill_buffer+0x1f>
			n=read(bs->pt, &bs->buf[i--], sizeof(unsigned char));
		if (!n)
		bs->eob= i+1;
	}
}
    3314:	90                   	nop
    3315:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3318:	5b                   	pop    %ebx
    3319:	5e                   	pop    %esi
    331a:	5d                   	pop    %ebp
    331b:	c3                   	ret    

0000331c <get1bit>:


int mask[8]={0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80};

unsigned int get1bit(Bit_stream_struc *bs)
{
    331c:	55                   	push   %ebp
    331d:	89 e5                	mov    %esp,%ebp
    331f:	53                   	push   %ebx
    3320:	83 ec 14             	sub    $0x14,%esp
   unsigned int bit;
   register int i;

   bs->totbit++;
    3323:	8b 45 08             	mov    0x8(%ebp),%eax
    3326:	8b 40 0c             	mov    0xc(%eax),%eax
    3329:	8d 50 01             	lea    0x1(%eax),%edx
    332c:	8b 45 08             	mov    0x8(%ebp),%eax
    332f:	89 50 0c             	mov    %edx,0xc(%eax)

   if (!bs->buf_bit_idx) {
    3332:	8b 45 08             	mov    0x8(%ebp),%eax
    3335:	8b 40 14             	mov    0x14(%eax),%eax
    3338:	85 c0                	test   %eax,%eax
    333a:	0f 85 a2 00 00 00    	jne    33e2 <get1bit+0xc6>
        bs->buf_bit_idx = 8;
    3340:	8b 45 08             	mov    0x8(%ebp),%eax
    3343:	c7 40 14 08 00 00 00 	movl   $0x8,0x14(%eax)
        bs->buf_byte_idx--;
    334a:	8b 45 08             	mov    0x8(%ebp),%eax
    334d:	8b 40 10             	mov    0x10(%eax),%eax
    3350:	8d 50 ff             	lea    -0x1(%eax),%edx
    3353:	8b 45 08             	mov    0x8(%ebp),%eax
    3356:	89 50 10             	mov    %edx,0x10(%eax)
        if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
    3359:	8b 45 08             	mov    0x8(%ebp),%eax
    335c:	8b 40 10             	mov    0x10(%eax),%eax
    335f:	83 f8 03             	cmp    $0x3,%eax
    3362:	7e 10                	jle    3374 <get1bit+0x58>
    3364:	8b 45 08             	mov    0x8(%ebp),%eax
    3367:	8b 50 10             	mov    0x10(%eax),%edx
    336a:	8b 45 08             	mov    0x8(%ebp),%eax
    336d:	8b 40 1c             	mov    0x1c(%eax),%eax
    3370:	39 c2                	cmp    %eax,%edx
    3372:	7d 6e                	jge    33e2 <get1bit+0xc6>
             if (bs->eob)
    3374:	8b 45 08             	mov    0x8(%ebp),%eax
    3377:	8b 40 1c             	mov    0x1c(%eax),%eax
    337a:	85 c0                	test   %eax,%eax
    337c:	74 0c                	je     338a <get1bit+0x6e>
                bs->eobs = TRUE;
    337e:	8b 45 08             	mov    0x8(%ebp),%eax
    3381:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
    3388:	eb 58                	jmp    33e2 <get1bit+0xc6>
             else {
                for (i=bs->buf_byte_idx; i>=0;i--)
    338a:	8b 45 08             	mov    0x8(%ebp),%eax
    338d:	8b 58 10             	mov    0x10(%eax),%ebx
    3390:	eb 2f                	jmp    33c1 <get1bit+0xa5>
                  bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
    3392:	8b 45 08             	mov    0x8(%ebp),%eax
    3395:	8b 50 04             	mov    0x4(%eax),%edx
    3398:	8b 45 08             	mov    0x8(%ebp),%eax
    339b:	8b 40 08             	mov    0x8(%eax),%eax
    339e:	8d 48 ff             	lea    -0x1(%eax),%ecx
    33a1:	8b 45 08             	mov    0x8(%ebp),%eax
    33a4:	8b 40 10             	mov    0x10(%eax),%eax
    33a7:	29 c1                	sub    %eax,%ecx
    33a9:	89 c8                	mov    %ecx,%eax
    33ab:	01 d8                	add    %ebx,%eax
    33ad:	01 c2                	add    %eax,%edx
    33af:	8b 45 08             	mov    0x8(%ebp),%eax
    33b2:	8b 40 04             	mov    0x4(%eax),%eax
    33b5:	89 d9                	mov    %ebx,%ecx
    33b7:	01 c8                	add    %ecx,%eax
    33b9:	0f b6 00             	movzbl (%eax),%eax
    33bc:	88 02                	mov    %al,(%edx)
        bs->buf_byte_idx--;
        if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
             if (bs->eob)
                bs->eobs = TRUE;
             else {
                for (i=bs->buf_byte_idx; i>=0;i--)
    33be:	83 eb 01             	sub    $0x1,%ebx
    33c1:	85 db                	test   %ebx,%ebx
    33c3:	79 cd                	jns    3392 <get1bit+0x76>
                  bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
                refill_buffer(bs);
    33c5:	83 ec 0c             	sub    $0xc,%esp
    33c8:	ff 75 08             	pushl  0x8(%ebp)
    33cb:	e8 e7 fe ff ff       	call   32b7 <refill_buffer>
    33d0:	83 c4 10             	add    $0x10,%esp
                bs->buf_byte_idx = bs->buf_size-1;
    33d3:	8b 45 08             	mov    0x8(%ebp),%eax
    33d6:	8b 40 08             	mov    0x8(%eax),%eax
    33d9:	8d 50 ff             	lea    -0x1(%eax),%edx
    33dc:	8b 45 08             	mov    0x8(%ebp),%eax
    33df:	89 50 10             	mov    %edx,0x10(%eax)
             }
        }
   }
   bit = bs->buf[bs->buf_byte_idx]&mask[bs->buf_bit_idx-1];
    33e2:	8b 45 08             	mov    0x8(%ebp),%eax
    33e5:	8b 50 04             	mov    0x4(%eax),%edx
    33e8:	8b 45 08             	mov    0x8(%ebp),%eax
    33eb:	8b 40 10             	mov    0x10(%eax),%eax
    33ee:	01 d0                	add    %edx,%eax
    33f0:	0f b6 00             	movzbl (%eax),%eax
    33f3:	0f b6 d0             	movzbl %al,%edx
    33f6:	8b 45 08             	mov    0x8(%ebp),%eax
    33f9:	8b 40 14             	mov    0x14(%eax),%eax
    33fc:	83 e8 01             	sub    $0x1,%eax
    33ff:	8b 04 85 e0 c7 00 00 	mov    0xc7e0(,%eax,4),%eax
    3406:	21 d0                	and    %edx,%eax
    3408:	89 45 f4             	mov    %eax,-0xc(%ebp)
   bit = bit >> (bs->buf_bit_idx-1);
    340b:	8b 45 08             	mov    0x8(%ebp),%eax
    340e:	8b 40 14             	mov    0x14(%eax),%eax
    3411:	83 e8 01             	sub    $0x1,%eax
    3414:	89 c1                	mov    %eax,%ecx
    3416:	d3 6d f4             	shrl   %cl,-0xc(%ebp)
   bs->buf_bit_idx--;
    3419:	8b 45 08             	mov    0x8(%ebp),%eax
    341c:	8b 40 14             	mov    0x14(%eax),%eax
    341f:	8d 50 ff             	lea    -0x1(%eax),%edx
    3422:	8b 45 08             	mov    0x8(%ebp),%eax
    3425:	89 50 14             	mov    %edx,0x14(%eax)
   return(bit);
    3428:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    342b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    342e:	c9                   	leave  
    342f:	c3                   	ret    

00003430 <getbits>:

int putmask[9]={0x0, 0x1, 0x3, 0x7, 0xf, 0x1f, 0x3f, 0x7f, 0xff};

unsigned long getbits(Bit_stream_struc *bs, int N)
{
    3430:	55                   	push   %ebp
    3431:	89 e5                	mov    %esp,%ebp
    3433:	57                   	push   %edi
    3434:	56                   	push   %esi
    3435:	53                   	push   %ebx
    3436:	83 ec 1c             	sub    $0x1c,%esp
	unsigned long val=0;
    3439:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	register int i;
	register int j = N;
    3440:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	register int k, tmp;

	if (N > MAX_LENGTH)
    3443:	83 7d 0c 20          	cmpl   $0x20,0xc(%ebp)
    3447:	7e 14                	jle    345d <getbits+0x2d>
		printf(0,"Cannot read or write more than %d bits at a time.\n", MAX_LENGTH);
    3449:	83 ec 04             	sub    $0x4,%esp
    344c:	6a 20                	push   $0x20
    344e:	68 c4 91 00 00       	push   $0x91c4
    3453:	6a 00                	push   $0x0
    3455:	e8 98 f1 ff ff       	call   25f2 <printf>
    345a:	83 c4 10             	add    $0x10,%esp

	bs->totbit += N;
    345d:	8b 45 08             	mov    0x8(%ebp),%eax
    3460:	8b 50 0c             	mov    0xc(%eax),%edx
    3463:	8b 45 0c             	mov    0xc(%ebp),%eax
    3466:	01 c2                	add    %eax,%edx
    3468:	8b 45 08             	mov    0x8(%ebp),%eax
    346b:	89 50 0c             	mov    %edx,0xc(%eax)
	while (j > 0) {
    346e:	e9 0d 01 00 00       	jmp    3580 <getbits+0x150>
		if (!bs->buf_bit_idx) {
    3473:	8b 45 08             	mov    0x8(%ebp),%eax
    3476:	8b 40 14             	mov    0x14(%eax),%eax
    3479:	85 c0                	test   %eax,%eax
    347b:	0f 85 a2 00 00 00    	jne    3523 <getbits+0xf3>
			bs->buf_bit_idx = 8;
    3481:	8b 45 08             	mov    0x8(%ebp),%eax
    3484:	c7 40 14 08 00 00 00 	movl   $0x8,0x14(%eax)
			bs->buf_byte_idx--;
    348b:	8b 45 08             	mov    0x8(%ebp),%eax
    348e:	8b 40 10             	mov    0x10(%eax),%eax
    3491:	8d 50 ff             	lea    -0x1(%eax),%edx
    3494:	8b 45 08             	mov    0x8(%ebp),%eax
    3497:	89 50 10             	mov    %edx,0x10(%eax)
			if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
    349a:	8b 45 08             	mov    0x8(%ebp),%eax
    349d:	8b 40 10             	mov    0x10(%eax),%eax
    34a0:	83 f8 03             	cmp    $0x3,%eax
    34a3:	7e 10                	jle    34b5 <getbits+0x85>
    34a5:	8b 45 08             	mov    0x8(%ebp),%eax
    34a8:	8b 50 10             	mov    0x10(%eax),%edx
    34ab:	8b 45 08             	mov    0x8(%ebp),%eax
    34ae:	8b 40 1c             	mov    0x1c(%eax),%eax
    34b1:	39 c2                	cmp    %eax,%edx
    34b3:	7d 6e                	jge    3523 <getbits+0xf3>
				if (bs->eob)
    34b5:	8b 45 08             	mov    0x8(%ebp),%eax
    34b8:	8b 40 1c             	mov    0x1c(%eax),%eax
    34bb:	85 c0                	test   %eax,%eax
    34bd:	74 0c                	je     34cb <getbits+0x9b>
					bs->eobs = TRUE;
    34bf:	8b 45 08             	mov    0x8(%ebp),%eax
    34c2:	c7 40 20 01 00 00 00 	movl   $0x1,0x20(%eax)
    34c9:	eb 58                	jmp    3523 <getbits+0xf3>
				else {
					for (i=bs->buf_byte_idx; i>=0;i--)
    34cb:	8b 45 08             	mov    0x8(%ebp),%eax
    34ce:	8b 70 10             	mov    0x10(%eax),%esi
    34d1:	eb 2f                	jmp    3502 <getbits+0xd2>
						bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
    34d3:	8b 45 08             	mov    0x8(%ebp),%eax
    34d6:	8b 50 04             	mov    0x4(%eax),%edx
    34d9:	8b 45 08             	mov    0x8(%ebp),%eax
    34dc:	8b 40 08             	mov    0x8(%eax),%eax
    34df:	8d 48 ff             	lea    -0x1(%eax),%ecx
    34e2:	8b 45 08             	mov    0x8(%ebp),%eax
    34e5:	8b 40 10             	mov    0x10(%eax),%eax
    34e8:	29 c1                	sub    %eax,%ecx
    34ea:	89 c8                	mov    %ecx,%eax
    34ec:	01 f0                	add    %esi,%eax
    34ee:	01 c2                	add    %eax,%edx
    34f0:	8b 45 08             	mov    0x8(%ebp),%eax
    34f3:	8b 40 04             	mov    0x4(%eax),%eax
    34f6:	89 f1                	mov    %esi,%ecx
    34f8:	01 c8                	add    %ecx,%eax
    34fa:	0f b6 00             	movzbl (%eax),%eax
    34fd:	88 02                	mov    %al,(%edx)
			bs->buf_byte_idx--;
			if ((bs->buf_byte_idx < MINIMUM) || (bs->buf_byte_idx < bs->eob)) {
				if (bs->eob)
					bs->eobs = TRUE;
				else {
					for (i=bs->buf_byte_idx; i>=0;i--)
    34ff:	83 ee 01             	sub    $0x1,%esi
    3502:	85 f6                	test   %esi,%esi
    3504:	79 cd                	jns    34d3 <getbits+0xa3>
						bs->buf[bs->buf_size-1-bs->buf_byte_idx+i] = bs->buf[i];
						refill_buffer(bs);
    3506:	83 ec 0c             	sub    $0xc,%esp
    3509:	ff 75 08             	pushl  0x8(%ebp)
    350c:	e8 a6 fd ff ff       	call   32b7 <refill_buffer>
    3511:	83 c4 10             	add    $0x10,%esp
					bs->buf_byte_idx = bs->buf_size-1;
    3514:	8b 45 08             	mov    0x8(%ebp),%eax
    3517:	8b 40 08             	mov    0x8(%eax),%eax
    351a:	8d 50 ff             	lea    -0x1(%eax),%edx
    351d:	8b 45 08             	mov    0x8(%ebp),%eax
    3520:	89 50 10             	mov    %edx,0x10(%eax)
				}
			}
		}
		k = MIN(j, bs->buf_bit_idx);
    3523:	8b 45 08             	mov    0x8(%ebp),%eax
    3526:	8b 40 14             	mov    0x14(%eax),%eax
    3529:	39 d8                	cmp    %ebx,%eax
    352b:	0f 4f c3             	cmovg  %ebx,%eax
    352e:	89 c6                	mov    %eax,%esi
		tmp = bs->buf[bs->buf_byte_idx]&putmask[bs->buf_bit_idx];
    3530:	8b 45 08             	mov    0x8(%ebp),%eax
    3533:	8b 50 04             	mov    0x4(%eax),%edx
    3536:	8b 45 08             	mov    0x8(%ebp),%eax
    3539:	8b 40 10             	mov    0x10(%eax),%eax
    353c:	01 d0                	add    %edx,%eax
    353e:	0f b6 00             	movzbl (%eax),%eax
    3541:	0f b6 d0             	movzbl %al,%edx
    3544:	8b 45 08             	mov    0x8(%ebp),%eax
    3547:	8b 40 14             	mov    0x14(%eax),%eax
    354a:	8b 04 85 00 c8 00 00 	mov    0xc800(,%eax,4),%eax
    3551:	89 d7                	mov    %edx,%edi
    3553:	21 c7                	and    %eax,%edi
		tmp = tmp >> (bs->buf_bit_idx-k);
    3555:	8b 45 08             	mov    0x8(%ebp),%eax
    3558:	8b 40 14             	mov    0x14(%eax),%eax
    355b:	29 f0                	sub    %esi,%eax
    355d:	89 c1                	mov    %eax,%ecx
    355f:	d3 ff                	sar    %cl,%edi
		val |= tmp << (j-k);
    3561:	89 d8                	mov    %ebx,%eax
    3563:	29 f0                	sub    %esi,%eax
    3565:	89 c1                	mov    %eax,%ecx
    3567:	d3 e7                	shl    %cl,%edi
    3569:	89 f8                	mov    %edi,%eax
    356b:	09 45 e4             	or     %eax,-0x1c(%ebp)
		bs->buf_bit_idx -= k;
    356e:	8b 45 08             	mov    0x8(%ebp),%eax
    3571:	8b 40 14             	mov    0x14(%eax),%eax
    3574:	29 f0                	sub    %esi,%eax
    3576:	89 c2                	mov    %eax,%edx
    3578:	8b 45 08             	mov    0x8(%ebp),%eax
    357b:	89 50 14             	mov    %edx,0x14(%eax)
		j -= k;
    357e:	29 f3                	sub    %esi,%ebx

	if (N > MAX_LENGTH)
		printf(0,"Cannot read or write more than %d bits at a time.\n", MAX_LENGTH);

	bs->totbit += N;
	while (j > 0) {
    3580:	85 db                	test   %ebx,%ebx
    3582:	0f 8f eb fe ff ff    	jg     3473 <getbits+0x43>
		tmp = tmp >> (bs->buf_bit_idx-k);
		val |= tmp << (j-k);
		bs->buf_bit_idx -= k;
		j -= k;
	}
	return val;
    3588:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
    358b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    358e:	5b                   	pop    %ebx
    358f:	5e                   	pop    %esi
    3590:	5f                   	pop    %edi
    3591:	5d                   	pop    %ebp
    3592:	c3                   	ret    

00003593 <seek_sync>:


int seek_sync(Bit_stream_struc *bs, unsigned long sync, int N)
{
    3593:	55                   	push   %ebp
    3594:	89 e5                	mov    %esp,%ebp
    3596:	83 ec 28             	sub    $0x28,%esp
	unsigned long aligning;
	unsigned long val;
	long maxi = (int)pow(2.0, (double)N) - 1;
    3599:	db 45 10             	fildl  0x10(%ebp)
    359c:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    35a0:	dd 1c 24             	fstpl  (%esp)
    35a3:	dd 05 30 92 00 00    	fldl   0x9230
    35a9:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    35ad:	dd 1c 24             	fstpl  (%esp)
    35b0:	e8 09 f5 ff ff       	call   2abe <pow>
    35b5:	83 c4 10             	add    $0x10,%esp
    35b8:	d9 7d e6             	fnstcw -0x1a(%ebp)
    35bb:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    35bf:	b4 0c                	mov    $0xc,%ah
    35c1:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    35c5:	d9 6d e4             	fldcw  -0x1c(%ebp)
    35c8:	db 5d e0             	fistpl -0x20(%ebp)
    35cb:	d9 6d e6             	fldcw  -0x1a(%ebp)
    35ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
    35d1:	83 e8 01             	sub    $0x1,%eax
    35d4:	89 45 f0             	mov    %eax,-0x10(%ebp)

	aligning = sstell(bs)%ALIGNING;
    35d7:	83 ec 0c             	sub    $0xc,%esp
    35da:	ff 75 08             	pushl  0x8(%ebp)
    35dd:	e8 ca fc ff ff       	call   32ac <sstell>
    35e2:	83 c4 10             	add    $0x10,%esp
    35e5:	83 e0 07             	and    $0x7,%eax
    35e8:	89 45 ec             	mov    %eax,-0x14(%ebp)
	if (aligning)
    35eb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    35ef:	74 17                	je     3608 <seek_sync+0x75>
		getbits(bs, (int)(ALIGNING-aligning));
    35f1:	b8 08 00 00 00       	mov    $0x8,%eax
    35f6:	2b 45 ec             	sub    -0x14(%ebp),%eax
    35f9:	83 ec 08             	sub    $0x8,%esp
    35fc:	50                   	push   %eax
    35fd:	ff 75 08             	pushl  0x8(%ebp)
    3600:	e8 2b fe ff ff       	call   3430 <getbits>
    3605:	83 c4 10             	add    $0x10,%esp

	val = getbits(bs, N);
    3608:	83 ec 08             	sub    $0x8,%esp
    360b:	ff 75 10             	pushl  0x10(%ebp)
    360e:	ff 75 08             	pushl  0x8(%ebp)
    3611:	e8 1a fe ff ff       	call   3430 <getbits>
    3616:	83 c4 10             	add    $0x10,%esp
    3619:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while (((val&maxi) != sync) && (!end_bs(bs))) {
    361c:	eb 17                	jmp    3635 <seek_sync+0xa2>
		val <<= ALIGNING;
    361e:	c1 65 f4 08          	shll   $0x8,-0xc(%ebp)
		val |= getbits(bs, ALIGNING);
    3622:	83 ec 08             	sub    $0x8,%esp
    3625:	6a 08                	push   $0x8
    3627:	ff 75 08             	pushl  0x8(%ebp)
    362a:	e8 01 fe ff ff       	call   3430 <getbits>
    362f:	83 c4 10             	add    $0x10,%esp
    3632:	09 45 f4             	or     %eax,-0xc(%ebp)
	aligning = sstell(bs)%ALIGNING;
	if (aligning)
		getbits(bs, (int)(ALIGNING-aligning));

	val = getbits(bs, N);
	while (((val&maxi) != sync) && (!end_bs(bs))) {
    3635:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3638:	23 45 f4             	and    -0xc(%ebp),%eax
    363b:	3b 45 0c             	cmp    0xc(%ebp),%eax
    363e:	74 12                	je     3652 <seek_sync+0xbf>
    3640:	83 ec 0c             	sub    $0xc,%esp
    3643:	ff 75 08             	pushl  0x8(%ebp)
    3646:	e8 56 fc ff ff       	call   32a1 <end_bs>
    364b:	83 c4 10             	add    $0x10,%esp
    364e:	85 c0                	test   %eax,%eax
    3650:	74 cc                	je     361e <seek_sync+0x8b>
		val <<= ALIGNING;
		val |= getbits(bs, ALIGNING);
	}

	if (end_bs(bs))
    3652:	83 ec 0c             	sub    $0xc,%esp
    3655:	ff 75 08             	pushl  0x8(%ebp)
    3658:	e8 44 fc ff ff       	call   32a1 <end_bs>
    365d:	83 c4 10             	add    $0x10,%esp
    3660:	85 c0                	test   %eax,%eax
    3662:	74 07                	je     366b <seek_sync+0xd8>
		return(0);
    3664:	b8 00 00 00 00       	mov    $0x0,%eax
    3669:	eb 05                	jmp    3670 <seek_sync+0xdd>
	else
		return(1);
    366b:	b8 01 00 00 00       	mov    $0x1,%eax
}
    3670:	c9                   	leave  
    3671:	c3                   	ret    

00003672 <js_bound>:

int js_bound(int lay, int m_ext)
{
    3672:	55                   	push   %ebp
    3673:	89 e5                	mov    %esp,%ebp
    3675:	83 ec 08             	sub    $0x8,%esp
		{ 4, 8, 12, 16 },
		{ 4, 8, 12, 16},
		{ 0, 4, 8, 16}
	};  /* lay+m_e -> jsbound */

    if(lay<1 || lay >3 || m_ext<0 || m_ext>3) {
    3678:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    367c:	7e 12                	jle    3690 <js_bound+0x1e>
    367e:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
    3682:	7f 0c                	jg     3690 <js_bound+0x1e>
    3684:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    3688:	78 06                	js     3690 <js_bound+0x1e>
    368a:	83 7d 0c 03          	cmpl   $0x3,0xc(%ebp)
    368e:	7e 1a                	jle    36aa <js_bound+0x38>
        printf(0, "js_bound bad layer/modext (%d/%d)\n", lay, m_ext);
    3690:	ff 75 0c             	pushl  0xc(%ebp)
    3693:	ff 75 08             	pushl  0x8(%ebp)
    3696:	68 f8 91 00 00       	push   $0x91f8
    369b:	6a 00                	push   $0x0
    369d:	e8 50 ef ff ff       	call   25f2 <printf>
    36a2:	83 c4 10             	add    $0x10,%esp
        exit();
    36a5:	e8 69 ed ff ff       	call   2413 <exit>
    }
	return(jsb_table[lay-1][m_ext]);
    36aa:	8b 45 08             	mov    0x8(%ebp),%eax
    36ad:	83 e8 01             	sub    $0x1,%eax
    36b0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    36b7:	8b 45 0c             	mov    0xc(%ebp),%eax
    36ba:	01 d0                	add    %edx,%eax
    36bc:	8b 04 85 40 c8 00 00 	mov    0xc840(,%eax,4),%eax
}
    36c3:	c9                   	leave  
    36c4:	c3                   	ret    

000036c5 <hdr_to_frps>:

void hdr_to_frps(struct frame_params *fr_ps)
{
    36c5:	55                   	push   %ebp
    36c6:	89 e5                	mov    %esp,%ebp
    36c8:	83 ec 18             	sub    $0x18,%esp
	layer *hdr = fr_ps->header;     /* (or pass in as arg?) */
    36cb:	8b 45 08             	mov    0x8(%ebp),%eax
    36ce:	8b 00                	mov    (%eax),%eax
    36d0:	89 45 f4             	mov    %eax,-0xc(%ebp)

	fr_ps->actual_mode = hdr->mode;
    36d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    36d6:	8b 50 1c             	mov    0x1c(%eax),%edx
    36d9:	8b 45 08             	mov    0x8(%ebp),%eax
    36dc:	89 50 04             	mov    %edx,0x4(%eax)
	fr_ps->stereo = (hdr->mode == MPG_MD_MONO) ? 1 : 2;
    36df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    36e2:	8b 40 1c             	mov    0x1c(%eax),%eax
    36e5:	83 f8 03             	cmp    $0x3,%eax
    36e8:	75 07                	jne    36f1 <hdr_to_frps+0x2c>
    36ea:	ba 01 00 00 00       	mov    $0x1,%edx
    36ef:	eb 05                	jmp    36f6 <hdr_to_frps+0x31>
    36f1:	ba 02 00 00 00       	mov    $0x2,%edx
    36f6:	8b 45 08             	mov    0x8(%ebp),%eax
    36f9:	89 50 08             	mov    %edx,0x8(%eax)
	fr_ps->sblimit = SBLIMIT;
    36fc:	8b 45 08             	mov    0x8(%ebp),%eax
    36ff:	c7 40 10 20 00 00 00 	movl   $0x20,0x10(%eax)
	if(hdr->mode == MPG_MD_JOINT_STEREO)
    3706:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3709:	8b 40 1c             	mov    0x1c(%eax),%eax
    370c:	83 f8 01             	cmp    $0x1,%eax
    370f:	75 23                	jne    3734 <hdr_to_frps+0x6f>
		fr_ps->jsbound = js_bound(hdr->lay, hdr->mode_ext);
    3711:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3714:	8b 50 20             	mov    0x20(%eax),%edx
    3717:	8b 45 f4             	mov    -0xc(%ebp),%eax
    371a:	8b 40 04             	mov    0x4(%eax),%eax
    371d:	83 ec 08             	sub    $0x8,%esp
    3720:	52                   	push   %edx
    3721:	50                   	push   %eax
    3722:	e8 4b ff ff ff       	call   3672 <js_bound>
    3727:	83 c4 10             	add    $0x10,%esp
    372a:	89 c2                	mov    %eax,%edx
    372c:	8b 45 08             	mov    0x8(%ebp),%eax
    372f:	89 50 0c             	mov    %edx,0xc(%eax)
	else
		fr_ps->jsbound = fr_ps->sblimit;
}
    3732:	eb 0c                	jmp    3740 <hdr_to_frps+0x7b>
	fr_ps->stereo = (hdr->mode == MPG_MD_MONO) ? 1 : 2;
	fr_ps->sblimit = SBLIMIT;
	if(hdr->mode == MPG_MD_JOINT_STEREO)
		fr_ps->jsbound = js_bound(hdr->lay, hdr->mode_ext);
	else
		fr_ps->jsbound = fr_ps->sblimit;
    3734:	8b 45 08             	mov    0x8(%ebp),%eax
    3737:	8b 50 10             	mov    0x10(%eax),%edx
    373a:	8b 45 08             	mov    0x8(%ebp),%eax
    373d:	89 50 0c             	mov    %edx,0xc(%eax)
}
    3740:	90                   	nop
    3741:	c9                   	leave  
    3742:	c3                   	ret    

00003743 <hputbuf>:

void hputbuf(unsigned int val, int N)
{
    3743:	55                   	push   %ebp
    3744:	89 e5                	mov    %esp,%ebp
    3746:	83 ec 08             	sub    $0x8,%esp
	if (N != 8) {
    3749:	83 7d 0c 08          	cmpl   $0x8,0xc(%ebp)
    374d:	74 17                	je     3766 <hputbuf+0x23>
		printf(0,"Not Supported yet!!\n");
    374f:	83 ec 08             	sub    $0x8,%esp
    3752:	68 1b 92 00 00       	push   $0x921b
    3757:	6a 00                	push   $0x0
    3759:	e8 94 ee ff ff       	call   25f2 <printf>
    375e:	83 c4 10             	add    $0x10,%esp
		exit();
    3761:	e8 ad ec ff ff       	call   2413 <exit>
	}
	getCoreBuf(1, val);
    3766:	83 ec 08             	sub    $0x8,%esp
    3769:	ff 75 08             	pushl  0x8(%ebp)
    376c:	6a 01                	push   $0x1
    376e:	e8 a0 ed ff ff       	call   2513 <getCoreBuf>
    3773:	83 c4 10             	add    $0x10,%esp
//	buf[offset % BUFSIZE] = val;
//	offset++;
}
    3776:	90                   	nop
    3777:	c9                   	leave  
    3778:	c3                   	ret    

00003779 <hsstell>:

unsigned long hsstell()
{
    3779:	55                   	push   %ebp
    377a:	89 e5                	mov    %esp,%ebp
    377c:	83 ec 08             	sub    $0x8,%esp
	return getCoreBuf(2, 0);
    377f:	83 ec 08             	sub    $0x8,%esp
    3782:	6a 00                	push   $0x0
    3784:	6a 02                	push   $0x2
    3786:	e8 88 ed ff ff       	call   2513 <getCoreBuf>
    378b:	83 c4 10             	add    $0x10,%esp
//	return(totbit);
}
    378e:	c9                   	leave  
    378f:	c3                   	ret    

00003790 <hgetbits>:

unsigned long hgetbits(int N)
{
    3790:	55                   	push   %ebp
    3791:	89 e5                	mov    %esp,%ebp
    3793:	83 ec 08             	sub    $0x8,%esp

	return getCoreBuf(3, N);
    3796:	83 ec 08             	sub    $0x8,%esp
    3799:	ff 75 08             	pushl  0x8(%ebp)
    379c:	6a 03                	push   $0x3
    379e:	e8 70 ed ff ff       	call   2513 <getCoreBuf>
    37a3:	83 c4 10             	add    $0x10,%esp
}
    37a6:	c9                   	leave  
    37a7:	c3                   	ret    

000037a8 <hget1bit>:


unsigned int hget1bit()
{
    37a8:	55                   	push   %ebp
    37a9:	89 e5                	mov    %esp,%ebp
    37ab:	83 ec 08             	sub    $0x8,%esp
	return(hgetbits(1));
    37ae:	83 ec 0c             	sub    $0xc,%esp
    37b1:	6a 01                	push   $0x1
    37b3:	e8 d8 ff ff ff       	call   3790 <hgetbits>
    37b8:	83 c4 10             	add    $0x10,%esp
}
    37bb:	c9                   	leave  
    37bc:	c3                   	ret    

000037bd <rewindNbits>:


void rewindNbits(int N)
{
    37bd:	55                   	push   %ebp
    37be:	89 e5                	mov    %esp,%ebp
    37c0:	83 ec 08             	sub    $0x8,%esp
	getCoreBuf(4, N);
    37c3:	83 ec 08             	sub    $0x8,%esp
    37c6:	ff 75 08             	pushl  0x8(%ebp)
    37c9:	6a 04                	push   $0x4
    37cb:	e8 43 ed ff ff       	call   2513 <getCoreBuf>
    37d0:	83 c4 10             	add    $0x10,%esp
}
    37d3:	90                   	nop
    37d4:	c9                   	leave  
    37d5:	c3                   	ret    

000037d6 <rewindNbytes>:


void rewindNbytes(int N)
{
    37d6:	55                   	push   %ebp
    37d7:	89 e5                	mov    %esp,%ebp
    37d9:	83 ec 08             	sub    $0x8,%esp
	getCoreBuf(5, N);
    37dc:	83 ec 08             	sub    $0x8,%esp
    37df:	ff 75 08             	pushl  0x8(%ebp)
    37e2:	6a 05                	push   $0x5
    37e4:	e8 2a ed ff ff       	call   2513 <getCoreBuf>
    37e9:	83 c4 10             	add    $0x10,%esp
}
    37ec:	90                   	nop
    37ed:	c9                   	leave  
    37ee:	c3                   	ret    

000037ef <read_decoder_table>:
				/* 0..31 Huffman code table 0..31	*/
				/* 32,33 count1-tables			*/

/* ��ȡ huffman ����� */
void read_decoder_table() 
{
    37ef:	55                   	push   %ebp
    37f0:	89 e5                	mov    %esp,%ebp
    37f2:	57                   	push   %edi
    37f3:	56                   	push   %esi
    37f4:	53                   	push   %ebx
    37f5:	81 ec 40 1b 00 00    	sub    $0x1b40,%esp
	unsigned char h1[7][2] = {{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11}};
    37fb:	c6 45 e6 02          	movb   $0x2,-0x1a(%ebp)
    37ff:	c6 45 e7 01          	movb   $0x1,-0x19(%ebp)
    3803:	c6 45 e8 00          	movb   $0x0,-0x18(%ebp)
    3807:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    380b:	c6 45 ea 02          	movb   $0x2,-0x16(%ebp)
    380f:	c6 45 eb 01          	movb   $0x1,-0x15(%ebp)
    3813:	c6 45 ec 00          	movb   $0x0,-0x14(%ebp)
    3817:	c6 45 ed 10          	movb   $0x10,-0x13(%ebp)
    381b:	c6 45 ee 02          	movb   $0x2,-0x12(%ebp)
    381f:	c6 45 ef 01          	movb   $0x1,-0x11(%ebp)
    3823:	c6 45 f0 00          	movb   $0x0,-0x10(%ebp)
    3827:	c6 45 f1 01          	movb   $0x1,-0xf(%ebp)
    382b:	c6 45 f2 00          	movb   $0x0,-0xe(%ebp)
    382f:	c6 45 f3 11          	movb   $0x11,-0xd(%ebp)

	unsigned char h2[17][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22}};
    3833:	c6 45 c4 02          	movb   $0x2,-0x3c(%ebp)
    3837:	c6 45 c5 01          	movb   $0x1,-0x3b(%ebp)
    383b:	c6 45 c6 00          	movb   $0x0,-0x3a(%ebp)
    383f:	c6 45 c7 00          	movb   $0x0,-0x39(%ebp)
    3843:	c6 45 c8 04          	movb   $0x4,-0x38(%ebp)
    3847:	c6 45 c9 01          	movb   $0x1,-0x37(%ebp)
    384b:	c6 45 ca 02          	movb   $0x2,-0x36(%ebp)
    384f:	c6 45 cb 01          	movb   $0x1,-0x35(%ebp)
    3853:	c6 45 cc 00          	movb   $0x0,-0x34(%ebp)
    3857:	c6 45 cd 10          	movb   $0x10,-0x33(%ebp)
    385b:	c6 45 ce 00          	movb   $0x0,-0x32(%ebp)
    385f:	c6 45 cf 01          	movb   $0x1,-0x31(%ebp)
    3863:	c6 45 d0 02          	movb   $0x2,-0x30(%ebp)
    3867:	c6 45 d1 01          	movb   $0x1,-0x2f(%ebp)
    386b:	c6 45 d2 00          	movb   $0x0,-0x2e(%ebp)
    386f:	c6 45 d3 11          	movb   $0x11,-0x2d(%ebp)
    3873:	c6 45 d4 04          	movb   $0x4,-0x2c(%ebp)
    3877:	c6 45 d5 01          	movb   $0x1,-0x2b(%ebp)
    387b:	c6 45 d6 02          	movb   $0x2,-0x2a(%ebp)
    387f:	c6 45 d7 01          	movb   $0x1,-0x29(%ebp)
    3883:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
    3887:	c6 45 d9 20          	movb   $0x20,-0x27(%ebp)
    388b:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
    388f:	c6 45 db 21          	movb   $0x21,-0x25(%ebp)
    3893:	c6 45 dc 02          	movb   $0x2,-0x24(%ebp)
    3897:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
    389b:	c6 45 de 00          	movb   $0x0,-0x22(%ebp)
    389f:	c6 45 df 12          	movb   $0x12,-0x21(%ebp)
    38a3:	c6 45 e0 02          	movb   $0x2,-0x20(%ebp)
    38a7:	c6 45 e1 01          	movb   $0x1,-0x1f(%ebp)
    38ab:	c6 45 e2 00          	movb   $0x0,-0x1e(%ebp)
    38af:	c6 45 e3 02          	movb   $0x2,-0x1d(%ebp)
    38b3:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
    38b7:	c6 45 e5 22          	movb   $0x22,-0x1b(%ebp)

	unsigned char h3[17][2] = {{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x2,0x1},{0x0,0x10},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22}};
    38bb:	c6 45 a2 04          	movb   $0x4,-0x5e(%ebp)
    38bf:	c6 45 a3 01          	movb   $0x1,-0x5d(%ebp)
    38c3:	c6 45 a4 02          	movb   $0x2,-0x5c(%ebp)
    38c7:	c6 45 a5 01          	movb   $0x1,-0x5b(%ebp)
    38cb:	c6 45 a6 00          	movb   $0x0,-0x5a(%ebp)
    38cf:	c6 45 a7 00          	movb   $0x0,-0x59(%ebp)
    38d3:	c6 45 a8 00          	movb   $0x0,-0x58(%ebp)
    38d7:	c6 45 a9 01          	movb   $0x1,-0x57(%ebp)
    38db:	c6 45 aa 02          	movb   $0x2,-0x56(%ebp)
    38df:	c6 45 ab 01          	movb   $0x1,-0x55(%ebp)
    38e3:	c6 45 ac 00          	movb   $0x0,-0x54(%ebp)
    38e7:	c6 45 ad 11          	movb   $0x11,-0x53(%ebp)
    38eb:	c6 45 ae 02          	movb   $0x2,-0x52(%ebp)
    38ef:	c6 45 af 01          	movb   $0x1,-0x51(%ebp)
    38f3:	c6 45 b0 00          	movb   $0x0,-0x50(%ebp)
    38f7:	c6 45 b1 10          	movb   $0x10,-0x4f(%ebp)
    38fb:	c6 45 b2 04          	movb   $0x4,-0x4e(%ebp)
    38ff:	c6 45 b3 01          	movb   $0x1,-0x4d(%ebp)
    3903:	c6 45 b4 02          	movb   $0x2,-0x4c(%ebp)
    3907:	c6 45 b5 01          	movb   $0x1,-0x4b(%ebp)
    390b:	c6 45 b6 00          	movb   $0x0,-0x4a(%ebp)
    390f:	c6 45 b7 20          	movb   $0x20,-0x49(%ebp)
    3913:	c6 45 b8 00          	movb   $0x0,-0x48(%ebp)
    3917:	c6 45 b9 21          	movb   $0x21,-0x47(%ebp)
    391b:	c6 45 ba 02          	movb   $0x2,-0x46(%ebp)
    391f:	c6 45 bb 01          	movb   $0x1,-0x45(%ebp)
    3923:	c6 45 bc 00          	movb   $0x0,-0x44(%ebp)
    3927:	c6 45 bd 12          	movb   $0x12,-0x43(%ebp)
    392b:	c6 45 be 02          	movb   $0x2,-0x42(%ebp)
    392f:	c6 45 bf 01          	movb   $0x1,-0x41(%ebp)
    3933:	c6 45 c0 00          	movb   $0x0,-0x40(%ebp)
    3937:	c6 45 c1 02          	movb   $0x2,-0x3f(%ebp)
    393b:	c6 45 c2 00          	movb   $0x0,-0x3e(%ebp)
    393f:	c6 45 c3 22          	movb   $0x22,-0x3d(%ebp)

	unsigned char h5[31][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x13},{0x2,0x1},{0x0,0x31},{0x2,0x1},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x33}};
    3943:	c6 85 64 ff ff ff 02 	movb   $0x2,-0x9c(%ebp)
    394a:	c6 85 65 ff ff ff 01 	movb   $0x1,-0x9b(%ebp)
    3951:	c6 85 66 ff ff ff 00 	movb   $0x0,-0x9a(%ebp)
    3958:	c6 85 67 ff ff ff 00 	movb   $0x0,-0x99(%ebp)
    395f:	c6 85 68 ff ff ff 04 	movb   $0x4,-0x98(%ebp)
    3966:	c6 85 69 ff ff ff 01 	movb   $0x1,-0x97(%ebp)
    396d:	c6 85 6a ff ff ff 02 	movb   $0x2,-0x96(%ebp)
    3974:	c6 85 6b ff ff ff 01 	movb   $0x1,-0x95(%ebp)
    397b:	c6 85 6c ff ff ff 00 	movb   $0x0,-0x94(%ebp)
    3982:	c6 85 6d ff ff ff 10 	movb   $0x10,-0x93(%ebp)
    3989:	c6 85 6e ff ff ff 00 	movb   $0x0,-0x92(%ebp)
    3990:	c6 85 6f ff ff ff 01 	movb   $0x1,-0x91(%ebp)
    3997:	c6 85 70 ff ff ff 02 	movb   $0x2,-0x90(%ebp)
    399e:	c6 85 71 ff ff ff 01 	movb   $0x1,-0x8f(%ebp)
    39a5:	c6 85 72 ff ff ff 00 	movb   $0x0,-0x8e(%ebp)
    39ac:	c6 85 73 ff ff ff 11 	movb   $0x11,-0x8d(%ebp)
    39b3:	c6 85 74 ff ff ff 08 	movb   $0x8,-0x8c(%ebp)
    39ba:	c6 85 75 ff ff ff 01 	movb   $0x1,-0x8b(%ebp)
    39c1:	c6 85 76 ff ff ff 04 	movb   $0x4,-0x8a(%ebp)
    39c8:	c6 85 77 ff ff ff 01 	movb   $0x1,-0x89(%ebp)
    39cf:	c6 85 78 ff ff ff 02 	movb   $0x2,-0x88(%ebp)
    39d6:	c6 85 79 ff ff ff 01 	movb   $0x1,-0x87(%ebp)
    39dd:	c6 85 7a ff ff ff 00 	movb   $0x0,-0x86(%ebp)
    39e4:	c6 85 7b ff ff ff 20 	movb   $0x20,-0x85(%ebp)
    39eb:	c6 85 7c ff ff ff 00 	movb   $0x0,-0x84(%ebp)
    39f2:	c6 85 7d ff ff ff 02 	movb   $0x2,-0x83(%ebp)
    39f9:	c6 85 7e ff ff ff 02 	movb   $0x2,-0x82(%ebp)
    3a00:	c6 85 7f ff ff ff 01 	movb   $0x1,-0x81(%ebp)
    3a07:	c6 45 80 00          	movb   $0x0,-0x80(%ebp)
    3a0b:	c6 45 81 21          	movb   $0x21,-0x7f(%ebp)
    3a0f:	c6 45 82 00          	movb   $0x0,-0x7e(%ebp)
    3a13:	c6 45 83 12          	movb   $0x12,-0x7d(%ebp)
    3a17:	c6 45 84 08          	movb   $0x8,-0x7c(%ebp)
    3a1b:	c6 45 85 01          	movb   $0x1,-0x7b(%ebp)
    3a1f:	c6 45 86 04          	movb   $0x4,-0x7a(%ebp)
    3a23:	c6 45 87 01          	movb   $0x1,-0x79(%ebp)
    3a27:	c6 45 88 02          	movb   $0x2,-0x78(%ebp)
    3a2b:	c6 45 89 01          	movb   $0x1,-0x77(%ebp)
    3a2f:	c6 45 8a 00          	movb   $0x0,-0x76(%ebp)
    3a33:	c6 45 8b 22          	movb   $0x22,-0x75(%ebp)
    3a37:	c6 45 8c 00          	movb   $0x0,-0x74(%ebp)
    3a3b:	c6 45 8d 30          	movb   $0x30,-0x73(%ebp)
    3a3f:	c6 45 8e 02          	movb   $0x2,-0x72(%ebp)
    3a43:	c6 45 8f 01          	movb   $0x1,-0x71(%ebp)
    3a47:	c6 45 90 00          	movb   $0x0,-0x70(%ebp)
    3a4b:	c6 45 91 03          	movb   $0x3,-0x6f(%ebp)
    3a4f:	c6 45 92 00          	movb   $0x0,-0x6e(%ebp)
    3a53:	c6 45 93 13          	movb   $0x13,-0x6d(%ebp)
    3a57:	c6 45 94 02          	movb   $0x2,-0x6c(%ebp)
    3a5b:	c6 45 95 01          	movb   $0x1,-0x6b(%ebp)
    3a5f:	c6 45 96 00          	movb   $0x0,-0x6a(%ebp)
    3a63:	c6 45 97 31          	movb   $0x31,-0x69(%ebp)
    3a67:	c6 45 98 02          	movb   $0x2,-0x68(%ebp)
    3a6b:	c6 45 99 01          	movb   $0x1,-0x67(%ebp)
    3a6f:	c6 45 9a 00          	movb   $0x0,-0x66(%ebp)
    3a73:	c6 45 9b 32          	movb   $0x32,-0x65(%ebp)
    3a77:	c6 45 9c 02          	movb   $0x2,-0x64(%ebp)
    3a7b:	c6 45 9d 01          	movb   $0x1,-0x63(%ebp)
    3a7f:	c6 45 9e 00          	movb   $0x0,-0x62(%ebp)
    3a83:	c6 45 9f 23          	movb   $0x23,-0x61(%ebp)
    3a87:	c6 45 a0 00          	movb   $0x0,-0x60(%ebp)
    3a8b:	c6 45 a1 33          	movb   $0x33,-0x5f(%ebp)

	unsigned char h6[31][2] = {{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x0,0x11},{0x6,0x1},{0x2,0x1},{0x0,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x6,0x1},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x2,0x1},{0x0,0x3},{0x0,0x33}};
    3a8f:	c6 85 26 ff ff ff 06 	movb   $0x6,-0xda(%ebp)
    3a96:	c6 85 27 ff ff ff 01 	movb   $0x1,-0xd9(%ebp)
    3a9d:	c6 85 28 ff ff ff 04 	movb   $0x4,-0xd8(%ebp)
    3aa4:	c6 85 29 ff ff ff 01 	movb   $0x1,-0xd7(%ebp)
    3aab:	c6 85 2a ff ff ff 02 	movb   $0x2,-0xd6(%ebp)
    3ab2:	c6 85 2b ff ff ff 01 	movb   $0x1,-0xd5(%ebp)
    3ab9:	c6 85 2c ff ff ff 00 	movb   $0x0,-0xd4(%ebp)
    3ac0:	c6 85 2d ff ff ff 00 	movb   $0x0,-0xd3(%ebp)
    3ac7:	c6 85 2e ff ff ff 00 	movb   $0x0,-0xd2(%ebp)
    3ace:	c6 85 2f ff ff ff 10 	movb   $0x10,-0xd1(%ebp)
    3ad5:	c6 85 30 ff ff ff 00 	movb   $0x0,-0xd0(%ebp)
    3adc:	c6 85 31 ff ff ff 11 	movb   $0x11,-0xcf(%ebp)
    3ae3:	c6 85 32 ff ff ff 06 	movb   $0x6,-0xce(%ebp)
    3aea:	c6 85 33 ff ff ff 01 	movb   $0x1,-0xcd(%ebp)
    3af1:	c6 85 34 ff ff ff 02 	movb   $0x2,-0xcc(%ebp)
    3af8:	c6 85 35 ff ff ff 01 	movb   $0x1,-0xcb(%ebp)
    3aff:	c6 85 36 ff ff ff 00 	movb   $0x0,-0xca(%ebp)
    3b06:	c6 85 37 ff ff ff 01 	movb   $0x1,-0xc9(%ebp)
    3b0d:	c6 85 38 ff ff ff 02 	movb   $0x2,-0xc8(%ebp)
    3b14:	c6 85 39 ff ff ff 01 	movb   $0x1,-0xc7(%ebp)
    3b1b:	c6 85 3a ff ff ff 00 	movb   $0x0,-0xc6(%ebp)
    3b22:	c6 85 3b ff ff ff 20 	movb   $0x20,-0xc5(%ebp)
    3b29:	c6 85 3c ff ff ff 00 	movb   $0x0,-0xc4(%ebp)
    3b30:	c6 85 3d ff ff ff 21 	movb   $0x21,-0xc3(%ebp)
    3b37:	c6 85 3e ff ff ff 06 	movb   $0x6,-0xc2(%ebp)
    3b3e:	c6 85 3f ff ff ff 01 	movb   $0x1,-0xc1(%ebp)
    3b45:	c6 85 40 ff ff ff 02 	movb   $0x2,-0xc0(%ebp)
    3b4c:	c6 85 41 ff ff ff 01 	movb   $0x1,-0xbf(%ebp)
    3b53:	c6 85 42 ff ff ff 00 	movb   $0x0,-0xbe(%ebp)
    3b5a:	c6 85 43 ff ff ff 12 	movb   $0x12,-0xbd(%ebp)
    3b61:	c6 85 44 ff ff ff 02 	movb   $0x2,-0xbc(%ebp)
    3b68:	c6 85 45 ff ff ff 01 	movb   $0x1,-0xbb(%ebp)
    3b6f:	c6 85 46 ff ff ff 00 	movb   $0x0,-0xba(%ebp)
    3b76:	c6 85 47 ff ff ff 02 	movb   $0x2,-0xb9(%ebp)
    3b7d:	c6 85 48 ff ff ff 00 	movb   $0x0,-0xb8(%ebp)
    3b84:	c6 85 49 ff ff ff 22 	movb   $0x22,-0xb7(%ebp)
    3b8b:	c6 85 4a ff ff ff 04 	movb   $0x4,-0xb6(%ebp)
    3b92:	c6 85 4b ff ff ff 01 	movb   $0x1,-0xb5(%ebp)
    3b99:	c6 85 4c ff ff ff 02 	movb   $0x2,-0xb4(%ebp)
    3ba0:	c6 85 4d ff ff ff 01 	movb   $0x1,-0xb3(%ebp)
    3ba7:	c6 85 4e ff ff ff 00 	movb   $0x0,-0xb2(%ebp)
    3bae:	c6 85 4f ff ff ff 31 	movb   $0x31,-0xb1(%ebp)
    3bb5:	c6 85 50 ff ff ff 00 	movb   $0x0,-0xb0(%ebp)
    3bbc:	c6 85 51 ff ff ff 13 	movb   $0x13,-0xaf(%ebp)
    3bc3:	c6 85 52 ff ff ff 04 	movb   $0x4,-0xae(%ebp)
    3bca:	c6 85 53 ff ff ff 01 	movb   $0x1,-0xad(%ebp)
    3bd1:	c6 85 54 ff ff ff 02 	movb   $0x2,-0xac(%ebp)
    3bd8:	c6 85 55 ff ff ff 01 	movb   $0x1,-0xab(%ebp)
    3bdf:	c6 85 56 ff ff ff 00 	movb   $0x0,-0xaa(%ebp)
    3be6:	c6 85 57 ff ff ff 30 	movb   $0x30,-0xa9(%ebp)
    3bed:	c6 85 58 ff ff ff 00 	movb   $0x0,-0xa8(%ebp)
    3bf4:	c6 85 59 ff ff ff 32 	movb   $0x32,-0xa7(%ebp)
    3bfb:	c6 85 5a ff ff ff 02 	movb   $0x2,-0xa6(%ebp)
    3c02:	c6 85 5b ff ff ff 01 	movb   $0x1,-0xa5(%ebp)
    3c09:	c6 85 5c ff ff ff 00 	movb   $0x0,-0xa4(%ebp)
    3c10:	c6 85 5d ff ff ff 23 	movb   $0x23,-0xa3(%ebp)
    3c17:	c6 85 5e ff ff ff 02 	movb   $0x2,-0xa2(%ebp)
    3c1e:	c6 85 5f ff ff ff 01 	movb   $0x1,-0xa1(%ebp)
    3c25:	c6 85 60 ff ff ff 00 	movb   $0x0,-0xa0(%ebp)
    3c2c:	c6 85 61 ff ff ff 03 	movb   $0x3,-0x9f(%ebp)
    3c33:	c6 85 62 ff ff ff 00 	movb   $0x0,-0x9e(%ebp)
    3c3a:	c6 85 63 ff ff ff 33 	movb   $0x33,-0x9d(%ebp)

	unsigned char h7[71][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x21},{0x12,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x3},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x4},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x41},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x43},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x34},{0x0,0x5},{0x0,0x51},{0x6,0x1},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x4,0x1},{0x2,0x1},{0x0,0x53},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x55}};
    3c41:	8d 85 98 fe ff ff    	lea    -0x168(%ebp),%eax
    3c47:	ba 40 92 00 00       	mov    $0x9240,%edx
    3c4c:	b9 23 00 00 00       	mov    $0x23,%ecx
    3c51:	89 c7                	mov    %eax,%edi
    3c53:	89 d6                	mov    %edx,%esi
    3c55:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    3c57:	89 f2                	mov    %esi,%edx
    3c59:	89 f8                	mov    %edi,%eax
    3c5b:	0f b7 0a             	movzwl (%edx),%ecx
    3c5e:	66 89 08             	mov    %cx,(%eax)
    3c61:	8d 40 02             	lea    0x2(%eax),%eax
    3c64:	8d 52 02             	lea    0x2(%edx),%edx

	unsigned char h8[71][2] = {{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x22},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x2,0x1},{0x0,0x41},{0x2,0x1},{0x0,0x14},{0x0,0x42},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x24},{0x2,0x1},{0x0,0x33},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x6,0x1},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x6,0x1},{0x2,0x1},{0x0,0x25},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x2,0x1},{0x0,0x53},{0x2,0x1},{0x0,0x45},{0x2,0x1},{0x0,0x54},{0x0,0x55}};
    3c67:	8d 85 0a fe ff ff    	lea    -0x1f6(%ebp),%eax
    3c6d:	bb e0 92 00 00       	mov    $0x92e0,%ebx
    3c72:	ba 8e 00 00 00       	mov    $0x8e,%edx
    3c77:	8b 0b                	mov    (%ebx),%ecx
    3c79:	89 08                	mov    %ecx,(%eax)
    3c7b:	8b 4c 13 fc          	mov    -0x4(%ebx,%edx,1),%ecx
    3c7f:	89 4c 10 fc          	mov    %ecx,-0x4(%eax,%edx,1)
    3c83:	8d 78 04             	lea    0x4(%eax),%edi
    3c86:	83 e7 fc             	and    $0xfffffffc,%edi
    3c89:	29 f8                	sub    %edi,%eax
    3c8b:	29 c3                	sub    %eax,%ebx
    3c8d:	01 c2                	add    %eax,%edx
    3c8f:	83 e2 fc             	and    $0xfffffffc,%edx
    3c92:	89 d0                	mov    %edx,%eax
    3c94:	c1 e8 02             	shr    $0x2,%eax
    3c97:	89 de                	mov    %ebx,%esi
    3c99:	89 c1                	mov    %eax,%ecx
    3c9b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	unsigned char h9[71][2] = {{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x2},{0x0,0x22},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x0,0x31},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x50},{0x0,0x43},{0x2,0x1},{0x0,0x34},{0x0,0x51},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x15},{0x0,0x52},{0x2,0x1},{0x0,0x25},{0x0,0x44},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x54},{0x0,0x53},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x45},{0x0,0x55}};
    3c9d:	8d 85 7c fd ff ff    	lea    -0x284(%ebp),%eax
    3ca3:	ba 80 93 00 00       	mov    $0x9380,%edx
    3ca8:	b9 23 00 00 00       	mov    $0x23,%ecx
    3cad:	89 c7                	mov    %eax,%edi
    3caf:	89 d6                	mov    %edx,%esi
    3cb1:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    3cb3:	89 f2                	mov    %esi,%edx
    3cb5:	89 f8                	mov    %edi,%eax
    3cb7:	0f b7 0a             	movzwl (%edx),%ecx
    3cba:	66 89 08             	mov    %cx,(%eax)
    3cbd:	8d 40 02             	lea    0x2(%eax),%eax
    3cc0:	8d 52 02             	lea    0x2(%edx),%edx

	unsigned char h10[127][2] = {{0x2,0x1},{0x0,0x0},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0xa,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x1c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x3},{0x0,0x32},{0x2,0x1},{0x0,0x23},{0x0,0x40},{0x4,0x1},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x1c,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x0,0x60},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x36},{0x0,0x71},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x17},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x0,0x6},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x35},{0x0,0x45},{0x0,0x62},{0x2,0x1},{0x0,0x70},{0x2,0x1},{0x0,0x7},{0x0,0x64},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x6,0x1},{0x2,0x1},{0x0,0x63},{0x2,0x1},{0x0,0x54},{0x0,0x55},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x37},{0x0,0x65},{0x2,0x1},{0x0,0x56},{0x0,0x74},{0x6,0x1},{0x2,0x1},{0x0,0x47},{0x2,0x1},{0x0,0x66},{0x0,0x75},{0x4,0x1},{0x2,0x1},{0x0,0x57},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    3cc3:	8d 85 7e fc ff ff    	lea    -0x382(%ebp),%eax
    3cc9:	bb 20 94 00 00       	mov    $0x9420,%ebx
    3cce:	ba fe 00 00 00       	mov    $0xfe,%edx
    3cd3:	8b 0b                	mov    (%ebx),%ecx
    3cd5:	89 08                	mov    %ecx,(%eax)
    3cd7:	8b 4c 13 fc          	mov    -0x4(%ebx,%edx,1),%ecx
    3cdb:	89 4c 10 fc          	mov    %ecx,-0x4(%eax,%edx,1)
    3cdf:	8d 78 04             	lea    0x4(%eax),%edi
    3ce2:	83 e7 fc             	and    $0xfffffffc,%edi
    3ce5:	29 f8                	sub    %edi,%eax
    3ce7:	29 c3                	sub    %eax,%ebx
    3ce9:	01 c2                	add    %eax,%edx
    3ceb:	83 e2 fc             	and    $0xfffffffc,%edx
    3cee:	89 d0                	mov    %edx,%eax
    3cf0:	c1 e8 02             	shr    $0x2,%eax
    3cf3:	89 de                	mov    %ebx,%esi
    3cf5:	89 c1                	mov    %eax,%ecx
    3cf7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	unsigned char h11[127][2] = {{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x12},{0x18,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x21},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x2,0x1},{0x0,0x41},{0x0,0x14},{0x1e,0x1},{0x10,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x43},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x34},{0x0,0x51},{0x0,0x61},{0x6,0x1},{0x2,0x1},{0x0,0x16},{0x2,0x1},{0x0,0x6},{0x0,0x26},{0x2,0x1},{0x0,0x62},{0x2,0x1},{0x0,0x15},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x10,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x25},{0x0,0x44},{0x0,0x60},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x17},{0x0,0x71},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x7},{0x0,0x64},{0x0,0x72},{0x2,0x1},{0x0,0x27},{0x4,0x1},{0x2,0x1},{0x0,0x53},{0x0,0x35},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x2,0x1},{0x0,0x65},{0x0,0x56},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x55},{0x0,0x57},{0x0,0x74},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    3cf9:	8d 85 80 fb ff ff    	lea    -0x480(%ebp),%eax
    3cff:	ba 20 95 00 00       	mov    $0x9520,%edx
    3d04:	b9 3f 00 00 00       	mov    $0x3f,%ecx
    3d09:	89 c7                	mov    %eax,%edi
    3d0b:	89 d6                	mov    %edx,%esi
    3d0d:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    3d0f:	89 f2                	mov    %esi,%edx
    3d11:	89 f8                	mov    %edi,%eax
    3d13:	0f b7 0a             	movzwl (%edx),%ecx
    3d16:	66 89 08             	mov    %cx,(%eax)
    3d19:	8d 40 02             	lea    0x2(%eax),%eax
    3d1c:	8d 52 02             	lea    0x2(%edx),%edx

	unsigned char h12[127][2] = {{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x10,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x31},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x40},{0x1a,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x2,0x1},{0x0,0x41},{0x0,0x33},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x14},{0x0,0x42},{0x2,0x1},{0x0,0x24},{0x2,0x1},{0x0,0x4},{0x0,0x50},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x1c,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x2,0x1},{0x0,0x53},{0x0,0x35},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x16},{0x0,0x61},{0x4,0x1},{0x2,0x1},{0x0,0x62},{0x0,0x26},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x6},{0x0,0x44},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x0,0x71},{0x4,0x1},{0x2,0x1},{0x0,0x17},{0x0,0x64},{0x2,0x1},{0x0,0x46},{0x0,0x72},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x27},{0x2,0x1},{0x0,0x55},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x0,0x56},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x65},{0x0,0x74},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x77}};
    3d1f:	8d 85 82 fa ff ff    	lea    -0x57e(%ebp),%eax
    3d25:	bb 20 96 00 00       	mov    $0x9620,%ebx
    3d2a:	ba fe 00 00 00       	mov    $0xfe,%edx
    3d2f:	8b 0b                	mov    (%ebx),%ecx
    3d31:	89 08                	mov    %ecx,(%eax)
    3d33:	8b 4c 13 fc          	mov    -0x4(%ebx,%edx,1),%ecx
    3d37:	89 4c 10 fc          	mov    %ecx,-0x4(%eax,%edx,1)
    3d3b:	8d 78 04             	lea    0x4(%eax),%edi
    3d3e:	83 e7 fc             	and    $0xfffffffc,%edi
    3d41:	29 f8                	sub    %edi,%eax
    3d43:	29 c3                	sub    %eax,%ebx
    3d45:	01 c2                	add    %eax,%edx
    3d47:	83 e2 fc             	and    $0xfffffffc,%edx
    3d4a:	89 d0                	mov    %edx,%eax
    3d4c:	c1 e8 02             	shr    $0x2,%eax
    3d4f:	89 de                	mov    %ebx,%esi
    3d51:	89 c1                	mov    %eax,%ecx
    3d53:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	unsigned char h13[511][2] = {{0x2,0x1},{0x0,0x0},{0x6,0x1},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0x1c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x22},{0x0,0x30},{0x2,0x1},{0x0,0x3},{0x0,0x31},{0x6,0x1},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x46,0x1},{0x1c,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x4,0x1},{0x2,0x1},{0x0,0x24},{0x0,0x50},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x4,0x1},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x52},{0x2,0x1},{0x0,0x25},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0x4,0x1},{0x2,0x1},{0x0,0x80},{0x0,0x8},{0x0,0x81},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x35},{0x0,0x62},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x4,0x1},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0x2,0x1},{0x0,0x36},{0x0,0x70},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x7},{0x0,0x55},{0x0,0x71},{0x2,0x1},{0x0,0x17},{0x2,0x1},{0x0,0x27},{0x0,0x37},{0x48,0x1},{0x18,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x18},{0x0,0x82},{0x2,0x1},{0x0,0x28},{0x4,0x1},{0x2,0x1},{0x0,0x64},{0x0,0x46},{0x0,0x72},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x2,0x1},{0x0,0x90},{0x0,0x9},{0x2,0x1},{0x0,0x91},{0x0,0x19},{0x18,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x73},{0x0,0x65},{0x2,0x1},{0x0,0x56},{0x0,0x74},{0x4,0x1},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x0,0x83},{0x6,0x1},{0x2,0x1},{0x0,0x38},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x92},{0x0,0x29},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x67},{0x0,0x85},{0x2,0x1},{0x0,0x58},{0x0,0x39},{0x2,0x1},{0x0,0x93},{0x2,0x1},{0x0,0x49},{0x0,0x86},{0x6,0x1},{0x2,0x1},{0x0,0xa0},{0x2,0x1},{0x0,0x68},{0x0,0xa},{0x2,0x1},{0x0,0xa1},{0x0,0x1a},{0x44,0x1},{0x18,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x4,0x1},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x2,0x1},{0x0,0xa3},{0x0,0x3a},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4a},{0x0,0x96},{0x2,0x1},{0x0,0xb0},{0x0,0xb},{0x2,0x1},{0x0,0xb1},{0x0,0x1b},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0xb2},{0x4,0x1},{0x2,0x1},{0x0,0x76},{0x0,0x77},{0x0,0x94},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x87},{0x0,0x78},{0x0,0xa4},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xa5},{0x0,0x2b},{0xc,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5a},{0x0,0x88},{0x0,0xb3},{0x2,0x1},{0x0,0x3b},{0x2,0x1},{0x0,0x79},{0x0,0xa6},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x6a},{0x0,0xb4},{0x0,0xc0},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0x98},{0x0,0xc1},{0x3c,0x1},{0x16,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x1c},{0x2,0x1},{0x0,0x89},{0x0,0xb5},{0x2,0x1},{0x0,0x5b},{0x0,0xc2},{0x4,0x1},{0x2,0x1},{0x0,0x2c},{0x0,0x3c},{0x4,0x1},{0x2,0x1},{0x0,0xb6},{0x0,0x6b},{0x2,0x1},{0x0,0xc4},{0x0,0x4c},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa8},{0x0,0x8a},{0x2,0x1},{0x0,0xd0},{0x0,0xd},{0x2,0x1},{0x0,0xd1},{0x2,0x1},{0x0,0x4b},{0x2,0x1},{0x0,0x97},{0x0,0xa7},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xc3},{0x2,0x1},{0x0,0x7a},{0x0,0x99},{0x4,0x1},{0x2,0x1},{0x0,0xc5},{0x0,0x5c},{0x0,0xb7},{0x4,0x1},{0x2,0x1},{0x0,0x1d},{0x0,0xd2},{0x2,0x1},{0x0,0x2d},{0x2,0x1},{0x0,0x7b},{0x0,0xd3},{0x34,0x1},{0x1c,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x4,0x1},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x2,0x1},{0x0,0x9a},{0x0,0xd4},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb8},{0x0,0x8b},{0x2,0x1},{0x0,0x4d},{0x0,0xc7},{0x4,0x1},{0x2,0x1},{0x0,0x7c},{0x0,0xd5},{0x2,0x1},{0x0,0x5d},{0x0,0xe0},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe1},{0x0,0x1e},{0x4,0x1},{0x2,0x1},{0x0,0xe},{0x0,0x2e},{0x0,0xe2},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe3},{0x0,0x6d},{0x2,0x1},{0x0,0x8c},{0x0,0xe4},{0x4,0x1},{0x2,0x1},{0x0,0xe5},{0x0,0xba},{0x0,0xf0},{0x26,0x1},{0x10,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf1},{0x0,0x1f},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xaa},{0x0,0x9b},{0x0,0xb9},{0x2,0x1},{0x0,0x3e},{0x2,0x1},{0x0,0xd6},{0x0,0xc8},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x4e},{0x2,0x1},{0x0,0xd7},{0x0,0x7d},{0x2,0x1},{0x0,0xab},{0x2,0x1},{0x0,0x5e},{0x0,0xc9},{0x6,0x1},{0x2,0x1},{0x0,0xf},{0x2,0x1},{0x0,0x9c},{0x0,0x6e},{0x2,0x1},{0x0,0xf2},{0x0,0x2f},{0x20,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0x8d},{0x0,0x3f},{0x6,0x1},{0x2,0x1},{0x0,0xf3},{0x2,0x1},{0x0,0xe6},{0x0,0xca},{0x2,0x1},{0x0,0xf4},{0x0,0x4f},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbb},{0x0,0xac},{0x2,0x1},{0x0,0xe7},{0x0,0xf5},{0x4,0x1},{0x2,0x1},{0x0,0xd9},{0x0,0x9d},{0x2,0x1},{0x0,0x5f},{0x0,0xe8},{0x1e,0x1},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x6f},{0x2,0x1},{0x0,0xf6},{0x0,0xcb},{0x4,0x1},{0x2,0x1},{0x0,0xbc},{0x0,0xad},{0x0,0xda},{0x8,0x1},{0x2,0x1},{0x0,0xf7},{0x4,0x1},{0x2,0x1},{0x0,0x7e},{0x0,0x7f},{0x0,0x8e},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xae},{0x0,0xcc},{0x2,0x1},{0x0,0xf8},{0x0,0x8f},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x2,0x1},{0x0,0xea},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xeb},{0x2,0x1},{0x0,0xbe},{0x2,0x1},{0x0,0xcd},{0x0,0xfa},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe9},{0x0,0xaf},{0x0,0xdc},{0x2,0x1},{0x0,0xce},{0x0,0xfb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbf},{0x0,0xde},{0x2,0x1},{0x0,0xcf},{0x0,0xee},{0x4,0x1},{0x2,0x1},{0x0,0xdf},{0x0,0xef},{0x2,0x1},{0x0,0xff},{0x2,0x1},{0x0,0xed},{0x2,0x1},{0x0,0xfd},{0x2,0x1},{0x0,0xfc},{0x0,0xfe}};
    3d55:	8d 85 84 f6 ff ff    	lea    -0x97c(%ebp),%eax
    3d5b:	ba 20 97 00 00       	mov    $0x9720,%edx
    3d60:	b9 ff 00 00 00       	mov    $0xff,%ecx
    3d65:	89 c7                	mov    %eax,%edi
    3d67:	89 d6                	mov    %edx,%esi
    3d69:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    3d6b:	89 f2                	mov    %esi,%edx
    3d6d:	89 f8                	mov    %edi,%eax
    3d6f:	0f b7 0a             	movzwl (%edx),%ecx
    3d72:	66 89 08             	mov    %cx,(%eax)
    3d75:	8d 40 02             	lea    0x2(%eax),%eax
    3d78:	8d 52 02             	lea    0x2(%edx),%edx

	unsigned char h15[511][2] = {{0x10,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x0},{0x2,0x1},{0x0,0x10},{0x0,0x1},{0x2,0x1},{0x0,0x11},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0x32,0x1},{0x10,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x31},{0x6,0x1},{0x2,0x1},{0x0,0x13},{0x2,0x1},{0x0,0x3},{0x0,0x40},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x14},{0x0,0x41},{0x4,0x1},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x2,0x1},{0x0,0x24},{0x0,0x43},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x34},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x2,0x1},{0x0,0x51},{0x0,0x15},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x0,0x61},{0x5a,0x1},{0x24,0x1},{0x12,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x2,0x1},{0x0,0x16},{0x0,0x62},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x36},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x2,0x1},{0x0,0x71},{0x0,0x55},{0x4,0x1},{0x2,0x1},{0x0,0x17},{0x0,0x64},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x18,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x73},{0x2,0x1},{0x0,0x37},{0x0,0x65},{0x4,0x1},{0x2,0x1},{0x0,0x56},{0x0,0x80},{0x2,0x1},{0x0,0x8},{0x0,0x74},{0x4,0x1},{0x2,0x1},{0x0,0x81},{0x0,0x18},{0x2,0x1},{0x0,0x82},{0x0,0x28},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x47},{0x0,0x66},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x90},{0x0,0x19},{0x0,0x91},{0x4,0x1},{0x2,0x1},{0x0,0x92},{0x0,0x76},{0x2,0x1},{0x0,0x67},{0x0,0x29},{0x5c,0x1},{0x24,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x4,0x1},{0x2,0x1},{0x0,0x9},{0x0,0x77},{0x0,0x93},{0x4,0x1},{0x2,0x1},{0x0,0x39},{0x0,0x94},{0x2,0x1},{0x0,0x49},{0x0,0x86},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x68},{0x2,0x1},{0x0,0xa0},{0x0,0xa},{0x2,0x1},{0x0,0xa1},{0x0,0x1a},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x1a,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xa3},{0x2,0x1},{0x0,0x3a},{0x0,0x87},{0x4,0x1},{0x2,0x1},{0x0,0x78},{0x0,0xa4},{0x2,0x1},{0x0,0x4a},{0x0,0x96},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xb0},{0x0,0xb1},{0x4,0x1},{0x2,0x1},{0x0,0x1b},{0x0,0xa5},{0x0,0xb2},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5a},{0x0,0x2b},{0x2,0x1},{0x0,0x88},{0x0,0x97},{0x2,0x1},{0x0,0xb3},{0x2,0x1},{0x0,0x79},{0x0,0x3b},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x6a},{0x0,0xb4},{0x2,0x1},{0x0,0x4b},{0x0,0xc1},{0x4,0x1},{0x2,0x1},{0x0,0x98},{0x0,0x89},{0x2,0x1},{0x0,0x1c},{0x0,0xb5},{0x50,0x1},{0x22,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5b},{0x0,0x2c},{0x0,0xc2},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb},{0x0,0xc0},{0x0,0xa6},{0x2,0x1},{0x0,0xa7},{0x0,0x7a},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc3},{0x0,0x3c},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0x99},{0x0,0xb6},{0x4,0x1},{0x2,0x1},{0x0,0x6b},{0x0,0xc4},{0x2,0x1},{0x0,0x4c},{0x0,0xa8},{0x14,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8a},{0x0,0xc5},{0x4,0x1},{0x2,0x1},{0x0,0xd0},{0x0,0x5c},{0x0,0xd1},{0x4,0x1},{0x2,0x1},{0x0,0xb7},{0x0,0x7b},{0x2,0x1},{0x0,0x1d},{0x2,0x1},{0x0,0xd},{0x0,0x2d},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd2},{0x0,0xd3},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9a},{0x0,0xb8},{0x0,0xd4},{0x4,0x1},{0x2,0x1},{0x0,0x8b},{0x0,0x4d},{0x2,0x1},{0x0,0xc7},{0x0,0x7c},{0x44,0x1},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd5},{0x0,0x5d},{0x4,0x1},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x0,0xe1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0xe2},{0x2,0x1},{0x0,0xaa},{0x0,0x2e},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb9},{0x0,0x9b},{0x2,0x1},{0x0,0xe3},{0x0,0xd6},{0x4,0x1},{0x2,0x1},{0x0,0x6d},{0x0,0x3e},{0x2,0x1},{0x0,0xc8},{0x0,0x8c},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe4},{0x0,0x4e},{0x2,0x1},{0x0,0xd7},{0x0,0x7d},{0x4,0x1},{0x2,0x1},{0x0,0xe5},{0x0,0xba},{0x2,0x1},{0x0,0xab},{0x0,0x5e},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc9},{0x0,0x9c},{0x2,0x1},{0x0,0xf1},{0x0,0x1f},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf0},{0x0,0x6e},{0x0,0xf2},{0x2,0x1},{0x0,0x2f},{0x0,0xe6},{0x26,0x1},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0xf3},{0x2,0x1},{0x0,0x3f},{0x0,0xf4},{0x6,0x1},{0x2,0x1},{0x0,0x4f},{0x2,0x1},{0x0,0x8d},{0x0,0xd9},{0x2,0x1},{0x0,0xbb},{0x0,0xca},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xac},{0x0,0xe7},{0x2,0x1},{0x0,0x7e},{0x0,0xf5},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9d},{0x0,0x5f},{0x2,0x1},{0x0,0xe8},{0x0,0x8e},{0x2,0x1},{0x0,0xf6},{0x0,0xcb},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf},{0x0,0xae},{0x0,0x6f},{0x2,0x1},{0x0,0xbc},{0x0,0xda},{0x4,0x1},{0x2,0x1},{0x0,0xad},{0x0,0xf7},{0x2,0x1},{0x0,0x7f},{0x0,0xe9},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xcc},{0x2,0x1},{0x0,0xf8},{0x0,0x8f},{0x4,0x1},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x2,0x1},{0x0,0xea},{0x0,0xf9},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xdc},{0x2,0x1},{0x0,0xcd},{0x0,0xeb},{0x4,0x1},{0x2,0x1},{0x0,0xbe},{0x0,0xfa},{0x2,0x1},{0x0,0xaf},{0x0,0xdd},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xec},{0x0,0xce},{0x0,0xfb},{0x4,0x1},{0x2,0x1},{0x0,0xbf},{0x0,0xed},{0x2,0x1},{0x0,0xde},{0x0,0xfc},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xcf},{0x0,0xfd},{0x0,0xee},{0x4,0x1},{0x2,0x1},{0x0,0xdf},{0x0,0xfe},{0x2,0x1},{0x0,0xef},{0x0,0xff}};
    3d7b:	8d 85 86 f2 ff ff    	lea    -0xd7a(%ebp),%eax
    3d81:	bb 20 9b 00 00       	mov    $0x9b20,%ebx
    3d86:	ba fe 03 00 00       	mov    $0x3fe,%edx
    3d8b:	8b 0b                	mov    (%ebx),%ecx
    3d8d:	89 08                	mov    %ecx,(%eax)
    3d8f:	8b 4c 13 fc          	mov    -0x4(%ebx,%edx,1),%ecx
    3d93:	89 4c 10 fc          	mov    %ecx,-0x4(%eax,%edx,1)
    3d97:	8d 78 04             	lea    0x4(%eax),%edi
    3d9a:	83 e7 fc             	and    $0xfffffffc,%edi
    3d9d:	29 f8                	sub    %edi,%eax
    3d9f:	29 c3                	sub    %eax,%ebx
    3da1:	01 c2                	add    %eax,%edx
    3da3:	83 e2 fc             	and    $0xfffffffc,%edx
    3da6:	89 d0                	mov    %edx,%eax
    3da8:	c1 e8 02             	shr    $0x2,%eax
    3dab:	89 de                	mov    %ebx,%esi
    3dad:	89 c1                	mov    %eax,%ecx
    3daf:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	unsigned char h16[511][2] = {{0x2,0x1},{0x0,0x0},{0x6,0x1},{0x2,0x1},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0x2a,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x2,0x1},{0x0,0x21},{0x0,0x12},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x6,0x1},{0x2,0x1},{0x0,0x14},{0x2,0x1},{0x0,0x33},{0x0,0x42},{0x4,0x1},{0x2,0x1},{0x0,0x24},{0x0,0x50},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x8a,0x1},{0x28,0x1},{0x10,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x5},{0x0,0x15},{0x0,0x51},{0x4,0x1},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x35},{0x0,0x53},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x0,0x61},{0x2,0x1},{0x0,0x16},{0x0,0x62},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x26},{0x0,0x54},{0x2,0x1},{0x0,0x45},{0x0,0x63},{0x4,0x1},{0x2,0x1},{0x0,0x36},{0x0,0x70},{0x0,0x71},{0x28,0x1},{0x12,0x1},{0x8,0x1},{0x2,0x1},{0x0,0x17},{0x2,0x1},{0x0,0x7},{0x2,0x1},{0x0,0x55},{0x0,0x64},{0x4,0x1},{0x2,0x1},{0x0,0x72},{0x0,0x27},{0x4,0x1},{0x2,0x1},{0x0,0x46},{0x0,0x65},{0x0,0x73},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x37},{0x2,0x1},{0x0,0x56},{0x0,0x8},{0x2,0x1},{0x0,0x80},{0x0,0x81},{0x6,0x1},{0x2,0x1},{0x0,0x18},{0x2,0x1},{0x0,0x74},{0x0,0x47},{0x2,0x1},{0x0,0x82},{0x2,0x1},{0x0,0x28},{0x0,0x66},{0x18,0x1},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x2,0x1},{0x0,0x75},{0x0,0x84},{0x4,0x1},{0x2,0x1},{0x0,0x48},{0x0,0x90},{0x0,0x91},{0x6,0x1},{0x2,0x1},{0x0,0x19},{0x2,0x1},{0x0,0x9},{0x0,0x76},{0x2,0x1},{0x0,0x92},{0x0,0x29},{0xe,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x2,0x1},{0x0,0x93},{0x0,0x39},{0x4,0x1},{0x2,0x1},{0x0,0xa0},{0x0,0xa},{0x0,0x1a},{0x8,0x1},{0x2,0x1},{0x0,0xa2},{0x2,0x1},{0x0,0x67},{0x2,0x1},{0x0,0x57},{0x0,0x49},{0x6,0x1},{0x2,0x1},{0x0,0x94},{0x2,0x1},{0x0,0x77},{0x0,0x86},{0x2,0x1},{0x0,0xa1},{0x2,0x1},{0x0,0x68},{0x0,0x95},{0xdc,0x1},{0x7e,0x1},{0x32,0x1},{0x1a,0x1},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x2a},{0x2,0x1},{0x0,0x59},{0x0,0x3a},{0x2,0x1},{0x0,0xa3},{0x2,0x1},{0x0,0x87},{0x0,0x78},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa4},{0x0,0x4a},{0x2,0x1},{0x0,0x96},{0x0,0x69},{0x4,0x1},{0x2,0x1},{0x0,0xb0},{0x0,0xb},{0x0,0xb1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1b},{0x0,0xb2},{0x2,0x1},{0x0,0x2b},{0x2,0x1},{0x0,0xa5},{0x0,0x5a},{0x6,0x1},{0x2,0x1},{0x0,0xb3},{0x2,0x1},{0x0,0xa6},{0x0,0x6a},{0x4,0x1},{0x2,0x1},{0x0,0xb4},{0x0,0x4b},{0x2,0x1},{0x0,0xc},{0x0,0xc1},{0x1e,0x1},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb5},{0x0,0xc2},{0x0,0x2c},{0x4,0x1},{0x2,0x1},{0x0,0xa7},{0x0,0xc3},{0x2,0x1},{0x0,0x6b},{0x0,0xc4},{0x8,0x1},{0x2,0x1},{0x0,0x1d},{0x4,0x1},{0x2,0x1},{0x0,0x88},{0x0,0x97},{0x0,0x3b},{0x4,0x1},{0x2,0x1},{0x0,0xd1},{0x0,0xd2},{0x2,0x1},{0x0,0x2d},{0x0,0xd3},{0x12,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0x2e},{0x0,0xe2},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x79},{0x0,0x98},{0x0,0xc0},{0x2,0x1},{0x0,0x1c},{0x2,0x1},{0x0,0x89},{0x0,0x5b},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3c},{0x2,0x1},{0x0,0x7a},{0x0,0xb6},{0x4,0x1},{0x2,0x1},{0x0,0x4c},{0x0,0x99},{0x2,0x1},{0x0,0xa8},{0x0,0x8a},{0x6,0x1},{0x2,0x1},{0x0,0xd},{0x2,0x1},{0x0,0xc5},{0x0,0x5c},{0x4,0x1},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x2,0x1},{0x0,0x6c},{0x0,0x9a},{0x58,0x1},{0x56,0x1},{0x24,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8b},{0x0,0x4d},{0x2,0x1},{0x0,0xc7},{0x0,0x7c},{0x4,0x1},{0x2,0x1},{0x0,0xd5},{0x0,0x5d},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x8,0x1},{0x2,0x1},{0x0,0xe3},{0x4,0x1},{0x2,0x1},{0x0,0xd0},{0x0,0xb7},{0x0,0x7b},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa9},{0x0,0xb8},{0x0,0xd4},{0x2,0x1},{0x0,0xe1},{0x2,0x1},{0x0,0xaa},{0x0,0xb9},{0x18,0x1},{0xa,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9b},{0x0,0xd6},{0x0,0x6d},{0x2,0x1},{0x0,0x3e},{0x0,0xc8},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8c},{0x0,0xe4},{0x0,0x4e},{0x4,0x1},{0x2,0x1},{0x0,0xd7},{0x0,0xe5},{0x2,0x1},{0x0,0xba},{0x0,0xab},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x9c},{0x0,0xe6},{0x4,0x1},{0x2,0x1},{0x0,0x6e},{0x0,0xd8},{0x2,0x1},{0x0,0x8d},{0x0,0xbb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xe7},{0x0,0x9d},{0x2,0x1},{0x0,0xe8},{0x0,0x8e},{0x4,0x1},{0x2,0x1},{0x0,0xcb},{0x0,0xbc},{0x0,0x9e},{0x0,0xf1},{0x2,0x1},{0x0,0x1f},{0x2,0x1},{0x0,0xf},{0x0,0x2f},{0x42,0x1},{0x38,0x1},{0x2,0x1},{0x0,0xf2},{0x34,0x1},{0x32,0x1},{0x14,0x1},{0x8,0x1},{0x2,0x1},{0x0,0xbd},{0x2,0x1},{0x0,0x5e},{0x2,0x1},{0x0,0x7d},{0x0,0xc9},{0x6,0x1},{0x2,0x1},{0x0,0xca},{0x2,0x1},{0x0,0xac},{0x0,0x7e},{0x4,0x1},{0x2,0x1},{0x0,0xda},{0x0,0xad},{0x0,0xcc},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0xae},{0x2,0x1},{0x0,0xdb},{0x0,0xdc},{0x2,0x1},{0x0,0xcd},{0x0,0xbe},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xeb},{0x0,0xed},{0x0,0xee},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xd9},{0x0,0xea},{0x0,0xe9},{0x2,0x1},{0x0,0xde},{0x4,0x1},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x0,0xce},{0x0,0x3f},{0x0,0xf0},{0x4,0x1},{0x2,0x1},{0x0,0xf3},{0x0,0xf4},{0x2,0x1},{0x0,0x4f},{0x2,0x1},{0x0,0xf5},{0x0,0x5f},{0xa,0x1},{0x2,0x1},{0x0,0xff},{0x4,0x1},{0x2,0x1},{0x0,0xf6},{0x0,0x6f},{0x2,0x1},{0x0,0xf7},{0x0,0x7f},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x8f},{0x2,0x1},{0x0,0xf8},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xfa},{0x0,0xaf},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xfb},{0x0,0xbf},{0x2,0x1},{0x0,0xfc},{0x0,0xcf},{0x4,0x1},{0x2,0x1},{0x0,0xfd},{0x0,0xdf},{0x2,0x1},{0x0,0xfe},{0x0,0xef}};
    3db1:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    3db7:	ba 20 9f 00 00       	mov    $0x9f20,%edx
    3dbc:	b9 ff 00 00 00       	mov    $0xff,%ecx
    3dc1:	89 c7                	mov    %eax,%edi
    3dc3:	89 d6                	mov    %edx,%esi
    3dc5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    3dc7:	89 f2                	mov    %esi,%edx
    3dc9:	89 f8                	mov    %edi,%eax
    3dcb:	0f b7 0a             	movzwl (%edx),%ecx
    3dce:	66 89 08             	mov    %cx,(%eax)
    3dd1:	8d 40 02             	lea    0x2(%eax),%eax
    3dd4:	8d 52 02             	lea    0x2(%edx),%edx

	unsigned char h24[512][2] = {{0x3c,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x10},{0x2,0x1},{0x0,0x1},{0x0,0x11},{0xe,0x1},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x20},{0x0,0x2},{0x0,0x21},{0x2,0x1},{0x0,0x12},{0x2,0x1},{0x0,0x22},{0x2,0x1},{0x0,0x30},{0x0,0x3},{0xe,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x31},{0x0,0x13},{0x4,0x1},{0x2,0x1},{0x0,0x32},{0x0,0x23},{0x4,0x1},{0x2,0x1},{0x0,0x40},{0x0,0x4},{0x0,0x41},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x14},{0x0,0x33},{0x2,0x1},{0x0,0x42},{0x0,0x24},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x43},{0x0,0x34},{0x0,0x51},{0x6,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x50},{0x0,0x5},{0x0,0x15},{0x2,0x1},{0x0,0x52},{0x0,0x25},{0xfa,0x1},{0x62,0x1},{0x22,0x1},{0x12,0x1},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x44},{0x0,0x53},{0x2,0x1},{0x0,0x35},{0x2,0x1},{0x0,0x60},{0x0,0x6},{0x4,0x1},{0x2,0x1},{0x0,0x61},{0x0,0x16},{0x2,0x1},{0x0,0x62},{0x0,0x26},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x54},{0x0,0x45},{0x2,0x1},{0x0,0x63},{0x0,0x36},{0x4,0x1},{0x2,0x1},{0x0,0x71},{0x0,0x55},{0x2,0x1},{0x0,0x64},{0x0,0x46},{0x20,0x1},{0xe,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x72},{0x2,0x1},{0x0,0x27},{0x0,0x37},{0x2,0x1},{0x0,0x73},{0x4,0x1},{0x2,0x1},{0x0,0x70},{0x0,0x7},{0x0,0x17},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x65},{0x0,0x56},{0x4,0x1},{0x2,0x1},{0x0,0x80},{0x0,0x8},{0x0,0x81},{0x4,0x1},{0x2,0x1},{0x0,0x74},{0x0,0x47},{0x2,0x1},{0x0,0x18},{0x0,0x82},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x28},{0x0,0x66},{0x2,0x1},{0x0,0x83},{0x0,0x38},{0x4,0x1},{0x2,0x1},{0x0,0x75},{0x0,0x57},{0x2,0x1},{0x0,0x84},{0x0,0x48},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x91},{0x0,0x19},{0x2,0x1},{0x0,0x92},{0x0,0x76},{0x4,0x1},{0x2,0x1},{0x0,0x67},{0x0,0x29},{0x2,0x1},{0x0,0x85},{0x0,0x58},{0x5c,0x1},{0x22,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x93},{0x0,0x39},{0x2,0x1},{0x0,0x94},{0x0,0x49},{0x4,0x1},{0x2,0x1},{0x0,0x77},{0x0,0x86},{0x2,0x1},{0x0,0x68},{0x0,0xa1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa2},{0x0,0x2a},{0x2,0x1},{0x0,0x95},{0x0,0x59},{0x4,0x1},{0x2,0x1},{0x0,0xa3},{0x0,0x3a},{0x2,0x1},{0x0,0x87},{0x2,0x1},{0x0,0x78},{0x0,0x4a},{0x16,0x1},{0xc,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xa4},{0x0,0x96},{0x4,0x1},{0x2,0x1},{0x0,0x69},{0x0,0xb1},{0x2,0x1},{0x0,0x1b},{0x0,0xa5},{0x6,0x1},{0x2,0x1},{0x0,0xb2},{0x2,0x1},{0x0,0x5a},{0x0,0x2b},{0x2,0x1},{0x0,0x88},{0x0,0xb3},{0x10,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x90},{0x2,0x1},{0x0,0x9},{0x0,0xa0},{0x2,0x1},{0x0,0x97},{0x0,0x79},{0x4,0x1},{0x2,0x1},{0x0,0xa6},{0x0,0x6a},{0x0,0xb4},{0xc,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x1a},{0x2,0x1},{0x0,0xa},{0x0,0xb0},{0x2,0x1},{0x0,0x3b},{0x2,0x1},{0x0,0xb},{0x0,0xc0},{0x4,0x1},{0x2,0x1},{0x0,0x4b},{0x0,0xc1},{0x2,0x1},{0x0,0x98},{0x0,0x89},{0x43,0x1},{0x22,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1c},{0x0,0xb5},{0x2,0x1},{0x0,0x5b},{0x0,0xc2},{0x4,0x1},{0x2,0x1},{0x0,0x2c},{0x0,0xa7},{0x2,0x1},{0x0,0x7a},{0x0,0xc3},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3c},{0x2,0x1},{0x0,0xc},{0x0,0xd0},{0x2,0x1},{0x0,0xb6},{0x0,0x6b},{0x4,0x1},{0x2,0x1},{0x0,0xc4},{0x0,0x4c},{0x2,0x1},{0x0,0x99},{0x0,0xa8},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8a},{0x0,0xc5},{0x2,0x1},{0x0,0x5c},{0x0,0xd1},{0x4,0x1},{0x2,0x1},{0x0,0xb7},{0x0,0x7b},{0x2,0x1},{0x0,0x1d},{0x0,0xd2},{0x9,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x2d},{0x0,0xd3},{0x2,0x1},{0x0,0x3d},{0x0,0xc6},{0x55,0xfa},{0x4,0x1},{0x2,0x1},{0x0,0x6c},{0x0,0xa9},{0x2,0x1},{0x0,0x9a},{0x0,0xd4},{0x20,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xb8},{0x0,0x8b},{0x2,0x1},{0x0,0x4d},{0x0,0xc7},{0x4,0x1},{0x2,0x1},{0x0,0x7c},{0x0,0xd5},{0x2,0x1},{0x0,0x5d},{0x0,0xe1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x1e},{0x0,0xe2},{0x2,0x1},{0x0,0xaa},{0x0,0xb9},{0x4,0x1},{0x2,0x1},{0x0,0x9b},{0x0,0xe3},{0x2,0x1},{0x0,0xd6},{0x0,0x6d},{0x14,0x1},{0xa,0x1},{0x6,0x1},{0x2,0x1},{0x0,0x3e},{0x2,0x1},{0x0,0x2e},{0x0,0x4e},{0x2,0x1},{0x0,0xc8},{0x0,0x8c},{0x4,0x1},{0x2,0x1},{0x0,0xe4},{0x0,0xd7},{0x4,0x1},{0x2,0x1},{0x0,0x7d},{0x0,0xab},{0x0,0xe5},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xba},{0x0,0x5e},{0x2,0x1},{0x0,0xc9},{0x2,0x1},{0x0,0x9c},{0x0,0x6e},{0x8,0x1},{0x2,0x1},{0x0,0xe6},{0x2,0x1},{0x0,0xd},{0x2,0x1},{0x0,0xe0},{0x0,0xe},{0x4,0x1},{0x2,0x1},{0x0,0xd8},{0x0,0x8d},{0x2,0x1},{0x0,0xbb},{0x0,0xca},{0x4a,0x1},{0x2,0x1},{0x0,0xff},{0x40,0x1},{0x3a,0x1},{0x20,0x1},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xac},{0x0,0xe7},{0x2,0x1},{0x0,0x7e},{0x0,0xd9},{0x4,0x1},{0x2,0x1},{0x0,0x9d},{0x0,0xe8},{0x2,0x1},{0x0,0x8e},{0x0,0xcb},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xbc},{0x0,0xda},{0x2,0x1},{0x0,0xad},{0x0,0xe9},{0x4,0x1},{0x2,0x1},{0x0,0x9e},{0x0,0xcc},{0x2,0x1},{0x0,0xdb},{0x0,0xbd},{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xea},{0x0,0xae},{0x2,0x1},{0x0,0xdc},{0x0,0xcd},{0x4,0x1},{0x2,0x1},{0x0,0xeb},{0x0,0xbe},{0x2,0x1},{0x0,0xdd},{0x0,0xec},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xce},{0x0,0xed},{0x2,0x1},{0x0,0xde},{0x0,0xee},{0x0,0xf},{0x4,0x1},{0x2,0x1},{0x0,0xf0},{0x0,0x1f},{0x0,0xf1},{0x4,0x1},{0x2,0x1},{0x0,0xf2},{0x0,0x2f},{0x2,0x1},{0x0,0xf3},{0x0,0x3f},{0x12,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf4},{0x0,0x4f},{0x2,0x1},{0x0,0xf5},{0x0,0x5f},{0x4,0x1},{0x2,0x1},{0x0,0xf6},{0x0,0x6f},{0x2,0x1},{0x0,0xf7},{0x2,0x1},{0x0,0x7f},{0x0,0x8f},{0xa,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xf8},{0x0,0xf9},{0x4,0x1},{0x2,0x1},{0x0,0x9f},{0x0,0xaf},{0x0,0xfa},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xfb},{0x0,0xbf},{0x2,0x1},{0x0,0xfc},{0x0,0xcf},{0x4,0x1},{0x2,0x1},{0x0,0xfd},{0x0,0xdf},{0x2,0x1},{0x0,0xfe},{0x0,0xef}};
    3dd7:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    3ddd:	bb 20 a3 00 00       	mov    $0xa320,%ebx
    3de2:	ba 00 01 00 00       	mov    $0x100,%edx
    3de7:	89 c7                	mov    %eax,%edi
    3de9:	89 de                	mov    %ebx,%esi
    3deb:	89 d1                	mov    %edx,%ecx
    3ded:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	unsigned char hA[31][2] = {{0x2,0x1},{0x0,0x0},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8},{0x0,0x4},{0x2,0x1},{0x0,0x1},{0x0,0x2},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0xa},{0x2,0x1},{0x0,0x3},{0x0,0x6},{0x6,0x1},{0x2,0x1},{0x0,0x9},{0x2,0x1},{0x0,0x5},{0x0,0x7},{0x4,0x1},{0x2,0x1},{0x0,0xe},{0x0,0xd},{0x2,0x1},{0x0,0xf},{0x0,0xb}};
    3def:	c6 85 4a ea ff ff 02 	movb   $0x2,-0x15b6(%ebp)
    3df6:	c6 85 4b ea ff ff 01 	movb   $0x1,-0x15b5(%ebp)
    3dfd:	c6 85 4c ea ff ff 00 	movb   $0x0,-0x15b4(%ebp)
    3e04:	c6 85 4d ea ff ff 00 	movb   $0x0,-0x15b3(%ebp)
    3e0b:	c6 85 4e ea ff ff 08 	movb   $0x8,-0x15b2(%ebp)
    3e12:	c6 85 4f ea ff ff 01 	movb   $0x1,-0x15b1(%ebp)
    3e19:	c6 85 50 ea ff ff 04 	movb   $0x4,-0x15b0(%ebp)
    3e20:	c6 85 51 ea ff ff 01 	movb   $0x1,-0x15af(%ebp)
    3e27:	c6 85 52 ea ff ff 02 	movb   $0x2,-0x15ae(%ebp)
    3e2e:	c6 85 53 ea ff ff 01 	movb   $0x1,-0x15ad(%ebp)
    3e35:	c6 85 54 ea ff ff 00 	movb   $0x0,-0x15ac(%ebp)
    3e3c:	c6 85 55 ea ff ff 08 	movb   $0x8,-0x15ab(%ebp)
    3e43:	c6 85 56 ea ff ff 00 	movb   $0x0,-0x15aa(%ebp)
    3e4a:	c6 85 57 ea ff ff 04 	movb   $0x4,-0x15a9(%ebp)
    3e51:	c6 85 58 ea ff ff 02 	movb   $0x2,-0x15a8(%ebp)
    3e58:	c6 85 59 ea ff ff 01 	movb   $0x1,-0x15a7(%ebp)
    3e5f:	c6 85 5a ea ff ff 00 	movb   $0x0,-0x15a6(%ebp)
    3e66:	c6 85 5b ea ff ff 01 	movb   $0x1,-0x15a5(%ebp)
    3e6d:	c6 85 5c ea ff ff 00 	movb   $0x0,-0x15a4(%ebp)
    3e74:	c6 85 5d ea ff ff 02 	movb   $0x2,-0x15a3(%ebp)
    3e7b:	c6 85 5e ea ff ff 08 	movb   $0x8,-0x15a2(%ebp)
    3e82:	c6 85 5f ea ff ff 01 	movb   $0x1,-0x15a1(%ebp)
    3e89:	c6 85 60 ea ff ff 04 	movb   $0x4,-0x15a0(%ebp)
    3e90:	c6 85 61 ea ff ff 01 	movb   $0x1,-0x159f(%ebp)
    3e97:	c6 85 62 ea ff ff 02 	movb   $0x2,-0x159e(%ebp)
    3e9e:	c6 85 63 ea ff ff 01 	movb   $0x1,-0x159d(%ebp)
    3ea5:	c6 85 64 ea ff ff 00 	movb   $0x0,-0x159c(%ebp)
    3eac:	c6 85 65 ea ff ff 0c 	movb   $0xc,-0x159b(%ebp)
    3eb3:	c6 85 66 ea ff ff 00 	movb   $0x0,-0x159a(%ebp)
    3eba:	c6 85 67 ea ff ff 0a 	movb   $0xa,-0x1599(%ebp)
    3ec1:	c6 85 68 ea ff ff 02 	movb   $0x2,-0x1598(%ebp)
    3ec8:	c6 85 69 ea ff ff 01 	movb   $0x1,-0x1597(%ebp)
    3ecf:	c6 85 6a ea ff ff 00 	movb   $0x0,-0x1596(%ebp)
    3ed6:	c6 85 6b ea ff ff 03 	movb   $0x3,-0x1595(%ebp)
    3edd:	c6 85 6c ea ff ff 00 	movb   $0x0,-0x1594(%ebp)
    3ee4:	c6 85 6d ea ff ff 06 	movb   $0x6,-0x1593(%ebp)
    3eeb:	c6 85 6e ea ff ff 06 	movb   $0x6,-0x1592(%ebp)
    3ef2:	c6 85 6f ea ff ff 01 	movb   $0x1,-0x1591(%ebp)
    3ef9:	c6 85 70 ea ff ff 02 	movb   $0x2,-0x1590(%ebp)
    3f00:	c6 85 71 ea ff ff 01 	movb   $0x1,-0x158f(%ebp)
    3f07:	c6 85 72 ea ff ff 00 	movb   $0x0,-0x158e(%ebp)
    3f0e:	c6 85 73 ea ff ff 09 	movb   $0x9,-0x158d(%ebp)
    3f15:	c6 85 74 ea ff ff 02 	movb   $0x2,-0x158c(%ebp)
    3f1c:	c6 85 75 ea ff ff 01 	movb   $0x1,-0x158b(%ebp)
    3f23:	c6 85 76 ea ff ff 00 	movb   $0x0,-0x158a(%ebp)
    3f2a:	c6 85 77 ea ff ff 05 	movb   $0x5,-0x1589(%ebp)
    3f31:	c6 85 78 ea ff ff 00 	movb   $0x0,-0x1588(%ebp)
    3f38:	c6 85 79 ea ff ff 07 	movb   $0x7,-0x1587(%ebp)
    3f3f:	c6 85 7a ea ff ff 04 	movb   $0x4,-0x1586(%ebp)
    3f46:	c6 85 7b ea ff ff 01 	movb   $0x1,-0x1585(%ebp)
    3f4d:	c6 85 7c ea ff ff 02 	movb   $0x2,-0x1584(%ebp)
    3f54:	c6 85 7d ea ff ff 01 	movb   $0x1,-0x1583(%ebp)
    3f5b:	c6 85 7e ea ff ff 00 	movb   $0x0,-0x1582(%ebp)
    3f62:	c6 85 7f ea ff ff 0e 	movb   $0xe,-0x1581(%ebp)
    3f69:	c6 85 80 ea ff ff 00 	movb   $0x0,-0x1580(%ebp)
    3f70:	c6 85 81 ea ff ff 0d 	movb   $0xd,-0x157f(%ebp)
    3f77:	c6 85 82 ea ff ff 02 	movb   $0x2,-0x157e(%ebp)
    3f7e:	c6 85 83 ea ff ff 01 	movb   $0x1,-0x157d(%ebp)
    3f85:	c6 85 84 ea ff ff 00 	movb   $0x0,-0x157c(%ebp)
    3f8c:	c6 85 85 ea ff ff 0f 	movb   $0xf,-0x157b(%ebp)
    3f93:	c6 85 86 ea ff ff 00 	movb   $0x0,-0x157a(%ebp)
    3f9a:	c6 85 87 ea ff ff 0b 	movb   $0xb,-0x1579(%ebp)

	unsigned char hB[31][2] = {{0x10,0x1},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x0},{0x0,0x1},{0x2,0x1},{0x0,0x2},{0x0,0x3},{0x4,0x1},{0x2,0x1},{0x0,0x4},{0x0,0x5},{0x2,0x1},{0x0,0x6},{0x0,0x7},{0x8,0x1},{0x4,0x1},{0x2,0x1},{0x0,0x8},{0x0,0x9},{0x2,0x1},{0x0,0xa},{0x0,0xb},{0x4,0x1},{0x2,0x1},{0x0,0xc},{0x0,0xd},{0x2,0x1},{0x0,0xe},{0x0,0xf}};
    3fa1:	c6 85 0c ea ff ff 10 	movb   $0x10,-0x15f4(%ebp)
    3fa8:	c6 85 0d ea ff ff 01 	movb   $0x1,-0x15f3(%ebp)
    3faf:	c6 85 0e ea ff ff 08 	movb   $0x8,-0x15f2(%ebp)
    3fb6:	c6 85 0f ea ff ff 01 	movb   $0x1,-0x15f1(%ebp)
    3fbd:	c6 85 10 ea ff ff 04 	movb   $0x4,-0x15f0(%ebp)
    3fc4:	c6 85 11 ea ff ff 01 	movb   $0x1,-0x15ef(%ebp)
    3fcb:	c6 85 12 ea ff ff 02 	movb   $0x2,-0x15ee(%ebp)
    3fd2:	c6 85 13 ea ff ff 01 	movb   $0x1,-0x15ed(%ebp)
    3fd9:	c6 85 14 ea ff ff 00 	movb   $0x0,-0x15ec(%ebp)
    3fe0:	c6 85 15 ea ff ff 00 	movb   $0x0,-0x15eb(%ebp)
    3fe7:	c6 85 16 ea ff ff 00 	movb   $0x0,-0x15ea(%ebp)
    3fee:	c6 85 17 ea ff ff 01 	movb   $0x1,-0x15e9(%ebp)
    3ff5:	c6 85 18 ea ff ff 02 	movb   $0x2,-0x15e8(%ebp)
    3ffc:	c6 85 19 ea ff ff 01 	movb   $0x1,-0x15e7(%ebp)
    4003:	c6 85 1a ea ff ff 00 	movb   $0x0,-0x15e6(%ebp)
    400a:	c6 85 1b ea ff ff 02 	movb   $0x2,-0x15e5(%ebp)
    4011:	c6 85 1c ea ff ff 00 	movb   $0x0,-0x15e4(%ebp)
    4018:	c6 85 1d ea ff ff 03 	movb   $0x3,-0x15e3(%ebp)
    401f:	c6 85 1e ea ff ff 04 	movb   $0x4,-0x15e2(%ebp)
    4026:	c6 85 1f ea ff ff 01 	movb   $0x1,-0x15e1(%ebp)
    402d:	c6 85 20 ea ff ff 02 	movb   $0x2,-0x15e0(%ebp)
    4034:	c6 85 21 ea ff ff 01 	movb   $0x1,-0x15df(%ebp)
    403b:	c6 85 22 ea ff ff 00 	movb   $0x0,-0x15de(%ebp)
    4042:	c6 85 23 ea ff ff 04 	movb   $0x4,-0x15dd(%ebp)
    4049:	c6 85 24 ea ff ff 00 	movb   $0x0,-0x15dc(%ebp)
    4050:	c6 85 25 ea ff ff 05 	movb   $0x5,-0x15db(%ebp)
    4057:	c6 85 26 ea ff ff 02 	movb   $0x2,-0x15da(%ebp)
    405e:	c6 85 27 ea ff ff 01 	movb   $0x1,-0x15d9(%ebp)
    4065:	c6 85 28 ea ff ff 00 	movb   $0x0,-0x15d8(%ebp)
    406c:	c6 85 29 ea ff ff 06 	movb   $0x6,-0x15d7(%ebp)
    4073:	c6 85 2a ea ff ff 00 	movb   $0x0,-0x15d6(%ebp)
    407a:	c6 85 2b ea ff ff 07 	movb   $0x7,-0x15d5(%ebp)
    4081:	c6 85 2c ea ff ff 08 	movb   $0x8,-0x15d4(%ebp)
    4088:	c6 85 2d ea ff ff 01 	movb   $0x1,-0x15d3(%ebp)
    408f:	c6 85 2e ea ff ff 04 	movb   $0x4,-0x15d2(%ebp)
    4096:	c6 85 2f ea ff ff 01 	movb   $0x1,-0x15d1(%ebp)
    409d:	c6 85 30 ea ff ff 02 	movb   $0x2,-0x15d0(%ebp)
    40a4:	c6 85 31 ea ff ff 01 	movb   $0x1,-0x15cf(%ebp)
    40ab:	c6 85 32 ea ff ff 00 	movb   $0x0,-0x15ce(%ebp)
    40b2:	c6 85 33 ea ff ff 08 	movb   $0x8,-0x15cd(%ebp)
    40b9:	c6 85 34 ea ff ff 00 	movb   $0x0,-0x15cc(%ebp)
    40c0:	c6 85 35 ea ff ff 09 	movb   $0x9,-0x15cb(%ebp)
    40c7:	c6 85 36 ea ff ff 02 	movb   $0x2,-0x15ca(%ebp)
    40ce:	c6 85 37 ea ff ff 01 	movb   $0x1,-0x15c9(%ebp)
    40d5:	c6 85 38 ea ff ff 00 	movb   $0x0,-0x15c8(%ebp)
    40dc:	c6 85 39 ea ff ff 0a 	movb   $0xa,-0x15c7(%ebp)
    40e3:	c6 85 3a ea ff ff 00 	movb   $0x0,-0x15c6(%ebp)
    40ea:	c6 85 3b ea ff ff 0b 	movb   $0xb,-0x15c5(%ebp)
    40f1:	c6 85 3c ea ff ff 04 	movb   $0x4,-0x15c4(%ebp)
    40f8:	c6 85 3d ea ff ff 01 	movb   $0x1,-0x15c3(%ebp)
    40ff:	c6 85 3e ea ff ff 02 	movb   $0x2,-0x15c2(%ebp)
    4106:	c6 85 3f ea ff ff 01 	movb   $0x1,-0x15c1(%ebp)
    410d:	c6 85 40 ea ff ff 00 	movb   $0x0,-0x15c0(%ebp)
    4114:	c6 85 41 ea ff ff 0c 	movb   $0xc,-0x15bf(%ebp)
    411b:	c6 85 42 ea ff ff 00 	movb   $0x0,-0x15be(%ebp)
    4122:	c6 85 43 ea ff ff 0d 	movb   $0xd,-0x15bd(%ebp)
    4129:	c6 85 44 ea ff ff 02 	movb   $0x2,-0x15bc(%ebp)
    4130:	c6 85 45 ea ff ff 01 	movb   $0x1,-0x15bb(%ebp)
    4137:	c6 85 46 ea ff ff 00 	movb   $0x0,-0x15ba(%ebp)
    413e:	c6 85 47 ea ff ff 0e 	movb   $0xe,-0x15b9(%ebp)
    4145:	c6 85 48 ea ff ff 00 	movb   $0x0,-0x15b8(%ebp)
    414c:	c6 85 49 ea ff ff 0f 	movb   $0xf,-0x15b7(%ebp)
	
	struct huffcodetab ht[HTN] = {
    4153:	66 c7 85 bc e4 ff ff 	movw   $0x30,-0x1b44(%ebp)
    415a:	30 00 
    415c:	c6 85 be e4 ff ff 00 	movb   $0x0,-0x1b42(%ebp)
    4163:	c7 85 c0 e4 ff ff 00 	movl   $0x0,-0x1b40(%ebp)
    416a:	00 00 00 
    416d:	c7 85 c4 e4 ff ff 00 	movl   $0x0,-0x1b3c(%ebp)
    4174:	00 00 00 
    4177:	c7 85 c8 e4 ff ff 00 	movl   $0x0,-0x1b38(%ebp)
    417e:	00 00 00 
    4181:	c7 85 cc e4 ff ff 00 	movl   $0x0,-0x1b34(%ebp)
    4188:	00 00 00 
    418b:	c7 85 d0 e4 ff ff ff 	movl   $0xffffffff,-0x1b30(%ebp)
    4192:	ff ff ff 
    4195:	c7 85 d4 e4 ff ff 00 	movl   $0x0,-0x1b2c(%ebp)
    419c:	00 00 00 
    419f:	c7 85 d8 e4 ff ff 00 	movl   $0x0,-0x1b28(%ebp)
    41a6:	00 00 00 
    41a9:	c7 85 dc e4 ff ff 00 	movl   $0x0,-0x1b24(%ebp)
    41b0:	00 00 00 
    41b3:	c7 85 e0 e4 ff ff 00 	movl   $0x0,-0x1b20(%ebp)
    41ba:	00 00 00 
    41bd:	66 c7 85 e4 e4 ff ff 	movw   $0x31,-0x1b1c(%ebp)
    41c4:	31 00 
    41c6:	c6 85 e6 e4 ff ff 00 	movb   $0x0,-0x1b1a(%ebp)
    41cd:	c7 85 e8 e4 ff ff 02 	movl   $0x2,-0x1b18(%ebp)
    41d4:	00 00 00 
    41d7:	c7 85 ec e4 ff ff 02 	movl   $0x2,-0x1b14(%ebp)
    41de:	00 00 00 
    41e1:	c7 85 f0 e4 ff ff 00 	movl   $0x0,-0x1b10(%ebp)
    41e8:	00 00 00 
    41eb:	c7 85 f4 e4 ff ff 00 	movl   $0x0,-0x1b0c(%ebp)
    41f2:	00 00 00 
    41f5:	c7 85 f8 e4 ff ff ff 	movl   $0xffffffff,-0x1b08(%ebp)
    41fc:	ff ff ff 
    41ff:	c7 85 fc e4 ff ff 00 	movl   $0x0,-0x1b04(%ebp)
    4206:	00 00 00 
    4209:	c7 85 00 e5 ff ff 00 	movl   $0x0,-0x1b00(%ebp)
    4210:	00 00 00 
    4213:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    4216:	89 85 04 e5 ff ff    	mov    %eax,-0x1afc(%ebp)
    421c:	c7 85 08 e5 ff ff 07 	movl   $0x7,-0x1af8(%ebp)
    4223:	00 00 00 
    4226:	66 c7 85 0c e5 ff ff 	movw   $0x32,-0x1af4(%ebp)
    422d:	32 00 
    422f:	c6 85 0e e5 ff ff 00 	movb   $0x0,-0x1af2(%ebp)
    4236:	c7 85 10 e5 ff ff 03 	movl   $0x3,-0x1af0(%ebp)
    423d:	00 00 00 
    4240:	c7 85 14 e5 ff ff 03 	movl   $0x3,-0x1aec(%ebp)
    4247:	00 00 00 
    424a:	c7 85 18 e5 ff ff 00 	movl   $0x0,-0x1ae8(%ebp)
    4251:	00 00 00 
    4254:	c7 85 1c e5 ff ff 00 	movl   $0x0,-0x1ae4(%ebp)
    425b:	00 00 00 
    425e:	c7 85 20 e5 ff ff ff 	movl   $0xffffffff,-0x1ae0(%ebp)
    4265:	ff ff ff 
    4268:	c7 85 24 e5 ff ff 00 	movl   $0x0,-0x1adc(%ebp)
    426f:	00 00 00 
    4272:	c7 85 28 e5 ff ff 00 	movl   $0x0,-0x1ad8(%ebp)
    4279:	00 00 00 
    427c:	8d 45 c4             	lea    -0x3c(%ebp),%eax
    427f:	89 85 2c e5 ff ff    	mov    %eax,-0x1ad4(%ebp)
    4285:	c7 85 30 e5 ff ff 11 	movl   $0x11,-0x1ad0(%ebp)
    428c:	00 00 00 
    428f:	66 c7 85 34 e5 ff ff 	movw   $0x33,-0x1acc(%ebp)
    4296:	33 00 
    4298:	c6 85 36 e5 ff ff 00 	movb   $0x0,-0x1aca(%ebp)
    429f:	c7 85 38 e5 ff ff 03 	movl   $0x3,-0x1ac8(%ebp)
    42a6:	00 00 00 
    42a9:	c7 85 3c e5 ff ff 03 	movl   $0x3,-0x1ac4(%ebp)
    42b0:	00 00 00 
    42b3:	c7 85 40 e5 ff ff 00 	movl   $0x0,-0x1ac0(%ebp)
    42ba:	00 00 00 
    42bd:	c7 85 44 e5 ff ff 00 	movl   $0x0,-0x1abc(%ebp)
    42c4:	00 00 00 
    42c7:	c7 85 48 e5 ff ff ff 	movl   $0xffffffff,-0x1ab8(%ebp)
    42ce:	ff ff ff 
    42d1:	c7 85 4c e5 ff ff 00 	movl   $0x0,-0x1ab4(%ebp)
    42d8:	00 00 00 
    42db:	c7 85 50 e5 ff ff 00 	movl   $0x0,-0x1ab0(%ebp)
    42e2:	00 00 00 
    42e5:	8d 45 a2             	lea    -0x5e(%ebp),%eax
    42e8:	89 85 54 e5 ff ff    	mov    %eax,-0x1aac(%ebp)
    42ee:	c7 85 58 e5 ff ff 11 	movl   $0x11,-0x1aa8(%ebp)
    42f5:	00 00 00 
    42f8:	66 c7 85 5c e5 ff ff 	movw   $0x34,-0x1aa4(%ebp)
    42ff:	34 00 
    4301:	c6 85 5e e5 ff ff 00 	movb   $0x0,-0x1aa2(%ebp)
    4308:	c7 85 60 e5 ff ff 00 	movl   $0x0,-0x1aa0(%ebp)
    430f:	00 00 00 
    4312:	c7 85 64 e5 ff ff 00 	movl   $0x0,-0x1a9c(%ebp)
    4319:	00 00 00 
    431c:	c7 85 68 e5 ff ff 00 	movl   $0x0,-0x1a98(%ebp)
    4323:	00 00 00 
    4326:	c7 85 6c e5 ff ff 00 	movl   $0x0,-0x1a94(%ebp)
    432d:	00 00 00 
    4330:	c7 85 70 e5 ff ff ff 	movl   $0xffffffff,-0x1a90(%ebp)
    4337:	ff ff ff 
    433a:	c7 85 74 e5 ff ff 00 	movl   $0x0,-0x1a8c(%ebp)
    4341:	00 00 00 
    4344:	c7 85 78 e5 ff ff 00 	movl   $0x0,-0x1a88(%ebp)
    434b:	00 00 00 
    434e:	c7 85 7c e5 ff ff 00 	movl   $0x0,-0x1a84(%ebp)
    4355:	00 00 00 
    4358:	c7 85 80 e5 ff ff 00 	movl   $0x0,-0x1a80(%ebp)
    435f:	00 00 00 
    4362:	66 c7 85 84 e5 ff ff 	movw   $0x35,-0x1a7c(%ebp)
    4369:	35 00 
    436b:	c6 85 86 e5 ff ff 00 	movb   $0x0,-0x1a7a(%ebp)
    4372:	c7 85 88 e5 ff ff 04 	movl   $0x4,-0x1a78(%ebp)
    4379:	00 00 00 
    437c:	c7 85 8c e5 ff ff 04 	movl   $0x4,-0x1a74(%ebp)
    4383:	00 00 00 
    4386:	c7 85 90 e5 ff ff 00 	movl   $0x0,-0x1a70(%ebp)
    438d:	00 00 00 
    4390:	c7 85 94 e5 ff ff 00 	movl   $0x0,-0x1a6c(%ebp)
    4397:	00 00 00 
    439a:	c7 85 98 e5 ff ff ff 	movl   $0xffffffff,-0x1a68(%ebp)
    43a1:	ff ff ff 
    43a4:	c7 85 9c e5 ff ff 00 	movl   $0x0,-0x1a64(%ebp)
    43ab:	00 00 00 
    43ae:	c7 85 a0 e5 ff ff 00 	movl   $0x0,-0x1a60(%ebp)
    43b5:	00 00 00 
    43b8:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
    43be:	89 85 a4 e5 ff ff    	mov    %eax,-0x1a5c(%ebp)
    43c4:	c7 85 a8 e5 ff ff 1f 	movl   $0x1f,-0x1a58(%ebp)
    43cb:	00 00 00 
    43ce:	66 c7 85 ac e5 ff ff 	movw   $0x36,-0x1a54(%ebp)
    43d5:	36 00 
    43d7:	c6 85 ae e5 ff ff 00 	movb   $0x0,-0x1a52(%ebp)
    43de:	c7 85 b0 e5 ff ff 04 	movl   $0x4,-0x1a50(%ebp)
    43e5:	00 00 00 
    43e8:	c7 85 b4 e5 ff ff 04 	movl   $0x4,-0x1a4c(%ebp)
    43ef:	00 00 00 
    43f2:	c7 85 b8 e5 ff ff 00 	movl   $0x0,-0x1a48(%ebp)
    43f9:	00 00 00 
    43fc:	c7 85 bc e5 ff ff 00 	movl   $0x0,-0x1a44(%ebp)
    4403:	00 00 00 
    4406:	c7 85 c0 e5 ff ff ff 	movl   $0xffffffff,-0x1a40(%ebp)
    440d:	ff ff ff 
    4410:	c7 85 c4 e5 ff ff 00 	movl   $0x0,-0x1a3c(%ebp)
    4417:	00 00 00 
    441a:	c7 85 c8 e5 ff ff 00 	movl   $0x0,-0x1a38(%ebp)
    4421:	00 00 00 
    4424:	8d 85 26 ff ff ff    	lea    -0xda(%ebp),%eax
    442a:	89 85 cc e5 ff ff    	mov    %eax,-0x1a34(%ebp)
    4430:	c7 85 d0 e5 ff ff 1f 	movl   $0x1f,-0x1a30(%ebp)
    4437:	00 00 00 
    443a:	66 c7 85 d4 e5 ff ff 	movw   $0x37,-0x1a2c(%ebp)
    4441:	37 00 
    4443:	c6 85 d6 e5 ff ff 00 	movb   $0x0,-0x1a2a(%ebp)
    444a:	c7 85 d8 e5 ff ff 06 	movl   $0x6,-0x1a28(%ebp)
    4451:	00 00 00 
    4454:	c7 85 dc e5 ff ff 06 	movl   $0x6,-0x1a24(%ebp)
    445b:	00 00 00 
    445e:	c7 85 e0 e5 ff ff 00 	movl   $0x0,-0x1a20(%ebp)
    4465:	00 00 00 
    4468:	c7 85 e4 e5 ff ff 00 	movl   $0x0,-0x1a1c(%ebp)
    446f:	00 00 00 
    4472:	c7 85 e8 e5 ff ff ff 	movl   $0xffffffff,-0x1a18(%ebp)
    4479:	ff ff ff 
    447c:	c7 85 ec e5 ff ff 00 	movl   $0x0,-0x1a14(%ebp)
    4483:	00 00 00 
    4486:	c7 85 f0 e5 ff ff 00 	movl   $0x0,-0x1a10(%ebp)
    448d:	00 00 00 
    4490:	8d 85 98 fe ff ff    	lea    -0x168(%ebp),%eax
    4496:	89 85 f4 e5 ff ff    	mov    %eax,-0x1a0c(%ebp)
    449c:	c7 85 f8 e5 ff ff 47 	movl   $0x47,-0x1a08(%ebp)
    44a3:	00 00 00 
    44a6:	66 c7 85 fc e5 ff ff 	movw   $0x38,-0x1a04(%ebp)
    44ad:	38 00 
    44af:	c6 85 fe e5 ff ff 00 	movb   $0x0,-0x1a02(%ebp)
    44b6:	c7 85 00 e6 ff ff 06 	movl   $0x6,-0x1a00(%ebp)
    44bd:	00 00 00 
    44c0:	c7 85 04 e6 ff ff 06 	movl   $0x6,-0x19fc(%ebp)
    44c7:	00 00 00 
    44ca:	c7 85 08 e6 ff ff 00 	movl   $0x0,-0x19f8(%ebp)
    44d1:	00 00 00 
    44d4:	c7 85 0c e6 ff ff 00 	movl   $0x0,-0x19f4(%ebp)
    44db:	00 00 00 
    44de:	c7 85 10 e6 ff ff ff 	movl   $0xffffffff,-0x19f0(%ebp)
    44e5:	ff ff ff 
    44e8:	c7 85 14 e6 ff ff 00 	movl   $0x0,-0x19ec(%ebp)
    44ef:	00 00 00 
    44f2:	c7 85 18 e6 ff ff 00 	movl   $0x0,-0x19e8(%ebp)
    44f9:	00 00 00 
    44fc:	8d 85 0a fe ff ff    	lea    -0x1f6(%ebp),%eax
    4502:	89 85 1c e6 ff ff    	mov    %eax,-0x19e4(%ebp)
    4508:	c7 85 20 e6 ff ff 47 	movl   $0x47,-0x19e0(%ebp)
    450f:	00 00 00 
    4512:	66 c7 85 24 e6 ff ff 	movw   $0x39,-0x19dc(%ebp)
    4519:	39 00 
    451b:	c6 85 26 e6 ff ff 00 	movb   $0x0,-0x19da(%ebp)
    4522:	c7 85 28 e6 ff ff 06 	movl   $0x6,-0x19d8(%ebp)
    4529:	00 00 00 
    452c:	c7 85 2c e6 ff ff 06 	movl   $0x6,-0x19d4(%ebp)
    4533:	00 00 00 
    4536:	c7 85 30 e6 ff ff 00 	movl   $0x0,-0x19d0(%ebp)
    453d:	00 00 00 
    4540:	c7 85 34 e6 ff ff 00 	movl   $0x0,-0x19cc(%ebp)
    4547:	00 00 00 
    454a:	c7 85 38 e6 ff ff ff 	movl   $0xffffffff,-0x19c8(%ebp)
    4551:	ff ff ff 
    4554:	c7 85 3c e6 ff ff 00 	movl   $0x0,-0x19c4(%ebp)
    455b:	00 00 00 
    455e:	c7 85 40 e6 ff ff 00 	movl   $0x0,-0x19c0(%ebp)
    4565:	00 00 00 
    4568:	8d 85 7c fd ff ff    	lea    -0x284(%ebp),%eax
    456e:	89 85 44 e6 ff ff    	mov    %eax,-0x19bc(%ebp)
    4574:	c7 85 48 e6 ff ff 47 	movl   $0x47,-0x19b8(%ebp)
    457b:	00 00 00 
    457e:	66 c7 85 4c e6 ff ff 	movw   $0x3031,-0x19b4(%ebp)
    4585:	31 30 
    4587:	c6 85 4e e6 ff ff 00 	movb   $0x0,-0x19b2(%ebp)
    458e:	c7 85 50 e6 ff ff 08 	movl   $0x8,-0x19b0(%ebp)
    4595:	00 00 00 
    4598:	c7 85 54 e6 ff ff 08 	movl   $0x8,-0x19ac(%ebp)
    459f:	00 00 00 
    45a2:	c7 85 58 e6 ff ff 00 	movl   $0x0,-0x19a8(%ebp)
    45a9:	00 00 00 
    45ac:	c7 85 5c e6 ff ff 00 	movl   $0x0,-0x19a4(%ebp)
    45b3:	00 00 00 
    45b6:	c7 85 60 e6 ff ff ff 	movl   $0xffffffff,-0x19a0(%ebp)
    45bd:	ff ff ff 
    45c0:	c7 85 64 e6 ff ff 00 	movl   $0x0,-0x199c(%ebp)
    45c7:	00 00 00 
    45ca:	c7 85 68 e6 ff ff 00 	movl   $0x0,-0x1998(%ebp)
    45d1:	00 00 00 
    45d4:	8d 85 7e fc ff ff    	lea    -0x382(%ebp),%eax
    45da:	89 85 6c e6 ff ff    	mov    %eax,-0x1994(%ebp)
    45e0:	c7 85 70 e6 ff ff 7f 	movl   $0x7f,-0x1990(%ebp)
    45e7:	00 00 00 
    45ea:	66 c7 85 74 e6 ff ff 	movw   $0x3131,-0x198c(%ebp)
    45f1:	31 31 
    45f3:	c6 85 76 e6 ff ff 00 	movb   $0x0,-0x198a(%ebp)
    45fa:	c7 85 78 e6 ff ff 08 	movl   $0x8,-0x1988(%ebp)
    4601:	00 00 00 
    4604:	c7 85 7c e6 ff ff 08 	movl   $0x8,-0x1984(%ebp)
    460b:	00 00 00 
    460e:	c7 85 80 e6 ff ff 00 	movl   $0x0,-0x1980(%ebp)
    4615:	00 00 00 
    4618:	c7 85 84 e6 ff ff 00 	movl   $0x0,-0x197c(%ebp)
    461f:	00 00 00 
    4622:	c7 85 88 e6 ff ff ff 	movl   $0xffffffff,-0x1978(%ebp)
    4629:	ff ff ff 
    462c:	c7 85 8c e6 ff ff 00 	movl   $0x0,-0x1974(%ebp)
    4633:	00 00 00 
    4636:	c7 85 90 e6 ff ff 00 	movl   $0x0,-0x1970(%ebp)
    463d:	00 00 00 
    4640:	8d 85 80 fb ff ff    	lea    -0x480(%ebp),%eax
    4646:	89 85 94 e6 ff ff    	mov    %eax,-0x196c(%ebp)
    464c:	c7 85 98 e6 ff ff 7f 	movl   $0x7f,-0x1968(%ebp)
    4653:	00 00 00 
    4656:	66 c7 85 9c e6 ff ff 	movw   $0x3231,-0x1964(%ebp)
    465d:	31 32 
    465f:	c6 85 9e e6 ff ff 00 	movb   $0x0,-0x1962(%ebp)
    4666:	c7 85 a0 e6 ff ff 08 	movl   $0x8,-0x1960(%ebp)
    466d:	00 00 00 
    4670:	c7 85 a4 e6 ff ff 08 	movl   $0x8,-0x195c(%ebp)
    4677:	00 00 00 
    467a:	c7 85 a8 e6 ff ff 00 	movl   $0x0,-0x1958(%ebp)
    4681:	00 00 00 
    4684:	c7 85 ac e6 ff ff 00 	movl   $0x0,-0x1954(%ebp)
    468b:	00 00 00 
    468e:	c7 85 b0 e6 ff ff ff 	movl   $0xffffffff,-0x1950(%ebp)
    4695:	ff ff ff 
    4698:	c7 85 b4 e6 ff ff 00 	movl   $0x0,-0x194c(%ebp)
    469f:	00 00 00 
    46a2:	c7 85 b8 e6 ff ff 00 	movl   $0x0,-0x1948(%ebp)
    46a9:	00 00 00 
    46ac:	8d 85 82 fa ff ff    	lea    -0x57e(%ebp),%eax
    46b2:	89 85 bc e6 ff ff    	mov    %eax,-0x1944(%ebp)
    46b8:	c7 85 c0 e6 ff ff 7f 	movl   $0x7f,-0x1940(%ebp)
    46bf:	00 00 00 
    46c2:	66 c7 85 c4 e6 ff ff 	movw   $0x3331,-0x193c(%ebp)
    46c9:	31 33 
    46cb:	c6 85 c6 e6 ff ff 00 	movb   $0x0,-0x193a(%ebp)
    46d2:	c7 85 c8 e6 ff ff 10 	movl   $0x10,-0x1938(%ebp)
    46d9:	00 00 00 
    46dc:	c7 85 cc e6 ff ff 10 	movl   $0x10,-0x1934(%ebp)
    46e3:	00 00 00 
    46e6:	c7 85 d0 e6 ff ff 00 	movl   $0x0,-0x1930(%ebp)
    46ed:	00 00 00 
    46f0:	c7 85 d4 e6 ff ff 00 	movl   $0x0,-0x192c(%ebp)
    46f7:	00 00 00 
    46fa:	c7 85 d8 e6 ff ff ff 	movl   $0xffffffff,-0x1928(%ebp)
    4701:	ff ff ff 
    4704:	c7 85 dc e6 ff ff 00 	movl   $0x0,-0x1924(%ebp)
    470b:	00 00 00 
    470e:	c7 85 e0 e6 ff ff 00 	movl   $0x0,-0x1920(%ebp)
    4715:	00 00 00 
    4718:	8d 85 84 f6 ff ff    	lea    -0x97c(%ebp),%eax
    471e:	89 85 e4 e6 ff ff    	mov    %eax,-0x191c(%ebp)
    4724:	c7 85 e8 e6 ff ff ff 	movl   $0x1ff,-0x1918(%ebp)
    472b:	01 00 00 
    472e:	66 c7 85 ec e6 ff ff 	movw   $0x3431,-0x1914(%ebp)
    4735:	31 34 
    4737:	c6 85 ee e6 ff ff 00 	movb   $0x0,-0x1912(%ebp)
    473e:	c7 85 f0 e6 ff ff 00 	movl   $0x0,-0x1910(%ebp)
    4745:	00 00 00 
    4748:	c7 85 f4 e6 ff ff 00 	movl   $0x0,-0x190c(%ebp)
    474f:	00 00 00 
    4752:	c7 85 f8 e6 ff ff 00 	movl   $0x0,-0x1908(%ebp)
    4759:	00 00 00 
    475c:	c7 85 fc e6 ff ff 00 	movl   $0x0,-0x1904(%ebp)
    4763:	00 00 00 
    4766:	c7 85 00 e7 ff ff ff 	movl   $0xffffffff,-0x1900(%ebp)
    476d:	ff ff ff 
    4770:	c7 85 04 e7 ff ff 00 	movl   $0x0,-0x18fc(%ebp)
    4777:	00 00 00 
    477a:	c7 85 08 e7 ff ff 00 	movl   $0x0,-0x18f8(%ebp)
    4781:	00 00 00 
    4784:	c7 85 0c e7 ff ff 00 	movl   $0x0,-0x18f4(%ebp)
    478b:	00 00 00 
    478e:	c7 85 10 e7 ff ff 00 	movl   $0x0,-0x18f0(%ebp)
    4795:	00 00 00 
    4798:	66 c7 85 14 e7 ff ff 	movw   $0x3531,-0x18ec(%ebp)
    479f:	31 35 
    47a1:	c6 85 16 e7 ff ff 00 	movb   $0x0,-0x18ea(%ebp)
    47a8:	c7 85 18 e7 ff ff 10 	movl   $0x10,-0x18e8(%ebp)
    47af:	00 00 00 
    47b2:	c7 85 1c e7 ff ff 10 	movl   $0x10,-0x18e4(%ebp)
    47b9:	00 00 00 
    47bc:	c7 85 20 e7 ff ff 00 	movl   $0x0,-0x18e0(%ebp)
    47c3:	00 00 00 
    47c6:	c7 85 24 e7 ff ff 00 	movl   $0x0,-0x18dc(%ebp)
    47cd:	00 00 00 
    47d0:	c7 85 28 e7 ff ff ff 	movl   $0xffffffff,-0x18d8(%ebp)
    47d7:	ff ff ff 
    47da:	c7 85 2c e7 ff ff 00 	movl   $0x0,-0x18d4(%ebp)
    47e1:	00 00 00 
    47e4:	c7 85 30 e7 ff ff 00 	movl   $0x0,-0x18d0(%ebp)
    47eb:	00 00 00 
    47ee:	8d 85 86 f2 ff ff    	lea    -0xd7a(%ebp),%eax
    47f4:	89 85 34 e7 ff ff    	mov    %eax,-0x18cc(%ebp)
    47fa:	c7 85 38 e7 ff ff ff 	movl   $0x1ff,-0x18c8(%ebp)
    4801:	01 00 00 
    4804:	66 c7 85 3c e7 ff ff 	movw   $0x3631,-0x18c4(%ebp)
    480b:	31 36 
    480d:	c6 85 3e e7 ff ff 00 	movb   $0x0,-0x18c2(%ebp)
    4814:	c7 85 40 e7 ff ff 10 	movl   $0x10,-0x18c0(%ebp)
    481b:	00 00 00 
    481e:	c7 85 44 e7 ff ff 10 	movl   $0x10,-0x18bc(%ebp)
    4825:	00 00 00 
    4828:	c7 85 48 e7 ff ff 01 	movl   $0x1,-0x18b8(%ebp)
    482f:	00 00 00 
    4832:	c7 85 4c e7 ff ff 01 	movl   $0x1,-0x18b4(%ebp)
    4839:	00 00 00 
    483c:	c7 85 50 e7 ff ff ff 	movl   $0xffffffff,-0x18b0(%ebp)
    4843:	ff ff ff 
    4846:	c7 85 54 e7 ff ff 00 	movl   $0x0,-0x18ac(%ebp)
    484d:	00 00 00 
    4850:	c7 85 58 e7 ff ff 00 	movl   $0x0,-0x18a8(%ebp)
    4857:	00 00 00 
    485a:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    4860:	89 85 5c e7 ff ff    	mov    %eax,-0x18a4(%ebp)
    4866:	c7 85 60 e7 ff ff ff 	movl   $0x1ff,-0x18a0(%ebp)
    486d:	01 00 00 
    4870:	66 c7 85 64 e7 ff ff 	movw   $0x3731,-0x189c(%ebp)
    4877:	31 37 
    4879:	c6 85 66 e7 ff ff 00 	movb   $0x0,-0x189a(%ebp)
    4880:	c7 85 68 e7 ff ff 10 	movl   $0x10,-0x1898(%ebp)
    4887:	00 00 00 
    488a:	c7 85 6c e7 ff ff 10 	movl   $0x10,-0x1894(%ebp)
    4891:	00 00 00 
    4894:	c7 85 70 e7 ff ff 02 	movl   $0x2,-0x1890(%ebp)
    489b:	00 00 00 
    489e:	c7 85 74 e7 ff ff 03 	movl   $0x3,-0x188c(%ebp)
    48a5:	00 00 00 
    48a8:	c7 85 78 e7 ff ff 10 	movl   $0x10,-0x1888(%ebp)
    48af:	00 00 00 
    48b2:	c7 85 7c e7 ff ff 00 	movl   $0x0,-0x1884(%ebp)
    48b9:	00 00 00 
    48bc:	c7 85 80 e7 ff ff 00 	movl   $0x0,-0x1880(%ebp)
    48c3:	00 00 00 
    48c6:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    48cc:	89 85 84 e7 ff ff    	mov    %eax,-0x187c(%ebp)
    48d2:	c7 85 88 e7 ff ff ff 	movl   $0x1ff,-0x1878(%ebp)
    48d9:	01 00 00 
    48dc:	66 c7 85 8c e7 ff ff 	movw   $0x3831,-0x1874(%ebp)
    48e3:	31 38 
    48e5:	c6 85 8e e7 ff ff 00 	movb   $0x0,-0x1872(%ebp)
    48ec:	c7 85 90 e7 ff ff 10 	movl   $0x10,-0x1870(%ebp)
    48f3:	00 00 00 
    48f6:	c7 85 94 e7 ff ff 10 	movl   $0x10,-0x186c(%ebp)
    48fd:	00 00 00 
    4900:	c7 85 98 e7 ff ff 03 	movl   $0x3,-0x1868(%ebp)
    4907:	00 00 00 
    490a:	c7 85 9c e7 ff ff 07 	movl   $0x7,-0x1864(%ebp)
    4911:	00 00 00 
    4914:	c7 85 a0 e7 ff ff 10 	movl   $0x10,-0x1860(%ebp)
    491b:	00 00 00 
    491e:	c7 85 a4 e7 ff ff 00 	movl   $0x0,-0x185c(%ebp)
    4925:	00 00 00 
    4928:	c7 85 a8 e7 ff ff 00 	movl   $0x0,-0x1858(%ebp)
    492f:	00 00 00 
    4932:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    4938:	89 85 ac e7 ff ff    	mov    %eax,-0x1854(%ebp)
    493e:	c7 85 b0 e7 ff ff ff 	movl   $0x1ff,-0x1850(%ebp)
    4945:	01 00 00 
    4948:	66 c7 85 b4 e7 ff ff 	movw   $0x3931,-0x184c(%ebp)
    494f:	31 39 
    4951:	c6 85 b6 e7 ff ff 00 	movb   $0x0,-0x184a(%ebp)
    4958:	c7 85 b8 e7 ff ff 10 	movl   $0x10,-0x1848(%ebp)
    495f:	00 00 00 
    4962:	c7 85 bc e7 ff ff 10 	movl   $0x10,-0x1844(%ebp)
    4969:	00 00 00 
    496c:	c7 85 c0 e7 ff ff 04 	movl   $0x4,-0x1840(%ebp)
    4973:	00 00 00 
    4976:	c7 85 c4 e7 ff ff 0f 	movl   $0xf,-0x183c(%ebp)
    497d:	00 00 00 
    4980:	c7 85 c8 e7 ff ff 10 	movl   $0x10,-0x1838(%ebp)
    4987:	00 00 00 
    498a:	c7 85 cc e7 ff ff 00 	movl   $0x0,-0x1834(%ebp)
    4991:	00 00 00 
    4994:	c7 85 d0 e7 ff ff 00 	movl   $0x0,-0x1830(%ebp)
    499b:	00 00 00 
    499e:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    49a4:	89 85 d4 e7 ff ff    	mov    %eax,-0x182c(%ebp)
    49aa:	c7 85 d8 e7 ff ff ff 	movl   $0x1ff,-0x1828(%ebp)
    49b1:	01 00 00 
    49b4:	66 c7 85 dc e7 ff ff 	movw   $0x3032,-0x1824(%ebp)
    49bb:	32 30 
    49bd:	c6 85 de e7 ff ff 00 	movb   $0x0,-0x1822(%ebp)
    49c4:	c7 85 e0 e7 ff ff 10 	movl   $0x10,-0x1820(%ebp)
    49cb:	00 00 00 
    49ce:	c7 85 e4 e7 ff ff 10 	movl   $0x10,-0x181c(%ebp)
    49d5:	00 00 00 
    49d8:	c7 85 e8 e7 ff ff 06 	movl   $0x6,-0x1818(%ebp)
    49df:	00 00 00 
    49e2:	c7 85 ec e7 ff ff 3f 	movl   $0x3f,-0x1814(%ebp)
    49e9:	00 00 00 
    49ec:	c7 85 f0 e7 ff ff 10 	movl   $0x10,-0x1810(%ebp)
    49f3:	00 00 00 
    49f6:	c7 85 f4 e7 ff ff 00 	movl   $0x0,-0x180c(%ebp)
    49fd:	00 00 00 
    4a00:	c7 85 f8 e7 ff ff 00 	movl   $0x0,-0x1808(%ebp)
    4a07:	00 00 00 
    4a0a:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    4a10:	89 85 fc e7 ff ff    	mov    %eax,-0x1804(%ebp)
    4a16:	c7 85 00 e8 ff ff ff 	movl   $0x1ff,-0x1800(%ebp)
    4a1d:	01 00 00 
    4a20:	66 c7 85 04 e8 ff ff 	movw   $0x3132,-0x17fc(%ebp)
    4a27:	32 31 
    4a29:	c6 85 06 e8 ff ff 00 	movb   $0x0,-0x17fa(%ebp)
    4a30:	c7 85 08 e8 ff ff 10 	movl   $0x10,-0x17f8(%ebp)
    4a37:	00 00 00 
    4a3a:	c7 85 0c e8 ff ff 10 	movl   $0x10,-0x17f4(%ebp)
    4a41:	00 00 00 
    4a44:	c7 85 10 e8 ff ff 08 	movl   $0x8,-0x17f0(%ebp)
    4a4b:	00 00 00 
    4a4e:	c7 85 14 e8 ff ff ff 	movl   $0xff,-0x17ec(%ebp)
    4a55:	00 00 00 
    4a58:	c7 85 18 e8 ff ff 10 	movl   $0x10,-0x17e8(%ebp)
    4a5f:	00 00 00 
    4a62:	c7 85 1c e8 ff ff 00 	movl   $0x0,-0x17e4(%ebp)
    4a69:	00 00 00 
    4a6c:	c7 85 20 e8 ff ff 00 	movl   $0x0,-0x17e0(%ebp)
    4a73:	00 00 00 
    4a76:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    4a7c:	89 85 24 e8 ff ff    	mov    %eax,-0x17dc(%ebp)
    4a82:	c7 85 28 e8 ff ff ff 	movl   $0x1ff,-0x17d8(%ebp)
    4a89:	01 00 00 
    4a8c:	66 c7 85 2c e8 ff ff 	movw   $0x3232,-0x17d4(%ebp)
    4a93:	32 32 
    4a95:	c6 85 2e e8 ff ff 00 	movb   $0x0,-0x17d2(%ebp)
    4a9c:	c7 85 30 e8 ff ff 10 	movl   $0x10,-0x17d0(%ebp)
    4aa3:	00 00 00 
    4aa6:	c7 85 34 e8 ff ff 10 	movl   $0x10,-0x17cc(%ebp)
    4aad:	00 00 00 
    4ab0:	c7 85 38 e8 ff ff 0a 	movl   $0xa,-0x17c8(%ebp)
    4ab7:	00 00 00 
    4aba:	c7 85 3c e8 ff ff ff 	movl   $0x3ff,-0x17c4(%ebp)
    4ac1:	03 00 00 
    4ac4:	c7 85 40 e8 ff ff 10 	movl   $0x10,-0x17c0(%ebp)
    4acb:	00 00 00 
    4ace:	c7 85 44 e8 ff ff 00 	movl   $0x0,-0x17bc(%ebp)
    4ad5:	00 00 00 
    4ad8:	c7 85 48 e8 ff ff 00 	movl   $0x0,-0x17b8(%ebp)
    4adf:	00 00 00 
    4ae2:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    4ae8:	89 85 4c e8 ff ff    	mov    %eax,-0x17b4(%ebp)
    4aee:	c7 85 50 e8 ff ff ff 	movl   $0x1ff,-0x17b0(%ebp)
    4af5:	01 00 00 
    4af8:	66 c7 85 54 e8 ff ff 	movw   $0x3332,-0x17ac(%ebp)
    4aff:	32 33 
    4b01:	c6 85 56 e8 ff ff 00 	movb   $0x0,-0x17aa(%ebp)
    4b08:	c7 85 58 e8 ff ff 10 	movl   $0x10,-0x17a8(%ebp)
    4b0f:	00 00 00 
    4b12:	c7 85 5c e8 ff ff 10 	movl   $0x10,-0x17a4(%ebp)
    4b19:	00 00 00 
    4b1c:	c7 85 60 e8 ff ff 0d 	movl   $0xd,-0x17a0(%ebp)
    4b23:	00 00 00 
    4b26:	c7 85 64 e8 ff ff ff 	movl   $0x1fff,-0x179c(%ebp)
    4b2d:	1f 00 00 
    4b30:	c7 85 68 e8 ff ff 10 	movl   $0x10,-0x1798(%ebp)
    4b37:	00 00 00 
    4b3a:	c7 85 6c e8 ff ff 00 	movl   $0x0,-0x1794(%ebp)
    4b41:	00 00 00 
    4b44:	c7 85 70 e8 ff ff 00 	movl   $0x0,-0x1790(%ebp)
    4b4b:	00 00 00 
    4b4e:	8d 85 88 ee ff ff    	lea    -0x1178(%ebp),%eax
    4b54:	89 85 74 e8 ff ff    	mov    %eax,-0x178c(%ebp)
    4b5a:	c7 85 78 e8 ff ff ff 	movl   $0x1ff,-0x1788(%ebp)
    4b61:	01 00 00 
    4b64:	66 c7 85 7c e8 ff ff 	movw   $0x3432,-0x1784(%ebp)
    4b6b:	32 34 
    4b6d:	c6 85 7e e8 ff ff 00 	movb   $0x0,-0x1782(%ebp)
    4b74:	c7 85 80 e8 ff ff 10 	movl   $0x10,-0x1780(%ebp)
    4b7b:	00 00 00 
    4b7e:	c7 85 84 e8 ff ff 10 	movl   $0x10,-0x177c(%ebp)
    4b85:	00 00 00 
    4b88:	c7 85 88 e8 ff ff 04 	movl   $0x4,-0x1778(%ebp)
    4b8f:	00 00 00 
    4b92:	c7 85 8c e8 ff ff 0f 	movl   $0xf,-0x1774(%ebp)
    4b99:	00 00 00 
    4b9c:	c7 85 90 e8 ff ff ff 	movl   $0xffffffff,-0x1770(%ebp)
    4ba3:	ff ff ff 
    4ba6:	c7 85 94 e8 ff ff 00 	movl   $0x0,-0x176c(%ebp)
    4bad:	00 00 00 
    4bb0:	c7 85 98 e8 ff ff 00 	movl   $0x0,-0x1768(%ebp)
    4bb7:	00 00 00 
    4bba:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    4bc0:	89 85 9c e8 ff ff    	mov    %eax,-0x1764(%ebp)
    4bc6:	c7 85 a0 e8 ff ff 00 	movl   $0x200,-0x1760(%ebp)
    4bcd:	02 00 00 
    4bd0:	66 c7 85 a4 e8 ff ff 	movw   $0x3532,-0x175c(%ebp)
    4bd7:	32 35 
    4bd9:	c6 85 a6 e8 ff ff 00 	movb   $0x0,-0x175a(%ebp)
    4be0:	c7 85 a8 e8 ff ff 10 	movl   $0x10,-0x1758(%ebp)
    4be7:	00 00 00 
    4bea:	c7 85 ac e8 ff ff 10 	movl   $0x10,-0x1754(%ebp)
    4bf1:	00 00 00 
    4bf4:	c7 85 b0 e8 ff ff 05 	movl   $0x5,-0x1750(%ebp)
    4bfb:	00 00 00 
    4bfe:	c7 85 b4 e8 ff ff 1f 	movl   $0x1f,-0x174c(%ebp)
    4c05:	00 00 00 
    4c08:	c7 85 b8 e8 ff ff 18 	movl   $0x18,-0x1748(%ebp)
    4c0f:	00 00 00 
    4c12:	c7 85 bc e8 ff ff 00 	movl   $0x0,-0x1744(%ebp)
    4c19:	00 00 00 
    4c1c:	c7 85 c0 e8 ff ff 00 	movl   $0x0,-0x1740(%ebp)
    4c23:	00 00 00 
    4c26:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    4c2c:	89 85 c4 e8 ff ff    	mov    %eax,-0x173c(%ebp)
    4c32:	c7 85 c8 e8 ff ff 00 	movl   $0x200,-0x1738(%ebp)
    4c39:	02 00 00 
    4c3c:	66 c7 85 cc e8 ff ff 	movw   $0x3632,-0x1734(%ebp)
    4c43:	32 36 
    4c45:	c6 85 ce e8 ff ff 00 	movb   $0x0,-0x1732(%ebp)
    4c4c:	c7 85 d0 e8 ff ff 10 	movl   $0x10,-0x1730(%ebp)
    4c53:	00 00 00 
    4c56:	c7 85 d4 e8 ff ff 10 	movl   $0x10,-0x172c(%ebp)
    4c5d:	00 00 00 
    4c60:	c7 85 d8 e8 ff ff 06 	movl   $0x6,-0x1728(%ebp)
    4c67:	00 00 00 
    4c6a:	c7 85 dc e8 ff ff 3f 	movl   $0x3f,-0x1724(%ebp)
    4c71:	00 00 00 
    4c74:	c7 85 e0 e8 ff ff 18 	movl   $0x18,-0x1720(%ebp)
    4c7b:	00 00 00 
    4c7e:	c7 85 e4 e8 ff ff 00 	movl   $0x0,-0x171c(%ebp)
    4c85:	00 00 00 
    4c88:	c7 85 e8 e8 ff ff 00 	movl   $0x0,-0x1718(%ebp)
    4c8f:	00 00 00 
    4c92:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    4c98:	89 85 ec e8 ff ff    	mov    %eax,-0x1714(%ebp)
    4c9e:	c7 85 f0 e8 ff ff 00 	movl   $0x200,-0x1710(%ebp)
    4ca5:	02 00 00 
    4ca8:	66 c7 85 f4 e8 ff ff 	movw   $0x3732,-0x170c(%ebp)
    4caf:	32 37 
    4cb1:	c6 85 f6 e8 ff ff 00 	movb   $0x0,-0x170a(%ebp)
    4cb8:	c7 85 f8 e8 ff ff 10 	movl   $0x10,-0x1708(%ebp)
    4cbf:	00 00 00 
    4cc2:	c7 85 fc e8 ff ff 10 	movl   $0x10,-0x1704(%ebp)
    4cc9:	00 00 00 
    4ccc:	c7 85 00 e9 ff ff 07 	movl   $0x7,-0x1700(%ebp)
    4cd3:	00 00 00 
    4cd6:	c7 85 04 e9 ff ff 7f 	movl   $0x7f,-0x16fc(%ebp)
    4cdd:	00 00 00 
    4ce0:	c7 85 08 e9 ff ff 18 	movl   $0x18,-0x16f8(%ebp)
    4ce7:	00 00 00 
    4cea:	c7 85 0c e9 ff ff 00 	movl   $0x0,-0x16f4(%ebp)
    4cf1:	00 00 00 
    4cf4:	c7 85 10 e9 ff ff 00 	movl   $0x0,-0x16f0(%ebp)
    4cfb:	00 00 00 
    4cfe:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    4d04:	89 85 14 e9 ff ff    	mov    %eax,-0x16ec(%ebp)
    4d0a:	c7 85 18 e9 ff ff 00 	movl   $0x200,-0x16e8(%ebp)
    4d11:	02 00 00 
    4d14:	66 c7 85 1c e9 ff ff 	movw   $0x3832,-0x16e4(%ebp)
    4d1b:	32 38 
    4d1d:	c6 85 1e e9 ff ff 00 	movb   $0x0,-0x16e2(%ebp)
    4d24:	c7 85 20 e9 ff ff 10 	movl   $0x10,-0x16e0(%ebp)
    4d2b:	00 00 00 
    4d2e:	c7 85 24 e9 ff ff 10 	movl   $0x10,-0x16dc(%ebp)
    4d35:	00 00 00 
    4d38:	c7 85 28 e9 ff ff 08 	movl   $0x8,-0x16d8(%ebp)
    4d3f:	00 00 00 
    4d42:	c7 85 2c e9 ff ff ff 	movl   $0xff,-0x16d4(%ebp)
    4d49:	00 00 00 
    4d4c:	c7 85 30 e9 ff ff 18 	movl   $0x18,-0x16d0(%ebp)
    4d53:	00 00 00 
    4d56:	c7 85 34 e9 ff ff 00 	movl   $0x0,-0x16cc(%ebp)
    4d5d:	00 00 00 
    4d60:	c7 85 38 e9 ff ff 00 	movl   $0x0,-0x16c8(%ebp)
    4d67:	00 00 00 
    4d6a:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    4d70:	89 85 3c e9 ff ff    	mov    %eax,-0x16c4(%ebp)
    4d76:	c7 85 40 e9 ff ff 00 	movl   $0x200,-0x16c0(%ebp)
    4d7d:	02 00 00 
    4d80:	66 c7 85 44 e9 ff ff 	movw   $0x3932,-0x16bc(%ebp)
    4d87:	32 39 
    4d89:	c6 85 46 e9 ff ff 00 	movb   $0x0,-0x16ba(%ebp)
    4d90:	c7 85 48 e9 ff ff 10 	movl   $0x10,-0x16b8(%ebp)
    4d97:	00 00 00 
    4d9a:	c7 85 4c e9 ff ff 10 	movl   $0x10,-0x16b4(%ebp)
    4da1:	00 00 00 
    4da4:	c7 85 50 e9 ff ff 09 	movl   $0x9,-0x16b0(%ebp)
    4dab:	00 00 00 
    4dae:	c7 85 54 e9 ff ff ff 	movl   $0x1ff,-0x16ac(%ebp)
    4db5:	01 00 00 
    4db8:	c7 85 58 e9 ff ff 18 	movl   $0x18,-0x16a8(%ebp)
    4dbf:	00 00 00 
    4dc2:	c7 85 5c e9 ff ff 00 	movl   $0x0,-0x16a4(%ebp)
    4dc9:	00 00 00 
    4dcc:	c7 85 60 e9 ff ff 00 	movl   $0x0,-0x16a0(%ebp)
    4dd3:	00 00 00 
    4dd6:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    4ddc:	89 85 64 e9 ff ff    	mov    %eax,-0x169c(%ebp)
    4de2:	c7 85 68 e9 ff ff 00 	movl   $0x200,-0x1698(%ebp)
    4de9:	02 00 00 
    4dec:	66 c7 85 6c e9 ff ff 	movw   $0x3033,-0x1694(%ebp)
    4df3:	33 30 
    4df5:	c6 85 6e e9 ff ff 00 	movb   $0x0,-0x1692(%ebp)
    4dfc:	c7 85 70 e9 ff ff 10 	movl   $0x10,-0x1690(%ebp)
    4e03:	00 00 00 
    4e06:	c7 85 74 e9 ff ff 10 	movl   $0x10,-0x168c(%ebp)
    4e0d:	00 00 00 
    4e10:	c7 85 78 e9 ff ff 0b 	movl   $0xb,-0x1688(%ebp)
    4e17:	00 00 00 
    4e1a:	c7 85 7c e9 ff ff ff 	movl   $0x7ff,-0x1684(%ebp)
    4e21:	07 00 00 
    4e24:	c7 85 80 e9 ff ff 18 	movl   $0x18,-0x1680(%ebp)
    4e2b:	00 00 00 
    4e2e:	c7 85 84 e9 ff ff 00 	movl   $0x0,-0x167c(%ebp)
    4e35:	00 00 00 
    4e38:	c7 85 88 e9 ff ff 00 	movl   $0x0,-0x1678(%ebp)
    4e3f:	00 00 00 
    4e42:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    4e48:	89 85 8c e9 ff ff    	mov    %eax,-0x1674(%ebp)
    4e4e:	c7 85 90 e9 ff ff 00 	movl   $0x200,-0x1670(%ebp)
    4e55:	02 00 00 
    4e58:	66 c7 85 94 e9 ff ff 	movw   $0x3133,-0x166c(%ebp)
    4e5f:	33 31 
    4e61:	c6 85 96 e9 ff ff 00 	movb   $0x0,-0x166a(%ebp)
    4e68:	c7 85 98 e9 ff ff 10 	movl   $0x10,-0x1668(%ebp)
    4e6f:	00 00 00 
    4e72:	c7 85 9c e9 ff ff 10 	movl   $0x10,-0x1664(%ebp)
    4e79:	00 00 00 
    4e7c:	c7 85 a0 e9 ff ff 0d 	movl   $0xd,-0x1660(%ebp)
    4e83:	00 00 00 
    4e86:	c7 85 a4 e9 ff ff ff 	movl   $0x1fff,-0x165c(%ebp)
    4e8d:	1f 00 00 
    4e90:	c7 85 a8 e9 ff ff 18 	movl   $0x18,-0x1658(%ebp)
    4e97:	00 00 00 
    4e9a:	c7 85 ac e9 ff ff 00 	movl   $0x0,-0x1654(%ebp)
    4ea1:	00 00 00 
    4ea4:	c7 85 b0 e9 ff ff 00 	movl   $0x0,-0x1650(%ebp)
    4eab:	00 00 00 
    4eae:	8d 85 88 ea ff ff    	lea    -0x1578(%ebp),%eax
    4eb4:	89 85 b4 e9 ff ff    	mov    %eax,-0x164c(%ebp)
    4eba:	c7 85 b8 e9 ff ff 00 	movl   $0x200,-0x1648(%ebp)
    4ec1:	02 00 00 
    4ec4:	66 c7 85 bc e9 ff ff 	movw   $0x3233,-0x1644(%ebp)
    4ecb:	33 32 
    4ecd:	c6 85 be e9 ff ff 00 	movb   $0x0,-0x1642(%ebp)
    4ed4:	c7 85 c0 e9 ff ff 01 	movl   $0x1,-0x1640(%ebp)
    4edb:	00 00 00 
    4ede:	c7 85 c4 e9 ff ff 10 	movl   $0x10,-0x163c(%ebp)
    4ee5:	00 00 00 
    4ee8:	c7 85 c8 e9 ff ff 00 	movl   $0x0,-0x1638(%ebp)
    4eef:	00 00 00 
    4ef2:	c7 85 cc e9 ff ff 00 	movl   $0x0,-0x1634(%ebp)
    4ef9:	00 00 00 
    4efc:	c7 85 d0 e9 ff ff ff 	movl   $0xffffffff,-0x1630(%ebp)
    4f03:	ff ff ff 
    4f06:	c7 85 d4 e9 ff ff 00 	movl   $0x0,-0x162c(%ebp)
    4f0d:	00 00 00 
    4f10:	c7 85 d8 e9 ff ff 00 	movl   $0x0,-0x1628(%ebp)
    4f17:	00 00 00 
    4f1a:	8d 85 4a ea ff ff    	lea    -0x15b6(%ebp),%eax
    4f20:	89 85 dc e9 ff ff    	mov    %eax,-0x1624(%ebp)
    4f26:	c7 85 e0 e9 ff ff 1f 	movl   $0x1f,-0x1620(%ebp)
    4f2d:	00 00 00 
    4f30:	66 c7 85 e4 e9 ff ff 	movw   $0x3333,-0x161c(%ebp)
    4f37:	33 33 
    4f39:	c6 85 e6 e9 ff ff 00 	movb   $0x0,-0x161a(%ebp)
    4f40:	c7 85 e8 e9 ff ff 01 	movl   $0x1,-0x1618(%ebp)
    4f47:	00 00 00 
    4f4a:	c7 85 ec e9 ff ff 10 	movl   $0x10,-0x1614(%ebp)
    4f51:	00 00 00 
    4f54:	c7 85 f0 e9 ff ff 00 	movl   $0x0,-0x1610(%ebp)
    4f5b:	00 00 00 
    4f5e:	c7 85 f4 e9 ff ff 00 	movl   $0x0,-0x160c(%ebp)
    4f65:	00 00 00 
    4f68:	c7 85 f8 e9 ff ff ff 	movl   $0xffffffff,-0x1608(%ebp)
    4f6f:	ff ff ff 
    4f72:	c7 85 fc e9 ff ff 00 	movl   $0x0,-0x1604(%ebp)
    4f79:	00 00 00 
    4f7c:	c7 85 00 ea ff ff 00 	movl   $0x0,-0x1600(%ebp)
    4f83:	00 00 00 
    4f86:	8d 85 0c ea ff ff    	lea    -0x15f4(%ebp),%eax
    4f8c:	89 85 04 ea ff ff    	mov    %eax,-0x15fc(%ebp)
    4f92:	c7 85 08 ea ff ff 1f 	movl   $0x1f,-0x15f8(%ebp)
    4f99:	00 00 00 
		{"31", 16, 16, 13, 8191, 24, 0, 0, h24, 512},
		{"32", 1, 16, 0, 0, -1, 0, 0, hA, 31},
		{"33", 1, 16, 0, 0, -1, 0, 0, hB, 31}
	};
	ht[0] = ht[0];
}
    4f9c:	90                   	nop
    4f9d:	81 c4 40 1b 00 00    	add    $0x1b40,%esp
    4fa3:	5b                   	pop    %ebx
    4fa4:	5e                   	pop    %esi
    4fa5:	5f                   	pop    %edi
    4fa6:	5d                   	pop    %ebp
    4fa7:	c3                   	ret    

00004fa8 <huffman_decoder>:


/* ����huffman����	*/
/* ע��! ��counta,countb - 4 bit ֵ �� y����, discard x */
int huffman_decoder(struct huffcodetab *h, int *x, int *y, int *v, int *w)
{  
    4fa8:	55                   	push   %ebp
    4fa9:	89 e5                	mov    %esp,%ebp
    4fab:	83 ec 18             	sub    $0x18,%esp
  HUFFBITS level;
  int point = 0;
    4fae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int error = 1;
    4fb5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
  level     = dmask;
    4fbc:	a1 70 c8 00 00       	mov    0xc870,%eax
    4fc1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (h->val == 0) return 2;
    4fc4:	8b 45 08             	mov    0x8(%ebp),%eax
    4fc7:	8b 40 20             	mov    0x20(%eax),%eax
    4fca:	85 c0                	test   %eax,%eax
    4fcc:	75 0a                	jne    4fd8 <huffman_decoder+0x30>
    4fce:	b8 02 00 00 00       	mov    $0x2,%eax
    4fd3:	e9 1a 03 00 00       	jmp    52f2 <huffman_decoder+0x34a>

  /* table 0 ����Ҫ bits */
  if ( h->treelen == 0)
    4fd8:	8b 45 08             	mov    0x8(%ebp),%eax
    4fdb:	8b 40 24             	mov    0x24(%eax),%eax
    4fde:	85 c0                	test   %eax,%eax
    4fe0:	75 1d                	jne    4fff <huffman_decoder+0x57>
  {  *x = *y = 0;
    4fe2:	8b 45 10             	mov    0x10(%ebp),%eax
    4fe5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    4feb:	8b 45 10             	mov    0x10(%ebp),%eax
    4fee:	8b 10                	mov    (%eax),%edx
    4ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
    4ff3:	89 10                	mov    %edx,(%eax)
     return 0;
    4ff5:	b8 00 00 00 00       	mov    $0x0,%eax
    4ffa:	e9 f3 02 00 00       	jmp    52f2 <huffman_decoder+0x34a>


  /* ���� Huffman table. */

  do {
    if (h->val[point][0]==0) {   /*���Ľ�β*/
    4fff:	8b 45 08             	mov    0x8(%ebp),%eax
    5002:	8b 40 20             	mov    0x20(%eax),%eax
    5005:	8b 55 f0             	mov    -0x10(%ebp),%edx
    5008:	01 d2                	add    %edx,%edx
    500a:	01 d0                	add    %edx,%eax
    500c:	0f b6 00             	movzbl (%eax),%eax
    500f:	84 c0                	test   %al,%al
    5011:	75 46                	jne    5059 <huffman_decoder+0xb1>
      *x = h->val[point][1] >> 4;
    5013:	8b 45 08             	mov    0x8(%ebp),%eax
    5016:	8b 40 20             	mov    0x20(%eax),%eax
    5019:	8b 55 f0             	mov    -0x10(%ebp),%edx
    501c:	01 d2                	add    %edx,%edx
    501e:	01 d0                	add    %edx,%eax
    5020:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    5024:	c0 e8 04             	shr    $0x4,%al
    5027:	0f b6 d0             	movzbl %al,%edx
    502a:	8b 45 0c             	mov    0xc(%ebp),%eax
    502d:	89 10                	mov    %edx,(%eax)
      *y = h->val[point][1] & 0xf;
    502f:	8b 45 08             	mov    0x8(%ebp),%eax
    5032:	8b 40 20             	mov    0x20(%eax),%eax
    5035:	8b 55 f0             	mov    -0x10(%ebp),%edx
    5038:	01 d2                	add    %edx,%edx
    503a:	01 d0                	add    %edx,%eax
    503c:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    5040:	0f b6 c0             	movzbl %al,%eax
    5043:	83 e0 0f             	and    $0xf,%eax
    5046:	89 c2                	mov    %eax,%edx
    5048:	8b 45 10             	mov    0x10(%ebp),%eax
    504b:	89 10                	mov    %edx,(%eax)

      error = 0;
    504d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
      break;
    5054:	e9 ae 00 00 00       	jmp    5107 <huffman_decoder+0x15f>
    } 
    if (hget1bit()) {
    5059:	e8 4a e7 ff ff       	call   37a8 <hget1bit>
    505e:	85 c0                	test   %eax,%eax
    5060:	74 5d                	je     50bf <huffman_decoder+0x117>
      while (h->val[point][1] >= MXOFF) point += h->val[point][1]; 
    5062:	eb 17                	jmp    507b <huffman_decoder+0xd3>
    5064:	8b 45 08             	mov    0x8(%ebp),%eax
    5067:	8b 40 20             	mov    0x20(%eax),%eax
    506a:	8b 55 f0             	mov    -0x10(%ebp),%edx
    506d:	01 d2                	add    %edx,%edx
    506f:	01 d0                	add    %edx,%eax
    5071:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    5075:	0f b6 c0             	movzbl %al,%eax
    5078:	01 45 f0             	add    %eax,-0x10(%ebp)
    507b:	8b 45 08             	mov    0x8(%ebp),%eax
    507e:	8b 40 20             	mov    0x20(%eax),%eax
    5081:	8b 55 f0             	mov    -0x10(%ebp),%edx
    5084:	01 d2                	add    %edx,%edx
    5086:	01 d0                	add    %edx,%eax
    5088:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    508c:	3c f9                	cmp    $0xf9,%al
    508e:	77 d4                	ja     5064 <huffman_decoder+0xbc>
      point += h->val[point][1];
    5090:	8b 45 08             	mov    0x8(%ebp),%eax
    5093:	8b 40 20             	mov    0x20(%eax),%eax
    5096:	8b 55 f0             	mov    -0x10(%ebp),%edx
    5099:	01 d2                	add    %edx,%edx
    509b:	01 d0                	add    %edx,%eax
    509d:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    50a1:	0f b6 c0             	movzbl %al,%eax
    50a4:	01 45 f0             	add    %eax,-0x10(%ebp)
    50a7:	eb 40                	jmp    50e9 <huffman_decoder+0x141>
    }
    else {
      while (h->val[point][0] >= MXOFF) point += h->val[point][0]; 
    50a9:	8b 45 08             	mov    0x8(%ebp),%eax
    50ac:	8b 40 20             	mov    0x20(%eax),%eax
    50af:	8b 55 f0             	mov    -0x10(%ebp),%edx
    50b2:	01 d2                	add    %edx,%edx
    50b4:	01 d0                	add    %edx,%eax
    50b6:	0f b6 00             	movzbl (%eax),%eax
    50b9:	0f b6 c0             	movzbl %al,%eax
    50bc:	01 45 f0             	add    %eax,-0x10(%ebp)
    50bf:	8b 45 08             	mov    0x8(%ebp),%eax
    50c2:	8b 40 20             	mov    0x20(%eax),%eax
    50c5:	8b 55 f0             	mov    -0x10(%ebp),%edx
    50c8:	01 d2                	add    %edx,%edx
    50ca:	01 d0                	add    %edx,%eax
    50cc:	0f b6 00             	movzbl (%eax),%eax
    50cf:	3c f9                	cmp    $0xf9,%al
    50d1:	77 d6                	ja     50a9 <huffman_decoder+0x101>
      point += h->val[point][0];
    50d3:	8b 45 08             	mov    0x8(%ebp),%eax
    50d6:	8b 40 20             	mov    0x20(%eax),%eax
    50d9:	8b 55 f0             	mov    -0x10(%ebp),%edx
    50dc:	01 d2                	add    %edx,%edx
    50de:	01 d0                	add    %edx,%eax
    50e0:	0f b6 00             	movzbl (%eax),%eax
    50e3:	0f b6 c0             	movzbl %al,%eax
    50e6:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    level >>= 1;
    50e9:	d1 6d f4             	shrl   -0xc(%ebp)
  } while (level  || (point < ht->treelen) );
    50ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    50f0:	0f 85 09 ff ff ff    	jne    4fff <huffman_decoder+0x57>
    50f6:	8b 15 04 fc 00 00    	mov    0xfc04,%edx
    50fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    50ff:	39 c2                	cmp    %eax,%edx
    5101:	0f 87 f8 fe ff ff    	ja     4fff <huffman_decoder+0x57>
  
  /* ������ */
  
  if (error) { /* ���� x �� y Ϊһ�м�ֵ */
    5107:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    510b:	74 24                	je     5131 <huffman_decoder+0x189>
    //print(0, "Illegal Huffman code in data.\n");
    *x = ((h->xlen-1) << 1);
    510d:	8b 45 08             	mov    0x8(%ebp),%eax
    5110:	8b 40 04             	mov    0x4(%eax),%eax
    5113:	83 e8 01             	sub    $0x1,%eax
    5116:	01 c0                	add    %eax,%eax
    5118:	89 c2                	mov    %eax,%edx
    511a:	8b 45 0c             	mov    0xc(%ebp),%eax
    511d:	89 10                	mov    %edx,(%eax)
    *y = ((h->ylen-1) << 1);
    511f:	8b 45 08             	mov    0x8(%ebp),%eax
    5122:	8b 40 08             	mov    0x8(%eax),%eax
    5125:	83 e8 01             	sub    $0x1,%eax
    5128:	01 c0                	add    %eax,%eax
    512a:	89 c2                	mov    %eax,%edx
    512c:	8b 45 10             	mov    0x10(%ebp),%eax
    512f:	89 10                	mov    %edx,(%eax)
  }

  /* �����źű��� */

  if (h->tablename[0] == '3'
    5131:	8b 45 08             	mov    0x8(%ebp),%eax
    5134:	0f b6 00             	movzbl (%eax),%eax
    5137:	3c 33                	cmp    $0x33,%al
    5139:	0f 85 ef 00 00 00    	jne    522e <huffman_decoder+0x286>
      && (h->tablename[1] == '2' || h->tablename[1] == '3')) {
    513f:	8b 45 08             	mov    0x8(%ebp),%eax
    5142:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    5146:	3c 32                	cmp    $0x32,%al
    5148:	74 0f                	je     5159 <huffman_decoder+0x1b1>
    514a:	8b 45 08             	mov    0x8(%ebp),%eax
    514d:	0f b6 40 01          	movzbl 0x1(%eax),%eax
    5151:	3c 33                	cmp    $0x33,%al
    5153:	0f 85 d5 00 00 00    	jne    522e <huffman_decoder+0x286>
     *v = (*y>>3) & 1;
    5159:	8b 45 10             	mov    0x10(%ebp),%eax
    515c:	8b 00                	mov    (%eax),%eax
    515e:	c1 f8 03             	sar    $0x3,%eax
    5161:	83 e0 01             	and    $0x1,%eax
    5164:	89 c2                	mov    %eax,%edx
    5166:	8b 45 14             	mov    0x14(%ebp),%eax
    5169:	89 10                	mov    %edx,(%eax)
     *w = (*y>>2) & 1;
    516b:	8b 45 10             	mov    0x10(%ebp),%eax
    516e:	8b 00                	mov    (%eax),%eax
    5170:	c1 f8 02             	sar    $0x2,%eax
    5173:	83 e0 01             	and    $0x1,%eax
    5176:	89 c2                	mov    %eax,%edx
    5178:	8b 45 18             	mov    0x18(%ebp),%eax
    517b:	89 10                	mov    %edx,(%eax)
     *x = (*y>>1) & 1;
    517d:	8b 45 10             	mov    0x10(%ebp),%eax
    5180:	8b 00                	mov    (%eax),%eax
    5182:	d1 f8                	sar    %eax
    5184:	83 e0 01             	and    $0x1,%eax
    5187:	89 c2                	mov    %eax,%edx
    5189:	8b 45 0c             	mov    0xc(%ebp),%eax
    518c:	89 10                	mov    %edx,(%eax)
     *y = *y & 1;
    518e:	8b 45 10             	mov    0x10(%ebp),%eax
    5191:	8b 00                	mov    (%eax),%eax
    5193:	83 e0 01             	and    $0x1,%eax
    5196:	89 c2                	mov    %eax,%edx
    5198:	8b 45 10             	mov    0x10(%ebp),%eax
    519b:	89 10                	mov    %edx,(%eax)
     /* v, w, x �� y �ڱ��������ǵߵ��ģ��������� 
         */
     
/*   {int i=*v; *v=*y; *y=i; i=*w; *w=*x; *x=i;}  MI */

     if (*v)
    519d:	8b 45 14             	mov    0x14(%ebp),%eax
    51a0:	8b 00                	mov    (%eax),%eax
    51a2:	85 c0                	test   %eax,%eax
    51a4:	74 18                	je     51be <huffman_decoder+0x216>
        if (hget1bit() == 1) *v = -*v;
    51a6:	e8 fd e5 ff ff       	call   37a8 <hget1bit>
    51ab:	83 f8 01             	cmp    $0x1,%eax
    51ae:	75 0e                	jne    51be <huffman_decoder+0x216>
    51b0:	8b 45 14             	mov    0x14(%ebp),%eax
    51b3:	8b 00                	mov    (%eax),%eax
    51b5:	f7 d8                	neg    %eax
    51b7:	89 c2                	mov    %eax,%edx
    51b9:	8b 45 14             	mov    0x14(%ebp),%eax
    51bc:	89 10                	mov    %edx,(%eax)
     if (*w)
    51be:	8b 45 18             	mov    0x18(%ebp),%eax
    51c1:	8b 00                	mov    (%eax),%eax
    51c3:	85 c0                	test   %eax,%eax
    51c5:	74 18                	je     51df <huffman_decoder+0x237>
        if (hget1bit() == 1) *w = -*w;
    51c7:	e8 dc e5 ff ff       	call   37a8 <hget1bit>
    51cc:	83 f8 01             	cmp    $0x1,%eax
    51cf:	75 0e                	jne    51df <huffman_decoder+0x237>
    51d1:	8b 45 18             	mov    0x18(%ebp),%eax
    51d4:	8b 00                	mov    (%eax),%eax
    51d6:	f7 d8                	neg    %eax
    51d8:	89 c2                	mov    %eax,%edx
    51da:	8b 45 18             	mov    0x18(%ebp),%eax
    51dd:	89 10                	mov    %edx,(%eax)
     if (*x)
    51df:	8b 45 0c             	mov    0xc(%ebp),%eax
    51e2:	8b 00                	mov    (%eax),%eax
    51e4:	85 c0                	test   %eax,%eax
    51e6:	74 18                	je     5200 <huffman_decoder+0x258>
        if (hget1bit() == 1) *x = -*x;
    51e8:	e8 bb e5 ff ff       	call   37a8 <hget1bit>
    51ed:	83 f8 01             	cmp    $0x1,%eax
    51f0:	75 0e                	jne    5200 <huffman_decoder+0x258>
    51f2:	8b 45 0c             	mov    0xc(%ebp),%eax
    51f5:	8b 00                	mov    (%eax),%eax
    51f7:	f7 d8                	neg    %eax
    51f9:	89 c2                	mov    %eax,%edx
    51fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    51fe:	89 10                	mov    %edx,(%eax)
     if (*y)
    5200:	8b 45 10             	mov    0x10(%ebp),%eax
    5203:	8b 00                	mov    (%eax),%eax
    5205:	85 c0                	test   %eax,%eax
    5207:	0f 84 e1 00 00 00    	je     52ee <huffman_decoder+0x346>
        if (hget1bit() == 1) *y = -*y;
    520d:	e8 96 e5 ff ff       	call   37a8 <hget1bit>
    5212:	83 f8 01             	cmp    $0x1,%eax
    5215:	0f 85 d3 00 00 00    	jne    52ee <huffman_decoder+0x346>
    521b:	8b 45 10             	mov    0x10(%ebp),%eax
    521e:	8b 00                	mov    (%eax),%eax
    5220:	f7 d8                	neg    %eax
    5222:	89 c2                	mov    %eax,%edx
    5224:	8b 45 10             	mov    0x10(%ebp),%eax
    5227:	89 10                	mov    %edx,(%eax)
        if (hget1bit() == 1) *v = -*v;
     if (*w)
        if (hget1bit() == 1) *w = -*w;
     if (*x)
        if (hget1bit() == 1) *x = -*x;
     if (*y)
    5229:	e9 c0 00 00 00       	jmp    52ee <huffman_decoder+0x346>
  else {
  
      /* �ڲ��Ա�������x �� y�ǵߵ��� 
         ����ߵ� x �� y ʹ���Ա��������� */
    
     if (h->linbits)
    522e:	8b 45 08             	mov    0x8(%ebp),%eax
    5231:	8b 40 0c             	mov    0xc(%eax),%eax
    5234:	85 c0                	test   %eax,%eax
    5236:	74 34                	je     526c <huffman_decoder+0x2c4>
       if ((h->xlen-1) == *x) 
    5238:	8b 45 08             	mov    0x8(%ebp),%eax
    523b:	8b 40 04             	mov    0x4(%eax),%eax
    523e:	8d 50 ff             	lea    -0x1(%eax),%edx
    5241:	8b 45 0c             	mov    0xc(%ebp),%eax
    5244:	8b 00                	mov    (%eax),%eax
    5246:	39 c2                	cmp    %eax,%edx
    5248:	75 22                	jne    526c <huffman_decoder+0x2c4>
         *x += hgetbits(h->linbits);
    524a:	8b 45 08             	mov    0x8(%ebp),%eax
    524d:	8b 40 0c             	mov    0xc(%eax),%eax
    5250:	83 ec 0c             	sub    $0xc,%esp
    5253:	50                   	push   %eax
    5254:	e8 37 e5 ff ff       	call   3790 <hgetbits>
    5259:	83 c4 10             	add    $0x10,%esp
    525c:	89 c2                	mov    %eax,%edx
    525e:	8b 45 0c             	mov    0xc(%ebp),%eax
    5261:	8b 00                	mov    (%eax),%eax
    5263:	01 d0                	add    %edx,%eax
    5265:	89 c2                	mov    %eax,%edx
    5267:	8b 45 0c             	mov    0xc(%ebp),%eax
    526a:	89 10                	mov    %edx,(%eax)
     if (*x)
    526c:	8b 45 0c             	mov    0xc(%ebp),%eax
    526f:	8b 00                	mov    (%eax),%eax
    5271:	85 c0                	test   %eax,%eax
    5273:	74 18                	je     528d <huffman_decoder+0x2e5>
        if (hget1bit() == 1) *x = -*x;
    5275:	e8 2e e5 ff ff       	call   37a8 <hget1bit>
    527a:	83 f8 01             	cmp    $0x1,%eax
    527d:	75 0e                	jne    528d <huffman_decoder+0x2e5>
    527f:	8b 45 0c             	mov    0xc(%ebp),%eax
    5282:	8b 00                	mov    (%eax),%eax
    5284:	f7 d8                	neg    %eax
    5286:	89 c2                	mov    %eax,%edx
    5288:	8b 45 0c             	mov    0xc(%ebp),%eax
    528b:	89 10                	mov    %edx,(%eax)
     if (h->linbits)	  
    528d:	8b 45 08             	mov    0x8(%ebp),%eax
    5290:	8b 40 0c             	mov    0xc(%eax),%eax
    5293:	85 c0                	test   %eax,%eax
    5295:	74 34                	je     52cb <huffman_decoder+0x323>
       if ((h->ylen-1) == *y)
    5297:	8b 45 08             	mov    0x8(%ebp),%eax
    529a:	8b 40 08             	mov    0x8(%eax),%eax
    529d:	8d 50 ff             	lea    -0x1(%eax),%edx
    52a0:	8b 45 10             	mov    0x10(%ebp),%eax
    52a3:	8b 00                	mov    (%eax),%eax
    52a5:	39 c2                	cmp    %eax,%edx
    52a7:	75 22                	jne    52cb <huffman_decoder+0x323>
         *y += hgetbits(h->linbits);
    52a9:	8b 45 08             	mov    0x8(%ebp),%eax
    52ac:	8b 40 0c             	mov    0xc(%eax),%eax
    52af:	83 ec 0c             	sub    $0xc,%esp
    52b2:	50                   	push   %eax
    52b3:	e8 d8 e4 ff ff       	call   3790 <hgetbits>
    52b8:	83 c4 10             	add    $0x10,%esp
    52bb:	89 c2                	mov    %eax,%edx
    52bd:	8b 45 10             	mov    0x10(%ebp),%eax
    52c0:	8b 00                	mov    (%eax),%eax
    52c2:	01 d0                	add    %edx,%eax
    52c4:	89 c2                	mov    %eax,%edx
    52c6:	8b 45 10             	mov    0x10(%ebp),%eax
    52c9:	89 10                	mov    %edx,(%eax)
     if (*y)
    52cb:	8b 45 10             	mov    0x10(%ebp),%eax
    52ce:	8b 00                	mov    (%eax),%eax
    52d0:	85 c0                	test   %eax,%eax
    52d2:	74 1b                	je     52ef <huffman_decoder+0x347>
        if (hget1bit() == 1) *y = -*y;
    52d4:	e8 cf e4 ff ff       	call   37a8 <hget1bit>
    52d9:	83 f8 01             	cmp    $0x1,%eax
    52dc:	75 11                	jne    52ef <huffman_decoder+0x347>
    52de:	8b 45 10             	mov    0x10(%ebp),%eax
    52e1:	8b 00                	mov    (%eax),%eax
    52e3:	f7 d8                	neg    %eax
    52e5:	89 c2                	mov    %eax,%edx
    52e7:	8b 45 10             	mov    0x10(%ebp),%eax
    52ea:	89 10                	mov    %edx,(%eax)
    52ec:	eb 01                	jmp    52ef <huffman_decoder+0x347>
        if (hget1bit() == 1) *v = -*v;
     if (*w)
        if (hget1bit() == 1) *w = -*w;
     if (*x)
        if (hget1bit() == 1) *x = -*x;
     if (*y)
    52ee:	90                   	nop
         *y += hgetbits(h->linbits);
     if (*y)
        if (hget1bit() == 1) *y = -*y;
     }
	  
  return error;  
    52ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
    52f2:	c9                   	leave  
    52f3:	c3                   	ret    

000052f4 <decode_info>:
#include "common.h"
#include "decode.h"
#include "huffman.h"

void decode_info(Bit_stream_struc *bs, struct frame_params *fr_ps)
{
    52f4:	55                   	push   %ebp
    52f5:	89 e5                	mov    %esp,%ebp
    52f7:	83 ec 18             	sub    $0x18,%esp
    layer *hdr = fr_ps->header;
    52fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    52fd:	8b 00                	mov    (%eax),%eax
    52ff:	89 45 f4             	mov    %eax,-0xc(%ebp)

    hdr->version = get1bit(bs);
    5302:	83 ec 0c             	sub    $0xc,%esp
    5305:	ff 75 08             	pushl  0x8(%ebp)
    5308:	e8 0f e0 ff ff       	call   331c <get1bit>
    530d:	83 c4 10             	add    $0x10,%esp
    5310:	89 c2                	mov    %eax,%edx
    5312:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5315:	89 10                	mov    %edx,(%eax)
    hdr->lay = 4-getbits(bs,2);
    5317:	83 ec 08             	sub    $0x8,%esp
    531a:	6a 02                	push   $0x2
    531c:	ff 75 08             	pushl  0x8(%ebp)
    531f:	e8 0c e1 ff ff       	call   3430 <getbits>
    5324:	83 c4 10             	add    $0x10,%esp
    5327:	ba 04 00 00 00       	mov    $0x4,%edx
    532c:	29 c2                	sub    %eax,%edx
    532e:	89 d0                	mov    %edx,%eax
    5330:	89 c2                	mov    %eax,%edx
    5332:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5335:	89 50 04             	mov    %edx,0x4(%eax)
    hdr->error_protection = !get1bit(bs); /* ���󱣻�. TRUE/FALSE */
    5338:	83 ec 0c             	sub    $0xc,%esp
    533b:	ff 75 08             	pushl  0x8(%ebp)
    533e:	e8 d9 df ff ff       	call   331c <get1bit>
    5343:	83 c4 10             	add    $0x10,%esp
    5346:	85 c0                	test   %eax,%eax
    5348:	0f 94 c0             	sete   %al
    534b:	0f b6 d0             	movzbl %al,%edx
    534e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5351:	89 50 08             	mov    %edx,0x8(%eax)
    hdr->bitrate_index = getbits(bs,4);
    5354:	83 ec 08             	sub    $0x8,%esp
    5357:	6a 04                	push   $0x4
    5359:	ff 75 08             	pushl  0x8(%ebp)
    535c:	e8 cf e0 ff ff       	call   3430 <getbits>
    5361:	83 c4 10             	add    $0x10,%esp
    5364:	89 c2                	mov    %eax,%edx
    5366:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5369:	89 50 0c             	mov    %edx,0xc(%eax)
    hdr->sampling_frequency = getbits(bs,2);
    536c:	83 ec 08             	sub    $0x8,%esp
    536f:	6a 02                	push   $0x2
    5371:	ff 75 08             	pushl  0x8(%ebp)
    5374:	e8 b7 e0 ff ff       	call   3430 <getbits>
    5379:	83 c4 10             	add    $0x10,%esp
    537c:	89 c2                	mov    %eax,%edx
    537e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5381:	89 50 10             	mov    %edx,0x10(%eax)
    hdr->padding = get1bit(bs);
    5384:	83 ec 0c             	sub    $0xc,%esp
    5387:	ff 75 08             	pushl  0x8(%ebp)
    538a:	e8 8d df ff ff       	call   331c <get1bit>
    538f:	83 c4 10             	add    $0x10,%esp
    5392:	89 c2                	mov    %eax,%edx
    5394:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5397:	89 50 14             	mov    %edx,0x14(%eax)
    hdr->extension = get1bit(bs);
    539a:	83 ec 0c             	sub    $0xc,%esp
    539d:	ff 75 08             	pushl  0x8(%ebp)
    53a0:	e8 77 df ff ff       	call   331c <get1bit>
    53a5:	83 c4 10             	add    $0x10,%esp
    53a8:	89 c2                	mov    %eax,%edx
    53aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    53ad:	89 50 18             	mov    %edx,0x18(%eax)
    hdr->mode = getbits(bs,2);
    53b0:	83 ec 08             	sub    $0x8,%esp
    53b3:	6a 02                	push   $0x2
    53b5:	ff 75 08             	pushl  0x8(%ebp)
    53b8:	e8 73 e0 ff ff       	call   3430 <getbits>
    53bd:	83 c4 10             	add    $0x10,%esp
    53c0:	89 c2                	mov    %eax,%edx
    53c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    53c5:	89 50 1c             	mov    %edx,0x1c(%eax)
    hdr->mode_ext = getbits(bs,2);
    53c8:	83 ec 08             	sub    $0x8,%esp
    53cb:	6a 02                	push   $0x2
    53cd:	ff 75 08             	pushl  0x8(%ebp)
    53d0:	e8 5b e0 ff ff       	call   3430 <getbits>
    53d5:	83 c4 10             	add    $0x10,%esp
    53d8:	89 c2                	mov    %eax,%edx
    53da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    53dd:	89 50 20             	mov    %edx,0x20(%eax)
    hdr->copyright = get1bit(bs);
    53e0:	83 ec 0c             	sub    $0xc,%esp
    53e3:	ff 75 08             	pushl  0x8(%ebp)
    53e6:	e8 31 df ff ff       	call   331c <get1bit>
    53eb:	83 c4 10             	add    $0x10,%esp
    53ee:	89 c2                	mov    %eax,%edx
    53f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    53f3:	89 50 24             	mov    %edx,0x24(%eax)
    hdr->original = get1bit(bs);
    53f6:	83 ec 0c             	sub    $0xc,%esp
    53f9:	ff 75 08             	pushl  0x8(%ebp)
    53fc:	e8 1b df ff ff       	call   331c <get1bit>
    5401:	83 c4 10             	add    $0x10,%esp
    5404:	89 c2                	mov    %eax,%edx
    5406:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5409:	89 50 28             	mov    %edx,0x28(%eax)
    hdr->emphasis = getbits(bs,2);
    540c:	83 ec 08             	sub    $0x8,%esp
    540f:	6a 02                	push   $0x2
    5411:	ff 75 08             	pushl  0x8(%ebp)
    5414:	e8 17 e0 ff ff       	call   3430 <getbits>
    5419:	83 c4 10             	add    $0x10,%esp
    541c:	89 c2                	mov    %eax,%edx
    541e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5421:	89 50 2c             	mov    %edx,0x2c(%eax)
}
    5424:	90                   	nop
    5425:	c9                   	leave  
    5426:	c3                   	ret    

00005427 <III_get_side_info>:

void III_get_side_info(Bit_stream_struc *bs, struct III_side_info_t *si, struct frame_params *fr_ps)
{
    5427:	55                   	push   %ebp
    5428:	89 e5                	mov    %esp,%ebp
    542a:	56                   	push   %esi
    542b:	53                   	push   %ebx
    542c:	83 ec 10             	sub    $0x10,%esp
	int ch, gr, i;
	int stereo = fr_ps->stereo;
    542f:	8b 45 10             	mov    0x10(%ebp),%eax
    5432:	8b 40 08             	mov    0x8(%eax),%eax
    5435:	89 45 e8             	mov    %eax,-0x18(%ebp)

	si->main_data_begin = getbits(bs, 9);
    5438:	83 ec 08             	sub    $0x8,%esp
    543b:	6a 09                	push   $0x9
    543d:	ff 75 08             	pushl  0x8(%ebp)
    5440:	e8 eb df ff ff       	call   3430 <getbits>
    5445:	83 c4 10             	add    $0x10,%esp
    5448:	89 c2                	mov    %eax,%edx
    544a:	8b 45 0c             	mov    0xc(%ebp),%eax
    544d:	89 10                	mov    %edx,(%eax)
	if (stereo == 1)
    544f:	83 7d e8 01          	cmpl   $0x1,-0x18(%ebp)
    5453:	75 1a                	jne    546f <III_get_side_info+0x48>
		si->private_bits = getbits(bs,5);
    5455:	83 ec 08             	sub    $0x8,%esp
    5458:	6a 05                	push   $0x5
    545a:	ff 75 08             	pushl  0x8(%ebp)
    545d:	e8 ce df ff ff       	call   3430 <getbits>
    5462:	83 c4 10             	add    $0x10,%esp
    5465:	89 c2                	mov    %eax,%edx
    5467:	8b 45 0c             	mov    0xc(%ebp),%eax
    546a:	89 50 04             	mov    %edx,0x4(%eax)
    546d:	eb 18                	jmp    5487 <III_get_side_info+0x60>
	else
		si->private_bits = getbits(bs,3);
    546f:	83 ec 08             	sub    $0x8,%esp
    5472:	6a 03                	push   $0x3
    5474:	ff 75 08             	pushl  0x8(%ebp)
    5477:	e8 b4 df ff ff       	call   3430 <getbits>
    547c:	83 c4 10             	add    $0x10,%esp
    547f:	89 c2                	mov    %eax,%edx
    5481:	8b 45 0c             	mov    0xc(%ebp),%eax
    5484:	89 50 04             	mov    %edx,0x4(%eax)

	for (ch=0; ch<stereo; ch++)
    5487:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    548e:	eb 40                	jmp    54d0 <III_get_side_info+0xa9>
		for (i=0; i<4; i++)
    5490:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    5497:	eb 2d                	jmp    54c6 <III_get_side_info+0x9f>
			si->ch[ch].scfsi[i] = get1bit(bs);
    5499:	83 ec 0c             	sub    $0xc,%esp
    549c:	ff 75 08             	pushl  0x8(%ebp)
    549f:	e8 78 de ff ff       	call   331c <get1bit>
    54a4:	83 c4 10             	add    $0x10,%esp
    54a7:	89 c3                	mov    %eax,%ebx
    54a9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    54ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
    54af:	89 d0                	mov    %edx,%eax
    54b1:	c1 e0 02             	shl    $0x2,%eax
    54b4:	01 d0                	add    %edx,%eax
    54b6:	c1 e0 03             	shl    $0x3,%eax
    54b9:	8b 55 ec             	mov    -0x14(%ebp),%edx
    54bc:	01 d0                	add    %edx,%eax
    54be:	89 5c 81 08          	mov    %ebx,0x8(%ecx,%eax,4)
		si->private_bits = getbits(bs,5);
	else
		si->private_bits = getbits(bs,3);

	for (ch=0; ch<stereo; ch++)
		for (i=0; i<4; i++)
    54c2:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    54c6:	83 7d ec 03          	cmpl   $0x3,-0x14(%ebp)
    54ca:	7e cd                	jle    5499 <III_get_side_info+0x72>
	if (stereo == 1)
		si->private_bits = getbits(bs,5);
	else
		si->private_bits = getbits(bs,3);

	for (ch=0; ch<stereo; ch++)
    54cc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    54d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    54d3:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    54d6:	7c b8                	jl     5490 <III_get_side_info+0x69>
		for (i=0; i<4; i++)
			si->ch[ch].scfsi[i] = get1bit(bs);

	for (gr=0; gr<2; gr++) {
    54d8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    54df:	e9 b6 05 00 00       	jmp    5a9a <III_get_side_info+0x673>
		for (ch=0; ch<stereo; ch++) {
    54e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    54eb:	e9 9a 05 00 00       	jmp    5a8a <III_get_side_info+0x663>
			si->ch[ch].gr[gr].part2_3_length = getbits(bs, 12);
    54f0:	83 ec 08             	sub    $0x8,%esp
    54f3:	6a 0c                	push   $0xc
    54f5:	ff 75 08             	pushl  0x8(%ebp)
    54f8:	e8 33 df ff ff       	call   3430 <getbits>
    54fd:	83 c4 10             	add    $0x10,%esp
    5500:	89 c6                	mov    %eax,%esi
    5502:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5505:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5508:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    550b:	89 c2                	mov    %eax,%edx
    550d:	c1 e2 03             	shl    $0x3,%edx
    5510:	01 c2                	add    %eax,%edx
    5512:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5519:	89 c2                	mov    %eax,%edx
    551b:	89 c8                	mov    %ecx,%eax
    551d:	c1 e0 02             	shl    $0x2,%eax
    5520:	01 c8                	add    %ecx,%eax
    5522:	c1 e0 05             	shl    $0x5,%eax
    5525:	01 d0                	add    %edx,%eax
    5527:	01 d8                	add    %ebx,%eax
    5529:	83 c0 18             	add    $0x18,%eax
    552c:	89 30                	mov    %esi,(%eax)
			si->ch[ch].gr[gr].big_values = getbits(bs, 9);
    552e:	83 ec 08             	sub    $0x8,%esp
    5531:	6a 09                	push   $0x9
    5533:	ff 75 08             	pushl  0x8(%ebp)
    5536:	e8 f5 de ff ff       	call   3430 <getbits>
    553b:	83 c4 10             	add    $0x10,%esp
    553e:	89 c6                	mov    %eax,%esi
    5540:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5543:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5546:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5549:	89 c2                	mov    %eax,%edx
    554b:	c1 e2 03             	shl    $0x3,%edx
    554e:	01 c2                	add    %eax,%edx
    5550:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5557:	89 c2                	mov    %eax,%edx
    5559:	89 c8                	mov    %ecx,%eax
    555b:	c1 e0 02             	shl    $0x2,%eax
    555e:	01 c8                	add    %ecx,%eax
    5560:	c1 e0 05             	shl    $0x5,%eax
    5563:	01 d0                	add    %edx,%eax
    5565:	01 d8                	add    %ebx,%eax
    5567:	83 c0 1c             	add    $0x1c,%eax
    556a:	89 30                	mov    %esi,(%eax)
			si->ch[ch].gr[gr].global_gain = getbits(bs, 8);
    556c:	83 ec 08             	sub    $0x8,%esp
    556f:	6a 08                	push   $0x8
    5571:	ff 75 08             	pushl  0x8(%ebp)
    5574:	e8 b7 de ff ff       	call   3430 <getbits>
    5579:	83 c4 10             	add    $0x10,%esp
    557c:	89 c6                	mov    %eax,%esi
    557e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5581:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5584:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5587:	89 c2                	mov    %eax,%edx
    5589:	c1 e2 03             	shl    $0x3,%edx
    558c:	01 c2                	add    %eax,%edx
    558e:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5595:	89 c2                	mov    %eax,%edx
    5597:	89 c8                	mov    %ecx,%eax
    5599:	c1 e0 02             	shl    $0x2,%eax
    559c:	01 c8                	add    %ecx,%eax
    559e:	c1 e0 05             	shl    $0x5,%eax
    55a1:	01 d0                	add    %edx,%eax
    55a3:	01 d8                	add    %ebx,%eax
    55a5:	83 c0 20             	add    $0x20,%eax
    55a8:	89 30                	mov    %esi,(%eax)
			si->ch[ch].gr[gr].scalefac_compress = getbits(bs, 4);
    55aa:	83 ec 08             	sub    $0x8,%esp
    55ad:	6a 04                	push   $0x4
    55af:	ff 75 08             	pushl  0x8(%ebp)
    55b2:	e8 79 de ff ff       	call   3430 <getbits>
    55b7:	83 c4 10             	add    $0x10,%esp
    55ba:	89 c6                	mov    %eax,%esi
    55bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    55bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    55c2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    55c5:	89 c2                	mov    %eax,%edx
    55c7:	c1 e2 03             	shl    $0x3,%edx
    55ca:	01 c2                	add    %eax,%edx
    55cc:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    55d3:	89 c2                	mov    %eax,%edx
    55d5:	89 c8                	mov    %ecx,%eax
    55d7:	c1 e0 02             	shl    $0x2,%eax
    55da:	01 c8                	add    %ecx,%eax
    55dc:	c1 e0 05             	shl    $0x5,%eax
    55df:	01 d0                	add    %edx,%eax
    55e1:	01 d8                	add    %ebx,%eax
    55e3:	83 c0 24             	add    $0x24,%eax
    55e6:	89 30                	mov    %esi,(%eax)
			si->ch[ch].gr[gr].window_switching_flag = get1bit(bs);
    55e8:	83 ec 0c             	sub    $0xc,%esp
    55eb:	ff 75 08             	pushl  0x8(%ebp)
    55ee:	e8 29 dd ff ff       	call   331c <get1bit>
    55f3:	83 c4 10             	add    $0x10,%esp
    55f6:	89 c6                	mov    %eax,%esi
    55f8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    55fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    55fe:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5601:	89 c2                	mov    %eax,%edx
    5603:	c1 e2 03             	shl    $0x3,%edx
    5606:	01 c2                	add    %eax,%edx
    5608:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    560f:	89 c2                	mov    %eax,%edx
    5611:	89 c8                	mov    %ecx,%eax
    5613:	c1 e0 02             	shl    $0x2,%eax
    5616:	01 c8                	add    %ecx,%eax
    5618:	c1 e0 05             	shl    $0x5,%eax
    561b:	01 d0                	add    %edx,%eax
    561d:	01 d8                	add    %ebx,%eax
    561f:	83 c0 28             	add    $0x28,%eax
    5622:	89 30                	mov    %esi,(%eax)
			if (si->ch[ch].gr[gr].window_switching_flag) {
    5624:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5627:	8b 45 f0             	mov    -0x10(%ebp),%eax
    562a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    562d:	89 c2                	mov    %eax,%edx
    562f:	c1 e2 03             	shl    $0x3,%edx
    5632:	01 c2                	add    %eax,%edx
    5634:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    563b:	89 c2                	mov    %eax,%edx
    563d:	89 c8                	mov    %ecx,%eax
    563f:	c1 e0 02             	shl    $0x2,%eax
    5642:	01 c8                	add    %ecx,%eax
    5644:	c1 e0 05             	shl    $0x5,%eax
    5647:	01 d0                	add    %edx,%eax
    5649:	01 d8                	add    %ebx,%eax
    564b:	83 c0 28             	add    $0x28,%eax
    564e:	8b 00                	mov    (%eax),%eax
    5650:	85 c0                	test   %eax,%eax
    5652:	0f 84 7c 02 00 00    	je     58d4 <III_get_side_info+0x4ad>
				si->ch[ch].gr[gr].block_type = getbits(bs, 2);
    5658:	83 ec 08             	sub    $0x8,%esp
    565b:	6a 02                	push   $0x2
    565d:	ff 75 08             	pushl  0x8(%ebp)
    5660:	e8 cb dd ff ff       	call   3430 <getbits>
    5665:	83 c4 10             	add    $0x10,%esp
    5668:	89 c6                	mov    %eax,%esi
    566a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    566d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5670:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5673:	89 c2                	mov    %eax,%edx
    5675:	c1 e2 03             	shl    $0x3,%edx
    5678:	01 c2                	add    %eax,%edx
    567a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5681:	89 c2                	mov    %eax,%edx
    5683:	89 c8                	mov    %ecx,%eax
    5685:	c1 e0 02             	shl    $0x2,%eax
    5688:	01 c8                	add    %ecx,%eax
    568a:	c1 e0 05             	shl    $0x5,%eax
    568d:	01 d0                	add    %edx,%eax
    568f:	01 d8                	add    %ebx,%eax
    5691:	83 c0 2c             	add    $0x2c,%eax
    5694:	89 30                	mov    %esi,(%eax)
				si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
    5696:	83 ec 0c             	sub    $0xc,%esp
    5699:	ff 75 08             	pushl  0x8(%ebp)
    569c:	e8 7b dc ff ff       	call   331c <get1bit>
    56a1:	83 c4 10             	add    $0x10,%esp
    56a4:	89 c6                	mov    %eax,%esi
    56a6:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    56a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    56ac:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    56af:	89 c2                	mov    %eax,%edx
    56b1:	c1 e2 03             	shl    $0x3,%edx
    56b4:	01 c2                	add    %eax,%edx
    56b6:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    56bd:	89 c2                	mov    %eax,%edx
    56bf:	89 c8                	mov    %ecx,%eax
    56c1:	c1 e0 02             	shl    $0x2,%eax
    56c4:	01 c8                	add    %ecx,%eax
    56c6:	c1 e0 05             	shl    $0x5,%eax
    56c9:	01 d0                	add    %edx,%eax
    56cb:	01 d8                	add    %ebx,%eax
    56cd:	83 c0 30             	add    $0x30,%eax
    56d0:	89 30                	mov    %esi,(%eax)
				for (i=0; i<2; i++)
    56d2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    56d9:	eb 43                	jmp    571e <III_get_side_info+0x2f7>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
    56db:	83 ec 08             	sub    $0x8,%esp
    56de:	6a 05                	push   $0x5
    56e0:	ff 75 08             	pushl  0x8(%ebp)
    56e3:	e8 48 dd ff ff       	call   3430 <getbits>
    56e8:	83 c4 10             	add    $0x10,%esp
    56eb:	89 c6                	mov    %eax,%esi
    56ed:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    56f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    56f3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    56f6:	89 c2                	mov    %eax,%edx
    56f8:	c1 e2 03             	shl    $0x3,%edx
    56fb:	01 c2                	add    %eax,%edx
    56fd:	8d 04 12             	lea    (%edx,%edx,1),%eax
    5700:	89 c2                	mov    %eax,%edx
    5702:	89 c8                	mov    %ecx,%eax
    5704:	c1 e0 02             	shl    $0x2,%eax
    5707:	01 c8                	add    %ecx,%eax
    5709:	c1 e0 03             	shl    $0x3,%eax
    570c:	01 c2                	add    %eax,%edx
    570e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    5711:	01 d0                	add    %edx,%eax
    5713:	83 c0 08             	add    $0x8,%eax
    5716:	89 74 83 14          	mov    %esi,0x14(%ebx,%eax,4)
			si->ch[ch].gr[gr].scalefac_compress = getbits(bs, 4);
			si->ch[ch].gr[gr].window_switching_flag = get1bit(bs);
			if (si->ch[ch].gr[gr].window_switching_flag) {
				si->ch[ch].gr[gr].block_type = getbits(bs, 2);
				si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
				for (i=0; i<2; i++)
    571a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    571e:	83 7d ec 01          	cmpl   $0x1,-0x14(%ebp)
    5722:	7e b7                	jle    56db <III_get_side_info+0x2b4>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
				for (i=0; i<3; i++)
    5724:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    572b:	eb 43                	jmp    5770 <III_get_side_info+0x349>
					si->ch[ch].gr[gr].subblock_gain[i] = getbits(bs, 3);
    572d:	83 ec 08             	sub    $0x8,%esp
    5730:	6a 03                	push   $0x3
    5732:	ff 75 08             	pushl  0x8(%ebp)
    5735:	e8 f6 dc ff ff       	call   3430 <getbits>
    573a:	83 c4 10             	add    $0x10,%esp
    573d:	89 c6                	mov    %eax,%esi
    573f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5742:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5745:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5748:	89 c2                	mov    %eax,%edx
    574a:	c1 e2 03             	shl    $0x3,%edx
    574d:	01 c2                	add    %eax,%edx
    574f:	8d 04 12             	lea    (%edx,%edx,1),%eax
    5752:	89 c2                	mov    %eax,%edx
    5754:	89 c8                	mov    %ecx,%eax
    5756:	c1 e0 02             	shl    $0x2,%eax
    5759:	01 c8                	add    %ecx,%eax
    575b:	c1 e0 03             	shl    $0x3,%eax
    575e:	01 c2                	add    %eax,%edx
    5760:	8b 45 ec             	mov    -0x14(%ebp),%eax
    5763:	01 d0                	add    %edx,%eax
    5765:	83 c0 0c             	add    $0xc,%eax
    5768:	89 74 83 10          	mov    %esi,0x10(%ebx,%eax,4)
			if (si->ch[ch].gr[gr].window_switching_flag) {
				si->ch[ch].gr[gr].block_type = getbits(bs, 2);
				si->ch[ch].gr[gr].mixed_block_flag = get1bit(bs);
				for (i=0; i<2; i++)
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
				for (i=0; i<3; i++)
    576c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5770:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    5774:	7e b7                	jle    572d <III_get_side_info+0x306>
					si->ch[ch].gr[gr].subblock_gain[i] = getbits(bs, 3);

				/* Set region_count parameters since they are implicit in this case. */

				if (si->ch[ch].gr[gr].block_type == 0) {
    5776:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5779:	8b 45 f0             	mov    -0x10(%ebp),%eax
    577c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    577f:	89 c2                	mov    %eax,%edx
    5781:	c1 e2 03             	shl    $0x3,%edx
    5784:	01 c2                	add    %eax,%edx
    5786:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    578d:	89 c2                	mov    %eax,%edx
    578f:	89 c8                	mov    %ecx,%eax
    5791:	c1 e0 02             	shl    $0x2,%eax
    5794:	01 c8                	add    %ecx,%eax
    5796:	c1 e0 05             	shl    $0x5,%eax
    5799:	01 d0                	add    %edx,%eax
    579b:	01 d8                	add    %ebx,%eax
    579d:	83 c0 2c             	add    $0x2c,%eax
    57a0:	8b 00                	mov    (%eax),%eax
    57a2:	85 c0                	test   %eax,%eax
    57a4:	75 05                	jne    57ab <III_get_side_info+0x384>
					//printf("Side info bad: block_type == 0 in split block.\n");
					exit();
    57a6:	e8 68 cc ff ff       	call   2413 <exit>
				}
				else if (si->ch[ch].gr[gr].block_type == 2
    57ab:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    57ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
    57b1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    57b4:	89 c2                	mov    %eax,%edx
    57b6:	c1 e2 03             	shl    $0x3,%edx
    57b9:	01 c2                	add    %eax,%edx
    57bb:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    57c2:	89 c2                	mov    %eax,%edx
    57c4:	89 c8                	mov    %ecx,%eax
    57c6:	c1 e0 02             	shl    $0x2,%eax
    57c9:	01 c8                	add    %ecx,%eax
    57cb:	c1 e0 05             	shl    $0x5,%eax
    57ce:	01 d0                	add    %edx,%eax
    57d0:	01 d8                	add    %ebx,%eax
    57d2:	83 c0 2c             	add    $0x2c,%eax
    57d5:	8b 00                	mov    (%eax),%eax
    57d7:	83 f8 02             	cmp    $0x2,%eax
    57da:	75 62                	jne    583e <III_get_side_info+0x417>
						&& si->ch[ch].gr[gr].mixed_block_flag == 0)
    57dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    57df:	8b 45 f0             	mov    -0x10(%ebp),%eax
    57e2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    57e5:	89 c2                	mov    %eax,%edx
    57e7:	c1 e2 03             	shl    $0x3,%edx
    57ea:	01 c2                	add    %eax,%edx
    57ec:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    57f3:	89 c2                	mov    %eax,%edx
    57f5:	89 c8                	mov    %ecx,%eax
    57f7:	c1 e0 02             	shl    $0x2,%eax
    57fa:	01 c8                	add    %ecx,%eax
    57fc:	c1 e0 05             	shl    $0x5,%eax
    57ff:	01 d0                	add    %edx,%eax
    5801:	01 d8                	add    %ebx,%eax
    5803:	83 c0 30             	add    $0x30,%eax
    5806:	8b 00                	mov    (%eax),%eax
    5808:	85 c0                	test   %eax,%eax
    580a:	75 32                	jne    583e <III_get_side_info+0x417>
					si->ch[ch].gr[gr].region0_count = 8; /* MI 9; */
    580c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    580f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5812:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5815:	89 c2                	mov    %eax,%edx
    5817:	c1 e2 03             	shl    $0x3,%edx
    581a:	01 c2                	add    %eax,%edx
    581c:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5823:	89 c2                	mov    %eax,%edx
    5825:	89 c8                	mov    %ecx,%eax
    5827:	c1 e0 02             	shl    $0x2,%eax
    582a:	01 c8                	add    %ecx,%eax
    582c:	c1 e0 05             	shl    $0x5,%eax
    582f:	01 d0                	add    %edx,%eax
    5831:	01 d8                	add    %ebx,%eax
    5833:	83 c0 4c             	add    $0x4c,%eax
    5836:	c7 00 08 00 00 00    	movl   $0x8,(%eax)
    583c:	eb 30                	jmp    586e <III_get_side_info+0x447>
				else si->ch[ch].gr[gr].region0_count = 7; /* MI 8; */
    583e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5841:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5844:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5847:	89 c2                	mov    %eax,%edx
    5849:	c1 e2 03             	shl    $0x3,%edx
    584c:	01 c2                	add    %eax,%edx
    584e:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5855:	89 c2                	mov    %eax,%edx
    5857:	89 c8                	mov    %ecx,%eax
    5859:	c1 e0 02             	shl    $0x2,%eax
    585c:	01 c8                	add    %ecx,%eax
    585e:	c1 e0 05             	shl    $0x5,%eax
    5861:	01 d0                	add    %edx,%eax
    5863:	01 d8                	add    %ebx,%eax
    5865:	83 c0 4c             	add    $0x4c,%eax
    5868:	c7 00 07 00 00 00    	movl   $0x7,(%eax)
					si->ch[ch].gr[gr].region1_count = 20 - si->ch[ch].gr[gr].region0_count;
    586e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5871:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5874:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5877:	89 c2                	mov    %eax,%edx
    5879:	c1 e2 03             	shl    $0x3,%edx
    587c:	01 c2                	add    %eax,%edx
    587e:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5885:	89 c2                	mov    %eax,%edx
    5887:	89 c8                	mov    %ecx,%eax
    5889:	c1 e0 02             	shl    $0x2,%eax
    588c:	01 c8                	add    %ecx,%eax
    588e:	c1 e0 05             	shl    $0x5,%eax
    5891:	01 d0                	add    %edx,%eax
    5893:	01 d8                	add    %ebx,%eax
    5895:	83 c0 4c             	add    $0x4c,%eax
    5898:	8b 00                	mov    (%eax),%eax
    589a:	ba 14 00 00 00       	mov    $0x14,%edx
    589f:	89 d3                	mov    %edx,%ebx
    58a1:	29 c3                	sub    %eax,%ebx
    58a3:	8b 75 0c             	mov    0xc(%ebp),%esi
    58a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    58a9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    58ac:	89 c2                	mov    %eax,%edx
    58ae:	c1 e2 03             	shl    $0x3,%edx
    58b1:	01 c2                	add    %eax,%edx
    58b3:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    58ba:	89 c2                	mov    %eax,%edx
    58bc:	89 c8                	mov    %ecx,%eax
    58be:	c1 e0 02             	shl    $0x2,%eax
    58c1:	01 c8                	add    %ecx,%eax
    58c3:	c1 e0 05             	shl    $0x5,%eax
    58c6:	01 d0                	add    %edx,%eax
    58c8:	01 f0                	add    %esi,%eax
    58ca:	83 c0 50             	add    $0x50,%eax
    58cd:	89 18                	mov    %ebx,(%eax)
    58cf:	e9 fe 00 00 00       	jmp    59d2 <III_get_side_info+0x5ab>
			}
			else {
				for (i=0; i<3; i++)
    58d4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    58db:	eb 43                	jmp    5920 <III_get_side_info+0x4f9>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
    58dd:	83 ec 08             	sub    $0x8,%esp
    58e0:	6a 05                	push   $0x5
    58e2:	ff 75 08             	pushl  0x8(%ebp)
    58e5:	e8 46 db ff ff       	call   3430 <getbits>
    58ea:	83 c4 10             	add    $0x10,%esp
    58ed:	89 c6                	mov    %eax,%esi
    58ef:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    58f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    58f5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    58f8:	89 c2                	mov    %eax,%edx
    58fa:	c1 e2 03             	shl    $0x3,%edx
    58fd:	01 c2                	add    %eax,%edx
    58ff:	8d 04 12             	lea    (%edx,%edx,1),%eax
    5902:	89 c2                	mov    %eax,%edx
    5904:	89 c8                	mov    %ecx,%eax
    5906:	c1 e0 02             	shl    $0x2,%eax
    5909:	01 c8                	add    %ecx,%eax
    590b:	c1 e0 03             	shl    $0x3,%eax
    590e:	01 c2                	add    %eax,%edx
    5910:	8b 45 ec             	mov    -0x14(%ebp),%eax
    5913:	01 d0                	add    %edx,%eax
    5915:	83 c0 08             	add    $0x8,%eax
    5918:	89 74 83 14          	mov    %esi,0x14(%ebx,%eax,4)
					si->ch[ch].gr[gr].region0_count = 8; /* MI 9; */
				else si->ch[ch].gr[gr].region0_count = 7; /* MI 8; */
					si->ch[ch].gr[gr].region1_count = 20 - si->ch[ch].gr[gr].region0_count;
			}
			else {
				for (i=0; i<3; i++)
    591c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5920:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    5924:	7e b7                	jle    58dd <III_get_side_info+0x4b6>
					si->ch[ch].gr[gr].table_select[i] = getbits(bs, 5);
				si->ch[ch].gr[gr].region0_count = getbits(bs, 4);
    5926:	83 ec 08             	sub    $0x8,%esp
    5929:	6a 04                	push   $0x4
    592b:	ff 75 08             	pushl  0x8(%ebp)
    592e:	e8 fd da ff ff       	call   3430 <getbits>
    5933:	83 c4 10             	add    $0x10,%esp
    5936:	89 c6                	mov    %eax,%esi
    5938:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    593b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    593e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5941:	89 c2                	mov    %eax,%edx
    5943:	c1 e2 03             	shl    $0x3,%edx
    5946:	01 c2                	add    %eax,%edx
    5948:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    594f:	89 c2                	mov    %eax,%edx
    5951:	89 c8                	mov    %ecx,%eax
    5953:	c1 e0 02             	shl    $0x2,%eax
    5956:	01 c8                	add    %ecx,%eax
    5958:	c1 e0 05             	shl    $0x5,%eax
    595b:	01 d0                	add    %edx,%eax
    595d:	01 d8                	add    %ebx,%eax
    595f:	83 c0 4c             	add    $0x4c,%eax
    5962:	89 30                	mov    %esi,(%eax)
				si->ch[ch].gr[gr].region1_count = getbits(bs, 3);
    5964:	83 ec 08             	sub    $0x8,%esp
    5967:	6a 03                	push   $0x3
    5969:	ff 75 08             	pushl  0x8(%ebp)
    596c:	e8 bf da ff ff       	call   3430 <getbits>
    5971:	83 c4 10             	add    $0x10,%esp
    5974:	89 c6                	mov    %eax,%esi
    5976:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5979:	8b 45 f0             	mov    -0x10(%ebp),%eax
    597c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    597f:	89 c2                	mov    %eax,%edx
    5981:	c1 e2 03             	shl    $0x3,%edx
    5984:	01 c2                	add    %eax,%edx
    5986:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    598d:	89 c2                	mov    %eax,%edx
    598f:	89 c8                	mov    %ecx,%eax
    5991:	c1 e0 02             	shl    $0x2,%eax
    5994:	01 c8                	add    %ecx,%eax
    5996:	c1 e0 05             	shl    $0x5,%eax
    5999:	01 d0                	add    %edx,%eax
    599b:	01 d8                	add    %ebx,%eax
    599d:	83 c0 50             	add    $0x50,%eax
    59a0:	89 30                	mov    %esi,(%eax)
				si->ch[ch].gr[gr].block_type = 0;
    59a2:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    59a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    59a8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    59ab:	89 c2                	mov    %eax,%edx
    59ad:	c1 e2 03             	shl    $0x3,%edx
    59b0:	01 c2                	add    %eax,%edx
    59b2:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    59b9:	89 c2                	mov    %eax,%edx
    59bb:	89 c8                	mov    %ecx,%eax
    59bd:	c1 e0 02             	shl    $0x2,%eax
    59c0:	01 c8                	add    %ecx,%eax
    59c2:	c1 e0 05             	shl    $0x5,%eax
    59c5:	01 d0                	add    %edx,%eax
    59c7:	01 d8                	add    %ebx,%eax
    59c9:	83 c0 2c             	add    $0x2c,%eax
    59cc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
			}
			si->ch[ch].gr[gr].preflag = get1bit(bs);
    59d2:	83 ec 0c             	sub    $0xc,%esp
    59d5:	ff 75 08             	pushl  0x8(%ebp)
    59d8:	e8 3f d9 ff ff       	call   331c <get1bit>
    59dd:	83 c4 10             	add    $0x10,%esp
    59e0:	89 c6                	mov    %eax,%esi
    59e2:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    59e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    59e8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    59eb:	89 c2                	mov    %eax,%edx
    59ed:	c1 e2 03             	shl    $0x3,%edx
    59f0:	01 c2                	add    %eax,%edx
    59f2:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    59f9:	89 c2                	mov    %eax,%edx
    59fb:	89 c8                	mov    %ecx,%eax
    59fd:	c1 e0 02             	shl    $0x2,%eax
    5a00:	01 c8                	add    %ecx,%eax
    5a02:	c1 e0 05             	shl    $0x5,%eax
    5a05:	01 d0                	add    %edx,%eax
    5a07:	01 d8                	add    %ebx,%eax
    5a09:	83 c0 54             	add    $0x54,%eax
    5a0c:	89 30                	mov    %esi,(%eax)
			si->ch[ch].gr[gr].scalefac_scale = get1bit(bs);
    5a0e:	83 ec 0c             	sub    $0xc,%esp
    5a11:	ff 75 08             	pushl  0x8(%ebp)
    5a14:	e8 03 d9 ff ff       	call   331c <get1bit>
    5a19:	83 c4 10             	add    $0x10,%esp
    5a1c:	89 c6                	mov    %eax,%esi
    5a1e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5a21:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5a24:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5a27:	89 c2                	mov    %eax,%edx
    5a29:	c1 e2 03             	shl    $0x3,%edx
    5a2c:	01 c2                	add    %eax,%edx
    5a2e:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5a35:	89 c2                	mov    %eax,%edx
    5a37:	89 c8                	mov    %ecx,%eax
    5a39:	c1 e0 02             	shl    $0x2,%eax
    5a3c:	01 c8                	add    %ecx,%eax
    5a3e:	c1 e0 05             	shl    $0x5,%eax
    5a41:	01 d0                	add    %edx,%eax
    5a43:	01 d8                	add    %ebx,%eax
    5a45:	83 c0 58             	add    $0x58,%eax
    5a48:	89 30                	mov    %esi,(%eax)
			si->ch[ch].gr[gr].count1table_select = get1bit(bs);
    5a4a:	83 ec 0c             	sub    $0xc,%esp
    5a4d:	ff 75 08             	pushl  0x8(%ebp)
    5a50:	e8 c7 d8 ff ff       	call   331c <get1bit>
    5a55:	83 c4 10             	add    $0x10,%esp
    5a58:	89 c6                	mov    %eax,%esi
    5a5a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5a5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5a60:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    5a63:	89 c2                	mov    %eax,%edx
    5a65:	c1 e2 03             	shl    $0x3,%edx
    5a68:	01 c2                	add    %eax,%edx
    5a6a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5a71:	89 c2                	mov    %eax,%edx
    5a73:	89 c8                	mov    %ecx,%eax
    5a75:	c1 e0 02             	shl    $0x2,%eax
    5a78:	01 c8                	add    %ecx,%eax
    5a7a:	c1 e0 05             	shl    $0x5,%eax
    5a7d:	01 d0                	add    %edx,%eax
    5a7f:	01 d8                	add    %ebx,%eax
    5a81:	83 c0 5c             	add    $0x5c,%eax
    5a84:	89 30                	mov    %esi,(%eax)
	for (ch=0; ch<stereo; ch++)
		for (i=0; i<4; i++)
			si->ch[ch].scfsi[i] = get1bit(bs);

	for (gr=0; gr<2; gr++) {
		for (ch=0; ch<stereo; ch++) {
    5a86:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    5a8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5a8d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    5a90:	0f 8c 5a fa ff ff    	jl     54f0 <III_get_side_info+0xc9>

	for (ch=0; ch<stereo; ch++)
		for (i=0; i<4; i++)
			si->ch[ch].scfsi[i] = get1bit(bs);

	for (gr=0; gr<2; gr++) {
    5a96:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    5a9a:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    5a9e:	0f 8e 40 fa ff ff    	jle    54e4 <III_get_side_info+0xbd>
			si->ch[ch].gr[gr].preflag = get1bit(bs);
			si->ch[ch].gr[gr].scalefac_scale = get1bit(bs);
			si->ch[ch].gr[gr].count1table_select = get1bit(bs);
         }
	}
}
    5aa4:	90                   	nop
    5aa5:	8d 65 f8             	lea    -0x8(%ebp),%esp
    5aa8:	5b                   	pop    %ebx
    5aa9:	5e                   	pop    %esi
    5aaa:	5d                   	pop    %ebp
    5aab:	c3                   	ret    

00005aac <III_get_scale_factors>:
	{{0,4,8,12,16,20,24,30,36,44,54,66,82,102,126,156,194,240,296,364,448,550,576},
		{0,4,8,12,16,22,30,42,58,78,104,138,180,192}}
};

void III_get_scale_factors(III_scalefac_t *scalefac, struct III_side_info_t *si, int gr, int ch, struct frame_params *fr_ps)
{
    5aac:	55                   	push   %ebp
    5aad:	89 e5                	mov    %esp,%ebp
    5aaf:	56                   	push   %esi
    5ab0:	53                   	push   %ebx
    5ab1:	83 ec 10             	sub    $0x10,%esp
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);
    5ab4:	8b 45 10             	mov    0x10(%ebp),%eax
    5ab7:	89 c2                	mov    %eax,%edx
    5ab9:	c1 e2 03             	shl    $0x3,%edx
    5abc:	01 c2                	add    %eax,%edx
    5abe:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5ac5:	89 c2                	mov    %eax,%edx
    5ac7:	8b 4d 14             	mov    0x14(%ebp),%ecx
    5aca:	89 c8                	mov    %ecx,%eax
    5acc:	c1 e0 02             	shl    $0x2,%eax
    5acf:	01 c8                	add    %ecx,%eax
    5ad1:	c1 e0 05             	shl    $0x5,%eax
    5ad4:	01 d0                	add    %edx,%eax
    5ad6:	8d 50 10             	lea    0x10(%eax),%edx
    5ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
    5adc:	01 d0                	add    %edx,%eax
    5ade:	83 c0 08             	add    $0x8,%eax
    5ae1:	89 45 e8             	mov    %eax,-0x18(%ebp)

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    5ae4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    5ae7:	8b 40 10             	mov    0x10(%eax),%eax
    5aea:	85 c0                	test   %eax,%eax
    5aec:	0f 84 93 02 00 00    	je     5d85 <III_get_scale_factors+0x2d9>
    5af2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    5af5:	8b 40 14             	mov    0x14(%eax),%eax
    5af8:	83 f8 02             	cmp    $0x2,%eax
    5afb:	0f 85 84 02 00 00    	jne    5d85 <III_get_scale_factors+0x2d9>
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    5b01:	8b 45 e8             	mov    -0x18(%ebp),%eax
    5b04:	8b 40 18             	mov    0x18(%eax),%eax
    5b07:	85 c0                	test   %eax,%eax
    5b09:	0f 84 7c 01 00 00    	je     5c8b <III_get_scale_factors+0x1df>
			for (sfb = 0; sfb < 8; sfb++)
    5b0f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    5b16:	eb 3b                	jmp    5b53 <III_get_scale_factors+0xa7>
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
    5b18:	8b 45 e8             	mov    -0x18(%ebp),%eax
    5b1b:	8b 40 0c             	mov    0xc(%eax),%eax
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
    5b1e:	8b 04 85 a0 c8 00 00 	mov    0xc8a0(,%eax,4),%eax
    5b25:	83 ec 0c             	sub    $0xc,%esp
    5b28:	50                   	push   %eax
    5b29:	e8 62 dc ff ff       	call   3790 <hgetbits>
    5b2e:	83 c4 10             	add    $0x10,%esp
    5b31:	89 c3                	mov    %eax,%ebx
    5b33:	8b 4d 08             	mov    0x8(%ebp),%ecx
    5b36:	8b 45 14             	mov    0x14(%ebp),%eax
    5b39:	89 c2                	mov    %eax,%edx
    5b3b:	8d 04 12             	lea    (%edx,%edx,1),%eax
    5b3e:	89 c2                	mov    %eax,%edx
    5b40:	89 d0                	mov    %edx,%eax
    5b42:	c1 e0 05             	shl    $0x5,%eax
    5b45:	29 d0                	sub    %edx,%eax
    5b47:	8b 55 f4             	mov    -0xc(%ebp),%edx
    5b4a:	01 d0                	add    %edx,%eax
    5b4c:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
    5b4f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    5b53:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    5b57:	7e bf                	jle    5b18 <III_get_scale_factors+0x6c>
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
    5b59:	c7 45 f4 03 00 00 00 	movl   $0x3,-0xc(%ebp)
    5b60:	eb 60                	jmp    5bc2 <III_get_scale_factors+0x116>
				for (window=0; window<3; window++)
    5b62:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    5b69:	eb 4d                	jmp    5bb8 <III_get_scale_factors+0x10c>
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
    5b6b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    5b6e:	8b 40 0c             	mov    0xc(%eax),%eax
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
    5b71:	8b 04 85 a0 c8 00 00 	mov    0xc8a0(,%eax,4),%eax
    5b78:	83 ec 0c             	sub    $0xc,%esp
    5b7b:	50                   	push   %eax
    5b7c:	e8 0f dc ff ff       	call   3790 <hgetbits>
    5b81:	83 c4 10             	add    $0x10,%esp
    5b84:	89 c6                	mov    %eax,%esi
    5b86:	8b 5d 08             	mov    0x8(%ebp),%ebx
    5b89:	8b 55 ec             	mov    -0x14(%ebp),%edx
    5b8c:	8b 4d 14             	mov    0x14(%ebp),%ecx
    5b8f:	89 d0                	mov    %edx,%eax
    5b91:	01 c0                	add    %eax,%eax
    5b93:	01 d0                	add    %edx,%eax
    5b95:	c1 e0 02             	shl    $0x2,%eax
    5b98:	01 d0                	add    %edx,%eax
    5b9a:	8d 14 09             	lea    (%ecx,%ecx,1),%edx
    5b9d:	89 d1                	mov    %edx,%ecx
    5b9f:	89 ca                	mov    %ecx,%edx
    5ba1:	c1 e2 05             	shl    $0x5,%edx
    5ba4:	29 ca                	sub    %ecx,%edx
    5ba6:	01 c2                	add    %eax,%edx
    5ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5bab:	01 d0                	add    %edx,%eax
    5bad:	83 c0 14             	add    $0x14,%eax
    5bb0:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
    5bb4:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5bb8:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    5bbc:	7e ad                	jle    5b6b <III_get_scale_factors+0xbf>
	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
			for (sfb = 0; sfb < 8; sfb++)
				(*scalefac)[ch].l[sfb] = hgetbits(
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
    5bbe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    5bc2:	83 7d f4 05          	cmpl   $0x5,-0xc(%ebp)
    5bc6:	7e 9a                	jle    5b62 <III_get_scale_factors+0xb6>
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
    5bc8:	c7 45 f4 06 00 00 00 	movl   $0x6,-0xc(%ebp)
    5bcf:	eb 63                	jmp    5c34 <III_get_scale_factors+0x188>
				for (window=0; window<3; window++)
    5bd1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    5bd8:	eb 50                	jmp    5c2a <III_get_scale_factors+0x17e>
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[1][gr_info->scalefac_compress]);
    5bda:	8b 45 e8             	mov    -0x18(%ebp),%eax
    5bdd:	8b 40 0c             	mov    0xc(%eax),%eax
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
    5be0:	83 c0 10             	add    $0x10,%eax
    5be3:	8b 04 85 a0 c8 00 00 	mov    0xc8a0(,%eax,4),%eax
    5bea:	83 ec 0c             	sub    $0xc,%esp
    5bed:	50                   	push   %eax
    5bee:	e8 9d db ff ff       	call   3790 <hgetbits>
    5bf3:	83 c4 10             	add    $0x10,%esp
    5bf6:	89 c6                	mov    %eax,%esi
    5bf8:	8b 5d 08             	mov    0x8(%ebp),%ebx
    5bfb:	8b 55 ec             	mov    -0x14(%ebp),%edx
    5bfe:	8b 4d 14             	mov    0x14(%ebp),%ecx
    5c01:	89 d0                	mov    %edx,%eax
    5c03:	01 c0                	add    %eax,%eax
    5c05:	01 d0                	add    %edx,%eax
    5c07:	c1 e0 02             	shl    $0x2,%eax
    5c0a:	01 d0                	add    %edx,%eax
    5c0c:	8d 14 09             	lea    (%ecx,%ecx,1),%edx
    5c0f:	89 d1                	mov    %edx,%ecx
    5c11:	89 ca                	mov    %ecx,%edx
    5c13:	c1 e2 05             	shl    $0x5,%edx
    5c16:	29 ca                	sub    %ecx,%edx
    5c18:	01 c2                	add    %eax,%edx
    5c1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5c1d:	01 d0                	add    %edx,%eax
    5c1f:	83 c0 14             	add    $0x14,%eax
    5c22:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
				for (window=0; window<3; window++)
    5c26:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5c2a:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    5c2e:	7e aa                	jle    5bda <III_get_scale_factors+0x12e>
					slen[0][gr_info->scalefac_compress]);
			for (sfb = 3; sfb < 6; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
    5c30:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    5c34:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    5c38:	7e 97                	jle    5bd1 <III_get_scale_factors+0x125>
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
    5c3a:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    5c41:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    5c48:	eb 36                	jmp    5c80 <III_get_scale_factors+0x1d4>
				(*scalefac)[ch].s[window][sfb] = 0;
    5c4a:	8b 5d 08             	mov    0x8(%ebp),%ebx
    5c4d:	8b 55 ec             	mov    -0x14(%ebp),%edx
    5c50:	8b 4d 14             	mov    0x14(%ebp),%ecx
    5c53:	89 d0                	mov    %edx,%eax
    5c55:	01 c0                	add    %eax,%eax
    5c57:	01 d0                	add    %edx,%eax
    5c59:	c1 e0 02             	shl    $0x2,%eax
    5c5c:	01 d0                	add    %edx,%eax
    5c5e:	8d 14 09             	lea    (%ecx,%ecx,1),%edx
    5c61:	89 d1                	mov    %edx,%ecx
    5c63:	89 ca                	mov    %ecx,%edx
    5c65:	c1 e2 05             	shl    $0x5,%edx
    5c68:	29 ca                	sub    %ecx,%edx
    5c6a:	01 c2                	add    %eax,%edx
    5c6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5c6f:	01 d0                	add    %edx,%eax
    5c71:	83 c0 14             	add    $0x14,%eax
    5c74:	c7 44 83 0c 00 00 00 	movl   $0x0,0xc(%ebx,%eax,4)
    5c7b:	00 
						slen[0][gr_info->scalefac_compress]);
			for (sfb = 6; sfb < 12; sfb++)
				for (window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = hgetbits(
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
    5c7c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5c80:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    5c84:	7e c4                	jle    5c4a <III_get_scale_factors+0x19e>
{
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    5c86:	e9 c5 01 00 00       	jmp    5e50 <III_get_scale_factors+0x3a4>
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
    5c8b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    5c92:	e9 93 00 00 00       	jmp    5d2a <III_get_scale_factors+0x27e>
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
    5c97:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5c9a:	83 c0 04             	add    $0x4,%eax
    5c9d:	8b 04 85 84 c8 00 00 	mov    0xc884(,%eax,4),%eax
    5ca4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    5ca7:	eb 68                	jmp    5d11 <III_get_scale_factors+0x265>
					for (window=0; window<3; window++)
    5ca9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    5cb0:	eb 55                	jmp    5d07 <III_get_scale_factors+0x25b>
						(*scalefac)[ch].s[window][sfb] = hgetbits(
							slen[i][gr_info->scalefac_compress]);
    5cb2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    5cb5:	8b 40 0c             	mov    0xc(%eax),%eax
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
						(*scalefac)[ch].s[window][sfb] = hgetbits(
    5cb8:	8b 55 f0             	mov    -0x10(%ebp),%edx
    5cbb:	c1 e2 04             	shl    $0x4,%edx
    5cbe:	01 d0                	add    %edx,%eax
    5cc0:	8b 04 85 a0 c8 00 00 	mov    0xc8a0(,%eax,4),%eax
    5cc7:	83 ec 0c             	sub    $0xc,%esp
    5cca:	50                   	push   %eax
    5ccb:	e8 c0 da ff ff       	call   3790 <hgetbits>
    5cd0:	83 c4 10             	add    $0x10,%esp
    5cd3:	89 c6                	mov    %eax,%esi
    5cd5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    5cd8:	8b 55 ec             	mov    -0x14(%ebp),%edx
    5cdb:	8b 4d 14             	mov    0x14(%ebp),%ecx
    5cde:	89 d0                	mov    %edx,%eax
    5ce0:	01 c0                	add    %eax,%eax
    5ce2:	01 d0                	add    %edx,%eax
    5ce4:	c1 e0 02             	shl    $0x2,%eax
    5ce7:	01 d0                	add    %edx,%eax
    5ce9:	8d 14 09             	lea    (%ecx,%ecx,1),%edx
    5cec:	89 d1                	mov    %edx,%ecx
    5cee:	89 ca                	mov    %ecx,%edx
    5cf0:	c1 e2 05             	shl    $0x5,%edx
    5cf3:	29 ca                	sub    %ecx,%edx
    5cf5:	01 c2                	add    %eax,%edx
    5cf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5cfa:	01 d0                	add    %edx,%eax
    5cfc:	83 c0 14             	add    $0x14,%eax
    5cff:	89 74 83 0c          	mov    %esi,0xc(%ebx,%eax,4)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
    5d03:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5d07:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    5d0b:	7e a5                	jle    5cb2 <III_get_scale_factors+0x206>
			for (sfb=12,window=0; window<3; window++)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
    5d0d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    5d11:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5d14:	83 c0 01             	add    $0x1,%eax
    5d17:	83 c0 04             	add    $0x4,%eax
    5d1a:	8b 04 85 84 c8 00 00 	mov    0xc884(,%eax,4),%eax
    5d21:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    5d24:	7f 83                	jg     5ca9 <III_get_scale_factors+0x1fd>
						slen[1][gr_info->scalefac_compress]);
			for (sfb=12,window=0; window<3; window++)
				(*scalefac)[ch].s[window][sfb] = 0;
		}
		else {  /* SHORT*/
			for (i=0; i<2; i++)
    5d26:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    5d2a:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    5d2e:	0f 8e 63 ff ff ff    	jle    5c97 <III_get_scale_factors+0x1eb>
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
						(*scalefac)[ch].s[window][sfb] = hgetbits(
							slen[i][gr_info->scalefac_compress]);
				for (sfb=12,window=0; window<3; window++)
    5d34:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    5d3b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    5d42:	eb 36                	jmp    5d7a <III_get_scale_factors+0x2ce>
					(*scalefac)[ch].s[window][sfb] = 0;
    5d44:	8b 5d 08             	mov    0x8(%ebp),%ebx
    5d47:	8b 55 ec             	mov    -0x14(%ebp),%edx
    5d4a:	8b 4d 14             	mov    0x14(%ebp),%ecx
    5d4d:	89 d0                	mov    %edx,%eax
    5d4f:	01 c0                	add    %eax,%eax
    5d51:	01 d0                	add    %edx,%eax
    5d53:	c1 e0 02             	shl    $0x2,%eax
    5d56:	01 d0                	add    %edx,%eax
    5d58:	8d 14 09             	lea    (%ecx,%ecx,1),%edx
    5d5b:	89 d1                	mov    %edx,%ecx
    5d5d:	89 ca                	mov    %ecx,%edx
    5d5f:	c1 e2 05             	shl    $0x5,%edx
    5d62:	29 ca                	sub    %ecx,%edx
    5d64:	01 c2                	add    %eax,%edx
    5d66:	8b 45 f4             	mov    -0xc(%ebp),%eax
    5d69:	01 d0                	add    %edx,%eax
    5d6b:	83 c0 14             	add    $0x14,%eax
    5d6e:	c7 44 83 0c 00 00 00 	movl   $0x0,0xc(%ebx,%eax,4)
    5d75:	00 
			for (i=0; i<2; i++)
				for (sfb = sfbtable.s[i]; sfb < sfbtable.s[i+1]; sfb++)
					for (window=0; window<3; window++)
						(*scalefac)[ch].s[window][sfb] = hgetbits(
							slen[i][gr_info->scalefac_compress]);
				for (sfb=12,window=0; window<3; window++)
    5d76:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    5d7a:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    5d7e:	7e c4                	jle    5d44 <III_get_scale_factors+0x298>
{
	int sfb, i, window;
	struct gr_info_s *gr_info = &(si->ch[ch].gr[gr]);

	if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
		if (gr_info->mixed_block_flag) { /* MIXED */ /* NEW - ag 11/25 */
    5d80:	e9 cb 00 00 00       	jmp    5e50 <III_get_scale_factors+0x3a4>
				for (sfb=12,window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = 0;
		}
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
    5d85:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    5d8c:	e9 92 00 00 00       	jmp    5e23 <III_get_scale_factors+0x377>
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
    5d91:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    5d94:	8b 55 14             	mov    0x14(%ebp),%edx
    5d97:	89 d0                	mov    %edx,%eax
    5d99:	c1 e0 02             	shl    $0x2,%eax
    5d9c:	01 d0                	add    %edx,%eax
    5d9e:	c1 e0 03             	shl    $0x3,%eax
    5da1:	8b 55 f0             	mov    -0x10(%ebp),%edx
    5da4:	01 d0                	add    %edx,%eax
    5da6:	8b 44 81 08          	mov    0x8(%ecx,%eax,4),%eax
    5daa:	85 c0                	test   %eax,%eax
    5dac:	74 06                	je     5db4 <III_get_scale_factors+0x308>
    5dae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    5db2:	75 6b                	jne    5e1f <III_get_scale_factors+0x373>
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
    5db4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5db7:	8b 04 85 80 c8 00 00 	mov    0xc880(,%eax,4),%eax
    5dbe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    5dc1:	eb 4a                	jmp    5e0d <III_get_scale_factors+0x361>
					(*scalefac)[ch].l[sfb] = hgetbits(
						slen[(i<2)?0:1][gr_info->scalefac_compress]);
    5dc3:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    5dc7:	0f 9f c0             	setg   %al
    5dca:	0f b6 d0             	movzbl %al,%edx
    5dcd:	8b 45 e8             	mov    -0x18(%ebp),%eax
    5dd0:	8b 40 0c             	mov    0xc(%eax),%eax
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
					(*scalefac)[ch].l[sfb] = hgetbits(
    5dd3:	c1 e2 04             	shl    $0x4,%edx
    5dd6:	01 d0                	add    %edx,%eax
    5dd8:	8b 04 85 a0 c8 00 00 	mov    0xc8a0(,%eax,4),%eax
    5ddf:	83 ec 0c             	sub    $0xc,%esp
    5de2:	50                   	push   %eax
    5de3:	e8 a8 d9 ff ff       	call   3790 <hgetbits>
    5de8:	83 c4 10             	add    $0x10,%esp
    5deb:	89 c3                	mov    %eax,%ebx
    5ded:	8b 4d 08             	mov    0x8(%ebp),%ecx
    5df0:	8b 45 14             	mov    0x14(%ebp),%eax
    5df3:	89 c2                	mov    %eax,%edx
    5df5:	8d 04 12             	lea    (%edx,%edx,1),%eax
    5df8:	89 c2                	mov    %eax,%edx
    5dfa:	89 d0                	mov    %edx,%eax
    5dfc:	c1 e0 05             	shl    $0x5,%eax
    5dff:	29 d0                	sub    %edx,%eax
    5e01:	8b 55 f4             	mov    -0xc(%ebp),%edx
    5e04:	01 d0                	add    %edx,%eax
    5e06:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
		}
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
    5e09:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    5e0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    5e10:	83 c0 01             	add    $0x1,%eax
    5e13:	8b 04 85 80 c8 00 00 	mov    0xc880(,%eax,4),%eax
    5e1a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    5e1d:	7f a4                	jg     5dc3 <III_get_scale_factors+0x317>
				for (sfb=12,window=0; window<3; window++)
					(*scalefac)[ch].s[window][sfb] = 0;
		}
	}
	else {   /* LONG types 0,1,3 */
		for (i=0; i<4; i++) {
    5e1f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    5e23:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    5e27:	0f 8e 64 ff ff ff    	jle    5d91 <III_get_scale_factors+0x2e5>
			if ((si->ch[ch].scfsi[i] == 0) || (gr == 0))
				for (sfb = sfbtable.l[i]; sfb < sfbtable.l[i+1]; sfb++)
					(*scalefac)[ch].l[sfb] = hgetbits(
						slen[(i<2)?0:1][gr_info->scalefac_compress]);
		}
		(*scalefac)[ch].l[22] = 0;
    5e2d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    5e30:	8b 45 14             	mov    0x14(%ebp),%eax
    5e33:	89 c2                	mov    %eax,%edx
    5e35:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5e3c:	89 c2                	mov    %eax,%edx
    5e3e:	89 d0                	mov    %edx,%eax
    5e40:	c1 e0 05             	shl    $0x5,%eax
    5e43:	29 d0                	sub    %edx,%eax
    5e45:	01 c8                	add    %ecx,%eax
    5e47:	83 c0 58             	add    $0x58,%eax
    5e4a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
}
    5e50:	90                   	nop
    5e51:	8d 65 f8             	lea    -0x8(%ebp),%esp
    5e54:	5b                   	pop    %ebx
    5e55:	5e                   	pop    %esi
    5e56:	5d                   	pop    %ebp
    5e57:	c3                   	ret    

00005e58 <initialize_huffman>:
struct huffcodetab ht[HTN];
*/
int huffman_initialized = FALSE;

void initialize_huffman()
{
    5e58:	55                   	push   %ebp
    5e59:	89 e5                	mov    %esp,%ebp
    5e5b:	83 ec 08             	sub    $0x8,%esp
	if (huffman_initialized) return;
    5e5e:	a1 c0 cb 00 00       	mov    0xcbc0,%eax
    5e63:	85 c0                	test   %eax,%eax
    5e65:	75 11                	jne    5e78 <initialize_huffman+0x20>
	read_decoder_table();
    5e67:	e8 83 d9 ff ff       	call   37ef <read_decoder_table>
	huffman_initialized = TRUE;
    5e6c:	c7 05 c0 cb 00 00 01 	movl   $0x1,0xcbc0
    5e73:	00 00 00 
    5e76:	eb 01                	jmp    5e79 <initialize_huffman+0x21>
*/
int huffman_initialized = FALSE;

void initialize_huffman()
{
	if (huffman_initialized) return;
    5e78:	90                   	nop
	read_decoder_table();
	huffman_initialized = TRUE;
}
    5e79:	c9                   	leave  
    5e7a:	c3                   	ret    

00005e7b <III_hufman_decode>:


void III_hufman_decode(long int is[SBLIMIT][SSLIMIT], struct III_side_info_t *si, int ch, int gr, int part2_start, struct frame_params *fr_ps)
{
    5e7b:	55                   	push   %ebp
    5e7c:	89 e5                	mov    %esp,%ebp
    5e7e:	57                   	push   %edi
    5e7f:	56                   	push   %esi
    5e80:	53                   	push   %ebx
    5e81:	83 ec 2c             	sub    $0x2c,%esp
   struct huffcodetab *h;
   int region1Start;
   int region2Start;
   //int bt = (*si).ch[ch].gr[gr].window_switching_flag && ((*si).ch[ch].gr[gr].block_type == 2);

   initialize_huffman();
    5e84:	e8 cf ff ff ff       	call   5e58 <initialize_huffman>

   /* ��������߽� */

   if ( ((*si).ch[ch].gr[gr].window_switching_flag) &&
    5e89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5e8c:	8b 45 14             	mov    0x14(%ebp),%eax
    5e8f:	8b 4d 10             	mov    0x10(%ebp),%ecx
    5e92:	89 c2                	mov    %eax,%edx
    5e94:	c1 e2 03             	shl    $0x3,%edx
    5e97:	01 c2                	add    %eax,%edx
    5e99:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5ea0:	89 c2                	mov    %eax,%edx
    5ea2:	89 c8                	mov    %ecx,%eax
    5ea4:	c1 e0 02             	shl    $0x2,%eax
    5ea7:	01 c8                	add    %ecx,%eax
    5ea9:	c1 e0 05             	shl    $0x5,%eax
    5eac:	01 d0                	add    %edx,%eax
    5eae:	01 d8                	add    %ebx,%eax
    5eb0:	83 c0 28             	add    $0x28,%eax
    5eb3:	8b 00                	mov    (%eax),%eax
    5eb5:	85 c0                	test   %eax,%eax
    5eb7:	74 44                	je     5efd <III_hufman_decode+0x82>
        ((*si).ch[ch].gr[gr].block_type == 2) ) {
    5eb9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5ebc:	8b 45 14             	mov    0x14(%ebp),%eax
    5ebf:	8b 4d 10             	mov    0x10(%ebp),%ecx
    5ec2:	89 c2                	mov    %eax,%edx
    5ec4:	c1 e2 03             	shl    $0x3,%edx
    5ec7:	01 c2                	add    %eax,%edx
    5ec9:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5ed0:	89 c2                	mov    %eax,%edx
    5ed2:	89 c8                	mov    %ecx,%eax
    5ed4:	c1 e0 02             	shl    $0x2,%eax
    5ed7:	01 c8                	add    %ecx,%eax
    5ed9:	c1 e0 05             	shl    $0x5,%eax
    5edc:	01 d0                	add    %edx,%eax
    5ede:	01 d8                	add    %ebx,%eax
    5ee0:	83 c0 2c             	add    $0x2c,%eax
    5ee3:	8b 00                	mov    (%eax),%eax

   initialize_huffman();

   /* ��������߽� */

   if ( ((*si).ch[ch].gr[gr].window_switching_flag) &&
    5ee5:	83 f8 02             	cmp    $0x2,%eax
    5ee8:	75 13                	jne    5efd <III_hufman_decode+0x82>
        ((*si).ch[ch].gr[gr].block_type == 2) ) {

      /* Region2. */

      region1Start = 36;  /* sfb[9/3]*3=36 */
    5eea:	c7 45 dc 24 00 00 00 	movl   $0x24,-0x24(%ebp)
      region2Start = 576; /* No Region2 for short block case. */
    5ef1:	c7 45 d8 40 02 00 00 	movl   $0x240,-0x28(%ebp)
    5ef8:	e9 cc 00 00 00       	jmp    5fc9 <III_hufman_decode+0x14e>
   }


   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
    5efd:	8b 45 1c             	mov    0x1c(%ebp),%eax
    5f00:	8b 00                	mov    (%eax),%eax
    5f02:	8b 48 10             	mov    0x10(%eax),%ecx
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
    5f05:	8b 75 0c             	mov    0xc(%ebp),%esi
    5f08:	8b 45 14             	mov    0x14(%ebp),%eax
    5f0b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    5f0e:	89 c2                	mov    %eax,%edx
    5f10:	c1 e2 03             	shl    $0x3,%edx
    5f13:	01 c2                	add    %eax,%edx
    5f15:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5f1c:	89 c2                	mov    %eax,%edx
    5f1e:	89 d8                	mov    %ebx,%eax
    5f20:	c1 e0 02             	shl    $0x2,%eax
    5f23:	01 d8                	add    %ebx,%eax
    5f25:	c1 e0 05             	shl    $0x5,%eax
    5f28:	01 d0                	add    %edx,%eax
    5f2a:	01 f0                	add    %esi,%eax
    5f2c:	83 c0 4c             	add    $0x4c,%eax
    5f2f:	8b 00                	mov    (%eax),%eax
    5f31:	8d 50 01             	lea    0x1(%eax),%edx
   }


   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
    5f34:	89 c8                	mov    %ecx,%eax
    5f36:	c1 e0 03             	shl    $0x3,%eax
    5f39:	01 c8                	add    %ecx,%eax
    5f3b:	c1 e0 02             	shl    $0x2,%eax
    5f3e:	01 c8                	add    %ecx,%eax
    5f40:	01 d0                	add    %edx,%eax
    5f42:	8b 04 85 20 c9 00 00 	mov    0xc920(,%eax,4),%eax
    5f49:	89 45 dc             	mov    %eax,-0x24(%ebp)
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
      region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
    5f4c:	8b 45 1c             	mov    0x1c(%ebp),%eax
    5f4f:	8b 00                	mov    (%eax),%eax
    5f51:	8b 48 10             	mov    0x10(%eax),%ecx
                              .l[(*si).ch[ch].gr[gr].region0_count +
    5f54:	8b 75 0c             	mov    0xc(%ebp),%esi
    5f57:	8b 45 14             	mov    0x14(%ebp),%eax
    5f5a:	8b 5d 10             	mov    0x10(%ebp),%ebx
    5f5d:	89 c2                	mov    %eax,%edx
    5f5f:	c1 e2 03             	shl    $0x3,%edx
    5f62:	01 c2                	add    %eax,%edx
    5f64:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5f6b:	89 c2                	mov    %eax,%edx
    5f6d:	89 d8                	mov    %ebx,%eax
    5f6f:	c1 e0 02             	shl    $0x2,%eax
    5f72:	01 d8                	add    %ebx,%eax
    5f74:	c1 e0 05             	shl    $0x5,%eax
    5f77:	01 d0                	add    %edx,%eax
    5f79:	01 f0                	add    %esi,%eax
    5f7b:	83 c0 4c             	add    $0x4c,%eax
    5f7e:	8b 30                	mov    (%eax),%esi
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
    5f80:	8b 7d 0c             	mov    0xc(%ebp),%edi
    5f83:	8b 45 14             	mov    0x14(%ebp),%eax
    5f86:	8b 5d 10             	mov    0x10(%ebp),%ebx
    5f89:	89 c2                	mov    %eax,%edx
    5f8b:	c1 e2 03             	shl    $0x3,%edx
    5f8e:	01 c2                	add    %eax,%edx
    5f90:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5f97:	89 c2                	mov    %eax,%edx
    5f99:	89 d8                	mov    %ebx,%eax
    5f9b:	c1 e0 02             	shl    $0x2,%eax
    5f9e:	01 d8                	add    %ebx,%eax
    5fa0:	c1 e0 05             	shl    $0x5,%eax
    5fa3:	01 d0                	add    %edx,%eax
    5fa5:	01 f8                	add    %edi,%eax
    5fa7:	83 c0 50             	add    $0x50,%eax
    5faa:	8b 00                	mov    (%eax),%eax
   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
      region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
                              .l[(*si).ch[ch].gr[gr].region0_count +
    5fac:	01 f0                	add    %esi,%eax
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
    5fae:	8d 50 02             	lea    0x2(%eax),%edx

   else {          /* ���ҳ�������µ�����߽�. */

      region1Start = sfBandIndex[fr_ps->header->sampling_frequency]
                           .l[(*si).ch[ch].gr[gr].region0_count + 1]; /* MI */
      region2Start = sfBandIndex[fr_ps->header->sampling_frequency]
    5fb1:	89 c8                	mov    %ecx,%eax
    5fb3:	c1 e0 03             	shl    $0x3,%eax
    5fb6:	01 c8                	add    %ecx,%eax
    5fb8:	c1 e0 02             	shl    $0x2,%eax
    5fbb:	01 c8                	add    %ecx,%eax
    5fbd:	01 d0                	add    %edx,%eax
    5fbf:	8b 04 85 20 c9 00 00 	mov    0xc920(,%eax,4),%eax
    5fc6:	89 45 d8             	mov    %eax,-0x28(%ebp)
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
      }


   /* ��ȡ��ֵ����Read bigvalues area. */
   for (i=0; i<(*si).ch[ch].gr[gr].big_values*2; i+=2) {
    5fc9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    5fd0:	e9 a3 01 00 00       	jmp    6178 <III_hufman_decode+0x2fd>
      if      (i<region1Start) h = &ht[(*si).ch[ch].gr[gr].table_select[0]];
    5fd5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    5fd8:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    5fdb:	7d 43                	jge    6020 <III_hufman_decode+0x1a5>
    5fdd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    5fe0:	8b 45 14             	mov    0x14(%ebp),%eax
    5fe3:	8b 4d 10             	mov    0x10(%ebp),%ecx
    5fe6:	89 c2                	mov    %eax,%edx
    5fe8:	c1 e2 03             	shl    $0x3,%edx
    5feb:	01 c2                	add    %eax,%edx
    5fed:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    5ff4:	89 c2                	mov    %eax,%edx
    5ff6:	89 c8                	mov    %ecx,%eax
    5ff8:	c1 e0 02             	shl    $0x2,%eax
    5ffb:	01 c8                	add    %ecx,%eax
    5ffd:	c1 e0 05             	shl    $0x5,%eax
    6000:	01 d0                	add    %edx,%eax
    6002:	01 d8                	add    %ebx,%eax
    6004:	83 c0 34             	add    $0x34,%eax
    6007:	8b 10                	mov    (%eax),%edx
    6009:	89 d0                	mov    %edx,%eax
    600b:	c1 e0 02             	shl    $0x2,%eax
    600e:	01 d0                	add    %edx,%eax
    6010:	c1 e0 03             	shl    $0x3,%eax
    6013:	05 e0 fb 00 00       	add    $0xfbe0,%eax
    6018:	89 45 e0             	mov    %eax,-0x20(%ebp)
    601b:	e9 86 00 00 00       	jmp    60a6 <III_hufman_decode+0x22b>
      else if (i<region2Start) h = &ht[(*si).ch[ch].gr[gr].table_select[1]];
    6020:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    6023:	3b 45 d8             	cmp    -0x28(%ebp),%eax
    6026:	7d 40                	jge    6068 <III_hufman_decode+0x1ed>
    6028:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    602b:	8b 45 14             	mov    0x14(%ebp),%eax
    602e:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6031:	89 c2                	mov    %eax,%edx
    6033:	c1 e2 03             	shl    $0x3,%edx
    6036:	01 c2                	add    %eax,%edx
    6038:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    603f:	89 c2                	mov    %eax,%edx
    6041:	89 c8                	mov    %ecx,%eax
    6043:	c1 e0 02             	shl    $0x2,%eax
    6046:	01 c8                	add    %ecx,%eax
    6048:	c1 e0 05             	shl    $0x5,%eax
    604b:	01 d0                	add    %edx,%eax
    604d:	01 d8                	add    %ebx,%eax
    604f:	83 c0 38             	add    $0x38,%eax
    6052:	8b 10                	mov    (%eax),%edx
    6054:	89 d0                	mov    %edx,%eax
    6056:	c1 e0 02             	shl    $0x2,%eax
    6059:	01 d0                	add    %edx,%eax
    605b:	c1 e0 03             	shl    $0x3,%eax
    605e:	05 e0 fb 00 00       	add    $0xfbe0,%eax
    6063:	89 45 e0             	mov    %eax,-0x20(%ebp)
    6066:	eb 3e                	jmp    60a6 <III_hufman_decode+0x22b>
           else                h = &ht[(*si).ch[ch].gr[gr].table_select[2]];
    6068:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    606b:	8b 45 14             	mov    0x14(%ebp),%eax
    606e:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6071:	89 c2                	mov    %eax,%edx
    6073:	c1 e2 03             	shl    $0x3,%edx
    6076:	01 c2                	add    %eax,%edx
    6078:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    607f:	89 c2                	mov    %eax,%edx
    6081:	89 c8                	mov    %ecx,%eax
    6083:	c1 e0 02             	shl    $0x2,%eax
    6086:	01 c8                	add    %ecx,%eax
    6088:	c1 e0 05             	shl    $0x5,%eax
    608b:	01 d0                	add    %edx,%eax
    608d:	01 d8                	add    %ebx,%eax
    608f:	83 c0 3c             	add    $0x3c,%eax
    6092:	8b 10                	mov    (%eax),%edx
    6094:	89 d0                	mov    %edx,%eax
    6096:	c1 e0 02             	shl    $0x2,%eax
    6099:	01 d0                	add    %edx,%eax
    609b:	c1 e0 03             	shl    $0x3,%eax
    609e:	05 e0 fb 00 00       	add    $0xfbe0,%eax
    60a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
      huffman_decoder(h, &x, &y, &v, &w);
    60a6:	83 ec 0c             	sub    $0xc,%esp
    60a9:	8d 45 c8             	lea    -0x38(%ebp),%eax
    60ac:	50                   	push   %eax
    60ad:	8d 45 cc             	lea    -0x34(%ebp),%eax
    60b0:	50                   	push   %eax
    60b1:	8d 45 d0             	lea    -0x30(%ebp),%eax
    60b4:	50                   	push   %eax
    60b5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    60b8:	50                   	push   %eax
    60b9:	ff 75 e0             	pushl  -0x20(%ebp)
    60bc:	e8 e7 ee ff ff       	call   4fa8 <huffman_decoder>
    60c1:	83 c4 20             	add    $0x20,%esp
      is[i/SSLIMIT][i%SSLIMIT] = x;
    60c4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    60c7:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    60cc:	89 c8                	mov    %ecx,%eax
    60ce:	f7 ea                	imul   %edx
    60d0:	c1 fa 02             	sar    $0x2,%edx
    60d3:	89 c8                	mov    %ecx,%eax
    60d5:	c1 f8 1f             	sar    $0x1f,%eax
    60d8:	29 c2                	sub    %eax,%edx
    60da:	89 d0                	mov    %edx,%eax
    60dc:	89 c2                	mov    %eax,%edx
    60de:	89 d0                	mov    %edx,%eax
    60e0:	c1 e0 03             	shl    $0x3,%eax
    60e3:	01 d0                	add    %edx,%eax
    60e5:	c1 e0 03             	shl    $0x3,%eax
    60e8:	89 c2                	mov    %eax,%edx
    60ea:	8b 45 08             	mov    0x8(%ebp),%eax
    60ed:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    60f0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    60f3:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    60f8:	89 c8                	mov    %ecx,%eax
    60fa:	f7 ea                	imul   %edx
    60fc:	c1 fa 02             	sar    $0x2,%edx
    60ff:	89 c8                	mov    %ecx,%eax
    6101:	c1 f8 1f             	sar    $0x1f,%eax
    6104:	29 c2                	sub    %eax,%edx
    6106:	89 d0                	mov    %edx,%eax
    6108:	c1 e0 03             	shl    $0x3,%eax
    610b:	01 d0                	add    %edx,%eax
    610d:	01 c0                	add    %eax,%eax
    610f:	29 c1                	sub    %eax,%ecx
    6111:	89 ca                	mov    %ecx,%edx
    6113:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    6116:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = y;
    6119:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    611c:	8d 48 01             	lea    0x1(%eax),%ecx
    611f:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6124:	89 c8                	mov    %ecx,%eax
    6126:	f7 ea                	imul   %edx
    6128:	c1 fa 02             	sar    $0x2,%edx
    612b:	89 c8                	mov    %ecx,%eax
    612d:	c1 f8 1f             	sar    $0x1f,%eax
    6130:	29 c2                	sub    %eax,%edx
    6132:	89 d0                	mov    %edx,%eax
    6134:	89 c2                	mov    %eax,%edx
    6136:	89 d0                	mov    %edx,%eax
    6138:	c1 e0 03             	shl    $0x3,%eax
    613b:	01 d0                	add    %edx,%eax
    613d:	c1 e0 03             	shl    $0x3,%eax
    6140:	89 c2                	mov    %eax,%edx
    6142:	8b 45 08             	mov    0x8(%ebp),%eax
    6145:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    6148:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    614b:	8d 48 01             	lea    0x1(%eax),%ecx
    614e:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6153:	89 c8                	mov    %ecx,%eax
    6155:	f7 ea                	imul   %edx
    6157:	c1 fa 02             	sar    $0x2,%edx
    615a:	89 c8                	mov    %ecx,%eax
    615c:	c1 f8 1f             	sar    $0x1f,%eax
    615f:	29 c2                	sub    %eax,%edx
    6161:	89 d0                	mov    %edx,%eax
    6163:	c1 e0 03             	shl    $0x3,%eax
    6166:	01 d0                	add    %edx,%eax
    6168:	01 c0                	add    %eax,%eax
    616a:	29 c1                	sub    %eax,%ecx
    616c:	89 ca                	mov    %ecx,%edx
    616e:	8b 45 d0             	mov    -0x30(%ebp),%eax
    6171:	89 04 93             	mov    %eax,(%ebx,%edx,4)
                              (*si).ch[ch].gr[gr].region1_count + 2]; /* MI */
      }


   /* ��ȡ��ֵ����Read bigvalues area. */
   for (i=0; i<(*si).ch[ch].gr[gr].big_values*2; i+=2) {
    6174:	83 45 e4 02          	addl   $0x2,-0x1c(%ebp)
    6178:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    617b:	8b 45 14             	mov    0x14(%ebp),%eax
    617e:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6181:	89 c2                	mov    %eax,%edx
    6183:	c1 e2 03             	shl    $0x3,%edx
    6186:	01 c2                	add    %eax,%edx
    6188:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    618f:	89 c2                	mov    %eax,%edx
    6191:	89 c8                	mov    %ecx,%eax
    6193:	c1 e0 02             	shl    $0x2,%eax
    6196:	01 c8                	add    %ecx,%eax
    6198:	c1 e0 05             	shl    $0x5,%eax
    619b:	01 d0                	add    %edx,%eax
    619d:	01 d8                	add    %ebx,%eax
    619f:	83 c0 1c             	add    $0x1c,%eax
    61a2:	8b 00                	mov    (%eax),%eax
    61a4:	8d 14 00             	lea    (%eax,%eax,1),%edx
    61a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    61aa:	39 c2                	cmp    %eax,%edx
    61ac:	0f 87 23 fe ff ff    	ja     5fd5 <III_hufman_decode+0x15a>
      is[i/SSLIMIT][i%SSLIMIT] = x;
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = y;
      }

   /* Read count1 area. */
   h = &ht[(*si).ch[ch].gr[gr].count1table_select+32];
    61b2:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    61b5:	8b 45 14             	mov    0x14(%ebp),%eax
    61b8:	8b 4d 10             	mov    0x10(%ebp),%ecx
    61bb:	89 c2                	mov    %eax,%edx
    61bd:	c1 e2 03             	shl    $0x3,%edx
    61c0:	01 c2                	add    %eax,%edx
    61c2:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    61c9:	89 c2                	mov    %eax,%edx
    61cb:	89 c8                	mov    %ecx,%eax
    61cd:	c1 e0 02             	shl    $0x2,%eax
    61d0:	01 c8                	add    %ecx,%eax
    61d2:	c1 e0 05             	shl    $0x5,%eax
    61d5:	01 d0                	add    %edx,%eax
    61d7:	01 d8                	add    %ebx,%eax
    61d9:	83 c0 5c             	add    $0x5c,%eax
    61dc:	8b 00                	mov    (%eax),%eax
    61de:	8d 50 20             	lea    0x20(%eax),%edx
    61e1:	89 d0                	mov    %edx,%eax
    61e3:	c1 e0 02             	shl    $0x2,%eax
    61e6:	01 d0                	add    %edx,%eax
    61e8:	c1 e0 03             	shl    $0x3,%eax
    61eb:	05 e0 fb 00 00       	add    $0xfbe0,%eax
    61f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
   while ((hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length ) &&
    61f3:	e9 88 01 00 00       	jmp    6380 <III_hufman_decode+0x505>
     ( i < SSLIMIT*SBLIMIT )) {
      huffman_decoder(h, &x, &y, &v, &w);
    61f8:	83 ec 0c             	sub    $0xc,%esp
    61fb:	8d 45 c8             	lea    -0x38(%ebp),%eax
    61fe:	50                   	push   %eax
    61ff:	8d 45 cc             	lea    -0x34(%ebp),%eax
    6202:	50                   	push   %eax
    6203:	8d 45 d0             	lea    -0x30(%ebp),%eax
    6206:	50                   	push   %eax
    6207:	8d 45 d4             	lea    -0x2c(%ebp),%eax
    620a:	50                   	push   %eax
    620b:	ff 75 e0             	pushl  -0x20(%ebp)
    620e:	e8 95 ed ff ff       	call   4fa8 <huffman_decoder>
    6213:	83 c4 20             	add    $0x20,%esp
      is[i/SSLIMIT][i%SSLIMIT] = v;
    6216:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    6219:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    621e:	89 c8                	mov    %ecx,%eax
    6220:	f7 ea                	imul   %edx
    6222:	c1 fa 02             	sar    $0x2,%edx
    6225:	89 c8                	mov    %ecx,%eax
    6227:	c1 f8 1f             	sar    $0x1f,%eax
    622a:	29 c2                	sub    %eax,%edx
    622c:	89 d0                	mov    %edx,%eax
    622e:	89 c2                	mov    %eax,%edx
    6230:	89 d0                	mov    %edx,%eax
    6232:	c1 e0 03             	shl    $0x3,%eax
    6235:	01 d0                	add    %edx,%eax
    6237:	c1 e0 03             	shl    $0x3,%eax
    623a:	89 c2                	mov    %eax,%edx
    623c:	8b 45 08             	mov    0x8(%ebp),%eax
    623f:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    6242:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    6245:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    624a:	89 c8                	mov    %ecx,%eax
    624c:	f7 ea                	imul   %edx
    624e:	c1 fa 02             	sar    $0x2,%edx
    6251:	89 c8                	mov    %ecx,%eax
    6253:	c1 f8 1f             	sar    $0x1f,%eax
    6256:	29 c2                	sub    %eax,%edx
    6258:	89 d0                	mov    %edx,%eax
    625a:	c1 e0 03             	shl    $0x3,%eax
    625d:	01 d0                	add    %edx,%eax
    625f:	01 c0                	add    %eax,%eax
    6261:	29 c1                	sub    %eax,%ecx
    6263:	89 ca                	mov    %ecx,%edx
    6265:	8b 45 cc             	mov    -0x34(%ebp),%eax
    6268:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = w;
    626b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    626e:	8d 48 01             	lea    0x1(%eax),%ecx
    6271:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6276:	89 c8                	mov    %ecx,%eax
    6278:	f7 ea                	imul   %edx
    627a:	c1 fa 02             	sar    $0x2,%edx
    627d:	89 c8                	mov    %ecx,%eax
    627f:	c1 f8 1f             	sar    $0x1f,%eax
    6282:	29 c2                	sub    %eax,%edx
    6284:	89 d0                	mov    %edx,%eax
    6286:	89 c2                	mov    %eax,%edx
    6288:	89 d0                	mov    %edx,%eax
    628a:	c1 e0 03             	shl    $0x3,%eax
    628d:	01 d0                	add    %edx,%eax
    628f:	c1 e0 03             	shl    $0x3,%eax
    6292:	89 c2                	mov    %eax,%edx
    6294:	8b 45 08             	mov    0x8(%ebp),%eax
    6297:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    629a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    629d:	8d 48 01             	lea    0x1(%eax),%ecx
    62a0:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    62a5:	89 c8                	mov    %ecx,%eax
    62a7:	f7 ea                	imul   %edx
    62a9:	c1 fa 02             	sar    $0x2,%edx
    62ac:	89 c8                	mov    %ecx,%eax
    62ae:	c1 f8 1f             	sar    $0x1f,%eax
    62b1:	29 c2                	sub    %eax,%edx
    62b3:	89 d0                	mov    %edx,%eax
    62b5:	c1 e0 03             	shl    $0x3,%eax
    62b8:	01 d0                	add    %edx,%eax
    62ba:	01 c0                	add    %eax,%eax
    62bc:	29 c1                	sub    %eax,%ecx
    62be:	89 ca                	mov    %ecx,%edx
    62c0:	8b 45 c8             	mov    -0x38(%ebp),%eax
    62c3:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+2)/SSLIMIT][(i+2)%SSLIMIT] = x;
    62c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    62c9:	8d 48 02             	lea    0x2(%eax),%ecx
    62cc:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    62d1:	89 c8                	mov    %ecx,%eax
    62d3:	f7 ea                	imul   %edx
    62d5:	c1 fa 02             	sar    $0x2,%edx
    62d8:	89 c8                	mov    %ecx,%eax
    62da:	c1 f8 1f             	sar    $0x1f,%eax
    62dd:	29 c2                	sub    %eax,%edx
    62df:	89 d0                	mov    %edx,%eax
    62e1:	89 c2                	mov    %eax,%edx
    62e3:	89 d0                	mov    %edx,%eax
    62e5:	c1 e0 03             	shl    $0x3,%eax
    62e8:	01 d0                	add    %edx,%eax
    62ea:	c1 e0 03             	shl    $0x3,%eax
    62ed:	89 c2                	mov    %eax,%edx
    62ef:	8b 45 08             	mov    0x8(%ebp),%eax
    62f2:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    62f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    62f8:	8d 48 02             	lea    0x2(%eax),%ecx
    62fb:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6300:	89 c8                	mov    %ecx,%eax
    6302:	f7 ea                	imul   %edx
    6304:	c1 fa 02             	sar    $0x2,%edx
    6307:	89 c8                	mov    %ecx,%eax
    6309:	c1 f8 1f             	sar    $0x1f,%eax
    630c:	29 c2                	sub    %eax,%edx
    630e:	89 d0                	mov    %edx,%eax
    6310:	c1 e0 03             	shl    $0x3,%eax
    6313:	01 d0                	add    %edx,%eax
    6315:	01 c0                	add    %eax,%eax
    6317:	29 c1                	sub    %eax,%ecx
    6319:	89 ca                	mov    %ecx,%edx
    631b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    631e:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      is[(i+3)/SSLIMIT][(i+3)%SSLIMIT] = y;
    6321:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    6324:	8d 48 03             	lea    0x3(%eax),%ecx
    6327:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    632c:	89 c8                	mov    %ecx,%eax
    632e:	f7 ea                	imul   %edx
    6330:	c1 fa 02             	sar    $0x2,%edx
    6333:	89 c8                	mov    %ecx,%eax
    6335:	c1 f8 1f             	sar    $0x1f,%eax
    6338:	29 c2                	sub    %eax,%edx
    633a:	89 d0                	mov    %edx,%eax
    633c:	89 c2                	mov    %eax,%edx
    633e:	89 d0                	mov    %edx,%eax
    6340:	c1 e0 03             	shl    $0x3,%eax
    6343:	01 d0                	add    %edx,%eax
    6345:	c1 e0 03             	shl    $0x3,%eax
    6348:	89 c2                	mov    %eax,%edx
    634a:	8b 45 08             	mov    0x8(%ebp),%eax
    634d:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    6350:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    6353:	8d 48 03             	lea    0x3(%eax),%ecx
    6356:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    635b:	89 c8                	mov    %ecx,%eax
    635d:	f7 ea                	imul   %edx
    635f:	c1 fa 02             	sar    $0x2,%edx
    6362:	89 c8                	mov    %ecx,%eax
    6364:	c1 f8 1f             	sar    $0x1f,%eax
    6367:	29 c2                	sub    %eax,%edx
    6369:	89 d0                	mov    %edx,%eax
    636b:	c1 e0 03             	shl    $0x3,%eax
    636e:	01 d0                	add    %edx,%eax
    6370:	01 c0                	add    %eax,%eax
    6372:	29 c1                	sub    %eax,%ecx
    6374:	89 ca                	mov    %ecx,%edx
    6376:	8b 45 d0             	mov    -0x30(%ebp),%eax
    6379:	89 04 93             	mov    %eax,(%ebx,%edx,4)
      i += 4;
    637c:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
      is[(i+1)/SSLIMIT][(i+1)%SSLIMIT] = y;
      }

   /* Read count1 area. */
   h = &ht[(*si).ch[ch].gr[gr].count1table_select+32];
   while ((hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length ) &&
    6380:	e8 f4 d3 ff ff       	call   3779 <hsstell>
    6385:	89 c6                	mov    %eax,%esi
    6387:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    638a:	8b 45 14             	mov    0x14(%ebp),%eax
    638d:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6390:	89 c2                	mov    %eax,%edx
    6392:	c1 e2 03             	shl    $0x3,%edx
    6395:	01 c2                	add    %eax,%edx
    6397:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    639e:	89 c2                	mov    %eax,%edx
    63a0:	89 c8                	mov    %ecx,%eax
    63a2:	c1 e0 02             	shl    $0x2,%eax
    63a5:	01 c8                	add    %ecx,%eax
    63a7:	c1 e0 05             	shl    $0x5,%eax
    63aa:	01 d0                	add    %edx,%eax
    63ac:	01 d8                	add    %ebx,%eax
    63ae:	83 c0 18             	add    $0x18,%eax
    63b1:	8b 10                	mov    (%eax),%edx
    63b3:	8b 45 18             	mov    0x18(%ebp),%eax
    63b6:	01 d0                	add    %edx,%eax
    63b8:	39 c6                	cmp    %eax,%esi
    63ba:	73 0d                	jae    63c9 <III_hufman_decode+0x54e>
    63bc:	81 7d e4 3f 02 00 00 	cmpl   $0x23f,-0x1c(%ebp)
    63c3:	0f 8e 2f fe ff ff    	jle    61f8 <III_hufman_decode+0x37d>
      is[(i+2)/SSLIMIT][(i+2)%SSLIMIT] = x;
      is[(i+3)/SSLIMIT][(i+3)%SSLIMIT] = y;
      i += 4;
      }

   if (hsstell() > part2_start + (*si).ch[ch].gr[gr].part2_3_length)
    63c9:	e8 ab d3 ff ff       	call   3779 <hsstell>
    63ce:	89 c6                	mov    %eax,%esi
    63d0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    63d3:	8b 45 14             	mov    0x14(%ebp),%eax
    63d6:	8b 4d 10             	mov    0x10(%ebp),%ecx
    63d9:	89 c2                	mov    %eax,%edx
    63db:	c1 e2 03             	shl    $0x3,%edx
    63de:	01 c2                	add    %eax,%edx
    63e0:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    63e7:	89 c2                	mov    %eax,%edx
    63e9:	89 c8                	mov    %ecx,%eax
    63eb:	c1 e0 02             	shl    $0x2,%eax
    63ee:	01 c8                	add    %ecx,%eax
    63f0:	c1 e0 05             	shl    $0x5,%eax
    63f3:	01 d0                	add    %edx,%eax
    63f5:	01 d8                	add    %ebx,%eax
    63f7:	83 c0 18             	add    $0x18,%eax
    63fa:	8b 10                	mov    (%eax),%edx
    63fc:	8b 45 18             	mov    0x18(%ebp),%eax
    63ff:	01 d0                	add    %edx,%eax
    6401:	39 c6                	cmp    %eax,%esi
    6403:	76 4e                	jbe    6453 <III_hufman_decode+0x5d8>
   {  i -=4;
    6405:	83 6d e4 04          	subl   $0x4,-0x1c(%ebp)
      rewindNbits(hsstell()-part2_start - (*si).ch[ch].gr[gr].part2_3_length);
    6409:	e8 6b d3 ff ff       	call   3779 <hsstell>
    640e:	89 c2                	mov    %eax,%edx
    6410:	8b 45 18             	mov    0x18(%ebp),%eax
    6413:	89 d6                	mov    %edx,%esi
    6415:	29 c6                	sub    %eax,%esi
    6417:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    641a:	8b 45 14             	mov    0x14(%ebp),%eax
    641d:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6420:	89 c2                	mov    %eax,%edx
    6422:	c1 e2 03             	shl    $0x3,%edx
    6425:	01 c2                	add    %eax,%edx
    6427:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    642e:	89 c2                	mov    %eax,%edx
    6430:	89 c8                	mov    %ecx,%eax
    6432:	c1 e0 02             	shl    $0x2,%eax
    6435:	01 c8                	add    %ecx,%eax
    6437:	c1 e0 05             	shl    $0x5,%eax
    643a:	01 d0                	add    %edx,%eax
    643c:	01 d8                	add    %ebx,%eax
    643e:	83 c0 18             	add    $0x18,%eax
    6441:	8b 00                	mov    (%eax),%eax
    6443:	29 c6                	sub    %eax,%esi
    6445:	89 f0                	mov    %esi,%eax
    6447:	83 ec 0c             	sub    $0xc,%esp
    644a:	50                   	push   %eax
    644b:	e8 6d d3 ff ff       	call   37bd <rewindNbits>
    6450:	83 c4 10             	add    $0x10,%esp
   }

   /* Dismiss stuffing Bits */
   if ( hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length )
    6453:	e8 21 d3 ff ff       	call   3779 <hsstell>
    6458:	89 c6                	mov    %eax,%esi
    645a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    645d:	8b 45 14             	mov    0x14(%ebp),%eax
    6460:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6463:	89 c2                	mov    %eax,%edx
    6465:	c1 e2 03             	shl    $0x3,%edx
    6468:	01 c2                	add    %eax,%edx
    646a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    6471:	89 c2                	mov    %eax,%edx
    6473:	89 c8                	mov    %ecx,%eax
    6475:	c1 e0 02             	shl    $0x2,%eax
    6478:	01 c8                	add    %ecx,%eax
    647a:	c1 e0 05             	shl    $0x5,%eax
    647d:	01 d0                	add    %edx,%eax
    647f:	01 d8                	add    %ebx,%eax
    6481:	83 c0 18             	add    $0x18,%eax
    6484:	8b 10                	mov    (%eax),%edx
    6486:	8b 45 18             	mov    0x18(%ebp),%eax
    6489:	01 d0                	add    %edx,%eax
    648b:	39 c6                	cmp    %eax,%esi
    648d:	0f 83 a3 00 00 00    	jae    6536 <III_hufman_decode+0x6bb>
      hgetbits( part2_start + (*si).ch[ch].gr[gr].part2_3_length - hsstell());
    6493:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    6496:	8b 45 14             	mov    0x14(%ebp),%eax
    6499:	8b 4d 10             	mov    0x10(%ebp),%ecx
    649c:	89 c2                	mov    %eax,%edx
    649e:	c1 e2 03             	shl    $0x3,%edx
    64a1:	01 c2                	add    %eax,%edx
    64a3:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
    64aa:	89 c2                	mov    %eax,%edx
    64ac:	89 c8                	mov    %ecx,%eax
    64ae:	c1 e0 02             	shl    $0x2,%eax
    64b1:	01 c8                	add    %ecx,%eax
    64b3:	c1 e0 05             	shl    $0x5,%eax
    64b6:	01 d0                	add    %edx,%eax
    64b8:	01 d8                	add    %ebx,%eax
    64ba:	83 c0 18             	add    $0x18,%eax
    64bd:	8b 10                	mov    (%eax),%edx
    64bf:	8b 45 18             	mov    0x18(%ebp),%eax
    64c2:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    64c5:	e8 af d2 ff ff       	call   3779 <hsstell>
    64ca:	29 c3                	sub    %eax,%ebx
    64cc:	89 d8                	mov    %ebx,%eax
    64ce:	83 ec 0c             	sub    $0xc,%esp
    64d1:	50                   	push   %eax
    64d2:	e8 b9 d2 ff ff       	call   3790 <hgetbits>
    64d7:	83 c4 10             	add    $0x10,%esp

   /* Zero out rest. */
   for (; i<SSLIMIT*SBLIMIT; i++)
    64da:	eb 5a                	jmp    6536 <III_hufman_decode+0x6bb>
      is[i/SSLIMIT][i%SSLIMIT] = 0;
    64dc:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    64df:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    64e4:	89 c8                	mov    %ecx,%eax
    64e6:	f7 ea                	imul   %edx
    64e8:	c1 fa 02             	sar    $0x2,%edx
    64eb:	89 c8                	mov    %ecx,%eax
    64ed:	c1 f8 1f             	sar    $0x1f,%eax
    64f0:	29 c2                	sub    %eax,%edx
    64f2:	89 d0                	mov    %edx,%eax
    64f4:	89 c2                	mov    %eax,%edx
    64f6:	89 d0                	mov    %edx,%eax
    64f8:	c1 e0 03             	shl    $0x3,%eax
    64fb:	01 d0                	add    %edx,%eax
    64fd:	c1 e0 03             	shl    $0x3,%eax
    6500:	89 c2                	mov    %eax,%edx
    6502:	8b 45 08             	mov    0x8(%ebp),%eax
    6505:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    6508:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    650b:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6510:	89 c8                	mov    %ecx,%eax
    6512:	f7 ea                	imul   %edx
    6514:	c1 fa 02             	sar    $0x2,%edx
    6517:	89 c8                	mov    %ecx,%eax
    6519:	c1 f8 1f             	sar    $0x1f,%eax
    651c:	29 c2                	sub    %eax,%edx
    651e:	89 d0                	mov    %edx,%eax
    6520:	c1 e0 03             	shl    $0x3,%eax
    6523:	01 d0                	add    %edx,%eax
    6525:	01 c0                	add    %eax,%eax
    6527:	29 c1                	sub    %eax,%ecx
    6529:	89 ca                	mov    %ecx,%edx
    652b:	c7 04 93 00 00 00 00 	movl   $0x0,(%ebx,%edx,4)
   /* Dismiss stuffing Bits */
   if ( hsstell() < part2_start + (*si).ch[ch].gr[gr].part2_3_length )
      hgetbits( part2_start + (*si).ch[ch].gr[gr].part2_3_length - hsstell());

   /* Zero out rest. */
   for (; i<SSLIMIT*SBLIMIT; i++)
    6532:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    6536:	81 7d e4 3f 02 00 00 	cmpl   $0x23f,-0x1c(%ebp)
    653d:	7e 9d                	jle    64dc <III_hufman_decode+0x661>
      is[i/SSLIMIT][i%SSLIMIT] = 0;
}
    653f:	90                   	nop
    6540:	8d 65 f4             	lea    -0xc(%ebp),%esp
    6543:	5b                   	pop    %ebx
    6544:	5e                   	pop    %esi
    6545:	5f                   	pop    %edi
    6546:	5d                   	pop    %ebp
    6547:	c3                   	ret    

00006548 <III_dequantize_sample>:


int pretab[22] = {0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,2,2,3,3,3,2,0};

void III_dequantize_sample(long int is[SBLIMIT][SSLIMIT], double xr[SBLIMIT][SSLIMIT], III_scalefac_t *scalefac, struct gr_info_s *gr_info, int ch, struct frame_params *fr_ps)
{
    6548:	55                   	push   %ebp
    6549:	89 e5                	mov    %esp,%ebp
    654b:	53                   	push   %ebx
    654c:	83 ec 34             	sub    $0x34,%esp
	int ss,sb,cb=0,sfreq=fr_ps->header->sampling_frequency;
    654f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    6556:	8b 45 1c             	mov    0x1c(%ebp),%eax
    6559:	8b 00                	mov    (%eax),%eax
    655b:	8b 40 10             	mov    0x10(%eax),%eax
    655e:	89 45 dc             	mov    %eax,-0x24(%ebp)
	//int stereo = fr_ps->stereo;
	int next_cb_boundary, cb_begin, cb_width = 0, sign;
    6561:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)

	/* choose correct scalefactor band per block type, initalize boundary */

	if (gr_info->window_switching_flag && (gr_info->block_type == 2) )
    6568:	8b 45 14             	mov    0x14(%ebp),%eax
    656b:	8b 40 10             	mov    0x10(%eax),%eax
    656e:	85 c0                	test   %eax,%eax
    6570:	74 5f                	je     65d1 <III_dequantize_sample+0x89>
    6572:	8b 45 14             	mov    0x14(%ebp),%eax
    6575:	8b 40 14             	mov    0x14(%eax),%eax
    6578:	83 f8 02             	cmp    $0x2,%eax
    657b:	75 54                	jne    65d1 <III_dequantize_sample+0x89>
		if (gr_info->mixed_block_flag)
    657d:	8b 45 14             	mov    0x14(%ebp),%eax
    6580:	8b 40 18             	mov    0x18(%eax),%eax
    6583:	85 c0                	test   %eax,%eax
    6585:	74 15                	je     659c <III_dequantize_sample+0x54>
			next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
    6587:	8b 45 dc             	mov    -0x24(%ebp),%eax
    658a:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    6590:	05 24 c9 00 00       	add    $0xc924,%eax
    6595:	8b 00                	mov    (%eax),%eax
    6597:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int next_cb_boundary, cb_begin, cb_width = 0, sign;

	/* choose correct scalefactor band per block type, initalize boundary */

	if (gr_info->window_switching_flag && (gr_info->block_type == 2) )
		if (gr_info->mixed_block_flag)
    659a:	eb 48                	jmp    65e4 <III_dequantize_sample+0x9c>
			next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
		else {
			next_cb_boundary=sfBandIndex[sfreq].s[1]*3; /* pure SHORT block */
    659c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    659f:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    65a5:	05 80 c9 00 00       	add    $0xc980,%eax
    65aa:	8b 10                	mov    (%eax),%edx
    65ac:	89 d0                	mov    %edx,%eax
    65ae:	01 c0                	add    %eax,%eax
    65b0:	01 d0                	add    %edx,%eax
    65b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cb_width = sfBandIndex[sfreq].s[1];
    65b5:	8b 45 dc             	mov    -0x24(%ebp),%eax
    65b8:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    65be:	05 80 c9 00 00       	add    $0xc980,%eax
    65c3:	8b 00                	mov    (%eax),%eax
    65c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			cb_begin = 0;
    65c8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	int next_cb_boundary, cb_begin, cb_width = 0, sign;

	/* choose correct scalefactor band per block type, initalize boundary */

	if (gr_info->window_switching_flag && (gr_info->block_type == 2) )
		if (gr_info->mixed_block_flag)
    65cf:	eb 13                	jmp    65e4 <III_dequantize_sample+0x9c>
			next_cb_boundary=sfBandIndex[sfreq].s[1]*3; /* pure SHORT block */
			cb_width = sfBandIndex[sfreq].s[1];
			cb_begin = 0;
		}
	else
		next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */
    65d1:	8b 45 dc             	mov    -0x24(%ebp),%eax
    65d4:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    65da:	05 24 c9 00 00       	add    $0xc924,%eax
    65df:	8b 00                	mov    (%eax),%eax
    65e1:	89 45 e8             	mov    %eax,-0x18(%ebp)

	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
    65e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    65eb:	e9 7e 06 00 00       	jmp    6c6e <III_dequantize_sample+0x726>
		for (ss=0 ; ss < SSLIMIT ; ss++) {
    65f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    65f7:	e9 64 06 00 00       	jmp    6c60 <III_dequantize_sample+0x718>
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
    65fc:	8b 55 f0             	mov    -0x10(%ebp),%edx
    65ff:	89 d0                	mov    %edx,%eax
    6601:	c1 e0 03             	shl    $0x3,%eax
    6604:	01 d0                	add    %edx,%eax
    6606:	01 c0                	add    %eax,%eax
    6608:	89 c2                	mov    %eax,%edx
    660a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    660d:	01 d0                	add    %edx,%eax
    660f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    6612:	0f 85 9b 02 00 00    	jne    68b3 <III_dequantize_sample+0x36b>
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    6618:	8b 45 14             	mov    0x14(%ebp),%eax
    661b:	8b 40 10             	mov    0x10(%eax),%eax
    661e:	85 c0                	test   %eax,%eax
    6620:	0f 84 68 02 00 00    	je     688e <III_dequantize_sample+0x346>
    6626:	8b 45 14             	mov    0x14(%ebp),%eax
    6629:	8b 40 14             	mov    0x14(%eax),%eax
    662c:	83 f8 02             	cmp    $0x2,%eax
    662f:	0f 85 59 02 00 00    	jne    688e <III_dequantize_sample+0x346>
					if (gr_info->mixed_block_flag) {
    6635:	8b 45 14             	mov    0x14(%ebp),%eax
    6638:	8b 40 18             	mov    0x18(%eax),%eax
    663b:	85 c0                	test   %eax,%eax
    663d:	0f 84 ae 01 00 00    	je     67f1 <III_dequantize_sample+0x2a9>
						if (((sb*18)+ss) == sfBandIndex[sfreq].l[8])  {
    6643:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6646:	89 d0                	mov    %edx,%eax
    6648:	c1 e0 03             	shl    $0x3,%eax
    664b:	01 d0                	add    %edx,%eax
    664d:	01 c0                	add    %eax,%eax
    664f:	89 c2                	mov    %eax,%edx
    6651:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6654:	01 c2                	add    %eax,%edx
    6656:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6659:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    665f:	05 40 c9 00 00       	add    $0xc940,%eax
    6664:	8b 00                	mov    (%eax),%eax
    6666:	39 c2                	cmp    %eax,%edx
    6668:	0f 85 92 00 00 00    	jne    6700 <III_dequantize_sample+0x1b8>
							next_cb_boundary=sfBandIndex[sfreq].s[4]*3;
    666e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6671:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    6677:	05 8c c9 00 00       	add    $0xc98c,%eax
    667c:	8b 10                	mov    (%eax),%edx
    667e:	89 d0                	mov    %edx,%eax
    6680:	01 c0                	add    %eax,%eax
    6682:	01 d0                	add    %edx,%eax
    6684:	89 45 e8             	mov    %eax,-0x18(%ebp)
							cb = 3;
    6687:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    668e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6691:	8d 48 01             	lea    0x1(%eax),%ecx
    6694:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6697:	89 d0                	mov    %edx,%eax
    6699:	c1 e0 03             	shl    $0x3,%eax
    669c:	01 d0                	add    %edx,%eax
    669e:	c1 e0 02             	shl    $0x2,%eax
    66a1:	01 d0                	add    %edx,%eax
    66a3:	01 c8                	add    %ecx,%eax
    66a5:	83 c0 14             	add    $0x14,%eax
    66a8:	8b 0c 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%ecx
										sfBandIndex[sfreq].s[cb];
    66af:	8b 55 dc             	mov    -0x24(%ebp),%edx
    66b2:	89 d0                	mov    %edx,%eax
    66b4:	c1 e0 03             	shl    $0x3,%eax
    66b7:	01 d0                	add    %edx,%eax
    66b9:	c1 e0 02             	shl    $0x2,%eax
    66bc:	01 d0                	add    %edx,%eax
    66be:	8b 55 ec             	mov    -0x14(%ebp),%edx
    66c1:	01 d0                	add    %edx,%eax
    66c3:	83 c0 14             	add    $0x14,%eax
    66c6:	8b 04 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%eax
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
						if (((sb*18)+ss) == sfBandIndex[sfreq].l[8])  {
							next_cb_boundary=sfBandIndex[sfreq].s[4]*3;
							cb = 3;
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    66cd:	29 c1                	sub    %eax,%ecx
    66cf:	89 c8                	mov    %ecx,%eax
    66d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
    66d4:	8b 55 dc             	mov    -0x24(%ebp),%edx
    66d7:	89 d0                	mov    %edx,%eax
    66d9:	c1 e0 03             	shl    $0x3,%eax
    66dc:	01 d0                	add    %edx,%eax
    66de:	c1 e0 02             	shl    $0x2,%eax
    66e1:	01 d0                	add    %edx,%eax
    66e3:	8b 55 ec             	mov    -0x14(%ebp),%edx
    66e6:	01 d0                	add    %edx,%eax
    66e8:	83 c0 14             	add    $0x14,%eax
    66eb:	8b 14 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%edx
    66f2:	89 d0                	mov    %edx,%eax
    66f4:	01 c0                	add    %eax,%eax
    66f6:	01 d0                	add    %edx,%eax
    66f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
    66fb:	e9 b3 01 00 00       	jmp    68b3 <III_dequantize_sample+0x36b>
							cb = 3;
							cb_width = sfBandIndex[sfreq].s[cb+1] -
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
						}
						else if (((sb*18)+ss) < sfBandIndex[sfreq].l[8])
    6700:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6703:	89 d0                	mov    %edx,%eax
    6705:	c1 e0 03             	shl    $0x3,%eax
    6708:	01 d0                	add    %edx,%eax
    670a:	01 c0                	add    %eax,%eax
    670c:	89 c2                	mov    %eax,%edx
    670e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6711:	01 c2                	add    %eax,%edx
    6713:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6716:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    671c:	05 40 c9 00 00       	add    $0xc940,%eax
    6721:	8b 00                	mov    (%eax),%eax
    6723:	39 c2                	cmp    %eax,%edx
    6725:	7d 2a                	jge    6751 <III_dequantize_sample+0x209>
							next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
    6727:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    672b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    672e:	8d 48 01             	lea    0x1(%eax),%ecx
    6731:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6734:	89 d0                	mov    %edx,%eax
    6736:	c1 e0 03             	shl    $0x3,%eax
    6739:	01 d0                	add    %edx,%eax
    673b:	c1 e0 02             	shl    $0x2,%eax
    673e:	01 d0                	add    %edx,%eax
    6740:	01 c8                	add    %ecx,%eax
    6742:	8b 04 85 20 c9 00 00 	mov    0xc920(,%eax,4),%eax
    6749:	89 45 e8             	mov    %eax,-0x18(%ebp)
	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
    674c:	e9 62 01 00 00       	jmp    68b3 <III_dequantize_sample+0x36b>
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
						}
						else if (((sb*18)+ss) < sfBandIndex[sfreq].l[8])
							next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
						else {
							next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
    6751:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    6755:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6758:	8d 48 01             	lea    0x1(%eax),%ecx
    675b:	8b 55 dc             	mov    -0x24(%ebp),%edx
    675e:	89 d0                	mov    %edx,%eax
    6760:	c1 e0 03             	shl    $0x3,%eax
    6763:	01 d0                	add    %edx,%eax
    6765:	c1 e0 02             	shl    $0x2,%eax
    6768:	01 d0                	add    %edx,%eax
    676a:	01 c8                	add    %ecx,%eax
    676c:	83 c0 14             	add    $0x14,%eax
    676f:	8b 14 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%edx
    6776:	89 d0                	mov    %edx,%eax
    6778:	01 c0                	add    %eax,%eax
    677a:	01 d0                	add    %edx,%eax
    677c:	89 45 e8             	mov    %eax,-0x18(%ebp)
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    677f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6782:	8d 48 01             	lea    0x1(%eax),%ecx
    6785:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6788:	89 d0                	mov    %edx,%eax
    678a:	c1 e0 03             	shl    $0x3,%eax
    678d:	01 d0                	add    %edx,%eax
    678f:	c1 e0 02             	shl    $0x2,%eax
    6792:	01 d0                	add    %edx,%eax
    6794:	01 c8                	add    %ecx,%eax
    6796:	83 c0 14             	add    $0x14,%eax
    6799:	8b 0c 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%ecx
										sfBandIndex[sfreq].s[cb];
    67a0:	8b 55 dc             	mov    -0x24(%ebp),%edx
    67a3:	89 d0                	mov    %edx,%eax
    67a5:	c1 e0 03             	shl    $0x3,%eax
    67a8:	01 d0                	add    %edx,%eax
    67aa:	c1 e0 02             	shl    $0x2,%eax
    67ad:	01 d0                	add    %edx,%eax
    67af:	8b 55 ec             	mov    -0x14(%ebp),%edx
    67b2:	01 d0                	add    %edx,%eax
    67b4:	83 c0 14             	add    $0x14,%eax
    67b7:	8b 04 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%eax
						}
						else if (((sb*18)+ss) < sfBandIndex[sfreq].l[8])
							next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
						else {
							next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
							cb_width = sfBandIndex[sfreq].s[cb+1] -
    67be:	29 c1                	sub    %eax,%ecx
    67c0:	89 c8                	mov    %ecx,%eax
    67c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
    67c5:	8b 55 dc             	mov    -0x24(%ebp),%edx
    67c8:	89 d0                	mov    %edx,%eax
    67ca:	c1 e0 03             	shl    $0x3,%eax
    67cd:	01 d0                	add    %edx,%eax
    67cf:	c1 e0 02             	shl    $0x2,%eax
    67d2:	01 d0                	add    %edx,%eax
    67d4:	8b 55 ec             	mov    -0x14(%ebp),%edx
    67d7:	01 d0                	add    %edx,%eax
    67d9:	83 c0 14             	add    $0x14,%eax
    67dc:	8b 14 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%edx
    67e3:	89 d0                	mov    %edx,%eax
    67e5:	01 c0                	add    %eax,%eax
    67e7:	01 d0                	add    %edx,%eax
    67e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
    67ec:	e9 c2 00 00 00       	jmp    68b3 <III_dequantize_sample+0x36b>
										sfBandIndex[sfreq].s[cb];
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
						}
					}
					else {
						next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
    67f1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    67f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    67f8:	8d 48 01             	lea    0x1(%eax),%ecx
    67fb:	8b 55 dc             	mov    -0x24(%ebp),%edx
    67fe:	89 d0                	mov    %edx,%eax
    6800:	c1 e0 03             	shl    $0x3,%eax
    6803:	01 d0                	add    %edx,%eax
    6805:	c1 e0 02             	shl    $0x2,%eax
    6808:	01 d0                	add    %edx,%eax
    680a:	01 c8                	add    %ecx,%eax
    680c:	83 c0 14             	add    $0x14,%eax
    680f:	8b 14 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%edx
    6816:	89 d0                	mov    %edx,%eax
    6818:	01 c0                	add    %eax,%eax
    681a:	01 d0                	add    %edx,%eax
    681c:	89 45 e8             	mov    %eax,-0x18(%ebp)
						cb_width = sfBandIndex[sfreq].s[cb+1] -
    681f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6822:	8d 48 01             	lea    0x1(%eax),%ecx
    6825:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6828:	89 d0                	mov    %edx,%eax
    682a:	c1 e0 03             	shl    $0x3,%eax
    682d:	01 d0                	add    %edx,%eax
    682f:	c1 e0 02             	shl    $0x2,%eax
    6832:	01 d0                	add    %edx,%eax
    6834:	01 c8                	add    %ecx,%eax
    6836:	83 c0 14             	add    $0x14,%eax
    6839:	8b 0c 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%ecx
									sfBandIndex[sfreq].s[cb];
    6840:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6843:	89 d0                	mov    %edx,%eax
    6845:	c1 e0 03             	shl    $0x3,%eax
    6848:	01 d0                	add    %edx,%eax
    684a:	c1 e0 02             	shl    $0x2,%eax
    684d:	01 d0                	add    %edx,%eax
    684f:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6852:	01 d0                	add    %edx,%eax
    6854:	83 c0 14             	add    $0x14,%eax
    6857:	8b 04 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%eax
							cb_begin = sfBandIndex[sfreq].s[cb]*3;
						}
					}
					else {
						next_cb_boundary = sfBandIndex[sfreq].s[(++cb)+1]*3;
						cb_width = sfBandIndex[sfreq].s[cb+1] -
    685e:	29 c1                	sub    %eax,%ecx
    6860:	89 c8                	mov    %ecx,%eax
    6862:	89 45 e0             	mov    %eax,-0x20(%ebp)
									sfBandIndex[sfreq].s[cb];
						cb_begin = sfBandIndex[sfreq].s[cb]*3;
    6865:	8b 55 dc             	mov    -0x24(%ebp),%edx
    6868:	89 d0                	mov    %edx,%eax
    686a:	c1 e0 03             	shl    $0x3,%eax
    686d:	01 d0                	add    %edx,%eax
    686f:	c1 e0 02             	shl    $0x2,%eax
    6872:	01 d0                	add    %edx,%eax
    6874:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6877:	01 d0                	add    %edx,%eax
    6879:	83 c0 14             	add    $0x14,%eax
    687c:	8b 14 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%edx
    6883:	89 d0                	mov    %edx,%eax
    6885:	01 c0                	add    %eax,%eax
    6887:	01 d0                	add    %edx,%eax
    6889:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
			if ( (sb*18)+ss == next_cb_boundary) { /* Adjust critical band boundary */
				if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
					if (gr_info->mixed_block_flag) {
    688c:	eb 25                	jmp    68b3 <III_dequantize_sample+0x36b>
									sfBandIndex[sfreq].s[cb];
						cb_begin = sfBandIndex[sfreq].s[cb]*3;
					}
				}
	            else /* long blocks */
		           next_cb_boundary = sfBandIndex[sfreq].l[(++cb)+1];
    688e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    6892:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6895:	8d 48 01             	lea    0x1(%eax),%ecx
    6898:	8b 55 dc             	mov    -0x24(%ebp),%edx
    689b:	89 d0                	mov    %edx,%eax
    689d:	c1 e0 03             	shl    $0x3,%eax
    68a0:	01 d0                	add    %edx,%eax
    68a2:	c1 e0 02             	shl    $0x2,%eax
    68a5:	01 d0                	add    %edx,%eax
    68a7:	01 c8                	add    %ecx,%eax
    68a9:	8b 04 85 20 c9 00 00 	mov    0xc920(,%eax,4),%eax
    68b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
			}

			/* Compute overall (global) scaling. */
			xr[sb][ss] = pow( 2.0 , (0.25 * (gr_info->global_gain - 210.0)));
    68b3:	8b 55 f0             	mov    -0x10(%ebp),%edx
    68b6:	89 d0                	mov    %edx,%eax
    68b8:	c1 e0 03             	shl    $0x3,%eax
    68bb:	01 d0                	add    %edx,%eax
    68bd:	c1 e0 04             	shl    $0x4,%eax
    68c0:	89 c2                	mov    %eax,%edx
    68c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    68c5:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    68c8:	8b 45 14             	mov    0x14(%ebp),%eax
    68cb:	8b 40 08             	mov    0x8(%eax),%eax
    68ce:	89 45 c8             	mov    %eax,-0x38(%ebp)
    68d1:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    68d8:	df 6d c8             	fildll -0x38(%ebp)
    68db:	dd 5d d0             	fstpl  -0x30(%ebp)
    68de:	dd 45 d0             	fldl   -0x30(%ebp)
    68e1:	dd 05 50 b7 00 00    	fldl   0xb750
    68e7:	de e9                	fsubrp %st,%st(1)
    68e9:	dd 05 58 b7 00 00    	fldl   0xb758
    68ef:	de c9                	fmulp  %st,%st(1)
    68f1:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    68f5:	dd 1c 24             	fstpl  (%esp)
    68f8:	dd 05 60 b7 00 00    	fldl   0xb760
    68fe:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    6902:	dd 1c 24             	fstpl  (%esp)
    6905:	e8 b4 c1 ff ff       	call   2abe <pow>
    690a:	83 c4 10             	add    $0x10,%esp
    690d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6910:	dd 1c c3             	fstpl  (%ebx,%eax,8)

			/* Do long/short dependent scaling operations. */

			if (gr_info->window_switching_flag && (
    6913:	8b 45 14             	mov    0x14(%ebp),%eax
    6916:	8b 40 10             	mov    0x10(%eax),%eax
    6919:	85 c0                	test   %eax,%eax
    691b:	0f 84 9c 01 00 00    	je     6abd <III_dequantize_sample+0x575>
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    6921:	8b 45 14             	mov    0x14(%ebp),%eax
    6924:	8b 40 14             	mov    0x14(%eax),%eax
			/* Compute overall (global) scaling. */
			xr[sb][ss] = pow( 2.0 , (0.25 * (gr_info->global_gain - 210.0)));

			/* Do long/short dependent scaling operations. */

			if (gr_info->window_switching_flag && (
    6927:	83 f8 02             	cmp    $0x2,%eax
    692a:	75 0a                	jne    6936 <III_dequantize_sample+0x3ee>
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    692c:	8b 45 14             	mov    0x14(%ebp),%eax
    692f:	8b 40 18             	mov    0x18(%eax),%eax
    6932:	85 c0                	test   %eax,%eax
    6934:	74 27                	je     695d <III_dequantize_sample+0x415>
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {
    6936:	8b 45 14             	mov    0x14(%ebp),%eax
    6939:	8b 40 14             	mov    0x14(%eax),%eax
			xr[sb][ss] = pow( 2.0 , (0.25 * (gr_info->global_gain - 210.0)));

			/* Do long/short dependent scaling operations. */

			if (gr_info->window_switching_flag && (
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
    693c:	83 f8 02             	cmp    $0x2,%eax
    693f:	0f 85 78 01 00 00    	jne    6abd <III_dequantize_sample+0x575>
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {
    6945:	8b 45 14             	mov    0x14(%ebp),%eax
    6948:	8b 40 18             	mov    0x18(%eax),%eax
    694b:	85 c0                	test   %eax,%eax
    694d:	0f 84 6a 01 00 00    	je     6abd <III_dequantize_sample+0x575>
    6953:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    6957:	0f 8e 60 01 00 00    	jle    6abd <III_dequantize_sample+0x575>

				xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
    695d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6960:	89 d0                	mov    %edx,%eax
    6962:	c1 e0 03             	shl    $0x3,%eax
    6965:	01 d0                	add    %edx,%eax
    6967:	01 c0                	add    %eax,%eax
    6969:	89 c2                	mov    %eax,%edx
    696b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    696e:	01 d0                	add    %edx,%eax
    6970:	2b 45 e4             	sub    -0x1c(%ebp),%eax
    6973:	99                   	cltd   
    6974:	f7 7d e0             	idivl  -0x20(%ebp)
    6977:	89 c2                	mov    %eax,%edx
    6979:	8b 45 14             	mov    0x14(%ebp),%eax
    697c:	83 c2 08             	add    $0x8,%edx
    697f:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax

			if (gr_info->window_switching_flag && (
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {

				xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
    6983:	89 45 c8             	mov    %eax,-0x38(%ebp)
    6986:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    698d:	df 6d c8             	fildll -0x38(%ebp)
    6990:	dd 5d d0             	fstpl  -0x30(%ebp)
    6993:	dd 45 d0             	fldl   -0x30(%ebp)
    6996:	dd 05 68 b7 00 00    	fldl   0xb768
    699c:	de c9                	fmulp  %st,%st(1)
    699e:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    69a2:	dd 1c 24             	fstpl  (%esp)
    69a5:	dd 05 60 b7 00 00    	fldl   0xb760
    69ab:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    69af:	dd 1c 24             	fstpl  (%esp)
    69b2:	e8 07 c1 ff ff       	call   2abe <pow>
    69b7:	83 c4 10             	add    $0x10,%esp
    69ba:	8b 55 f0             	mov    -0x10(%ebp),%edx
    69bd:	89 d0                	mov    %edx,%eax
    69bf:	c1 e0 03             	shl    $0x3,%eax
    69c2:	01 d0                	add    %edx,%eax
    69c4:	c1 e0 04             	shl    $0x4,%eax
    69c7:	89 c2                	mov    %eax,%edx
    69c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    69cc:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    69cf:	8b 55 f0             	mov    -0x10(%ebp),%edx
    69d2:	89 d0                	mov    %edx,%eax
    69d4:	c1 e0 03             	shl    $0x3,%eax
    69d7:	01 d0                	add    %edx,%eax
    69d9:	c1 e0 04             	shl    $0x4,%eax
    69dc:	89 c2                	mov    %eax,%edx
    69de:	8b 45 0c             	mov    0xc(%ebp),%eax
    69e1:	01 c2                	add    %eax,%edx
    69e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    69e6:	dd 04 c2             	fldl   (%edx,%eax,8)
    69e9:	de c9                	fmulp  %st,%st(1)
    69eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    69ee:	dd 1c c1             	fstpl  (%ecx,%eax,8)
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
				xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0+gr_info->scalefac_scale)
    69f1:	8b 45 14             	mov    0x14(%ebp),%eax
    69f4:	8b 40 40             	mov    0x40(%eax),%eax
    69f7:	89 45 c8             	mov    %eax,-0x38(%ebp)
    69fa:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    6a01:	df 6d c8             	fildll -0x38(%ebp)
    6a04:	dd 5d d0             	fstpl  -0x30(%ebp)
    6a07:	dd 45 d0             	fldl   -0x30(%ebp)
    6a0a:	d9 e8                	fld1   
    6a0c:	de c1                	faddp  %st,%st(1)
    6a0e:	dd 05 70 b7 00 00    	fldl   0xb770
    6a14:	de c9                	fmulp  %st,%st(1)
						* (*scalefac)[ch].s[(((sb*18)+ss) - cb_begin)/cb_width][cb]);
    6a16:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6a19:	89 d0                	mov    %edx,%eax
    6a1b:	c1 e0 03             	shl    $0x3,%eax
    6a1e:	01 d0                	add    %edx,%eax
    6a20:	01 c0                	add    %eax,%eax
    6a22:	89 c2                	mov    %eax,%edx
    6a24:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6a27:	01 d0                	add    %edx,%eax
    6a29:	2b 45 e4             	sub    -0x1c(%ebp),%eax
    6a2c:	99                   	cltd   
    6a2d:	f7 7d e0             	idivl  -0x20(%ebp)
    6a30:	89 c2                	mov    %eax,%edx
    6a32:	8b 5d 10             	mov    0x10(%ebp),%ebx
    6a35:	8b 4d 18             	mov    0x18(%ebp),%ecx
    6a38:	89 d0                	mov    %edx,%eax
    6a3a:	01 c0                	add    %eax,%eax
    6a3c:	01 d0                	add    %edx,%eax
    6a3e:	c1 e0 02             	shl    $0x2,%eax
    6a41:	01 d0                	add    %edx,%eax
    6a43:	8d 14 09             	lea    (%ecx,%ecx,1),%edx
    6a46:	89 d1                	mov    %edx,%ecx
    6a48:	89 ca                	mov    %ecx,%edx
    6a4a:	c1 e2 05             	shl    $0x5,%edx
    6a4d:	29 ca                	sub    %ecx,%edx
    6a4f:	01 c2                	add    %eax,%edx
    6a51:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6a54:	01 d0                	add    %edx,%eax
    6a56:	83 c0 14             	add    $0x14,%eax
    6a59:	8b 44 83 0c          	mov    0xc(%ebx,%eax,4),%eax
				((gr_info->block_type == 2) && (gr_info->mixed_block_flag == 0)) ||
				((gr_info->block_type == 2) && gr_info->mixed_block_flag && (sb >= 2)) )) {

				xr[sb][ss] *= pow(2.0, 0.25 * -8.0 *
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
				xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0+gr_info->scalefac_scale)
    6a5d:	89 45 c8             	mov    %eax,-0x38(%ebp)
    6a60:	db 45 c8             	fildl  -0x38(%ebp)
    6a63:	de c9                	fmulp  %st,%st(1)
    6a65:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    6a69:	dd 1c 24             	fstpl  (%esp)
    6a6c:	dd 05 60 b7 00 00    	fldl   0xb760
    6a72:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    6a76:	dd 1c 24             	fstpl  (%esp)
    6a79:	e8 40 c0 ff ff       	call   2abe <pow>
    6a7e:	83 c4 10             	add    $0x10,%esp
    6a81:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6a84:	89 d0                	mov    %edx,%eax
    6a86:	c1 e0 03             	shl    $0x3,%eax
    6a89:	01 d0                	add    %edx,%eax
    6a8b:	c1 e0 04             	shl    $0x4,%eax
    6a8e:	89 c2                	mov    %eax,%edx
    6a90:	8b 45 0c             	mov    0xc(%ebp),%eax
    6a93:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    6a96:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6a99:	89 d0                	mov    %edx,%eax
    6a9b:	c1 e0 03             	shl    $0x3,%eax
    6a9e:	01 d0                	add    %edx,%eax
    6aa0:	c1 e0 04             	shl    $0x4,%eax
    6aa3:	89 c2                	mov    %eax,%edx
    6aa5:	8b 45 0c             	mov    0xc(%ebp),%eax
    6aa8:	01 c2                	add    %eax,%edx
    6aaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6aad:	dd 04 c2             	fldl   (%edx,%eax,8)
    6ab0:	de c9                	fmulp  %st,%st(1)
    6ab2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6ab5:	dd 1c c1             	fstpl  (%ecx,%eax,8)
						* (*scalefac)[ch].s[(((sb*18)+ss) - cb_begin)/cb_width][cb]);
    6ab8:	e9 c0 00 00 00       	jmp    6b7d <III_dequantize_sample+0x635>
			}
			else {   /* LONG block types 0,1,3 & 1st 2 subbands of switched blocks */
				xr[sb][ss] *= pow(2.0, -0.5 * (1.0+gr_info->scalefac_scale)
    6abd:	8b 45 14             	mov    0x14(%ebp),%eax
    6ac0:	8b 40 40             	mov    0x40(%eax),%eax
    6ac3:	89 45 c8             	mov    %eax,-0x38(%ebp)
    6ac6:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    6acd:	df 6d c8             	fildll -0x38(%ebp)
    6ad0:	dd 5d d0             	fstpl  -0x30(%ebp)
    6ad3:	dd 45 d0             	fldl   -0x30(%ebp)
    6ad6:	d9 e8                	fld1   
    6ad8:	de c1                	faddp  %st,%st(1)
    6ada:	dd 05 70 b7 00 00    	fldl   0xb770
    6ae0:	de c9                	fmulp  %st,%st(1)
								* ((*scalefac)[ch].l[cb]
    6ae2:	8b 4d 10             	mov    0x10(%ebp),%ecx
    6ae5:	8b 45 18             	mov    0x18(%ebp),%eax
    6ae8:	89 c2                	mov    %eax,%edx
    6aea:	8d 04 12             	lea    (%edx,%edx,1),%eax
    6aed:	89 c2                	mov    %eax,%edx
    6aef:	89 d0                	mov    %edx,%eax
    6af1:	c1 e0 05             	shl    $0x5,%eax
    6af4:	29 d0                	sub    %edx,%eax
    6af6:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6af9:	01 d0                	add    %edx,%eax
    6afb:	8b 04 81             	mov    (%ecx,%eax,4),%eax
								+ gr_info->preflag * pretab[cb]));
    6afe:	89 c1                	mov    %eax,%ecx
    6b00:	8b 45 14             	mov    0x14(%ebp),%eax
    6b03:	8b 50 3c             	mov    0x3c(%eax),%edx
    6b06:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6b09:	8b 04 85 e0 ca 00 00 	mov    0xcae0(,%eax,4),%eax
    6b10:	0f af c2             	imul   %edx,%eax
    6b13:	01 c8                	add    %ecx,%eax
						gr_info->subblock_gain[(((sb*18)+ss) - cb_begin)/cb_width]);
				xr[sb][ss] *= pow(2.0, 0.25 * -2.0 * (1.0+gr_info->scalefac_scale)
						* (*scalefac)[ch].s[(((sb*18)+ss) - cb_begin)/cb_width][cb]);
			}
			else {   /* LONG block types 0,1,3 & 1st 2 subbands of switched blocks */
				xr[sb][ss] *= pow(2.0, -0.5 * (1.0+gr_info->scalefac_scale)
    6b15:	89 45 c8             	mov    %eax,-0x38(%ebp)
    6b18:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    6b1f:	df 6d c8             	fildll -0x38(%ebp)
    6b22:	dd 5d d0             	fstpl  -0x30(%ebp)
    6b25:	dd 45 d0             	fldl   -0x30(%ebp)
    6b28:	de c9                	fmulp  %st,%st(1)
    6b2a:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    6b2e:	dd 1c 24             	fstpl  (%esp)
    6b31:	dd 05 60 b7 00 00    	fldl   0xb760
    6b37:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    6b3b:	dd 1c 24             	fstpl  (%esp)
    6b3e:	e8 7b bf ff ff       	call   2abe <pow>
    6b43:	83 c4 10             	add    $0x10,%esp
    6b46:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6b49:	89 d0                	mov    %edx,%eax
    6b4b:	c1 e0 03             	shl    $0x3,%eax
    6b4e:	01 d0                	add    %edx,%eax
    6b50:	c1 e0 04             	shl    $0x4,%eax
    6b53:	89 c2                	mov    %eax,%edx
    6b55:	8b 45 0c             	mov    0xc(%ebp),%eax
    6b58:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    6b5b:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6b5e:	89 d0                	mov    %edx,%eax
    6b60:	c1 e0 03             	shl    $0x3,%eax
    6b63:	01 d0                	add    %edx,%eax
    6b65:	c1 e0 04             	shl    $0x4,%eax
    6b68:	89 c2                	mov    %eax,%edx
    6b6a:	8b 45 0c             	mov    0xc(%ebp),%eax
    6b6d:	01 c2                	add    %eax,%edx
    6b6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6b72:	dd 04 c2             	fldl   (%edx,%eax,8)
    6b75:	de c9                	fmulp  %st,%st(1)
    6b77:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6b7a:	dd 1c c1             	fstpl  (%ecx,%eax,8)
								+ gr_info->preflag * pretab[cb]));
			}

			/* Scale quantized value. */

			sign = (is[sb][ss]<0) ? 1 : 0;
    6b7d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6b80:	89 d0                	mov    %edx,%eax
    6b82:	c1 e0 03             	shl    $0x3,%eax
    6b85:	01 d0                	add    %edx,%eax
    6b87:	c1 e0 03             	shl    $0x3,%eax
    6b8a:	89 c2                	mov    %eax,%edx
    6b8c:	8b 45 08             	mov    0x8(%ebp),%eax
    6b8f:	01 c2                	add    %eax,%edx
    6b91:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6b94:	8b 04 82             	mov    (%edx,%eax,4),%eax
    6b97:	c1 e8 1f             	shr    $0x1f,%eax
    6b9a:	0f b6 c0             	movzbl %al,%eax
    6b9d:	89 45 d8             	mov    %eax,-0x28(%ebp)
			xr[sb][ss] *= pow( (double) abs(is[sb][ss]), ((double)4.0/3.0) );
    6ba0:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6ba3:	89 d0                	mov    %edx,%eax
    6ba5:	c1 e0 03             	shl    $0x3,%eax
    6ba8:	01 d0                	add    %edx,%eax
    6baa:	c1 e0 03             	shl    $0x3,%eax
    6bad:	89 c2                	mov    %eax,%edx
    6baf:	8b 45 08             	mov    0x8(%ebp),%eax
    6bb2:	01 c2                	add    %eax,%edx
    6bb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6bb7:	8b 04 82             	mov    (%edx,%eax,4),%eax
    6bba:	83 ec 0c             	sub    $0xc,%esp
    6bbd:	50                   	push   %eax
    6bbe:	e8 e5 bd ff ff       	call   29a8 <abs>
    6bc3:	83 c4 10             	add    $0x10,%esp
    6bc6:	89 45 c8             	mov    %eax,-0x38(%ebp)
    6bc9:	db 45 c8             	fildl  -0x38(%ebp)
    6bcc:	dd 05 78 b7 00 00    	fldl   0xb778
    6bd2:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    6bd6:	dd 1c 24             	fstpl  (%esp)
    6bd9:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    6bdd:	dd 1c 24             	fstpl  (%esp)
    6be0:	e8 d9 be ff ff       	call   2abe <pow>
    6be5:	83 c4 10             	add    $0x10,%esp
    6be8:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6beb:	89 d0                	mov    %edx,%eax
    6bed:	c1 e0 03             	shl    $0x3,%eax
    6bf0:	01 d0                	add    %edx,%eax
    6bf2:	c1 e0 04             	shl    $0x4,%eax
    6bf5:	89 c2                	mov    %eax,%edx
    6bf7:	8b 45 0c             	mov    0xc(%ebp),%eax
    6bfa:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    6bfd:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6c00:	89 d0                	mov    %edx,%eax
    6c02:	c1 e0 03             	shl    $0x3,%eax
    6c05:	01 d0                	add    %edx,%eax
    6c07:	c1 e0 04             	shl    $0x4,%eax
    6c0a:	89 c2                	mov    %eax,%edx
    6c0c:	8b 45 0c             	mov    0xc(%ebp),%eax
    6c0f:	01 c2                	add    %eax,%edx
    6c11:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6c14:	dd 04 c2             	fldl   (%edx,%eax,8)
    6c17:	de c9                	fmulp  %st,%st(1)
    6c19:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6c1c:	dd 1c c1             	fstpl  (%ecx,%eax,8)
			if (sign) xr[sb][ss] = -xr[sb][ss];
    6c1f:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    6c23:	74 37                	je     6c5c <III_dequantize_sample+0x714>
    6c25:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6c28:	89 d0                	mov    %edx,%eax
    6c2a:	c1 e0 03             	shl    $0x3,%eax
    6c2d:	01 d0                	add    %edx,%eax
    6c2f:	c1 e0 04             	shl    $0x4,%eax
    6c32:	89 c2                	mov    %eax,%edx
    6c34:	8b 45 0c             	mov    0xc(%ebp),%eax
    6c37:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    6c3a:	8b 55 f0             	mov    -0x10(%ebp),%edx
    6c3d:	89 d0                	mov    %edx,%eax
    6c3f:	c1 e0 03             	shl    $0x3,%eax
    6c42:	01 d0                	add    %edx,%eax
    6c44:	c1 e0 04             	shl    $0x4,%eax
    6c47:	89 c2                	mov    %eax,%edx
    6c49:	8b 45 0c             	mov    0xc(%ebp),%eax
    6c4c:	01 c2                	add    %eax,%edx
    6c4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6c51:	dd 04 c2             	fldl   (%edx,%eax,8)
    6c54:	d9 e0                	fchs   
    6c56:	8b 45 f4             	mov    -0xc(%ebp),%eax
    6c59:	dd 1c c1             	fstpl  (%ecx,%eax,8)
	else
		next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */

	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
		for (ss=0 ; ss < SSLIMIT ; ss++) {
    6c5c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    6c60:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    6c64:	0f 8e 92 f9 ff ff    	jle    65fc <III_dequantize_sample+0xb4>
		}
	else
		next_cb_boundary=sfBandIndex[sfreq].l[1];  /* LONG blocks: 0,1,3 */

	/* apply formula per block type */
	for (sb=0 ; sb < SBLIMIT ; sb++) {
    6c6a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    6c6e:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    6c72:	0f 8e 78 f9 ff ff    	jle    65f0 <III_dequantize_sample+0xa8>
			sign = (is[sb][ss]<0) ? 1 : 0;
			xr[sb][ss] *= pow( (double) abs(is[sb][ss]), ((double)4.0/3.0) );
			if (sign) xr[sb][ss] = -xr[sb][ss];
		}
	}
}
    6c78:	90                   	nop
    6c79:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    6c7c:	c9                   	leave  
    6c7d:	c3                   	ret    

00006c7e <III_reorder>:


void III_reorder(double xr[SBLIMIT][SSLIMIT], double ro[SBLIMIT][SSLIMIT], struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
    6c7e:	55                   	push   %ebp
    6c7f:	89 e5                	mov    %esp,%ebp
    6c81:	57                   	push   %edi
    6c82:	56                   	push   %esi
    6c83:	53                   	push   %ebx
    6c84:	83 ec 34             	sub    $0x34,%esp
   int sfreq=fr_ps->header->sampling_frequency;
    6c87:	8b 45 14             	mov    0x14(%ebp),%eax
    6c8a:	8b 00                	mov    (%eax),%eax
    6c8c:	8b 40 10             	mov    0x10(%eax),%eax
    6c8f:	89 45 d0             	mov    %eax,-0x30(%ebp)
   int sfb, sfb_start, sfb_lines;
   int sb, ss, window, freq, src_line, des_line;

   for(sb=0;sb<SBLIMIT;sb++)
    6c92:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    6c99:	eb 33                	jmp    6cce <III_reorder+0x50>
      for(ss=0;ss<SSLIMIT;ss++)
    6c9b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    6ca2:	eb 20                	jmp    6cc4 <III_reorder+0x46>
         ro[sb][ss] = 0;
    6ca4:	8b 55 e0             	mov    -0x20(%ebp),%edx
    6ca7:	89 d0                	mov    %edx,%eax
    6ca9:	c1 e0 03             	shl    $0x3,%eax
    6cac:	01 d0                	add    %edx,%eax
    6cae:	c1 e0 04             	shl    $0x4,%eax
    6cb1:	89 c2                	mov    %eax,%edx
    6cb3:	8b 45 0c             	mov    0xc(%ebp),%eax
    6cb6:	01 c2                	add    %eax,%edx
    6cb8:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6cbb:	d9 ee                	fldz   
    6cbd:	dd 1c c2             	fstpl  (%edx,%eax,8)
   int sfreq=fr_ps->header->sampling_frequency;
   int sfb, sfb_start, sfb_lines;
   int sb, ss, window, freq, src_line, des_line;

   for(sb=0;sb<SBLIMIT;sb++)
      for(ss=0;ss<SSLIMIT;ss++)
    6cc0:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    6cc4:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    6cc8:	7e da                	jle    6ca4 <III_reorder+0x26>
{
   int sfreq=fr_ps->header->sampling_frequency;
   int sfb, sfb_start, sfb_lines;
   int sb, ss, window, freq, src_line, des_line;

   for(sb=0;sb<SBLIMIT;sb++)
    6cca:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    6cce:	83 7d e0 1f          	cmpl   $0x1f,-0x20(%ebp)
    6cd2:	7e c7                	jle    6c9b <III_reorder+0x1d>
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
    6cd4:	8b 45 10             	mov    0x10(%ebp),%eax
    6cd7:	8b 40 10             	mov    0x10(%eax),%eax
    6cda:	85 c0                	test   %eax,%eax
    6cdc:	0f 84 ac 03 00 00    	je     708e <III_reorder+0x410>
    6ce2:	8b 45 10             	mov    0x10(%ebp),%eax
    6ce5:	8b 40 14             	mov    0x14(%eax),%eax
    6ce8:	83 f8 02             	cmp    $0x2,%eax
    6ceb:	0f 85 9d 03 00 00    	jne    708e <III_reorder+0x410>
      if (gr_info->mixed_block_flag) {
    6cf1:	8b 45 10             	mov    0x10(%ebp),%eax
    6cf4:	8b 40 18             	mov    0x18(%eax),%eax
    6cf7:	85 c0                	test   %eax,%eax
    6cf9:	0f 84 fe 01 00 00    	je     6efd <III_reorder+0x27f>
         for (sb=0 ; sb < 2 ; sb++)
    6cff:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    6d06:	eb 4c                	jmp    6d54 <III_reorder+0xd6>
            for (ss=0 ; ss < SSLIMIT ; ss++) {
    6d08:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    6d0f:	eb 39                	jmp    6d4a <III_reorder+0xcc>
               ro[sb][ss] = xr[sb][ss];
    6d11:	8b 55 e0             	mov    -0x20(%ebp),%edx
    6d14:	89 d0                	mov    %edx,%eax
    6d16:	c1 e0 03             	shl    $0x3,%eax
    6d19:	01 d0                	add    %edx,%eax
    6d1b:	c1 e0 04             	shl    $0x4,%eax
    6d1e:	89 c2                	mov    %eax,%edx
    6d20:	8b 45 0c             	mov    0xc(%ebp),%eax
    6d23:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    6d26:	8b 55 e0             	mov    -0x20(%ebp),%edx
    6d29:	89 d0                	mov    %edx,%eax
    6d2b:	c1 e0 03             	shl    $0x3,%eax
    6d2e:	01 d0                	add    %edx,%eax
    6d30:	c1 e0 04             	shl    $0x4,%eax
    6d33:	89 c2                	mov    %eax,%edx
    6d35:	8b 45 08             	mov    0x8(%ebp),%eax
    6d38:	01 c2                	add    %eax,%edx
    6d3a:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6d3d:	dd 04 c2             	fldl   (%edx,%eax,8)
    6d40:	8b 45 dc             	mov    -0x24(%ebp),%eax
    6d43:	dd 1c c1             	fstpl  (%ecx,%eax,8)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
            for (ss=0 ; ss < SSLIMIT ; ss++) {
    6d46:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    6d4a:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    6d4e:	7e c1                	jle    6d11 <III_reorder+0x93>
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
    6d50:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    6d54:	83 7d e0 01          	cmpl   $0x1,-0x20(%ebp)
    6d58:	7e ae                	jle    6d08 <III_reorder+0x8a>
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
    6d5a:	c7 45 ec 03 00 00 00 	movl   $0x3,-0x14(%ebp)
    6d61:	8b 45 d0             	mov    -0x30(%ebp),%eax
    6d64:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    6d6a:	05 88 c9 00 00       	add    $0xc988,%eax
    6d6f:	8b 00                	mov    (%eax),%eax
    6d71:	89 45 e8             	mov    %eax,-0x18(%ebp)
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
    6d74:	8b 45 d0             	mov    -0x30(%ebp),%eax
    6d77:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    6d7d:	05 8c c9 00 00       	add    $0xc98c,%eax
    6d82:	8b 00                	mov    (%eax),%eax
    6d84:	2b 45 e8             	sub    -0x18(%ebp),%eax
    6d87:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
    6d8a:	e9 5f 01 00 00       	jmp    6eee <III_reorder+0x270>
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    6d8f:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    6d96:	e9 fd 00 00 00       	jmp    6e98 <III_reorder+0x21a>
                  for(freq=0;freq<sfb_lines;freq++) {
    6d9b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    6da2:	e9 e1 00 00 00       	jmp    6e88 <III_reorder+0x20a>
                     src_line = sfb_start*3 + window*sfb_lines + freq;
    6da7:	8b 55 e8             	mov    -0x18(%ebp),%edx
    6daa:	89 d0                	mov    %edx,%eax
    6dac:	01 c0                	add    %eax,%eax
    6dae:	01 c2                	add    %eax,%edx
    6db0:	8b 45 d8             	mov    -0x28(%ebp),%eax
    6db3:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    6db7:	01 c2                	add    %eax,%edx
    6db9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    6dbc:	01 d0                	add    %edx,%eax
    6dbe:	89 45 cc             	mov    %eax,-0x34(%ebp)
                     des_line = (sfb_start*3) + window + (freq*3);
    6dc1:	8b 55 e8             	mov    -0x18(%ebp),%edx
    6dc4:	89 d0                	mov    %edx,%eax
    6dc6:	01 c0                	add    %eax,%eax
    6dc8:	01 c2                	add    %eax,%edx
    6dca:	8b 45 d8             	mov    -0x28(%ebp),%eax
    6dcd:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    6dd0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    6dd3:	89 d0                	mov    %edx,%eax
    6dd5:	01 c0                	add    %eax,%eax
    6dd7:	01 d0                	add    %edx,%eax
    6dd9:	01 c8                	add    %ecx,%eax
    6ddb:	89 45 c8             	mov    %eax,-0x38(%ebp)
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    6dde:	8b 4d c8             	mov    -0x38(%ebp),%ecx
    6de1:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6de6:	89 c8                	mov    %ecx,%eax
    6de8:	f7 ea                	imul   %edx
    6dea:	c1 fa 02             	sar    $0x2,%edx
    6ded:	89 c8                	mov    %ecx,%eax
    6def:	c1 f8 1f             	sar    $0x1f,%eax
    6df2:	29 c2                	sub    %eax,%edx
    6df4:	89 d0                	mov    %edx,%eax
    6df6:	89 c2                	mov    %eax,%edx
    6df8:	89 d0                	mov    %edx,%eax
    6dfa:	c1 e0 03             	shl    $0x3,%eax
    6dfd:	01 d0                	add    %edx,%eax
    6dff:	c1 e0 04             	shl    $0x4,%eax
    6e02:	89 c2                	mov    %eax,%edx
    6e04:	8b 45 0c             	mov    0xc(%ebp),%eax
    6e07:	8d 34 02             	lea    (%edx,%eax,1),%esi
    6e0a:	8b 5d c8             	mov    -0x38(%ebp),%ebx
    6e0d:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6e12:	89 d8                	mov    %ebx,%eax
    6e14:	f7 ea                	imul   %edx
    6e16:	c1 fa 02             	sar    $0x2,%edx
    6e19:	89 d8                	mov    %ebx,%eax
    6e1b:	c1 f8 1f             	sar    $0x1f,%eax
    6e1e:	89 d1                	mov    %edx,%ecx
    6e20:	29 c1                	sub    %eax,%ecx
    6e22:	89 c8                	mov    %ecx,%eax
    6e24:	c1 e0 03             	shl    $0x3,%eax
    6e27:	01 c8                	add    %ecx,%eax
    6e29:	01 c0                	add    %eax,%eax
    6e2b:	29 c3                	sub    %eax,%ebx
    6e2d:	89 d9                	mov    %ebx,%ecx
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
    6e2f:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    6e32:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6e37:	89 d8                	mov    %ebx,%eax
    6e39:	f7 ea                	imul   %edx
    6e3b:	c1 fa 02             	sar    $0x2,%edx
    6e3e:	89 d8                	mov    %ebx,%eax
    6e40:	c1 f8 1f             	sar    $0x1f,%eax
    6e43:	29 c2                	sub    %eax,%edx
    6e45:	89 d0                	mov    %edx,%eax
    6e47:	89 c2                	mov    %eax,%edx
    6e49:	89 d0                	mov    %edx,%eax
    6e4b:	c1 e0 03             	shl    $0x3,%eax
    6e4e:	01 d0                	add    %edx,%eax
    6e50:	c1 e0 04             	shl    $0x4,%eax
    6e53:	89 c2                	mov    %eax,%edx
    6e55:	8b 45 08             	mov    0x8(%ebp),%eax
    6e58:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    6e5b:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    6e5e:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6e63:	89 d8                	mov    %ebx,%eax
    6e65:	f7 ea                	imul   %edx
    6e67:	c1 fa 02             	sar    $0x2,%edx
    6e6a:	89 d8                	mov    %ebx,%eax
    6e6c:	c1 f8 1f             	sar    $0x1f,%eax
    6e6f:	29 c2                	sub    %eax,%edx
    6e71:	89 d0                	mov    %edx,%eax
    6e73:	c1 e0 03             	shl    $0x3,%eax
    6e76:	01 d0                	add    %edx,%eax
    6e78:	01 c0                	add    %eax,%eax
    6e7a:	29 c3                	sub    %eax,%ebx
    6e7c:	89 da                	mov    %ebx,%edx
    6e7e:	dd 04 d7             	fldl   (%edi,%edx,8)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
                     src_line = sfb_start*3 + window*sfb_lines + freq;
                     des_line = (sfb_start*3) + window + (freq*3);
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    6e81:	dd 1c ce             	fstpl  (%esi,%ecx,8)
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
    6e84:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    6e88:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    6e8b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    6e8e:	0f 8c 13 ff ff ff    	jl     6da7 <III_reorder+0x129>
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    6e94:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    6e98:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
    6e9c:	0f 8e f9 fe ff ff    	jle    6d9b <III_reorder+0x11d>
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
            sfb_lines=sfBandIndex[sfreq].s[4] - sfb_start;
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
    6ea2:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    6ea6:	8b 55 d0             	mov    -0x30(%ebp),%edx
    6ea9:	89 d0                	mov    %edx,%eax
    6eab:	c1 e0 03             	shl    $0x3,%eax
    6eae:	01 d0                	add    %edx,%eax
    6eb0:	c1 e0 02             	shl    $0x2,%eax
    6eb3:	01 d0                	add    %edx,%eax
    6eb5:	8b 55 ec             	mov    -0x14(%ebp),%edx
    6eb8:	01 d0                	add    %edx,%eax
    6eba:	83 c0 14             	add    $0x14,%eax
    6ebd:	8b 04 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%eax
    6ec4:	89 45 e8             	mov    %eax,-0x18(%ebp)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
    6ec7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    6eca:	8d 48 01             	lea    0x1(%eax),%ecx
    6ecd:	8b 55 d0             	mov    -0x30(%ebp),%edx
    6ed0:	89 d0                	mov    %edx,%eax
    6ed2:	c1 e0 03             	shl    $0x3,%eax
    6ed5:	01 d0                	add    %edx,%eax
    6ed7:	c1 e0 02             	shl    $0x2,%eax
    6eda:	01 d0                	add    %edx,%eax
    6edc:	01 c8                	add    %ecx,%eax
    6ede:	83 c0 14             	add    $0x14,%eax
    6ee1:	8b 04 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%eax
    6ee8:	2b 45 e8             	sub    -0x18(%ebp),%eax
    6eeb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if (gr_info->mixed_block_flag) {
         for (sb=0 ; sb < 2 ; sb++)
            for (ss=0 ; ss < SSLIMIT ; ss++) {
               ro[sb][ss] = xr[sb][ss];
            }
         for(sfb=3,sfb_start=sfBandIndex[sfreq].s[3],
    6eee:	83 7d ec 0c          	cmpl   $0xc,-0x14(%ebp)
    6ef2:	0f 8e 97 fe ff ff    	jle    6d8f <III_reorder+0x111>
   for(sb=0;sb<SBLIMIT;sb++)
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
    6ef8:	e9 ec 01 00 00       	jmp    70e9 <III_reorder+0x46b>
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
    6efd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    6f04:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    6f0b:	8b 45 d0             	mov    -0x30(%ebp),%eax
    6f0e:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    6f14:	05 80 c9 00 00       	add    $0xc980,%eax
    6f19:	8b 00                	mov    (%eax),%eax
    6f1b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    6f1e:	e9 5f 01 00 00       	jmp    7082 <III_reorder+0x404>
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    6f23:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    6f2a:	e9 fd 00 00 00       	jmp    702c <III_reorder+0x3ae>
                  for(freq=0;freq<sfb_lines;freq++) {
    6f2f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    6f36:	e9 e1 00 00 00       	jmp    701c <III_reorder+0x39e>
                     src_line = sfb_start*3 + window*sfb_lines + freq;
    6f3b:	8b 55 e8             	mov    -0x18(%ebp),%edx
    6f3e:	89 d0                	mov    %edx,%eax
    6f40:	01 c0                	add    %eax,%eax
    6f42:	01 c2                	add    %eax,%edx
    6f44:	8b 45 d8             	mov    -0x28(%ebp),%eax
    6f47:	0f af 45 e4          	imul   -0x1c(%ebp),%eax
    6f4b:	01 c2                	add    %eax,%edx
    6f4d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    6f50:	01 d0                	add    %edx,%eax
    6f52:	89 45 cc             	mov    %eax,-0x34(%ebp)
                     des_line = (sfb_start*3) + window + (freq*3);
    6f55:	8b 55 e8             	mov    -0x18(%ebp),%edx
    6f58:	89 d0                	mov    %edx,%eax
    6f5a:	01 c0                	add    %eax,%eax
    6f5c:	01 c2                	add    %eax,%edx
    6f5e:	8b 45 d8             	mov    -0x28(%ebp),%eax
    6f61:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    6f64:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    6f67:	89 d0                	mov    %edx,%eax
    6f69:	01 c0                	add    %eax,%eax
    6f6b:	01 d0                	add    %edx,%eax
    6f6d:	01 c8                	add    %ecx,%eax
    6f6f:	89 45 c8             	mov    %eax,-0x38(%ebp)
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    6f72:	8b 4d c8             	mov    -0x38(%ebp),%ecx
    6f75:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6f7a:	89 c8                	mov    %ecx,%eax
    6f7c:	f7 ea                	imul   %edx
    6f7e:	c1 fa 02             	sar    $0x2,%edx
    6f81:	89 c8                	mov    %ecx,%eax
    6f83:	c1 f8 1f             	sar    $0x1f,%eax
    6f86:	29 c2                	sub    %eax,%edx
    6f88:	89 d0                	mov    %edx,%eax
    6f8a:	89 c2                	mov    %eax,%edx
    6f8c:	89 d0                	mov    %edx,%eax
    6f8e:	c1 e0 03             	shl    $0x3,%eax
    6f91:	01 d0                	add    %edx,%eax
    6f93:	c1 e0 04             	shl    $0x4,%eax
    6f96:	89 c2                	mov    %eax,%edx
    6f98:	8b 45 0c             	mov    0xc(%ebp),%eax
    6f9b:	8d 34 02             	lea    (%edx,%eax,1),%esi
    6f9e:	8b 5d c8             	mov    -0x38(%ebp),%ebx
    6fa1:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6fa6:	89 d8                	mov    %ebx,%eax
    6fa8:	f7 ea                	imul   %edx
    6faa:	c1 fa 02             	sar    $0x2,%edx
    6fad:	89 d8                	mov    %ebx,%eax
    6faf:	c1 f8 1f             	sar    $0x1f,%eax
    6fb2:	89 d1                	mov    %edx,%ecx
    6fb4:	29 c1                	sub    %eax,%ecx
    6fb6:	89 c8                	mov    %ecx,%eax
    6fb8:	c1 e0 03             	shl    $0x3,%eax
    6fbb:	01 c8                	add    %ecx,%eax
    6fbd:	01 c0                	add    %eax,%eax
    6fbf:	29 c3                	sub    %eax,%ebx
    6fc1:	89 d9                	mov    %ebx,%ecx
                       xr[src_line/SSLIMIT][src_line%SSLIMIT];
    6fc3:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    6fc6:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6fcb:	89 d8                	mov    %ebx,%eax
    6fcd:	f7 ea                	imul   %edx
    6fcf:	c1 fa 02             	sar    $0x2,%edx
    6fd2:	89 d8                	mov    %ebx,%eax
    6fd4:	c1 f8 1f             	sar    $0x1f,%eax
    6fd7:	29 c2                	sub    %eax,%edx
    6fd9:	89 d0                	mov    %edx,%eax
    6fdb:	89 c2                	mov    %eax,%edx
    6fdd:	89 d0                	mov    %edx,%eax
    6fdf:	c1 e0 03             	shl    $0x3,%eax
    6fe2:	01 d0                	add    %edx,%eax
    6fe4:	c1 e0 04             	shl    $0x4,%eax
    6fe7:	89 c2                	mov    %eax,%edx
    6fe9:	8b 45 08             	mov    0x8(%ebp),%eax
    6fec:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    6fef:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    6ff2:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    6ff7:	89 d8                	mov    %ebx,%eax
    6ff9:	f7 ea                	imul   %edx
    6ffb:	c1 fa 02             	sar    $0x2,%edx
    6ffe:	89 d8                	mov    %ebx,%eax
    7000:	c1 f8 1f             	sar    $0x1f,%eax
    7003:	29 c2                	sub    %eax,%edx
    7005:	89 d0                	mov    %edx,%eax
    7007:	c1 e0 03             	shl    $0x3,%eax
    700a:	01 d0                	add    %edx,%eax
    700c:	01 c0                	add    %eax,%eax
    700e:	29 c3                	sub    %eax,%ebx
    7010:	89 da                	mov    %ebx,%edx
    7012:	dd 04 d7             	fldl   (%edi,%edx,8)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
                     src_line = sfb_start*3 + window*sfb_lines + freq;
                     des_line = (sfb_start*3) + window + (freq*3);
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
    7015:	dd 1c ce             	fstpl  (%esi,%ecx,8)
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
                  for(freq=0;freq<sfb_lines;freq++) {
    7018:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    701c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    701f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
    7022:	0f 8c 13 ff ff ff    	jl     6f3b <III_reorder+0x2bd>
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
               for(window=0; window<3; window++)
    7028:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
    702c:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
    7030:	0f 8e f9 fe ff ff    	jle    6f2f <III_reorder+0x2b1>
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
            sfb < 13; sfb++,sfb_start=sfBandIndex[sfreq].s[sfb],
    7036:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    703a:	8b 55 d0             	mov    -0x30(%ebp),%edx
    703d:	89 d0                	mov    %edx,%eax
    703f:	c1 e0 03             	shl    $0x3,%eax
    7042:	01 d0                	add    %edx,%eax
    7044:	c1 e0 02             	shl    $0x2,%eax
    7047:	01 d0                	add    %edx,%eax
    7049:	8b 55 ec             	mov    -0x14(%ebp),%edx
    704c:	01 d0                	add    %edx,%eax
    704e:	83 c0 14             	add    $0x14,%eax
    7051:	8b 04 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%eax
    7058:	89 45 e8             	mov    %eax,-0x18(%ebp)
            (sfb_lines=sfBandIndex[sfreq].s[sfb+1] - sfb_start))
    705b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    705e:	8d 48 01             	lea    0x1(%eax),%ecx
    7061:	8b 55 d0             	mov    -0x30(%ebp),%edx
    7064:	89 d0                	mov    %edx,%eax
    7066:	c1 e0 03             	shl    $0x3,%eax
    7069:	01 d0                	add    %edx,%eax
    706b:	c1 e0 02             	shl    $0x2,%eax
    706e:	01 d0                	add    %edx,%eax
    7070:	01 c8                	add    %ecx,%eax
    7072:	83 c0 14             	add    $0x14,%eax
    7075:	8b 04 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%eax
    707c:	2b 45 e8             	sub    -0x18(%ebp),%eax
    707f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                     ro[des_line/SSLIMIT][des_line%SSLIMIT] =
                                    xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
      else {
         for(sfb=0,sfb_start=0,sfb_lines=sfBandIndex[sfreq].s[1];
    7082:	83 7d ec 0c          	cmpl   $0xc,-0x14(%ebp)
    7086:	0f 8e 97 fe ff ff    	jle    6f23 <III_reorder+0x2a5>
   for(sb=0;sb<SBLIMIT;sb++)
      for(ss=0;ss<SSLIMIT;ss++)
         ro[sb][ss] = 0;

   if (gr_info->window_switching_flag && (gr_info->block_type == 2)) {
      if (gr_info->mixed_block_flag) {
    708c:	eb 5b                	jmp    70e9 <III_reorder+0x46b>
                       xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
   }
   else {   /*long blocks */
      for (sb=0 ; sb < SBLIMIT ; sb++)
    708e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    7095:	eb 4c                	jmp    70e3 <III_reorder+0x465>
         for (ss=0 ; ss < SSLIMIT ; ss++)
    7097:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    709e:	eb 39                	jmp    70d9 <III_reorder+0x45b>
            ro[sb][ss] = xr[sb][ss];
    70a0:	8b 55 e0             	mov    -0x20(%ebp),%edx
    70a3:	89 d0                	mov    %edx,%eax
    70a5:	c1 e0 03             	shl    $0x3,%eax
    70a8:	01 d0                	add    %edx,%eax
    70aa:	c1 e0 04             	shl    $0x4,%eax
    70ad:	89 c2                	mov    %eax,%edx
    70af:	8b 45 0c             	mov    0xc(%ebp),%eax
    70b2:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    70b5:	8b 55 e0             	mov    -0x20(%ebp),%edx
    70b8:	89 d0                	mov    %edx,%eax
    70ba:	c1 e0 03             	shl    $0x3,%eax
    70bd:	01 d0                	add    %edx,%eax
    70bf:	c1 e0 04             	shl    $0x4,%eax
    70c2:	89 c2                	mov    %eax,%edx
    70c4:	8b 45 08             	mov    0x8(%ebp),%eax
    70c7:	01 c2                	add    %eax,%edx
    70c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
    70cc:	dd 04 c2             	fldl   (%edx,%eax,8)
    70cf:	8b 45 dc             	mov    -0x24(%ebp),%eax
    70d2:	dd 1c c1             	fstpl  (%ecx,%eax,8)
               }
      }
   }
   else {   /*long blocks */
      for (sb=0 ; sb < SBLIMIT ; sb++)
         for (ss=0 ; ss < SSLIMIT ; ss++)
    70d5:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
    70d9:	83 7d dc 11          	cmpl   $0x11,-0x24(%ebp)
    70dd:	7e c1                	jle    70a0 <III_reorder+0x422>
                       xr[src_line/SSLIMIT][src_line%SSLIMIT];
               }
      }
   }
   else {   /*long blocks */
      for (sb=0 ; sb < SBLIMIT ; sb++)
    70df:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    70e3:	83 7d e0 1f          	cmpl   $0x1f,-0x20(%ebp)
    70e7:	7e ae                	jle    7097 <III_reorder+0x419>
         for (ss=0 ; ss < SSLIMIT ; ss++)
            ro[sb][ss] = xr[sb][ss];
   }
}
    70e9:	90                   	nop
    70ea:	83 c4 34             	add    $0x34,%esp
    70ed:	5b                   	pop    %ebx
    70ee:	5e                   	pop    %esi
    70ef:	5f                   	pop    %edi
    70f0:	5d                   	pop    %ebp
    70f1:	c3                   	ret    

000070f2 <III_stereo>:


void III_stereo(double xr[2][SBLIMIT][SSLIMIT], double lr[2][SBLIMIT][SSLIMIT], III_scalefac_t *scalefac, struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
    70f2:	55                   	push   %ebp
    70f3:	89 e5                	mov    %esp,%ebp
    70f5:	56                   	push   %esi
    70f6:	53                   	push   %ebx
    70f7:	81 ec 50 1b 00 00    	sub    $0x1b50,%esp
   int sfreq = fr_ps->header->sampling_frequency;
    70fd:	8b 45 18             	mov    0x18(%ebp),%eax
    7100:	8b 00                	mov    (%eax),%eax
    7102:	8b 40 10             	mov    0x10(%eax),%eax
    7105:	89 45 c8             	mov    %eax,-0x38(%ebp)
   int stereo = fr_ps->stereo;
    7108:	8b 45 18             	mov    0x18(%ebp),%eax
    710b:	8b 40 08             	mov    0x8(%eax),%eax
    710e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
   int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    7111:	8b 45 18             	mov    0x18(%ebp),%eax
    7114:	8b 00                	mov    (%eax),%eax
    7116:	8b 40 1c             	mov    0x1c(%eax),%eax
    7119:	83 f8 01             	cmp    $0x1,%eax
    711c:	75 16                	jne    7134 <III_stereo+0x42>
                   (fr_ps->header->mode_ext & 0x2);
    711e:	8b 45 18             	mov    0x18(%ebp),%eax
    7121:	8b 00                	mov    (%eax),%eax
    7123:	8b 40 20             	mov    0x20(%eax),%eax
    7126:	83 e0 02             	and    $0x2,%eax

void III_stereo(double xr[2][SBLIMIT][SSLIMIT], double lr[2][SBLIMIT][SSLIMIT], III_scalefac_t *scalefac, struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
   int sfreq = fr_ps->header->sampling_frequency;
   int stereo = fr_ps->stereo;
   int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    7129:	85 c0                	test   %eax,%eax
    712b:	74 07                	je     7134 <III_stereo+0x42>
    712d:	b8 01 00 00 00       	mov    $0x1,%eax
    7132:	eb 05                	jmp    7139 <III_stereo+0x47>
    7134:	b8 00 00 00 00       	mov    $0x0,%eax
    7139:	89 45 c0             	mov    %eax,-0x40(%ebp)
                   (fr_ps->header->mode_ext & 0x2);
   int i_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    713c:	8b 45 18             	mov    0x18(%ebp),%eax
    713f:	8b 00                	mov    (%eax),%eax
    7141:	8b 40 1c             	mov    0x1c(%eax),%eax
    7144:	83 f8 01             	cmp    $0x1,%eax
    7147:	75 16                	jne    715f <III_stereo+0x6d>
                  (fr_ps->header->mode_ext & 0x1);
    7149:	8b 45 18             	mov    0x18(%ebp),%eax
    714c:	8b 00                	mov    (%eax),%eax
    714e:	8b 40 20             	mov    0x20(%eax),%eax
    7151:	83 e0 01             	and    $0x1,%eax
{
   int sfreq = fr_ps->header->sampling_frequency;
   int stereo = fr_ps->stereo;
   int ms_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
                   (fr_ps->header->mode_ext & 0x2);
   int i_stereo = (fr_ps->header->mode == MPG_MD_JOINT_STEREO) &&
    7154:	85 c0                	test   %eax,%eax
    7156:	74 07                	je     715f <III_stereo+0x6d>
    7158:	b8 01 00 00 00       	mov    $0x1,%eax
    715d:	eb 05                	jmp    7164 <III_stereo+0x72>
    715f:	b8 00 00 00 00       	mov    $0x0,%eax
    7164:	89 45 bc             	mov    %eax,-0x44(%ebp)
   int sfb;
   int i,j,sb,ss,ch,is_pos[576];
   double is_ratio[576];

   /* intialization */
   for ( i=0; i<576; i++ )
    7167:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    716e:	eb 12                	jmp    7182 <III_stereo+0x90>
      is_pos[i] = 7;
    7170:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7173:	c7 84 85 bc f6 ff ff 	movl   $0x7,-0x944(%ebp,%eax,4)
    717a:	07 00 00 00 
   int sfb;
   int i,j,sb,ss,ch,is_pos[576];
   double is_ratio[576];

   /* intialization */
   for ( i=0; i<576; i++ )
    717e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    7182:	81 7d f0 3f 02 00 00 	cmpl   $0x23f,-0x10(%ebp)
    7189:	7e e5                	jle    7170 <III_stereo+0x7e>
      is_pos[i] = 7;

   if ((stereo == 2) && i_stereo )
    718b:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
    718f:	0f 85 36 0a 00 00    	jne    7bcb <III_stereo+0xad9>
    7195:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
    7199:	0f 84 2c 0a 00 00    	je     7bcb <III_stereo+0xad9>
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
    719f:	8b 45 14             	mov    0x14(%ebp),%eax
    71a2:	8b 40 10             	mov    0x10(%eax),%eax
    71a5:	85 c0                	test   %eax,%eax
    71a7:	0f 84 21 08 00 00    	je     79ce <III_stereo+0x8dc>
    71ad:	8b 45 14             	mov    0x14(%ebp),%eax
    71b0:	8b 40 14             	mov    0x14(%eax),%eax
    71b3:	83 f8 02             	cmp    $0x2,%eax
    71b6:	0f 85 12 08 00 00    	jne    79ce <III_stereo+0x8dc>
      {  if( gr_info->mixed_block_flag )
    71bc:	8b 45 14             	mov    0x14(%ebp),%eax
    71bf:	8b 40 18             	mov    0x18(%eax),%eax
    71c2:	85 c0                	test   %eax,%eax
    71c4:	0f 84 dd 04 00 00    	je     76a7 <III_stereo+0x5b5>
         {  int max_sfb = 0;
    71ca:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)

            for ( j=0; j<3; j++ )
    71d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    71d8:	e9 1e 03 00 00       	jmp    74fb <III_stereo+0x409>
            {  int sfbcnt;
               sfbcnt = 2;
    71dd:	c7 45 d8 02 00 00 00 	movl   $0x2,-0x28(%ebp)
               for( sfb=12; sfb >=3; sfb-- )
    71e4:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    71eb:	e9 0f 01 00 00       	jmp    72ff <III_stereo+0x20d>
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    71f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    71f3:	8d 48 01             	lea    0x1(%eax),%ecx
    71f6:	8b 55 c8             	mov    -0x38(%ebp),%edx
    71f9:	89 d0                	mov    %edx,%eax
    71fb:	c1 e0 03             	shl    $0x3,%eax
    71fe:	01 d0                	add    %edx,%eax
    7200:	c1 e0 02             	shl    $0x2,%eax
    7203:	01 d0                	add    %edx,%eax
    7205:	01 c8                	add    %ecx,%eax
    7207:	83 c0 14             	add    $0x14,%eax
    720a:	8b 0c 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%ecx
    7211:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7214:	89 d0                	mov    %edx,%eax
    7216:	c1 e0 03             	shl    $0x3,%eax
    7219:	01 d0                	add    %edx,%eax
    721b:	c1 e0 02             	shl    $0x2,%eax
    721e:	01 d0                	add    %edx,%eax
    7220:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7223:	01 d0                	add    %edx,%eax
    7225:	83 c0 14             	add    $0x14,%eax
    7228:	8b 04 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%eax
    722f:	29 c1                	sub    %eax,%ecx
    7231:	89 c8                	mov    %ecx,%eax
    7233:	89 45 d4             	mov    %eax,-0x2c(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
    7236:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7239:	89 d0                	mov    %edx,%eax
    723b:	c1 e0 03             	shl    $0x3,%eax
    723e:	01 d0                	add    %edx,%eax
    7240:	c1 e0 02             	shl    $0x2,%eax
    7243:	01 d0                	add    %edx,%eax
    7245:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7248:	01 d0                	add    %edx,%eax
    724a:	83 c0 14             	add    $0x14,%eax
    724d:	8b 14 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%edx
    7254:	89 d0                	mov    %edx,%eax
    7256:	01 c0                	add    %eax,%eax
    7258:	01 c2                	add    %eax,%edx
    725a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    725d:	83 c0 01             	add    $0x1,%eax
    7260:	0f af 45 d4          	imul   -0x2c(%ebp),%eax
    7264:	01 d0                	add    %edx,%eax
    7266:	83 e8 01             	sub    $0x1,%eax
    7269:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  while ( lines > 0 )
    726c:	e9 80 00 00 00       	jmp    72f1 <III_stereo+0x1ff>
                  {  if ( xr[1][i/SSLIMIT][i%SSLIMIT] != 0.0 )
    7271:	8b 45 08             	mov    0x8(%ebp),%eax
    7274:	8d b0 00 12 00 00    	lea    0x1200(%eax),%esi
    727a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    727d:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    7282:	89 c8                	mov    %ecx,%eax
    7284:	f7 ea                	imul   %edx
    7286:	c1 fa 02             	sar    $0x2,%edx
    7289:	89 c8                	mov    %ecx,%eax
    728b:	c1 f8 1f             	sar    $0x1f,%eax
    728e:	89 d3                	mov    %edx,%ebx
    7290:	29 c3                	sub    %eax,%ebx
    7292:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    7295:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    729a:	89 c8                	mov    %ecx,%eax
    729c:	f7 ea                	imul   %edx
    729e:	c1 fa 02             	sar    $0x2,%edx
    72a1:	89 c8                	mov    %ecx,%eax
    72a3:	c1 f8 1f             	sar    $0x1f,%eax
    72a6:	29 c2                	sub    %eax,%edx
    72a8:	89 d0                	mov    %edx,%eax
    72aa:	c1 e0 03             	shl    $0x3,%eax
    72ad:	01 d0                	add    %edx,%eax
    72af:	01 c0                	add    %eax,%eax
    72b1:	29 c1                	sub    %eax,%ecx
    72b3:	89 ca                	mov    %ecx,%edx
    72b5:	89 d8                	mov    %ebx,%eax
    72b7:	c1 e0 03             	shl    $0x3,%eax
    72ba:	01 d8                	add    %ebx,%eax
    72bc:	01 c0                	add    %eax,%eax
    72be:	01 d0                	add    %edx,%eax
    72c0:	dd 04 c6             	fldl   (%esi,%eax,8)
    72c3:	d9 ee                	fldz   
    72c5:	df e9                	fucomip %st(1),%st
    72c7:	7a 0a                	jp     72d3 <III_stereo+0x1e1>
    72c9:	d9 ee                	fldz   
    72cb:	df e9                	fucomip %st(1),%st
    72cd:	dd d8                	fstp   %st(0)
    72cf:	74 18                	je     72e9 <III_stereo+0x1f7>
    72d1:	eb 02                	jmp    72d5 <III_stereo+0x1e3>
    72d3:	dd d8                	fstp   %st(0)
                     {  sfbcnt = sfb;
    72d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    72d8:	89 45 d8             	mov    %eax,-0x28(%ebp)
                        sfb = -10;
    72db:	c7 45 f4 f6 ff ff ff 	movl   $0xfffffff6,-0xc(%ebp)
                        lines = -10;
    72e2:	c7 45 d4 f6 ff ff ff 	movl   $0xfffffff6,-0x2c(%ebp)
                     }
                     lines--;
    72e9:	83 6d d4 01          	subl   $0x1,-0x2c(%ebp)
                     i--;
    72ed:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
               sfbcnt = 2;
               for( sfb=12; sfb >=3; sfb-- )
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
                  while ( lines > 0 )
    72f1:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
    72f5:	0f 8f 76 ff ff ff    	jg     7271 <III_stereo+0x17f>
         {  int max_sfb = 0;

            for ( j=0; j<3; j++ )
            {  int sfbcnt;
               sfbcnt = 2;
               for( sfb=12; sfb >=3; sfb-- )
    72fb:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    72ff:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
    7303:	0f 8f e7 fe ff ff    	jg     71f0 <III_stereo+0xfe>
                     }
                     lines--;
                     i--;
                  }
               }
               sfb = sfbcnt + 1;
    7309:	8b 45 d8             	mov    -0x28(%ebp),%eax
    730c:	83 c0 01             	add    $0x1,%eax
    730f:	89 45 f4             	mov    %eax,-0xc(%ebp)

               if ( sfb > max_sfb )
    7312:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7315:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    7318:	0f 8e 05 01 00 00    	jle    7423 <III_stereo+0x331>
                  max_sfb = sfb;
    731e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7321:	89 45 dc             	mov    %eax,-0x24(%ebp)

               while( sfb<12 )
    7324:	e9 fa 00 00 00       	jmp    7423 <III_stereo+0x331>
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    7329:	8b 45 f4             	mov    -0xc(%ebp),%eax
    732c:	8d 48 01             	lea    0x1(%eax),%ecx
    732f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7332:	89 d0                	mov    %edx,%eax
    7334:	c1 e0 03             	shl    $0x3,%eax
    7337:	01 d0                	add    %edx,%eax
    7339:	c1 e0 02             	shl    $0x2,%eax
    733c:	01 d0                	add    %edx,%eax
    733e:	01 c8                	add    %ecx,%eax
    7340:	83 c0 14             	add    $0x14,%eax
    7343:	8b 0c 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%ecx
    734a:	8b 55 c8             	mov    -0x38(%ebp),%edx
    734d:	89 d0                	mov    %edx,%eax
    734f:	c1 e0 03             	shl    $0x3,%eax
    7352:	01 d0                	add    %edx,%eax
    7354:	c1 e0 02             	shl    $0x2,%eax
    7357:	01 d0                	add    %edx,%eax
    7359:	8b 55 f4             	mov    -0xc(%ebp),%edx
    735c:	01 d0                	add    %edx,%eax
    735e:	83 c0 14             	add    $0x14,%eax
    7361:	8b 04 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%eax
    7368:	29 c1                	sub    %eax,%ecx
    736a:	89 c8                	mov    %ecx,%eax
    736c:	89 45 e8             	mov    %eax,-0x18(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
    736f:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7372:	89 d0                	mov    %edx,%eax
    7374:	c1 e0 03             	shl    $0x3,%eax
    7377:	01 d0                	add    %edx,%eax
    7379:	c1 e0 02             	shl    $0x2,%eax
    737c:	01 d0                	add    %edx,%eax
    737e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7381:	01 d0                	add    %edx,%eax
    7383:	83 c0 14             	add    $0x14,%eax
    7386:	8b 14 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%edx
    738d:	89 d0                	mov    %edx,%eax
    738f:	01 c0                	add    %eax,%eax
    7391:	01 c2                	add    %eax,%edx
    7393:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7396:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    739a:	01 d0                	add    %edx,%eax
    739c:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  for ( ; sb > 0; sb--)
    739f:	eb 78                	jmp    7419 <III_stereo+0x327>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
    73a1:	8b 4d 10             	mov    0x10(%ebp),%ecx
    73a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
    73a7:	89 d0                	mov    %edx,%eax
    73a9:	01 c0                	add    %eax,%eax
    73ab:	01 d0                	add    %edx,%eax
    73ad:	c1 e0 02             	shl    $0x2,%eax
    73b0:	01 d0                	add    %edx,%eax
    73b2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    73b5:	01 d0                	add    %edx,%eax
    73b7:	83 c0 52             	add    $0x52,%eax
    73ba:	8b 54 81 0c          	mov    0xc(%ecx,%eax,4),%edx
    73be:	8b 45 f0             	mov    -0x10(%ebp),%eax
    73c1:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                     if ( is_pos[i] != 7 )
    73c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    73cb:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    73d2:	83 f8 07             	cmp    $0x7,%eax
    73d5:	74 3a                	je     7411 <III_stereo+0x31f>
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
    73d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    73da:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    73e1:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    73e7:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    73ed:	dd 05 80 b7 00 00    	fldl   0xb780
    73f3:	de c9                	fmulp  %st,%st(1)
    73f5:	83 ec 08             	sub    $0x8,%esp
    73f8:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    73fc:	dd 1c 24             	fstpl  (%esp)
    73ff:	e8 84 b6 ff ff       	call   2a88 <tan>
    7404:	83 c4 10             	add    $0x10,%esp
    7407:	8b 45 f0             	mov    -0x10(%ebp),%eax
    740a:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                     i++;
    7411:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                  max_sfb = sfb;

               while( sfb<12 )
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
                  for ( ; sb > 0; sb--)
    7415:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    7419:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    741d:	7f 82                	jg     73a1 <III_stereo+0x2af>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
                     if ( is_pos[i] != 7 )
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
                     i++;
                  }
                  sfb++;
    741f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
               sfb = sfbcnt + 1;

               if ( sfb > max_sfb )
                  max_sfb = sfb;

               while( sfb<12 )
    7423:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    7427:	0f 8e fc fe ff ff    	jle    7329 <III_stereo+0x237>
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
                     i++;
                  }
                  sfb++;
               }
               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
    742d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7430:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7436:	05 a8 c9 00 00       	add    $0xc9a8,%eax
    743b:	8b 10                	mov    (%eax),%edx
    743d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7440:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7446:	05 a4 c9 00 00       	add    $0xc9a4,%eax
    744b:	8b 00                	mov    (%eax),%eax
    744d:	29 c2                	sub    %eax,%edx
    744f:	89 d0                	mov    %edx,%eax
    7451:	89 45 e8             	mov    %eax,-0x18(%ebp)
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
    7454:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7457:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    745d:	05 a4 c9 00 00       	add    $0xc9a4,%eax
    7462:	8b 10                	mov    (%eax),%edx
    7464:	89 d0                	mov    %edx,%eax
    7466:	01 c0                	add    %eax,%eax
    7468:	01 c2                	add    %eax,%edx
    746a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    746d:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    7471:	01 d0                	add    %edx,%eax
    7473:	89 45 f4             	mov    %eax,-0xc(%ebp)
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
    7476:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7479:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    747f:	05 ac c9 00 00       	add    $0xc9ac,%eax
    7484:	8b 10                	mov    (%eax),%edx
    7486:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7489:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    748f:	05 a8 c9 00 00       	add    $0xc9a8,%eax
    7494:	8b 00                	mov    (%eax),%eax
    7496:	29 c2                	sub    %eax,%edx
    7498:	89 d0                	mov    %edx,%eax
    749a:	89 45 e8             	mov    %eax,-0x18(%ebp)
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
    749d:	8b 45 c8             	mov    -0x38(%ebp),%eax
    74a0:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    74a6:	05 a8 c9 00 00       	add    $0xc9a8,%eax
    74ab:	8b 10                	mov    (%eax),%edx
    74ad:	89 d0                	mov    %edx,%eax
    74af:	01 c0                	add    %eax,%eax
    74b1:	01 c2                	add    %eax,%edx
    74b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    74b6:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    74ba:	01 d0                	add    %edx,%eax
    74bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
               for ( ; sb > 0; sb-- )
    74bf:	eb 30                	jmp    74f1 <III_stereo+0x3ff>
               {  is_pos[i] = is_pos[sfb];
    74c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    74c4:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    74cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    74ce:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                  is_ratio[i] = is_ratio[sfb];
    74d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    74d8:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    74df:	8b 45 f0             	mov    -0x10(%ebp),%eax
    74e2:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                  i++;
    74e9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
               }
               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
               for ( ; sb > 0; sb-- )
    74ed:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    74f1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    74f5:	7f ca                	jg     74c1 <III_stereo+0x3cf>
   if ((stereo == 2) && i_stereo )
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
      {  if( gr_info->mixed_block_flag )
         {  int max_sfb = 0;

            for ( j=0; j<3; j++ )
    74f7:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    74fb:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    74ff:	0f 8e d8 fc ff ff    	jle    71dd <III_stereo+0xeb>
               {  is_pos[i] = is_pos[sfb];
                  is_ratio[i] = is_ratio[sfb];
                  i++;
               }
             }
             if ( max_sfb <= 3 )
    7505:	83 7d dc 03          	cmpl   $0x3,-0x24(%ebp)
    7509:	0f 8f bb 06 00 00    	jg     7bca <III_stereo+0xad8>
             {  i = 2;
    750f:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
                ss = 17;
    7516:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
                sb = -1;
    751d:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
                while ( i >= 0 )
    7524:	eb 63                	jmp    7589 <III_stereo+0x497>
                {  if ( xr[1][i][ss] != 0.0 )
    7526:	8b 45 08             	mov    0x8(%ebp),%eax
    7529:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    752f:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7532:	89 d0                	mov    %edx,%eax
    7534:	c1 e0 03             	shl    $0x3,%eax
    7537:	01 d0                	add    %edx,%eax
    7539:	01 c0                	add    %eax,%eax
    753b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    753e:	01 d0                	add    %edx,%eax
    7540:	dd 04 c1             	fldl   (%ecx,%eax,8)
    7543:	d9 ee                	fldz   
    7545:	df e9                	fucomip %st(1),%st
    7547:	7a 0a                	jp     7553 <III_stereo+0x461>
    7549:	d9 ee                	fldz   
    754b:	df e9                	fucomip %st(1),%st
    754d:	dd d8                	fstp   %st(0)
    754f:	74 23                	je     7574 <III_stereo+0x482>
    7551:	eb 02                	jmp    7555 <III_stereo+0x463>
    7553:	dd d8                	fstp   %st(0)
                   {  sb = i*18+ss;
    7555:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7558:	89 d0                	mov    %edx,%eax
    755a:	c1 e0 03             	shl    $0x3,%eax
    755d:	01 d0                	add    %edx,%eax
    755f:	01 c0                	add    %eax,%eax
    7561:	89 c2                	mov    %eax,%edx
    7563:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    7566:	01 d0                	add    %edx,%eax
    7568:	89 45 e8             	mov    %eax,-0x18(%ebp)
                      i = -1;
    756b:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    7572:	eb 15                	jmp    7589 <III_stereo+0x497>
                   } else
                   {  ss--;
    7574:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
                      if ( ss < 0 )
    7578:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    757c:	79 0b                	jns    7589 <III_stereo+0x497>
                      {  i--;
    757e:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
                         ss = 17;
    7582:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
             }
             if ( max_sfb <= 3 )
             {  i = 2;
                ss = 17;
                sb = -1;
                while ( i >= 0 )
    7589:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    758d:	79 97                	jns    7526 <III_stereo+0x434>
                      {  i--;
                         ss = 17;
                      }
                   }
                }
                i = 0;
    758f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
                while ( sfBandIndex[sfreq].l[i] <= sb )
    7596:	eb 04                	jmp    759c <III_stereo+0x4aa>
                   i++;
    7598:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                         ss = 17;
                      }
                   }
                }
                i = 0;
                while ( sfBandIndex[sfreq].l[i] <= sb )
    759c:	8b 55 c8             	mov    -0x38(%ebp),%edx
    759f:	89 d0                	mov    %edx,%eax
    75a1:	c1 e0 03             	shl    $0x3,%eax
    75a4:	01 d0                	add    %edx,%eax
    75a6:	c1 e0 02             	shl    $0x2,%eax
    75a9:	01 d0                	add    %edx,%eax
    75ab:	8b 55 f0             	mov    -0x10(%ebp),%edx
    75ae:	01 d0                	add    %edx,%eax
    75b0:	8b 04 85 20 c9 00 00 	mov    0xc920(,%eax,4),%eax
    75b7:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    75ba:	7e dc                	jle    7598 <III_stereo+0x4a6>
                   i++;
                sfb = i;
    75bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    75bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
                i = sfBandIndex[sfreq].l[i];
    75c2:	8b 55 c8             	mov    -0x38(%ebp),%edx
    75c5:	89 d0                	mov    %edx,%eax
    75c7:	c1 e0 03             	shl    $0x3,%eax
    75ca:	01 d0                	add    %edx,%eax
    75cc:	c1 e0 02             	shl    $0x2,%eax
    75cf:	01 d0                	add    %edx,%eax
    75d1:	8b 55 f0             	mov    -0x10(%ebp),%edx
    75d4:	01 d0                	add    %edx,%eax
    75d6:	8b 04 85 20 c9 00 00 	mov    0xc920(,%eax,4),%eax
    75dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
                for ( ; sfb<8; sfb++ )
    75e0:	e9 b3 00 00 00       	jmp    7698 <III_stereo+0x5a6>
                {  sb = sfBandIndex[sfreq].l[sfb+1]-sfBandIndex[sfreq].l[sfb];
    75e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    75e8:	8d 48 01             	lea    0x1(%eax),%ecx
    75eb:	8b 55 c8             	mov    -0x38(%ebp),%edx
    75ee:	89 d0                	mov    %edx,%eax
    75f0:	c1 e0 03             	shl    $0x3,%eax
    75f3:	01 d0                	add    %edx,%eax
    75f5:	c1 e0 02             	shl    $0x2,%eax
    75f8:	01 d0                	add    %edx,%eax
    75fa:	01 c8                	add    %ecx,%eax
    75fc:	8b 0c 85 20 c9 00 00 	mov    0xc920(,%eax,4),%ecx
    7603:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7606:	89 d0                	mov    %edx,%eax
    7608:	c1 e0 03             	shl    $0x3,%eax
    760b:	01 d0                	add    %edx,%eax
    760d:	c1 e0 02             	shl    $0x2,%eax
    7610:	01 d0                	add    %edx,%eax
    7612:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7615:	01 d0                	add    %edx,%eax
    7617:	8b 04 85 20 c9 00 00 	mov    0xc920(,%eax,4),%eax
    761e:	29 c1                	sub    %eax,%ecx
    7620:	89 c8                	mov    %ecx,%eax
    7622:	89 45 e8             	mov    %eax,-0x18(%ebp)
                   for ( ; sb > 0; sb--)
    7625:	eb 67                	jmp    768e <III_stereo+0x59c>
                   {  is_pos[i] = (*scalefac)[1].l[sfb];
    7627:	8b 45 10             	mov    0x10(%ebp),%eax
    762a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    762d:	83 c2 3e             	add    $0x3e,%edx
    7630:	8b 14 90             	mov    (%eax,%edx,4),%edx
    7633:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7636:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                      if ( is_pos[i] != 7 )
    763d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7640:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    7647:	83 f8 07             	cmp    $0x7,%eax
    764a:	74 3a                	je     7686 <III_stereo+0x594>
                         is_ratio[i] = tan( is_pos[i] * (PI / 12));
    764c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    764f:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    7656:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    765c:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    7662:	dd 05 80 b7 00 00    	fldl   0xb780
    7668:	de c9                	fmulp  %st,%st(1)
    766a:	83 ec 08             	sub    $0x8,%esp
    766d:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    7671:	dd 1c 24             	fstpl  (%esp)
    7674:	e8 0f b4 ff ff       	call   2a88 <tan>
    7679:	83 c4 10             	add    $0x10,%esp
    767c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    767f:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                      i++;
    7686:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                   i++;
                sfb = i;
                i = sfBandIndex[sfreq].l[i];
                for ( ; sfb<8; sfb++ )
                {  sb = sfBandIndex[sfreq].l[sfb+1]-sfBandIndex[sfreq].l[sfb];
                   for ( ; sb > 0; sb--)
    768a:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    768e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    7692:	7f 93                	jg     7627 <III_stereo+0x535>
                i = 0;
                while ( sfBandIndex[sfreq].l[i] <= sb )
                   i++;
                sfb = i;
                i = sfBandIndex[sfreq].l[i];
                for ( ; sfb<8; sfb++ )
    7694:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7698:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    769c:	0f 8e 43 ff ff ff    	jle    75e5 <III_stereo+0x4f3>
   for ( i=0; i<576; i++ )
      is_pos[i] = 7;

   if ((stereo == 2) && i_stereo )
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
      {  if( gr_info->mixed_block_flag )
    76a2:	e9 23 05 00 00       	jmp    7bca <III_stereo+0xad8>
                      i++;
                   }
                }
            }
         } else
         {  for ( j=0; j<3; j++ )
    76a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    76ae:	e9 0c 03 00 00       	jmp    79bf <III_stereo+0x8cd>
            {  int sfbcnt;
               sfbcnt = -1;
    76b3:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%ebp)
               for( sfb=12; sfb >=0; sfb-- )
    76ba:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    76c1:	e9 0f 01 00 00       	jmp    77d5 <III_stereo+0x6e3>
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    76c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    76c9:	8d 48 01             	lea    0x1(%eax),%ecx
    76cc:	8b 55 c8             	mov    -0x38(%ebp),%edx
    76cf:	89 d0                	mov    %edx,%eax
    76d1:	c1 e0 03             	shl    $0x3,%eax
    76d4:	01 d0                	add    %edx,%eax
    76d6:	c1 e0 02             	shl    $0x2,%eax
    76d9:	01 d0                	add    %edx,%eax
    76db:	01 c8                	add    %ecx,%eax
    76dd:	83 c0 14             	add    $0x14,%eax
    76e0:	8b 0c 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%ecx
    76e7:	8b 55 c8             	mov    -0x38(%ebp),%edx
    76ea:	89 d0                	mov    %edx,%eax
    76ec:	c1 e0 03             	shl    $0x3,%eax
    76ef:	01 d0                	add    %edx,%eax
    76f1:	c1 e0 02             	shl    $0x2,%eax
    76f4:	01 d0                	add    %edx,%eax
    76f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
    76f9:	01 d0                	add    %edx,%eax
    76fb:	83 c0 14             	add    $0x14,%eax
    76fe:	8b 04 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%eax
    7705:	29 c1                	sub    %eax,%ecx
    7707:	89 c8                	mov    %ecx,%eax
    7709:	89 45 cc             	mov    %eax,-0x34(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
    770c:	8b 55 c8             	mov    -0x38(%ebp),%edx
    770f:	89 d0                	mov    %edx,%eax
    7711:	c1 e0 03             	shl    $0x3,%eax
    7714:	01 d0                	add    %edx,%eax
    7716:	c1 e0 02             	shl    $0x2,%eax
    7719:	01 d0                	add    %edx,%eax
    771b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    771e:	01 d0                	add    %edx,%eax
    7720:	83 c0 14             	add    $0x14,%eax
    7723:	8b 14 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%edx
    772a:	89 d0                	mov    %edx,%eax
    772c:	01 c0                	add    %eax,%eax
    772e:	01 c2                	add    %eax,%edx
    7730:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7733:	83 c0 01             	add    $0x1,%eax
    7736:	0f af 45 cc          	imul   -0x34(%ebp),%eax
    773a:	01 d0                	add    %edx,%eax
    773c:	83 e8 01             	sub    $0x1,%eax
    773f:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  while ( lines > 0 )
    7742:	e9 80 00 00 00       	jmp    77c7 <III_stereo+0x6d5>
                  {  if ( xr[1][i/SSLIMIT][i%SSLIMIT] != 0.0 )
    7747:	8b 45 08             	mov    0x8(%ebp),%eax
    774a:	8d b0 00 12 00 00    	lea    0x1200(%eax),%esi
    7750:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    7753:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    7758:	89 c8                	mov    %ecx,%eax
    775a:	f7 ea                	imul   %edx
    775c:	c1 fa 02             	sar    $0x2,%edx
    775f:	89 c8                	mov    %ecx,%eax
    7761:	c1 f8 1f             	sar    $0x1f,%eax
    7764:	89 d3                	mov    %edx,%ebx
    7766:	29 c3                	sub    %eax,%ebx
    7768:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    776b:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    7770:	89 c8                	mov    %ecx,%eax
    7772:	f7 ea                	imul   %edx
    7774:	c1 fa 02             	sar    $0x2,%edx
    7777:	89 c8                	mov    %ecx,%eax
    7779:	c1 f8 1f             	sar    $0x1f,%eax
    777c:	29 c2                	sub    %eax,%edx
    777e:	89 d0                	mov    %edx,%eax
    7780:	c1 e0 03             	shl    $0x3,%eax
    7783:	01 d0                	add    %edx,%eax
    7785:	01 c0                	add    %eax,%eax
    7787:	29 c1                	sub    %eax,%ecx
    7789:	89 ca                	mov    %ecx,%edx
    778b:	89 d8                	mov    %ebx,%eax
    778d:	c1 e0 03             	shl    $0x3,%eax
    7790:	01 d8                	add    %ebx,%eax
    7792:	01 c0                	add    %eax,%eax
    7794:	01 d0                	add    %edx,%eax
    7796:	dd 04 c6             	fldl   (%esi,%eax,8)
    7799:	d9 ee                	fldz   
    779b:	df e9                	fucomip %st(1),%st
    779d:	7a 0a                	jp     77a9 <III_stereo+0x6b7>
    779f:	d9 ee                	fldz   
    77a1:	df e9                	fucomip %st(1),%st
    77a3:	dd d8                	fstp   %st(0)
    77a5:	74 18                	je     77bf <III_stereo+0x6cd>
    77a7:	eb 02                	jmp    77ab <III_stereo+0x6b9>
    77a9:	dd d8                	fstp   %st(0)
                     {  sfbcnt = sfb;
    77ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    77ae:	89 45 d0             	mov    %eax,-0x30(%ebp)
                        sfb = -10;
    77b1:	c7 45 f4 f6 ff ff ff 	movl   $0xfffffff6,-0xc(%ebp)
                        lines = -10;
    77b8:	c7 45 cc f6 ff ff ff 	movl   $0xfffffff6,-0x34(%ebp)
                     }
                     lines--;
    77bf:	83 6d cc 01          	subl   $0x1,-0x34(%ebp)
                     i--;
    77c3:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
               sfbcnt = -1;
               for( sfb=12; sfb >=0; sfb-- )
               {  int lines;
                  lines = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + (j+1) * lines - 1;
                  while ( lines > 0 )
    77c7:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
    77cb:	0f 8f 76 ff ff ff    	jg     7747 <III_stereo+0x655>
            }
         } else
         {  for ( j=0; j<3; j++ )
            {  int sfbcnt;
               sfbcnt = -1;
               for( sfb=12; sfb >=0; sfb-- )
    77d1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    77d5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    77d9:	0f 89 e7 fe ff ff    	jns    76c6 <III_stereo+0x5d4>
                     }
                     lines--;
                     i--;
                  }
               }
               sfb = sfbcnt + 1;
    77df:	8b 45 d0             	mov    -0x30(%ebp),%eax
    77e2:	83 c0 01             	add    $0x1,%eax
    77e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
               while( sfb<12 )
    77e8:	e9 fa 00 00 00       	jmp    78e7 <III_stereo+0x7f5>
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
    77ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
    77f0:	8d 48 01             	lea    0x1(%eax),%ecx
    77f3:	8b 55 c8             	mov    -0x38(%ebp),%edx
    77f6:	89 d0                	mov    %edx,%eax
    77f8:	c1 e0 03             	shl    $0x3,%eax
    77fb:	01 d0                	add    %edx,%eax
    77fd:	c1 e0 02             	shl    $0x2,%eax
    7800:	01 d0                	add    %edx,%eax
    7802:	01 c8                	add    %ecx,%eax
    7804:	83 c0 14             	add    $0x14,%eax
    7807:	8b 0c 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%ecx
    780e:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7811:	89 d0                	mov    %edx,%eax
    7813:	c1 e0 03             	shl    $0x3,%eax
    7816:	01 d0                	add    %edx,%eax
    7818:	c1 e0 02             	shl    $0x2,%eax
    781b:	01 d0                	add    %edx,%eax
    781d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7820:	01 d0                	add    %edx,%eax
    7822:	83 c0 14             	add    $0x14,%eax
    7825:	8b 04 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%eax
    782c:	29 c1                	sub    %eax,%ecx
    782e:	89 c8                	mov    %ecx,%eax
    7830:	89 45 e8             	mov    %eax,-0x18(%ebp)
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
    7833:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7836:	89 d0                	mov    %edx,%eax
    7838:	c1 e0 03             	shl    $0x3,%eax
    783b:	01 d0                	add    %edx,%eax
    783d:	c1 e0 02             	shl    $0x2,%eax
    7840:	01 d0                	add    %edx,%eax
    7842:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7845:	01 d0                	add    %edx,%eax
    7847:	83 c0 14             	add    $0x14,%eax
    784a:	8b 14 85 2c c9 00 00 	mov    0xc92c(,%eax,4),%edx
    7851:	89 d0                	mov    %edx,%eax
    7853:	01 c0                	add    %eax,%eax
    7855:	01 c2                	add    %eax,%edx
    7857:	8b 45 ec             	mov    -0x14(%ebp),%eax
    785a:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    785e:	01 d0                	add    %edx,%eax
    7860:	89 45 f0             	mov    %eax,-0x10(%ebp)
                  for ( ; sb > 0; sb--)
    7863:	eb 78                	jmp    78dd <III_stereo+0x7eb>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
    7865:	8b 4d 10             	mov    0x10(%ebp),%ecx
    7868:	8b 55 ec             	mov    -0x14(%ebp),%edx
    786b:	89 d0                	mov    %edx,%eax
    786d:	01 c0                	add    %eax,%eax
    786f:	01 d0                	add    %edx,%eax
    7871:	c1 e0 02             	shl    $0x2,%eax
    7874:	01 d0                	add    %edx,%eax
    7876:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7879:	01 d0                	add    %edx,%eax
    787b:	83 c0 52             	add    $0x52,%eax
    787e:	8b 54 81 0c          	mov    0xc(%ecx,%eax,4),%edx
    7882:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7885:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                     if ( is_pos[i] != 7 )
    788c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    788f:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    7896:	83 f8 07             	cmp    $0x7,%eax
    7899:	74 3a                	je     78d5 <III_stereo+0x7e3>
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
    789b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    789e:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    78a5:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    78ab:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    78b1:	dd 05 80 b7 00 00    	fldl   0xb780
    78b7:	de c9                	fmulp  %st,%st(1)
    78b9:	83 ec 08             	sub    $0x8,%esp
    78bc:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    78c0:	dd 1c 24             	fstpl  (%esp)
    78c3:	e8 c0 b1 ff ff       	call   2a88 <tan>
    78c8:	83 c4 10             	add    $0x10,%esp
    78cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    78ce:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                     i++;
    78d5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
               }
               sfb = sfbcnt + 1;
               while( sfb<12 )
               {  sb = sfBandIndex[sfreq].s[sfb+1]-sfBandIndex[sfreq].s[sfb];
                  i = 3*sfBandIndex[sfreq].s[sfb] + j * sb;
                  for ( ; sb > 0; sb--)
    78d9:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    78dd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    78e1:	7f 82                	jg     7865 <III_stereo+0x773>
                  {  is_pos[i] = (*scalefac)[1].s[j][sfb];
                     if ( is_pos[i] != 7 )
                        is_ratio[i] = tan( is_pos[i] * (PI / 12));
                     i++;
                  }
                  sfb++;
    78e3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                     lines--;
                     i--;
                  }
               }
               sfb = sfbcnt + 1;
               while( sfb<12 )
    78e7:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    78eb:	0f 8e fc fe ff ff    	jle    77ed <III_stereo+0x6fb>
                     i++;
                  }
                  sfb++;
               }

               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
    78f1:	8b 45 c8             	mov    -0x38(%ebp),%eax
    78f4:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    78fa:	05 a8 c9 00 00       	add    $0xc9a8,%eax
    78ff:	8b 10                	mov    (%eax),%edx
    7901:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7904:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    790a:	05 a4 c9 00 00       	add    $0xc9a4,%eax
    790f:	8b 00                	mov    (%eax),%eax
    7911:	29 c2                	sub    %eax,%edx
    7913:	89 d0                	mov    %edx,%eax
    7915:	89 45 e8             	mov    %eax,-0x18(%ebp)
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
    7918:	8b 45 c8             	mov    -0x38(%ebp),%eax
    791b:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7921:	05 a4 c9 00 00       	add    $0xc9a4,%eax
    7926:	8b 10                	mov    (%eax),%edx
    7928:	89 d0                	mov    %edx,%eax
    792a:	01 c0                	add    %eax,%eax
    792c:	01 c2                	add    %eax,%edx
    792e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    7931:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    7935:	01 d0                	add    %edx,%eax
    7937:	89 45 f4             	mov    %eax,-0xc(%ebp)
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
    793a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    793d:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7943:	05 ac c9 00 00       	add    $0xc9ac,%eax
    7948:	8b 10                	mov    (%eax),%edx
    794a:	8b 45 c8             	mov    -0x38(%ebp),%eax
    794d:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7953:	05 a8 c9 00 00       	add    $0xc9a8,%eax
    7958:	8b 00                	mov    (%eax),%eax
    795a:	29 c2                	sub    %eax,%edx
    795c:	89 d0                	mov    %edx,%eax
    795e:	89 45 e8             	mov    %eax,-0x18(%ebp)
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
    7961:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7964:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    796a:	05 a8 c9 00 00       	add    $0xc9a8,%eax
    796f:	8b 10                	mov    (%eax),%edx
    7971:	89 d0                	mov    %edx,%eax
    7973:	01 c0                	add    %eax,%eax
    7975:	01 c2                	add    %eax,%edx
    7977:	8b 45 ec             	mov    -0x14(%ebp),%eax
    797a:	0f af 45 e8          	imul   -0x18(%ebp),%eax
    797e:	01 d0                	add    %edx,%eax
    7980:	89 45 f0             	mov    %eax,-0x10(%ebp)
               for ( ; sb > 0; sb-- )
    7983:	eb 30                	jmp    79b5 <III_stereo+0x8c3>
               {  is_pos[i] = is_pos[sfb];
    7985:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7988:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    798f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7992:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
                  is_ratio[i] = is_ratio[sfb];
    7999:	8b 45 f4             	mov    -0xc(%ebp),%eax
    799c:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    79a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    79a6:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
                  i++;
    79ad:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)

               sb = sfBandIndex[sfreq].s[11]-sfBandIndex[sfreq].s[10];
               sfb = 3*sfBandIndex[sfreq].s[10] + j * sb;
               sb = sfBandIndex[sfreq].s[12]-sfBandIndex[sfreq].s[11];
               i = 3*sfBandIndex[sfreq].s[11] + j * sb;
               for ( ; sb > 0; sb-- )
    79b1:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    79b5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    79b9:	7f ca                	jg     7985 <III_stereo+0x893>
                      i++;
                   }
                }
            }
         } else
         {  for ( j=0; j<3; j++ )
    79bb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    79bf:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
    79c3:	0f 8e ea fc ff ff    	jle    76b3 <III_stereo+0x5c1>
   for ( i=0; i<576; i++ )
      is_pos[i] = 7;

   if ((stereo == 2) && i_stereo )
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
      {  if( gr_info->mixed_block_flag )
    79c9:	e9 fc 01 00 00       	jmp    7bca <III_stereo+0xad8>
                  i++;
               }
            }
         }
      } else
      {  i = 31;
    79ce:	c7 45 f0 1f 00 00 00 	movl   $0x1f,-0x10(%ebp)
         ss = 17;
    79d5:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
         sb = 0;
    79dc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
         while ( i >= 0 )
    79e3:	eb 63                	jmp    7a48 <III_stereo+0x956>
         {  if ( xr[1][i][ss] != 0.0 )
    79e5:	8b 45 08             	mov    0x8(%ebp),%eax
    79e8:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    79ee:	8b 55 f0             	mov    -0x10(%ebp),%edx
    79f1:	89 d0                	mov    %edx,%eax
    79f3:	c1 e0 03             	shl    $0x3,%eax
    79f6:	01 d0                	add    %edx,%eax
    79f8:	01 c0                	add    %eax,%eax
    79fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    79fd:	01 d0                	add    %edx,%eax
    79ff:	dd 04 c1             	fldl   (%ecx,%eax,8)
    7a02:	d9 ee                	fldz   
    7a04:	df e9                	fucomip %st(1),%st
    7a06:	7a 0a                	jp     7a12 <III_stereo+0x920>
    7a08:	d9 ee                	fldz   
    7a0a:	df e9                	fucomip %st(1),%st
    7a0c:	dd d8                	fstp   %st(0)
    7a0e:	74 23                	je     7a33 <III_stereo+0x941>
    7a10:	eb 02                	jmp    7a14 <III_stereo+0x922>
    7a12:	dd d8                	fstp   %st(0)
            {  sb = i*18+ss;
    7a14:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7a17:	89 d0                	mov    %edx,%eax
    7a19:	c1 e0 03             	shl    $0x3,%eax
    7a1c:	01 d0                	add    %edx,%eax
    7a1e:	01 c0                	add    %eax,%eax
    7a20:	89 c2                	mov    %eax,%edx
    7a22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    7a25:	01 d0                	add    %edx,%eax
    7a27:	89 45 e8             	mov    %eax,-0x18(%ebp)
               i = -1;
    7a2a:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
    7a31:	eb 15                	jmp    7a48 <III_stereo+0x956>
            } else
            {  ss--;
    7a33:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
               if ( ss < 0 )
    7a37:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    7a3b:	79 0b                	jns    7a48 <III_stereo+0x956>
               {  i--;
    7a3d:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
                  ss = 17;
    7a41:	c7 45 e4 11 00 00 00 	movl   $0x11,-0x1c(%ebp)
         }
      } else
      {  i = 31;
         ss = 17;
         sb = 0;
         while ( i >= 0 )
    7a48:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    7a4c:	79 97                	jns    79e5 <III_stereo+0x8f3>
               {  i--;
                  ss = 17;
               }
            }
         }
         i = 0;
    7a4e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
         while ( sfBandIndex[sfreq].l[i] <= sb )
    7a55:	eb 04                	jmp    7a5b <III_stereo+0x969>
            i++;
    7a57:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                  ss = 17;
               }
            }
         }
         i = 0;
         while ( sfBandIndex[sfreq].l[i] <= sb )
    7a5b:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7a5e:	89 d0                	mov    %edx,%eax
    7a60:	c1 e0 03             	shl    $0x3,%eax
    7a63:	01 d0                	add    %edx,%eax
    7a65:	c1 e0 02             	shl    $0x2,%eax
    7a68:	01 d0                	add    %edx,%eax
    7a6a:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7a6d:	01 d0                	add    %edx,%eax
    7a6f:	8b 04 85 20 c9 00 00 	mov    0xc920(,%eax,4),%eax
    7a76:	3b 45 e8             	cmp    -0x18(%ebp),%eax
    7a79:	7e dc                	jle    7a57 <III_stereo+0x965>
            i++;
         sfb = i;
    7a7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7a7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
         i = sfBandIndex[sfreq].l[i];
    7a81:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7a84:	89 d0                	mov    %edx,%eax
    7a86:	c1 e0 03             	shl    $0x3,%eax
    7a89:	01 d0                	add    %edx,%eax
    7a8b:	c1 e0 02             	shl    $0x2,%eax
    7a8e:	01 d0                	add    %edx,%eax
    7a90:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7a93:	01 d0                	add    %edx,%eax
    7a95:	8b 04 85 20 c9 00 00 	mov    0xc920(,%eax,4),%eax
    7a9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
         for ( ; sfb<21; sfb++ )
    7a9f:	e9 b3 00 00 00       	jmp    7b57 <III_stereo+0xa65>
         {  sb = sfBandIndex[sfreq].l[sfb+1] - sfBandIndex[sfreq].l[sfb];
    7aa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7aa7:	8d 48 01             	lea    0x1(%eax),%ecx
    7aaa:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7aad:	89 d0                	mov    %edx,%eax
    7aaf:	c1 e0 03             	shl    $0x3,%eax
    7ab2:	01 d0                	add    %edx,%eax
    7ab4:	c1 e0 02             	shl    $0x2,%eax
    7ab7:	01 d0                	add    %edx,%eax
    7ab9:	01 c8                	add    %ecx,%eax
    7abb:	8b 0c 85 20 c9 00 00 	mov    0xc920(,%eax,4),%ecx
    7ac2:	8b 55 c8             	mov    -0x38(%ebp),%edx
    7ac5:	89 d0                	mov    %edx,%eax
    7ac7:	c1 e0 03             	shl    $0x3,%eax
    7aca:	01 d0                	add    %edx,%eax
    7acc:	c1 e0 02             	shl    $0x2,%eax
    7acf:	01 d0                	add    %edx,%eax
    7ad1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7ad4:	01 d0                	add    %edx,%eax
    7ad6:	8b 04 85 20 c9 00 00 	mov    0xc920(,%eax,4),%eax
    7add:	29 c1                	sub    %eax,%ecx
    7adf:	89 c8                	mov    %ecx,%eax
    7ae1:	89 45 e8             	mov    %eax,-0x18(%ebp)
            for ( ; sb > 0; sb--)
    7ae4:	eb 67                	jmp    7b4d <III_stereo+0xa5b>
            {  is_pos[i] = (*scalefac)[1].l[sfb];
    7ae6:	8b 45 10             	mov    0x10(%ebp),%eax
    7ae9:	8b 55 f4             	mov    -0xc(%ebp),%edx
    7aec:	83 c2 3e             	add    $0x3e,%edx
    7aef:	8b 14 90             	mov    (%eax,%edx,4),%edx
    7af2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7af5:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
               if ( is_pos[i] != 7 )
    7afc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7aff:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    7b06:	83 f8 07             	cmp    $0x7,%eax
    7b09:	74 3a                	je     7b45 <III_stereo+0xa53>
                  is_ratio[i] = tan( is_pos[i] * (PI / 12));
    7b0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7b0e:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    7b15:	89 85 b4 e4 ff ff    	mov    %eax,-0x1b4c(%ebp)
    7b1b:	db 85 b4 e4 ff ff    	fildl  -0x1b4c(%ebp)
    7b21:	dd 05 80 b7 00 00    	fldl   0xb780
    7b27:	de c9                	fmulp  %st,%st(1)
    7b29:	83 ec 08             	sub    $0x8,%esp
    7b2c:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    7b30:	dd 1c 24             	fstpl  (%esp)
    7b33:	e8 50 af ff ff       	call   2a88 <tan>
    7b38:	83 c4 10             	add    $0x10,%esp
    7b3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7b3e:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
               i++;
    7b45:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
            i++;
         sfb = i;
         i = sfBandIndex[sfreq].l[i];
         for ( ; sfb<21; sfb++ )
         {  sb = sfBandIndex[sfreq].l[sfb+1] - sfBandIndex[sfreq].l[sfb];
            for ( ; sb > 0; sb--)
    7b49:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    7b4d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    7b51:	7f 93                	jg     7ae6 <III_stereo+0x9f4>
         i = 0;
         while ( sfBandIndex[sfreq].l[i] <= sb )
            i++;
         sfb = i;
         i = sfBandIndex[sfreq].l[i];
         for ( ; sfb<21; sfb++ )
    7b53:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7b57:	83 7d f4 14          	cmpl   $0x14,-0xc(%ebp)
    7b5b:	0f 8e 43 ff ff ff    	jle    7aa4 <III_stereo+0x9b2>
               if ( is_pos[i] != 7 )
                  is_ratio[i] = tan( is_pos[i] * (PI / 12));
               i++;
            }
         }
         sfb = sfBandIndex[sfreq].l[20];
    7b61:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7b64:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7b6a:	05 70 c9 00 00       	add    $0xc970,%eax
    7b6f:	8b 00                	mov    (%eax),%eax
    7b71:	89 45 f4             	mov    %eax,-0xc(%ebp)
         for ( sb = 576 - sfBandIndex[sfreq].l[21]; sb > 0; sb-- )
    7b74:	8b 45 c8             	mov    -0x38(%ebp),%eax
    7b77:	69 c0 94 00 00 00    	imul   $0x94,%eax,%eax
    7b7d:	05 74 c9 00 00       	add    $0xc974,%eax
    7b82:	8b 00                	mov    (%eax),%eax
    7b84:	ba 40 02 00 00       	mov    $0x240,%edx
    7b89:	29 c2                	sub    %eax,%edx
    7b8b:	89 d0                	mov    %edx,%eax
    7b8d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    7b90:	eb 30                	jmp    7bc2 <III_stereo+0xad0>
         {  is_pos[i] = is_pos[sfb];
    7b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7b95:	8b 94 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%edx
    7b9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7b9f:	89 94 85 bc f6 ff ff 	mov    %edx,-0x944(%ebp,%eax,4)
            is_ratio[i] = is_ratio[sfb];
    7ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7ba9:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    7bb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7bb3:	dd 9c c5 b8 e4 ff ff 	fstpl  -0x1b48(%ebp,%eax,8)
            i++;
    7bba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
                  is_ratio[i] = tan( is_pos[i] * (PI / 12));
               i++;
            }
         }
         sfb = sfBandIndex[sfreq].l[20];
         for ( sb = 576 - sfBandIndex[sfreq].l[21]; sb > 0; sb-- )
    7bbe:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
    7bc2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    7bc6:	7f ca                	jg     7b92 <III_stereo+0xaa0>
    7bc8:	eb 01                	jmp    7bcb <III_stereo+0xad9>
   for ( i=0; i<576; i++ )
      is_pos[i] = 7;

   if ((stereo == 2) && i_stereo )
   {  if (gr_info->window_switching_flag && (gr_info->block_type == 2))
      {  if( gr_info->mixed_block_flag )
    7bca:	90                   	nop
            i++;
         }
      }
   }

   for(ch=0;ch<2;ch++)
    7bcb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    7bd2:	eb 55                	jmp    7c29 <III_stereo+0xb37>
      for(sb=0;sb<SBLIMIT;sb++)
    7bd4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    7bdb:	eb 42                	jmp    7c1f <III_stereo+0xb2d>
         for(ss=0;ss<SSLIMIT;ss++)
    7bdd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    7be4:	eb 2f                	jmp    7c15 <III_stereo+0xb23>
            lr[ch][sb][ss] = 0;
    7be6:	8b 55 e0             	mov    -0x20(%ebp),%edx
    7be9:	89 d0                	mov    %edx,%eax
    7beb:	c1 e0 03             	shl    $0x3,%eax
    7bee:	01 d0                	add    %edx,%eax
    7bf0:	c1 e0 09             	shl    $0x9,%eax
    7bf3:	89 c2                	mov    %eax,%edx
    7bf5:	8b 45 0c             	mov    0xc(%ebp),%eax
    7bf8:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    7bfb:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7bfe:	89 d0                	mov    %edx,%eax
    7c00:	c1 e0 03             	shl    $0x3,%eax
    7c03:	01 d0                	add    %edx,%eax
    7c05:	01 c0                	add    %eax,%eax
    7c07:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7c0a:	01 d0                	add    %edx,%eax
    7c0c:	d9 ee                	fldz   
    7c0e:	dd 1c c1             	fstpl  (%ecx,%eax,8)
      }
   }

   for(ch=0;ch<2;ch++)
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
    7c11:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    7c15:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    7c19:	7e cb                	jle    7be6 <III_stereo+0xaf4>
         }
      }
   }

   for(ch=0;ch<2;ch++)
      for(sb=0;sb<SBLIMIT;sb++)
    7c1b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    7c1f:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    7c23:	7e b8                	jle    7bdd <III_stereo+0xaeb>
            i++;
         }
      }
   }

   for(ch=0;ch<2;ch++)
    7c25:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    7c29:	83 7d e0 01          	cmpl   $0x1,-0x20(%ebp)
    7c2d:	7e a5                	jle    7bd4 <III_stereo+0xae2>
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
            lr[ch][sb][ss] = 0;

   if (stereo==2)
    7c2f:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
    7c33:	0f 85 3b 02 00 00    	jne    7e74 <III_stereo+0xd82>
      for(sb=0;sb<SBLIMIT;sb++)
    7c39:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    7c40:	e9 23 02 00 00       	jmp    7e68 <III_stereo+0xd76>
         for(ss=0;ss<SSLIMIT;ss++) {
    7c45:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    7c4c:	e9 09 02 00 00       	jmp    7e5a <III_stereo+0xd68>
            i = (sb*18)+ss;
    7c51:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7c54:	89 d0                	mov    %edx,%eax
    7c56:	c1 e0 03             	shl    $0x3,%eax
    7c59:	01 d0                	add    %edx,%eax
    7c5b:	01 c0                	add    %eax,%eax
    7c5d:	89 c2                	mov    %eax,%edx
    7c5f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    7c62:	01 d0                	add    %edx,%eax
    7c64:	89 45 f0             	mov    %eax,-0x10(%ebp)
            if ( is_pos[i] == 7 ) {
    7c67:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7c6a:	8b 84 85 bc f6 ff ff 	mov    -0x944(%ebp,%eax,4),%eax
    7c71:	83 f8 07             	cmp    $0x7,%eax
    7c74:	0f 85 2c 01 00 00    	jne    7da6 <III_stereo+0xcb4>
               if ( ms_stereo ) {
    7c7a:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
    7c7e:	0f 84 b5 00 00 00    	je     7d39 <III_stereo+0xc47>
                  lr[0][sb][ss] = (xr[0][sb][ss]+xr[1][sb][ss])/1.41421356;
    7c84:	8b 4d 08             	mov    0x8(%ebp),%ecx
    7c87:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7c8a:	89 d0                	mov    %edx,%eax
    7c8c:	c1 e0 03             	shl    $0x3,%eax
    7c8f:	01 d0                	add    %edx,%eax
    7c91:	01 c0                	add    %eax,%eax
    7c93:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7c96:	01 d0                	add    %edx,%eax
    7c98:	dd 04 c1             	fldl   (%ecx,%eax,8)
    7c9b:	8b 45 08             	mov    0x8(%ebp),%eax
    7c9e:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    7ca4:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7ca7:	89 d0                	mov    %edx,%eax
    7ca9:	c1 e0 03             	shl    $0x3,%eax
    7cac:	01 d0                	add    %edx,%eax
    7cae:	01 c0                	add    %eax,%eax
    7cb0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7cb3:	01 d0                	add    %edx,%eax
    7cb5:	dd 04 c1             	fldl   (%ecx,%eax,8)
    7cb8:	de c1                	faddp  %st,%st(1)
    7cba:	dd 05 88 b7 00 00    	fldl   0xb788
    7cc0:	de f9                	fdivrp %st,%st(1)
    7cc2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    7cc5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7cc8:	89 d0                	mov    %edx,%eax
    7cca:	c1 e0 03             	shl    $0x3,%eax
    7ccd:	01 d0                	add    %edx,%eax
    7ccf:	01 c0                	add    %eax,%eax
    7cd1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7cd4:	01 d0                	add    %edx,%eax
    7cd6:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                  lr[1][sb][ss] = (xr[0][sb][ss]-xr[1][sb][ss])/1.41421356;
    7cd9:	8b 45 0c             	mov    0xc(%ebp),%eax
    7cdc:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    7ce2:	8b 4d 08             	mov    0x8(%ebp),%ecx
    7ce5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7ce8:	89 d0                	mov    %edx,%eax
    7cea:	c1 e0 03             	shl    $0x3,%eax
    7ced:	01 d0                	add    %edx,%eax
    7cef:	01 c0                	add    %eax,%eax
    7cf1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7cf4:	01 d0                	add    %edx,%eax
    7cf6:	dd 04 c1             	fldl   (%ecx,%eax,8)
    7cf9:	8b 45 08             	mov    0x8(%ebp),%eax
    7cfc:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    7d02:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7d05:	89 d0                	mov    %edx,%eax
    7d07:	c1 e0 03             	shl    $0x3,%eax
    7d0a:	01 d0                	add    %edx,%eax
    7d0c:	01 c0                	add    %eax,%eax
    7d0e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7d11:	01 d0                	add    %edx,%eax
    7d13:	dd 04 c1             	fldl   (%ecx,%eax,8)
    7d16:	de e9                	fsubrp %st,%st(1)
    7d18:	dd 05 88 b7 00 00    	fldl   0xb788
    7d1e:	de f9                	fdivrp %st,%st(1)
    7d20:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7d23:	89 d0                	mov    %edx,%eax
    7d25:	c1 e0 03             	shl    $0x3,%eax
    7d28:	01 d0                	add    %edx,%eax
    7d2a:	01 c0                	add    %eax,%eax
    7d2c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7d2f:	01 d0                	add    %edx,%eax
    7d31:	dd 1c c3             	fstpl  (%ebx,%eax,8)
    7d34:	e9 1d 01 00 00       	jmp    7e56 <III_stereo+0xd64>
               }
               else {
                  lr[0][sb][ss] = xr[0][sb][ss];
    7d39:	8b 4d 08             	mov    0x8(%ebp),%ecx
    7d3c:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7d3f:	89 d0                	mov    %edx,%eax
    7d41:	c1 e0 03             	shl    $0x3,%eax
    7d44:	01 d0                	add    %edx,%eax
    7d46:	01 c0                	add    %eax,%eax
    7d48:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7d4b:	01 d0                	add    %edx,%eax
    7d4d:	dd 04 c1             	fldl   (%ecx,%eax,8)
    7d50:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    7d53:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7d56:	89 d0                	mov    %edx,%eax
    7d58:	c1 e0 03             	shl    $0x3,%eax
    7d5b:	01 d0                	add    %edx,%eax
    7d5d:	01 c0                	add    %eax,%eax
    7d5f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7d62:	01 d0                	add    %edx,%eax
    7d64:	dd 1c c1             	fstpl  (%ecx,%eax,8)
                  lr[1][sb][ss] = xr[1][sb][ss];
    7d67:	8b 45 0c             	mov    0xc(%ebp),%eax
    7d6a:	8d 88 00 12 00 00    	lea    0x1200(%eax),%ecx
    7d70:	8b 45 08             	mov    0x8(%ebp),%eax
    7d73:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    7d79:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7d7c:	89 d0                	mov    %edx,%eax
    7d7e:	c1 e0 03             	shl    $0x3,%eax
    7d81:	01 d0                	add    %edx,%eax
    7d83:	01 c0                	add    %eax,%eax
    7d85:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7d88:	01 d0                	add    %edx,%eax
    7d8a:	dd 04 c3             	fldl   (%ebx,%eax,8)
    7d8d:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7d90:	89 d0                	mov    %edx,%eax
    7d92:	c1 e0 03             	shl    $0x3,%eax
    7d95:	01 d0                	add    %edx,%eax
    7d97:	01 c0                	add    %eax,%eax
    7d99:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7d9c:	01 d0                	add    %edx,%eax
    7d9e:	dd 1c c1             	fstpl  (%ecx,%eax,8)
    7da1:	e9 b0 00 00 00       	jmp    7e56 <III_stereo+0xd64>
               }
            }
            else if (i_stereo ) {
    7da6:	83 7d bc 00          	cmpl   $0x0,-0x44(%ebp)
    7daa:	0f 84 94 00 00 00    	je     7e44 <III_stereo+0xd52>
               lr[0][sb][ss] = xr[0][sb][ss] * (is_ratio[i]/(1+is_ratio[i]));
    7db0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    7db3:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7db6:	89 d0                	mov    %edx,%eax
    7db8:	c1 e0 03             	shl    $0x3,%eax
    7dbb:	01 d0                	add    %edx,%eax
    7dbd:	01 c0                	add    %eax,%eax
    7dbf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7dc2:	01 d0                	add    %edx,%eax
    7dc4:	dd 04 c1             	fldl   (%ecx,%eax,8)
    7dc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7dca:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    7dd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7dd4:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    7ddb:	d9 e8                	fld1   
    7ddd:	de c1                	faddp  %st,%st(1)
    7ddf:	de f9                	fdivrp %st,%st(1)
    7de1:	de c9                	fmulp  %st,%st(1)
    7de3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    7de6:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7de9:	89 d0                	mov    %edx,%eax
    7deb:	c1 e0 03             	shl    $0x3,%eax
    7dee:	01 d0                	add    %edx,%eax
    7df0:	01 c0                	add    %eax,%eax
    7df2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7df5:	01 d0                	add    %edx,%eax
    7df7:	dd 1c c1             	fstpl  (%ecx,%eax,8)
               lr[1][sb][ss] = xr[0][sb][ss] * (1/(1+is_ratio[i]));
    7dfa:	8b 45 0c             	mov    0xc(%ebp),%eax
    7dfd:	8d 98 00 12 00 00    	lea    0x1200(%eax),%ebx
    7e03:	8b 4d 08             	mov    0x8(%ebp),%ecx
    7e06:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7e09:	89 d0                	mov    %edx,%eax
    7e0b:	c1 e0 03             	shl    $0x3,%eax
    7e0e:	01 d0                	add    %edx,%eax
    7e10:	01 c0                	add    %eax,%eax
    7e12:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7e15:	01 d0                	add    %edx,%eax
    7e17:	dd 04 c1             	fldl   (%ecx,%eax,8)
    7e1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    7e1d:	dd 84 c5 b8 e4 ff ff 	fldl   -0x1b48(%ebp,%eax,8)
    7e24:	d9 e8                	fld1   
    7e26:	de c1                	faddp  %st,%st(1)
    7e28:	d9 e8                	fld1   
    7e2a:	de f1                	fdivp  %st,%st(1)
    7e2c:	de c9                	fmulp  %st,%st(1)
    7e2e:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7e31:	89 d0                	mov    %edx,%eax
    7e33:	c1 e0 03             	shl    $0x3,%eax
    7e36:	01 d0                	add    %edx,%eax
    7e38:	01 c0                	add    %eax,%eax
    7e3a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7e3d:	01 d0                	add    %edx,%eax
    7e3f:	dd 1c c3             	fstpl  (%ebx,%eax,8)
    7e42:	eb 12                	jmp    7e56 <III_stereo+0xd64>
            }
            else {
               printf(0,"Error in streo processing\n");
    7e44:	83 ec 08             	sub    $0x8,%esp
    7e47:	68 20 a7 00 00       	push   $0xa720
    7e4c:	6a 00                	push   $0x0
    7e4e:	e8 9f a7 ff ff       	call   25f2 <printf>
    7e53:	83 c4 10             	add    $0x10,%esp
         for(ss=0;ss<SSLIMIT;ss++)
            lr[ch][sb][ss] = 0;

   if (stereo==2)
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++) {
    7e56:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    7e5a:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    7e5e:	0f 8e ed fd ff ff    	jle    7c51 <III_stereo+0xb5f>
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
            lr[ch][sb][ss] = 0;

   if (stereo==2)
      for(sb=0;sb<SBLIMIT;sb++)
    7e64:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    7e68:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    7e6c:	0f 8e d3 fd ff ff    	jle    7c45 <III_stereo+0xb53>
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
            lr[0][sb][ss] = xr[0][sb][ss];

}
    7e72:	eb 54                	jmp    7ec8 <III_stereo+0xdd6>
            else {
               printf(0,"Error in streo processing\n");
            }
         }
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
    7e74:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    7e7b:	eb 45                	jmp    7ec2 <III_stereo+0xdd0>
         for(ss=0;ss<SSLIMIT;ss++)
    7e7d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    7e84:	eb 32                	jmp    7eb8 <III_stereo+0xdc6>
            lr[0][sb][ss] = xr[0][sb][ss];
    7e86:	8b 4d 08             	mov    0x8(%ebp),%ecx
    7e89:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7e8c:	89 d0                	mov    %edx,%eax
    7e8e:	c1 e0 03             	shl    $0x3,%eax
    7e91:	01 d0                	add    %edx,%eax
    7e93:	01 c0                	add    %eax,%eax
    7e95:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7e98:	01 d0                	add    %edx,%eax
    7e9a:	dd 04 c1             	fldl   (%ecx,%eax,8)
    7e9d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    7ea0:	8b 55 e8             	mov    -0x18(%ebp),%edx
    7ea3:	89 d0                	mov    %edx,%eax
    7ea5:	c1 e0 03             	shl    $0x3,%eax
    7ea8:	01 d0                	add    %edx,%eax
    7eaa:	01 c0                	add    %eax,%eax
    7eac:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    7eaf:	01 d0                	add    %edx,%eax
    7eb1:	dd 1c c1             	fstpl  (%ecx,%eax,8)
               printf(0,"Error in streo processing\n");
            }
         }
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
         for(ss=0;ss<SSLIMIT;ss++)
    7eb4:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    7eb8:	83 7d e4 11          	cmpl   $0x11,-0x1c(%ebp)
    7ebc:	7e c8                	jle    7e86 <III_stereo+0xd94>
            else {
               printf(0,"Error in streo processing\n");
            }
         }
   else  /* mono , bypass xr[0][][] to lr[0][][]*/
      for(sb=0;sb<SBLIMIT;sb++)
    7ebe:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    7ec2:	83 7d e8 1f          	cmpl   $0x1f,-0x18(%ebp)
    7ec6:	7e b5                	jle    7e7d <III_stereo+0xd8b>
         for(ss=0;ss<SSLIMIT;ss++)
            lr[0][sb][ss] = xr[0][sb][ss];

}
    7ec8:	90                   	nop
    7ec9:	8d 65 f8             	lea    -0x8(%ebp),%esp
    7ecc:	5b                   	pop    %ebx
    7ecd:	5e                   	pop    %esi
    7ece:	5d                   	pop    %ebp
    7ecf:	c3                   	ret    

00007ed0 <III_antialias>:


double Ci[8]={-0.6,-0.535,-0.33,-0.185,-0.095,-0.041,-0.0142,-0.0037};
void III_antialias(double xr[SBLIMIT][SSLIMIT], double hybridIn[SBLIMIT][SSLIMIT], struct gr_info_s *gr_info, struct frame_params *fr_ps)
{
    7ed0:	55                   	push   %ebp
    7ed1:	89 e5                	mov    %esp,%ebp
    7ed3:	83 ec 38             	sub    $0x38,%esp
   static int    init = 1;
   static double ca[8],cs[8];
   double        bu,bd;  /* upper and lower butterfly inputs */
   int           ss,sb,sblim;

   if (init) {
    7ed6:	a1 80 cb 00 00       	mov    0xcb80,%eax
    7edb:	85 c0                	test   %eax,%eax
    7edd:	74 72                	je     7f51 <III_antialias+0x81>
      int i;
      double    sq;
      for (i=0;i<8;i++) {
    7edf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    7ee6:	eb 59                	jmp    7f41 <III_antialias+0x71>
         sq=sqrt(1.0+Ci[i]*Ci[i]);
    7ee8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7eeb:	dd 04 c5 40 cb 00 00 	fldl   0xcb40(,%eax,8)
    7ef2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7ef5:	dd 04 c5 40 cb 00 00 	fldl   0xcb40(,%eax,8)
    7efc:	de c9                	fmulp  %st,%st(1)
    7efe:	d9 e8                	fld1   
    7f00:	de c1                	faddp  %st,%st(1)
    7f02:	83 ec 08             	sub    $0x8,%esp
    7f05:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    7f09:	dd 1c 24             	fstpl  (%esp)
    7f0c:	e8 3a ad ff ff       	call   2c4b <sqrt>
    7f11:	83 c4 10             	add    $0x10,%esp
    7f14:	dd 5d e0             	fstpl  -0x20(%ebp)
         cs[i] = 1.0/sq;
    7f17:	d9 e8                	fld1   
    7f19:	dc 75 e0             	fdivl  -0x20(%ebp)
    7f1c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7f1f:	dd 1c c5 e0 cb 00 00 	fstpl  0xcbe0(,%eax,8)
         ca[i] = Ci[i]/sq;
    7f26:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7f29:	dd 04 c5 40 cb 00 00 	fldl   0xcb40(,%eax,8)
    7f30:	dc 75 e0             	fdivl  -0x20(%ebp)
    7f33:	8b 45 e8             	mov    -0x18(%ebp),%eax
    7f36:	dd 1c c5 20 cc 00 00 	fstpl  0xcc20(,%eax,8)
   int           ss,sb,sblim;

   if (init) {
      int i;
      double    sq;
      for (i=0;i<8;i++) {
    7f3d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    7f41:	83 7d e8 07          	cmpl   $0x7,-0x18(%ebp)
    7f45:	7e a1                	jle    7ee8 <III_antialias+0x18>
         sq=sqrt(1.0+Ci[i]*Ci[i]);
         cs[i] = 1.0/sq;
         ca[i] = Ci[i]/sq;
      }
      init = 0;
    7f47:	c7 05 80 cb 00 00 00 	movl   $0x0,0xcb80
    7f4e:	00 00 00 
   }

   /* clear all inputs */

    for(sb=0;sb<SBLIMIT;sb++)
    7f51:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    7f58:	eb 4c                	jmp    7fa6 <III_antialias+0xd6>
       for(ss=0;ss<SSLIMIT;ss++)
    7f5a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    7f61:	eb 39                	jmp    7f9c <III_antialias+0xcc>
          hybridIn[sb][ss] = xr[sb][ss];
    7f63:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7f66:	89 d0                	mov    %edx,%eax
    7f68:	c1 e0 03             	shl    $0x3,%eax
    7f6b:	01 d0                	add    %edx,%eax
    7f6d:	c1 e0 04             	shl    $0x4,%eax
    7f70:	89 c2                	mov    %eax,%edx
    7f72:	8b 45 0c             	mov    0xc(%ebp),%eax
    7f75:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    7f78:	8b 55 f0             	mov    -0x10(%ebp),%edx
    7f7b:	89 d0                	mov    %edx,%eax
    7f7d:	c1 e0 03             	shl    $0x3,%eax
    7f80:	01 d0                	add    %edx,%eax
    7f82:	c1 e0 04             	shl    $0x4,%eax
    7f85:	89 c2                	mov    %eax,%edx
    7f87:	8b 45 08             	mov    0x8(%ebp),%eax
    7f8a:	01 c2                	add    %eax,%edx
    7f8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7f8f:	dd 04 c2             	fldl   (%edx,%eax,8)
    7f92:	8b 45 f4             	mov    -0xc(%ebp),%eax
    7f95:	dd 1c c1             	fstpl  (%ecx,%eax,8)
   }

   /* clear all inputs */

    for(sb=0;sb<SBLIMIT;sb++)
       for(ss=0;ss<SSLIMIT;ss++)
    7f98:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    7f9c:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    7fa0:	7e c1                	jle    7f63 <III_antialias+0x93>
      init = 0;
   }

   /* clear all inputs */

    for(sb=0;sb<SBLIMIT;sb++)
    7fa2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    7fa6:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
    7faa:	7e ae                	jle    7f5a <III_antialias+0x8a>
       for(ss=0;ss<SSLIMIT;ss++)
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
    7fac:	8b 45 10             	mov    0x10(%ebp),%eax
    7faf:	8b 40 10             	mov    0x10(%eax),%eax
    7fb2:	85 c0                	test   %eax,%eax
    7fb4:	74 19                	je     7fcf <III_antialias+0xff>
    7fb6:	8b 45 10             	mov    0x10(%ebp),%eax
    7fb9:	8b 40 14             	mov    0x14(%eax),%eax
    7fbc:	83 f8 02             	cmp    $0x2,%eax
    7fbf:	75 0e                	jne    7fcf <III_antialias+0xff>
       !gr_info->mixed_block_flag ) return;
    7fc1:	8b 45 10             	mov    0x10(%ebp),%eax
    7fc4:	8b 40 18             	mov    0x18(%eax),%eax

    for(sb=0;sb<SBLIMIT;sb++)
       for(ss=0;ss<SSLIMIT;ss++)
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
    7fc7:	85 c0                	test   %eax,%eax
    7fc9:	0f 84 1e 01 00 00    	je     80ed <III_antialias+0x21d>
       !gr_info->mixed_block_flag ) return;

   if ( gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    7fcf:	8b 45 10             	mov    0x10(%ebp),%eax
    7fd2:	8b 40 10             	mov    0x10(%eax),%eax
    7fd5:	85 c0                	test   %eax,%eax
    7fd7:	74 1e                	je     7ff7 <III_antialias+0x127>
    7fd9:	8b 45 10             	mov    0x10(%ebp),%eax
    7fdc:	8b 40 18             	mov    0x18(%eax),%eax
    7fdf:	85 c0                	test   %eax,%eax
    7fe1:	74 14                	je     7ff7 <III_antialias+0x127>
     (gr_info->block_type == 2))
    7fe3:	8b 45 10             	mov    0x10(%ebp),%eax
    7fe6:	8b 40 14             	mov    0x14(%eax),%eax
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
       !gr_info->mixed_block_flag ) return;

   if ( gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    7fe9:	83 f8 02             	cmp    $0x2,%eax
    7fec:	75 09                	jne    7ff7 <III_antialias+0x127>
     (gr_info->block_type == 2))
      sblim = 1;
    7fee:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
    7ff5:	eb 07                	jmp    7ffe <III_antialias+0x12e>
   else
      sblim = SBLIMIT-1;
    7ff7:	c7 45 ec 1f 00 00 00 	movl   $0x1f,-0x14(%ebp)

   /* 31 alias-reduction operations between each pair of sub-bands */
   /* with 8 butterflies between each pair                         */

   for(sb=0;sb<sblim;sb++)
    7ffe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    8005:	e9 d5 00 00 00       	jmp    80df <III_antialias+0x20f>
      for(ss=0;ss<8;ss++) {
    800a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8011:	e9 bb 00 00 00       	jmp    80d1 <III_antialias+0x201>
         bu = xr[sb][17-ss];
    8016:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8019:	89 d0                	mov    %edx,%eax
    801b:	c1 e0 03             	shl    $0x3,%eax
    801e:	01 d0                	add    %edx,%eax
    8020:	c1 e0 04             	shl    $0x4,%eax
    8023:	89 c2                	mov    %eax,%edx
    8025:	8b 45 08             	mov    0x8(%ebp),%eax
    8028:	01 c2                	add    %eax,%edx
    802a:	b8 11 00 00 00       	mov    $0x11,%eax
    802f:	2b 45 f4             	sub    -0xc(%ebp),%eax
    8032:	dd 04 c2             	fldl   (%edx,%eax,8)
    8035:	dd 5d d8             	fstpl  -0x28(%ebp)
         bd = xr[sb+1][ss];
    8038:	8b 45 f0             	mov    -0x10(%ebp),%eax
    803b:	8d 50 01             	lea    0x1(%eax),%edx
    803e:	89 d0                	mov    %edx,%eax
    8040:	c1 e0 03             	shl    $0x3,%eax
    8043:	01 d0                	add    %edx,%eax
    8045:	c1 e0 04             	shl    $0x4,%eax
    8048:	89 c2                	mov    %eax,%edx
    804a:	8b 45 08             	mov    0x8(%ebp),%eax
    804d:	01 c2                	add    %eax,%edx
    804f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8052:	dd 04 c2             	fldl   (%edx,%eax,8)
    8055:	dd 5d d0             	fstpl  -0x30(%ebp)
         hybridIn[sb][17-ss] = (bu * cs[ss]) - (bd * ca[ss]);
    8058:	8b 55 f0             	mov    -0x10(%ebp),%edx
    805b:	89 d0                	mov    %edx,%eax
    805d:	c1 e0 03             	shl    $0x3,%eax
    8060:	01 d0                	add    %edx,%eax
    8062:	c1 e0 04             	shl    $0x4,%eax
    8065:	89 c2                	mov    %eax,%edx
    8067:	8b 45 0c             	mov    0xc(%ebp),%eax
    806a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    806d:	b8 11 00 00 00       	mov    $0x11,%eax
    8072:	2b 45 f4             	sub    -0xc(%ebp),%eax
    8075:	8b 55 f4             	mov    -0xc(%ebp),%edx
    8078:	dd 04 d5 e0 cb 00 00 	fldl   0xcbe0(,%edx,8)
    807f:	dc 4d d8             	fmull  -0x28(%ebp)
    8082:	8b 55 f4             	mov    -0xc(%ebp),%edx
    8085:	dd 04 d5 20 cc 00 00 	fldl   0xcc20(,%edx,8)
    808c:	dc 4d d0             	fmull  -0x30(%ebp)
    808f:	de e9                	fsubrp %st,%st(1)
    8091:	dd 1c c1             	fstpl  (%ecx,%eax,8)
         hybridIn[sb+1][ss] = (bd * cs[ss]) + (bu * ca[ss]);
    8094:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8097:	8d 50 01             	lea    0x1(%eax),%edx
    809a:	89 d0                	mov    %edx,%eax
    809c:	c1 e0 03             	shl    $0x3,%eax
    809f:	01 d0                	add    %edx,%eax
    80a1:	c1 e0 04             	shl    $0x4,%eax
    80a4:	89 c2                	mov    %eax,%edx
    80a6:	8b 45 0c             	mov    0xc(%ebp),%eax
    80a9:	01 c2                	add    %eax,%edx
    80ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    80ae:	dd 04 c5 e0 cb 00 00 	fldl   0xcbe0(,%eax,8)
    80b5:	dc 4d d0             	fmull  -0x30(%ebp)
    80b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    80bb:	dd 04 c5 20 cc 00 00 	fldl   0xcc20(,%eax,8)
    80c2:	dc 4d d8             	fmull  -0x28(%ebp)
    80c5:	de c1                	faddp  %st,%st(1)
    80c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    80ca:	dd 1c c2             	fstpl  (%edx,%eax,8)

   /* 31 alias-reduction operations between each pair of sub-bands */
   /* with 8 butterflies between each pair                         */

   for(sb=0;sb<sblim;sb++)
      for(ss=0;ss<8;ss++) {
    80cd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    80d1:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
    80d5:	0f 8e 3b ff ff ff    	jle    8016 <III_antialias+0x146>
      sblim = SBLIMIT-1;

   /* 31 alias-reduction operations between each pair of sub-bands */
   /* with 8 butterflies between each pair                         */

   for(sb=0;sb<sblim;sb++)
    80db:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    80df:	8b 45 f0             	mov    -0x10(%ebp),%eax
    80e2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    80e5:	0f 8c 1f ff ff ff    	jl     800a <III_antialias+0x13a>
    80eb:	eb 01                	jmp    80ee <III_antialias+0x21e>
    for(sb=0;sb<SBLIMIT;sb++)
       for(ss=0;ss<SSLIMIT;ss++)
          hybridIn[sb][ss] = xr[sb][ss];

   if  (gr_info->window_switching_flag && (gr_info->block_type == 2) &&
       !gr_info->mixed_block_flag ) return;
    80ed:	90                   	nop
         bu = xr[sb][17-ss];
         bd = xr[sb+1][ss];
         hybridIn[sb][17-ss] = (bu * cs[ss]) - (bd * ca[ss]);
         hybridIn[sb+1][ss] = (bd * cs[ss]) + (bu * ca[ss]);
         }
}
    80ee:	c9                   	leave  
    80ef:	c3                   	ret    

000080f0 <inv_mdct>:


void inv_mdct(double in[18], double out[36], int block_type)
{
    80f0:	55                   	push   %ebp
    80f1:	89 e5                	mov    %esp,%ebp
    80f3:	81 ec 98 00 00 00    	sub    $0x98,%esp
	double  tmp[12],sum;
	static  double  win[4][36];
	static  int init=0;
	static  double COS[4*36];

    if(init==0){
    80f9:	a1 60 cc 00 00       	mov    0xcc60,%eax
    80fe:	85 c0                	test   %eax,%eax
    8100:	0f 85 9f 02 00 00    	jne    83a5 <inv_mdct+0x2b5>

    /* type 0 */
      for(i=0;i<36;i++)
    8106:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    810d:	eb 33                	jmp    8142 <inv_mdct+0x52>
         win[0][i] = sin( PI/36 *(i+0.5) );
    810f:	db 45 f4             	fildl  -0xc(%ebp)
    8112:	dd 05 90 b7 00 00    	fldl   0xb790
    8118:	de c1                	faddp  %st,%st(1)
    811a:	dd 05 98 b7 00 00    	fldl   0xb798
    8120:	de c9                	fmulp  %st,%st(1)
    8122:	83 ec 08             	sub    $0x8,%esp
    8125:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    8129:	dd 1c 24             	fstpl  (%esp)
    812c:	e8 8c a8 ff ff       	call   29bd <sin>
    8131:	83 c4 10             	add    $0x10,%esp
    8134:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8137:	dd 1c c5 80 cc 00 00 	fstpl  0xcc80(,%eax,8)
	static  double COS[4*36];

    if(init==0){

    /* type 0 */
      for(i=0;i<36;i++)
    813e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8142:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    8146:	7e c7                	jle    810f <inv_mdct+0x1f>
         win[0][i] = sin( PI/36 *(i+0.5) );

    /* type 1*/
      for(i=0;i<18;i++)
    8148:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    814f:	eb 36                	jmp    8187 <inv_mdct+0x97>
         win[1][i] = sin( PI/36 *(i+0.5) );
    8151:	db 45 f4             	fildl  -0xc(%ebp)
    8154:	dd 05 90 b7 00 00    	fldl   0xb790
    815a:	de c1                	faddp  %st,%st(1)
    815c:	dd 05 98 b7 00 00    	fldl   0xb798
    8162:	de c9                	fmulp  %st,%st(1)
    8164:	83 ec 08             	sub    $0x8,%esp
    8167:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    816b:	dd 1c 24             	fstpl  (%esp)
    816e:	e8 4a a8 ff ff       	call   29bd <sin>
    8173:	83 c4 10             	add    $0x10,%esp
    8176:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8179:	83 c0 24             	add    $0x24,%eax
    817c:	dd 1c c5 80 cc 00 00 	fstpl  0xcc80(,%eax,8)
    /* type 0 */
      for(i=0;i<36;i++)
         win[0][i] = sin( PI/36 *(i+0.5) );

    /* type 1*/
      for(i=0;i<18;i++)
    8183:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8187:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    818b:	7e c4                	jle    8151 <inv_mdct+0x61>
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
    818d:	c7 45 f4 12 00 00 00 	movl   $0x12,-0xc(%ebp)
    8194:	eb 13                	jmp    81a9 <inv_mdct+0xb9>
         win[1][i] = 1.0;
    8196:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8199:	83 c0 24             	add    $0x24,%eax
    819c:	d9 e8                	fld1   
    819e:	dd 1c c5 80 cc 00 00 	fstpl  0xcc80(,%eax,8)
         win[0][i] = sin( PI/36 *(i+0.5) );

    /* type 1*/
      for(i=0;i<18;i++)
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
    81a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    81a9:	83 7d f4 17          	cmpl   $0x17,-0xc(%ebp)
    81ad:	7e e7                	jle    8196 <inv_mdct+0xa6>
         win[1][i] = 1.0;
      for(i=24;i<30;i++)
    81af:	c7 45 f4 18 00 00 00 	movl   $0x18,-0xc(%ebp)
    81b6:	eb 3e                	jmp    81f6 <inv_mdct+0x106>
         win[1][i] = sin( PI/12 *(i+0.5-18) );
    81b8:	db 45 f4             	fildl  -0xc(%ebp)
    81bb:	dd 05 90 b7 00 00    	fldl   0xb790
    81c1:	de c1                	faddp  %st,%st(1)
    81c3:	dd 05 a0 b7 00 00    	fldl   0xb7a0
    81c9:	de e9                	fsubrp %st,%st(1)
    81cb:	dd 05 80 b7 00 00    	fldl   0xb780
    81d1:	de c9                	fmulp  %st,%st(1)
    81d3:	83 ec 08             	sub    $0x8,%esp
    81d6:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    81da:	dd 1c 24             	fstpl  (%esp)
    81dd:	e8 db a7 ff ff       	call   29bd <sin>
    81e2:	83 c4 10             	add    $0x10,%esp
    81e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    81e8:	83 c0 24             	add    $0x24,%eax
    81eb:	dd 1c c5 80 cc 00 00 	fstpl  0xcc80(,%eax,8)
    /* type 1*/
      for(i=0;i<18;i++)
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
         win[1][i] = 1.0;
      for(i=24;i<30;i++)
    81f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    81f6:	83 7d f4 1d          	cmpl   $0x1d,-0xc(%ebp)
    81fa:	7e bc                	jle    81b8 <inv_mdct+0xc8>
         win[1][i] = sin( PI/12 *(i+0.5-18) );
      for(i=30;i<36;i++)
    81fc:	c7 45 f4 1e 00 00 00 	movl   $0x1e,-0xc(%ebp)
    8203:	eb 13                	jmp    8218 <inv_mdct+0x128>
         win[1][i] = 0.0;
    8205:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8208:	83 c0 24             	add    $0x24,%eax
    820b:	d9 ee                	fldz   
    820d:	dd 1c c5 80 cc 00 00 	fstpl  0xcc80(,%eax,8)
         win[1][i] = sin( PI/36 *(i+0.5) );
      for(i=18;i<24;i++)
         win[1][i] = 1.0;
      for(i=24;i<30;i++)
         win[1][i] = sin( PI/12 *(i+0.5-18) );
      for(i=30;i<36;i++)
    8214:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8218:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    821c:	7e e7                	jle    8205 <inv_mdct+0x115>
         win[1][i] = 0.0;

    /* type 3*/
      for(i=0;i<6;i++)
    821e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8225:	eb 13                	jmp    823a <inv_mdct+0x14a>
         win[3][i] = 0.0;
    8227:	8b 45 f4             	mov    -0xc(%ebp),%eax
    822a:	83 c0 6c             	add    $0x6c,%eax
    822d:	d9 ee                	fldz   
    822f:	dd 1c c5 80 cc 00 00 	fstpl  0xcc80(,%eax,8)
         win[1][i] = sin( PI/12 *(i+0.5-18) );
      for(i=30;i<36;i++)
         win[1][i] = 0.0;

    /* type 3*/
      for(i=0;i<6;i++)
    8236:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    823a:	83 7d f4 05          	cmpl   $0x5,-0xc(%ebp)
    823e:	7e e7                	jle    8227 <inv_mdct+0x137>
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
    8240:	c7 45 f4 06 00 00 00 	movl   $0x6,-0xc(%ebp)
    8247:	eb 3e                	jmp    8287 <inv_mdct+0x197>
         win[3][i] = sin( PI/12 *(i+0.5-6) );
    8249:	db 45 f4             	fildl  -0xc(%ebp)
    824c:	dd 05 90 b7 00 00    	fldl   0xb790
    8252:	de c1                	faddp  %st,%st(1)
    8254:	dd 05 a8 b7 00 00    	fldl   0xb7a8
    825a:	de e9                	fsubrp %st,%st(1)
    825c:	dd 05 80 b7 00 00    	fldl   0xb780
    8262:	de c9                	fmulp  %st,%st(1)
    8264:	83 ec 08             	sub    $0x8,%esp
    8267:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    826b:	dd 1c 24             	fstpl  (%esp)
    826e:	e8 4a a7 ff ff       	call   29bd <sin>
    8273:	83 c4 10             	add    $0x10,%esp
    8276:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8279:	83 c0 6c             	add    $0x6c,%eax
    827c:	dd 1c c5 80 cc 00 00 	fstpl  0xcc80(,%eax,8)
         win[1][i] = 0.0;

    /* type 3*/
      for(i=0;i<6;i++)
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
    8283:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8287:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    828b:	7e bc                	jle    8249 <inv_mdct+0x159>
         win[3][i] = sin( PI/12 *(i+0.5-6) );
      for(i=12;i<18;i++)
    828d:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    8294:	eb 13                	jmp    82a9 <inv_mdct+0x1b9>
         win[3][i] =1.0;
    8296:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8299:	83 c0 6c             	add    $0x6c,%eax
    829c:	d9 e8                	fld1   
    829e:	dd 1c c5 80 cc 00 00 	fstpl  0xcc80(,%eax,8)
    /* type 3*/
      for(i=0;i<6;i++)
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
         win[3][i] = sin( PI/12 *(i+0.5-6) );
      for(i=12;i<18;i++)
    82a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    82a9:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    82ad:	7e e7                	jle    8296 <inv_mdct+0x1a6>
         win[3][i] =1.0;
      for(i=18;i<36;i++)
    82af:	c7 45 f4 12 00 00 00 	movl   $0x12,-0xc(%ebp)
    82b6:	eb 36                	jmp    82ee <inv_mdct+0x1fe>
         win[3][i] = sin( PI/36*(i+0.5) );
    82b8:	db 45 f4             	fildl  -0xc(%ebp)
    82bb:	dd 05 90 b7 00 00    	fldl   0xb790
    82c1:	de c1                	faddp  %st,%st(1)
    82c3:	dd 05 98 b7 00 00    	fldl   0xb798
    82c9:	de c9                	fmulp  %st,%st(1)
    82cb:	83 ec 08             	sub    $0x8,%esp
    82ce:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    82d2:	dd 1c 24             	fstpl  (%esp)
    82d5:	e8 e3 a6 ff ff       	call   29bd <sin>
    82da:	83 c4 10             	add    $0x10,%esp
    82dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    82e0:	83 c0 6c             	add    $0x6c,%eax
    82e3:	dd 1c c5 80 cc 00 00 	fstpl  0xcc80(,%eax,8)
         win[3][i] = 0.0;
      for(i=6;i<12;i++)
         win[3][i] = sin( PI/12 *(i+0.5-6) );
      for(i=12;i<18;i++)
         win[3][i] =1.0;
      for(i=18;i<36;i++)
    82ea:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    82ee:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    82f2:	7e c4                	jle    82b8 <inv_mdct+0x1c8>
         win[3][i] = sin( PI/36*(i+0.5) );

    /* type 2*/
      for(i=0;i<12;i++)
    82f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    82fb:	eb 36                	jmp    8333 <inv_mdct+0x243>
         win[2][i] = sin( PI/12*(i+0.5) ) ;
    82fd:	db 45 f4             	fildl  -0xc(%ebp)
    8300:	dd 05 90 b7 00 00    	fldl   0xb790
    8306:	de c1                	faddp  %st,%st(1)
    8308:	dd 05 80 b7 00 00    	fldl   0xb780
    830e:	de c9                	fmulp  %st,%st(1)
    8310:	83 ec 08             	sub    $0x8,%esp
    8313:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    8317:	dd 1c 24             	fstpl  (%esp)
    831a:	e8 9e a6 ff ff       	call   29bd <sin>
    831f:	83 c4 10             	add    $0x10,%esp
    8322:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8325:	83 c0 48             	add    $0x48,%eax
    8328:	dd 1c c5 80 cc 00 00 	fstpl  0xcc80(,%eax,8)
         win[3][i] =1.0;
      for(i=18;i<36;i++)
         win[3][i] = sin( PI/36*(i+0.5) );

    /* type 2*/
      for(i=0;i<12;i++)
    832f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8333:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    8337:	7e c4                	jle    82fd <inv_mdct+0x20d>
         win[2][i] = sin( PI/12*(i+0.5) ) ;
      for(i=12;i<36;i++)
    8339:	c7 45 f4 0c 00 00 00 	movl   $0xc,-0xc(%ebp)
    8340:	eb 13                	jmp    8355 <inv_mdct+0x265>
         win[2][i] = 0.0 ;
    8342:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8345:	83 c0 48             	add    $0x48,%eax
    8348:	d9 ee                	fldz   
    834a:	dd 1c c5 80 cc 00 00 	fstpl  0xcc80(,%eax,8)
         win[3][i] = sin( PI/36*(i+0.5) );

    /* type 2*/
      for(i=0;i<12;i++)
         win[2][i] = sin( PI/12*(i+0.5) ) ;
      for(i=12;i<36;i++)
    8351:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8355:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    8359:	7e e7                	jle    8342 <inv_mdct+0x252>
         win[2][i] = 0.0 ;

      for (i=0; i<4*36; i++)
    835b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8362:	eb 2b                	jmp    838f <inv_mdct+0x29f>
         COS[i] = cos(PI/(2*36) * i);
    8364:	db 45 f4             	fildl  -0xc(%ebp)
    8367:	dd 05 b0 b7 00 00    	fldl   0xb7b0
    836d:	de c9                	fmulp  %st,%st(1)
    836f:	83 ec 08             	sub    $0x8,%esp
    8372:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    8376:	dd 1c 24             	fstpl  (%esp)
    8379:	e8 de a6 ff ff       	call   2a5c <cos>
    837e:	83 c4 10             	add    $0x10,%esp
    8381:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8384:	dd 1c c5 00 d1 00 00 	fstpl  0xd100(,%eax,8)
      for(i=0;i<12;i++)
         win[2][i] = sin( PI/12*(i+0.5) ) ;
      for(i=12;i<36;i++)
         win[2][i] = 0.0 ;

      for (i=0; i<4*36; i++)
    838b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    838f:	81 7d f4 8f 00 00 00 	cmpl   $0x8f,-0xc(%ebp)
    8396:	7e cc                	jle    8364 <inv_mdct+0x274>
         COS[i] = cos(PI/(2*36) * i);

      init++;
    8398:	a1 60 cc 00 00       	mov    0xcc60,%eax
    839d:	83 c0 01             	add    $0x1,%eax
    83a0:	a3 60 cc 00 00       	mov    %eax,0xcc60
    }

    for(i=0;i<36;i++)
    83a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    83ac:	eb 17                	jmp    83c5 <inv_mdct+0x2d5>
       out[i]=0;
    83ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    83b1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    83b8:	8b 45 0c             	mov    0xc(%ebp),%eax
    83bb:	01 d0                	add    %edx,%eax
    83bd:	d9 ee                	fldz   
    83bf:	dd 18                	fstpl  (%eax)
         COS[i] = cos(PI/(2*36) * i);

      init++;
    }

    for(i=0;i<36;i++)
    83c1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    83c5:	83 7d f4 23          	cmpl   $0x23,-0xc(%ebp)
    83c9:	7e e3                	jle    83ae <inv_mdct+0x2be>
       out[i]=0;

    if(block_type == 2){
    83cb:	83 7d 10 02          	cmpl   $0x2,0x10(%ebp)
    83cf:	0f 85 8f 01 00 00    	jne    8564 <inv_mdct+0x474>
       N=12;
    83d5:	c7 45 dc 0c 00 00 00 	movl   $0xc,-0x24(%ebp)
       for(i=0;i<3;i++){
    83dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    83e3:	e9 6d 01 00 00       	jmp    8555 <inv_mdct+0x465>
          for(p= 0;p<N;p++){
    83e8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    83ef:	e9 e9 00 00 00       	jmp    84dd <inv_mdct+0x3ed>
             sum = 0.0;
    83f4:	d9 ee                	fldz   
    83f6:	dd 5d e0             	fstpl  -0x20(%ebp)
             for(m=0;m<N/2;m++)
    83f9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    8400:	e9 99 00 00 00       	jmp    849e <inv_mdct+0x3ae>
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
    8405:	8b 55 f0             	mov    -0x10(%ebp),%edx
    8408:	89 d0                	mov    %edx,%eax
    840a:	01 c0                	add    %eax,%eax
    840c:	01 c2                	add    %eax,%edx
    840e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8411:	01 d0                	add    %edx,%eax
    8413:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    841a:	8b 45 08             	mov    0x8(%ebp),%eax
    841d:	01 d0                	add    %edx,%eax
    841f:	dd 00                	fldl   (%eax)
    8421:	dd 9d 70 ff ff ff    	fstpl  -0x90(%ebp)
    8427:	8b 45 dc             	mov    -0x24(%ebp),%eax
    842a:	01 c0                	add    %eax,%eax
    842c:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
    8432:	db 85 6c ff ff ff    	fildl  -0x94(%ebp)
    8438:	dd 05 b8 b7 00 00    	fldl   0xb7b8
    843e:	de f1                	fdivp  %st,%st(1)
    8440:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8443:	01 c0                	add    %eax,%eax
    8445:	8d 50 01             	lea    0x1(%eax),%edx
    8448:	8b 45 dc             	mov    -0x24(%ebp),%eax
    844b:	89 c1                	mov    %eax,%ecx
    844d:	c1 e9 1f             	shr    $0x1f,%ecx
    8450:	01 c8                	add    %ecx,%eax
    8452:	d1 f8                	sar    %eax
    8454:	01 d0                	add    %edx,%eax
    8456:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
    845c:	db 85 6c ff ff ff    	fildl  -0x94(%ebp)
    8462:	de c9                	fmulp  %st,%st(1)
    8464:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8467:	01 c0                	add    %eax,%eax
    8469:	83 c0 01             	add    $0x1,%eax
    846c:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
    8472:	db 85 6c ff ff ff    	fildl  -0x94(%ebp)
    8478:	de c9                	fmulp  %st,%st(1)
    847a:	83 ec 08             	sub    $0x8,%esp
    847d:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    8481:	dd 1c 24             	fstpl  (%esp)
    8484:	e8 d3 a5 ff ff       	call   2a5c <cos>
    8489:	83 c4 10             	add    $0x10,%esp
    848c:	dc 8d 70 ff ff ff    	fmull  -0x90(%ebp)
    8492:	dd 45 e0             	fldl   -0x20(%ebp)
    8495:	de c1                	faddp  %st,%st(1)
    8497:	dd 5d e0             	fstpl  -0x20(%ebp)
    if(block_type == 2){
       N=12;
       for(i=0;i<3;i++){
          for(p= 0;p<N;p++){
             sum = 0.0;
             for(m=0;m<N/2;m++)
    849a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    849e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    84a1:	89 c2                	mov    %eax,%edx
    84a3:	c1 ea 1f             	shr    $0x1f,%edx
    84a6:	01 d0                	add    %edx,%eax
    84a8:	d1 f8                	sar    %eax
    84aa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    84ad:	0f 8f 52 ff ff ff    	jg     8405 <inv_mdct+0x315>
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
             tmp[p] = sum * win[block_type][p] ;
    84b3:	8b 55 10             	mov    0x10(%ebp),%edx
    84b6:	89 d0                	mov    %edx,%eax
    84b8:	c1 e0 03             	shl    $0x3,%eax
    84bb:	01 d0                	add    %edx,%eax
    84bd:	c1 e0 02             	shl    $0x2,%eax
    84c0:	8b 55 ec             	mov    -0x14(%ebp),%edx
    84c3:	01 d0                	add    %edx,%eax
    84c5:	dd 04 c5 80 cc 00 00 	fldl   0xcc80(,%eax,8)
    84cc:	dc 4d e0             	fmull  -0x20(%ebp)
    84cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    84d2:	dd 9c c5 78 ff ff ff 	fstpl  -0x88(%ebp,%eax,8)
       out[i]=0;

    if(block_type == 2){
       N=12;
       for(i=0;i<3;i++){
          for(p= 0;p<N;p++){
    84d9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    84dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    84e0:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    84e3:	0f 8c 0b ff ff ff    	jl     83f4 <inv_mdct+0x304>
             sum = 0.0;
             for(m=0;m<N/2;m++)
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
             tmp[p] = sum * win[block_type][p] ;
          }
          for(p=0;p<N;p++)
    84e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    84f0:	eb 57                	jmp    8549 <inv_mdct+0x459>
             out[6*i+p+6] += tmp[p];
    84f2:	8b 55 f4             	mov    -0xc(%ebp),%edx
    84f5:	89 d0                	mov    %edx,%eax
    84f7:	01 c0                	add    %eax,%eax
    84f9:	01 d0                	add    %edx,%eax
    84fb:	01 c0                	add    %eax,%eax
    84fd:	89 c2                	mov    %eax,%edx
    84ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8502:	01 d0                	add    %edx,%eax
    8504:	83 c0 06             	add    $0x6,%eax
    8507:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    850e:	8b 45 0c             	mov    0xc(%ebp),%eax
    8511:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    8514:	8b 55 f4             	mov    -0xc(%ebp),%edx
    8517:	89 d0                	mov    %edx,%eax
    8519:	01 c0                	add    %eax,%eax
    851b:	01 d0                	add    %edx,%eax
    851d:	01 c0                	add    %eax,%eax
    851f:	89 c2                	mov    %eax,%edx
    8521:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8524:	01 d0                	add    %edx,%eax
    8526:	83 c0 06             	add    $0x6,%eax
    8529:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    8530:	8b 45 0c             	mov    0xc(%ebp),%eax
    8533:	01 d0                	add    %edx,%eax
    8535:	dd 00                	fldl   (%eax)
    8537:	8b 45 ec             	mov    -0x14(%ebp),%eax
    853a:	dd 84 c5 78 ff ff ff 	fldl   -0x88(%ebp,%eax,8)
    8541:	de c1                	faddp  %st,%st(1)
    8543:	dd 19                	fstpl  (%ecx)
             sum = 0.0;
             for(m=0;m<N/2;m++)
                sum += in[i+3*m] * cos( PI/(2*N)*(2*p+1+N/2)*(2*m+1) );
             tmp[p] = sum * win[block_type][p] ;
          }
          for(p=0;p<N;p++)
    8545:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8549:	8b 45 ec             	mov    -0x14(%ebp),%eax
    854c:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    854f:	7c a1                	jl     84f2 <inv_mdct+0x402>
    for(i=0;i<36;i++)
       out[i]=0;

    if(block_type == 2){
       N=12;
       for(i=0;i<3;i++){
    8551:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8555:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
    8559:	0f 8e 89 fe ff ff    	jle    83e8 <inv_mdct+0x2f8>
         for(m=0;m<N/2;m++)
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
         out[p] = sum * win[block_type][p];
      }
    }
}
    855f:	e9 da 00 00 00       	jmp    863e <inv_mdct+0x54e>
          for(p=0;p<N;p++)
             out[6*i+p+6] += tmp[p];
       }
    }
    else{
      N=36;
    8564:	c7 45 dc 24 00 00 00 	movl   $0x24,-0x24(%ebp)
      for(p= 0;p<N;p++){
    856b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    8572:	e9 bb 00 00 00       	jmp    8632 <inv_mdct+0x542>
         sum = 0.0;
    8577:	d9 ee                	fldz   
    8579:	dd 5d e0             	fstpl  -0x20(%ebp)
         for(m=0;m<N/2;m++)
    857c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    8583:	eb 6a                	jmp    85ef <inv_mdct+0x4ff>
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
    8585:	8b 45 f0             	mov    -0x10(%ebp),%eax
    8588:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    858f:	8b 45 08             	mov    0x8(%ebp),%eax
    8592:	01 d0                	add    %edx,%eax
    8594:	dd 00                	fldl   (%eax)
    8596:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8599:	01 c0                	add    %eax,%eax
    859b:	8d 50 01             	lea    0x1(%eax),%edx
    859e:	8b 45 dc             	mov    -0x24(%ebp),%eax
    85a1:	89 c1                	mov    %eax,%ecx
    85a3:	c1 e9 1f             	shr    $0x1f,%ecx
    85a6:	01 c8                	add    %ecx,%eax
    85a8:	d1 f8                	sar    %eax
    85aa:	01 c2                	add    %eax,%edx
    85ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    85af:	01 c0                	add    %eax,%eax
    85b1:	83 c0 01             	add    $0x1,%eax
    85b4:	89 d1                	mov    %edx,%ecx
    85b6:	0f af c8             	imul   %eax,%ecx
    85b9:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
    85be:	89 c8                	mov    %ecx,%eax
    85c0:	f7 ea                	imul   %edx
    85c2:	c1 fa 05             	sar    $0x5,%edx
    85c5:	89 c8                	mov    %ecx,%eax
    85c7:	c1 f8 1f             	sar    $0x1f,%eax
    85ca:	29 c2                	sub    %eax,%edx
    85cc:	89 d0                	mov    %edx,%eax
    85ce:	c1 e0 03             	shl    $0x3,%eax
    85d1:	01 d0                	add    %edx,%eax
    85d3:	c1 e0 04             	shl    $0x4,%eax
    85d6:	29 c1                	sub    %eax,%ecx
    85d8:	89 ca                	mov    %ecx,%edx
    85da:	dd 04 d5 00 d1 00 00 	fldl   0xd100(,%edx,8)
    85e1:	de c9                	fmulp  %st,%st(1)
    85e3:	dd 45 e0             	fldl   -0x20(%ebp)
    85e6:	de c1                	faddp  %st,%st(1)
    85e8:	dd 5d e0             	fstpl  -0x20(%ebp)
    }
    else{
      N=36;
      for(p= 0;p<N;p++){
         sum = 0.0;
         for(m=0;m<N/2;m++)
    85eb:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    85ef:	8b 45 dc             	mov    -0x24(%ebp),%eax
    85f2:	89 c2                	mov    %eax,%edx
    85f4:	c1 ea 1f             	shr    $0x1f,%edx
    85f7:	01 d0                	add    %edx,%eax
    85f9:	d1 f8                	sar    %eax
    85fb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    85fe:	7f 85                	jg     8585 <inv_mdct+0x495>
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
         out[p] = sum * win[block_type][p];
    8600:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8603:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    860a:	8b 45 0c             	mov    0xc(%ebp),%eax
    860d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    8610:	8b 55 10             	mov    0x10(%ebp),%edx
    8613:	89 d0                	mov    %edx,%eax
    8615:	c1 e0 03             	shl    $0x3,%eax
    8618:	01 d0                	add    %edx,%eax
    861a:	c1 e0 02             	shl    $0x2,%eax
    861d:	8b 55 ec             	mov    -0x14(%ebp),%edx
    8620:	01 d0                	add    %edx,%eax
    8622:	dd 04 c5 80 cc 00 00 	fldl   0xcc80(,%eax,8)
    8629:	dc 4d e0             	fmull  -0x20(%ebp)
    862c:	dd 19                	fstpl  (%ecx)
             out[6*i+p+6] += tmp[p];
       }
    }
    else{
      N=36;
      for(p= 0;p<N;p++){
    862e:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    8632:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8635:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    8638:	0f 8c 39 ff ff ff    	jl     8577 <inv_mdct+0x487>
         for(m=0;m<N/2;m++)
           sum += in[m] * COS[((2*p+1+N/2)*(2*m+1))%(4*36)];
         out[p] = sum * win[block_type][p];
      }
    }
}
    863e:	90                   	nop
    863f:	c9                   	leave  
    8640:	c3                   	ret    

00008641 <III_hybrid>:


void III_hybrid(double fsIn[SSLIMIT], double tsOut[SSLIMIT], int sb, int ch, struct gr_info_s *gr_info, struct frame_params *fr_ps)
/* fsIn:freq samples per subband in */
/* tsOut:time samples per subband out */
{
    8641:	55                   	push   %ebp
    8642:	89 e5                	mov    %esp,%ebp
    8644:	53                   	push   %ebx
    8645:	81 ec 44 01 00 00    	sub    $0x144,%esp
   double rawout[36];
   static double prevblck[2][SBLIMIT][SSLIMIT];
   static int init = 1;
   int bt;

   if (init) {
    864b:	a1 84 cb 00 00       	mov    0xcb84,%eax
    8650:	85 c0                	test   %eax,%eax
    8652:	74 6f                	je     86c3 <III_hybrid+0x82>
      int i,j,k;

      for(i=0;i<2;i++)
    8654:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    865b:	eb 56                	jmp    86b3 <III_hybrid+0x72>
         for(j=0;j<SBLIMIT;j++)
    865d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    8664:	eb 43                	jmp    86a9 <III_hybrid+0x68>
            for(k=0;k<SSLIMIT;k++)
    8666:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    866d:	eb 30                	jmp    869f <III_hybrid+0x5e>
               prevblck[i][j][k]=0.0;
    866f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    8672:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    8675:	89 c2                	mov    %eax,%edx
    8677:	c1 e2 03             	shl    $0x3,%edx
    867a:	01 c2                	add    %eax,%edx
    867c:	8d 04 12             	lea    (%edx,%edx,1),%eax
    867f:	89 c2                	mov    %eax,%edx
    8681:	89 c8                	mov    %ecx,%eax
    8683:	c1 e0 03             	shl    $0x3,%eax
    8686:	01 c8                	add    %ecx,%eax
    8688:	c1 e0 06             	shl    $0x6,%eax
    868b:	01 c2                	add    %eax,%edx
    868d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    8690:	01 d0                	add    %edx,%eax
    8692:	d9 ee                	fldz   
    8694:	dd 1c c5 80 d5 00 00 	fstpl  0xd580(,%eax,8)
   if (init) {
      int i,j,k;

      for(i=0;i<2;i++)
         for(j=0;j<SBLIMIT;j++)
            for(k=0;k<SSLIMIT;k++)
    869b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    869f:	83 7d e8 11          	cmpl   $0x11,-0x18(%ebp)
    86a3:	7e ca                	jle    866f <III_hybrid+0x2e>

   if (init) {
      int i,j,k;

      for(i=0;i<2;i++)
         for(j=0;j<SBLIMIT;j++)
    86a5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    86a9:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
    86ad:	7e b7                	jle    8666 <III_hybrid+0x25>
   int bt;

   if (init) {
      int i,j,k;

      for(i=0;i<2;i++)
    86af:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    86b3:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    86b7:	7e a4                	jle    865d <III_hybrid+0x1c>
         for(j=0;j<SBLIMIT;j++)
            for(k=0;k<SSLIMIT;k++)
               prevblck[i][j][k]=0.0;
      init = 0;
    86b9:	c7 05 84 cb 00 00 00 	movl   $0x0,0xcb84
    86c0:	00 00 00 
   }

   bt = (gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    86c3:	8b 45 18             	mov    0x18(%ebp),%eax
    86c6:	8b 40 10             	mov    0x10(%eax),%eax
    86c9:	85 c0                	test   %eax,%eax
    86cb:	74 10                	je     86dd <III_hybrid+0x9c>
    86cd:	8b 45 18             	mov    0x18(%ebp),%eax
    86d0:	8b 40 18             	mov    0x18(%eax),%eax
    86d3:	85 c0                	test   %eax,%eax
    86d5:	74 06                	je     86dd <III_hybrid+0x9c>
    86d7:	83 7d 10 01          	cmpl   $0x1,0x10(%ebp)
    86db:	7e 08                	jle    86e5 <III_hybrid+0xa4>
          (sb < 2)) ? 0 : gr_info->block_type;
    86dd:	8b 45 18             	mov    0x18(%ebp),%eax
    86e0:	8b 40 14             	mov    0x14(%eax),%eax
            for(k=0;k<SSLIMIT;k++)
               prevblck[i][j][k]=0.0;
      init = 0;
   }

   bt = (gr_info->window_switching_flag && gr_info->mixed_block_flag &&
    86e3:	eb 05                	jmp    86ea <III_hybrid+0xa9>
    86e5:	b8 00 00 00 00       	mov    $0x0,%eax
    86ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
          (sb < 2)) ? 0 : gr_info->block_type;

   inv_mdct( fsIn, rawout, bt);
    86ed:	83 ec 04             	sub    $0x4,%esp
    86f0:	ff 75 e4             	pushl  -0x1c(%ebp)
    86f3:	8d 85 c0 fe ff ff    	lea    -0x140(%ebp),%eax
    86f9:	50                   	push   %eax
    86fa:	ff 75 08             	pushl  0x8(%ebp)
    86fd:	e8 ee f9 ff ff       	call   80f0 <inv_mdct>
    8702:	83 c4 10             	add    $0x10,%esp

   /* overlap addition */
   for(ss=0; ss<SSLIMIT; ss++) {
    8705:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    870c:	e9 83 00 00 00       	jmp    8794 <III_hybrid+0x153>
      tsOut[ss] = rawout[ss] + prevblck[ch][sb][ss];
    8711:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8714:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    871b:	8b 45 0c             	mov    0xc(%ebp),%eax
    871e:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
    8721:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8724:	dd 84 c5 c0 fe ff ff 	fldl   -0x140(%ebp,%eax,8)
    872b:	8b 45 10             	mov    0x10(%ebp),%eax
    872e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    8731:	89 c2                	mov    %eax,%edx
    8733:	c1 e2 03             	shl    $0x3,%edx
    8736:	01 c2                	add    %eax,%edx
    8738:	8d 04 12             	lea    (%edx,%edx,1),%eax
    873b:	89 c2                	mov    %eax,%edx
    873d:	89 c8                	mov    %ecx,%eax
    873f:	c1 e0 03             	shl    $0x3,%eax
    8742:	01 c8                	add    %ecx,%eax
    8744:	c1 e0 06             	shl    $0x6,%eax
    8747:	01 c2                	add    %eax,%edx
    8749:	8b 45 f4             	mov    -0xc(%ebp),%eax
    874c:	01 d0                	add    %edx,%eax
    874e:	dd 04 c5 80 d5 00 00 	fldl   0xd580(,%eax,8)
    8755:	de c1                	faddp  %st,%st(1)
    8757:	dd 1b                	fstpl  (%ebx)
      prevblck[ch][sb][ss] = rawout[ss+18];
    8759:	8b 45 f4             	mov    -0xc(%ebp),%eax
    875c:	83 c0 12             	add    $0x12,%eax
    875f:	dd 84 c5 c0 fe ff ff 	fldl   -0x140(%ebp,%eax,8)
    8766:	8b 45 10             	mov    0x10(%ebp),%eax
    8769:	8b 4d 14             	mov    0x14(%ebp),%ecx
    876c:	89 c2                	mov    %eax,%edx
    876e:	c1 e2 03             	shl    $0x3,%edx
    8771:	01 c2                	add    %eax,%edx
    8773:	8d 04 12             	lea    (%edx,%edx,1),%eax
    8776:	89 c2                	mov    %eax,%edx
    8778:	89 c8                	mov    %ecx,%eax
    877a:	c1 e0 03             	shl    $0x3,%eax
    877d:	01 c8                	add    %ecx,%eax
    877f:	c1 e0 06             	shl    $0x6,%eax
    8782:	01 c2                	add    %eax,%edx
    8784:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8787:	01 d0                	add    %edx,%eax
    8789:	dd 1c c5 80 d5 00 00 	fstpl  0xd580(,%eax,8)
          (sb < 2)) ? 0 : gr_info->block_type;

   inv_mdct( fsIn, rawout, bt);

   /* overlap addition */
   for(ss=0; ss<SSLIMIT; ss++) {
    8790:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8794:	83 7d f4 11          	cmpl   $0x11,-0xc(%ebp)
    8798:	0f 8e 73 ff ff ff    	jle    8711 <III_hybrid+0xd0>
      tsOut[ss] = rawout[ss] + prevblck[ch][sb][ss];
      prevblck[ch][sb][ss] = rawout[ss+18];
   }
}
    879e:	90                   	nop
    879f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    87a2:	c9                   	leave  
    87a3:	c3                   	ret    

000087a4 <create_syn_filter>:


/* create in synthesis filter */
void create_syn_filter(double filter[64][SBLIMIT])
{
    87a4:	55                   	push   %ebp
    87a5:	89 e5                	mov    %esp,%ebp
    87a7:	57                   	push   %edi
    87a8:	56                   	push   %esi
    87a9:	53                   	push   %ebx
    87aa:	83 ec 1c             	sub    $0x1c,%esp
	register int i,k;

	for (i=0; i<64; i++)
    87ad:	be 00 00 00 00       	mov    $0x0,%esi
    87b2:	e9 1a 01 00 00       	jmp    88d1 <create_syn_filter+0x12d>
		for (k=0; k<32; k++) {
    87b7:	bb 00 00 00 00       	mov    $0x0,%ebx
    87bc:	e9 04 01 00 00       	jmp    88c5 <create_syn_filter+0x121>
			if ((filter[i][k] = 1e9*cos((double)((PI64*i+PI4)*(2*k+1)))) >= 0)
    87c1:	89 f0                	mov    %esi,%eax
    87c3:	c1 e0 08             	shl    $0x8,%eax
    87c6:	89 c2                	mov    %eax,%edx
    87c8:	8b 45 08             	mov    0x8(%ebp),%eax
    87cb:	8d 3c 02             	lea    (%edx,%eax,1),%edi
    87ce:	89 75 dc             	mov    %esi,-0x24(%ebp)
    87d1:	db 45 dc             	fildl  -0x24(%ebp)
    87d4:	dd 05 c0 b7 00 00    	fldl   0xb7c0
    87da:	de c9                	fmulp  %st,%st(1)
    87dc:	dd 05 c8 b7 00 00    	fldl   0xb7c8
    87e2:	de c1                	faddp  %st,%st(1)
    87e4:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
    87e7:	83 c0 01             	add    $0x1,%eax
    87ea:	89 45 dc             	mov    %eax,-0x24(%ebp)
    87ed:	db 45 dc             	fildl  -0x24(%ebp)
    87f0:	de c9                	fmulp  %st,%st(1)
    87f2:	83 ec 08             	sub    $0x8,%esp
    87f5:	8d 64 24 f8          	lea    -0x8(%esp),%esp
    87f9:	dd 1c 24             	fstpl  (%esp)
    87fc:	e8 5b a2 ff ff       	call   2a5c <cos>
    8801:	83 c4 10             	add    $0x10,%esp
    8804:	dd 05 d0 b7 00 00    	fldl   0xb7d0
    880a:	de c9                	fmulp  %st,%st(1)
    880c:	dd 1c df             	fstpl  (%edi,%ebx,8)
    880f:	dd 04 df             	fldl   (%edi,%ebx,8)
    8812:	d9 ee                	fldz   
    8814:	d9 c9                	fxch   %st(1)
    8816:	df e9                	fucomip %st(1),%st
    8818:	dd d8                	fstp   %st(0)
    881a:	72 41                	jb     885d <create_syn_filter+0xb9>
				filter[i][k] = (int)(filter[i][k]+0.5);
    881c:	89 f0                	mov    %esi,%eax
    881e:	c1 e0 08             	shl    $0x8,%eax
    8821:	89 c2                	mov    %eax,%edx
    8823:	8b 45 08             	mov    0x8(%ebp),%eax
    8826:	01 c2                	add    %eax,%edx
    8828:	89 f0                	mov    %esi,%eax
    882a:	c1 e0 08             	shl    $0x8,%eax
    882d:	89 c1                	mov    %eax,%ecx
    882f:	8b 45 08             	mov    0x8(%ebp),%eax
    8832:	01 c8                	add    %ecx,%eax
    8834:	dd 04 d8             	fldl   (%eax,%ebx,8)
    8837:	dd 05 90 b7 00 00    	fldl   0xb790
    883d:	de c1                	faddp  %st,%st(1)
    883f:	d9 7d e6             	fnstcw -0x1a(%ebp)
    8842:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    8846:	b4 0c                	mov    $0xc,%ah
    8848:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    884c:	d9 6d e4             	fldcw  -0x1c(%ebp)
    884f:	db 5d dc             	fistpl -0x24(%ebp)
    8852:	d9 6d e6             	fldcw  -0x1a(%ebp)
    8855:	db 45 dc             	fildl  -0x24(%ebp)
    8858:	dd 1c da             	fstpl  (%edx,%ebx,8)
    885b:	eb 3f                	jmp    889c <create_syn_filter+0xf8>
				//modf(filter[i][k]+0.5, &filter[i][k]);
			else
				filter[i][k] = (int)(filter[i][k]-0.5);
    885d:	89 f0                	mov    %esi,%eax
    885f:	c1 e0 08             	shl    $0x8,%eax
    8862:	89 c2                	mov    %eax,%edx
    8864:	8b 45 08             	mov    0x8(%ebp),%eax
    8867:	01 c2                	add    %eax,%edx
    8869:	89 f0                	mov    %esi,%eax
    886b:	c1 e0 08             	shl    $0x8,%eax
    886e:	89 c1                	mov    %eax,%ecx
    8870:	8b 45 08             	mov    0x8(%ebp),%eax
    8873:	01 c8                	add    %ecx,%eax
    8875:	dd 04 d8             	fldl   (%eax,%ebx,8)
    8878:	dd 05 90 b7 00 00    	fldl   0xb790
    887e:	de e9                	fsubrp %st,%st(1)
    8880:	d9 7d e6             	fnstcw -0x1a(%ebp)
    8883:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
    8887:	b4 0c                	mov    $0xc,%ah
    8889:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
    888d:	d9 6d e4             	fldcw  -0x1c(%ebp)
    8890:	db 5d dc             	fistpl -0x24(%ebp)
    8893:	d9 6d e6             	fldcw  -0x1a(%ebp)
    8896:	db 45 dc             	fildl  -0x24(%ebp)
    8899:	dd 1c da             	fstpl  (%edx,%ebx,8)
				//modf(filter[i][k]-0.5, &filter[i][k]);
			filter[i][k] *= 1e-9;
    889c:	89 f0                	mov    %esi,%eax
    889e:	c1 e0 08             	shl    $0x8,%eax
    88a1:	89 c2                	mov    %eax,%edx
    88a3:	8b 45 08             	mov    0x8(%ebp),%eax
    88a6:	01 d0                	add    %edx,%eax
    88a8:	89 f2                	mov    %esi,%edx
    88aa:	89 d1                	mov    %edx,%ecx
    88ac:	c1 e1 08             	shl    $0x8,%ecx
    88af:	8b 55 08             	mov    0x8(%ebp),%edx
    88b2:	01 ca                	add    %ecx,%edx
    88b4:	dd 04 da             	fldl   (%edx,%ebx,8)
    88b7:	dd 05 d8 b7 00 00    	fldl   0xb7d8
    88bd:	de c9                	fmulp  %st,%st(1)
    88bf:	dd 1c d8             	fstpl  (%eax,%ebx,8)
void create_syn_filter(double filter[64][SBLIMIT])
{
	register int i,k;

	for (i=0; i<64; i++)
		for (k=0; k<32; k++) {
    88c2:	83 c3 01             	add    $0x1,%ebx
    88c5:	83 fb 1f             	cmp    $0x1f,%ebx
    88c8:	0f 8e f3 fe ff ff    	jle    87c1 <create_syn_filter+0x1d>
/* create in synthesis filter */
void create_syn_filter(double filter[64][SBLIMIT])
{
	register int i,k;

	for (i=0; i<64; i++)
    88ce:	83 c6 01             	add    $0x1,%esi
    88d1:	83 fe 3f             	cmp    $0x3f,%esi
    88d4:	0f 8e dd fe ff ff    	jle    87b7 <create_syn_filter+0x13>
			else
				filter[i][k] = (int)(filter[i][k]-0.5);
				//modf(filter[i][k]-0.5, &filter[i][k]);
			filter[i][k] *= 1e-9;
		}
}
    88da:	90                   	nop
    88db:	8d 65 f4             	lea    -0xc(%ebp),%esp
    88de:	5b                   	pop    %ebx
    88df:	5e                   	pop    %esi
    88e0:	5f                   	pop    %edi
    88e1:	5d                   	pop    %ebp
    88e2:	c3                   	ret    

000088e3 <read_syn_window>:



/* read in synthesis window */
void read_syn_window(double window[HAN_SIZE])
{
    88e3:	55                   	push   %ebp
    88e4:	89 e5                	mov    %esp,%ebp
    88e6:	57                   	push   %edi
    88e7:	56                   	push   %esi
    88e8:	53                   	push   %ebx
    88e9:	81 ec 04 10 00 00    	sub    $0x1004,%esp
	double gb_window[HAN_SIZE] = {0.0000000000, -0.0000152590, -0.0000152590, -0.0000152590,
    88ef:	8d 85 f0 ef ff ff    	lea    -0x1010(%ebp),%eax
    88f5:	bb 40 a7 00 00       	mov    $0xa740,%ebx
    88fa:	ba 00 04 00 00       	mov    $0x400,%edx
    88ff:	89 c7                	mov    %eax,%edi
    8901:	89 de                	mov    %ebx,%esi
    8903:	89 d1                	mov    %edx,%ecx
    8905:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		0.0000762940, 0.0000762940, 0.0000610350, 0.0000610350,
		0.0000457760, 0.0000457760, 0.0000305180, 0.0000305180,
		0.0000305180, 0.0000305180, 0.0000152590, 0.0000152590,
		0.0000152590, 0.0000152590, 0.0000152590, 0.0000152590,
	};
	window = gb_window;
    8907:	8d 85 f0 ef ff ff    	lea    -0x1010(%ebp),%eax
    890d:	89 45 08             	mov    %eax,0x8(%ebp)
}
    8910:	90                   	nop
    8911:	81 c4 04 10 00 00    	add    $0x1004,%esp
    8917:	5b                   	pop    %ebx
    8918:	5e                   	pop    %esi
    8919:	5f                   	pop    %edi
    891a:	5d                   	pop    %ebp
    891b:	c3                   	ret    

0000891c <SubBandSynthesis>:

int SubBandSynthesis (double *bandPtr, int channel, short *samples)
{
    891c:	55                   	push   %ebp
    891d:	89 e5                	mov    %esp,%ebp
    891f:	57                   	push   %edi
    8920:	56                   	push   %esi
    8921:	53                   	push   %ebx
    8922:	83 ec 2c             	sub    $0x2c,%esp
	static NN *filter;
	typedef double BB[2][2*HAN_SIZE];
	static BB *buf;
	static int bufOffset[2] = {64,64};
	static double *window;
	int clip = 0;               /* count & return how many samples clipped */
    8925:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	if (init) {
    892c:	a1 88 cb 00 00       	mov    0xcb88,%eax
    8931:	85 c0                	test   %eax,%eax
    8933:	74 7a                	je     89af <SubBandSynthesis+0x93>
		buf = (BB *) mem_alloc(sizeof(BB),"BB");
    8935:	83 ec 08             	sub    $0x8,%esp
    8938:	68 40 b7 00 00       	push   $0xb740
    893d:	68 00 40 00 00       	push   $0x4000
    8942:	e8 00 a8 ff ff       	call   3147 <mem_alloc>
    8947:	83 c4 10             	add    $0x10,%esp
    894a:	a3 80 f9 00 00       	mov    %eax,0xf980
		filter = (NN *) mem_alloc(sizeof(NN), "NN");
    894f:	83 ec 08             	sub    $0x8,%esp
    8952:	68 43 b7 00 00       	push   $0xb743
    8957:	68 00 40 00 00       	push   $0x4000
    895c:	e8 e6 a7 ff ff       	call   3147 <mem_alloc>
    8961:	83 c4 10             	add    $0x10,%esp
    8964:	a3 84 f9 00 00       	mov    %eax,0xf984
		create_syn_filter(*filter);
    8969:	a1 84 f9 00 00       	mov    0xf984,%eax
    896e:	83 ec 0c             	sub    $0xc,%esp
    8971:	50                   	push   %eax
    8972:	e8 2d fe ff ff       	call   87a4 <create_syn_filter>
    8977:	83 c4 10             	add    $0x10,%esp
		window = (double *) mem_alloc(sizeof(double) * HAN_SIZE, "WIN");
    897a:	83 ec 08             	sub    $0x8,%esp
    897d:	68 46 b7 00 00       	push   $0xb746
    8982:	68 00 10 00 00       	push   $0x1000
    8987:	e8 bb a7 ff ff       	call   3147 <mem_alloc>
    898c:	83 c4 10             	add    $0x10,%esp
    898f:	a3 88 f9 00 00       	mov    %eax,0xf988
		read_syn_window(window);
    8994:	a1 88 f9 00 00       	mov    0xf988,%eax
    8999:	83 ec 0c             	sub    $0xc,%esp
    899c:	50                   	push   %eax
    899d:	e8 41 ff ff ff       	call   88e3 <read_syn_window>
    89a2:	83 c4 10             	add    $0x10,%esp
		init = 0;
    89a5:	c7 05 88 cb 00 00 00 	movl   $0x0,0xcb88
    89ac:	00 00 00 
	}
/*    if (channel == 0) */
	bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
    89af:	8b 45 0c             	mov    0xc(%ebp),%eax
    89b2:	8b 04 85 8c cb 00 00 	mov    0xcb8c(,%eax,4),%eax
    89b9:	83 e8 40             	sub    $0x40,%eax
    89bc:	25 ff 03 00 00       	and    $0x3ff,%eax
    89c1:	89 c2                	mov    %eax,%edx
    89c3:	8b 45 0c             	mov    0xc(%ebp),%eax
    89c6:	89 14 85 8c cb 00 00 	mov    %edx,0xcb8c(,%eax,4)
	bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);
    89cd:	8b 15 80 f9 00 00    	mov    0xf980,%edx
    89d3:	8b 45 0c             	mov    0xc(%ebp),%eax
    89d6:	8b 04 85 8c cb 00 00 	mov    0xcb8c(,%eax,4),%eax
    89dd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    89e0:	c1 e1 0a             	shl    $0xa,%ecx
    89e3:	01 c8                	add    %ecx,%eax
    89e5:	c1 e0 03             	shl    $0x3,%eax
    89e8:	8d 3c 02             	lea    (%edx,%eax,1),%edi

	for (i=0; i<64; i++) {
    89eb:	bb 00 00 00 00       	mov    $0x0,%ebx
    89f0:	eb 40                	jmp    8a32 <SubBandSynthesis+0x116>
		sum = 0;
    89f2:	d9 ee                	fldz   
		for (k=0; k<32; k++)
    89f4:	be 00 00 00 00       	mov    $0x0,%esi
    89f9:	eb 26                	jmp    8a21 <SubBandSynthesis+0x105>
			sum += bandPtr[k] * (*filter)[i][k];
    89fb:	89 f0                	mov    %esi,%eax
    89fd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    8a04:	8b 45 08             	mov    0x8(%ebp),%eax
    8a07:	01 d0                	add    %edx,%eax
    8a09:	dd 00                	fldl   (%eax)
    8a0b:	a1 84 f9 00 00       	mov    0xf984,%eax
    8a10:	89 da                	mov    %ebx,%edx
    8a12:	c1 e2 05             	shl    $0x5,%edx
    8a15:	01 f2                	add    %esi,%edx
    8a17:	dd 04 d0             	fldl   (%eax,%edx,8)
    8a1a:	de c9                	fmulp  %st,%st(1)
    8a1c:	de c1                	faddp  %st,%st(1)
	bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
	bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);

	for (i=0; i<64; i++) {
		sum = 0;
		for (k=0; k<32; k++)
    8a1e:	83 c6 01             	add    $0x1,%esi
    8a21:	83 fe 1f             	cmp    $0x1f,%esi
    8a24:	7e d5                	jle    89fb <SubBandSynthesis+0xdf>
			sum += bandPtr[k] * (*filter)[i][k];
		bufOffsetPtr[i] = sum;
    8a26:	89 d8                	mov    %ebx,%eax
    8a28:	c1 e0 03             	shl    $0x3,%eax
    8a2b:	01 f8                	add    %edi,%eax
    8a2d:	dd 18                	fstpl  (%eax)
	}
/*    if (channel == 0) */
	bufOffset[channel] = (bufOffset[channel] - 64) & 0x3ff;
	bufOffsetPtr = &((*buf)[channel][bufOffset[channel]]);

	for (i=0; i<64; i++) {
    8a2f:	83 c3 01             	add    $0x1,%ebx
    8a32:	83 fb 3f             	cmp    $0x3f,%ebx
    8a35:	7e bb                	jle    89f2 <SubBandSynthesis+0xd6>
			sum += bandPtr[k] * (*filter)[i][k];
		bufOffsetPtr[i] = sum;
	}
	/*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
    8a37:	bf 00 00 00 00       	mov    $0x0,%edi
    8a3c:	e9 c7 00 00 00       	jmp    8b08 <SubBandSynthesis+0x1ec>
		sum = 0;
    8a41:	d9 ee                	fldz   
		for (i=0; i<16; i++) {
    8a43:	bb 00 00 00 00       	mov    $0x0,%ebx
    8a48:	eb 4c                	jmp    8a96 <SubBandSynthesis+0x17a>
			k = j + (i<<5);
    8a4a:	89 d8                	mov    %ebx,%eax
    8a4c:	c1 e0 05             	shl    $0x5,%eax
    8a4f:	8d 34 38             	lea    (%eax,%edi,1),%esi
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
    8a52:	a1 88 f9 00 00       	mov    0xf988,%eax
    8a57:	89 f2                	mov    %esi,%edx
    8a59:	c1 e2 03             	shl    $0x3,%edx
    8a5c:	01 d0                	add    %edx,%eax
    8a5e:	dd 00                	fldl   (%eax)
    8a60:	a1 80 f9 00 00       	mov    0xf980,%eax
    8a65:	8d 53 01             	lea    0x1(%ebx),%edx
    8a68:	d1 fa                	sar    %edx
    8a6a:	c1 e2 06             	shl    $0x6,%edx
    8a6d:	8d 0c 32             	lea    (%edx,%esi,1),%ecx
												bufOffset[channel]) & 0x3ff];
    8a70:	8b 55 0c             	mov    0xc(%ebp),%edx
    8a73:	8b 14 95 8c cb 00 00 	mov    0xcb8c(,%edx,4),%edx
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
		sum = 0;
		for (i=0; i<16; i++) {
			k = j + (i<<5);
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
    8a7a:	01 ca                	add    %ecx,%edx
												bufOffset[channel]) & 0x3ff];
    8a7c:	89 d1                	mov    %edx,%ecx
    8a7e:	81 e1 ff 03 00 00    	and    $0x3ff,%ecx
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
		sum = 0;
		for (i=0; i<16; i++) {
			k = j + (i<<5);
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
    8a84:	8b 55 0c             	mov    0xc(%ebp),%edx
    8a87:	c1 e2 0a             	shl    $0xa,%edx
    8a8a:	01 ca                	add    %ecx,%edx
    8a8c:	dd 04 d0             	fldl   (%eax,%edx,8)
    8a8f:	de c9                	fmulp  %st,%st(1)
    8a91:	de c1                	faddp  %st,%st(1)
	}
	/*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
		sum = 0;
		for (i=0; i<16; i++) {
    8a93:	83 c3 01             	add    $0x1,%ebx
    8a96:	83 fb 0f             	cmp    $0xf,%ebx
    8a99:	7e af                	jle    8a4a <SubBandSynthesis+0x12e>
			sum += window[k] * (*buf) [channel] [( (k + ( ((i+1)>>1) <<6) ) +
												bufOffset[channel]) & 0x3ff];
		}
		{
			/*long foo = (sum > 0) ? sum * SCALE + 0.5 : sum * SCALE - 0.5; */
			long foo = sum * SCALE;
    8a9b:	dd 05 e0 b7 00 00    	fldl   0xb7e0
    8aa1:	de c9                	fmulp  %st,%st(1)
    8aa3:	d9 7d d6             	fnstcw -0x2a(%ebp)
    8aa6:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
    8aaa:	b4 0c                	mov    $0xc,%ah
    8aac:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
    8ab0:	d9 6d d4             	fldcw  -0x2c(%ebp)
    8ab3:	db 5d e0             	fistpl -0x20(%ebp)
    8ab6:	d9 6d d6             	fldcw  -0x2a(%ebp)
			if (foo >= (long) SCALE)      {samples[j] = SCALE-1; ++clip;}
    8ab9:	81 7d e0 ff 7f 00 00 	cmpl   $0x7fff,-0x20(%ebp)
    8ac0:	7e 15                	jle    8ad7 <SubBandSynthesis+0x1bb>
    8ac2:	89 f8                	mov    %edi,%eax
    8ac4:	8d 14 00             	lea    (%eax,%eax,1),%edx
    8ac7:	8b 45 10             	mov    0x10(%ebp),%eax
    8aca:	01 d0                	add    %edx,%eax
    8acc:	66 c7 00 ff 7f       	movw   $0x7fff,(%eax)
    8ad1:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    8ad5:	eb 2e                	jmp    8b05 <SubBandSynthesis+0x1e9>
			else if (foo < (long) -SCALE) {samples[j] = -SCALE;  ++clip;}
    8ad7:	81 7d e0 00 80 ff ff 	cmpl   $0xffff8000,-0x20(%ebp)
    8ade:	7d 15                	jge    8af5 <SubBandSynthesis+0x1d9>
    8ae0:	89 f8                	mov    %edi,%eax
    8ae2:	8d 14 00             	lea    (%eax,%eax,1),%edx
    8ae5:	8b 45 10             	mov    0x10(%ebp),%eax
    8ae8:	01 d0                	add    %edx,%eax
    8aea:	66 c7 00 00 80       	movw   $0x8000,(%eax)
    8aef:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    8af3:	eb 10                	jmp    8b05 <SubBandSynthesis+0x1e9>
			else                           samples[j] = foo;
    8af5:	89 f8                	mov    %edi,%eax
    8af7:	8d 14 00             	lea    (%eax,%eax,1),%edx
    8afa:	8b 45 10             	mov    0x10(%ebp),%eax
    8afd:	01 d0                	add    %edx,%eax
    8aff:	8b 55 e0             	mov    -0x20(%ebp),%edx
    8b02:	66 89 10             	mov    %dx,(%eax)
			sum += bandPtr[k] * (*filter)[i][k];
		bufOffsetPtr[i] = sum;
	}
	/*  S(i,j) = D(j+32i) * U(j+32i+((i+1)>>1)*64)  */
	/*  samples(i,j) = MWindow(j+32i) * bufPtr(j+32i+((i+1)>>1)*64)  */
	for (j=0; j<32; j++) {
    8b05:	83 c7 01             	add    $0x1,%edi
    8b08:	83 ff 1f             	cmp    $0x1f,%edi
    8b0b:	0f 8e 30 ff ff ff    	jle    8a41 <SubBandSynthesis+0x125>
			if (foo >= (long) SCALE)      {samples[j] = SCALE-1; ++clip;}
			else if (foo < (long) -SCALE) {samples[j] = -SCALE;  ++clip;}
			else                           samples[j] = foo;
		}
	}
    return(clip);
    8b11:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
    8b14:	8d 65 f4             	lea    -0xc(%ebp),%esp
    8b17:	5b                   	pop    %ebx
    8b18:	5e                   	pop    %esi
    8b19:	5f                   	pop    %edi
    8b1a:	5d                   	pop    %ebp
    8b1b:	c3                   	ret    

00008b1c <out_fifo>:

void out_fifo(short pcm_sample[2][SSLIMIT][SBLIMIT], int num, struct frame_params *fr_ps, unsigned long *psampFrames)
{
    8b1c:	55                   	push   %ebp
    8b1d:	89 e5                	mov    %esp,%ebp
    8b1f:	83 ec 10             	sub    $0x10,%esp
	int i,j,l;
	int stereo = fr_ps->stereo;
    8b22:	8b 45 10             	mov    0x10(%ebp),%eax
    8b25:	8b 40 08             	mov    0x8(%eax),%eax
    8b28:	89 45 f0             	mov    %eax,-0x10(%ebp)
	//int sblimit = fr_ps->sblimit;
	static long k = 0;

        for (i=0;i<num;i++) for (j=0;j<SBLIMIT;j++) {
    8b2b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    8b32:	eb 75                	jmp    8ba9 <out_fifo+0x8d>
    8b34:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    8b3b:	eb 62                	jmp    8b9f <out_fifo+0x83>
            (*psampFrames)++;
    8b3d:	8b 45 14             	mov    0x14(%ebp),%eax
    8b40:	8b 00                	mov    (%eax),%eax
    8b42:	8d 50 01             	lea    0x1(%eax),%edx
    8b45:	8b 45 14             	mov    0x14(%ebp),%eax
    8b48:	89 10                	mov    %edx,(%eax)
            for (l=0;l<stereo;l++) {
    8b4a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    8b51:	eb 40                	jmp    8b93 <out_fifo+0x77>
                if (!(k%1600) && k) {
    8b53:	8b 0d 8c f9 00 00    	mov    0xf98c,%ecx
    8b59:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    8b5e:	89 c8                	mov    %ecx,%eax
    8b60:	f7 ea                	imul   %edx
    8b62:	c1 fa 09             	sar    $0x9,%edx
    8b65:	89 c8                	mov    %ecx,%eax
    8b67:	c1 f8 1f             	sar    $0x1f,%eax
    8b6a:	29 c2                	sub    %eax,%edx
    8b6c:	89 d0                	mov    %edx,%eax
    8b6e:	69 c0 40 06 00 00    	imul   $0x640,%eax,%eax
    8b74:	29 c1                	sub    %eax,%ecx
    8b76:	89 c8                	mov    %ecx,%eax
    8b78:	85 c0                	test   %eax,%eax
    8b7a:	75 13                	jne    8b8f <out_fifo+0x73>
    8b7c:	a1 8c f9 00 00       	mov    0xf98c,%eax
    8b81:	85 c0                	test   %eax,%eax
    8b83:	74 0a                	je     8b8f <out_fifo+0x73>
                    //fwrite(outsamp,2,1600,outFile);
                    k = 0;
    8b85:	c7 05 8c f9 00 00 00 	movl   $0x0,0xf98c
    8b8c:	00 00 00 
	//int sblimit = fr_ps->sblimit;
	static long k = 0;

        for (i=0;i<num;i++) for (j=0;j<SBLIMIT;j++) {
            (*psampFrames)++;
            for (l=0;l<stereo;l++) {
    8b8f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    8b93:	8b 45 f4             	mov    -0xc(%ebp),%eax
    8b96:	3b 45 f0             	cmp    -0x10(%ebp),%eax
    8b99:	7c b8                	jl     8b53 <out_fifo+0x37>
	int i,j,l;
	int stereo = fr_ps->stereo;
	//int sblimit = fr_ps->sblimit;
	static long k = 0;

        for (i=0;i<num;i++) for (j=0;j<SBLIMIT;j++) {
    8b9b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    8b9f:	83 7d f8 1f          	cmpl   $0x1f,-0x8(%ebp)
    8ba3:	7e 98                	jle    8b3d <out_fifo+0x21>
    8ba5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    8ba9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    8bac:	3b 45 0c             	cmp    0xc(%ebp),%eax
    8baf:	7c 83                	jl     8b34 <out_fifo+0x18>
                    k = 0;
                }
                //outsamp[k++] = pcm_sample[l][i][j];
            }
        }
}
    8bb1:	90                   	nop
    8bb2:	c9                   	leave  
    8bb3:	c3                   	ret    

00008bb4 <buffer_CRC>:


void  buffer_CRC(Bit_stream_struc *bs, unsigned int *old_crc)
{
    8bb4:	55                   	push   %ebp
    8bb5:	89 e5                	mov    %esp,%ebp
    8bb7:	83 ec 08             	sub    $0x8,%esp
    *old_crc = getbits(bs, 16);
    8bba:	83 ec 08             	sub    $0x8,%esp
    8bbd:	6a 10                	push   $0x10
    8bbf:	ff 75 08             	pushl  0x8(%ebp)
    8bc2:	e8 69 a8 ff ff       	call   3430 <getbits>
    8bc7:	83 c4 10             	add    $0x10,%esp
    8bca:	89 c2                	mov    %eax,%edx
    8bcc:	8b 45 0c             	mov    0xc(%ebp),%eax
    8bcf:	89 10                	mov    %edx,(%eax)
}
    8bd1:	90                   	nop
    8bd2:	c9                   	leave  
    8bd3:	c3                   	ret    

00008bd4 <main_data_slots>:

extern int bitrate[3][15];
extern double s_freq[4];
/* Return the number of slots for main data of current frame, */
int main_data_slots(struct frame_params fr_ps)
{
    8bd4:	55                   	push   %ebp
    8bd5:	89 e5                	mov    %esp,%ebp
    8bd7:	83 ec 18             	sub    $0x18,%esp
	int nSlots;

	nSlots = (144 * bitrate[2][fr_ps.header->bitrate_index])
    8bda:	8b 45 08             	mov    0x8(%ebp),%eax
    8bdd:	8b 40 0c             	mov    0xc(%eax),%eax
    8be0:	83 c0 1e             	add    $0x1e,%eax
    8be3:	8b 14 85 e0 c6 00 00 	mov    0xc6e0(,%eax,4),%edx
    8bea:	89 d0                	mov    %edx,%eax
    8bec:	c1 e0 03             	shl    $0x3,%eax
    8bef:	01 d0                	add    %edx,%eax
    8bf1:	c1 e0 04             	shl    $0x4,%eax
    8bf4:	89 45 e8             	mov    %eax,-0x18(%ebp)
			/ s_freq[fr_ps.header->sampling_frequency];
    8bf7:	db 45 e8             	fildl  -0x18(%ebp)
    8bfa:	8b 45 08             	mov    0x8(%ebp),%eax
    8bfd:	8b 40 10             	mov    0x10(%eax),%eax
    8c00:	dd 04 c5 a0 c7 00 00 	fldl   0xc7a0(,%eax,8)
    8c07:	de f9                	fdivrp %st,%st(1)
/* Return the number of slots for main data of current frame, */
int main_data_slots(struct frame_params fr_ps)
{
	int nSlots;

	nSlots = (144 * bitrate[2][fr_ps.header->bitrate_index])
    8c09:	d9 7d ee             	fnstcw -0x12(%ebp)
    8c0c:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
    8c10:	b4 0c                	mov    $0xc,%ah
    8c12:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    8c16:	d9 6d ec             	fldcw  -0x14(%ebp)
    8c19:	db 5d fc             	fistpl -0x4(%ebp)
    8c1c:	d9 6d ee             	fldcw  -0x12(%ebp)
			/ s_freq[fr_ps.header->sampling_frequency];
	if (fr_ps.header->padding) nSlots++;
    8c1f:	8b 45 08             	mov    0x8(%ebp),%eax
    8c22:	8b 40 14             	mov    0x14(%eax),%eax
    8c25:	85 c0                	test   %eax,%eax
    8c27:	74 04                	je     8c2d <main_data_slots+0x59>
    8c29:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
	nSlots -= 4;
    8c2d:	83 6d fc 04          	subl   $0x4,-0x4(%ebp)
	if (fr_ps.header->error_protection)
    8c31:	8b 45 08             	mov    0x8(%ebp),%eax
    8c34:	8b 40 08             	mov    0x8(%eax),%eax
    8c37:	85 c0                	test   %eax,%eax
    8c39:	74 04                	je     8c3f <main_data_slots+0x6b>
		nSlots -= 2;
    8c3b:	83 6d fc 02          	subl   $0x2,-0x4(%ebp)
	if (fr_ps.stereo == 1)
    8c3f:	8b 45 10             	mov    0x10(%ebp),%eax
    8c42:	83 f8 01             	cmp    $0x1,%eax
    8c45:	75 06                	jne    8c4d <main_data_slots+0x79>
		nSlots -= 17;
    8c47:	83 6d fc 11          	subl   $0x11,-0x4(%ebp)
    8c4b:	eb 04                	jmp    8c51 <main_data_slots+0x7d>
	else
		nSlots -=32;
    8c4d:	83 6d fc 20          	subl   $0x20,-0x4(%ebp)
	return(nSlots);
    8c51:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    8c54:	c9                   	leave  
    8c55:	c3                   	ret    
