//
//  ICXRequest.m
//  MuemHTTPManager
//
//  Created by allentang on 2017/12/17.
//  Copyright © 2017年 allentang. All rights reserved.
//

#import "ICXRequest.h"
#import "ICXHTTPKit.h"
#define Request(Type)\
__block NSNumber *requestId = nil;\
NSURLSessionTask *dataTask = [ICXHTTPKit requestBy##Type##WithURLMethod:URL params:params success:^(id responseObject)\
{success ? success(responseObject) : nil;\
[[ICXRequest request].allTasks removeObjectForKey:requestId];\
} failed:fail];\
requestId = @(dataTask.taskIdentifier);\
[ICXRequest request].allTasks[requestId] = dataTask;\
return requestId;
@implementation ICXRequest

+ (instancetype)request{
    static ICXRequest *req = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        req = [[self alloc] init];
    });
    return req;
}

+ (NSNumber *)requestByGetWithURL:(NSString *)URL params:(NSDictionary *)params success:(void (^)(id))success failed:(void (^)(NSError *))fail{
    Request(Get);
}
+ (NSNumber *)requestByPostWithURL:(NSString *)URL params:(NSDictionary *)params success:(void (^)(id))success failed:(void (^)(NSError *))fail{
    Request(Post);
}
+ (NSNumber *)requestByPutWithURL:(NSString *)URL params:(NSDictionary *)params success:(void (^)(id))success failed:(void (^)(NSError *))fail{
    Request(Put);
}
+ (NSNumber *)requestByDeleteWithURL:(NSString *)URL params:(NSDictionary *)params success:(void (^)(id))success failed:(void (^)(NSError *))fail{
    Request(Delete);
}
+ (NSNumber *)uploadFileWithURLMethod:(NSString *)URL images:(NSArray<UIImage *> *)images params:(NSDictionary *)params progress:(void(^)(NSProgress *uploadProgress))progress success:(void (^)(id))success failed:(void (^)(NSError *))fail{
    __block NSNumber *requestId = nil;
    NSURLSessionTask *dataTask = [ICXHTTPKit uploadFileWithURLMethod:URL images:images params:params progress:^(NSProgress *uploadProgress) {
        progress ? progress(uploadProgress) : nil;
    } success:^(id responseObject) {
        success ? success(responseObject) : nil;
        [[ICXRequest request].allTasks removeObjectForKey:requestId];
    }failed:^(NSError *error) {
        fail ? fail(error) : nil;
    }];
    requestId = @(dataTask.taskIdentifier);
    [ICXRequest request].allTasks[requestId] = dataTask;
    return requestId;
}

#pragma mark - private

- (void)cancelAllTasks{
    if (self.allTasks) {
        [self.allTasks enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSURLSessionTask *dataTask = obj;
            [dataTask cancel];
            ALog(@"already cancel all tasks");
        }];
    }
}
- (void)cancelTaskWithRequestId:(NSNumber *)requestId{
    if (self.allTasks[requestId]) {
        NSURLSessionTask *dataTask = self.allTasks[requestId];
        [dataTask cancel];
        ALog(@"cancel task %@",requestId);
    }
}
#pragma mark - getter

- (NSMutableDictionary *)allTasks{
    if (!_allTasks) {
        _allTasks = [[NSMutableDictionary alloc] init];
    }
    return _allTasks;
}
@end
