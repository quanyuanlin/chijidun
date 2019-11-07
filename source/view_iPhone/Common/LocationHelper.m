#import "LocationHelper.h"

@implementation LocationHelper {
    CLLocationManager *locationManager;
    CLLocationCoordinate2D lastCoordinate;
}

- (instancetype)init {

    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    if (IsIOS8) {
        [locationManager requestAlwaysAuthorization];
    }
    return self;
}

- (void)run {
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    _isLocationServiceEnable = NO;
    if (_failed) {
        _failed(error);
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    _isLocationServiceEnable = YES;
    CLLocationCoordinate2D coordinate = [newLocation coordinate];
    if (getCoordinateDistance(lastCoordinate.latitude, lastCoordinate.longitude, coordinate.latitude, coordinate.longitude) > 100) {
        lastCoordinate = coordinate;
        AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];

        NSString *url = [[NSString alloc]
                initWithFormat:@"http://api.map.baidu.com/geocoder/v2/?ak=%@&output=json&location=%f,%f&coordtype=wgs84ll",
                               @"tjX16LvjZVLBuYxK8XyUNuAn",
                               lastCoordinate.latitude,
                               lastCoordinate.longitude];
        NSLog(@"%@", url);
        [httpManager GET:url
              parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                     NSMutableDictionary *result = (NSMutableDictionary *) responseObject;
                     if (_success != nil) {
                         _success((NSMutableDictionary *) responseObject, url);
                     }
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                 }];
    }
}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [locationManager requestAlwaysAuthorization];
            }
            NSLog(@"用户还未决定授权");
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
            } else {
                NSLog(@"定位服务关闭，不可用");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
            
    }
}
@end
