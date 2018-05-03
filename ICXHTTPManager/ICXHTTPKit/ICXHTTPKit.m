//
//  ICXHTTPKIT.m
//  MuemHTTPManager
//
//  Created by allentang on 2017/12/17.
//  Copyright © 2017年 allentang. All rights reserved.
//

#import "ICXHTTPKit.h"

@implementation ICXHTTPKit

+ (instancetype)httpKit{
    static ICXHTTPKit *http = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        http = [[self alloc] init];
    });
    return http;
}

+ (NSURLSessionTask *)requestByGetWithURLMethod:(NSString *)URLMethod params:(NSDictionary *)params success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;{
    AFHTTPSessionManager *manager =  [[ICXHTTPKit httpKit] defaultManager];
    return [ICXNormalRequest requestWithType:ICXNormalReqeustTypeGET manager:manager URL:URLMethod params:params success:success failed:fail];
}

+ (NSURLSessionTask *)requestByPostWithURLMethod:(NSString *)URLMethod params:(NSDictionary *)params success:(void (^)(id))success failed:(void (^)(NSError *))fail{
    AFHTTPSessionManager *manager =  [[ICXHTTPKit httpKit] defaultManager];
    return [ICXNormalRequest requestWithType:ICXNormalReqeustTypePOST manager:manager URL:URLMethod params:params success:success failed:fail];
}

+ (NSURLSessionTask *)requestByPutWithURLMethod:(NSString *)URLMethod params:(NSDictionary *)params success:(void (^)(id))success failed:(void (^)(NSError *))fail{
    AFHTTPSessionManager *manager =  [[ICXHTTPKit httpKit] defaultManager];
    return [ICXNormalRequest requestWithType:ICXNormalReqeustTypePUT manager:manager URL:URLMethod params:params success:success failed:fail];
}

+ (NSURLSessionTask *)requestByDeleteWithURLMethod:(NSString *)URLMethod params:(NSDictionary *)params success:(void (^)(id))success failed:(void (^)(NSError *))fail{
    AFHTTPSessionManager *manager =  [[ICXHTTPKit httpKit] defaultManager];
    return [ICXNormalRequest requestWithType:ICXNormalReqeustTypeDELETE manager:manager URL:URLMethod params:params success:success failed:fail];
}

+ (NSURLSessionTask *)uploadFileWithURLMethod:(NSString *)URLMethod images:(NSArray<UIImage *> *)images params:(NSDictionary *)params progress:(void(^)(NSProgress *uploadProgress))progress success:(void (^)(id))success failed:(void (^)(NSError *))fail{
    AFHTTPSessionManager *manager =  [[ICXHTTPKit httpKit] defaultManager];
    return [ICXUploadRequest requestWithManager:manager images:images URL:URLMethod params:params progress:progress success:success failed:fail];
}
#pragma mark - prviate

#pragma mark - getter

- (AFHTTPSessionManager *)defaultManager{
    if (!_defaultManager) {
        _defaultManager = [AFHTTPSessionManager manager];
        _defaultManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _defaultManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
        _defaultManager.requestSerializer.timeoutInterval = 15;
    }
    //ALog(@"默认的manager : %@",_defaultManager);
    return _defaultManager;
}
@end
