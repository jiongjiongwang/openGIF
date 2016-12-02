//
//  ViewController.m
//  OpenGIF
//
//  Created by dn210 on 16/11/23.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "ViewController.h"
#import "FWGIFImageView.h"
#import "BackView.h"

//屏幕的长度(固定值)
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()


@property (nonatomic,weak)FWGIFImageView *gifImage;

@property (nonatomic,weak)UIView *redView;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    //方法一:直接播放gif图
    //[self PlayGIF];
    
    //方法二:画图+动画的形式
    [self setUpOpen];
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:1 animations:^{
        
        self.redView.alpha = 0;
        
        
    } completion:^(BOOL finished) {
        
        
        
        
    }];
}




//方法一:直接播放gif图
-(void)PlayGIF
{
    FWGIFImageView *gifImage = [[FWGIFImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.gifImage = gifImage;
    
    [self.view addSubview:gifImage];
    
    
    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"splash" ofType:@"gif"];
    [gifImage setGIFPath:gifPath];
    gifImage.contentMode = UIViewContentModeScaleAspectFill;
    
    gifImage.animationRepeatCount = 1;
    
    [gifImage startAnimating];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repeatOneFinished:) name:kReapeatCountAnimationFinishedNotification object:nil];
}


- (void)repeatOneFinished:(NSNotification *)notification
{
    [UIView animateWithDuration:1 animations:^{
        
        self.gifImage.alpha = 0;
        
        
    } completion:^(BOOL finished) {
        
        [self.gifImage removeFromSuperview];
        
    }];
    
}

//方法二:画图+动画的形式
-(void)setUpOpen
{
    BackView *backView = [[BackView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    
    [self.view addSubview:backView];
    
    
    //加载图和动画
    [backView StartAnimate];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
