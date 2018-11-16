//
//  ViewController.m
//  webdemo2
//
//  Created by zhangqiang on 2018/11/16.
//  Copyright © 2018年 zhangqiang. All rights reserved.
//

#import "ViewController.h"
#import "XLWebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 350, 440, 44);
    leftButton.backgroundColor = [UIColor redColor];
    [leftButton addTarget:self action:@selector(sender:) forControlEvents:UIControlEventTouchUpInside];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [self.view addSubview:leftButton];
}

- (void)sender:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XLWebViewController *vc1=[[XLWebViewController alloc] init];
        [self.navigationController pushViewController:vc1 animated:YES];
    });
}
@end
