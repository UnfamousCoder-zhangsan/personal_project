//
//  AnswerViewController.m
//  cloudDriving
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "AnswerViewController.h"
//#import <BmobSDK/Bmob.h>
#import "TestAnswerTableView.h"
#import "settingVC.h"



@interface AnswerViewController () <TestAnswerTableViewDelegate>

@end

@implementation AnswerViewController{
    UITextView *_kTitleTextView;
    UIView *_kBarView;
    UIView *_kBottomView;
    NSMutableArray *_kTitleArr;
    TestAnswerTableView  *_kTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _kTitleArr = [@[] mutableCopy];
    
    //_kTableView.tableViewDataSource = [dataManager getDataArray];

    [self setKBarView];
    [self setBottomView];
    [self setTableView];
    
    
    [self getDataWithBmob];
    
}
#pragma mark --BarView | bottom 布局设置
-(void)setKBarView{
     _kBarView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:_kBarView];
    _kBarView.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
    //边框设置
    [dataManager setBorderWithView:_kBarView top:NO left:NO bottom:YES right:NO borderColor:[UIColor colorWithRed:238/255.0 green:233/255.0 blue:233/255.0 alpha:1.0] borderWidth:1];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 40, 30)];
    [leftButton addTarget:self action:@selector(rollbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    NSArray *array = [NSArray arrayWithObjects:@"答题模式",@"背题模式", nil];
    UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:array];
    segmented.frame = CGRectMake((SCREEN_WIDTH -100)/ 2 - 8, 30, 120, 30);
    segmented.selectedSegmentIndex = 0; //默认选中0
    segmented.tintColor = [UIColor whiteColor];
    [segmented addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 30, 40, 30)];
    [rightButton addTarget:self action:@selector(popSettingClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"设置" forState:UIControlStateNormal];
    
    
    [_kBarView addSubview:leftButton];
    [_kBarView addSubview:segmented];
    [_kBarView addSubview:rightButton];
    
    
}

-(void)setTableView{
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _kTableView = [[TestAnswerTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:UITableViewStyleGrouped];
    _kTableView.separatorStyle = UITableViewCellSeparatorStyleNone; //去除UITableView横线
    _kTableView.tableDelegate = self;
    [self.view addSubview:_kTableView];
}

-(void)setBottomView{
    _kBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    [self.view addSubview:_kBottomView];
    _kBottomView.backgroundColor = [UIColor whiteColor];
    [dataManager setBorderWithView:_kBottomView top:YES left:NO bottom:NO right:NO borderColor:[UIColor colorWithRed:238/255.0 green:233/255.0 blue:233/255.0 alpha:1.0] borderWidth:1];
    
    UIButton *collect = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 60, 40)];
    [collect setTitle:@"收藏" forState:UIControlStateNormal];
    [collect setTitle:@"已收藏" forState:UIControlStateSelected];
    collect.backgroundColor = [UIColor orangeColor];
    
    [_kBottomView addSubview:collect];
    
    
}


-(void)change:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"答题模式");
    }else if(sender.selectedSegmentIndex == 1){
        NSLog(@"背题模式");
    }
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
        
        
        _kTableView.tableViewDataSource = _kTitleArr;
        
        NSLog(@"%@",_kTitleArr);
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
