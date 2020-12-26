//
//  BaseResponse.m
//  JYMJAD-SDK
//
//  Created by ethan on 2020/11/18.
//

#import "BaseResponse.h"

@implementation BaseResponse

//将字典转成当前对象
- (void)convert:(NSDictionary*)dataSource
{
    for (NSString *key in [dataSource allKeys]) {
        if ([[self propertyKeys] containsObject:key]) {
            id propertyValue = [dataSource valueForKey:key];
            if (![propertyValue isKindOfClass:[NSNull class]]
                && propertyValue != nil) {
                [self setValue:propertyValue
                        forKey:key];
            }
        }
    }
}
//将对象转成字典
-(NSDictionary*)changeToDic{
    NSMutableDictionary*mDic = [NSMutableDictionary dictionary];
    for (NSString*key in [self propertyKeys]) {

        [mDic setValue:[self valueForKey:key] forKey:key];
    }
    return mDic;
}
//获取属性列表
- (NSArray*)propertyKeys
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableArray *propertys = [NSMutableArray arrayWithCapacity:outCount];
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [propertys addObject:propertyName];
    }
    free(properties);
    return propertys;
}

@end
