//
//  CustomAnnotationView.m
//  ETravel
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import "CustomAnnotationView.h"

#define DeviceWidth     [UIScreen mainScreen].bounds.size.width
#define DeviceHeight    [UIScreen mainScreen].bounds.size.height

@interface CustomAnnotationView ()

@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;

@end

@implementation CustomAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth-68, 80)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        self.calloutView.title = self.annotation.title;
        self.calloutView.subtitle = self.annotation.subtitle;
        
        __weak typeof (self) weakSelf = self;
        self.calloutView.naviClicked = ^{
            
            weakSelf.naviClicked();
            
        };
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil)
    {
        CGPoint tempoint = [self.calloutView.naviButton convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.calloutView.naviButton.bounds, tempoint))
        {
            view = self.calloutView.naviButton;
        }
    }
    
    return view;
}

@end
