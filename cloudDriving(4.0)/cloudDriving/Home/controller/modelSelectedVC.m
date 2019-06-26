//
//  modelSelectedVC.m
//  cloudDriving
//
//  Created by apple on 2019/6/3.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "modelSelectedVC.h"
#import "AnswerViewController.h"
#import "MainTestViewController.h"
#import "TestViewController.h"
#import "TestSelectViewController.h"
#import "RandomAnswerViewController.h"
#import "AnswerTwoViewController.h"

@interface modelSelectedVC ()
@property (weak, nonatomic) IBOutlet UIButton *onByOne; //顺序练习
@property (weak, nonatomic) IBOutlet UIButton *testButton; //模拟考试
@property (weak, nonatomic) IBOutlet UIButton *chapterBtn; //章节练习
@property (weak, nonatomic) IBOutlet UIButton *randomBtn;  //随机练习


@end

@implementation modelSelectedVC{
    UIView *_kBarView;
    NSMutableArray *_ceshidataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ceshidataArray = [@[] mutableCopy];
    // Do any additional setup after loading the view.
    
    [self setBarView];
    [self getDataWithBmob];
}
-(void)setBarView{
    _kBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    [self.view addSubview:_kBarView];
    _kBarView.backgroundColor = [UIColor orangeColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2 +10, 40, 80, 20)];
    [_kBarView addSubview:titleLabel];
    titleLabel.text = @"模式选择";
    titleLabel.textColor = [UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 35, 30, 30)];
    [_kBarView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(rollbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    self.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)oneByOneClick:(id)sender {
    [SVProgressHUD showWithStatus:@"请稍后..."];
    AnswerViewController *vc = [AnswerViewController new];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
}
- (IBAction)testButtonClick:(id)sender {
    MainTestViewController *vc = [MainTestViewController new];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
- (IBAction)chapterBtnClick:(id)sender {
//    TestSelectViewController *vc = [TestSelectViewController new];
//    [self presentViewController:vc animated:YES completion:^{
//
//    }];
    AnswerTwoViewController *vc = [AnswerTwoViewController new];
    
    vc.testArray = _ceshidataArray;
    
    
    [self presentViewController:vc animated:YES completion:^{
         
    }];
    
}
- (IBAction)randomBtnClick:(id)sender {
    RandomAnswerViewController *vc = [RandomAnswerViewController new];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
}


-(void)rollbackBtnClick{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark --获取试题--
-(void)getDataWithBmob{
    [SVProgressHUD showWithStatus:@"请稍后..."];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"DrivingSub1"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        
        
        for (BmobObject *obj in array) {
            NSMutableDictionary *dict = [@{} mutableCopy];
            dict[@"picture"] = [obj objectForKey:@"question_picture"];  //题目图片
            dict[@"id"] = [obj objectForKey:@"question_id"];            //题目id
            dict[@"question"] = [obj objectForKey:@"question_content"]; //问题内容
            dict[@"answer"] = [obj objectForKey:@"rightAnswer"];        //正确答案
            dict[@"types"]   = [obj objectForKey:@"type"];              //题目内型
            dict[@"analysis"] = [obj objectForKey:@"question_analyzing"]; //题目解析

            NSMutableArray *optionArr = [@[] mutableCopy];
            for (int i = 1; i <= 4; i ++) {
                NSString *str = [NSString stringWithFormat:@"answer%d",i];
                [optionArr addObject:[obj objectForKey:str]];
            }
            dict[@"option"] = optionArr;

            [_ceshidataArray addObject:dict];
        }
        
        [SVProgressHUD dismiss];
        
    }];
}


@end
