//
//  BCWiFiTool.h
//  wwz
//
//  Created by wwz on 16/6/25.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WZESPTouchDelegate <NSObject>

/**
 *  成功连接wifi设备到路由器
 *
 *  @param host wifi设备host
 */
- (void)EsptouchDidAddHost:(NSString *)host;

@end

@interface WZESPTouch : NSObject


@property (nonatomic, weak) id<WZESPTouchDelegate> delegate;

/**
 *  BCWiFiTool
 *
 *  @param ssid     wifi 名
 *  @param bssid    wifi参数
 *  @param pwd      wifi pwd
 *
 *  @return BCWiFiTool
 */
- (instancetype)initWithSsid:(NSString *)ssid bssid:(NSString *)bssid pwd:(NSString *)pwd delegate:(id<WZESPTouchDelegate>)delegate;

/**
 *  开始搜索
 */
- (void)startSearchDeviceSuccess:(void(^)())success failure:(void(^)())failure;

/**
 *  取消搜索
 */
- (void)cancel;

@end
