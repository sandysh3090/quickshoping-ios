//
//  ItemDetails.h
//
//  Created by Gaurav Sharma on 27/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item;

@interface ItemDetails : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *itemQty;
@property (nonatomic, strong) NSString *itemOrignalCost;
@property (nonatomic, strong) NSString *itemOurPrice;
@property (nonatomic, strong) Item *item;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
