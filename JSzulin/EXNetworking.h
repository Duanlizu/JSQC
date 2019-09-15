//
//  EXNetworking.h
//  NetBase
//
//  Created by seer on 2017/6/20.
//  Copyright © 2017年 seer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

#define CT_FORM @"application/x-www-form-urlencoded"

@interface EXNetworking : NSObject

/**
 GET 请求
 
 @param URLString URLString
 @param parameters param
 @param success block
 @parma failure block
 */
+ (void)GET:(NSString *_Nullable)URLString
 parameters:(nullable id)parameters
    success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

/**
 GET 请求
 
 @param URLString URLString
 @param parameters param
 @param dProgress progress
 @param success block
 @parma failure block
 */
+ (void)GET:(NSString *_Nullable)URLString
 parameters:(nullable id)parameters
contentType:(NSString *_Nullable)contentType
   progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))dProgress
    success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;


/**
 POST 请求
 
 @param URLString URLString
 @param parameters param
 @param success block
 @parma failure block
 */
+ (void)POST:(NSString *_Nullable)URLString
  parameters:(nullable id)parameters
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

/**
 POST 请求
 
 @param URLString URLString
 @param parameters param
 @param contentType contentType
 @param success block
 @parma failure block
 */
+ (void)POST:(NSString *_Nullable)URLString
  parameters:(nullable id)parameters
 contentType:(NSString *_Nullable)contentType
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

/**
 POST 请求
 
 @param URLString URLString
 @param parameters param
 @param uProgress upload progress
 @param success block
 @parma failure block
 */
- (void)POST:(NSString *_Nullable)URLString
  parameters:(nullable id)parameters
    progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uProgress
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

//文件上传
+ (void)upload:(NSString *_Nullable)URLString
    parameters:(id _Nullable)parameters
      fileData:(NSArray * _Nullable)dataList
          name:(NSArray * _Nullable)nameList
      fileName:(NSArray * _Nullable)fileNameList
      mimeType:(NSString * _Nullable)mimeType
      progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uProgress
       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

//文件下载
+ (void)download:(NSString * _Nullable)URLString savePath:(NSString * _Nullable)savePath result:(void (^_Nullable) (NSURL * _Nullable filePath, NSError * _Nullable error))dResult;

+ (void)networkReachabilityStatus;

/**
 DELETE 请求
 
 @param URLString URLString
 @param parameters param
 @param success block
 @parma failure block
 */
+ (void)DELETE:(NSString *_Nullable)URLString
    parameters:(id _Nullable)parameters
   contentType:(NSString *_Nullable)contentType
       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

/**
 PUT 请求
 
 @param URLString URLString
 @param parameters param
 @param success block
 @parma failure block
 */
+ (void)PUT:(NSString *_Nullable)URLString
 parameters:(nullable id)parameters
    success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

@end
