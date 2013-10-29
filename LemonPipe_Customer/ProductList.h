//
//  ProductList.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Product;

@protocol RefreshDataDelegate <NSObject>

- (void) refreshData;
- (void) addNewPromotion;

@end

@interface ProductList : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>
@property (nonatomic, retain) NSMutableArray *list;
@property (nonatomic, retain) id<RefreshDataDelegate> delegate;

- (void)pull: (NSUInteger) productID;
- (void)remove: (Product *)aProduct;
- (void)refreshList;

+(id)sharedInstance;
@end
