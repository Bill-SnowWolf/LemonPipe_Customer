//
//  ExpandedImageView.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-25.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Product;

@interface ExpandedImageView : UIView
@property (nonatomic, retain) Product *product;

- (void)setDays:(NSInteger)days;
- (void)setHours:(NSInteger)hours;
- (void)setMinutes:(NSInteger)minutes;
- (void)setSeconds:(NSInteger)seconds;

- (id)initWithFrame:(CGRect)frame product:(Product *)product;
@end
