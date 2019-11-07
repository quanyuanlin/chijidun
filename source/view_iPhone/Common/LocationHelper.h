#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/*
 * 百度返回格式:
{
    "status": 0,
    "result": {
        "location": {
            "lng": 116.40297458203,
            "lat": 39.912953709181
        },
        "formatted_address": "北京市东城区广场西侧路",
        "business": "天安门,前门,和平门",
        "addressComponent": {
            "city": "北京市",
            "country": "中国",
            "direction": "",
            "distance": "",
            "district": "东城区",
            "province": "北京市",
            "street": "广场西侧路",
            "street_number": "",
            "country_code": 0
        },
        "poiRegions": [{
            "direction_desc": "\u5185",
            "name": "\u5929\u5b89\u95e8\u5e7f\u573a"
        }],
        "sematic_description": "天安门广场内",
        "cityCode": 131
    }
}
 */
typedef void (^locationHelperSuccessBlock)(NSMutableDictionary *data, NSString *url);

typedef void (^locationHelperFailedBlock)(NSError *error);

@interface LocationHelper : NSObject <CLLocationManagerDelegate>
@property(strong, atomic) locationHelperSuccessBlock success;
@property(strong, atomic) locationHelperFailedBlock failed;
@property BOOL isLocationServiceEnable;

- (void)run;
@end