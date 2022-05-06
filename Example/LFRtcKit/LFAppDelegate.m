//
//  LFAppDelegate.m
//  LFRtcKit
//
//  Created by kerwin on 01/18/2022.
//  Copyright (c) 2022 kerwin. All rights reserved.
//

#import "LFAppDelegate.h"
#import "LoginViewController.h"
#import <LiveFullerDC/LFRtcKit.h>
#import <AVFoundation/AVFoundation.h>
@interface LFAppDelegate ()<LFManagerDelegate,AVAudioPlayerDelegate>
@property (nonatomic, retain)AVAudioPlayer *player;
@property (strong,nonatomic)LFManager *manager;
@property (strong,nonatomic)LFRemoteInvitation *remoteInvitation;
@end

@implementation LFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    LoginViewController *login = [[LoginViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:login];
    window.rootViewController = navi;
    self.window = window;
    [window makeKeyAndVisible];
    [LFManager initWithClientType:@"CLIENT_FHN3" authorization:@"bXGZROlpNiAzmHG92DCy/c/Y9tiUveulkI/RY7/HlnMy4SR9clUSmehgta0g4kcMK60lKXKBBEkwyQVair7hbDcifsvKNmVoURi20GJasrEIXuk+WfxSRB6nR1bWj0I1f0b5W0VofyhMPEE7hF+YVlkwUUSD3jjlPA5PSp4UyH4=" domain:@"https://apiv2-gateway-fhn3.fullertonhealthtech.com"];
    [LFManager shareManager].delegate = self;
   
    return YES;
}








@end
