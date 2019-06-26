//
//  MainTestViewController.m
//  cloudDriving
//
//  Created by apple on 2019/6/8.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "MainTestViewController.h"
#import "TestViewController.h"
#import "modelSelectedVC.h"

@interface MainTestViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testBtnLeft;
@property (weak, nonatomic) IBOutlet UIButton *testBtnRight;

@end

@implementation MainTestViewController{
    UIView *_kBarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _kBarView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:_kBarView];
    _kBarView.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2 + 5, 40, 80, 20)];
    [_kBarView addSubview:titleLabel];
    titleLabel.text = @"全真模拟";
    [titleLabel setFont:[UIFont systemFontOfSize:18]];
    titleLabel.textColor = [UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 35, 40, 30)];
    [_kBarView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(rollbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    //设置button属性
    [_testBtnLeft.layer setCornerRadius:12];
    [_testBtnRight.layer setCornerRadius:12];
    
    _testBtnLeft.layer.masksToBounds = YES;
    _testBtnRight.layer.masksToBounds = YES;
    
}


- (void)rollbackBtnClick {
    [self dismissViewControllerAnimated:YES completion:^{
    
    }];
}
- (IBAction)testBtnLeft:(id)sender {
    
    TestViewController *vc = [TestViewController new];
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
}

@end
