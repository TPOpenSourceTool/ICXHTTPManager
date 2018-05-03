//
//  ICXNormalRequest.m
//  MuemHTTPManager
//
//  Created by allentang on 2018/1/6.
//  Copyright © 2018年 allentang. All rights reserved.
//

#import "ICXNormalRequest.h"
#import "ICXNetworkUtil.h"
#import "ICXBaseFilter.h"
#import "ICXHTTPErrorManager.h"
@implementation ICXNormalRequest
+ (NSURLSessionTask *)requestWithType:(ICXNormalReqeustType)type manager:(AFHTTPSessionManager *)manager URL:(NSString *)URLMethod params:(NSDictionary *)params success:(void (^)(id))success failed:(void (^)(NSError *))fail{
    
    AFHTTPSessionManager *customManager = params[ICXNetworkCustomManager];
    //自定义的manager
    if (customManager) {
        manager = customManager;
    }
    
    //自定义header
    NSDictionary *header = params[ICXNetworkCustomHeader];
    if (header && [header allKeys].count != 0) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    //是否需要debug打印
    __block BOOL debugMode = [params[ICXNetworkDebugMode] boolValue];

    //是否需要过滤
    __block ICXBaseFilter *filter = params[ICXNetworkCustomFilter];
    
    id param = params[ICXNetworkParams];
    
    NSError *error = nil;
    NSString *method = [ICXNetworkUtil requestMethod:type];
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:URLMethod parameters:param error:&error];
    NSURLSessionTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            fail ? fail(error) : nil;
            if (debugMode) {
                ALog(@"fail : %@",error.description);
            }
        }else{
            if (filter) {
                if ([filter respondsToSelector:@selector(filterData:)]) {
                    success ? success([filter filterData:responseObject]) : nil;
                }else if ([filter respondsToSelector:@selector(filterData:modelClass:)]) {
                    success ? success([filter filterData:responseObject modelClass:filter.modleClass]) : nil;
                }else{
                    success ? success(responseObject) : nil;
                }
            }else{
                success ? success(responseObject) : nil;
            }
            if (debugMode) {
                ALog(@"success : %@",responseObject);
            }
        }
    }];
    [dataTask resume];
    return dataTask;
}
@end
