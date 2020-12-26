//
//  CpsRequest.h
//  YBSDK
//
//  Created by ethan on 2020/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYMJADCpsRequest : NSObject

/**
 记录id
 */
@property (nonatomic,copy) NSString *recordId;

/**
 价格
 */
@property (nonatomic,copy) NSString *price;

/**
 数量
 */
@property (nonatomic,copy) NSString *num;

/**
 名字
 */
@property (nonatomic,copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
