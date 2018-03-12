//
//  HomeController.m
//  customAnnotation
//
//  Created by Z on 2017/11/22.
//Copyright © 2017年 Z. All rights reserved.
//

#import "HomeController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotationView.h>
#import "AnnotationModel.h"
#import "CustomAnnotation.h"
#import "CustomAnnotationView.h"

@interface HomeController () <MKMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic,strong) MKMapView * mapView;
@property (nonatomic,strong) CLLocationManager * locationManger;
@property (nonatomic,strong) NSMutableArray * listArray;
@property (nonatomic,strong) NSMutableDictionary * annotationDic;
@end

@implementation HomeController
#pragma mark - Lazy loading           懒加载
- (CLLocationManager *)locationManger {
    if (!_locationManger) {
        _locationManger = [[CLLocationManager alloc] init];
    }
    return _locationManger;
}

- (NSMutableDictionary *)annotationDic {
    if (!_annotationDic) {
        _annotationDic = [NSMutableDictionary dictionary];
    }
    return _annotationDic;
}

#pragma mark - LifeCyle               生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义方式一";
    
    [self createViews];
    
    [self loadData];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

- (void)dealloc {
    NSLog(@"%@--->释放了",self.class);
}



#pragma mark - Initial control        初始化控件
//初始化界面
- (void)createViews {
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
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
        NSLog(@"%@",response);
        AnnotationModel * annModel = [AnnotationModel yy_modelWithDictionary:response];
        self.listArray = [annModel valueForKey:@"data"];
        [self addAnnotation];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } progressBlock:nil];
}


- (void)addAnnotation {
    for (int i = 0; i < self.listArray.count; i++) {
        Data * dataModel = [Data yy_modelWithDictionary:[self.listArray objectAtIndex:i]];
        CustomAnnotation * annotation = [[CustomAnnotation alloc] init];
        CLLocationCoordinate2D coor;
        coor.latitude = [dataModel.lat doubleValue];
        coor.longitude = [dataModel.lng doubleValue];
        annotation.coordinate = coor;
        [_mapView addAnnotation:annotation];
        
        annotation.annotModel = dataModel;
        [_annotationDic setObject:dataModel forKey:[NSValue valueWithMKCoordinate:annotation.coordinate]];

        
        //默认选中一个大头针
        //[_mapView selectAnnotation:pointAnnotation animated:YES];
        //精准度不高，不推荐使用
        //[self.mapView setCenterCoordinate:coor animated:YES];
        //区域跨度-经纬度跨度
        MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
        MKCoordinateRegion region = MKCoordinateRegionMake(coor, span);
        [self.mapView setRegion:region animated:YES];
    }
}

#pragma mark - Action  Method         控件事件

#pragma mark - Private Method         私有方法

#pragma mark - Set/Get Methods        重写设值/取值

#pragma mark - External Delegate      外部代理

#pragma mark - Notification           通知方法

#pragma mark - UITableView            代理方法

#pragma mark - OtherMethods           其他方法

#pragma mark - MapView Delegate
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
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        NSLog(@"纬度是--->%f，经度是--->%f",view.annotation.coordinate.latitude,view.annotation.coordinate.longitude);
    }
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *returnedAnnotationView = nil;
    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
        Data *annotationModel = (Data *)[_annotationDic objectForKey:[NSValue valueWithMKCoordinate:annotation.coordinate]];
        returnedAnnotationView = [CustomAnnotation createViewAnnotationForMapView:self.mapView
                                                                       annotation:annotation
                                                                             icon:annotationModel.thumbimg
                                                                            label:annotationModel.title];
    }

    return returnedAnnotationView;
}

@end
