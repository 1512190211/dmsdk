//
//  ViewController.m
//  TvsLoginDemo
//
//  Created by ZACARDFANG on 2017/8/11.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "LoginController.h"

#import <TVSAccountSDK/TVSAccountSDK.h>

@interface LoginController()
@property (strong, nonatomic) IBOutlet UIButton *btnWXLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnWXToken;
@property (strong, nonatomic) IBOutlet UIButton *btnQQLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnQQToken;
@property (strong, nonatomic) IBOutlet UITextView *tvResult;
@property (strong, nonatomic) IBOutlet UIButton *btnLogout;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshBtnStatus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//调用微信登录
- (IBAction)onClickBtnWXLogin:(id)sender {
    [[TVSAccount shared]wxLoginWithViewController:self handler:^(BOOL success){
        [self showText:[NSString stringWithFormat:@"微信登录%@", success ? @"成功" : @"失败"]];
        if (success) {
            [self readAccountUserInfo];
        }
        [self refreshBtnStatus];
    }];
}

//刷新微信token(已登录情况下)
- (IBAction)onClickBtnWXToken:(id)sender {
    [[TVSAccount shared]wxTokenRefreshWithHandler:^(BOOL success){
        [self showText:[NSString stringWithFormat:@"微信 token 刷新%@", success ? @"成功" : @"失败"]];
        if (success) {
            [self readAccountUserInfo];
        }
        [self refreshBtnStatus];
    }];
}

//调用微信支付
- (IBAction)onClickWXPay:(id)sender {
    [[TVSAccount shared]wxPayWithAppId:@"appid" partnerid:@"partnerid" prepayid:@"prepayid" package:@"package" noncestr:@"noncestr" sign:@"sign" timestamp:123456789 handler:^(BOOL success, NSString* key){
        if (success) {
            [self showText:[NSString stringWithFormat:@"微信支付成功：%@", key]];
        } else {
            [self showText:@"微信支付失败"];
        }
    }];
}

//调用QQ登录
- (IBAction)onClickQQLogin:(id)sender {
    [[TVSAccount shared]qqLoginWithHandler:^(BOOL success){
        [self showText:[NSString stringWithFormat:@"QQ 登录%@",  success ? @"成功" : @"失败"]];
        if (success) {
            [self readAccountUserInfo];
        }
        [self refreshBtnStatus];
    }];
}

//验证QQ token(已登录情况下)
- (IBAction)onClickQQToken:(id)sender {
    [[TVSAccount shared]qqTokenVerifyWithHandler:^(BOOL success){
        [self showText:[NSString stringWithFormat:@"QQ token 验证%@",  success ? @"成功" : @"失败"]];
        if (success) {
            [self readAccountUserInfo];
        }
        [self refreshBtnStatus];
    }];
}

//读取账号、用户信息
-(void)readAccountUserInfo {
    TVSAccountInfo* ai = [TVSAccount shared].accountInfo;
    TVSUserInfo* ui = [TVSAccount shared].userInfo;
    NSString* clientId = [TVSAccountInfo clientIdWithDSN:@"mDSN" productId:@"mProductId"];
    [self showText:[NSString stringWithFormat:@"nickname: %@",  ui.nickName]];
    [self showText:[NSString stringWithFormat:@"token: %@",  ai.accessToken]];
    [self showText:[NSString stringWithFormat:@"ClientId: %@",  clientId]];
}

//注销登录
- (IBAction)onClickBtnLogout:(id)sender {
    [[TVSAccount shared]logout];
    [self refreshBtnStatus];
    _tvResult.text = nil;
}

//进入会员H5页面
- (IBAction)onClickBtnUserCenter:(id)sender {
    TVSWebPage* twp = [TVSWebPage new];
    [twp setDeviceType:@"mDeviceType" deviceOEM:@"mDeviceOEM" productId:@"7e8ab486-c6f6-4ecc-b52e-7ea8da82c9da:9cb1fbf4c54442cc80c9aed8cb3c25b6" DSN:@"mDSN"];
    [twp enterPage:TVSWebPageTypeMember fromViewController:self title:@"个人中心" delegate:nil];
}

-(void)refreshBtnStatus {
    if ([[TVSAccount shared]isWXTokenExist]) {//是否微信登录
        _btnWXLogin.enabled = NO;
        _btnWXToken.enabled = YES;
        _btnQQLogin.enabled = NO;
        _btnQQToken.enabled = NO;
        _btnLogout.enabled = YES;
    } else if ([[TVSAccount shared]isQQTokenExist]) {//是否QQ登录
        _btnWXLogin.enabled = NO;
        _btnWXToken.enabled = NO;
        _btnQQLogin.enabled = NO;
        _btnQQToken.enabled = YES;
        _btnLogout.enabled = YES;
    } else {//未登录
        _btnWXLogin.enabled = YES;
        _btnWXToken.enabled = NO;
        _btnQQLogin.enabled = YES;
        _btnQQToken.enabled = NO;
        _btnLogout.enabled = NO;
    }
}

-(void)showText:(NSString*)text {
    if (_tvResult.text == nil || _tvResult.text.length == 0) {
        _tvResult.text = text;
    } else {
        _tvResult.text = [_tvResult.text stringByAppendingString:[NSString stringWithFormat:@"%@%@", @"\n\n", text]];
    }
    if (_tvResult.text.length > 0) {
        NSRange bottom = NSMakeRange(_tvResult.text.length - 1, 1);
        [_tvResult scrollRangeToVisible:bottom];
    }
}

#pragma mark 设备绑定相关示例
-(void)testDeviceBind {
    NSString* deviceProductId = @"s7adsa7dsa78dsads7sad|ds8fds8fds8f8dsf98ds";
    NSString* deviceDSN = @"1g:3g:b4:7f:f8:d9:d0:k8";
    TVSPushDevice* tpd = [TVSPushDevice new];
    tpd.productId = deviceProductId;
    tpd.DSN = deviceDSN;
    //绑定设备
    [[TVSDeviceBind shared] bindDevice:tpd handler:^(BOOL success) {
        NSLog(@"绑定 %@", success ? @"成功" : @"失败");
    }];
    //解绑设备
    [[TVSDeviceBind shared] unbindDeviceWithProductId:deviceProductId dsn:deviceDSN handler:^(BOOL success) {
        NSLog(@"解绑 %@", success ? @"成功" : @"失败");
    }];
    //查询绑定的设备列表
    [[TVSDeviceBind shared]queryPushDevicesWithHandler:^(NSArray<TVSPushDevice *> * devices) {
        if (devices) {
            for (TVSPushDevice* d in devices) {
                NSLog(@"deviceProductId:%@ deviceDSN:%@", d.productId, d.DSN);
            }
        }
    }];
    //根据设备信息查询绑定的账户信息
    [[TVSDeviceBind shared]queryBoundAccountWithDeviceProductId:deviceProductId dsn:deviceDSN handler:^(TVSAccountInfo * account) {
        if (account) {
            NSLog(@"openId: %@", account.openId);
        }
    }];
}

@end
