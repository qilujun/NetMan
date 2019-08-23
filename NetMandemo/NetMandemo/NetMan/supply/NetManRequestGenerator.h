//
//  NetManRequestGenerator.h
//  CQNetFrame
//
//  Created by Arthur's on 2019/8/18.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class NetManBaseRequestModel;

@interface NetManRequestGenerator : NSObject

/**
 *  生成一个单例
 *
 */
+ (instancetype)defaultGenerator;

-(NSURLRequest *)generateWithRequestDataModel:(NetManBaseRequestModel *)dataModel;



@end

NS_ASSUME_NONNULL_END
