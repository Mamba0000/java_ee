//
//  YBSDK.m
//  YBSDK
//
//  Created by ethan on 2020/11/9.
//

#import "JYMJADYBSDK.h"
#import "XMNetWorkHelper.h"
#import <objc/runtime.h>
#import "KeyChainStore.h"
#import <AdSupport/AdSupport.h>
#import <sys/utsname.h>

/**
 lipo -create /Users/ethan/Library/Developer/Xcode/DerivedData/YBSDK-goqxuigmqkjwbhabxznqyhuhqgft/Build/Products/Release-iphoneos/libYBSDK.a  /Users/ethan/Library/Developer/Xcode/DerivedData/YBSDK-goqxuigmqkjwbhabxznqyhuhqgft/Build/Products/Release-iphonesimulator/libYBSDK.a -output /Users/ethan/Documents/Ethan/IOS-SDK/YBSDK-a/libYBSDK.a
 */

/**
 
 lipo /Users/ethan/Library/Developer/Xcode/DerivedData/YBSDK-goqxuigmqkjwbhabxznqyhuhqgft/Build/Products/Release-iphoneos/libYBSDK.a -remove arm64 -output /Users/ethan/Library/Developer/Xcode/DerivedData/YBSDK-goqxuigmqkjwbhabxznqyhuhqgft/Build/Products/Release-iphoneos/libYBSDK.a 
 
 
 */
/**
 lipo -create /Users/ethan/Library/Developer/Xcode/DerivedData/YBSDK-goqxuigmqkjwbhabxznqyhuhqgft/Build/Products/Release-iphoneos/libYBSDK.a  /Users/ethan/Library/Developer/Xcode/DerivedData/YBSDK-goqxuigmqkjwbhabxznqyhuhqgft/Build/Products/Release-iphonesimulator/libYBSDK.a  -remove arm64 -output /Users/ethan/Documents/test/test/YBSDK/libYBSDK.a
 */


/**
 lipo -create /Users/ethan/Library/Developer/Xcode/DerivedData/JYMJAD-SDK-bsncqlkkgcqmseeqyykaqmhkerqq/Build/Products/Release-iphoneos/JYMJAD_SDK.framework /Users/ethan/Library/Developer/Xcode/DerivedData/JYMJAD-SDK-bsncqlkkgcqmseeqyykaqmhkerqq/Build/Products/Release-iphonesimulator/JYMJAD_SDK.framework
  -output /Users/ethan/Library/Developer/Xcode/DerivedData/JYMJAD-SDK-bsncqlkkgcqmseeqyykaqmhkerqq/Build/Products

 */

/**
 lipo -create /Users/ethan/Library/Developer/Xcode/DerivedData/JYMJAD-SDK-bsncqlkkgcqmseeqyykaqmhkerqq/Build/Products/Release-iphoneos/JYMJAD_SDK.framework/JYMJAD_SDK /Users/ethan/Library/Developer/Xcode/DerivedData/JYMJAD-SDK-bsncqlkkgcqmseeqyykaqmhkerqq/Build/Products/Release-iphonesimulator/JYMJAD_SDK.framework/JYMJAD_SDK.framework/JYMJAD_SDK -output /Users/ethan/Library/Developer/Xcode/DerivedData/JYMJAD-SDK-bsncqlkkgcqmseeqyykaqmhkerqq/Build/Products/a.framework

 */



/**
 
 sudo lipo -create /Users/ethan/Library/Developer/Xcode/DerivedData/JYMJAD-SDK-bsncqlkkgcqmseeqyykaqmhkerqq/Build/Products/Release-iphoneos/JYMJAD_SDK.framework/JYMJAD_SDK /Users/ethan/Library/Developer/Xcode/DerivedData/JYMJAD-SDK-bsncqlkkgcqmseeqyykaqmhkerqq/Build/Products/Release-iphonesimulator/JYMJAD_SDK.framework/JYMJAD_SDK -output /Users/ethan/Library/Developer/Xcode/DerivedData/JYMJAD-SDK-bsncqlkkgcqmseeqyykaqmhkerqq/Build/Products/JYMJAD_SDK
 */


@interface JYMJADYBSDK ()
@end


@implementation JYMJADYBSDK


+ (JYMJADYBSDK *) build:(NSString *)url showlog:(Boolean) showlog {
    JYMJADYBSDK *ybsdk = [[JYMJADYBSDK alloc] init];
    ybsdk.url = url;
    ybsdk.showlog = showlog;
    return ybsdk;
}


+ (JYMJADYBSDK *) build:(Boolean) showlog {
    return [JYMJADYBSDK build:@"http://110.53.163.235:9000/" showlog: showlog];
}


