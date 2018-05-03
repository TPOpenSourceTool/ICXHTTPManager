//
//  ICXHTTPKIT.h
//  MuemHTTPManager
//
//  Created by allentang on 2017/12/17.
//  Copyright © 2017年 allentang. All rights reserved.
//  这个类只是对AFN做一个简单的封装,目的是为了将来如果需要更新网络库,那么只需要在这个类进行更改即可,更优的方式是用协议,但目前AFN很久估计都不会变

#import <Foundation/Foundation.h>
#import "ICXNetworkMarco.h"
#import "ICXNormalRequest.h"
#import "ICXUploadRequest.h"
#import "ICXCustomManagerProtocol.h"
@interface ICXHTTPKit : NSObject
//默认的manager
@property (nonatomic,strong) AFHTTPSessionManager *defaultManager;

+ (instancetype)httpKit;

/**
 Get请求

 @param URLMethod url
 @param success 成功的回调
 @param fail 失败回调
 */
+ (NSURLSessionTask *)requestByGetWithURLMethod:(NSString *)URLMethod params:(NSDictionary *)params success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;
/**
 Post请求
 
 @param URLMethod url
 @param success 成功的回调
 @param fail 失败回调
 */
+ (NSURLSessionTask *)requestByPostWithURLMethod:(NSString *)URLMethod params:(NSDictionary *)params success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;
/**
 Delete请求
 
 @param URLMethod url
 @param success 成功的回调
 @param fail 失败回调
 */
+ (NSURLSessionTask *)requestByDeleteWithURLMethod:(NSString *)URLMethod params:(NSDictionary *)params success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;
/**
 Put请求
 
 @param URLMethod rul
 @param success 成功的回调
 @param fail 失败回调
 */
+ (NSURLSessionTask *)requestByPutWithURLMethod:(NSString *)URLMethod params:(NSDictionary *)params success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;

/**
 批量上传图片
 
 @param URLMethod rul
 @param success 成功的回调
 @param fail 失败回调
 */
+ (NSURLSessionTask *)uploadFileWithURLMethod:(NSString *)URLMethod images:(NSArray<UIImage *> *)images params:(NSDictionary *)params progress:(void(^)(NSProgress *uploadProgress))progress success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;

@end
