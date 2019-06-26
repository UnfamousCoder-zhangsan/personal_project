//
//  RankTableView.h
//  cloudDriving
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019 Harden. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *tableDataArray;

@end

NS_ASSUME_NONNULL_END
