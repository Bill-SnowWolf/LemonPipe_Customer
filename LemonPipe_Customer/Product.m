//
//  Products.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "Product.h"

@implementation Product
@synthesize image;
@synthesize MSRP;
@synthesize discount;
@synthesize discountPrice;
@synthesize promotionHours;
@synthesize promotionDays;
@synthesize numOfDayLeft;
@synthesize name;
@synthesize productID;

@synthesize selected;
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
    }
    return self;
}


@end
