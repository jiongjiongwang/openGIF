//
//  BackView.m
//  OpenGIF
//
//  Created by dn210 on 16/11/30.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "BackView.h"
#import "Masonry.h"

@interface BackView()

@property (nonatomic,weak)UIImageView *iconImage;

@property (nonatomic,weak)UILabel *iconLabel;

@property (nonatomic,assign)BOOL isAnimate;

@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic,assign)CGFloat angle;

//间隔时间(不断变化的)
@property (nonatomic,assign)CGFloat angleInterval;

//上一个时间(更新为前一个时间)
@property (nonatomic,assign)CGFloat preAngleInterval;

@property (nonatomic,assign)NSInteger maxNum;


@end


@implementation BackView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        //布局界面
        [self setUpUI];
        
        _angle = 0;
        
        _angleInterval = 0.01;
        
        _preAngleInterval = 0.01;
        
        _maxNum = 0;
        
    }
    
    return self;
}


//布局界面
-(void)setUpUI
{
    //1-设置背景
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back"]];
    
    //2-添加图标
    UIImageView *iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Guicon"]];
    
    self.iconImage = iconImage;
    
    [iconImage sizeToFit];
    
    iconImage.alpha = 0;
    
    [self addSubview:iconImage];
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX);
        
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    
    
    //3-添加label
    UILabel *iconLabel = [[UILabel alloc] init];
    
    self.iconLabel = iconLabel;
    
    [iconLabel setText:@"友鼓轻松学"];
    
    [iconLabel setTextAlignment:NSTextAlignmentCenter];
    
    [iconLabel setFont:[UIFont systemFontOfSize:18]];
    
    [iconLabel setTextColor:[UIColor whiteColor]];
    
    iconLabel.alpha = 0;
    
    
    [self addSubview:iconLabel];
    
    [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX);
        
        make.top.equalTo(iconImage.mas_bottom).offset(20);
        
    }];
    
}

- (void)drawRect:(CGRect)rect
{
    
    //NSLog(@"画圆,角度为%f",_angle);
    
    //画一个圈+动画
    if (_isAnimate)
    {
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:45 startAngle:0 endAngle:_angle clockwise:YES];
        
        path.lineWidth = 12;
        
        [[UIColor lightGrayColor] setStroke];
        
        [path stroke];
    
        
        //方法一:画一段小的弧来显示残缺部分
        /*
        //画半圆
        if (_angle >= M_PI)
        {
            UIBezierPath *hanlPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:46.5  startAngle:M_PI endAngle:_angle clockwise:YES];
            
            hanlPath.lineWidth = 8;
            
            [[UIColor whiteColor] setStroke];
            
            [hanlPath stroke];
        }
    
        //再画一段小的弧来显示残缺部分
        if (_angle >= M_PI + M_PI/6 - M_PI/15 && _angle <= M_PI + M_PI/6)
        {
            UIBezierPath *hanlPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:46.5  startAngle:M_PI + M_PI/6 - M_PI/15 endAngle:_angle clockwise:YES];
            
            hanlPath.lineWidth = 8;
            
            [[UIColor lightGrayColor] setStroke];
            
            [hanlPath stroke];
        }
        else if (_angle >= M_PI + M_PI/6)
        {
            UIBezierPath *hanlPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:46.5  startAngle:M_PI + M_PI/6 - M_PI/15 endAngle:M_PI + M_PI/6 clockwise:YES];
            
            hanlPath.lineWidth = 8;
            
            [[UIColor lightGrayColor] setStroke];
            
            [hanlPath stroke];
        }
        */
        
        //方法二:三部分画圆
        //1-画半圆第一部分
        if (_angle >= M_PI && _angle <= M_PI + M_PI/6 - M_PI/15)
        {
            UIBezierPath *hanlPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:46.5  startAngle:M_PI endAngle:_angle clockwise:YES];
            
            hanlPath.lineWidth = 8;
            
            [[UIColor whiteColor] setStroke];
            
            [hanlPath stroke];
        }
        //2-半圆第二部分
        else if (_angle > M_PI + M_PI/6 - M_PI/15 && _angle < M_PI + M_PI/6)
        {
            UIBezierPath *hanlPath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:46.5  startAngle:M_PI endAngle:M_PI + M_PI/6 - M_PI/15 clockwise:YES];
            
            hanlPath1.lineWidth = 8;
            
            [[UIColor whiteColor] setStroke];
            
            [hanlPath1 stroke];
            
            
            
            UIBezierPath *hanlPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:46.5  startAngle:M_PI + M_PI/6 - M_PI/15 endAngle:_angle clockwise:YES];
            
            hanlPath2.lineWidth = 8;
            
            [[UIColor clearColor] setStroke];
            
            [hanlPath2 stroke];
            
        }
        //3-半圆第三部分
        else if(_angle >= M_PI + M_PI/6)
        {
            UIBezierPath *hanlPath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:46.5  startAngle:M_PI endAngle:M_PI + M_PI/6 - M_PI/15 clockwise:YES];
            
            hanlPath1.lineWidth = 8;
            
            [[UIColor whiteColor] setStroke];
            
            [hanlPath1 stroke];
            
            
            
            UIBezierPath *hanlPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:46.5  startAngle:M_PI + M_PI/6 - M_PI/15 endAngle:M_PI + M_PI/6 clockwise:YES];
            
            hanlPath2.lineWidth = 8;
            
            [[UIColor clearColor] setStroke];
            
            [hanlPath2 stroke];
            
            
            
            UIBezierPath *hanlPath3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:46.5  startAngle:M_PI + M_PI/6 endAngle:_angle clockwise:YES];
            
            hanlPath3.lineWidth = 8;
            
            [[UIColor whiteColor] setStroke];
            
            [hanlPath3 stroke];
        }
        
    }
}

-(void)StartAnimate
{
    [UIView animateWithDuration:2 animations:^{
       
        self.iconImage.alpha = 1;
        
        self.iconLabel.alpha = 1;
        
        
    } completion:^(BOOL finished) {
        
        _isAnimate = YES;
        
        
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(Round) userInfo:nil repeats:YES];
        
        
    }];
}

-(void)Round
{
    
    if (_angle == M_PI *2)
    {
        [_timer invalidate];
        
        return;
    }
    
    
    //上升的起点
    if (_angleInterval == 0.01)
    {
        _preAngleInterval = _angleInterval;
        
         _angleInterval += 0.02;
    }
    //下降的终点
    else if (_angleInterval == 0.1)
    {
        _preAngleInterval = _angleInterval;
    
        _angleInterval -= 0.0105;
    }
    else if (_angleInterval > 0.10)
    {
        _maxNum++;
        
        //NSLog(@"最高%ld次",_maxNum);
        //最高持续2次开始减小
        if (_maxNum == 2)
        {
            _preAngleInterval = _angleInterval;
            
            _angleInterval = 0.10;
        }
    }
    else
    {
        //处在减小的阶段
        if (_preAngleInterval > _angleInterval && _angleInterval > 0.01)
        {
           _preAngleInterval = _angleInterval;
        
           _angleInterval -= 0.0105;
            
        }
        //处在上升的阶段
        if (_angleInterval > _preAngleInterval && _angleInterval < 0.10)
        {
            _preAngleInterval = _angleInterval;
            
            _angleInterval += 0.02;
            
        }
    }
    
    //NSLog(@"%f",_angleInterval);
    
    
    
    _angle += M_PI * 2 * _angleInterval;
    
    
    if (_angle >= M_PI *2)
    {
        _angle = M_PI *2;
    }
    
    
    [self setNeedsDisplay];
    
    
}

@end
