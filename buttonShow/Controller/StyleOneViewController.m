//
//  StyleOneViewController.m
//  buttonShow
//
//  Created by limin on 15/06/15.
//  Copyright © 2015年 信诺汇通信息科技(北京)有限公司. All rights reserved.
//

#import "StyleOneViewController.h"
#import "UIViewExt.h"
//每列间隔
#define KViewMargin 10
//每行列数高
#define KVieH 28

#define KscreenW [UIScreen mainScreen].bounds.size.width
#define Color(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
@interface StyleOneViewController ()
{
    UIButton *tmpBtn;
    CGFloat btnW;
    CGFloat btnViewHeight;
}
/* 存放按钮的view */
@property(nonatomic,strong)UIView *btnsView;
/* 按钮上的文字 */
@property(nonatomic,strong)NSMutableArray *btnMsgArrays;
@property (nonatomic,strong) NSMutableArray* btnIDArrays;
/** 所有按钮 */
@property(nonatomic,strong)NSMutableArray *allBtnArrays;
/** 服务器提供按钮标签 */
@property(nonatomic,strong)NSArray *tagInfoArray;
//-------展示选中的文字
/* 确认按钮 */
@property(nonatomic,strong)UIButton *sureButton;
/* 文字 */
@property(nonatomic,strong)UILabel *showLabel;
@end

