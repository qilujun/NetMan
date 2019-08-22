//
//  NSObject+NMNetWorkingAutoCancle.h
//  CQNetFrame
//
//  Created by CoderQi on 2019/8/15.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetManAutoCancelHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NMNetWorkingAutoCancel)

@property (nonatomic, strong, readonly) NetManAutoCancelHandler *netManAutoCancelRequests;

@end

NS_ASSUME_NONNULL_END
