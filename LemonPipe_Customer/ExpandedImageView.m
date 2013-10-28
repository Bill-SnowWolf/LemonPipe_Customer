//
//  ExpandedImageView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-25.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "ExpandedImageView.h"
#import <QuartzCore/CAShapeLayer.h>
#import "Product.h"

@implementation ExpandedImageView
@synthesize product;

- (id)initWithFrame:(CGRect)frame product:(Product *)newProduct
{
    self = [super initWithFrame:frame];
    if (self) {
        self.product = newProduct;
        [self initialize];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initialize
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [imageView setImage:[product image]];
    
    CAShapeLayer *textLayer = [CAShapeLayer layer];
    textLayer.frame = CGRectMake(0, 0, 200, 25);
    textLayer.fillColor = [UIColor colorWithWhite:0.2 alpha:0.6].CGColor;
    textLayer.strokeColor = [UIColor clearColor].CGColor;
    CGMutablePathRef textPathRef = CGPathCreateMutable();
    CGPathAddRect(textPathRef, NULL, textLayer.frame);
    [textLayer setPath:textPathRef];
    CGPathRelease(textPathRef);
    [imageView.layer addSublayer:textLayer];
    
    [self addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 25)];
    [nameLabel setText:product.name];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setFont:[UIFont fontWithName:@"Ubuntu-Bold" size:18]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    
    [self addSubview:nameLabel];
    
    UIView *timerView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, 200, 20)];
    [timerView setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.6]];
    
    UILabel *timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75, 18)];
    [timerLabel setText:@"Expires in:"];
    [timerLabel setTextColor:[UIColor whiteColor]];
    [timerLabel setTextAlignment:NSTextAlignmentCenter];
    [timerLabel setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:15]];
    [timerLabel setBackgroundColor:[UIColor clearColor]];
    [timerView addSubview:timerLabel];
    
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"TimerBackground" ofType:@"png"];
    UIImageView *timerBackground = [[UIImageView alloc] initWithFrame:CGRectMake(73, -2, 127, 24)];
    [timerBackground setImage:[UIImage imageWithContentsOfFile:fileName]];
    [timerView addSubview:timerBackground];
    
    UILabel *daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 0, 23, 21)];
    [daysLabel setBackgroundColor:[UIColor clearColor]];
    [daysLabel setTextAlignment:NSTextAlignmentCenter];
    [daysLabel setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    
    NSMutableString *daysStr = [[NSMutableString alloc] initWithCapacity:5];
    if (product.promotionDays<10)
        [daysStr appendString:@"0"];
    [daysStr appendFormat:@"%dd", product.promotionDays];
    [daysLabel setText:daysStr];
    [timerView addSubview:daysLabel];
    
    UILabel *hoursLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(109.5, 0, 12, 21)];
    [hoursLabel1 setBackgroundColor:[UIColor clearColor]];
    [hoursLabel1 setTextAlignment:NSTextAlignmentCenter];
    [hoursLabel1 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [timerView addSubview:hoursLabel1];
    
    UILabel *hoursLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(122.5, 0, 12, 21)];
    [hoursLabel2 setBackgroundColor:[UIColor clearColor]];
    [hoursLabel2 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [hoursLabel2 setTextAlignment:NSTextAlignmentCenter];
    [timerView addSubview:hoursLabel2];
    
    if (product.promotionHours<10)
        [hoursLabel1 setText:@"0"];
    else
        [hoursLabel1 setText:[NSString stringWithFormat:@"%d", (product.promotionHours/10)]];
    
    [hoursLabel2 setText:[NSString stringWithFormat:@"%d", product.promotionHours/10]];
    
    UILabel *minutesLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(139.5, 0, 12, 21)];
    [minutesLabel1 setBackgroundColor:[UIColor clearColor]];
    [minutesLabel1 setTextAlignment:NSTextAlignmentCenter];
    [minutesLabel1 setText:@"0"];
    [minutesLabel1 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [timerView addSubview:minutesLabel1];
    
    UILabel *minutesLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(153.5, 0, 12, 21)];
    [minutesLabel2 setTextAlignment:NSTextAlignmentCenter];
    [minutesLabel2 setBackgroundColor:[UIColor clearColor]];
    [minutesLabel2 setText:@"0"];
    [minutesLabel2 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [timerView addSubview:minutesLabel2];
    
    UILabel *secondsLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(170.5, 0, 12, 21)];
    [secondsLabel1 setTextAlignment:NSTextAlignmentCenter];
    [secondsLabel1 setBackgroundColor:[UIColor clearColor]];
    [secondsLabel1 setText:@"0"];
    [secondsLabel1 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [timerView addSubview:secondsLabel1];
    
    UILabel *secondsLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(184.5, 0, 12, 21)];
    [secondsLabel2 setTextAlignment:NSTextAlignmentCenter];
    [secondsLabel2 setBackgroundColor:[UIColor clearColor]];
    [secondsLabel2 setText:@"0"];
    [secondsLabel2 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [timerView addSubview:secondsLabel2];
    
    [self addSubview:timerView];
    
    
}
@end
