//
//  ZKDialogCell.m
//  zoneke
//
//  Created by  on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZKDialogCell.h"
#include "stdlib.h"
#import "Composing.h"

@implementation ZKDialogCell

@synthesize label = _label;
@synthesize dialog = _dialog;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setSelectionStyle: UITableViewCellSelectionStyleNone];
        
        _label = [[UILabel alloc] init];

    }
    return self;
}

-(void)dealloc{
    [_label release];
    [_dialog release];
    [super dealloc];
}

CGContextRef MyCreateBitmapContext (int pixelsWide,
                                    int pixelsHigh)
{
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    //声明一个变量来代表每行的字节数。每一个位图像素的代表是4个字节，8bit红，8bit绿，8bit蓝，和8bit alpha通道信息(透明信息)。
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();// 创建一个通用的RGB色彩空间
    bitmapData = malloc( bitmapByteCount );// 调用的malloc函数来创建的内存用来存储位图数据块
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        return NULL;
    }
    
    //创建一个位图图形上下文
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedLast);
    if (context== NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
        return NULL;
    }
    //释放colorSpace 注意使用的函数
    CGColorSpaceRelease( colorSpace );
    
    return context;
}

/*
 生成一个聊天的对话框背景图
 参数
 myContext:一个图形上下文
 ox: 矩形左下角x坐标
 oy: 矩形左下角y坐标
 rw: 矩形宽度
 rh: 矩形高度
 r : 矩形圆角半径
 Orientation: 箭头方向，0-7 
 */
