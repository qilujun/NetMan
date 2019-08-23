//
//  CQBaseNetEngine.h
//  CQNetFrame
//
//  Created by Arthur's on 2019/7/11.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetManConfig.h"

@class NetManBaseServer;

NS_ASSUME_NONNULL_BEGIN

@interface NetManBaseNetEngine : NSObject

/**  取消持有的网络请求  **/
-(void)cancelAllRequest;

/**  取消网路请求  */
-(void)cancelRequest;

/**
 * 请求服务器数据响应函数，这里可以对每种请求方式分别提取一个方法，方便上层Engine调用
 *
 * @param control         控制器对象
 * @param server          服务器相关信息
 * @param apiUrl          API路径
 * @param parameters      参数字典
 * @param requestType     网络请求类型
 * @param progressBlock   网络进度回调
 * @param handlerBlock    请求结果数据处理回调
 **/
+(NetManBaseNetEngine *)control:(NSObject *)control
              requestWithServer:(NetManBaseServer *)server
                     APIUrlPath:(NSString *)apiUrl
                          param:(NSDictionary *)parameters
                    requestType:(NetManRequestType)requestType
                  progressBlock:(ProgressBlock)progressBlock
                  completeBlock:(CompletionHandlerBlock)handlerBlock;



/**
* 将文件上传到服务器，这里可以对每种请求方式分别提取一个方法，方便上层Engine调用
*
* @param control                控制器对象
* @param serverType             服务器类型
* @param apiUrl                 API路径
* @param parameters             参数字典
* @param dataFilePath           上传文件路径
* @param dataName               文件名字
* @param fileName               服务器接收名字
* @param mimeType               文件类型
* @param requestType            网络请求类型
* @param uploadProgressBlock    上传进度回调
* @param responseBlock          请求结果数据处理回调
**/
+(NetManBaseNetEngine *)control:(NSObject *)control
     uploadRequestWithServerType:(NetManServerType)serverType
                      serverInfo:(NetManBaseServer *)server
                      APIUrlPath:(NSString *)apiUrl
                           param:(NSDictionary *)parameters
                    dataFilePath:(NSString *)dataFilePath
                        dataName:(NSString *)dataName
                        fileName:(NSString *)fileName
                        mimeType:(NSString *)mimeType
                     requestType:(NetManRequestType)requestType
             uploadProgressBlock:(ProgressBlock)uploadProgressBlock
           downloadProgressBlock:(ProgressBlock)downloadProgressBlock
                   completeBlock:(CompletionHandlerBlock)responseBlock;


/**
 * 从服务器下载文件，这里可以对每种请求方式分别提取一个方法，方便上层Engine调用
 *
 * @param control                控制器对象
 * @param serverType             服务器类型
 * @param apiUrl                 API路径
 * @param parameters             参数字典
 * @param requestType            网络请求类型
 * @param downloadProgressBlock  下载进度回调
 * @param responseBlock          请求结果数据处理回调
 **/

+(NetManBaseNetEngine *)control:(NSObject *)control
  downloadRequestWithServerType:(NetManServerType)serverType
                     serverInfo:(NetManBaseServer *)server
                     APIUrlPath:(NSString *)apiUrl
                          param:(NSDictionary *)parameters
                    requestType:(NetManRequestType)requestType
          downloadProgressBlock:(ProgressBlock)downloadProgressBlock
                  completeBlock:(CompletionHandlerBlock)responseBlock;

@end

NS_ASSUME_NONNULL_END
