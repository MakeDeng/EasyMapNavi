//
//  CustomCalloutView.h
//  ETravel
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCalloutView : UIView

@property (nonatomic, strong) UIButton *naviButton;//导航按钮
@property (nonatomic, copy) NSString *title; //商户名
@property (nonatomic, copy) NSString *subtitle; //地址

@property (nonatomic, strong) void (^naviClicked)();//导航按钮点击事件

@end
