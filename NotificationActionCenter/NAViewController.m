//
//  NAViewController.m
//  NotificationActionCenter
//
//  Created by YLCHUN on 16/9/3.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "NAViewController.h"
#import "NotificationActionCenter.h"
//#import "ViewController.h"
@interface NAViewController ()
@property(nonatomic)UITextField *textField;
@property(nonatomic)UITextView*textView;
@end

@implementation NAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton*butSend=[[UIButton alloc]initWithFrame:CGRectMake(10, 160, 100, 50)];
    [butSend setTitle:@"butSend" forState:UIControlStateNormal];
    butSend.backgroundColor=[UIColor redColor];
    [butSend addTarget:self action:@selector(butSendAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butSend];
    
    self.textField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
    self.textField.borderStyle=UITextBorderStyleLine;
    self.textField.placeholder=@"控制器名称";
    self.textField.text=@"vc-";
    [self.view addSubview:self.textField];
    
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), 100)];
    self.textView.text=@"测试内容";
    [self.view addSubview:self.textView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)butSendAction{
    [NACenter pushNotificationActionWithName:@"text" targetNow:true toVCClass:NSClassFromString(@"ViewController") keyId:self.textField.text object:self.textView.text userInfo:nil];
    [self.view endEditing:true];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
