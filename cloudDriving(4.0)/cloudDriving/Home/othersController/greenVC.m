//
//  greenVC.m
//  cloudDriving
//
//  Created by apple on 2019/6/5.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "greenVC.h"

@interface greenVC ()

@end

@implementation greenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    // When the current trait collection changes (e.g. the device rotates),
    // update the preferredContentSize.
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
}


- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection
{
    // 左右留35
    // 上下留80
    
    CGFloat w = SCREEN_WIDTH - 35.f * 2;
    CGFloat h = SCREEN_HEIGHT - 80.f * 2;
    
    self.preferredContentSize = CGSizeMake(w,h);
}




- (void)dealloc
{
    //NSLog(@"%@ --> dealloc",[self class]);
}

@end
