//
//  JYMJADCpaResponse.h
//  JYMJAD-SDK
//
//  Created by ethan on 2020/11/18.
//

#import <Foundation/Foundation.h>
#import "BaseResponse.h"


NS_ASSUME_NONNULL_BEGIN

@interface JYMJADCpaResponse : BaseResponse
///// 状态码
//@property (nonatomic,copy) NSString * code;
//
///// 消息描述
//@property (nonatomic,copy) NSString * msg;
//
///// 返回数据
//@property (nonatomic,strong) NSString *data;

/// 状态码
@property (nonatomic,strong) NSString *status;

/// 消息描述
@property (nonatomic,strong) NSString *message;

/// 时间戳
@property (nonatomic,strong) NSString *timestamp;

/// 路径
@property (nonatomic,strong) NSString *path;

/// 错误描述
@property (nonatomic,strong) NSString *erro;
@end

NS_ASSUME_NONNULL_END
