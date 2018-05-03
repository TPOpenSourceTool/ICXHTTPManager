//
//  ICXNetworkUtil.m
//  MuemHTTPManager
//
//  Created by allentang on 2018/1/6.
//  Copyright © 2018年 allentang. All rights reserved.
//

#import "ICXNetworkUtil.h"

@implementation ICXNetworkUtil
+ (NSString *)requestMethod:(ICXNormalReqeustType)type{
    return [self methodDict][@(type)];
}
+ (NSDictionary *)methodDict{
    return @{
             @(ICXNormalReqeustTypeGET) : @"GET",
             @(ICXNormalReqeustTypePOST) : @"POST",
             @(ICXNormalReqeustTypeDELETE) : @"DELETE",
             @(ICXNormalReqeustTypePUT) : @"PUT",
             };
}
@end
