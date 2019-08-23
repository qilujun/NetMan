//
//  NetManManger.m
//  CQNetFrame
//
//  Created by CoderQi on 2019/8/15.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import "NetManManager.h"
#import "NetManBaseRequestModel.h"
#import "AFURLSessionManager.h"
#import "NetManRequestGenerator.h"

@interface NetManManager ()

//AFNetworking stuff
@property (nonatomic, strong) AFURLSessionManager *sessionManager;
// 根据 requestid，存放 task
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestId;
// 根据 requestID，存放 requestModel
@property (nonatomic, strong) NSMutableDictionary *requestModelDict;

@end

@implementation NetManManager

+(instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    static NetManManager *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetManManager alloc] init];
    });
    return sharedInstance;
}

/**
 *  取消网络请求
 */
-(void)cancelRequestWithRequestID:(NSNumber *)requestID
{
    NSURLSessionDataTask *task = [self.dispatchTable objectForKey:requestID];
    [task cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

/**
 *  根据dataModel发起网络请求，并根据dataModel发起回调
 *
 *
 *  @return 网络请求task哈希值
 */
- (NSNumber *)callRequestWithRequestModel:(NetManBaseRequestModel *)requestModel{
    NSURLRequest *request = [[NetManRequestGenerator defaultGenerator] generateWithRequestDataModel:requestModel];
    typeof(self) __weak weakSelf = self;
    AFURLSessionManager *sessionManager = self.sessionManager;
    NSURLSessionDataTask *task = [sessionManager
                                  dataTaskWithRequest:request
                                  uploadProgress:requestModel.uploadProgressBlock
                                  downloadProgress:requestModel.downloadProgressBlock
                                  completionHandler:^(NSURLResponse * _Nonnull response,
                                                      id  _Nullable responseObject,
                                                      NSError * _Nullable error)
                                  {
                                      if (task.state == NSURLSessionTaskStateCanceling) {
                                          // 如果这个operation是被cancel的，那就不用处理回调了。
                                      } else {
                                          NSNumber *requestID = [NSNumber numberWithUnsignedInteger:task.hash];
                                          [weakSelf.dispatchTable removeObjectForKey:requestID];
                                          
                                          requestModel.responseBlock(responseObject, error);
                                          //在这里进行错误的框架处理，提供一些错误的常规处理
                                          //错误解析并处理完成后通过调用requestModel.responseBlock进行回调
//
                                      }
                                  }];
    [task resume];
    NSNumber *requestID = [NSNumber numberWithUnsignedInteger:task.hash];
    [self.dispatchTable setObject:task forKey:requestID];
    return requestID;
}


-(void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList
{
    typeof(self) __weak weakSelf = self;
    [requestIDList enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSURLSessionDataTask *task = [weakSelf.dispatchTable objectForKey:obj];
        [task cancel];
    }];
    [self.dispatchTable removeObjectsForKeys:requestIDList];
}


//设置URL缓存
#pragma mark ---这里利用的是AFN的URL缓存机制进行的缓存，需要重写，在AFN的基础上加一个处理，如果是服务器请求失败的消息也是会进行缓存的，这个时候需要判断下，如果是Error的请求，就不进行缓存了, 缓存机制要进行设置，是缓存在内存还是缓存在硬盘，
- (AFURLSessionManager *)getCommonSessionManager
{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForResource = 20;
    
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    return sessionManager;
}

#pragma mark - getters and setters
- (AFURLSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [self getCommonSessionManager];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _sessionManager;
}
- (NSMutableDictionary *)dispatchTable{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}


@end
