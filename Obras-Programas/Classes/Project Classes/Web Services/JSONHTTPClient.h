//
//  JSONHTTPClient.h
//  Versailles
//
//  Created by Abdiel on 7/11/14.
//  Copyright (c) 2014 Smartthinking. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@protocol JSONHTTPClientDelegate;

@interface JSONHTTPClient : AFHTTPSessionManager

@property (nonatomic, weak) id<JSONHTTPClientDelegate>delegate;

+ (JSONHTTPClient *)sharedJSONAPIClient;

- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)performPOSTRequestWithParameters:(NSDictionary *)parameters toServlet:(NSString *)servletName;

@end

@protocol JSONHTTPClientDelegate <NSObject>

@required

////// General

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didFailResponseWithError:(NSError *)error;
-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToStates:(id)response;
-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToInaugurators:(id)response;


@end