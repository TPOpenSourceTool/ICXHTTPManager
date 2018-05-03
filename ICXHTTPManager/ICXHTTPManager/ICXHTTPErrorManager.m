//
//  ICXHTTPErrorManager.m
//  MuemHTTPManager
//
//  Created by tangpeng on 2018/1/9.
//Copyright © 2018年 allentang. All rights reserved.
//

#import "ICXHTTPErrorManager.h"
#import "ICXNetworkMarco.h"

@interface ICXHTTPErrorManager()
@property(strong,nonatomic) NSError *error;
@end
@implementation ICXHTTPErrorManager
#pragma mark - init methods

- (instancetype)initWithError:(NSError *)error
{
    self = [super init];
    if (self) {
        self.error = error;
    }
    return self;
}
#pragma mark - system delegate

#pragma mark - custom delegate

#pragma mark - api methods

#pragma mark - event response

#pragma mark - private
- (void)handleErrorMessage{
    switch (self.error.code) {
        case -1001:
            ALog(@"Request Time Out");
            break;

    }
}
#pragma mark - getter / setter
@end
