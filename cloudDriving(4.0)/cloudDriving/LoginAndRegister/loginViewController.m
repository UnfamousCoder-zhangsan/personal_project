//
//  loginViewController.m
//  cloudDriving
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTxt; //用户名
@property (weak, nonatomic) IBOutlet UITextField *passwdTxt; //密码
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;  //登录
@property (weak, nonatomic) IBOutlet UIButton *signBtn;   //注册
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;  //忘记密码


@end

@implementation loginViewController{
    UIView *_kBarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _kBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:_kBarView];
    _kBarView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80)/2 +15, 35, 80, 20)];
    [_kBarView addSubview:titleLabel];
    titleLabel.text = @"登录/注册";
    titleLabel.textColor = [UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 35, 30, 30)];
    [_kBarView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(rollbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark 点击返回按钮
-(void)rollbackBtnClick{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent; //状态栏白色
}
- (IBAction)loginBtnClick:(id)sender {
    [SVProgressHUD showWithStatus:@"请稍等..."];
    if ([self.loginBtn.titleLabel.text isEqualToString:@"登录"]) {
        if([_nameTxt.text isEqualToString:@""]){
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"用户名为空，请输入用户名"];
            [SVProgressHUD dismissWithDelay:0.8]; //消失
        }else if ([_passwdTxt.text isEqualToString:@""])
        {
            [SVProgressHUD  showImage:[UIImage imageNamed:@""] status:@"密码为空,请输入密码"]; //提示消息
            [SVProgressHUD dismissWithDelay:0.6]; //消失
        }
        else
        {
            
            [BmobUser loginInbackgroundWithAccount:_nameTxt.text andPassword:_passwdTxt.text block:^(BmobUser *user, NSError *error) {
                if (user) {
                    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                    NSNotification *notification = [NSNotification notificationWithName:@"loginNo" object:nil userInfo:@{@"isLogin":@true}];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    [self rollbackBtnClick];
                } else {
                    
                    [SVProgressHUD showErrorWithStatus:@"账号或密码错误，验证后重新登录！"];
                    [SVProgressHUD dismissWithDelay:1.0]; //消失
                }
            }];
        }
    } else {
        BmobUser *bUser = [[BmobUser alloc] init];
        [bUser setUsername:_nameTxt.text];
        [bUser setPassword:_passwdTxt.text];
        [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
            if (isSuccessful){
                [BmobUser loginInbackgroundWithAccount:_nameTxt.text andPassword:_passwdTxt.text block:^(BmobUser *user, NSError *error) {
                    if (user) {
                        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                        NSNotification *notification = [NSNotification notificationWithName:@"loginNo" object:nil userInfo:@{@"isLogin":@true}];
                        [[NSNotificationCenter defaultCenter] postNotification:notification];
                        [self rollbackBtnClick];
                    } else {
                        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
                    }
                }];
            } else {
            
                if([_nameTxt.text isEqualToString:@""]){
                    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"用户名为空，请输入用户名"];
                    [SVProgressHUD dismissWithDelay:0.8]; //消失
                }else if ([_passwdTxt.text isEqualToString:@""]){
                    [SVProgressHUD  showImage:[UIImage imageNamed:@""] status:@"密码为空,请输入密码"]; //提示消息
                    [SVProgressHUD dismissWithDelay:0.6]; //消失
                }
                else{
                    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"该用户名已存在"];
                    //[SVProgressHUD showErrorWithStatus:@"该用户名已存在"];
                    [SVProgressHUD dismissWithDelay:1.0]; //消失
                }
            }
        }];
    }
    
    
}



- (IBAction)signInBtnClick:(id)sender {
    if ([self.signBtn.titleLabel.text isEqualToString:@"没有账号？前往注册"]) {
        [self.signBtn setTitle:@"已有账号，前往登录" forState:UIControlStateNormal];
        [self.loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        self.loginBtn.backgroundColor = [UIColor orangeColor];
    }else{
        [self.signBtn setTitle:@"没有账号？前往注册" forState:UIControlStateNormal];
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        self.loginBtn.backgroundColor = [UIColor colorWithRed:15/255.0 green:127/255.0 blue:1 alpha:1];
    }
}

- (IBAction)forgetPwdBtnClick:(id)sender {
    
    NSLog(@"点击了忘记密码按钮");
}





@end
