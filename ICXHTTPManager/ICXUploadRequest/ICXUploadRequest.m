//
//  ICXUploadRequest.m
//  MuemHTTPManager
//
//  Created by allentang on 2018/1/6.
//  Copyright © 2018年 allentang. All rights reserved.
//

#import "ICXUploadRequest.h"
#import "ICXHTTPErrorManager.h"
@implementation ICXUploadRequest
+ (NSURLSessionTask *)requestWithManager:(AFHTTPSessionManager *)manager images:(NSArray<UIImage *> *)images URL:(NSString *)URLMethod params:(NSDictionary *)params progress:(void(^)(NSProgress *uploadProgress))progress success:(void (^)(id))success failed:(void (^)(NSError *))fail{

    AFHTTPSessionManager *customManager = params[ICXNetworkCustomManager];
    //自定义的manager
    if (customManager) {
        manager = customManager;
    }
    
    NSDictionary *imageInfo = params[ICXNetworkCustomImageInfo];
    if ([imageInfo allKeys].count == 0) {
        ALog(@"null image info")
        return nil;
    }
    
    NSDictionary *header = params[ICXNetworkCustomHeader];
    //自定义header
    if (header && [header allKeys].count != 0) {
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    //是否需要debug打印
    __block BOOL debugMode = [params[ICXNetworkDebugMode] boolValue];
    
    //图片压缩率
    __block CGFloat radio = [params[ICXNetworkImageRadio] floatValue];
    
    id param = params[ICXNetworkParams];
    return [manager POST:URLMethod parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *imageData = nil;
            if ([imageInfo[FileType] isEqualToString:@"png"] || [imageInfo[FileType] isEqualToString:@"PNG"]) {
                imageData = UIImagePNGRepresentation(obj);
            }else{
                imageData = UIImageJPEGRepresentation(obj, (radio <= 0 || radio > 1) ? 1 : radio);
            }
            [formData appendPartWithFileData:imageData name:imageInfo[FileName] fileName:imageInfo[FileType] mimeType:imageInfo[MimeType]];
        }];
    } progress:^(NSProgress *uploadProgress){
        progress ? progress(uploadProgress) : nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success ? success(responseObject) : nil;
        if (debugMode) {
            ALog(@"success : %@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (debugMode) {
            ALog(@"fail : %@",error.description);
        }
        fail ? fail(error) : nil;
    }];
}
@end
