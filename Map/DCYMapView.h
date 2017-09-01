//
//  DCYMapView.h
//  DrDriver
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface DCYMapView : MAMapView

+ (DCYMapView *)shareMAMapView:(CGRect)frame;

@end
