//
//  NetManConfig.h
//  CQNetFrame
//
//  Created by Arthur's on 2019/7/11.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#ifndef NetManConfig_h
#define NetManConfig_h

typedef NS_ENUM(NSUInteger, NetManServerType) {
    NetManServerTypeDevelop,                  //测试服务器
    NetManServerTypePrepareRelease,         //发版前服务器
    NetManServerTypeRelease,                //正式服务器
    
};

//网络请求类型
typedef NS_ENUM(NSInteger, NetManRequestType){
    NetManRequestTypeGet,       //get请求
    NetManRequestTypePost,      //post请求
    NetManRequestTypeUpload,    //上传文件
    NetManRequestTypeDownload   //下载文件
};

typedef void(^ProgressBlock)(NSProgress *taskProgress);
typedef void(^CompletionHandlerBlock)(id data, NSError *error);

#endif /* NetManConfig_h */
