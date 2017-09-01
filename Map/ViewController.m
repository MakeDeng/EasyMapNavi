//
//  ViewController.m
//  Map
//
//  Created by mac on 2017/8/31.
//  Copyright © 2017年 tangchaoke. All rights reserved.
//
//需要现在info.plist里添加各个地图的scheme 

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "DCYMapView.h"
#import "CustomAnnotationView.h"

@interface ViewController () <UIActionSheetDelegate,MAMapViewDelegate>

@property (nonatomic,strong) UIActionSheet * actionSheet;
@property (nonatomic,strong) NSMutableArray * mapArray;//1:百度地图  2：腾讯地图  3：高德地图
@property (nonatomic,strong) DCYMapView * mapView;//地图

@end

@implementation ViewController

-(UIActionSheet *)actionSheet
{
    if (!_actionSheet) {
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
            
            [self.mapArray addObject:@"1"];
            
        }
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
            
            [self.mapArray addObject:@"2"];
            
        }
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[@"iosamap://" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]) {
            
            [self.mapArray addObject:@"3"];
            
        }
        
        switch (self.mapArray.count) {
            case 0:
            {
                _actionSheet=[[UIActionSheet alloc]initWithTitle:@"导航" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"手机地图" otherButtonTitles:nil];
            }
                break;
            case 1:
            {
                NSString * string=@"";
                switch ([self.mapArray[0] integerValue]) {
                    case 1:
                    {
                        string=@"百度地图";
                    }
                        break;
                    case 2:
                    {
                        string=@"腾讯地图";
                    }
                        break;
                    case 3:
                    {
                        string=@"高德地图";
                    }
                        break;
                    default:
                        break;
                }
                
                _actionSheet=[[UIActionSheet alloc]initWithTitle:@"导航" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"手机地图" otherButtonTitles:string, nil];
            }
                break;
            case 2:
            {
                NSString * string=@"";
                NSString * stringOne=@"";
                
                switch ([self.mapArray[0] integerValue]) {
                    case 1:
                    {
                        string=@"百度地图";
                    }
                        break;
                    case 2:
                    {
                        string=@"腾讯地图";
                    }
                        break;
                    case 3:
                    {
                        string=@"高德地图";
                    }
                        break;
                    default:
                        break;
                }
                
                switch ([self.mapArray[1] integerValue]) {
                    case 1:
                    {
                        stringOne=@"百度地图";
                    }
                        break;
                    case 2:
                    {
                        stringOne=@"腾讯地图";
                    }
                        break;
                    case 3:
                    {
                        stringOne=@"高德地图";
                    }
                        break;
                    default:
                        break;
                }
                
                _actionSheet=[[UIActionSheet alloc]initWithTitle:@"导航" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"手机地图" otherButtonTitles:string,stringOne, nil];
            }
                break;
            case 3:
            {
                _actionSheet=[[UIActionSheet alloc]initWithTitle:@"导航" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"手机地图" otherButtonTitles:@"百度地图",@"腾讯地图",@"高德地图", nil];
            }
                break;
            default:
                break;
        }
        
    }
    
    return _actionSheet;
}

-(NSMutableArray *)mapArray
{
    if (!_mapArray) {
        
        _mapArray=[[NSMutableArray alloc]init];
        
    }
    
    return _mapArray;
}

-(DCYMapView *)mapView
{
    if (!_mapView) {
        
        [AMapServices sharedServices].enableHTTPS = YES;
        _mapView = [DCYMapView shareMAMapView:self.view.bounds];
        [self.view addSubview:_mapView];
        
        _mapView.mapType=MAMapTypeNavi;
        _mapView.showsLabels=YES;
        _mapView.showsBuildings=YES;
        _mapView.delegate=self;
        _mapView.rotateEnabled=NO;//此属性用于地图旋转手势的开启和关闭
        _mapView.rotateCameraEnabled=NO;//此属性用于地图旋转旋转的开启和关闭
        
    }
    
    return _mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"北斗星海鲜自助餐厅";
    pointAnnotation.subtitle = @"南开区南开三马路和广开中街交口轻纺城3";
    
    [self.mapView addAnnotation:pointAnnotation];
    [self.mapView selectAnnotation:pointAnnotation animated:YES];//设置大头针选中
    
}

