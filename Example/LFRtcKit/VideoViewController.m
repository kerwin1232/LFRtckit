//
//  VideoViewController.m
//  MyVideoSDK
//
//  Created by kerwin on 2020/1/6.
//  Copyright © 2020 kerwin. All rights reserved.
//

#import "VideoViewController.h"
#import <LiveFullerDC/LFRtcKit.h>
#import "Toast+UIView.h"
@interface VideoViewController ()<LFVideoEngineDelegate>
@property(nonatomic,strong)LFVideoEngine *engine;

@property(nonatomic,strong)UIView *remoteVideo;
@property(nonatomic,strong)UIView *localVideo;
@property(nonatomic,strong)UIButton *muteAudioBtn;
@property(nonatomic,strong)UIButton *hangUpBtn;
@property(nonatomic,strong)UIButton *cameraBtn;

@end

@implementation VideoViewController
-(void)dealloc{
    NSLog(@"dealloc videoviewcontroller");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.remoteVideo];
    [self.view addSubview:self.localVideo];
    [self.view addSubview:self.muteAudioBtn];
    [self.view addSubview:self.hangUpBtn];
    [self.view addSubview: self.cameraBtn];
    
    self.engine = [LFVideoEngine shareEngine];
    self.engine.delegate = self;
    
    [self.engine setupLocalVideo:self.localVideo];
    [self.engine enableVideo];
    [self.engine startPreview];
    [self.engine joinChannelByChannelId:self.channelId completion:^(LFJoinChannelErrorCode errorCode) {
        if (errorCode == LFJoinChannelErrorCodeOk) {
            NSLog(@"join channel success");
        }else{
            NSLog(@"join channel fail %d",(int)errorCode);
        }
    }];
}

-(void)onSetRemoteVideoFrameWithUid:(NSUInteger)uid size:(CGSize)size{
    [self.engine setupRemoteVideo:self.remoteVideo uid:uid];
}
-(void)didOfflineOfUid:(NSUInteger)uid reason:(LFUserOfflineReason)reason{
    [self.engine leaveChannel];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.engine destoryEngine];
    }];
}
-(void)onNetworkQuality:(NSUInteger)uid txQuality:(LFNetworkQuality)txQuality rxQuality:(LFNetworkQuality)rxQuality{
    
    switch (rxQuality) {
        case LFNetworkQualityUnknown:
            [self.view makeToast:@"Unknown"];
            break;
        case LFNetworkQualityExcellent:
            [self.view makeToast:@"Excellent"];
            break;
        case LFNetworkQualityGood:
            [self.view makeToast:@"Good"];
            break;
        case LFNetworkQualityPoor:
            [self.view makeToast:@"Poor"];
            break;
        case LFNetworkQualityBad:
            [self.view makeToast:@"Bad"];
            break;
        case LFNetworkQualityVBad:
            [self.view makeToast:@"VBad"];
            break;
        case LFNetworkQualityDown:
            [self.view makeToast:@"Down"];
            break;
        case LFNetworkQualityUnsupported:
            [self.view makeToast:@"Unsupported"];
            break;
        case LFNetworkQualityDetecting:
            [self.view makeToast:@"Detecting"];
            break;
        default:
            break;
    }
    
}
- (void)hangup:(id)sender {

    [self.engine leaveChannel];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)muteButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.engine muteLocalAudio:sender.selected];
}
- (void)switchCameraButtonClick:(id)sender {
    [self.engine switchCamera];
}

-(UIView *)remoteVideo{
    if (!_remoteVideo) {
        _remoteVideo = [[UIView alloc]initWithFrame:self.view.bounds];
        _remoteVideo.backgroundColor = [UIColor grayColor];
    }
    return _remoteVideo;
}
-(UIView *)localVideo{
    if (!_localVideo) {
        _localVideo = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 125, 100, 85, 140)];
    }
    return _localVideo;
}


-(UIButton *)muteAudioBtn{
    if (!_muteAudioBtn) {
        _muteAudioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _muteAudioBtn.frame = CGRectMake(60, self.view.frame.size.height-70-94, 60, 60);
        [_muteAudioBtn setImage:[UIImage imageNamed:@"mute_select"] forState:(UIControlStateNormal)];
        [_muteAudioBtn setImage:[UIImage imageNamed:@"mute_selected"] forState:(UIControlStateSelected)];
        [_muteAudioBtn addTarget:self action:@selector(muteButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _muteAudioBtn;
}

-(UIButton *)hangUpBtn{
    if (!_hangUpBtn) {
        _hangUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _hangUpBtn.frame = CGRectMake((self.view.frame.size.width)/2-30, self.view.frame.size.height-70-94, 60, 60);
        [_hangUpBtn setImage: [UIImage imageNamed:@"hangup"] forState:(UIControlStateNormal)];
        [_hangUpBtn addTarget:self action:@selector(hangup:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _hangUpBtn;
}
-(UIButton *)cameraBtn{
    
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraBtn setImage:[UIImage imageNamed:@"camera"] forState:(UIControlStateNormal)];
        _cameraBtn.frame = CGRectMake(self.view.frame.size.width- 120 , self.view.frame.size.height-70-94, 60, 60);
        [_cameraBtn addTarget:self action:@selector(switchCameraButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _cameraBtn;
}

@end
