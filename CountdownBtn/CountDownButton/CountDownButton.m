//
//  CountdownBtn.m
//
//  Created by tanjianzhong on 2018/5/24.
//  Copyright © 2018年 tanjianzhong. All rights reserved.
//
#import "CountDownButton.h"

#import "MBProgressHUD.h"

@interface CountDownButton ()

/** 保存起始状态下的title */
@property (nonatomic, copy) NSString *originalTitle;
/** 保存倒计时的时长 */
@property (nonatomic, assign) NSInteger tempDurationOfCountDown;
/** 定时器对象 */
@property (nonatomic, strong) NSTimer *ccpCountDownTimer;


/** 避免开始计时时快速连续点击显示问题 */
@property (nonatomic,assign) int count;

@end

@implementation CountDownButton

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    // 倒计时过程中title的改变不更新originalTitle
    if (self.tempDurationOfCountDown == self.durationOfCountDown) {
        self.originalTitle = title;
        
        self.originalColor = self.titleLabel.textColor;
    }
}


- (void)setDurationOfCountDown:(NSInteger)durationOfCountDown {
    _durationOfCountDown = durationOfCountDown;
    self.tempDurationOfCountDown = _durationOfCountDown;
}


- (void)setOriginalColor:(UIColor *)originalColor {
    _originalColor = originalColor;
    [self setTitleColor:originalColor forState:UIControlStateNormal];
}
- (void)setOriginalBgColor:(UIColor *)originalBgColor
{
    _originalBgColor = originalBgColor;
    [self setBackgroundColor:originalBgColor];
}


- (void)setProcessColor:(UIColor *)processColor {
    _processColor = processColor;
}
- (void)setProcessBgColor:(UIColor *)processBgColor
{
    _processBgColor = processBgColor;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //默认颜色红色
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.count = 0;
        // 设置默认的倒计时时长为60秒
        self.durationOfCountDown = 60;
        // 设置button的默认标题为“获取验证码”
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //默认颜色红色
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.count = 0;
        // 设置默认的倒计时时长为60秒
        self.durationOfCountDown = 60;
        // 设置button的默认标题为“获取验证码”
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return self;
}


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    //在设置不能点击的条件下，做出提示
    if (!self.canTouch) {
        [self hudWithStr:@"请输入正确的手机号"];
        return NO;
    }
    self.count ++;
    // 若正在倒计时，不响应点击事件
    if (self.tempDurationOfCountDown != self.durationOfCountDown||self.count != 1) {
        self.count = 0;
        [self HUDinfo];
        return NO;
    }
    // 若未开始倒计时，响应并传递点击事件，开始倒计时
    [self startCountDown];
    return [super beginTrackingWithTouch:touch withEvent:event];
}

//创建定时器，开始倒计时
- (void)startCountDown {
    // 创建定时器
    self.ccpCountDownTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateCCPCountDownButtonTitle) userInfo:nil repeats:YES];
    // 将定时器添加到当前的RunLoop中（自动开启定时器）
    [[NSRunLoop currentRunLoop] addTimer:self.ccpCountDownTimer forMode:NSRunLoopCommonModes];
}
//更新CCPCountDownButton的title为倒计时剩余的时间
- (void)updateCCPCountDownButtonTitle {
    if (self.tempDurationOfCountDown == 0) {

        // 设置CCPCountDownButton的title为开始倒计时前的title
        [self setTitle:self.originalTitle forState:UIControlStateNormal];
        [self setTitleColor:self.originalColor forState:UIControlStateNormal];
        
        if (self.originalBgColor) {
            [self setBackgroundColor:self.originalBgColor];
        }else{
            [self setBackgroundColor:[UIColor whiteColor]];
        }

        // 恢复CCPCountDownButton开始倒计时
        self.tempDurationOfCountDown = self.durationOfCountDown;
        [self.ccpCountDownTimer invalidate];
        self.ccpCountDownTimer = nil;
        self.count = 0;
    } else {
        // 设置CCPCountDownButton的title为当前倒计时剩余的时间
        [self setTitle:[NSString stringWithFormat:@"重新获取(%zd)", self.tempDurationOfCountDown--] forState:UIControlStateNormal];
        
        if (self.processBgColor) {
            [self setBackgroundColor:self.processBgColor];
        }else{
            [self setBackgroundColor:[UIColor grayColor]];
        }
        
        if (self.processColor) {
            
            [self setTitleColor:self.processColor forState:UIControlStateNormal];
            
        } else {
            //默认颜色 蓝色
            [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

        }
    }
}

- (void)HUDinfo {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = [NSString stringWithFormat:@"%lds之内请勿重复操作",(long)self.tempDurationOfCountDown];
    [hud hideAnimated:YES afterDelay:2.f];
}
- (void)hudWithStr:(NSString *)str {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = str;

    [hud hideAnimated:YES afterDelay:2.f];
}



- (void)dealloc {
    
    [self.ccpCountDownTimer invalidate];
}


@end
