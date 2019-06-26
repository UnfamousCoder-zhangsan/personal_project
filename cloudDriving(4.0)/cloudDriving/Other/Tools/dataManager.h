//
//  dataManager.h
//  cloudDriving
//
//  Created by apple on 2019/6/10.
//  Copyright © 2019 Harden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface dataManager : NSObject

+(NSArray *)getDataArray;

+(NSArray *)mixtureOptionDataArray:(NSArray *)DataArray;

//设置边框线的方法
+(void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

//根据内容长度设置View高度
+(CGSize)getSizeWithString:(NSString *)str with:(UIFont *)font withSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
