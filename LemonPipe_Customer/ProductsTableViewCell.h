//
//  ProductsTableViewCell.h
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@interface ProductsTableViewCell : UITableViewCell

- (void)setCellUnselected;
- (void)setCellSelected;

- (void)createCellWithProduct:(Product *)aProduct;
@end
