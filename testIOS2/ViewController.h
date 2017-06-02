//
//  ViewController.h
//  testIOS2
//
//  Created by yyfwptz on 2017/5/10.
//  Copyright © 2017年 yyfwptz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "UpView.h"


@interface ViewController : UIViewController <viewDelegate, BMKMapViewDelegate, BMKLocationServiceDelegate> {
    BMKMapView *_mapView;
    BMKLocationService *_locService;
    ViewController *_viewController;
    NSArray *_latitude;
    NSArray *_longitude;
    NSMutableArray *_icon;
    BMKPointAnnotation* annotation;
}
@property (strong, nonatomic) IBOutlet UIView *view1;


@end
