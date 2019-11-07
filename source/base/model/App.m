#import "App.h"

@implementation App
+ (instancetype)shared
{
    static App *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _global = [NSMutableDictionary new];
    }
    return self;
}

- (BOOL)isUserLogin {
   // return self.user.token != nil && ![self.user.token isEqualToString:@""];
    return YES;
}

- (void)save {
    [NSUserDefaults saveJsonForKey:@"user_info" data:[self.user toJSON]];
    [NSUserDefaults saveDataForKey:@"global" data:_global];
}
-(void)setUser
{
    self.currentUser = [[USER alloc] init];
    self.currentUser.email = self.user.email;
    self.currentUser.tele = self.user.tele;
    self.currentUser.name = self.user.username;
    self.currentUser.sex = self.user.sex;
    self.currentUser.birthday = self.user.birthday;
    self.currentUser.intro = self.user.intro;
    self.currentUser.avatarimg = self.user.img;
    self.currentUser.coupon_num =self.user.quans;
    self.currentUser.score = self.user.score;
    self.currentUser.user_id =[NSNumber numberWithInt:[self.user.Id intValue]];
    self.currentUser.token = self.user.token;
    self.currentUser.rank_level = self.user.level;
    self.currentUser.weibo = self.user.is_weibo_bind;
    self.currentUser.weixin = self.user.is_weixin_bind;
    self.currentUser.qq = self.user.is_qq_bind;
    self.currentUser.provence = self.user.province;
    self.currentUser.city = self.user.city;
    self.currentUser.area = self.user.area;
    NSData *raw = [NSKeyedArchiver archivedDataWithRootObject:self.currentUser];
    [[NSUserDefaults standardUserDefaults] setObject:raw forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)restore {
    self. user= [[UserTable new] fromJSON:[NSUserDefaults getJsonForKey:@"user_info"]];
    [self setUser];
    _global = [NSUserDefaults getDataForKey:@"global"];
}

- (void)logout {
    _user = nil;
    _global = nil;
    [self save];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}
-(void)saveDeviceToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.deviceToken forKey:@"device_token"];
}
-(void)readDeviceToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.deviceToken=[defaults objectForKey:@"device_token"];
}
@end








