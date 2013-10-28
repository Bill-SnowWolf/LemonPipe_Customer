//
//  ProductsTableViewCell.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "ProductsTableViewCell.h"
#import "RegPromoView.h"
#import "ExpandedPromoView.h"
@implementation ProductsTableViewCell
{
    RegPromoView *regPromoView;
    ExpandedPromoView *expandedPromoView;
    Product *product;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)createCellWithProduct:(Product *)aProduct
{
    product = aProduct;
    regPromoView = [[RegPromoView alloc] initWithOrigin:CGPointMake(7, 6) product:product];
    [regPromoView setTag:999];
    expandedPromoView = [[ExpandedPromoView alloc] initWithOrigin:CGPointMake(7, 6) product:product];
    [expandedPromoView setTag:999];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setCellSelected
{
    [self removeSubViews];
    [self addSubview:expandedPromoView];
}

- (void)setCellUnselected
{
    [self removeSubViews];
    [self addSubview:regPromoView];
}

- (void)removeSubViews
{
    for (UIView *subview in self.subviews) {
        if (subview.tag == 999)
            [subview removeFromSuperview];
    }
}
@end
