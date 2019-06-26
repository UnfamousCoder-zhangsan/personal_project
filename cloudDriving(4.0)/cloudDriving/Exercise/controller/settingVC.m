//
//  settingVC.m
//  cloudDriving
//
//  Created by apple on 2019/6/5.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "settingVC.h"

@interface settingVC ()
@property (nonnull, strong) UISwitch *switchView;

@end

@implementation settingVC{
    UIView *_bgView;
    UIView *_contentView;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //显示上个控制器的View
        self.modalPresentationStyle = UIModalPresentationCustom;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.view.backgroundColor = [UIColor clearColor];
    
    _bgView = [[UIView alloc] init];
    //_bgView.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:0.5f];
    _bgView.backgroundColor = [UIColor clearColor]; //背景颜色
    [self.view addSubview:_bgView];
    _bgView.alpha = 0.0f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBgView)];
    [_bgView addGestureRecognizer:tap];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    
    

    
    UILabel *jumpLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 150, 30)];
    jumpLabel.font = [UIFont systemFontOfSize:18];
    jumpLabel.text = @"答对跳转下一题";
    
     UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectMake(300, 20, 60, 30)];
    self.switchView = switchView;
    
    self.switchView.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"switchType"];
    
    if (self.switchView.isOn) {
        NSLog(@"打开状态");
    }else{
        NSLog(@"关闭状态");
    }
    [self.switchView addTarget:self action:@selector(didSwitch:) forControlEvents:UIControlEventValueChanged];
    
    
    UILabel *fontLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 80, 30)];
    fontLabel.font = [UIFont systemFontOfSize:18];
    fontLabel.text = @"字体大小";
    
    [_contentView addSubview:self.switchView];
    [_contentView addSubview:jumpLabel];
    [_contentView addSubview:fontLabel];
    
    //contentview 边框
    _contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    _contentView.layer.borderWidth = 1.0 ;
}

-(void)didSwitch:(id)sender{
    BOOL isOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"switchType"];
    
    isOn = ! isOn;
    [[NSUserDefaults standardUserDefaults] setBool:isOn forKey:@"switchType"];
    
    self.switchView.on = isOn;
}

#pragma mark - 在此方法做动画呈现
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _bgView.frame = [UIScreen mainScreen].bounds;
    _contentView.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height, CGRectGetWidth([UIScreen mainScreen].bounds), 250.0);
    
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.95 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _bgView.alpha = 1.0f ;
        
        _contentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 250.f, CGRectGetWidth([UIScreen mainScreen].bounds), 250.0f);
        [dataManager setBorderWithView:_contentView top:YES left:NO bottom:NO right:NO borderColor:[UIColor colorWithRed:238/255.0 green:233/255.0 blue:233/255.0 alpha:1.0] borderWidth:2];
        
    } completion:^(BOOL finished) {
    }];
}


#pragma mark - 消失
- (void)clickBgView
{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.95 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _bgView.alpha = 0.0f ;
        _contentView.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height, CGRectGetWidth([UIScreen mainScreen].bounds), 250.0);
        
    } completion:^(BOOL finished) {
        // 动画Animated必须是NO，不然消失之后，会有0.35s时间，再点击无效
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}



// 这里主动释放一些空间，加速内存的释放，防止有时候消失之后，再点不出来。
- (void)dealloc
{
   // NSLog(@"%@ --> dealloc",[self class]);
    [_bgView removeFromSuperview];
    _bgView = nil;
    [_contentView removeFromSuperview];
    _contentView = nil;
}



@end
