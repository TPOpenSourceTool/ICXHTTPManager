//
//  ICXUploadRequest.h
//  MuemHTTPManager
//
//  Created by allentang on 2018/1/6.
//  Copyright © 2018年 allentang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICXNetworkMarco.h"
#import "ICXCustomManagerProtocol.h"
@interface ICXUploadRequest : NSObject
+ (NSURLSessionTask *)requestWithManager:(AFHTTPSessionManager *)manager images:(NSArray<UIImage *> *)images URL:(NSString *)URLMethod params:(NSDictionary *)params progress:(void(^)(NSProgress *uploadProgress))progress success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;
@end
