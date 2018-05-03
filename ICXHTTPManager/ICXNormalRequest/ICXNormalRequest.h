//
//  ICXNormalRequest.h
//  MuemHTTPManager
//
//  Created by allentang on 2018/1/6.
//  Copyright © 2018年 allentang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICXNetworkMarco.h"
#import "ICXCustomManagerProtocol.h"
@interface ICXNormalRequest : NSObject
+ (NSURLSessionTask *)requestWithType:(ICXNormalReqeustType)type manager:(AFHTTPSessionManager *)manager URL:(NSString *)URLMethod params:(NSDictionary *)params success:(void(^)(id responseObject))success failed:(void(^)(NSError *error))fail;
@end
