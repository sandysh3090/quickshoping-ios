
//
//  PunchhSoapApiClient.h
//
//
//  Created by sandeep kumar sharma on 27/11/15.
//  Copyright © 2015 Punchh Inc. All rights reserved.

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface PunchhSoapApiClient : NSObject

- (void)getSoapApiResponse:(NSString *)URLString
                    method:(NSString *)method
             setHTTPMethod:(NSString *)httpMthod
                parameters:(NSArray *)parameters
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(NSMutableURLRequest *)createSoapMsgAndRquest:(NSArray *)parameters setHTTPMethod:(NSString *)httpMthod setrequestMethod:(NSString *)method setRequestUrl:(NSString *)URLString;

@end
