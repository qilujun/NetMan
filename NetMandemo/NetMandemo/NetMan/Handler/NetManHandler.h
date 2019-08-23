//
//  CQNetManHandler.h
//  CQNetFrame
//
//  Created by Arthur's on 2019/7/11.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class NetManBaseRequestModel;

/**
 * Handler负责与网络请求的底层的沟通。包含了网络请求的计算记录、发起、回调处理。
 **/
@interface NetManHandler : NSObject

/**
 *  根据dataModel发起网络请求，并根据dataModel发起回调
 *
 * @param requestModel 网络请求的封装Model
 *
 *  @return 网络请求task哈希值
 */
- (NSNumber *)callRequestWithRequestModel:(NetManBaseRequestModel *)requestModel;



/**
 * 取消网络请求
 * @param requestID     网络请求标记ID
 */
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
