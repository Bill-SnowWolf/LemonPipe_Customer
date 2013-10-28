//
//  ProductsViewController.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "ProductsTableViewController.h"
#import "ProductsTableViewCell.h"
#import "Product.h"
#import <QuartzCore/CAShapeLayer.h>

@interface ProductsTableViewController ()
{
    ProductList *productList;
}
@end

@implementation ProductsTableViewController
@synthesize instructionView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize Instruction View
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = instructionView.frame;
    shapeLayer.strokeColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    shapeLayer.lineWidth = 2.0;
    shapeLayer.lineCap = kCALineCapRound;
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 10, 50);
    CGPathAddLineToPoint(pathRef, NULL, 300, 50);
    [shapeLayer setPath:pathRef];
    CGPathRelease(pathRef);
    [instructionView.layer addSublayer:shapeLayer];
    
    [instructionView setBackgroundColor:[UIColor colorWithRed:0.129 green:0.282 blue:0.384 alpha:1.0]];
    
    UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 21)];
    [titleLabel1 setText:@"Tap on discounts"];
    [titleLabel1 setTextAlignment:NSTextAlignmentCenter];
    [titleLabel1 setTextColor:[UIColor whiteColor]];
    [titleLabel1 setBackgroundColor:[UIColor clearColor]];
    [titleLabel1 setFont:[UIFont fontWithName:@"Marko one" size:17]];
    [instructionView addSubview:titleLabel1];
    
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 200, 21)];
    [titleLabel2 setText:@"to view details"];
    [titleLabel2 setTextAlignment:NSTextAlignmentCenter];
    [titleLabel2 setTextColor:[UIColor whiteColor]];
    [titleLabel2 setBackgroundColor:[UIColor clearColor]];
    [titleLabel2 setFont:[UIFont fontWithName:@"Marko one" size:17]];
    [instructionView addSubview:titleLabel2];
        
    [self.navigationItem setTitle:@"Products"];
    
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.129 green:0.282 blue:0.384 alpha:1.0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return productList.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductCell";
    ProductsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ProductsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Product *product = [productList.list objectAtIndex:indexPath.row];
    [cell createCellWithProduct:product];
    if (product.selected)
        [cell setCellSelected];
    else
        [cell setCellUnselected];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[productList.list objectAtIndex:indexPath.row] selected])
        return 207.5;
    else
        return 107.5;
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSLog(@"%d", [[productList.list objectAtIndex:indexPath.row] productID]);
        [productList remove:[productList.list objectAtIndex:indexPath.row]];
        [productList.list removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product *product = [productList.list objectAtIndex:indexPath.row];
    if (product.selected)
        product.selected = false;
    else
        product.selected = true;
    [self.tableView reloadData];
}

#pragma mark - AddNewProductDelegate
- (void)getNewProduc:(NSUInteger)productID
{
    [productList pull:productID];
}

- (void)getAllPromotions
{
    productList = [ProductList sharedInstance];
    productList.delegate = self;
    [productList refreshList];
}

#pragma mark - Refresh Data Delegate
- (void)refreshData
{
    NSLog(@"Reload");
    [self.tableView reloadData];
}

@end
