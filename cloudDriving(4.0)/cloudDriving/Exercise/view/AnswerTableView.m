//
//  AnswerTableView.m
//  cloudDriving
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019 Harden. All rights reserved.


#import "AnswerTableView.h"
#import "AnswerTableViewCell.h"

static int titleNum;
static int score;

@implementation AnswerTableView{
    UIView *headView;
    UIView *footerView;
    UITextView *questionView;
    
}

- (id)init {
    self = [super init];
    [self initView];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    [self initView];
    return self;
}

- (void)initView {
    titleNum = 0;
    score = 0;
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"AnswerTableViewCell" bundle:nil] forCellReuseIdentifier:@"AnswerTableViewCell"];
    self.tableFooterView = [UIView new];
}

- (void)setTableViewDataSource:(NSArray *)tableViewDataSource {
    _tableViewDataSource = tableViewDataSource;
    [self reloadData];
    
    NSLog(@"%@",_tableViewDataSource);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_tableViewDataSource[titleNum][@"picture"] !=NULL) {
        return 260;
    }else{
    return 150;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
//    headView.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
    
    if (_tableViewDataSource[titleNum][@"picture"] !=NULL) {

        headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
        headView.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];

        NSURL *url1 = [NSURL URLWithString:@"https://bmob-cdn-26200.b0.upaiyun.com/2019/06/04/25065b53409f1c168086ed52d07b5b1f.jpg"];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 60, SCREEN_WIDTH-20, 200)];
        
        image.image = [UIImage imageWithData:data1];
        
        [headView addSubview:image];
        
        //富文本实现问题展示
        questionView= [[UITextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH -20, 60)];
        questionView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:250/255.0 alpha:1.0];
        //是否允许编辑
        questionView.editable = NO;
        //用户交互
        questionView.userInteractionEnabled = NO;
        questionView.delegate = self;
        [headView addSubview:questionView];
        
    }else{
        
        headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        headView.backgroundColor = [UIColor whiteColor];
        //headView.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1.0];
    
    //富文本实现问题展示
     questionView= [[UITextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH -20, 150)];
    questionView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:250/255.0 alpha:1.0];
    //是否允许编辑
    questionView.editable = NO;
    //用户交互
    questionView.userInteractionEnabled = NO;
    questionView.delegate = self;
    [headView addSubview:questionView];
    }
    
    NSString *type = [NSString stringWithFormat:@"%@",_tableViewDataSource[titleNum][@"types"]];
    NSString *test = [NSString stringWithFormat:@"2"];
    if ([type isEqualToString:test]) {
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:@"多选"];
        attachment.bounds = CGRectMake(0, -5, 20, 20);
        
        NSString *str = [NSString stringWithFormat:@" %@",_tableViewDataSource[titleNum][@"question"]];
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
        
        

    }else{
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [UIImage imageNamed:@"单选"];
        attachment.bounds = CGRectMake(0, -5, 20, 20);
        
        NSString *str = [NSString stringWithFormat:@" %@",_tableViewDataSource[titleNum][@"question"]];
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
        
      }
    return headView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
     footerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 300)];
    footerView.backgroundColor = [UIColor colorWithRed:238/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30) ];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"🔎  试题详解   ";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    [footerView addSubview:titleLabel];
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-20, 150)];
    footerLabel.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:footerLabel];
    NSString *analying = [NSString stringWithFormat:@"%@",_tableViewDataSource[titleNum][@"analysis"]];
    footerLabel.numberOfLines = 0;
    [footerLabel setLineBreakMode:NSLineBreakByWordWrapping];//自动换行
    footerLabel.text = analying;
    footerLabel.font = [UIFont systemFontOfSize:16];
    footerLabel.isTop =YES;
    footerView.hidden = YES;
    return footerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

//cell复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消灰色的背景颜色
    cell.selectLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    cell.cellTitleLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    
    cell.selectLabel.text = [NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];
    cell.cellTitleLabel.text = _tableViewDataSource[titleNum][@"option"][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerTableViewCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
    cell.selected = true;
    NSString *answerString = _tableViewDataSource[titleNum][@"answer"];
   // NSLog(@"点击了：%@ 正确答案：%@",cell.cellTitleLabel.text,answerString);
    NSLog(@"%d",score);
    if ([answerString isEqualToString:cell.cellTitleLabel.text]) {
        NSLog(@"点击了正确答案");
        titleNum ++;
        score += 1;
        //答对设置颜色
        cell.selectLabel.textColor = [UIColor greenColor];
        cell.cellTitleLabel.textColor = [UIColor greenColor];
        
        //所有题目都完成答题完成
        if (titleNum == _tableViewDataSource.count) {
            [[BmobUser currentUser] setObject:[NSString stringWithFormat:@"%d", titleNum] forKey:@"score"];
            [[BmobUser currentUser] updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                   // [_tableDelegate finishAnswerActivity:score];
                } else {
                    NSLog(@"error %@",[error description]);
                }
            }];
        } else {
            //全局刷新 跳转到下一题
           // [NSThread sleepForTimeInterval:0.6];
            [[BmobUser currentUser] setObject:[NSString stringWithFormat:@"%d",titleNum] forKey:@"score"];
            [[BmobUser currentUser] updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    //[_tableDelegate handPapaerActivity:score];
                } else {
                    NSLog(@"error %@",[error description]);
                }
            }];
            [self reloadData];

        }
    } else {
        //回答错误
        score --;
        cell.selectLabel.textColor = [UIColor colorWithRed:255/255.0 green:69/255.0 blue:0/255.0 alpha:1];
        cell.cellTitleLabel.textColor = [UIColor colorWithRed:255/255.0 green:69/255.0 blue:0/255.0 alpha:1];
       // cell.userInteractionEnabled = NO; //点击后无法选中
        //点击一次后显示正确解析与答案
        if ((footerView.hidden = YES)) {
            footerView.hidden = NO;
        }
        
    }
}


@end

