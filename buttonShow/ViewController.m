//
//  ViewController.m
//  buttonShow
//
//  Created by limin on 16/11/15.
//  Copyright © 2016年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "StyleOneViewController.h"
#import "StyleTwoViewController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
}
/** 第一种样式 */
- (IBAction)showStyleOneClick:(UIButton *)sender
{
   StyleOneViewController *oneVC = [[StyleOneViewController alloc]init];
    [self presentViewController:oneVC animated:YES completion:nil];
}
/** 第二种样式 */
- (IBAction)showStyleTwoClick:(UIButton *)sender
{
    StyleTwoViewController *twoVC = [[StyleTwoViewController alloc]init];
    [self presentViewController:twoVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
