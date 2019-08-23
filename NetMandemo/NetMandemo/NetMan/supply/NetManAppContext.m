//
//  NetManAppInfoContext.m
//  CQNetFrame
//
//  Created by Arthur's on 2019/8/18.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import "NetManAppContext.h"
#import "AFNetworkReachabilityManager.h"
#import "UIDevice+NetMan.h"

@implementation NetManAppContext

-(void)dealloc{
}

- (NSString *)user_id {
   //这里需要关联用户id，想法做到可以通用
    _user_id = @"loginUser.userID";
    return _user_id;
}

-(NSString *)qtime
{
    NSString *time = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    return time;
}

-(BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

+(instancetype)defaultContext
{
    static NetManAppContext *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetManAppContext alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        #pragma mark ---这里做为演示，需要额外再添加
        self.appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
        self.channelID = @"App Store";
        _device_id = @"[OpenUDID value]";
        _os_name = [[UIDevice currentDevice] systemName];
        _os_version = [[UIDevice currentDevice] systemVersion];
        _bundle_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        _app_client_id = @"1";
        _device_model = [[UIDevice currentDevice] platform];
        _device_name = [[UIDevice currentDevice] name];
        
    }
    return self;
}

- (void)logoutAction
{
    _user_id = nil;
}

@end
