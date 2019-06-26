//
//  dataManager.m
//  cloudDriving
//
//  Created by apple on 2019/6/10.
//  Copyright © 2019 Harden. All rights reserved.
//

#import "dataManager.h"
#import <BmobSDK/Bmob.h>

@interface dataManager ()



@end

@implementation dataManager

+(NSArray *)getDataArray{
    NSMutableArray *dataMutablrArray = [@[] mutableCopy];
    static   NSArray  *dataArray;
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"DrivingSub1"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            NSMutableDictionary *dict = [@{} mutableCopy];
            dict[@"picture"] = [obj objectForKey:@"question_picture"];
            dict[@"id"] = [obj objectForKey:@"question_id"];
            dict[@"question"] = [obj objectForKey:@"question_content"];
            dict[@"answer"] = [obj objectForKey:@"rightAnswer"];
            dict[@"types"]   = [obj objectForKey:@"type"];
            dict[@"analysis"] = [obj objectForKey:@"question_analyzing"];
            NSMutableArray *optionArr = [@[] mutableCopy];
            for (int i = 1; i <= 4; i ++) {
                NSString *str = [NSString stringWithFormat:@"answer%d", i];
                [optionArr addObject:[obj objectForKey:str]];
            }
             dict[@"option"] = optionArr;
            
            [dataMutablrArray addObject:dict];
        }
        
        dataArray = dataMutablrArray;
        
        }];
    return dataArray;
}


+(NSArray *)mixtureOptionDataArray:(NSArray *)DataArray{
    int a = (int)DataArray.count;
    int numnum[a];
    NSMutableArray *numArr = [@[] mutableCopy];
    for (int i = 0; i < a; i ++) {
        int num = arc4random() % a;
        if ([numArr containsObject:@(num)]) {
            while (true) {
                num = arc4random() % a;
                if ([numArr containsObject:@(num)]) {
                    continue;
                } else {
                    [numArr addObject:@(num)];
                    numnum[i] = num;
                    break;
                }
            }
        } else {
            [numArr addObject:@(num)];
            numnum[i] = num;
        }
    }
    
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (int i = 0; i < a; i++) {
        [tempArr addObject:[DataArray objectAtIndex:numnum[i]]];
    }
    return tempArr;
}

+(void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}

+(CGSize)getSizeWithString:(NSString *)str with:(UIFont *)font withSize:(CGSize)size{
    CGSize newSize = [str sizeWithFont:font constrainedToSize:size];
    
    return newSize;
}

@end
