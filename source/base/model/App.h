#import <Foundation/Foundation.h>
#import "Models.h"
//#import "UserBackend.h"

@class UserTable;

@interface App : NSObject
//当前用户信息
@property(strong, nonatomic) USER *currentUser;
@property(strong, nonatomic) AFHTTPRequestOperationManager *manager;
@property(assign, nonatomic) CLLocationCoordinate2D lastCoordinate;

+ (instancetype)shared;

//当前用户信息
@property(strong, nonatomic) UserTable *user;
@property BOOL isUpdateDeviceToken;
@property(strong, nonatomic) NSMutableDictionary *global;

- (BOOL)isUserLogin;

- (void)restore;

- (void)logout;

- (void)save;

@property(nonatomic,strong)NSString *deviceToken;
-(void)saveDeviceToken;
-(void)readDeviceToken;

@end
