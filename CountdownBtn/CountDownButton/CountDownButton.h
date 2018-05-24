//
//  CountDownButton
//
//  Created by tanjianzhong on 2018/5/24.
//  Copyright © 2018年 tanjianzhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownButton : UIButton

/**
 验证码倒计时的时长
 */
@property (nonatomic, assign) NSInteger durationOfCountDown;

/**
 只是对 enable 的补充，可以让按钮在不满足条件的下，也可以有交互
 */
@property (nonatomic, assign) BOOL canTouch;

/**
 原始 字体颜色
 */
@property (nonatomic,strong) UIColor *originalColor;

/**
 原始 背景颜色
 */
@property (nonatomic,strong) UIColor *originalBgColor;

/**
 倒计时 字体颜色
 */
@property (nonatomic,strong) UIColor *processColor;

/**
 倒计时 背景颜色
 */
@property (nonatomic,strong) UIColor *processBgColor;
@end
