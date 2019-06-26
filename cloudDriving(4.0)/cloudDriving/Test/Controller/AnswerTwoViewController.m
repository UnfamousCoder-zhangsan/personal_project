//
//  AnswerTwoViewController.m
//  cloudDriving
//
//  Created by apple on 2019/6/9.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "AnswerTwoViewController.h"
#import "AnswerScrollView.h"
#import "settingVC.h"

@interface AnswerTwoViewController ()

@end

@implementation AnswerTwoViewController
{
    UIView *_kBarView;
    NSMutableArray *_kTitleQuestionArr;
    AnswerScrollView *_kScrollView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    _kTitleQuestionArr = [@[] mutableCopy];
    // Do any additional setup after loading the view.
    
    [self setBarView];

    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    self.view.backgroundColor = [UIColor redColor];


    _kScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) withDataArray:_testArray];
    [self.view addSubview:_kScrollView];
    
    
}

-(void)setBarView{
    
    _kBarView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:_kBarView];
    //背景色设置
    _kBarView.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
    //边框设置
    [dataManager setBorderWithView:_kBarView top:NO left:NO bottom:YES right:NO borderColor:[UIColor lightGrayColor] borderWidth:1];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 40, 25)];
    [leftButton addTarget:self action:@selector(rollbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    NSArray *array = [NSArray arrayWithObjects:@"答题模式",@"背题模式", nil];
    UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:array];
    segmented.frame = CGRectMake((SCREEN_WIDTH -100)/ 2 - 8, 30, 120, 25);
    segmented.selectedSegmentIndex = 0; //默认选中0
    segmented.tintColor = [UIColor whiteColor];
    [segmented addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 30, 40, 25)];
    [rightButton addTarget:self action:@selector(popSettingClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"设置" forState:UIControlStateNormal];
    
    
    [_kBarView addSubview:leftButton];
    [_kBarView addSubview:segmented];
    [_kBarView addSubview:rightButton];
}

-(void)setTestArray:(NSMutableArray *)testArray{
    _testArray = testArray;
    
    NSLog(@"%@",_testArray);
    
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
@end
