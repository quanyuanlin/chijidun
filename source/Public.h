#ifndef insuny_Public_h
#define insuny_Public_h

#define API_URL @"https://chu.chijidun.com:8859/chiApi"
#define kTeamUrl @"https://wos.chijidun.com:8859"
#define kFindUrl @"http://h5-front.chijidun.com/app/find/index.html"


//#define kTeamOrderUrl @"http://aos.chijidun.com:8858/applyIndex.html" //正式
//#define API_URL @"http://218.244.130.96:8858/chiApi" //测试
//#define kTeamUrl @"http://test.c.chijidun.com" //测试
//#define kTeamOrderUrl @"http://test.aos.chijidun.com:8858/aos.chijidun.com/layout/applyIndex.html" //测试
//#define kFindUrl @"http://test.h5-front.chijidun.com:8858/app/find/index.html"

#define MARGIN 10
#define SEARCH_FIELD_WIDTH 240

//com.sina.weibo.SNWeiboSDKDemo
#define kAppKey         @"2140309335"
#define kAppSecret      @"2dcbc166e39ef8ef03c133d65bd2f449"
#define kRedirectURI    @"http://www.chijidun.com"
#define kLanchImgUrl @"http://h5.chijidun.com/about.html"
#define kshareUrl @"https://chu.chijidun.com:8859/wap/member/index.html"

//qq
#define kQQAppKey         @"1104814584"
#define kQQAppSecret      @"F4RRsqKaCfHX8J2K"

//微信
#define kWXAppKey         @"wxc380e9fd7b1d1bce"
#define kWXAppSecret      @"2e8874366a86432b3e88fc1e25f1819f"

//百度地图
#define kBaiduMapKey    @"mxVV5mvqp1nwxvIgGc2B5lnW"
#define coverimagewidth 1
//友盟
#define kUMengAppKey @"55c471d4e0f55a3a1e000514"
//系统颜色
#define MAIN_COLOR         [UIColor colorWithRed:255/255.f green:170/255.f blue:48/255.f alpha:1.000]
#define MAIN_COLOR2         [UIColor colorWithRed:245/255.f green:177/255.f blue:61/255.f alpha:1.000]
#define MAIN_COLOR3         [UIColor colorWithRed:238/255.f green:109/255.f blue:33/255.f alpha:1.000]
#define NAVI_COLOR       getUIColor(0xf8f8f8)

#define YELLOW_COLOR    getUIColor(0xff9900)
#define ORANGE_COLOR    getUIColor(0xff6600)
#define GREEN_COLOR     getUIColor(0x5ccd00)
#define RED_COLOR       getUIColor(0xff5436)
#define BLUE_COLOR      getUIColor(0x0099ff)

#define TEXT_DEEP         getUIColor(0x333333)
#define TEXT_MIDDLE       getUIColor(0x666666)
#define TEXT_LIGHT        getUIColor(0x999999)
#define DISABLE_COLOR     getUIColor(0xcccccc)
#define BORDER_COLOR      getUIColor(0xdddddd)
#define WHITE_COLOR       getUIColor(0xffffff)
#define BG_COLOR          getUIColor(0xf2f2f2)

#define TEXT_COLOR_LIGHT       [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.000]
#define TEXT_COLOR_DARK       [UIColor colorWithRed:160/255.f green:160/255.f blue:160/255.f alpha:1.000]
#define TEXT_COLOR_BLACK       [UIColor colorWithRed:67/255.f green:67/255.f blue:67/255.f alpha:1.000]

#define TEXT_COLOR_GRAY [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]
#define COLOR_DEEP_GRAY [UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1.0]
#define COLOR_MID_GRAY [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]
#define COLOR_LIGHT_GRAY [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]

#define img_placehold_small @"noPicture_small"
#define img_placehold_big @"noPicture_big"
#define url(v) [NSURL URLWithString:v]

//字号
#define ICON_TEXT_SIZE 35
#define LARGE_TEXT_SIZE 18
#define MEDIUM_TEXT_SIZE 15
#define SMALL_TEXT_SIZE 14
#define MICRO_TEXT_SIZE 12


/*****************************APP字体定义********************/
#define FONT_DEFAULT11 [UIFont systemFontOfSize:11]
#define FONT_DEFAULT30 [UIFont systemFontOfSize:30]
#define FONT_DEFAULT10 [UIFont systemFontOfSize:10]
#define FONT_DEFAULT12 [UIFont systemFontOfSize:12]
#define FONT_DEFAULT13 [UIFont systemFontOfSize:13]
#define FONT_DEFAULT15 [UIFont systemFontOfSize:15]
#define FONT_DEFAULT18 [UIFont systemFontOfSize:18]
#define FONT_DEFAULT21 [UIFont systemFontOfSize:21]
#define FONT_DEFAULT24 [UIFont systemFontOfSize:24]

//图标字体
#define ICON_CART_TEXT @""


/*****************************全局变量********************/
#define MODEL_VERSION [[UIDevice currentDevice].systemVersion floatValue]
#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#define IsIOS8 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=8)

#define iPhone4      ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5      ([UIScreen mainScreen].bounds.size.height == 568)
#define iPhone6      ([UIScreen mainScreen].bounds.size.height == 667)
#define iPhone6P     ([UIScreen mainScreen].bounds.size.height == 736)

#define hScale ((kMainScreen_Height < 667) ? kMainScreen_Height/667 : 1)
#define wScale ((kMainScreen_Height < 375) ? kMainScreen_Height/375 : 1)

#define Current_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]
/********************ios的3.5，4.0适配操作***************************/
#define kMainScreen_Height [UIScreen mainScreen].bounds.size.height
#define kMainScreen_Width [UIScreen mainScreen].bounds.size.width
#define kMainScreen_Bounds CGRectMake(0.0f, 0.0f, kMainScreen_Width, kMainScreen_Height)
#define W(obj)   (!obj?0:(obj).frame.size.width)
#define H(obj)   (!obj?0:(obj).frame.size.height)
#define X(obj)   (!obj?0:(obj).frame.origin.x)
#define Y(obj)   (!obj?0:(obj).frame.origin.y)
#define XWW(obj) ((X(obj))+(W(obj)))
#define YHH(obj) ((Y(obj))+H((obj)))

#define S(x) (x*hScale)

#define kCart_HEIGHT 50.0
#define kNAV_HEIGHT 45.0
#define NAV_HEIGHT 64.0
#define kCellHeight 40.0
#define kTableCellHeight 50.0
#define kbigCell 200.0
#define kPickerHeight 260
#define kDistance 15
#define kDistanceMin 10

/*****************************APP颜色定义********************/
#define COLOR_BLACK  [UIColor colorWithRed:60.0f/255.0f green:60.0f/255.0f blue:60.0f/255.0f alpha:1]
#define COLOR_Border [UIColor colorWithRed:216.0f/255.0f green:216.0f/255.0f blue:216.0f/255.0f alpha:1]
#define COLOR_GRAY   [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1]
#define COLOR_ORANGE [UIColor colorWithRed:240.0f/255.0f green:109.0f/255.0f blue:4.0f/255.0f alpha:1]

#import "common.h"
#import "ApiClient.h"
#endif
