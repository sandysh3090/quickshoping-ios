//
//  Offers.m
//
//  Created by Gaurav Sharma on 27/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Offers.h"


NSString *const kOffersDetail = @"detail";
NSString *const kOffersActive = @"active";
NSString *const kOffersMinOrder = @"min_order";
NSString *const kOffersOffer = @"offer";
NSString *const kOffersType = @"type";
NSString *const kOffersOid = @"oid";
NSString *const kOffersPid = @"pid";


@interface Offers ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Offers

@synthesize detail = _detail;
@synthesize active = _active;
@synthesize minOrder = _minOrder;
@synthesize offer = _offer;
@synthesize type = _type;
@synthesize oid = _oid;
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
            self.detail = [self objectOrNilForKey:kOffersDetail fromDictionary:dict];
            self.active = [self objectOrNilForKey:kOffersActive fromDictionary:dict];
            self.minOrder = [self objectOrNilForKey:kOffersMinOrder fromDictionary:dict];
            self.offer = [self objectOrNilForKey:kOffersOffer fromDictionary:dict];
            self.type = [self objectOrNilForKey:kOffersType fromDictionary:dict];
            self.oid = [self objectOrNilForKey:kOffersOid fromDictionary:dict];
            self.pid = [self objectOrNilForKey:kOffersPid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.detail forKey:kOffersDetail];
    [mutableDict setValue:self.active forKey:kOffersActive];
    [mutableDict setValue:self.minOrder forKey:kOffersMinOrder];
    [mutableDict setValue:self.offer forKey:kOffersOffer];
    [mutableDict setValue:self.type forKey:kOffersType];
    [mutableDict setValue:self.oid forKey:kOffersOid];
    [mutableDict setValue:self.pid forKey:kOffersPid];

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

    self.detail = [aDecoder decodeObjectForKey:kOffersDetail];
    self.active = [aDecoder decodeObjectForKey:kOffersActive];
    self.minOrder = [aDecoder decodeObjectForKey:kOffersMinOrder];
    self.offer = [aDecoder decodeObjectForKey:kOffersOffer];
    self.type = [aDecoder decodeObjectForKey:kOffersType];
    self.oid = [aDecoder decodeObjectForKey:kOffersOid];
    self.pid = [aDecoder decodeObjectForKey:kOffersPid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_detail forKey:kOffersDetail];
    [aCoder encodeObject:_active forKey:kOffersActive];
    [aCoder encodeObject:_minOrder forKey:kOffersMinOrder];
    [aCoder encodeObject:_offer forKey:kOffersOffer];
    [aCoder encodeObject:_type forKey:kOffersType];
    [aCoder encodeObject:_oid forKey:kOffersOid];
    [aCoder encodeObject:_pid forKey:kOffersPid];
}

- (id)copyWithZone:(NSZone *)zone
{
    Offers *copy = [[Offers alloc] init];
    
    if (copy) {

        copy.detail = [self.detail copyWithZone:zone];
        copy.active = [self.active copyWithZone:zone];
        copy.minOrder = [self.minOrder copyWithZone:zone];
        copy.offer = [self.offer copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.oid = [self.oid copyWithZone:zone];
        copy.pid = [self.pid copyWithZone:zone];
    }
    
    return copy;
}


@end