- (void)getAd       :(JYMJADAdRequest  *)parameters success:(SuccessBlockOfAdRequest)successBlock failure:(FailureBlock)failureBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@" , self.url, @"/api/getAdFromIOS"];
    
    if(self.showlog) NSLog(@"%@", url);
    parameters.deviceImei = [self getUUIDByKeyChain];
    parameters.deviceModel = [self platformString];
    
    if(self.showlog) NSLog(@"%@--%@", parameters.deviceImei, parameters.deviceModel);

    [XMNetWorkHelper postWithUrlString:url parameters:[self getObjectData:parameters] success:^(NSDictionary *data) {
        JYMJADAdResponse *response =  [[JYMJADAdResponse alloc] init];
        [response convert:data];
        successBlock(response);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

//获取ios设备号
- (NSString *)platformString {

    //需要导入头文件：
   NSString *padType = @"";
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";

    if ([deviceString isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([deviceString isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([deviceString isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";

    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";

    if ([deviceString isEqualToString:@"iPad1,1"]){
        padType = @"ipad";
        return @"iPad";
    }
    if ([deviceString isEqualToString:@"iPad1,2"]){
        padType = @"ipad";
        return @"iPad 3G";
    }
    if ([deviceString isEqualToString:@"iPad2,1"]){
        padType = @"ipad";
        return @"iPad 2 (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad2,2"]){
        padType = @"ipad";
        return @"iPad 2";
    }
    if ([deviceString isEqualToString:@"iPad2,3"]){
        padType = @"ipad";
        return @"iPad 2 (CDMA)";
    }
    if ([deviceString isEqualToString:@"iPad2,4"]){
        padType = @"ipad";
        return @"iPad 2";
    }
    if ([deviceString isEqualToString:@"iPad2,5"]){
        padType = @"ipad";
        return @"iPad Mini (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad2,6"]){
        padType = @"ipad";
        return @"iPad Mini";
    }
    if ([deviceString isEqualToString:@"iPad2,7"]){
        padType = @"ipad";
        return @"iPad Mini (GSM+CDMA)";
    }
    if ([deviceString isEqualToString:@"iPad3,1"]){
        padType = @"ipad";
        return @"iPad 3 (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad3,2"]){
        padType = @"ipad";
        return @"iPad 3 (GSM+CDMA)";
    }
    if ([deviceString isEqualToString:@"iPad3,3"]){
        padType = @"ipad";
        return @"iPad 3";
    }
    if ([deviceString isEqualToString:@"iPad3,4"]){
        padType = @"ipad";
        return @"iPad 4 (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad3,5"]){
        padType = @"ipad";
        return @"iPad 4";
    }
    if ([deviceString isEqualToString:@"iPad3,6"]){
        padType = @"ipad";
        return @"iPad 4 (GSM+CDMA)";
    }
    if ([deviceString isEqualToString:@"iPad4,1"]){
        padType = @"ipad";
        return @"iPad Air (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad4,2"]){
        padType = @"ipad";
        return @"iPad Air (Cellular)";
    }
    if ([deviceString isEqualToString:@"iPad4,4"]){
        padType = @"ipad";
        return @"iPad Mini 2 (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad4,5"]){
        padType = @"ipad";
        return @"iPad Mini 2 (Cellular)";
    }
    if ([deviceString isEqualToString:@"iPad4,6"]){
        padType = @"ipad";
        return @"iPad Mini 2";
    }
    if ([deviceString isEqualToString:@"iPad4,7"]){
        padType = @"ipad";
        return @"iPad Mini 3";
    }
    if ([deviceString isEqualToString:@"iPad4,8"]){
        padType = @"ipad";
        return @"iPad Mini 3";
    }
    if ([deviceString isEqualToString:@"iPad4,9"]){
        padType = @"ipad";
        return @"iPad Mini 3";
    }
    if ([deviceString isEqualToString:@"iPad5,1"]){
        padType = @"ipad";
        return @"iPad Mini 4 (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad5,2"]){
        padType = @"ipad";
        return @"iPad Mini 4 (LTE)";
    }
    if ([deviceString isEqualToString:@"iPad5,3"]){
        padType = @"ipad";
        return @"iPad Air 2";
    }
    if ([deviceString isEqualToString:@"iPad5,4"]){
        padType = @"ipad";
        return @"iPad Air 2";
    }
    if ([deviceString isEqualToString:@"iPad6,3"]){
        padType = @"ipad";
        return @"iPad Pro 9.7";
    }
    if ([deviceString isEqualToString:@"iPad6,4"]){
        padType = @"ipad";
        return @"iPad Pro 9.7";
    }
    if ([deviceString isEqualToString:@"iPad6,7"]){
        padType = @"ipad";
        return @"iPad Pro 12.9";
    }
    if ([deviceString isEqualToString:@"iPad6,8"]){
        padType = @"ipad";
        return @"iPad Pro 12.9";
    }
    if ([deviceString isEqualToString:@"iPad6,11"]){
        padType = @"ipad";
        return @"iPad 5 (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad6,12"]){
        padType = @"ipad";
        return @"iPad 5 (Cellular)";
    }
    if ([deviceString isEqualToString:@"iPad7,1"]){
        padType = @"ipad";
        return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad7,2"]){
        padType = @"ipad";
        return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    }
    if ([deviceString isEqualToString:@"iPad7,3"]){
        padType = @"ipad";
        return @"iPad Pro 10.5 inch (WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad7,4"]){
        padType = @"ipad";
        return @"iPad Pro 10.5 inch (Cellular)";
    }

    if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";

    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";

    return deviceString;


}

