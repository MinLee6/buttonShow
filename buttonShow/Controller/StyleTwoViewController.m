//
//  StyleTwoViewController.m
//  buttonShow
//
//  Created by limin on 16/11/15.
//  Copyright © 2016年 君安信（北京）科技有限公司. All rights reserved.
//

#import "StyleTwoViewController.h"
#import "UIViewExt.h"
#define kTagMargin 14
#define kCellMargin 15
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define Color(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
@interface StyleTwoViewController ()
/* 按钮 */
@property(nonatomic,strong)NSMutableArray *btnsArray;
/* 按钮文字 */
@property(nonatomic,strong)NSArray *tagsArray;
/* 默认选择的按钮 */
@property(nonatomic,strong)UIButton *selectedBtn;
/* 标签 */
@property(nonatomic,copy)NSString *selectTopicTitle;
@end

@implementation StyleTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getTagMsg];
}
-(void)getTagMsg
{
    _btnsArray = [NSMutableArray array];
    //添加tag按钮
    NSArray *tagsArray = @[@"美好生活1",@"美好生活2",@"美好生活3",@"美好生活4",@"美好生活5",@"美好生活6",@"美好生活7",@"美好生活8",@"美好生活9",@"美好生活10",@"美好生活11",@"美好生活12",@"美好生活13",@"美好生活14",@"美好生活15",@"美好生活16",@"美好生活17",@"美好生活18",@"美好生活19",@"美好生活20",@"美好生活21",@"美好生活22",@"美好生活23",@"美好生活24"];
    _tagsArray = tagsArray;
    [self createTagSqures:tagsArray];
}
#pragma mark - 创建方块
-(void)createTagSqures:(NSArray *)tags
{
    //一行最多4个。
    int maxCols = 4;
    //宽度、高度
    CGFloat TotalWidth = kScreenWidth - 2*kCellMargin - (maxCols-1)*kTagMargin;
    CGFloat BtnWidth = TotalWidth / maxCols;
    CGFloat BtnHeight = 30;
    for (int i=0; i<tags.count; i++) {
        
        //创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = Color(211, 156, 4);
        //设置按钮属性
        [btn setBackgroundImage:[UIImage imageNamed:@"discover_btnbg"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"discover_btnbg"] forState:UIControlStateDisabled];
        btn.adjustsImageWhenHighlighted = NO;
        [btn setTitleColor:Color(51, 51, 51) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = i+10;
        
        // 监听点击
        [btn addTarget:self action:@selector(TagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //按钮赋值
        [btn setTitle:tags[i] forState:UIControlStateNormal];
        
        [self.view addSubview:btn];
        
        //计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        btn.x = kCellMargin + col*(BtnWidth + kTagMargin);
        btn.y = 40 + 11 + row * (BtnHeight + kTagMargin);
        btn.width = BtnWidth;
        btn.height = BtnHeight;
        //设置所有按钮默认状态为NO 。
        btn.enabled = YES;
        [self.btnsArray addObject:btn];
    }
    
    
    //默认第一个按钮为选中
    UIButton *btn = self.btnsArray[0];
    btn.enabled = NO;
    self.selectedBtn = btn;
    self.selectTopicTitle = self.tagsArray[0];
    //返回按钮
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-80)*0.5, self.view.height-160, 80, 80)];
    [btn2 setTitle:@"返回" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    btn2.layer.cornerRadius = 40;
    btn2.clipsToBounds = YES;
    btn2.layer.borderColor = [UIColor purpleColor].CGColor;
    btn2.layer.borderWidth = 2;
    [btn2 addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    //创建确认按钮
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(kCellMargin, btn2.top-80, kScreenWidth-2*kCellMargin, 44)];
    [btn3 setTitle:@"确认" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn3.backgroundColor = Color(214, 116, 0);
    [btn3 addTarget:self action:@selector(showSelectedClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
}
#pragma mark - 按钮点击事件
- (void)TagBtnClick:(UIButton *)button
{
    //获取点击的button，取消选中样式
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    
    NSInteger index = button.tag-10;
    NSString *selectStr = self.tagsArray[index];
    
    self.selectTopicTitle = selectStr;
    
}
-(void)showSelectedClick:(UIButton *)button
{
    //保留选择标签的文字
    NSLog(@"所选择的文字：%@",self.selectTopicTitle);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:self.selectTopicTitle message:@"" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
}
-(void)backBtnClick:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
