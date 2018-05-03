//
//  ICXHTTPBaseManager.m
//  MuemHTTPManager
//
//  Created by tangpeng on 2018/1/8.
//Copyright © 2018年 allentang. All rights reserved.
//

#import "ICXHTTPBaseManager.h"
#import "ICXRequest.h"
#import "ICXHTTPKit.h"

@interface ICXHTTPBaseManager()
@property(strong,nonatomic) ICXRequest *apiRequest;
@property (nonatomic,strong) NSNumber *requestId;
@end

@implementation ICXHTTPBaseManager
#pragma mark - init methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化的时候,让该类等于childManager,完成请求参数的传递
        if ([self conformsToProtocol:@protocol(ICXHTTPBaseManagerProtocol)]) {
            self.childManager = (ICXHTTPBaseManager<ICXHTTPBaseManagerProtocol> *)self;
        }
    }
    return self;
}
#pragma mark - system delegate

#pragma mark - custom delegate

#pragma mark - api methods
- (void)loadDataWithCompletion:(void (^)(id))completion failed:(void (^)(NSError *))fail{
    switch (self.childManager.requestType) {
        case ICXNormalReqeustTypeGET:
        {
            self.requestId = [ICXRequest requestByGetWithURL:self.childManager.requestURL params:[self networkInfo] success:completion failed:fail];
        }
            break;
        case ICXNormalReqeustTypePOST:
        {
            self.requestId = [ICXRequest requestByPostWithURL:self.childManager.requestURL params:[self networkInfo] success:completion failed:fail];
        }
            break;
        case ICXNormalReqeustTypePUT:
        {
            self.requestId = [ICXRequest requestByPutWithURL:self.childManager.requestURL params:[self networkInfo] success:completion failed:fail];
        }
            break;
        case ICXNormalReqeustTypeDELETE:
        {
            self.requestId = [ICXRequest requestByDeleteWithURL:self.childManager.requestURL params:[self networkInfo] success:completion failed:fail];
        }
            break;
    }
}

- (void)uploadImageWithImages:(NSArray<UIImage *> *)images progress:(void(^)(NSProgress *uploadProgress))progress Completion:(void(^)(id responseObject))completion failed:(void(^)(NSError *error))fail{
    self.requestId = [ICXRequest uploadFileWithURLMethod:self.childManager.requestURL images:images params:[self networkInfo] progress:progress success:completion failed:fail];
}
#pragma mark - event response

#pragma mark - private

- (void)cancelTask{
    [self.apiRequest cancelTaskWithRequestId:self.requestId];
}
- (BOOL)childRespondsToSelector:(SEL)Selector{
    if ([self.childManager respondsToSelector:Selector]) {
        return YES;
    }
    return NO;
}

#pragma mark - getter / setter

- (NSDictionary *)networkInfo{
    
    AFHTTPSessionManager *manager = nil;
    if ([self childRespondsToSelector:@selector(customManager)]) {
        manager = self.childManager.customManager;
    }
    
    NSDictionary *header = nil;
    if ([self childRespondsToSelector:@selector(customHeader)]) {
        header = self.childManager.customHeader;
    }
    NSDictionary *imageInfo = nil;
    if ([self childRespondsToSelector:@selector(imageInfo)]) {
        imageInfo = self.childManager.imageInfo;
    }
    ICXBaseFilter *filter = nil;
    if ([self childRespondsToSelector:@selector(baseFilter)]) {
        filter = self.childManager.baseFilter;
    }
    CGFloat radio = 0;
    if ([self childRespondsToSelector:@selector(radio)]) {
        radio = self.childManager.radio;
    }
    
    return @{
             ICXNetworkCustomManager : manager ? : [ICXHTTPKit httpKit].defaultManager,
             ICXNetworkCustomHeader : header ? : @{},
             ICXNetworkCustomFilter : filter ? : [ICXBaseFilter new],
             ICXNetworkCustomImageInfo : imageInfo ? :@{},
             ICXNetworkParams : self.childManager.params ? : @{},
             ICXNetworkDebugMode : @(self.debugModeOn),
             ICXNetworkImageRadio: @(radio)
             };
}

- (ICXRequest *)apiRequest{
    if (!_apiRequest) {
        _apiRequest = [ICXRequest request];
    }
    return _apiRequest;
}

@end
