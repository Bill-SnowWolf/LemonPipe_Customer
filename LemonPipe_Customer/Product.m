//
//  Products.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "Product.h"

@implementation Product
{
    NSDate *endDate;
}
@synthesize image;
@synthesize MSRP;
@synthesize discount;
@synthesize discountPrice;
@synthesize promotionHours;
@synthesize promotionDays;
@synthesize numOfDayLeft;
@synthesize name;
@synthesize productID;
@synthesize countDownTimer;
@synthesize delegate;
@synthesize selected;
@synthesize timeLeft;

- (id) init
{
    self = [super init];
    if (self) {
        image = [[UIImage alloc] init];
        MSRP = 0;
        discount = 0;
        discountPrice = 0;
        promotionDays = 0;
        promotionHours = 0;
        name = [[NSString alloc] init];
        selected = false;
    }
    return self;
}

- (id) initWithImage:(UIImage *)aImage MSRP:(float)retailPrice discount:(NSInteger)disc promotionDays:(NSInteger)days promotionHours:(NSInteger) hours name:(NSString *)productName
{
    self = [super init];
    if (self) {
        image = aImage;
        MSRP = retailPrice;
        discount = disc;
        discountPrice = MSRP * discount;
        promotionHours = hours;
        promotionDays = days;
        selected = false;
        name = productName;
        
        NSDate *today = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSDateComponents *offset = [[NSDateComponents alloc] init];
        [offset setDay:promotionDays];
        [offset setHour:promotionHours];
        endDate = [calendar dateByAddingComponents:offset toDate:today options:0];
        
        timeLeft = [calendar components:NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:today toDate:endDate options:0];
        
    }
    return self;
}

- (void)startTimer
{
    [self.countDownTimer invalidate];
    NSDate *today = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *offset = [[NSDateComponents alloc] init];
    [offset setDay:promotionDays];
    [offset setHour:promotionHours];
    endDate = [calendar dateByAddingComponents:offset toDate:today options:0];
    
    timeLeft = [calendar components:NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:today toDate:endDate options:0];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(countingDown:) userInfo:nil repeats:YES];
    self.countDownTimer = timer;
}


- (void)stopTimer
{
    [self.countDownTimer invalidate];
}

- (void)countingDown:(id)sender
{
    NSDate *currentTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    timeLeft = [calendar components:NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:currentTime toDate:endDate options:0];
    
    [delegate setTime:timeLeft];
    
    if (timeLeft.day==0 && timeLeft.hour == 0 && timeLeft.minute ==0 && timeLeft.second == 0)
        [self stopTimer];
}

@end
