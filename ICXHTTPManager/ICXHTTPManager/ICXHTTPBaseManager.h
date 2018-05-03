//
//  ICXHTTPBaseManager.h
//  MuemHTTPManager
//
//  Created by tangpeng on 2018/1/8.
//Copyright © 2018年 allentang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICXNetworkMarco.h"
#import "ICXBaseFilter.h"
#import "ICXCustomManagerProtocol.h"
@protocol ICXHTTPBaseManagerProtocol <NSObject>
//请求方式
- (ICXNormalReqeustType)requestType;
//请求的参数
- (id)params;
//请求的url
- (NSString *)requestURL;
@optional
//custom header
- (NSDictionary *)customHeader;
//custom manager
- (AFHTTPSessionManager *)customManager;
//过滤装置
- (ICXBaseFilter *)baseFilter;
//imageInfo
- (NSDictionary *)imageInfo;
//图片压缩率
- (CGFloat)radio;
@end

@interface ICXHTTPBaseManager : NSObject
//遵守协议的子类,须遵守ICXHTTPBaseManagerProtocol协议
@property (nonatomic , weak) ICXHTTPBaseManager<ICXHTTPBaseManagerProtocol> *childManager;
//外部传入的参数
@property (strong,nonatomic) NSMutableDictionary *outerParams;
//整合自定义的参数
@property(strong,nonatomic) NSDictionary *networkInfo;

//是否需要打印回调结果
@property(assign,nonatomic) BOOL debugModeOn;

/**
 * 加载数据
 */
- (void)loadDataWithCompletion:(void(^)(id responseObject))completion failed:(void(^)(NSError *error))fail;

/**
 * 上传图片
 */
- (void)uploadImageWithImages:(NSArray<UIImage *> *)images progress:(void(^)(NSProgress *uploadProgress))progress Completion:(void(^)(id responseObject))completion failed:(void(^)(NSError *error))fail;

- (void)cancelTask;




@end
