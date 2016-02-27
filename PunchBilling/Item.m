//
//  Item.m
//
//  Created by Gaurav Sharma on 27/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Item.h"
#import "Offers.h"


NSString *const kItemDetail = @"detail";
NSString *const kItemOrignalPrice = @"orignal_price";
NSString *const kItemActive = @"active";
NSString *const kItemOffers = @"offers";
NSString *const kItemOurPrice = @"our_price";
NSString *const kItemTitle = @"title";
NSString *const kItemImage = @"image";
NSString *const kItemCid = @"cid";
NSString *const kItemAvailableStock = @"available_stock";
NSString *const kItemScanCode = @"scan_code";
NSString *const kItemPid = @"pid";


@interface Item ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Item

@synthesize detail = _detail;
@synthesize orignalPrice = _orignalPrice;
@synthesize active = _active;
@synthesize offers = _offers;
@synthesize ourPrice = _ourPrice;
@synthesize title = _title;
@synthesize image = _image;
@synthesize cid = _cid;
@synthesize availableStock = _availableStock;
@synthesize scanCode = _scanCode;
@synthesize pid = _pid;


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
            self.detail = [self objectOrNilForKey:kItemDetail fromDictionary:dict];
            self.orignalPrice = [self objectOrNilForKey:kItemOrignalPrice fromDictionary:dict];
            self.active = [self objectOrNilForKey:kItemActive fromDictionary:dict];
    NSObject *receivedOffers = [dict objectForKey:kItemOffers];
    NSMutableArray *parsedOffers = [NSMutableArray array];
    if ([receivedOffers isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOffers) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOffers addObject:[Offers modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOffers isKindOfClass:[NSDictionary class]]) {
       [parsedOffers addObject:[Offers modelObjectWithDictionary:(NSDictionary *)receivedOffers]];
    }

    self.offers = [NSArray arrayWithArray:parsedOffers];
            self.ourPrice = [self objectOrNilForKey:kItemOurPrice fromDictionary:dict];
            self.title = [self objectOrNilForKey:kItemTitle fromDictionary:dict];
            self.image = [self objectOrNilForKey:kItemImage fromDictionary:dict];
            self.cid = [self objectOrNilForKey:kItemCid fromDictionary:dict];
            self.availableStock = [self objectOrNilForKey:kItemAvailableStock fromDictionary:dict];
            self.scanCode = [self objectOrNilForKey:kItemScanCode fromDictionary:dict];
            self.pid = [self objectOrNilForKey:kItemPid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.detail forKey:kItemDetail];
    [mutableDict setValue:self.orignalPrice forKey:kItemOrignalPrice];
    [mutableDict setValue:self.active forKey:kItemActive];
    NSMutableArray *tempArrayForOffers = [NSMutableArray array];
    for (NSObject *subArrayObject in self.offers) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOffers addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOffers addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOffers] forKey:kItemOffers];
    [mutableDict setValue:self.ourPrice forKey:kItemOurPrice];
    [mutableDict setValue:self.title forKey:kItemTitle];
    [mutableDict setValue:self.image forKey:kItemImage];
    [mutableDict setValue:self.cid forKey:kItemCid];
    [mutableDict setValue:self.availableStock forKey:kItemAvailableStock];
    [mutableDict setValue:self.scanCode forKey:kItemScanCode];
    [mutableDict setValue:self.pid forKey:kItemPid];

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

    self.detail = [aDecoder decodeObjectForKey:kItemDetail];
    self.orignalPrice = [aDecoder decodeObjectForKey:kItemOrignalPrice];
    self.active = [aDecoder decodeObjectForKey:kItemActive];
    self.offers = [aDecoder decodeObjectForKey:kItemOffers];
    self.ourPrice = [aDecoder decodeObjectForKey:kItemOurPrice];
    self.title = [aDecoder decodeObjectForKey:kItemTitle];
    self.image = [aDecoder decodeObjectForKey:kItemImage];
    self.cid = [aDecoder decodeObjectForKey:kItemCid];
    self.availableStock = [aDecoder decodeObjectForKey:kItemAvailableStock];
    self.scanCode = [aDecoder decodeObjectForKey:kItemScanCode];
    self.pid = [aDecoder decodeObjectForKey:kItemPid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_detail forKey:kItemDetail];
    [aCoder encodeObject:_orignalPrice forKey:kItemOrignalPrice];
    [aCoder encodeObject:_active forKey:kItemActive];
    [aCoder encodeObject:_offers forKey:kItemOffers];
    [aCoder encodeObject:_ourPrice forKey:kItemOurPrice];
    [aCoder encodeObject:_title forKey:kItemTitle];
    [aCoder encodeObject:_image forKey:kItemImage];
    [aCoder encodeObject:_cid forKey:kItemCid];
    [aCoder encodeObject:_availableStock forKey:kItemAvailableStock];
    [aCoder encodeObject:_scanCode forKey:kItemScanCode];
    [aCoder encodeObject:_pid forKey:kItemPid];
}

- (id)copyWithZone:(NSZone *)zone
{
    Item *copy = [[Item alloc] init];
    
    if (copy) {

        copy.detail = [self.detail copyWithZone:zone];
        copy.orignalPrice = [self.orignalPrice copyWithZone:zone];
        copy.active = [self.active copyWithZone:zone];
        copy.offers = [self.offers copyWithZone:zone];
        copy.ourPrice = [self.ourPrice copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.cid = [self.cid copyWithZone:zone];
        copy.availableStock = [self.availableStock copyWithZone:zone];
        copy.scanCode = [self.scanCode copyWithZone:zone];
        copy.pid = [self.pid copyWithZone:zone];
    }
    
    return copy;
}


@end
