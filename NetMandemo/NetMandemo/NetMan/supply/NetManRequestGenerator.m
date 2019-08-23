//
//  NetManRequestGenerator.m
//  CQNetFrame
//
//  Created by Arthur's on 2019/8/18.
//  Copyright © 2019 Arthur's. All rights reserved.
//

#import "NetManRequestGenerator.h"
#import "AFURLRequestSerialization.h"
#import "NetManGenerator.h"
#import "NSString+NetMan.h"
#import "NetManBaseRequestModel.h"
#import "NetManBaseServer.h"

static NSTimeInterval kNetManTimeoutSeconds = 20.0f;

@interface NetManRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation NetManRequestGenerator

/**
 *  生成一个单例
 */
+ (instancetype)defaultGenerator{
    static dispatch_once_t onceToken;
    static NetManRequestGenerator *generator = nil;
    dispatch_once(&onceToken, ^{
        generator = [[NetManRequestGenerator alloc] init];
    });
    return generator;
}


- (NSURLRequest *)generateWithRequestDataModel:(NetManBaseRequestModel *)dataModel
{
    //这里用多肽，动态获取
    NetManBaseServer *server;
    if(dataModel.netManServerDelegate){
        server = dataModel.netManServerDelegate;
    }else{
        server = [[NetManBaseServer alloc] init];
    }
    BOOL baseUrlIsError = NO;
    if(![self isCorrectPreUrl:dataModel.netManServerDelegate.developApiBaseUrl]){
        baseUrlIsError = YES;
    }
    if(![self isCorrectPreUrl:dataModel.netManServerDelegate.prereleaseApiBaseUrl]){
        baseUrlIsError = YES;
    }
    if(![self isCorrectPreUrl:dataModel.netManServerDelegate.releaseApiBaseUrl]){
        baseUrlIsError = YES;
    }
    if(baseUrlIsError){
        NSAssert(NO,@"BaseServer子类的BaseUrl存在不合法数值");
    }
    
    server.environmentType = (EnvironmentType)dataModel.serverType;
    NSMutableDictionary *commonParams = [NSMutableDictionary dictionaryWithDictionary:[NetManGenerator generateCommonInfoParamsDictionary]];
    [commonParams addEntriesFromDictionary:dataModel.parameters];
    NSString *privateKey = @"";
    if (![NSString isEmptyString:privateKey]) {
        /**
         *  每个公司的签名方法不同，可以根据自己的设计进行修改，这里是将privateKey放在参数里面，然后将所有的参数和参数名转成字符串进行MD5，将得到的MD5值放进commonParams，上传的时候再讲privateKey从commonParams移除
         */
        //        commonParams[@"private_key"] = service.privateKey;
        //        NSString *signature = [YASignatureGenerator sign:commonParams];
        //        commonParams[@"sign"] = signature;
        //        [commonParams removeObjectForKey:@"private_key"];
    }
    
    NSString *urlString = [self URLStringWithServiceUrl:server.apiBaseUrl path:dataModel.apiMethodPath];
    NSError *error;
    NSMutableURLRequest *request;
    if (dataModel.requestType == NetManRequestTypeGet) {
        request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:commonParams error:&error];
    } else if (dataModel.requestType == NetManRequestTypePost) {
        request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:commonParams error:&error];
    } else if (dataModel.requestType == NetManRequestTypeUpload) {
        request = [self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:commonParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            /**
             *  这里的参数配置也可以根据自己的设计修改默认值.
             为什么没有直接使用NSData?
             */
            if (![NSString isEmptyString:dataModel.dataFileURLPath]) {
                NSURL *fileURL = [NSURL fileURLWithPath:dataModel.dataFileURLPath];
                NSString *name = dataModel.dataName?dataModel.dataName:@"data";
                NSString *fileName = dataModel.fileName?dataModel.fileName:@"data.zip";
                NSString *mimeType = dataModel.mimeType?dataModel.mimeType:@"application/zip";
                NSError *error;
                [formData appendPartWithFileURL:fileURL
                                           name:name
                                       fileName:fileName
                                       mimeType:mimeType
                                          error:&error];
            }
            
        } error:&error];
    }
    if (error || request == nil) {
        return nil;
    }
    
    request.timeoutInterval = kNetManTimeoutSeconds;
    return request;
}
#pragma mark - private methods
- (NSString *)URLStringWithServiceUrl:(NSString *)serviceUrl path:(NSString *)path{
    NSURL *fullURL = [NSURL URLWithString:serviceUrl];
    if (![NSString isEmptyString:path]) {
        fullURL = [NSURL URLWithString:path relativeToURL:fullURL];
    }
    if (fullURL == nil) {
        return nil;
    }
    return [fullURL absoluteString];
}
#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kNetManTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

-(BOOL)isCorrectPreUrl:(NSString *)string{
    NSString *pattern = @"^([hH][tT]{2}[pP]://|[hH][tT]{2}[pP][sS]://)(([A-Za-z0-9-~]+).)+([A-Za-z0-9-~\\/])+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

@end
