//
//  AnswerTableView.h
//  cloudDriving
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019 Harden. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AnswerTableViewDelegate <NSObject>
@required
-(void)finishAnswerActivity:(int)score;

@optional
-(void)handPapaerActivity:(int)currrentScore;

@end

@interface AnswerTableView : UITableView<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong) NSArray *tableViewDataSource;
@property (nonatomic, weak)   id<AnswerTableViewDelegate> tableDelegate;

@end

NS_ASSUME_NONNULL_END
