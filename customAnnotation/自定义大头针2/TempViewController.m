//
//  TempViewController.m
//  customAnnotation
//
//  Created by Z on 2018/3/9.
//  Copyright © 2018年 Z. All rights reserved.
//

#import "TempViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotationView.h>
#import "LocationModel.h"
#import "LocationAnnoation.h"
#import "LocationAnnotationView.h"
#import "CalloutAnnotation.h"
#import "CalloutAnnotationView.h"

@interface TempViewController () <MKMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic, strong) MKMapView * mapView;
@property (nonatomic, strong) CLLocationManager * locationManger;
@property (nonatomic, strong) NSMutableArray * listArray;
@property (nonatomic, strong) NSMutableArray * modelArray;

@end

@implementation TempViewController
#pragma mark - Lazy loading          懒加载
- (CLLocationManager *)locationManger {
    if (!_locationManger) {
        _locationManger = [[CLLocationManager alloc] init];
    }
    return _locationManger;
}

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}


#pragma mark - LifeCyle             生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义方式二";
    
    [self createViews];
    
    [self loadData];
    
    
}


#pragma mark - Initial control       初始化控件
//初始化界面
- (void)createViews {
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    _mapView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_mapView];
    //显示建筑物
    _mapView.showsBuildings = YES;
    //显示指南针
    _mapView.showsCompass = YES;
    //兴趣点
    _mapView.showsPointsOfInterest = YES;
    //比例尺
    _mapView.showsScale = YES;
    //交通
    _mapView.showsTraffic = YES;
    
    _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
}


//初始化数据
- (void)loadData {
    [BANetManager ba_request_POSTWithUrlString:MAPURL isNeedCache:NO parameters:nil successBlock:^(id response) {
        self.modelArray = response[@"data"];
        //遍历数组获取里面的字典，在调用YYModel方法
        [self.modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = obj;
            LocationModel * model = [LocationModel yy_modelWithDictionary:dic];
            //NSString * lat = [model valueForKey:@"lat"];
            //NSString * lng = [model valueForKey:@"lng"];
            //NSString * nameID = [NSString stringWithFormat:@"%@",[model valueForKey:@"nameID"]];
            [self.listArray addObject:model];
        } ];
        
        NSLog(@"%@",self.listArray);
        
        //添加大头针
        [self addAnnotation];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } progressBlock:nil];
}


- (void)addAnnotation {
    for (int i = 0; i < _listArray.count; i ++) {
        LocationAnnoation *pointAnnotation = [[LocationAnnoation alloc] init];
        pointAnnotation.location = _listArray[i];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(pointAnnotation.location.lat.floatValue, pointAnnotation.location.lng.floatValue);
        [_mapView addAnnotation:pointAnnotation];
        MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
        MKCoordinateRegion region = MKCoordinateRegionMake(pointAnnotation.coordinate, span);
        [self.mapView setRegion:region animated:YES];
    }
}

#pragma mark - Action  Method        控件事件


#pragma mark - Private Method        私有方法


#pragma mark - Set/Get Methods       重写设值/取值


#pragma mark - External Delegate     外部代理
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [_locationManger stopUpdatingLocation];
    [self.mapView setShowsUserLocation:NO];
    
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view isKindOfClass:[LocationAnnotationView class]]) {
        NSLog(@"纬度是--->%f，经度是--->%f",view.annotation.coordinate.latitude,view.annotation.coordinate.longitude);
        LocationAnnoation *anno = (LocationAnnoation *)view.annotation;
        CalloutAnnotation *calloutAnno = [[CalloutAnnotation alloc] init];
        calloutAnno.coordinate = anno.coordinate;
        calloutAnno.location = anno.location;
        [_mapView addAnnotation:calloutAnno];
        view.alpha = 0;
    }
    
    
    
}




-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[LocationAnnoation class]]) {
        LocationAnnotationView *annotationview = [LocationAnnotationView annotationViewWithMapView:mapView];
        annotationview.annotation = annotation;
        return annotationview;
        
    } else if([annotation isKindOfClass:[CalloutAnnotation class]]) {
        CalloutAnnotationView *annotationview = [CalloutAnnotationView annotationViewWithMapView:mapView];
        annotationview.annotation = annotation;
        return annotationview;
        
    } else {
        return nil;
    }
}



//取消点击大头针
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    if ([view isKindOfClass:[LocationAnnotationView class]]) {
        view.alpha = 1;
        
        NSLog(@"取消点击大头针一");
        
        for (CalloutAnnotation *anno in _mapView.annotations) {
            if ([anno isKindOfClass:[CalloutAnnotation class]]) {
                [_mapView removeAnnotation:anno];
            }
        }
        
    }else if ([view isKindOfClass:[CalloutAnnotationView class]]) {
       NSLog(@"取消点击大头针二");
    }
 
}




#pragma mark - Notification          通知方法


#pragma mark - OtherMethods          其他方法



@end
