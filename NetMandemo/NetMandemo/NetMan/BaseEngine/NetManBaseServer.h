//
//  NetManBaseServer.h
//  CQNetFrame
//
//  Created by Arthur's on 2019/8/18.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetManConfig.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  这里是
 */
typedef NS_ENUM(NSUInteger,EnvironmentType) {
    EnvironmentTypeDevelop,
    EnvironmentTypePreRelease,
    EnvironmentTypeRelease,
};


@interface NetManBaseServer : NSObject

//服务器类型
@property (nonatomic, assign) EnvironmentType environmentType;

@property (nonatomic, strong) NSString *developApiBaseUrl;
@property (nonatomic, strong) NSString *prereleaseApiBaseUrl;
@property (nonatomic, strong) NSString *releaseApiBaseUrl;

@property (nonatomic, strong, readonly) NSString *publicKey;
@property (nonatomic, strong, readonly) NSString *privateKey;
@property (nonatomic, strong, readonly) NSString *apiBaseUrl;

@end

NS_ASSUME_NONNULL_END
