//
//  ICXNetworkMarco.h
//  MuemHTTPManager
//
//  Created by allentang on 2017/12/17.
//  Copyright © 2017年 allentang. All rights reserved.
//

#ifndef ICXNetworkMarco_h
#define ICXNetworkMarco_h


#endif /* ICXNetworkMarco_h */
//自定义文件上传信息,"FileName" ,@"FileType", "MimeType","File"
#define FileName @"FileName"
#define FileType @"FileType"
#define MimeType @"MimeType"
//网络状态的宏
#define ICXNETWORKSTATUSUNKOWN @"UNKOWN"
#define ICXNETWORKSTATUSWIFI @"WIFI"
#define ICXNETWORKSTATUSNOTREACH @"NOTREACH"
#define ICXNETWORKSTATUSWWAN @"WWAN"
#define ICXNetworkStatus @"EWNetworkStatus"
//重置自定义信息的宏
#define ICXRESETCSUTOMITEM @"ICXRESETCSUTOMITEM"

//自定义信息key
#define ICXNetworkCustomManager @"ICXNetworkCustomManager"
#define ICXNetworkCustomHeader @"ICXNetworkCustomHeader"
#define ICXNetworkCustomFilter @"ICXNetworkCustomFilter"
#define ICXNetworkCustomImageInfo @"ICXNetworkCustomImageInfo"
#define ICXNetworkParams @"ICXNetworkParams"
#define ICXNetworkDebugMode @"ICXNetworkDebugMode"
#define ICXNetworkImageRadio @"ICXNetworkImageRadio"

#define ALog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] );

typedef NS_ENUM(NSInteger, ICXNormalReqeustType)
{
    ICXNormalReqeustTypeGET,
    ICXNormalReqeustTypePOST,
    ICXNormalReqeustTypeDELETE,
    ICXNormalReqeustTypePUT
};
#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF __strong typeof(self) strongSelf = weakSelf;
