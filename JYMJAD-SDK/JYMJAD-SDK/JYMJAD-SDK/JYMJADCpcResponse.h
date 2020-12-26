//
//  JYMJADCpcResponse.h
//  JYMJAD-SDK
//
//  Created by ethan on 2020/11/18.
//

#import <Foundation/Foundation.h>
#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYMJADCpcResponse : BaseResponse


/// 状态码
@property (nonatomic,copy) NSString * code;

/// 消息
@property (nonatomic,copy) NSString * msg;

/// 数据
@property (nonatomic,strong) NSString *data;

@end

NS_ASSUME_NONNULL_END
