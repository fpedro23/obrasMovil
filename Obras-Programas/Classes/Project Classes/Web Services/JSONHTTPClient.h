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
@property (nonatomic, strong) NSString *servletName;
+ (JSONHTTPClient *)sharedJSONAPIClient;

- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)performPOSTRequestWithParameters:(NSDictionary *)parameters toServlet:(NSString *)servletName withOptions:(NSString *)option;
- (NSArray *)deserializeDependenciesFromJSON:(NSArray *)impactsJSON;
- (NSArray *)deserializeWorksFromJSON:(NSArray *)worksJSON;
- (NSArray *)deserializeProgramsFromJSON:(NSArray *)worksJSON;
- (NSArray *)deserializeStatesFromJSON:(NSArray *)statesJSON;
- (NSArray *)deserializeInauguratorsFromJSON:(NSArray *)inauguratorsJSON;
- (NSArray *)deserializeImpactsFromJSON:(NSArray *)impactsJSON;
- (NSArray *)deserializeClasificationsFromJSON:(NSArray *)impactsJSON;
- (NSArray *)deserializeInvesmentsFromJSON:(NSArray *)invesmentsJSON;
- (NSArray *)deserializeWorksProgramsFromJSON:(NSArray *)typeWorkProgramJSON;
- (NSArray *)deserializeListReportDependenciesromJSON:(NSArray *)typeWorkProgramJSON;
- (NSArray *)deserializeListReporteStateFromJSON:(NSArray *)typeWorkProgramJSON;
- (NSArray *)deserializeListGeneralReporteFromJSON:(NSArray *)typeWorkProgramJSON;
- (NSArray *)deserializeSubclasificationsFromJSON:(NSArray *)typeWorkProgramJSON;
@end

@protocol JSONHTTPClientDelegate <NSObject>

@required

////// General

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didFailResponseWithError:(NSError *)error;
-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToStates:(id)response;
-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToInaugurators:(id)response;
-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToImpacts:(id)response;
-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToDependencies:(id)response;
-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToClasifications:(id)response;
-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToTypesOfWorksAndPrograms:(id)response;
-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToTypesOfInvesments:(id)response;
-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseToSubclasifications:(id)response;

-(void)JSONHTTPClientDelegate:(JSONHTTPClient *)client didResponseSearchWorks:(id)response;



@end