@implementation StyleOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getTagMsg];
    
}
-(void)getTagMsg
{
    self.btnMsgArrays = [[NSMutableArray alloc]init];
    _allBtnArrays = [[NSMutableArray alloc]init];
    self.btnIDArrays = [[NSMutableArray alloc]init];
    self.tagInfoArray = @[@{@"id":@"1",@"tagmsg":@"味道很好味道很好"},
                          @{@"id":@"1",@"tagmsg":@"环境不错"},
                          @{@"id":@"1",@"tagmsg":@"性价比高"},
                          @{@"id":@"1",@"tagmsg":@"位置好找"},
                          @{@"id":@"1",@"tagmsg":@"上菜快"},
                          @{@"id":@"1",@"tagmsg":@"菜量足"},
                          @{@"id":@"1",@"tagmsg":@"好吃"},
                          @{@"id":@"1",@"tagmsg":@"态度好，服务周到"}
                          ];
    
    //挨个赋值
    for (int i=0; i<_tagInfoArray.count; i++) {
        NSDictionary *dict = _tagInfoArray[i];
        [self.btnIDArrays addObject:dict[@"id"]];
        [self.btnMsgArrays addObject:dict[@"tagmsg"]];
    }
    [self createBtns];
}
//创建按钮
-(void)createBtns{
    //创建放置button的view
    self.btnsView = [[UIView alloc]initWithFrame:CGRectMake(10, 40, KscreenW-2*KViewMargin, 40)];
    self.btnsView.backgroundColor = Color(237, 237, 237);
    [self.view addSubview:self.btnsView];
    /**
     *  数组存放适配屏幕大小的每行按钮的个数
     */
    NSMutableArray *indexbtns=[self returnBtnsForRowAndCol];
    //统计按钮View的高度
    btnViewHeight=indexbtns.count*(KVieH+KViewMargin)+10;
    
    //设置btnView的高度
    self.btnsView.height=btnViewHeight;
    
    NSInteger count=0;
    CGFloat Y;
    
    //循环创建按钮
    for (int row=0; row<indexbtns.count; row++) {
        for (int col=0; col<[indexbtns[row]intValue]; col++) {
            
            CGFloat X;
            Y=10+row*(KViewMargin+KVieH);
            
            //按钮的宽
            btnW=[self returnBtnWithWithStr:self.btnMsgArrays[count]];
            
            if (tmpBtn&&col) {
                X=CGRectGetMaxX(tmpBtn.frame)+KViewMargin;
            }else{
                X=KViewMargin+col*btnW;
            }
            
            
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(X, Y, btnW, KVieH)];
            
            [btn setTitle:self.btnMsgArrays[count] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:12];
            btn.layer.borderWidth=1;
            btn.layer.borderColor = Color(156,156,156).CGColor;
            
            [btn setTitleColor:Color(156, 156, 156) forState:UIControlStateNormal];
            [btn setTitleColor:Color(202, 48, 130) forState:UIControlStateSelected];
            btn.backgroundColor=[UIColor clearColor];
            btn.layer.cornerRadius=2;
            btn.tag=[self.btnIDArrays[count] integerValue];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.allBtnArrays addObject:btn];
            tmpBtn=btn;
            [self.btnsView addSubview:btn];
            count+=1;
        }
    }
    
    //创建确认按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(KViewMargin, self.btnsView.bottom+40, KscreenW-2*KViewMargin, 44)];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = Color(214, 116, 0);
    [btn addTarget:self action:@selector(showSelectedClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sureButton = btn;
    [self.view addSubview:btn];
    //返回按钮
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake((KscreenW-80)*0.5, self.view.height-80, 80, 80)];
    [btn2 setTitle:@"返回" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    btn2.layer.cornerRadius = 40;
    btn2.clipsToBounds = YES;
    btn2.layer.borderColor = [UIColor purpleColor].CGColor;
    btn2.layer.borderWidth = 2;
    [btn2 addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
}
#pragma mark-返回view中有几行几列按钮
-(NSMutableArray*)returnBtnsForRowAndCol{
    CGFloat allWidth = 0.0;
    NSInteger countW=0;
    NSMutableArray *indexbtns=[NSMutableArray array];
    NSMutableArray *tmpbtns=[NSMutableArray array];
    for (int j=0;j<self.btnMsgArrays.count;j++) {
        CGFloat width=[self returnBtnWithWithStr:self.btnMsgArrays[j]];
        allWidth+=width+KViewMargin;
        countW+=1;
        if (allWidth>KscreenW-10) {
            //判断第一行情况
            NSInteger lastNum=[[tmpbtns lastObject]integerValue];
            [indexbtns addObject:@(lastNum)];
            
            [tmpbtns removeAllObjects];
            allWidth=0.0;
            countW=0;
            j-=1;
        }else{
            [tmpbtns addObject:@(countW)];
            
        }
        
    }
    if (tmpbtns.count!=0) {
        NSInteger lastNum=[[tmpbtns lastObject]integerValue];
        [indexbtns addObject:@(lastNum)];
    }
    return indexbtns;
}
-(CGFloat)returnBtnWithWithStr:(NSString *)str{
    //计算字符长度
    NSDictionary *minattributesri = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize mindetailSizeRi = [str boundingRectWithSize:CGSizeMake(100, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:minattributesri context:nil].size;
    return mindetailSizeRi.width+12;
    
}
#pragma mark-按钮点击事件
-(void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
    if (btn.isSelected) {
        btn.layer.borderColor = Color(202, 48, 130).CGColor;
    }else
    {
        btn.layer.borderColor = Color(156, 156, 156).CGColor;
    }
}
-(void)showSelectedClick:(UIButton *)btn
{
    NSMutableArray *strArray = [[NSMutableArray alloc]init];
    for (UIButton *btn in self.allBtnArrays) {
        if (btn.isSelected) {
            [strArray addObject:btn.currentTitle];
        }
    }
    NSString *str = [strArray componentsJoinedByString:@" & "];
    UIFont *font = [UIFont systemFontOfSize:14];
    CGFloat strH = [str boundingRectWithSize:CGSizeMake(KscreenW-2*KViewMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
    //展示文字
    if (!self.showLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(KViewMargin, self.sureButton.bottom+20, KscreenW-2*KViewMargin, strH)];
        label.font = font;
        label.textColor = [UIColor redColor];
        label.numberOfLines = 0;
        self.showLabel = label;
        [self.view addSubview:label];
    }
    self.showLabel.text = str;
    self.showLabel.height = strH;
    
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
