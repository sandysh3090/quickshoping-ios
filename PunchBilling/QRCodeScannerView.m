//
//  QRCodeScannerView.m
//  Punchh Framework
//
//  Created by Sharad Shankar on 30/09/12.
//  Copyright (c) 2013 Punchh. All rights reserved.
//

#import "QRCodeScannerView.h"
#import <QuartzCore/QuartzCore.h>

@implementation QRCodeScannerView
{
    UIImageView *qrCodeImageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        CALayer *bgLayer = [CALayer layer];
        bgLayer.frame = CGRectMake(0.0, 0.0, frame.size.width, 61.0);
        [self.layer addSublayer:bgLayer];
        CATextLayer *_textLayer = [CATextLayer layer];
        _textLayer.frame = CGRectMake(0.0, 13.0, frame.size.width, 44.0);;
        _textLayer.fontSize = 16.0;
        _textLayer.wrapped = TRUE;
        _textLayer.backgroundColor = [UIColor clearColor].CGColor;
        _textLayer.alignmentMode = kCAAlignmentCenter;
        _textLayer.string =@"hi";
        [bgLayer addSublayer:_textLayer];
        bgLayer.backgroundColor = [UIColor blackColor].CGColor;
        //Add image view at the top
        qrCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,5,30,30)];
        qrCodeImageView.image = [UIImage imageNamed:@"qrCode"];
        [self addSubview:qrCodeImageView];

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect _drawRect = CGRectMake(20.0, 0, 280, 200.0);
    CGFloat _width = 60.0;
    UIColor *defaultColor = [UIColor blackColor];
    //    UIColor *linStrokeColor = [UIColor colorWithRed:195.0/255.0 green:195.0/255.0 blue:195.0/255.0 alpha:1.0];
    UIColor *linStrokeColor = defaultColor;
    
    CGContextSetStrokeColorWithColor(context, linStrokeColor.CGColor);
    CGContextSetLineWidth(context, 5.0);
    CGContextBeginPath (context);
    
    CGContextMoveToPoint(context,_drawRect.origin.x,_drawRect.origin.y);
    CGContextAddLineToPoint(context,_drawRect.origin.x+_width,_drawRect.origin.y);
    
    CGContextMoveToPoint(context,_drawRect.origin.x,_drawRect.origin.y);
    CGContextAddLineToPoint(context,_drawRect.origin.x,_drawRect.origin.y+_width);
    
    CGContextMoveToPoint(context,_drawRect.origin.x+_drawRect.size.width,_drawRect.origin.y);
    CGContextAddLineToPoint(context,_drawRect.origin.x+_drawRect.size.width-_width,_drawRect.origin.y);
    
    CGContextMoveToPoint(context,_drawRect.origin.x+_drawRect.size.width,_drawRect.origin.y);
    CGContextAddLineToPoint(context,_drawRect.origin.x+_drawRect.size.width,_drawRect.origin.y+_width);
    
    CGContextMoveToPoint(context,_drawRect.origin.x,_drawRect.origin.y+_drawRect.size.height);
    CGContextAddLineToPoint(context,_drawRect.origin.x+_width,_drawRect.origin.y+_drawRect.size.height);
    
    CGContextMoveToPoint(context,_drawRect.origin.x,_drawRect.origin.y+_drawRect.size.height);
    CGContextAddLineToPoint(context,_drawRect.origin.x,_drawRect.origin.y+_drawRect.size.height-_width);
    
    CGContextMoveToPoint(context,_drawRect.origin.x+_drawRect.size.width,_drawRect.origin.y+_drawRect.size.height);
    CGContextAddLineToPoint(context,_drawRect.origin.x+_drawRect.size.width-_width,_drawRect.origin.y+_drawRect.size.height);
    
    CGContextMoveToPoint(context,_drawRect.origin.x+_drawRect.size.width,_drawRect.origin.y+_drawRect.size.height);
    CGContextAddLineToPoint(context,_drawRect.origin.x+_drawRect.size.width,_drawRect.origin.y-_width+_drawRect.size.height);
    CGContextStrokePath(context);
}


@end
