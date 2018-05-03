//
//  ICXCustomManagerProtocol.h
//  MuemHTTPManager
//
//  Created by allentang on 2018/1/6.
//  Copyright © 2018年 allentang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@protocol ICXCustomManagerProtocol <NSObject>
@optional
- (AFHTTPSessionManager *)customManager;
@end
