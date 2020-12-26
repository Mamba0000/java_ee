//
//  YBSDK.h
//  YBSDK
//
//  Created by ethan on 2020/11/9.
//

#import <Foundation/Foundation.h>
#import "JYMJADAdRequest.h"
#import "JYMJADCpcRequest.h"
#import "JYMJADCpsRequest.h"
#import "JYMJADCpaRequest.h"
#import "JYMJADCpmRequest.h"
#import "JYMJADEndRequest.h"

#import "JYMJADAdResponse.h"
#import "JYMJADCpcResponse.h"
#import "JYMJADCpsResponse.h"
#import "JYMJADCpaResponse.h"
#import "JYMJADCpmResponse.h"
#import "JYMJADEndResponse.h"


typedef void (^SuccessBlock)(NSDictionary *data);

typedef void (^SuccessBlockOfAdRequest)(JYMJADAdResponse *data);
typedef void (^SuccessBlockOfCpcRequest)(JYMJADCpcResponse *data);
typedef void (^SuccessBlockOfCpsRequest)(JYMJADCpsResponse *data);
typedef void (^SuccessBlockOfCpaRequest)(JYMJADCpaResponse *data);
typedef void (^SuccessBlockOfCpmRequest)(JYMJADCpmResponse *data);
typedef void (^SuccessBlockOfADEndRequest)(JYMJADEndResponse *data);

typedef void (^FailureBlock)(NSError *error);

@interface JYMJADYBSDK : NSObject

/// 请求地址
@property (nonatomic,copy) NSString *url;

/// 是否显示日志
@property (nonatomic, assign) Boolean showlog;



/// 实例化对象
/// @param showlog 是否显示日志
+ (JYMJADYBSDK *) build:(Boolean) showlog ;


/// 获取广告信息（包含cpm,pct统计）
/// @param parameters 请求对象
/// @param successBlock 成功回调
/// @param failureBlock 失败回调
- (void)getAd       :(JYMJADAdRequest  *)parameters success:(SuccessBlockOfAdRequest)successBlock failure:(FailureBlock)failureBlock;



/// cpc回调
/// @param parameters 请求对象
/// @param successBlock 成功回调
/// @param failureBlock 失败回调
- (void)cpcCallBack:(JYMJADCpcRequest  *)parameters success:(SuccessBlockOfCpcRequest)successBlock failure:(FailureBlock)failureBlock;


/// cps回调
/// @param parameters 请求对象
/// @param successBlock 成功回调
/// @param failureBlock 失败回调
- (void)cpsCallBack:(JYMJADCpsRequest  *)parameters success:(SuccessBlockOfCpsRequest)successBlock failure:(FailureBlock)failureBlock;

/// cpa回调
/// @param parameters 请求对象
/// @param successBlock 成功回调
/// @param failureBlock 失败回调
- (void)cpaCallBack:(JYMJADCpaRequest  *)parameters success:(SuccessBlockOfCpaRequest)successBlock failure:(FailureBlock)failureBlock;


/// cpm回调
/// @param parameters 请求对象
/// @param successBlock 成功回调
/// @param failureBlock 失败回调
- (void)cpmCallBack:(JYMJADCpmRequest  *)parameters success:(SuccessBlockOfCpmRequest)successBlock failure:(FailureBlock)failureBlock;

/// end回调
/// @param parameters 请求对象
/// @param successBlock 成功回调
/// @param failureBlock 失败回调
- (void)endCallBack:(JYMJADEndRequest  *)parameters success:(SuccessBlockOfADEndRequest)successBlock failure:(FailureBlock)failureBlock;

@end
