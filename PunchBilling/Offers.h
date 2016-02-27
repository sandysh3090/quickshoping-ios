//
//  Offers.h
//
//  Created by Gaurav Sharma on 27/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Offers : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *active;
@property (nonatomic, strong) NSString *minOrder;
@property (nonatomic, strong) NSString *offer;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *oid;
@property (nonatomic, strong) NSString *pid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
