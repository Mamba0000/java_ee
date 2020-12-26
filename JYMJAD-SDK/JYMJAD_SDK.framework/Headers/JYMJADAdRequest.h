//
//  AdRequest.h
//  YBSDK
//
//  Created by ethan on 2020/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYMJADAdRequest : NSObject


/// 广告id
@property (nonatomic,copy) NSString *adId;

@property (nonatomic,copy) NSString *deviceImei;

@property (nonatomic,copy) NSString *deviceModel;


@end

NS_ASSUME_NONNULL_END
