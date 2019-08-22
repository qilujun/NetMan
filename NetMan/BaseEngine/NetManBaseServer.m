//
//  NetManBaseServer.m
//  CQNetFrame
//
//  Created by Arthur's on 2019/8/18.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import "NetManBaseServer.h"

@interface NetManBaseServer ()

//@property (nonatomic, weak) NetManBaseServer *child;
@property (nonatomic, strong) NSString *customApiBaseUrl;

@end

@implementation NetManBaseServer

@synthesize privateKey = _privateKey;
@synthesize apiBaseUrl = _apiBaseUrl;

- (instancetype)init
{
    self = [super init];
    if (self) {        //默认设置开发环境
        self.environmentType = EnvironmentTypeDevelop;
    }
    return self;
}

- (NSString *)privateKey
{
    if (!_privateKey) {
        _privateKey = @"Hey NetMan";
    }
    return _privateKey;
}

- (NSString *)apiBaseUrl
{
    if (_apiBaseUrl == nil) {
        switch (self.environmentType) {
            case EnvironmentTypeDevelop:
                _apiBaseUrl = self.developApiBaseUrl;
                break;
            case EnvironmentTypePreRelease:
                _apiBaseUrl = self.prereleaseApiBaseUrl;
                break;
            case EnvironmentTypeRelease:
                _apiBaseUrl = self.releaseApiBaseUrl;
                break;
            default:
                break;
        }
    }
    return _apiBaseUrl;
}

@synthesize developApiBaseUrl = _developApiBaseUrl;

@synthesize prereleaseApiBaseUrl = _prereleaseApiBaseUrl;

@synthesize releaseApiBaseUrl = _releaseApiBaseUrl;

@end
