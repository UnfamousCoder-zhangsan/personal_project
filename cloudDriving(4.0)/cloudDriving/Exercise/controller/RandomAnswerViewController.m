//
//  RandomAnswerViewController.m
//  cloudDriving
//
//  Created by apple on 2019/6/10.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "RandomAnswerViewController.h"
#import "TestAnswerTableView.h"
#import "dataManager.h"
#import "settingVC.h"



@interface RandomAnswerViewController () <TestAnswerTableViewDelegate>

@end

@implementation RandomAnswerViewController{
    UITextView *_kTitleTextView;
    UIView *_kBarView;
    NSMutableArray *_kTitleArr;
    TestAnswerTableView  *_kTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _kTitleArr = [@[] mutableCopy];
    
    //dataManager *dM = [[dataManager alloc] init];
    
    _kBarView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:_kBarView];
    _kBarView.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2 + 5, 40, 80, 20)];
    [_kBarView addSubview:titleLabel];
    titleLabel.text = @"随机练习";
    titleLabel.textColor = [UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 35, 40, 30)];
    [_kBarView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(rollbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 35, 40, 30)];
    [_kBarView addSubview:rightButton];
    [rightButton addTarget:self action:@selector(popSettingClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"设置" forState:UIControlStateNormal];
    
    
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _kTableView = [[TestAnswerTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _kTableView.separatorStyle = UITableViewCellSeparatorStyleNone; //去除横线
    _kTableView.tableDelegate = self;
    [self.view addSubview:_kTableView];
    //    AnswerScrollView *view = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 32, SCREEN_WIDTH, SCREEN_HEIGHT - 60)];
    
    [self getDataWithBmob];
}

- (void)rollbackBtnClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)popSettingClick{
    settingVC *vc = [[settingVC alloc] init];
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getDataWithBmob {
    [SVProgressHUD showWithStatus:@"请稍后..."];
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"DrivingSub1"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            NSMutableDictionary *dict = [@{} mutableCopy];
            dict[@"picture"] = [obj objectForKey:@"question_picture"];
            dict[@"id"] = [obj objectForKey:@"question_id"];
            dict[@"question"] = [obj objectForKey:@"question_content"];
            dict[@"answer"] = [obj objectForKey:@"rightAnswer"];
            dict[@"types"]   = [obj objectForKey:@"type"];
            dict[@"analysis"] = [obj objectForKey:@"question_analyzing"];
            NSMutableArray *optionArr = [@[] mutableCopy];
            for (int i = 1; i <= 4; i ++) {
                NSString *str = [NSString stringWithFormat:@"answer%d", i];
                [optionArr addObject:[obj objectForKey:str]];
            }
            //随机选项
            dict[@"option"] = [dataManager mixtureOptionDataArray:optionArr];
            //固定选项
            // dict[@"option"] = optionArr;
            
            [_kTitleArr addObject:dict];
        }
        [SVProgressHUD dismiss];
        
        
        _kTableView.tableViewDataSource = [dataManager mixtureOptionDataArray:_kTitleArr];
        
        
    }];
}

// 修改状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

// 弹出alertView代理方法
- (void)finishAnswerActivity:(int)score {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"答题完成" message:[NSString stringWithFormat:@"您本次总共获得了%d分", score] preferredStyle:UIAlertControllerStyleAlert];
    // 确定
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
            BmobUser *bUser = [BmobUser currentUser];
            [bUser setObject:[NSNumber numberWithInt:score] forKey:@"score"];
            [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                NSLog(@"error %@",[error description]);
            }];
        }];
    }];
    
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
