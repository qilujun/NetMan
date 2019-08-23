//
//  NSObject+NMNetWorkingAutoCancle.m
//  CQNetFrame
//
//  Created by CoderQi on 2019/8/15.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import "NSObject+NMNetWorkingAutoCancel.h"
#import <objc/runtime.h>

@implementation NSObject (NMNetWorkingAutoCancel)


-(NetManAutoCancelHandler *)netManAutoCancelRequests
{
    
    NetManAutoCancelHandler *requests = objc_getAssociatedObject(self, @selector(netManAutoCancelRequests));
    if (requests == nil) {
        requests = [[NetManAutoCancelHandler alloc]init];
        objc_setAssociatedObject(self, @selector(netManAutoCancelRequests), requests, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return requests;
}


@end
