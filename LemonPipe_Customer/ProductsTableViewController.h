//
//  ProductsViewController.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ProductList.h"

@interface ProductsTableViewController : UITableViewController <RefreshDataDelegate, RefreshPromotionsDelegate>

@property (nonatomic, retain) IBOutlet UIView *instructionView;

@end
