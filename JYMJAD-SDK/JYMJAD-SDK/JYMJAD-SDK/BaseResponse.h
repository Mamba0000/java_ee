//
//  BaseResponse.h
//  JYMJAD-SDK
//
//  Created by ethan on 2020/11/18.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseResponse : NSObject

//将字典转成当前对象
- (void)convert:(NSDictionary*)dataSource;

//将对象转成字典
-(NSDictionary*)changeToDic;

//获取属性列表
- (NSArray*)propertyKeys;

@end

NS_ASSUME_NONNULL_END
