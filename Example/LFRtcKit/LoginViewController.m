//
//  LoginViewController.m
//  MyVideoSDK
//
//  Created by kerwin on 2020/1/6.
//  Copyright © 2020 kerwin. All rights reserved.
//

#import "LoginViewController.h"
#import <LiveFullerDC/LFRtcKit.h>
#import "Toast+UIView.h"
#import "ConsultationViewController.h"
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;
@interface LoginViewController ()<LFManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userIdField;
@property (strong,nonatomic)LFManager *manager;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(acceptInvitation:) name:@"ACCEPTINVITATION" object:nil];
    self.manager = [LFManager shareManager];
}
-(void)acceptInvitation:(NSNotification *)noti{
    
    LFRemoteInvitation *ri = noti.object;
    [self.manager acceptRemoteInvitation:ri completion:^(LFInvitationApiCallErrorCode errorCode) {
        if (errorCode == LFInvitationApiCallErrorOk) {
            
        }else{
            NSLog(@"accept fail : %d",(int)errorCode);
        }
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)loginButton:(id)sender {
    [self.view endEditing:YES];
    if ([self.userIdField.text isEqualToString:@""]) {
        return;
    }
    [[UIApplication sharedApplication].keyWindow makeToastActivity];
    kWeakSelf(self)
    [self.manager loginByUserId:self.userIdField.text Success:^(NSString * _Nonnull accountToken, NSString * _Nonnull userId, NSString * _Nonnull tencentAppId, NSString * _Nonnull userSig) {
   
        kStrongSelf(self)
        NSLog(@"login success");
        [[UIApplication sharedApplication].keyWindow hideToastActivity];
        ConsultationViewController *home = [[ConsultationViewController alloc]init];
        [self.navigationController pushViewController:home animated:YES];
    } Failure:^(LFLoginErrorCode errorCode) {
        NSLog(@"login failed : %d",(int)errorCode);
        [[UIApplication sharedApplication].keyWindow hideToastActivity];
        [[UIApplication sharedApplication].keyWindow makeToast:[NSString stringWithFormat:@"login failed : %d",(int)errorCode]];
    }];
    
}






@end
