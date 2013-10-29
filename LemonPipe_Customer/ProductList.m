//
//  ProductList.m
//  Lemon-Pipe
//
//  Created by Bill on 13-10-07.
//  Copyright (c) 2013 Bill. All rights reserved.
//

#import "ProductList.h"
#import "Product.h"
#import "Base64.h"

@implementation ProductList
{
    NSURLConnection *refreshConnection;
    NSMutableData *refreshResponseData;
    NSURLConnection *pullConnection;
    NSMutableData *pullResponseData;
}
@synthesize list;
@synthesize delegate;

#pragma mark - Singleton
static ProductList *sharedInstance = nil;

+ (ProductList *)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}


#pragma mark - ProductList Operations
- (void)pull:(NSUInteger)productID
{
    NSMutableURLRequest *pullRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www1.lemonpipe.com/promotions"]];
    [pullRequest setHTTPMethod:@"GET"];
    pullResponseData = [[NSMutableData alloc] init];
    
    pullConnection = [[NSURLConnection alloc] initWithRequest:pullRequest delegate:self];
    [pullConnection start];
}

- (void)remove:(Product *)aProduct
{
    NSMutableURLRequest *deleteRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www1.lemonpipe.com/promotions/%d", aProduct.productID]]];
    [deleteRequest setHTTPMethod:@"DELETE"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:deleteRequest delegate:self];
    [connection start];
}

- (void)refreshList
{
    list = [[NSMutableArray alloc] initWithCapacity:20];
    // Get Product Lists from Server
    NSMutableURLRequest *refreshRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www1.lemonpipe.com/promotions.json"]];
    [refreshRequest setHTTPMethod:@"GET"];
    
    refreshResponseData = [[NSMutableData alloc] init];
    
    refreshConnection = [[NSURLConnection alloc] initWithRequest:refreshRequest delegate:self];
    [refreshConnection start];
}

#pragma mark - NSURLConnectionDelegate, NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Receive Response %@", connection);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == refreshConnection) {
        [refreshResponseData appendData:data];
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection Faile: %@", connection);
    NSLog(@"Error: %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == refreshConnection) {
        list = [[NSMutableArray alloc] initWithCapacity:20];
        NSError *error;
        NSArray *newList = [NSJSONSerialization JSONObjectWithData:refreshResponseData options:kNilOptions error:&error];
        
        for (int i=0; i<newList.count; i++) {
            NSDictionary *product = [newList objectAtIndex:i];
            NSString *imageStr = [NSString stringWithString:[product objectForKey:@"image"]];
            UIImage *image = [UIImage imageWithData:[imageStr base64DecodedData]];
            
            Product *newProduct = [[Product alloc] initWithImage:image
                                                            MSRP:[[product objectForKey:@"msrp"] floatValue]
                                                        discount:[[product objectForKey:@"discount"] intValue]
                                                   promotionDays:[[product objectForKey:@"promotion_days"] intValue]
                                                  promotionHours:[[product objectForKey:@"promotion_hours"] intValue]
                                                            name:[product objectForKey:@"name"]];
            newProduct.productID = [[product objectForKey:@"id"] intValue];
            [list insertObject:newProduct atIndex:0];
            [newProduct startTimer];
        }
        [delegate refreshData];
    } else if (connection == pullConnection) {
        NSDictionary *product = [NSJSONSerialization JSONObjectWithData:pullResponseData options:kNilOptions error:NULL];
        NSString *imageStr = [NSString stringWithString:[product objectForKey:@"image"]];
        UIImage *image = [UIImage imageWithData:[imageStr base64DecodedData]];
        
        Product *newProduct = [[Product alloc] initWithImage:image
                                                        MSRP:[[product objectForKey:@"msrp"] floatValue]
                                                    discount:[[product objectForKey:@"discount"] intValue]
                                               promotionDays:[[product objectForKey:@"promotion_days"] intValue]
                                              promotionHours:[[product objectForKey:@"promotion_hours"] intValue]
                                                        name:[product objectForKey:@"name"]];
        newProduct.productID = [[product objectForKey:@"id"] intValue];
        [list insertObject:newProduct atIndex:0];
        [newProduct startTimer];
        [delegate refreshData];
    }
}
@end
