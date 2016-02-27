//
//  PaymentDetail.m
//
//  Created by Gaurav Sharma on 27/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "PaymentDetail.h"


NSString *const kPaymentDetailCardNo = @"card_no";
NSString *const kPaymentDetailCardHolderName = @"card_holder_name";


@interface PaymentDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PaymentDetail

@synthesize cardNo = _cardNo;
@synthesize cardHolderName = _cardHolderName;


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
            self.cardNo = [self objectOrNilForKey:kPaymentDetailCardNo fromDictionary:dict];
            self.cardHolderName = [self objectOrNilForKey:kPaymentDetailCardHolderName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cardNo forKey:kPaymentDetailCardNo];
    [mutableDict setValue:self.cardHolderName forKey:kPaymentDetailCardHolderName];

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

    self.cardNo = [aDecoder decodeObjectForKey:kPaymentDetailCardNo];
    self.cardHolderName = [aDecoder decodeObjectForKey:kPaymentDetailCardHolderName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cardNo forKey:kPaymentDetailCardNo];
    [aCoder encodeObject:_cardHolderName forKey:kPaymentDetailCardHolderName];
}

- (id)copyWithZone:(NSZone *)zone
{
    PaymentDetail *copy = [[PaymentDetail alloc] init];
    
    if (copy) {

        copy.cardNo = [self.cardNo copyWithZone:zone];
        copy.cardHolderName = [self.cardHolderName copyWithZone:zone];
    }
    
    return copy;
}


@end
