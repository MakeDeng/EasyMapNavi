//
//  DCYMapView.m
//  DrDriver
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//

#import "DCYMapView.h"

static DCYMapView * _mapView=nil;

@implementation DCYMapView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (DCYMapView *)shareMAMapView:(CGRect)frame
{
    @synchronized(self) {
        if (_mapView == nil) {
            _mapView = [[DCYMapView alloc] initWithFrame:frame];
        }
        _mapView.frame = frame;
                
        return _mapView;
    }
}

//重写allocWithZone保证分配内存alloc相同
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (_mapView == nil) {
            _mapView = [super allocWithZone:zone];
            return _mapView; // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

//保证copy相同
+ (id)copyWithZone:(NSZone *)zone
{
    return _mapView;
}
    


@end
