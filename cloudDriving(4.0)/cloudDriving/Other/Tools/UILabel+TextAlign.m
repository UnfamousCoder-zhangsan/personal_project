//
//  UILabel+TextAlign.m
//  cloudDriving
//
//  Created by apple on 2019/6/2.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "UILabel+TextAlign.h"

@implementation UILabel (TextAlign)

-(void)setIsTop:(BOOL)isTop{
    if (isTop) {
        CGSize fontSize = [self.text sizeWithFont:self.font];
        
        int num = self.frame.size.height/fontSize.height;
        
        int newLinesToPad = num - self.numberOfLines;
        
        self.numberOfLines = 0;
        
        for (int i=0; i < newLinesToPad; i++) {
            self.text = [self.text stringByAppendingString:@"\n"];
        }
    }
}

@end
