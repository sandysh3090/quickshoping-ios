//
//  SoapApiClient.m
//  
//
//  Created by sandeep kumar sharma on 27/11/15.
//  Copyright © 2015 IOS dev Inc. All rights reserved.
//

#import "billingSoapApiClient.h"
#import "JSON.h"



@implementation billingSoapApiClient

-(void)getSoapApiResponse:(NSString *)URLString
            setHTTPMethod:(NSString *)httpMthod
                 bodydata:(NSString *)body
                  success:(void (^)(AFHTTPRequestOperation *, id))success
                  failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [theRequest setHTTPMethod:httpMthod];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    [theRequest setHTTPBody:data];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* resultsd = [[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]JSONValue];
         success(operation, resultsd);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(operation, error);
    }];
    [[NSOperationQueue mainQueue] addOperation:operation];
    
}

-(NSMutableURLRequest *)createSoapMsgAndRquest:(NSArray *)parameters setHTTPMethod:(NSString *)httpMthod setrequestMethod:(NSString *)method setRequestUrl:(NSString *)URLString {
    NSURL *url = [NSURL URLWithString:URLString];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
//    NSString *msgLength = [NSString stringWithFormat:@"%lu",(unsigned long)[soapMessage length]];
//    
//    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
//    [theRequest addValue:[NSString stringWithFormat:@"%@%@",Soap_Action_url,
//                          method] forHTTPHeaderField:@"SOAPAction"];
//    [theRequest setHTTPMethod:httpMthod];
//    [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    return theRequest;
}


@end
