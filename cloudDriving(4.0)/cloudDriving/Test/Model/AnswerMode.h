//
//  AnswerMode.h
//  cloudDriving
//
//  Created by apple on 2019/6/9.
//  Copyright © 2019 Harden. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnswerMode : NSObject


@property (nonatomic ,copy)NSString *mquestion; //问题内容
@property (nonatomic ,copy)NSString *manalysis;    //解析
@property (nonatomic ,copy)NSString *mid; //题目id
@property (nonatomic ,copy)NSString *manswer; //正确答案
@property (nonatomic ,copy)NSString *mimage; //图片
@property (nonatomic ,copy)NSString *mtype;  //类型
@property (nonatomic ,copy)NSString *moptions; //选项

@end

NS_ASSUME_NONNULL_END
