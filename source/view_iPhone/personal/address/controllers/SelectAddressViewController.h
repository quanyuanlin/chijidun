//
//  SelectAddressViewController.h
//  chijidun
//
//  Created by iMac on 16/11/22.
//
//

#import <UIKit/UIKit.h>

#import "MYTextField.h"
#import "SearchAddressTableViewCell.h"
#import "BaiduMapHelper.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>

typedef void (^selectCallback)(BMKPoiInfo *info);
@interface SelectAddressViewController : TBaseUIViewController
<UITableViewDataSource,UITableViewDelegate,BMKLocationServiceDelegate,BMKMapViewDelegate,UITextFieldDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic,strong) BMKMapView *mapView;//地图视图
@property (nonatomic,strong) BMKLocationService *locationService;//定位服务


@property(nonatomic,strong)NSString *city;
- (void)setSelectCallback:(selectCallback)callback;


@property CLLocationCoordinate2D centerPt;
//- (void)setCurrentPOI:(BMKPoiInfo *)info;



@end
