//
//  JYMJADAdResponse.h
//  JYMJAD-SDK
//
//  Created by ethan on 2020/11/18.
//

#import <Foundation/Foundation.h>
#import "JYMJADAdBean.h"
#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYMJADAdResponse : BaseResponse
/// 状态码
@property (nonatomic,copy) NSString * code;

/// 描述信息
@property (nonatomic,copy) NSString * msg;

/// 数据
@property (nonatomic,strong) JYMJADAdBean *data;

@end

NS_ASSUME_NONNULL_END
