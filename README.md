# 一个倒计时的按钮

运行环境：XCode9, Mac OS X 10.13.4

 对UIbutton 的封装的一个倒计时按钮
 多用于获取验证码的时候
如图：
![预览图](1.gif)

#### 例子
代码

```    objc
_btn2 = [[CountDownButton alloc] init];
_btn2.durationOfCountDown = 60;
_btn2.canTouch = NO;

_btn2.frame = CGRectMake(80, 250, 140, 30);

[self.view addSubview:_btn2];
}

```
