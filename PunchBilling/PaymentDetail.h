//
//  PaymentDetail.h
//
//  Created by Gaurav Sharma on 27/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PaymentDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *cardNo;
@property (nonatomic, strong) NSString *cardHolderName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
