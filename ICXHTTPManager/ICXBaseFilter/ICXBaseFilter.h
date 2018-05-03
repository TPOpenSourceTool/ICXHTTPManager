//
//  ICXBaseFilter.h
//  MuemHTTPManager
//
//  Created by allentang on 2017/12/17.
//  Copyright © 2017年 allentang. All rights reserved.
//  用作数据过滤,需要新建一个filter的类,其实可以单独用协议,但是考虑方便书写,就写一个基类即可

#import <Foundation/Foundation.h>
@protocol ICXRequestFilterProtocol<NSObject>
@optional
/*
 * 自定义过滤规则
 */
- (id)filterData:(id)data;
/*
 * 传入模型进行过滤
 */
- (id)filterData:(id)data modelClass:(NSString *)modelClass;
@end

@interface ICXBaseFilter : NSObject<ICXRequestFilterProtocol>
@property(strong,nonatomic) NSString *modleClass;
@end
