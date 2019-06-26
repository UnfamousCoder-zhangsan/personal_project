//
//  RankTableView.m
//  cloudDriving
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "RankTableView.h"
#import "RankTableViewCell.h"

@implementation RankTableView

- (id)init {
    self = [super init];
    [self initView];
    return self;
}

- (void)initView {
    self.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    
    
    [self registerNib:[UINib nibWithNibName:@"RankTableViewCell" bundle:nil] forCellReuseIdentifier:@"RankTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableDataArray.count;
}
//cell复用
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankTableViewCell" forIndexPath:indexPath];
    cell.rankLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
    cell.nameLabel.text = _tableDataArray[indexPath.row][@"username"];
    NSString *score = _tableDataArray[indexPath.row][@"score"];
    if (score!=NULL) {
        cell.scoreLabel.text = [NSString stringWithFormat:@"%@",score];
        cell.scoreLabel.textColor = [UIColor redColor];
    }else{
        cell.scoreLabel.text = score;
        cell.fen.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //cell不可点击
    return cell;
}

- (void)setTableDataArray:(NSArray *)tableDataArray {
    _tableDataArray = tableDataArray;
    [self reloadData];
}


@end
