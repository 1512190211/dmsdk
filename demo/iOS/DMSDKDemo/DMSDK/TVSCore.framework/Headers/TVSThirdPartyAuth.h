//
//  TVSThirdPartyAuth.h
//  TVSCore
//
//  Created by Rinc Liu on 28/3/2019.
//  Copyright © 2019 RINC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TVSCore/TVSAuth.h>
#import <TVSCore/TVSDevice.h>
#import <TVSCore/TVSTSKMProxy.h>

typedef NS_ENUM(NSInteger,TVSCP) {
    TVSCPUnknown,
    TVSCPQQMusic
};

@interface TVSCPCredential : NSObject

@property(nonatomic,readonly) TVSCP cp;

@property(nonatomic,readonly) NSString* appId;

@property(nonatomic,readonly) NSString* openId;

@property(nonatomic,readonly) NSString* openToken;

@property(nonatomic,readonly) NSInteger expireTime;

-(instancetype)initWithCP:(TVSCP)cp andAppId:(NSString*)appId andOpenId:(NSString*)openId andOpenToken:(NSString*)openToken andExpireTime:(NSInteger)expireTime;

@end

typedef NS_ENUM(NSInteger,TVSCPError) {
    TVSCPErrorNotSupported = 1,
    TVSCPErrorNotInstalled,
    TVSCPErrorConnectingToAppFailure,
    TVSCPErrorUserCancellation,
    TVSCPErrorRequestingAuthFailure,
    TVSCPErrorBindingFailure
};

@protocol TVSCPAuthAgent <NSObject>

-(NSString *)getAppId;

-(BOOL)checkCPInstalled;

-(void)requestCPCredentialWithHandler:(void(^)(BOOL,NSInteger,NSString *,TVSCPCredential *))handler;

-(void)jumpToAppStore;

@end

@interface TVSCPAuthAgentManager : NSObject

+(instancetype)shared;

-(id<TVSCPAuthAgent>)getAgentOfCP:(TVSCP)cp;

-(void)setAgent:(id<TVSCPAuthAgent>)agent ofCP:(TVSCP)cp;

@end

/*
 * @class TVSThirdPartyAuth
 * @brief TVS 第三方授权
 */
@interface TVSThirdPartyAuth : NSObject

/*
 * @brief 跳转到云叮当 APP 进行第三方授权
 * @param accountInfo 账号信息，使用本 SDK 做账号登录的传 nil
 * @param deviceInfo 设备信息，其中 productId、dsn、guid 必填！！
 * @param handler 回调，BOOL 表示是否成功
 */
+(void)gotoAuthWithAccountInfo:(nullable TVSAccountInfo*)accountInfo deviceInfo:(TVSDeviceInfo*)deviceInfo handler:(nonnull void(^)(BOOL))handler __attribute__ ((deprecated("云叮当账号方案即将下线，请迁移到QQ音乐应用方案")));

/*
 * @brief TVSThirdPartyAuth 类实例化
 * @param tskmProxy TSKMProxy 对象
 * @param deviceInfo 设备信息
 * @return TVSThirdPartyAuth 实例
 */
-(instancetype)initWithTSKMProxy:(nonnull TVSTSKMProxy*)tskmProxy deviceInfo:(TVSDeviceInfo*)deviceInfo;

/*
 * @brief 查询绑定的云叮当账号信息
 * @param handler 回调
 */
-(void)getBindedAccountInfoWithHandler:(nonnull void(^)(TVSAccountInfo* _Nullable))handler __attribute__ ((deprecated("云叮当账号方案即将下线，请迁移到QQ音乐应用方案")));

/*
 * @brief 解绑云叮当账号
 * @param accountInfo 账号信息
 * @param handler 回调
 */
-(void)unbindWithAccountInfo:(TVSAccountInfo*)accountInfo handler:(nonnull void(^)(BOOL))handler __attribute__ ((deprecated("云叮当账号方案即将下线，请迁移到QQ音乐应用方案")));

@end
