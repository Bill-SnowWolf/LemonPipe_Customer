//
//  AppDelegate.h
//  LemonPipe_Customer
//
//  Created by Bill on 13-10-23.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;
@protocol RefreshPromotionsDelegate <NSObject>

- (void)getNewProduc: (NSUInteger)productID;
- (void)getAllPromotions;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) id<RefreshPromotionsDelegate> delegate;

@end
