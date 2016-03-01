
//
//  PunchhSoapApiClient.h
//
//
//  Created by sandeep kumar sharma on 27/11/15.
//  Copyright © 2015 IOS dev Inc. All rights reserved.

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface PunchhSoapApiClient : NSObject

-(void)getSoapApiResponse:(NSString *)URLString
            setHTTPMethod:(NSString *)httpMthod
                 bodydata:(NSString *)body
                  success:(void (^)(AFHTTPRequestOperation *, id))success
                  failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

-(NSMutableURLRequest *)createSoapMsgAndRquest:(NSArray *)parameters setHTTPMethod:(NSString *)httpMthod setrequestMethod:(NSString *)method setRequestUrl:(NSString *)URLString;

@end
