//
//  ViewController.m
//  testIOS2
//
//  Created by yyfwptz on 2017/5/10.
//  Copyright © 2017年 yyfwptz. All rights reserved.
//

#import "ViewController.h"
#import "BMKClusterManager.h"
#import "CordovaViewController.h"
#import "UpView.h"
#import "SWRevealViewController.h"
#import <QuartzCore/QuartzCore.h>

UpView *seekHelpView;

@interface ClusterAnnotation : BMKPointAnnotation

///所包含annotation个数
@property(nonatomic, assign) NSInteger size;

@end

@implementation ClusterAnnotation

@synthesize size = _size;

@end


@interface ClusterAnnotationView : BMKPinAnnotationView {

}

@property(nonatomic, assign) NSInteger size;
@property(nonatomic, strong) UILabel *label;

@end

@implementation ClusterAnnotationView

@synthesize size = _size;
@synthesize label = _label;

- (id)initWithAnnotation:(id <BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBounds:CGRectMake(0.f, 0.f, 22.f, 22.f)];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 22.f, 22.f)];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:11];
        _label.textAlignment = NSTextAlignmentCenter;
        /**
         * 圆形
         */
        _label.layer.cornerRadius = _label.bounds.size.width / 2;
        _label.layer.masksToBounds = YES;
        [self addSubview:_label];
        self.alpha = 0.85;
    }
    return self;
}

- (void)setSize:(NSInteger)size {
    _size = size;
    if (_size == 1) {
        self.label.hidden = YES;
        self.pinColor = BMKPinAnnotationColorRed;
        return;
    }
    self.label.hidden = NO;
    if (size > 20) {
        self.label.backgroundColor = [UIColor purpleColor];
    } else if (size > 10) {
        self.label.backgroundColor = [UIColor purpleColor];
    } else if (size > 5) {
        self.label.backgroundColor = [UIColor purpleColor];
    } else {
        self.label.backgroundColor = [UIColor purpleColor];
    }
    _label.text = [NSString stringWithFormat:@"%ld", size];
}

@end

@interface ViewController () {
    BMKClusterManager *_clusterManager;
    NSInteger _clusterZoom;//聚合级别
    NSMutableArray *_clusterCaches;//点聚合缓存标注
}
@end


@implementation ViewController
CALayer *imageLayer;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"MIMI", nil);

    /**
     * seek help view add
     */
    seekHelpView = [[UpView alloc] initWithFrame:CGRectMake(0, 400, [UIScreen mainScreen].bounds.size.width, 290)];
    seekHelpView.frame = CGRectMake(20, 540, [UIScreen mainScreen].bounds.size.width - 40, 200);
    seekHelpView.delegate = self;

    _clusterCaches = [[NSMutableArray alloc] init];
    for (NSInteger i = 3; i < 22; i++) {
        [_clusterCaches addObject:[NSMutableArray array]];
    }
    _clusterManager = [[BMKClusterManager alloc] init];

    /**
     * init map
     */
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:_mapView];
    [self.view addSubview:seekHelpView];

//    UIImage *image = [UIImage imageNamed:@"location"];
//    UIImageView *locate =[[UIImageView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 15, [[UIScreen mainScreen] bounds].size.height/2 - 15, 30, 30)];
//    locate.image = image;

    /**
     * init locate
     */
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    _locService.distanceFilter=10.0f;
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.showsUserLocation = YES;

//    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(43.976765990111566, 125.39304679529695);
//    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//    annotation.coordinate = coor;
//    annotation.title = @"这里是北京";
//    [_mapView addAnnotation:annotation];
//    //向点聚合管理类中添加标注
//    for (NSInteger i = 0; i < 20; i++) {
//        double lat =  (arc4random() % 100) * 0.001f;
//        double lon =  (arc4random() % 100) * 0.001f;
//        BMKClusterItem *clusterItem = [[BMKClusterItem alloc] init];
//        clusterItem.coor = CLLocationCoordinate2DMake(coor.latitude + lat, coor.longitude + lon);
//        NSLog(@"%d", coor.latitude);
//        NSLog(@"%d", coor.longitude);
//        [_clusterManager addClusterItem:clusterItem];
//    }

    [self performSelector:@selector(setNavigationBar)];
