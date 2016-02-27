//
//  UserCart.h
//
//  Created by Gaurav Sharma on 27/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCart.h"
#import "ItemDetails.h"

@class PaymentDetail, Item;

@interface UserCart : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) PaymentDetail *paymentDetail;
@property (nonatomic, strong) NSString *paymentMode;
@property (nonatomic, strong) NSString *payment;
@property (nonatomic, strong) NSMutableArray <ItemDetails*>*itemDetails;
@property (nonatomic, strong) NSString *itemOurPrice;
@property (nonatomic, strong) NSString *totalBill;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

- (void)addItem:(Item*)item;
+ (UserCart *)sharedCart;
- (void)emptyCart;
@end
