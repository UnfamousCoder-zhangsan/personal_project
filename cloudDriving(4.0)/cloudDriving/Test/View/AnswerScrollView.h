//
//  AnswerScrollView.h
//  cloudDriving
//
//  Created by apple on 2019/6/9.
//  Copyright © 2019 Harden. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnswerScrollView : UIView{
    @public UIScrollView  *_scrollView;
}

@property (nonatomic,assign,readonly)int currentPage;


-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSMutableArray *)array;



@end

NS_ASSUME_NONNULL_END
