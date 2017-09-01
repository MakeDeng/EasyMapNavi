//
//  CustomCalloutView.m
//  ETravel
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import "CustomCalloutView.h"

#define DeviceWidth     [UIScreen mainScreen].bounds.size.width
#define DeviceHeight    [UIScreen mainScreen].bounds.size.height

#define kArrorHeight        10

@interface CustomCalloutView ()

@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CustomCalloutView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor whiteColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.masksToBounds=YES;
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

/////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    // 添加标题，即商户名
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, DeviceWidth-82-68-20, 20)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = @"北斗星海鲜自助餐厅";
    [self addSubview:self.titleLabel];
    
    // 添加副标题，即商户地址
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 31, DeviceWidth-82-68-20, 32)];
    self.subtitleLabel.font = [UIFont systemFontOfSize:11];
    self.subtitleLabel.textColor = [UIColor lightGrayColor];
    self.subtitleLabel.numberOfLines=0;
    self.subtitleLabel.text = @"南开区南开三马路和广开中街交口轻纺城3";
    [self addSubview:self.subtitleLabel];
    
    // 导航按钮
    self.naviButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.naviButton setTitle:@"导航" forState:UIControlStateNormal];
    self.naviButton.titleLabel.font=[UIFont systemFontOfSize:18];
    self.naviButton.backgroundColor=[UIColor orangeColor];
    self.naviButton.frame=CGRectMake(DeviceWidth-82-68, 0, 82, 70);
    [self.naviButton addTarget:self action:@selector(naviButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.naviButton];
    
    UIBezierPath * path=[UIBezierPath bezierPathWithRoundedRect:self.naviButton.bounds byRoundingCorners:UIRectCornerTopRight
                         |UIRectCornerBottomRight cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer * shapLayer=[[CAShapeLayer alloc]init];
    shapLayer.frame=self.naviButton.bounds;
    shapLayer.path=path.CGPath;
    
    self.naviButton.layer.mask=shapLayer;
    
}

//导航按钮点击事件
-(void)naviButtonClicked
{
    self.naviClicked();
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
    self.subtitleLabel.text = subtitle;
}

@end
