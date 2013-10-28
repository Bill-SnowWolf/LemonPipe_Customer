//
//  Products.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//
//  This class is a Data structure of product
#import <Foundation/Foundation.h>

@protocol CountDownTimerDelegate <NSObject>

- (void)setTime:(NSDateComponents *)components;

@end

@interface Product : NSObject
@property (nonatomic, retain) UIImage *image;
@property (nonatomic) float MSRP;
@property (nonatomic) NSInteger discount;
@property (nonatomic) float discountPrice;
@property (nonatomic) NSInteger promotionDays;
@property (nonatomic) NSInteger promotionHours;
@property (nonatomic) NSInteger numOfDayLeft;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSInteger productID;

@property (nonatomic) BOOL selected;    // Indicate if this item is selected. For product lists only. Defaut = false;

@property (nonatomic, weak) NSTimer *countDownTimer;
@property (nonatomic, retain) NSDateComponents *timeLeft;

@property (nonatomic, weak) id<CountDownTimerDelegate> delegate;

- (id) init;
- (id) initWithImage:(UIImage *)aImage MSRP:(float)retailPrice discount:(NSInteger)disc promotionDays:(NSInteger)days promotionHours:(NSInteger) hours name:(NSString *)productName;

- (void)startTimer;
- (void)stopTimer;

@end
