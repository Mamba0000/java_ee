//
//  JYMJADCpsResponse.h
//  JYMJAD-SDK
//
//  Created by ethan on 2020/11/18.
//

#import <Foundation/Foundation.h>
#import "BaseResponse.h"
#import "JYMJADAdBean.h"


NS_ASSUME_NONNULL_BEGIN

@interface JYMJADCpsResponse : BaseResponse

/// 状态码
@property (nonatomic,copy) NSString * code;

/// 消息
@property (nonatomic,copy) NSString * msg;

/// 数据
@property (nonatomic,strong) JYMJADAdBean *data;

@end

NS_ASSUME_NONNULL_END
