//
//  ViewController.m
//  NotificationActionCenter
//
//  Created by YLCHUN on 16/9/3.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "ViewController.h"
#import "NotificationActionCenter.h"
#import "NAViewController.h"

@interface ViewController ()<NotificationActionCenterProtocol>
@property(nonatomic)UILabel *labContent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor=[UIColor whiteColor];
    NSString*title=[NSString stringWithFormat:@"vc-%ld",self.navigationController.viewControllers.count];
    self.title=title;
    [self bindingNotificationActionWithKeyId:title];
    
    self.labContent=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
    [self.view addSubview:self.labContent];
    
    UIButton*butNex=[[UIButton alloc]initWithFrame:CGRectMake(10, 110, 100, 50)];
    [butNex setTitle:@"nexVC" forState:UIControlStateNormal];
    butNex.backgroundColor=[UIColor redColor];
    [butNex addTarget:self action:@selector(butNextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butNex];
    
    UIButton*butNA=[[UIButton alloc]initWithFrame:CGRectMake(10, 170, 100, 50)];
    [butNA setTitle:@"butNA" forState:UIControlStateNormal];
    butNA.backgroundColor=[UIColor redColor];
    [butNA addTarget:self action:@selector(butNAAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butNA];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)butNextAction{
    ViewController *vc=[[ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}
-(void)butNAAction{
    NAViewController *vc=[[NAViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}
-(void)notificationActionWithName:(NSString*)name  object:(id) object userInfo:(NSDictionary*)userInfo{
    self.labContent.text=object;
}

@end
