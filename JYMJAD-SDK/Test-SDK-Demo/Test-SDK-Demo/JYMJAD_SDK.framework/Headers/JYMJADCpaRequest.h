//
//  CpaRequest.h
//  YBSDK
//
//  Created by ethan on 2020/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYMJADCpaRequest : NSObject
/**
   记录id
 */
@property (nonatomic,copy) NSString *recordId;

/**
 名字
 */
@property (nonatomic,copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
