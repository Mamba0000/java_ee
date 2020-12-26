//
//  ViewController.m
//  Test-SDK-Demo
//
//  Created by ethan on 2020/11/17.
//

#import "ViewController.h"


#import <JYMJAD_SDK/JYMJADYBSDK.h>



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)getAd:(id)sender {
    
    JYMJADYBSDK *mYBSDK = [JYMJADYBSDK build:YES];
    JYMJADAdRequest *request  = [[JYMJADAdRequest alloc] init];
    request.adId = @"ecde765e3f5aface6564f8dc499d2b7b"; // 广告id
    [mYBSDK getAd:request success:^(JYMJADAdResponse *data) {
        // 返回数据格式是字典 客户端自由解析 目前demo这边转成字符串比较好显示
        NSLog(@"%@", data);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textview.text = [self dicToJsonStr:[data changeToDic]];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textview.text = [NSString stringWithFormat:@"调用出错请看日志--%@,", [error userInfo] ];

        });
    }];
    
}

- (IBAction)cpcCallBack:(id)sender {
    
    JYMJADYBSDK *mYBSDK = [JYMJADYBSDK build:YES];
    JYMJADCpcRequest *request  = [[JYMJADCpcRequest alloc] init];
    request.recordId = @"37c2090cf1ba43558f8f960574c417a3"; // 记录id
    [mYBSDK cpcCallBack:request success:^(JYMJADCpcResponse *data) {
        // 返回数据格式是字典 客户端自由解析 目前demo这边转成字符串比较好显示
        NSLog(@"%@", data);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textview.text = [self dicToJsonStr:[data changeToDic]];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textview.text = [NSString stringWithFormat:@"调用出错请看日志--%@,", [error userInfo] ];

        });
    }];
    
}

- (IBAction)cpsCallBack:(id)sender {
    JYMJADYBSDK *mYBSDK = [JYMJADYBSDK build:YES];
    JYMJADCpsRequest *request  = [[JYMJADCpsRequest alloc] init];
    request.recordId = @"37c2090cf1ba43558f8f960574c417a3"; // 记录id
    request.price = @"12"; //价格
    request.num = @"5"; // 数量
    request.name = @"名字"; //名字
    [mYBSDK cpsCallBack:request success:^(JYMJADCpsResponse *data) {
        // 返回数据格式是字典 客户端自由解析 目前demo这边转成字符串比较好显示
        NSLog(@"%@", data);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textview.text = [self dicToJsonStr:[data changeToDic]];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textview.text = [NSString stringWithFormat:@"调用出错请看日志--%@,", [error userInfo] ];

        });
    }];
}
- (IBAction)cpaCallBack:(id)sender {
    JYMJADYBSDK *mYBSDK = [JYMJADYBSDK build:YES];
    JYMJADCpaRequest *request  = [[JYMJADCpaRequest alloc] init];
    request.recordId = @"37c2090cf1ba43558f8f960574c417a3";
    request.name = @"名字";
    [mYBSDK cpaCallBack:request success:^(JYMJADCpaResponse *data) {
        // 返回数据格式是字典 客户端自由解析 目前demo这边转成字符串比较好显示
        NSLog(@"%@", data);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textview.text = [self dicToJsonStr:[data changeToDic]];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textview.text = [NSString stringWithFormat:@"调用出错请看日志--%@,", [error userInfo] ];

        });
    }];
}
- (IBAction)cpmCallBack:(id)sender {
    JYMJADYBSDK *mYBSDK = [JYMJADYBSDK build:YES];
    JYMJADCpmRequest *request  = [[JYMJADCpmRequest alloc] init];
    request.recordId = @"37c2090cf1ba43558f8f960574c417a3";
    [mYBSDK cpmCallBack:request success:^(JYMJADCpmResponse *data) {
        // 返回数据格式是字典 客户端自由解析 目前demo这边转成字符串比较好显示
        NSLog(@"%@", data);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textview.text = [self dicToJsonStr:[data changeToDic]];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textview.text = [NSString stringWithFormat:@"调用出错请看日志--%@,", [error userInfo] ];

        });
    }];
}
- (IBAction)endCallBack:(id)sender {
    
    JYMJADYBSDK *mYBSDK = [JYMJADYBSDK build:YES];
    JYMJADEndRequest *request  = [[JYMJADEndRequest alloc] init];
    request.recordId = @"37c2090cf1ba43558f8f960574c417a3";
    [mYBSDK endCallBack:request success:^(JYMJADEndResponse *data) {
        // 返回数据格式是字典 客户端自由解析 目前demo这边转成字符串比较好显示
        NSLog(@"%@", data);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textview.text = [self dicToJsonStr:[data changeToDic]];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textview.text = [NSString stringWithFormat:@"调用出错请看日志--%@,", [error userInfo] ];
        });
    }];
    
}
- (IBAction)clear:(id)sender {
    
    self.textview.text = @"";

    
}

-(NSString *) dicToJsonStr:(NSDictionary *)dic {
    NSError * error = nil;
    NSData  * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

@end
