//
//  NetManAutoCancelHandler.m
//  CQNetFrame
//
//  Created by CoderQi on 2019/8/15.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import "NetManAutoCancelHandler.h"
#import "NetManBaseNetEngine.h"

@interface NetManAutoCancelHandler()

/** requestEngines 将网络请求和编号绑定在一起存放，并且一起绑定到NSObject上，在requestEngines释放的时候，根据request取消没有返回的网络请求*/
@property (nonatomic, strong) NSMutableDictionary<NSNumber *,NetManBaseNetEngine *> *requestEngines;

@end


@implementation NetManAutoCancelHandler

-(void)dealloc{
    //在释放的时候，根据request取消没有返回的网络请求
    [self.requestEngines enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NetManBaseNetEngine * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj cancelRequest];
    }];
    [self.requestEngines removeAllObjects];
    self.requestEngines = nil;
}

-(NSMutableDictionary *)requestEngines
{
    if (_requestEngines == nil) {
        _requestEngines = [[NSMutableDictionary alloc] init];
    }
    return _requestEngines;
}

-(void)setEngine:(NetManBaseNetEngine *)engine requestID:(NSNumber *)requestID
{
    if (engine && requestID) {
        self.requestEngines[requestID] = engine;
    }
}

-(void)removeEngineWithRequestID:(NSNumber *)requestID
{
    if (requestID) {
        [self.requestEngines removeObjectForKey:requestID];
    }
}

@end
