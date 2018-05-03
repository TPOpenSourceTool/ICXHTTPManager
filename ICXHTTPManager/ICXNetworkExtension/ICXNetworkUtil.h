//
//  ICXNetworkUtil.h
//  MuemHTTPManager
//
//  Created by allentang on 2018/1/6.
//  Copyright © 2018年 allentang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICXNetworkMarco.h"
@interface ICXNetworkUtil : NSObject
+ (NSString *)requestMethod:(ICXNormalReqeustType)type;
@end
