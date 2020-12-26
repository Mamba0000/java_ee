//
//  KeyChainStore.h
//  JYMJAD-SDK
//
//  Created by ethan on 2020/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyChainStore : NSObject

+ (void)save:(NSString*)service data:(id)data;
+ (id)load:(NSString*)service;
+ (void)deleteKeyData:(NSString*)service;

@end

NS_ASSUME_NONNULL_END
