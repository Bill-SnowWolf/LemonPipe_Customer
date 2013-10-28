//
//  ExpandedPromoView.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-28.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@interface ExpandedPromoView : UIView
- (id)initWithOrigin:(CGPoint)origin product:(Product *)newProduct;
@end
