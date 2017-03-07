//
//  BCWiFiTool.m
//  wwz
//
//  Created by wwz on 16/6/25.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import "WZESPTouch.h"
#import "ESPTouchTask.h"
#import "ESPTouchResult.h"
#import "ESP_NetUtil.h"

// G-C-D
// 主线程
#define kMain_GCD(block) dispatch_async(dispatch_get_main_queue(),block)
// 子线程
#define kBack_GCD(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
// 延时
#define kAfter_GCD(a, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(a* NSEC_PER_SEC)), dispatch_get_main_queue(), block)


@interface WZESPTouch ()<ESPTouchTaskDelegate>

@property (nonatomic, strong) ESPTouchTask *touchTask;

@property (nonatomic, copy) NSString *ssid;

@property (nonatomic, copy) NSString *bssid;

@property (nonatomic, copy) NSString *pwd;

@property (nonatomic, assign) NSUInteger requestCount;

@end

@implementation WZESPTouch

- (instancetype)initWithSsid:(NSString *)ssid bssid:(NSString *)bssid pwd:(NSString *)pwd delegate:(id<WZESPTouchDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        _ssid = ssid;
        
        _bssid = bssid;
        
        _pwd = pwd;
        
        _delegate = delegate;
    }
    return self;
}

- (void)startSearchDeviceSuccess:(void(^)())success failure:(void(^)())failure{

    _requestCount = 0;
    
    kBack_GCD(^{
        
        ESPTouchResult *firstResult = nil;
        
        while (_requestCount < 8) {
            
            // execute the task
            // 使wifi设备连接到路由器，并返回设备信息
            
            firstResult = [self.touchTask executeForResults:1][0];
//            NSLog(@"firstResult=====%@， 第%d次", firstResult, _requestCount);
            
            if (!firstResult || firstResult.isCancelled) {
                
                return ;
            }
            
            if (!firstResult.isSuc) {// 不成功
                
                _requestCount++;
                [self cancel];
                sleep(1);
                
            }else{
            
                break;
            }
            
        }
        
        kMain_GCD(^{
                
            if (firstResult.isSuc){
                
                if (success) {
                    success();
                }
                
            }else{
                
                if (failure) {
                    failure();
                }
            }
            [self cancel];
         
        });
    });

}

- (void)cancel{

    if (_touchTask != nil){
        [_touchTask interrupt];
        _touchTask = nil;
    }
}

- (ESPTouchTask *)touchTask{
    
    if (!_touchTask) {
        _touchTask = [[ESPTouchTask alloc] initWithApSsid:_ssid andApBssid:_bssid andApPwd:_pwd andIsSsidHiden:NO];
        [_touchTask setDelegate:self];
    }
    return _touchTask;
}
#pragma mark - ESPTouchDelegate
/**
 *  得到设备信息回调代理
 */
- (void)onEsptouchResultAddedWithResult:(ESPTouchResult *) result{
    
    NSString *host = [ESP_NetUtil descriptionInetAddrByData:result.ipAddrData];
    
    if ([self.delegate respondsToSelector:@selector(EsptouchDidAddHost:)]) {
        [self.delegate EsptouchDidAddHost:host];
    }
    
}

@end
