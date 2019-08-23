//
//  UIDevice+NetMan.h
//  CQNetFrame
//
//  Created by Arthur's on 2019/8/18.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (NetMan)

- (NSString *)platform;
-(NSString *)corerespondVersion;

@end

NS_ASSUME_NONNULL_END
