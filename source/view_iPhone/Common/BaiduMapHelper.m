#import "BaiduMapHelper.h"

@implementation BaiduMapHelper {
    double lastLatitude;
    double lastLongitude;
    NSString *lastKeyword;

    CLLocationManager *locationManager;
    CLLocationCoordinate2D lastCoordinate;
    getCoordinateCallback _getCoordinateCallback;

    //POI搜索
    BMKPoiSearch *_poiSearch;
    getPOIListCallback _getPOIListCallback;
    //搜索建议
    BMKSuggestionSearch *_suggestionSearch;
    BMKSuggestionResult *_suggestionResult;
    suggestionResultBlock _suggestionResultBlock;
}
+ (void)setup {
    [[BMKMapManager new] start:kBaiduMapKey generalDelegate:nil];
}

- (void)getCoordinate:(getCoordinateCallback)callback {
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;

    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    _getCoordinateCallback = callback;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if (_getCoordinateCallback != nil) {
        _getCoordinateCallback(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    }
}

- (void)getPOIList:(NSString *)keyword callback:(getPOIListCallback)callback {
    _poiSearch = [[BMKPoiSearch alloc] init];
    _poiSearch.delegate = self;
    _getPOIListCallback = callback;
    [self getCoordinate:^(double latitude, double longitude) {
        if (latitude == lastLatitude && longitude == lastLongitude && lastKeyword == keyword)
            return;

        lastLatitude = latitude;
        lastLongitude = longitude;
        lastKeyword = keyword;

        BMKNearbySearchOption *option = [BMKNearbySearchOption new];
        option.pageIndex = 0;
        option.radius=3000;
        option.pageCapacity = 10;
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude;
        coordinate.longitude = longitude;
        option.location = coordinate;
        option.keyword = keyword;
        if (![_poiSearch poiSearchNearBy:option]) {
            NSLog(@"周边检索发送失败");
        }
    }];
}
- (void)getSearchList:(BMKNearbySearchOption *)poiSearchOptions callback:(getPOIListCallback)callback
{
    _poiSearch = [[BMKPoiSearch alloc] init];
    _poiSearch.delegate = self;
    _getPOIListCallback = callback;
    
    poiSearchOptions.pageIndex = 0;
    poiSearchOptions.radius=500;
    poiSearchOptions.pageCapacity = 10;
    poiSearchOptions.keyword = @"公司";
    if (![_poiSearch poiSearchNearBy:poiSearchOptions]) {
        NSLog(@"周边检索发送失败");
    }

}
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    if (_getPOIListCallback != nil) {
        _getPOIListCallback(poiResult);
    }
}

- (void)getSuggestions:(NSString *)city keyword:(NSString *)keyword callback:(suggestionResultBlock)callback {
    _suggestionSearch = [[BMKSuggestionSearch alloc] init];
    _suggestionSearch.delegate = self;
    _suggestionResultBlock = callback;

    BMKSuggestionSearchOption *option = [BMKSuggestionSearchOption new];
    option.cityname = city;
    option.keyword = keyword;
    [_suggestionSearch suggestionSearch:option];
}

- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionResult *)result errorCode:(BMKSearchErrorCode)error {
    _suggestionResult = result;
    if (_suggestionResultBlock != nil) {

    }
}

@end






