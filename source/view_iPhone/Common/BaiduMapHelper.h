#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import <BaiduMapAPI_Search/BMKSuggestionSearch.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>

typedef void (^getCoordinateCallback)(double latitude, double longitude);

typedef void (^getPOIListCallback)(BMKPoiResult *result);

typedef void (^suggestionResultBlock)(NSMutableDictionary *data, NSString *url);

@interface BaiduMapHelper : NSObject <BMKSuggestionSearchDelegate, BMKPoiSearchDelegate, CLLocationManagerDelegate>
- (void)getSuggestions:(NSString *)city keyword:(NSString *)keyword callback:(suggestionResultBlock)callback;

- (void)getPOIList:(NSString *)keyword callback:(getPOIListCallback)callback;

- (void)getSearchList:(BMKNearbySearchOption *)poiSearchOptions callback:(getPOIListCallback)callback;

+ (void)setup;
@end
