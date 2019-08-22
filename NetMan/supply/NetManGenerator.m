//
//  NetManGenerator.m
//  CQNetFrame
//
//  Created by Arthur's on 2019/8/18.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import "NetManGenerator.h"
#import <CommonCrypto/CommonDigest.h>
#import "NetManAppContext.h"
#import "NSString+NetMan.h"

@implementation NetManGenerator

+ (NSString *)generateParamsSignature:(NSDictionary *)paramsDict {
    NSString *result;
    NSArray *sortedKeys = [[paramsDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *sortedValues = [NSMutableArray array];
    for (NSString *key in sortedKeys) {
        [sortedValues addObject:key];
    }
    NSString *inputString;
    for (int i = 0; i < [sortedValues count]; i++) {
        if (i == 0) {
            inputString = [NSString stringWithFormat:@"%@=%@", [sortedValues objectAtIndex:i], [paramsDict valueForKey:[sortedValues objectAtIndex:i]]];
        } else {
            inputString = [inputString stringByAppendingString:[NSString stringWithFormat:@"&%@=%@", [sortedValues objectAtIndex:i], [paramsDict valueForKey:[sortedValues objectAtIndex:i]]]];
        }
    }
    
    result = [self md5:inputString];
    
    return result;
}


+ (NSString *)generateParamsSignature:(NSDictionary *)paramsDict publicKey:(NSString *)publicKey{
    NSString *result;
    NSString *inputString = [self generateParamsSignature:paramsDict];
    //先对参数加密，之后将加密的结果和公钥进行加密
    inputString = [inputString stringByAppendingString:[NSString stringWithFormat:@"&%@", publicKey]];
    
    result = [self md5:inputString];
    
    return result;
}


+ (NSString *)md5:(NSString *)input {
    const char *cStr = [[input dataUsingEncoding:NSUTF8StringEncoding] bytes];
    
    unsigned char digest[16];
    CC_MD5(cStr, (uint32_t)[[input dataUsingEncoding:NSUTF8StringEncoding] length], digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+(NSDictionary *)generateCommonInfoParamsDictionary{
    NetManAppContext *context = [NetManAppContext defaultContext];
    
    NSMutableDictionary *commonParams = [@{
                                           @"device_id":context.device_id,
                                           @"channel":context.channelID,
                                           @"os_version":context.os_version,
                                           @"api_version":context.bundle_version,
                                           @"app_client_id":context.app_client_id,
                                           @"device_model":context.device_model,
                                           @"time":context.qtime
                                           } mutableCopy];
    
    if (![NSString isEmptyString:context.user_id]) {
        commonParams[@"uid"] = context.user_id;
    }
    return commonParams;
}

@end
