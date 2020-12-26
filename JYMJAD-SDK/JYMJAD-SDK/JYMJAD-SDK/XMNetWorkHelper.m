
#import "XMNetWorkHelper.h"

@implementation XMNetWorkHelper

//GET请求
+ (void)getWithUrlString:(NSString *)url parameters:(id)parameters success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock
{
    NSMutableString *mutableUrl = [[NSMutableString alloc] initWithString:url];
    if ([parameters allKeys]) {
        [mutableUrl appendString:@"?"];
        for (id key in parameters) {
            NSString *value = [[parameters objectForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [mutableUrl appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
        }
    }
    NSString *urlEnCode = [[mutableUrl substringToIndex:mutableUrl.length - 1] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEnCode]];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            successBlock(dic);
        }
    }];
    [dataTask resume];
}

//POST请求 使用NSMutableURLRequest可以加入请求头
+ (void)postWithUrlString:(NSString *)url parameters:(id)parameters success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock
{
    NSURL *nsurl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    //如果想要设置网络超时的时间的话，可以使用下面的方法：
    //NSMutableURLRequest *mutableRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //设置请求类型
    request.HTTPMethod = @"POST";
    
    //将需要的信息放入请求头 随便定义了几个
//    [request setValue:@"xxx" forHTTPHeaderField:@"Authorization"];//token
//    [request setValue:@"xxx" forHTTPHeaderField:@"Gis-Lng"];//坐标 lng
//    [request setValue:@"xxx" forHTTPHeaderField:@"Gis-Lat"];//坐标 lat
//    [request setValue:@"xxx" forHTTPHeaderField:@"Version"];//版本
//    NSLog(@"POST-Header:%@",request.allHTTPHeaderFields);
    
    //把参数放到请求体内
    
    
    NSString *postStr = [XMNetWorkHelper parseParamsToJsonStr:parameters];
    
//    NSLog(@"请求参数:%@",postStr);


    [request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [postStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) { //请求失败
            failureBlock(error);
        } else {  //请求成功
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            successBlock(dic);
        }
    }];
    [dataTask resume];  //开始请求
}

//对象转化为字典



//重新封装参数 加入app相关信息
+ (NSString *)parseParams:(NSDictionary *)params
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:params];
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    NSEnumerator *keyEnum = [parameters keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&", key, [params valueForKey:key]];
        [result appendString:keyValueFormat];
    }
    return result;
}



//重新封装参数 加入app相关信息
+ (NSString *)parseParamsToJsonStr:(NSDictionary *)params
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:params];
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}






//下载图片
/**
 该下载方式不适合大文件下载，
 因为该方法需要等到文件下载完毕了，
 才会回调completionHandler后面的block参数，
 然后才可以在这个block参数可以获取location(文件下载缓存的路径)、response(响应)、error(错误信息)。
 这样的话，对于大文件，我们就无法实时的在下载过程中获取文件的下载进度了。
 @param imgUrl 图片地址
 */
- (void)downloadImgWithUrl:(NSString *)imgUrl{
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.请求路径
    NSURL *url = [NSURL URLWithString:imgUrl];
    
    //3.创建task
    //接受到数据之后内部会直接写入到沙盒里面
    //completionHandler location(文件下载缓存的路径)、response(响应)、error(错误信息)
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            //5.接受数据
//            NSLog(@"%@",location);
            
            //5.1确定文件的全路径
            NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
            
            //5.2 剪切文件
            /*
             第一个参数：要剪切的文件在哪里
             第二个参数：目标地址
             第三个参数：错误信息
             */
            NSError *fileError;
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:&fileError];
            //打印
//            NSLog(@"%@---%@",fullPath,[NSThread currentThread]);
            if (fileError == nil) {
                NSLog(@"file save success");
            } else {
                NSLog(@"file save error: %@",fileError);
            }
        } else {
            NSLog(@"download error:%@",error);
        }

    }];
    
    //4.启动task
    [downloadTask resume];
}

//下载视频
- (void)downloadVideoWithUrl:(NSString *)videoUrl{
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //2.请求路径
    NSURL *url = [NSURL URLWithString:videoUrl];
    
    //3.创建task
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
    
    //4.启动task
    [downloadTask resume];
}

