//
//  noticeVC.m
//  cloudDriving
//
//  Created by apple on 2019/6/5.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "noticeVC.h"

@interface noticeVC ()
@property (weak, nonatomic) IBOutlet UITextView *noticeText;

@end

@implementation noticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
    [self.noticeText scrollRangeToVisible:NSMakeRange(0, 0)];
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
    
    CGFloat w = self.view.bounds.size.width - 35.f * 2;
    CGFloat h = self.view.bounds.size.height - 80.f * 2;
    
    self.preferredContentSize = CGSizeMake(w,h);
}




- (void)dealloc
{
   // NSLog(@"%@ --> dealloc",[self class]);
}

@end
