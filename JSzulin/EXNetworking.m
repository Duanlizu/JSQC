//
//  EXNetworking.m
//  NetBase
//
//  Created by seer on 2017/6/20.
//  Copyright © 2017年 seer. All rights reserved.
//

#import "EXNetworking.h"

@implementation EXNetworking

#pragma mark - GET method
+ (void)GET:(NSString *_Nullable)URLString
 parameters:(nullable id)parameters
    success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    
    [self GET:URLString
   parameters:parameters
  contentType:nil
     progress:^(NSProgress * _Nullable downloadProgress) {
         
     }
      success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
          
          if (success) {
              
              success(task, responseObject);
          }
      }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
          
          if(error.code == -1009) {
              
//              [ProgressHUD showAlert:@"似乎已断开与互联网的连接。"];
          }
          
          if (failure) {
              
              failure(task, error);
          }
      }];
}

+ (void)GET:(NSString *_Nullable)URLString
 parameters:(nullable id)parameters
contentType:(NSString *_Nullable)contentType
   progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))dProgress
    success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    if (contentType) {
        
        sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [sessionManager.requestSerializer setValue:contentType forHTTPHeaderField:@"Content-Type"];
    }
    else {//默认
        
        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    sessionManager.requestSerializer.timeoutInterval = 300;
    
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", @"text/json", nil];
    
    [sessionManager GET:URLString
             parameters:parameters
               progress:^(NSProgress * _Nonnull downloadProgress)
     {
         if (dProgress) {
             
             dProgress(downloadProgress);
         }
     }
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (success) {
             
             success(task, responseObject);
         }
     }
                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         if (failure) {
             
             failure(task, error);
         }
     }];
}

#pragma mark - POST method
+ (void)POST:(NSString *_Nullable)URLString
  parameters:(nullable id)parameters
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];

    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];

    sessionManager.requestSerializer.timeoutInterval = 300;
    
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", @"text/json", nil];
    
    [sessionManager POST:URLString
              parameters:parameters
                progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    if (success) {
                        
                        success(task, responseObject);
                    }
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    if (failure) {
                        
                        failure(task, error);
                    }
                }];
}

+ (void)POST:(NSString *_Nullable)URLString
  parameters:(nullable id)parameters
 contentType:(NSString *_Nullable)contentType
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
//
    if (contentType) {

        sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [sessionManager.requestSerializer setValue:contentType forHTTPHeaderField:@"Content-Type"];
    }
    else {//默认

        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
//
    sessionManager.requestSerializer.timeoutInterval = 300;
    
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", @"text/json", nil];
    
    [sessionManager POST:URLString
              parameters:parameters
                progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    if (success) {
                        
                        success(task, responseObject);
                    }
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    if (failure) {
                        
                        failure(task, error);
                    }
                }];
}

- (void)POST:(NSString *_Nullable)URLString
  parameters:(nullable id)parameters
    progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uProgress
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    
    [[AFHTTPSessionManager manager] POST:URLString
                              parameters:parameters
                                progress:^(NSProgress * _Nonnull uploadProgress)
     {
         if (uProgress) {
             
             uProgress(uploadProgress);
         }
     }
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if (success) {
             
             success(task, responseObject);
         }
     }
                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         if (failure) {
             
             failure(task, error);
         }
     }];
}

#pragma mark - upload method
+ (void)upload:(NSString *_Nullable)URLString
    parameters:(id _Nullable)parameters
      fileData:(NSArray * _Nullable)dataList
          name:(NSArray * _Nullable)nameList
      fileName:(NSArray * _Nullable)fileNameList
      mimeType:(NSString * _Nullable)mimeType
      progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uProgress
       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];//[AFHTTPRequestSerializer serializer];
    sessionManager.requestSerializer.timeoutInterval = 300;
    [sessionManager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [sessionManager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < fileNameList.count; i++)
        [formData appendPartWithFileData:dataList[i] name:@"files" fileName:fileNameList[i] mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (uProgress) { uProgress(uploadProgress); }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) { success(task, responseObject); }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) { failure(task, error); }
        
    }];
    
}

#pragma mark - download method
+ (void)download:(NSString *)URLString savePath:(NSString *)savePath result:(void (^)(NSURL * _Nullable, NSError * _Nullable))dResult {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath]) {
        
        if (dResult) {
            
            dResult([NSURL fileURLWithPath:savePath], NULL);
        }
        return;
    }
    
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:url];
    
    [[[AFHTTPSessionManager manager] downloadTaskWithRequest:URLRequest
                                                    progress:^(NSProgress * _Nonnull downloadProgress) {
                                                        
                                                    }
                                                 destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                     
                                                     return [NSURL fileURLWithPath:savePath];
                                                 }
                                           completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                               
                                               NSLog(@"--download:completionHandler:%@", filePath);
                                               if (dResult) {
                                                   
                                                   dResult(filePath, error);
                                               }
                                               
                                           }] resume];
}

#pragma mark - 检测网络状态
+ (void)networkReachabilityStatus {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SHX_NET_ERR" object:nil];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"SHX_NET_OK" object:nil];
                break;
            default:
                break;
        }
        
    }];
    
    [manager startMonitoring];
}

+ (void)DELETE:(NSString *_Nullable)URLString
    parameters:(id _Nullable)parameters
   contentType:(NSString *_Nullable)contentType
       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    
    if (contentType) { //json
        
        AFURLSessionManager *URLSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:nil];
        URLSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]];
        [mutableRequest setHTTPMethod:@"DELETE"];
        [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSError *error;
        [mutableRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error]];
        
        [[URLSessionManager dataTaskWithRequest:mutableRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (success) {
                
                success(nil,responseObject);
            }
            
        }] resume];
        
        return;
    }
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.requestSerializer.timeoutInterval = 300;
    
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", @"text/json", nil];
    
    [sessionManager DELETE:URLString
                parameters:parameters
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                       
                       if (success) {
                           
                           success(task, responseObject);
                       }
                       
                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                       
                       if (failure) {
                           
                           failure(task, error);
                       }
                   }];
}

+ (void)PUT:(NSString *_Nullable)URLString
 parameters:(nullable id)parameters
    success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.requestSerializer.timeoutInterval = 300;
    
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", @"text/json", nil];
    
    [sessionManager PUT:URLString
             parameters:parameters
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    if (success) {
                        
                        success(task, responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    if (failure) {
                        
                        failure(task, error);
                    }
                }];
}

@end
