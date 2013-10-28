//
//  ExpandedPromoView.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-28.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "ExpandedPromoView.h"
#import "ExpandedImageView.h"
#import "Product.h"
#import <QuartzCore/CAShapeLayer.h>

@implementation ExpandedPromoView
{
    Product *product;
}
- (id)initWithOrigin:(CGPoint)origin product:(Product *)newProduct
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, 306, 201.5)];
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
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ExpandedPromoBG" ofType:@"png"];
    UIImageView *expandedPromoBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 306, 201.5)];
    [expandedPromoBackground setImage:[UIImage imageWithContentsOfFile:filePath]];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.frame = expandedPromoBackground.bounds;
    lineLayer.strokeColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.5].CGColor;
    lineLayer.lineWidth = 1.5f;
    lineLayer.lineCap = kCALineCapRound;
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 222, 53);
    CGPathAddLineToPoint(pathRef, NULL, 296, 53);
    CGPathMoveToPoint(pathRef, NULL, 222, 118);
    CGPathAddLineToPoint(pathRef, NULL, 296, 118);
    [lineLayer setPath:pathRef];
    CGPathRelease(pathRef);
    [expandedPromoBackground.layer addSublayer:lineLayer];
    
    [self addSubview:expandedPromoBackground];
    
    ExpandedImageView *expandedImageView = [[ExpandedImageView alloc] initWithFrame:CGRectMake(15, 0.5, 200, 200) product:product];
    
    [self addSubview:expandedImageView];
    
    
    UILabel *expandedDiscountLabel = [[UILabel alloc] initWithFrame:CGRectMake(215, 3, 55, 55)];
    [expandedDiscountLabel setText:[NSString stringWithFormat:@"%d", product.discount]];
    [expandedDiscountLabel setTextColor:[UIColor whiteColor]];
    [expandedDiscountLabel setTextAlignment:NSTextAlignmentCenter];
    [expandedDiscountLabel setFont:[UIFont fontWithName:@"PlantagenetCherokee" size:45]];
    [expandedDiscountLabel setBackgroundColor:[UIColor clearColor]];
    
    CGAffineTransform transform = CGAffineTransformRotate(expandedDiscountLabel.transform, -0.06);
    [expandedDiscountLabel setTransform:transform];
    
    [self addSubview:expandedDiscountLabel];

    filePath = [[NSBundle mainBundle] pathForResource:@"PercentOff" ofType:@"png"];
    UIImage *percentOffImage = [UIImage imageWithContentsOfFile:filePath];
    
    UIImageView *expandedPercentOffView = [[UIImageView alloc] initWithFrame:CGRectMake(265, 6, 35.5, 36)];
    [expandedPercentOffView setImage:percentOffImage];
    [self addSubview:expandedPercentOffView];
    
    
    UILabel *msrpLabel = [[UILabel alloc] initWithFrame:CGRectMake(223, 60, 75, 21)];
    [msrpLabel setText:[NSString stringWithFormat:@"$%.2f", product.MSRP]];
    [msrpLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:20]];
    [msrpLabel setTextColor:[UIColor whiteColor]];
    [msrpLabel setBackgroundColor:[UIColor clearColor]];
    [msrpLabel setTextAlignment:NSTextAlignmentCenter];
    
    lineLayer = [CAShapeLayer layer];
    lineLayer.frame = msrpLabel.bounds;
    lineLayer.strokeColor = [UIColor redColor].CGColor;
    lineLayer.lineWidth = 2.0f;
    lineLayer.lineCap = kCALineCapRound;
    
    pathRef = CGPathCreateMutable();
    float xOffset = 5;
    
    if (product.MSRP<10)
        xOffset = 15;
    else if (product.MSRP<100)
        xOffset = 10;
    else if (product.MSRP<1000)
        xOffset = 5;
    CGPathMoveToPoint(pathRef, NULL, xOffset, CGRectGetMidY(lineLayer.bounds)+2);
    CGPathAddLineToPoint(pathRef, NULL, lineLayer.bounds.size.width-xOffset, CGRectGetMidY(lineLayer.bounds)-4);
    [lineLayer setPath:pathRef];
    CGPathRelease(pathRef);
    [msrpLabel.layer addSublayer:lineLayer];
    
    transform = CGAffineTransformRotate(msrpLabel.transform, -0.06);
    [msrpLabel setTransform:transform];
    
    [self addSubview:msrpLabel];
    
    
    UILabel *discountPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(216, 85, 90, 21)];
    [discountPriceLabel setText:[NSString stringWithFormat:@"$%.2f", product.MSRP*(1-product.discount/100.0)]];
    [discountPriceLabel setTextAlignment:NSTextAlignmentCenter];
    [discountPriceLabel setTextColor:[UIColor whiteColor]];
    [discountPriceLabel setFont:[UIFont fontWithName:@"Ubuntu-Bold" size:24]];
    [discountPriceLabel setBackgroundColor:[UIColor clearColor]];
    
    transform = CGAffineTransformRotate(discountPriceLabel.transform, -0.06);
    [discountPriceLabel setTransform:transform];
    
    
    filePath = [[NSBundle mainBundle] pathForResource:@"BuyButton" ofType:@"png"];
    UIImage *buyButtonImage = [UIImage imageWithContentsOfFile:filePath];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton setFrame:CGRectMake(225, 125, 70, 70)];
    [buyButton setImage:buyButtonImage forState:UIControlStateNormal];
    [buyButton setUserInteractionEnabled:NO];
    [self addSubview:buyButton];
    
    
    [self addSubview:discountPriceLabel];
    
}

@end
