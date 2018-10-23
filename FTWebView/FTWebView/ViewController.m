//
//  ViewController.m
//  FTWebView
//
//  Created by wolffy on 2018/10/10.
//  Copyright © 2018年 派博在线（北京）科技有限责任公司. All rights reserved.
//

#import "ViewController.h"
#import "FTWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70 - 10, BJNEWS_SCREEN_NAVHEIGHT(20), 70, 44);
    [button setTitle:@"下一页" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rightButtonClick:(id)sender{
    FTWebViewController * vc = [[FTWebViewController alloc]init];
    vc.url = @"https://www.baidu.com";
    vc.title = @"网页";
    [self.navigationController pushViewController:vc animated:YES];
}


@end
