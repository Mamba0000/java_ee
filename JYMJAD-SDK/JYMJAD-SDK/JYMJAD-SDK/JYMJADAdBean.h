//
//  AdBean.h
//  YBSDK
//
//  Created by ethan on 2020/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYMJADAdBean : NSObject

@property (nonatomic,copy) NSString * ideaId;
@property (nonatomic,copy) NSString * ideaName;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString *positionType;
@property (nonatomic,copy) NSString *pictureUrl1;
@property (nonatomic,copy) NSString *pictureUrl2;
@property (nonatomic,copy) NSString * pictureUrl3;
@property (nonatomic,copy) NSString * ideaUser;
@property (nonatomic,copy) NSString * bid;
@property (nonatomic,copy) NSString * landPage;
@property (nonatomic,copy) NSString * recordId;

@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * name;


@end

NS_ASSUME_NONNULL_END
