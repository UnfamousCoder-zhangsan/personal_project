//
//  AnswerScrollView.m
//  cloudDriving
//
//  Created by apple on 2019/6/9.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "AnswerScrollView.h"
#import "AnswerMode.h"
#import "AnswerTwoTableViewCell.h"
#import "AnswerTwoViewController.h"

#define SIZE  self.frame.size

@interface AnswerScrollView ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>{
    
}

@end

@implementation AnswerScrollView
{
    UITableView  *_leftTableView;
    UITableView  *_mainTableView;
    UITableView  *_rightTableView;
    NSMutableArray      *_dataArr;
    NSMutableArray *_handAnswerArray;
    UITextView *questionView;
    UIView *_headView; //tableView 头部
    UIView *_footerView; //tableView 尾部
    
}

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSMutableArray *)array{
    self  =[super initWithFrame:frame];
    if (self) {
        _currentPage = 0;
        _dataArr = [[NSMutableArray alloc] initWithArray:array];
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.delegate = self;
        
        _leftTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _rightTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.dataSource  = self;
        _leftTableView.delegate    = self;
        _mainTableView.dataSource  = self;
        _mainTableView.delegate    = self;
        _rightTableView.dataSource = self;
        _rightTableView.delegate   = self;
        
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        if (_dataArr.count > 1) {
            
            _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *2, 0);
        }
        
        [self creatView];
    }
    return self;
}

-(void)creatView{
    _leftTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64);
    _mainTableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64);
    _rightTableView.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64);
    
    _leftTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _rightTableView.backgroundColor = [UIColor whiteColor];
    
    [_scrollView addSubview:_leftTableView];
    [_scrollView addSubview:_mainTableView];
    [_scrollView addSubview:_rightTableView];
    
    [self addSubview:_scrollView];
}


#pragma mark  -tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    NSString *str = _dataArr[_currentPage][@"question"];
    UIFont *font = [UIFont systemFontOfSize:17];
    CGFloat height = [dataManager getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width - 20, 400)].height +30;
    if (height <= 80) {
        return 80;
    }else{
        return height;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSString *str = _dataArr[_currentPage][@"analysis"];
    UIFont *font = [UIFont systemFontOfSize:17];
    CGFloat height = [dataManager getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width - 20, 400)].height +30;
    if (height <= 80) {
        return 80;
    }else{
        return height;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark -- head 设置
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *str1 = _dataArr[_currentPage][@"question"];
    UIFont *font = [UIFont systemFontOfSize:17];
    CGFloat height = [dataManager getSizeWithString:str1 with:font withSize:CGSizeMake(tableView.frame.size.width - 20, 400)].height + 30;
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width - 20, height)];
    _headView.backgroundColor = [UIColor whiteColor];
    
    
    //富文本实现问题展示
    questionView= [[UITextView alloc] initWithFrame:CGRectMake(10, 10, tableView.frame.size.width - 20, height)];
    questionView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:250/255.0 alpha:1.0];
    //是否允许编辑
    questionView.editable = NO;
    //用户交互
    questionView.userInteractionEnabled = NO;
    questionView.delegate = self;
    [_headView addSubview:questionView];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"单选"];
    attachment.bounds = CGRectMake(0, -5, 20, 20);
    
    NSString *str = [NSString stringWithFormat:@" %@",_dataArr[_currentPage][@"question"]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    //设置字号
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, attributedString.length)];
    
    //设置行间距
    NSMutableParagraphStyle *parStyle = [[NSMutableParagraphStyle alloc] init];
    
    parStyle.lineSpacing = 10; //字体行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:parStyle range:NSMakeRange(0, attributedString.length)];
    
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    [attributedString insertAttributedString:attachmentString atIndex:0];
    
    //设置attributedText
    questionView.attributedText = attributedString;
    
    return _headView;
}

#pragma mark ---footerView --

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    NSString *str = _dataArr[_currentPage][@"analysis"];
    UIFont *font = [UIFont systemFontOfSize:17];
    CGFloat height = [dataManager getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width - 20, 400)].height +30;
    
    _footerView= [[UIView alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width - 20, height)];
    _footerView.backgroundColor = [UIColor colorWithRed:238/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width - 20, 30) ];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"🔎  试题详解   ";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    [_footerView addSubview:titleLabel];
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, tableView.frame.size.width - 20, height)];
    footerLabel.backgroundColor = [UIColor whiteColor];
    [_footerView addSubview:footerLabel];
    NSString *analying = [NSString stringWithFormat:@"%@",_dataArr[_currentPage][@"analysis"]];
    footerLabel.numberOfLines = 0;
    [footerLabel setLineBreakMode:NSLineBreakByWordWrapping];//自动换行
    footerLabel.text = analying;
    footerLabel.font = [UIFont systemFontOfSize:17];
    footerLabel.isTop =NO;
    _footerView.hidden = NO;
    return _footerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"AnswerTwoTableViewCell";
    AnswerTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnswerTwoTableViewCell" owner:self options:nil] lastObject];
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius = 10;
    }
    cell.numberLabel.text = [NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];
    AnswerMode *model1 = [[AnswerMode alloc] init];
    if (tableView == _leftTableView && _currentPage == 0) {
        model1 =  _dataArr[_currentPage];
    }else if (tableView == _leftTableView  && _currentPage >0){
        model1 = _dataArr[_currentPage - 1] ;
    }else if (tableView  == _mainTableView && _currentPage == 0){
        model1 = _dataArr[_currentPage + 1];
    }else if (tableView == _mainTableView  && _currentPage > 0 && _currentPage < _dataArr.count - 1){
        model1 = _dataArr[_currentPage];
    }else if (tableView == _mainTableView  && _currentPage == _dataArr.count - 1){
        model1 = _dataArr[_currentPage - 1];
    }else if (tableView == _rightTableView && _currentPage == _dataArr.count - 1){
        model1 = _dataArr[_currentPage];
    }else if (tableView == _rightTableView && _currentPage < _dataArr.count - 1){
        model1 = _dataArr[_currentPage + 1];
    }
     cell.answerlabel.text = _dataArr[_currentPage][@"option"][indexPath.row];

    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint currentOffset = scrollView.contentOffset;
    int page = (int)currentOffset.x / SIZE.width;
    if (page < _dataArr.count -1 && page > 0) {
        _scrollView.contentSize = CGSizeMake(currentOffset.x + SCREEN_WIDTH * 2, 0);
        _mainTableView.frame = CGRectMake(currentOffset.x, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _leftTableView.frame = CGRectMake(currentOffset.x - SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _rightTableView.frame = CGRectMake(currentOffset.x + SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    _currentPage = page;
    [self reloadData];
}

-(void)reloadData{
    
    [_leftTableView reloadData];
    [_mainTableView  reloadData];
    [_rightTableView reloadData];
}



@end
