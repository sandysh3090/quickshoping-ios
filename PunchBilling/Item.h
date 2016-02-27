//
//  Item.h
//
//  Created by Gaurav Sharma on 27/02/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Item : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *orignalPrice;
@property (nonatomic, strong) NSString *active;
@property (nonatomic, strong) NSArray *offers;
@property (nonatomic, strong) NSString *ourPrice;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *availableStock;
@property (nonatomic, strong) NSString *scanCode;
@property (nonatomic, strong) NSString *pid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
