//
//  CartItem.h
//  PunchBilling
//
//  Created by sandeep kumar sharma on 27/02/16.
//  Copyright © 2016 Punchh Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface CartItem : NSObject

@property (nonatomic, strong) NSNumber *item_orignal_cost;
@property (nonatomic, strong) NSNumber *item_our_price;
@property (nonatomic, strong) NSNumber *item_qty;
@property (nonatomic, strong) Item *item;

@end