/**  获取UUID*/
- (NSString *)getUUIDByKeyChain{
    // 这个key的前缀最好是你的BundleID
    NSString*strUUID = (NSString*)[KeyChainStore load:@"com.yb.JYMJAD-SDK"];
    //首次执行该方法时，uuid为空
    if([strUUID isEqualToString:@""]|| !strUUID)
    {
        // 获取UUID 这个是要引入<AdSupport/AdSupport.h>的
        strUUID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        
        if(strUUID.length ==0 || [strUUID isEqualToString:@"00000000-0000-0000-0000-000000000000"])
        {
            //生成一个uuid的方法
            CFUUIDRef uuidRef= CFUUIDCreate(kCFAllocatorDefault);
            strUUID = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
            CFRelease(uuidRef);
        }
        
        //将该uuid保存到keychain
        [KeyChainStore save:@"com.yb.JYMJAD-SDK" data:strUUID];
    }
    return strUUID;
}


- (void)cpcCallBack:(JYMJADCpcRequest  *)parameters success:(SuccessBlockOfCpcRequest)successBlock failure:(FailureBlock)failureBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@" , self.url, @"/api/cpcCallBack"];
    if(self.showlog) NSLog(@"%@", url);
    [XMNetWorkHelper postWithUrlString:url parameters:[self getObjectData:parameters] success:^(NSDictionary *data) {
        JYMJADCpcResponse *response =  [[JYMJADCpcResponse alloc] init];
        [response convert:data];
        
        successBlock(response);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}


- (void)cpsCallBack:(JYMJADCpsRequest  *)parameters success:(SuccessBlockOfCpsRequest)successBlock failure:(FailureBlock)failureBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@" , self.url, @"/api/cpsCallBack"];
    if(self.showlog) NSLog(@"%@", url);
    [XMNetWorkHelper postWithUrlString:url parameters:[self getObjectData:parameters] success:^(NSDictionary *data) {
        
        JYMJADCpsResponse *response =  [[JYMJADCpsResponse alloc] init];
        [response convert:data];
        successBlock(response);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}


- (void)cpaCallBack:(JYMJADCpaRequest  *)parameters success:(SuccessBlockOfCpaRequest)successBlock failure:(FailureBlock)failureBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@" , self.url, @"/api/cpaCallBack"];
    if(self.showlog) NSLog(@"%@", url);
    [XMNetWorkHelper postWithUrlString:url parameters:[self getObjectData:parameters] success:^(NSDictionary *data) {
        
        JYMJADCpaResponse *response =  [[JYMJADCpaResponse alloc] init];
        [response convert:data];
        
        successBlock(response);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}


- (void)cpmCallBack:(JYMJADCpmRequest  *)parameters success:(SuccessBlockOfCpmRequest)successBlock failure:(FailureBlock)failureBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@" , self.url, @"/api/cpmCallBack"];
    if(self.showlog) NSLog(@"%@", url);
    [XMNetWorkHelper postWithUrlString:url parameters:[self getObjectData:parameters] success:^(NSDictionary *data) {
        JYMJADCpmResponse *response =  [[JYMJADCpmResponse alloc] init];
        [response convert:data];
        successBlock(response);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}


- (void)endCallBack:(JYMJADEndRequest  *)parameters success:(SuccessBlockOfADEndRequest )successBlock failure:(FailureBlock)failureBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@" , self.url, @"/api/endCallBack"];
    if(self.showlog) NSLog(@"%@", url);
    [XMNetWorkHelper postWithUrlString:url parameters:[self getObjectData:parameters] success:^(NSDictionary *data) {
        JYMJADEndResponse *response =  [[JYMJADEndResponse alloc] init];
        [response convert:data];
        successBlock(response);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}


- (NSDictionary*)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);//获得属性列表
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];//获得属性的名称
        id value = [obj valueForKey:propName];//kvc读值
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value = [self getObjectInternal:value];//自定义处理数组，字典，其他类
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}


- (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}


@end
