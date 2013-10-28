//
//  ExpandedImageView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-25.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "ExpandedImageView.h"
#import <QuartzCore/CAShapeLayer.h>

@implementation ExpandedImageView
{
    UILabel *daysLabel;
    UILabel *hoursLabel1;
    UILabel *hoursLabel2;
    UILabel *minutesLabel1;
    UILabel *minutesLabel2;
    UILabel *secondsLabel1;
    UILabel *secondsLabel2;
}
@synthesize product;

- (id)initWithFrame:(CGRect)frame product:(Product *)newProduct
{
    self = [super initWithFrame:frame];
    if (self) {
        self.product = newProduct;
        self.product.delegate = self;
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
    
    [self setDays:product.timeLeft.day];
    [timerView addSubview:daysLabel];
    
    [self setHours:product.timeLeft.hour];
    [timerView addSubview:hoursLabel1];
    [timerView addSubview:hoursLabel2];
    
    [self setMinutes:0];
    [timerView addSubview:minutesLabel1];
    [timerView addSubview:minutesLabel2];
    
    [self setSeconds:0];
    [timerView addSubview:secondsLabel1];
    [timerView addSubview:secondsLabel2];
    
    [self addSubview:timerView];
    
    
}

- (void)setDays:(NSInteger)days
{
    if (!daysLabel)
        daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 0, 23, 21)];
    [daysLabel setBackgroundColor:[UIColor clearColor]];
    [daysLabel setTextAlignment:NSTextAlignmentCenter];
    [daysLabel setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    
    NSMutableString *daysStr = [[NSMutableString alloc] initWithCapacity:5];
    if (days<10)
        [daysStr appendString:@"0"];
    [daysStr appendFormat:@"%dd", days];
    [daysLabel setText:daysStr];
    
}

- (void)setHours:(NSInteger)hours
{
    if (!hoursLabel1)
        hoursLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(109.5, 0, 12, 21)];
    [hoursLabel1 setBackgroundColor:[UIColor clearColor]];
    [hoursLabel1 setTextAlignment:NSTextAlignmentCenter];
    [hoursLabel1 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    
    if (!hoursLabel2)
        hoursLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(122.5, 0, 12, 21)];
    [hoursLabel2 setBackgroundColor:[UIColor clearColor]];
    [hoursLabel2 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    [hoursLabel2 setTextAlignment:NSTextAlignmentCenter];
    
    if (hours<10)
        [hoursLabel1 setText:@"0"];
    else
        [hoursLabel1 setText:[NSString stringWithFormat:@"%d", (hours/10)]];
    
    [hoursLabel2 setText:[NSString stringWithFormat:@"%d", hours%10]];
    
}

- (void)setMinutes:(NSInteger)minutes
{
    if (!minutesLabel1) minutesLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(139.5, 0, 12, 21)];
    [minutesLabel1 setBackgroundColor:[UIColor clearColor]];
    [minutesLabel1 setTextAlignment:NSTextAlignmentCenter];
    [minutesLabel1 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    
    if (!minutesLabel2)
        minutesLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(153.5, 0, 12, 21)];
    [minutesLabel2 setTextAlignment:NSTextAlignmentCenter];
    [minutesLabel2 setBackgroundColor:[UIColor clearColor]];
    [minutesLabel2 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    
    if (minutes<10)
        [minutesLabel1 setText:@"0"];
    else
        [minutesLabel1 setText:[NSString stringWithFormat:@"%d", minutes/10]];
    
    [minutesLabel2 setText:[NSString stringWithFormat:@"%d", minutes%10]];
}

- (void)setSeconds:(NSInteger)seconds
{
    if (!secondsLabel1)
        secondsLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(170.5, 0, 12, 21)];
    [secondsLabel1 setTextAlignment:NSTextAlignmentCenter];
    [secondsLabel1 setBackgroundColor:[UIColor clearColor]];
    [secondsLabel1 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    
    if (!secondsLabel2)
        secondsLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(184.5, 0, 12, 21)];
    [secondsLabel2 setTextAlignment:NSTextAlignmentCenter];
    [secondsLabel2 setBackgroundColor:[UIColor clearColor]];
    [secondsLabel2 setFont:[UIFont fontWithName:@"BerlinSansFB-Reg" size:11]];
    
    if (seconds<10)
        [secondsLabel1 setText:@"0"];
    else
        [secondsLabel1 setText:[NSString stringWithFormat:@"%d", seconds/10]];
    
    [secondsLabel2 setText:[NSString stringWithFormat:@"%d", seconds%10]];
    
}

- (void)setTime:(NSDateComponents *)components
{
    [self setDays:components.day];
    [self setHours:components.hour];
    [self setMinutes:components.minute];
    [self setSeconds:components.second];
}
@end
