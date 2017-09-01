//
//  CustomAnnotationView.h
//  ETravel
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) CustomCalloutView *calloutView;

@property (nonatomic, strong) void (^naviClicked)();//导航按钮点击事件

@end
