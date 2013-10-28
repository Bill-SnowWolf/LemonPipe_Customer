//
//  RegPromoView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-28.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "RegPromoView.h"
#import "Product.h"

@implementation RegPromoView
{
    Product *product;
}
- (id)initWithOrigin:(CGPoint)origin product:(Product *)newProduct
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, 306, 101.5)];
    if (self) {
        product = newProduct;
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
    [self setBackgroundColor:[UIColor clearColor]];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"RegPromoBG" ofType:@"png"];
    UIImageView *regPromoBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 306, 101.5)];
    [regPromoBackground setImage:[UIImage imageWithContentsOfFile:filePath]];
    [self addSubview:regPromoBackground];
    
    UIImageView *regImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0.5, 100, 100)];
    [regImageView setImage:product.image];
    [self addSubview:regImageView];
    
    UILabel *regDiscountLabel = [[UILabel alloc] initWithFrame:CGRectMake(124, 3, 130, 80)];
    [regDiscountLabel setText:[NSString stringWithFormat:@"%d", product.discount]];
    [regDiscountLabel setBackgroundColor:[UIColor clearColor]];
    [regDiscountLabel setTextColor:[UIColor whiteColor]];
    [regDiscountLabel setFont:[UIFont fontWithName:@"PlantagenetCherokee" size:95]];
    
    CGAffineTransform transform;
    transform = CGAffineTransformRotate(regDiscountLabel.transform, -0.06);
    [regDiscountLabel setTransform:transform];
    
    [self addSubview:regDiscountLabel];
    
    
    filePath = [[NSBundle mainBundle] pathForResource:@"PercentOff" ofType:@"png"];
    UIImage *percentOffImage = [UIImage imageWithContentsOfFile:filePath];
    
    UIImageView *regPercentOffView = [[UIImageView alloc] initWithImage:percentOffImage];
    [regPercentOffView setFrame:CGRectMake(225, 0, 66, 68)];
    [self addSubview:regPercentOffView];
    
    
    UILabel *regNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(124, 76, 175, 21)];
    [regNameLabel setTextColor:[UIColor whiteColor]];
    [regNameLabel setText:product.name];
    [regNameLabel setTextAlignment:NSTextAlignmentCenter];
    [regNameLabel setBackgroundColor:[UIColor clearColor]];
    [regNameLabel setFont:[UIFont fontWithName:@"Ubuntu-Bold" size:17]];
    [self addSubview:regNameLabel];
    
}

@end
