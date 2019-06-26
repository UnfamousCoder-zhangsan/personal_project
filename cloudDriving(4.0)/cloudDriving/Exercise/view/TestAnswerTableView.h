//
//  TestAnswerTableView.h
//  cloudDriving
//
//  Created by apple on 2019/6/10.
//  Copyright © 2019 Harden. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TestAnswerTableViewDelegate <NSObject>

-(void)finishAnswerActivity:(int)score;

@end

@interface TestAnswerTableView : UITableView<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong) NSArray *tableViewDataSource; //接收题库
@property (nonatomic, weak)   id<TestAnswerTableViewDelegate> tableDelegate;

@end

NS_ASSUME_NONNULL_END
