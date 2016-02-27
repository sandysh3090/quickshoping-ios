//
//  ItemDetails.m
//
//  Created by Gaurav Sharma on 27/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ItemDetails.h"
#import "Item.h"


NSString *const kItemDetailsItemQty = @"item_qty";
NSString *const kItemDetailsItemOrignalCost = @"item_orignal_cost";
NSString *const kItemDetailsItemOurPrice = @"item_our_price";
NSString *const kItemDetailsItem = @"item";


@interface ItemDetails ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ItemDetails

@synthesize itemQty = _itemQty;
@synthesize itemOrignalCost = _itemOrignalCost;
@synthesize itemOurPrice = _itemOurPrice;
@synthesize item = _item;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.itemQty = [self objectOrNilForKey:kItemDetailsItemQty fromDictionary:dict];
            self.itemOrignalCost = [self objectOrNilForKey:kItemDetailsItemOrignalCost fromDictionary:dict];
            self.itemOurPrice = [self objectOrNilForKey:kItemDetailsItemOurPrice fromDictionary:dict];
            self.item = [Item modelObjectWithDictionary:[dict objectForKey:kItemDetailsItem]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.itemQty forKey:kItemDetailsItemQty];
    [mutableDict setValue:self.itemOrignalCost forKey:kItemDetailsItemOrignalCost];
    [mutableDict setValue:self.itemOurPrice forKey:kItemDetailsItemOurPrice];
    [mutableDict setValue:[self.item dictionaryRepresentation] forKey:kItemDetailsItem];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.itemQty = [aDecoder decodeObjectForKey:kItemDetailsItemQty];
    self.itemOrignalCost = [aDecoder decodeObjectForKey:kItemDetailsItemOrignalCost];
    self.itemOurPrice = [aDecoder decodeObjectForKey:kItemDetailsItemOurPrice];
    self.item = [aDecoder decodeObjectForKey:kItemDetailsItem];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_itemQty forKey:kItemDetailsItemQty];
    [aCoder encodeObject:_itemOrignalCost forKey:kItemDetailsItemOrignalCost];
    [aCoder encodeObject:_itemOurPrice forKey:kItemDetailsItemOurPrice];
    [aCoder encodeObject:_item forKey:kItemDetailsItem];
}

- (id)copyWithZone:(NSZone *)zone
{
    ItemDetails *copy = [[ItemDetails alloc] init];
    
    if (copy) {

        copy.itemQty = [self.itemQty copyWithZone:zone];
        copy.itemOrignalCost = [self.itemOrignalCost copyWithZone:zone];
        copy.itemOurPrice = [self.itemOurPrice copyWithZone:zone];
        copy.item = [self.item copyWithZone:zone];
    }
    
    return copy;
}


@end
