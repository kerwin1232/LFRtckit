//
//  ConsultationViewController.m
//  MyVideoSDK
//
//  Created by kerwin Zhang on 2022/1/18.
//  Copyright © 2022 kerwin. All rights reserved.
//

#import "ConsultationViewController.h"
#import "VideoViewController.h"
#import <LiveFullerDC/LFRtcKit.h>
@interface ConsultationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (strong,nonatomic)LFManager *manager;

@end

@implementation ConsultationViewController

- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.interactivePopGestureRecognizer setEnabled:NO];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    [super viewDidLoad];
    self.manager = [LFManager shareManager];
}
- (IBAction)joinIn:(id)sender {
    VideoViewController *vc = [[VideoViewController alloc]init];
    vc.channelId = self.textfield.text;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)logOut:(id)sender {
   
    [self.manager logOutWithCompletion:^(LFLogoutErrorCode errorCode) {
        if (errorCode == LFLogoutErrorOk) {
            NSLog(@"log out success");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"log out failed : %d",(int)errorCode);
        }
    }];
 

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
