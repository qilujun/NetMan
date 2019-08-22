//
//  CQNetManBaseRequestModel.m
//  CQNetFrame
//
//  Created by Arthur's on 2019/7/11.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import "NetManBaseRequestModel.h"

@implementation NetManBaseRequestModel


+(NetManBaseRequestModel *)dataModelWithServerType:(NetManServerType)serverType
                                             APIUrlPath:(NSString *)apiUrl
                                                  param:(NSDictionary *)parameters
                                           dataFilePath:(NSString *)dataFilePath
                                               dataName:(NSString *)dataName
                                               fileName:(NSString *)fileName
                                               mimeType:(NSString *)mimeType
                                            requestType:(NetManRequestType)requestType
                                    uploadProgressBlock:(ProgressBlock)uploadProgressBlock
                                  downloadProgressBlock:(ProgressBlock)downloadProgressBlock
                                               complete:(CompletionHandlerBlock)responseBlock
{
    NetManBaseRequestModel *dataModel = [[NetManBaseRequestModel alloc] init];
    dataModel.serverType = serverType;
    dataModel.apiMethodPath = apiUrl;
    dataModel.parameters = parameters;
    dataModel.dataFileURLPath = dataFilePath;
    dataModel.dataName = dataName;
    dataModel.fileName = fileName;
    dataModel.mimeType = mimeType;
    dataModel.requestType = requestType;
    dataModel.uploadProgressBlock = uploadProgressBlock;
    dataModel.downloadProgressBlock = downloadProgressBlock;
    dataModel.responseBlock = responseBlock;
    return dataModel;
}
@end
