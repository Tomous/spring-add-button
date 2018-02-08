//
//  ViewController.m
//  动画添加button
//
//  Created by wenhua on 2017/11/22.
//  Copyright © 2017年 wenhua. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "DCVerticalButton.h"
#import "POPSpringAnimation.h"
#import "POPBasicAnimation.h"
#import "NSString+Size.h"

static CGFloat const DCAnimationDelay = 0.1;
static CGFloat const DCSpringFactor = 7;
@interface ViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView *backgroundView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.width - 44)*0.5, (self.view.height - 44)*0.5, 64, 64)];
    [btn setTitle:@"😄点我" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
-(void)btnDidClick{
    [self setUpBackGroundView];
}
-(void)setUpBackGroundView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    backgroundView.userInteractionEnabled = YES;
    self.backgroundView = backgroundView;
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDidClick)];
    tap.delegate = self;
    [backgroundView addGestureRecognizer:tap];
    
    UIImageView *backgroundImage = [[UIImageView alloc]initWithFrame:backgroundView.bounds];
    backgroundImage.image = [UIImage imageNamed:@"active_bj"];
    backgroundImage.userInteractionEnabled = YES;
    [backgroundView addSubview:backgroundImage];
    
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake((backgroundImage.width - 44) * 0.5, backgroundImage.height - 44 *2, 44, 44)];
    [cancleBtn setImage:[UIImage imageNamed:@"built_click"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:cancleBtn];
    
    // 数据
//    NSArray *images = @[@"timg",@"班活图标fin_class_activity_workupload",@"班活图标fin_class_activity_workspoken",@"fin_class_activity_groupwork",@"班活图标fin_class_activity_vote-1",@"班活图标fin_class_activity_sign",@"班活图标_class_activity_QA"];
    NSArray *titles = @[@"你",@"就",@"说",@"我",@"帅",@"不",@"帅"];
    
    int maxCols = 3;
    CGFloat buttonW = self.backgroundView.width/3;
    CGFloat buttonH = 95;
    CGFloat buttonStartY = (self.backgroundView.height - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (self.backgroundView.width - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<titles.count; i++) {
        DCVerticalButton *button = [[DCVerticalButton alloc] init];
        
        button.margin = 10;
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:button];
        
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:50];
        
        CGRect frame = button.titleLabel.frame;
        NSString* title = titles[i];
        CGSize size = [title LE_sizeWithFont:14 MaxWidth:buttonW];
        frame.size = size;
        button.titleLabel.frame = frame;
        button.titleLabel.numberOfLines = 2;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:titles[i]] forState:UIControlStateNormal];
        
        // 计算X\Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - self.backgroundView.height;
        
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = DCSpringFactor;
        anim.springSpeed = DCSpringFactor;
        anim.beginTime = CACurrentMediaTime() + DCAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
    }
    
    
}

- (void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        
        if (button.tag == 0 || button.tag == 1 || button.tag == 2) {
            NSLog(@"0 1 2");
  
        }else if (button.tag == 3){
            NSLog(@"3");
            
        }else if (button.tag == 4){//投票
            
            NSLog(@"4");
            
        }else if (button.tag == 5){//签到
            
            NSLog(@"5");
        }else if (button.tag == 6){
            NSLog(@"6");
        }
        
        UIViewController *vv = [[UIViewController alloc]init];
        vv.view.backgroundColor = [UIColor lightGrayColor];
        [self.navigationController pushViewController:vv animated:YES];
        
    }];
}

/**
 * 先执行退出动画, 动画完毕后执行completionBlock
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    // 让控制器的view不能被点击
    self.backgroundView.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    
    for (int i = beginIndex; i<self.backgroundView.subviews.count; i++) {
        UIView *subview = self.backgroundView.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + [UIScreen mainScreen].bounds.size.height;
        // 动画的执行节奏(一开始很慢, 后面很快)
        //        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * DCAnimationDelay;
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.backgroundView.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                //                [self dismissViewControllerAnimated:NO completion:nil];
                self.backgroundView.hidden = YES;
                
                // 执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}
-(void)tapDidClick
{
    [self cancelWithCompletionBlock:nil];
}

-(void)cancleBtnDidClick
{
    [self cancelWithCompletionBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
