//
//  NSString+Additional.m
//  DemoQucikShop
//
//  Created by SANDEEP SHARMA on 27/02/16.
//  Copyright (c) 2016 Softex Lab. All rights reserved.
//

#import "NSString+Additional.h"

@implementation NSString (Additional)

-(NSString *)getTrimmedString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *)getTrimmedStringWithCharacterSet:(NSString *)trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:trimString]];
}

-(NSString *)removeWhiteSpaces {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(BOOL)present {
    return (self &&
            self.getTrimmedString.length &&
            [self isKindOfClass:[NSString class]] &&
            ![self isEqualToString:@"null"]);
}

@end