UIImage* createDialogBox (CGContextRef myContext, float ox, float oy, float rw, float rh, float r,  int Orientation)
{
    CGMutablePathRef path = CGPathCreateMutable();
    //画矩形
    CGPathMoveToPoint(path, NULL,ox, oy+r);
    CGPathAddArcToPoint(path, NULL, ox, oy+rh, ox+r,oy+rh, r);
    CGPathAddArcToPoint(path, NULL, ox+rw, oy+rh, ox+rw, oy+rh-r, r);
    CGPathAddArcToPoint(path, NULL, ox+rw, oy, ox+rw-r, oy, r);
    CGPathAddArcToPoint(path, NULL, ox, oy, ox,oy+r,r);
    
    //画箭头
    switch (Orientation) {
        case 0:
            CGPathMoveToPoint(path, NULL,ox+r+10.0, oy+rh);
            CGPathAddLineToPoint(path, NULL, ox+r+10.0, oy+rh+20);
            CGPathAddLineToPoint(path, NULL, ox+r+30.0, oy+rh);
            break;
        case 1:
            CGPathMoveToPoint(path, NULL,ox+rw-r-10.0, oy+rh);
            CGPathAddLineToPoint(path, NULL, ox+rw-r-10.0, oy+rh+20);
            CGPathAddLineToPoint(path, NULL, ox+rw-r-30.0, oy+rh);
            break;
        case 2:
            CGPathMoveToPoint(path, NULL,ox+rw, oy+rh-r-10);
            CGPathAddLineToPoint(path, NULL, ox+rw+20, oy+rh-r-10);
            CGPathAddLineToPoint(path, NULL, ox+rw, oy+rh-r-30);
            break;
        case 3:
            CGPathMoveToPoint(path, NULL,ox+rw, oy+r+10);
            CGPathAddLineToPoint(path, NULL, ox+rw+20, oy+r+10);
            CGPathAddLineToPoint(path, NULL, ox+rw, oy+r+30);
            break;
        case 4:
            CGPathMoveToPoint(path, NULL,ox+rw-r-10.0, oy);
            CGPathAddLineToPoint(path, NULL, ox+rw-r-10.0, oy-20);
            CGPathAddLineToPoint(path, NULL, ox+rw-r-30.0, oy);
            break;
        case 5:
            CGPathMoveToPoint(path, NULL,ox+r+10.0, oy);
            CGPathAddLineToPoint(path, NULL, ox+r+10.0, oy-20);
            CGPathAddLineToPoint(path, NULL, ox+r+30.0, oy);
            break;
        case 6:
            CGPathMoveToPoint(path, NULL,ox, oy+r+10);
            CGPathAddLineToPoint(path, NULL, ox-20, oy+r+10);
            CGPathAddLineToPoint(path, NULL, ox, oy+r+30);
            break;
        case 7:
            CGPathMoveToPoint(path, NULL,ox, oy+rh-r-10);
            CGPathAddLineToPoint(path, NULL, ox-20, oy+rh-r-10);
            CGPathAddLineToPoint(path, NULL, ox, oy+rh-r-30);
            break;
        default:
            break;
    }
    
    
    //描边 以及添加阴影效果
    CGContextSetLineJoin(myContext, kCGLineJoinRound);
    CGFloat zStrokeColour[4]    = {254.0/255, 254.0/255.0, 254.0/255.0, 1.0};
    CGContextSetLineWidth(myContext, 8.0);
    CGContextAddPath(myContext,path);
    CGContextSetStrokeColorSpace(myContext, CGColorSpaceCreateDeviceRGB());
    CGContextSetStrokeColor(myContext, zStrokeColour);
    CGContextStrokePath(myContext);
    
    CGSize myShadowOffset = CGSizeMake (0,  0);
    CGContextSaveGState(myContext);
    
    CGContextSetShadow (myContext, myShadowOffset, 5);
    CGContextSetLineJoin(myContext, kCGLineJoinRound);
    CGFloat zStrokeColour1[4]    = {228.0/255, 168.0/255.0, 81.0/255.0, 1.0};
    CGContextSetLineWidth(myContext, 3.0);
    CGContextAddPath(myContext,path);
    CGContextSetStrokeColorSpace(myContext, CGColorSpaceCreateDeviceRGB());
    CGContextSetStrokeColor(myContext, zStrokeColour1);
    CGContextStrokePath(myContext);
    
    CGContextRestoreGState(myContext);
    
    //填充矩形内部颜色
    CGContextAddPath(myContext,path);
    CGContextSetFillColorSpace(myContext, CGColorSpaceCreateDeviceRGB());
    CGFloat zFillColour1[4]    = {150.0/255, 168.0/255.0, 231.0/255.0, 1.0};
    CGContextSetFillColor(myContext, zFillColour1);
    CGContextEOFillPath(myContext);
    
    //生成图像
    CGImageRef myImage = CGBitmapContextCreateImage (myContext);
    UIImage * image = [UIImage imageWithCGImage:myImage];
    CGImageRelease(myImage);
    return image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*
 *   origin 2, 3 is right
 *   origin 6, 7 is left 
 */

- (void) loadData:(int) origin content: (NSString *) content{
    if (_dialog){
        [_dialog removeFromSuperview];
        [_dialog release];
    }
    
    CGContextRef myContextRef = MyCreateBitmapContext(320, 100); 
    
    Composing *composing = [[Composing alloc] initWithString:content];
    
    int lines = composing.lines;
    float height = composing.height;
    float width = composing.width;
    
    float dialog_height = height + 10;
    float dialog_width = width + 10;
    
    float dialog_x = 20;
    
    if (origin == 2){
        dialog_x = 320 - dialog_x - dialog_width;
    }
    
    float dialog_y = 10;
    
   // _label = [[UILabel alloc] initWithFrame: CGRectMake(5, 5, dialog_width, dialog_height)];
    _label.frame = CGRectMake(dialog_x + 5, 5, width, height);
    _label.text = content;
    _label.textAlignment = UITextAlignmentCenter;
    _label.numberOfLines = lines;
    _label.backgroundColor = [UIColor clearColor];
    
    _dialog = [[UIImageView alloc] initWithImage:createDialogBox(myContextRef, dialog_x, dialog_y, dialog_width, dialog_height, 2, origin)];
    [_dialog addSubview: _label];

    
    [self.contentView addSubview: _dialog];
    [Composing release];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}


@end
