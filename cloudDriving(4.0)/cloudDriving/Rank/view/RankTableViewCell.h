//
//  RankTableViewCell.h
//  cloudDriving
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019 Harden. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; //用户名
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel; //得分
@property (weak, nonatomic) IBOutlet UILabel *fen;  

@property (weak, nonatomic) IBOutlet UIImageView *userImage; //用户头像

@end

NS_ASSUME_NONNULL_END
