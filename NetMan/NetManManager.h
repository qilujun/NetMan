//
//  NetManManger.h
//  CQNetFrame
//
//  Created by CoderQi on 2019/8/15.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetManBaseServer.h"

NS_ASSUME_NONNULL_BEGIN

@class NetManBaseRequestModel;

/**
 * Manager 负责计算request, 发起请求。 做出回调，封装底层的接口
 */
@interface NetManManager : NSObject

+(instancetype)defaultManager;

/**
 *  根据dataModel发起网络请求，并根据dataModel发起回调
 *  @return 网络请求task哈希值(目前先返回哈希值，比较稳妥的是返回内存地址)
 */
-(NSNumber *)callRequestWithRequestModel:(NetManBaseRequestModel *)requestModel;

/**
 *  取消网络请求
 */
-(void)cancelRequestWithRequestID:(NSNumber *)requestID;

-(void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList;

@end

NS_ASSUME_NONNULL_END
