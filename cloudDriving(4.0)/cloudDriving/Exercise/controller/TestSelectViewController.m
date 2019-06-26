//
//  TestSelectViewController.m
//  cloudDriving
//
//  Created by apple on 2019/6/10.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "TestSelectViewController.h"
#import "TestSelectTableViewCell.h"
#import "TestSelectModel.h"

@interface TestSelectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIView *_kBarView;
    
}

@end

@implementation TestSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _kBarView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:_kBarView];
    _kBarView.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2 + 5, 40, 80, 20)];
    [_kBarView addSubview:titleLabel];
    titleLabel.text = @"章节练习";
    titleLabel.textColor = [UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 35, 40, 30)];
    [_kBarView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(rollbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = _myTitle;
    [self creatTableView];
}

-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)rollbackBtnClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId= @"TestSelectTableViewCell";
    TestSelectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius  = 8;
    }
   // TestSelectModel *model = _dataArray[indexPath.row];
    int  a = 1;
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",a];
    cell.titleLabel.text  = @"测试";
    
    return cell;
}

@end
