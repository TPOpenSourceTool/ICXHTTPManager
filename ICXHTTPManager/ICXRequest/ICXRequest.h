//
//  ICXRequest.h
//  MuemHTTPManager
//
//  Created by allentang on 2017/12/17.
//  Copyright © 2017年 allentang. All rights reserved.
//  这个类是对ICXHTTPKit的再封装,在这里可以对数据进行处理

#import <UIKit/UIKit.h>
#import "ICXNetworkMarco.h"

@interface ICXRequest : NSObject
//存放所有进行的任务,什么时候清空?
@property (nonatomic,strong) NSMutableDictionary *allTasks;
+ (instancetype)request;
/**
 Get请求
 
 @param URL url
 @param success 成功的回调
 @param fail 失败回调
 */
+ (NSNumber *)requestByGetWithURL:(NSString *)URL params:(NSDictionary *)params success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;
/**
 Post请求
 
 @param URL url
 @param success 成功的回调
 @param fail 失败回调
 */
+ (NSNumber *)requestByPostWithURL:(NSString *)URL params:(NSDictionary *)params success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;
/**
 Delete请求
 
 @param URL url
 @param success 成功的回调
 @param fail 失败回调
 */
+ (NSNumber *)requestByDeleteWithURL:(NSString *)URL params:(NSDictionary *)params success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;
/**
 Put请求
 
 @param URL url
 @param success 成功的回调
 @param fail 失败回调
 */
+ (NSNumber *)requestByPutWithURL:(NSString *)URL params:(NSDictionary *)params success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;

/**
 上传文件
 
 @param URL url
 @param success 成功的回调
 @param fail 失败回调
 */
+ (NSNumber *)uploadFileWithURLMethod:(NSString *)URL images:(NSArray<UIImage *> *)images params:(NSDictionary *)params progress:(void(^)(NSProgress *uploadProgress))progress success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;

/**
 结束所有请求任务
 */
- (void)cancelAllTasks;

/**
 根据id取消某个任务

 @param requestId 任务id
 */
- (void)cancelTaskWithRequestId:(NSNumber *)requestId;

@end
