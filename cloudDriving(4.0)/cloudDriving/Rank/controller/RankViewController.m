//
//  RankViewController.m
//  cloudDriving
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "RankViewController.h"
#import "RankTableView.h"

@interface RankViewController ()

@end

@implementation RankViewController{
    RankTableView *_kTableView;
    UIView *_kBarView;
    UIView *_kBottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setBarView];
    
    [self getDataFromBmob];
}


-(void)setBarView{
    _kBarView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:_kBarView];
    _kBarView.backgroundColor = [UIColor orangeColor];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80)/2, 40, 80, 20)];
    [_kBarView addSubview:titleLabel];
    titleLabel.text = @"排行榜";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont systemFontOfSize:18]];
    titleLabel.textColor = [UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 35, 30, 30)];
    [_kBarView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(rollbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    _kTableView = [RankTableView new];
    [self.view addSubview:_kTableView];
}


- (void)getDataFromBmob {
    BmobQuery   *bquery = [BmobUser query]; //操作用户表
    [bquery orderByDescending:@"score"]; //排序
    [SVProgressHUD showWithStatus:@"请稍等..."];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSMutableArray *userArr = [@[] mutableCopy];
        for (BmobObject *obj in array) {
            NSMutableDictionary *dict = [@{} mutableCopy];
            dict[@"username"] = [obj objectForKey:@"username"];
            dict[@"score"] = [obj objectForKey:@"score"];
            [userArr addObject:dict];
        }
        [SVProgressHUD dismiss];
        [self arrSort:userArr];
        _kTableView.tableDataArray = userArr;
    }];
}

- (void)rollbackBtnClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)arrSort:(NSArray *)dataArr {
    int tempNum[dataArr.count];
    for (int i = 0; i < dataArr.count; i ++) {
        NSString *str = [dataArr objectAtIndex:i][@"score"];
        int tempInt = (int)[str integerValue];
        tempNum[i] =tempInt;
    }
    
//    for (int i = 0; i < dataArr.count; i++) {
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
