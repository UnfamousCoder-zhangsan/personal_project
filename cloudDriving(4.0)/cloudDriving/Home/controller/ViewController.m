//
//  ViewController.m
//  cloudDriving
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "ViewController.h"
#import "RankViewController.h"
#import "loginViewController.h"
#import "modelSelectedVC.h"

#import "greenVC.h"
#import "noticeVC.h"
#import "noticePresentationController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *rankBtn;
@property (weak, nonatomic) IBOutlet UIButton *answerBtn;


@end

@implementation ViewController{
    UILabel *_kNameLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _kNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH, 20)];
    [self.view addSubview:_kNameLabel];
    if ([BmobUser currentUser]) {
        _kNameLabel.text = [NSString stringWithFormat:@"欢迎您，%@", [[BmobUser currentUser] objectForKey:@"username"]];
        _kNameLabel.textColor = [UIColor orangeColor];
    } else {
        _kNameLabel.text = @"未登录";
    }
    
    UILabel *WelcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 210)/2, 100, 250, 50)];
    [self.view addSubview:WelcomeLabel];
    WelcomeLabel.text = @"欢迎使用云驾考！";
    WelcomeLabel.textColor = [UIColor purpleColor];
    WelcomeLabel.font = [UIFont systemFontOfSize:25];
    
    
    if (![BmobUser currentUser]) {
        [_registerBtn addTarget:self action:@selector(signinOrSignupBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_registerBtn setTitle:@"登录／注册" forState:UIControlStateNormal];
    }else{
        
        [_registerBtn addTarget:self action:@selector(outBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_registerBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginReload:) name:@"loginNo"object:nil];
}

#pragma mark --注册/登录--
- (void)signinOrSignupBtnClick {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"login" bundle:nil];
    loginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"loginViewController"];
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
}

- (void)outBtnClick {
    [BmobUser logout];
    _kNameLabel.text = @"未登录";
    _kNameLabel.textColor = [UIColor grayColor];;
    [_registerBtn setTitle:@"登录／注册" forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(signinOrSignupBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self signinOrSignupBtnClick];
    
}

// 登录成功的通知
- (void)loginReload:(NSNotification *)no {
    if (no.userInfo[@"isLogin"]) {
        _kNameLabel.text = [NSString stringWithFormat:@"欢迎您，%@", [[BmobUser currentUser] objectForKey:@"username"]];
        _kNameLabel.textColor = [UIColor orangeColor];
         [_registerBtn setTitle:@"退出登录" forState:UIControlStateNormal];
         [_registerBtn addTarget:self action:@selector(outBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (IBAction)answerStartBtnClick:(id)sender {
    if([BmobUser currentUser]){
        UIStoryboard *model = [UIStoryboard storyboardWithName:@"modelSB" bundle:nil];
        modelSelectedVC *modelvc = [model instantiateViewControllerWithIdentifier:@"modelSelectedVC"];
        [self presentViewController:modelvc animated:YES completion:^{
        }];
    }else{
        UIStoryboard *sb =  [UIStoryboard storyboardWithName:@"login" bundle:nil];
        loginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"loginViewController"];
        
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

- (IBAction)rankBtnClick:(id)sender {
    RankViewController *vc = [RankViewController new];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 //报名须知
- (IBAction)noticeClick:(id)sender {
    
    noticeVC *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"noticeVC"];
    
    noticePresentationController *presentationC = [[noticePresentationController alloc] initWithPresentedViewController:toVC presentingViewController:self];
    toVC.transitioningDelegate = presentationC ;  // 指定自定义modal动画的代理
    
    [self presentViewController:toVC animated:YES completion:nil];
}

//新手上路
- (IBAction)greenClick:(id)sender {
    greenVC *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"greenVC"];
    
    noticePresentationController *presentationC = [[noticePresentationController alloc] initWithPresentedViewController:toVC presentingViewController:self];
    toVC.transitioningDelegate = presentationC ;  // 指定自定义modal动画的代理
    
    [self presentViewController:toVC animated:YES completion:nil];
}



@end
