//
//  NetManAutoCancelHandler.h
//  CQNetFrame
//
//  Created by CoderQi on 2019/8/15.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NetManBaseNetEngine;

NS_ASSUME_NONNULL_BEGIN

@interface NetManAutoCancelHandler : NSObject

-(void)setEngine:(NetManBaseNetEngine *)engine requestID:(NSNumber *)requestID;

-(void)removeEngineWithRequestID:(NSNumber *)requestID;

@end

NS_ASSUME_NONNULL_END
