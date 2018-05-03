//
//  ICXNetworkMonitor.h
//  MuemHTTPManager
//
//  Created by allentang on 2017/12/17.
//  Copyright © 2017年 allentang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICXNetworkMonitor : NSObject
/*
 * 开始检测
 */
+ (void)startMonitoring;
/*
 * 是否有网络
 */
+ (BOOL)networkOn;
@end
