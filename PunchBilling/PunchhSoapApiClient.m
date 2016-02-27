//
//  PunchhSoapApiClient.m
//  Punchh
//
//  Created by sandeep kumar sharma on 27/11/15.
//  Copyright © 2015 Punchh Inc. All rights reserved.
//

#import "PunchhSoapApiClient.h"



@implementation PunchhSoapApiClient

-(void)getSoapApiResponse:(NSString *)URLString
                   method:(NSString *)method
            setHTTPMethod:(NSString *)httpMthod
               parameters:(NSArray *)parameters
                  success:(void (^)(AFHTTPRequestOperation *, id))success
                  failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[self createSoapMsgAndRquest:parameters setHTTPMethod:httpMthod setrequestMethod:method setRequestUrl:URLString]];
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    if ([AFNetworkReachabilityManager sharedManager].reachable){
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    } else {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error" message:@"Network not Reachable." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
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