#pragma mark - 设置大头针样式

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        CustomAnnotationView*annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.highlighted=YES;
        
        annotationView.image = [UIImage imageNamed:@"building"];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -19);
        
        [self.mapView setZoomLevel:18];
        [self.mapView showAnnotations:@[annotation] animated:YES];
        
        //导航按钮点击事件
        annotationView.naviClicked = ^{
            
            [self.actionSheet showInView:self.view];
            
        };
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - UIActionSheet代理方法

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString * buttonString=[_actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonString isEqualToString:@"手机地图"]) {
        
        [self iphoneMap:@{@"start_address":@"我的位置",@"end_address":@"终点",@"start_lat":@"39.1138003159",@"start_lng":@"117.2165143490",@"end_lat":@"39.1042806705",@"end_lng":@"117.2229087353"}];
        
    }
    
    if ([buttonString isEqualToString:@"百度地图"]) {
        
        [self baiduMap:@{@"start_address":@"我的位置",@"end_address":@"终点",@"start_lat":@"39.1138003159",@"start_lng":@"117.2165143490",@"end_lat":@"39.1042806705",@"end_lng":@"117.2229087353"}];
        
    }
    
    if ([buttonString isEqualToString:@"腾讯地图"]) {
        
        [self tencentMap:@{@"start_address":@"我的位置",@"end_address":@"终点",@"start_lat":@"39.1138003159",@"start_lng":@"117.2165143490",@"end_lat":@"39.1042806705",@"end_lng":@"117.2229087353"}];
        
    }
    
    if ([buttonString isEqualToString:@"高德地图"]) {
        
        [self gaodeMap:@{@"start_address":@"我的位置",@"end_address":@"终点",@"start_lat":@"39.1138003159",@"start_lng":@"117.2165143490",@"end_lat":@"39.1042806705",@"end_lng":@"117.2229087353"}];
        
    }
}

//手机地图
-(void)iphoneMap:(NSDictionary *)dic
{
    //起点
    CLLocationCoordinate2D from =CLLocationCoordinate2DMake([dic[@"start_lat"] doubleValue],[dic[@"start_lng"] doubleValue]);
    
    MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:from addressDictionary:nil]];
    
    currentLocation.name =dic[@"start_address"];
    
    //终点
    CLLocationCoordinate2D to =CLLocationCoordinate2DMake([dic[@"end_lat"] doubleValue],[dic[@"end_lng"] doubleValue]);
    
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
    
    toLocation.name = dic[@"end_address"];
    
    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation,nil];
    
    NSDictionary *options =@{
                             
                             MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                             
                             MKLaunchOptionsMapTypeKey:
                                 
                                 [NSNumber numberWithInteger:MKMapTypeStandard],
                             
                             MKLaunchOptionsShowsTrafficKey:@YES
                             
                             };
    
    
    
    //打开苹果自身地图应用
    
    [MKMapItem openMapsWithItems:items launchOptions:options];
}

#pragma mark - 以下url地址所传参数含义具体看文档说明

//百度地图 文档地址：http://lbsyun.baidu.com/index.php?title=uri/api/ios
-(void)baiduMap:(NSDictionary *)dic
{
    NSString * urlString=[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name:%@&mode=driving&coord_type=gcj02&src=webapp.navi.wanglu.etravel",dic[@"end_lat"],dic[@"end_lng"],dic[@"end_address"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

//腾讯地图 文档地址：http://lbs.qq.com/uri_v1/guide-route.html（前面的qqmap://需换一下表示app调用）
-(void)tencentMap:(NSDictionary *)dic
{
    NSString * urlString=[[NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&from=我的位置&tocoord=%@,%@&to=%@&policy=1",dic[@"end_lat"],dic[@"end_lng"],dic[@"end_address"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

//高德地图 文档地址：http://lbs.amap.com/api/amap-mobile/gettingstarted
-(void)gaodeMap:(NSDictionary *)dic
{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"iosamap://navi?sourceApplication=etravel&backScheme=etravel&lat=%@&lon=%@&dev=0&style=2",dic[@"end_lat"],dic[@"end_lng"]]];
    
    if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) {
        //iOS10以后,使用新API
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            NSLog(@"scheme调用结束");
        }];
    } else {
        //iOS10以前,使用旧API
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
