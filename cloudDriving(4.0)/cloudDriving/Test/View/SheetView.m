//
//  SheetView.m
//  cloudDriving
//
//  Created by apple on 2019/6/9.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "SheetView.h"

@interface  SheetView()
{
    UIView  *_backView;
    UIView  *_superView;
    BOOL  _startMoving;
    float _hight;
    float _width;
    float _y;
}

@end

@implementation SheetView

-(instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _superView = superView;
        _hight = frame.size.height;
        _width = frame.size.width;
        _y = frame.origin.y;
        [self creatView];
    }
    return self;
}

-(void)creatView{
    _backView = [[UIView alloc] initWithFrame: _superView.frame];
    _backView.backgroundColor = [UIColor grayColor];
    _backView.alpha = 0;
    [_superView addSubview:_backView];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    if (point.y < 25) {
        _startMoving = YES;
    }
    if (_startMoving && self.frame.origin.y >= _y - _hight) {
        self.frame = CGRectMake(0, [self convertPoint:point toView:_superView].y, _width, _hight);
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _startMoving = NO;
    if (self.frame.origin.y > _y - _hight/2) {
        [UIView animateWithDuration:0.3 animations:^{
           self.frame = CGRectMake(0, _y, _width, _hight);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, _y - _hight, _width, _hight);
        }];
    }
}

@end