//    [self.view addSubview:locate];
    imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 15, [[UIScreen mainScreen] bounds].size.height/2 - 15, 30, 30);
    imageLayer.contents = (id)[[UIImage imageNamed:@"location"] CGImage];
    [self.view.layer addSublayer:imageLayer];
}

- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate = self;

}

- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;

}

- (void)setNavigationBar {

    /**
     * left slide page config
     */
    SWRevealViewController *revealViewController = [self revealViewController];
    [revealViewController panGestureRecognizer];
    [revealViewController tapGestureRecognizer];

    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;

//    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, 74)];
//    UINavigationItem *navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"MIMI"];
//    [navigationBar pushNavigationItem:navigationBarTitle animated:YES];
//    [self.view addSubview:navigationBar];
//
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(navigationButton:)];
//    navigationBarTitle.leftBarButtonItem = item;

}

- (void)navigationButton:(id)sender {
    NSLog(@"left button clicked!");
}

- (void)showCordova {
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSLog(@"haha");
    CordovaViewController *cordovaViewController = [[CordovaViewController alloc] init];
    [self presentViewController:cordovaViewController animated:YES completion:nil];
}


//// 根据anntation生成对应的View
//- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
//        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
//        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
//        return newAnnotationView;
//    }
//
//    //普通annotation
//    NSString *AnnotationViewID = @"ClusterMark";
//    ClusterAnnotation *cluster = (ClusterAnnotation*)annotation;
//    ClusterAnnotationView *annotationView = [[ClusterAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
//    annotationView.size = cluster.size;
//    annotationView.draggable = YES;
//    annotationView.annotation = cluster;
//    return annotationView;
//
//}




- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate {
//    [self performSelector:@selector(setIcon)];
//    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor;
//    coor.latitude = 44;
//    coor.longitude = 125.40;
//    annotation.coordinate = coor;
//    [_mapView addAnnotation:annotation];
//    seekHelpView.hidden = NO;

    CGPoint fromPoint = imageLayer.position;
    CGPoint toPoint = CGPointMake(fromPoint.x  , fromPoint.y - 10);
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.fromValue = [NSValue valueWithCGPoint:fromPoint];
    anim.toValue = [NSValue valueWithCGPoint:toPoint];
    anim.duration = 0.1;
    imageLayer.position = fromPoint;
    anim.removedOnCompletion = YES;
    [imageLayer addAnimation:anim forKey:nil];
}



//-(void)setIcon {
//    /**
//     * 测试数据
//     */
//    _latitude = @[@"43.976765990111566", @"43.98045709845306", @"43.980379256725655", @"43.97433323526407", @"43.981890665224014"];
//    _longitude = @[@"125.39304679529695", @"125.39393611775184", @"125.38560882567434", @"125.38875289495925", @"125.39140289621369"];
//    _icon = [NSMutableArray arrayWithCapacity:[_latitude count]];
//    for (NSUInteger j = 0; j < [_latitude count]; ++j) {
//        annotation = [[BMKPointAnnotation alloc]init];
//        CLLocationCoordinate2D clLocationCoordinate2D;
//        clLocationCoordinate2D.latitude = [_latitude[j] doubleValue];
//        clLocationCoordinate2D.longitude = [_longitude[j] doubleValue];
//        [_icon addObject:[NSValue value:&clLocationCoordinate2D withObjCType:@encode(CLLocationCoordinate2D)]];
//        annotation.coordinate = clLocationCoordinate2D;
//        [_mapView addAnnotation:annotation];
//    }
//}

//- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view {
//    if ([view isKindOfClass:[ClusterAnnotationView class]]) {
//        ClusterAnnotation *clusterAnnotation = (ClusterAnnotation*)view.annotation;
//        if (clusterAnnotation.size > 1) {
//            [mapView setCenterCoordinate:view.annotation.coordinate];
//            [mapView zoomIn];
//        }
//    }
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];

}


- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {

//    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
//    NSLog(@" regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
//    CLLocationCoordinate2D coor;
//    coor.longitude = centerCoordinate.longitude;
//    coor.latitude = centerCoordinate.latitude;
//    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//    annotation.coordinate = coor;
////    annotation.title = @"这里是北京";
//    [_mapView addAnnotation:annotation];
//    [_mapView setCenterCoordinate:coor animated:YES];
    CGPoint fromPoint = imageLayer.position;
    CGPoint toPoint = CGPointMake(fromPoint.x  , fromPoint.y - 10);
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.fromValue = [NSValue valueWithCGPoint:fromPoint];
    anim.toValue = [NSValue valueWithCGPoint:toPoint];
    anim.duration = 0.1;
    imageLayer.position = fromPoint;
    anim.removedOnCompletion = YES;
    [imageLayer addAnimation:anim forKey:nil];
}


- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
//    NSLog(@"didUpdateUserLocation lat %f,long %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    /**
     * 跳转 放大
     */
    _mapView.centerCoordinate = userLocation.location.coordinate;
    [_mapView setZoomLevel:17];
    [_locService stopUserLocationService];

//    CGFloat centerLongitude = (CGFloat) _mapView.region.center.longitude;
//    CGFloat centerLatitude = (CGFloat) _mapView.region.center.latitude;     //当前屏幕显示范围的经纬度
//
//
//    NSLog(@"%f,%f",centerLatitude,centerLongitude);
//
//
//    _mapView.centerCoordinate = userLocation.location.coordinate;
//    [_mapView setZoomLevel:17];
//    CLLocationDegrees pointssLongitudeDelta = _mapView.region.span.longitudeDelta;
//    CLLocationDegrees pointssLatitudeDelta = _mapView.region.span.latitudeDelta;
//
//    //左上角
//
//    CGFloat leftUpLong = centerLongitude - pointssLongitudeDelta / 2.0;
//    CGFloat leftUpLati = centerLatitude - pointssLatitudeDelta / 2.0;     //右上角
//
//    CGFloat rightUpLong = centerLongitude + pointssLongitudeDelta / 2.0;
//    CGFloat rightUpLati = centerLatitude - pointssLatitudeDelta / 2.0;     //左下角
//
//    CGFloat leftDownLong = centerLongitude - pointssLongitudeDelta / 2.0;
//    CGFloat leftDownlati = centerLatitude + pointssLatitudeDelta / 2.0;     //右下角
//
//    CGFloat rightDownLong = centerLongitude + pointssLongitudeDelta / 2.0;
//    CGFloat rightDownLati = centerLatitude + pointssLatitudeDelta / 2.0;


}
//
//- (void)didStopLocatingUser
//{
//}
//
//- (void)didFailToLocateUserWithError:(NSError *)error
//{
//}
//
//
////更新聚合状态
//- (void)updateClusters {
//    _clusterZoom = (NSInteger)_mapView.zoomLevel;
//    @synchronized(_clusterCaches) {
//        __block NSMutableArray *clusters = _clusterCaches[_clusterZoom - 3];
//
//        if (clusters.count > 0) {
//            [_mapView removeAnnotations:_mapView.annotations];
//            [_mapView addAnnotations:clusters];
//        } else {
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//                ///获取聚合后的标注
//                __block NSArray *array = [_clusterManager getClusters:_clusterZoom];
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    for (BMKCluster *item in array) {
//                        ClusterAnnotation *annotation = [[ClusterAnnotation alloc] init];
//                        annotation.coordinate = item.coordinate;
//                        annotation.size = item.size;
//                        annotation.title = [NSString stringWithFormat:@"我是%ld个", (unsigned long)item.size];
//                        [clusters addObject:annotation];
//                    }
//                    [_mapView removeAnnotations:_mapView.annotations];
//                    [_mapView addAnnotations:clusters];
//                });
//            });
//        }
//    }
//}
//
//- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus *)status {
//    if (_clusterZoom != 0 && _clusterZoom != (NSInteger)mapView.zoomLevel) {
//        [self updateClusters];
//    }
//}
//
//- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
//    [self updateClusters];
//}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

@end
