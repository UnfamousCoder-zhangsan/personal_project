//
//  RankTableViewCell.m
//  cloudDriving
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "RankTableViewCell.h"

@implementation RankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _userImage.layer.cornerRadius = _userImage.frame.size.width * 0.5; //设置圆角半径
    _userImage.layer.borderColor = [UIColor orangeColor].CGColor; //边框颜色
    _userImage.layer.borderWidth = 0.5;
    _userImage.clipsToBounds = YES;  //超出主层边框就要裁剪
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
