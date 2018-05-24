//
//  ViewController.m
//  CountdownBtn
//
//  Created by tanjianzhong on 2018/5/24.
//  Copyright © 2018年 tanjianzhong. All rights reserved.
//

#import "ViewController.h"
#import "CountDownButton.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTf;
@property (weak, nonatomic) IBOutlet CountDownButton *btn1;

@property (strong, nonatomic) CountDownButton *btn2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.phoneNumTf addTarget:self action:@selector(accoutBeginEdit:) forControlEvents:UIControlEventEditingChanged];
    
    self.btn1.originalColor = [UIColor whiteColor];
    self.btn1.originalBgColor = [UIColor lightGrayColor];
    self.btn1.processColor = [UIColor whiteColor];
    self.btn1.processBgColor = [UIColor grayColor];
    self.btn1.durationOfCountDown = 60;
    self.btn1.canTouch = NO;
    
    _btn2 = [[CountDownButton alloc] init];
    _btn2.durationOfCountDown = 60;
    _btn2.canTouch = NO;
    
    _btn2.frame = CGRectMake(80, 250, 140, 30);
    
    [self.view addSubview:_btn2];
}


- (void)accoutBeginEdit:(UITextField *)textField
{
    
    self.btn1.canTouch = self.phoneNumTf.text.length;
    self.btn2.canTouch = self.phoneNumTf.text.length;
}

@end
