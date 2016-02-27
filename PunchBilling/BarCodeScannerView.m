  //
//  BarCodeScannerView.m
//  Punchh Framework
//
//  Created by Sharad Shankar on 30/09/12.
//  Copyright (c) 2013 Punchh. All rights reserved.
//

#import "BarCodeScannerView.h"
#import <QuartzCore/QuartzCore.h>


@interface BarCodeScannerView ()
@property (copy, nonatomic) void(^scannerActionBlock)(NSInteger buttonTag);
@end

@implementation BarCodeScannerView {
    UIView *scannerView;
    UIImageView *barCodeImageView;
	UIColor *linStrokeColor;
}

- (instancetype) initWithFrame:(CGRect)frame
             withScannerAction:(void(^)(NSInteger scannerButtonIndex))block {
    if (self = [super initWithFrame:frame]) {
        self.scannerActionBlock = block;
        linStrokeColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
        CALayer *bgLayer = [CALayer layer];
        bgLayer.frame = CGRectMake(0.0, 0.0, frame.size.width, 44.0);
        //[self.layer addSublayer:bgLayer];

        UIImageView *_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanner_top_bar"]];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setFrame:CGRectMake(0, 0, 320, 61)];
        //[self addSubview:_imageView];

        UILabel *_textLayer = [[UILabel alloc]init];
        _textLayer.frame = CGRectMake(0.0, 0.0, frame.size.width, 44);
        _textLayer.numberOfLines = 0;
        _textLayer.font = [UIFont systemFontOfSize:14];
        _textLayer.lineBreakMode = NSLineBreakByWordWrapping;
        _textLayer.textColor = [UIColor redColor];
        _textLayer.backgroundColor = [UIColor clearColor];
        _textLayer.textAlignment = NSTextAlignmentCenter;
        _textLayer.text = @"test by sandeep";
        bgLayer.backgroundColor = [UIColor blackColor].CGColor;

        scannerView = [[UIView alloc] initWithFrame:CGRectMake(0.0,0.0, 320.0, 4.0)];
        scannerView.backgroundColor = [UIColor redColor];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = scannerView.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor], (id)[[UIColor colorWithRed:0.5 green:0.0 blue:0.0 alpha:0.5]CGColor], nil];
        [scannerView.layer insertSublayer:gradient atIndex:0];

        CGRect buttonFrame = CGRectMake(20,self.frame.size.height - (61+47 ), 280 , 50);
        
        UIButton *unableToScanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        unableToScanButton.layer.cornerRadius = 8.0f;
        [unableToScanButton setFrame:buttonFrame];
        [unableToScanButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        unableToScanButton.backgroundColor = [UIColor greenColor];
        [unableToScanButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [unableToScanButton setTitle:@"test" forState:UIControlStateNormal];
        unableToScanButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [unableToScanButton addTarget:self action:@selector(unableToScanTapped:) forControlEvents:UIControlEventTouchUpInside];

       // [self addSubview:_textLayer];
        [self addSubview:scannerView];
       // [self addSubview:unableToScanButton];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(translateDown)
                                                     name:@"applicationbecomeActive"
                                                   object:nil];
    }
    return self;
}

- (void)unableToScanTapped:(UIButton *)sender {
    if (self.scannerActionBlock) {
        self.scannerActionBlock(sender.tag);
    }
}

-(void)translateDown {
    [UIView animateWithDuration:5.0 animations:^{
        scannerView.transform = CGAffineTransformMakeTranslation(0.0,148.0);

    } completion:^(BOOL finished) {
        if (finished)
            [self translateUp];
    }];
}

-(void)translateUp{
    [UIView animateWithDuration:5.0 animations:^{
        scannerView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        if (finished)
            [self translateDown];
    }];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect _drawRect = CGRectMake(20.0, 0, 280, 150.0);
    CGFloat _width = 40.0;
    //    UIColor *linStrokeColor = [UIColor colorWithRed:195.0/255.0 green:195.0/255.0 blue:195.0/255.0 alpha:1.0];
    CGContextSetStrokeColorWithColor(context, linStrokeColor.CGColor);
    CGContextSetLineWidth(context, 3.0);
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
	UIGraphicsEndImageContext();
}

@end
