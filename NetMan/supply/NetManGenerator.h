//
//  NetManGenerator.h
//  CQNetFrame
//
//  Created by Arthur's on 2019/8/18.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *
 * NetMan生成器，负责生成一些固定的产物，如 请求参数的MD5、生成应用基本信息
 *
 */
@interface NetManGenerator : NSObject

+ (NSString *)generateParamsSignature:(NSDictionary *)paramsDict;


+ (NSString *)generateParamsSignature:(NSDictionary *)paramsDict publicKey:(NSString *)publicKey;

+(NSDictionary *)generateCommonInfoParamsDictionary;

@end

NS_ASSUME_NONNULL_END
