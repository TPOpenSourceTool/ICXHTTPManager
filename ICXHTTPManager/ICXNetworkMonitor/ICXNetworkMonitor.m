//
//  ICXNetworkMonitor.m
//  MuemHTTPManager
//
//  Created by allentang on 2017/12/17.
//  Copyright © 2017年 allentang. All rights reserved.
//

#import "ICXNetworkMonitor.h"
#import "AFNetworking.h"
#import "ICXNetworkMarco.h"
@implementation ICXNetworkMonitor

+ (void)startMonitoring{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    __block NSString *networkStatus = [NSString string];
    //设置网络状态改变后的处理
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown:
                // 未知网络
                ALog(@"UNKnown");
                networkStatus = ICXNETWORKSTATUSUNKOWN;
                [self sendNetworkNotification:ICXNETWORKSTATUSUNKOWN];
                [self recordNetworkStatus:networkStatus];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                // 没有网络(断网)
                ALog(@"NO Network");
                networkStatus = ICXNETWORKSTATUSNOTREACH;
                [self sendNetworkNotification:ICXNETWORKSTATUSNOTREACH];
                [self recordNetworkStatus:networkStatus];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                // 手机自带网络
                networkStatus = ICXNETWORKSTATUSWWAN;
                [self sendNetworkNotification:ICXNETWORKSTATUSWWAN];
                [self recordNetworkStatus:networkStatus];
                ALog(@"3G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                // WIFI
                ALog(@"WIFI");
                networkStatus = ICXNETWORKSTATUSWIFI;
                //发送监听通知
                [self sendNetworkNotification:ICXNETWORKSTATUSWIFI];
                //记录网络状态
                [self recordNetworkStatus:networkStatus];
                break;
        }
    }];
    
    // 3.开始监控
    [manager startMonitoring];
}

/**
 *     发送网络状态通知,用于监听网络状态
 */
+ (void)sendNetworkNotification:(NSString *)notifacationName{
    [[NSNotificationCenter defaultCenter] postNotificationName:notifacationName object:nil];
}

/**
 *     保存网络状态
 */
+ (void)recordNetworkStatus:(NSString *)status{
    [[NSUserDefaults standardUserDefaults] setObject:status forKey:ICXNetworkStatus];
}
/**
 *     判断网络状态
 */
+ (BOOL)networkOn{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:ICXNetworkStatus] isEqualToString:ICXNETWORKSTATUSUNKOWN] || [[[NSUserDefaults standardUserDefaults] objectForKey:ICXNetworkStatus] isEqualToString:ICXNETWORKSTATUSNOTREACH]) {
        return NO;
    }else{
        return YES;
    }
}
@end
