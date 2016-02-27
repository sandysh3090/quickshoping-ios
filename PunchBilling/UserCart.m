//
//  UserCart.m
//
//  Created by Gaurav Sharma on 27/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "UserCart.h"
#import "PaymentDetail.h"


NSString *const kUserCartPaymentDetail = @"payment_detail";
NSString *const kUserCartPaymentMode = @"payment_mode";
NSString *const kUserCartPayment = @"payment";
NSString *const kUserCartItemDetails = @"item_details";
NSString *const kUserCartItemOurPrice = @"item_our_price";
NSString *const kUserCartTotalBill = @"total_bill";


@interface UserCart ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserCart

@synthesize paymentDetail = _paymentDetail;
@synthesize paymentMode = _paymentMode;
@synthesize payment = _payment;
@synthesize itemDetails = _itemDetails;
@synthesize itemOurPrice = _itemOurPrice;
@synthesize totalBill = _totalBill;

+ (UserCart *)sharedCart {
    static dispatch_once_t pred = 0;
    __strong static id _sharedCart = nil;
    dispatch_once(&pred, ^{
        _sharedCart = (UserCart *)[[self alloc] init]; // or some other init method
    });
    return _sharedCart;
}

- (id) init {
    if (self = [super init]) {
        _itemDetails = [NSMutableArray array];
    }
    return self;
}

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
            self.paymentDetail = [PaymentDetail modelObjectWithDictionary:[dict objectForKey:kUserCartPaymentDetail]];
            self.paymentMode = [self objectOrNilForKey:kUserCartPaymentMode fromDictionary:dict];
            self.payment = [self objectOrNilForKey:kUserCartPayment fromDictionary:dict];
    NSObject *receivedItemDetails = [dict objectForKey:kUserCartItemDetails];
    NSMutableArray *parsedItemDetails = [NSMutableArray array];
    if ([receivedItemDetails isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedItemDetails) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedItemDetails addObject:[ItemDetails modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedItemDetails isKindOfClass:[NSDictionary class]]) {
       [parsedItemDetails addObject:[ItemDetails modelObjectWithDictionary:(NSDictionary *)receivedItemDetails]];
    }

    self.itemDetails = [NSMutableArray arrayWithArray:parsedItemDetails];
            self.itemOurPrice = [self objectOrNilForKey:kUserCartItemOurPrice fromDictionary:dict];
            self.totalBill = [self objectOrNilForKey:kUserCartTotalBill fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.paymentDetail dictionaryRepresentation] forKey:kUserCartPaymentDetail];
    [mutableDict setValue:self.paymentMode forKey:kUserCartPaymentMode];
    [mutableDict setValue:self.payment forKey:kUserCartPayment];
    NSMutableArray *tempArrayForItemDetails = [NSMutableArray array];
    for (NSObject *subArrayObject in self.itemDetails) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForItemDetails addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForItemDetails addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItemDetails] forKey:kUserCartItemDetails];
    [mutableDict setValue:self.itemOurPrice forKey:kUserCartItemOurPrice];
    [mutableDict setValue:self.totalBill forKey:kUserCartTotalBill];

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

    self.paymentDetail = [aDecoder decodeObjectForKey:kUserCartPaymentDetail];
    self.paymentMode = [aDecoder decodeObjectForKey:kUserCartPaymentMode];
    self.payment = [aDecoder decodeObjectForKey:kUserCartPayment];
    self.itemDetails = [aDecoder decodeObjectForKey:kUserCartItemDetails];
    self.itemOurPrice = [aDecoder decodeObjectForKey:kUserCartItemOurPrice];
    self.totalBill = [aDecoder decodeObjectForKey:kUserCartTotalBill];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_paymentDetail forKey:kUserCartPaymentDetail];
    [aCoder encodeObject:_paymentMode forKey:kUserCartPaymentMode];
    [aCoder encodeObject:_payment forKey:kUserCartPayment];
    [aCoder encodeObject:_itemDetails forKey:kUserCartItemDetails];
    [aCoder encodeObject:_itemOurPrice forKey:kUserCartItemOurPrice];
    [aCoder encodeObject:_totalBill forKey:kUserCartTotalBill];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserCart *copy = [[UserCart alloc] init];
    
    if (copy) {

        copy.paymentDetail = [self.paymentDetail copyWithZone:zone];
        copy.paymentMode = [self.paymentMode copyWithZone:zone];
        copy.payment = [self.payment copyWithZone:zone];
        copy.itemDetails = [self.itemDetails copyWithZone:zone];
        copy.itemOurPrice = [self.itemOurPrice copyWithZone:zone];
        copy.totalBill = [self.totalBill copyWithZone:zone];
    }
    
    return copy;
}


#pragma mark - My methods

//- (void)addItem:(Item*)item {
//    if (!self.itemDetails) {
//        self.itemDetails = [NSMutableArray new];
//    }
//    self.itemDetails add
//}

@end