#pragma mark -NSURLSessionDownloadDelegate Function
// 下载数据的过程中会调用的代理方法
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
//    NSLog(@"%lf",1.0 * totalBytesWritten / totalBytesExpectedToWrite);
}
// 重新恢复下载的代理方法
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}
// 写入数据到本地的时候会调用的方法
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSString* fullPath =
    [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
     stringByAppendingPathComponent:downloadTask.response.suggestedFilename];;
    [[NSFileManager defaultManager] moveItemAtURL:location
                                            toURL:[NSURL fileURLWithPath:fullPath]
                                            error:nil];
//    NSLog(@"%@",fullPath);
}
// 请求完成，错误调用的代理方法
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
}

//第1种方式 以流的方式上传，大小理论上不受限制，但应注意时间
-(void)uploadFileWithData:(NSData *)fileData{
    // 1.创建url 服务器上传脚本
    NSString *urlString = @"http://服务端/upload.php";
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 文件上传使用post
    request.HTTPMethod = @"POST";
    
    // 3.开始上传   request的body data将被忽略，而由fromData提供
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:fileData     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"upload success：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        } else {
            NSLog(@"upload error:%@",error);
        }
    }] resume];
}


//第2种方式 拼接表单的方式进行上传
- (void)uploadWithFilePath:(NSString *)filePath withfileName:(NSString *)fileName {
    // 1.创建url  服务器上传脚本
    NSString *urlString = @"http://服务器/upload.php";
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 文件上传使用post
    request.HTTPMethod = @"POST";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",@"boundary"];
    
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    // 3.拼接表单，大小受MAX_FILE_SIZE限制(2MB)  FilePath:要上传的本地文件路径  formName:表单控件名称，应于服务器一致
    NSData* data = [self getHttpBodyWithFilePath:filePath formName:@"file" reName:fileName];
    request.HTTPBody = data;
    // 根据需要是否提供，非必须,如果不提供，session会自动计算
    [request setValue:[NSString stringWithFormat:@"%lu",data.length] forHTTPHeaderField:@"Content-Length"];
    
    // 4.1 使用dataTask
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"upload success：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        } else {
            NSLog(@"upload error:%@",error);
        }
        
    }] resume];
#if 0
    // 4.2 开始上传 使用uploadTask   fromData:可有可无，会被忽略
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:nil     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"upload success：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        } else {
            NSLog(@"upload error:%@",error);
        }
    }] resume];
#endif
}

/// filePath:要上传的文件路径   formName：表单控件名称  reName：上传后文件名
- (NSData *)getHttpBodyWithFilePath:(NSString *)filePath formName:(NSString *)formName reName:(NSString *)reName
{
    NSMutableData *data = [NSMutableData data];
    NSURLResponse *response = [self getLocalFileResponse:filePath];
    // 文件类型：MIMEType  文件的大小：expectedContentLength  文件名字：suggestedFilename
    NSString *fileType = response.MIMEType;
    
    // 如果没有传入上传后文件名称,采用本地文件名!
    if (reName == nil) {
        reName = response.suggestedFilename;
    }
    
    // 表单拼接
    NSMutableString *headerStrM =[NSMutableString string];
    [headerStrM appendFormat:@"--%@\r\n",@"boundary"];
    // name：表单控件名称  filename：上传文件名
    [headerStrM appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",formName,reName];
    [headerStrM appendFormat:@"Content-Type: %@\r\n\r\n",fileType];
    [data appendData:[headerStrM dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 文件内容
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [data appendData:fileData];
    
    NSMutableString *footerStrM = [NSMutableString stringWithFormat:@"\r\n--%@--\r\n",@"boundary"];
    [data appendData:[footerStrM  dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSLog(@"dataStr=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    return data;
}
/// 获取响应，主要是文件类型和文件名
- (NSURLResponse *)getLocalFileResponse:(NSString *)urlString
{
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    // 本地文件请求
    NSURL *url = [NSURL fileURLWithPath:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __block NSURLResponse *localResponse = nil;
    // 使用信号量实现NSURLSession同步请求
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        localResponse = response;
        dispatch_semaphore_signal(semaphore);
    }] resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return  localResponse;
}

@end
